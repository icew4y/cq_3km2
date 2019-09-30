unit ERecord;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TFrmRecord = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    cboItem: TComboBox;
    Editfind: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ListView1: TListView;
    PopupMenu1: TPopupMenu;
    cc1: TMenuItem;
    ccccc1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    imglstData: TImageList;
    imglstBigData: TImageList;
    procedure ListView1CustomDraw(Sender: TCustomListView;
      const ARect: TRect; var DefaultDraw: Boolean);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
  end;

var
  FrmRecord: TFrmRecord;

implementation

{$R *.dfm}

procedure TFrmRecord.ListView1CustomDraw(Sender: TCustomListView;
  const ARect: TRect; var DefaultDraw: Boolean);
var
  x,y:integer;
  str1,str2:string;
begin
  str1:='使用鼠标双击查看详细资料.';
  str2:='没有数据可以显示．';
  Listview1.Canvas.Font.Color :=clBtnFace;
  y:=round(Listview1.Height/2);
  if Listview1.Items.Count >0 then
  begin
    x:=round(Listview1.Width /2)-Length(str1)*3;
    Listview1.Canvas.TextOut(x,y,str1);
  end
  else
  begin
    x:=round(ListView1.Width /2)-Length(str2)*3;
    ListView1.Canvas.TextOut(x,y,str2);
  end;
  ListView1.Canvas.Refresh;
end;

procedure TFrmRecord.Open;
begin
  ShowModal;
end;

procedure TFrmRecord.N3Click(Sender: TObject);
begin
  ListView1.ViewStyle :=vsIcon;
end;

procedure TFrmRecord.N4Click(Sender: TObject);
begin
  ListView1.ViewStyle :=vsSmallIcon;
end;

procedure TFrmRecord.N5Click(Sender: TObject);
begin
  ListView1.ViewStyle :=vsList;
end;

procedure TFrmRecord.N7Click(Sender: TObject);
begin
  ListView1.ViewStyle :=vsReport;
end;

end.
