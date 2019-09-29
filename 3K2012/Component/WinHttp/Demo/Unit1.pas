unit Unit1;

interface

uses
  Windows, Classes, Graphics, Controls, Forms,
  StdCtrls, ComCtrls, ExtCtrls, WinHTTP;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    URLCombo: TComboBox;
    Label1: TLabel;
    Out1: TRadioButton;
    Out2: TRadioButton;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    WinHTTP1: TWinHTTP;
    GroupBox3: TGroupBox;
    POSTEdit: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    StatusBar1: TStatusBar;
    ProgressBar1: TProgressBar;
    Panel1: TPanel;
    GOBtn: TButton;
    STOPBtn: TButton;
    Memo2: TMemo;
    Label5: TLabel;
    Label2: TLabel;
    procedure GOBtnClick(Sender: TObject);
    procedure STOPBtnClick(Sender: TObject);
    procedure WinHTTP1Aborted(Sender: TObject);
    procedure WinHTTP1ConnLost(Sender: TObject; const ContentType: string;
      FileSize, BytesRead: Integer; Stream: TStream);
    procedure WinHTTP1Done(Sender: TObject; const ContentType: string;
      FileSize: Integer; Stream: TStream);
    procedure WinHTTP1HostUnreachable(Sender: TObject);
    procedure WinHTTP1HTTPError(Sender: TObject; ErrorCode: Integer;
      Stream: TStream);
    procedure WinHTTP1Progress(Sender: TObject; const ContentType: string;
      FileSize, BytesRead, ElapsedTime, EstimatedTimeLeft: Integer;
      PercentsDone: Byte; TransferRate: Single; Stream: TStream);
    procedure FormResize(Sender: TObject);
    procedure WinHTTP1PasswordRequest(Sender: TObject; const Realm: string;
      var TryAgain: Boolean);
    procedure WinHTTP1HeaderInfo(Sender: TObject; ErrorCode: Integer;
      const RawHeadersCRLF, ContentType, ContentLanguage,
      ContentEncoding: string; ContentLength: Integer;
      const Location: string; const Date, LastModified, Expires: TDateTime;
      const ETag: string; var ContinueDownload: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses SysUtils;

procedure TForm1.GOBtnClick(Sender: TObject);
begin
  WinHTTP1.URL := URLCombo.Text;
  WinHTTP1.POSTData := POSTEdit.Text;
  WinHTTP1.Read;

  Memo1.Clear;
  ProgressBar1.Position := 0;
end;

procedure TForm1.STOPBtnClick(Sender: TObject);
begin
  WinHTTP1.Abort(False, False);
end;

procedure TForm1.WinHTTP1Aborted(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := 'Connection aborted by user';
end;

procedure TForm1.WinHTTP1ConnLost(Sender: TObject; const ContentType: string;
  FileSize, BytesRead: Integer; Stream: TStream);
begin
  StatusBar1.Panels[0].Text := 'Connection with remote host lost';
end;

procedure TForm1.WinHTTP1Done(Sender: TObject; const ContentType: string;
  FileSize: Integer; Stream: TStream);
var
  Str: String;  
begin
  with Stream as TMemoryStream do
   if Out1.Checked then
    begin
     SetLength(Str, Size);
     Move(Memory^, Str[1], Size);
     Memo1.Text := Str;
    end
   else
    begin
     Memo1.Text := 'Saved to c:\httptest.dat';
     SaveToFile('c:\httptest.dat');
    end;
     
  StatusBar1.Panels[0].Text := 'Successfully downloaded ' + IntToStr(FileSize) + ' bytes';
end;

procedure TForm1.WinHTTP1HostUnreachable(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := 'Host unrechable';
end;

procedure TForm1.WinHTTP1HTTPError(Sender: TObject; ErrorCode: Integer;
  Stream: TStream);
var
  Str: String;
begin
  with Stream as TMemoryStream do
   if Out1.Checked then
    begin
     SetLength(Str, Size);
     Move(Memory^, Str[1], Size);
     Memo1.Text := Str;
    end
   else
    begin
     Memo1.Text := 'Saved to c:\httptest.dat';
     SaveToFile('c:\httptest.dat');
    end;

  case ErrorCode of
    404: Str := '404: Document not found';
    500: Str := '500: CGI script failed';
    else
      Str := IntToStr(ErrorCode);
   end;

  StatusBar1.Panels[0].Text := 'HTTP Error #' + Str;
end;

procedure TForm1.WinHTTP1Progress(Sender: TObject; const ContentType: string;
  FileSize, BytesRead, ElapsedTime, EstimatedTimeLeft: Integer;
  PercentsDone: Byte; TransferRate: Single; Stream: TStream);
begin
  ProgressBar1.Position := PercentsDone;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  URLCombo.Width := GroupBox1.Width - URLCombo.Left - GoBtn.Width - STOPBtn.Width - 8;
end;

procedure TForm1.WinHTTP1PasswordRequest(Sender: TObject;
  const Realm: string; var TryAgain: Boolean);
begin
  Caption := 'Password protected site: ' + Realm;

  { implement dialog which asks the username/password here }
{  acHTTP1.Username := AskUsername;
  acHTTP1.Password := AskPassword;
  TryAgain := True;}
end;

procedure TForm1.WinHTTP1HeaderInfo(Sender: TObject; ErrorCode: Integer;
  const RawHeadersCRLF, ContentType, ContentLanguage,
  ContentEncoding: string; ContentLength: Integer; const Location: string;
  const Date, LastModified, Expires: TDateTime; const ETag: string;
  var ContinueDownload: Boolean);
begin
  Memo2.Text := RawHeadersCRLF + #13#10'Local Date: ' + DateTimeToStr(Date);
end;

end.
