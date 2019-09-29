{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{             Version Strings file               }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

{$I Exceptions.inc}

{$IFDEF Delphi3}
const
  RADVersionString = '3.0';
  Real_RADVersionString = RADVersionString;
  VCL = 'VCL30.DPL';
  INDY = '';
  IniAppendLine = '';
  CreateFileA_Module = VCL;
{$ENDIF}

{$IFDEF Delphi4}
const
  RADVersionString = '4.0';
  Real_RADVersionString = RADVersionString;
  VCL = 'VCL40.BPL';
  INDY = 'INDY40.BPL';
  IniAppendLine = '';
  CreateFileA_Module = VCL;
  LoadLibraryExA_Module = 'CORIDE40.BPL';
{$ENDIF}

{$IFDEF Delphi5}
const
  RADVersionString = '5.0';
  Real_RADVersionString = RADVersionString;
  VCL = 'VCL50.BPL';
  INDY = 'INDY50.BPL';
  {$IFDEF CBuilder}
    IniAppendLine = '</IDEOPTIONS>';
  {$ELSE}
    IniAppendLine = '';
  {$ENDIF}
  CreateFileA_Module = VCL;
  LoadLibraryExA_Module = 'CORIDE50.BPL';
{$ENDIF}

{$IFDEF Delphi6}
const
  RADVersionString = '6.0';
  Real_RADVersionString = RADVersionString;
  VCL = 'VCL60.BPL';
  CLX = 'VISUALCLX60.BPL';
  INDY = 'INDY60.BPL';
  {$IFDEF CBuilder}
    IniAppendLine = '</IDEOPTIONS>';
  {$ELSE}
    IniAppendLine = '';
  {$ENDIF}
  CreateFileA_Module = 'RTL60.BPL';
  LoadLibraryExA_Module = 'COREIDE60.BPL';
{$ENDIF}

{$IFDEF Delphi7}
const
  RADVersionString = '7.0';
  Real_RADVersionString = RADVersionString;
  VCL = 'VCL70.BPL';
  CLX = 'VISUALCLX70.BPL';
  INDY = 'INDY70.BPL';
  IniAppendLine = '';
  CreateFileA_Module = 'RTL70.BPL';
  LoadLibraryExA_Module = 'COREIDE70.BPL';
{$ENDIF}

{$IFDEF Delphi9}
const
  RADVersionString = '3.0';
  Real_RADVersionString = '9.0';
  VCL = 'VCL90.BPL';
  CLX = 'VISUALCLX90.BPL'; // CLX unsupported ???
  INDY = 'INDY90.BPL';
  IniAppendLine = '</BorlandProject>';
  CreateFileA_Module = 'RTL90.BPL';
  LoadLibraryExA_Module = 'COREIDE90.BPL';
{$ENDIF}

{$IFDEF Delphi10}
const
  RADVersionString = '4.0';
  Real_RADVersionString = '10.0';
  VCL = 'VCL100.BPL';
  CLX = 'VISUALCLX100.BPL'; // CLX unsupported ???
  INDY = 'INDY90.BPL';
  IniAppendLine = '</BorlandProject>';
  CreateFileA_Module = 'RTL100.BPL';
  LoadLibraryExA_Module = 'COREIDE100.BPL';
{$ENDIF}

{$IFDEF Delphi11}
const
  RADVersionString = '5.0';
  Real_RADVersionString = '11.0';
  VCL = 'VCL100.BPL';
  CLX = 'VISUALCLX100.BPL'; // CLX unsupported ???
  INDY = 'INDY100.BPL';
  IniAppendLine = '';
  CreateFileA_Module = 'RTL100.BPL';
  LoadLibraryExA_Module = 'COREIDE100.BPL';
{$ENDIF}

{$IFNDEF CBuilder}
  {$IFDEF Delphi9Up}
    RADRegKeyName = 'BDS';
    RADExeName = 'BDS.EXE';
    DEFINEDirName = 'BDS';
  {$ELSE}
    RADRegKeyName = 'Delphi';
    RADExeName = 'DELPHI32.EXE';
    DEFINEDirName = 'DELPHI';
  {$ENDIF}
  DefaultSourceExt = '.pas';
  InstallDirName = 'Delphi';
{$ELSE}
  {$IFDEF Delphi10Up}
    RADRegKeyName = 'BDS';
    RADExeName = 'BDS.EXE';
    DEFINEDirName = 'BDS';
  {$ELSE}
    RADRegKeyName = 'C++Builder';
    RADExeName = 'BCB.EXE';
    DEFINEDirName = 'BCB';
  {$ENDIF}
  DefaultSourceExt = '.cpp';
  InstallDirName = 'CBuilder';
{$ENDIF}

{$IFDEF CBuilder}
  {$IFDEF Delphi5}
    CppBuilderRTLVer = '50';
  {$ENDIF}
  {$IFDEF Delphi6}
    CppBuilderRTLVer = '60';
  {$ENDIF}
  {$IFDEF Delphi10}
    CppBuilderRTLVer = '70';
  {$ENDIF}
  {$IFDEF Delphi11}
    CppBuilderRTLVer = '80';
  {$ENDIF}
{$ENDIF}

