{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{          Resource Unit - EResource             }
{                                                }
{************************************************}

// --------------------------------------------
// 01-March-2004   Modify by Fabio Dell'Aria. |
// --------------------------------------------

// Modifies:
// -----------------------------------------------------------------
// 1)...increase the load speed                                    |
// 2)...removed many not needed functionalities                    |
// 3)...fixed a bug that did not works with the CBuilder DLLs      |
// 4)...fixed a bug that corrupted the Debug section               |
// 5)...fixed a bug that corrupted the resource section            |
// 6)...fixed a bug that raised an AV in big PE resource sections  |
// -----------------------------------------------------------------

// Notes:
// -----------------------------------------------------
// the original 'unitResourceDetails' and 'unitPEFile' |
// units are modified and merged into this new unit.   |
// -----------------------------------------------------

// Comment of original 'unitResourceDetails' unit...
(*======================================================================*
 | unitResourceDetails unit for PEResourceExplorer                      |
 |                                                                      |
 | Ultra-light classes to wrap resources and resource modules.          |
 |                                                                      |
 | TResourceModule is an abstract base class for things that can        |
 | provide lists of resources - eg. .RES files, modules, etc.           |
 |                                                                      |
 | TResourceDetails is a base class for resources.                      |
 |                                                                      |
 | ... and here's the neat trick...                                     |
 |                                                                      |
 | The contents of this file are subject to the Mozilla Public License  |
 | Version 1.1 (the "License"); you may not use this file except in     |
 | compliance with the License. You may obtain a copy of the License    |
 | at http://www.mozilla.org/MPL/                                       |
 |                                                                      |
 | Software distributed under the License is distributed on an "AS IS"  |
 | basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See  |
 | the License for the specific language governing rights and           |
 | limitations under the License.                                       |
 |                                                                      |
 | Copyright © Colin Wilson 2002  All Rights Reserved
 |                                                                      |
 | Version  Date        By    Description                               |
 | -------  ----------  ----  ------------------------------------------|
 | 1.0      06/02/2001  CPWW  Original                                  |
 | 1.1      11/02/2002  CPWW  Continued development                     |
 *======================================================================*)

// Comment of the original 'unitPEFile' unit...
(*======================================================================*
 | unitPEFile unit for PEResourceExplorer                               |
 |                                                                      |
 | Windows PE File Decoder unit.  Tricky stuff!                         |
 |                                                                      |
 |                                                                      |
 | The contents of this file are subject to the Mozilla Public License  |
 | Version 1.1 (the "License"); you may not use this file except in     |
 | compliance with the License. You may obtain a copy of the License    |
 | at http://www.mozilla.org/MPL/                                       |
 |                                                                      |
 | Software distributed under the License is distributed on an "AS IS"  |
 | basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See  |
 | the License for the specific language governing rights and           |
 | limitations under the License.                                       |
 |                                                                      |
 | Copyright © Colin Wilson 2002  All Rights Reserved
 |                                                                      |
 | Version  Date        By    Description                               |
 | -------  ----------  ----  ------------------------------------------|
 | 1.0      19/10/2000  CPWW  Original                                  |
 | 1.1      31/05/2001  CPWW  Fixed crash when no resource section.     |
 |                      CPWW  Fixed crash when 'VirtualSize' contains   |
 |                            0, and SizeOfRawData doesn't.             |
 *======================================================================*)

// A PE file looks like this...
//
//   [ DOS Header      ]     First word is 'MK'
//   [ COFF header     ]     Starts at DOSHdr._lfaNew.  First dword is COFF signature
//   [ Optional header ]     Follows COFF header.  First word is IMAGE_NT_OPTIONAL_HDR_MAGIC
//     [ Data Directory  ]   Really part of the optional header

//   [ Image Sections Headers ] Starts at optionalHeader + COFFHdr.SizeOfOptionalHeader

//   [ Section data]         Each one pointed to by it's Image Section Header

unit EResource;

{$I Exceptions.inc}

interface

uses Windows,
  Classes,
  SysUtils;

type
  PImageDosHeader = ^TImageDosHeader;
  TImageDosHeader = packed record   { DOS .EXE header                  }
    e_magic: Word; //               { Magic number                     }
    e_cblp: Word; //                { Bytes on last page of file       }
    e_cp: Word; //                  { Pages in file                    }
    e_crlc: Word; //                { Relocations                      }
    e_cparhdr: Word; //             { Size of header in paragraphs     }
    e_minalloc: Word; //            { Minimum extra paragraphs needed  }
    e_maxalloc: Word; //            { Maximum extra paragraphs needed  }
    e_ss: Word; //                  { Initial (relative) SS value      }
    e_sp: Word; //                  { Initial SP value                 }
    e_csum: Word; //                { Checksum                         }
    e_ip: Word; //                  { Initial IP value                 }
    e_cs: Word; //                  { Initial (relative) CS value      }
    e_lfarlc: Word; //              { File address of relocation table }
    e_ovno: Word; //                { Overlay number                   }
    e_res: array[0..3] of Word; //  { Reserved words                   }
    e_oemid: Word; //               { OEM identifier (for e_oeminfo)   }
    e_oeminfo: Word; //             { OEM information; e_oemid specific}
    e_res2: array[0..9] of Word; // { Reserved words                   }
    _lfanew: LongInt; //            { File address of new exe header   }
  end;

  TResourceDetails = class;

  //======================================================================
  // TResourceModule class

  TResourceModule = class
  private
    fDirty: Boolean;
    function GetDirty: Boolean;
  protected
    function GetResourceCount: Integer; virtual; abstract;
    function GetResourceDetails(idx: Integer): TResourceDetails; virtual; abstract;

  public
    procedure DeleteResource(idx: Integer); virtual;
    procedure InsertResource(idx: Integer; details: TResourceDetails); virtual;
    function AddResource(details: TResourceDetails): Integer; virtual;
    function IndexOfResource(details: TResourceDetails): Integer; virtual; abstract;

    procedure SaveToStream(stream: TStream); virtual;
    procedure LoadFromStream(stream: TStream); virtual;

    procedure SaveToFile(const FileName: string); virtual;
    procedure LoadFromFile(const FileName: string); virtual;
    procedure SortResources; virtual;

    property ResourceCount: Integer read GetResourceCount;
    property ResourceDetails[idx: Integer]: TResourceDetails read GetResourceDetails;
    property Dirty: Boolean read GetDirty write fDirty;
    procedure ClearDirty;
  end;

  //======================================================================
  // TResourceDetails class

  TResourceDetails = class
  private
    fParent: TResourceModule;
    fData: TMemoryStream;
    fCodePage: Integer;
    fResourceLanguage: LCID;
    fResourceName: string;
    fResourceType: string;

    fDataVersion, fVersion: DWORD; // Resource header version info
    fCharacteristics: DWORD;
    fTag: LongInt;
    fDirty: Boolean;
    // Resource header characteristics

  protected
    constructor Create(AParent: TResourceModule; ALanguage: Integer;
      const AName, AType: string; ASize: Integer; AData: pointer); virtual;
    procedure InitNew; virtual;
    procedure SetResourceName(const Value: string); virtual;
  public
    class function GetBaseType: string; virtual;

    destructor Destroy; override;

    procedure ChangeData(newData: TMemoryStream); virtual;

    property Parent: TResourceModule read fParent;
    property Data: TMemoryStream read fData;
    property ResourceName: string read fResourceName write SetResourceName;
    property ResourceType: string read fResourceType;
    property ResourceLanguage: LCID read fResourceLanguage write fResourceLanguage;

    property CodePage: Integer read fCodePage write fCodePage;
    property Characteristics: DWORD read fCharacteristics write fCharacteristics;
    property Version: DWORD read fVersion write fDataVersion;
    property DataVersion: DWORD read fDataVersion write fDataVersion;
    property Dirty: Boolean read fDirty write fDirty;
    property Tag: LongInt read fTag write fTag;
  end;

  TPEModule = class;

  //----------------------------------------------------------------------
  // TImageSection class

  TImageSectionRead = class(TObject)
  private
    fSectionHeader: TImageSectionHeader;
    fData: Pointer;
  public
    constructor Create(const AHeader: TImageSectionHeader; rawData: Pointer);
  end;

  //----------------------------------------------------------------------
  // TImageSectionWrite class

  TImageSectionWrite = class(TObject)
  protected
    fSectionHeader: TImageSectionHeader;
    fRawData: TMemoryStream;
  public
    constructor Create(const AHeader: TImageSectionHeader; rawData: Pointer);
    destructor Destroy; override;
  end;

  //----------------------------------------------------------------------
  // TPEModule class

  TPEModule = class(TResourceModule)
  private
    fDOSHeader: TImageDosHeader;
    fCOFFHeader: TImageFileHeader;
    fOptionalHeader: PImageOptionalHeader;
    fSectionList: TList; // List of TImageSection objects
    fDOSStub: TMemoryStream;
    fCommentBlock: PChar;
    fCommentSize: Integer;
    fEndComment: PChar;
    fEndCommentSize: Integer;

    function GetImageSection(index: Integer): TImageSectionRead;
    function GetImageSectionCount: Integer;
    function GetDataDictionary(index: Integer): PImageDataDirectory;
    function GetDataDictionaryCount: Integer;
    function GetDOSHeader: TImageDosHeader;
    function GetCOFFHeader: TImageFileHeader;

  protected
    fBuffer: TMemoryStream;

    procedure Decode(memory: pointer; exeSize: Integer); virtual;
    procedure Encode(Stream: TMemoryStream); virtual;
    property OptionalHeaderPtr: PImageOptionalHeader read fOptionalHeader;
    function FindDictionaryEntrySection(entryNo: Integer): Integer;

  public
    constructor Create;
    destructor Destroy; override;

    property DOSHeader: TImageDosHeader read GetDOSHeader;
    property COFFHeader: TImageFileHeader read GetCOFFHeader;

    property ImageSectionCount: Integer read GetImageSectionCount;
    property ImageSection[index: Integer]: TImageSectionRead read GetImageSection;

    property DataDictionaryCount: Integer read GetDataDictionaryCount;
    property DataDictionary[index: Integer]: PImageDataDirectory read GetDataDictionary;

    procedure LoadFromStream(s: TStream); override;
    procedure LoadFromFile(const name: string); override;

    procedure SaveToStream(s: TStream); override;
    procedure SaveToFile(const name: string); override;
  end;

  //----------------------------------------------------------------------
  // TResourceDirectoryTable record

  TResourceDirectoryTable = packed record
    characteristics: DWORD; // Resource flags, reserved for future use; currently set to zero.
    timeDateStamp: DWORD; // Time the resource data was created by the resource compiler.
    versionMajor: WORD; // Major version number, set by the user.
    versionMinor: WORD; // Minor version number.
    cNameEntries: WORD; // Number of directory entries, immediately following the table, that use strings to identify Type, Name, or Language (depending on the level of the table).
    cIDEntries: WORD; // Number of directory entries, immediately following the Name entries, that use numeric identifiers for Type, Name, or Language.
  end;
  PResourceDirectoryTable = ^TResourceDirectoryTable;

  //----------------------------------------------------------------------
  // TPEModule record

  TResourceDirectoryEntry = packed record
    name: DWORD; // RVA Address of integer or string that gives the Type, Name, or Language identifier, depending on level of table.
    RVA: DWORD; // RVA High bit 0. Address of a Resource Data Entry (a leaf).
    // RVA High bit 1. Lower 31 bits are the address of another Resource Directory Table (the next level down).
  end;
  PResourceDirectoryEntry = ^TResourceDirectoryEntry;

  //----------------------------------------------------------------------
  // TResourceDirectoryEntry record

  TResourceDataEntry = packed record
    OffsetToData: DWORD;
    Size: DWORD;
    CodePage: DWORD;
    Reserved: DWORD
  end;
  PResourceDataEntry = ^TResourceDataEntry;

  //----------------------------------------------------------------------
  // TPEResourceModule class

  TPEResourceModule = class(TPEModule)
  private
    fDetailList: TList; // List of TResourceDetails objects

    function GetResourceSection: TImageSectionRead;
  protected
    procedure Decode(memory: pointer; exeSize: Integer); override;
    procedure Encode(Stream: TMemoryStream); override;
    function GetResourceCount: Integer; override;
    function GetResourceDetails(idx: Integer): TResourceDetails; override;
  public
    constructor Create;
    destructor Destroy; override;

    property ResourceCount: Integer read GetResourceCount;
    property ResourceDetails[idx: Integer]: TResourceDetails read GetResourceDetails;
    procedure DeleteResource(resourceNo: Integer); override;
    procedure InsertResource(idx: Integer; details: TResourceDetails); override;
    function AddResource(details: TResourceDetails): Integer; override;
    function IndexOfResource(details: TResourceDetails): Integer; override;
    procedure SortResources; override;
  end;

  EPEException = class(Exception);

procedure WriteResourceInStream(PEStream: TMemoryStream; ResName: string;
  ResData: Pointer; ResSize: DWord);

implementation

const
  IMG_DIR_RES = 2;         { Resource Directory  }
  IMG_DIR_DEB = 6;         { Debug Directory     }
  RES_IMGCODE = $00000fff; { Resource image code }
  RES_IMGDATA = $ffffffff; { Resource image data }

{ TPEModule }
resourcestring
  rstNoStreaming = 'Module doesn''t support streaming';

  rstInvalidDOSSignature = 'Invalid DOS signature';
  rstInvalidCOFFSignature = 'Invalid COFF signature';
  rstInvalidOptionalHeader = 'Invalid Windows Image';
  rstBadDictionaryIndex = 'Index exceeds data dictionary count';
  rstBadLangID = 'Unsupported non-integer language ID in resource';

type
  TResourceNode = class;

  TNode = packed record
    id: string;
    intID: Boolean;
    case leaf: Boolean of
      False: (next: TResourceNode);
      True: (data: TMemoryStream; CodePage: DWord);
  end;

  TResourceNode = class(TObject)
  protected
    procedure SetSize(NewSize: DWord);
    procedure SetInitialSize;
    procedure ChangeSize(NewSize: DWord);
  public
    count: Integer;
{$IFDEF Delphi4Up}
    FRealCount: DWord;
    nodes: array of TNode;
{$ELSE}
    nodes: array [0..2047] of TNode;
{$ENDIF}

    constructor Create(const AType, AName: string; ALang: Integer;
      aData: TMemoryStream; CodePage: DWORD);
    constructor CreateNameNode(const AName: string; ALang: Integer;
      aData: TMemoryStream; CodePage: DWORD);
    constructor CreateLangNode(ALang: Integer; aData: TMemoryStream;
      CodePage: DWORD);
    procedure Add(const AType, AName: string; ALang: Integer;
      aData: TMemoryStream; CodePage: DWORD);
    procedure AddName(const AName: string; ALang: Integer;
      aData: TMemoryStream; CodePage: DWORD);
    procedure AddLang(ALang: Integer; aData: TMemoryStream; CodePage: DWORD);
    function IsID(idx: Integer): boolean;
    destructor Destroy; override;
  end;

  // Windows resource types...
  //----------------------------------------------------------------------------
  TArrayImageSectionHeader = array[0..MaxInt shr 6] of TImageSectionHeader;
  PArrayImageSectionHeader = ^TArrayImageSectionHeader;
  //----------------------------------------------------------------------------

function GetImageNtHeaders(HModule: THandle): PImageNtHeaders;
type
  THeader = packed record
    Unused: array[0..59] of Byte; // unused information.
    Offset: DWord;
  end;
  PHeader = ^THeader;
begin
  Result := PImageNtHeaders(HModule + PHeader(HModule).Offset);
end;

procedure WriteResourceSection(PEStream, ResStream: TMemoryStream);
var
  Headers: PImageNtHeaders;
  SecCount, n, i, ResSecNo: Integer;
  SecHead: PArrayImageSectionHeader;
  SecAlign: DWord;
  DeltaSec: Integer;
  StartSection: DWord;
  SecDebug: PImageDebugDirectory;

  function ModuleHnd: THandle;
  begin
    Result := DWord(PEStream.Memory);
  end;

  procedure MoveResourceData(AResStart: DWord; ADeltaSec: Integer);
  var
    BlockSize: DWord;
  begin
    BlockSize := (ModuleHnd + DWord(PEStream.Size) - AResStart - DWord(ADeltaSec));
    Move(Pointer(AResStart)^, Pointer(AResStart + DWord(ADeltaSec))^, BlockSize);
  end;

  function GetResourceSecNo(H: PImageNtHeaders): Integer;
  var
    n, SecNum: Integer;
    SecH: PArrayImageSectionHeader;
  begin
    Result := 0;
    SecH := PArrayImageSectionHeader(DWord(H) + SizeOf(H^));
    SecNum := H^.FileHeader.NumberOfSections;
    for n := 0 to SecNum - 1 do
      if (SecH[n].VirtualAddress =
        H^.OptionalHeader.DataDirectory[IMG_DIR_RES].VirtualAddress) then Result := n;
  end;

  function GetAlign(Value, Align: DWord): DWord;
  begin
    Result := ((Value + Align - 1) div Align) * Align;
  end;

begin
  Headers := GetImageNtHeaders(ModuleHnd);
  ResSecNo := GetResourceSecNo(Headers);
  SecAlign := Headers^.OptionalHeader.SectionAlignment;
  SecCount := Headers^.FileHeader.NumberOfSections;

  DeltaSec := (GetAlign(DWord(ResStream.Size) -
    DWord(Headers^.OptionalHeader.DataDirectory[IMG_DIR_RES].Size), SecAlign));

  PEStream.Size := (PEStream.Size + DeltaSec);

  // Recalculate for stream remapping.
  Headers := GetImageNtHeaders(ModuleHnd);
  SecHead := PArrayImageSectionHeader(DWord(Headers) + SizeOf(Headers^));

  StartSection := (ModuleHnd + SecHead[ResSecNo].PointerToRawData);

  MoveResourceData(StartSection, DeltaSec);

  Move(Pointer(ResStream.Memory)^, Pointer(StartSection)^, ResStream.Size);

  if (Headers^.OptionalHeader.DataDirectory[IMG_DIR_RES].Size > 0) then
    Inc(Headers^.OptionalHeader.DataDirectory[IMG_DIR_RES].Size, DeltaSec);
  if (SecHead[ResSecNo].SizeOfRawData > 0) then
    Inc(SecHead[ResSecNo].SizeOfRawData, DeltaSec);
  if (SecHead[ResSecNo].Misc.VirtualSize > 0) then
    Inc(SecHead[ResSecNo].Misc.VirtualSize, DeltaSec);

  for n := 0 to Headers^.OptionalHeader.NumberOfRvaAndSizes - 1 do
    if (Headers^.OptionalHeader.DataDirectory[n].VirtualAddress >
      SecHead[ResSecNo].VirtualAddress) then
      Inc(Headers^.OptionalHeader.DataDirectory[n].VirtualAddress, DeltaSec);

  for n := 0 to SecCount - 1 do
    if (SecHead[n].VirtualAddress > SecHead[ResSecNo].VirtualAddress) then
    begin
      Inc(SecHead[n].VirtualAddress, DeltaSec);
      Inc(SecHead[n].PointerToRawData, DeltaSec);
      if (SecHead[n].PointerToRelocations > 0) then
        Inc(SecHead[n].PointerToRelocations, DeltaSec);
      if (SecHead[n].PointerToLinenumbers > 0) then
        Inc(SecHead[n].PointerToLinenumbers, DeltaSec);
    end;

  // Elaborate the Debug section...
  if (Headers^.OptionalHeader.DataDirectory[IMG_DIR_DEB].Size > 0) then
  begin
    for n := 0 to SecCount - 1 do
    begin
      if (SecHead[n].VirtualAddress =
        Headers^.OptionalHeader.DataDirectory[IMG_DIR_DEB].VirtualAddress) then
      begin
        SecDebug := PImageDebugDirectory(ModuleHnd + SecHead[n].PointerToRawData);
        for i := 1 to Headers^.OptionalHeader.DataDirectory[IMG_DIR_DEB].Size do
        begin
          if SecDebug^.AddressOfRawData > SecHead[ResSecNo].VirtualAddress then
          begin
            Inc(SecDebug^.PointerToRawData, DeltaSec);
            Inc(SecDebug^.AddressOfRawData, DeltaSec);
          end;
          Inc(SecDebug);
        end;
        Break;
      end;
    end;
  end;

  Inc(Headers^.OptionalHeader.SizeOfImage, DeltaSec);
  Inc(Headers^.OptionalHeader.SizeOfInitializedData, DeltaSec);
end;

procedure WriteResourceInStream(PEStream: TMemoryStream; ResName: string;
  ResData: Pointer; ResSize: DWord);
var
  Res: TPEResourceModule;
begin
  Res := TPEResourceModule.Create;
  try
    Res.Decode(PEStream.Memory, PEStream.Size);
    TResourceDetails.Create(Res, 0, ResName, '10', ResSize, ResData).Dirty := True;
    Res.SortResources;
    Res.Encode(PEStream);
  finally
    Res.Free;
  end;
end;

(*----------------------------------------------------------------------------*
 | procedure ResourceWideCharToStr ()                                         |
 |                                                                            |
 | Convert Pascal-style WideChar array to a string                            |
 |                                                                            |
 | Parameters:                                                                |
 |   WStr : PWChar             The characters                                 |
 *----------------------------------------------------------------------------*)

function ResourceWideCharToStr(var wstr: PWideChar): string;
var
  len: word;
begin
  len := word(wstr^);
  SetLength(result, len);
  Inc(wstr);
  WideCharToMultiByte(CP_ACP, 0, WStr, Len, PChar(Result), Len + 1, nil, nil);
  Inc(wstr, len);
  result := PChar(result);
end;

(*----------------------------------------------------------------------*
 | procedure ResourceNameToInt                                          |
 |                                                                      |
 | Get integer value of resource name (or type).  Return -1 if it's     |
 | not numeric.                                                         |
 *----------------------------------------------------------------------*)

function ResourceNameToInt(const s: string): Integer;
var
  isNumeric: Boolean;
  i: Integer;
begin
  isNumeric := Length(s) > 0;
  for i := 1 to Length(s) do
    if not (s[i] in ['0'..'9']) then
    begin
      isNumeric := False;
      break
    end;

  if isNumeric then
    Result := StrToInt(s)
  else
    Result := -1
end;

(*----------------------------------------------------------------------*
 | function CompareDetails                                              |
 |                                                                      |
 | 'Compare' function used when sorting resources.  p1 and p2 must be   |
 | TResourceDetails references.  Returns > 0 if details at p1 are >     |
 | details at p2.                                                       |
 |                                                                      |
 | *  Compare resource types.  If they match then compare names.        |
 | *  'Integer' ids or names must come *after* non integer ids or names.|
 *----------------------------------------------------------------------*)

function CompareDetails(p1, p2: Pointer): Integer;
var
  d1: TResourceDetails;
  d2: TResourceDetails;
  i1, i2: Integer;
begin
  d1 := TResourceDetails(p1);
  d2 := TResourceDetails(p2);

  i1 := ResourceNameToInt(d1.ResourceType);
  i2 := ResourceNameToInt(d2.ResourceType);

  if i1 >= 0 then
    if i2 >= 0 then
      Result := i1 - i2 // Compare two integer ids
    else
      Result := 1 // id1 is int, so it's greater than non-int id2
  else
    if i2 >= 0 then
      Result := -1 // id2 is int, so it's less than non-int id1
    else
      // Compare two string resource ids
      Result := CompareText(d1.ResourceType, d2.ResourceType);

  if Result = 0 then // If they match, do the same with the names
  begin
    i1 := ResourceNameToInt(d1.ResourceName);
    i2 := ResourceNameToInt(d2.ResourceName);

    if i1 >= 0 then
      if i2 >= 0 then
        Result := i1 - i2
      else
        Result := 1
    else
      if i2 >= 0 then
        Result := -1
      else
        Result := CompareText(d1.ResourceName, d2.ResourceName);

    if Result = 0 then // If they match, do the same with the languages
      Result := (d1.ResourceLanguage - d2.ResourceLanguage);
  end;
end;

{ TResourceDetails }

(*----------------------------------------------------------------------*
 | TResourceDetails.ChangeData                                          |
 |                                                                      |
 | Change all the data.  Handy for implementing 'undo', etc.            |
 *----------------------------------------------------------------------*)

procedure TResourceDetails.ChangeData(newData: TMemoryStream);
begin
  fData.Clear;
  fData.CopyFrom(newData, 0);
end;

(*----------------------------------------------------------------------*
 | TResourceDetails.Create                                              |
 |                                                                      |
 | Raw - protected - constructor for resource details.                  |
 *----------------------------------------------------------------------*)

constructor TResourceDetails.Create(AParent: TResourceModule;
  ALanguage: Integer; const AName, AType: string; ASize: Integer; AData: pointer);
begin
  inherited Create;
  fParent := AParent;
  fResourceLanguage := ALanguage;
  fResourceName := AName;
  fResourceType := AType;
  if Assigned(AParent) then
    AParent.AddResource(Self);
  fData := TMemoryStream.Create;
  fData.Write(AData^, ASize);
end;

(*----------------------------------------------------------------------*
 | TResourceDetails.Destroy                                             |
 *----------------------------------------------------------------------*)

destructor TResourceDetails.Destroy;
begin
  fData.Free;
  inherited;
end;

(*----------------------------------------------------------------------*
 | TResourceDetails.GetBaseType                                         |
 |                                                                      |
 | Return the base type for the resource details.  This is overridden   |
 | in derived classes.                                                  |
 *----------------------------------------------------------------------*)

class function TResourceDetails.GetBaseType: string;
begin
  Result := '0';
end;

(*----------------------------------------------------------------------*
 | TResourceDetails.InitNew                                             |
 |                                                                      |
 | Override this to initialize a new resource being added to a module.  |
 *----------------------------------------------------------------------*)

procedure TResourceDetails.InitNew;
begin
  // Stub
end;

(*----------------------------------------------------------------------*
 | TResourceDetails.SetResourceName                                     |
 |                                                                      |
 | Set the resource name.                                               |
 *----------------------------------------------------------------------*)

procedure TResourceDetails.SetResourceName(const Value: string);
begin
  fResourceName := Value;
  fDirty := True
end;

{ TResourceModule }

(*----------------------------------------------------------------------*
 | TResourceModule.LoadFromFile                                         |
 |                                                                      |
 | Load from file.  This can be overriden but usually isn't as it       |
 | relies on LoadFromStream, which must be.                             |
 *----------------------------------------------------------------------*)

function TResourceModule.AddResource(details: TResourceDetails): Integer;
begin
  result := -1
    // Stub
end;

procedure TResourceModule.ClearDirty;
var
  i: Integer;
begin
  fDirty := False;
  for i := 0 to ResourceCount - 1 do
    ResourceDetails[i].Dirty := False
end;

(*----------------------------------------------------------------------*
 | TResourceModule.DeleteResource                                       |
 |                                                                      |
 | Must be overridden to remove the resource details object from        |
 | wherever it's stored.  The overriding method must call               |
 | inherited                                                            |
 *----------------------------------------------------------------------*)

procedure TResourceModule.DeleteResource(idx: Integer);
begin
  fDirty := True;
end;

(*----------------------------------------------------------------------*
 | TResourceModule.GetDirty                                             |
 |                                                                      |
 | Returns true if the module or it's resources are 'dirty'             |
 |                                                                      |
 | nb. fDirty is only set if resources have been deleted.               |
 |     After adding a resource make sure the resource's Dirty is set to |
 |     true.                                                            |
 *----------------------------------------------------------------------*)

function TResourceModule.GetDirty: Boolean;
var
  i: Integer;
begin
  Result := fDirty;
  if not fDirty then
    for i := 0 to ResourceCount - 1 do
      if ResourceDetails[i].Dirty then
      begin
        Result := True;
        break
      end
end;

procedure TResourceModule.InsertResource(idx: Integer;
  details: TResourceDetails);
begin
  // Stub
end;

(*----------------------------------------------------------------------*
 | TResourceModule.LoadFromFile                                         |
 |                                                                      |
 | Load from a file.  Not usually overriden.                            |
 *----------------------------------------------------------------------*)

procedure TResourceModule.LoadFromFile(const FileName: string);
var
  s: TFileStream;
begin
  s := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
  try
    LoadFromStream(s);
  finally
    s.Free
  end
end;

(*----------------------------------------------------------------------*
 | TResourceModule.SaveToFile                                           |
 |                                                                      |
 | Save to file.  This can be overriden but usually isn't as it         |
 | relies on SaveToStream, which must be.                               |
 *----------------------------------------------------------------------*)

procedure TResourceModule.LoadFromStream(stream: TStream);
begin
  raise Exception.Create(rstNoStreaming);
end;

procedure TResourceModule.SaveToFile(const FileName: string);
var
  s: TFileStream;
begin
  s := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(s);
    ClearDirty
  finally
    s.Free
  end
end;

procedure TResourceModule.SaveToStream(stream: TStream);
begin
  raise Exception.Create(rstNoStreaming);
end;

procedure TResourceModule.SortResources;
begin
  // Stub
end;

(*----------------------------------------------------------------------*
 | constructor PEModule.Create                                          |
 |                                                                      |
 | Constructor for TPEModule instance.  Create empty section list       |
 *----------------------------------------------------------------------*)

constructor TPEModule.Create;
begin
  inherited Create;
  fSectionList := TList.Create;
  fDOSStub := TMemoryStream.Create;
  fBuffer := TMemoryStream.Create;
end;

(*----------------------------------------------------------------------*
 | procedure PEModule.Decode                                            |
 |                                                                      |
 | Decode the PE file.  Load the DOS header, the COFF header and the    |
 | 'optional' header, then load each section into fSectionList          |
 *----------------------------------------------------------------------*)

procedure TPEModule.Decode(Memory: pointer; exeSize: Integer);
var
  offset: LongInt;
  i: Integer;
  sectionHeader: PImageSectionHeader;
  commentOffset: Integer;
begin
  for i := 0 to fSectionList.Count - 1 do
    TObject(fSectionList[i]).Free;
  fSectionList.Clear;

  // Check it's really a PE file.
  if PWORD(Memory)^ <> IMAGE_DOS_SIGNATURE then
    raise EPEException.Create(rstInvalidDOSSignature);

  // Load the DOS header
  fDOSHeader := PImageDosHeader(Memory)^;

  offset := fDOSHeader._lfanew;
  fDOSStub.Write((PChar(Memory) + sizeof(fDOSHeader))^,
    fDOSHeader._lfanew - sizeof(fDOSHeader));
  // Check the COFF signature
  if PDWORD(PChar(Memory) + offset)^ <> IMAGE_NT_SIGNATURE then
    raise EPEException.Create(rstInvalidCOFFSignature);

  // Load the COFF header
  Inc(offset, sizeof(DWORD));
  fCOFFHeader := PImageFileHEader(PChar(Memory) + offset)^;

  Inc(offset, sizeof(fCOFFHeader));

  // Check the Optional Header signature.  nb
  // the optional header is compulsory for
  // 32 bit windows modules!
  if PWORD(PChar(Memory) + offset)^ <> IMAGE_NT_OPTIONAL_HDR_MAGIC then
    raise EPEException.Create(rstInvalidOptionalHeader);

  // Save the 'optional' header
  ReallocMem(fOptionalHeader, fCOFFHeader.SizeOfOptionalHeader);
  Move((PChar(Memory) + Offset)^, fOptionalHeader^,
    fCOFFHeader.SizeOfOptionalHeader);

  Inc(offset, fCOFFHeader.SizeOfOptionalHeader);

  sectionHeader := PImageSectionHeader(PChar(memory) + offset);
  commentOffset := offset + fCOFFHeader.NumberOfSections *
    sizeof(TImageSectionHeader);

  // Save padding between the end of the section headers, and the start of the
  // 1st section.  TDump reports this as 'comment', and it seems to be important
  // to MS clock.exe...

  fCommentSize := Integer(sectionHeader^.PointerToRawData) - commentOffset;

  if fCommentSize > 0 then
  begin
    GetMem(fCommentBlock, fCommentSize);
    Move((PChar(memory) + commentOffset)^, fCommentBlock^, fCommentSize)
  end;
  // Now save each image section in the fSectionList
  for i := 0 to fCOFFHeader.NumberOfSections - 1 do
  begin
    sectionHeader := PImageSectionHeader(PChar(memory) + offset);
    fSectionList.Add(TImageSectionRead.Create(sectionHeader^,
      PChar(memory) + sectionHeader^.PointertoRawData));
    Inc(offset, sizeof(TImageSectionHeader));
  end;

  i := sectionHeader^.PointerToRawData + sectionHeader^.SizeOfRawData;

  // Save the padding between the last section and the end of the file.
  // This appears to hold debug info and things ??

  fEndCommentSize := exeSize - i;
  if fEndCommentSize > 0 then
  begin
    GetMem(fEndComment, fEndCommentSize);
    Move((PChar(memory) + i)^, fEndComment^, fEndCommentSize)
  end
end;

(*----------------------------------------------------------------------*
 | destructor PEModule.Destroy                                          |
 |                                                                      |
 | Destructor for TPEModule instance.                                   |
 *----------------------------------------------------------------------*)

destructor TPEModule.Destroy;
var
  i: Integer;
begin
  ReallocMem(fOptionalHeader, 0);
  for i := 0 to fSectionList.Count - 1 do
    TObject(fSectionList[i]).Free;
  fSectionList.Free;
  fDOSStub.Free;
  ReallocMem(fCommentBlock, 0);
  ReallocMem(fEndComment, 0);
  fBuffer.Free;
  inherited;
end;

(*----------------------------------------------------------------------*
 | procedure PEModule.Encode                                            |
 |                                                                      |
 | Fix up the data prior to writing to stream.                          |
 |                                                                      |
 | Ensure that the headers match what we've got...                      |
 *----------------------------------------------------------------------*)

procedure TPEModule.Encode(Stream: TMemoryStream);
begin
end;

(*----------------------------------------------------------------------*
 | function PEModule.FindDictionaryEntrySection                         |
 |                                                                      |
 | Return the index of the specified section.  The 'entryNo' to find    |
 | should be a 'IMAGE_DIRECTORY_ENTRY_xxxx' constant defined in         |
 | Windows.pas.                                                         |
 *----------------------------------------------------------------------*)

function TPEModule.FindDictionaryEntrySection(entryNo: Integer): Integer;
var
  i: Integer;
  p: PImageDataDirectory;
begin
  result := -1;
  p := DataDictionary[entryNo];
  // Find section with matching virt address.
  for i := 0 to ImageSectionCount - 1 do
    if ImageSection[i].fSectionHeader.VirtualAddress = p^.VirtualAddress then
    begin
      result := i;
      break
    end
end;

(*----------------------------------------------------------------------*
 | function TPEModule.GetCOFFHeader                                     |
 |                                                                      |
 | Return COFF header                                                   |
 *----------------------------------------------------------------------*)

function TPEModule.GetCOFFHeader: TImageFileHeader;
begin
  result := fCoffHeader;
end;

(*----------------------------------------------------------------------*
 | function TPEModule.GetDataDictionary                                 |
 |                                                                      |
 | Return the data dictionary for a specified                           |
 | IMAGE_DIRECTORY_ENTRY_xxxx  index                                    |
 *----------------------------------------------------------------------*)

function TPEModule.GetDataDictionary(index: Integer): PImageDataDirectory;
var
  p: PImageDataDirectory;
begin
  if index < DataDictionaryCount then
  begin
    p := @fOptionalHeader.DataDirectory[0];
    Inc(p, index);
    result := p
  end
  else
    raise ERangeError.Create(rstBadDictionaryIndex);
end;

(*----------------------------------------------------------------------*
 | function TPEModule.GetDataDictionaryCount                            |
 |                                                                      |
 | Return no of entries in the Data Directory                           |
 *----------------------------------------------------------------------*)

function TPEModule.GetDataDictionaryCount: Integer;
begin
  result := fOptionalHeader^.NumberOfRvaAndSizes
end;

(*----------------------------------------------------------------------*
 | function TPEModule.GetDosHeader                                      |
 |                                                                      |
 | Return DOS header                                                    |
 *----------------------------------------------------------------------*)

function TPEModule.GetDOSHeader: TImageDosHeader;
begin
  result := fDOSHeader;
end;

(*----------------------------------------------------------------------*
 | function TPEModule.GetImageSection () : TImageSection                |
 |                                                                      |
 | Get the specified image section                                      |
 *----------------------------------------------------------------------*)

function TPEModule.GetImageSection(index: Integer): TImageSectionRead;
begin
  result := TImageSectionRead(fSectionList[index]);
end;

(*----------------------------------------------------------------------*
 | function TPEModule.GetImageSectionCount                              |
 |                                                                      |
 | Return no of image sections                                          |
 *----------------------------------------------------------------------*)

function TPEModule.GetImageSectionCount: Integer;
begin
  result := fSectionList.Count
end;

(*----------------------------------------------------------------------*
 | procedure TPEModule.LoadFromFile                                     |
 |                                                                      |
 | Load the module from a file                                          |
 *----------------------------------------------------------------------*)

procedure TPEModule.LoadFromFile(const name: string);
var
  f: TFileStream;
begin
  f := TFileStream.Create(name, fmOpenRead or fmShareDenyNone);
  try
    LoadFromStream(f)
  finally
    f.Free
  end
end;

(*----------------------------------------------------------------------*
 | procedure TPEModule.LoadFromFile                                     |
 |                                                                      |
 | Load the module from a stream                                        |
 *----------------------------------------------------------------------*)

procedure TPEModule.LoadFromStream(s: TStream);
begin
  fBuffer.LoadFromStream(s);
  Decode(fBuffer.memory, fBuffer.size);
end;

(*----------------------------------------------------------------------*
 | procedure TPEModule.SaveToFile                                       |
 |                                                                      |
 | Save the module to a file                                            |
 *----------------------------------------------------------------------*)

procedure TPEModule.SaveToFile(const name: string);
var
  f: TFileStream;
begin
  f := TFileStream.Create(name, fmCreate);
  try
    SaveToStream(f)
  finally
    f.Free
  end
end;

(*----------------------------------------------------------------------*
 | procedure TPEModule.SaveToStream                                     |
 |                                                                      |
 | Save the module to a stream                                          |
 *----------------------------------------------------------------------*)

procedure TPEModule.SaveToStream(s: TStream);
begin
  Encode(fBuffer); // Encode the data.
  fBuffer.SaveToStream(s);
end;

{ TImageSectionRead }

constructor TImageSectionRead.Create(const AHeader: TImageSectionHeader; rawData: Pointer);
begin
  fSectionHeader := AHeader;
  fData := rawData;

  //  nb.  SizeOfRawData is usually bigger than VirtualSize because it's padded,
  //       and VirtualSize isn't.
  if fSectionHeader.Misc.VirtualSize <= fSectionHeader.SizeOfRawData then
  begin
    // Some linkers (?) set VirtualSize to 0 - which isn't correct.  Work round it.
    // (Encountered in MCL Link Lite HHT software )
    if (fSectionHeader.Misc.VirtualSize = 0) then
      fSectionHeader.Misc.VirtualSize := fSectionHeader.SizeOfRawData;
  end;
end;

{ TImageSectionWrite }

constructor TImageSectionWrite.Create(const AHeader: TImageSectionHeader; rawData: Pointer);
begin
  fSectionHeader := AHeader;
  fRawData := TMemoryStream.Create;

  //  nb.  SizeOfRawData is usually bigger than VirtualSize because it's padded,
  //       and VirtualSize isn't.
  if fSectionHeader.Misc.VirtualSize <= fSectionHeader.SizeOfRawData then
  begin
    // Some linkers (?) set VirtualSize to 0 - which isn't correct.  Work round it.
    // (Encountered in MCL Link Lite HHT software )
    if (fSectionHeader.Misc.VirtualSize = 0) then
      fSectionHeader.Misc.VirtualSize := fSectionHeader.SizeOfRawData;

    if (rawData <> nil) then fRawData.Write(rawData^, fSectionHeader.Misc.VirtualSize)
  end
  else
  // nb.  If VirtualSize is bigger than SizeOfRawData it implies that extra padding is required.
  //      Save the amount, so we can get all the COFF header values right.  See 'Encode' above.
  begin
    if (rawData <> nil) then fRawData.Write(rawData^, fSectionHeader.SizeOfRawData);
  end;
end;

destructor TImageSectionWrite.Destroy;
begin
  fRawData.Free;
  inherited;
end;


{ TPEResourceModule }

(*----------------------------------------------------------------------*
 | function TPEResourceModule.                                          |
 |                                                                      |
 | Return the TImageSection that contains 'resource' data. - eg.  the   |
 | .rsrc one.                                                           |
 *----------------------------------------------------------------------*)

function TPEResourceModule.GetResourceSection: TImageSectionRead;
var
  idx: Integer;
begin
  idx := FindDictionaryEntrySection(IMAGE_DIRECTORY_ENTRY_RESOURCE);
  if idx = -1 then
    result := nil
  else
    result := ImageSection[idx]
end;

(*----------------------------------------------------------------------*
 | procedure TPEResourceModule.DeleteResource                           |
 |                                                                      |
 | Delete the specified resource (by index)                             |
 *----------------------------------------------------------------------*)

procedure TPEResourceModule.DeleteResource(resourceNo: Integer);
var
  res: TResourceDetails;
begin
  res := ResourceDetails[resourceNo];
  inherited;
  resourceNo := IndexOfResource(Res);
  if resourceNo <> -1 then
  begin
    TObject(fDetailList[resourceNo]).Free;
    fDetailList.Delete(resourceNo);
  end;
end;

(*----------------------------------------------------------------------*
 | constructor TPEResourceModule.Create                                 |
 |                                                                      |
 | Constructor for TPEResourceModule                                    |
 *----------------------------------------------------------------------*)

constructor TPEResourceModule.Create;
begin
  inherited Create;
  fDetailList := TList.Create;
end;

(*----------------------------------------------------------------------*
 | destructor TPEResourceModule.Destroy                                 |
 |                                                                      |
 | Destructor for TPEResourceModule                                     |
 *----------------------------------------------------------------------*)

destructor TPEResourceModule.Destroy;
var
  i: Integer;
begin
  for i := 0 to fDetailList.Count - 1 do
    TObject(fDetailList[i]).Free;
  fDetailList.Free;
  inherited;
end;

(*----------------------------------------------------------------------*
 | function TPEResourceModule.Decode                                    |
 |                                                                      |
 | Decode the section's resource tree into a list of resource details   |
 *----------------------------------------------------------------------*)

procedure TPEResourceModule.Decode;
var
  section: TImageSectionRead;
  tp, name: string;
  lang: Integer;

  // Get string resource name

  function GetResourceStr(IdorName: boolean; section: TImageSectionRead; n: DWORD): string;
  var
    p: PWideChar;
  begin
    if IdorName then
      result := IntToStr(n)
    else
    begin
      p := PWideChar(PChar(section.fData) + (n and $7FFFFFFF));
      result := ResourceWideCharToStr(p)
    end
  end;

  // (recursively) get resources

  procedure GetResource(offset, level: Integer);
  var
    entry: PResourceDirectoryEntry;
    i, count: Integer;
    IDorName: boolean;
    dataEntry: PResourceDataEntry;
    table: PResourceDirectoryTable;
    details: TResourceDetails;
  begin
    table := PResourceDirectoryTable(PChar(section.fData) + offset);
    with table^ do
      count := cNameEntries + cIDEntries;

    entry := PResourceDirectoryEntry(PChar(section.fData) +
      offset + sizeof(TResourceDirectoryTable));
    for i := 0 to count - 1 do
    begin
      idOrName := i >= table^.cNameEntries;
      case level of
        0: tp := GetResourceStr(IDOrName, section, entry^.name);
        1:
          name := GetResourceStr(IDOrName, section, entry^.name);
        2:
          begin
            if not IdOrName then
              raise EPEException.Create(rstBadLangID);

            lang := entry^.name
          end
      end;

      if (entry^.RVA and $80000000) <> 0 then // Not a leaf node - traverse the tree
        GetResource(entry^.RVA and $7FFFFFFF, level + 1)
      else
      begin
        // It's a leaf node - create resource details
        dataEntry := PResourceDataEntry(PChar(section.fData) + entry^.RVA);
        details := TResourceDetails.Create(self, lang, name, tp,
          dataEntry^.Size, PChar(section.fData) +
          dataEntry^.OffsetToData - section.fSectionHeader.VirtualAddress);
        details.CodePage := dataEntry^.CodePage;
        details.Characteristics := table^.characteristics;
        details.DataVersion := DWORD(table^.versionMajor) * 65536 +
          DWORD(table^.versionMinor);
      end;

      Inc(entry)
    end
  end;

begin
  inherited;
  section := GetResourceSection;
  if section <> nil then
    GetResource(0, 0)
end;

(*----------------------------------------------------------------------*
 | function TPEResourceModule.GetResourceCount                          |
 |                                                                      |
 | Return the number of resources in the resource section               |
 *----------------------------------------------------------------------*)

function TPEResourceModule.GetResourceCount: Integer;
begin
  result := fDetailList.Count;
end;

(*----------------------------------------------------------------------*
 | function TPEResourceModule.GetResourceDetails                        |
 |                                                                      |
 | Get the resource details for the specified resource.                 |
 *----------------------------------------------------------------------*)

function TPEResourceModule.GetResourceDetails(
  idx: Integer): TResourceDetails;
begin
  result := TResourceDetails(fDetailList[idx]);
end;

(*----------------------------------------------------------------------*
 | function TPEResourceModule.IndexOfResource                           |
 |                                                                      |
 | Return the index of the specified resource details in the resource   |
 *----------------------------------------------------------------------*)

function TPEResourceModule.IndexOfResource(details: TResourceDetails): Integer;
begin
  result := fDetailList.IndexOf(details);
end;

(*----------------------------------------------------------------------*
 | function TPEResourceModule.InsertResource                            |
 |                                                                      |
 | Insert a resource in the list.                                       |
 *----------------------------------------------------------------------*)

procedure TPEResourceModule.InsertResource(idx: Integer;
  details: TResourceDetails);
begin
  fDetailList.Insert(idx, details);
end;

(*----------------------------------------------------------------------*
 | function TPEResourceModule.Encode                                    |
 |                                                                      |
 | Complicated?  I'll give you complicated ...                          |
 *----------------------------------------------------------------------*)

procedure TPEResourceModule.Encode(Stream: TMemoryStream);
var
  i: Integer;
  details: TResourceDetails;
  readsection: TImageSectionRead;
  section: TImageSectionWrite;
  root: TResourceNode;
  versMajor, versMinor: word;
  TimeStamp: DWORD;
  nameSize, nameOffset, namePos, tableOffset: DWORD;
  deOffset, dePos, deSize: DWORD;
  dataOffset, dataPos, dataSize: DWORD;

  nameTable: PChar;
  deTable: PChar;
  data: PChar;
  zeros: PChar;

  //------------------------------------------------------------------
  // Calculate offset and size of name table and DirectoryEntry table.
  // Calculate size of data

  procedure GetNameTableSize(node: TResourceNode);
  var
    i: Integer;
  begin
    Inc(nameOffset, sizeof(TResourceDirectoryTable));
    Inc(deOffset, sizeof(TResourceDirectoryTable));

    for i := 0 to node.count - 1 do
    begin
      Inc(nameOffset, sizeof(TResourceDirectoryEntry));
      Inc(deOffset, sizeof(TResourceDirectoryEntry));

      if not node.nodes[i].intID then
        Inc(nameSize, Length(node.nodes[i].id) * sizeof(WideChar) + sizeof(word));

      if not node.nodes[i].leaf then
        GetNameTableSize(node.nodes[i].next)
      else
      begin
        Inc(nameOffset, sizeof(TResourceDataEntry));
        Inc(deSize, sizeof(TResourceDataEntry));
        dataSize := (dataSize + DWORD(node.nodes[i].data.Size) + 3) div 4 * 4;
      end
    end
  end;

  //------------------------------------------------------------------
  // Save a node to section.fRawData (and save it's child nodes recursively)

  procedure SaveToSection(node: TResourceNode);
  var
    table: TResourceDirectoryTable;
    entry: TResourceDirectoryEntry;
    dataEntry: PResourceDataEntry;
    i, n: Integer;
    w: WideString;
    wl: word;

    //------------------------------------------------------------------
    // Save entry (i), and the child nodes

    procedure SaveNode(i: Integer);
    begin
      if node.nodes[i].intID then // id is a simple integer
        entry.name := StrToInt(node.nodes[i].id)
      else
      begin // id is an offset to a name in the
        // name table.
        entry.name := nameOffset + namePos + $80000000;
        w := node.nodes[i].id;
        wl := Length(node.nodes[i].id);
        Move(wl, nameTable[namePos], sizeof(wl));
        Inc(namePos, sizeof(wl));
        Move(w[1], nameTable[namePos], wl * sizeof(WideChar));
        Inc(namePos, wl * sizeof(WideChar))
      end;

      if node.nodes[i].leaf then // RVA points to a TResourceDataEntry in the
      begin // data entry table.
        entry.RVA := deOffset + dePos;
        dataEntry := PResourceDataEntry(deTable + dePos);
        dataEntry^.CodePage := node.nodes[i].CodePage;
        dataEntry^.Reserved := 0;
        dataEntry^.Size := node.nodes[i].data.Size;
        dataEntry^.OffsetToData := dataOffset + dataPos +
          section.fSectionHeader.VirtualAddress;

        Move(node.nodes[i].data.memory^, data[dataPos], dataEntry^.Size);

        Inc(dePos, sizeof(TResourceDataEntry));
        dataPos := (dataPos + dataEntry^.size + 3) div 4 * 4;
        section.fRawData.Write(entry, sizeof(entry));
      end
      else // RVA points to another table.
      begin
        entry.RVA := $80000000 + tableOffset;
        section.fRawData.Write(entry, sizeof(entry));
        n := section.fRawData.Position;
        SaveToSection(node.nodes[i].next);
        section.fRawData.Seek(n, soFromBeginning);
      end
    end;

  begin { SaveToSection }
    table.characteristics := 0;
    table.timeDateStamp := TimeStamp;
    table.versionMajor := versMajor;
    table.versionMinor := versMinor;
    table.cNameEntries := 0;
    table.cIDEntries := 0;

    // Calculate no of integer and string IDs
    for i := 0 to node.count - 1 do
      if node.nodes[i].intID then
        Inc(table.cIDEntries)
      else
        Inc(table.cNameEntries);

    section.fRawData.Seek(tableOffset, soFromBeginning);
    section.fRawData.Write(table, sizeof(table));

    tableOffset := tableOffset + sizeof(TResourceDirectoryTable) +
      DWORD(node.Count) * sizeof(TResourceDirectoryEntry);

    // The docs suggest that you save the nodes
    // with string entries first.  Goodness knows why,
    // but play along...
    for i := 0 to node.count - 1 do
      if not node.nodes[i].intID then
        SaveNode(i);

    for i := 0 to node.count - 1 do
      if node.nodes[i].intID then
        SaveNode(i);

    section.fRawData.Seek(0, soFromEnd);
  end;

begin { Encode }
  readsection := GetResourceSection;
  section := TImageSectionWrite.Create(readsection.fSectionHeader, nil);
  try
    // Get the details in a tree structure
    root := nil;
    data := nil;
    deTable := nil;
    zeros := nil;

    try
      for i := 0 to fDetailList.Count - 1 do
      begin
        details := TResourceDetails(fDetailList.Items[i]);
        if root = nil then
          root := TResourceNode.Create(details.ResourceType, details.ResourceName,
            details.ResourceLanguage, details.Data, details.CodePage)
        else
          root.Add(details.ResourceType, details.ResourceName,
            details.ResourceLanguage, details.Data, details.CodePage)
      end;

      // Save elements of their original EXE
      versMajor := PResourceDirectoryTable(readsection.fData)^.versionMajor;
      versMinor := PResourceDirectoryTable(readsection.fData)^.versionMinor;
      TimeStamp := PResourceDirectoryTable(readsection.fData)^.timeDateStamp;

      section.fRawData.Clear; // Clear the data.  We're gonna recreate
      // it from our resource details.

      nameSize := 0;
      nameOffset := 0;
      deSize := 0;
      deOffset := 0;
      dataSize := 0;

      GetNameTableSize(root); // Calculate sizes and offsets of the
      // name table, the data entry table and
      // the size of the data.

      // Calculate the data offset.  Must be aligned.
      dataOffset := (nameOffset + nameSize + 15) div 16 * 16;

      // Initialize globals...
      namePos := 0; //   Offset of next entry in the string table
      dePos := 0; //   Offset of next entry in the data entry table
      dataPos := 0; //   Offset of next data block.
      tableOffset := 0; //   Offset of next TResourceDirectoryTable

      GetMem(nameTable, nameSize); // Allocate buffers for tables
      GetMem(data, dataSize);
      GetMem(deTable, deSize);

      SaveToSection(root); // Do the work.

      // Save the tables
      section.fRawData.Write(deTable^, deSize);
      section.fRawData.Write(nameTable^, nameSize);

      // Add padding so the data goes on a
      // 16 byte boundary.
      if DWORD(section.fRawData.Position) < dataOffset then
      begin
        GetMem(zeros, dataOffset - DWORD(section.fRawData.Position));
        ZeroMemory(zeros, dataOffset - DWORD(section.fRawData.Position));
        section.fRawData.Write(zeros^, dataOffset - DWORD(section.fRawData.Position))
      end;

      // Write the data.
      section.fRawData.Write(data^, dataSize);

    finally // Tidy up.
      ReallocMem(zeros, 0);
      FreeMem(nameTable);
      FreeMem(deTable);
      FreeMem(data);
      root.Free
    end;

    WriteResourceSection(Stream, section.fRawData);
  finally
    section.Free;
  end;
end;

{ TResourceNode }

const
  MinCountStep = 64;

procedure TResourceNode.SetSize(NewSize: DWord);
begin
{$IFDEF Delphi4Up}
  FRealCount := NewSize;
  SetLength(nodes, FRealCount);
{$ENDIF}
end;

procedure TResourceNode.SetInitialSize;
begin
  SetSize(1);
end;

procedure TResourceNode.ChangeSize(NewSize: DWord);
{$IFDEF Delphi4Up}
var
  IntPart, ModPart, NewCount: DWord;
begin
  if (NewSize > FRealCount) then
  begin
    IntPart := (NewSize div MinCountStep);
    ModPart := (NewSize mod MinCountStep);
    NewCount := (IntPart * MinCountStep);
    if (ModPart > 0) then Inc(NewCount, MinCountStep);
    SetSize(NewCount);
  end;
{$ELSE}
begin
{$ENDIF}
end;

procedure TResourceNode.Add(const AType, AName: string; ALang: Integer;
  aData: TMemoryStream; codePage: DWORD);
var
  i: Integer;

begin
  for i := 0 to count - 1 do
    if AType = nodes[i].id then
    begin
      nodes[i].next.AddName(AName, ALang, aData, codePage);
      exit
    end;

  Inc(count);
  //  SetLength (nodes, count);
  ChangeSize(count);
  nodes[count - 1].id := AType;
  nodes[count - 1].intID := isID(count - 1);
  nodes[count - 1].leaf := False;
  nodes[count - 1].next := TResourceNode.CreateNameNode(AName, ALang, AData, codePage)
end;

procedure TResourceNode.AddLang(ALang: Integer; aData: TMemoryStream; codePage: DWORD);
var
  i: Integer;
begin
  for i := 0 to count - 1 do
    if IntToStr(ALang) = nodes[i].id then
    begin
      nodes[i].data := aData;
      exit
    end;

  Inc(count);
  //  SetLength (nodes, count);
  ChangeSize(count);
  nodes[count - 1].id := IntToStr(ALang);
  nodes[count - 1].intId := True;
  nodes[count - 1].leaf := True;
  nodes[count - 1].data := aData;
  nodes[count - 1].CodePage := codePage;
end;

procedure TResourceNode.AddName(const AName: string; ALang: Integer;
  aData: TMemoryStream; codePage: DWORD);
var
  i: Integer;
begin
  for i := 0 to count - 1 do
    if AName = nodes[i].id then
    begin
      nodes[i].next.AddLang(ALang, aData, codePage);
      exit
    end;

  Inc(count);
  //  SetLength (nodes, count);
  ChangeSize(count);
  nodes[count - 1].id := AName;
  nodes[count - 1].intID := isID(count - 1);
  nodes[count - 1].leaf := False;
  nodes[count - 1].next := TResourceNode.CreateLangNode(ALang, aData, codePage)
end;

constructor TResourceNode.Create(const AType, AName: string;
  ALang: Integer; aData: TMemoryStream; codePage: DWORD);
begin
  count := 1;
  //  SetLength (nodes, 1);
  SetInitialSize;
  nodes[0].id := AType;
  nodes[count - 1].intID := isID(count - 1);
  nodes[0].leaf := False;
  nodes[0].next := TResourceNode.CreateNameNode(AName, ALang, aData, codePage);
end;

constructor TResourceNode.CreateLangNode(ALang: Integer;
  aData: TMemoryStream; codePage: DWORD);
begin
  count := 1;
  //  SetLength (nodes, 1);
  SetInitialSize;
  nodes[0].id := IntToStr(ALang);
  nodes[count - 1].intID := True;
  nodes[0].leaf := True;
  nodes[0].data := aData;
  nodes[0].CodePage := codePage
end;

constructor TResourceNode.CreateNameNode(const AName: string;
  ALang: Integer; aData: TMemoryStream; codePage: DWORD);
begin
  count := 1;
  //  SetLength (nodes, 1);
  SetInitialSize;
  nodes[0].id := AName;
  nodes[count - 1].intID := isID(count - 1);

  nodes[0].leaf := False;
  nodes[0].next := TResourceNode.CreateLangNode(ALang, aData, codePage)
end;

destructor TResourceNode.Destroy;
var
  i: Integer;
begin
  for i := 0 to count - 1 do
    if not nodes[i].leaf then
      nodes[i].next.Free;
  inherited;
end;

function TResourceNode.IsID(idx: Integer): boolean;
var
  i: Integer;
begin
  Result := True;
  if (nodes[idx].id = '') then
  begin
    Result := False;
    Exit;
  end;

  for i := 1 to Length(nodes[idx].id) do
    if not (nodes[idx].id[i] in ['0'..'9']) then
    begin
      Result := False;
      Exit;
    end;

  if Result then
    Result := (IntToStr(StrToInt(nodes[idx].id)) = nodes[idx].id);
end;

function TPEResourceModule.AddResource(details: TResourceDetails): Integer;
begin
  Result := fDetailList.Add(details);
end;

procedure TPEResourceModule.SortResources;
begin
  fDetailList.Sort(CompareDetails);
end;

end.

