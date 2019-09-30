{.$define demo}
//----------------------------------------------------------------------------------------------------------------------
// Include file to determine which compiler is currently being used to build the project/component.
// This file uses ideas from Brad Stowers DFS.inc file (www.delphifreestuff.com).
//
// Portions created by Mike Lischke are Copyright
// (C) 1999-2002 Dipl. Ing. Mike Lischke. All Rights Reserved.
//----------------------------------------------------------------------------------------------------------------------
// The following symbols are defined:
//
// COMPILER_1    : Kylix/Delphi/BCB 1.x is the compiler.
// COMPILER_1_UP : Kylix/Delphi/BCB 1.x or higher is the compiler.
// COMPILER_2    : Kylix/Delphi 2.x or BCB 1.x is the compiler.
// COMPILER_2_UP : Kylix/Delphi 2.x or higher, or BCB 1.x or higher is the compiler.
// COMPILER_3    : Kylix/Delphi/BCB 3.x is the compiler.
// COMPILER_3_UP : Kylix/Delphi/BCB 3.x or higher is the compiler.
// COMPILER_4    : Kylix/Delphi/BCB 4.x is the compiler.
// COMPILER_4_UP : Kylix/Delphi/BCB 4.x or higher is the compiler.
// COMPILER_5    : Kylix/Delphi/BCB 5.x is the compiler.
// COMPILER_5_UP : Kylix/Delphi/BCB 5.x or higher is the compiler.
// COMPILER_6    : Kylix/Delphi/BCB 6.x is the compiler.
// COMPILER_6_UP : Kylix/Delphi/BCB 6.x or higher is the compiler.
// COMPILER_7    : Kylix/Delphi/BCB 7.x is the compiler.
// COMPILER_7_UP : Kylix/Delphi/BCB 7.x or higher is the compiler.
//
// Only defined if Windows is the target:
// CPPB        : Any version of BCB is being used.
// CPPB_1      : BCB v1.x is being used.
// CPPB_3      : BCB v3.x is being used.
// CPPB_3_UP   : BCB v3.x or higher is being used.
// CPPB_4      : BCB v4.x is being used.
// CPPB_4_UP   : BCB v4.x or higher is being used.
// CPPB_5      : BCB v5.x is being used.
// CPPB_5_UP   : BCB v5.x or higher is being used.
// CPPB_6      : BCB v6.x is being used.
// CPPB_6_UP   : BCB v6.x or higher is being used.
//
// Only defined if Windows is the target:
// DELPHI      : Any version of Delphi is being used.
// DELPHI_1    : Delphi v1.x is being used.
// DELPHI_2    : Delphi v2.x is being used.
// DELPHI_2_UP : Delphi v2.x or higher is being used.
// DELPHI_3    : Delphi v3.x is being used.
// DELPHI_3_UP : Delphi v3.x or higher is being used.
// DELPHI_4    : Delphi v4.x is being used.
// DELPHI_4_UP : Delphi v4.x or higher is being used.
// DELPHI_5    : Delphi v5.x is being used.
// DELPHI_5_UP : Delphi v5.x or higher is being used.
// DELPHI_6    : Delphi v6.x is being used.
// DELPHI_6_UP : Delphi v6.x or higher is being used.
// DELPHI_7    : Delphi v7.x is being used.
// DELPHI_7_UP : Delphi v7.x or higher is being used.
//
// Only defined if Linux is the target:
// KYLIX       : Any version of Kylix is being used.
// KYLIX_1     : Kylix 1.x is being used.
// KYLIX_1_UP  : Kylix 1.x or higher is being used.
// KYLIX_2     : Kylix 2.x is being used.
// KYLIX_2_UP  : Kylix 2.x or higher is being used.
// KYLIX_3     : Kylix 3.x is being used.
// KYLIX_3_UP  : Kylix 3.x or higher is being used.
//
// Only defined if Linux is the target:
// QT_CLX      : Trolltech's QT library is being used.
//----------------------------------------------------------------------------------------------------------------------

