unit BlurFind;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  ExtCtrls, RzPanel, RzButton, StdCtrls, RzLstBox, Mask, RzEdit,
  RzLabel,HumDB, StrUtils;

type
  TFrmBlurFind = class(TForm)
    RzPanel1: TRzPanel;
    RzLabel26: TRzLabel;
    RzEdit1: TRzEdit;
    ListBox: TRzListBox;
    RzToolButton1: TRzToolButton;
    RzToolButton2: TRzToolButton;
    RzToolButton3: TRzToolButton;
    procedure RzToolButton3Click(Sender: TObject);
    procedure RzToolButton1Click(Sender: TObject);
    procedure RzToolButton2Click(Sender: TObject);
  private
    btMode: Byte;
  public
    procedure Open(Mode: Byte);
  end;

var
  FrmBlurFind: TFrmBlurFind;

implementation
uses Grobal2, IDDB, Main;
{$R *.dfm}

{ TFrmBlurFind }

procedure TFrmBlurFind.Open(Mode: Byte);
begin
  RzEdit1.Text := '';
  ListBox.Clear;
  case Mode of
    0: begin
      RzLabel26.Caption := 'ID帐号：';
    end;
    1: begin
      RzLabel26.Caption := '角色名：';
    end;
    2: begin
      RzLabel26.Caption := 'ID帐号：';
    end;
  end;
  btMode := Mode;
  ShowModal;
end;

procedure TFrmBlurFind.RzToolButton3Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmBlurFind.RzToolButton1Click(Sender: TObject);
var
  sAccount: string;
  AccountList: TStringList;
  I, nIndex: Integer;
  DBRecord: TAccountDBRecord;
  HumanRCD: THumDataInfo;
begin
  ListBox.Clear;
  case btMode of
    1: begin
        sAccount := Trim(RzEdit1.Text);
        if sAccount = '' then Exit;
        try
          if HumDataDB.OpenEx then begin
            if HumDataDB.count > 0 then begin
              for nIndex:= 0 to HumDataDB.count -1 do begin
                if HumDataDB.Get(nIndex, HumanRCD) >= 0 then begin
                  if AnsiContainsText(HumanRCD.Data.sChrName, sAccount) and (not HumanRCD.Header.boIsHero) then
                   ListBox.Items.Add(HumanRCD.Data.sChrName);
                end;
              end;
            end;
          end;
        finally
          HumDataDB.Close;
        end;
     end;
    2: begin
      try
        sAccount := Trim(RzEdit1.Text);
        if sAccount = '' then Exit;
        AccountList := TStringList.Create;
        try
          if AccountDB.Open then begin
            if AccountDB.FindByName(sAccount, AccountList) > 0 then begin
              for I := 0 to AccountList.Count - 1 do begin
                nIndex := Integer(AccountList.Objects[I]);
                if AccountDB.GetBy(nIndex, DBRecord) then begin
                  ListBox.Items.Add(DBRecord.UserEntry.sAccount);
                end;
              end;
            end;
          end;
        finally
          AccountDB.Close;
        end;
        AccountList.Free;
      except
       // MainOutMessage('TFrmFindUserId.BtnFindAllClick');
      end;
    end;
  end;
end;

procedure TFrmBlurFind.RzToolButton2Click(Sender: TObject);
var
  n10, nIndex: Integer;
  HumDBRecord: THumInfo;
  HumanRCD: THumDataInfo;
begin
  if ListBox.ItemIndex >= 0 then begin
    case btMode of
      1:begin
          if Trim(ListBox.SelectedItem) = '' then begin
            Application.MessageBox('请选择帐号！', '提示', MB_OK + MB_ICONINFORMATION);
            Exit;
          end;
          try
            if HumChrDB.OpenEx then begin
              n10 := HumChrDB.Index(ListBox.SelectedItem);
              if n10 >= 0 then begin
                nIndex := HumChrDB.Get(n10, HumDBRecord);
                if (nIndex >= 0) and (not HumDBRecord.Header.boIsHero) then begin
                  FrmMain.ComboBoxAccount.Items.Clear;
                  FrmMain.ComboBoxAccount.Style:= csDropDown;
                  FrmMain.ComboBoxAccount.Text := HumDBRecord.sAccount;

                  FrmMain.ComboBoxHum.Items.Clear;
                  FrmMain.ComboBoxHum.Style:= csDropDown;
                  FrmMain.ComboBoxHum.Text := Trim(ListBox.SelectedItem);
                  FrmMain.RzEdit2.Text := Trim(ListBox.SelectedItem);
                  try
                    if HumDataDB.OpenEx then begin
                      if HumDataDB.count > 0 then begin
                        n10:= HumDataDB.Index(Trim(ListBox.SelectedItem));
                        nIndex := HumDataDB.Get(n10, HumInfo);
                        if nIndex >= 0 then begin
                          FrmMain.RefChrGrid(HumInfo);
                        end;
                        FrmMain.ComboBoxHero.Items.Clear;
                        for nIndex:= 0 to HumDataDB.count -1 do begin
                          if HumDataDB.Get(nIndex, HumanRCD) >= 0 then begin
                            if HumanRCD.Data.boIsHero and (CompareText(Trim(ListBox.SelectedItem), HumanRCD.Data.sMasterName) = 0) then
                            FrmMain.ComboBoxHero.Items.Add(HumanRCD.Data.sChrName);
                          end;
                        end;
                      end;
                    end;
                  finally
                    HumDataDB.Close;
                  end;
                end else begin
                  Application.MessageBox('没有找到你要查找的角色！', '提示', MB_OK + MB_ICONINFORMATION);
                  FrmMain.ComboBoxHum.Style:= csDropDownList;
                end;
              end;
            end;
          finally
            HumChrDB.Close;
          end;
          Close;
      end;
      2:begin
          if Trim(ListBox.SelectedItem) = '' then begin
            Application.MessageBox('请选择帐号！', '提示', MB_OK + MB_ICONINFORMATION);
            Exit;
          end;
          try
            if AccountDB.Open then begin
              n10 := AccountDB.Index(Trim(ListBox.SelectedItem));
              if (n10 >= 0) and (AccountDB.Get(n10, DBRecord) >= 0) then begin
                FrmMain.ComboBoxAccount.Items.Clear;
                FrmMain.ComboBoxAccount.Style:= csDropDown;
                FrmMain.ComboBoxAccount.Text := ListBox.SelectedItem;
                FrmMain.ComboBoxAccount1.Items.Clear;
                FrmMain.ComboBoxAccount1.Style:= csDropDown;
                FrmMain.ComboBoxAccount1.Text := ListBox.SelectedItem;
                FrmMain.ComboBoxAccount.OnChange(self);
                FrmMain.RzEdit1.Text := Trim(ListBox.SelectedItem);
                FrmMain.ShowUserAccount(DBRecord);
                Close;
              end else begin
                Application.MessageBox('没有找到你要查找的帐号！', '提示', MB_OK + MB_ICONINFORMATION);
                FrmMain.ComboBoxAccount.Style:= csDropDownList;
                FrmMain.ComboBoxAccount1.Style:= csDropDownList;
              end;
            end;
          finally
            AccountDB.Close;
          end;
      end;
    end;
  end;
end;

end.
