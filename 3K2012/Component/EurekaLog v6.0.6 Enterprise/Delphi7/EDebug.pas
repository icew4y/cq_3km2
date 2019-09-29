{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{             Debug Unit - EDebug                }
{                                                }
{************************************************}

// -----------------------------------------------
// 28-February-2006   Modify by Fabio Dell'Aria. |
// -----------------------------------------------

// Modifies:
// -----------------------------------------------------------------
// 1)...some TDS (TD32) fixes                                      |
// 2)...TJclDebugInfoSource.ValidData method added                 |
// -----------------------------------------------------------------

// Notes:
// ----------------------------------------------
// the original 'JclDebug' and 'JclTD32' units  |
// are modified and merged into this new unit.  |
// ----------------------------------------------

{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is JclDebug.pas.                                                               }
{                                                                                                  }
{ The Initial Developers of the Original Code are Petr Vones and Marcel van Brakel.                }
{ Portions created by these individuals are Copyright (C) of these individuals.                    }
{ All Rights Reserved.                                                                             }
{                                                                                                  }
{ Contributor(s):                                                                                  }
{   Marcel van Brakel                                                                              }
{   Flier Lu (flier)                                                                               }
{   Florent Ouchet (outchy)                                                                        }
{   Robert Marquardt (marquardt)                                                                   }
{   Robert Rossmair (rrossmair)                                                                    }
{   Petr Vones (pvones)                                                                            }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Various debugging support routines and classes. This includes: Diagnostics routines, Trace       }
{ routines, Stack tracing and Source Locations a la the C/C++ __FILE__ and __LINE__ macros.        }
{                                                                                                  }
{ Unit owner: Petr Vones                                                                           }
{                                                                                                  }
{**************************************************************************************************}

unit EDebug;

{$I Exceptions.inc}

interface

uses
  Windows, Classes, SysUtils;

const
  Borland32BitSymbolFileSignatureForDelphi = $39304246; // 'FB09'
  Borland32BitSymbolFileSignatureForBCB    = $41304246; // 'FB0A'

type
  { Signature structure }
  PJclTD32FileSignature = ^TELTD32FileSignature;
  TELTD32FileSignature = packed record
    Signature: DWORD;
    Offset: DWORD;
  end;

const
  { Subsection Types }
  SUBSECTION_TYPE_MODULE         = $120;
  SUBSECTION_TYPE_TYPES          = $121;
  SUBSECTION_TYPE_SYMBOLS        = $124;
  SUBSECTION_TYPE_ALIGN_SYMBOLS  = $125;
  SUBSECTION_TYPE_SOURCE_MODULE  = $127;
  SUBSECTION_TYPE_GLOBAL_SYMBOLS = $129;
  SUBSECTION_TYPE_GLOBAL_TYPES   = $12B;
  SUBSECTION_TYPE_NAMES          = $130;

type
  PDirectoryEntry = ^TDirectoryEntry;
  TDirectoryEntry = packed record
    SubsectionType: Word; // Subdirectory type
    ModuleIndex: Word;    // Module index
    Offset: DWORD;        // Offset from the base offset lfoBase
    Size: DWORD;          // Number of bytes in subsection
  end;

  PDirectoryHeader = ^TDirectoryHeader;
  TDirectoryHeader = packed record
    Size: Word;           // Length of this structure
    DirEntrySize: Word;   // Length of each directory entry
    DirEntryCount: DWORD; // Number of directory entries
    lfoNextDir: DWORD;    // Offset from lfoBase of next directory.
    Flags: DWORD;         // Flags describing directory and subsection tables.
    DirEntries: array [0..0] of TDirectoryEntry;
  end;

{*******************************************************************************
  SUBSECTION_TYPE_MODULE $120
*******************************************************************************}

type
  PSegmentInfo = ^TSegmentInfo;
  TSegmentInfo = packed record
    Segment: Word; // Segment that this structure describes
    Flags: Word;   // Attributes for the logical segment.
                   // The following attributes are defined:
                   //   $0000  Data segment
                   //   $0001  Code segment
    Offset: DWORD; // Offset in segment where the code starts
    Size: DWORD;   // Count of the number of bytes of code in the segment
  end;
  PSegmentInfoArray = ^TSegmentInfoArray;
  TSegmentInfoArray = array [0..32767] of TSegmentInfo;

  PModuleInfo = ^TModuleInfo;
  TModuleInfo = packed record
    OverlayNumber: Word;  // Overlay number
    LibraryIndex: Word;   // Index into sstLibraries subsection
                          // if this module was linked from a library
    SegmentCount: Word;   // Count of the number of code segments
                          // this module contributes to
    DebuggingStyle: Word; // Debugging style  for this  module.
    NameIndex: DWORD;     // Name index of module.
    TimeStamp: DWORD;     // Time stamp from the OBJ file.
    Reserved: array [0..2] of DWORD; // Set to 0.
    Segments: array [0..0] of TSegmentInfo;
                          // Detailed information about each segment
                          // that code is contributed to.
                          // This is an array of cSeg count segment
                          // information descriptor structures.
  end;

{*******************************************************************************
  SUBSECTION_TYPE_SOURCE_MODULE $0127
*******************************************************************************}
type
  { The line number to address mapping information is contained in a table with
    the following format: }
  PLineMappingEntry = ^TLineMappingEntry;
  TLineMappingEntry = packed record
    SegmentIndex: Word;  // Segment index for this table
    PairCount: Word;     // Count of the number of source line pairs to follow
    Offsets: array [0..0] of DWORD;
                     // An array of 32-bit offsets for the offset
                     // within the code segment ofthe start of ine contained
                     // in the parallel array linenumber.
  end;

  TOffsetPair = packed record
    StartOffset: DWORD;
    EndOffset: DWORD;
  end;
  POffsetPairArray = ^TOffsetPairArray;
  TOffsetPairArray = array [0..32767] of TOffsetPair;

  { The file table describes the code segments that receive code from this
    source file. Source file entries have the following format: }
  PSourceFileEntry = ^TSourceFileEntry;
  TSourceFileEntry = packed record
    SegmentCount: Word; // Number of segments that receive code from this source file.
    NameIndex: DWORD;   // Name index of Source file name.

    BaseSrcLines: array [0..0] of DWORD;
                        // An array of offsets for the line/address mapping
                        // tables for each of the segments that receive code
                        // from this source file.
  end;

  { The module header structure describes the source file and code segment
    organization of the module. Each module header has the following format: }
  PSourceModuleInfo = ^TSourceModuleInfo;
  TSourceModuleInfo = packed record
    FileCount: Word;    // The number of source file scontributing code to segments
    SegmentCount: Word; // The number of code segments receiving code from this module
    BaseSrcFiles: array [0..0] of DWORD;
  end;

{*******************************************************************************
  SUBSECTION_TYPE_GLOBAL_TYPES $12b
*******************************************************************************}

type
  PGlobalTypeInfo = ^TGlobalTypeInfo;
  TGlobalTypeInfo = packed record
    Count: DWORD; // count of the number of types
    // offset of each type string from the beginning of table
    Offsets: array [0..0] of DWORD;
  end;

const
  { Symbol type defines }
  SYMBOL_TYPE_COMPILE        = $0001; // Compile flags symbol
  SYMBOL_TYPE_REGISTER       = $0002; // Register variable
  SYMBOL_TYPE_CONST          = $0003; // Constant symbol
  SYMBOL_TYPE_UDT            = $0004; // User-defined Type
  SYMBOL_TYPE_SSEARCH        = $0005; // Start search
  SYMBOL_TYPE_END            = $0006; // End block, procedure, with, or thunk
  SYMBOL_TYPE_SKIP           = $0007; // Skip - Reserve symbol space
  SYMBOL_TYPE_CVRESERVE      = $0008; // Reserved for Code View internal use
  SYMBOL_TYPE_OBJNAME        = $0009; // Specify name of object file

  SYMBOL_TYPE_BPREL16        = $0100; // BP relative 16:16
  SYMBOL_TYPE_LDATA16        = $0101; // Local data 16:16
  SYMBOL_TYPE_GDATA16        = $0102; // Global data 16:16
  SYMBOL_TYPE_PUB16          = $0103; // Public symbol 16:16
  SYMBOL_TYPE_LPROC16        = $0104; // Local procedure start 16:16
  SYMBOL_TYPE_GPROC16        = $0105; // Global procedure start 16:16
  SYMBOL_TYPE_THUNK16        = $0106; // Thunk start 16:16
  SYMBOL_TYPE_BLOCK16        = $0107; // Block start 16:16
  SYMBOL_TYPE_WITH16         = $0108; // With start 16:16
  SYMBOL_TYPE_LABEL16        = $0109; // Code label 16:16
  SYMBOL_TYPE_CEXMODEL16     = $010A; // Change execution model 16:16
  SYMBOL_TYPE_VFTPATH16      = $010B; // Virtual function table path descriptor 16:16

  SYMBOL_TYPE_BPREL32        = $0200; // BP relative 16:32
  SYMBOL_TYPE_LDATA32        = $0201; // Local data 16:32
  SYMBOL_TYPE_GDATA32        = $0202; // Global data 16:32
  SYMBOL_TYPE_PUB32          = $0203; // Public symbol 16:32
  SYMBOL_TYPE_LPROC32        = $0204; // Local procedure start 16:32
  SYMBOL_TYPE_GPROC32        = $0205; // Global procedure start 16:32
  SYMBOL_TYPE_THUNK32        = $0206; // Thunk start 16:32
  SYMBOL_TYPE_BLOCK32        = $0207; // Block start 16:32
  SYMBOL_TYPE_WITH32         = $0208; // With start 16:32
  SYMBOL_TYPE_LABEL32        = $0209; // Label 16:32
  SYMBOL_TYPE_CEXMODEL32     = $020A; // Change execution model 16:32
  SYMBOL_TYPE_VFTPATH32      = $020B; // Virtual function table path descriptor 16:32

{*******************************************************************************
  Global and Local Procedure Start 16:32

  SYMBOL_TYPE_LPROC32 $0204
  SYMBOL_TYPE_GPROC32 $0205

*******************************************************************************}

type
  TSymbolProcInfo = packed record
    pParent: DWORD;
    pEnd: DWORD;
    pNext: DWORD;
    Size: DWORD;        // Length in bytes of this procedure
    DebugStart: DWORD;  // Offset in bytes from the start of the procedure to
                        // the point where the stack frame has been set up.
    DebugEnd: DWORD;    // Offset in bytes from the start of the procedure to
                        // the point where the  procedure is  ready to  return
                        // and has calculated its return value, if any.
                        // Frame and register variables an still be viewed.
    Offset: DWORD;      // Offset portion of  the segmented address of
                        // the start of the procedure in the code segment
    Segment: Word;      // Segment portion of the segmented address of
                        // the start of the procedure in the code segment
    ProcType: DWORD;    // Type of the procedure type record
    NearFar: Byte;      // Type of return the procedure makes:
                        //   0       near
                        //   4       far
    Reserved: Byte;
    NameIndex: DWORD;   // Name index of procedure
  end;

  TSymbolObjNameInfo = packed record
    Signature: DWORD;   // Signature for the CodeView information contained in
                        // this module
    NameIndex: DWORD;   // Name index of the object file
  end;

  TSymbolDataInfo = packed record
    Offset: DWORD;      // Offset portion of  the segmented address of
                        // the start of the data in the code segment
    Segment: Word;      // Segment portion of the segmented address of
                        // the start of the data in the code segment
    Reserved: Word;
    TypeIndex: DWORD;   // Type index of the symbol
    NameIndex: DWORD;   // Name index of the symbol
  end;

  TSymbolWithInfo = packed record
    pParent: DWORD;
    pEnd: DWORD;
    Size: DWORD;        // Length in bytes of this "with"
    Offset: DWORD;      // Offset portion of the segmented address of
                        // the start of the "with" in the code segment
    Segment: Word;      // Segment portion of the segmented address of
                        // the start of the "with" in the code segment
    Reserved: Word;
    NameIndex: DWORD;   // Name index of the "with"
  end;

  TSymbolLabelInfo = packed record
    Offset: DWORD;      // Offset portion of  the segmented address of
                        // the start of the label in the code segment
    Segment: Word;      // Segment portion of the segmented address of
                        // the start of the label in the code segment
    NearFar: Byte;      // Address mode of the label:
                        //   0       near
                        //   4       far
    Reserved: Byte;
    NameIndex: DWORD;   // Name index of the label
  end;

  TSymbolConstantInfo = packed record
    TypeIndex: DWORD;   // Type index of the constant (for enums)
    NameIndex: DWORD;   // Name index of the constant
    Reserved: DWORD;
    Value: DWORD;       // value of the constant
  end;

  TSymbolUdtInfo = packed record
    TypeIndex: DWORD;   // Type index of the type
    Properties: Word;   // isTag:1 True if this is a tag (not a typedef)
                        // isNest:1 True if the type is a nested type (its name
                        // will be 'class_name::type_name' in that case)
    NameIndex: DWORD;   // Name index of the type
    Reserved: DWORD;
  end;

  TSymbolVftPathInfo = packed record
    Offset: DWORD;      // Offset portion of start of the virtual function table
    Segment: Word;      // Segment portion of the virtual function table
    Reserved: Word;
    RootIndex: DWORD;   // The type index of the class at the root of the path
    PathIndex: DWORD;   // Type index of the record describing the base class
                        // path from the root to the leaf class for the virtual
                        // function table
  end;

