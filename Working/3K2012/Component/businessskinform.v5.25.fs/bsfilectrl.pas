{*******************************************************************}
{                                                                   }
{       Almediadev Visual Component Library                         }
{       BusinessSkinForm                                            }
{       Version 5.25                                                }
{                                                                   }
{       Copyright (c) 2000-2006 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}

unit bsfilectrl;

{$R-,T-,H+,X+}

interface

uses Windows, Messages, SysUtils, Classes, Controls, Graphics, Forms,
  Menus, StdCtrls, Buttons, bsSkinBoxCtrls, bsSkinCtrls;

type
  TbsFileAttr = (bsftReadOnly, bsftHidden, bsftSystem, bsftVolumeID, bsftDirectory,
    bsftArchive, bsftNormal);
  TbsFileType = set of TbsFileAttr;

  TbsDriveType = (bsdtUnknown, bsdtNoDrive, bsdtFloppy, bsdtFixed, bsdtNetwork, bsdtCDROM,
    bsdtRAM);

  TbsSkinDirectoryListBox = class;
  TbsSkinFilterComboBox = class;
  TbsSkinDriveComboBox = class;

{ TbsSkinFileListBox }

  TbsSkinFileListBox = class(TbsSkinListBox)
  private
    function GetDrive: char;
    function GetFileName: string;
    function IsMaskStored: Boolean;
    procedure SetDrive(Value: char);
    procedure SetFileEdit(Value: TEdit);
    procedure SetDirectory(const NewDirectory: string);
    procedure SetFileType(NewFileType: TbsFileType);
    procedure SetMask(const NewMask: string);
    procedure SetFileName(const NewFile: string);
  protected
    FDirectory: string;
    FMask: string;
    FFileType: TbsFileType;
    FFileEdit: TEdit;
    FDirList: TbsSkinDirectoryListBox;
    FFilterCombo: TbsSkinFilterComboBox;
    FOnChange: TNotifyEvent;
    FLastSel: Integer;
    procedure CreateWnd; override;
    procedure ListBoxClick; override;
    procedure Change; virtual;
    procedure ReadFileNames; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetFilePath: string; virtual;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update; reintroduce;
    procedure ApplyFilePath (const EditText: string); virtual;
    property Drive: char read GetDrive write SetDrive;
    property Directory: string read FDirectory write ApplyFilePath;
    property FileName: string read GetFilePath write ApplyFilePath;
  published
    property Align;
    property Anchors;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FileEdit: TEdit read FFileEdit write SetFileEdit;
    property FileType: TbsFileType read FFileType write SetFileType default [bsftNormal];
    property Font;
    property ImeMode;
    property ImeName;
    property Mask: string read FMask write SetMask stored IsMaskStored;
    property MultiSelect;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

{ TbsDirectoryListBox }

  TbsSkinDirectoryListBox = class(TbsSkinListBox)
  private
    FFileList: TbsSkinFileListBox;
    FDriveCombo: TbsSkinDriveComboBox;
    FDirLabel: TbsSkinStdLabel;
    FInSetDir: Boolean;
    FPreserveCase: Boolean;
    FCaseSensitive: Boolean;
    function GetDrive: char;
    procedure SeTbsSkinFileListBox(Value: TbsSkinFileListBox);
    procedure SetDirLabel(Value: TbsSkinStdLabel);
    procedure SetDirLabelCaption;
    procedure SetDrive(Value: char);
    procedure DriveChange(NewDrive: Char);
    procedure SetDir(const NewDirectory: string);
    procedure SetDirectory(const NewDirectory: string); virtual;
  protected
    ClosedBMP, OpenedBMP, CurrentBMP: TBitmap;
    FDirectory: string;
    FOnChange: TNotifyEvent;
    procedure Change; virtual;
    procedure ListBoxDblClick; override;
    procedure ReadBitmaps; virtual;
    procedure CreateWnd; override;
    procedure DrawItem(Cnvs: TCanvas; Index: Integer;
       ItemWidth, ItemHeight: Integer; TextRect: TRect; State: TOwnerDrawState);
    function  ReadDirectoryNames(const ParentDirectory: string;
      DirectoryList: TStringList): Integer;
    procedure BuildList; virtual;
    procedure ListBoxKeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
    function GetFullItemWidth(Index: Integer; ACnvs: TCanvas): Integer; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function  DisplayCase(const S: String): String;
    function  FileCompareText(const A, B: String): Integer;
    function GetItemPath(Index: Integer): string;
    procedure OpenCurrent;
    procedure Update; reintroduce;
    property Drive: Char read GetDrive write SetDrive;
    property Directory: string read FDirectory write SetDirectory;
    property PreserveCase: Boolean read FPreserveCase;
    property CaseSensitive: Boolean read FCaseSensitive;
  published
    property Align;
    property Anchors;
    property Color;
    property Columns;
    property Constraints;
    property Ctl3D;
    property DirLabel: TbsSkinStdLabel read FDirLabel write SetDirLabel;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FileList: TbsSkinFileListBox read FFileList write SeTbsSkinFileListBox;
    property Font;
    property ImeMode;
    property ImeName;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

