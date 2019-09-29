{
  Hook Api Library 0.2 [Ring3] By Anskya
  Email:Anskya@Gmail.com
  ring3 inline hook For Api

Thank:
  前29A高手也一直都是我的偶像...z0mbie大牛...这里膜拜一下
  使用的LDE32引擎是翻译他老人家的...C->Delphi...


说明:
  1.利用堆栈跳转
  没有使用传统的jmp xxxx 长跳转,使用容易理解的push xxxx+ret
  仔细看代码容易理解...封装完好.

  2.内存补丁结构:
  补丁1:|push xxx--钩子处理过程|ret|
  补丁2:|保存原始补丁地址|保存原始地址代码长度|原始地址的代码|push xxxxxx|ret|

更新说明:
  0.2:
    支持Ring0 Inline Hook
  0.1:
    Ring3 Inline Hook
}
unit uHelperH;

interface

//{$DEFINE Ring0}

uses
  uHelperL,
{$IFDEF Ring0}
  ntddk
{$ELSE}
  Windows
{$ENDIF}
  ;

function HelperHCode(OldProc, NewProc: Pointer): Pointer;
function UnHelperHCode(TargetProc: Pointer): Boolean;

implementation

type
  LPfar_jmp = ^_far_jmp;
  _far_jmp = packed record
    PushOpCode: BYTE;
    PushArg: Pointer;
    RetOpCode: BYTE;
  end;
  Tfar_jmp = _far_jmp;

function HelperHCode(OldProc, NewProc: Pointer): Pointer;
var
  lpFuncProc, lpInlineProc: Pointer;
  InlineLen, OpcodeLen: DWORD;
  stfar_jmp_hook: Tfar_jmp;
  OldProtect: DWORD;
begin
  Result := nil;
  if ((OldProc = nil) or (NewProc = nil)) then Exit;

  InlineLen := 0;
  lpFuncProc := OldProc;

  while (InlineLen < SizeOf(Tfar_jmp)) do begin
    GetInstLenght(lpFuncProc, @OpcodeLen);
    lpFuncProc := Pointer(ULONG(lpFuncProc) + OpcodeLen);
    InlineLen := InlineLen + OpcodeLen;
  end;

  stfar_jmp_hook.PushOpCode := $68;
  stfar_jmp_hook.PushArg := NewProc;
  stfar_jmp_hook.RetOpCode := $C3;

{$IFDEF Ring0}
  lpInlineProc := ExAllocatePoolWithTag(NonPagedPool, 8 + InlineLen  + SizeOf(Tfar_jmp), PoolWithTag);
{$ELSE}
  lpInlineProc := Pointer(GlobalAlloc(GMEM_FIXED, SizeOf(Pointer) + SizeOf(ULONG) + InlineLen  + SizeOf(Tfar_jmp)));
{$ENDIF}

  if (lpInlineProc = nil) then Exit;
  
  PPointer(lpInlineProc)^ := OldProc;
  Inc(PBYTE(lpInlineProc), SizeOf(Pointer));

  PULONG(lpInlineProc)^ := InlineLen;
  Inc(PBYTE(lpInlineProc), SizeOf(ULONG));

{$IFDEF Ring0}
  memcpy(lpInlineProc, OldProc, InlineLen);
{$ELSE}
  CopyMemory(lpInlineProc, OldProc, InlineLen);
{$ENDIF}
  Inc(PBYTE(lpInlineProc), InlineLen);
  //  改写跳转代码
  with LPfar_jmp(lpInlineProc)^ do begin
    PushOpCode := $68;
    PushArg := Pointer(ULONG(OldProc) + InlineLen);
    RetOpCode := $C3;
  end;

{$IFDEF Ring0}
  //  开始嵌入Hook
  if NT_SUCCESS(WriteReadOnlyMemoryMark(OldProc, @stfar_jmp_hook, SizeOf(Tfar_jmp))) then begin
    Result := Pointer(ULONG(lpInlineProc) - InlineLen);
  end else begin
    ExFreePoolWithTag(lpInlineProc, PoolWithTag);
    Result := nil;
  end;  
{$ELSE}
  //  使内存可写
  VirtualProtect(OldProc, SizeOf(Tfar_jmp), PAGE_EXECUTE_READWRITE, OldProtect);
  //  写入跳转代码
  CopyMemory(OldProc, @stfar_jmp_hook, SizeOf(Tfar_jmp));
  Result := Pointer(ULONG(lpInlineProc) - InlineLen);
  //  写回原属性
  VirtualProtect(OldProc, SizeOf(Tfar_jmp), OldProtect, OldProtect);
{$ENDIF}
end;

function UnHelperHCode(TargetProc: Pointer): Boolean;
var
  lpFuncProc, lpInlineProc: Pointer;
  InlineLen: ULONG;
  OldProtect: ULONG;
begin
  Result := False;
  if (TargetProc = nil) then Exit;
  lpInlineProc := TargetProc;
  Dec(PBYTE(lpInlineProc), SizeOf(Pointer) + SizeOf(ULONG));

  lpFuncProc := PPointer(lpInlineProc)^;
  Inc(PBYTE(lpInlineProc), SizeOf(Pointer));

  InlineLen := PULONG(lpInlineProc)^;
  Inc(PBYTE(lpInlineProc), SizeOf(ULONG));

{$IFDEF Ring0}
  //  开始解除Hook
  if NT_SUCCESS(WriteReadOnlyMemoryMark(lpFuncProc, TargetProc, InlineLen)) then
  begin
    Dec(PBYTE(lpInlineProc), SizeOf(Pointer) + SizeOf(ULONG));
    ExFreePoolWithTag(lpInlineProc, PoolWithTag);
    Result := True;
  end;  
{$ELSE}
  //  使内存可写
  VirtualProtect(lpFuncProc, InlineLen, PAGE_EXECUTE_READWRITE, OldProtect);
  //  写回原有数据
  CopyMemory(lpFuncProc, TargetProc, InlineLen);
  Dec(PBYTE(lpInlineProc), SizeOf(Pointer) + SizeOf(ULONG));

  GlobalFree(ULONG(lpInlineProc));
  Result := True;
  //  写回原属性
  VirtualProtect(lpFuncProc, InlineLen, OldProtect, OldProtect);
{$ENDIF}
end;

end.
