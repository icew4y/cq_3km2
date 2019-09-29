unit DBToolsShare;

interface
uses Windows,Classes,Grobal2,SysUtils;
var
  n4ADAE4: Integer;
  n4ADAF0: Integer;
  n4ADAE8: Integer;
  n4ADAEC: Integer;
  n4ADAFC: Integer;
  n4ADB04: Integer;
  n4ADB00: Integer;

  //ID的变量
  g_n472A6C: Integer;
  g_n472A70: Integer;
  g_n472A74: Integer;
  g_boDataDBReady: Boolean; //0x00472A78
  //End
  boHumDBReady: Boolean; //0x4ADB08
  boDataDBReady: Boolean; //0x004ADAF4
  HumDB_CS: TRTLCriticalSection; //0x004ADACC
  MagicList: TList; //魔法列表
  StdItemList: TList;

  sHeroDB: string = 'HeroDB';//数据源
  sIDDBFilePath: string = 'D:\Mirserver\LoginSrv\IDDB\ID.DB';
  sHumDBFilePath: string = 'D:\Mirserver\DBServer\FDB\Hum.DB';
  sMirDBFilePath: string = 'D:\Mirserver\DBServer\FDB\Mir.DB';
  sHeroMirDBFilePath: string = 'D:\Mirserver\DBServer\FDB\HeroMir.DB';
  boReadHumDate: Boolean;

  function GetMagicName(wMagicId: Word; nType: Byte): string;//根据技能ID查出技能名称
  function GetMagicId(sMagicName: String): Word;//根据技能名称查出技能ID

implementation
//根据技能ID查出技能名称
function GetMagicName(wMagicId: Word; nType: Byte): string;
var
  i: Integer;
  Magic: pTMagic;
  sMagicDescr: string;
begin
  case nType of
    1:sMagicDescr:='英雄';
    2:sMagicDescr:='内功';
    else sMagicDescr:='';
  end;
  for i := 0 to MagicList.Count - 1 do begin
    Magic := MagicList.Items[i];
    if Magic <> nil then begin
      if (Magic.wMagicId = wMagicId) and ((Magic.sDescr = sMagicDescr) or
        (Magic.sDescr='连击') or (Magic.sDescr='通用')or (Magic.sDescr='神技')) then begin
        if (nType = 2) and (Magic.sDescr='连击') then Continue;//继续
        Result := Magic.sMagicName;
        break;
      end;
    end;
  end;
end;

//根据技能名称查出技能ID
function GetMagicId(sMagicName: String): Word;
var
  i: Integer;
  Magic: pTMagic;
begin
  Result := 0;
  for i := 0 to MagicList.Count - 1 do begin
    Magic := MagicList.Items[i];
    if Magic <> nil then begin
      if CompareText(Magic.sMagicName,sMagicName) = 0 then begin
        Result := Magic.wMagicId;
        break;
      end;
    end;
  end;
end;

initialization
  begin
  InitializeCriticalSection(HumDB_CS);
  MagicList := TList.Create;
  StdItemList := TList.Create;
  end;
finalization
  begin
    DeleteCriticalSection(HumDB_CS);
    MagicList.Free;
    StdItemList.Free;
  end;
end.
