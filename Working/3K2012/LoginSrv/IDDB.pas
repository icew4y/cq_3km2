unit IDDB;

interface
uses
  Windows, Classes, SysUtils, Forms, Grobal2, MudUtil, LSShare{$IF IDMODE = 1}, DB, ADODB, ActiveX{$IFEND};
resourcestring
  sDBHeaderDesc = '清客网络数据库文件 2008/03/07';
  sDBIdxHeaderDesc = '清客网络数据库索引文件 2008/03/07';
type
  TDBHeader = packed record//Size 124
    sDesc: string[34]; //0x00
    n23: Integer; //0x23
    n28: Integer; //0x27
    n2C: Integer; //0x2B
    n30: Integer; //0x2F
    n34: Integer; //0x33
    n38: Integer; //0x37
    n3C: Integer; //0x3B
    n40: Integer; //0x3F
    n44: Integer; //0x43
    n48: Integer; //0x47
    n4B: Byte; //0x4B
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    nLastIndex: Integer; //0x5C
    dLastDate: TDateTime; //0x60
    nIDCount: Integer; //0x68
    n6C: Integer; //0x6C
    nDeletedIdx: Integer; //0x70
    dUpdateDate: TDateTime; //0x74
  end;
  pTDBHeader = ^TDBHeader;

  TIdxHeader = packed record
    sDesc: string[43]; //0x00
    n2C: Integer; //0x2C
    n30: Integer; //0x30
    n34: Integer; //0x34
    n38: Integer; //0x38
    n3C: Integer; //0x3C
    n40: Integer; //0x40
    n44: Integer; //0x44
    n48: Integer; //0x48
    n4C: Integer; //0x4C
    n50: Integer; //0x50
    n54: Integer; //0x54
    n58: Integer; //0x58
    n5C: Integer; //0x5C
    n60: Integer; //0x60
    nQuickCount: Integer; //0x64
    nIDCount: Integer; //0x68
    nLastIndex: Integer; //0x6C
    dUpdateDate: TDateTime; //0x70
  end;

  TIdxRecord = packed record
    sName: string[11];
    nIndex: Integer;
  end;
  pTIdxRecord = ^TIdxRecord;

  TFileIDDB = class
    m_OnChange: TNotifyEvent;
    m_boChanged: Boolean; //0x18 数据库已被更改
    m_QuickList: TQuickList; //0xA4 数据索引表
    FCriticalSection: TRTLCriticalSection;
    {$IF IDMODE = 1}
    ADOConnection: TADOConnection;
    dbQry: TADOQuery;
    nRecordCount: Integer;//有效记录数
    {$ELSE}
    nC: Integer; //0x0C
    m_nLastReadIdx: Integer; //0x4  最后访问的记录号
    m_nDeletedIdx: Integer; //0x8  已删除的最后一个记录号
    m_nLastIndex: Integer; //0x1C 最后一次写数据的记录号
    m_dLastDate: TDateTime; //0x20 最后修改日期
    m_nFileHandle: Integer; //0x28
    m_Header: TDBHeader; //0x2C 数据库头
    m_sDBFileName: string; //0xAC
    m_sIdxFileName: string; //0xB0
    {$IFEND}
  private
    procedure LoadQuickList;
    function GetRecord(nIndex: Integer; var DBRecord: TAccountDBRecord): Boolean;
    {$IF IDMODE = 1}
    function UpdateRecord(nIndex: Integer; DBRecord: TAccountDBRecord; btFlag: Byte): Boolean;
    {$ELSE}
    function LoadDBIndex: Boolean;
    procedure SaveDBIndex;
    function UpdateRecord(nIndex: Integer; DBRecord: TAccountDBRecord; boNew: Boolean): Boolean;
    {$IFEND}
  public
    constructor Create(sFileName: string);
    destructor Destroy; override;
    procedure Lock;
    procedure UnLock;
    function Open: Boolean;
    function Index(sName: string): Integer;
    function Get(nIndex: Integer; var DBRecord: TAccountDBRecord): Integer;
    function FindByName(sName: string; var List: TStringList): Integer;
    function GetBy(nIndex: Integer; var DBRecord: TAccountDBRecord): Boolean;
    function Update(nIndex: Integer; var DBRecord: TAccountDBRecord): Boolean;
    function Add(var DBRecord: TAccountDBRecord): Boolean;
    procedure Close;
    {$IF IDMODE = 1}
    function Delete(nIndex: integer; var DBRecord: TAccountDBRecord): boolean;
    {$ELSE}
    function OpenEx: Boolean;
    {$IFEND}
  end;
