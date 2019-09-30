program DBServer;

uses
  Forms,
  viewrcd in 'viewrcd.pas' {FrmFDBViewer},
  newchr in 'newchr.pas' {FrmNewChr},
  frmcpyrcd in 'frmcpyrcd.pas' {FrmCopyRcd},
  CreateId in 'CreateId.pas' {FrmCreateId},
  CreateChr in 'CreateChr.pas' {FrmCreateChr},
  FIDHum in 'FIDHum.pas' {FrmIDHum},
  IDSocCli in 'IDSocCli.pas' {FrmIDSoc},
  UsrSoc in 'UsrSoc.pas' {FrmUserSoc},
  FDBexpl in 'FDBexpl.pas' {FrmFDBExplore},
  AddrEdit in 'AddrEdit.pas' {FrmEditAddr},
  DBSMain in 'DBSMain.pas' {FrmDBSrv},
  HumDB in 'HumDB.pas',
  DBShare in 'DBShare.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  MudUtil in '..\Common\MudUtil.pas',
  Common in '..\Common\Common.pas',
  DBTools in 'DBTools.pas' {frmDBTool},
  EDCode in '..\Common\EDCode.pas',
  EditRcd in 'EditRcd.pas' {frmEditRcd},
  TestSelGate in 'TestSelGate.pas' {frmTestSelGate},
  RouteManage in 'RouteManage.pas' {frmRouteManage},
  RouteEdit in 'RouteEdit.pas' {frmRouteEdit},
  HumanOrder in 'HumanOrder.pas' {HumanOrderFrm},
  SetDisableList in 'SetDisableList.pas' {SetDisableListFrm},
  AboutUnit in 'AboutUnit.pas' {FrmAbout},
  DenyChrName in 'DenyChrName.pas' {DenyChrNameFrm},
  ThreadOrders in 'ThreadOrders.pas',
  GrobalSession in 'GrobalSession.pas' {frmGrobalSession};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmDBSrv, FrmDBSrv);
  Application.CreateForm(TFrmFDBViewer, FrmFDBViewer);
  Application.CreateForm(TFrmNewChr, FrmNewChr);
  Application.CreateForm(TFrmCopyRcd, FrmCopyRcd);
  Application.CreateForm(TFrmCreateId, FrmCreateId);
  Application.CreateForm(TFrmCreateChr, FrmCreateChr);
  Application.CreateForm(TFrmIDHum, FrmIDHum);
  Application.CreateForm(TFrmIDSoc, FrmIDSoc);
  Application.CreateForm(TFrmUserSoc, FrmUserSoc);
  Application.CreateForm(TFrmFDBExplore, FrmFDBExplore);
  Application.CreateForm(TFrmCreateChr, FrmCreateChr);
  Application.CreateForm(TFrmEditAddr, FrmEditAddr);
  Application.CreateForm(TfrmDBTool, frmDBTool);
  Application.CreateForm(TfrmEditRcd, frmEditRcd);
  Application.CreateForm(TfrmRouteManage, frmRouteManage);
  Application.CreateForm(TfrmRouteEdit, frmRouteEdit);
  Application.CreateForm(TFrmAbout, FrmAbout);
  Application.Run;
end.
