unit PlugIn;

interface
uses
  Windows, Classes, SysUtils, Forms, Grobal2, SDK;
var
  PlugHandList: TStringList;
type
  TPlugInfo = record
    DllName: string;
    sDesc: string;
    Module: THandle;
  end;
  pTPlugInfo = ^TPlugInfo;

  TPlugInManage = class
    m_PlugList: TStringList;
    StartPlugList: TList;
  private
    function GetPlug(Module: THandle): Boolean;
  public
    constructor Create();
    destructor Destroy; override;
    procedure StartPlugMoudle();
    procedure LoadPlugIn();
    procedure UnLoadPlugIn();
  end;
procedure MainMessage(Msg: PChar; nMsgLen: Integer; nMode: Integer); stdcall;
procedure SendBroadCastMsg(Msg: PChar; MsgType: TMsgType); stdcall;

function GetFunAddr(nIndex: Integer): Pointer; stdcall;
function FindOBjTable_(ObjName: PChar; nNameLen, nCode: Integer): TObject; stdcall;
function SetProcCode_(ProcName: PChar; nNameLen, nCode: Integer): Boolean; stdcall;
function SetProcTable_(ProcAddr: Pointer; ProcName: PChar; nNameLen, nCode: Integer): Boolean; stdcall;
function FindProcCode_(ProcName: PChar; nNameLen: Integer): Integer; stdcall;
function FindProcTable_(ProcName: PChar; nNameLen, nCode: Integer): Pointer; stdcall;

function FindProcTable(ProcName: PChar; nNameLen: Integer): Pointer; stdcall;
function SetProcTable(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer): Boolean; stdcall;
function FindOBjTable(ObjName: PChar; nNameLen: Integer): TObject; stdcall;
function SetStartPlugProc(StartPlug: Pointer): Boolean; stdcall;

implementation

uses M2Share;


var
  PublicMoudle: Integer;
procedure MainMessage(Msg: PChar; nMsgLen: Integer; nMode: Integer);
var
  MsgBuff: string;
begin
  if (Msg <> nil) and (nMsgLen > 0) then begin
    setlength(MsgBuff, nMsgLen);
    Move(Msg^, MsgBuff[1], nMsgLen);
    case nMode of
      0: begin
          if Memo <> nil then Memo.Lines.Add(MsgBuff);
        end;
    else MainOutMessage(MsgBuff);
    end;
  end;
end;

procedure SendBroadCastMsg(Msg: PChar; MsgType: TMsgType); stdcall;
begin
  if UserEngine <> nil then
    UserEngine.SendBroadCastMsgExt(Msg, MsgType);
end;
//由DLL调用按名字查找函数地址

function FindProcTable_(ProcName: PChar; nNameLen, nCode: Integer): Pointer;
var
  i: Integer;
  sProcName: string;
begin
  Result := nil;
  setlength(sProcName, nNameLen);
  Move(ProcName^, sProcName[1], nNameLen);
  for i := Low(ProcArray) to High(ProcArray) do begin
    if (ProcArray[i].nProcAddr <> nil) and (CompareText(sProcName, ProcArray[i].sProcName) = 0) and (ProcArray[i].nProcCode = nCode) then begin
      Result := ProcArray[i].nProcAddr;
      break;
    end;
  end;
end;

function FindProcCode_(ProcName: PChar; nNameLen: Integer): Integer;
var
  i: Integer;
  sProcName: string;
begin
  Result := -1;
  setlength(sProcName, nNameLen);
  Move(ProcName^, sProcName[1], nNameLen);
  for i := Low(PlugProcArray) to High(PlugProcArray) do begin
    if CompareText(sProcName, PlugProcArray[i].sProcName) = 0 then begin
      Result := PlugProcArray[i].nProcCode;
      break;
    end;
  end;
end;
//=================================
//由DLL调用按名字设置插件中的函数地址

function SetProcTable_(ProcAddr: Pointer; ProcName: PChar; nNameLen, nCode: Integer): Boolean;
var
  i: Integer;
  sProcName: string;
begin
  Result := False;
  setlength(sProcName, nNameLen);
  Move(ProcName^, sProcName[1], nNameLen);
  for i := Low(PlugProcArray) to High(PlugProcArray) do begin
    if (PlugProcArray[i].nProcAddr = nil) and (CompareText(sProcName, PlugProcArray[i].sProcName) = 0) and (PlugProcArray[i].nProcCode = nCode) then begin
      PlugProcArray[i].nProcAddr := ProcAddr;
      Result := True;
      break;
    end;
  end;
