unit DBTools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, ComCtrls;

type
  TFrmDBTools = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    GridIDDBInfo: TStringGrid;
    TabSheet2: TTabSheet;
    LabelProcess: TLabel;
    ButtonStartRebuild: TButton;
    TimerShowInfo: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonStartRebuildClick(Sender: TObject);
    procedure TimerShowInfoTimer(Sender: TObject);
  private
    procedure RefDBInfo;
    { Private declarations }
  public
    { Public declarations }
  end;

  TBuildDB = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

var
  FrmDBTools: TFrmDBTools;

implementation

uses IDDB, LSShare, Grobal2;
var
  boRebuilding: Boolean = False;
  BuildDB: TBuildDB;
  nProcID: Integer;
  nProcMax: Integer;
{$R *.dfm}

procedure TfrmDBTools.RefDBInfo;
begin
{$IF IDMODE = 0}
  try
    if AccountDB.OpenEx then begin
      GridIDDBInfo.Cells[1, 1] := AccountDB.m_sDBFileName;
      GridIDDBInfo.Cells[1, 2] := AccountDB.m_Header.sDesc;
      GridIDDBInfo.Cells[1, 3] := IntToStr(AccountDB.m_Header.nIDCount);
      GridIDDBInfo.Cells[1, 4] := IntToStr(AccountDB.m_QuickList.Count);
      GridIDDBInfo.Cells[1, 5] := DateTimeToStr(AccountDB.m_Header.dUpdateDate);
    end;
  finally
    AccountDB.Close();
  end;
{$IFEND}
end;


procedure TFrmDBTools.FormShow(Sender: TObject);
begin
  RefDBInfo;
end;

procedure TFrmDBTools.FormCreate(Sender: TObject);
begin
  GridIDDBInfo.Cells[0, 0] := '参数';
  GridIDDBInfo.Cells[1, 0] := '内容';
  GridIDDBInfo.Cells[0, 1] := '文件位置';
  GridIDDBInfo.Cells[0, 2] := '文件标识';
  GridIDDBInfo.Cells[0, 3] := '记录总数';
  GridIDDBInfo.Cells[0, 4] := '有效数量';
  GridIDDBInfo.Cells[0, 5] := '更新日期';
end;


{ TBuildDB }

procedure TBuildDB.Execute;
var
  i: Integer;
  NewIDDB: TFileIDDB;
  sDBFile: string;
  DBRecord,DBRecord2: TAccountDBRecord;
begin
{$IF IDMODE = 0}
  sDBFile := g_Config.sIdDir + 'NewID.DB';
  if FileExists(sDBFile) then DeleteFile(sDBFile);

  NewIDDB := TFileIDDB.Create(sDBFile);
  try
    if AccountDB.Open then begin
      nProcID := 0;
      nProcMax := AccountDB.m_QuickList.Count - 1;
      for I := 0 to AccountDB.m_QuickList.Count - 1 do begin
        nProcID := I;
        if (AccountDB.Get(I, DBRecord) < 0)  then Continue;
         NewIDDB.Lock;
          try
            if NewIDDB.Index(DBRecord.Header.sAccount) >= 0 then Continue;
          finally
            NewIDDB.UnLock;
          end;
          FillChar(DBRecord2, SizeOf(TAccountDBRecord), #0);
          try
            if NewIDDB.Open then begin
              DBRecord2.Header:= DBRecord.Header;
              DBRecord2.UserEntry:= DBRecord.UserEntry;
              DBRecord2.UserEntryAdd:= DBRecord.UserEntryAdd;
              DBRecord2.nErrorCount:= DBRecord.nErrorCount;
              DBRecord2.dwActionTick:= DBRecord.dwActionTick;
              DBRecord2.N:= DBRecord.N;
              NewIDDB.Add(DBRecord2);
            end;
          finally
            NewIDDB.Close;
          end;
      end;//for i := 0 to AccountDB.m_QuickList.Count - 1 do begin
    end;
  finally
    AccountDB.Close;
  end;
  NewIDDB.Free;
  boRebuilding := False;
{$IFEND}   
end;

procedure TFrmDBTools.ButtonStartRebuildClick(Sender: TObject);
begin
  boRebuilding := True;
  BuildDB := TBuildDB.Create(False);
  BuildDB.FreeOnTerminate := True;
  TimerShowInfo.Enabled := True;
end;

procedure TFrmDBTools.TimerShowInfoTimer(Sender: TObject);
begin
  LabelProcess.Caption := IntToStr(nProcID) + '/' + IntToStr(nProcMax);
  if not boRebuilding then begin
    TimerShowInfo.Enabled := False;
    LabelProcess.Caption := '完成！！！';
    ShowMessage('完成！！！');
  end;
end;

end.
