unit LogSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, StdCtrls, ComCtrls, Buttons, DB,
  ADODB, DBGrids, Menus, Clipbrd;

type
  TLogFrm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label3: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Button1: TButton;
    ListView1: TListView;
    ADOConn: TADOConnection;
    ADOA: TADOQuery;
    PopupMenu: TPopupMenu;
    POPUPMENU_COPY: TMenuItem;
    POPUPMENU_SELALL: TMenuItem;
    N7: TMenuItem;
    POPUPMENU_SAVE: TMenuItem;
    N1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure POPUPMENU_COPYClick(Sender: TObject);
    procedure POPUPMENU_SELALLClick(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure POPUPMENU_SAVEClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
   //查询数据表
   procedure SelectTable(Str:string);
   //遍历日志文件 20080131
   Function SelectDirFile(Dir,SqlStr,Sqlstr1: String;Dt1,Dt2:Tdate):Boolean;
    { Private declarations }
  public
    StrString: String;
    { Public declarations }
  end;

type
  TLogFile = record //日志文件类
    sFileName: string;//去后缀的文件名
    sDir: string;//文件全路径
  end;
  pTLogFile = ^TLogFile;

  TQueryThread = class(TThread)//查询线程
  private
  protected
    procedure Execute;override;
  public
    SQLText:String;
    constructor Create;
    destructor  Destroy;override;
  end;

var
  LogFrm: TLogFrm;
  List:TList;
  ColumnToSort: Integer;
  QueryThread: TQueryThread;

implementation

uses LogDataMain,DM ,LDShare;

{$R *.dfm}
constructor TQueryThread.Create;
begin
  SQLText:= '';
  FreeOnTerminate:= True;
  inherited  Create(True);
end;

destructor TQueryThread.Destroy;
begin
  inherited;
end;

procedure TQueryThread.Execute;
begin
  try
    LogFrm.SelectTable(SQLText);
  except
  end;
end;


procedure TLogFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=CaFree;
end;

//遍历日志文件 20080131
Function TLogFrm.SelectDirFile(Dir,SqlStr,Sqlstr1: String;Dt1,Dt2:Tdate):Boolean;
var
  sr: TSearchRec;
  I:integer;
  StrString:string;
  LogFile:pTLogFile;

  TempItem:TListItem;
  FileName,Str1: String;
  fs:TFormatSettings;
begin
  Result:=False;
  ListView1.Clear;
  fs.ShortDateFormat:='yyyy-mm-dd';
  fs.DateSeparator:='-';
  try
    if FindFirst(dir+'*.mdb', faAnyFile, sr) = 0 then begin
      repeat
        if (sr.Attr and faDirectory)=0 then begin
          if pos('.mdb',lowercase(sr.Name)) > 0 then begin
            FileName:=ExtractFileName(ChangeFileExt(sr.Name,''));
            if (int(StrToDate(FileName, fs)) >= int(Dt1)) and (int(StrToDate(FileName, fs)) <= int(Dt2)) then begin//20110728 修改
              New(LogFile);
              LogFile.sFileName :=FileName;
              LogFile.sDir:= dir+sr.Name;
              List.Add(LogFile);//得目录下的全部文件名
            end;
          end;
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;

    for I:=0 to List.Count-1 do begin
      LogFile:= pTLogFile(List.Items[I]);
      if LogFile <> nil then begin
        ADOConn.connected:=False;
        ADOConn.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+LogFile.sDir+';Persist Security Info=False';
        ADOConn.connected:=true;

        Str1:=Trim(Combobox1.text);
        if ComboBox1.text='所有记录' then begin
          if SqlStr <> '' then
           StrString:='select 编号,动作,地图,X坐标,Y坐标,人物名称,物品名称,物品ID,记录,交易对像,'+
                      '时间 from Log where '+SqlStr+' order by 时间 DESC'
          else StrString:='select 编号,动作,地图,X坐标,Y坐标,人物名称,物品名称,物品ID,记录,交易对像,时间 from Log order by 时间 DESC'
        end else begin
        if SqlStr <> '' then
          {StrString:='select 编号,动作,地图,X坐标,Y坐标,人物名称,物品名称,物品ID,记录,交易对像,'+
                     '时间 from Log where '+Str1+' like '+''''+'%%'+Sqlstr1+'%%'+''''+' and '+SqlStr+' order by 时间' }
           StrString:='select 编号,动作,地图,X坐标,Y坐标,人物名称,物品名称,物品ID,记录,交易对像,'+
                     '时间 from Log where InStr(1,LCase('+Str1+'),LCase('+''''+Sqlstr1+''''+'),0)<>0 and '+SqlStr+' order by 时间 DESC'
          else
          {StrString:='select 编号,动作,地图,X坐标,Y坐标,人物名称,物品名称,物品ID,记录,交易对像,'+
                     '时间 from Log where '+Str1+' like '+''''+'%'+Sqlstr1+'%'+''''+' order by 时间'; }
          {StrString:='select 编号,动作,地图,X坐标,Y坐标,人物名称,物品名称,物品ID,记录,交易对像,'+
                     '时间 from Log where '+Str1+' ='+''''+Sqlstr1+''''+' order by 时间'; }
          StrString:='select 编号,动作,地图,X坐标,Y坐标,人物名称,物品名称,物品ID,记录,交易对像,'+
                     '时间 from Log where InStr(1,LCase('+Str1+'),LCase('+''''+Sqlstr1+''''+'),0)<>0 order by 时间 DESC';

        end;
        ADOA.close;
        ADOA.sql.Clear;
        ADOA.sql.Add(StrString);
        ADOA.Open;
        if ADOA.RecordCount > 0 then begin
          ADOA.First;
          while not ADOA.Eof do begin
            TempItem:=ListView1.Items.Add;
            with TempItem do begin
              Caption:=ADOA.fieldbyName('编号').AsString;
              SubItems.Add(ADOA.fieldbyName('动作').AsString);
              SubItems.Add(ADOA.fieldbyName('地图').AsString);
              SubItems.Add( ADOA.fieldbyName('X坐标').AsString);
              SubItems.Add( ADOA.fieldbyName('Y坐标').AsString);
              SubItems.Add( ADOA.fieldbyName('人物名称').AsString);
              SubItems.Add( ADOA.fieldbyName('物品名称').AsString);
              SubItems.Add( ADOA.fieldbyName('物品ID').AsString);
              SubItems.Add( ADOA.fieldbyName('记录').AsString);
              SubItems.Add( ADOA.fieldbyName('交易对像').AsString);
              SubItems.Add(ADOA.fieldbyName('时间').AsString );
            end;
            ADOA.Next;
          end;
        end;
        Result:=True;
      end;
    end; //for I:=0 to List.Count-1 do
  except
    Result:=True;
  end;
  if List.Count > 0 then begin
    for I:=0 to List.Count - 1 do begin
      if pTLogFile(List.Items[I]) <> nil then Dispose(pTLogFile(List.Items[I]));
    end;
    List.Clear;
  end;  
