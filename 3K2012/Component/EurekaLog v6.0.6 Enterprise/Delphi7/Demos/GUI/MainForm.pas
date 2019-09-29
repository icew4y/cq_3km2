unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ExceptionLog, ECore, ComCtrls;

type
  TGUIForm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    E0: TRadioButton;
    E1: TRadioButton;
    E2: TRadioButton;
    E3: TRadioButton;
    E4: TRadioButton;
    E5: TRadioButton;
    E6: TRadioButton;
    E7: TRadioButton;
    EurekaActive: TCheckBox;
    Panel1: TPanel;
    Image: TImage;
    Panel2: TPanel;
    EmailLabel: TLabel;
    WebLabel: TLabel;
    EmailCheck: TCheckBox;
    EmailEdit: TEdit;
    WebCheck: TCheckBox;
    WebEdit: TEdit;
    EurekaLog: TEurekaLog;
    WebRTF: TRichEdit;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    E8: TRadioButton;
    E9: TRadioButton;
    E10: TRadioButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure E0Click(Sender: TObject);
    procedure EurekaLogExceptionNotify(
      EurekaExceptionRecord: TEurekaExceptionRecord; var Handled: Boolean);
    procedure EmailCheckClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure WebCheckClick(Sender: TObject);
  private
    function SelectedItem: integer;
  public
    { Public declarations }
  end;

  TMyThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

var
  GUIForm: TGUIForm;
  Typ: Integer;
  SavedEmailSendMode: TEmailSendMode;
  SavedWebSendMode: TWebSendMode;

implementation

{$R *.DFM}

{$R Images.res}

{$R WinXP.res}

var
  bmp: THandle = 0;

//------------------------------------------------------------------------------

const
  RTFText =
    '{\rtf1\ansi\ansicpg1252\deff0\deflang1040{\fonttbl{\f0\fmodern\fprq1\fcharset0 Courier New;}}' +
    '{\colortbl ;\red255\green0\blue0;\red0\green0\blue255;\red0\green0\blue0;\red128\green0\blue128;\red0\green128\blue0;}' +
    '\viewkind4\uc1\pard\cf1\lang2057\f0\fs20 <?\par' +
    '\cf2   foreach\cf3 ($_FILES \cf2 as \cf3 $key=>$value)\par' +
    '\b   \{\b0\par' +
    '    $uploaded_file = $_FILES[$key][\cf4 ''tmp_name''\cf3 ];\par' +
    '    $server_dir = \cf4 ''upload/''\cf3 ; \cf5\lang1040\i // Upload folder\i0  \cf3\lang2057\par' +
    '    $server_file = $server_dir.\cf2 basename\cf3 ($_FILES[$key][\cf4 ''name''\cf3 ]);\par' +
    '\par' +
    '\cf5\i     // Move the uploaded file to the Server uploaded directory...\cf3\i0\par' +
    '\cf2     if \cf3 (\cf2 move_uploaded_file\cf3 ($uploaded_file, $server_file))\par' +
    '\b     \{\b0\par' +
    '\cf5\i       // Here your code...\cf3\i0\par' +
    '\b     \}\b0\par' +
    '\b   \}\b0\par' +
    '\cf1 ?>\par' +
    '}';
  EM_STREAMIN = (WM_USER + 73);
  SF_RTF = $0002;

type
  TEditStream = packed record
    dwCookie, dwError: Integer;
    pfnCallback: Pointer;
  end;

procedure RTF_LoadFromStream(RichHandle: THandle; Stream: TStream);
var
  EditStream: TEditStream;

  function Load(Stream: TStream; Buff: PByte; c: Integer; var pc: Integer): Integer; stdcall;
  begin
    Result := NoError;
    try
      pc := Stream.Read(Buff^, c);
    except
      Result := 1;
    end;
  end;

