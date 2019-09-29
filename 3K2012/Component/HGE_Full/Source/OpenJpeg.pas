unit OpenJpeg;
{ Partial Delphi interface to the OpenJpeg JPEG 2000 library.
  (See www.openjpeg.org).
  Links in the OpenJpeg object files. }

interface

{$MINENUMSIZE 4}
{$ALIGN ON}

uses
  Windows;

type
  TOPJ_CodecFormat = (
    CodecUnknown = -1,
    CodecJ2K = 0,
    CodecJPT = 1,
    CodecJP2 = 2);

type
  TOPJ_ColorSpace = (
    ClrSpcUnknown = -1,
    ClrSpcSRGB = 1,
    ClrSpcGray = 2,
    ClrSpcSYCC = -3,
    ClrSpcForce32);
    
type
  TOPJ_DParameters = record
    CPReduce: Integer;
    CPLayer: Integer;
    InFile: array [0..MAX_PATH - 1] of Char;
    OutFile: array [0..MAX_PATH - 1] of Char;
    DecodFormat: Integer;
    CodFormat: Integer;
  end;

type
  TOPJ_MsgCallback = procedure(Msg: PChar; ClientData: Pointer); cdecl;
  TOPJ_EventMgr = record
    ErrorHandler: TOPJ_MsgCallback;
    WarningHandler: TOPJ_MsgCallback;
    InfoHandler: TOPJ_MsgCallback;
  end;
  POPJ_EventMgr = ^TOPJ_EventMgr;

type
  TOPJ_CommonStruct = record
    EventMgr: POPJ_EventMgr;
    ClientData: Pointer;
    IsDecompressor: Bool;
    CodecFormat: TOPJ_CodecFormat;
    J2KHandle: Pointer;
    JP2Handle: Pointer;
  end;
  POPJ_CommonStruct = ^TOPJ_CommonStruct;

type
  TOPJ_CIO = record
    CInfo: POPJ_CommonStruct;
    OpenMode: Integer;
    Buffer: PChar;
    Length: Integer;
    Start: PChar;
    End_: PChar;
    BP: PChar;
  end;
  POPJ_CIO = ^TOPJ_CIO;

type
  TOPJ_ImageComp = record
    DX: Integer;
    DY: Integer;
    W: Integer;
    H: Integer;
    X0: Integer;
    Y0: Integer;
    Prec: Integer;
    BPP: Integer;
    Sgnd: Integer;
    ResnoDecoded: Integer; 
    Factor: Integer;
    Data: PIntegerArray;
  end;
  POPJ_ImageComp = ^TOPJ_ImageComp;
  TOPJ_ImageCompArray = array [0..255] of TOPJ_ImageComp;
  POPJ_ImageCompArray = ^TOPJ_ImageCompArray;

type
  TOPJ_Image = record
    X0: Integer;
    Y0: Integer;
    X1: Integer;
    Y1: Integer;
    NumComps: Integer;
    ColorSpace: TOPJ_ColorSpace;
    Comps: POPJ_ImageCompArray;
  end;
  POPJ_Image = ^TOPJ_Image;

type
  TOPJ_DInfo = TOPJ_CommonStruct;
  POPJ_DInfo = POPJ_CommonStruct;

procedure opj_set_default_decoder_parameters(const Parameters: TOPJ_DParameters); cdecl; external;
function cio_tell(CIO: POPJ_CIO): Integer; cdecl; external;
procedure cio_seek(CIO: POPJ_CIO; Pos: Integer); cdecl; external;
procedure opj_image_destroy(Image: POPJ_Image); cdecl; external;
function opj_create_decompress(Format: TOPJ_CodecFormat): POPJ_DInfo; cdecl; external;
procedure opj_destroy_decompress(DInfo: POPJ_DInfo); cdecl; external;
function opj_cio_open(CInfo: POPJ_CommonStruct; Buffer: PByte;
  Length: Integer): POPJ_CIO; cdecl; external;
procedure opj_cio_close(CIO: POPJ_CIO); cdecl; external;
procedure opj_setup_decoder(Info: POPJ_DInfo; const Parameters: TOPJ_DParameters); cdecl; external;
function opj_decode(DInfo: POPJ_DInfo; CIO: POPJ_CIO): POPJ_Image; cdecl; external;

implementation

uses
  SysUtils;

{$LINK Obj\w32bor_pi.obj}
{$LINK Obj\w32bor_openjpeg.obj}
{$LINK Obj\w32bor_j2k_lib.obj}
{$LINK Obj\w32bor_event.obj}
{$LINK Obj\w32bor_cio.obj}
{$LINK Obj\w32bor_image.obj}
{$LINK Obj\w32bor_j2k.obj}
{$LINK Obj\w32bor_jp2.obj}
{$LINK Obj\w32bor_jpt.obj}
{$LINK Obj\w32bor_mqc.obj}
{$LINK Obj\w32bor_raw.obj}
{$LINK Obj\w32bor_bio.obj}
{$LINK Obj\w32bor_tgt.obj}
{$LINK Obj\w32bor_tcd.obj}
{$LINK Obj\w32bor_t1.obj}
{$LINK Obj\w32bor_dwt.obj}
{$LINK Obj\w32bor_t2.obj}
{$LINK Obj\w32bor_mct.obj}