var
  AccountDB: TFileIDDB;
implementation

uses  HUtil32;

{const
  g_sSQL1 = 'FLD_LOGINID CHAR(10) NOT NULL,' +
    'FLD_PASSWORD CHAR(10) NOT NULL,' +
    'FLD_USERNAME CHAR(20) NULL,' +
    'FLD_ERRORCOUNT INT NULL,' +
    'FLD_ACTIONTICK INT NULL,' +
    'FLD_CREATEDATE DATETIME NOT NULL,' +
    'FLD_LASTUPDATE DATETIME NOT NULL,' +
    'FLD_DELETED BIT NOT NULL';

  g_sSQL2 =
    'FLD_LOGINID CHAR(10) NOT NULL,' +
    'FLD_SSNO CHAR(14),' +
    'FLD_BIRTHDAY CHAR(10) NOT NULL,' +
    'FLD_PHONE CHAR(14),' +
    'FLD_MOBILEPHONE CHAR(14),' +
    'FLD_EMAIL CHAR(40),' +
    'FLD_QUIZ1 CHAR(20),' +
    'FLD_ANSWER1 CHAR(20),' +
    'FLD_QUIZ2 CHAR(20),' +
    'FLD_ANSWER2 CHAR(20),' +
    'FLD_MEMO1 CHAR(20),' +
    'FLD_MEMO2 CHAR(20)';   }

{ TFileIDDB }
constructor TFileIDDB.Create(sFileName: string);
begin
{$IF IDMODE = 1}
  inherited Create;
  CoInitialize(nil);//以单线程的方式创建com对象

  InitializeCriticalSection(FCriticalSection);
  m_QuickList := TQuickList.Create;
  m_QuickList.boCaseSensitive := False;
  m_boChanged    := False;
  nRecordCount   := -1;
  g_n472A6C := 0;
  g_n472A74 := 0;
  g_boDataDBReady := False;

  ADOConnection := TADOConnection.Create(nil);
  dbQry := TADOQuery.Create(nil);

  ADOConnection.ConnectionString := sFileName;
  ADOConnection.LoginPrompt := False;
  ADOConnection.KeepConnection := True;
  ADOConnection.CommandTimeout :=20;
  ADOConnection.ConnectionTimeout :=10;

  dbQry.Connection := ADOConnection;
  dbQry.Prepared := True;

  try
    ADOConnection.Connected := True;

    LoadQuickList;
  except
    MainOutMessage('[警告] SQL 连接失败！请检查SQL设置...');
  end;
{$ELSE}
  InitializeCriticalSection(FCriticalSection);
  m_nLastReadIdx := 0;
  m_sDBFileName := sFileName;
  m_sIdxFileName := sFileName + '.idx';
  m_QuickList := TQuickList.Create;
  g_n472A6C := 0;
  g_n472A74 := 0;
  g_boDataDBReady := False;
  m_nLastIndex := -1;
  m_nDeletedIdx := -1;
  if LoadDBIndex then g_boDataDBReady := true
  else LoadQuickList();
{$IFEND}
end;

destructor TFileIDDB.Destroy;
begin
{$IF IDMODE = 1}
  m_QuickList.Free;
  DeleteCriticalSection(FCriticalSection);
  dbQry.Free;
  ADOConnection.Free;
  CoUnInitialize;
  inherited;
{$ELSE}
  if g_boDataDBReady then SaveDBIndex();
  m_QuickList.Free;
  DeleteCriticalSection(FCriticalSection);
{$IFEND}
end;

procedure TFileIDDB.Lock;
begin
  EnterCriticalSection(FCriticalSection);
