unit HumanOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ComCtrls, IniFiles,HUtil32{20080220},DBShare,
  ExtCtrls;

type
  THumanOrderFrm = class(TForm)
    GroupBox1: TGroupBox;
    boAutoSort: TCheckBox;
    Label10: TLabel;
    SortLevel: TSpinEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    SpinEdit4: TSpinEdit;
    Label1: TLabel;
    SpinEdit2: TSpinEdit;
    Label3: TLabel;
    SpinEdit3: TSpinEdit;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    PageControl3: TPageControl;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    ListView1: TListView;
    ListView2: TListView;
    ListView3: TListView;
    ListView4: TListView;
    PageControl5: TPageControl;
    TabSheet16: TTabSheet;
    ListView5: TListView;
    TabSheet17: TTabSheet;
    ListView6: TListView;
    TabSheet18: TTabSheet;
    ListView7: TListView;
    TabSheet19: TTabSheet;
    ListView8: TListView;
    ListView9: TListView;
    ListView10: TListView;
    ListView11: TListView;
    ListView12: TListView;
    Label5: TLabel;
    ProgressBar1: TProgressBar;
    Label6: TLabel;
    SpinEdit5: TSpinEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure boAutoSortClick(Sender: TObject);
    procedure SortLevelChange(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SpinEdit5Change(Sender: TObject);
  private
    { Private declarations }
    procedure ModValue();
    procedure uModValue();
    //procedure LoadHumanOrder; //∂¡»°≈≈––∞Ò 20080220;
  public
    { Public declarations }
  end;

var
  HumanOrderFrm: THumanOrderFrm;

implementation
uses  Grobal2, HumDB, ThreadOrders;

{$R *.dfm}

procedure THumanOrderFrm.ModValue();
begin
  Button1.Enabled := True;
end;

procedure THumanOrderFrm.uModValue();
begin
  Button1.Enabled := False;
end;

procedure THumanOrderFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure THumanOrderFrm.FormDestroy(Sender: TObject);
begin
  HumanOrderFrm:= nil;
end;

procedure THumanOrderFrm.FormShow(Sender: TObject);
begin
  PageControl1.TabIndex:=0;
  PageControl2.TabIndex:=0;
  PageControl1Change(Nil);
  boAutoSort.Checked:= m_boAutoSort;
  SortLevel.Value := nSortLevel;
  SpinEdit5.Value := nSortMaxLevel;
  SpinEdit1.Value := nSortHour;
  SpinEdit4.Value := nSortMinute;
  SpinEdit2.Value := nSortHour;
  SpinEdit3.Value := nSortMinute;
  case nSortClass of
    0: RadioButton2.Checked:= True;
    1: RadioButton1.Checked:= True;
  end;

  uModValue();
end;

procedure THumanOrderFrm.Button1Click(Sender: TObject);
var
  Config: TIniFile;
begin
  Config := TIniFile.Create(sConfFileName);
  if Config <> nil then begin
    Config.WriteBool('Setup', 'AutoSort', m_boAutoSort);
    Config.WriteInteger('Setup', 'SortClass', nSortClass);
    Config.WriteInteger('Setup', 'SortHour', nSortHour);
    Config.WriteInteger('Setup', 'SortMinute', nSortMinute);
    Config.WriteInteger('Setup', 'SortLevel', nSortLevel);
    Config.WriteInteger('Setup', 'SortMaxLevel', nSortMaxLevel);
    uModValue();
    Config.Free;
  end;
end;

procedure THumanOrderFrm.boAutoSortClick(Sender: TObject);
begin
  m_boAutoSort := boAutoSort.Checked;
  ModValue();
end;

procedure THumanOrderFrm.SortLevelChange(Sender: TObject);
begin
  nSortLevel := SortLevel.Value;
  ModValue();
end;

procedure THumanOrderFrm.RadioButton2Click(Sender: TObject);
begin
  if RadioButton2.Checked then nSortClass := 0;
  ModValue();
end;

procedure THumanOrderFrm.RadioButton1Click(Sender: TObject);
begin
  if RadioButton1.Checked then nSortClass := 1;
  ModValue();
end;

procedure THumanOrderFrm.SpinEdit2Change(Sender: TObject);
begin
  if not RadioButton2.Checked then Exit;
  nSortHour:= SpinEdit2.Value ;
  ModValue();
end;

procedure THumanOrderFrm.SpinEdit3Change(Sender: TObject);
begin
  if not RadioButton2.Checked then Exit;
  nSortMinute:= SpinEdit3.Value ;
  ModValue();
end;

procedure THumanOrderFrm.SpinEdit1Change(Sender: TObject);
begin
  if not RadioButton1.Checked then Exit;
  nSortHour:= SpinEdit1.Value ;
  ModValue();
end;

procedure THumanOrderFrm.SpinEdit4Change(Sender: TObject);
begin
  if not RadioButton1.Checked then Exit;
  nSortMinute:= SpinEdit4.Value ;
  ModValue();
end;

procedure THumanOrderFrm.Button2Click(Sender: TObject);
var
  Taxis:TThreadOrders;
begin
  try
    Button2.Enabled:=False;
    Taxis:=TThreadOrders.Create(sHumDBFilePath,True);
    Taxis.Execute;
    Taxis.Free;
    PageControl1.Enabled:=False;
    PageControl1Change(nil);
    Button2.Enabled:=True;
    PageControl1.Enabled:=True;
  except
    if boViewHackMsg then MainOutMessage('[“Ï≥£] THumanOrderFrm.Button2Click');
  end;
end;

procedure THumanOrderFrm.PageControl1Change(Sender: TObject);

  procedure ShowList(List:TListView;Taxis:THumSort);
  var
    i:integer;
    Temp:TListItem;
  begin
    if Taxis.nMaxIdx <= 0 then Exit;
    for I:=0 to Taxis.nMaxIdx-1 do begin
      Temp:=List.Items.Add;
      Temp.Caption:=IntToStr(Taxis.List[I].nIndex);
      Temp.SubItems.Add(Taxis.List[I].sChrName);
      Temp.SubItems.Add(IntToStr(Taxis.List[I].wLevel));
      Temp.SubItems.Add(IntToStr(Taxis.List[I].nHeartLevel));
    end;
  end;
  procedure ShowHeroList(List:TListView;Taxis:THeroSort);
  var
    i:integer;
    Temp:TListItem;
  begin
    if Taxis.nMaxIdx <= 0 then Exit;
    for I:=0 to Taxis.nMaxIdx-1 do begin
      Temp:=List.Items.Add;
      Temp.Caption:=IntToStr(Taxis.List[I].nIndex);
      Temp.SubItems.Add(Taxis.List[I].sHeroName);
      Temp.SubItems.Add(Taxis.List[I].sChrName);
      Temp.SubItems.Add(IntToStr(Taxis.List[I].wLevel));
    end;
  end;
begin
  ListView1.Visible:=False;
  ListView2.Visible:=False;
  ListView3.Visible:=False;
  ListView4.Visible:=False;
  ListView7.Visible:=False;
  ListView9.Visible:=False;
  ListView10.Visible:=False;
  ListView11.Visible:=False;
  ListView12.Visible:=False;
  ListView1.Items.Clear;
  ListView2.Items.Clear;
  ListView3.Items.Clear;
  ListView4.Items.Clear;
  ListView7.Items.Clear;
  ListView9.Items.Clear;
  ListView10.Items.Clear;
  ListView11.Items.Clear;
  ListView12.Items.Clear;
  case PageControl1.TabIndex of
    0 : begin
      case PageControl2.TabIndex of
        0: ShowList(ListView1,g_TaxisAllList);
        1: ShowList(ListView2,g_TaxisWarrList);
        2: ShowList(ListView3,g_TaxisWaidList);
        3: ShowList(ListView4,g_TaxisTaosList);
      end;
    end;
    1 : begin
      case PageControl3.TabIndex of
        0: ShowHeroList(ListView7,g_HeroAllList);
        1: ShowHeroList(ListView9,g_HeroWarrList);
        2: ShowHeroList(ListView10,g_HeroWaidList);
        3: ShowHeroList(ListView11,g_HeroTaosList);
      end;
    end;
    2 : begin
      ShowList(ListView12,g_MasterList);
    end;
  end;
  ListView1.Visible:=True;
  ListView2.Visible:=True;
  ListView3.Visible:=True;
  ListView4.Visible:=True;
  ListView7.Visible:=True;
  ListView9.Visible:=True;
  ListView10.Visible:=True;
  ListView11.Visible:=True;
  ListView12.Visible:=True;
end;

procedure THumanOrderFrm.SpinEdit5Change(Sender: TObject);
begin
  nSortMaxLevel := SpinEdit5.Value;
  ModValue();
end;

end.
