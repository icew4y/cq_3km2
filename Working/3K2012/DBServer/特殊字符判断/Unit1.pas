unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, StrUtils;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    Edit1: TEdit;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function GetValidStr3 (Str: string; var Dest: string; const Divider: array of Char): string;
const
   BUF_SIZE = 20480; //$7FFF;
var
	Buf: array[0..BUF_SIZE] of char;
   BufCount, Count, SrcLen, I, ArrCount: Longint;
   Ch: char;
label
	CATCH_DIV;
begin
  Ch:=#0;//Jacky
   try
      SrcLen := Length(Str);
      BufCount := 0;
      Count := 1;

      if SrcLen >= BUF_SIZE-1 then begin
         Result := '';
         Dest := '';
         exit;
      end;

      if Str = '' then begin
         Dest := '';
         Result := Str;
         exit;
      end;
      ArrCount := sizeof(Divider) div sizeof(char);

      while TRUE do begin
         if Count <= SrcLen then begin
           Ch := Str[Count];
           if ByteType(Str, Count) = mbSingleByte then begin  //20100927增加，防止繁体字Str[Count]分解出“\”符号
            //Ch := Str[Count];
            //Form1.Memo1.Lines.Add(Ch+ '  Str:'+Str);
            for I:=0 to ArrCount- 1 do
               if Ch = Divider[I] then
                  goto CATCH_DIV;
           end;
         end;
         if (Count > SrcLen) then begin
            CATCH_DIV:
            if (BufCount > 0) then begin
               if BufCount < BUF_SIZE-1 then begin
                  Buf[BufCount] := #0;
                  Dest := string (Buf);
                  Result := Copy (Str, Count+1, SrcLen-Count);
               end;
               break;
            end else begin
               if (Count > SrcLen) then begin
                  Dest := '';
                  Result := Copy (Str, Count+2, SrcLen-1);
                  break;
               end;
            end;
         end else begin
            if BufCount < BUF_SIZE-1 then begin
               Buf[BufCount] := Ch;
               Inc (BufCount);
            end;// else
         end;
         Inc (Count);
      end;
   except
      Dest := '';
      Result := '';
   end;
end;

function CheckChrName(sChrName: string): Boolean;//0x0045BE60
var
  i: Integer;
  Chr: Char;
  boIsTwoByte: Boolean;
  FirstChr: Char;
  sgr:string;
begin
  Result := True;
  boIsTwoByte := False;
  FirstChr := #0;
  for i := 1 to Length(sChrName) do begin
    Chr := (sChrName[i]);
    if ord(Chr) < 32 then Result := False;
    if boIsTwoByte then begin
      if not ((FirstChr <= #$F7) and (Chr >= #$40) and (Chr <= #$FE)) then
        if not ((FirstChr > #$F7) and (Chr >= #$40) and (Chr <= #$A0)) then Result := False;
      boIsTwoByte := False;
    end else begin
      if (Chr >= #$81) and (Chr <= #$FE) then begin
        boIsTwoByte := True;
        FirstChr := Chr;
      end else begin //0x0045BED2
        if not ((Chr >= '0' {#30}) and (Chr <= '9' {#39})) and
          not ((Chr >= 'a' {#61}) and (Chr <= 'z') {#7A}) and
          not ((Chr >= 'A' {#41}) and (Chr <= 'Z' {#5A})) then
          Result := False;
      end;
    end;
    if not Result then break;
  end;
  //if Result then begin//20100625 过滤使客户端截取出错的字符
    {if AnsiContainsText(sChrName, 'ň') or AnsiContainsText(sChrName, 'ń') or
       AnsiContainsText(sChrName, '啾') or AnsiContainsText(sChrName, '㈱') or
       AnsiContainsText(sChrName, '朳') {or
       AnsiContainsText(sChrName, '‐') or AnsiContainsText(sChrName, '賊') or
       AnsiContainsText(sChrName, '╘') or AnsiContainsText(sChrName, '塡') or
       AnsiContainsText(sChrName, '黒') or AnsiContainsText(sChrName, '謀') or
       AnsiContainsText(sChrName, '籠') or AnsiContainsText(sChrName, '朶') or
       AnsiContainsText(sChrName, '錦') or AnsiContainsText(sChrName, '淺') or
       AnsiContainsText(sChrName, '俓') or AnsiContainsText(sChrName, '鵟') or
       AnsiContainsText(sChrName, '衆') or AnsiContainsText(sChrName, '甛') or
       or AnsiContainsText(sChrName, '竆') or AnsiContainsText(sChrName, '誠') then Result := False;    }
    //if Result then begin
      GetValidStr3(sChrName,sgr,['\']);
      Form1.memo1.Lines.Add(sgr);

      //if Length(sChrName) <> Length(sgr) then Result := False;
    //end;
  //end;
end;



procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  if CheckChrName(Edit1.text) then Memo1.Lines.Add('合法字符')
  else Memo1.Lines.Add('非法字符')
end;


end.
