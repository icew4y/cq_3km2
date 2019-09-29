{
  LDE32.pas: Z0MBiE DISASM ENGINE[LDE32]
  LDE32 Delphi Coded By Anskya
  Email: Anskya@Gmail.com

更新说明:
  procedure GetInstLenght(myiptr0: Pointer; osizeptr: PULONG);
  function GetProcLength(myiptr0: Pointer): ULONG;

0.2:
  增加 GetProcLength函数.用于获取一个函数过程的长度.

0.1:
  翻译

  Thank: z0mbie
}
unit uHelperL;

interface

type
  ULONG = Cardinal;
  PULONG = ^ULONG;
  PBYTE = ^BYTE;

const
  C_ERROR         = $FFFFFFFF;
  C_PREFIX        = $00000001;
  C_66            = $00000002;
  C_67            = $00000004;
  C_DATA66        = $00000008;
  C_DATA1         = $00000010;
  C_DATA2         = $00000020;
  C_DATA4         = $00000040;
  C_MEM67         = $00000080;
  C_MEM1          = $00000100;
  C_MEM2          = $00000200;
  C_MEM4          = $00000400;
  C_MODRM         = $00000800;
  C_DATAW0        = $00001000;
  C_FUCKINGTEST   = $00002000;
  C_TABLE_0F      = $00004000;

  OpcodeFlags: Array [$00..$FF] of ULONG =
  (
    C_MODRM,          //  $00
    C_MODRM,          //  $01
    C_MODRM,          //  $02
		C_MODRM,          //  $03
		C_DATAW0,         //  $04
    C_DATAW0,         //  $05
		0,                //  $06
		0,                //  $07
		C_MODRM,          //  $08
		C_MODRM,          //  $09
		C_MODRM,          //  $0A
		C_MODRM,          //  $0B
		C_DATAW0,         //  $0C
		C_DATAW0,         //  $0D
		0,                //  $0E
		C_TABLE_0F,       //  $0F
		C_MODRM,          //  $10
		C_MODRM,          //  $11
		C_MODRM,          //  $12
		C_MODRM,          //  $13
		C_DATAW0,         //  $14
		C_DATAW0,         //  $15
		0,                //  $16
		0,                //  $17
		C_MODRM,          //  $18
		C_MODRM,          //  $19
		C_MODRM,          //  $1A
		C_MODRM,          //  $1B
		C_DATAW0,         //  $1C
		C_DATAW0,         //  $1D
		0,                //  $1E
		0,                //  $1F
		C_MODRM,          //  $20
		C_MODRM,          //  $21
		C_MODRM,          //  $22
		C_MODRM,          //  $23
		C_DATAW0,         //  $24
		C_DATAW0,         //  $25
		C_PREFIX,         //  $26
		0,                //  $27
		C_MODRM,          //  $28
		C_MODRM,          //  $29
		C_MODRM,          //  $2A
		C_MODRM,          //  $2B
		C_DATAW0,         //  $2C
		C_DATAW0,         //  $2D
		C_PREFIX,         //  $2E
		0,                //  $2F
		C_MODRM,          //  $30
		C_MODRM,          //  $31
		C_MODRM,          //  $32
		C_MODRM,          //  $33
		C_DATAW0,         //  $34
		C_DATAW0,         //  $35
		C_PREFIX,         //  $36
		0,                //  $37
		C_MODRM,          //  $38
		C_MODRM,          //  $39
		C_MODRM,          //  $3A
		C_MODRM,          //  $3B
		C_DATAW0,         //  $3C
		C_DATAW0,         //  $3D
		C_PREFIX,         //  $3E
		0,                //  $3F
    0,                //  $40
		0,                //  $41
		0,                //  $42
		0,                //  $43
		0,                //  $44
		0,                //  $45
		0,                //  $46
		0,                //  $47
		0,                //  $48
		0,                //  $49
		0,                //  $4A
		0,                //  $4B
		0,                //  $4C
		0,                //  $4D
		0,                //  $4E
    0,                //  $4F
    0,                //  $50
    0,                //  $51
    0,                //  $52
    0,                //  $53
    0,                //  $54
    0,                //  $55
    0,                //  $56
    0,                //  $57
    0,                //  $58
    0,                //  $59
    0,                //  $5A
    0,                //  $5B
    0,                //  $5C
    0,                //  $5D
    0,                //  $5E
    0,                //  $5F
    0,                //  $60
    0,                //  $61
		C_MODRM,          //  $62
		C_MODRM,          //  $63
		C_PREFIX,         //  $64
		C_PREFIX,         //  $65
		C_PREFIX+C_66,    //  $66
		C_PREFIX+C_67,    //  $67
		C_DATA66,         //  $68
		C_MODRM+C_DATA66, //  $69
		C_DATA1,          //  $6A
		C_MODRM+C_DATA1,  //  $6B
		0,                //  $6C
		0,                //  $6D
		0,                //  $6E
		0,                //  $6F
		C_DATA1,          //  $70
		C_DATA1,          //  $71
		C_DATA1,          //  $72
    C_DATA1,          //  $73
    C_DATA1,          //  $74
    C_DATA1,          //  $75
    C_DATA1,          //  $76
    C_DATA1,          //  $77
    C_DATA1,          //  $78
    C_DATA1,          //  $79
    C_DATA1,          //  $7A
    C_DATA1,          //  $7B
    C_DATA1,          //  $7C
    C_DATA1,          //  $7D
    C_DATA1,          //  $7E
    C_DATA1,          //  $7F
    C_MODRM+C_DATA1,  //  $80
    C_MODRM+C_DATA66, //  $81
    C_MODRM+C_DATA1,  //  $82
    C_MODRM+C_DATA1,  //  $83
    C_MODRM,          //  $84
    C_MODRM,          //  $85
    C_MODRM,          //  $86
    C_MODRM,          //  $87
    C_MODRM,          //  $88
    C_MODRM,          //  $89
    C_MODRM,          //  $8A
    C_MODRM,          //  $8B
    C_MODRM,          //  $8C
    C_MODRM,          //  $8D
    C_MODRM,          //  $8E
    C_MODRM,          //  $8F
    0,                //  $90
    0,                //  $91
    0,                //  $92
    0,                //  $93
    0,                //  $94
    0,                //  $95
    0,                //  $96
    0,                //  $97
    0,                //  $98
    0,                //  $99
    C_DATA66+C_MEM2,  //  $9A
    0,                //  $9B
    0,                //  $9C
    0,                //  $9D
    0,                //  $9E
    0,                //  $9F
    C_MEM67,          //  $A0
    C_MEM67,          //  $A1
    C_MEM67,          //  $A2
    C_MEM67,          //  $A3
    0,                //  $A4
    0,                //  $A5
    0,                //  $A6
    0,                //  $A7
    C_DATA1,          //  $A8
    C_DATA66,         //  $A9
    0,                //  $AA
    0,                //  $AB
    0,                //  $AC
    0,                //  $AD
    0,                //  $AE
    0,                //  $AF
    C_DATA1,          //  $B0
    C_DATA1,          //  $B1
    C_DATA1,          //  $B2
    C_DATA1,          //  $B3
    C_DATA1,          //  $B4
    C_DATA1,          //  $B5
    C_DATA1,          //  $B6
    C_DATA1,          //  $B7
    C_DATA66,         //  $B8
    C_DATA66,         //  $B9
    C_DATA66,         //  $BA
    C_DATA66,         //  $BB
    C_DATA66,         //  $BC
    C_DATA66,         //  $BD
    C_DATA66,         //  $BE
    C_DATA66,         //  $BF
    C_MODRM+C_DATA1,  //  $C0
    C_MODRM+C_DATA1,  //  $C1
    C_DATA2,          //  $C2
    0,                //  $C3
    C_MODRM,          //  $C4
    C_MODRM,          //  $C5
    C_MODRM+C_DATA66, //  $C6
    C_MODRM+C_DATA66, //  $C7
    C_DATA2+C_DATA1,  //  $C8
    0,                //  $C9
    C_DATA2,          //  $CA
    0,                //  $CB
    0,                //  $CC
    C_DATA1+C_DATA4,  //  $CD
    0,                //  $CE
    0,                //  $CF
    C_MODRM,          //  $D0
    C_MODRM,          //  $D1
    C_MODRM,          //  $D2
    C_MODRM,          //  $D3
    0,                //  $D4
    0,                //  $D5
    0,                //  $D6
    0,                //  $D7
    C_MODRM,          //  $D8
    C_MODRM,          //  $D9
    C_MODRM,          //  $DA
    C_MODRM,          //  $DB
    C_MODRM,          //  $DC
    C_MODRM,          //  $DD
    C_MODRM,          //  $DE
    C_MODRM,          //  $DF
    C_DATA1,          //  $E0
    C_DATA1,          //  $E1
    C_DATA1,          //  $E2
    C_DATA1,          //  $E3
    C_DATA1,          //  $E4
    C_DATA1,          //  $E5
    C_DATA1,          //  $E6
    C_DATA1,          //  $E7
    C_DATA66,         //  $E8
    C_DATA66,         //  $E9
    C_DATA66+C_MEM2,  //  $EA
    C_DATA1,          //  $EB
    0,                //  $EC
    0,                //  $ED
    0,                //  $EE
    0,                //  $EF
    C_PREFIX,         //  $F0
    0,                //  $F1
    C_PREFIX,         //  $F2
    C_PREFIX,         //  $F3
    0,                //  $F4
    0,                //  $F5
    C_FUCKINGTEST,    //  $F6
    C_FUCKINGTEST,    //  $F7
    0,                //  $F8
    0,                //  $F9
    0,                //  $FA
    0,                //  $FB
    0,                //  $FC
    0,                //  $FD
    C_MODRM,          //  $FE
    C_MODRM           //  $FF
  );

  OpcodeFlagsExt: Array [$00..$FF] of ULONG =
  (
    C_MODRM,          //  $00
    C_MODRM,          //  $01
    C_MODRM,          //  $02
    C_MODRM,          //  $03
    C_ERROR,          //  $04
    C_ERROR,          //  $05
    0,                //  $06
    C_ERROR,          //  $07
    0,                //  $08
    0,                //  $09
    0,                //  $0A
    0,                //  $0B
    C_ERROR,          //  $0C
    C_ERROR,          //  $0D
    C_ERROR,          //  $0E
    C_ERROR,          //  $0F
    C_ERROR,          //  $10
    C_ERROR,          //  $11
    C_ERROR,          //  $12
    C_ERROR,          //  $13
		C_ERROR,          //  $14
		C_ERROR,          //  $15
		C_ERROR,          //  $16
		C_ERROR,          //  $17
		C_ERROR,          //  $18
		C_ERROR,          //  $19
		C_ERROR,          //  $1A
		C_ERROR,          //  $1B
		C_ERROR,          //  $1C
		C_ERROR,          //  $1D
		C_ERROR,          //  $1E
		C_ERROR,          //  $1F
		C_ERROR,          //  $20
		C_ERROR,          //  $21
		C_ERROR,          //  $22
		C_ERROR,          //  $23
		C_ERROR,          //  $24
		C_ERROR,          //  $25
		C_ERROR,          //  $26
		C_ERROR,          //  $27
		C_ERROR,          //  $28
		C_ERROR,          //  $29
		C_ERROR,          //  $2A
		C_ERROR,          //  $2B
		C_ERROR,          //  $2C
		C_ERROR,          //  $2D
		C_ERROR,          //  $2E
		C_ERROR,          //  $2F
		C_ERROR,          //  $30
		C_ERROR,          //  $31
		C_ERROR,          //  $32
		C_ERROR,          //  $33
		C_ERROR,          //  $34
		C_ERROR,          //  $35
		C_ERROR,          //  $36
		C_ERROR,          //  $37
		C_ERROR,          //  $38
		C_ERROR,          //  $39
		C_ERROR,          //  $3A
		C_ERROR,          //  $3B
		C_ERROR,          //  $3C
		C_ERROR,          //  $3D
		C_ERROR,          //  $3E
		C_ERROR,          //  $3F
		C_ERROR,          //  $40
		C_ERROR,          //  $41
		C_ERROR,          //  $42
		C_ERROR,          //  $43
		C_ERROR,          //  $44
		C_ERROR,          //  $45
		C_ERROR,          //  $46
		C_ERROR,          //  $47
		C_ERROR,          //  $48
		C_ERROR,          //  $49
		C_ERROR,          //  $4A
		C_ERROR,          //  $4B
		C_ERROR,          //  $4C
		C_ERROR,          //  $4D
		C_ERROR,          //  $4E
		C_ERROR,          //  $4F
		C_ERROR,          //  $50
		C_ERROR,          //  $51
		C_ERROR,          //  $52
		C_ERROR,          //  $53
		C_ERROR,          //  $54
		C_ERROR,          //  $55
		C_ERROR,          //  $56
		C_ERROR,          //  $57
		C_ERROR,          //  $58
		C_ERROR,          //  $59
		C_ERROR,          //  $5A
		C_ERROR,          //  $5B
		C_ERROR,          //  $5C
		C_ERROR,          //  $5D
		C_ERROR,          //  $5E
		C_ERROR,          //  $5F
		C_ERROR,          //  $60
		C_ERROR,          //  $61
		C_ERROR,          //  $62
		C_ERROR,          //  $63
		C_ERROR,          //  $64
		C_ERROR,          //  $65
		C_ERROR,          //  $66
		C_ERROR,          //  $67
		C_ERROR,          //  $68
		C_ERROR,          //  $69
		C_ERROR,          //  $6A
		C_ERROR,          //  $6B
		C_ERROR,          //  $6C
		C_ERROR,          //  $6D
		C_ERROR,          //  $6E
		C_ERROR,          //  $6F
		C_ERROR,          //  $70
		C_ERROR,          //  $71
		C_ERROR,          //  $72
		C_ERROR,          //  $73
		C_ERROR,          //  $74
		C_ERROR,          //  $75
		C_ERROR,          //  $76
		C_ERROR,          //  $77
		C_ERROR,          //  $78
		C_ERROR,          //  $79
		C_ERROR,          //  $7A
		C_ERROR,          //  $7B
		C_ERROR,          //  $7C
		C_ERROR,          //  $7D
		C_ERROR,          //  $7E
		C_ERROR,          //  $7F
    C_DATA66,         //  $80
    C_DATA66,         //  $81
    C_DATA66,         //  $82
    C_DATA66,         //  $83
    C_DATA66,         //  $84
    C_DATA66,         //  $85
    C_DATA66,         //  $86
    C_DATA66,         //  $87
    C_DATA66,         //  $88
    C_DATA66,         //  $89
    C_DATA66,         //  $8A
    C_DATA66,         //  $8B
    C_DATA66,         //  $8C
    C_DATA66,         //  $8D
    C_DATA66,         //  $8E
    C_DATA66,         //  $8F
		C_MODRM,          //  $90
		C_MODRM,          //  $91
		C_MODRM,          //  $92
		C_MODRM,          //  $93
		C_MODRM,          //  $94
		C_MODRM,          //  $95
		C_MODRM,          //  $96
		C_MODRM,          //  $97
		C_MODRM,          //  $98
		C_MODRM,          //  $99
		C_MODRM,          //  $9A
		C_MODRM,          //  $9B
		C_MODRM,          //  $9C
		C_MODRM,          //  $9D
		C_MODRM,          //  $9E
		C_MODRM,          //  $9F
    0,                //  $A0
    0,                //  $A1
    0,                //  $A2
    C_MODRM,          //  $A3
    C_MODRM+C_DATA1,  //  $A4
    C_MODRM,          //  $A5
    C_ERROR,          //  $A6
    C_ERROR,          //  $A7
    0,                //  $A8
    0,                //  $A9
    0,                //  $AA
    C_MODRM,          //  $AB
    C_MODRM+C_DATA1,  //  $AC
    C_MODRM,          //  $AD
    C_ERROR,          //  $AE
    C_MODRM,          //  $AF
    C_MODRM,          //  $B0
    C_MODRM,          //  $B1
    C_MODRM,          //  $B2
    C_MODRM,          //  $B3
    C_MODRM,          //  $B4
    C_MODRM,          //  $B5
    C_MODRM,          //  $B6
    C_MODRM,          //  $B7
    C_ERROR,          //  $B8
    C_ERROR,          //  $B9
    C_MODRM+C_DATA1,  //  $BA
    C_MODRM,          //  $BB
    C_MODRM,          //  $BC
    C_MODRM,          //  $BD
    C_MODRM,          //  $BE
    C_MODRM,          //  $BF
    C_MODRM,          //  $C0
    C_MODRM,          //  $C1
    C_ERROR,          //  $C2
    C_ERROR,          //  $C3
    C_ERROR,          //  $C4
    C_ERROR,          //  $C5
    C_ERROR,          //  $C6
    C_ERROR,          //  $C7
    0,                //  $C8
    0,                //  $C9
    0,                //  $CA
    0,                //  $CB
    0,                //  $CC
    0,                //  $CD
    0,                //  $CE
    0,                //  $CF
    C_ERROR,          //  $D0
    C_ERROR,          //  $D1
    C_ERROR,          //  $D2
    C_ERROR,          //  $D3
    C_ERROR,          //  $D4
    C_ERROR,          //  $D5
    C_ERROR,          //  $D6
    C_ERROR,          //  $D7
    C_ERROR,          //  $D8
    C_ERROR,          //  $D9
    C_ERROR,          //  $DA
    C_ERROR,          //  $DB
    C_ERROR,          //  $DC
    C_ERROR,          //  $DD
    C_ERROR,          //  $DE
    C_ERROR,          //  $DF
    C_ERROR,          //  $E0
    C_ERROR,          //  $E1
    C_ERROR,          //  $E2
    C_ERROR,          //  $E3
    C_ERROR,          //  $E4
    C_ERROR,          //  $E5
    C_ERROR,          //  $E6
    C_ERROR,          //  $E7
    C_ERROR,          //  $E8
    C_ERROR,          //  $E9
    C_ERROR,          //  $EA
    C_ERROR,          //  $EB
    C_ERROR,          //  $EC
    C_ERROR,          //  $ED
    C_ERROR,          //  $EE
    C_ERROR,          //  $EF
    C_ERROR,          //  $F0
    C_ERROR,          //  $F1
    C_ERROR,          //  $F2
    C_ERROR,          //  $F3
    C_ERROR,          //  $F4
    C_ERROR,          //  $F5
    C_ERROR,          //  $F6
    C_ERROR,          //  $F7
    C_ERROR,          //  $F8
    C_ERROR,          //  $F9
    C_ERROR,          //  $FA
    C_ERROR,          //  $FB
    C_ERROR,          //  $FC
    C_ERROR,          //  $FD
    C_ERROR,          //  $FE
    C_ERROR           //  $FF
  );

