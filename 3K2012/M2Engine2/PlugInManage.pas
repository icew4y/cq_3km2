unit PlugInManage;

interface

uses
  Windows, Classes, Controls, Forms,
  StdCtrls, SDK;

type
  TftmPlugInManage = class(TForm)
    ListBoxPlugin: TListBox;
    ButtonConfig: TButton;
    procedure ListBoxPluginClick(Sender: TObject);
    procedure ButtonConfigClick(Sender: TObject);
    procedure ListBoxPluginDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    procedure RefPlugin();
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  ftmPlugInManage: TftmPlugInManage;
  StartProc: TStartProc;
implementation

uses M2Share, PlugIn;

{$R *.dfm}

procedure TftmPlugInManage.Open;
begin
  ButtonConfig.Enabled := False;
  RefPlugin();
  Self.ShowModal;
end;

procedure TftmPlugInManage.RefPlugin;
var
  I: Integer;
begin
  ListBoxPlugin.Clear;
  if PlugInEngine.m_PlugList.Count > 0 then begin//20080630
    for I := 0 to PlugInEngine.m_PlugList.Count - 1 do begin
      ListBoxPlugin.Items.AddObject(PlugInEngine.m_PlugList.Strings[I], PlugInEngine.m_PlugList.Objects[I]);
    end;
  end;
end;

procedure TftmPlugInManage.ListBoxPluginClick(Sender: TObject);
var
  Module: THandle;
begin
  try
    StartProc := nil;
    Module := pTPlugInfo(ListBoxPlugin.Items.Objects[ListBoxPlugin.ItemIndex]).Module;
    StartProc := GetProcAddress(Module, 'Config');
    if Assigned(StartProc) then ButtonConfig.Enabled := True else ButtonConfig.Enabled := False;
  except
    ButtonConfig.Enabled := False;
    StartProc := nil;
  end;
end;

procedure TftmPlugInManage.ButtonConfigClick(Sender: TObject);
begin
  if Assigned(StartProc) then TStartProc(StartProc);
end;

procedure TftmPlugInManage.ListBoxPluginDblClick(Sender: TObject);
begin
  if Assigned(StartProc) then TStartProc(StartProc);
end;

procedure TftmPlugInManage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TftmPlugInManage.FormDestroy(Sender: TObject);
begin
  ftmPlugInManage:= nil;
end;

end.