end;

//查询数据表
procedure TLogFrm.SelectTable(Str:string);
var Str2:string;
begin
  //设置动作条件
  case ComboBox2.ItemIndex of
     0:Str2:='';//全部动作
     1:Str2:=' 动作='+''''+'取回物品'+'''';//取回物品
     2:Str2:=' 动作='+''''+'存放物品'+'''';//存放物品
     3:Str2:=' 动作='+''''+'炼制药品'+'''';//炼制药品
     4:Str2:=' 动作='+''''+'持久消失'+'''';//持久消失
     5:Str2:=' 动作='+''''+'捡起物品'+'''';//捡起物品
     6:Str2:=' 动作='+''''+'制造物品'+'''';//制造物品
     7:Str2:=' 动作='+''''+'毁掉物品'+'''';//毁掉物品
     8:Str2:=' 动作='+''''+'扔掉物品'+'''';//扔掉物品
     9:Str2:=' 动作='+''''+'交易物品'+'''';//交易物品
     10:Str2:=' 动作='+''''+'购买物品'+''''; //购买物品
     11:Str2:=' 动作='+''''+'出售物品'+'''';//出售物品
     12:Str2:=' 动作='+''''+'使用物品'+'''';//使用物品
     13:Str2:=' 动作='+''''+'人物升级'+'''';//人物升级
     14:Str2:=' 动作='+''''+'减少金币'+'''';//减少金币
     15:Str2:=' 动作='+''''+'增加金币'+'''';//增加金币
     16:Str2:=' 动作='+''''+'死亡掉落'+'''';//死亡掉落
     17:Str2:=' 动作='+''''+'掉落物品'+'''';//掉落物品
     18:Str2:=' 动作='+''''+'等级调整'+'''';//等级调整
     19:Str2:=' 动作='+''''+'人物死亡'+'''';//人物死亡
     20:Str2:=' 动作='+''''+'升级成功'+'''';//升级成功
     21:Str2:=' 动作='+''''+'升级失败'+'''';//升级失败
     22:Str2:=' 动作='+''''+'城堡取钱'+'''';//城堡取钱
     23:Str2:=' 动作='+''''+'城堡存钱'+'''';//城堡存钱
     24:Str2:=' 动作='+''''+'升级取回'+'''';//升级取回
     25:Str2:=' 动作='+''''+'武器升级'+'''';//武器升级
     26:Str2:=' 动作='+''''+'背包减少'+'''';//背包减少
     27:Str2:=' 动作='+''''+'改变城主'+'''';//改变城主
     28:Str2:=' 动作='+''''+'元宝改变'+'''';//元宝改变
     29:Str2:=' 动作='+''''+'能量改变'+'''';//能量改变
     30:Str2:=' 动作='+''''+'商铺购买'+'''';//商铺购买
     31:Str2:=' 动作='+''''+'装备升级'+'''';//装备升级
     32:Str2:=' 动作='+''''+'寄售物品'+'''';//寄售物品
     33:Str2:=' 动作='+''''+'寄售购买'+'''';//寄售购买
     34:Str2:=' 动作='+''''+'个人商店'+'''';//个人商店
     35:Str2:=' 动作='+''''+'行会酒泉'+'''';//行会酒泉
     36:Str2:=' 动作='+''''+'挑战物品'+'''';//挑战物品
     37:Str2:=' 动作='+''''+'挖人形怪'+'''';//挖人形怪
     38:Str2:=' 动作='+''''+'NPC 酿酒'+'''';
     39:Str2:=' 动作='+''''+'游戏点改变'+'''';
     40:Str2:=' 动作='+''''+'获得矿石'+'''';
     41:Str2:=' 动作='+''''+'开启宝箱'+'''';
     42:Str2:=' 动作='+''''+'粹练物品'+'''';
     43:Str2:=' 动作='+''''+'拆分物品'+'''';
     44:Str2:=' 动作='+''''+'合并物品'+'''';
     45:Str2:=' 动作='+''''+'锻炼物品'+'''';
     46:Str2:=' 动作='+''''+'金刚石改变'+'''';
     47:Str2:=' 动作='+''''+'灵符改变'+'''';
     48:Str2:=' 动作='+''''+'荣誉改变'+'''';
     49:Str2:=' 动作='+''''+'高级鉴定'+'''';
     50:Str2:=' 动作='+''''+'挖取宝物'+'''';
  end;
  //遍历文件,并把数据写入临时表 20080131
  if SelectDirFile(sBaseDir,Str2,Str,DateTimePicker1.Date,DateTimePicker2.Date) then begin
     Button1.Enabled:=True;
  end;
