unit FState1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DWinCtl, DXDraws, uDCheckBox;

type
  TFrmDlg1 = class(TForm)
    DWRefineDrum: TDWindow;
    RefineBtn2: TDButton;
    RefineBtn1: TDButton;
    RefineBtn4: TDButton;
    RefineBtn5: TDButton;
    RefineBtn3: TDButton;
    RefineBtn6: TDButton;
    DBRefineDrumOKBtn: TDButton;
    DBRefineDrumCloseBtn: TDButton;
    DWSignedItemNew: TDWindow;
    DCHSignedItemValue1: TDCheckBox;
    DCHSignedItemValue2: TDCheckBox;
    DCHSignedItemValue3: TDCheckBox;
    DCHSignedItemValue4: TDCheckBox;
    DWSignedItemPage0: TDButton;
    DWSignedItemPage1: TDButton;
    DWSignedItemOk: TDButton;
    DWSignedItemNewNeed2: TDButton;
    DWSignedItemNewNeed1: TDButton;
    DWSignedItemNewItem: TDButton;
    DWSignedItemClose: TDButton;
    DCHSignedItemAutoLockValue: TDCheckBox;
    procedure DBRefineDrumCloseBtnClick(Sender: TObject; X, Y: Integer);
    procedure DBRefineDrumOKBtnClick(Sender: TObject; X, Y: Integer);
    procedure RefineBtn1Click(Sender: TObject; X, Y: Integer);
    procedure RefineBtn1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure RefineBtn1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DWRefineDrumInitialize(Sender: TObject);
    procedure DBRefineDrumOKBtnInitialize(Sender: TObject);
    procedure DBRefineDrumOKBtnDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DBRefineDrumCloseBtnInitialize(Sender: TObject);
    procedure DBRefineDrumCloseBtnDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DWSignedItemNewDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DWSignedItemNewInitialize(Sender: TObject);
    procedure DWSignedItemNewMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DCHSignedItemValue1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DCHSignedItemValue1Initialize(Sender: TObject);
    procedure DWSignedItemOkClick(Sender: TObject; X, Y: Integer);
    procedure DWSignedItemNewItemClick(Sender: TObject; X, Y: Integer);
    procedure DWSignedItemNewItemDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DCHSignedItemAutoLockValueInitialize(Sender: TObject);
    procedure DCHSignedItemAutoLockValueDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DWSignedItemOkDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DWSignedItemPage0DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DWSignedItemPage0Initialize(Sender: TObject);
    procedure DWSignedItemCloseDirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DWSignedItemOkInitialize(Sender: TObject);
    procedure DWSignedItemPage1Click(Sender: TObject; X, Y: Integer);
    procedure DWSignedItemNewNeed1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DWSignedItemNewItemInitialize(Sender: TObject);
    procedure DWSignedItemNewNeed1Initialize(Sender: TObject);
    procedure DWSignedItemNewNeed1DirectPaint(Sender: TObject;
      dsurface: TDirectDrawSurface);
    procedure DWSignedItemCloseClick(Sender: TObject; X, Y: Integer);
    procedure DWSignedItemCloseInitialize(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  FrmDlg1: TFrmDlg1;

implementation
uses MShare, FState, ClFunc, ClMain, EDcode, Grobal2, SoundUtil, Share, cliUtil;
{$R *.dfm}

procedure TFrmDlg1.DBRefineDrumCloseBtnClick(Sender: TObject; X, Y: Integer);
var
  I : Integer;
begin
  DWRefineDrum.Visible:=False;
  for I := 0 to 5 do
  if g_RefineDrumItem[I].s.Name <> '' then begin
    AddItemBag(g_RefineDrumItem[I]);
    g_RefineDrumItem[I].s.Name := '';
  end;
  // 发送消息给服务端，有物品则放到包裹里面
end;

procedure TFrmDlg1.DBRefineDrumCloseBtnDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
    if WLib <> nil then begin   //20080701
      if not Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
           dsurface.Draw (SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, TRUE);
      end else begin
         d := WLib.Images[FaceIndex + 1];
         if d <> nil then
           dsurface.Draw(SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, TRUE);
      end;
    end;
   end;

end;

procedure TFrmDlg1.DBRefineDrumCloseBtnInitialize(Sender: TObject);
begin
	with Sender as TDButton do
    SetImgIndex(g_WMain3Images,233);
end;

procedure TFrmDlg1.DBRefineDrumOKBtnClick(Sender: TObject; X, Y: Integer);
var msg: TDefaultMessage;
    I,btCount:Integer;
    Str2:string;
    MakeIndexs : array [0..9] of Integer;
begin
  btCount := 0;
  //修改提示 By TasNat at: 2012-04-21 23:16:35
  if g_RefineDrumItem[5].s.Name = ''  then begin
    FrmDlg.DMessageDlg('缺少主材料!',[mbOK]);
    Exit;
  end;
  for I := 0 to 4 do
  begin
    {if ((g_RefineDrumItem[I].s.Name='') then
    begin
      DMessageDlg('缺少辅助材料!',[mbOK]);
      Exit;
    end;}
    if g_RefineDrumItem[I].s.Name<>'' then
    begin
      MakeIndexs[btCount] := g_RefineDrumItem[I].MakeIndex;
      Inc(btCount);
    end;
  end;
  msg := MakeDefaultMsg (aa(CM_REFINEARMYDRUM, frmMain.TempCertification), g_RefineDrumItem[5].MakeIndex, btCount, 0, 0, frmMain.m_nSendMsgCount);// 发送淬炼军鼓到服务端
  FrmMain.SendSocket(EncodeMessage (msg)+Encodestring(EncodeBuffer(@MakeIndexs, btCount * 4)));//20071231
end;

procedure TFrmDlg1.DBRefineDrumOKBtnDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
begin
   with Sender as TDButton do begin
    if WLib <> nil then begin   //20080701
      MainForm.Canvas.Font.Style := [fsBold];
      if not Downed then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
           dsurface.Draw (SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, TRUE);

         dsurface.TextOut(SurfaceX(GLeft)+18,SurfaceY(GTop)+11,$00B4E2FE,'升级'); // $00C0E9FE

      end else begin
         d := WLib.Images[FaceIndex + 1];
         if d <> nil then
           dsurface.Draw(SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, TRUE);
         dsurface.TextOut(SurfaceX(GLeft)+19,SurfaceY(GTop)+12,$00B4E2FE,'升级');
      end;
      MainForm.Canvas.Font.Style := [];
    end;
   end;

end;

procedure TFrmDlg1.DBRefineDrumOKBtnInitialize(Sender: TObject);
begin
	with Sender as TDButton do
    SetImgIndex(g_WMainImages,1421);
end;

procedure TFrmDlg1.DWSignedItemPage0DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
{$IF M2Version <> 2}
var
  d: TDirectDrawSurface;
{$IFEND}
begin
  {$IF M2Version <> 2}
  with TDButton(Sender) do begin
    if WLib <> nil then begin
      if Downed then begin
        d := WLib.Images[FaceIndex + 1];
        if d <> nil then begin
          dsurface.Draw(SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, True);
          dsurface.BoldTextOut (SurfaceX(GLeft) + 37 - frmMain.Canvas.TextWidth(TDButton(Sender).Hint) div 2, SurfaceY(GTop) + 6, $0048A4E8, clBlack, TDButton(Sender).Hint);
        end;
      end else begin
        d := WLib.Images[FaceIndex];
        if d <> nil then begin
          dsurface.Draw(SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, True);
          if MouseMoveing then begin
            dsurface.BoldTextOut (SurfaceX(GLeft) + 36 - frmMain.Canvas.TextWidth(TDButton(Sender).Hint) div 2, SurfaceY(GTop) + 5, $00A8D4E8, clBlack, TDButton(Sender).Hint);
          end else dsurface.BoldTextOut (SurfaceX(GLeft) + 36 - frmMain.Canvas.TextWidth(TDButton(Sender).Hint) div 2, SurfaceY(GTop) + 5, $0088C4E8, clBlack, TDButton(Sender).Hint);
        end;
      end;
    end;
  end;
  {$IFEND}

end;

procedure TFrmDlg1.DWSignedItemPage0Initialize(Sender: TObject);
begin
{$IF M2Version <> 2}
  TDButton(Sender).SetImgIndex(g_WMainImages, 1614);
{$IFEND}
end;

procedure TFrmDlg1.DWSignedItemPage1Click(Sender: TObject; X, Y: Integer);
begin
  DWSignedItemNew.Tag := TDButton(Sender).Tag;

  DCHSignedItemValue1.Enabled := DWSignedItemNew.Tag = 0;
  DCHSignedItemValue2.Enabled := DWSignedItemNew.Tag = 0;
  DCHSignedItemValue3.Enabled := DWSignedItemNew.Tag = 0;
  DCHSignedItemValue4.Enabled := DWSignedItemNew.Tag = 0;
  DCHSignedItemAutoLockValue.Enabled := DWSignedItemNew.Tag = 0;

  DCHSignedItemAutoLockValue.Visible := DWSignedItemNew.Tag = 0;

  DCHSignedItemValue1.Visible := DCHSignedItemValue1.Enabled and (DCHSignedItemValue1.Caption <> '');
  DCHSignedItemValue2.Visible := DCHSignedItemValue2.Enabled and (DCHSignedItemValue2.Caption <> '');
  DCHSignedItemValue3.Visible := DCHSignedItemValue3.Enabled and (DCHSignedItemValue3.Caption <> '');
  DCHSignedItemValue4.Visible := DCHSignedItemValue4.Enabled and (DCHSignedItemValue4.Caption <> '');

  DWSignedItemNewItem.Visible := DWSignedItemNew.Tag = 0;
  DWSignedItemNewNeed1.Visible := DWSignedItemNew.Tag = 0;
  DWSignedItemNewNeed2.Visible := DWSignedItemNew.Tag = 0;
  DWSignedItemOk.Visible := DWSignedItemNew.Tag = 0;
end;

procedure TFrmDlg1.DWSignedItemOkClick(Sender: TObject; X, Y: Integer);
var
  boTrainee  : Boolean;
  sItemValueRetainMarks : string;
  I,II : Integer;
begin
{$IF M2Version <> 2}
  if FrmDlg.m_boSignedLock then begin
    //FrmDlg.DMessageDlg ('鉴定中请稍等...', [mbOK]);
    Exit;
  end;
  FrmDlg.m_dwSignedLockTick := GetTickCount;
  g_XinJianDingNeeds[0] := g_SerXinJianDingNeeds[0];
  g_XinJianDingNeeds[1] := g_SerXinJianDingNeeds[1];
  with DCHSignedItemValue1 do begin
    if Checked then
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 1
    else
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 0;
  end;
  with DCHSignedItemValue2 do begin
    if Checked then
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 1
    else
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 0;
  end;
  with DCHSignedItemValue3 do begin
    if Checked then
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 1
    else
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 0;
  end;
  
  with DCHSignedItemValue4 do begin
    if Checked then
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 1
    else
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 0;
  end;

  for II := Low(g_XinJianDingData.ItemValueRetainMarks) to High(g_XinJianDingData.ItemValueRetainMarks) do
     if g_XinJianDingData.ItemValueRetainMarks[II] = 1 then
     for I := Low(g_SerXinJianDingLockNeeds)to High(g_SerXinJianDingLockNeeds) do
       Inc(g_XinJianDingNeeds[I], g_SerXinJianDingLockNeeds[I]);

  if FrmDlg.m_boSignedLock then Exit;
  if not TDButton(Sender).Enabled then Exit;
  if g_SignedItem[0].s.Name = '' then begin
    FrmDlg.DMessageDlg ('请放入需要鉴定的装备！', [mbOK]);
    Exit;
  end;
  boTrainee := False;
  for I := Low(g_XinJianDingData.ItemValueRetainMarks) to High(g_XinJianDingData.ItemValueRetainMarks) do
    if 1 <> (g_XinJianDingData.ItemValueRetainMarks[I]) then boTrainee := True;

  if not boTrainee then begin
    FrmDlg.DMessageDlg ('不能全部保留！', [mbOK]);
    Exit;
  end;
  boTrainee := False;
  if g_SignedItem[0].s.Name <> '' then begin
    if (g_SignedItem[1].s.Name = '') or (g_SignedItem[1].s.StdMode <> 17) or
    (g_SignedItem[1].s.Shape <> 7)or
            (g_SignedItem[1].Dura < g_XinJianDingNeeds[0]) then begin
            FrmDlg.DMessageDlg ('请放入足够数量的卷轴碎片！', [mbOK]);
          end
          else
          with g_SignedItem[2].s do begin
          if (Name = '') or (StdMode <> 17) or (Shape <> 99)or
            (g_SignedItem[2].Dura < g_XinJianDingNeeds[1]) then begin
            FrmDlg.DMessageDlg ('请放入足够数量的残卷！', [mbOK]);
          end
          else
            boTrainee := True;
          end;
        end;

  if boTrainee then begin
    sItemValueRetainMarks := '你确定替换以下属性：\';
    if (not DCHSignedItemValue1.Checked) and (DCHSignedItemValue1.Caption <> '') then
      sItemValueRetainMarks := sItemValueRetainMarks + '\' + DCHSignedItemValue1.Caption;
    if (not DCHSignedItemValue2.Checked) and (DCHSignedItemValue2.Caption <> '') then
      sItemValueRetainMarks := sItemValueRetainMarks + '\' + DCHSignedItemValue2.Caption;
    if (not DCHSignedItemValue3.Checked) and (DCHSignedItemValue3.Caption <> '') then
      sItemValueRetainMarks := sItemValueRetainMarks + '\' + DCHSignedItemValue3.Caption;
    if (not DCHSignedItemValue4.Checked) and (DCHSignedItemValue4.Caption <> '') then
      sItemValueRetainMarks := sItemValueRetainMarks + '\' + DCHSignedItemValue4.Caption;

    if  (not DCHSignedItemAutoLockValue.Checked) and (Length(sItemValueRetainMarks) > 22) and (FrmDlg.DMessageDlg (sItemValueRetainMarks, [mbOK, mbCancel]) <> mrOk) then
      Exit;
    FrmDlg.m_boSignedLock := True;
    g_XinJianDingData.Item3MakeIndex := g_SignedItem[2].MakeIndex;
    FrmMain.SendNewSginedItem(g_SignedItem[0].MakeIndex, g_SignedItem[1].MakeIndex);
  end;// else DMessageDlg ('鉴定的装备与卷轴不匹配！', []);
{$IFEND}
end;

procedure TFrmDlg1.DWSignedItemOkDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
{$IF M2Version <> 2}
var
  d: TDirectDrawSurface;
{$IFEND}
begin
{$IF M2Version <> 2}
  with Sender as TDButton do begin
    if WLib <> nil then begin //20080701
      if not Enabled then begin
         d := WLib.Images[FaceIndex];
         if d <> nil then
            dsurface.Draw (SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, TRUE);
        dsurface.BoldTextOut (SurfaceX(GLeft) + d.Width div 2 - frmMain.Canvas.TextWidth(Hint) div 2, SurfaceY(GTop) + d.Height div 2 - frmMain.Canvas.TextHeight(Hint) div 2{+ 5}, $0099A8AC, clBlack, Hint);
        Exit;
      end;
      if TDButton(Sender).Downed then begin
        d := WLib.Images[FaceIndex + 1];
        if d <> nil then
            dsurface.Draw (SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, True);
        dsurface.BoldTextOut (SurfaceX(GLeft) + d.Width div 2 - frmMain.Canvas.TextWidth(Hint) div 2+1, SurfaceY(GTop) + d.Height div 2 - frmMain.Canvas.TextHeight(Hint) div 2 + 1{SurfaceY(GTop) + 6}, $0048A4E8, clBlack, Hint);
      end else begin
        if TDButton(Sender).MouseMoveing then begin
          d := WLib.Images[FaceIndex];
          if d <> nil then
              dsurface.Draw (SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, True);
          dsurface.BoldTextOut (SurfaceX(GLeft) + d.Width div 2 - frmMain.Canvas.TextWidth(TDButton(Sender).Hint) div 2, SurfaceY(GTop) + d.Height div 2 - frmMain.Canvas.TextHeight(Hint) div 2, $00A8D4E8, clBlack, TDButton(Sender).Hint);
        end else begin
          d := WLib.Images[FaceIndex];
          if d <> nil then
            dsurface.Draw (SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, TRUE);
          dsurface.BoldTextOut (SurfaceX(GLeft) + d.Width div 2 - frmMain.Canvas.TextWidth(TDButton(Sender).Hint) div 2, SurfaceY(GTop) + d.Height div 2 - frmMain.Canvas.TextHeight(Hint) div 2, $0088C4E8, clBlack, TDButton(Sender).Hint);
        end;
      end;
    end;
  end;
{$IFEND}
end;

procedure TFrmDlg1.DWSignedItemOkInitialize(Sender: TObject);
begin
{$IF M2Version <> 2}
  TDButton(Sender).SetImgIndex(g_WMainImages, 663);
{$IFEND}
end;

procedure TFrmDlg1.DCHSignedItemAutoLockValueDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
  with Sender as TDCheckBox do begin
    if Visible and (WLib <> nil) then begin
      d := nil;
      if Checked and Enabled then begin
        d := WLib.Images[FaceIndex + 1];
      end else begin
        d := WLib.Images[FaceIndex];
      end;
      if d <> nil then begin
        dsurface.Draw(SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, True);
      	if not Enabled then
        	dsurface.FillRect(Bounds(SurfaceX(GLeft), SurfaceY(GTop), GWidth, GHeight), clGray);
      end;
    end;
  end;

end;

procedure TFrmDlg1.DCHSignedItemAutoLockValueInitialize(Sender: TObject);
begin
  with Sender as TDCheckBox do begin
    SetImgIndex(g_qingqingImages, 7);
  end;
end;

procedure TFrmDlg1.DCHSignedItemValue1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
var
   d: TDirectDrawSurface;
begin
  with Sender as TDCheckBox do begin
    if WLib <> nil then begin
      d := nil;
      if Checked and Enabled then begin
        d := g_WUI1Images.Images[3183];
        if d <> nil then
          dsurface.Draw(SurfaceX(GLeft) - d.Width, SurfaceY(GTop), d.ClientRect, d, True);
        d := WLib.Images[FaceIndex + 1];
      end else begin
        d := WLib.Images[FaceIndex];
      end;
      if d <> nil then begin
        dsurface.Draw(SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, True);
      	if not Enabled then
        	dsurface.FillRect(Bounds(SurfaceX(GLeft), SurfaceY(GTop), GWidth, GHeight), clGray);
      end;
    end;
  end;

end;

procedure TFrmDlg1.DCHSignedItemValue1Initialize(Sender: TObject);
begin
  with Sender as TDCheckBox do begin
    SetImgIndex(g_qingqingImages, 7);
  end;
end;

procedure TFrmDlg1.DWRefineDrumInitialize(Sender: TObject);
var
  d: TDirectDrawSurface;
begin
   d := g_WMainImages.Images[1420];
   if d <> nil then DWRefineDrum.SetImgIndex (g_WMainImages, 1420)

end;

procedure TFrmDlg1.DWSignedItemCloseClick(Sender: TObject; X, Y: Integer);
{$IF M2Version <> 2}
var
  I: Integer;
{$IFEND}
begin
{$IF M2Version <> 2}             //增加十秒超时By TasNat at: 2012-11-12 10:15:20
  if (FrmDlg.m_boSignedLock) and (GetTickCount - FrmDlg.m_dwSignedLockTick < 10*1000) then Exit;
  for I:=Low(g_SignedItem) to High(g_SignedItem) do begin
    if g_SignedItem[I].s.Name <> '' then begin
      AddItemBag(g_SignedItem[I]);
      g_SignedItem[I].s.Name := '';
    end;
  end;
  DWSignedItemNew.Visible := False;
{$IFEND}
end;

procedure TFrmDlg1.DWSignedItemCloseDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
begin
  FrmDlg.DBotGroupDirectPaint(Sender, dsurface);
end;

procedure TFrmDlg1.DWSignedItemCloseInitialize(Sender: TObject);
begin
{$IF M2Version <> 2}
  TDButton(Sender).SetImgIndex(g_WMain2Images, 148);
{$IFEND}
end;

procedure TFrmDlg1.DWSignedItemNewDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
{$IF M2Version <> 2}
var
  d: TDirectDrawSurface;
  C : TColor;
  I, II : Integer;
  sCount : string;
  nCount : Integer;
  TmpXinJianDingNeeds           :array [0..1] of DWord;
{$IFEND}
begin
  {$IF M2Version <> 2}
  TmpXinJianDingNeeds[0] := g_SerXinJianDingNeeds[0];
  TmpXinJianDingNeeds[1] := g_SerXinJianDingNeeds[1];
  with DCHSignedItemValue1 do begin
    if Checked then
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 1
    else
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 0;
  end;
  with DCHSignedItemValue2 do begin
    if Checked then
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 1
    else
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 0;
  end;
  with DCHSignedItemValue3 do begin
    if Checked then
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 1
    else
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 0;
  end;
  
  with DCHSignedItemValue4 do begin
    if Checked then
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 1
    else
      g_XinJianDingData.ItemValueRetainMarks[Tag] := 0;
  end;

  for II := Low(g_XinJianDingData.ItemValueRetainMarks) to High(g_XinJianDingData.ItemValueRetainMarks) do
     if g_XinJianDingData.ItemValueRetainMarks[II] = 1 then
     for I := Low(g_SerXinJianDingLockNeeds)to High(g_SerXinJianDingLockNeeds) do
       Inc(TmpXinJianDingNeeds[I], g_SerXinJianDingLockNeeds[I]);

  with DWSignedItemNew do begin
    if WLib <> nil then begin
      d := WLib.Images[FaceIndex];
      if d <> nil then begin
        dsurface.Draw(SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, True);
      end;
    end;
    dsurface.BoldTextOut(SurfaceX(GLeft) + 50, SurfaceY(GTop) + 157, $0088C4E8, clBlack, '鉴宝师');
    case Tag of
      0: begin
        dsurface.TextOut(SurfaceX(GLeft)+126, SurfaceY(GTop)+ 17,        clWhite, '鉴定师委托我来到玛法大陆，我带来了更多突破装备极限的');
        dsurface.TextOut(SurfaceX(GLeft)+126, SurfaceY(GTop)+ 17 + 15*1, clWhite, '方法，不知道你是否愿意尝试。如果愿意请将物品放在桌子');
        dsurface.TextOut(SurfaceX(GLeft)+126, SurfaceY(GTop)+ 17 + 15*2, clWhite, '上吧！');

        if g_SignedItem[0].s.Name <> '' then begin
          with g_SignedItem[1] do begin
            if (s.Name = '') or (s.StdMode <> 17) or (s.Shape <> 7)  then
              nCount := 0
            else
              nCount := Dura
          end;
            if nCount  < TmpXinJianDingNeeds[0] then
              C := clRed
            else
              C := clLime;

          sCount := IntToStr(nCount);

          dsurface.TextOut(SurfaceX(GLeft)+227, SurfaceY(GTop)+ 255, C, sCount);
          dsurface.TextOut(SurfaceX(GLeft)+227 + FrmMain.Canvas.TextWidth(sCount), SurfaceY(GTop)+ 255, clLime, '/' + IntToStr(TmpXinJianDingNeeds[0]));

          with g_SignedItem[2] do begin
            if (s.Name = '') or (s.StdMode <> 17) or (s.Shape <> 99)  then
              nCount := 0
            else
              nCount := Dura
          end;
            if nCount  < TmpXinJianDingNeeds[1] then
              C := clRed
            else
              C := clLime;

          sCount := IntToStr(nCount);
          dsurface.TextOut(SurfaceX(GLeft)+293, SurfaceY(GTop)+ 255, C, sCount);
          dsurface.TextOut(SurfaceX(GLeft)+293 + FrmMain.Canvas.TextWidth(sCount), SurfaceY(GTop)+ 255, clLime, '/' + IntToStr(TmpXinJianDingNeeds[1]));
        end;
      end;
      1: begin
        dsurface.TextOut(SurfaceX(GLeft)+126, SurfaceY(GTop)+20, clWhite, '宝物除了能给你带来意外的财富，还能给你的装备附加强效');
        dsurface.TextOut(SurfaceX(GLeft)+126, SurfaceY(GTop)+20 + 15*1, clWhite, '属性。');
        d := WLib.Images[3182];
        if d <> nil then begin
          dsurface.Draw(SurfaceX(GLeft) + 124, SurfaceY(GTop) + 57, d.ClientRect, d, True);
        end;
        dsurface.TextOut(SurfaceX(GLeft)+124 + 11, SurfaceY(GTop)+123 - 50, clYellow, '1.新的鉴定系统需要卷轴碎片和残卷来进行鉴定；');
        dsurface.TextOut(SurfaceX(GLeft)+124 + 11, SurfaceY(GTop)+128 + 6*1 - 40, clYellow, '2.每件装备最少拥有四个属性；');
        dsurface.TextOut(SurfaceX(GLeft)+124 + 11, SurfaceY(GTop)+143 + 6*2 - 40, clYellow, '3.每次鉴定，没有被锁定的属性将会被更换，如果四个属');
        dsurface.TextOut(SurfaceX(GLeft)+124 + 11, SurfaceY(GTop)+158 + 6*3 - 40, clYellow, '性都没有被锁定，则每次刷新四个属性；');
        dsurface.TextOut(SurfaceX(GLeft)+124 + 11, SurfaceY(GTop)+173 + 6*4 - 40, clYellow, '4.被锁定的鉴定属性不会被刷新；');
        dsurface.TextOut(SurfaceX(GLeft)+124 + 11, SurfaceY(GTop)+188 + 6*5 - 40, clYellow, '5.被锁定的属性越多，鉴定所需的卷轴碎片和残卷越多，');
        dsurface.TextOut(SurfaceX(GLeft)+124 + 11, SurfaceY(GTop)+203 + 6*6 - 40, clYellow, '残卷可以在商城购买');
        dsurface.TextOut(SurfaceX(GLeft)+124 + 11, SurfaceY(GTop)+218 + 6*7 - 40, clYellow, '6.麻痹神技、魔道麻痹神技、八卦护身神技等特殊属性永');
        dsurface.TextOut(SurfaceX(GLeft)+124 + 11, SurfaceY(GTop)+233 + 6*8 - 40, clYellow, '远不会被洗掉；');
        dsurface.TextOut(SurfaceX(GLeft)+124 + 11, SurfaceY(GTop)+248 + 6*9 - 40, clYellow, '7.取消神秘属性解读功能。');
      end;
    end;
  end;
  {$IFEND}

end;

procedure TFrmDlg1.DWSignedItemNewInitialize(Sender: TObject);
begin
{$IF M2Version <> 2}
  DWSignedItemNew.SetImgIndex(g_WUI1Images, 3180);
{$IFEND}
end;

procedure TFrmDlg1.DWSignedItemNewItemClick(Sender: TObject; X, Y: Integer);
{$IF M2Version <> 2}
var
  temp: TClientItem;
  I: Integer;
{$IFEND}
begin
{$IF M2Version <> 2}
  if FrmDlg.m_boSignedLock then Exit;

  with Sender as TDButton do begin
    if not g_boItemMoving then begin
      if g_SignedItem[Tag].s.Name <> '' then begin
         ItemClickSound (g_SignedItem[Tag].s);
         if g_MovingItem.Item.S.Name <> '' then Exit;
         g_boItemMoving := TRUE;
         g_MovingItem.Item := g_SignedItem[Tag];
         g_SignedItem[Tag].s.Name := '';
         g_SignedItem[Tag].Dura := 0;
      end;
    end else begin
      if (g_MovingItem.Item.S.Name <> '') and (g_MovingItem.Index >= 0) then begin
        ItemClickSound (g_MovingItem.Item.S);
        case Tag of
          0: begin
            if (GetTakeOnPosition(g_MovingItem.Item.S.StdMode) < 0) or
              ((g_MovingItem.Item.S.StdMode = 25) and
              (g_MovingItem.Item.S.Shape in [1,2,5])) or
              (g_MovingItem.Item.btAppraisalLevel = 0) then Exit;
              if (g_SignedItem[1].s.Name = '') then begin
                for I:=6 to MAXBAGITEMCL-1 do begin
                  if (g_ItemArr[I].Item.S.Name <> '') and
                    (g_ItemArr[I].Item.S.StdMode = 17) and
                    (g_ItemArr[I].Item.S.Shape = 7) then begin
                    g_SignedItem[1] := g_ItemArr[I].Item;
                    g_ItemArr[I].Item.S.Name := '';
                    Break;
                  end;
                end;
              end;
              if (g_SignedItem[2].s.Name = '') then begin
                for I:=6 to MAXBAGITEMCL-1 do begin
                  if (g_ItemArr[I].Item.S.Name <> '') and
                    (g_ItemArr[I].Item.S.StdMode = 17) and
                    (g_ItemArr[I].Item.S.Shape = 99) then begin
                    g_SignedItem[2] := g_ItemArr[I].Item;
                    g_ItemArr[I].Item.S.Name := '';
                    Break;
                  end;
                end;
              end;
          end;
          1: if (g_MovingItem.Item.S.StdMode <> 17) or (g_MovingItem.Item.S.Shape <> 7) then Exit;
          2: if (g_MovingItem.Item.S.StdMode <> 17) or (g_MovingItem.Item.S.Shape <> 99) then Exit;
        end;
        if g_SignedItem[Tag].s.Name <> '' then begin
          temp := g_SignedItem[Tag];
          g_SignedItem[Tag] := g_MovingItem.Item;
          g_MovingItem.Item := temp
        end else begin
          g_SignedItem[Tag] := g_MovingItem.Item;
          g_MovingItem.Item.S.name := '';
          g_boItemMoving := FALSE;
        end;
      end;
    end;
  end;
  if Sender = DWSignedItemNewItem then begin
            FillChar(g_XinJianDingData, SizeOf(g_XinJianDingData), 0);
            FillChar(g_sXinJianDingValues, SizeOf(g_sXinJianDingValues), 0);
            if g_SignedItem[0].s.Name <> '' then             
            for I := 2 to 5 do begin
              g_sXinJianDingValues[I] := GetAAppendItemValue(g_SignedItem[0].btAppraisalValue[I]);
            end;
            DCHSignedItemValue1.Caption := g_sXinJianDingValues[2];
            DCHSignedItemValue2.Caption := g_sXinJianDingValues[3];
            DCHSignedItemValue3.Caption := g_sXinJianDingValues[4];
            DCHSignedItemValue4.Caption := g_sXinJianDingValues[5];
            DCHSignedItemValue1.Visible := DCHSignedItemValue1.Caption <> '';
            DCHSignedItemValue2.Visible := DCHSignedItemValue2.Caption <> '';
            DCHSignedItemValue3.Visible := DCHSignedItemValue3.Caption <> '';
            DCHSignedItemValue4.Visible := DCHSignedItemValue4.Caption <> '';
  end;
{$IFEND}


end;

procedure TFrmDlg1.DWSignedItemNewItemDirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
{$IF M2Version <> 2}
var
  d: TDirectDrawSurface;
  idx: Integer;
{$IFEND}
begin
{$IF M2Version <> 2}
  with Sender as TDButton do begin
    if WLib <> nil then begin

      if FrmDlg.m_btSignedItemsPage = 1 then begin
        d := g_WUI1Images.Images[883];
      end else begin
        d := WLib.Images[FaceIndex];
      end;
      if d <> nil then begin
        dsurface.Draw(SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, True);
      end;
      if g_SignedItem[Tag].s.Name <> '' then begin
        idx := g_SignedItem[Tag].s.Looks;
        if idx >= 0 then begin
            d := frmMain.GetBagItemImg(idx);
            if d <> nil then
            dsurface.Draw (SurfaceX(GLeft + (GWidth - d.Width) div 2),
                           SurfaceY(GTop + (GHeight - d.Height) div 2),
                           d.ClientRect, d, TRUE);
        end;
      end else if (g_MovingItem.Item.S.Name <> '') and (g_MovingItem.Index >= 0) then begin
        if Sender = DWSignedItemNewItem then
          dsurface.FillRectAlpha(Bounds(SurfaceX(GLeft)+7, SurfaceY(GTop)+7, GWidth - 14, GHeight - 14), $0046B5FF, 90)
        else
          dsurface.FillRectAlpha(Bounds(SurfaceX(GLeft)+2, SurfaceY(GTop)+2, GWidth - 4, GHeight - 4), $0046B5FF, 90);
      end;
      if Sender = DWSignedItemNewItem then begin
        case FrmDlg.m_btSignedSuccess of
          1: begin
            if GetTickCount - FrmDlg.m_dwSignedTimeTick > 120 then begin
              FrmDlg.m_dwSignedTimeTick := GetTickCount();
              Inc(FrmDlg.m_btSignedImginsex);
            end;
            if FrmDlg.m_btSignedImginsex > 21 then begin
              FrmDlg.m_btSignedImginsex := 0;
              FrmDlg.m_btSignedSuccess := 0; //停止动画
              FrmDlg.m_boSignedLock := False;
            end;
            d := g_WUI1Images.Images[940+FrmDlg.m_btSignedImginsex];
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(GLeft), SurfaceY(GTop), d);
          end;
          2: begin
            if GetTickCount - FrmDlg.m_dwSignedTimeTick > 120 then begin
              FrmDlg.m_dwSignedTimeTick := GetTickCount();
              Inc(FrmDlg.m_btSignedImginsex);
            end;
            if FrmDlg.m_btSignedImginsex > 21 then begin
              FrmDlg.m_btSignedImginsex := 0;
              FrmDlg.m_btSignedSuccess := 0; //停止动画
              FrmDlg.m_boSignedLock := False;
            end;
            d := g_WUI1Images.Images[970+FrmDlg.m_btSignedImginsex];
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(GLeft), SurfaceY(GTop), d);
          end;
          3: begin
            if GetTickCount - FrmDlg.m_dwSignedTimeTick > 120 then begin
              FrmDlg.m_dwSignedTimeTick := GetTickCount();
              Inc(FrmDlg.m_btSignedImginsex);
            end;
            if FrmDlg.m_btSignedImginsex > 21 then begin
              FrmDlg.m_btSignedImginsex := 0;
              FrmDlg.m_btSignedSuccess := 0; //停止动画
              FrmDlg.m_boSignedLock := False;
            end;
            d := g_WUI1Images.Images[1000+FrmDlg.m_btSignedImginsex];
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(GLeft), SurfaceY(GTop), d);
          end;
          4: begin
            if GetTickCount - FrmDlg.m_dwSignedTimeTick > 120 then begin
              FrmDlg.m_dwSignedTimeTick := GetTickCount();
              Inc(FrmDlg.m_btSignedImginsex);
            end;
            if FrmDlg.m_btSignedImginsex > 21 then begin
              FrmDlg.m_btSignedImginsex := 0;
              FrmDlg.m_btSignedSuccess := 0; //停止动画
              FrmDlg.m_boSignedLock := False;
            end;
            d := g_WUI1Images.Images[1030+FrmDlg.m_btSignedImginsex];
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(GLeft), SurfaceY(GTop), d);
          end;
        end;
      end;
    end;
  end;
{$IFEND}