{ Declarations below are used by the JPEG2000 object files }

var
  __turboFloat: LongInt;
  _max_dble: Double;

procedure cio_write; cdecl; external;
procedure cio_skip; cdecl; external;
procedure cio_read; cdecl; external;
procedure cio_numbytesleft; cdecl; external;
procedure cio_getbp; cdecl; external;
procedure opj_image_create0; cdecl; external;
procedure opj_event_msg; cdecl; external;
procedure opj_realloc; cdecl; external;
procedure j2k_destroy_compress; cdecl; external;
procedure bio_write; cdecl; external;
procedure bio_read; cdecl; external;
procedure tgt_create; cdecl; external;
procedure tgt_destroy; cdecl; external;
procedure opj_clock; cdecl; external;
procedure mqc_setcurctx; cdecl; external;
procedure mqc_bypass_enc; cdecl; external;
procedure mqc_encode; cdecl; external;
procedure raw_decode; cdecl; external;
procedure mqc_decode; cdecl; external;
procedure mqc_resetstates; cdecl; external;
procedure mqc_setstate; cdecl; external;
procedure mqc_init_enc; cdecl; external;
procedure mqc_segmark_enc; cdecl; external;
procedure mqc_flush; cdecl; external;
procedure mqc_bypass_init_enc; cdecl; external;
procedure mqc_restart_init_enc; cdecl; external;
procedure mqc_numbytes; cdecl; external;
procedure mqc_reset_enc; cdecl; external;
procedure mqc_erterm_enc; cdecl; external;
procedure raw_init_dec; cdecl; external;
procedure mqc_init_dec; cdecl; external;
procedure mqc_create; cdecl; external;
procedure raw_create; cdecl; external;
procedure mqc_destroy; cdecl; external;
procedure raw_destroy; cdecl; external;
procedure tgt_reset; cdecl; external;
procedure tgt_setvalue; cdecl; external;
procedure bio_create; cdecl; external;
procedure bio_init_enc; cdecl; external;
procedure tgt_encode; cdecl; external;
procedure bio_flush; cdecl; external;
procedure bio_numbytes; cdecl; external;
procedure bio_destroy; cdecl; external;
procedure bio_init_dec; cdecl; external;
procedure bio_inalign; cdecl; external;
procedure tgt_decode; cdecl; external;
procedure pi_create; cdecl; external;
procedure pi_next; cdecl; external;
procedure pi_destroy; cdecl; external;

const
  MSVCRT = 'msvcrt.dll';

function _ftol(X: Single): LongInt; cdecl; external MSVCRT;
function vsprintf(S, Format: PChar): Integer; cdecl; varargs; external MSVCRT;
function fprintf(F: Pointer; Format: PChar): Integer; cdecl; varargs; external MSVCRT;
function fopen(FileName, Mode: PChar): Pointer; cdecl; external MSVCRT;
function fclose(F: Pointer): Integer; cdecl; external MSVCRT;
function printf(Format: PChar): Integer; cdecl; varargs; external MSVCRT;

procedure _llmul; cdecl;
// Copied from System.pas
asm
  push  edx
  push  eax

  mov   eax, [esp+16]
  mul   dword ptr [esp]
  mov   ecx, eax

  mov   eax, [esp+4]
  mul   dword ptr [esp+12]
  add   ecx, eax

  mov   eax, [esp]
  mul   dword ptr [esp+12]
  add   edx, ecx

  pop   ecx
  pop   ecx

  ret     8
end;

function floor(const X: Double): Double; cdecl;
begin
  Result := Trunc(X);
  if Frac(X) < 0.0 then
    Result := Result - 1.0;
end;

function ceil(const Num: Double): Double; cdecl;
begin
  Result := Trunc(Num);
  if Frac(Num) > 0.0 then
    Result := Result + 1;
end;

function memset(S: Pointer; C, N: Integer): Pointer; cdecl;
begin
  FillChar(S^,N,C);
  Result := S;
end;

function strlen(S: PChar): Integer; cdecl;
begin
  Result := SysUtils.StrLen(S);
end;

function memcpy(S1, S2: Pointer; N: Integer): Pointer; cdecl;
begin
 Move(S2^,S1^,N);
 Result := S1;
end;

function malloc(Size: Integer): Pointer; cdecl;
begin
  GetMem(Result, Size);
end;

function realloc(Ptr: Pointer; Size: Integer): Pointer; cdecl;
begin
  ReallocMem(Ptr, Size);
  Result := Ptr;
end;

procedure free(Ptr: Pointer); cdecl;
begin
  FreeMem(Ptr);
end;

function pow(const Base, Exponent: Double): Double; cdecl;
begin
  if Exponent = 0.0 then
    Result := 1.0
  else if (Base = 0.0) and (Exponent > 0.0) then
    Result := 0.0
  else
    Result := Exp(Exponent * Ln(Base));
end;

function fabs(const Num: Double): Double; cdecl;
begin
  Result := Abs(Num);
end;

end.
