unit PlugOfEngine;

interface
uses MShare,actor;
procedure TPlugOfEngine_ClickBox(Click:Boolean;TabOrder:Integer);stdcall;
implementation
procedure TPlugOfEngine_ClickBox(Click:Boolean;TabOrder:Integer);
begin
case TabOrder of
  0:if Click then g_boShowRedHPLable := True else g_boShowRedHPLable:= False;//血条
  1:if Click then {g_boShowHPNumber := True else g_boShowHPNumber:= False;}//显示队员
end;
end;

end.
