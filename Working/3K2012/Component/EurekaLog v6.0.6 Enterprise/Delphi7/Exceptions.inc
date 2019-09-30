{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{                 Include file                   }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

//{$DEFINE EUREKALOG_DEMO}
{$DEFINE PROFESSIONAL} // Comment only for Standard version.
//{$DEFINE DUNIT}

{$R-} // Disable Range-Checks.
{$Q-} // Disable Overflow-Checks.
{$B-} // Disable Complete-Boolean evaluation.
{$T-} // Disable Typed-Pointer generation.
{$U-} // Disable Safe-Divide generation.
{$J-} // Disable Assignable-Typed-Constant.
{$A+} // Enable Record-Field-Alignment.
{$X+} // Enable Extended-Syntax.
{$V+} // Enable Strict-Var-Strings.
{$P+} // Enable Open-Parameters.
{$H+} // Enable Huge-Strings.
{$C+} // Enable Assertions.
{$Z1} // Set MinEnumSize=1 byte.
{$D+} // Enable Debug-Infos generation (for internal Debugging).

{$IFNDEF DUNIT}
  {$W-} // Disable Stack-Frames generation.
  {$O+} // Enable Optimization.
{$ELSE}
  {$W+} // Enable Stack-Frames generation.
  {$O-} // Disable Optimization.
{$ENDIF}

// Delphi/C++Builder DEFINE directives...

// Experimental...
{$IFDEF VER125} // C++ Builder 4.0
  {$DEFINE VER120} // Simulate Delphi 4
{$ENDIF}

{$IFDEF VER100} // Delphi 3.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi3}
  {$DEFINE Delphi3Down}
  {$DEFINE Delphi4Down}
  {$DEFINE Delphi5Down}
  {$DEFINE Delphi6Down}
  {$DEFINE Delphi7Down}
  {$DEFINE Delphi8Down}
  {$DEFINE Delphi9Down}
{$ENDIF}

{$IFDEF VER120} // Delphi 4.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi4}
  {$DEFINE Delphi4Down}
  {$DEFINE Delphi5Down}
  {$DEFINE Delphi6Down}
  {$DEFINE Delphi7Down}
  {$DEFINE Delphi8Down}
  {$DEFINE Delphi9Down}
{$ENDIF}

{$IFDEF VER130} // Delphi 5.0 - C++Builder 5
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi5}
  {$DEFINE Delphi5Down}
  {$DEFINE Delphi6Down}
  {$DEFINE Delphi7Down}
  {$DEFINE Delphi8Down}
  {$DEFINE Delphi9Down}
{$ENDIF}

{$IFDEF VER140} // Delphi 6.0 - C++Builder 6
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi6}
  {$DEFINE Delphi6Down}
  {$DEFINE Delphi7Down}
  {$DEFINE Delphi8Down}
  {$DEFINE Delphi9Down}
{$ENDIF}

{$IFDEF VER150} // Delphi 7.0
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi7}
  {$DEFINE Delphi7Down}
  {$DEFINE Delphi8Down}
  {$DEFINE Delphi9Down}
{$ENDIF}

{$IFDEF VER170} // Delphi 9.0 - 2005
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi9}
  {$DEFINE Delphi9Down}
  {$DEFINE EurekaLog_XML_Options}
{$ENDIF}

{$IFDEF VER180} // Delphi 10.0 - 2006
  {$IFNDEF VER185} // Delphi 11.0 - 2007
    {$DEFINE Delphi3Up}
    {$DEFINE Delphi4Up}
    {$DEFINE Delphi5Up}
    {$DEFINE Delphi6Up}
    {$DEFINE Delphi7Up}
    {$DEFINE Delphi8Up}
    {$DEFINE Delphi9Up}
    {$DEFINE Delphi10Up}
    {$DEFINE Delphi10}
    {$DEFINE Delphi10Down}
    {$DEFINE EurekaLog_XML_Options}
  {$ENDIF}
{$ENDIF}

{$IFDEF VER185} // Delphi 11.0 - 2007
  {$DEFINE Delphi3Up}
  {$DEFINE Delphi4Up}
  {$DEFINE Delphi5Up}
  {$DEFINE Delphi6Up}
  {$DEFINE Delphi7Up}
  {$DEFINE Delphi8Up}
  {$DEFINE Delphi9Up}
  {$DEFINE Delphi10Up}
  {$DEFINE Delphi11Up}
  {$DEFINE Delphi11}
  {$DEFINE Delphi11Down}
{$ENDIF}

{$IFDEF BCB} // C++Builder
  {$DEFINE CBuilder}
  {$OBJEXPORTALL On}
  {$DEFINE EurekaLog_XML_Options}
{$ELSE}
  {$DEFINE Delphi}
{$ENDIF}

{$IFNDEF CBuilder} // Use Win32 INI file
  {$IFDEF Delphi7Down}
    {$DEFINE UseIniFile}
  {$ENDIF}
{$ENDIF}

// Disable "Special" Warnings Messages...
{$IFDEF Delphi6Up}
  {$WARN SYMBOL_PLATFORM OFF}   // Disable General Platform Warning Messages.
  {$WARN UNIT_PLATFORM OFF}     // Disable Unit Platform Warning Messages.
  {$WARN UNIT_DEPRECATED OFF}   // Disable Unit Deprecated Warning Messages.
  {$WARN SYMBOL_DEPRECATED OFF} // Disable Symbol Deprecated Warning Messages.
  {$IFDEF Delphi7Up}
    {$WARN UNSAFE_CODE OFF} // Disable Unsafe Code Warning Messages.
    {$WARN UNSAFE_TYPE OFF} // Disable Unsafe Type Warning Messages.
    {$WARN UNSAFE_CAST OFF} // Disable Unsafe TypeCast Warning Messages.
  {$ENDIF}
{$ENDIF}