end;

procedure TFrmDlg1.DWSignedItemNewItemInitialize(Sender: TObject);
begin
{$IF M2Version <> 2}
  DWSignedItemNewItem.SetImgIndex(g_WUI1Images, 3071);
{$IFEND}
end;

procedure TFrmDlg1.DWSignedItemNewMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  DScreen.ClearHint;
end;

procedure TFrmDlg1.DWSignedItemNewNeed1DirectPaint(Sender: TObject;
  dsurface: TDirectDrawSurface);
{$IF M2Version <> 2}
var
  d: TDirectDrawSurface;
  idx: Integer;
{$IFEND}
begin
{$IF M2Version <> 2}
  with Sender as TDButton do begin
    if WLib <> nil then begin
      if FrmDlg.m_btSignedItemsPage = 1 then begin
        d := g_WUI1Images.Images[883];
      end else begin
        d := WLib.Images[FaceIndex];
      end;
      if d <> nil then begin
        dsurface.Draw(SurfaceX(GLeft), SurfaceY(GTop), d.ClientRect, d, True);
      end;
      if g_SignedItem[Tag].s.Name <> '' then begin
        idx := g_SignedItem[Tag].s.Looks;
        if idx >= 0 then begin
            d := frmMain.GetBagItemImg(idx);
            if d <> nil then
            dsurface.Draw (SurfaceX(GLeft + (GWidth - d.Width) div 2),
                           SurfaceY(GTop + (GHeight - d.Height) div 2),
                           d.ClientRect, d, TRUE);
        end;
      end else if (g_MovingItem.Item.S.Name <> '') and (g_MovingItem.Index >= 0) then begin
        if Sender = DWSignedItemNewItem then
          dsurface.FillRectAlpha(Bounds(SurfaceX(GLeft)+7, SurfaceY(GTop)+7, GWidth - 14, GHeight - 14), $0046B5FF, 90)
        else
          dsurface.FillRectAlpha(Bounds(SurfaceX(GLeft)+2, SurfaceY(GTop)+2, GWidth - 4, GHeight - 4), $0046B5FF, 90);
      end;
      if Sender = DWSignedItemNewItem then begin
        case FrmDlg.m_btSignedSuccess of
          1: begin
            if GetTickCount - FrmDlg.m_dwSignedTimeTick > 120 then begin
              FrmDlg.m_dwSignedTimeTick := GetTickCount();
              Inc(FrmDlg.m_btSignedImginsex);
            end;
            if FrmDlg.m_btSignedImginsex > 21 then begin
              FrmDlg.m_btSignedImginsex := 0;
              FrmDlg.m_btSignedSuccess := 0; //停止动画
              FrmDlg.m_boSignedLock := False;
            end;
            d := g_WUI1Images.Images[940+FrmDlg.m_btSignedImginsex];
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(GLeft), SurfaceY(GTop), d);
          end;
          2: begin
            if GetTickCount - FrmDlg.m_dwSignedTimeTick > 120 then begin
              FrmDlg.m_dwSignedTimeTick := GetTickCount();
              Inc(FrmDlg.m_btSignedImginsex);
            end;
            if FrmDlg.m_btSignedImginsex > 21 then begin
              FrmDlg.m_btSignedImginsex := 0;
              FrmDlg.m_btSignedSuccess := 0; //停止动画
              FrmDlg.m_boSignedLock := False;
            end;
            d := g_WUI1Images.Images[970+FrmDlg.m_btSignedImginsex];
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(GLeft), SurfaceY(GTop), d);
          end;
          3: begin
            if GetTickCount - FrmDlg.m_dwSignedTimeTick > 120 then begin
              FrmDlg.m_dwSignedTimeTick := GetTickCount();
              Inc(FrmDlg.m_btSignedImginsex);
            end;
            if FrmDlg.m_btSignedImginsex > 21 then begin
              FrmDlg.m_btSignedImginsex := 0;
              FrmDlg.m_btSignedSuccess := 0; //停止动画
              FrmDlg.m_boSignedLock := False;
            end;
            d := g_WUI1Images.Images[1000+FrmDlg.m_btSignedImginsex];
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(GLeft), SurfaceY(GTop), d);
          end;
          4: begin
            if GetTickCount - FrmDlg.m_dwSignedTimeTick > 120 then begin
              FrmDlg.m_dwSignedTimeTick := GetTickCount();
              Inc(FrmDlg.m_btSignedImginsex);
            end;
            if FrmDlg.m_btSignedImginsex > 21 then begin
              FrmDlg.m_btSignedImginsex := 0;
              FrmDlg.m_btSignedSuccess := 0; //停止动画
              FrmDlg.m_boSignedLock := False;
            end;
            d := g_WUI1Images.Images[1030+FrmDlg.m_btSignedImginsex];
            if d <> nil then
              DrawBlend(dsurface, SurfaceX(GLeft), SurfaceY(GTop), d);
          end;
        end;
      end;
    end;
  end;
{$IFEND}

