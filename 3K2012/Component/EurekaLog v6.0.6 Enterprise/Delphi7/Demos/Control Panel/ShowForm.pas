unit ShowForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CtlPanel;

type
  TApplet = class(TAppletModule)
    procedure AppletModuleActivate(Sender: TObject; Data: Integer);
  private
  { private declarations }
  protected
  { protected declarations }
  public
  { public declarations }
  end;

var
  Applet: TApplet;

implementation

{$R *.DFM}

uses MainPanel;

procedure TApplet.AppletModuleActivate(Sender: TObject; Data: Integer);
begin
  MainForm := TMainForm.Create(nil);
  MainForm.ShowModal;
  MainForm.Free;
end;

end.