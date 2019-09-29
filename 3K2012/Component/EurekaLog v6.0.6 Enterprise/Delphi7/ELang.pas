{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{      International Languages Unit - ELang      }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit ELang;

{$I Exceptions.inc}

interface

uses Windows;

function UserCharSet: Cardinal;

implementation

uses SysUtils;

function TranslateCharsetInfo(lpSrc: PDWORD; var lpCs: TCharsetInfo;
  dwFlags: DWORD): BOOL; stdcall; external gdi32 name 'TranslateCharsetInfo';

function UserCharSet: Cardinal;
var
  C: TCharsetInfo;
  Buf: array[0..6] of AnsiChar;
  CodePage: DWord;
begin
  Buf := '';
  GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IDEFAULTANSICODEPAGE, Buf, 6);
  CodePage := StrToIntDef(Buf, GetACP);
  TranslateCharsetInfo(PDWord(CodePage), C, TCI_SRCCODEPAGE);
  Result := C.ciCharset;
end;

{function CharSetToCodePage(Charset: DWord): Cardinal;
var
  C: TCharsetInfo;
begin
  TranslateCharsetInfo(PDWord(Charset), C, TCI_SRCCHARSET);
  Result := C.ciACP
end;

function LanguageStringToWideString(const S: string; Charset: DWord): WideString;
var
  L: Integer;
  CodePage: Cardinal;
begin
  CodePage := CharSetToCodePage(Charset);
  L := MultiByteToWideChar(CodePage, 0, PChar(S), -1, nil, 0);
  SetLength(Result, L - 1);
  MultiByteToWideChar(CodePage, 0, PChar(S), -1, PWideChar(Result), L - 1);
end;

function LanguageMessageBox(hWnd: HWND; lpText, lpCaption: PChar; uType: UINT): Integer;
begin
  Result := MessageBoxW(hWnd,
    PWideChar(LanguageStringToWideString(lpText, UserCharSet)),
    PWideChar(LanguageStringToWideString(lpCaption, UserCharSet)),
    uType);
end;}

end.

