unit ConfigMerchant;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, Dialogs,
  StdCtrls, Spin, ObjNpc, HUtil32, Messages;

type
  TfrmConfigMerchant = class(TForm)
    GroupBoxNPC: TGroupBox;
    Label2: TLabel;
    EditScriptName: TEdit;
    Label3: TLabel;
    EditMapName: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EditShowName: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    CheckBoxOfCastle: TCheckBox;
    ComboBoxDir: TComboBox;
    EditImageIdx: TSpinEdit;
    EditX: TSpinEdit;
    EditY: TSpinEdit;
    GroupBoxScript: TGroupBox;
    MemoScript: TMemo;
    ButtonScriptSave: TButton;
    GroupBox3: TGroupBox;
    CheckBoxBuy: TCheckBox;
    CheckBoxSell: TCheckBox;
    CheckBoxStorage: TCheckBox;
    CheckBoxGetback: TCheckBox;
    CheckBoxMakedrug: TCheckBox;
    CheckBoxUpgradenow: TCheckBox;
    CheckBoxGetbackupgnow: TCheckBox;
    CheckBoxRepair: TCheckBox;
    CheckBoxS_repair: TCheckBox;
    ButtonReLoadNpc: TButton;
    ButtonSave: TButton;
    CheckBoxDenyRefStatus: TCheckBox;
    Label9: TLabel;
    EditPriceRate: TSpinEdit;
    Label10: TLabel;
    EditMapDesc: TEdit;
    CheckBoxSendMsg: TCheckBox;
    CheckBoxAutoMove: TCheckBox;
    Label11: TLabel;
    EditMoveTime: TSpinEdit;
    ButtonClearTempData: TButton;
    ButtonViewData: TButton;
    GroupBox1: TGroupBox;
    ListBoxMerChant: TListBox;
    CheckBoxArmsTear: TCheckBox;
    CheckBoxArmsExchange: TCheckBox;
    procedure ListBoxMerChantClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure CheckBoxDenyRefStatusClick(Sender: TObject);
    procedure EditXChange(Sender: TObject);
    procedure EditYChange(Sender: TObject);
    procedure EditShowNameChange(Sender: TObject);
    procedure EditImageIdxChange(Sender: TObject);
    procedure CheckBoxOfCastleClick(Sender: TObject);
    procedure CheckBoxBuyClick(Sender: TObject);
    procedure CheckBoxSellClick(Sender: TObject);
    procedure CheckBoxGetbackClick(Sender: TObject);
    procedure CheckBoxStorageClick(Sender: TObject);
    procedure CheckBoxUpgradenowClick(Sender: TObject);
    procedure CheckBoxGetbackupgnowClick(Sender: TObject);
    procedure CheckBoxRepairClick(Sender: TObject);
    procedure CheckBoxS_repairClick(Sender: TObject);
    procedure CheckBoxMakedrugClick(Sender: TObject);
    procedure EditPriceRateChange(Sender: TObject);
    procedure ButtonScriptSaveClick(Sender: TObject);
    procedure ButtonReLoadNpcClick(Sender: TObject);
    procedure EditScriptNameChange(Sender: TObject);
    procedure EditMapNameChange(Sender: TObject);
    procedure ComboBoxDirChange(Sender: TObject);
    procedure MemoScriptChange(Sender: TObject);
    procedure CheckBoxSendMsgClick(Sender: TObject);
    procedure CheckBoxAutoMoveClick(Sender: TObject);
    procedure EditMoveTimeChange(Sender: TObject);
    procedure ButtonClearTempDataClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBoxArmsTearClick(Sender: TObject);
    procedure CheckBoxArmsExchangeClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MemoScriptDblClick(Sender: TObject);
  private
    SelMerchant: TMerchant;
    boOpened: Boolean;
    //boModValued: Boolean;//20080522 注释
    procedure ModValue();
    procedure uModValue();
    procedure RefListBoxMerChant();
    procedure ClearMerchantData();
    procedure LoadScriptFile();
    procedure ChangeScriptAllowAction();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmConfigMerchant: TfrmConfigMerchant;

implementation

uses M2Share, Grobal2;

{$R *.dfm}

{ TfrmConfigMerchant }
procedure TfrmConfigMerchant.ModValue;
begin
  ButtonSave.Enabled := True;
  ButtonScriptSave.Enabled := True;
