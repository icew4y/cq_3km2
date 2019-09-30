unit uTzHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bsSkinData, BusinessSkinForm, bsSkinShellCtrls, jpeg, ExtCtrls,
  StdCtrls;

type
  TFrmTzHelp = class(TForm)
    LoadPatchFileOpenDialog: TbsSkinOpenDialog;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinData1: TbsSkinData;
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    Memo1: TMemo;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTzHelp: TFrmTzHelp;

implementation

{$R *.dfm}

end.
