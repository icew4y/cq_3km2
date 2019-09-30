{*********************************************************}
{*                     umDefines.INC                     *}
{*      Assorted conditional compilation directives      *}
{*      Copyright (c) UtilMind Solutions 1998-2001       *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$IFNDEF VER80}          {Delphi 1}
 {$IFNDEF VER90}         {Delphi 2}
  {$IFNDEF VER93}        {BCB 1}
   {$DEFINE D3}          {* Delphi 3 or higher}
   {$IFNDEF VER100}      {Delphi 3}
    {$IFNDEF VER110}     {BCB 3}
     {$DEFINE D4}        {* Delphi 4 or higher}
     {$IFNDEF VER120}    {Delphi 4}
      {$IFNDEF VER125}   {BCB 4}
       {$DEFINE D5}      {* Delphi 5 or higher}
       {$IFNDEF VER130}  {Delphi/BCB 5}
        {$ObjExportAll On}
        {$WARN SYMBOL_PLATFORM OFF}
        {$DEFINE D6}     {* Delphi 6 or higher}
        {$IFNDEF VER140}  {Delphi/BCB 6}
         {$DEFINE D7}
         {$IFNDEF VER150} {Delphi/BCB 7}
           { * delphi 8? * }
         {$ENDIF}
        {$ENDIF}
       {$ELSE}
         {$DEFINE D5ONLY}
       {$ENDIF}
      {$ENDIF}
     {$ENDIF}
    {$ENDIF}
   {$ENDIF}
  {$ENDIF}
 {$ENDIF}
{$ENDIF}

{$IFDEF VER93}  // BCB1 and BCB3 does not supports WinInet 4 functions
  {$DEFINE IE3}
  {$DEFINE LowerCB5}
{$ENDIF}
{$IFDEF VER110}
  {$DEFINE IE3}
  {$DEFINE LowerCB5}
{$ENDIF}
{$IFDEF VER125}
  {$DEFINE LowerCB5}
{$ENDIF}

{$IFNDEF D3} // For Delphi 2 & BCB 1 only
  {$DEFINE NO_COM_CLEANUP}
{$ENDIF}

{$R-}

// {$DEFINE TRIAL}