end;

procedure TLogFrm.FormShow(Sender: TObject);
begin
  ComboBox1.ItemIndex:=0;
  ComboBox2.ItemIndex:=0;
  DateTimePicker1.Date:=Date();
  DateTimePicker2.Date:=Date();
end;

procedure TLogFrm.ComboBox1Click(Sender: TObject);
begin
  if ComboBox1.text='所有记录' then begin
    Edit1.Text:='*';
    Edit1.ReadOnly:=True;
    Edit1.Font.Color:=cl3DLight;
  end else begin
    Edit1.Text:='';
    Edit1.ReadOnly:=False;
    Edit1.Font.Color:=clWindowText;
  end;
end;

procedure TLogFrm.Button1Click(Sender: TObject);
begin
  Button1.Enabled:=False;
  if Trim(Edit1.text)='' then
  begin
    Application.MessageBox('注意:请输入查询内容！','提示信息',MB_ICONQUESTION+MB_OK);
    Button1.Enabled:=True;
    exit;
  end;
  //SelectTable(Trim(Edit1.text));//20080928 注释,使用线程来查询数据
  Try
    QueryThread:= TQueryThread.Create;
    QueryThread.SQLText:= Trim(Edit1.text);
    QueryThread.Resume;
  except
    Button1.Enabled:=True;
  end;
