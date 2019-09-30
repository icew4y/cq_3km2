unit LDShare;

interface
uses
  Windows,Messages,SysUtils;
var
  sBaseDir       :String = '.\LogBase';
  sServerName    :String = '传奇';
  sCaption       :String = '3K科技引擎日志服务器';

  nServerPort    :Integer = 10000;
  g_dwGameCenterHandle:THandle;
const
  g_sProductName = 'DFC05A36DBCBB96B320C77276A0E2EB98BC9ED2FECE443BB'; //3K科技日志记录程序
  g_sVersion = '593322ECC998964C2F344FC7EADF5DF9C5C3C9374D92394E';  //2.00 Build 20110129
  g_sUpDateTime = '75C2CAC77285616BCF3ABB7DBC68FB4D'; //2011/01/29
  g_sProgram = 'BF329B13CBE9010C601B4C1E88011620'; //3K科技
  g_sWebSite = '92A51ADA62A0738AC5DB86D6E7E9CDE140574B5A981AB1753188062D144466D7'; //http://www.3KM2.com(官网站)
  g_sBbsSite = '6136601E4431B32C60BFBF8207DB95FA40574B5A981AB1753188062D144466D7'; //http://www.3KM2.net(程序站)

  tLogServer=2;
  procedure SendGameCenterMsg(wIdent:Word;sSendMsg:String);
implementation

uses Grobal2, HUtil32;
procedure SendGameCenterMsg(wIdent:Word;sSendMsg:String);
var
  SendData:TCopyDataStruct;
  nParam:Integer;
begin
  nParam:=MakeLong(Word(tLogServer),wIdent);
  SendData.cbData:=Length (sSendMsg) + 1;
  GetMem(SendData.lpData,SendData.cbData);
  StrCopy (SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle,WM_COPYDATA,nParam,Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;

end.