end;

procedure TfrmConfigMerchant.uModValue;
begin
  ButtonSave.Enabled := False;
  ButtonScriptSave.Enabled := False;
end;

procedure TfrmConfigMerchant.Open;
begin
  boOpened := False;
  uModValue();
  CheckBoxDenyRefStatus.Checked := False;
  SelMerchant := nil;
  RefListBoxMerChant;
  {$IF M2Version <> 2}
  CheckBoxArmsTear.Visible := True;
  {$IFEND}
  boOpened := True;
  //Caption:= Caption +':'+ IntToStr(UserEngine.m_MerchantList.Count); 
  ShowModal;
end;

procedure TfrmConfigMerchant.ButtonClearTempDataClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('是否确认清除NPC临时数据？'), '确认信息', MB_YESNO + MB_ICONQUESTION) = mrYes then begin
    ClearMerchantData();//清空NPC数据
  end;
end;

procedure TfrmConfigMerchant.ButtonSaveClick(Sender: TObject);
var
  I: Integer;
  SaveList: TStringList;
  Merchant: TMerchant;
  sMerchantFile: string;
  sIsCastle: string;
  sCanMove: string;
begin
  sMerchantFile := g_Config.sEnvirDir + 'Merchant.txt';
  SaveList := TStringList.Create;
  UserEngine.m_MerchantList.Lock;
  try
    if UserEngine.m_MerchantList.Count > 0 then begin//20080630
      for I := 0 to UserEngine.m_MerchantList.Count - 1 do begin
        Merchant := TMerchant(UserEngine.m_MerchantList.Items[I]);
        if Merchant.m_sMapName = '0' then Continue;

        if Merchant.m_boCastle then sIsCastle := '1'
        else sIsCastle := '0';
        if Merchant.m_boCanMove then sCanMove := '1'
        else sCanMove := '0';

        SaveList.Add(Merchant.m_sScript + #9 +
          Merchant.m_sMapName + #9 +
          IntToStr(Merchant.m_nCurrX) + #9 +
          IntToStr(Merchant.m_nCurrY) + #9 +
          Merchant.m_sCharName + #9 +
          IntToStr(Merchant.m_nFlag) + #9 +
          IntToStr(Merchant.m_wAppr) + #9 +
          sIsCastle + #9 +
          sCanMove + #9 +
          IntToStr(Merchant.m_dwMoveTime)
          )
      end;
    end;
    SaveList.SaveToFile(sMerchantFile);
  finally
    UserEngine.m_MerchantList.UnLock;
  end;
  SaveList.Free;
  uModValue();
end;

procedure TfrmConfigMerchant.ClearMerchantData;
var
  I: Integer;
  Merchant: TMerchant;
begin
  UserEngine.m_MerchantList.Lock;
  try
    if UserEngine.m_MerchantList.Count > 0 then begin//20080630
      for I := 0 to UserEngine.m_MerchantList.Count - 1 do begin
        Merchant := TMerchant(UserEngine.m_MerchantList.Items[I]);
        Merchant.ClearData();
      end;
    end;
  finally
    UserEngine.m_MerchantList.UnLock;
  end;
end;

procedure TfrmConfigMerchant.RefListBoxMerChant;
var
  I: Integer;
  Merchant: TMerchant;
begin
  UserEngine.m_MerchantList.Lock;
  try
    if UserEngine.m_MerchantList.Count > 0 then begin//20080630
      for I := 0 to UserEngine.m_MerchantList.Count - 1 do begin
        Merchant := TMerchant(UserEngine.m_MerchantList.Items[I]);
        if (Merchant.m_sMapName = '0') and (Merchant.m_nCurrX = 0) and (Merchant.m_nCurrY = 0) then Continue;
        ListBoxMerChant.Items.AddObject(Merchant.m_sCharName + ' - ' + Merchant.m_sMapName + ' (' + IntToStr(Merchant.m_nCurrX) + ':' + IntToStr(Merchant.m_nCurrY) + ')', Merchant);
      end;
    end;
  finally
    UserEngine.m_MerchantList.UnLock;
  end;

end;

procedure TfrmConfigMerchant.ListBoxMerChantClick(Sender: TObject);
var
  nSelIndex: Integer;