end;

procedure TFileIDDB.UnLock;
begin
  LeaveCriticalSection(FCriticalSection);
end;

function TFileIDDB.Open: Boolean;
begin
{$IF IDMODE = 1}
  Result := False;
  Lock();

  m_boChanged    := False;
  Result := True;
{$ELSE}
  Lock();
  m_nLastReadIdx := 0;
  m_boChanged := False;
  if FileExists(m_sDBFileName) then begin
    m_nFileHandle := FileOpen(m_sDBFileName, fmOpenReadWrite or fmShareDenyNone);
    if m_nFileHandle > 0 then
      FileRead(m_nFileHandle, m_Header, SizeOf(TDBHeader));
  end else begin
    m_nFileHandle := FileCreate(m_sDBFileName);
    if m_nFileHandle > 0 then begin
      m_Header.sDesc := sDBHeaderDesc;
      m_Header.nIDCount := 0;
      m_Header.n6C := 0;
      m_Header.nDeletedIdx := -1;
      FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
    end;
  end;
  if m_nFileHandle > 0 then begin
    Result := true;
    //    nDeletedIdx:=Header.n70; //Jacky 增加
  end else Result := False;
{$IFEND}
end;

procedure TFileIDDB.Close();
begin
{$IF IDMODE = 0}
  FileClose(m_nFileHandle);
{$IFEND}
  if m_boChanged and Assigned(m_OnChange) then begin
    m_OnChange(Self);
  end;
  UnLock();
end;

{$IF IDMODE = 1}
//生成数据索引
procedure TFileIDDB.LoadQuickList();
var
  nIndex: Integer;
  boDeleted :Boolean;
  sAccount  :String;
resourcestring
  sSQL = 'SELECT * FROM TBL_ACCOUNT';
begin
  nRecordCount := -1;
  g_n472A6C := 0;
  g_n472A70 := 0;
  g_n472A74 := 0;
  m_QuickList.Clear;
  Lock;
  try
    try
      dbQry.SQL.Clear;
      dbQry.SQL.Add(sSQL);
      try
        dbQry.Open;
      except
        MainOutMessage('[异常] TFileIDDB.LoadQuickList');
      end;

      nRecordCount := dbQry.RecordCount;
      g_n472A74 := nRecordCount;
      for nIndex := 0 to nRecordCount - 1 do begin
        Inc(g_n472A6C);
        boDeleted:= dbQry.FieldByName('FLD_DELETED').AsBoolean;
        sAccount:= Trim(dbQry.FieldByName('FLD_LOGINID').AsString);
        if (not boDeleted) and (sAccount <> '') then begin
          m_QuickList.AddObject(sAccount, TObject(nIndex));
          Inc(g_n472A70);
        end;
        dbQry.Next;
      end;
    finally
      dbQry.Close;
    end;
  finally
    UnLock;
  end;
  m_QuickList.SortString(0, m_QuickList.Count - 1);//对索引进行排序
  g_boDataDBReady := True;
end;

function TFileIDDB.UpdateRecord(nIndex: Integer; DBRecord: TAccountDBRecord; btFlag: Byte): Boolean;
var
  sdt:String;
