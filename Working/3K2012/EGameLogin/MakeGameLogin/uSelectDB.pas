unit uSelectDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BusinessSkinForm, bsSkinData, StdCtrls, Mask, RzEdit, DBTables,
  bsSkinCtrls;

type
  TFrmSelectDB = class(TForm)
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    bsSkinData1: TbsSkinData;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    Label1: TLabel;
    BtnOK: TbsSkinButton;
    BtnNo: TbsSkinButton;
    EdtDBName: TRzEdit;
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

{$R *.dfm}

procedure TFrmSelectDB.WMNcLButtonDown(var Message: TMessage);
begin
  if not (Message.WParam = HTCAPTION) then inherited;
end;

procedure TFrmSelectDB.WMNcRButtonDown(var Message: TMessage);
begin
  if not (Message.WParam = HTCAPTION) then inherited;
end;

procedure TFrmSelectDB.BtnNoClick(Sender: TObject);
begin
  Close;
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
