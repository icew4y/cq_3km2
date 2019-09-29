unit Grobal2;

interface
uses
  Windows;
const
  DEFBLOCKSIZE = 16;
  BUFFERSIZE = 10000;

  SM_CERTIFICATION_SUCCESS = 502;

  GS_QUIT = 2000;
  GS_USERACCOUNT =2001;
  GS_CHANGEACCOUNTINFO =2002;


  SG_CHECKCODEADDR =1006;


  SG_FORMHANDLE=1000;//账号服务器HANLD
  SG_STARTNOW=1001;  //正在启动登录服务器...
  SG_STARTOK=1002;   //登录服务器启动完成...

  WM_SENDPROCMSG=11111;

  CM_GETGAMELIST  = 2000;

  SM_SENDGAMELIST = 5000;
type
  TDefaultMessage = record
    Recog: Integer;
    Ident: word;
    Param: word;
    Tag: word;
    Series: word;
    nSessionID: Integer;//20081210
  end;

implementation

end.