end;

procedure TLogFrm.FormCreate(Sender: TObject);
begin
  List:=TList.Create;
end;

procedure TLogFrm.ListView1Compare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  ix: Integer;
begin
  if ColumnToSort = 0 then
    Compare := CompareText(Item1.Caption,Item2.Caption)
  else begin
   ix := ColumnToSort - 1;
   Compare := CompareText(Item1.SubItems[ix],Item2.SubItems[ix]);
  end;
end;

procedure TLogFrm.ListView1ColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  if not Button1.Enabled then Exit;
   ColumnToSort := Column.Index;
  (Sender as TCustomListView).AlphaSort;
end;

procedure TLogFrm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var I: Integer;
begin
  for I:=0 to List.Count - 1 do begin
    if pTLogFile(List.Items[I]) <> nil then Dispose(pTLogFile(List.Items[I]));
  end;
  List.Free;
  LogFrm:= nil;
end;


procedure TLogFrm.FormDestroy(Sender: TObject);
begin
  LogFrm:= nil;
end;

procedure TLogFrm.POPUPMENU_COPYClick(Sender: TObject);
var
  ListItem :TListItem;
begin
  ListItem := ListView1.Selected;
  if ListItem <> nil then begin
    Clipbrd.Clipboard.AsText := ListItem.SubItems.Strings[4];
  end;
end;

procedure TLogFrm.POPUPMENU_SELALLClick(Sender: TObject);
var
  ListItem :TListItem;
begin
  ListItem := ListView1.Selected;
  if ListItem <> nil then begin
    Clipbrd.Clipboard.AsText := ListItem.SubItems.Strings[5];
  end;
end;

procedure TLogFrm.N7Click(Sender: TObject);
var
  ListItem :TListItem;
begin
  ListItem := ListView1.Selected;
  if ListItem <> nil then begin
    Clipbrd.Clipboard.AsText := ListItem.SubItems.Strings[6];
  end;
end;

procedure TLogFrm.POPUPMENU_SAVEClick(Sender: TObject);
var
  ListItem :TListItem;
begin
  ListItem := ListView1.Selected;
  if ListItem <> nil then begin
    Clipbrd.Clipboard.AsText := ListItem.SubItems.Strings[8];
  end;
end;

procedure TLogFrm.N1Click(Sender: TObject);
var
  ListItem :TListItem;
begin
  ListItem := ListView1.Selected;
  if ListItem <> nil then begin
    Clipbrd.Clipboard.AsText := ListItem.Caption + ' ' + ListItem.SubItems.Strings[0] + ' ' + ListItem.SubItems.Strings[1] + ' ' + ListItem.SubItems.Strings[2] + ' ' +
                                ListItem.SubItems.Strings[3] + ' ' + ListItem.SubItems.Strings[4] + ' ' + ListItem.SubItems.Strings[5] + ' ' + ListItem.SubItems.Strings[6]+ ' ' +
                                ListItem.SubItems.Strings[7] + ' ' + ListItem.SubItems.Strings[8] + ' ' + ListItem.SubItems.Strings[9];
  end;
end;

end.