{ TbsSkinDriveComboBox }

  TTextCase = (tcLowerCase, tcUpperCase);

  TbsSkinDriveComboBox = class(TbsSkinComboBox)
  private
    FDirList: TbsSkinDirectoryListBox;
    FDrive: Char;
    FTextCase: TTextCase;
    procedure SetDirListBox (Value: TbsSkinDirectoryListBox);
    procedure SetDrive(NewDrive: Char);
    procedure SetTextCase(NewTextCase: TTextCase);
    procedure ReadBitmaps;
  protected
    FloppyBMP, FixedBMP, NetworkBMP, CDROMBMP, RAMBMP: TBitmap;
    procedure CreateWnd; override;
    procedure DrawItem(Cnvs: TCanvas; Index: Integer;
       ItemWidth, ItemHeight: Integer; TextRect: TRect; State: TOwnerDrawState);
    procedure NewChange(Sender: TObject);
    procedure BuildList; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Text;
    property Drive: Char read FDrive write SetDrive;
  published
    property Anchors;
    property Color;
    property Constraints;
    property Ctl3D;
    property DirList: TbsSkinDirectoryListBox read FDirList write SetDirListBox;
    property DragMode;
    property DragCursor;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TextCase: TTextCase read FTextCase write SetTextCase default tcLowerCase;
    property Visible;
    property OnChange;
  end;

{ TFilterComboBox }

  TbsSkinFilterComboBox = class(TbsSkinComboBox)
  private
    FFilter: string;
    FFileList: TbsSkinFileListBox;
    MaskList: TStringList;
    function IsFilterStored: Boolean;
    function GetMask: string;
    procedure SetFilter(const NewFilter: string);
    procedure SeTbsSkinFileListBox (Value: TbsSkinFileListBox);
  protected
    procedure Change; override;
    procedure CreateWnd; override;
    procedure Click; override;
    procedure BuildList;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Mask: string read GetMask;
    property Text;
  published
    property Anchors;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property Enabled;
    property FileList: TbsSkinFileListBox read FFileList write SeTbsSkinFileListBox;
    property Filter: string read FFilter write SetFilter stored IsFilterStored;
    property Font;
    property ImeName;
    property ImeMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
  end;

procedure ProcessPath (const EditText: string; var Drive: Char;
  var DirPart: string; var FilePart: string);

function MinimizeName(const Filename: TFileName; Canvas: TCanvas;
  MaxLen: Integer): TFileName;

const
  WNTYPE_DRIVE = 1;

type
  TSelectDirOpt = (sdAllowCreate, sdPerformCreate, sdPrompt);
  TSelectDirOpts = set of TSelectDirOpt;

function DirectoryExists(const Name: string): Boolean;
function ForceDirectories(Dir: string): Boolean;

implementation

uses Consts, Dialogs, bsUtils;

{$R bsfilectrl}

function DirectoryExists(const Name: string): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Name));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

function ForceDirectories(Dir: string): Boolean;
begin
  Result := True;
  Dir := ExcludeTrailingBackslash(Dir);
  if (Length(Dir) < 3) or DirectoryExists(Dir)
    or (ExtractFilePath(Dir) = Dir) then Exit;
  Result := ForceDirectories(ExtractFilePath(Dir)) and CreateDir(Dir);
end;

function SlashSep(const Path, S: String): String;
begin
  if AnsiLastChar(Path)^ <> '\' then
    Result := Path + '\' + S
  else
    Result := Path + S;
end;

{ TbsSkinDriveComboBox }

procedure CutFirstDirectory(var S: TFileName);
var
  Root: Boolean;
  P: Integer;