begin
  CheckBoxDenyRefStatus.Checked := False;
  uModValue();
  boOpened := False;
  nSelIndex := ListBoxMerChant.ItemIndex;
  if nSelIndex < 0 then Exit;
  SelMerchant := TMerchant(ListBoxMerChant.Items.Objects[nSelIndex]);
  EditScriptName.Text := SelMerchant.m_sScript;
  EditMapName.Text := SelMerchant.m_sMapName;
  EditMapDesc.Text := SelMerchant.m_PEnvir.sMapDesc;
  EditX.Value := SelMerchant.m_nCurrX;
  EditY.Value := SelMerchant.m_nCurrY;
  EditShowName.Text := SelMerchant.m_sCharName;
  ComboBoxDir.ItemIndex := SelMerchant.m_nFlag;
  EditImageIdx.Value := SelMerchant.m_wAppr;
  CheckBoxOfCastle.Checked := SelMerchant.m_boCastle;
  CheckBoxAutoMove.Checked := SelMerchant.m_boCanMove;
  EditMoveTime.Value := SelMerchant.m_dwMoveTime;

  CheckBoxBuy.Checked := SelMerchant.m_boBuy;
  CheckBoxSell.Checked := SelMerchant.m_boSell;
  CheckBoxGetback.Checked := SelMerchant.m_boGetback;
  CheckBoxStorage.Checked := SelMerchant.m_boStorage;
  CheckBoxUpgradenow.Checked := SelMerchant.m_boUpgradenow;
  CheckBoxGetbackupgnow.Checked := SelMerchant.m_boGetBackupgnow;
  CheckBoxRepair.Checked := SelMerchant.m_boRepair;
  CheckBoxArmsTear.Checked := SelMerchant.m_boArmsTear;
  CheckBoxArmsExchange.Checked := SelMerchant.m_boArmsExchange;
  CheckBoxS_repair.Checked := SelMerchant.m_boS_repair;
  CheckBoxMakedrug.Checked := SelMerchant.m_boMakeDrug;
  CheckBoxSendMsg.Checked := SelMerchant.m_boSendmsg;


  EditPriceRate.Value := SelMerchant.m_nPriceRate;
  MemoScript.Clear;
  ButtonReLoadNpc.Enabled := False;
  LoadScriptFile();

  GroupBoxNPC.Enabled := True;
  GroupBoxScript.Enabled := True;

  boOpened := True;
end;

procedure TfrmConfigMerchant.FormCreate(Sender: TObject);
begin
  ComboBoxDir.Items.Add('0');
  ComboBoxDir.Items.Add('1');
  ComboBoxDir.Items.Add('2');
  ComboBoxDir.Items.Add('3');
  ComboBoxDir.Items.Add('4');
  ComboBoxDir.Items.Add('5');
  ComboBoxDir.Items.Add('6');
  ComboBoxDir.Items.Add('7');
end;


procedure TfrmConfigMerchant.CheckBoxDenyRefStatusClick(Sender: TObject);
begin
  if SelMerchant <> nil then begin
    SelMerchant.m_boDenyRefStatus := CheckBoxDenyRefStatus.Checked;
  end;
end;

procedure TfrmConfigMerchant.EditXChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_nCurrX := EditX.Value;
  ModValue();
end;

procedure TfrmConfigMerchant.EditYChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_nCurrY := EditY.Value;
  ModValue();
end;

procedure TfrmConfigMerchant.EditShowNameChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_sCharName := Trim(EditShowName.Text);
  ModValue();
end;

procedure TfrmConfigMerchant.EditImageIdxChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_wAppr := EditImageIdx.Value;
  ModValue();
end;

procedure TfrmConfigMerchant.EditScriptNameChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_sScript := Trim(EditScriptName.Text);
  ModValue();
end;

procedure TfrmConfigMerchant.EditMapNameChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_sMapName := Trim(EditMapName.Text);
  ModValue();
end;

procedure TfrmConfigMerchant.ComboBoxDirChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_nFlag := ComboBoxDir.ItemIndex;
  ModValue();
end;

procedure TfrmConfigMerchant.CheckBoxOfCastleClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_boCastle := CheckBoxOfCastle.Checked;
  ModValue();
end;


procedure TfrmConfigMerchant.CheckBoxAutoMoveClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_boCanMove := CheckBoxAutoMove.Checked;
  ModValue();
