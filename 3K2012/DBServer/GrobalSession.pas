unit GrobalSession;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls;

type
  TfrmGrobalSession = class(TForm)
    ButtonRefGrid: TButton;
    PanelStatus: TPanel;
    GridSession: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure ButtonRefGridClick(Sender: TObject);
  private
    procedure RefGridSession();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmGrobalSession: TfrmGrobalSession;

implementation

uses DBShare, Grobal2;

{$R *.dfm}
{ TfrmGrobalSession }

procedure TfrmGrobalSession.ButtonRefGridClick(Sender: TObject);
begin
  RefGridSession;
end;

procedure TfrmGrobalSession.FormCreate(Sender: TObject);
begin
  GridSession.Cells[0, 0] := '序号';
  GridSession.Cells[1, 0] := '登录帐号';
  GridSession.Cells[2, 0] := '登录角色';
  GridSession.Cells[3, 0] := '登录地址';
  GridSession.Cells[4, 0] := '会话ID';
  GridSession.Cells[5, 0] := '开始游戏';
end;

procedure TfrmGrobalSession.Open;
begin
  RefGridSession();
  ShowModal;
end;

procedure TfrmGrobalSession.RefGridSession;
var
  I: Integer;
  GlobaSessionInfo: pTGlobaSessionInfo;
begin
  PanelStatus.Caption := '正在取得数据...';
  GridSession.Visible := False;
  GridSession.Cells[0, 1] := '';
  GridSession.Cells[1, 1] := '';
  GridSession.Cells[2, 1] := '';
  GridSession.Cells[3, 1] := '';
  GridSession.Cells[4, 1] := '';
  GridSession.Cells[5, 1] := '';
  //Config.SessionList.Lock;
  try
    if g_GlobaSessionList.Count <= 0 then begin
      GridSession.RowCount := 2;
      GridSession.FixedRows := 1;
    end else begin
      GridSession.RowCount := g_GlobaSessionList.Count + 1;
    end;
    for I := 0 to g_GlobaSessionList.Count - 1 do begin
      GlobaSessionInfo := g_GlobaSessionList.Items[I];
      GridSession.Cells[0, I + 1] := IntToStr(I);
      GridSession.Cells[1, I + 1] := GlobaSessionInfo.sAccount;
      GridSession.Cells[2, I + 1] := GlobaSessionInfo.sSelChrName;
      GridSession.Cells[3, I + 1] := GlobaSessionInfo.sIPaddr;
      GridSession.Cells[4, I + 1] := IntToStr(GlobaSessionInfo.nSessionID);
      GridSession.Cells[5, I + 1] := BoolToStr(GlobaSessionInfo.boStartPlay);
    end;
  finally
    //Config.SessionList.UnLock;
  end;
  GridSession.Visible := true;
end;

end.
