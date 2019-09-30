unit uDesignMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WinHTTP, JSocket, IdAntiFreezeBase, IdAntiFreeze,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  ExtCtrls, ComCtrls, OleCtrls, SHDocVw, RzPanel, jpeg, ImageProgressbar,
  RzBmpBtn, RzButton, RzRadChk, StdCtrls, RzCmboBx, RzLabel, AutoControl,
  Menus, PicEdit, RzShellDialogs, share, RzPrgres, RzCommon,
  BusinessSkinForm, bsSkinData, WinSkinData;

type
  TFrmDesignMain = class(TForm)
    MainImage: TImage;
    RzLabelStatus: TRzLabel;
    RzComboBox1: TRzComboBox;
    RzCheckBox1: TRzCheckBox;
    MinimizeBtn: TRzBmpButton;
    CloseBtn: TRzBmpButton;
    StartButton: TRzBmpButton;
    ButtonHomePage: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    ImageButtonClose: TRzBmpButton;
    ButtonGetBackPassword: TRzBmpButton;
    ButtonChgPassword: TRzBmpButton;
    ButtonNewAccount: TRzBmpButton;
    ProgressBarCurDownload: TImageProgressbar;
    ProgressBarAll: TImageProgressbar;
    TreeView1: TTreeView;
    WebBrowser1: TWebBrowser;
    PopupMenuTreeView: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    PopupMenuWebBrowser: TPopupMenu;
    N111: TMenuItem;
    PopupMenuMainImage: TPopupMenu;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    PopupMenuBtn: TPopupMenu;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    PopupMenuCheckBox: TPopupMenu;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    RzCheckBoxFullScreen: TRzCheckBox;
    N24: TMenuItem;
    N25: TMenuItem;
    PopupMenuLabel: TPopupMenu;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    ComboBox1: TComboBox;
    PopupMenuRzComboBox: TPopupMenu;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    FontDialog1: TFontDialog;
    ColorDialog1: TColorDialog;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    Panel2: TPanel;
    N39: TMenuItem;
    N40: TMenuItem;
    N41: TMenuItem;
    RzLabel1: TRzLabel;
    SaveDialog1: TSaveDialog;
    PopupMenuImageProgressBar: TPopupMenu;
    N42: TMenuItem;
    N43: TMenuItem;
    N44: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    N47: TMenuItem;
    RzProgressBar1: TRzProgressBar;
    RzProgressBar2: TRzProgressBar;
    PopupMenuRzProgressBar: TPopupMenu;
    N48: TMenuItem;
    N49: TMenuItem;
    OpenDialog1: TOpenDialog;
    PopupMenuComboBox: TPopupMenu;
    N50: TMenuItem;
    N51: TMenuItem;
    N52: TMenuItem;
    N53: TMenuItem;
    N54: TMenuItem;
    N55: TMenuItem;
    N56: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    LED1: TMenuItem;
    N59: TMenuItem;
    N60: TMenuItem;
    N63: TMenuItem;
    N64: TMenuItem;
    N65: TMenuItem;
    N67: TMenuItem;
    N68: TMenuItem;
    N61: TMenuItem;
    N62: TMenuItem;
    PopupMenu1: TPopupMenu;
    N66: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure AutoControlTargetChanged(Sender: TObject;
      NewTarget: TControl);
    procedure AutoControlTargetChanging (Sender: TObject;
      NewTarget: TControl; var IsValidTarget: boolean);
    procedure AutoControlMoving(Sender: TObject; ControlRect: TRect);
    procedure AutoControlMoved(Sender: TObject; ControlRect: TRect);
    procedure MainImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MainImageDblClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure PopupMenuMainImagePopup(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure PopupMenuTreeViewPopup(Sender: TObject);
    procedure PopupMenuWebBrowserPopup(Sender: TObject);
    procedure PopupMenuBtnPopup(Sender: TObject);
    procedure PopupMenuCheckBoxPopup(Sender: TObject);
    procedure PopupMenuLabelPopup(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N38Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N111Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N40Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N34Click(Sender: TObject);
    procedure PopupMenuRzComboBoxPopup(Sender: TObject);
    procedure N41Click(Sender: TObject);
    procedure N32Click(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N45Click(Sender: TObject);
    procedure N42Click(Sender: TObject);
    procedure N43Click(Sender: TObject);
    procedure PopupMenuImageProgressBarPopup(Sender: TObject);
    procedure N47Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N28Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure N30Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N57Click(Sender: TObject);
    procedure N50Click(Sender: TObject);
    procedure N52Click(Sender: TObject);
    procedure N54Click(Sender: TObject);
    procedure N55Click(Sender: TObject);
    procedure PopupMenuComboBoxPopup(Sender: TObject);
    procedure PopupMenuRzProgressBarPopup(Sender: TObject);
    procedure N58Click(Sender: TObject);
    procedure LED1Click(Sender: TObject);
    procedure N59Click(Sender: TObject);
    procedure N63Click(Sender: TObject);
    procedure N64Click(Sender: TObject);
    procedure N65Click(Sender: TObject);
    procedure N68Click(Sender: TObject);
    procedure N62Click(Sender: TObject);
    procedure StartButtonContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure N48Click(Sender: TObject);
    procedure N66Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    function OpenImageEdit(Picture: TPicture; FilterType: TFilterType; AutoSize: Boolean): Boolean;
    procedure TrialRun();
  public
    AutoControl: TAutoControl;
    procedure SaveToFile(FileName: string);
  end;

var
  FrmDesignMain: TFrmDesignMain;

implementation

{$R *.dfm}

procedure TFrmDesignMain.FormCreate(Sender: TObject);
begin
  //this circumvents installing TAutoControl on the component palette...
  AutoControl := TAutoControl.create(self);
  with AutoControl do
  begin
   // AutoControl.Enabled := False;
    SnapToGrid := False;
    OnTargetChanged := AutoControlTargetChanged;
    OnTargetChanging := AutoControlTargetChanging;
    OnMoving := AutoControlMoving;
    OnResizing := AutoControlMoving;
    OnMoved := AutoControlMoved;
    OnResized := AutoControlMoved;
    GridSize := 0;
    //Target := nil;
    MouseButtons := [mbLeft]; //only respond to the left button
    //PopupMenu := nil;  //popup menu to assist aligning
  end;  
end;
procedure TFrmDesignMain.AutoControlTargetChanged(Sender: TObject;
  NewTarget: TControl);
const
  dummyRec: TRect = (left:0;top:0;right:0;bottom:0);
begin
  //display changes in Object Inspector...
  {if NewTarget = nil then
    ObjectInspectorForm.pnlControlName.Caption := ' '+self.Name else
    ObjectInspectorForm.pnlControlName.Caption := ' '+NewTarget.Name;   }
  AutoControlMoved(nil,dummyRec);
end;

procedure TFrmDesignMain.AutoControlTargetChanging (Sender: TObject;
  NewTarget: TControl; var IsValidTarget: boolean);
begin
  //TO DEMONSTRATE PREVENTING A CONTROL RECEIVING SizeControl FOCUS:
  //the following line prevents Label3 getting SizeControl focus...
  if (NewTarget = MainImage) then begin
    IsValidTarget := False;
  end else if NewTarget = Panel2 then begin
    IsValidTarget := False;
  end else if NewTarget = RzLabel1 then begin
    IsValidTarget := False;
  end else if NewTarget = TreeView1 then begin
    AutoControl.PopupMenu := PopupMenuTreeView;
  end else if NewTarget = WebBrowser1 then begin
    AutoControl.PopupMenu := PopupMenuWebBrowser;
  end else if NewTarget = MinimizeBtn then begin
    AutoControl.PopupMenu := PopupMenuBtn;
  end else if NewTarget = CloseBtn then begin
    AutoControl.PopupMenu := PopupMenuBtn;
  end else if NewTarget = StartButton then begin
    AutoControl.PopupMenu := PopupMenuBtn;
  end else if NewTarget = ButtonHomePage then begin
    AutoControl.PopupMenu := PopupMenuBtn;
  end else if NewTarget = RzBmpButton1 then begin
    AutoControl.PopupMenu := PopupMenuBtn;
  end else if NewTarget = RzBmpButton2 then begin
    AutoControl.PopupMenu := PopupMenuBtn;
  end else if NewTarget = ButtonNewAccount then begin
    AutoControl.PopupMenu := PopupMenuBtn;
  end else if NewTarget = ButtonChgPassword then begin
    AutoControl.PopupMenu := PopupMenuBtn;
  end else if NewTarget = ButtonGetBackPassword then begin
    AutoControl.PopupMenu := PopupMenuBtn;
  end else if NewTarget = ImageButtonClose then begin
    AutoControl.PopupMenu := PopupMenuBtn;
  end else if NewTarget = RzCheckBox1 then begin
    AutoControl.PopupMenu := PopupMenuCheckBox;
  end else if NewTarget = RzCheckBoxFullScreen then begin
    AutoControl.PopupMenu := PopupMenuCheckBox;
  end else if NewTarget = RzLabelStatus then begin
    AutoControl.PopupMenu := PopupMenuLabel;
  end else if NewTarget = RzComboBox1 then begin
    AutoControl.PopupMenu := PopupMenuRzComboBox;
  end else if NewTarget = ComboBox1 then begin
    AutoControl.PopupMenu := PopupMenuComboBox;
  end else if NewTarget = ProgressBarCurDownload then begin
    AutoControl.PopupMenu := PopupMenuImageProgressBar;
  end else if NewTarget = ProgressBarAll then begin
    AutoControl.PopupMenu := PopupMenuImageProgressBar;
  end else if NewTarget = RzProgressBar1 then begin
    AutoControl.PopupMenu := PopupMenuRzProgressBar;
  end else if NewTarget = RzProgressBar2 then begin
    AutoControl.PopupMenu := PopupMenuRzProgressBar;
  end else begin
    AutoControl.PopupMenu := nil;
  end;
end;


procedure TFrmDesignMain.AutoControlMoving(Sender: TObject; ControlRect: TRect);
begin
  {with ControlRect do
  begin
    ObjectInspectorForm.StringGrid1.Cols[1][1] := inttostr(Bottom-Top);
    ObjectInspectorForm.StringGrid1.Cols[1][2] := inttostr(Left);
    ObjectInspectorForm.StringGrid1.Cols[1][3] := inttostr(Top);
    ObjectInspectorForm.StringGrid1.Cols[1][4] := inttostr(Right-Left);
  end; }
end;

procedure TFrmDesignMain.AutoControlMoved(Sender: TObject; ControlRect: TRect);
var
  alignStr: string;
begin
  //display alignment...
  case  AutoControl.Target_Align of
    alNone: alignStr := 'alNone';
    alClient: alignStr := 'alClient';
    alLeft: alignStr := 'alLeft';
    alTop: alignStr := 'alTop';
    alRight: alignStr := 'alRight';
    alBottom: alignStr := 'alBottom';
  end;
    {ObjectInspectorForm.StringGrid1.Cols[1][0] := alignStr;
  ObjectInspectorForm.StringGrid1.Cols[1][1] := inttostr(AutoControl.Target_Height);
  ObjectInspectorForm.StringGrid1.Cols[1][2] := inttostr(AutoControl.Target_Left);
  ObjectInspectorForm.StringGrid1.Cols[1][3] := inttostr(AutoControl.Target_Top);
  ObjectInspectorForm.StringGrid1.Cols[1][4] := inttostr(AutoControl.Target_Width);    }
end;
procedure TFrmDesignMain.MainImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, $F012, 0);
  end;
end;

procedure TFrmDesignMain.MainImageDblClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmDesignMain.N1Click(Sender: TObject);
begin
  TreeView1.ShowHint := not TreeView1.ShowHint;
end;

procedure TFrmDesignMain.N6Click(Sender: TObject);
begin
  if g_TrialRun.boTrialRun then Exit;
  if OpenImageEdit(MainImage.Picture, FTAll, True) then begin
    FrmDesignMain.Width := MainImage.Width;
    FrmDesignMain.Height := MainImage.Height + Panel2.Height;
  end;
end;

function TFrmDesignMain.OpenImageEdit(Picture: TPicture; FilterType: TFilterType; AutoSize: Boolean): Boolean;
var
  AEditor:TPictureEditor;
begin
  Result := False;
  AEditor:=TPictureEditor.Create(nil);
  AEditor.Picture.Assign(Picture);
  AEditor.Filters := FilterType;
  try
    if AEditor.Execute() then begin
      Picture.Assign(AEditor.Picture);
      if Assigned(Picture.Graphic) then begin  //是System   Unit中的函数，X必须为一个变量参考或指针或函数类型，本函数返回一个Boolean值，当X=nil时，返回False。
        if AutoSize then begin
          FrmDesignMain.Width := Picture.Width;
          FrmDesignMain.Height := Picture.Height + Panel2.Height;
        end;
      end;
    end;
  finally
    AEditor.Free;
  end;
end;

procedure TFrmDesignMain.N25Click(Sender: TObject);
begin
  if g_TrialRun.boTrialRun then Exit;
  FrmDesignMain.TransparentColor := not FrmDesignMain.TransparentColor;
end;

procedure TFrmDesignMain.PopupMenuMainImagePopup(Sender: TObject);
begin
  N25.Checked := FrmDesignMain.TransparentColor;
  N62.Checked := g_TrialRun.boTrialRun;
end;

procedure TFrmDesignMain.N11Click(Sender: TObject);
begin
  Close();
end;

procedure TFrmDesignMain.PopupMenuTreeViewPopup(Sender: TObject);
begin
  N1.Checked := TreeView1.ShowHint;
end;

procedure TFrmDesignMain.PopupMenuWebBrowserPopup(Sender: TObject);
begin
  N111.Checked := WebBrowser1.ShowHint;
end;

procedure TFrmDesignMain.PopupMenuBtnPopup(Sender: TObject);
begin
  if PopupMenuBtn.PopupComponent = AutoControl then begin
    N17.Checked := TAutoControl(PopupMenuBtn.PopupComponent).Target.ShowHint;
  end else N17.Checked := TWinControl(PopupMenuBtn.PopupComponent).ShowHint;
end;

procedure TFrmDesignMain.PopupMenuCheckBoxPopup(Sender: TObject);
begin
  if PopupMenuCheckBox.PopupComponent = AutoControl then begin
    N23.Checked := TAutoControl(PopupMenuCheckBox.PopupComponent).Target.ShowHint;
  end else N23.Checked := TWinControl(PopupMenuCheckBox.PopupComponent).ShowHint;
end;

procedure TFrmDesignMain.PopupMenuLabelPopup(Sender: TObject);
begin
  N26.Checked := RzLabelStatus.ShowHint;
end;

procedure TFrmDesignMain.N2Click(Sender: TObject);
begin
  FontDialog1.Font := TreeView1.Font;
  if FontDialog1.Execute then begin
    TreeView1.Font := FontDialog1.Font;
  end;
end;

procedure TFrmDesignMain.N3Click(Sender: TObject);
begin
  ColorDialog1.Color := TreeView1.Color;
  if ColorDialog1.Execute then begin
    TreeView1.Color := ColorDialog1.Color;
  end;
end;

procedure TFrmDesignMain.N38Click(Sender: TObject);
begin
  ColorDialog1.Color := TreeView1.Font.Color;
  if ColorDialog1.Execute then begin
    TreeView1.Font.Color := ColorDialog1.Color;
  end;
end;

procedure TFrmDesignMain.N5Click(Sender: TObject);
begin
  TreeView1.Visible := False;
  ComboBox1.Left := TreeView1.Left;
  ComboBox1.Top := TreeView1.Top;
  ComboBox1.Visible := True;
  AutoControl.Target := nil;
end;

procedure TFrmDesignMain.N111Click(Sender: TObject);
begin
  WebBrowser1.ShowHint := not WebBrowser1.ShowHint;
end;

procedure TFrmDesignMain.N12Click(Sender: TObject);
begin
  if PopupMenuBtn.PopupComponent = AutoControl then begin
    OpenImageEdit(TPicture(TRzBmpButton(TAutoControl(PopupMenuBtn.PopupComponent).Target).Bitmaps.Up), FTBmp, False);
  end else OpenImageEdit(TPicture(TRzBmpButton(PopupMenuBtn.PopupComponent).Bitmaps.Up), FTBmp, False);
end;

procedure TFrmDesignMain.N13Click(Sender: TObject);
begin
  if PopupMenuBtn.PopupComponent = AutoControl then begin
    OpenImageEdit(TPicture(TRzBmpButton(TAutoControl(PopupMenuBtn.PopupComponent).Target).Bitmaps.Hot), FTBmp, False);
  end else OpenImageEdit(TPicture(TRzBmpButton(PopupMenuBtn.PopupComponent).Bitmaps.Hot), FTBmp, False);
end;

procedure TFrmDesignMain.N14Click(Sender: TObject);
begin
  if PopupMenuBtn.PopupComponent = AutoControl then begin
    OpenImageEdit(TPicture(TRzBmpButton(TAutoControl(PopupMenuBtn.PopupComponent).Target).Bitmaps.Down), FTBmp, False);
  end else OpenImageEdit(TPicture(TRzBmpButton(PopupMenuBtn.PopupComponent).Bitmaps.Down), FTBmp, False);
end;

procedure TFrmDesignMain.N15Click(Sender: TObject);
begin
  if PopupMenuBtn.PopupComponent = AutoControl then begin
    OpenImageEdit(TPicture(TRzBmpButton(TAutoControl(PopupMenuBtn.PopupComponent).Target).Bitmaps.Disabled), FTBmp, False);
  end else OpenImageEdit(TPicture(TRzBmpButton(PopupMenuBtn.PopupComponent).Bitmaps.Disabled), FTBmp, False);
end;

procedure TFrmDesignMain.N17Click(Sender: TObject);
begin
  if PopupMenuBtn.PopupComponent = AutoControl then begin
    TAutoControl(PopupMenuBtn.PopupComponent).Target.ShowHint := not TAutoControl(PopupMenuBtn.PopupComponent).Target.ShowHint;
  end else TWinControl(PopupMenuBtn.PopupComponent).ShowHint := not TWinControl(PopupMenuBtn.PopupComponent).ShowHint;
end;

procedure TFrmDesignMain.N18Click(Sender: TObject);
begin
  if PopupMenuCheckBox.PopupComponent = AutoControl then begin
    FontDialog1.Font := TRzCheckBox(TAutoControl(PopupMenuCheckBox.PopupComponent).Target).Font;
    if FontDialog1.Execute then begin
      TRzCheckBox(TAutoControl(PopupMenuCheckBox.PopupComponent).Target).Font := FontDialog1.Font;
    end;
  end else begin
    FontDialog1.Font := TRzCheckBox(PopupMenuCheckBox.PopupComponent).Font;
    if FontDialog1.Execute then begin
      TRzCheckBox(PopupMenuCheckBox.PopupComponent).Font := FontDialog1.Font;
    end;
  end;
end;

procedure TFrmDesignMain.N40Click(Sender: TObject);
begin
  if PopupMenuCheckBox.PopupComponent = AutoControl then begin
    ColorDialog1.Color := TRzCheckBox(TAutoControl(PopupMenuCheckBox.PopupComponent).Target).Font.Color;
    if ColorDialog1.Execute then begin
      TRzCheckBox(TAutoControl(PopupMenuCheckBox.PopupComponent).Target).Font.Color := ColorDialog1.Color;
    end;
  end else begin
    ColorDialog1.Color := TRzCheckBox(PopupMenuCheckBox.PopupComponent).Font.Color;
    if ColorDialog1.Execute then begin
      TRzCheckBox(PopupMenuCheckBox.PopupComponent).Font.Color := ColorDialog1.Color;
    end;
  end;
end;

procedure TFrmDesignMain.N20Click(Sender: TObject);
begin
  if PopupMenuCheckBox.PopupComponent = AutoControl then begin
    ColorDialog1.Color := TRzCheckBox(TAutoControl(PopupMenuCheckBox.PopupComponent).Target).FrameColor;
    if ColorDialog1.Execute then begin
      TRzCheckBox(TAutoControl(PopupMenuCheckBox.PopupComponent).Target).FrameColor := ColorDialog1.Color;
    end;
  end else begin
    ColorDialog1.Color := TRzCheckBox(PopupMenuCheckBox.PopupComponent).FrameColor;
    if ColorDialog1.Execute then begin
      TRzCheckBox(PopupMenuCheckBox.PopupComponent).FrameColor := ColorDialog1.Color;
    end;
  end;
end;

procedure TFrmDesignMain.N21Click(Sender: TObject);
begin
  if PopupMenuCheckBox.PopupComponent = AutoControl then begin
    ColorDialog1.Color := TRzCheckBox(TAutoControl(PopupMenuCheckBox.PopupComponent).Target).HotTrackColor;
    if ColorDialog1.Execute then begin
      TRzCheckBox(TAutoControl(PopupMenuCheckBox.PopupComponent).Target).HotTrackColor := ColorDialog1.Color;
    end;
  end else begin
    ColorDialog1.Color := TRzCheckBox(PopupMenuCheckBox.PopupComponent).HotTrackColor;
    if ColorDialog1.Execute then begin
      TRzCheckBox(PopupMenuCheckBox.PopupComponent).HotTrackColor := ColorDialog1.Color;
    end;
  end;
end;

procedure TFrmDesignMain.N23Click(Sender: TObject);
begin
  if PopupMenuCheckBox.PopupComponent = AutoControl then begin
    TAutoControl(PopupMenuCheckBox.PopupComponent).Target.ShowHint := not TAutoControl(PopupMenuCheckBox.PopupComponent).Target.ShowHint;
  end else begin
    TWinControl(PopupMenuCheckBox.PopupComponent).ShowHint := not TWinControl(PopupMenuCheckBox.PopupComponent).ShowHint;
  end;
end;

procedure TFrmDesignMain.N34Click(Sender: TObject);
begin
  RzComboBox1.ShowHint := not RzComboBox1.ShowHint;
end;

procedure TFrmDesignMain.PopupMenuRzComboBoxPopup(Sender: TObject);
begin
  N34.Checked := RzComboBox1.ShowHint;
end;

procedure TFrmDesignMain.N41Click(Sender: TObject);
begin
  FontDialog1.Font := RzComboBox1.Font;
  if FontDialog1.Execute then begin
    RzComboBox1.Font := FontDialog1.Font;
  end;
end;

procedure TFrmDesignMain.N32Click(Sender: TObject);
begin
  ColorDialog1.Color := RzComboBox1.Font.Color;
  if ColorDialog1.Execute then begin
    RzComboBox1.Font.Color := ColorDialog1.Color;
  end;
end;

procedure TFrmDesignMain.N33Click(Sender: TObject);
begin
  ColorDialog1.Color := RzComboBox1.FrameColor;
  if ColorDialog1.Execute then begin
    RzComboBox1.FrameColor := ColorDialog1.Color;
  end;
end;

procedure TFrmDesignMain.N9Click(Sender: TObject);
begin
  if g_TrialRun.boTrialRun then Exit;
  SaveDialog1.Filter := '3KSkin文件|*.3KSkin';
  if SaveDialog1.Execute then begin
    SaveToFile(SaveDialog1.FileName); 
  end;
end;

procedure TFrmDesignMain.N45Click(Sender: TObject);
begin
  if PopupMenuImageProgressBar.PopupComponent = AutoControl then begin
    TImageProgressbar(TAutoControl(PopupMenuImageProgressBar.PopupComponent).Target).ShowHint := not TImageProgressbar(TAutoControl(PopupMenuImageProgressBar.PopupComponent).Target).ShowHint;
  end else begin
    TWinControl(PopupMenuImageProgressBar.PopupComponent).ShowHint := not TWinControl(PopupMenuImageProgressBar.PopupComponent).ShowHint;
  end;
end;

procedure TFrmDesignMain.N42Click(Sender: TObject);
begin
  if PopupMenuImageProgressBar.PopupComponent = AutoControl then begin
    OpenImageEdit(TPicture(TImageProgressbar(TAutoControl(PopupMenuImageProgressBar.PopupComponent).Target).PicBar), FTAll, False);
  end else begin
    OpenImageEdit(TPicture(TImageProgressbar(PopupMenuImageProgressBar.PopupComponent).PicBar), FTAll, False);
  end;
end;

procedure TFrmDesignMain.N43Click(Sender: TObject);
begin
  if PopupMenuImageProgressBar.PopupComponent = AutoControl then begin
    OpenImageEdit(TPicture(TImageProgressbar(TAutoControl(PopupMenuImageProgressBar.PopupComponent).Target).PicMain), FTAll, False);
  end else begin
    OpenImageEdit(TPicture(TImageProgressbar(PopupMenuImageProgressBar.PopupComponent).PicMain), FTAll, False);
  end;
end;

procedure TFrmDesignMain.PopupMenuImageProgressBarPopup(Sender: TObject);
begin
  if PopupMenuImageProgressBar.PopupComponent = AutoControl then begin
    N45.Checked := TAutoControl(PopupMenuImageProgressBar.PopupComponent).Target.ShowHint;
  end else N45.Checked := TWinControl(PopupMenuImageProgressBar.PopupComponent).ShowHint;
end;

procedure TFrmDesignMain.N47Click(Sender: TObject);
begin
  if PopupMenuImageProgressBar.PopupComponent = AutoControl then begin
    if TAutoControl(PopupMenuImageProgressBar.PopupComponent).Target = ProgressBarCurDownload then begin
      RzProgressBar1.Left := TAutoControl(PopupMenuImageProgressBar.PopupComponent).Target.Left;
      RzProgressBar1.Top := TAutoControl(PopupMenuImageProgressBar.PopupComponent).Target.Top;
      RzProgressBar1.Visible := True;
      TAutoControl(PopupMenuImageProgressBar.PopupComponent).Target.Visible := False;
    end else begin
      RzProgressBar2.Left := TAutoControl(PopupMenuImageProgressBar.PopupComponent).Target.Left;
      RzProgressBar2.Top := TAutoControl(PopupMenuImageProgressBar.PopupComponent).Target.Top;
      RzProgressBar2.Visible := True;
      TAutoControl(PopupMenuImageProgressBar.PopupComponent).Target.Visible := False;
    end;
  end else begin
    if PopupMenuImageProgressBar.PopupComponent = ProgressBarCurDownload then begin
      RzProgressBar1.Left := TWinControl(PopupMenuImageProgressBar.PopupComponent).Left;
      RzProgressBar1.Top := TWinControl(PopupMenuImageProgressBar.PopupComponent).Top;
      RzProgressBar1.Visible := True;
      TWinControl(PopupMenuImageProgressBar.PopupComponent).Visible := False;
    end else begin
      RzProgressBar2.Left := TWinControl(PopupMenuImageProgressBar.PopupComponent).Left;
      RzProgressBar2.Top := TWinControl(PopupMenuImageProgressBar.PopupComponent).Top;
      RzProgressBar2.Visible := True;
      TWinControl(PopupMenuImageProgressBar.PopupComponent).Visible := False;
    end;
  end;
  AutoControl.Target := nil;
end;

procedure TFrmDesignMain.N8Click(Sender: TObject);
var
  FileStream: TFileStream;
  FileHeader: TSkinFileHeader;
  bfImage: T3KBImage;
  sText: string;
  bfTreeView: T3KTreeView;
  bfBtn: T3KButton;
  bfCheckBox: T3KCheckBox;
  bfRzComboBox: T3KRzComboBox;
  bfLabel: T3KLabel;
  bfWebBrowser: T3KWebBrowser;
  bfComboBox: T3KCombobox;
  bfImageProgressBar: T3KImageProgressBar;
  bfRzProgressBar: T3KRzProgressBar;
  Buffer: Word;
begin
  if g_TrialRun.boTrialRun then Exit;
  AutoControl.Target := nil;
  OpenDialog1.Filter := '3KSkin文件|*.3KSkin';
  if OpenDialog1.Execute then begin
    FileStream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead or fmShareDenyNone);
    try
      FileStream.Position := 0;
      FillChar(FileHeader, SizeOf(TSkinFileHeader), #0);
      FileStream.Read(FileHeader, SizeOf(TSkinFileHeader));
      if FileHeader.sDesc <> sSkinHeaderDesc then begin
        Application.MessageBox('读取皮肤文件失败，该文件已被改动！', 'Error',
          MB_OK + MB_ICONSTOP);
        Exit;
      end;
      TransparentColor := FileHeader.boFrmTransparent;
      TreeView1.Visible := FileHeader.boServerList;
      ComboBox1.Visible := not FileHeader.boServerList;
      ProgressBarCurDownload.Visible := FileHeader.boProgressBarDown;
      RzProgressBar1.Visible := not FileHeader.boProgressBarDown;
      ProgressBarAll.Visible := FileHeader.boProgressBarAll;
      RzProgressBar2.Visible := not FileHeader.boProgressBarAll;
      //--MainImage
      FillChar(bfImage, SizeOf(T3KBImage), #0);
      FileStream.Read(bfImage, SizeOf(T3KBImage));
      if bfImage.ImageLen > 0 then begin
        SetLength(sText, bfImage.ImageLen);
        FileStream.Read(sText[1], bfImage.ImageLen);
        MakeStringIntoBitmap(sText).ReadBuffer(Buffer,2);
        if Buffer = $4D42 then begin //BMP
          if not Assigned(MainImage.Picture.Graphic) then MainImage.Picture.Bitmap := TBitmap.Create();
          MainImage.Picture.Bitmap.LoadFromStream(MakeStringIntoBitmap(sText));
        end else if Buffer = $D8FF then begin //JPG
          if not Assigned(MainImage.Picture.Graphic) then MainImage.Picture.Graphic := TJpegImage.Create();
          MainImage.Picture.Graphic.LoadFromStream(MakeStringIntoBitmap(sText));
        end else begin
          Application.MessageBox('窗体背景图片只允许JPG和BMP格式！此图片没读取成功！',
            'Error', MB_OK + MB_ICONSTOP);
        end;
        SetLength(sText, 0);
        Width := MainImage.Picture.Width;
        Height := MainImage.Picture.Height + Panel2.Height;
      end;
      //--TreeView
      if FileHeader.boServerList then begin
        if FileHeader.ControlVisible.TreeView then begin
          FillChar(bfTreeView, SizeOf(T3KTreeView), #0);
          FileStream.Read(bfTreeView, SizeOf(T3KTreeView));
          ReadGuiBase(bfTreeView.Base, TreeView1);
          ReadGuiFont(bfTreeView.Font, TreeView1.Font);
          if bfTreeView.Font.NameLen > 0 then begin
            SetLength(sText, bfTreeView.Font.NameLen);
            FileStream.Read(sText[1], bfTreeView.Font.NameLen);
            TreeView1.Font.Name := sText;
          end;
        end;
      end else begin //ComboBox1
        if FileHeader.ControlVisible.ComboBox1 then begin
          FillChar(bfComboBox, SizeOf(T3KComboBox), #0);
          FileStream.Read(bfComboBox, SizeOf(T3KComboBox));
          ReadGuiBase(bfComboBox.Base, ComboBox1);
          ReadGuiFont(bfComboBox.Font, ComboBox1.Font);
          ComboBox1.Color := bfComboBox.bColor;
          if bfComboBox.Font.NameLen > 0 then begin
            SetLength(sText, bfComboBox.Font.NameLen);
            FileStream.Read(sText[1], bfComboBox.Font.NameLen);
            ComboBox1.Font.Name := sText;
          end;
        end;
      end;
      //--MinimizeBtn
      if FileHeader.ControlVisible.MinimizeBtn then begin
        FillChar(bfBtn, SizeOf(T3KButton), #0);
        FileStream.Read(bfBtn, SizeOf(T3KButton));
        ReadGuiBase(bfBtn.Base, MinimizeBtn);
        ReadGuiBitMaps(FileStream, bfBtn.BitMaps, MinimizeBtn.Bitmaps);
      end;
      MinimizeBtn.ShowHint := FileHeader.ControlVisible.MinimizeBtn;
      //--CloseBtn
      if FileHeader.ControlVisible.CloseBtn then begin
        FillChar(bfBtn, SizeOf(T3KButton), #0);
        FileStream.Read(bfBtn, SizeOf(T3KButton));
        ReadGuiBase(bfBtn.Base, CloseBtn);
        ReadGuiBitMaps(FileStream, bfBtn.BitMaps, CloseBtn.Bitmaps);
      end;
      CloseBtn.ShowHint := FileHeader.ControlVisible.CloseBtn;
      //----StartButton
      if FileHeader.ControlVisible.StartButton then begin
        FillChar(bfBtn, SizeOf(T3KButton), #0);
        FileStream.Read(bfBtn, SizeOf(T3KButton));
        ReadGuiBase(bfBtn.Base, StartButton);
        ReadGuiBitMaps(FileStream, bfBtn.BitMaps, StartButton.Bitmaps);
      end;
      StartButton.ShowHint := FileHeader.ControlVisible.StartButton;
      //----ButtonHomePage
      if FileHeader.ControlVisible.ButtonHomePage then begin
        FillChar(bfBtn, SizeOf(T3KButton), #0);
        FileStream.Read(bfBtn, SizeOf(T3KButton));
        ReadGuiBase(bfBtn.Base, ButtonHomePage);
        ReadGuiBitMaps(FileStream, bfBtn.BitMaps, ButtonHomePage.Bitmaps);
      end;
      ButtonHomePage.ShowHint := FileHeader.ControlVisible.ButtonHomePage;
      //----RzBmpButton1
      if FileHeader.ControlVisible.RzBmpButton1 then begin
        FillChar(bfBtn, SizeOf(T3KButton), #0);
        FileStream.Read(bfBtn, SizeOf(T3KButton));
        ReadGuiBase(bfBtn.Base, RzBmpButton1);
        ReadGuiBitMaps(FileStream, bfBtn.BitMaps, RzBmpButton1.Bitmaps);
      end;
      RzBmpButton1.ShowHint := FileHeader.ControlVisible.RzBmpButton1;
      //----RzBmpButton2
      if FileHeader.ControlVisible.RzBmpButton2 then begin
        FillChar(bfBtn, SizeOf(T3KButton), #0);
        FileStream.Read(bfBtn, SizeOf(T3KButton));
        ReadGuiBase(bfBtn.Base, RzBmpButton2);
        ReadGuiBitMaps(FileStream, bfBtn.BitMaps, RzBmpButton2.Bitmaps);
      end;
      RzBmpButton2.ShowHint := FileHeader.ControlVisible.RzBmpButton2;
      //----ButtonNewAccount
      if FileHeader.ControlVisible.ButtonNewAccount then begin
        FillChar(bfBtn, SizeOf(T3KButton), #0);
        FileStream.Read(bfBtn, SizeOf(T3KButton));
        ReadGuiBase(bfBtn.Base, ButtonNewAccount);
        ReadGuiBitMaps(FileStream, bfBtn.BitMaps, ButtonNewAccount.Bitmaps);
      end;
      ButtonNewAccount.ShowHint := FileHeader.ControlVisible.ButtonNewAccount;
      //----ButtonChgPassword
      if FileHeader.ControlVisible.ButtonChgPassword then begin
        FillChar(bfBtn, SizeOf(T3KButton), #0);
        FileStream.Read(bfBtn, SizeOf(T3KButton));
        ReadGuiBase(bfBtn.Base, ButtonChgPassword);
        ReadGuiBitMaps(FileStream, bfBtn.BitMaps, ButtonChgPassword.Bitmaps);
      end;
      ButtonChgPassword.ShowHint := FileHeader.ControlVisible.ButtonChgPassword;
      //----ButtonGetBackPassword
      if FileHeader.ControlVisible.ButtonGetBackPassword then begin
        FillChar(bfBtn, SizeOf(T3KButton), #0);
        FileStream.Read(bfBtn, SizeOf(T3KButton));
        ReadGuiBase(bfBtn.Base, ButtonGetBackPassword);
        ReadGuiBitMaps(FileStream, bfBtn.BitMaps, ButtonGetBackPassword.Bitmaps);
      end;
      ButtonGetBackPassword.ShowHint := FileHeader.ControlVisible.ButtonGetBackPassword;
      //----ImageButtonClose
      if FileHeader.ControlVisible.ImageButtonClose then begin
        FillChar(bfBtn, SizeOf(T3KButton), #0);
        FileStream.Read(bfBtn, SizeOf(T3KButton));
        ReadGuiBase(bfBtn.Base, ImageButtonClose);
        ReadGuiBitMaps(FileStream, bfBtn.BitMaps, ImageButtonClose.Bitmaps);
      end;
      ImageButtonClose.ShowHint := FileHeader.ControlVisible.ImageButtonClose;
      //----RzCheckBox1
      if FileHeader.ControlVisible.RzCheckBox1 then begin
        FillChar(bfCheckBox, SizeOf(T3KCheckBox), #0);
        FileStream.Read(bfCheckBox, SizeOf(T3KCheckBox));
        ReadGuiBase(bfCheckBox.Base, RzCheckBox1);
        ReadGuiFont(bfCheckBox.Font, RzCheckBox1.Font);
        if bfCheckBox.Font.NameLen > 0 then begin
          SetLength(sText, bfCheckBox.Font.NameLen);
          FileStream.Read(sText[1], bfCheckBox.Font.NameLen);
          RzCheckBox1.Font.Name := sText;
        end;
        RzCheckBox1.FrameColor := bfCheckBox.FrameColor;
        RzCheckBox1.HotTrackColor := bfCheckBox.HotTrackColor;
      end;
      RzCheckBox1.ShowHint := FileHeader.ControlVisible.RzCheckBox1;
      //----RzCombobox1
      if FileHeader.ControlVisible.RzComboBox1 then begin
        FillChar(bfRzComboBox, SizeOf(T3KRzComboBox), #0);
        FileStream.Read(bfRzComboBox, SizeOf(T3KRzComboBox));
        ReadGuiBase(bfRzComboBox.Base, RzComboBox1);
        ReadGuiFont(bfRzComboBox.Font, RzComboBox1.Font);
        if bfRzComboBox.Font.NameLen > 0 then begin
          SetLength(sText, bfRzComboBox.Font.NameLen);
          FileStream.Read(sText[1], bfRzComboBox.Font.NameLen);
          RzComboBox1.Font.Name := sText;
        end;
        RzComboBox1.FrameColor := bfRzComboBox.FrameColor;
        RzComboBox1.Color := bfRzComboBox.bColor;
      end;
      RzComboBox1.ShowHint := FileHeader.ControlVisible.RzComboBox1;
      //----RzCheckBoxFullScreen
      if FileHeader.ControlVisible.RzCheckBoxFullScreen then begin
        FillChar(bfCheckBox, SizeOf(T3KCheckBox), #0);
        FileStream.Read(bfCheckBox, SizeOf(T3KCheckBox));
        ReadGuiBase(bfCheckBox.Base, RzCheckBoxFullScreen);
        ReadGuiFont(bfCheckBox.Font, RzCheckBoxFullScreen.Font);
        if bfCheckBox.Font.NameLen > 0 then begin
          SetLength(sText, bfCheckBox.Font.NameLen);
          FileStream.Read(sText[1], bfCheckBox.Font.NameLen);
          RzCheckBoxFullScreen.Font.Name := sText;
        end;
        RzCheckBoxFullScreen.FrameColor := bfCheckBox.FrameColor;
        RzCheckBoxFullScreen.HotTrackColor := bfCheckBox.HotTrackColor;
      end;
      RzCheckBoxFullScreen.ShowHint := FileHeader.ControlVisible.RzCheckBoxFullScreen;
      //----RzLabelStatus
      if FileHeader.ControlVisible.RzLabelStatus then begin
        FillChar(bfLabel, SizeOf(T3KLabel), #0);
        FileStream.Read(bfLabel, SizeOf(T3KLabel));
        ReadGuiBase(bfLabel.Base, RzLabelStatus);
        ReadGuiFont(bfLabel.Font, RzLabelStatus.Font);
        if bfLabel.Font.NameLen > 0 then begin
          SetLength(sText, bfLabel.Font.NameLen);
          FileStream.Read(sText[1], bfLabel.Font.NameLen);
          RzLabelStatus.Font.Name := sText;
        end;
        g_ConnectLabelColor := bfLabel.Color1;
        g_DisconnectLabelColor := bfLabel.Color2;
      end;
      RzLabelStatus.ShowHint := FileHeader.ControlVisible.RzLabelStatus;
      //----WebBrowser1
      if FileHeader.ControlVisible.WebBrowser1 then begin
        FillChar(bfWebBrowser, SizeOf(T3KWebBrowser), #0);
        FileStream.Read(bfWebBrowser, SizeOf(T3KWebBrowser));
        ReadGuiBase(bfWebBrowser.Base, WebBrowser1);
      end;
      WebBrowser1.ShowHint := FileHeader.ControlVisible.WebBrowser1;
      //----ProgressBarCurDownload
      if FileHeader.boProgressBarDown then begin
        if FileHeader.ControlVisible.ProgressBarCurDownload then begin
          FillChar(bfImageProgressBar, SizeOf(T3KImageProgressBar), #0);
          FileStream.Read(bfImageProgressBar, SizeOf(T3KImageProgressBar));
          ReadGuiBase(bfImageProgressBar.Base, ProgressBarCurDownload);
          if bfImageProgressBar.BarImageLen > 0 then begin
            SetLength(sText, bfImageProgressBar.BarImageLen);
            FileStream.Read(sText[1], bfImageProgressBar.BarImageLen);
            MakeStringIntoBitmap(sText).ReadBuffer(Buffer,2);
            if Buffer = $4D42 then begin //BMP
              if not Assigned(ProgressBarCurDownload.PicBar.Graphic) then ProgressBarCurDownload.PicBar.Bitmap := TBitmap.Create();
              ProgressBarCurDownload.PicBar.Bitmap.LoadFromStream(MakeStringIntoBitmap(sText));
            end else if Buffer = $D8FF then begin //JPG
              if not Assigned(ProgressBarCurDownload.PicBar.Graphic) then ProgressBarCurDownload.PicBar.Graphic := TJpegImage.Create();
              ProgressBarCurDownload.PicBar.Graphic.LoadFromStream(MakeStringIntoBitmap(sText));
            end else begin
              Application.MessageBox('进度条的滚动格图片只允许JPG和BMP格式！此图片没读取成功！',
                'Error', MB_OK + MB_ICONSTOP);
            end;
            SetLength(sText, 0);
          end;
          if bfImageProgressBar.BfBarImageLen > 0 then begin
            SetLength(sText, bfImageProgressBar.BfBarImageLen);
            FileStream.Read(sText[1], bfImageProgressBar.BfBarImageLen);
            MakeStringIntoBitmap(sText).ReadBuffer(Buffer,2);
            if Buffer = $4D42 then begin //BMP
              if not Assigned(ProgressBarCurDownload.PicMain.Graphic) then ProgressBarCurDownload.PicMain.Bitmap := TBitmap.Create();
              ProgressBarCurDownload.PicMain.Bitmap.LoadFromStream(MakeStringIntoBitmap(sText));
            end else if Buffer = $D8FF then begin //JPG
              if not Assigned(ProgressBarCurDownload.PicMain.Graphic) then ProgressBarCurDownload.PicMain.Graphic := TJpegImage.Create();
              ProgressBarCurDownload.PicMain.Graphic.LoadFromStream(MakeStringIntoBitmap(sText));
            end else begin
              Application.MessageBox('进度条的滚动格图片只允许JPG和BMP格式！此图片没读取成功！',
                'Error', MB_OK + MB_ICONSTOP);
            end;
            MakeStringIntoBitmap(sText).Free;
            SetLength(sText, 0);
          end;
        end;
        ProgressBarCurDownload.ShowHint := FileHeader.ControlVisible.ProgressBarCurDownload;
      end else begin //----RzProgressBar1
        if FileHeader.ControlVisible.RzProgressBar1 then begin
          FillChar(bfRzProgressBar, SizeOf(T3KRzProgressBar), #0);
          FileStream.Read(bfRzProgressBar, SizeOf(T3KRzProgressBar));
          ReadGuiBase(bfRzProgressBar.Base, RzProgressBar1);
          RzProgressBar1.BarStyle := bfRzProgressBar.BarStyle;
          RzProgressBar1.BackColor := bfRzProgressBar.BackColor;
          RzProgressBar1.FlatColor := bfRzProgressBar.FlatColor;
          RzProgressBar1.BarColor := bfRzProgressBar.BarColor;
        end;
        RzProgressBar1.ShowHint := FileHeader.ControlVisible.RzProgressBar1;
      end;
      //----ProgressBarAll
      if FileHeader.boProgressBarAll then begin
        if FileHeader.ControlVisible.ProgressBarAll then begin
          FillChar(bfImageProgressBar, SizeOf(T3KImageProgressBar), #0);
          FileStream.Read(bfImageProgressBar, SizeOf(T3KImageProgressBar));
          ReadGuiBase(bfImageProgressBar.Base, ProgressBarAll);
          if bfImageProgressBar.BarImageLen > 0 then begin
            SetLength(sText, bfImageProgressBar.BarImageLen);
            FileStream.Read(sText[1], bfImageProgressBar.BarImageLen);
            MakeStringIntoBitmap(sText).ReadBuffer(Buffer,2);
            if Buffer = $4D42 then begin //BMP
              if not Assigned(ProgressBarAll.PicBar.Graphic) then ProgressBarAll.PicBar.Bitmap := TBitmap.Create();
              ProgressBarAll.PicBar.Bitmap.LoadFromStream(MakeStringIntoBitmap(sText));
            end else if Buffer = $D8FF then begin //JPG
              if not Assigned(ProgressBarAll.PicBar.Graphic) then ProgressBarAll.PicBar.Graphic := TJpegImage.Create();
              ProgressBarAll.PicBar.Graphic.LoadFromStream(MakeStringIntoBitmap(sText));
            end else begin
              Application.MessageBox('进度条的滚动格图片只允许JPG和BMP格式！此图片没读取成功！', 
                'Error', MB_OK + MB_ICONSTOP);
            end;
            SetLength(sText, 0);
          end;
          if bfImageProgressBar.BfBarImageLen > 0 then begin
            SetLength(sText, bfImageProgressBar.BfBarImageLen);
            FileStream.Read(sText[1], bfImageProgressBar.BfBarImageLen);
            MakeStringIntoBitmap(sText).ReadBuffer(Buffer,2);
            if Buffer = $4D42 then begin //BMP
              if not Assigned(ProgressBarAll.PicMain.Graphic) then ProgressBarAll.PicMain.Bitmap := TBitmap.Create();
              ProgressBarAll.PicMain.Bitmap.LoadFromStream(MakeStringIntoBitmap(sText));
            end else if Buffer = $D8FF then begin //JPG
              if not Assigned(ProgressBarAll.PicMain.Graphic) then ProgressBarAll.PicMain.Graphic := TJpegImage.Create();
              ProgressBarAll.PicMain.Graphic.LoadFromStream(MakeStringIntoBitmap(sText));
            end else begin
              Application.MessageBox('进度条的背景图片只允许JPG和BMP格式！此图片没读取成功！', 
                'Error', MB_OK + MB_ICONSTOP);
            end;
            MakeStringIntoBitmap(sText).Free;
            SetLength(sText, 0);
          end;
        end;
        ProgressBarAll.ShowHint := FileHeader.ControlVisible.ProgressBarAll;
      end else begin//----RzProgressBar2
        if FileHeader.ControlVisible.RzProgressBar2 then begin
          FillChar(bfRzProgressBar, SizeOf(T3KRzProgressBar), #0);
          FileStream.Read(bfRzProgressBar, SizeOf(T3KRzProgressBar));
          ReadGuiBase(bfRzProgressBar.Base, RzProgressBar2);
          RzProgressBar2.BarStyle := bfRzProgressBar.BarStyle;
          RzProgressBar2.BackColor := bfRzProgressBar.BackColor;
          RzProgressBar2.FlatColor := bfRzProgressBar.FlatColor;
          RzProgressBar2.BarColor := bfRzProgressBar.BarColor;
        end;
        RzProgressBar2.ShowHint := FileHeader.ControlVisible.RzProgressBar2;
      end;
    finally
      FileStream.Free;
    end;
  end;
end;

procedure TFrmDesignMain.SaveToFile(FileName: string);
  function ExtractFileNameOnly(const fname: string): string;
  var
    extpos: Integer;
    ext, fn: string;
  begin
    ext := ExtractFileExt(fname);
    fn := ExtractFileName(fname);
    if ext <> '' then begin
      extpos := Pos(ext, fn);
      Result := Copy(fn, 1, extpos - 1);
    end else
      Result := fn;
  end;
var
  FileStream: TFileStream;
  FileHeader: TSkinFileHeader;
  bfImage: T3KBImage;
  bfTreeView: T3KTreeView;
  bfBtn: T3KButton;
  sText,sText1: string;
  bfCheckBox: T3KCheckBox;
  bfRzComboBox: T3KRzComboBox;
  bfLabel: T3KLabel;
  bfWebBrowser: T3KWebBrowser;
  bfComboBox: T3KCombobox;
  bfImageProgressBar: T3KImageProgressBar;
  bfRzProgressBar: T3KRzProgressBar;
begin
  if ExtractFileExt(FileName) <> '.3kskin' then
    FileName := ExtractFilePath(FileName) + ExtractFileNameOnly(FileName) + '.3kskin';

  if FileExists(FileName) then begin
    FileSetAttr(FileName, 0);
    FileStream := TFileStream.Create(FileName, fmOpenReadWrite or fmShareDenyNone);
  end else begin
    FileStream := TFileStream.Create(FileName, fmOpenReadWrite or fmShareDenyNone or fmCreate);
  end;
  try
    FileStream.Size := 0;
    FileStream.Position := 0;
    FillChar(FileHeader, SizeOf(TSkinFileHeader), #0);
    FileHeader.sDesc := sSkinHeaderDesc;
    FileHeader.boServerList := TreeView1.Visible;
    FileHeader.boProgressBarDown := ProgressBarCurDownload.Visible;
    FileHeader.boProgressBarAll := ProgressBarAll.Visible;
    FileHeader.boFrmTransparent := TransparentColor;
    FileHeader.dCreateDate := Now;
    FileHeader.ControlVisible.TreeView := TreeView1.ShowHint;
    FileHeader.ControlVisible.ComboBox1 := ComboBox1.ShowHint;
    FileHeader.ControlVisible.MinimizeBtn := MinimizeBtn.ShowHint;
    FileHeader.ControlVisible.CloseBtn := CloseBtn.ShowHint;
    FileHeader.ControlVisible.StartButton := StartButton.ShowHint;
    FileHeader.ControlVisible.ButtonHomePage := ButtonHomePage.ShowHint;
    FileHeader.ControlVisible.RzBmpButton1 := RzBmpButton1.ShowHint;
    FileHeader.ControlVisible.RzBmpButton2 := RzBmpButton2.ShowHint;
    FileHeader.ControlVisible.ButtonNewAccount := ButtonNewAccount.ShowHint;
    FileHeader.ControlVisible.ButtonChgPassword := ButtonChgPassword.ShowHint;
    FileHeader.ControlVisible.ButtonGetBackPassword := ButtonGetBackPassword.ShowHint;
    FileHeader.ControlVisible.ImageButtonClose := ImageButtonClose.ShowHint;
    FileHeader.ControlVisible.RzCheckBox1 := RzCheckBox1.ShowHint;
    FileHeader.ControlVisible.RzCheckBoxFullScreen := RzCheckBoxFullScreen.ShowHint;
    FileHeader.ControlVisible.RzLabelStatus := RzLabelStatus.ShowHint;
    FileHeader.ControlVisible.RzComboBox1 := RzComboBox1.ShowHint;
    FileHeader.ControlVisible.WebBrowser1 := WebBrowser1.ShowHint;
    FileHeader.ControlVisible.RzProgressBar1 := RzProgressBar1.ShowHint;
    FileHeader.ControlVisible.RzProgressBar2 := RzProgressBar2.ShowHint;
    FileHeader.ControlVisible.ProgressBarCurDownload := ProgressBarCurDownload.ShowHint;
    FileHeader.ControlVisible.ProgressBarAll := ProgressBarAll.ShowHint;
    FileStream.Write(FileHeader, SizeOf(TSkinFileHeader));
    //--MainImage
    FillChar(bfImage, SizeOf(T3KBImage), #0);
    if Assigned(MainImage.Picture.Graphic) then begin
      sText := MakeBitmapIntoString(MainImage.Picture.Graphic);
      bfImage.ImageLen := Length(sText);
    end;
    FileStream.Write(bfImage, SizeOf(T3KBImage));
    if Assigned(MainImage.Picture.Graphic) then begin
      FileStream.Write(sText[1], bfImage.ImageLen);
    end;
    //--TreeView
    if FileHeader.boServerList then begin
      if FileHeader.ControlVisible.TreeView then begin
        FillChar(bfTreeView, SizeOf(T3KTreeView), #0);
        bfTreeView.Base := WriteGuiBase(TreeView1);
        bfTreeView.Font := WriteGuiFont(TreeView1.Font);
        sText := TreeView1.Font.Name;
        bfTreeView.Color := TreeView1.Color;
        FileStream.Write(bfTreeView, SizeOf(T3KTreeView));
        FileStream.Write(sText[1], bfTreeView.Font.NameLen);
      end;
    end else begin //ComboBox1
      if FileHeader.ControlVisible.ComboBox1 then begin
        FillChar(bfComboBox, SizeOf(T3KComboBox), #0);
        bfComboBox.Base := WriteGuiBase(ComboBox1);
        bfComboBox.Font := WriteGuiFont(ComboBox1.Font);
        sText := ComboBox1.Font.Name;
        bfComboBox.bColor := ComboBox1.Color;
        FileStream.Write(bfComboBox, SizeOf(T3KComboBox));
        FileStream.Write(sText[1], bfComboBox.Font.NameLen);
      end;
    end;
    //----MinimizeBtn
    if FileHeader.ControlVisible.MinimizeBtn then begin
      FillChar(bfBtn, SizeOf(T3KButton), #0);
      bfBtn.Base := WriteGuiBase(MinimizeBtn);
      WriteGuiBitMaps(FileStream, MinimizeBtn.Bitmaps, bfBtn);
    end;
    //----CloseBtn
    if FileHeader.ControlVisible.CloseBtn then begin
      FillChar(bfBtn, SizeOf(T3KButton), #0);
      bfBtn.Base := WriteGuiBase(CloseBtn);
      WriteGuiBitMaps(FileStream, CloseBtn.Bitmaps, bfBtn);
    end;
    //----StartButton
    if FileHeader.ControlVisible.StartButton then begin
      FillChar(bfBtn, SizeOf(T3KButton), #0);
      bfBtn.Base := WriteGuiBase(StartButton);
      WriteGuiBitMaps(FileStream, StartButton.Bitmaps, bfBtn);
    end;
    //----ButtonHomePage
    if FileHeader.ControlVisible.ButtonHomePage then begin
      FillChar(bfBtn, SizeOf(T3KButton), #0);
      bfBtn.Base := WriteGuiBase(ButtonHomePage);
      WriteGuiBitMaps(FileStream, ButtonHomePage.Bitmaps, bfBtn);
    end;
    //----RzBmpButton1
    if FileHeader.ControlVisible.RzBmpButton1 then begin
      FillChar(bfBtn, SizeOf(T3KButton), #0);
      bfBtn.Base := WriteGuiBase(RzBmpButton1);
      WriteGuiBitMaps(FileStream, RzBmpButton1.Bitmaps, bfBtn);
    end;
    //----RzBmpButton2
    if FileHeader.ControlVisible.RzBmpButton2 then begin
      FillChar(bfBtn, SizeOf(T3KButton), #0);
      bfBtn.Base := WriteGuiBase(RzBmpButton2);
      WriteGuiBitMaps(FileStream, RzBmpButton2.Bitmaps, bfBtn);
    end;
    //----ButtonNewAccount
    if FileHeader.ControlVisible.ButtonNewAccount then begin
      FillChar(bfBtn, SizeOf(T3KButton), #0);
      bfBtn.Base := WriteGuiBase(ButtonNewAccount);
      WriteGuiBitMaps(FileStream, ButtonNewAccount.Bitmaps, bfBtn);
    end;
    //----ButtonChgPassword
    if FileHeader.ControlVisible.ButtonChgPassword then begin
      FillChar(bfBtn, SizeOf(T3KButton), #0);
      bfBtn.Base := WriteGuiBase(ButtonChgPassword);
      WriteGuiBitMaps(FileStream, ButtonChgPassword.Bitmaps, bfBtn);
    end;
    //----ButtonGetBackPassword
    if FileHeader.ControlVisible.ButtonGetBackPassword then begin
      FillChar(bfBtn, SizeOf(T3KButton), #0);
      bfBtn.Base := WriteGuiBase(ButtonGetBackPassword);
      WriteGuiBitMaps(FileStream, ButtonGetBackPassword.Bitmaps, bfBtn);
    end;
    //----ImageButtonClose
    if FileHeader.ControlVisible.ImageButtonClose then begin
      FillChar(bfBtn, SizeOf(T3KButton), #0);
      bfBtn.Base := WriteGuiBase(ImageButtonClose);
      WriteGuiBitMaps(FileStream, ImageButtonClose.Bitmaps, bfBtn);
    end;
    //----RzCheckBox1
    if FileHeader.ControlVisible.RzCheckBox1 then begin
      FillChar(bfCheckBox, SizeOf(T3KCheckBox), #0);
      bfCheckBox.Base := WriteGuiBase(RzCheckBox1);
      bfCheckBox.Font := WriteGuiFont(RzCheckBox1.Font);
      sText := RzCheckBox1.Font.Name;
      bfCheckBox.FrameColor := RzCheckBox1.FrameColor;
      bfCheckBox.HotTrackColor := RzCheckBox1.HotTrackColor;
      FileStream.Write(bfCheckBox, SizeOf(T3KCheckBox));
      FileStream.Write(sText[1], bfCheckBox.Font.NameLen);
    end;
    //----RzCombobox1
    if FileHeader.ControlVisible.RzComboBox1 then begin
      FillChar(bfRzComboBox, SizeOf(T3KRzComboBox), #0);
      bfRzComboBox.Base := WriteGuiBase(RzComboBox1);
      bfRzComboBox.Font := WriteGuiFont(RzComboBox1.Font);
      sText := RzComboBox1.Font.Name;
      bfRzComboBox.bColor := RzComboBox1.Color;
      bfRzComboBox.FrameColor := RzCombobox1.FrameColor;
      FileStream.Write(bfRzComboBox, SizeOf(T3KRzComboBox));
      FileStream.Write(sText[1], bfRzComboBox.Font.NameLen);
    end;
    //----RzCheckBoxFullScreen
    if FileHeader.ControlVisible.RzCheckBoxFullScreen then begin
      FillChar(bfCheckBox, SizeOf(T3KCheckBox), #0);
      bfCheckBox.Base := WriteGuiBase(RzCheckBoxFullScreen);
      bfCheckBox.Font := WriteGuiFont(RzCheckBoxFullScreen.Font);
      sText := RzCheckBoxFullScreen.Font.Name;
      bfCheckBox.FrameColor := RzCheckBoxFullScreen.FrameColor;
      bfCheckBox.HotTrackColor := RzCheckBoxFullScreen.HotTrackColor;
      FileStream.Write(bfCheckBox, SizeOf(T3KCheckBox));
      FileStream.Write(sText[1], bfCheckBox.Font.NameLen);
    end;
    //----RzLabelStatus
    if FileHeader.ControlVisible.RzLabelStatus then begin
      FillChar(bfLabel, SizeOf(T3KLabel), #0);
      bfLabel.Base := WriteGuiBase(RzLabelStatus);
      bfLabel.Font := WriteGuiFont(RzLabelStatus.Font);
      sText := RzLabelStatus.Font.Name;
      bfLabel.Color1 := g_ConnectLabelColor;
      bfLabel.Color2 := g_DisconnectLabelColor;
      FileStream.Write(bfLabel, SizeOf(T3KLabel));
      FileStream.Write(sText[1], bfLabel.Font.NameLen);
    end;
    //----WebBrowser1
    if FileHeader.ControlVisible.WebBrowser1 then begin
      FillChar(bfWebBrowser, SizeOf(T3KWebBrowser), #0);
      bfWebBrowser.Base := WriteGuiBase(WebBrowser1);
      FileStream.Write(bfWebBrowser, SizeOf(T3KWebBrowser));
    end;
    //----ProgressBarCurDownload
    if FileHeader.boProgressBarDown then begin
      if FileHeader.ControlVisible.ProgressBarCurDownload then begin
        FillChar(bfImageProgressBar, SizeOf(T3KImageProgressBar), #0);
        bfImageProgressBar.Base := WriteGuiBase(ProgressBarCurDownload);
        sText := MakeBitmapIntoString(ProgressBarCurDownload.PicBar.Graphic);
        bfImageProgressBar.BarImageLen := Length(sText);
        sText1 := MakeBitmapIntoString(ProgressBarCurDownload.PicMain.Graphic);
        bfImageProgressBar.BfBarImageLen := Length(sText1);
        FileStream.Write(bfImageProgressBar, SizeOf(T3KImageProgressBar));
        FileStream.Write(sText[1], bfImageProgressBar.BarImageLen);
        FileStream.Write(sText1[1], bfImageProgressBar.BfBarImageLen);
      end;
    end else begin //RzProgressBar1
      if FileHeader.ControlVisible.RzProgressBar1 then begin
        FillChar(bfRzProgressBar, SizeOf(T3KRzProgressBar), #0);
        bfRzProgressBar.Base := WriteGuiBase(RzProgressBar1);
        bfRzProgressBar.BarStyle := RzProgressBar1.BarStyle;
        bfRzProgressBar.BackColor := RzProgressBar1.BackColor;
        bfRzProgressBar.FlatColor := RzProgressBar1.FlatColor;
        bfRzProgressBar.BarColor := RzProgressBar1.BarColor;
        FileStream.Write(bfRzProgressBar, SizeOf(T3KRzProgressBar));
      end;
    end;
    //----ProgressBarAll
    if FileHeader.boProgressBarAll then begin
      if FileHeader.ControlVisible.ProgressBarAll then begin
        FillChar(bfImageProgressBar, SizeOf(T3KImageProgressBar), #0);
        bfImageProgressBar.Base := WriteGuiBase(ProgressBarAll);
        sText := MakeBitmapIntoString(ProgressBarAll.PicBar.Graphic);
        bfImageProgressBar.BarImageLen := Length(sText);
        sText1 := MakeBitmapIntoString(ProgressBarAll.PicMain.Graphic);
        bfImageProgressBar.BfBarImageLen := Length(sText1);
        FileStream.Write(bfImageProgressBar, SizeOf(T3KImageProgressBar));
        FileStream.Write(sText[1], bfImageProgressBar.BarImageLen);
        FileStream.Write(sText1[1], bfImageProgressBar.BfBarImageLen);
      end;
    end else begin //RzProgressBar2
      if FileHeader.ControlVisible.RzProgressBar2 then begin
        FillChar(bfRzProgressBar, SizeOf(T3KRzProgressBar), #0);
        bfRzProgressBar.Base := WriteGuiBase(RzProgressBar2);
        bfRzProgressBar.BarStyle := RzProgressBar2.BarStyle;
        bfRzProgressBar.BackColor := RzProgressBar2.BackColor;
        bfRzProgressBar.FlatColor := RzProgressBar2.FlatColor;
        bfRzProgressBar.BarColor := RzProgressBar2.BarColor;
        FileStream.Write(bfRzProgressBar, SizeOf(T3KRzProgressBar));
      end;
    end;
  finally
    FileStream.Free;
  end;
end;
procedure TFrmDesignMain.N26Click(Sender: TObject);
begin
    RzLabelStatus.ShowHint := not RzLabelStatus.ShowHint;
end;

procedure TFrmDesignMain.N28Click(Sender: TObject);
begin
  FontDialog1.Font := RzLabelStatus.Font;
  if FontDialog1.Execute then begin
    RzLabelStatus.Font := FontDialog1.Font;
  end;
end;

procedure TFrmDesignMain.N29Click(Sender: TObject);
begin
  ColorDialog1.Color := RzLabelStatus.Font.Color;
  if ColorDialog1.Execute then begin
     RzLabelStatus.Font.Color := ColorDialog1.Color;
  end;
end;

procedure TFrmDesignMain.N30Click(Sender: TObject);
begin
  ColorDialog1.Color := g_ConnectLabelColor;
  if ColorDialog1.Execute then begin
     g_ConnectLabelColor := ColorDialog1.Color;
  end;
end;

procedure TFrmDesignMain.N31Click(Sender: TObject);
begin
  ColorDialog1.Color := g_DisconnectLabelColor;
  if ColorDialog1.Execute then begin
     g_DisconnectLabelColor := ColorDialog1.Color;
  end;
end;

procedure TFrmDesignMain.N57Click(Sender: TObject);
begin
  ComboBox1.Visible := False;
  TreeView1.Left := ComboBox1.Left;
  TreeView1.Top := ComboBox1.Top;
  TreeView1.Visible := True;
  AutoControl.Target := nil;
end;

procedure TFrmDesignMain.N50Click(Sender: TObject);
begin
  ComboBox1.ShowHint := not ComboBox1.ShowHint;
end;

procedure TFrmDesignMain.N52Click(Sender: TObject);
begin
  FontDialog1.Font := ComboBox1.Font;
  if FontDialog1.Execute then begin
    ComboBox1.Font := FontDialog1.Font;
  end;
end;

procedure TFrmDesignMain.N54Click(Sender: TObject);
begin
  ColorDialog1.Color := ComboBox1.Font.Color;
  if ColorDialog1.Execute then begin
    ComboBox1.Font.Color := ColorDialog1.Color;
  end;
end;

procedure TFrmDesignMain.N55Click(Sender: TObject);
begin
  ColorDialog1.Color := ComboBox1.Color;
  if ColorDialog1.Execute then begin
    ComboBox1.Color := ColorDialog1.Color;
  end;
end;

procedure TFrmDesignMain.PopupMenuComboBoxPopup(Sender: TObject);
begin
  N50.Checked := ComboBox1.ShowHint;
end;

//RzProgressBar
procedure TFrmDesignMain.PopupMenuRzProgressBarPopup(Sender: TObject);
begin
  if PopupMenuRzProgressBar.PopupComponent = AutoControl then begin
    N48.Checked := TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target.ShowHint;
    N58.Checked := TRzProgressBar(TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target).BarStyle = bsTraditional;
    LED1.Checked := TRzProgressBar(TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target).BarStyle = bsLED;
    N59.Checked := TRzProgressBar(TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target).BarStyle = bsGradient;
  end else begin
    N48.Checked := TWinControl(PopupMenuRzProgressBar.PopupComponent).ShowHint;
    N58.Checked := TRzProgressBar(PopupMenuRzProgressBar.PopupComponent).BarStyle = bsTraditional;
    LED1.Checked := TRzProgressBar(PopupMenuRzProgressBar.PopupComponent).BarStyle = bsLED;
    N59.Checked := TRzProgressBar(PopupMenuRzProgressBar.PopupComponent).BarStyle = bsGradient;
  end;
end;

procedure TFrmDesignMain.N58Click(Sender: TObject);
begin
  if PopupMenuRzProgressBar.PopupComponent = AutoControl then begin
    TRzProgressBar(TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target).BarStyle := bsTraditional;
  end else TRzProgressBar(PopupMenuRzProgressBar.PopupComponent).BarStyle := bsTraditional;
end;

procedure TFrmDesignMain.LED1Click(Sender: TObject);
begin
  if PopupMenuRzProgressBar.PopupComponent = AutoControl then begin
    TRzProgressBar(TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target).BarStyle := bsLED;
    TRzProgressBar(TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target).InteriorOffset := 0;
  end else begin
    TRzProgressBar(PopupMenuRzProgressBar.PopupComponent).BarStyle := bsLED;
    TRzProgressBar(PopupMenuRzProgressBar.PopupComponent).InteriorOffset := 0;
  end;
end;

procedure TFrmDesignMain.N59Click(Sender: TObject);
begin
  if PopupMenuRzProgressBar.PopupComponent = AutoControl then begin
    TRzProgressBar(TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target).BarStyle := bsGradient;
  end else TRzProgressBar(PopupMenuRzProgressBar.PopupComponent).BarStyle := bsGradient;
end;

procedure TFrmDesignMain.N63Click(Sender: TObject);
begin
  if PopupMenuRzProgressBar.PopupComponent = AutoControl then begin
    ColorDialog1.Color := TRzProgressBar(TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target).BackColor;
    if ColorDialog1.Execute then begin
      TRzProgressBar(TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target).BackColor := ColorDialog1.Color;
    end;
  end else begin
    ColorDialog1.Color:= TRzProgressBar(PopupMenuRzProgressBar.PopupComponent).BackColor;
    if ColorDialog1.Execute then begin
      TRzProgressBar(PopupMenuRzProgressBar.PopupComponent).BackColor := ColorDialog1.Color;
    end;
  end;
end;

procedure TFrmDesignMain.N64Click(Sender: TObject);
begin
  if PopupMenuRzProgressBar.PopupComponent = AutoControl then begin
    ColorDialog1.Color := TRzProgressBar(TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target).FlatColor;
    if ColorDialog1.Execute then begin
      TRzProgressBar(TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target).FlatColor := ColorDialog1.Color;
    end;
  end else begin
    ColorDialog1.Color:= TRzProgressBar(PopupMenuRzProgressBar.PopupComponent).FlatColor;
    if ColorDialog1.Execute then begin
      TRzProgressBar(PopupMenuRzProgressBar.PopupComponent).FlatColor := ColorDialog1.Color;
    end;
  end;
end;

procedure TFrmDesignMain.N65Click(Sender: TObject);
begin
  if PopupMenuRzProgressBar.PopupComponent = AutoControl then begin
    ColorDialog1.Color := TRzProgressBar(TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target).BarColor;
    if ColorDialog1.Execute then begin
      TRzProgressBar(TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target).BarColor := ColorDialog1.Color;
    end;
  end else begin
    ColorDialog1.Color:= TRzProgressBar(PopupMenuRzProgressBar.PopupComponent).BarColor;
    if ColorDialog1.Execute then begin
      TRzProgressBar(PopupMenuRzProgressBar.PopupComponent).BarColor := ColorDialog1.Color;
    end;
  end;
end;

procedure TFrmDesignMain.N48Click(Sender: TObject);
begin
  if PopupMenuRzProgressBar.PopupComponent = AutoControl then begin
    TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target.ShowHint := not TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target.ShowHint;
  end else begin
    TWinControl(PopupMenuRzProgressBar.PopupComponent).ShowHint := not TWinControl(PopupMenuRzProgressBar.PopupComponent).ShowHint;
  end;
end;

procedure TFrmDesignMain.N68Click(Sender: TObject);
begin
  if PopupMenuRzProgressBar.PopupComponent = AutoControl then begin
    if TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target = RzProgressBar1 then begin
      ProgressBarCurDownload.Left := TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target.Left;
      ProgressBarCurDownload.Top := TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target.Top;
      ProgressBarCurDownload.Visible := True;
      TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target.Visible := False;
    end else begin
      ProgressBarAll.Left := TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target.Left;
      ProgressBarAll.Top := TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target.Top;
      ProgressBarAll.Visible := True;
      TAutoControl(PopupMenuRzProgressBar.PopupComponent).Target.Visible := False;
    end;
  end else begin
    if PopupMenuRzProgressBar.PopupComponent = RzProgressBar1 then begin
      ProgressBarCurDownload.Left := TWinControl(PopupMenuRzProgressBar.PopupComponent).Left;
      ProgressBarCurDownload.Top := TWinControl(PopupMenuRzProgressBar.PopupComponent).Top;
      ProgressBarCurDownload.Visible := True;
      TWinControl(PopupMenuRzProgressBar.PopupComponent).Visible := False;
    end else begin
      ProgressBarAll.Left := TWinControl(PopupMenuRzProgressBar.PopupComponent).Left;
      ProgressBarAll.Top := TWinControl(PopupMenuRzProgressBar.PopupComponent).Top;
      ProgressBarAll.Visible := True;
      TWinControl(PopupMenuRzProgressBar.PopupComponent).Visible := False;
    end;
  end;
  AutoControl.Target := nil;
end;

procedure TFrmDesignMain.N62Click(Sender: TObject);
begin
  g_TrialRun.boTrialRun := not N62.Checked;
  TrialRun();
end;

procedure TFrmDesignMain.TrialRun();
var
  I: Integer;
begin
  if g_TrialRun.boTrialRun then begin
    g_TrialRun.boTreeVisble := TreeView1.Visible;
    g_TrialRun.boProgressBar1Visible := ProgressBarCurDownload.Visible;
    g_TrialRun.boProgressBar2Visible := ProgressBarAll.Visible; 
    g_TrialRun.nWebWidth := WebBrowser1.Width;
    if TreeView1.Visible then begin
      TreeView1.Visible := TreeView1.ShowHint;
      ComboBox1.Visible := False;
    end else if ComboBox1.Visible then begin
      ComboBox1.Visible := ComboBox1.ShowHint;
      TreeView1.Visible := False;
    end;
    if ProgressBarCurDownload.Visible then begin
      ProgressBarCurDownload.Visible := ProgressBarCurDownload.ShowHint;
      RzProgressBar1.Visible := False;
    end else if RzProgressBar1.Visible then begin
      RzProgressBar1.Visible := RzProgressBar1.ShowHint;
      ProgressBarCurDownload.Visible := False;
    end;
    if ProgressBarAll.Visible then begin
      ProgressBarAll.Visible := ProgressBarAll.ShowHint;
      RzProgressBar2.Visible := False;
    end else if RzProgressBar2.Visible then begin
      RzProgressBar2.Visible := RzProgressBar2.ShowHint;
      ProgressBarAll.Visible := False;
    end;

    MinimizeBtn.Visible := MinimizeBtn.ShowHint;
    CloseBtn.Visible := CloseBtn.ShowHint;
    StartButton.Visible := StartButton.ShowHint;
    ButtonHomePage.Visible := ButtonHomePage.ShowHint;
    RzBmpButton1.Visible := RzBmpButton1.ShowHint;
    RzBmpButton2.Visible := RzBmpButton2.ShowHint;
    ButtonNewAccount.Visible := ButtonNewAccount.ShowHint;
    ButtonChgPassword.Visible := ButtonChgPassword.ShowHint;
    ButtonGetBackPassword.Visible := ButtonGetBackPassword.ShowHint;
    ImageButtonClose.Visible := ImageButtonClose.ShowHint;

    RzCheckBox1.Visible := RzCheckBox1.ShowHint;
    RzCheckBoxFullScreen.Visible := RzCheckBoxFullScreen.ShowHint;
    RzComboBox1.Visible := RzComboBox1.ShowHint;
    RzLabelStatus.Visible := RzLabelStatus.ShowHint;

    if not WebBrowser1.ShowHint then WebBrowser1.Width := 0;

    WebBrowser1.PopupMenu := PopupMenu1;
    ProgressBarCurDownload.PopupMenu := PopupMenu1;
    ProgressBarAll.PopupMenu := PopupMenu1;
  end else begin
    TreeView1.Visible := g_TrialRun.boTreeVisble;
    ComboBox1.Visible := not g_TrialRun.boTreeVisble;
    ProgressBarCurDownload.Visible := g_TrialRun.boProgressBar1Visible;
    RzProgressBar1.Visible := not g_TrialRun.boProgressBar1Visible;
    ProgressBarAll.Visible := g_TrialRun.boProgressBar2Visible;
    RzProgressBar2.Visible := not g_TrialRun.boProgressBar2Visible;
    MinimizeBtn.Visible := True;
    CloseBtn.Visible := True;
    StartButton.Visible := True;
    ButtonHomePage.Visible := True;
    RzBmpButton1.Visible := True;
    RzBmpButton2.Visible := True;
    ButtonNewAccount.Visible := True;
    ButtonChgPassword.Visible := True;
    ButtonGetBackPassword.Visible := True;
    ImageButtonClose.Visible := True;

    RzCheckBox1.Visible := True;
    RzCheckBoxFullScreen.Visible := True;
    RzComboBox1.Visible := True;
    RzLabelStatus.Visible := True;
    WebBrowser1.Width := g_TrialRun.nWebWidth;

    WebBrowser1.PopupMenu := PopupMenuWebBrowser;
    ProgressBarCurDownload.PopupMenu := PopupMenuImageProgressBar;
    ProgressBarAll.PopupMenu := PopupMenuImageProgressBar;
  end;
  Panel2.Visible := not g_TrialRun.boTrialRun;
  if Panel2.Visible then begin
    for   I:=0 to ControlCount - 1 do begin
      TWinControl(Controls[I]).Top := TWinControl(Controls[I]).Top + Panel2.Height;
    end;
    Height := Height + Panel2.Height;
  end else begin
    for   I:=0 to ControlCount - 1 do begin
      TWinControl(Controls[I]).Top := TWinControl(Controls[I]).Top - Panel2.Height;
    end;
    Height := Height - Panel2.Height;
  end;

  AutoControl.Enabled := not g_TrialRun.boTrialRun;
  AutoControl.Target := nil;
end;

procedure TFrmDesignMain.StartButtonContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  if g_TrialRun.boTrialRun then Handled := True;
end;



procedure TFrmDesignMain.N66Click(Sender: TObject);
begin
  ColorDialog1.Color := RzComboBox1.Color;
  if ColorDialog1.Execute then begin
    RzComboBox1.Color := ColorDialog1.Color;
  end;
end;

procedure TFrmDesignMain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