end;


procedure TfrmConfigMerchant.EditMoveTimeChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_dwMoveTime := EditMoveTime.Value;
  ModValue();
end;

procedure TfrmConfigMerchant.LoadScriptFile;
var
  I: Integer;
  sScriptFile: string;
  LoadList: TStringList;
  LineText: string;
  boNoHeader: Boolean;
begin
  if SelMerchant = nil then Exit;
  sScriptFile := g_Config.sEnvirDir + 'Market_Def\' + SelMerchant.m_sScript + '-' + SelMerchant.m_sMapName + '.txt';
  MemoScript.Visible := False;
  LineText := '(';
  if SelMerchant.m_boBuy then LineText := LineText + sBUY + ' ';
  if SelMerchant.m_boSell then LineText := LineText + sSELL + ' ';
  if SelMerchant.m_boMakeDrug then LineText := LineText + sMAKEDURG + ' ';
  if SelMerchant.m_boStorage then LineText := LineText + sSTORAGE + ' ';
  if SelMerchant.m_boGetback then LineText := LineText + sGETBACK + ' ';
  if SelMerchant.m_boUpgradenow then LineText := LineText + sUPGRADENOW + ' ';
  if SelMerchant.m_boGetBackupgnow then LineText := LineText + sGETBACKUPGNOW + ' ';
  if SelMerchant.m_boRepair then LineText := LineText + sREPAIR + ' ';
  {$IF M2Version <> 2}
  if SelMerchant.m_boArmsTear then LineText := LineText + sArmsTear + ' ';
  if SelMerchant.m_boArmsExchange then LineText := LineText + sArmsExchange + ' ';
  {$IFEND}
  if SelMerchant.m_boS_repair then LineText := LineText + sSUPERREPAIR + ' ';
  if SelMerchant.m_boSendmsg then LineText := LineText + sSL_SENDMSG + ' ';

  {if SelMerchant.m_boBuyOff then LineText := LineText + sBUYOFF + ' ';
  if SelMerchant.m_boSellOff then LineText := LineText + sSELLOFF + ' ';
  if SelMerchant.m_boGetSellGold then LineText := LineText + sGETSELLGOLD + ' ';} //20080416 去掉拍卖功能

  LineText := LineText + ')';
  MemoScript.Lines.Add(LineText);
  LineText := '%' + IntToStr(SelMerchant.m_nPriceRate);
  MemoScript.Lines.Add(LineText);
  if SelMerchant.m_ItemTypeList.Count > 0 then begin//20080630
    for I := 0 to SelMerchant.m_ItemTypeList.Count - 1 do begin
      LineText := '+' + IntToStr(Integer(SelMerchant.m_ItemTypeList.Items[I]));
      MemoScript.Lines.Add(LineText);
    end;
  end;
  if FileExists(sScriptFile) then begin
    LoadList := TStringList.Create;
    LoadList.LoadFromFile(sScriptFile);
    boNoHeader := False;
    if LoadList.Count > 0 then begin//20080630
      for I := 0 to LoadList.Count - 1 do begin
        LineText := LoadList.Strings[I];
        if (LineText = '') or (LineText[1] = ';') then Continue;    
        if (LineText[1] = '[') or (LineText[1] = '#') then boNoHeader := True;
        if boNoHeader then begin
          MemoScript.Lines.Add(LineText);
        end;         
      end;
    end;
    LoadList.Free;
  end;
  MemoScript.Visible := True;
  MemoScript.ReadOnly := False;
end;

procedure TfrmConfigMerchant.ChangeScriptAllowAction;
var
  LineText: string;
