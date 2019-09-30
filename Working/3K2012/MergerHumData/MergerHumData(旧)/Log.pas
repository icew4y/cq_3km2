unit Log;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzEdit, RzPanel, ExtCtrls;

type
  TFrmLog = class(TForm)
    RzPanel1: TRzPanel;
    RzGroupBox1: TRzGroupBox;
    Memo1: TRzMemo;
    RzPanel2: TRzPanel;
    RzGroupBox2: TRzGroupBox;
    Memo2: TRzMemo;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLog: TFrmLog;

implementation

{$R *.dfm}

procedure TFrmLog.FormShow(Sender: TObject);
var ID,Hum:Tstringlist;
    sFileName,sFileName1: string;
begin
  sFileName:=ExtractFilePath(Paramstr(0))+'ID变更.txt';
  if FileExists(sFileName) then
  begin
    ID := TStringList.Create;
    ID.LoadFromFile(sFileName);
    memo1.Text:='【原ID名】              【变更名】'+#13#10+ID.Text;
    ID.Free;
  end;
  
  sFileName1:=ExtractFilePath(Paramstr(0))+'名字变更.txt';
  if FileExists(sFileName1) then
  begin
    Hum := TStringList.Create;
    Hum.LoadFromFile(sFileName1);
    memo2.Text:='【原名字】              【变更名】'+#13#10+Hum.Text;
    Hum.Free;
  end;
end;

procedure TFrmLog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmLog.FormDestroy(Sender: TObject);
begin
  FrmLog := nil;
end;

end.
