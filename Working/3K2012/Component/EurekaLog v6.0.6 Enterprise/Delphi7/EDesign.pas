{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{      Design-Time functions Unit - EDesign      }
{                                                }
{  Copyright (c) 2001 - 2005 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EDesign;

{$I Exceptions.inc}

interface

uses Controls;

procedure AdjustFontLanguage(Cnt: TWinControl);
procedure ShowHelp(Topic: string);
procedure ShowLog(const FileName: string);
function BaseDir: string;
function PackagePath: string;
procedure ShowTutorial;

implementation

uses Windows, Graphics, SysUtils, ShellAPI, ExtCtrls, EConsts, ELang, ECore;

type
  TInternalControl = class(TControl)
  end;

procedure ChangeCharset(P: TWinControl);
var
  i: integer;

  procedure SetSingle(Cnt: TControl);
  var
    LogFont: TLogFont;

    function FontFamily(FontName: string): Integer;
    var
      DC: THandle;
      Font: TLogFont;

      function EnumFontFamProc(var EnumLogFont: TEnumLogFontEx; var TextMetric:
        Pointer; FontType: Integer; Param: PInteger): Integer; stdcall;
      begin
        Result := 0;
        Param^ := EnumLogFont.elfLogFont.lfPitchAndFamily;
      end;

    begin
      Result := 0;
      DC := GetDC(0);
      FillChar(Font, SizeOf(Font), #0);
      StrPCopy(Font.lfFaceName, FontName);
      EnumFontFamiliesEx(DC, Font, @EnumFontFamProc, Integer(@Result), 0);
      ReleaseDC(0, DC);
    end;

  begin
    if not TInternalControl(Cnt).ParentFont then
    begin
      GetObject(TInternalControl(Cnt).Font.Handle, SizeOf(LogFont), @LogFont);
      with LogFont do
      begin
        TInternalControl(Cnt).Font.Handle :=
          CreateFont(lfHeight,
          lfWidth,
          lfEscapement,
          lfOrientation,
          lfWeight, // Bold style.
          lfItalic,
          lfUnderline,
          lfStrikeOut,
          DEFAULT_CHARSET,
          lfOutPrecision,
          lfClipPrecision,
          lfQuality,
          FontFamily(lfFaceName),
          lfFaceName);
      end;
    end;
  end;

begin
  SetSingle(P);
  for i := 0 to P.ControlCount - 1 do
  begin
    if P.Controls[i] is TWinControl then
      ChangeCharset(TWinControl(P.Controls[i]));
  end;
end;

procedure AdjustFontLanguage(Cnt: TWinControl);

{$IFDEF Delphi7Up}
  procedure AdjustXPThemeSupport(Cnt: TControl);
  var
    i: Integer;
    WCnt: TWinControl;
  begin
    if (Cnt is TPanel) then TPanel(Cnt).ParentBackground := False;
    if (Cnt is TWinControl) then
    begin
      WCnt := TWinControl(Cnt);
      for i := 0 to WCnt.ControlCount - 1 do
        AdjustXPThemeSupport(WCnt.Controls[i]);
    end;
  end;
{$ENDIF}

begin
  ChangeCharset(Cnt);
{$IFDEF Delphi7Up}
  AdjustXPThemeSupport(Cnt);
{$ENDIF}
end;

function BaseDir: string;
var
  Buff: array[0..MAX_PATH - 1] of Char;
begin
  Result := ReadKey(HKEY_CURRENT_USER, '\Software\EurekaLog', 'AppDir');
  if (Result <> '') then // With EurekaLog installation...
    Result := (Result + '\')
  else
  begin // Without EurekaLog installation...
    GetModuleFileName(HInstance, Buff, SizeOf(Buff));
    Result := ExtractFilePath(string(Buff));
    if (not IntoIDE) then // EurekaLog Viewer
      Result := ExtractFilePath(Copy(Result, 1, Length(Result) - 1));
  end;
end;

function PackagePath: string;
var
  Buff: array[0..MAX_PATH - 1] of Char;
begin
  GetModuleFileName(HInstance, Buff, SizeOf(Buff));
  Result := ExtractFilePath(Buff);
end;    
    
procedure ShowLog(const FileName: string);

  function ViewerPath: string;
  begin
    Result := (BaseDir + 'EurekaLog Viewer\EurekaLog_Viewer.exe');
  end;

begin
  if (FileExists(FileName)) then
    ShellExecute(0, 'open', PChar(ViewerPath), PChar('"' + FileName + '"'), nil, SW_SHOWNORMAL)
  else
    MessageBox(0, ELogNotFound, EAttenction, MB_OK or MB_ICONWARNING or MB_TASKMODAL);
end;

procedure ShowHelp(Topic: string);

  function HelpPath: string;
  begin
    Result := (BaseDir + 'EurekaLog.chm');
  end;

begin
  if (Topic <> '') then Topic := ('::/' + ChangeFileExt(Topic, '.html'));
  ShellExecute(0, 'open', 'hh.exe',
    PChar(Format('"%s"', [HelpPath + Topic])), nil, SW_SHOWMAXIMIZED);
end;

procedure ShowTutorial;
begin
  ShellExecute(0, 'open', PChar(BaseDir + 'Tutorials\Tutorial.htm'),
    nil, nil, SW_SHOWMAXIMIZED);
end;
  
end.

