unit AddMagic;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  RzButton, StdCtrls, Mask, RzEdit, RzLabel, ExtCtrls, RzPanel,
  RzCmboBx,Grobal2;

type
  TAddMagicFrm = class(TForm)
    RzPanel2: TRzPanel;
    RzLabel5: TRzLabel;
    edtEdtMagicLevel: TRzEdit;
    RzBitBtn3: TRzBitBtn;
    RzBitBtn4: TRzBitBtn;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    ComboBoxJob: TRzComboBox;
    MagicBox: TRzComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure RzBitBtn4Click(Sender: TObject);
    procedure ComboBoxJobChange(Sender: TObject);
    procedure edtEdtMagicLevelKeyPress(Sender: TObject; var Key: Char);
    procedure RzBitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    IsHero:Boolean;
    nCode:Byte;//20081003
    { Public declarations }
  end;

var
  AddMagicFrm: TAddMagicFrm;

implementation
uses DBToolsShare, Main;
{$R *.dfm}

procedure TAddMagicFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TAddMagicFrm.FormDestroy(Sender: TObject);
begin
  AddMagicFrm:= nil;
end;

procedure TAddMagicFrm.RzBitBtn4Click(Sender: TObject);
begin
  Close;
end;

procedure TAddMagicFrm.ComboBoxJobChange(Sender: TObject);
  procedure FindMagic(Job:byte);
  var
    I: Integer;
    Magic: pTMagic;
  begin
    for i := 0 to MagicList.Count - 1 do begin
      Magic := MagicList.Items[i];
      if Magic <> nil then begin
        if (Magic.btJob = Job) or (Magic.btJob = 99) then begin
          if not IsHero then begin
            case nCode of
              0:begin
                if Magic.sDescr <> '' then Continue;
                MagicBox.Items.Add(Magic.sMagicName);
              end;
              1:begin
                if Magic.sDescr <> '内功' then Continue;
                MagicBox.Items.Add(Magic.sMagicName);
              end;
            end;//case
          end else begin
            case nCode of
              0:begin
                if Magic.sDescr = '' then Continue;
                MagicBox.Items.Add(Magic.sMagicName);
              end;
              1:begin
                if (Magic.sDescr = '') or (Magic.sDescr <> '内功') then Continue;
                MagicBox.Items.Add(Magic.sMagicName);
              end;
            end;//case
          end;
        end;
      end;
    end;
  end;
begin
  try
    if Trim(ComboBoxJob.Text) = '' then Exit;
    Case ComboBoxJob.ItemIndex of
      0: FindMagic(0);//战士
      1: FindMagic(1);//法师
      2: FindMagic(2);//道士
    end;
  except
  end;
end;

procedure TAddMagicFrm.edtEdtMagicLevelKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9',#8,#13]) then
  begin
    key:=#0;
    MessageBeep(1);
  end;
end;

procedure TAddMagicFrm.RzBitBtn3Click(Sender: TObject);
var I:Integer;
begin
  if (MagicBox.Text <> '') and (edtEdtMagicLevel.Text <> '') then begin
    case nCode of
      0:begin
        for I:= 0 to FrmMain.GridSkill.RowCount -1 do begin
          if FrmMain.GridSkill.Cells[1,I+1]='' then begin
            FrmMain.GridSkill.Cells[1, I+1] := Trim(MagicBox.Text);
            FrmMain.GridSkill.Cells[2, I+1] := IntToStr(GetMagicId(Trim(MagicBox.Text)));
            FrmMain.GridSkill.Cells[3, I+1] := Trim(edtEdtMagicLevel.Text);
            FrmMain.GridSkill.Cells[4, I+1] := '0';
            FrmMain.GridSkill.Cells[5, I+1] := '0';
            Break;
          end;
        end;
      end;
      1:begin
        for I:= 0 to FrmMain.GridNGSkill.RowCount -1 do begin
          if FrmMain.GridNGSkill.Cells[1,I+1]='' then begin
            FrmMain.GridNGSkill.Cells[1, I+1] := Trim(MagicBox.Text);
            FrmMain.GridNGSkill.Cells[2, I+1] := IntToStr(GetMagicId(Trim(MagicBox.Text)));
            FrmMain.GridNGSkill.Cells[3, I+1] := Trim(edtEdtMagicLevel.Text);
            FrmMain.GridNGSkill.Cells[4, I+1] := '0';
            FrmMain.GridNGSkill.Cells[5, I+1] := '0';
            Break;
          end;
        end;
      end;
    end;
  end else begin
    Application.MessageBox('技能名称及等级资料不能为空！' ,'提示信息',MB_ICONQUESTION+MB_OK);
  end;
end;

procedure TAddMagicFrm.FormShow(Sender: TObject);
begin
  ComboBoxJob.ItemIndex :=HumInfo.Data.btJob;
  ComboBoxJobChange(self);
end;

end.