begin
  with EditStream do
  begin
    dwCookie := Integer(Stream);
    pfnCallBack := @Load;
    dwError := 0;
  end;
  SendMessage(RichHandle, EM_STREAMIN, SF_RTF, Integer(@EditStream));
end;

procedure RTF_LoadFromText(RichHandle: THandle; Text: string);
var
  Data: TMemoryStream;
begin
  Data := TMemoryStream.Create;
  try
    Data.Write(PChar(Text)^, Length(Text));
    Data.Position := 0;
    RTF_LoadFromStream(RichHandle, Data);
  finally
    Data.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure AccessViolation;
begin
  PByte(nil)^ := 0;
end;

procedure DivByZero;
var
  a, b: integer;
begin
  a := 0;
  b := a div a;
  if b = 0 then Beep; // Used to skip the borland optimizer...
end;

procedure StringConversionError;
begin
  WriteLn(StrToDateTime('99/99/1998'));
end;

procedure CustomException;
begin
  raise Exception.Create('Custom exception');
end;

procedure ListIndexOutOfBound;
var
  list: TList;
begin
  list := TList.Create;
  try
    if list[0] <> nil then Beep;
  finally
    list.Free;
  end;
end;

{-------------------------------------------------------------------------------
procedure TMyThread.Execute;
begin
  AccessViolation;
end;
-------------------------------------------------------------------------------}

procedure ThreadError;
var
  thread: TMyThread;
begin
  thread := TMyThread.Create(True);
  thread.FreeOnTerminate := True;
  thread.Resume;
end;

procedure DLLError;
var
  DLL_Error: procedure;
  Handle: THandle;
begin
  Handle := LoadLibrary('DLL.DLL');
  if Handle <> 0 then
  begin
    @DLL_Error := GetProcAddress(Handle, 'DLL_Error');
    if @DLL_Error <> nil then DLL_Error
    else
      MessageBox(0, 'Cannot found "DLL_Error" procedure into DLL.DLL library.',
        'Error.', MB_OK or MB_ICONERROR);
  end
  else
    MessageBox(0, 'Cannot found DLL.DLL library.', 'Error.',
      MB_OK or MB_ICONERROR);
end;

procedure ApplicationFreeze;
begin
  repeat
  until (1 = 2);
end;

procedure GetMemLeak;
var
  P: Pointer;
begin
  GetMem(P, 10000);
  if (P = nil) then Beep; // Used to skip the borland optimizer...
end;

procedure TObjectLeak;
var
  Obj: TObject;
begin
  Obj := TObject.Create;
  if (Obj = nil) then Beep; // Used to skip the borland optimizer...
end;

procedure TFormLeak;
var
  Form: TForm;
begin
  Form := TForm.Create(nil);
  if (Form = nil) then Beep; // Used to skip the borland optimizer...
end;

procedure RunError(idx: integer);
begin
  case idx of
    0: AccessViolation;
    1: DivByZero;
    2: StringConversionError;
    3: CustomException;
    4: ListIndexOutOfBound;
    5: ThreadError;
    6: DLLError;
    7: ApplicationFreeze;
    8: GetMemLeak;
    9: TObjectLeak;
    10: TFormLeak;
  end;
end;

procedure Error(i: integer);
begin
  RunError(i);
end;

procedure RaiseException(i: integer);
begin
  Error(i);
end;

{ TMyThread }

procedure TMyThread.Execute;
begin
  AccessViolation;
end;

// -----------------------------------------------------------------------------

function TGuiForm.SelectedItem: integer;
var
  RB: TRadioButton;
begin
  Result := 0;
  repeat
    RB := TRadioButton(FindComponent('E' + IntToStr(Result)));
    if not RB.Checked then inc(Result);
  until RB.Checked;
end;