begin
  if (SelMerchant = nil) or (MemoScript.Lines.Count <= 0) then Exit;
  LineText := '(';
  if SelMerchant.m_boBuy then LineText := LineText + sBUY + ' ';
  if SelMerchant.m_boSell then LineText := LineText + sSELL + ' ';
  if SelMerchant.m_boMakeDrug then LineText := LineText + sMAKEDURG + ' ';
  if SelMerchant.m_boStorage then LineText := LineText + sSTORAGE + ' ';
  if SelMerchant.m_boGetback then LineText := LineText + sGETBACK + ' ';
  if SelMerchant.m_boUpgradenow then LineText := LineText + sUPGRADENOW + ' ';
  if SelMerchant.m_boGetBackupgnow then LineText := LineText + sGETBACKUPGNOW + ' ';
  if SelMerchant.m_boRepair then LineText := LineText + sREPAIR + ' ';
  {$IF M2Version <> 2}
  if SelMerchant.m_boArmsTear then LineText := LineText + sArmsTear + ' ';
  if SelMerchant.m_boArmsExchange then LineText := LineText + sArmsExchange + ' ';
  {$IFEND}  
  if SelMerchant.m_boS_repair then LineText := LineText + sSUPERREPAIR + ' ';
  if SelMerchant.m_boSendmsg then LineText := LineText + sSL_SENDMSG + ' ';
  LineText := LineText + ')';
  MemoScript.Lines[0] := LineText;
end;

procedure TfrmConfigMerchant.CheckBoxBuyClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_boBuy := CheckBoxBuy.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxSellClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_boSell := CheckBoxSell.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxGetbackClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_boGetback := CheckBoxGetback.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxStorageClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_boStorage := CheckBoxStorage.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxUpgradenowClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_boUpgradenow := CheckBoxUpgradenow.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxGetbackupgnowClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_boGetBackupgnow := CheckBoxGetbackupgnow.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxRepairClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_boRepair := CheckBoxRepair.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxS_repairClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_boS_repair := CheckBoxS_repair.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxMakedrugClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_boMakeDrug := CheckBoxMakedrug.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxSendMsgClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_boSendmsg := CheckBoxSendMsg.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.EditPriceRateChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;

  SelMerchant.m_nPriceRate := EditPriceRate.Value;
  MemoScript.Lines[1] := '%' + IntToStr(SelMerchant.m_nPriceRate);
  ModValue();

end;

procedure TfrmConfigMerchant.ButtonScriptSaveClick(Sender: TObject);
var
  sScriptFile: string;
begin
  sScriptFile := g_Config.sEnvirDir + 'Market_Def\' + SelMerchant.m_sScript + '-' + SelMerchant.m_sMapName + '.txt';
  MemoScript.Lines.SaveToFile(sScriptFile);
  uModValue();
  ButtonReLoadNpc.Enabled := True;
end;
//重新加载NPC脚本内容
procedure TfrmConfigMerchant.ButtonReLoadNpcClick(Sender: TObject);
begin
  if (SelMerchant = nil) then Exit;
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    SelMerchant.ClearScript;
    SelMerchant.LoadNpcScript;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
  ButtonReLoadNpc.Enabled := False;
end;

