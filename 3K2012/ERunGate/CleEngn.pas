unit CleEngn;

interface

uses
  Windows,Classes,SysUtils;

type
  TClearEngine = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;
  function GetDateTime(wM,wD:Word):TDateTime;
var
  DBClear:TClearEngine;
implementation

uses HumDB, DBShare, Grobal2;

{ Important: Methods and properties of objects in VCL or CLX can only be used
  in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TClearEngine.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TClearEngine }

procedure TClearEngine.Execute;
var
  Level1Date,Level2Date,Level3Date:TDateTime;
  RecordIndex:Integer;
  ChrName:String;
  ChrRecord:THumDataInfo;
begin
  while (True) do begin
    if Self.Terminated then break;
    //nRecordCount:=0;
    ChrName:='';
    Level1Date:=GetDateTime(nMonth1,nDay1);
    Level2Date:=GetDateTime(nMonth2,nDay2);
    Level3Date:=GetDateTime(nMonth3,nDay3);
    try
      if HumDataDB.Open then begin
        nRecordCount:= HumDataDB.Count;
        if nClearIndex < nRecordCount then begin
          RecordIndex:=HumDataDB.Get(nClearIndex,ChrRecord);
          if RecordIndex >= 0 then begin
            if ((ChrRecord.Header.dCreateDate < Level1Date) and (ChrRecord.Data.btLevel <= nLevel1)) or
               ((ChrRecord.Header.dCreateDate < Level2Date) and (ChrRecord.Data.btLevel <= nLevel2)) or
               ((ChrRecord.Header.dCreateDate < Level3Date) and (ChrRecord.Data.btLevel <= nLevel3)) then begin
               ChrName:=ChrRecord.Header.sName;
               HumDataDB.Delete(RecordIndex);
               Inc(nClearCount);
             end;
             Inc(nClearIndex);
          end;
        end else nClearIndex:=0;
      end;
    finally
      HumDataDB.Close;
    end;
    if ChrName <> '' then begin
      try
        if HumChrDB.Open then HumChrDB.Delere(ChrName);
      finally
        HumChrDB.Close;
      end;
    end;
    Sleep(dwInterval);
  end;
end;
function GetDateTime(wM,wD:Word):TDateTime;
var
  Year, Month, Day: Word;
  i:integer;
begin
  DecodeDate(Now,Year, Month, Day);
  for I := 0 to wM - 1 do begin
    if Month > 1 then Dec(Month)
    else begin
      Month:=12;
      Dec(Year);
    end;
  end;
  for I := 0 to wD - 1 do begin
    if Day > 1 then Dec(Day)
    else begin
      Day:=28;
      if Month > 1 then Dec(Month)
      else begin
        Month:=12;
        Dec(Year);
      end;
    end;
  end;
  Result:=EncodeDate(Year,Month,Day);
end;
end.
