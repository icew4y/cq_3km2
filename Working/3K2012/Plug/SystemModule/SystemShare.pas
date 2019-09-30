unit SystemShare;

interface
const
  Mode1 = 1;//免杀段1
  Mode2 = 1;//免杀段2
  Mode3 = 1;//免杀段3
  Mode4 = 1;//免杀段4
  Mode5 = 1;//免杀段5
  Mode6 = 1;//免杀段6
  Mode7 = 1;//免杀段7
  Mode8 = 1;//免杀段8
  Mode42 = 1;//免杀段
  Mode43 = 1;//免杀段 删除注册表-特征
  sLoadPlug        = '加载【3K科技 系统模块】';
  sLoadPlugSucceed = '【3K科技 系统模块】启动成功';
  sLoadPlugFail    = '【3K科技 系统模块】启动失败';
  sUnLoadPlug      = '卸载【3K科技 系统模块】成功';
  s108 ='0XPH84sD1QNHRNR7jViS3c9FvlE='; //2013-12-31 限制使用的日期(0627) \Plug\SystemModule\EDoceInfo.exe
  UserMode1 = 1;//用户模式 0-免费 1-限制使用天数(0627、176)  2-绑定IP(连击) 与M2模式对应
{$IF UserMode1 = 1}
  sPlugName        = '【3K科技 系统模块0627】(2012/12/18)';
{$ELSE}
  sPlugName        = '【3K科技 系统模块】(2012/12/18)';
{$IFEND}
 TESTMODE = 0;//是否是测试,1-测试 0-正式
 //查找 function Init, 通过MainOutMessasge('M2 CRC:'+inttostr(CalcFileCRC(Application.Exename)), 0); 取得CRC值
 nCode: Integer = -925969484;//////////M2程序CRCA   0627(-98533354)  176(-1440222524)  连击(-379373253)
 procedure LaJiDaiMa(aint : Integer = 111; bint: Integer = 222; c : Single = 0.14);
implementation
procedure LaJiDaiMa(aint : Integer = 111; bint: Integer = 222; c : Single = 0.14);
begin
  if (aint > 0) then
    aint :=  bint + 1;
end;

end.
