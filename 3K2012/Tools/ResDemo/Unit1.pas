unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRes, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Buf : PChar;
  BufSize : DWORD;
begin
  if LoadRes(Buf, BufSize) then
    ShowMessage('读取成功.' + sLineBreak + IntToStr(BufSize))
  else
    ShowMessage('读取失败.');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  sSrcFile : string;
begin
  with TOpenDialog.Create(Self) do begin
    Title := '选择需要写入的文件'; 
    if Execute(Self.Handle) then begin
      sSrcFile := FileName;
      with TMemoryStream.Create do begin
        LoadFromFile(sSrcFile);
        if SaveRes(Application.ExeName, ExtractFilePath(Application.ExeName) + '\Out.exe', PChar(Memory), Size) then
          ShowMessage('写入成功.' + sLineBreak + IntToStr(Size))
        else
          ShowMessage('写入失败.');
        Free;
      end;
    end;
    Free;
  end;

end;

end.
