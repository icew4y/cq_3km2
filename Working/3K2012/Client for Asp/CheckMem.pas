unit CheckMem;//Add it to the first line of project uses

interface

procedure SnapCurrMemStatToFile(Filename: string);

implementation

uses
   Windows, SysUtils, TypInfo;

const
   MaxCount = High(Word);

var
   OldMemMgr: TMemoryManager;
   ObjList: array[0..1000000] of Pointer;
   FreeInList: Integer = 0;
   GetMemCount: Integer = 0;
   FreeMemCount: Integer = 0;
   ReallocMemCount: Integer = 0;

procedure AddToList(P: Pointer);
begin
   if FreeInList > High(ObjList) then
   begin
     MessageBox(0, '内存管理监视器指针列表溢出，请增大列表项数！', '内存管理监视器', mb_ok);
     Exit;
   end;
   ObjList[FreeInList] := P;
   Inc(FreeInList);
end;

procedure RemoveFromList(P: Pointer);
var
   I: Integer;
begin
   for I := 0 to FreeInList - 1 do
     if ObjList[I] = P then
     begin
       Dec(FreeInList);
       Move(ObjList[I + 1], ObjList[I], (FreeInList - I) * SizeOf(Pointer));
       Exit;
     end;
end;

procedure SnapCurrMemStatToFile(Filename: string);
const
   FIELD_WIDTH = 20;
var
   OutFile: TextFile;
   I, CurrFree, BlockSize: Integer;
   HeapStatus: THeapStatus;
   Item: TObject;
   ptd: PTypeData;
   ppi: PPropInfo;

   procedure Output(Text: string; Value: integer);
   begin
     Writeln(OutFile, Text: FIELD_WIDTH, Value div 1024, ' KB(', Value, ' Byte)');
   end;

begin
   AssignFile(OutFile, Filename);
   try
     if FileExists(Filename) then
     begin
       Append(OutFile);
       Writeln(OutFile);
     end
     else
       Rewrite(OutFile);
     CurrFree := FreeInList;
     HeapStatus := GetHeapStatus; { 局部堆状态 }
     with HeapStatus do
     begin
       Writeln(OutFile, '===== ', ExtractFileName(ParamStr(0)), ',', DateTimeToStr(Now), ' =====');
       Writeln(OutFile);
       Output('可用地址空间 : ', TotalAddrSpace);
       Output('未提交部分 : ', TotalUncommitted);
       Output('已提交部分 : ', TotalCommitted);
       Output('空闲部分 : ', TotalFree);
       Output('已分配部分 : ', TotalAllocated);
       Output('全部小空闲内存块 : ', FreeSmall);
       Output('全部大空闲内存块 : ', FreeBig);
       Output('其它未用内存块 : ', Unused);
       Output('内存管理器消耗 : ', Overhead);
       Writeln(OutFile, '地址空间载入 : ': FIELD_WIDTH, TotalAllocated div (TotalAddrSpace div 100), '%');
     end;
     Writeln(OutFile);
     Writeln(OutFile, Format('当前出现 %d 处内存漏洞 :', [GetMemCount - FreeMemCount]));
     for I := 0 to CurrFree - 1 do
     begin
       Write(OutFile, I: 4, ') ', IntToHex(Cardinal(ObjList[I]), 16), ' - ');
       BlockSize := PDWORD(DWORD(ObjList[I]) - 4)^;
       Write(OutFile, BlockSize: 4, '($' + IntToHex(BlockSize, 4) + ')字节', ' - ');
       try
         Item := TObject(ObjList[I]);
         if PTypeInfo(Item.ClassInfo).Kind <> tkClass then { type info technique }
           write(OutFile, '不是对象')
         else
         begin
           ptd := GetTypeData(PTypeInfo(Item.ClassInfo));
           ppi := GetPropInfo(PTypeInfo(Item.ClassInfo), 'Name'); { 如果是TComponent }
           if ppi <> nil then
           begin
           write(OutFile, GetStrProp(Item, ppi));
           write(OutFile, ' : ');
           end
           else
           write(OutFile, '(未命名): ');
           Write(OutFile, Item.ClassName, ' (', ptd.ClassType.InstanceSize,
           ' 字节) - In ', ptd.UnitName, '.pas');
         end
       except
         on Exception do
           write(OutFile, '不是对象');
       end;
       writeln(OutFile);
     end;
   finally
     CloseFile(OutFile);
   end;
end;

function NewGetMem(Size: Integer): Pointer;
begin
   Inc(GetMemCount);
   Result := OldMemMgr.GetMem(Size);
   AddToList(Result);
end;

function NewFreeMem(P: Pointer): Integer;
begin
   Inc(FreeMemCount);
   Result := OldMemMgr.FreeMem(P);
   RemoveFromList(P);
end;

function NewReallocMem(P: Pointer; Size: Integer): Pointer;
begin
   Inc(ReallocMemCount);
   Result := OldMemMgr.ReallocMem(P, Size);
   RemoveFromList(P);
   AddToList(Result);
end;

const
   NewMemMgr: TMemoryManager = (
     GetMem: NewGetMem;
     FreeMem: NewFreeMem;
     ReallocMem: NewReallocMem);

initialization
   GetMemoryManager(OldMemMgr);
   SetMemoryManager(NewMemMgr);

finalization
   SetMemoryManager(OldMemMgr);
   if (GetMemCount - FreeMemCount) <> 0 then
     SnapCurrMemStatToFile(ExtractFileDir(ParamStr(0)) + '\CheckMemory.Log');
end.