type
  { Symbol Information Records }
  PSymbolInfo = ^TSymbolInfo;
  TSymbolInfo = packed record
    Size: Word;
    SymbolType: Word;
    case Word of
      SYMBOL_TYPE_LPROC32, SYMBOL_TYPE_GPROC32:
        (Proc: TSymbolProcInfo);
      SYMBOL_TYPE_OBJNAME:
        (ObjName: TSymbolObjNameInfo);
      SYMBOL_TYPE_LDATA32, SYMBOL_TYPE_GDATA32, SYMBOL_TYPE_PUB32:
        (Data: TSymbolDataInfo);
      SYMBOL_TYPE_WITH32:
        (With32: TSymbolWithInfo);
      SYMBOL_TYPE_LABEL32:
        (Label32: TSymbolLabelInfo);
      SYMBOL_TYPE_CONST:
        (Constant: TSymbolConstantInfo);
      SYMBOL_TYPE_UDT:
        (Udt: TSymbolUdtInfo);
      SYMBOL_TYPE_VFTPATH32:
        (VftPath: TSymbolVftPathInfo);
  end;

  PSymbolInfos = ^TSymbolInfos;
  TSymbolInfos = packed record
    Signature: DWORD;
    Symbols: array [0..0] of TSymbolInfo;
  end;

// TD32 information related classes
type
  TELModuleInfo = class(TObject)
  private
    FNameIndex: DWORD;
    FSegments: PSegmentInfoArray;
    FSegmentCount: Integer;
    function GetSegment(const Idx: Integer): TSegmentInfo;
  protected
    constructor Create(pModInfo: PModuleInfo);
  public
    property NameIndex: DWORD read FNameIndex;
    property SegmentCount: Integer read FSegmentCount; //GetSegmentCount;
    property Segment[const Idx: Integer]: TSegmentInfo read GetSegment; default;
  end;

  TELLineInfo = class(TObject)
  private
    FLineNo: DWORD;
    FOffset: DWORD;
  protected
    constructor Create(ALineNo, AOffset: DWORD);
  public
    property LineNo: DWORD read FLineNo;
    property Offset: DWORD read FOffset;
  end;

  TELSourceModuleInfo = class(TObject)
  private
    FLines: TList;
    FSegments: POffsetPairArray;
    FSegmentCount: Integer;
    FNameIndex: DWORD;
    function GetLine(const Idx: Integer): TELLineInfo;
    function GetLineCount: Integer;
    function GetSegment(const Idx: Integer): TOffsetPair;
  protected
    constructor Create(pSrcFile: PSourceFileEntry; Base: DWORD);
  public
    destructor Destroy; override;
    function FindLine(const AAddr: DWORD; var ALine: TELLineInfo): Boolean;
    property NameIndex: DWORD read FNameIndex;
    property LineCount: Integer read GetLineCount;
    property Line[const Idx: Integer]: TELLineInfo read GetLine; default;
    property SegmentCount: Integer read FSegmentCount; //GetSegmentCount;
    property Segment[const Idx: Integer]: TOffsetPair read GetSegment;
  end;

  TELSymbolInfo = class(TObject)
  private
    FSymbolType: Word;
  protected
    constructor Create(pSymInfo: PSymbolInfo); virtual;
    property SymbolType: Word read FSymbolType;
  end;

  TELProcSymbolInfo = class(TELSymbolInfo)
  private
    FNameIndex: DWORD;
    FOffset: DWORD;
    FSize: DWORD;
  protected
    constructor Create(pSymInfo: PSymbolInfo); override;
  public
    property NameIndex: DWORD read FNameIndex;
    property Offset: DWORD read FOffset;
    property Size: DWORD read FSize;
  end;

  TELLocalProcSymbolInfo = class(TELProcSymbolInfo);
  TELGlobalProcSymbolInfo = class(TELProcSymbolInfo);

  { not used by Delphi }
  TELObjNameSymbolInfo = class(TELSymbolInfo)
  private
    FSignature: DWORD;
    FNameIndex: DWORD;
  protected
    constructor Create(pSymInfo: PSymbolInfo); override;
  public
    property NameIndex: DWORD read FNameIndex;
    property Signature: DWORD read FSignature;
  end;

  TELDataSymbolInfo = class(TELSymbolInfo)
  private
    FOffset: DWORD;
    FTypeIndex: DWORD;
    FNameIndex: DWORD;
  protected
    constructor Create(pSymInfo: PSymbolInfo); override;
  public
    property NameIndex: DWORD read FNameIndex;
    property TypeIndex: DWORD read FTypeIndex;
    property Offset: DWORD read FOffset;
  end;

  TELLDataSymbolInfo = class(TELDataSymbolInfo);
  TELGDataSymbolInfo = class(TELDataSymbolInfo);
  TELPublicSymbolInfo = class(TELDataSymbolInfo);

  TELWithSymbolInfo = class(TELSymbolInfo)
  private
    FOffset: DWORD;
    FSize: DWORD;
    FNameIndex: DWORD;
  protected
    constructor Create(pSymInfo: PSymbolInfo); override;
  public
    property NameIndex: DWORD read FNameIndex;
    property Offset: DWORD read FOffset;
    property Size: DWORD read FSize;
  end;

  { not used by Delphi }
  TELLabelSymbolInfo = class(TELSymbolInfo)
  private
    FOffset: DWORD;
    FNameIndex: DWORD;
  protected
    constructor Create(pSymInfo: PSymbolInfo); override;
  public
    property NameIndex: DWORD read FNameIndex;
    property Offset: DWORD read FOffset;
  end;

  { not used by Delphi }
  TELConstantSymbolInfo = class(TELSymbolInfo)
  private
    FValue: DWORD;
    FTypeIndex: DWORD;
    FNameIndex: DWORD;
  protected
    constructor Create(pSymInfo: PSymbolInfo); override;
  public
    property NameIndex: DWORD read FNameIndex;
    property TypeIndex: DWORD read FTypeIndex; // for enums
    property Value: DWORD read FValue;
  end;

  TELUdtSymbolInfo = class(TELSymbolInfo)
  private
    FTypeIndex: DWORD;
    FNameIndex: DWORD;
    FProperties: Word;
  protected
    constructor Create(pSymInfo: PSymbolInfo); override;
  public
    property NameIndex: DWORD read FNameIndex;
    property TypeIndex: DWORD read FTypeIndex;
    property Properties: Word read FProperties;
  end;

  { not used by Delphi }
  TELVftPathSymbolInfo = class(TELSymbolInfo)
  private
    FRootIndex: DWORD;
    FPathIndex: DWORD;
    FOffset: DWORD;
  protected
    constructor Create(pSymInfo: PSymbolInfo); override;
  public
    property RootIndex: DWORD read FRootIndex;
    property PathIndex: DWORD read FPathIndex;
    property Offset: DWORD read FOffset;
  end;

  // TD32 parser
  TELTD32InfoParser = class(TObject)
  private
    FBase: Pointer;
    FData: TCustomMemoryStream;
    FNames: TList;
    FModules: TList;
    FSourceModules: TList;
    FSymbols: TList;
    FValidData: Boolean;
    function GetName(const Idx: Integer): string;
    function GetNameCount: Integer;
    function GetSymbol(const Idx: Integer): TELSymbolInfo;
    function GetSymbolCount: Integer;
    function GetModule(const Idx: Integer): TELModuleInfo;
    function GetModuleCount: Integer;
    function GetSourceModule(const Idx: Integer): TELSourceModuleInfo;
    function GetSourceModuleCount: Integer;
  protected
    procedure Analyse;
    procedure AnalyseNames(const pSubsection: Pointer; const Size: DWORD); virtual;
    procedure AnalyseAlignSymbols(pSymbols: PSymbolInfos; const Size: DWORD); virtual;
    procedure AnalyseModules(pModInfo: PModuleInfo; const Size: DWORD); virtual;
    procedure AnalyseSourceModules(pSrcModInfo: PSourceModuleInfo; const Size: DWORD); virtual;
    function LfaToVa(Lfa: DWORD): Pointer;
  public
    constructor Create(const ATD32Data: TCustomMemoryStream); // Data mustn't be freed before the class is destroyed
    destructor Destroy; override;
    function FindModule(const AAddr: DWORD; var AMod: TELModuleInfo): Boolean;
    function FindSourceModule(const AAddr: DWORD; var ASrcMod: TELSourceModuleInfo): Boolean;
    function FindProc(const AAddr: DWORD; var AProc: TELProcSymbolInfo): Boolean;
    class function IsTD32Sign(const Sign: TELTD32FileSignature): Boolean;
    class function IsTD32DebugInfoValid(const DebugData: Pointer; const DebugDataSize: DWord): Boolean;
    property Data: TCustomMemoryStream read FData;
    property Names[const Idx: Integer]: string read GetName;
    property NameCount: Integer read GetNameCount;
    property Symbols[const Idx: Integer]: TELSymbolInfo read GetSymbol;
    property SymbolCount: Integer read GetSymbolCount;
    property Modules[const Idx: Integer]: TELModuleInfo read GetModule;
    property ModuleCount: Integer read GetModuleCount;
    property SourceModules[const Idx: Integer]: TELSourceModuleInfo read GetSourceModule;
    property SourceModuleCount: Integer read GetSourceModuleCount;
    property ValidData: Boolean read FValidData;
  end;

  // TD32 scanner with source location methods
  TELTD32InfoScanner = class(TELTD32InfoParser)
  public
    function LineNumberFromAddr(AAddr: DWORD; var Offset: Integer): Integer;
    function ProcNameFromAddr(AAddr: DWORD; var Offset: Integer): string;
    function ModuleNameFromAddr(AAddr: DWORD): string;
    function SourceNameFromAddr(AAddr: DWORD): string;
  end;

  // PE Image with TD32 information and source location support
  TELPeBorTD32Image = class
  private
    FIsTD32DebugPresent: Boolean;
    FTD32DebugData: TCustomMemoryStream;
    FTD32Scanner: TELTD32InfoScanner;
    FModule: THandle;
  protected
    procedure Clear;
    procedure ClearDebugData;
    procedure CheckDebugData;
    function IsDebugInfoInImage(var DataStream: TCustomMemoryStream): Boolean;
    function IsDebugInfoInTds(var DataStream: TCustomMemoryStream): Boolean;
  public
    constructor Create(AModule: THandle);
    destructor Destroy; override;

    property IsTD32DebugPresent: Boolean read FIsTD32DebugPresent;
    property TD32DebugData: TCustomMemoryStream read FTD32DebugData write FTD32DebugData;
    property TD32Scanner: TELTD32InfoScanner read FTD32Scanner;
  end;