begin
  Result := True;
  //sdt := FormatDateTime('mm"/"dd"/"yyyy hh":"nn":"ss', Now);
  sdt := FormatDateTime('yyyy"-"mm"-"dd hh":"nn":"ss', Now);
  try
    dbQry.SQL.Clear;
    case btFlag of
      1: begin // New 新建账号
        dbQry.SQL.Add(format('INSERT INTO TBL_ACCOUNT(FLD_LOGINID, FLD_PASSWORD, FLD_USERNAME, FLD_CREATEDATE, FLD_LASTUPDATE, FLD_DELETED, '+
                             'FLD_SSNO, FLD_BIRTHDAY,FLD_PHONE, FLD_MOBILEPHONE, FLD_EMAIL, FLD_QUIZ1, FLD_ANSWER1, FLD_QUIZ2, FLD_ANSWER2) '+
				                     'VALUES( ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', 0 , ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'', ''%s'')',
                             [DBRecord.UserEntry.sAccount,
                             DBRecord.UserEntry.sPassword,
                             DBRecord.UserEntry.sUserName,
                             sdt,
                             sdt,
                             DBRecord.UserEntry.sSSNo,
                             DBRecord.UserEntryAdd.sBirthDay,
                             DBRecord.UserEntry.sPhone,
                             DBRecord.UserEntryAdd.sMobilePhone,
                             DBRecord.UserEntry.sEMail,
                             DBRecord.UserEntry.sQuiz,
                             DBRecord.UserEntry.sAnswer,
                             DBRecord.UserEntryAdd.sQuiz2,
                             DBRecord.UserEntryAdd.sAnswer2]));

        try
          dbQry.ExecSQL;
        except
          Result := False;
          MainOutMessage('[异常] TFileIDDB.UpdateRecord (1)');
          Exit;
        end;
      end;
      2: begin // Delete 删除账号
        dbQry.SQL.Add(format('UPDATE TBL_ACCOUNT SET FLD_DELETED=1, FLD_CREATEDATE=''%s'' '+
                             'WHERE FLD_LOGINID=''%s''',
                             [sdt,
                             DBRecord.UserEntry.sAccount]));

        try
          dbQry.ExecSQL;
        except
          Result := False;
          MainOutMessage('[异常] TFileIDDB.UpdateRecord (3)');
        end;
      end;
      else begin //General Update 修改相关信息
        dbQry.SQL.Add(format('UPDATE TBL_ACCOUNT SET FLD_PASSWORD=''%s'', FLD_USERNAME=''%s'', '+
                             'FLD_LASTUPDATE=''%s'', FLD_ERRORCOUNT=%d, FLD_ACTIONTICK=%d '+
                             'FLD_SSNO=''%s'', FLD_BIRTHDAY=''%s'', FLD_PHONE=''%s'', '+
                             'FLD_MOBILEPHONE=''%s'', FLD_EMAIL=''%s'', FLD_QUIZ1=''%s'', FLD_ANSWER1=''%s'', FLD_QUIZ2=''%s'', '+
                             'FLD_ANSWER2=''%s'', FLD_MEMO1=''%s'', FLD_MEMO2=''%s'' '+
                             'WHERE FLD_LOGINID=''%s''',
                             [DBRecord.UserEntry.sPassword,
                             DBRecord.UserEntry.sUserName,
                             sdt,
                             DBRecord.nErrorCount,
                             DBRecord.dwActionTick,
                             DBRecord.UserEntry.sSSNo,
                             DBRecord.UserEntryAdd.sBirthDay,
                             DBRecord.UserEntry.sPhone,
                             DBRecord.UserEntryAdd.sMobilePhone,
                             DBRecord.UserEntry.sEMail,
                             DBRecord.UserEntry.sQuiz,
                             DBRecord.UserEntry.sAnswer,
                             DBRecord.UserEntryAdd.sQuiz2,
                             DBRecord.UserEntryAdd.sAnswer2,
                             DBRecord.UserEntryAdd.sMemo,
                             DBRecord.UserEntryAdd.sMemo2,
                             DBRecord.UserEntry.sAccount]));

        try
          dbQry.ExecSQL;
        except
          Result := False;
          MainOutMessage('[异常] TFileIDDB.UpdateRecord (4)');
          Exit;
        end;
      end;
    end;
    m_boChanged := True;
  finally
    dbQry.Close;
  end;
end;

function TFileIDDB.GetRecord(nIndex: Integer; var DBRecord: TAccountDBRecord): Boolean;
var
  sAccount:String;
resourcestring
  sSQL = 'SELECT * FROM TBL_ACCOUNT WHERE FLD_LOGINID=''%s''';