begin
  if S = '\' then
    S := ''
  else
  begin
    if S[1] = '\' then
    begin
      Root := True;
      Delete(S, 1, 1);
    end
    else
      Root := False;
    if S[1] = '.' then
      Delete(S, 1, 4);
    P := AnsiPos('\',S);
    if P <> 0 then
    begin
      Delete(S, 1, P);
      S := '...\' + S;
    end
    else
      S := '';
    if Root then
      S := '\' + S;
  end;
end;

function MinimizeName(const Filename: TFileName; Canvas: TCanvas;
  MaxLen: Integer): TFileName;
var
  Drive: TFileName;
  Dir: TFileName;
  Name: TFileName;
begin
  Result := FileName;
  Dir := ExtractFilePath(Result);
  Name := ExtractFileName(Result);

  if (Length(Dir) >= 2) and (Dir[2] = ':') then
  begin
    Drive := Copy(Dir, 1, 2);
    Delete(Dir, 1, 2);
  end
  else
    Drive := '';
  while ((Dir <> '') or (Drive <> '')) and (Canvas.TextWidth(Result) > MaxLen) do
  begin
    if Dir = '\...\' then
    begin
      Drive := '';
      Dir := '...\';
    end
    else if Dir = '' then
      Drive := ''
    else
      CutFirstDirectory(Dir);
    Result := Drive + Dir + Name;
  end;
end;

function VolumeID(DriveChar: Char): string;
var
  OldErrorMode: Integer;
  NotUsed, VolFlags: DWORD;
  Buf: array [0..MAX_PATH] of Char;
begin
  OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  try
    Buf[0] := #$00;
    if GetVolumeInformation(PChar(DriveChar + ':\'), Buf, DWORD(sizeof(Buf)),
      nil, NotUsed, VolFlags, nil, 0) then
      SetString(Result, Buf, StrLen(Buf))
    else Result := '';  
    if DriveChar < 'a' then
      Result := AnsiUpperCaseFileName(Result)
    else
      Result := AnsiLowerCaseFileName(Result);
    Result := Format('[%s]',[Result]);
  finally
    SetErrorMode(OldErrorMode);
  end;
end;

function NetworkVolume(DriveChar: Char): string;
var
  Buf: Array [0..MAX_PATH] of Char;
  DriveStr: array [0..3] of Char;
  BufferSize: DWORD;
begin
  BufferSize := sizeof(Buf);
  DriveStr[0] := UpCase(DriveChar);
  DriveStr[1] := ':';
  DriveStr[2] := #0;
  if WNetGetConnection(DriveStr, Buf, BufferSize) = WN_SUCCESS then
  begin
    SetString(Result, Buf, BufferSize);
    if DriveChar < 'a' then
      Result := AnsiUpperCaseFileName(Result)
    else
      Result := AnsiLowerCaseFileName(Result);
  end
  else
    Result := VolumeID(DriveChar);
end;

procedure ProcessPath (const EditText: string; var Drive: Char;
  var DirPart: string; var FilePart: string);
var
  SaveDir, Root: string;
begin
  GetDir(0, SaveDir);
  Drive := SaveDir[1];
  DirPart := EditText;
  if (DirPart[1] = '[') and (AnsiLastChar(DirPart)^ = ']') then
    DirPart := Copy(DirPart, 2, Length(DirPart) - 2)
  else
  begin
    Root := ExtractFileDrive(DirPart);
    if Length(Root) = 0 then
      Root := ExtractFileDrive(SaveDir)
    else
      Delete(DirPart, 1, Length(Root));
    if (Length(Root) >= 2) and (Root[2] = ':') then
      Drive := Root[1]
    else
      Drive := #0;
  end;

  try
    if DirectoryExists(Root) then
      ChDir(Root);
    FilePart := ExtractFileName (DirPart);
    if Length(DirPart) = (Length(FilePart) + 1) then
      DirPart := '\'
    else if Length(DirPart) > Length(FilePart) then
      SetLength(DirPart, Length(DirPart) - Length(FilePart) - 1)
    else
    begin
      GetDir(0, DirPart);
      Delete(DirPart, 1, Length(ExtractFileDrive(DirPart)));
      if Length(DirPart) = 0 then
        DirPart := '\';
    end;
    if Length(DirPart) > 0 then
      ChDir (DirPart);  {first go to our new directory}
    if (Length(FilePart) > 0) and not
       (((Pos('*', FilePart) > 0) or (Pos('?', FilePart) > 0)) or
       FileExists(FilePart)) then
    begin
      ChDir(FilePart);
      if Length(DirPart) = 1 then
        DirPart := '\' + FilePart
      else
        DirPart := DirPart + '\' + FilePart;
      FilePart := '';
    end;
    if Drive = #0 then
      DirPart := Root + DirPart;
  finally
    if DirectoryExists(SaveDir) then
      ChDir(SaveDir);  { restore original directory }
  end;
end;

{ TbsSkinDriveComboBox }

constructor TbsSkinDriveComboBox.Create(AOwner: TComponent);
var
  Temp: ShortString;
begin
  inherited Create(AOwner);
  OnChange := NewChange;
  OnListBoxDrawItem := DrawItem;
  OnComboBoxDrawItem := DrawItem;
  ReadBitmaps;
  GetDir(0, Temp);
  FDrive := Temp[1]; { make default drive selected }
  if FDrive = '\' then FDrive := #0;
end;

destructor TbsSkinDriveComboBox.Destroy;
begin
  FloppyBMP.Free;
  FixedBMP.Free;
  NetworkBMP.Free;
  CDROMBMP.Free;
  RAMBMP.Free;
  inherited Destroy;
end;

procedure TbsSkinDriveComboBox.BuildList;
var
  DriveNum: Integer;
  DriveChar: Char;
  DriveType: TbsDriveType;
  DriveBits: set of 0..25;

  procedure AddDrive(const VolName: string; Obj: TObject);
  begin
    Items.AddObject(Format('%s: %s',[DriveChar, VolName]), Obj);
  end;

begin
  { fill list }
  Items.Clear;
  Integer(DriveBits) := GetLogicalDrives;
  for DriveNum := 0 to 25 do
  begin
    if not (DriveNum in DriveBits) then Continue;
    DriveChar := Char(DriveNum + Ord('a'));
    DriveType := TbsDriveType(GetDriveType(PChar(DriveChar + ':\')));
    if TextCase = tcUpperCase then
      DriveChar := Upcase(DriveChar);

    case DriveType of
      bsdtFloppy:   Items.AddObject(DriveChar + ':', FloppyBMP);
      bsdtFixed:    AddDrive(VolumeID(DriveChar), FixedBMP);
      bsdtNetwork:  AddDrive(NetworkVolume(DriveChar), NetworkBMP);
      bsdtCDROM:    AddDrive(VolumeID(DriveChar), CDROMBMP);
      bsdtRAM:      AddDrive(VolumeID(DriveChar), RAMBMP);
    end;
  end;
end;

procedure TbsSkinDriveComboBox.SetDrive(NewDrive: Char);
var
  Item: Integer;
  drv: string;
begin
  if (ItemIndex < 0) or (UpCase(NewDrive) <> UpCase(FDrive)) then
  begin
    if NewDrive = #0 then
    begin
      FDrive := NewDrive;
      ItemIndex := -1;
    end
    else
    begin
      if TextCase = tcUpperCase then
        FDrive := UpCase(NewDrive)
      else
        FDrive := Chr(ord(UpCase(NewDrive)) + 32);

      { change selected item }
      for Item := 0 to Items.Count - 1 do
      begin
        drv := Items[Item];
        if (UpCase(drv[1]) = UpCase(FDrive)) and (drv[2] = ':') then
        begin
          ItemIndex := Item;
          break;
        end;
      end;
    end;
    if FDirList <> nil then FDirList.DriveChange(Drive);
    Change;
  end;
end;

procedure TbsSkinDriveComboBox.SetTextCase(NewTextCase: TTextCase);
var
  OldDrive: Char;
begin
  FTextCase := NewTextCase;
  OldDrive := FDrive;
  BuildList;
  SetDrive (OldDrive);
end;

procedure TbsSkinDriveComboBox.SetDirListBox (Value: TbsSkinDirectoryListBox);
begin
  if FDirList <> nil then FDirList.FDriveCombo := nil;
  FDirList := Value;
  if FDirList <> nil then
  begin
    FDirList.FDriveCombo := Self;
    FDirList.FreeNotification(Self);
  end;
end;

procedure TbsSkinDriveComboBox.Loaded;
var
  Temp: String;
begin
  inherited;
  if (csDesigning in ComponentState)
  then
    begin
      GetDir(0, Temp);
      FDrive := Temp[1]; { make default drive selected }
      if FDrive = '\' then FDrive := #0;
      BuildList;
      SetDrive (FDrive);
    end;  
end;

procedure TbsSkinDriveComboBox.CreateWnd;
begin
  inherited CreateWnd;
  BuildList;
  SetDrive (FDrive);
end;

procedure TbsSkinDriveComboBox.DrawItem;
var
  Bitmap: TBitmap;
  bmpWidth: Integer;
begin
  Bitmap := TBitmap(Items.Objects[Index]);
  if Bitmap <> nil then
  begin
    bmpWidth := Bitmap.Width;
    Cnvs.BrushCopy(Bounds(TextRect.Left,
               (TextRect.Top + TextRect.Bottom - Bitmap.Height) div 2,
                Bitmap.Width, Bitmap.Height),
                Bitmap, Bounds(0, 0, Bitmap.Width, Bitmap.Height),
                Bitmap.Canvas.Pixels[0, Bitmap.Height - 1]);
  end
  else
    bmpWidth := 0;
  Cnvs.TextOut(TextRect.Left + bmpWidth + 6,
               TextRect.Top + RectHeight(TextRect) div 2 - Cnvs.TextHeight('Wg') div 2,
               Items[Index]);
end;

procedure TbsSkinDriveComboBox.NewChange(Sender: TObject);
begin
  if ItemIndex >= 0 then
    Drive := Items[ItemIndex][1];
end;

procedure TbsSkinDriveComboBox.ReadBitmaps;
begin
  { assign bitmap glyphs }
  FloppyBMP := TBitmap.Create;
  FloppyBMP.Handle := LoadBitmap(HInstance, 'BS_FLOPPY');
  FixedBMP := TBitmap.Create;
  FixedBMP.Handle := LoadBitmap(HInstance, 'BS_HARD');
  NetworkBMP := TBitmap.Create;
  NetworkBMP.Handle := LoadBitmap(HInstance, 'BS_NETWORK');
  CDROMBMP := TBitmap.Create;
  CDROMBMP.Handle := LoadBitmap(HInstance, 'BS_CDROM');
  RAMBMP := TBitmap.Create;
  RAMBMP.Handle := LoadBitmap(HInstance, 'BS_RAM');
end;

procedure TbsSkinDriveComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FDirList) then
    FDirList := nil;
end;

{ TbsSkinDirectoryListBox }

function DirLevel(const PathName: string): Integer;  { counts '\' in path }
var
  P: PChar;
begin
  Result := 0;
  P := AnsiStrScan(PChar(PathName), '\');
  while P <> nil do
  begin
    Inc(Result);
    Inc(P);
    P := AnsiStrScan(P, '\');
  end;
end;

constructor TbsSkinDirectoryListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  OnDrawItem := DrawItem;
  Width := 145;
  Sorted := False;
  ReadBitmaps;
  GetDir(0, FDirectory);
end;

destructor TbsSkinDirectoryListBox.Destroy;
begin
  ClosedBMP.Free;
  OpenedBMP.Free;
  CurrentBMP.Free;
  inherited Destroy;
end;

procedure TbsSkinDirectoryListBox.DriveChange(NewDrive: Char);
begin
  if (UpCase(NewDrive) <> UpCase(Drive)) then
  begin
    if NewDrive <> #0 then
    begin
      {$I-}
      ChDir(NewDrive + ':');
      {$I+}
      if IOResult = 0 then GetDir(0, FDirectory);
    end;
    if (not FInSetDir) and (IOResult = 0) then
    begin
      BuildList;
      Change;
    end;
  end;
end;

procedure TbsSkinDirectoryListBox.SeTbsSkinFileListBox (Value: TbsSkinFileListBox);
begin
  if FFileList <> nil then FFileList.FDirList := nil;
  FFileList := Value;
  if FFileList <> nil then
  begin
    FFileList.FDirList := Self;
    FFileList.FreeNotification(Self);
  end;
end;

procedure TbsSkinDirectoryListBox.SetDirLabel;
begin
  FDirLabel := Value;
  if Value <> nil then Value.FreeNotification(Self);
  SetDirLabelCaption;
end;

procedure TbsSkinDirectoryListBox.SetDir(const NewDirectory: string);
begin
     { go to old directory first, in case of incomplete pathname
       and curdir changed - probably not necessary }
  if DirectoryExists(FDirectory) then
    ChDir(FDirectory);
  ChDir(NewDirectory);     { exception raised if invalid dir }
  GetDir(0, FDirectory);   { store correct directory name }
  BuildList;
  Change;
end;

procedure TbsSkinDirectoryListBox.OpenCurrent;
begin
  Directory := GetItemPath(ItemIndex);
end;

procedure TbsSkinDirectoryListBox.Update;
begin
  BuildList;
  Change;
end;

function TbsSkinDirectoryListBox.DisplayCase(const S: String): String;
begin
  if FPreserveCase or FCaseSensitive then
    Result := S
  else
    Result := AnsiLowerCase(S);
end;

function TbsSkinDirectoryListBox.FileCompareText(const A,B: String): Integer;
begin
  if FCaseSensitive then
    Result := AnsiCompareStr(A,B)
  else
    Result := AnsiCompareFileName(A,B);
end;

  {
    Reads all directories in ParentDirectory, adds their paths to
    DirectoryList,and returns the number added
  }
function TbsSkinDirectoryListBox.ReadDirectoryNames(const ParentDirectory: string;
  DirectoryList: TStringList): Integer;
var
  Status: Integer;
  SearchRec: TSearchRec;
begin
  Result := 0;
  Status := FindFirst(SlashSep(ParentDirectory, '*.*'), faDirectory, SearchRec);
  try
    while Status = 0 do
    begin
      if (SearchRec.Attr and faDirectory = faDirectory) then
      begin
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        begin
          DirectoryList.Add(SearchRec.Name);
          Inc(Result);
        end;
      end;
      Status := FindNext(SearchRec);
    end;
  finally
    FindClose(SearchRec);
  end;
end;

procedure TbsSkinDirectoryListBox.BuildList;
var
  TempPath: string;
  DirName: string;
  IndentLevel, BackSlashPos: Integer;
  VolFlags: DWORD;
  I: Integer;
  Siblings: TStringList;
  NewSelect: Integer;
  Root: string;
begin
  FStopUpDateHScrollBar := True;
  try
    Items.BeginUpdate;
    Items.Clear;
    IndentLevel := 0;
    Root := ExtractFileDrive(Directory)+'\';
    GetVolumeInformation(PChar(Root), nil, 0, nil, DWORD(i), VolFlags, nil, 0);
    FPreserveCase := VolFlags and (FS_CASE_IS_PRESERVED or FS_CASE_SENSITIVE) <> 0;
    FCaseSensitive := (VolFlags and FS_CASE_SENSITIVE) <> 0;
    if (Length(Root) >= 2) and (Root[2] = '\') then
    begin
      ListBox.Items.AddObject(Root, OpenedBMP);
      Inc(IndentLevel);
      TempPath := Copy(Directory, Length(Root)+1, Length(Directory));
    end
    else
      TempPath := Directory;
    if (Length(TempPath) > 0) then
    begin
      if AnsiLastChar(TempPath)^ <> '\' then
      begin
        BackSlashPos := AnsiPos('\', TempPath);
        while BackSlashPos <> 0 do
        begin
          DirName := Copy(TempPath, 1, BackSlashPos - 1);
          if IndentLevel = 0 then DirName := DirName + '\';
          Delete(TempPath, 1, BackSlashPos);
          ListBox.Items.AddObject(DirName, OpenedBMP);
          Inc(IndentLevel);
          BackSlashPos := AnsiPos('\', TempPath);
        end;
      end;
      Items.AddObject(TempPath, CurrentBMP);
    end;
    NewSelect := Items.Count - 1;
    Siblings := TStringList.Create;
    try
      Siblings.Sorted := True;
        { read all the dir names into Siblings }
      ReadDirectoryNames(Directory, Siblings);
      for i := 0 to Siblings.Count - 1 do
        ListBox.Items.AddObject(Siblings[i], ClosedBMP);
    finally
      Siblings.Free;
    end;
  finally
    Items.EndUpdate;
  end;
  FStopUpDateHScrollBar := False;
  if HandleAllocated then
  begin
    ItemIndex := NewSelect;
    UpDateScrollbar;
  end;
end;

procedure TbsSkinDirectoryListBox.ReadBitmaps;
begin
  OpenedBMP := TBitmap.Create;
  OpenedBMP.LoadFromResourceName(HInstance, 'BS_OPENFOLDER');
  ClosedBMP := TBitmap.Create;
  ClosedBMP.LoadFromResourceName(HInstance, 'BS_CLOSEDFOLDER');
  CurrentBMP := TBitmap.Create;
  CurrentBMP.LoadFromResourceName(HInstance, 'BS_CURRENTFOLDER');
end;

procedure TbsSkinDirectoryListBox.ListBoxDblClick;
begin
  inherited;
  OpenCurrent;
end;

procedure TbsSkinDirectoryListBox.Change;
begin
  if FFileList <> nil then FFileList.SetDirectory(Directory);
  SetDirLabelCaption;
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TbsSkinDirectoryListBox.GetFullItemWidth(Index: Integer; ACnvs: TCanvas): Integer;
var
  bmpWidth, dirOffset: Integer;
  BitMap: TBitMap;
begin
  Result := inherited GetFullItemWidth(Index, ACnvs);
  bmpWidth  := 16;
  dirOffset := Index * 4 + 2;
  Bitmap := TBitmap(ListBox.Items.Objects[Index]);
  if Bitmap <> nil
  then
    begin
      if Bitmap = ClosedBMP then
         dirOffset := (DirLevel (Directory) + 1) * 4 + 2;
      bmpWidth := Bitmap.Width;   
    end;
  Result := Result + DirOffset + bmpWidth + 4;
end;

procedure TbsSkinDirectoryListBox.DrawItem(Cnvs: TCanvas; Index: Integer;
       ItemWidth, ItemHeight: Integer; TextRect: TRect; State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  bmpWidth: Integer;
  dirOffset: Integer;
  R: TRect;
begin
  bmpWidth  := 16;
  dirOffset := Index * 4 + 2;
  Bitmap := TBitmap(ListBox.Items.Objects[Index]);
  if Bitmap <> nil then
  begin
    if Bitmap = ClosedBMP then
       dirOffset := (DirLevel (Directory) + 1) * 4 + 2;
    bmpWidth := Bitmap.Width;
    Cnvs.BrushCopy(Bounds(TextRect.Left + dirOffset - ListBox.HorizontalExtentValue,
               (TextRect.Top + TextRect.Bottom - Bitmap.Height) div 2,
                Bitmap.Width, Bitmap.Height),
                Bitmap, Bounds(0, 0, Bitmap.Width, Bitmap.Height),
                Bitmap.Canvas.Pixels[0, Bitmap.Height - 1]);
  end;
  R := TextRect;
  Cnvs.Brush.Style := bsClear;
  BSDrawText3(Cnvs, Items[Index], R, bmpWidth + dirOffset + 4 - ListBox.HorizontalExtentValue);
end;

function TbsSkinDirectoryListBox.GetItemPath (Index: Integer): string;
var
  CurDir: string;
  i, j: Integer;
  Bitmap: TBitmap;
begin
  Result := '';
  if Index < Items.Count then
  begin
    CurDir := Directory;
    Bitmap := TBitmap(Items.Objects[Index]);
    if Index = 0 then
      Result := ExtractFileDrive(CurDir)+'\'
    else if Bitmap = ClosedBMP then
      Result := SlashSep(CurDir,Items[Index])
    else if Bitmap = CurrentBMP then
      Result := CurDir
    else
    begin
      i   := 0;
      j   := 0;
      Delete(CurDir, 1, Length(ExtractFileDrive(CurDir)));
      while j <> (Index + 1) do
      begin
        Inc(i);
        if i > Length (CurDir) then
          break;
        if CurDir[i] in LeadBytes then
          Inc(i)
        else if CurDir[i] = '\' then
          Inc(j);
      end;
      Result := ExtractFileDrive(Directory) + Copy(CurDir, 1, i - 1);
    end;
  end;
end;

procedure TbsSkinDirectoryListBox.Loaded;
begin
  inherited;
  if (csDesigning in ComponentState)
  then
    begin
      GetDir(0, FDirectory);
      BuildList;
    end;  
end;

procedure TbsSkinDirectoryListBox.CreateWnd;
begin
  inherited;
  BuildList;
  ItemIndex := DirLevel (Directory);
end;

function TbsSkinDirectoryListBox.GetDrive: char;
begin
  Result := FDirectory[1];
end;

procedure TbsSkinDirectoryListBox.SetDrive(Value: char);
begin
  if (UpCase(Value) <> UpCase(Drive)) then
    SetDirectory (Format ('%s:', [Value]));
end;

procedure TbsSkinDirectoryListBox.SetDirectory(const NewDirectory: string);
var
  DirPart: string;
  FilePart: string;
  NewDrive: Char;
begin
  if Length (NewDirectory) = 0 then Exit;
  if (FileCompareText(NewDirectory, Directory) = 0) then Exit;
  ProcessPath (NewDirectory, NewDrive, DirPart, FilePart);
  try
    if Drive <> NewDrive then
    begin
      FInSetDir := True;
      if (FDriveCombo <> nil) then
        FDriveCombo.Drive := NewDrive
      else
        DriveChange(NewDrive);
    end;
  finally
    FInSetDir := False;
  end;
  SetDir(DirPart);
end;

procedure TbsSkinDirectoryListBox.ListBoxKeyPress;
begin
  inherited;
  if (Word(Key) = VK_RETURN) then
    OpenCurrent;
end;

procedure TbsSkinDirectoryListBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = FFileList) then FFileList := nil
    else if (AComponent = FDriveCombo) then FDriveCombo := nil
    else if (AComponent = FDirLabel) then FDirLabel := nil;
  end;
end;

procedure TbsSkinDirectoryListBox.SetDirLabelCaption;
var
  DirWidth: Integer;
begin
  if FDirLabel <> nil then
  begin
    DirWidth := Width;
    if not FDirLabel.AutoSize then DirWidth := FDirLabel.Width;
    FDirLabel.Caption := MinimizeName(Directory, FDirLabel.Canvas, DirWidth);
  end;
end;

{ TbsSkinFileListBox }

const
  DefaultMask = '*.*';

constructor TbsSkinFileListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 145;
  FFileType := [bsftNormal]; { show only normal files by default }
  GetDir(0, FDirectory); { initially use current dir on default drive }
  FMask := DefaultMask;  { default file mask is all }
  MultiSelect := False;    { default is not multi-select }
  FLastSel := -1;
  Sorted := True;
end;

destructor TbsSkinFileListBox.Destroy;
begin
  inherited Destroy;
end;

procedure TbsSkinFileListBox.Update;
begin
  ReadFileNames;
end;

procedure TbsSkinFileListBox.CreateWnd;
begin
  inherited;
  ReadFileNames;
end;

procedure TbsSkinFileListBox.Loaded;
begin
  inherited;
  if (csDesigning in ComponentState)
  then
    begin
      GetDir(0, FDirectory);
      ReadFileNames;
    end;  
end;

function TbsSkinFileListBox.IsMaskStored: Boolean;
begin
  Result := DefaultMask <> FMask;
end;

function TbsSkinFileListBox.GetDrive: char;
begin
  Result := FDirectory[1];
end;

procedure TbsSkinFileListBox.ReadFileNames;
var
  AttrIndex: TbsFileAttr;
  I: Integer;
  FileExt: string;
  MaskPtr: PChar;
  Ptr: PChar;
  AttrWord: Word;
  FileInfo: TSearchRec;
  SaveCursor: TCursor;
const
   Attributes: array[TbsFileAttr] of Word = (faReadOnly, faHidden, faSysFile,
     faVolumeID, faDirectory, faArchive, 0);
begin
      { if no handle allocated yet, this call will force
        one to be allocated incorrectly (i.e. at the wrong time.
        In due time, one will be allocated appropriately.  }
  AttrWord := DDL_READWRITE;
  if HandleAllocated then
  begin
    { Set attribute flags based on values in FileType }
    for AttrIndex := bsftReadOnly to bsftArchive do
      if AttrIndex in FileType then
        AttrWord := AttrWord or Attributes[AttrIndex];

    ChDir(FDirectory); { go to the directory we want }
    Clear; { clear the list }

    I := 0;
    SaveCursor := Screen.Cursor;
    try
      MaskPtr := PChar(FMask);
      while MaskPtr <> nil do
      begin
        Ptr := StrScan (MaskPtr, ';');
        if Ptr <> nil then
          Ptr^ := #0;
        if FindFirst(MaskPtr, AttrWord, FileInfo) = 0 then
        begin
          repeat            { exclude normal files if ftNormal not set }
            if (bsftNormal in FileType) or (FileInfo.Attr and AttrWord <> 0) then
              if FileInfo.Attr and faDirectory <> 0 then
              begin
                I := Items.Add(Format('[%s]',[FileInfo.Name]));
              end
              else
              begin
                FileExt := AnsiLowerCase(ExtractFileExt(FileInfo.Name));
                I := Items.AddObject(FileInfo.Name, nil);
              end;
            if I = 100 then
              Screen.Cursor := crHourGlass;
          until FindNext(FileInfo) <> 0;
          FindClose(FileInfo);
        end;
        if Ptr <> nil then
        begin
          Ptr^ := ';';
          Inc (Ptr);
        end;
        MaskPtr := Ptr;
      end;
    finally
      Screen.Cursor := SaveCursor;
    end;
    Change;
  end;
end;

procedure TbsSkinFileListBox.ListBoxClick;
begin
  inherited;
  if FLastSel <> ItemIndex then
     Change;
end;

procedure TbsSkinFileListBox.Change;
begin
  FLastSel := ItemIndex;
  if FFileEdit <> nil then
  begin
    if Length(GetFileName) = 0 then
      FileEdit.Text := Mask
    else
      FileEdit.Text := GetFileName;
    FileEdit.SelectAll;
  end;
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TbsSkinFileListBox.GetFileName: string;
var
  idx: Integer;
begin
  idx  := ItemIndex;
  if (idx < 0)  or  (Items.Count = 0)  or  (Selected[idx] = FALSE)  then
    Result  := ''
  else
    Result  := Items[idx];
end;

procedure TbsSkinFileListBox.SetFileName(const NewFile: string);
begin
  if AnsiCompareFileName(NewFile, GetFileName) <> 0 then
  begin
    ItemIndex := SendMessage(Handle, LB_FindStringExact, 0,
      Longint(PChar(NewFile)));
    Change;
  end;
end;

procedure TbsSkinFileListBox.SetFileEdit(Value: TEdit);
begin
  FFileEdit := Value;
  if FFileEdit <> nil then
  begin
    FFileEdit.FreeNotification(Self);
    if GetFileName <> '' then
      FFileEdit.Text := GetFileName
    else
      FFileEdit.Text := Mask;
  end;
end;

procedure TbsSkinFileListBox.SetDrive(Value: char);
begin
  if (UpCase(Value) <> UpCase(FDirectory[1])) then
    ApplyFilePath (Format ('%s:', [Value]));
end;

procedure TbsSkinFileListBox.SetDirectory(const NewDirectory: string);
begin
  if AnsiCompareFileName(NewDirectory, FDirectory) <> 0 then
  begin
       { go to old directory first, in case not complete pathname
         and curdir changed - probably not necessary }
    if DirectoryExists(FDirectory) then
      ChDir(FDirectory);
    ChDir(NewDirectory);     { exception raised if invalid dir }
    GetDir(0, FDirectory);   { store correct directory name }
    ReadFileNames;
  end;
end;

procedure TbsSkinFileListBox.SetFileType(NewFileType: TbsFileType);
begin
  if NewFileType <> FFileType then
  begin
    FFileType := NewFileType;
    ReadFileNames;
  end;
end;

procedure TbsSkinFileListBox.SetMask(const NewMask: string);
begin
  if FMask <> NewMask then
  begin
    FMask := NewMask;
    ReadFileNames;
  end;
end;

procedure TbsSkinFileListBox.ApplyFilePath(const EditText: string);
var
  DirPart: string;
  FilePart: string;
  NewDrive: Char;
begin
  if AnsiCompareFileName(FileName, EditText) = 0 then Exit;
  if Length (EditText) = 0 then Exit;
  ProcessPath (EditText, NewDrive, DirPart, FilePart);
  if FDirList <> nil then
    FDirList.Directory := EditText
  else
    if NewDrive <> #0 then
      SetDirectory(Format('%s:%s', [NewDrive, DirPart]))
    else
      SetDirectory(DirPart);
  if (Pos('*', FilePart) > 0) or (Pos('?', FilePart) > 0) then
    SetMask (FilePart)
  else if Length(FilePart) > 0 then
  begin
    SetFileName (FilePart);
    if FileExists (FilePart) then
    begin
      if GetFileName = '' then
      begin
        SetMask(FilePart);
        SetFileName (FilePart);
      end;
    end;
  end;
end;

function TbsSkinFileListBox.GetFilePath: string;
begin
  Result := '';
  if GetFileName <> '' then
    Result := SlashSep(FDirectory, GetFileName);
end;

procedure TbsSkinFileListBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = FFileEdit) then FFileEdit := nil
    else if (AComponent = FDirList) then FDirList := nil
    else if (AComponent = FFilterCombo) then FFilterCombo := nil;
  end;
end;

{ TbsSkinFilterComboBox }

constructor TbsSkinFilterComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFilter := SDefaultFilter;
  MaskList := TStringList.Create;
end;

destructor TbsSkinFilterComboBox.Destroy;
begin
  MaskList.Free;
  inherited Destroy;
end;

procedure TbsSkinFilterComboBox.CreateWnd;
begin
  inherited CreateWnd;
  BuildList;
end;

function TbsSkinFilterComboBox.IsFilterStored: Boolean;
begin
  Result := SDefaultFilter <> FFilter;
end;

procedure TbsSkinFilterComboBox.SetFilter(const NewFilter: string);
begin
  if AnsiCompareFileName(NewFilter, FFilter) <> 0 then
  begin
    FFilter := NewFilter;
    if HandleAllocated then BuildList;
    Change;
  end;
end;

procedure TbsSkinFilterComboBox.SeTbsSkinFileListBox (Value: TbsSkinFileListBox);
begin
  if FFileList <> nil then FFileList.FFilterCombo := nil;
  FFileList := Value;
  if FFileList <> nil then
  begin
    FFileList.FreeNotification(Self);
    FFileList.FFilterCombo := Self;
  end;
end;

procedure TbsSkinFilterComboBox.Click;
begin
  inherited Click;
  Change;
end;

function TbsSkinFilterComboBox.GetMask: string;
begin
  if ItemIndex < 0 then
    ItemIndex := Items.Count - 1;

  if ItemIndex >= 0 then
  begin
     Result := MaskList[ItemIndex];
  end
  else
     Result := '*.*';
end;

procedure TbsSkinFilterComboBox.BuildList;
var
  AFilter, MaskName, Mask: string;
  BarPos: Integer;
begin
  Items.Clear;
  MaskList.Clear;
  AFilter := Filter;
  BarPos := AnsiPos('|', AFilter);
  while BarPos <> 0 do
  begin
    MaskName := Copy(AFilter, 1, BarPos - 1);
    Delete(AFilter, 1, BarPos);
    BarPos := AnsiPos('|', AFilter);
    if BarPos > 0 then
    begin
      Mask := Copy(AFilter, 1, BarPos - 1);
      Delete(AFilter, 1, BarPos);
    end
    else
    begin
      Mask := AFilter;
      AFilter := '';
    end;
    Items.Add(MaskName);
    MaskList.Add(Mask);
    BarPos := AnsiPos('|', AFilter);
  end;
  ItemIndex := 0;
end;

procedure TbsSkinFilterComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFileList) then
    FFileList := nil;
end;

procedure TbsSkinFilterComboBox.Change;
begin
  if FFileList <> nil then FFileList.Mask := Mask;
  inherited Change;
end;

end.