// MAP file abstract parser
type
  PJclMapAddress = ^TELMapAddress;
  TELMapAddress = packed record
    Segment: Word;
    Offset: Integer;
  end;

  PJclMapString = PAnsiChar;

  TELAbstractMapParser = class(TObject)
  private
    FLinkerBug: Boolean;
    FLinkerBugUnitName: PJclMapString;
    FStream: TMemoryStream;
    function GetLinkerBugUnitName: string;
  protected
    FLastUnitName: PJclMapString;
    FLastUnitFileName: PJclMapString;
    procedure ClassTableItem(const Address: TELMapAddress; Len: Integer; SectionName, GroupName: PJclMapString); virtual; abstract;
    procedure SegmentItem(const Address: TELMapAddress; Len: Integer; GroupName, UnitName: PJclMapString); virtual; abstract;
    procedure PublicsByNameItem(const Address: TELMapAddress; Name: PJclMapString); virtual; abstract;
    procedure PublicsByValueItem(const Address: TELMapAddress; Name: PJclMapString); virtual; abstract;
    procedure LineNumberUnitItem(UnitName, UnitFileName: PJclMapString); virtual; abstract;
    procedure LineNumbersItem(LineNumber: Integer; const Address: TELMapAddress); virtual; abstract;
  public
    constructor Create(const MapFileName: TFileName); virtual;
    destructor Destroy; override;
    procedure Parse;
    class function MapStringToStr(MapString: PJclMapString): string;
    class function MapStringToFileName(MapString: PJclMapString): string;
    property LinkerBug: Boolean read FLinkerBug;
    property LinkerBugUnitName: string read GetLinkerBugUnitName;
    property Stream: TMemoryStream read FStream;
  end;

  // MAP file parser
  TELMapClassTableEvent = procedure(Sender: TObject; const Address: TELMapAddress; Len: Integer; const SectionName, GroupName: string) of object;
  TELMapSegmentEvent = procedure(Sender: TObject; const Address: TELMapAddress; Len: Integer; const GroupName, UnitName: string) of object;
  TELMapPublicsEvent = procedure(Sender: TObject; const Address: TELMapAddress; const Name: string) of object;
  TELMapLineNumberUnitEvent = procedure(Sender: TObject; const UnitName, UnitFileName: string) of object;
  TELMapLineNumbersEvent = procedure(Sender: TObject; LineNumber: Integer; const Address: TELMapAddress) of object;

  TELMapParser = class(TELAbstractMapParser)
  private
    FOnClassTable: TELMapClassTableEvent;
    FOnLineNumbers: TELMapLineNumbersEvent;
    FOnLineNumberUnit: TELMapLineNumberUnitEvent;
    FOnPublicsByValue: TELMapPublicsEvent;
    FOnPublicsByName: TELMapPublicsEvent;
    FOnSegmentItem: TELMapSegmentEvent;
  protected
    procedure ClassTableItem(const Address: TELMapAddress; Len: Integer; SectionName, GroupName: PJclMapString); override;
    procedure SegmentItem(const Address: TELMapAddress; Len: Integer; GroupName, UnitName: PJclMapString); override;
    procedure PublicsByNameItem(const Address: TELMapAddress; Name: PJclMapString); override;
    procedure PublicsByValueItem(const Address: TELMapAddress; Name: PJclMapString); override;
    procedure LineNumberUnitItem(UnitName, UnitFileName: PJclMapString); override;
    procedure LineNumbersItem(LineNumber: Integer; const Address: TELMapAddress); override;
  public
    property OnClassTable: TELMapClassTableEvent read FOnClassTable write FOnClassTable;
    property OnSegment: TELMapSegmentEvent read FOnSegmentItem write FOnSegmentItem;
    property OnPublicsByName: TELMapPublicsEvent read FOnPublicsByName write FOnPublicsByName;
    property OnPublicsByValue: TELMapPublicsEvent read FOnPublicsByValue write FOnPublicsByValue;
    property OnLineNumberUnit: TELMapLineNumberUnitEvent read FOnLineNumberUnit write FOnLineNumberUnit;
    property OnLineNumbers: TELMapLineNumbersEvent read FOnLineNumbers write FOnLineNumbers;
  end;

  // MAP file scanner
  PJclMapSegment = ^TELMapSegment;
  TELMapSegment = record
    StartAddr: DWORD;
    EndAddr: DWORD;
    UnitName: PJclMapString;
  end;

  PJclMapProcName = ^TELMapProcName;
  TELMapProcName = record
    Addr: DWORD;
    ProcName: PJclMapString;
  end;

  PJclMapLineNumber = ^TELMapLineNumber;
  TELMapLineNumber = record
    Addr: DWORD;
    LineNumber: Integer;
  end;

  TLineNumbersArray= array [0..0] of TELMapLineNumber;
  TProcNamesArray= array [0..0] of TELMapProcName;
  TSegmentsArray= array [0..0] of TELMapSegment;
  TSourceNamesArray= array [0..0] of TELMapProcName;

  TELMapScanner = class(TELAbstractMapParser)
  private
    FLineNumbers: ^ TLineNumbersArray;
    FLineNumbersLen: Integer;
    FProcNames: ^ TProcNamesArray;
    FProcNamesLen: Integer;
    FSegments: ^ TSegmentsArray;
    FSegmentsLen: Integer;
    FSourceNames: ^ TSourceNamesArray;
    FSourceNamesLen: Integer;
    FLastValidAddr: TELMapAddress;
    FLineNumbersCnt: Integer;
    FLineNumberErrors: Integer;
    FNewUnitFileName: PJclMapString;
    FProcNamesCnt: Integer;
    FTopValidAddr: Integer;
  protected
    procedure ClassTableItem(const Address: TELMapAddress; Len: Integer; SectionName, GroupName: PJclMapString); override;
    procedure SegmentItem(const Address: TELMapAddress; Len: Integer; GroupName, UnitName: PJclMapString); override;
    procedure PublicsByNameItem(const Address: TELMapAddress; Name: PJclMapString); override;
    procedure PublicsByValueItem(const Address: TELMapAddress; Name: PJclMapString); override;
    procedure LineNumbersItem(LineNumber: Integer; const Address: TELMapAddress); override;
    procedure LineNumberUnitItem(UnitName, UnitFileName: PJclMapString); override;
    procedure Scan;
  public
    constructor Create(const MapFileName: TFileName); override;
    destructor Destroy; override;
    function LineNumberFromAddr(Addr: DWORD; var Offset: Integer): Integer;
    function ModuleNameFromAddr(Addr: DWORD): string;
    function ModuleStartFromAddr(Addr: DWORD): DWORD;
    function ProcNameFromAddr(Addr: DWORD; var Offset: Integer): string;
    function SourceNameFromAddr(Addr: DWORD): string;
    property LineNumberErrors: Integer read FLineNumberErrors;
  end;

// JCL binary debug data generator and scanner
const
  JclDbgDataSignature = $4742444A; // JDBG
  JclDbgDataResName   = 'JCLDEBUG';
  JclDbgFileExtension = '.jdbg';

  JclDbgHeaderVersion = 1; // JCL 1.11 and 1.20

  MapFileExtension    = '.map';
  DrcFileExtension    = '.drc';

type
  PJclDbgHeader = ^TELDbgHeader;
  TELDbgHeader = packed record
    Signature: DWORD;
    Version: Byte;
    Units: Integer;
    SourceNames: Integer;
    Symbols: Integer;
    LineNumbers: Integer;
    Words: Integer;
    ModuleName: Integer;
    CheckSum: Integer;
    CheckSumValid: Boolean;
  end;

  TELBinDbgNameCache = record
    Addr: DWORD;
    FirstWord: Integer;
    SecondWord: Integer;
  end;

  TBinProcNamesArray= array [0..0] of TELBinDbgNameCache;

  TELBinDebugScanner = class(TObject)
  private
    FCacheData: Boolean;
    FStream: TCustomMemoryStream;
    FValidFormat: Boolean;
    FLineNumbers: ^ TLineNumbersArray;
    FLineNumbersLen: Integer;
    FProcNames: ^ TBinProcNamesArray;
    FProcNamesLen: Integer;
    function GetModuleName: string;
  protected
    procedure CacheLineNumbers;
    procedure CacheProcNames;
    procedure CheckFormat;
    function DataToStr(A: Integer): string;
    function MakePtr(A: Integer): Pointer;
    function ReadValue(var P: Pointer; var Value: Integer): Boolean;
  public
    constructor Create(AStream: TCustomMemoryStream; CacheData: Boolean);
    destructor Destroy; override;
    function LineNumberFromAddr(Addr: DWORD; var Offset: Integer): Integer;
    function ProcNameFromAddr(Addr: DWORD; var Offset: Integer): string;
    function ModuleNameFromAddr(Addr: DWORD): string;
    function ModuleStartFromAddr(Addr: DWORD): DWORD;
    function SourceNameFromAddr(Addr: DWORD): string;
    property ModuleName: string read GetModuleName;
    property ValidFormat: Boolean read FValidFormat;
  end;

// Source Locations
type
  TELDebugInfoSource = class;

  PJclLocationInfo = ^TELLocationInfo;
  TELLocationInfo = record
    Address: Pointer;               // Error address
    UnitName: string;               // Name of Delphi unit
    ProcedureName: string;          // Procedure name
    ProcOffsetLine: Integer;        // Offset from Procedure line and Address line
    LineNumber: Integer;            // Line number
    SourceName: string;             // Module file name
    DebugInfo: TELDebugInfoSource;  // Location object
  end;

   TELDebugInfoSource = class(TObject)
  private
    FModule: HMODULE;
    function GetFileName: TFileName;
  protected
    function InitializeSource: Boolean; virtual; abstract;
    function VAFromAddr(const Addr: Pointer): DWORD; virtual;
  public
    constructor Create(AModule: HMODULE); virtual;
    function ValidData: Boolean; virtual; abstract;
    function GetLocationInfo(const Addr: Pointer; var Info: TELLocationInfo): Boolean; virtual; abstract;
    property Module: HMODULE read FModule;
    property FileName: TFileName read GetFileName;
  end;

  // Various source location implementations
  TELDebugInfoMap = class(TELDebugInfoSource)
  private
    FScanner: TELMapScanner;
  protected
    function InitializeSource: Boolean; override;
  public
    destructor Destroy; override;
    function ValidData: Boolean; override;
    function GetLocationInfo(const Addr: Pointer; var Info: TELLocationInfo): Boolean; override;
  end;

  TELDebugInfoJedy = class(TELDebugInfoSource)
  private
    FScanner: TELBinDebugScanner;
    FStream: TMemoryStream;
  protected
    function InitializeSource: Boolean; override;
  public
    destructor Destroy; override;
    function ValidData: Boolean; override;
    function GetLocationInfo(const Addr: Pointer; var Info: TELLocationInfo): Boolean; override;
  end;

  TELDebugInfoTD32 = class(TELDebugInfoSource)
  private
    FImage: TELPeBorTD32Image;
  protected
    function InitializeSource: Boolean; override;
  public
    destructor Destroy; override;
    function ValidData: Boolean; override;
    function GetLocationInfo(const Addr: Pointer; var Info: TELLocationInfo): Boolean; override;
  end;

function AssignValidDebugInfo(Module: THandle; var DebugInfo: TELDebugInfoSource): Boolean;

implementation

//=== Helper assembler routines ==============================================