procedure TfrmConfigMerchant.MemoScriptChange(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  ModValue();
end;

procedure TfrmConfigMerchant.MemoScriptDblClick(Sender: TObject);
var
  sSel : string;
  sFileName : string;
  nCol : Integer; 
  sAdds : TStringList;
  I : Integer;
  H : HWND;
begin
  if MemoScript.Lines.Count > 0 then begin   
    //Call解析 By TasNat at: 2012-04-17 11:19:29  
    nCol := SendMessage(MemoScript.Handle, EM_LINEFROMCHAR, MemoScript.SelStart, 0); 
    if (nCol >= 0) and (nCol < MemoScript.Lines.Count) then begin//范围检测
      sSel := MemoScript.Lines[nCol];
      if (sSel <> '') and (sSel[1] = '#') then begin
        if CompareLStr(sSel, '#CALL', 5) {or CompareLStr(s14, 'GOTO', 5)} then begin
          sSel := Trim(ArrestStringEx(sSel, '[', ']', sFileName));
          while (sFileName <> '') and (sFileName[1] = '\') do
            Delete(sFileName, 1, 1);
          sFileName := g_Config.sEnvirDir + 'QuestDiary\' + sFileName;
          if FileExists(sFileName) then begin
            sAdds := TStringList.Create;
            try
              sAdds.LoadFromFile(sFileName);
              I := 0;   
              sSel := '[' + sSel + ']';
              //跳转到标签
              while (sAdds.Count > 0) and ((sAdds[0] = '') or (sAdds[0][1] <> '[') or (CompareText(sSel, sAdds[0]) <> 0)) do begin
                Inc(I, Length(sAdds[0]) + 2);
                sAdds.Delete(0);
              end;
              //用Windows 记事本打开
              WinExec(PChar('Notepad "' + sFileName + '"'), SW_SHOW);
              //查找编辑框句柄
              H := FindWindowEx(FindWindow('Notepad', nil), 0,'Edit', nil);
              //跳转到标签所在行
              if H > 0 then begin     
                SendMessage(H, EM_SETSEL, I, I);
                SendMessage(H, EM_SCROLLCARET, 0,0);
              end else begin//失败则在编辑框里显示(只读)
                MemoScript.Lines.AddStrings(sAdds);
                MemoScript.ReadOnly := True;
              end;
            finally
              sAdds.Free;
            end;
          end;
        end;
      end;

    end;
  end;
  

end;

procedure TfrmConfigMerchant.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmConfigMerchant.FormDestroy(Sender: TObject);
begin
  frmConfigMerchant:= nil;
end;

procedure TfrmConfigMerchant.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  btFindMode : Byte;
  sFindStr : string;
  nFindData: Integer;
  I  : Integer;
  Merchant: TMerchant;
begin
  if Key = VK_ESCAPE then Close;
  if (ssCtrl in Shift) then begin
    //查找NPC By TasNat at: 2012-04-17 11:21:34
    if (Key = Ord('F')) or (Key = Ord('f')) then begin
      sFindStr := InputBox('输入查找内容','如:0老兵, All=全部', '0老兵');
      if (Length(sFindStr) > 1) then begin
        ListBoxMerChant.Items.Clear;
        if CompareText(sFindStr, 'All') =0  then begin
          RefListBoxMerChant;
          Exit;
        end;

        btFindMode := Str_ToInt(sFindStr[1], 0);
        Delete(sFindStr, 1, 1);
        nFindData := Str_ToInt(sFindStr, 0);

        
        for I := 0 to UserEngine.m_MerchantList.Count - 1 do begin
          Merchant := TMerchant(UserEngine.m_MerchantList.Items[I]);
          if (Merchant <> nil) then begin
            if (Merchant.m_sMapName = '0') and (Merchant.m_nCurrX = 0) and (Merchant.m_nCurrY = 0) then Continue;
            case btFindMode of
              0:if Pos(sFindStr, Merchant.m_sCharName) > 0 then ListBoxMerChant.Items.AddObject(Merchant.m_sCharName + ' - ' + Merchant.m_sMapName + ' (' + IntToStr(Merchant.m_nCurrX) + ':' + IntToStr(Merchant.m_nCurrY) + ')', Merchant);//查找名字
              1:if Abs(nFindData - Merchant.m_nCurrX) <= 10 then ListBoxMerChant.Items.AddObject(Merchant.m_sCharName + ' - ' + Merchant.m_sMapName + ' (' + IntToStr(Merchant.m_nCurrX) + ':' + IntToStr(Merchant.m_nCurrY) + ')', Merchant);//查找坐标
              2:if Abs(nFindData - Merchant.m_nCurrY) <= 10 then ListBoxMerChant.Items.AddObject(Merchant.m_sCharName + ' - ' + Merchant.m_sMapName + ' (' + IntToStr(Merchant.m_nCurrX) + ':' + IntToStr(Merchant.m_nCurrY) + ')', Merchant);//查找坐标
              3:if nFindData = Merchant.m_wAppr then ListBoxMerChant.Items.AddObject(Merchant.m_sCharName + ' - ' + Merchant.m_sMapName + ' (' + IntToStr(Merchant.m_nCurrX) + ':' + IntToStr(Merchant.m_nCurrY) + ')', Merchant);//查找坐标
              4:if Pos(sFindStr, Merchant.m_sMapName) > 0 then ListBoxMerChant.Items.AddObject(Merchant.m_sCharName + ' - ' + Merchant.m_sMapName + ' (' + IntToStr(Merchant.m_nCurrX) + ':' + IntToStr(Merchant.m_nCurrY) + ')', Merchant);//查找名字
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmConfigMerchant.CheckBoxArmsExchangeClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_boArmsExchange := CheckBoxArmsExchange.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

procedure TfrmConfigMerchant.CheckBoxArmsTearClick(Sender: TObject);
begin
  if not boOpened or (SelMerchant = nil) then Exit;
  SelMerchant.m_boArmsTear := CheckBoxArmsTear.Checked;
  ModValue();
  ChangeScriptAllowAction();
end;

end.