end;

procedure TFrmDlg1.DWSignedItemNewNeed1Initialize(Sender: TObject);
begin
 TDButton(Sender).SetImgIndex(g_WUI1Images, 3073);
end;

procedure TFrmDlg1.DWSignedItemNewNeed1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  FrmDlg.DBSignedBelt1MouseMove(Sender, Shift, X, Y);
end;

procedure TFrmDlg1.RefineBtn1Click(Sender: TObject; X, Y: Integer);
var
   temp: TClientItem;
   butt: TDButton;
   sel: Integer;
begin
   butt := TDButton(Sender);
   sel := 0;
   if not g_boItemMoving then begin
      if g_RefineDrumItem[butt.Tag].s.Name <> '' then begin
         ItemClickSound (g_RefineDrumItem[butt.Tag].s);
         if (g_MovingItem.Item.S.Name <> '') or (g_WaitingItemUp.Item.S.Name <> '') then exit;
         sel := -1;
         {if Sender = DItemsUpBelt1 then sel := 0;
         if Sender = DItemsUpBelt2 then sel := 1;
         if Sender = DItemsUpBelt3 then sel := 2;}
         g_boItemMoving := TRUE;
         g_MovingItem.Index := -(sel + 81);
         g_MovingItem.Item := g_RefineDrumItem[butt.Tag];
         g_RefineDrumItem[butt.Tag].s.Name := '';
      end;
   end else begin
      //if (g_MovingItem.Index = -97) or (g_MovingItem.Index = -98) or (g_MovingItem.Index = -99) then Exit;
      //if (g_MovingItem.Index >= 0) or (g_MovingItem.Index = -41) or (g_MovingItem.Index = -42) or
      //   (g_MovingItem.Index = -43) then
      begin
         ItemClickSound (g_MovingItem.Item.S);

         if g_RefineDrumItem[butt.Tag].s.Name <> '' then begin //磊府俊 乐栏搁
            temp := g_RefineDrumItem[butt.Tag];
            g_RefineDrumItem[butt.Tag] := g_MovingItem.Item;
            g_MovingItem.Index := -(sel + 81);
            g_MovingItem.Item := temp
         end else begin
            g_RefineDrumItem[butt.Tag] := g_MovingItem.Item;
            g_MovingItem.Item.S.name := '';
            g_boItemMoving := FALSE;
         end;
      end;
   end;