procedure TGUIForm.BitBtn1Click(Sender: TObject);

  function IsValidEmail(const Addr: string): Boolean;
  begin
    Result := ((Pos('@', Addr) > 0) and (Pos('.', Addr) > 0));
  end;

  procedure SetEurekaLogData;
  begin
    // Check for email send.
    if (EmailCheck.Checked) then
    begin
      // Set the email address.
      CurrentEurekaLogOptions.EMailAddresses := EmailEdit.Text;
      CurrentEurekaLogOptions.EMailSendMode := SavedEmailSendMode;
    end
    else
    begin
      // Disable the email sending.
      CurrentEurekaLogOptions.EMailSendMode := esmNoSend;
    end;

    // Check the Web send.
    if (WebCheck.Checked) then
    begin
      // Set the web options.
      CurrentEurekaLogOptions.WebURL := WebEdit.Text;
      CurrentEurekaLogOptions.WebSendMode := SavedWebSendMode;
    end
    else
    begin
      // Disable the Web sending.
      CurrentEurekaLogOptions.WebSendMode := wsmNoSend;
    end;
  end;

begin
  if (EmailCheck.Checked) then
  begin
    if (not IsValidEmail(EmailEdit.Text)) then
    begin
      MessageBox(0, 'You must insert all valid Emails', 'Error',
        MB_OK or MB_ICONERROR or MB_TASKMODAL);
      Exit;
    end;
  end;

  if (WebCheck.Checked) then
  begin
    if (Trim(WebEdit.Text) = '') then
    begin
      MessageBox(0, 'You must insert a valid URL', 'Error',
        MB_OK or MB_ICONERROR or MB_TASKMODAL);
      Exit;
    end;
  end;

  SetEurekaLogData;

  RaiseException(SelectedItem);
end;

procedure TGUIForm.FormCreate(Sender: TObject);
var
  bmp: TBitmap;
begin
  // We save the EurekaLog design-time send options...
  SavedEmailSendMode := CurrentEurekaLogOptions.EMailSendMode;
  SavedWebSendMode   := CurrentEurekaLogOptions.WebSendMode;

  RTF_LoadFromText(WebRTF.Handle, RTFText);
  EmailEdit.Text := CurrentEurekaLogOptions.EMailAddresses;
  WebEdit.Text := CurrentEurekaLogOptions.WebURL;
  bmp := TBitmap.Create;
  bmp.Width := 0;
  bmp.Height := 0;
  image.Picture.Assign(bmp);
  bmp.free;
  E0Click(nil);
end;

procedure TGUIForm.FormDestroy(Sender: TObject);
begin
  if (bmp <> 0) then DeleteObject(bmp);
  // Disable/Enable EurekaLog at the program end (Memory Leaks detection).
  SetEurekaLogState(EurekaActive.Checked);
end;

procedure TGUIForm.E0Click(Sender: TObject);
var
  res_name: string;
  BitMap: TBitMap;
begin
  res_name := 'B' + IntToStr(SelectedItem);
  if (bmp <> 0) then DeleteObject(bmp);
  bmp := LoadBitmap(HInstance, PChar(res_name));
  BitMap := TBitmap.Create;
  try
    BitMap.Handle := bmp;
    BitMap.Canvas.Brush.Color := clNavy;
    BitMap.Height := Image.Height;
    Image.Picture.Assign(BitMap);
  finally
    BitMap.Free;
  end;
end;

procedure TGUIForm.EmailCheckClick(Sender: TObject);
begin
  EmailLabel.Enabled := EmailCheck.Checked;
  EmailEdit.Enabled := EmailCheck.Checked;
end;

// EurekaLog "ExceptionNotify" event.

procedure TGUIForm.EurekaLogExceptionNotify(
  EurekaExceptionRecord: TEurekaExceptionRecord; var Handled: Boolean);
begin
  Handled := GUIForm.EurekaActive.Checked; // Active/Deactive EurekaLog.
end;

procedure TGUIForm.WebCheckClick(Sender: TObject);
begin
  WebLabel.Enabled := WebCheck.Checked;
  WebEdit.Enabled := WebCheck.Checked;
end;

end.