begin
  Result := True;
  sAccount := m_QuickList[nIndex];

  try
    dbQry.SQL.Clear;
    dbQry.SQL.Add(format(sSQL, [sAccount]));
    try
      dbQry.Open;
    except
      Result := False;
      MainOutMessage('[异常] TFileIDDB.GetRecord (1)');
      Exit;
    end;

    DBRecord.Header.sAccount    := Trim(dbQry.FieldByName('FLD_LOGINID').AsString);
    DBRecord.Header.boDeleted   := dbQry.FieldByName('FLD_DELETED').AsBoolean;
    DBRecord.Header.CreateDate  := dbQry.FieldByName('FLD_CREATEDATE').AsDateTime;
    DBRecord.Header.UpdateDate  := dbQry.FieldByName('FLD_LASTUPDATE').AsDateTime;

    DBRecord.nErrorCount        := dbQry.FieldByName('FLD_ERRORCOUNT').AsInteger;
    DBRecord.dwActionTick       := dbQry.FieldByName('FLD_ACTIONTICK').AsInteger;

    DBRecord.UserEntry.sAccount := Trim(dbQry.FieldByName('FLD_LOGINID').AsString);
    DBRecord.UserEntry.sPassword:= Trim(dbQry.FieldByName('FLD_PASSWORD').AsString);
    DBRecord.UserEntry.sUserName:= Trim(dbQry.FieldByName('FLD_USERNAME').AsString);

    DBRecord.UserEntry.sSSNo      := Trim(dbQry.FieldByName('FLD_SSNO').AsString);
    DBRecord.UserEntry.sPhone     := Trim(dbQry.FieldByName('FLD_PHONE').AsString);
    DBRecord.UserEntry.sQuiz      := Trim(dbQry.FieldByName('FLD_QUIZ1').AsString);
    DBRecord.UserEntry.sAnswer    := Trim(dbQry.FieldByName('FLD_ANSWER1').AsString);
    DBRecord.UserEntry.sEMail     := Trim(dbQry.FieldByName('FLD_EMAIL').AsString);
    //--------------------------------------------------------------------------------
    DBRecord.UserEntryAdd.sQuiz2  := Trim(dbQry.FieldByName('FLD_QUIZ2').AsString);
    DBRecord.UserEntryAdd.sAnswer2 := Trim(dbQry.FieldByName('FLD_ANSWER2').AsString);
    DBRecord.UserEntryAdd.sBirthDay := Trim(dbQry.FieldByName('FLD_BIRTHDAY').AsString);
    DBRecord.UserEntryAdd.sMobilePhone := Trim(dbQry.FieldByName('FLD_MOBILEPHONE').AsString);
    DBRecord.UserEntryAdd.sMemo   := Trim(dbQry.FieldByName('FLD_MEMO1').AsString);
    DBRecord.UserEntryAdd.sMemo2  := Trim(dbQry.FieldByName('FLD_MEMO2').AsString);
  finally
    dbQry.Close;
  end;
end;

function TFileIDDB.Delete(nIndex: integer; var DBRecord: TAccountDBRecord): boolean;
begin
  Result := False;
  if nIndex < 0 then exit;
  if m_QuickList.Count <= nIndex then exit;
  if UpdateRecord(nIndex, DBRecord, 2) then begin
    m_QuickList.Delete(nIndex);
    Result := True;
  end;
end;
{$ELSE}
//加载数据索引文件
function TFileIDDB.LoadDBIndex(): Boolean;
var
  nIdxFileHandle: Integer;
  IdxHeader: TIdxHeader;
  DBHeader: TDBHeader;
  IdxRecord: TIdxRecord;
  HumRecord: TAccountDBRecord;
  I: Integer;
  nCode: Byte;