{$ifdef Win32}
  {$IFDEF VER210}         // Delphi 2010
    {$define COMPILER_12}
    {$ifdef BCB}
      {$define CPPB}
      {$define CPPB_6}
    {$else}
      {$define DELPHI}
      {$define DELPHI_11}
      {$define DELPHI_6_UP}
    {$endif}
  {$endif}

  {$IFDEF VER200}         // Delphi 2009
    {$define COMPILER_12}
    {$ifdef BCB}
      {$define CPPB}
      {$define CPPB_6}
    {$else}
      {$define DELPHI}
      {$define DELPHI_11}
      {$define DELPHI_6_UP}
    {$endif}
  {$endif}

  {$IFDEF VER190}         // Delphi 9
    {$define COMPILER_11}
    {$ifdef BCB}
      {$define CPPB}
      {$define CPPB_6}
    {$else}
      {$define DELPHI}
      {$define DELPHI_11}
      {$define DELPHI_6_UP}
    {$endif}
  {$endif}
  {$IFDEF VER180}         // Delphi 9
    {$define COMPILER_10}
    {$ifdef BCB}
      {$define CPPB}
      {$define CPPB_6}
    {$else}
      {$define DELPHI}
      {$define DELPHI_10}
    {$endif}
  {$endif}
  {$IFDEF VER170}         // Delphi 9
    {$define COMPILER_9}
    {$define DELPHI}
    {$define DELPHI_9}
  {$endif}

  {$ifdef VER150}
    {$define COMPILER_7}
    {$define DELPHI}
    {$define DELPHI_7}
  {$endif}

  {$ifdef VER140}
    {$define COMPILER_6}
    {$ifdef BCB}
      {$define CPPB}
      {$define CPPB_6}
    {$else}
      {$define DELPHI}
      {$define DELPHI_6}
    {$endif}
  {$endif}

  {$ifdef VER130}
    {$define COMPILER_5}
    {$ifdef BCB}
      {$define CPPB}
      {$define CPPB_5}
    {$else}
      {$define DELPHI}
      {$define DELPHI_5}
    {$endif}
  {$endif}

  {$ifdef VER125}
    {$define COMPILER_4}
    {$define CPPB}
    {$define CPPB_4}
  {$endif}

  {$ifdef VER120}
    {$define COMPILER_4}
    {$define DELPHI}
    {$define DELPHI_4}
  {$endif}

  {$ifdef VER110}
    {$define COMPILER_3}
    {$define CPPB}
    {$define CPPB_3}
  {$endif}

  {$ifdef VER100}
    {$define COMPILER_3}
    {$define DELPHI}
    {$define DELPHI_3}
  {$endif}

  {$ifdef VER93}
    {$define COMPILER_2} // BCB v1 compiler is really v2
    {$define CPPB}
    {$define CPPB_1}
  {$endif}

  {$ifdef VER90}
    {$define COMPILER_2}
    {$define DELPHI}
    {$define DELPHI_2}
  {$endif}

  {$ifdef VER80}
    {$define COMPILER_1}
    {$define DELPHI}
    {$define DELPHI_1}
  {$endif}

{$else (not Windows)}
  // Linux is the target
  {$define QT_CLX}

  {$ifdef VER150}
    {$define COMPILER_7}
    {$ifdef BCB}
      please tell milan_va@seznam.cz it works, then delete this line
      {$define KYLIXC}
      {$define KYLIXC_2}
    {$else}
      {$define KYLIX}
      {$define KYLIX_2}
    {$endif}
  {$endif}

  {$ifdef VER140}
    {$define COMPILER_6}
    {$ifdef BCB}
      please tell milan_va@seznam.cz it works, then delete this line
      {$define KYLIXC}
      {$define KYLIXC_1}
    {$else}
      {$define KYLIX}
      {$define KYLIX_1}
    {$endif}
  {$endif}

{$endif (Win32)}

{$ifdef COMPILER_1}
  {$define COMPILER_1_UP}
{$endif}

{$ifdef COMPILER_2}
  {$define COMPILER_1_UP}
  {$define COMPILER_2_UP}
{$endif}

{$ifdef COMPILER_3}
  {$define COMPILER_1_UP}
  {$define COMPILER_2_UP}
  {$define COMPILER_3_UP}
{$endif}