end;

function SetProcCode_(ProcName: PChar; nNameLen, nCode: Integer): Boolean;
var
  i: Integer;
  sProcName: string;
begin
  Result := False;
  setlength(sProcName, nNameLen);
  Move(ProcName^, sProcName[1], nNameLen);
  for i := Low(PlugProcArray) to High(PlugProcArray) do begin
    if (PlugProcArray[i].nProcAddr = nil) and (CompareText(sProcName, PlugProcArray[i].sProcName) = 0) then begin
      PlugProcArray[i].nProcCode := nCode;
      Result := True;
      break;
    end;
  end;
end;

function SetStartPlugProc(StartPlug: Pointer): Boolean;
begin
  Result := False;
  if PlugInEngine <> nil then begin
    PlugInEngine.StartPlugList.Add(StartPlug);// 20080303 出现异常
    Result := True;
  end;
end;
//由DLL调用按名字查找全局对象地址
function FindOBjTable_(ObjName: PChar; nNameLen, nCode: Integer): TObject;
var
  i: Integer;
  sObjName: string;
begin
  Result := nil;
  setlength(sObjName, nNameLen);
  Move(ObjName^, sObjName[1], nNameLen);
  for i := Low(ProcArray) to High(ProcArray) do begin
    if (ObjectArray[i].Obj <> nil) and (CompareText(sObjName, ObjectArray[i].sObjcName) = 0) and (ObjectArray[i].nObjcCode = nCode) then begin
      Result := ObjectArray[i].Obj;
      break;
    end;
  end;
end;

function GetFunAddr(nIndex: Integer): Pointer;
begin
  Result := nil;
  case nIndex of
    0: Result := @FindProcCode_;
    1: Result := @FindProcTable_;
    2: Result := @SetProcTable_;
    3: Result := @SetProcCode_;
    4: Result := @FindOBjTable_;
    5: Result := @FindOBjTable;
    6: Result := @PublicMoudle;
    8: Result := @SetStartPlugProc;
  end;
end;
//=================================
//由DLL调用按名字查找函数地址
function FindProcTable(ProcName: PChar; nNameLen: Integer): Pointer;
var
  i: Integer;
  sProcName: string;
begin
  Result := nil;
  setlength(sProcName, nNameLen);
  Move(ProcName^, sProcName[1], nNameLen);
  for i := Low(ProcArray) to High(ProcArray) do begin
    if (ProcArray[i].nProcAddr <> nil) and (CompareText(sProcName, ProcArray[i].sProcName) = 0) and (ProcArray[i].nProcCode <= 0) then begin
      Result := ProcArray[i].nProcAddr;
      break;
    end;
  end;
end;
//=================================
//由DLL调用按名字设置插件中的函数地址
function SetProcTable(ProcAddr: Pointer; ProcName: PChar; nNameLen: Integer): Boolean;
var
  i: Integer;
  sProcName: string;
begin
  Result := False;
  setlength(sProcName, nNameLen);
  Move(ProcName^, sProcName[1], nNameLen);
  for i := Low(PlugProcArray) to High(PlugProcArray) do begin
    if (PlugProcArray[i].nProcAddr = nil) and (CompareText(sProcName, PlugProcArray[i].sProcName) = 0) and (PlugProcArray[i].nProcCode <= 0) then begin
      PlugProcArray[i].nProcAddr := ProcAddr;
      Result := True;
      break;
    end;
  end;
end;

//=================================
//由DLL调用按名字查找全局对象地址
function FindOBjTable(ObjName: PChar; nNameLen: Integer): TObject;
var
  i: Integer;
  sObjName: string;
begin
  Result := nil;
  setlength(sObjName, nNameLen);
  Move(ObjName^, sObjName[1], nNameLen);
  for i := Low(ProcArray) to High(ProcArray) do begin
    if (ObjectArray[i].Obj <> nil) and (CompareText(sObjName, ObjectArray[i].sObjcName) = 0) and (ObjectArray[i].nObjcCode <= 0) then begin
      Result := ObjectArray[i].Obj;
      break;
    end;
  end;
end;
{ TPlugIn }

constructor TPlugInManage.Create;
begin
  m_PlugList := TStringList.Create;
  StartPlugList := TList.Create;
end;

