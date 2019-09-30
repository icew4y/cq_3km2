unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms, StdCtrls,
  Registry, EDcode,HardInfo, MD5EncodeStr;

type
  TFrmClean = class(TForm)
    ButtonClear: TButton;
    Label1: TLabel;
    procedure ButtonClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmClean: TFrmClean;
  nCheckCode: Integer;
implementation

{$R *.dfm}
//取硬件信息
function GetRegisterName(): string;
var
  sRegisterName, Str: string;
begin
  try
    Str := '';
    sRegisterName := '';

    if sRegisterName = '' then begin
      try
        sRegisterName := Trim(HardInfo.GetCPUInfo_); //CPU序列号
      except
        sRegisterName := '';
      end;
    end;

    if sRegisterName = '' then begin
      try
        sRegisterName := Trim({HardInfo.GetAdapterMac(0)} HardInfo.MacAddress); //网卡地址
      except
        sRegisterName := '';
      end;
    end;

    if sRegisterName = '' then begin
      try
        sRegisterName := Trim(HardInfo.GetScsisn); //硬盘序列号
      except
        sRegisterName := '';
      end;
    end;
    
    if sRegisterName <> '' then begin
      Str := Encry(sRegisterName, DecodeInfo('08BZO37YQD51lBI5eK2TVw==')); //927746880
      Result := RivestStr(Str);
    end else Result := '';
  finally
  end;
end;

function ClearRegistry: Boolean;
var
  rRegObject: TRegistry;
const
  MyRootKey = HKEY_LOCAL_MACHINE; //注册表根键
  MySubKey = '\Software\Microsoft\Windows\CurrentVersion\Windows UpData\'; //注册表子键
begin
  rRegObject := TRegistry.Create;
  try
    rRegObject.RootKey := MyRootKey;
    if rRegObject.OpenKey(MySubKey, False) then begin
      if rRegObject.DeleteKey(MySubKey) then Result := True else Result := False;
    end else Result := False;
  finally
    rRegObject.Free;
  end;
end;
function myGetWindowsDirectory: string;
var
  pcWindowsDirectory: PChar;
  dwWDSize: DWORD;
begin
  dwWDSize := MAX_PATH + 1;
  Result := '';
  GetMem(pcWindowsDirectory, dwWDSize);
  try
    if Windows.GetWindowsDirectory(pcWindowsDirectory, dwWDSize) <> 0 then
      Result := pcWindowsDirectory;
  finally
    FreeMem(pcWindowsDirectory);
  end;
end;

procedure TFrmClean.ButtonClearClick(Sender: TObject);
var
  sWindowsDirectory: string;
begin
  if nCheckCode < 2 then Exit;
  if Application.MessageBox('是否确认要修复引擎，修复前注意备份？？？', '确认信息', MB_YESNO + MB_ICONQUESTION) = IDYES then begin
    sWindowsDirectory := myGetWindowsDirectory;
    if sWindowsDirectory[Length(sWindowsDirectory)] <> '\' then sWindowsDirectory := sWindowsDirectory + '\';
    DeleteFile(sWindowsDirectory +GetRegisterName()+'.ini');
    if ClearRegistry then Application.MessageBox('修复成功！！！', '提示信息', MB_ICONQUESTION) else Application.MessageBox('修复失败！！！', '提示信息', MB_ICONQUESTION);
  end;
end;

procedure TFrmClean.FormCreate(Sender: TObject);
begin
  Inc(nCheckCode);
  Label1.Caption := DecodeInfo('98SImNSJqfLIM7Tzq4duqOGi9JSGCwiHiUfZ6Q==');
  Inc(nCheckCode);
end;

end.

