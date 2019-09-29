unit AI3;

interface

uses
  Classes,SysUtils;

type
  TAI3 = class(TObject)
  private
    iAIPt: Integer;
    QusFile: string;
    QusList: TStringList;
    AnsFile: string;
    AnsList: TStringList;
    function LocateQus(sQuestion: string): Integer;
    function GetAns(LocID: Integer): string;
    procedure AppendGus(sQuestion: string);
    function GetRandAns: string;
    procedure BindAns(sQuestion: string);
    procedure XorFile(sFileName: string; iPassWord: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    function Ask(sQuestion: string): string;
    procedure Teach(sQuestion: string);
  end;

implementation
uses M2Share;
{ TAI3 }

constructor TAI3.Create;
begin
  iAIPt := -1;
  QusFile := g_Config.sEnvirDir + 'MemA.txt';
  QusList := TStringList.Create;
  if FileExists(QusFile) then
  try
    XorFile(QusFile, 911);
    QusList.LoadFromFile(QusFile);
  finally
    XorFile(QusFile, 911);
  end;
  AnsFile := g_Config.sEnvirDir + 'MemB.txt';
  AnsList := TStringList.Create;
  if FileExists(AnsFile) then
  try
    XorFile(AnsFile, 911);
    AnsList.LoadFromFile(AnsFile);
  finally
    XorFile(AnsFile, 911);
  end;
end;

destructor TAI3.Destroy;
begin
  if FileExists(QusFile) then begin
    QusList.SaveToFile(QusFile);
    XorFile(QusFile, 911);
  end;
  QusList.Free;
  if FileExists(AnsFile) then begin
    AnsList.SaveToFile(AnsFile);
    XorFile(AnsFile, 911);
  end;
  AnsList.Free;
  inherited;
end;

function TAI3.LocateQus(sQuestion: string): Integer;
var
  i: Integer;
  sNowQus: string;
  n: Integer;
  iLikeCount: Integer;
  sS: string;
  iMaxCount: Integer;
  ResultList: TStringList;
begin
  ResultList := TStringList.Create;
  try
    Result := -1;
    iMaxCount := 0;
    for i := 0 to QusList.Count - 1 do begin
      sNowQus := QusList[i];
      iLikeCount := 0;
      for n := 0 to Length(sNowQus) - 1 do begin
        sS := sNowQus[n];
        if Pos(sS, sQuestion) > 0 then
          iLikeCount := iLikeCount + 1
        else iLikeCount := iLikeCount - 1;
      end;
      if iLikeCount > iMaxCount then begin
        iMaxCount := iLikeCount;
        ResultList.Add(IntToStr(i));
      end else
      if iMaxCount > 0 then
        if iLikeCount = iMaxCount then begin
          ResultList.Add(IntToStr(i));
        end;
    end;
    if ResultList.Count > 0 then  begin
      for i := ResultList.Count - 1 downto 0 do begin
        if StrToInt(ResultList[i]) >= AnsList.Count then
          ResultList[i] := IntToStr(Random(AnsList.Count));
        if AnsList[StrToInt(ResultList[i])] = '' then ResultList.Delete(i);
      end;
    end;
    if ResultList.Count > 0 then Result := StrToInt(ResultList[ResultList.Count - 1]);
  finally
    ResultList.Free;
  end;
end;

function TAI3.GetAns(LocID: Integer): string;
var
  CAnsList: TStringList;
  i: Integer;
  iQusID: Integer;
  iMax: Integer;
  RandList: TStringList;
begin
  Result := '';
  RandList := TStringList.Create;
  CAnsList := TStringList.Create;
  try
    iQusID := -1;
    CAnsList.CommaText := AnsList[LocID];
    iMax := 0;
    i := 0;
    while i < CAnsList.Count do begin
      if StrToInt(CAnsList[i]) > iMax then begin
        iMax := StrToInt(CAnsList[i]);
        RandList.Clear;
        RandList.Add(CAnsList[i + 1]);
      end else
        if StrToInt(CAnsList[i]) = iMax then RandList.Add(CAnsList[i + 1]);
      i := i + 2;
    end;
    if RandList.Count > 0 then iQusID := StrToInt(RandList[Random(RandList.Count)]);
    if iQusID >= 0 then begin
      Result := QusList[iQusID];
      iAIPt := iQusID;
    end;
  finally
    CAnsList.Free;
    RandList.Free;
  end;
end;

procedure TAI3.AppendGus(sQuestion: string);
var
  i: Integer;
begin
  i := QusList.IndexOf(sQuestion);
  if i < 0 then begin
    QusList.Add(sQuestion);
    AnsList.Add('');
  end;
end;

function TAI3.GetRandAns: string;
var
  iRnd: Integer;
begin
  if QusList.Count > 0 then begin
    iRnd := Random(QusList.Count);
    Result := QusList[iRnd];
    iAIPt := iRnd;
  end;
end;

procedure TAI3.BindAns(sQuestion: string);
var
  sNowAnsList: TStringList;
  i: Integer;
  n: Integer;
  bHas: Boolean;
begin
  if iAIPt >= 0 then begin
    n := QusList.IndexOf(sQuestion);
    sNowAnsList := TStringList.Create;
    try
      if iAIPt >= AnsList.Count then iAIPt := Random(AnsList.Count);
      sNowAnsList.CommaText := AnsList[iAIPt];
      i := 0;
      bHas := False;
      while i < sNowAnsList.Count do begin
        if StrToInt(sNowAnsList[i + 1]) = n then begin
          sNowAnsList[i] := IntToStr(StrToInt(sNowAnsList[i]) + 1);
          bHas := True;
        end;
        i := i + 2;
      end;
      if bHas = False then begin
        sNowAnsList.Add('1');
        sNowAnsList.Add(IntToStr(n));
      end;
      AnsList[iAIPt] := sNowAnsList.CommaText;
    finally
      sNowAnsList.Free;
    end;
  end;
end;

procedure TAI3.XorFile(sFileName: string; iPassWord: Integer);
var
  FileStream, WriteFileStream: TFileStream; //建立两个文件流，一个读一个写。
  cA: Char; //声明一个字节来存每次取出的字节内容。
  i: Integer;
begin
  //功能：对指定文件以 PassWord 为密匙异或。
  //参数：指定文件，整形密匙。
  FileStream := TFileStream.Create(sFileName, fmOpenRead);
  WriteFileStream := TFileStream.Create(ExtractFilePath(sFileName) + '~t.t', fmCreate);
  try
    for i := 0 to FileStream.Size - 1 do begin
      FileStream.Read(cA, 1); //读字节。
      cA := Chr(Ord(cA) xor iPassWord); //进行异或。
      WriteFileStream.Write(cA, 1); //写字节。
    end;
  finally
    FileStream.Free;
    WriteFileStream.Free;
    DeleteFile(sFileName);
    ReNameFile(ExtractFilePath(sFileName) + '~t.t', sFileName);
  end;
end;

function TAI3.Ask(sQuestion: string): string;
var
  iLocID: Integer;
begin
  Result := '';
  AppendGus(sQuestion);
  BindAns(sQuestion);
  iLocID := LocateQus(sQuestion);
  if iLocID >= 0 then
    Result := GetAns(iLocID);
  if Result = '' then
    Result := GetRandAns;
end;

procedure TAI3.Teach(sQuestion: string);
var
  n: Integer;
begin
  n := QusList.IndexOf(sQuestion);
  if n < 0 then begin
    QusList.Add(sQuestion);
    AnsList.Add('');
    iAIPt := QusList.Count - 1;
  end else iAIPt := n;
end;

end.