begin
  Result := False;
  nCode:= 0;
  try
    nIdxFileHandle := 0;
    FillChar(IdxHeader, SizeOf(TIdxHeader), #0);
    nCode:= 1;
    if FileExists(m_sIdxFileName) then
      nIdxFileHandle := FileOpen(m_sIdxFileName, fmOpenReadWrite or fmShareDenyNone);
    nCode:= 2;
    if nIdxFileHandle > 0 then begin
      Result := true;
      nCode:= 3;
      FileRead(nIdxFileHandle, IdxHeader, SizeOf(TIdxHeader));
      try
        nCode:= 4;
        if Open then begin
          FileSeek(m_nFileHandle, 0, 0);
          if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then begin
            if IdxHeader.nIDCount <> DBHeader.nIDCount then
              Result := False;
          end;
          nCode:= 5;
          if IdxHeader.nLastIndex <> DBHeader.nLastIndex then begin
            Result := False;
          end;
          nCode:= 6;
          if IdxHeader.nLastIndex > -1 then begin
            FileSeek(m_nFileHandle, IdxHeader.nLastIndex * SizeOf(TAccountDBRecord) + SizeOf(TDBHeader), 0);
            nCode:= 7;
            if FileRead(m_nFileHandle, HumRecord, SizeOf(TAccountDBRecord)) = SizeOf(TAccountDBRecord) then begin
              nCode:= 8;
              if IdxHeader.dUpdateDate <> HumRecord.Header.UpdateDate then
                Result := False;
            end;
          end;
        end;
      finally
        Close();
      end;
      nCode:= 9;
      if Result then begin
        nCode:= 10;
        m_nLastIndex := IdxHeader.nLastIndex;
        m_dLastDate := IdxHeader.dUpdateDate;
        nCode:= 11;
        for I := 0 to IdxHeader.nQuickCount - 1 do begin
          if FileRead(nIdxFileHandle, IdxRecord, SizeOf(TIdxRecord)) = SizeOf(TIdxRecord) then begin
            m_QuickList.AddObject(IdxRecord.sName, TObject(IdxRecord.nIndex));
          end else begin
            Result := False;
            break;
          end;
        end;
      end;
      FileClose(nIdxFileHandle);
    end;
    if Result then begin
      nCode:= 12;
      g_n472A6C := DBHeader.nIDCount;
      g_n472A74 := DBHeader.nIDCount;
    end else m_QuickList.Clear;
  except
    MainOutMessage('[异常] TFileIDDB.LoadDBIndex Code:'+inttostr(nCode));
  end;
end;

//储存数据索引
procedure TFileIDDB.SaveDBIndex();
var
  IdxHeader: TIdxHeader;
  nIdxFileHandle: Integer;
  I: Integer;
  IdxRecord: TIdxRecord;
begin
  FillChar(IdxHeader, SizeOf(TIdxHeader), #0);
  IdxHeader.sDesc := sDBIdxHeaderDesc;
  IdxHeader.nQuickCount := m_QuickList.Count;
  IdxHeader.nIDCount := m_Header.nIDCount;
  IdxHeader.nLastIndex := m_nLastIndex;
  IdxHeader.dUpdateDate := m_dLastDate;
  if FileExists(m_sIdxFileName) then
    nIdxFileHandle := FileOpen(m_sIdxFileName, fmOpenReadWrite or fmShareDenyNone)
  else nIdxFileHandle := FileCreate(m_sIdxFileName);
  if nIdxFileHandle > 0 then begin
    FileWrite(nIdxFileHandle, IdxHeader, SizeOf(TIdxHeader));
    for I := 0 to m_QuickList.Count - 1 do begin
      FillChar(IdxRecord, SizeOf(TIdxRecord), #0);
      IdxRecord.sName := m_QuickList.Strings[I];
      IdxRecord.nIndex := Integer(m_QuickList.Objects[I]);
      FileWrite(nIdxFileHandle, IdxRecord, SizeOf(TIdxRecord));
    end;
    FileClose(nIdxFileHandle);
  end;
end;

function TFileIDDB.UpdateRecord(nIndex: Integer; DBRecord: TAccountDBRecord;
  boNew: Boolean): Boolean;
var
//  DeletedHeader: TRecordDeletedHeader;
  nPosion: Integer;
  n10: Integer;
  dDateTime: TDateTime;
begin
  nPosion := nIndex * SizeOf(TAccountDBRecord) + SizeOf(TDBHeader);
  if FileSeek(m_nFileHandle, nPosion, 0) = nPosion then begin
    m_nLastIndex := nIndex;
    dDateTime := Now();
    m_dLastDate := dDateTime;
    n10 := FileSeek(m_nFileHandle, 0, 1);
    if boNew then begin
      {if FileRead(m_nFileHandle, DeletedHeader, SizeOf(TRecordDeletedHeader)) = SizeOf(TRecordDeletedHeader) then begin
        if DeletedHeader.boDeleted then begin
          m_nDeletedIdx := DeletedHeader.nNextDeletedIdx;
        end else begin
          m_nDeletedIdx := -1;
          Result := False;
          Exit;
        end;
      end;}
      DBRecord.Header.CreateDate := dDateTime;
    end;
    //DBRecord.Header.boDeleted := False;//20080817 注释
    DBRecord.Header.UpdateDate := dDateTime;
    m_Header.nLastIndex := m_nLastIndex;
    m_Header.dLastDate := m_dLastDate;
    m_Header.nDeletedIdx := m_nDeletedIdx;
    m_Header.dUpdateDate := Now();
    FileSeek(m_nFileHandle, 0, 0);
    FileWrite(m_nFileHandle, m_Header, SizeOf(TDBHeader));
    FileSeek(m_nFileHandle, nPosion, 0);
    FileWrite(m_nFileHandle, DBRecord, SizeOf(TAccountDBRecord));
    FileSeek(m_nFileHandle, -SizeOf(TAccountDBRecord), 1);
    m_nLastReadIdx := nIndex;
    m_boChanged := true;
    Result := true;
  end else Result := False;
end;

//生成数据索引
procedure TFileIDDB.LoadQuickList();
var
  nIndex: Integer;
  n10: Integer;
  DBHeader: TDBHeader;
  DBRecord: TAccountDBRecord;
  DeletedHeader: TRecordDeletedHeader;
begin
  m_nLastReadIdx := 0;
  m_nDeletedIdx := -1;
//  nIndex := 0;
  g_n472A6C := 0;
  g_n472A70 := 0;
  g_n472A74 := 0;
  try
    m_QuickList.Clear;
    try
      if Open then begin
        FileSeek(m_nFileHandle, 0, 0);
        if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then begin
          g_n472A74 := DBHeader.nIDCount;
          for nIndex := 0 to DBHeader.nIDCount - 1 do begin
            Inc(g_n472A6C);
            if FileRead(m_nFileHandle, DBRecord, SizeOf(TAccountDBRecord)) <> SizeOf(TAccountDBRecord) then begin
              break;
            end;
            if not DBRecord.Header.boDeleted then begin
              if DBRecord.UserEntry.sAccount <> '' then begin
                {if m_QuickList.IndexOf(DBRecord.UserEntry.sAccount) >= 0 then begin
                  MainOutMessage('帐号重复： ' + DBRecord.UserEntry.sAccount);
                end;}
                m_QuickList.AddObject(DBRecord.UserEntry.sAccount, TObject(nIndex));
                Inc(g_n472A70);
              end;
            end else begin //004581D5  //20100116 修改，修正删除账号后，ID索引生成出错
              {n10 := FileSeek(m_nFileHandle, -SizeOf(TAccountDBRecord), 1);
              FileRead(m_nFileHandle, DeletedHeader, SizeOf(TRecordDeletedHeader));
              FileSeek(m_nFileHandle, -SizeOf(TRecordDeletedHeader), 1);
              DeletedHeader.nNextDeletedIdx := m_nDeletedIdx;}
              m_nDeletedIdx := nIndex;
              {FileWrite(m_nFileHandle, DeletedHeader, SizeOf(TRecordDeletedHeader));
              FileSeek(m_nFileHandle, n10, 0);}
            end;
            Application.ProcessMessages;
            if Application.Terminated then begin
              Close;
              Exit;
            end;
          end;
        end;
      end;
    finally
      Close();
    end;
    m_QuickList.SortString(0, m_QuickList.Count - 1);
    m_nLastIndex := m_Header.nLastIndex;
    m_dLastDate := m_Header.dLastDate;
    g_boDataDBReady := true;
  except
    MainOutMessage('[异常] TFileIDDB.LoadQuickList');
  end;
end;

function TFileIDDB.GetRecord(nIndex: Integer; var DBRecord: TAccountDBRecord): Boolean;
begin
  if FileSeek(m_nFileHandle, SizeOf(TAccountDBRecord) * nIndex + SizeOf(TDBHeader), 0) <> -1 then begin
    FileRead(m_nFileHandle, DBRecord, SizeOf(TAccountDBRecord));
    FileSeek(m_nFileHandle, -SizeOf(TAccountDBRecord) * nIndex + SizeOf(TDBHeader), 1);
    if DBRecord.Header.boDeleted then begin //20080817 增加
       Result := False;
       Exit;
    end;
    m_nLastReadIdx := nIndex;
    Result := true;
  end else Result := False;
end;

function TFileIDDB.OpenEx: Boolean;
var
  DBHeader: TDBHeader;
begin
  Lock();
  m_boChanged := False;
  m_nFileHandle := FileOpen(m_sDBFileName, fmOpenRead or fmShareDenyNone);
  if m_nFileHandle > 0 then begin
    Result := true;
    if FileRead(m_nFileHandle, DBHeader, SizeOf(TDBHeader)) = SizeOf(TDBHeader) then
      m_Header := DBHeader;
    m_nLastReadIdx := 0;
  end else Result := False;
end;
{$IFEND}

function TFileIDDB.FindByName(sName: string; var List: TStringList): Integer;
var
  I: Integer;
begin
  for I := 0 to m_QuickList.Count - 1 do begin
    if CompareLStr(m_QuickList.Strings[I], sName, length(sName)) then begin
      List.AddObject(m_QuickList.Strings[I], m_QuickList.Objects[I]);
    end;
  end;
  Result := List.Count;
end;

function TFileIDDB.GetBy(nIndex: Integer; var DBRecord: TAccountDBRecord): Boolean;
begin
  if (nIndex >= 0) and (m_QuickList.Count > nIndex) then Result := GetRecord(nIndex, DBRecord)
  else Result := False;
end;

function TFileIDDB.Index(sName: string): Integer;
begin
  Result := m_QuickList.GetIndex(sName);
end;

function TFileIDDB.Get(nIndex: Integer; var DBRecord: TAccountDBRecord): Integer;
var
  nRecordIndex: Integer;
begin
  nRecordIndex := Integer(m_QuickList.Objects[nIndex]);
  if GetRecord(nRecordIndex, DBRecord) then Result := nRecordIndex
  else Result := -1;
end;

function TFileIDDB.Update(nIndex: Integer; var DBRecord: TAccountDBRecord): Boolean;
begin
  Result := False;
  if nIndex < 0 then Exit;
  if m_QuickList.Count <= nIndex then Exit;
  {$IF IDMODE = 1}
  if UpdateRecord(nIndex, DBRecord, 0) then Result := true;
  {$ELSE}
  if UpdateRecord(Integer(m_QuickList.Objects[nIndex]), DBRecord, False) then Result := true;
  {$IFEND}
end;

function TFileIDDB.Add(var DBRecord: TAccountDBRecord): Boolean;
var
  sAccountName: string;
  nC: Integer;
  {$IF IDMODE = 0}
  DBHeader: TDBHeader;
  {$IFEND}
begin
  sAccountName := DBRecord.UserEntry.sAccount;
  if m_QuickList.GetIndex(sAccountName) >= 0 then begin
    Result := False;
  end else begin
    {$IF IDMODE = 1}
    nC := nRecordCount;
    Inc(nRecordCount);

    if UpdateRecord(nC, DBRecord, 1) then begin
      m_QuickList.AddRecord(sAccountName, nC);
      Result := True;
    end else begin
      Result   := False;
    end;    
    {$ELSE}
    DBHeader := m_Header;
    if m_nDeletedIdx = -1 then begin
      nC := m_Header.nIDCount;
      Inc(m_Header.nIDCount);
    end else nC := m_nDeletedIdx;

    if UpdateRecord(nC, DBRecord, true) then begin
      m_QuickList.AddRecord(DBRecord.UserEntry.sAccount, nC);
      Result := true;
    end else begin
      m_Header := DBHeader;
      Result := False;
    end;
    {$IFEND}
  end;
end;

end.
