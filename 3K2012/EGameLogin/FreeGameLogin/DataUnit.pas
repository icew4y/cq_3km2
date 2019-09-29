unit DataUnit;

interface

var DemoDfm: string = {$I Image2.dfm.txt};

implementation

procedure FastCode(var Str: string);
const
  XorKey: array[0..7] of Byte = ($D7, $EE, $B0, $AE, $BA, $D0, $D7, $D3);
var                               
  I, J: Integer;
  P: PByte;
begin
  P := @Str[1];
  J := 0;
  for I := 1 to Length(Str) do
  begin
    P^ := P^ xor XorKey[J];
    Inc(P);
    J := (J + 1) mod 8;
  end;
end;

initialization FastCode(DemoDfm);

end.