destructor TPlugInManage.Destroy;
begin
  if m_PlugList.Count > 0 then UnLoadPlugIn();
  StartPlugList.Free;
  m_PlugList.Free;
  inherited;
end;

function TPlugInManage.GetPlug(Module: THandle): Boolean;
var
  I: Integer;
begin
  Result := False;
  if m_PlugList.Count > 0 then begin//20080630
    for I := 0 to m_PlugList.Count - 1 do begin
      if Module = pTPlugInfo(m_PlugList.Objects[I]).Module then begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

procedure TPlugInManage.StartPlugMoudle();
var
  i: Integer;
begin
  if StartPlugList.Count > 0 then begin//20080630
    for i := 0 to StartPlugList.Count - 1 do begin
      if Assigned(StartPlugList.Items[i]) then
        if not TStartPlug(StartPlugList.Items[i]) then break;
    end;
  end;
end;

procedure TPlugInManage.LoadPlugIn;
var
  I: Integer;
  LoadList: TStringList;
  sPlugFileName: string;
  sPlugLibName: string;
  sPlugLibFileName: string;
  Module: THandle;
  Init: TPlugInit;
  PlugInfo: pTPlugInfo;
begin
  //{$If TESTMODE = 0}//修改测试模式不加载SystemModule.dll By TasNat at: 2012-10-14 11:07:22
  sPlugFileName := g_Config.sPlugDir + 'PlugList.txt';
  if not DirectoryExists(g_Config.sPlugDir) then begin
    //CreateDirectory(PChar(g_Config.sConLogDir),nil);
    CreateDir(g_Config.sPlugDir);
  end;
  if not FileExists(sPlugFileName) then begin
    LoadList := TStringList.Create;
    //LoadList.Add('SystemModule.dll');
    LoadList.SaveToFile(sPlugFileName);
    LoadList.Free;
  end;
  if FileExists(sPlugFileName) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sPlugFileName);
    for I := 0 to LoadList.Count - 1 do begin
      sPlugLibName := Trim(LoadList.Strings[I]);
      if (sPlugLibName = '') or (sPlugLibName[1] = ';') then Continue;
      sPlugLibFileName := g_Config.sPlugDir + sPlugLibName;// 20080303 出现异常
      if FileExists(sPlugLibFileName) then begin
        Module := LoadLibrary(PChar(sPlugLibFileName)); //FreeLibrary
        if Module > 32 then begin
          if GetPlug(Module) then begin //2007-01-22 增加 是否重复加载同一个插件
            FreeLibrary(Module);
            Continue;
          end;
          Init := GetProcAddress(Module, 'Init');
          if @Init <> nil then begin
            PlugHandList.AddObject('', TObject(Module));
            PublicMoudle := Module;
            New(PlugInfo);// 20080303 出现异常
            PlugInfo.DllName := sPlugLibFileName;
            PlugInfo.Module := Module;
            {20071015}
            PlugInfo.sDesc := Init(Application.Handle, @MainMessage, @FindProcTable, @SetProcTable, @GetFunAddr);// 20080303 出现异常
            m_PlugList.AddObject(PlugInfo.sDesc, TObject(PlugInfo));
            PublicMoudle := -1;
          end;
        end;
      end;
    end;//for
    LoadList.Free;
  end;
  //{$I Encode_Start.inc}//代码加密标识
  //if (nGetDateIP >= 0) and (not Assigned(PlugProcArray[nGetDateIP].nProcAddr)) then begin//20080818 增加，判断是否加载系统插件
  //  asm
   //   MOV FS:[0],0;
   //   MOV DS:[0],EAX;
   // end;
  //end;
  //{$I Encode_End.inc}
  //{$IFend}
end;

procedure TPlugInManage.UnLoadPlugIn;
var
  I: Integer;
  PlugInfo : pTPlugInfo;
  Module: THandle;
  PFunc: procedure(); stdcall;
begin;
  if m_PlugList.Count > 0 then begin//20080630
    for I := 0 to m_PlugList.Count - 1 do begin
      PlugInfo := pTPlugInfo(m_PlugList.Objects[I]);
      Module := PlugInfo.Module;
      PFunc := GetProcAddress(Module, 'UnInit');
      if @PFunc <> nil then PFunc();
      FreeLibrary(Module);
      Dispose(PlugInfo);
    end;
  end;
  m_PlugList.Clear;
end;

initialization

finalization

end.