end;

procedure TFrmDlg1.RefineBtn1DirectPaint(Sender: TObject; dsurface: TDirectDrawSurface);
var
  d: TDirectDrawSurface;
  idx: Integer;
  btn:TDButton;
  Str:string;
begin
  btn:=TDButton(Sender);

  if Sender = RefineBtn6 then
  begin
    if g_RefineDrumItem[5].s.Name <> '' then
    begin
      idx := g_RefineDrumItem[5].s.Looks;
      if idx >= 0 then
      d := frmMain.GetBagItemImg(idx);

    end else begin
      d := g_WUI1Images.Images[1653];
    end;
  end else
  begin
    if g_RefineDrumItem[btn.Tag].s.Name <> '' then
    begin
      idx := g_RefineDrumItem[btn.Tag].s.Looks;
      if idx >= 0 then begin
        d := frmMain.GetBagItemImg(idx);
      end;
    end else
    begin
      d := g_WUI1Images.Images[1651];
    end;

  end;
  if d <> nil then
    dsurface.Draw (btn.SurfaceX(btn.GLeft+(btn.GWidth-d.Width) div 2), btn.SurfaceY(btn.GTop+(btn.GHeight-d.Height) div 2), d.ClientRect, d, TRUE);
  with g_RefineDrumItem[btn.Tag] do
  if s.Name <> '' then
    if S.StdMode = 17 then
      dsurface.TextOut(btn.SurfaceX(btn.GLeft+35-frmMain.Canvas.TextWidth(IntToStr(Dura))), btn.SurfaceY(btn.GTop+20), clWhite, InttoStr(Dura));


end;

procedure TFrmDlg1.RefineBtn1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
   idx: integer;
begin
   {idx := TDButton(Sender).Tag;
   if idx in [0..5] then begin
     with Sender as TDButton do
      if g_RefineDrumItem[idx].s.Name <> '' then begin
        g_MouseItem := g_RefineDrumItem[idx];
        ShowMouseItemInfo(SurfaceX(GLeft),
                          SurfaceY(GTop), '', 1, True);
      end else DScreen.ShowHint(SurfaceX(GLeft), SurfaceY(GTop), g_RefineDrumItemName[Tag+1] , clYellow, FALSE);
   end;  }
end;

end.
