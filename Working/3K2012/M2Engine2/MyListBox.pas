unit MyListBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  ComCtrls, StdCtrls, ExtCtrls;
type
  TMyListBox = class(TListBox)
  private
    FOnSelect: TNotifyEvent;
    procedure DoOnSelect;
  protected
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  published
    property OnSelect: TNotifyEvent read FOnSelect write FOnSelect;
  end;
procedure Register;
implementation

procedure Register;
begin
  RegisterComponents('MyListBox', [TMyListBox]);
end;

procedure TMyListBox.CNCommand(var Message: TWMCommand);
begin
  inherited;
  if Message.NotifyCode = LBN_SELCHANGE then
    DoOnSelect();
 { case Message.NotifyCode of
    LBN_SELCHANGE:
      begin
        inherited Changed;
        Click;
      end;
    LBN_DBLCLK: DblClick;
  end; }
end;

procedure TMyListBox.DoOnSelect;
begin
  if Assigned(FOnSelect) then FOnSelect(Self);
end;

end.