const
  ModuleCodeOffset = $1000;
  AnsiWhiteSpace = [#9, #10, #11, #12, #13, ' '];
  AnsiDecDigits = ['0'..'9'];

type
  THModuleStream = class(TMemoryStream)
  public
    constructor Create(HModule: THandle; Size: Integer);
  end;

  TDynArraySortCompare = function (Item1, Item2: Pointer): Integer;

// Miscellaneous routines...

function Max(const B1, B2: DWord): DWord;
begin
  if B1 > B2 then
    Result := B1
  else
    Result := B2;
end;

function Min(const B1, B2: DWord): DWord;
begin
  if B1 < B2 then
    Result := B1
  else
    Result := B2;
end;

function SearchDynArray(const ArrayPtr: Pointer; ElementSize, ArraySize: Cardinal;
  SortFunc: TDynArraySortCompare; ValuePtr: Pointer; Nearest: Boolean): Integer;
var
  L, H, I, C: Integer;
  B: Boolean;
begin
  Result := -1;
  if ArrayPtr <> nil then
  begin
    L := 0;
    H := (ArraySize - 1);
    B := False;
    while L <= H do
    begin
      I := (L + H) shr 1;
      C := SortFunc(Pointer(Cardinal(ArrayPtr) + (Cardinal(I) * ElementSize)), ValuePtr);
      if C < 0 then L := I + 1
      else
      begin
        H := I - 1;
        if C = 0 then
        begin
          B := True;
          L := I;
        end;
      end;
    end;
    if B then Result := L
    else
    if Nearest and (H >= 0) then Result := H;
  end;
end;

function SafeLoadFromFileToStream(Stream: TMemoryStream; const FileName: string): Boolean;
var
  MapFile: TStream;
  HFile: THandle;
begin
  Result := False;
  HFile := CreateFile(PChar(FileName), GENERIC_READ,
    FILE_SHARE_READ or FILE_SHARE_WRITE,
    nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if (HFile <> INVALID_HANDLE_VALUE) then
  try
    MapFile := THandleStream.Create(HFile);
    try
      Stream.LoadFromStream(MapFile);
      Result := True;
    finally
      MapFile.Free;
    end;
  finally
    CloseHandle(HFile);
  end;
end;

//=== { TELAbstractMapParser } ==============================================

constructor TELAbstractMapParser.Create(const MapFileName: TFileName);
begin
  if FileExists(MapFileName) then
  begin
    FStream := TMemoryStream.Create;
    SafeLoadFromFileToStream(FStream, MapFileName);
  end;
end;

destructor TELAbstractMapParser.Destroy;
begin
  FStream.Free;
  FStream := nil;
  inherited Destroy;
end;

function TELAbstractMapParser.GetLinkerBugUnitName: string;
begin
  Result := MapStringToStr(FLinkerBugUnitName);
end;

class function TELAbstractMapParser.MapStringToFileName(
  MapString: PJclMapString): string;
var
  PStart, PEnd, PExtension: PChar;
begin
  if MapString = nil then
  begin
    Result := '';
    Exit;
  end;
  PEnd := MapString;
  while not (PEnd^ in [#13, '=']) do
    Inc(PEnd);
  if (PEnd^ = '=') then
  begin
    while not (PEnd^ = ' ') do
      Dec(PEnd);
    while ((PEnd-1)^ = ' ') do
      Dec(PEnd);
  end;
  PExtension := PEnd;
  while (not (PExtension^ in ['.', '|'])) and (PExtension >= MapString) do
    Dec(PExtension);
  if (PExtension^ = '.') then
    PEnd := PExtension;
  PExtension := PEnd;
  while (not (PExtension^ in ['|','\'])) and (PExtension >= MapString) do
    Dec(PExtension);
  if (PExtension^ in ['|','\']) then
    PStart := PExtension + 1
  else PStart := MapString;
  SetString(Result, PStart, PEnd - PStart);
end;

class function TELAbstractMapParser.MapStringToStr(MapString: PJclMapString): string;
var
  P: PChar;
begin
  if MapString = nil then
  begin
    Result := '';
    Exit;
  end;
  if MapString^ = '(' then
  begin
    Inc(MapString);
    P := MapString;
    while not (P^ in [#13, ')']) do
      Inc(P);
  end
  else
  begin
    P := MapString;
    while not (P^ in [' ', #13, '(']) do
      Inc(P);
  end;
  SetString(Result, MapString, P - MapString);
end;

procedure TELAbstractMapParser.Parse;
const
  TableHeader          : array [0..3] of string = ('Start', 'Length', 'Name', 'Class');
  SegmentsHeader       : array [0..3] of string = ('Detailed', 'map', 'of', 'segments');
  PublicsByNameHeader  : array [0..3] of string = ('Address', 'Publics', 'by', 'Name');
  PublicsByValueHeader : array [0..3] of string = ('Address', 'Publics', 'by', 'Value');
  LineNumbersPrefix    = 'Line numbers for';
  ResourceFilesHeader  : array [0..2] of string = ('Bound', 'resource', 'files');
var
  CurrPos, EndPos: PChar;
{$IFNDEF Delphi9Up}
  PreviousA,
{$ENDIF}
  A: TELMapAddress;
  L: Integer;
  P1, P2: PJclMapString;

  procedure SkipWhiteSpace;
  begin
    while CurrPos^ in AnsiWhiteSpace do
      Inc(CurrPos);
  end;

  procedure SkipEndLine;
  begin
    while CurrPos^ <> #10 do
      Inc(CurrPos);
    SkipWhiteSpace;
  end;

  function Eof: Boolean;
  begin
    Result := (CurrPos >= EndPos);
  end;

  function IsDecDigit: Boolean;
  begin
    Result := CurrPos^ in AnsiDecDigits;
  end;

  function ReadTextLine: string;
  var
    P: PChar;
  begin
    P := CurrPos;
    while not (CurrPos^ in [#13, #0]) do
      Inc(CurrPos);
    SetString(Result, P, CurrPos - P);
  end;


  function ReadDecValue: Integer;
  begin
    Result := 0;
    while CurrPos^ in AnsiDecDigits do
    begin
      Result := Result * 10 + (Ord(CurrPos^) - Ord('0'));
      Inc(CurrPos);
    end;
  end;

  function ReadHexValue: Integer;
  var
    C: Char;
  begin
    Result := 0;
    repeat
      C := CurrPos^;
      case C of
        '0'..'9':
          begin
            Result := Result * 16;
            Inc(Result, Ord(C) - Ord('0'));
          end;
        'A'..'F':
          begin
            Result := Result * 16;
            Inc(Result, Ord(C) - Ord('A') + 10);
          end;
        'a'..'f':
          begin
            Result := Result * 16;
            Inc(Result, Ord(C) - Ord('a') + 10);
          end;
        'H', 'h':
          begin
            Inc(CurrPos);
            Break;
          end;
      else
        Break;
      end;
      Inc(CurrPos);
    until False;
  end;

  function ReadAddress: TELMapAddress;
  begin
    Result.Segment := ReadHexValue;
    if CurrPos^ = ':' then
    begin
      Inc(CurrPos);
      Result.Offset := ReadHexValue;
    end
    else
      Result.Offset := 0;
  end;

  function ReadString: PJclMapString;
  begin
    SkipWhiteSpace;
    Result := CurrPos;
    while not (CurrPos^ in AnsiWhiteSpace) do
      Inc(CurrPos);
  end;

  procedure FindParam(Param: Char);
  begin
    while not ((CurrPos^ = Param) and ((CurrPos + 1)^ = '=')) do
      Inc(CurrPos);
    Inc(CurrPos, 2);
  end;

  function SyncToHeader(const Header: array of string): Boolean;
  var
    S: string;
    TokenIndex, OldPosition, CurrentPosition: Integer;
  begin
    Result := False;
    while not Eof do
    begin
      S := Trim(ReadTextLine);
      TokenIndex := Low(Header);
      CurrentPosition := 0;
      OldPosition := 0;
      while (TokenIndex <= High(Header)) do
      begin
        CurrentPosition := Pos(Header[TokenIndex],S);
        if (CurrentPosition <= OldPosition) then
        begin
          CurrentPosition := 0;
          Break;
        end;
        OldPosition := CurrentPosition;
        Inc(TokenIndex);
      end;
      Result := CurrentPosition <> 0;
      if Result then
        Break;
      SkipEndLine;
    end;
    if not Eof then
      SkipWhiteSpace;
  end;

  function SyncToPrefix(const Prefix: string): Boolean;
  var
    I: Integer;
    P: PChar;
    S: string;
  begin
    if Eof then
    begin
      Result := False;
      Exit;
    end;
    SkipWhiteSpace;
    I := Length(Prefix);
    P := CurrPos;
    while not Eof and (not (P^ in [#13, #0])) and (I > 0) do
    begin
      Inc(P);
      Dec(I);
    end;
    SetString(S, CurrPos, Length(Prefix));
    Result := (S = Prefix);
    if Result then
      CurrPos := P;
    SkipWhiteSpace;
  end;

begin
  if FStream <> nil then
  begin
    FLinkerBug := False;
{$IFNDEF Delphi9Up}
    PreviousA.Segment := 0;
    PreviousA.Offset := 0;
{$ENDIF}
    CurrPos := FStream.Memory;
    EndPos := CurrPos + FStream.Size;
    if SyncToHeader(TableHeader) then
      while IsDecDigit do
      begin
        A := ReadAddress;
        SkipWhiteSpace;
        L := ReadHexValue;
        P1 := ReadString;
        P2 := ReadString;
        SkipEndLine;
        ClassTableItem(A, L, P1, P2);
      end;
    if SyncToHeader(SegmentsHeader) then
      while IsDecDigit do
      begin
        A := ReadAddress;
        SkipWhiteSpace;
        L := ReadHexValue;
        FindParam('C');
        P1 := ReadString;
        FindParam('M');
        P2 := ReadString;
        SkipEndLine;
        SegmentItem(A, L, P1, P2);
      end;
    if SyncToHeader(PublicsByNameHeader) then
      while IsDecDigit do
      begin
        A := ReadAddress;
        P1 := ReadString;
        SkipWhiteSpace;
        PublicsByNameItem(A, P1);
      end;
    if SyncToHeader(PublicsByValueHeader) then
      while IsDecDigit do
      begin
        A := ReadAddress;
        P1 := ReadString;
        SkipWhiteSpace;
        PublicsByValueItem(A, P1);
      end;
    while SyncToPrefix(LineNumbersPrefix) do
    begin
      FLastUnitName := CurrPos;
      FLastUnitFileName := CurrPos;
      while FLastUnitFileName^ <> '(' do
        Inc(FLastUnitFileName);
      SkipEndLine;
      LineNumberUnitItem(FLastUnitName, FLastUnitFileName);
      repeat
        SkipWhiteSpace;
        L := ReadDecValue;
        SkipWhiteSpace;
        A := ReadAddress;
        SkipWhiteSpace;
        LineNumbersItem(L, A);
{$IFNDEF Delphi9Up}
        if (not FLinkerBug) and (A.Offset < PreviousA.Offset) then
        begin
          FLinkerBugUnitName := FLastUnitName;
          FLinkerBug := True;
        end;
        PreviousA := A;
{$ENDIF}
      until not IsDecDigit;
    end;
  end;
end;

//=== { TELMapParser 0 ======================================================

procedure TELMapParser.ClassTableItem(const Address: TELMapAddress;
  Len: Integer; SectionName, GroupName: PJclMapString);
begin
  if Assigned(FOnClassTable) then
    FOnClassTable(Self, Address, Len, MapStringToStr(SectionName), MapStringToStr(GroupName));
end;

procedure TELMapParser.LineNumbersItem(LineNumber: Integer; const Address: TELMapAddress);
begin
  if Assigned(FOnLineNumbers) then
    FOnLineNumbers(Self, LineNumber, Address);
end;

procedure TELMapParser.LineNumberUnitItem(UnitName, UnitFileName: PJclMapString);
begin
  if Assigned(FOnLineNumberUnit) then
    FOnLineNumberUnit(Self, MapStringToStr(UnitName), MapStringToStr(UnitFileName));
end;

procedure TELMapParser.PublicsByNameItem(const Address: TELMapAddress;
  Name: PJclMapString);
begin
  if Assigned(FOnPublicsByName) then
    FOnPublicsByName(Self, Address, MapStringToStr(Name));
end;

procedure TELMapParser.PublicsByValueItem(const Address: TELMapAddress;
  Name: PJclMapString);
begin
  if Assigned(FOnPublicsByValue) then
    FOnPublicsByValue(Self, Address, MapStringToStr(Name));
end;

procedure TELMapParser.SegmentItem(const Address: TELMapAddress;
  Len: Integer; GroupName, UnitName: PJclMapString);
begin
  if Assigned(FOnSegmentItem) then
    FOnSegmentItem(Self, Address, Len, MapStringToStr(GroupName), MapStringToFileName(UnitName));
end;

//=== { TELMapScanner } =====================================================

constructor TELMapScanner.Create(const MapFileName: TFileName);
begin
  inherited Create(MapFileName);
  FLineNumbers := nil;
  FProcNames := nil;
  FSegments := nil;
  FSourceNames := nil;
  FLineNumbersLen := 0;
  FProcNamesLen := 0;
  FSegmentsLen := 0;
  FSourceNamesLen := 0;
  Scan;
end;

destructor TELMapScanner.Destroy;
begin
  if (FLineNumbers <> nil) then FreeMem(FLineNumbers);
  if (FProcNames <> nil) then FreeMem(FProcNames);
  if (FSegments <> nil) then FreeMem(FSegments);
  if (FSourceNames <> nil) then FreeMem(FSourceNames);
  inherited;
end;

procedure TELMapScanner.ClassTableItem(const Address: TELMapAddress; Len: Integer;
  SectionName, GroupName: PJclMapString);
begin
end;

function Search_MapLineNumber(Item1, Item2: Pointer): Integer;
begin
  Result := Integer(PJclMapLineNumber(Item1)^.Addr) - PInteger(Item2)^;
end;

function TELMapScanner.LineNumberFromAddr(Addr: DWORD; var Offset: Integer): Integer;
var
  I: Integer;
  ModuleStartAddr: DWORD;
begin
  ModuleStartAddr := ModuleStartFromAddr(Addr);
  Result := 0;
  Offset := 0;
  I := SearchDynArray(FLineNumbers, SizeOf(FLineNumbers[0]), FLineNumbersLen,
    Search_MapLineNumber, @Addr, True);
  if (I <> -1) and (FLineNumbers[I].Addr >= ModuleStartAddr) then
  begin
    Result := FLineNumbers[I].LineNumber;
    Offset := Addr - FLineNumbers[I].Addr;
  end;
end;

procedure TELMapScanner.LineNumbersItem(LineNumber: Integer; const Address: TELMapAddress);
var
  C: Integer;
begin
  // Try to eliminate invalid line numbers caused by bug in the linker
  if (FLastValidAddr.Offset = 0) or ((Address.Offset > 0) and (Address.Offset <= FTopValidAddr) and
    (FLastValidAddr.Segment = Address.Segment) and (FLastValidAddr.Offset < Address.Offset)) then
  begin
    FLastValidAddr := Address;
    if (FLineNumbersCnt mod 256 = 0) then
    begin
      FLineNumbersLen := (FLineNumbersCnt + 256);
      ReallocMem(FLineNumbers, SizeOf(FLineNumbers[0]) * FLineNumbersLen);
    end;
    FLineNumbers[FLineNumbersCnt].Addr := Address.Offset;
    FLineNumbers[FLineNumbersCnt].LineNumber := LineNumber;
    Inc(FLineNumbersCnt);
    if (FNewUnitFileName <> nil) then
    begin
      C := FSourceNamesLen;
      Inc(FSourceNamesLen);
      ReallocMem(FSourceNames, SizeOf(FSourceNames[0]) * FSourceNamesLen);
      FSourceNames[C].Addr := Address.Offset;
      FSourceNames[C].ProcName := FNewUnitFileName;
      FNewUnitFileName := nil;
    end;
  end
  else
    Inc(FLineNumberErrors);
end;

procedure TELMapScanner.LineNumberUnitItem(UnitName, UnitFileName: PJclMapString);
begin
  FNewUnitFileName := UnitFileName;
end;

function TELMapScanner.ModuleNameFromAddr(Addr: DWORD): string;
var
  I: Integer;
begin
  Result := '';
  for I := FSegmentsLen - 1 downto 0 do
    if (FSegments[I].StartAddr <= Addr) and (FSegments[I].EndAddr >= Addr) then
    begin
      Result := MapStringToStr(FSegments[I].UnitName);
      Break;
    end;
end;

function TELMapScanner.ModuleStartFromAddr(Addr: DWORD): DWORD;
var
  I: Integer;
begin
  Result := DWORD(-1);
  for I := FSegmentsLen - 1 downto 0 do
    if (FSegments[I].StartAddr <= Addr) and (FSegments[I].EndAddr >= Addr) then
    begin
      Result := FSegments[I].StartAddr;
      Break;
    end;
end;

function Search_MapProcName(Item1, Item2: Pointer): Integer;
begin
  Result := Integer(PJclMapProcName(Item1)^.Addr) - PInteger(Item2)^;
end;

function TELMapScanner.ProcNameFromAddr(Addr: DWORD; var Offset: Integer): string;
var
  I: Integer;
  ModuleStartAddr: DWORD;
begin
  ModuleStartAddr := ModuleStartFromAddr(Addr);
  Result := '';
  Offset := 0;
  I := SearchDynArray(FProcNames, SizeOf(FProcNames[0]), FProcNamesLen,
    Search_MapProcName, @Addr, True);
  if (I <> -1) and (FProcNames[I].Addr >= ModuleStartAddr) then
  begin
    Result := MapStringToStr(FProcNames[I].ProcName);
    Offset := Addr - FProcNames[I].Addr;
  end;
end;

procedure TELMapScanner.PublicsByNameItem(const Address: TELMapAddress;  Name: PJclMapString);
begin
  { TODO : What to do? }
end;

procedure TELMapScanner.PublicsByValueItem(const Address: TELMapAddress; Name: PJclMapString);
begin
  if Address.Segment = 1 then
  begin
    if FProcNamesCnt mod 256 = 0 then
    begin
      FProcNamesLen := (FProcNamesCnt + 256);
      ReallocMem(FProcNames, SizeOf(FProcNames[0]) * FProcNamesLen);
    end;
    FProcNames[FProcNamesCnt].Addr := Address.Offset;
    FProcNames[FProcNamesCnt].ProcName := Name;
    Inc(FProcNamesCnt);
  end;
end;

procedure TELMapScanner.Scan;
begin
  FLastValidAddr.Segment := 0;
  FLastValidAddr.Offset := 0;
  FTopValidAddr := 0;
  FLineNumberErrors := 0;
  Parse;
  FLineNumbersLen := FLineNumbersCnt;
  ReallocMem(FLineNumbers, SizeOf(FLineNumbers[0]) * FLineNumbersLen);
  FProcNamesLen := FProcNamesCnt;
  ReallocMem(FProcNames, SizeOf(FProcNames[0]) * FProcNamesLen);
end;

procedure TELMapScanner.SegmentItem(const Address: TELMapAddress; Len: Integer;
  GroupName, UnitName: PJclMapString);
var
  C: Integer;
begin
  if Address.Segment = 1 then
  begin
    C := FSegmentsLen;
    Inc(FSegmentsLen);
    ReallocMem(FSegments, SizeOf(FSegments[0]) * FSegmentsLen);
    FSegments[C].StartAddr := Address.Offset;
    FSegments[C].EndAddr := Address.Offset + Len;
    FSegments[C].UnitName := UnitName;
    FTopValidAddr := Max(FTopValidAddr, Address.Offset + Len);
  end;
end;

function TELMapScanner.SourceNameFromAddr(Addr: DWORD): string;
var
  I: Integer;
  ModuleStartAddr: DWORD;
begin
  ModuleStartAddr := ModuleStartFromAddr(Addr);
  Result := '';
  I := SearchDynArray(FSourceNames, SizeOf(FSourceNames[0]), FSourceNamesLen,
    Search_MapProcName, @Addr, True);
  if (I <> -1) and (FSourceNames[I].Addr >= ModuleStartAddr) then
    Result := MapStringToStr(FSourceNames[I].ProcName);
end;

// JCL binary debug format string encoding/decoding routines
{ Strings are compressed to following 6bit format (A..D represents characters) and terminated with }
{ 6bit #0 char. First char = #1 indicates non compressed text, #2 indicates compressed text with   }
{ leading '@' character                                                                            }
{                                                                                                  }
{ 7   6   5   4   3   2   1   0  |                                                                 }
{---------------------------------                                                                 }
{ B1  B0  A5  A4  A3  A2  A1  A0 | Data byte 0                                                     }
{---------------------------------                                                                 }
{ C3  C2  C1  C0  B5  B4  B3  B2 | Data byte 1                                                     }
{---------------------------------                                                                 }
{ D5  D4  D3  D2  D1  D0  C5  C4 | Data byte 2                                                     }
{---------------------------------                                                                 }

function SimpleCryptString(const S: string): string;
var
  I: Integer;
  C: Byte;
  P: PByte;
begin
  SetLength(Result, Length(S));
  P := PByte(Result);
  for I := 1 to Length(S) do
  begin
    C := Ord(S[I]);
    if C <> $AA then
      C := C xor $AA;
    P^ := C;
    Inc(P);
  end;
end;

function DecodeNameString(const S: PChar): string;
var
  I, B: Integer;
  C: Byte;
  P: PByte;
  Buffer: array [0..255] of Char;
begin
  Result := '';
  B := 0;
  P := PByte(S);
  case P^ of
    1:
      begin
        Inc(P);
        Result := SimpleCryptString(PChar(P));
        Exit;
      end;
    2:
      begin
        Inc(P);
        Buffer[B] := '@';
        Inc(B);
      end;
  end;
  I := 0;
  C := 0;
  repeat
    case I and $03 of
      0:
        C := P^ and $3F;
      1:
        begin
          C := (P^ shr 6) and $03;
          Inc(P);
          Inc(C, (P^ and $0F) shl 2);
        end;
      2:
        begin
          C := (P^ shr 4) and $0F;
          Inc(P);
          Inc(C, (P^ and $03) shl 4);
        end;
      3:
        begin
          C := (P^ shr 2) and $3F;
          Inc(P);
        end;
    end;
    case C of
      $00:
        Break;
      $01..$0A:
        Inc(C, Ord('0') - $01);
      $0B..$24:
        Inc(C, Ord('A') - $0B);
      $25..$3E:
        Inc(C, Ord('a') - $25);
      $3F:
        C := Ord('_');
    end;
    Buffer[B] := Chr(C);
    Inc(B);
    Inc(I);
  until B >= SizeOf(Buffer) - 1;
  Buffer[B] := #0;
  Result := Buffer;
end;

//=== { TELBinDebugScanner } ================================================

constructor TELBinDebugScanner.Create(AStream: TCustomMemoryStream; CacheData: Boolean);
begin
  FLineNumbers := nil;
  FProcNames := nil;
  FLineNumbersLen := 0;
  FProcNamesLen := 0;
  FCacheData := CacheData;
  FStream := AStream;
  CheckFormat;
end;

procedure TELBinDebugScanner.CacheLineNumbers;
var
  P: Pointer;
  Value, LineNumber, C, Ln: Integer;
  CurrAddr: DWORD;
begin
  if FLineNumbers = nil then
  begin
    LineNumber := 0;
    CurrAddr := 0;
    C := 0;
    Ln := 0;
    P := MakePtr(PJclDbgHeader(FStream.Memory)^.LineNumbers);
    while ReadValue(P, Value) do
    begin
      Inc(CurrAddr, Value);
      ReadValue(P, Value);
      Inc(LineNumber, Value);
      if C = Ln then
      begin
        if Ln < 64 then
          Ln := 64
        else
          Ln := Ln + Ln div 4;
        FLineNumbersLen := Ln;
        ReallocMem(FLineNumbers, SizeOf(FLineNumbers[0]) * FLineNumbersLen);
      end;
      FLineNumbers[C].Addr := CurrAddr;
      FLineNumbers[C].LineNumber := LineNumber;
      Inc(C);
    end;
    FLineNumbersLen := C;
    ReallocMem(FLineNumbers, SizeOf(FLineNumbers[0]) * FLineNumbersLen);
  end;
end;

procedure TELBinDebugScanner.CacheProcNames;
var
  P: Pointer;
  Value, FirstWord, SecondWord, C, Ln: Integer;
  CurrAddr: DWORD;
begin
  if FProcNames = nil then
  begin
    FirstWord := 0;
    SecondWord := 0;
    CurrAddr := 0;
    C := 0;
    Ln := 0;    
    P := MakePtr(PJclDbgHeader(FStream.Memory)^.Symbols);
    while ReadValue(P, Value) do
    begin
      Inc(CurrAddr, Value);
      ReadValue(P, Value);
      Inc(FirstWord, Value);
      ReadValue(P, Value);
      Inc(SecondWord, Value);
      if C = Ln then
      begin
        if Ln < 64 then
          Ln := 64
        else
          Ln := Ln + Ln div 4;
        FProcNamesLen := Ln;
        ReallocMem(FProcNames, SizeOf(FProcNames[0]) * FProcNamesLen);
      end;
      FProcNames[C].Addr := CurrAddr;
      FProcNames[C].FirstWord := FirstWord;
      FProcNames[C].SecondWord := SecondWord;
      Inc(C);
    end;
    FProcNamesLen := C;
    ReallocMem(FProcNames, SizeOf(FProcNames[0]) * FProcNamesLen);
  end;
end;

procedure TELBinDebugScanner.CheckFormat;
var
  CheckSum: Integer;
  Data, EndData: PChar;
  Header: PJclDbgHeader;
begin
  Data := FStream.Memory;
  Header := PJclDbgHeader(Data);
  FValidFormat := (Data <> nil) and (FStream.Size > SizeOf(TELDbgHeader)) and
    (FStream.Size mod 4 = 0) and
    (Header^.Signature = JclDbgDataSignature) and (Header^.Version = JclDbgHeaderVersion);
  if FValidFormat and Header^.CheckSumValid then
  begin
    CheckSum := -Header^.CheckSum;
    EndData := Data + FStream.Size;
    while Data < EndData do
    begin
      Inc(CheckSum, PInteger(Data)^);
      Inc(PInteger(Data));
    end;
    CheckSum := (CheckSum shr 8) or (CheckSum shl 24);
    FValidFormat := (CheckSum = Header^.CheckSum);
  end;
end;

function TELBinDebugScanner.DataToStr(A: Integer): string;
var
  P: PChar;
begin
  if A = 0 then
    Result := ''
  else
  begin
    P := PChar(DWORD(A) + DWORD(FStream.Memory) + DWORD(PJclDbgHeader(FStream.Memory)^.Words) - 1);
    Result := DecodeNameString(P);
  end;
end;

function TELBinDebugScanner.GetModuleName: string;
begin
  Result := DataToStr(PJclDbgHeader(FStream.Memory)^.ModuleName);
end;

function TELBinDebugScanner.LineNumberFromAddr(Addr: DWORD; var Offset: Integer): Integer;
var
  P: Pointer;
  Value, LineNumber: Integer;
  CurrAddr, ModuleStartAddr, ItemAddr: DWORD;
begin
  ModuleStartAddr := ModuleStartFromAddr(Addr);
  LineNumber := 0;
  Offset := 0;
  if FCacheData then
  begin
    CacheLineNumbers;
    for Value := FLineNumbersLen - 1 downto 0 do
      if FLineNumbers[Value].Addr <= Addr then
      begin
        if FLineNumbers[Value].Addr >= ModuleStartAddr then
        begin
          LineNumber := FLineNumbers[Value].LineNumber;
          Offset := Addr - FLineNumbers[Value].Addr;
        end;
        Break;
      end;
  end
  else
  begin
    P := MakePtr(PJclDbgHeader(FStream.Memory)^.LineNumbers);
    CurrAddr := 0;
    ItemAddr := 0;
    while ReadValue(P, Value) do
    begin
      Inc(CurrAddr, Value);
      if Addr < CurrAddr then
      begin
        if ItemAddr < ModuleStartAddr then
        begin
          LineNumber := 0;
          Offset := 0;
        end;
        Break;
      end
      else
      begin
        ItemAddr := CurrAddr;
        ReadValue(P, Value);
        Inc(LineNumber, Value);
        Offset := Addr - CurrAddr;
      end;
    end;
  end;
  Result := LineNumber;
end;

function TELBinDebugScanner.MakePtr(A: Integer): Pointer;
begin
  Result := Pointer(DWORD(FStream.Memory) + DWORD(A));
end;

function TELBinDebugScanner.ModuleNameFromAddr(Addr: DWORD): string;
var
  Value, Name: Integer;
  StartAddr: DWORD;
  P: Pointer;
begin
  P := MakePtr(PJclDbgHeader(FStream.Memory)^.Units);
  Name := 0;
  StartAddr := 0;
  while ReadValue(P, Value) do
  begin
    Inc(StartAddr, Value);
    if Addr < StartAddr then
      Break
    else
    begin
      ReadValue(P, Value);
      Inc(Name, Value);
    end;
  end;
  Result := DataToStr(Name);
end;

function TELBinDebugScanner.ModuleStartFromAddr(Addr: DWORD): DWORD;
var
  Value: Integer;
  StartAddr, ModuleStartAddr: DWORD;
  P: Pointer;
begin
  P := MakePtr(PJclDbgHeader(FStream.Memory)^.Units);
  StartAddr := 0;
  ModuleStartAddr := DWORD(-1);
  while ReadValue(P, Value) do
  begin
    Inc(StartAddr, Value);
    if Addr < StartAddr then
      Break
    else
    begin
      ReadValue(P, Value);
      ModuleStartAddr := StartAddr;
    end;
  end;
  Result := ModuleStartAddr;
end;

function TELBinDebugScanner.ProcNameFromAddr(Addr: DWORD; var Offset: Integer): string;
var
  P: Pointer;
  Value, FirstWord, SecondWord: Integer;
  CurrAddr, ModuleStartAddr, ItemAddr: DWORD;
begin
  ModuleStartAddr := ModuleStartFromAddr(Addr);
  FirstWord := 0;
  SecondWord := 0;
  Offset := 0;
  if FCacheData then
  begin
    CacheProcNames;
    for Value := FProcNamesLen - 1 downto 0 do
      if FProcNames[Value].Addr <= Addr then
      begin
        if FProcNames[Value].Addr >= ModuleStartAddr then
        begin
          FirstWord := FProcNames[Value].FirstWord;
          SecondWord := FProcNames[Value].SecondWord;
          Offset := Addr - FProcNames[Value].Addr;
        end;
        Break;
      end;
  end
  else
  begin
    P := MakePtr(PJclDbgHeader(FStream.Memory)^.Symbols);
    CurrAddr := 0;
    ItemAddr := 0;
    while ReadValue(P, Value) do
    begin
      Inc(CurrAddr, Value);
      if Addr < CurrAddr then
      begin
        if ItemAddr < ModuleStartAddr then
        begin
          FirstWord := 0;
          SecondWord := 0;
          Offset := 0;
        end;
        Break;
      end
      else
      begin
        ItemAddr := CurrAddr;
        ReadValue(P, Value);
        Inc(FirstWord, Value);
        ReadValue(P, Value);
        Inc(SecondWord, Value);
        Offset := Addr - CurrAddr;
      end;
    end;
  end;
  if FirstWord <> 0 then
  begin
    Result := DataToStr(FirstWord);
    if SecondWord <> 0 then
      Result := Result + '.' + DataToStr(SecondWord)
  end
  else
    Result := '';
end;

function TELBinDebugScanner.ReadValue(var P: Pointer; var Value: Integer): Boolean;
var
  N: Integer;
  I: Integer;
  B: Byte;
begin
  N := 0;
  I := 0;
  repeat
    B := PByte(P)^;
    Inc(PByte(P));
    Inc(N, (B and $7F) shl I);
    Inc(I, 7);
  until B and $80 = 0;
  Value := N;
  Result := (Value <> MaxInt);
end;

function TELBinDebugScanner.SourceNameFromAddr(Addr: DWORD): string;
var
  Value, Name: Integer;
  StartAddr, ModuleStartAddr, ItemAddr: DWORD;
  P: Pointer;
begin
  ModuleStartAddr := ModuleStartFromAddr(Addr);
  P := MakePtr(PJclDbgHeader(FStream.Memory)^.SourceNames);
  Name := 0;
  StartAddr := 0;
  ItemAddr := 0;
  while ReadValue(P, Value) do
  begin
    Inc(StartAddr, Value);
    if Addr < StartAddr then
    begin
      if ItemAddr < ModuleStartAddr then
        Name := 0;
      Break;
    end
    else
    begin
      ItemAddr := StartAddr;
      ReadValue(P, Value);
      Inc(Name, Value);
    end;
  end;
  Result := DataToStr(Name);
end;

//=== { TELDebugInfoSource } ================================================

constructor TELDebugInfoSource.Create(AModule: HMODULE);
begin
  FModule := AModule;
  InitializeSource;
end;

function TELDebugInfoSource.GetFileName: TFileName;
var
  Buff: array[0..MAX_PATH - 1] of Char;
begin
  if (GetModuleFileName(FModule, Buff, SizeOf(Buff)) > 0) then Result := Buff
  else Result := '';
end;

function TELDebugInfoSource.VAFromAddr(const Addr: Pointer): DWORD;
begin
  Result := DWORD(Addr) - FModule - ModuleCodeOffset;
end;

//=== { TELDebugInfoMap } ===================================================

destructor TELDebugInfoMap.Destroy;
begin
  FScanner.Free;
  FScanner := nil;
  inherited Destroy;
end;

function TELDebugInfoMap.GetLocationInfo(const Addr: Pointer; var Info: TELLocationInfo): Boolean;
var
  VA: DWord;
  ProcAddr: DWord;
  Tmp, ProcOffset: Integer;
begin
  VA := VAFromAddr(Addr);
  with FScanner do
  begin
    Info.UnitName := ModuleNameFromAddr(VA);
    Result := (Info.UnitName <> '');
    if Result then
    begin
      Info.Address := Addr;
      Info.ProcedureName := ProcNameFromAddr(VA, ProcOffset);
      Info.LineNumber := LineNumberFromAddr(VA, Tmp);
      Info.SourceName := SourceNameFromAddr(VA);
      Info.DebugInfo := Self;
      ProcAddr := (Integer(VA) - ProcOffset);
      Info.ProcOffsetLine := (Info.LineNumber - LineNumberFromAddr(ProcAddr, Tmp));
    end;
  end;
end;

function TELDebugInfoMap.InitializeSource: Boolean;
var
  MapFileName: TFileName;
begin
  MapFileName := ChangeFileExt(FileName, MapFileExtension);
  Result := FileExists(MapFileName);
  if Result then
    FScanner := TELMapScanner.Create(MapFileName)
  else FScanner := nil;
end;

function TELDebugInfoMap.ValidData: Boolean;
begin
  Result := (FScanner <> nil);
end;

//=== { TELDebugInfoBinary } ================================================

destructor TELDebugInfoJedy.Destroy;
begin
  FScanner.Free;
  FScanner := nil;
  FStream.Free;
  FStream := nil;
  inherited Destroy;
end;

function TELDebugInfoJedy.GetLocationInfo(const Addr: Pointer; var Info: TELLocationInfo): Boolean;
var
  VA: DWord;
  ProcAddr: DWord;
  Tmp, ProcOffset: Integer;
begin
  VA := VAFromAddr(Addr);
  with FScanner do
  begin
    Info.UnitName := ModuleNameFromAddr(VA);
    Result := (Info.UnitName) <> '';
    if Result then
    begin
      Info.Address := Addr;
      Info.ProcedureName := ProcNameFromAddr(VA, ProcOffset);
      Info.LineNumber := LineNumberFromAddr(VA, Tmp);
      Info.SourceName := SourceNameFromAddr(VA);
      Info.DebugInfo := Self;
      ProcAddr := (Integer(VA) - ProcOffset);
      Info.ProcOffsetLine := (Info.LineNumber - LineNumberFromAddr(ProcAddr, Tmp));      
    end;
  end;
end;

function TELDebugInfoJedy.InitializeSource: Boolean;
var
  JdbgFileName: TFileName;

  function PeMapImgSections(NtHeaders: PImageNtHeaders): PImageSectionHeader;
  begin
    if NtHeaders = nil then
      Result := nil
    else
      Result := PImageSectionHeader(DWORD(@NtHeaders^.OptionalHeader) +
        NtHeaders^.FileHeader.SizeOfOptionalHeader);
  end;

  function PeMapImgFindSection(NtHeaders: PImageNtHeaders;
    const SectionName: string): PImageSectionHeader;
  var
    Header: PImageSectionHeader;
    I: Integer;
    P: PChar;
  begin
    Result := nil;
    if NtHeaders <> nil then
    begin
      P := PChar(SectionName);
      Header := PeMapImgSections(NtHeaders);
      with NtHeaders^ do
        for I := 1 to FileHeader.NumberOfSections do
          if StrLComp(PChar(@Header^.Name), P, IMAGE_SIZEOF_SHORT_NAME) = 0 then
          begin
            Result := Header;
            Break;
          end
          else
            Inc(Header);
    end;
  end;

  function PeMapImgNtHeaders(const BaseAddress: Pointer): PImageNtHeaders;
  type
    TImageDosHeader = packed record      { DOS .EXE header                  }
        e_magic: Word;                     { Magic number                     }
        e_cblp: Word;                      { Bytes on last page of file       }
        e_cp: Word;                        { Pages in file                    }
        e_crlc: Word;                      { Relocations                      }
        e_cparhdr: Word;                   { Size of header in paragraphs     }
        e_minalloc: Word;                  { Minimum extra paragraphs needed  }
        e_maxalloc: Word;                  { Maximum extra paragraphs needed  }
        e_ss: Word;                        { Initial (relative) SS value      }
        e_sp: Word;                        { Initial SP value                 }
        e_csum: Word;                      { Checksum                         }
        e_ip: Word;                        { Initial IP value                 }
        e_cs: Word;                        { Initial (relative) CS value      }
        e_lfarlc: Word;                    { File address of relocation table }
        e_ovno: Word;                      { Overlay number                   }
        e_res: array [0..3] of Word;       { Reserved words                   }
        e_oemid: Word;                     { OEM identifier (for e_oeminfo)   }
        e_oeminfo: Word;                   { OEM information; e_oemid specific}
        e_res2: array [0..9] of Word;      { Reserved words                   }
        _lfanew: LongInt;                  { File address of new exe header   }
    end;
    PImageDosHeader = ^TImageDosHeader;
  begin
    Result := nil;
    if IsBadReadPtr(BaseAddress, SizeOf(TImageDosHeader)) then
      Exit;
    if (PImageDosHeader(BaseAddress)^.e_magic <> IMAGE_DOS_SIGNATURE) or
      (PImageDosHeader(BaseAddress)^._lfanew = 0) then
      Exit;
    Result := PImageNtHeaders(DWORD(BaseAddress) + DWORD(PImageDosHeader(BaseAddress)^._lfanew));
    if IsBadReadPtr(Result, SizeOf(TImageNtHeaders)) or
      (Result^.Signature <> IMAGE_NT_SIGNATURE) then
        Result := nil
  end;

  function PEInitialize(Instance: HMODULE; const ASectionName: string): TMemoryStream;
  var
    Header: PImageSectionHeader;
    NtHeaders: PImageNtHeaders;
    DataSize: Integer;
  begin
    NtHeaders := PeMapImgNtHeaders(Pointer(Instance));
    Header := PeMapImgFindSection(NtHeaders, ASectionName);
    // Borland and Microsoft seems to have swapped the meaning of this items.
    DataSize := Min(Header^.SizeOfRawData, Header^.Misc.VirtualSize);
    Result := THModuleStream.Create((Instance + Header^.VirtualAddress), DataSize);
  end;


begin
  Result := (PeMapImgFindSection(PeMapImgNtHeaders(Pointer(Module)), JclDbgDataResName) <> nil);
  if Result then
    FStream := PEInitialize(Module, JclDbgDataResName)
  else
  begin
    JdbgFileName := ChangeFileExt(FileName, JclDbgFileExtension);
    Result := FileExists(JdbgFileName);
    if Result then
    begin
      FStream := TMemoryStream.Create;
      SafeLoadFromFileToStream(FStream, JdbgFileName);
    end;
  end;
  if Result then
    FScanner := TELBinDebugScanner.Create(FStream, True)
  else
    FScanner := nil;
end;

function TELDebugInfoJedy.ValidData: Boolean;
begin
  Result := (Fscanner <> nil) and (FScanner.ValidFormat);
end;

//=== { TELDebugInfoTD32 } ==================================================

destructor TELDebugInfoTD32.Destroy;
begin
  FImage.Free;
  FImage := nil;
  inherited Destroy;
end;

function TELDebugInfoTD32.GetLocationInfo(const Addr: Pointer; var Info: TELLocationInfo): Boolean;
var
  VA: DWord;
  ProcAddr: DWord;
  Tmp, ProcOffset: Integer;
begin
  VA := VAFromAddr(Addr);
  Info.UnitName := FImage.TD32Scanner.ModuleNameFromAddr(VA);
  Result := (Info.UnitName) <> '';
  if Result then
    with Info do
    begin
      Address := Addr;
      ProcedureName := FImage.TD32Scanner.ProcNameFromAddr(VA, ProcOffset);
      LineNumber := FImage.TD32Scanner.LineNumberFromAddr(VA, Tmp);
      SourceName := FImage.TD32Scanner.SourceNameFromAddr(VA);
      DebugInfo := Self;
      ProcAddr := (Integer(VA) - ProcOffset);
      ProcOffsetLine := (LineNumber - FImage.TD32Scanner.LineNumberFromAddr(ProcAddr, Tmp));
    end;
end;

function TELDebugInfoTD32.InitializeSource: Boolean;
begin
  if (Module <> 0) then
  begin
    FImage := TELPeBorTD32Image.Create(Module);
    try
      Result := FImage.IsTD32DebugPresent;
    except
      Result := False;
    end;
  end
  else
  begin
    FImage := nil;
    Result := False;
  end;
end;

function TELDebugInfoTD32.ValidData: Boolean;
begin
  Result := (FImage <> nil) and (FImage.TD32Scanner <> nil) and
    (FImage.TD32Scanner.ValidData);
end;

const
  TurboDebuggerSymbolExt = '.tds';

//------------------------------------------------------------------------------
// THModuleStream...
//------------------------------------------------------------------------------

constructor THModuleStream.Create(HModule: THandle; Size: Integer);
begin
  inherited Create;
  SetPointer(Pointer(HModule), Size);
end;

//=== { TELModuleInfo } =====================================================

constructor TELModuleInfo.Create(pModInfo: PModuleInfo);
begin
  Assert(Assigned(pModInfo));
  inherited Create;
  FNameIndex := pModInfo.NameIndex;
  FSegments := @pModInfo.Segments[0];
  FSegmentCount := pModInfo.SegmentCount;
end;

function TELModuleInfo.GetSegment(const Idx: Integer): TSegmentInfo;
begin
  Assert((0 <= Idx) and (Idx < FSegmentCount));
  Result := FSegments[Idx];
end;

//=== { TELLineInfo } =======================================================

constructor TELLineInfo.Create(ALineNo, AOffset: DWORD);
begin
  inherited Create;
  FLineNo := ALineNo;
  FOffset := AOffset;
end;

//=== { TELSourceModuleInfo } ===============================================

constructor TELSourceModuleInfo.Create(pSrcFile: PSourceFileEntry; Base: DWORD);
type
  PArrayOfWord = ^TArrayOfWord;
  TArrayOfWord = array [0..0] of Word;
var
  I, J: Integer;
  pLineEntry: PLineMappingEntry;
begin
  Assert(Assigned(pSrcFile));
  inherited Create;
  FNameIndex := pSrcFile.NameIndex;
  FLines := TList.Create;
  for I := 0 to pSrcFile.SegmentCount - 1 do
  begin
    pLineEntry := PLineMappingEntry(Base + pSrcFile.BaseSrcLines[I]);
    for J := 0 to pLineEntry.PairCount - 1 do
      FLines.Add(TELLineInfo.Create(
        PArrayOfWord(@pLineEntry.Offsets[pLineEntry.PairCount])^[J],
        pLineEntry.Offsets[J]));
  end;

  FSegments := @pSrcFile.BaseSrcLines[pSrcFile.SegmentCount];
  FSegmentCount := pSrcFile.SegmentCount;
end;

destructor TELSourceModuleInfo.Destroy;
begin
  FLines.Free;
  FLines := nil;
  inherited Destroy;
end;

function TELSourceModuleInfo.GetLine(const Idx: Integer): TELLineInfo;
begin
  Result := TELLineInfo(FLines.Items[Idx]);
end;

function TELSourceModuleInfo.GetLineCount: Integer;
begin
  Result := FLines.Count;
end;

function TELSourceModuleInfo.GetSegment(const Idx: Integer): TOffsetPair;
begin
  Assert((0 <= Idx) and (Idx < FSegmentCount));
  Result := FSegments[Idx];
end;

function TELSourceModuleInfo.FindLine(const AAddr: DWORD; var ALine: TELLineInfo): Boolean;
var
  I: Integer;
begin
  for I := 0 to LineCount - 1 do
    with Line[I] do
    begin
      if AAddr = Offset then
      begin
        Result := True;
        ALine := Line[I];
        Exit;
      end
      else
      if (I > 0) and (Line[I - 1].Offset < AAddr) and (AAddr < Offset) then
      begin
        Result := True;
        ALine := Line[I-1];
        Exit;
      end;
    end;
  Result := False;
  ALine := nil;
end;

//=== { TELSymbolInfo } =====================================================

constructor TELSymbolInfo.Create(pSymInfo: PSymbolInfo);
begin
  Assert(Assigned(pSymInfo));
  inherited Create;
  FSymbolType := pSymInfo.SymbolType;
end;

//=== { TELProcSymbolInfo } =================================================

constructor TELProcSymbolInfo.Create(pSymInfo: PSymbolInfo);
begin
  Assert(Assigned(pSymInfo));
  inherited Create(pSymInfo);
  with pSymInfo^ do
  begin
    FNameIndex := Proc.NameIndex;
    FOffset := Proc.Offset;
    FSize := Proc.Size;
  end;
end;

//=== { TELObjNameSymbolInfo } ==============================================

constructor TELObjNameSymbolInfo.Create(pSymInfo: PSymbolInfo);
begin
  Assert(Assigned(pSymInfo));
  inherited Create(pSymInfo);
  with pSymInfo^ do
  begin
    FNameIndex := ObjName.NameIndex;
    FSignature := ObjName.Signature;
  end;
end;

//=== { TELDataSymbolInfo } =================================================

constructor TELDataSymbolInfo.Create(pSymInfo: PSymbolInfo);
begin
  Assert(Assigned(pSymInfo));
  inherited Create(pSymInfo);
  with pSymInfo^ do
  begin
    FTypeIndex := Data.TypeIndex;
    FNameIndex := Data.NameIndex;
    FOffset := Data.Offset;
  end;
end;

//=== { TELWithSymbolInfo } =================================================

constructor TELWithSymbolInfo.Create(pSymInfo: PSymbolInfo);
begin
  Assert(Assigned(pSymInfo));
  inherited Create(pSymInfo);
  with pSymInfo^ do
  begin
    FNameIndex := With32.NameIndex;
    FOffset := With32.Offset;
    FSize := With32.Size;
  end;
end;

//=== { TELLabelSymbolInfo } ================================================

constructor TELLabelSymbolInfo.Create(pSymInfo: PSymbolInfo);
begin
  Assert(Assigned(pSymInfo));
  inherited Create(pSymInfo);
  with pSymInfo^ do
  begin
    FNameIndex := Label32.NameIndex;
    FOffset := Label32.Offset;
  end;
end;

//=== { TELConstantSymbolInfo } =============================================

constructor TELConstantSymbolInfo.Create(pSymInfo: PSymbolInfo);
begin
  Assert(Assigned(pSymInfo));
  inherited Create(pSymInfo);
  with pSymInfo^ do
  begin
    FNameIndex := Constant.NameIndex;
    FTypeIndex := Constant.TypeIndex;
    FValue := Constant.Value;
  end;
end;

//=== { TELUdtSymbolInfo } ==================================================

constructor TELUdtSymbolInfo.Create(pSymInfo: PSymbolInfo);
begin
  Assert(Assigned(pSymInfo));
  inherited Create(pSymInfo);
  with pSymInfo^ do
  begin
    FNameIndex := Udt.NameIndex;
    FTypeIndex := Udt.TypeIndex;
    FProperties := Udt.Properties;
  end;
end;

//=== { TELVftPathSymbolInfo } ==============================================

constructor TELVftPathSymbolInfo.Create(pSymInfo: PSymbolInfo);
begin
  Assert(Assigned(pSymInfo));
  inherited Create(pSymInfo);
  with pSymInfo^ do
  begin
    FRootIndex := VftPath.RootIndex;
    FPathIndex := VftPath.PathIndex;
    FOffset := VftPath.Offset;
  end;
end;

//=== { TELTD32InfoParser } =================================================

constructor TELTD32InfoParser.Create(const ATD32Data: TCustomMemoryStream);
begin
  Assert(Assigned(ATD32Data));
  inherited Create;
  FNames := TList.Create;
  FModules := TList.Create;
  FSourceModules := TList.Create;
  FSymbols := TList.Create;
  FNames.Add(nil);
  FData := ATD32Data;
  FBase := FData.Memory;
  FValidData := IsTD32DebugInfoValid(FBase, FData.Size);
  if FValidData then
    Analyse;
end;

destructor TELTD32InfoParser.Destroy;
begin
  FSymbols.Free;
  FSymbols := nil;
  FSourceModules.Free;
  FSourceModules := nil;
  FModules.Free;
  FModules := nil;
  FNames.Free;
  FNames := nil;
  inherited Destroy;
end;

procedure TELTD32InfoParser.Analyse;
var
  I: Integer;
  pDirHeader: PDirectoryHeader;
  pSubsection: Pointer;
begin
  pDirHeader := PDirectoryHeader(LfaToVa(PJclTD32FileSignature(LfaToVa(0)).Offset));
  while True do
  begin
    Assert(pDirHeader.DirEntrySize = SizeOf(TDirectoryEntry));
    for I := 0 to pDirHeader.DirEntryCount - 1 do
      with pDirHeader.DirEntries[I] do
      begin
        pSubsection := LfaToVa(Offset);
        case SubsectionType of
          SUBSECTION_TYPE_MODULE:
            AnalyseModules(pSubsection, Size);
          SUBSECTION_TYPE_ALIGN_SYMBOLS:
            AnalyseAlignSymbols(pSubsection, Size);
          SUBSECTION_TYPE_SOURCE_MODULE:
            AnalyseSourceModules(pSubsection, Size);
          SUBSECTION_TYPE_NAMES:
            AnalyseNames(pSubsection, Size);
        end;
      end;
    if pDirHeader.lfoNextDir <> 0 then
      pDirHeader := PDirectoryHeader(LfaToVa(pDirHeader.lfoNextDir))
    else
      Break;
  end;
end;

procedure TELTD32InfoParser.AnalyseNames(const pSubsection: Pointer; const Size: DWORD);
var
  I, Count, Len: Integer;
  pszName: PChar;
begin
  Count := PDWORD(pSubsection)^;
  pszName := PChar(DWORD(pSubsection) + SizeOf(DWORD));
  for I := 0 to Count - 1 do
  begin
    // Get the length of the name
    Len := Ord(pszName^);
    Inc(pszName);
    // Get the name
    FNames.Add(pszName);
    // skip the length of name and a NULL at the end
    Inc(pszName, Len + 1);
  end;
end;

type
  PSymbolTypeInfo = ^TSymbolTypeInfo;
  TSymbolTypeInfo = packed record
    TypeId: DWORD;
    NameIndex: DWORD;  // 0 if unnamed
    Size: Word;        //  size in bytes of the object
    MaxSize: Byte;
    ParentIndex: DWORD;
  end;

procedure TELTD32InfoParser.AnalyseAlignSymbols(pSymbols: PSymbolInfos; const Size: DWORD);
var
  Offset: DWORD;
  pInfo: PSymbolInfo;
  Symbol: TELSymbolInfo;
begin
  Offset := DWORD(@pSymbols.Symbols[0]) - DWORD(pSymbols);
  while Offset < Size do
  begin
    pInfo := PSymbolInfo(DWORD(pSymbols) + Offset);
    case pInfo.SymbolType of
      SYMBOL_TYPE_LPROC32:
        Symbol := TELLocalProcSymbolInfo.Create(pInfo);
      SYMBOL_TYPE_GPROC32:
        Symbol := TELGlobalProcSymbolInfo.Create(pInfo);
      SYMBOL_TYPE_OBJNAME:
        Symbol := TELObjNameSymbolInfo.Create(pInfo);
      SYMBOL_TYPE_LDATA32:
        Symbol := TELLDataSymbolInfo.Create(pInfo);
      SYMBOL_TYPE_GDATA32:
        Symbol := TELGDataSymbolInfo.Create(pInfo);
      SYMBOL_TYPE_PUB32:
        Symbol := TELPublicSymbolInfo.Create(pInfo);
      SYMBOL_TYPE_WITH32:
        Symbol := TELWithSymbolInfo.Create(pInfo);
      SYMBOL_TYPE_LABEL32:
        Symbol := TELLabelSymbolInfo.Create(pInfo);
      SYMBOL_TYPE_CONST:
        Symbol := TELConstantSymbolInfo.Create(pInfo);
      SYMBOL_TYPE_UDT:
        Symbol := TELUdtSymbolInfo.Create(pInfo);
      SYMBOL_TYPE_VFTPATH32:
        Symbol := TELVftPathSymbolInfo.Create(pInfo);
    else
      Symbol := nil;
    end;
    if Assigned(Symbol) then
      FSymbols.Add(Symbol);
    Inc(Offset, pInfo.Size + SizeOf(pInfo.Size));
  end;
end;

procedure TELTD32InfoParser.AnalyseModules(pModInfo: PModuleInfo; const Size: DWORD);
begin
  FModules.Add(TELModuleInfo.Create(pModInfo));
end;

procedure TELTD32InfoParser.AnalyseSourceModules(pSrcModInfo: PSourceModuleInfo; const Size: DWORD);
var
  I: Integer;
  pSrcFile: PSourceFileEntry;
begin
  for I := 0 to pSrcModInfo.FileCount - 1 do
  begin
    pSrcFile := PSourceFileEntry(DWORD(pSrcModInfo) + pSrcModInfo.BaseSrcFiles[I]);
    if pSrcFile.NameIndex > 0 then
      FSourceModules.Add(TELSourceModuleInfo.Create(pSrcFile, DWORD(pSrcModInfo)));
  end;
end;

function TELTD32InfoParser.GetModule(const Idx: Integer): TELModuleInfo;
begin
  Result := TELModuleInfo(FModules.Items[Idx]);
end;

function TELTD32InfoParser.GetModuleCount: Integer;
begin
  Result := FModules.Count;
end;

function TELTD32InfoParser.GetName(const Idx: Integer): string;
begin
  Result := PChar(FNames.Items[Idx]);
end;

function TELTD32InfoParser.GetNameCount: Integer;
begin
  Result := FNames.Count;
end;

function TELTD32InfoParser.GetSourceModule(const Idx: Integer): TELSourceModuleInfo;
begin
  Result := TELSourceModuleInfo(FSourceModules.Items[Idx]);
end;

function TELTD32InfoParser.GetSourceModuleCount: Integer;
begin
  Result := FSourceModules.Count;
end;

function TELTD32InfoParser.GetSymbol(const Idx: Integer): TELSymbolInfo;
begin
  Result := TELSymbolInfo(FSymbols.Items[Idx]);
end;

function TELTD32InfoParser.GetSymbolCount: Integer;
begin
  Result := FSymbols.Count;
end;

function TELTD32InfoParser.FindModule(const AAddr: DWORD;
  var AMod: TELModuleInfo): Boolean;
var
  I, J: Integer;
begin
  if ValidData then
    for I := 0 to ModuleCount - 1 do
    with Modules[I] do
      for J := 0 to SegmentCount - 1 do
      begin
        if AAddr >= FSegments[J].Offset then
        begin
          if AAddr - FSegments[J].Offset <= Segment[J].Size then
          begin
            Result := True;
            AMod := Modules[I];
            Exit;
          end;
        end;
      end;
  Result := False;
  AMod := nil;
end;

function TELTD32InfoParser.FindSourceModule(const AAddr: DWORD;
  var ASrcMod: TELSourceModuleInfo): Boolean;
var
  I, J: Integer;
begin
  if ValidData then
    for I := 0 to SourceModuleCount - 1 do
    with SourceModules[I] do
      for J := 0 to SegmentCount - 1 do
      with Segment[J] do
        if (StartOffset <= AAddr) and (AAddr < EndOffset) then
        begin
          Result := True;
          ASrcMod := SourceModules[I];
          Exit;
        end;
  Result := False;
  ASrcMod := nil;
end;

function TELTD32InfoParser.FindProc(const AAddr: DWORD; var AProc: TELProcSymbolInfo): Boolean;
var
  I: Integer;
begin
  if ValidData then
    for I := 0 to SymbolCount - 1 do
      if Symbols[I].InheritsFrom(TELProcSymbolInfo) then
      with Symbols[I] as TELProcSymbolInfo do
        if (Offset <= AAddr) and (AAddr < Offset + Size) then
        begin
          AProc := TELProcSymbolInfo(Symbols[I]);
          Result := True;
          Exit;
        end;
  Result := False;
  AProc := nil;
end;

class function TELTD32InfoParser.IsTD32DebugInfoValid(
  const DebugData: Pointer; const DebugDataSize: DWord): Boolean;
var
  Sign: TELTD32FileSignature;
  EndOfDebugData: DWord;
begin
  Assert(not IsBadReadPtr(DebugData, DebugDataSize));
  Result := False;
  EndOfDebugData := DWord(DebugData) + DebugDataSize;
  if DebugDataSize > SizeOf(Sign) then
  begin
    Sign := PJclTD32FileSignature(EndOfDebugData - SizeOf(Sign))^;
    if IsTD32Sign(Sign) and (Sign.Offset <= DebugDataSize) then
    begin
      Sign := PJclTD32FileSignature(EndOfDebugData - Sign.Offset)^;
      Result := IsTD32Sign(Sign);
    end;
  end;
end;

class function TELTD32InfoParser.IsTD32Sign(const Sign: TELTD32FileSignature): Boolean;
begin
  Result := (Sign.Signature = Borland32BitSymbolFileSignatureForDelphi) or
    (Sign.Signature = Borland32BitSymbolFileSignatureForBCB);
end;

function TELTD32InfoParser.LfaToVa(Lfa: DWORD): Pointer;
begin
  Result := Pointer(DWORD(FBase) + Lfa)
end;

//=== { TELTD32InfoScanner } ================================================

function TELTD32InfoScanner.LineNumberFromAddr(AAddr: DWORD; var Offset: Integer): Integer;
var
  ASrcMod: TELSourceModuleInfo;
  ALine: TELLineInfo;
begin
  if FindSourceModule(AAddr, ASrcMod) and ASrcMod.FindLine(AAddr, ALine) then
  begin
    Result := ALine.LineNo;
    Offset := AAddr - ALine.Offset;
  end
  else
  begin
    Result := 0;
    Offset := 0;
  end;
end;

function TELTD32InfoScanner.ModuleNameFromAddr(AAddr: DWORD): string;
var
  AMod: TELModuleInfo;
begin
  if FindModule(AAddr, AMod) then
    Result := Names[AMod.NameIndex]
  else
    Result := '';
end;

function TELTD32InfoScanner.ProcNameFromAddr(AAddr: DWORD; var Offset: Integer): string;
var
  AProc: TELProcSymbolInfo;
  UnitName: string;

  function FormatProcName(const UnitName, ProcName: string): string;
  var
    Idx: Integer;

  function StringReplace(const S, OldPattern, NewPattern: string): string;
  var
    SearchStr, Patt, NewStr: string;
    Offset: Integer;
  begin
    SearchStr := S;
    Patt := OldPattern;
    NewStr := S;
    Result := '';
    while SearchStr <> '' do
    begin
      Offset := AnsiPos(Patt, SearchStr);
      if Offset = 0 then
      begin
        Result := Result + NewStr;
        Break;
      end;
      Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
      NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
      SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
    end;
  end;

  begin
    Result := ProcName;
    if (Result <> '') and (Result[1] = '@') then
    begin
      Delete(Result, 1, 1); // Remove first '@' char.

      // Search for parameters...
      Idx := Pos('$', Result);
      if (Idx > 0) then // Remove parameters.
      begin
        if (Idx > 1) and (Result[Idx - 1] = '@') then Dec(Idx);
        Delete(Result, Idx, Length(Result));
      end;

      // Replace the remaining '@' chars with '.' char.
      Result := StringReplace(Result, '@', '.');

      // Replace the '..' chars with '.@' char (System routines).
      Result := StringReplace(Result, '..', '.@');

      // WARNING!!!
      // ----------
      // Top FIX a Borland C++Builder Linker BUG (did not add the UnitName)...
      if (Pos(LowerCase(UnitName), LowerCase(Result)) = 1) then Delete(Result, 1, Length(UnitName) + 1);
    end;
  end;

begin
  if FindProc(AAddr, AProc) then
  begin
    UnitName := ModuleNameFromAddr(AAddr);
    Result := FormatProcName(UnitName, Names[AProc.NameIndex]);
    Offset := AAddr - AProc.Offset;
  end
  else
  begin
    Result := '';
    Offset := 0;
  end;
end;

function TELTD32InfoScanner.SourceNameFromAddr(AAddr: DWORD): string;
var
  ASrcMod: TELSourceModuleInfo;
begin
  if FindSourceModule(AAddr, ASrcMod) then
    Result := Names[ASrcMod.NameIndex];
end;

//=== { TELPeBorTD32Image } =================================================

constructor TELPeBorTD32Image.Create(AModule: THandle);
begin
  FModule := AModule;
  FTD32DebugData := THModuleStream.Create(FModule, MaxInt);
  CheckDebugData;
end;

destructor TELPeBorTD32Image.Destroy;
begin
  if (FTD32DebugData <> nil) then FTD32DebugData.Free;
end;

procedure TELPeBorTD32Image.CheckDebugData;
begin
  FIsTD32DebugPresent := IsDebugInfoInImage(FTD32DebugData);
  if not FIsTD32DebugPresent then
    FIsTD32DebugPresent := IsDebugInfoInTds(FTD32DebugData);
  if FIsTD32DebugPresent then
  begin
    FTD32Scanner := TELTD32InfoScanner.Create(FTD32DebugData);
    if not FTD32Scanner.ValidData then ClearDebugData;
  end;
end;

procedure TELPeBorTD32Image.Clear;
begin
  ClearDebugData;
end;

procedure TELPeBorTD32Image.ClearDebugData;
begin
  FIsTD32DebugPresent := False;
  FTD32Scanner.Free;
  FTD32Scanner := nil;
  FTD32DebugData.Free;
  FTD32DebugData := nil;
end;

type
// Windows resource types...
//----------------------------------------------------------------------------
TArrayImageSectionHeader = array[0..MaxInt shr 6] of TImageSectionHeader;
PArrayImageSectionHeader = ^TArrayImageSectionHeader;
//----------------------------------------------------------------------------

function TELPeBorTD32Image.IsDebugInfoInImage(var DataStream: TCustomMemoryStream): Boolean;
const
  IMG_DIR_RES = 2; { Resource Directory }
  IMG_DIR_DEB = 6; { Debug Directory }
var
  BugDataStart: Pointer;
  DebugDataSize: Integer;
  Headers: PImageNtHeaders;
  SecHead: PArrayImageSectionHeader;
  SecDebug: PImageDebugDirectory;
  SecCount, ModuleHnd: DWord;
  n: Integer;

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

begin
  ModuleHnd := DWord(DataStream.Memory);
  Headers := GetImageNtHeaders(ModuleHnd);
  SecCount := Headers^.FileHeader.NumberOfSections;
  SecHead := PArrayImageSectionHeader(DWord(Headers) + SizeOf(Headers^));
  if (Headers^.OptionalHeader.DataDirectory[IMG_DIR_DEB].Size > 0) then
  begin
    for n := 0 to SecCount - 1 do
    begin
      if (SecHead[n].VirtualAddress =
        Headers^.OptionalHeader.DataDirectory[IMG_DIR_DEB].VirtualAddress) then
      begin
        SecDebug := PImageDebugDirectory(ModuleHnd + SecHead[n].VirtualAddress);
        BugDataStart := Pointer(ModuleHnd + DWord(SecDebug^.AddressOfRawData));
        DebugDataSize := SecDebug^.SizeOfData;
        Result := TELTD32InfoParser.IsTD32DebugInfoValid(BugDataStart, DebugDataSize);
        if Result then
        begin
          DataStream := THModuleStream.Create(DWord(BugDataStart), DebugDataSize);
          Exit;
        end;
      end;
    end;
  end;

  Result := False;
  if (DataStream <> nil) then DataStream.Free;
  DataStream := nil;
end;

function TELPeBorTD32Image.IsDebugInfoInTds(var DataStream: TCustomMemoryStream): Boolean;
var
  TdsFileName: TFileName;
  TempStream: TMemoryStream;

  function ModuleFileName(HModule: THandle): string;
  var
    Buff: array[0..MAX_PATH - 1] of Char;
  begin
    if (GetModuleFileName(HModule, Buff, SizeOf(Buff)) > 0) then Result := Buff
    else Result := '';
  end;

begin
  Result := False;
  DataStream := nil;
  TdsFileName := ChangeFileExt(ModuleFileName(FModule), TurboDebuggerSymbolExt);
  if FileExists(TdsFileName) then
  begin
    TempStream := TMemoryStream.Create;
    try
      SafeLoadFromFileToStream(TempStream, TdsFileName);
      Result := TELTD32InfoParser.IsTD32DebugInfoValid(TempStream.Memory, TempStream.Size);
      if Result then
        DataStream := TempStream
      else
        TempStream.Free;
    except
      TempStream.Free;
      raise;
    end;
  end;
end;

function AssignValidDebugInfo(Module: THandle; var DebugInfo: TELDebugInfoSource): Boolean;
begin
  Result := False;
  if (DebugInfo <> nil) then Exit;

  DebugInfo := TELDebugInfoMap.Create(Module);
  Result := DebugInfo.ValidData;
  if (Result) then Exit
  else DebugInfo.Free;

  DebugInfo := TELDebugInfoTD32.Create(Module);
  Result := DebugInfo.ValidData;
  if (Result) then Exit
  else DebugInfo.Free;

  DebugInfo := TELDebugInfoJedy.Create(Module);
  Result := DebugInfo.ValidData;
  if (Result) then Exit
  else DebugInfo.Free;

  DebugInfo := nil;
end;

destructor TELBinDebugScanner.Destroy;
begin
  if (FLineNumbers <> nil) then FreeMem(FLineNumbers);
  if (FProcNames <> nil) then FreeMem(FProcNames);
  inherited;
end;

end.
