unit uSelectDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBTables;

type
  TFrmSelectDB = class(TForm)
    EdtDBName: TEdit;
    Label1: TLabel;
    BtnOK: TButton;
    BtnNo: TButton;
    procedure BtnNoClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
  private
    procedure WMNcLButtonDown(var Message: TMessage);message WM_NCLBUTTONDOWN;
    procedure WMNcRButtonDown(var Message: TMessage);message WM_NCRBUTTONDOWN;

  public
    { Public declarations }
  end;

var
  FrmSelectDB: TFrmSelectDB;

implementation
uses MakeLogin, Share;
{$R *.dfm}

procedure TFrmSelectDB.BtnNoClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmSelectDB.WMNcLButtonDown(var Message: TMessage);
begin
  if not (Message.WParam = HTCAPTION) then inherited;
end;

procedure TFrmSelectDB.WMNcRButtonDown(var Message: TMessage);
begin
  if not (Message.WParam = HTCAPTION) then inherited;
end;

procedure TFrmSelectDB.BtnOKClick(Sender: TObject);
var
  ap: TStringList;
begin
  ap := Tstringlist.Create;
  try
    Session.GetAliasNames(ap);
    if (ap.IndexOf(Trim(EdtDBName.Text)) = -1)then begin
      Application.MessageBox(PChar('没检测到"'+Trim(EdtDBName.Text)+'"数据源！'), 'Error', MB_OK + MB_ICONSTOP);
      ModalResult := -1;
    end;
  finally
    ap.Free;
  end;
end;



end.
