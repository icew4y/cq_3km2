{              ranlib.pas                                  Agner Fog 2001-10-23

Pascal unit for linking assembled random number generator library into
Borland Delphi project.

The .obj files contain assembled code optimized for speed. Works in Windows
95 and later, as well as other systems running on an Intel-compatible
microprocessor in 32-bit mode.

This file has been tested with Borland Delphi version 6.0. For other versions
of Pascal and Delphi, you need the appropriate LINK statements to link in the
.obj files and the external function declarations.

Example of use:
-------------------------------------------------------------------------------
uses
  ranlib,
  SysUtils;

var seed, i: integer;
var s: string;

begin

  seed := Round(Time()*3600000.0);

  WRandomInit(seed);

  for i := 1 to 20 do begin
    Writeln(WRandom(), '  ', WIRandom(0,99));
  end;

  Writeln('');
  Read(s);

end.
-------------------------------------------------------------------------------
}

unit ranlib;

interface
{link in external functions:}

{$LINK motrot.obj}
{$LINK mother32.obj}
{$LINK ranrot32.obj}

{declare external functions:}
procedure XRandomInit(seed:Integer); cdecl; external;
function XRandom():Double; cdecl; external;
function XIRandom(min:Integer; max:Integer): Integer; cdecl; external;

procedure WRandomInit(seed:Integer); cdecl; external;
function WRandom():Double; cdecl; external;
function WIRandom(min:Integer; max:Integer): Integer; cdecl; external;

procedure MRandomInit(seed:Integer); cdecl; external;
function MRandom():Double; cdecl; external;

implementation

end.