{$ifdef COMPILER_4}
  {$define COMPILER_1_UP}
  {$define COMPILER_2_UP}
  {$define COMPILER_3_UP}
  {$define COMPILER_4_UP}
{$endif}

{$ifdef COMPILER_5}
  {$define COMPILER_1_UP}
  {$define COMPILER_2_UP}
  {$define COMPILER_3_UP}
  {$define COMPILER_4_UP}
  {$define COMPILER_5_UP}
{$endif}

{$ifdef COMPILER_6}
  {$define COMPILER_1_UP}
  {$define COMPILER_2_UP}
  {$define COMPILER_3_UP}
  {$define COMPILER_4_UP}
  {$define COMPILER_5_UP}
  {$define COMPILER_6_UP}
{$endif}

{$ifdef COMPILER_7}
  {$define COMPILER_1_UP}
  {$define COMPILER_2_UP}
  {$define COMPILER_3_UP}
  {$define COMPILER_4_UP}
  {$define COMPILER_5_UP}
  {$define COMPILER_6_UP}
  {$define COMPILER_7_UP}
{$endif}

{$ifdef DELPHI_2}
  {$define DELPHI_2_UP}
{$endif}

{$ifdef DELPHI_3}
  {$define DELPHI_2_UP}
  {$define DELPHI_3_UP}
{$endif}

{$ifdef DELPHI_4}
  {$define DELPHI_2_UP}
  {$define DELPHI_3_UP}
  {$define DELPHI_4_UP}
{$endif}

{$ifdef DELPHI_5}
  {$define DELPHI_2_UP}
  {$define DELPHI_3_UP}
  {$define DELPHI_4_UP}
  {$define DELPHI_5_UP}
{$endif}

{$ifdef DELPHI_6}
  {$define DELPHI_2_UP}
  {$define DELPHI_3_UP}
  {$define DELPHI_4_UP}
  {$define DELPHI_5_UP}
  {$define DELPHI_6_UP}
{$endif}

{$ifdef DELPHI_7}
  {$define DELPHI_2_UP}
  {$define DELPHI_3_UP}
  {$define DELPHI_4_UP}
  {$define DELPHI_5_UP}
  {$define DELPHI_6_UP}
  {$define DELPHI_7_UP}
{$endif}

{$ifdef DELPHI_9}
  {$define DELPHI_2_UP}
  {$define DELPHI_3_UP}
  {$define DELPHI_4_UP}
  {$define DELPHI_5_UP}
  {$define DELPHI_6_UP}
  {$define DELPHI_7_UP}
{$endif}

{$ifdef DELPHI_10}
  {$define DELPHI_2_UP}
  {$define DELPHI_3_UP}
  {$define DELPHI_4_UP}
  {$define DELPHI_5_UP}
  {$define DELPHI_6_UP}
  {$define DELPHI_7_UP}
{$endif}

{$ifdef CPPB_3}
  {$define CPPB_3_UP}
{$endif}

{$ifdef CPPB_4}
  {$define CPPB_3_UP}
  {$define CPPB_4_UP}
{$endif}

{$ifdef CPPB_5}
  {$define CPPB_3_UP}
  {$define CPPB_4_UP}
  {$define CPPB_5_UP}
{$endif}

{$ifdef CPPB_6}
  {$define CPPB_3_UP}
  {$define CPPB_4_UP}
  {$define CPPB_5_UP}
  {$define CPPB_6_UP}
{$endif}

{$ifdef KYLIX_1}
  {$define KYLIX_1_UP}
{$endif}

{$ifdef KYLIX_2}
  {$define KYLIX_1_UP}
  {$define KYLIX_2_UP}
{$endif}

{$ifdef KYLIXC_1}
  {$define KYLIXC_1_UP}
{$endif}

{$ifdef KYLIXC_2}
  {$define KYLIXC_1_UP}
  {$define KYLIXC_2_UP}
{$endif}

{$ifdef CPPB_3_UP}
  // C++ Builder requires this if you use Delphi components in run-time packages.
  {$ObjExportAll On}
{$endif}

//----------------------------------------------------------------------------------------------------------------------