procedure GetInstLenght(myiptr0: Pointer; osizeptr: PULONG);
function GetProcLength(myiptr0: Pointer): ULONG;

implementation

//  判断指令长度
procedure GetInstLenght(myiptr0: Pointer; osizeptr: PULONG);
label
  prefix;
var
  iptr0, iptr: PBYTE;
  b, bmod, rm: BYTE;
  f: ULONG;
begin
  iptr0 := PBYTE(myiptr0);
  iptr := iptr0;
  f := 0;

prefix:
  b := iptr^;
  Inc(iptr);

  f := OpcodeFlags[b] or f;
  if ((f and C_FUCKINGTEST) > 0) then
  begin
    if ((iptr^ and $38) = 0) then
    begin
      f := C_MODRM + C_DATAW0;     // TEST
    end else
    begin
      f := C_MODRM;				         // NOT,NEG,MUL,IMUL,DIV,IDIV
    end;
  end;

  if ((f and C_TABLE_0F) > 0) then
  begin
    b := iptr^;
    Inc(iptr);
    f := OpcodeFlags[b];
  end;

  if (f = C_ERROR) then
  begin
    osizeptr^ := C_ERROR;
    Exit;
  end;

  if ((f and C_PREFIX) > 0) then
  begin
    f := not C_PREFIX and f;
    goto prefix;
  end;

  if ((f and C_DATAW0) > 0) then
  begin
    if ((b and $01) > 0) then
    begin
      f := C_DATA66 or f;
    end else
    begin
      f := C_DATA1 or f;
    end;
  end;

  if ((f and C_MODRM) > 0) then
  begin
    b := iptr^;
    Inc(iptr);

    bmod := b and $C0;
    rm := b and $07;
    if (bmod <> $C0) then
    begin
      if ((f and C_67) > 0) then    //  modrm16
      begin
        if ((bmod = $00) and (rm = $06)) then f := C_MEM2 or f;
        if (bmod = $40) then f := C_MEM1 or f;
        if (bmod = $80) then f := C_MEM1 or f;
      end else
      begin
        if (bmod = $40) then f := C_MEM1 or f;
        if (bmod = $80) then f := C_MEM4 or f;
        if (rm = $04) then
        begin
          rm := (iptr^) and $07;
          Inc(iptr);
        end;
        if ((rm = $05) and (bmod = $00)) then f := C_MEM4 or f;
      end;
    end;
  end;

  if ((f and C_MEM67) > 0) then
  begin
    if ((f and C_67) > 0) then
    begin
      f := C_MEM2 or f;
    end else
    begin
      f := C_MEM4 or f;
    end;
  end;

  if ((f and C_DATA66) > 0) then
  begin
    if ((f and C_66) > 0) then
    begin
      f := C_DATA2 or f;
    end else
    begin
      f := C_DATA4 or f;
    end;
  end;

  if ((f and C_MEM1) > 0) then Inc(iptr);
  if ((f and C_MEM2) > 0) then Inc(iptr, 2);
  if ((f and C_MEM4) > 0) then Inc(iptr, 4);

  if ((f and C_DATA1) > 0) then Inc(iptr);
  if ((f and C_DATA2) > 0) then Inc(iptr, 2);
  if ((f and C_DATA4) > 0) then Inc(iptr, 4);

  osizeptr^ := ULONG(iptr) - ULONG(iptr0);
end;


//  判断过程长度
function GetProcLength(myiptr0: Pointer): ULONG;
var
  lpFuncProc: Pointer;
  InlineLen, OpCodeLen: ULONG;
begin
  Result := 0;
  lpFuncProc := myiptr0;
  if (lpFuncProc = nil) then Exit;
  InlineLen := 0;
  
  while (True) do
  begin
    GetInstLenght(lpFuncProc, @OpCodeLen);
    case OpCodeLen of

      0:        //  无法解析的指令
      begin
        Result := C_ERROR;
        Break;
      end;

      C_ERROR:  //  无法解析的指令
      begin
        Result := C_ERROR;
        Break;
      end;

      1:        //  判断是否是retn
      begin
        if (PBYTE(lpFuncProc)^ = $C3) then
        begin
          Result := InlineLen + 1;
          Break;
        end;
      end;

      3:        //  ret $0001
      begin
        if (PBYTE(lpFuncProc)^ = $C2) then
        begin
          Result := InlineLen + 3;
          Break;
        end;
      end;
    end;

    Inc(PBYTE(lpFuncProc), OpCodeLen);
    Inc(InlineLen, OpCodeLen);
  end;
end;



end.
