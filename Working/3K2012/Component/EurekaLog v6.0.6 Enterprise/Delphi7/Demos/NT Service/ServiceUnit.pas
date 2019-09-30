unit ServiceUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs;

type
  TEurekaLogService = class(TService)
    procedure ServiceExecute(Sender: TService);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  EurekaLogService: TEurekaLogService;

implementation

{$R *.DFM}

uses MainService;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  EurekaLogService.Controller(CtrlCode);
end;

function TEurekaLogService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TEurekaLogService.ServiceExecute(Sender: TService);
begin
  MainForm := TMainForm.Create (nil);
  MainForm.ShowModal;
  MainForm.Free;
end;

end.
