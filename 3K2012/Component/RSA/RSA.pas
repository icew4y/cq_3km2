unit RSA;

interface

uses
  SysUtils, Classes,FGInt, FGIntPrimeGeneration, FGIntRSA;

type
  TRSA = class(TComponent)
  private
    FCommonalityKey     :TFGInt;
    FCommonalityKeySet  :Boolean;
    FCommonalityMode    :TFGInt;
    FCommonalityModeSet :Boolean;
    FPrivateKey         :TFGInt;
    FPrivateKeySet      :Boolean;
    FServer             :Boolean;
    procedure FWriteCommonalityKey(Value :String);
    Function  FReadCommonalityKey():String;
    procedure FWriteCommonalityMode(Value :String);
    Function  FReadCommonalityMode():String;
    procedure FWritePrivateKey(Value :String);
    Function  FReadPrivateKey():String;
  protected
    { Protected declarations }
  public
    Function EncryptStr(sMsg:String):String;
    Function DecryptStr(sMsg:String):String;
    Function EncryptStr16(sMsg:String):String;
    Function DecryptStr16(sMsg:String):String;

  published
    property CommonalityKey  :String  read  FReadCommonalityKey   write FWriteCommonalityKey;
    property CommonalityMode :String  read  FReadCommonalityMode  write FWriteCommonalityMode;
    property PrivateKey      :String  read  FReadPrivateKey       write FWritePrivateKey;
    property Server          :Boolean read  FServer               write FServer default False;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TRSA]);
end;

Function TRSA.FReadCommonalityKey():String;
begin
  Result:='';
  if FCommonalityKeySet then
    FGIntToBase10String(FCommonalityKey,Result);
end;

procedure TRSA.FWriteCommonalityKey(Value :String);
begin
  if Value<>'' then begin
    Base10StringToFGInt(Value,FCommonalityKey);
    FCommonalityKeySet:=True;
  end;
end;

procedure TRSA.FWriteCommonalityMode(Value :String);
begin
  if Value<>'' then begin
    Base10StringToFGInt(Value,FCommonalityMode);
    FCommonalityModeSet:=True;
  end;
end;

Function TRSA.FReadCommonalityMode():String;
begin
  Result:='';
  if FCommonalityModeSet then
    FGIntToBase10String(FCommonalityMode,Result);
end;

procedure TRSA.FWritePrivateKey(Value :String);
begin
  if Value<>'' then begin
    Base10StringToFGInt(Value,FPrivateKey);
    FPrivateKeySet:=True;
  end;
end;

Function TRSA.FReadPrivateKey():String;
begin
  Result:='';
  if FPrivateKeySet then
    FGIntToBase10String(FPrivateKey,Result);
end;

Function TRSA.DecryptStr(sMsg:String):String;
var
  Test:String;
  Nilgint:TFGInt;
begin
  if sMsg<>'' then begin
    ConvertBase64to256(sMsg,Test);
    if FServer then RSADecrypt(Test,FPrivateKey,FCommonalityMode,Nilgint,Nilgint,Nilgint,Nilgint,Result)
    else RSADecrypt(Test,FCommonalityKey,FCommonalityMode,Nilgint,Nilgint,Nilgint,Nilgint,Result);
  end;
end;

Function TRSA.EncryptStr(sMsg:String):String;
var
  Test:String;
begin
  Result:='';
  Test:=sMsg;
  if Test<>'' then begin
    if FServer then RSAEncrypt(Test,FPrivateKey,FCommonalityMode,Test)
    else RSAEncrypt(Test,FCommonalityKey,FCommonalityMode,Test);
    //Result:=Test;
    ConvertBase256to64(Test,Result);
  end;
end;

Function TRSA.EncryptStr16(sMsg:String):String;
var
  Test:String;
  I:integer;
begin
  Test:=EncryptStr(sMsg);
  Result:='';
  Try
    for i:=1 to Length(Test) do begin
      Result:=Result+IntToHex(Byte(Test[i]),0);
    end;
  Except
  end;
end;

Function TRSA.DecryptStr16(sMsg:String):String;
var
  Test:String;
  I:integer;
begin
  Test:='';
  Result:='';
  Try
    for i:=1 to Length(sMsg) div 2 do begin
      Test:=Test+Char(Byte(StrToInt('$'+Copy(sMsg,I*2-1,2))));
    end;
    Result:=DecryptStr(Test);
  Except
  end;
end;

end.
 