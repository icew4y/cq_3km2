unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Clipbrd, ShellAPI, StdCtrls, Md5;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure WMDropFiles(var Msg : TWMDropFiles); message WM_DROPFILES;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  Memo1.WantReturns := CheckBox3.Checked;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //WinExec(PChar('D:\Working\3K2012\EGameLogin\GetMD5\¸´¼þ GetMD5.exe'),SW_SHOWNORMAL);
  DragAcceptFiles(Handle, True);
  //Sleep(9999999999);

end;

procedure TForm1.WMDropFiles(var Msg : TWMDropFiles);
var
  I : Integer;
  Buf : array [0..255] of Char;
  sFileName : string;
  sMD5 : string;
  sLine : string;
begin
  Memo1.Clear;
  I := DragQueryFile(Msg.Drop, MAXDWORD, Buf, 255);
  for I := 0 to I - 1 do begin
    DragQueryFile(Msg.Drop, I, Buf, 255);
    sFileName := Buf;
    sMD5 := RivestFile(sFileName);
    sLine := '';
    if CheckBox1.Checked then begin
      if not CheckBox2.Checked then
        sLine := sFileName + '======'
      else
        sLine := ExtractFileName(sFileName) + '======';
    end;
    sLine := sLine + sMD5;
    Memo1.Lines.Add(sLine);
  end;
end;

end.
