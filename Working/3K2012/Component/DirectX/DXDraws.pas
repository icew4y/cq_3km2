unit DXDraws;

interface

//{$INCLUDE DelphiXcfg.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  DXClass, DIB, DXTexImg, DirectX;

type
  {  EDirectDrawError  }

  EDirectDrawError = class(EDirectXError);
  EDirectDrawPaletteError = class(EDirectDrawError);
  EDirectDrawClipperError = class(EDirectDrawError);
  EDirectDrawSurfaceError = class(EDirectDrawError);

  {  TDirectDraw  }

  TDirectDrawClipper = class;
  TDirectDrawPalette = class;
  TDirectDrawSurface = class;

  TDirectDraw = class(TDirectX)
  private
    FIDDraw: IDirectDraw7;
    FDriverCaps: TDDCaps;
    FHELCaps: TDDCaps;
    FClippers: TList;
    FPalettes: TList;
    FSurfaces: TList;
    function GetClipper(Index: Integer): TDirectDrawClipper;
    function GetClipperCount: Integer;
    function GetDisplayMode: TDDSurfaceDesc2;

    function GetIDDraw7: IDirectDraw7;
    function GetIDraw7: IDirectDraw7;

    function GetPalette(Index: Integer): TDirectDrawPalette;
    function GetPaletteCount: Integer;
    function GetSurface(Index: Integer): TDirectDrawSurface;
    function GetSurfaceCount: Integer;
  public
    constructor Create(GUID: PGUID);
    constructor CreateEx(GUID: PGUID; DirectX7Mode: Boolean);
    destructor Destroy; override;
    class function Drivers: TDirectXDrivers;
    property ClipperCount: Integer read GetClipperCount;
    property Clippers[Index: Integer]: TDirectDrawClipper read GetClipper;
    property DisplayMode: TDDSurfaceDesc2 read GetDisplayMode;
    property DriverCaps: TDDCaps read FDriverCaps;
    property HELCaps: TDDCaps read FHELCaps;
    property IDDraw: IDirectDraw7 read GetIDDraw7;

    property IDraw: IDirectDraw7 read GetIDraw7;
    property PaletteCount: Integer read GetPaletteCount;
    property Palettes[Index: Integer]: TDirectDrawPalette read GetPalette;
    property SurfaceCount: Integer read GetSurfaceCount;
    property Surfaces[Index: Integer]: TDirectDrawSurface read GetSurface;
  end;

  {  TDirectDrawClipper  }

  TDirectDrawClipper = class(TDirectX)
  private
    FDDraw: TDirectDraw;
    FIDDClipper: IDirectDrawClipper;
    function GetIDDClipper: IDirectDrawClipper;
    function GetIClipper: IDirectDrawClipper;
    procedure SetHandle(Value: THandle);
    procedure SetIDDClipper(Value: IDirectDrawClipper);
    property Handle: THandle write SetHandle;
  public
    constructor Create(ADirectDraw: TDirectDraw);
    destructor Destroy; override;
    procedure SetClipRects(const Rects: array of TRect);
    property DDraw: TDirectDraw read FDDraw;
    property IClipper: IDirectDrawClipper read GetIClipper;
    property IDDClipper: IDirectDrawClipper read GetIDDClipper write SetIDDClipper;
  end;

  {  TDirectDrawPalette  }

  TDirectDrawPalette = class(TDirectX)
  private
    FDDraw: TDirectDraw;
    FIDDPalette: IDirectDrawPalette;
    function GetEntry(Index: Integer): TPaletteEntry;
    function GetIDDPalette: IDirectDrawPalette;
    function GetIPalette: IDirectDrawPalette;
    procedure SetEntry(Index: Integer; Value: TPaletteEntry);
    procedure SetIDDPalette(Value: IDirectDrawPalette);
  public
    constructor Create(ADirectDraw: TDirectDraw);
    destructor Destroy; override;
    function CreatePalette(Caps: DWORD; const Entries): Boolean;
    function GetEntries(StartIndex, NumEntries: Integer; var Entries): Boolean;
    procedure LoadFromDIB(DIB: TDIB);
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream);
    function SetEntries(StartIndex, NumEntries: Integer; const Entries): Boolean;
    property DDraw: TDirectDraw read FDDraw;
    property Entries[Index: Integer]: TPaletteEntry read GetEntry write SetEntry;
    property IDDPalette: IDirectDrawPalette read GetIDDPalette write SetIDDPalette;
    property IPalette: IDirectDrawPalette read GetIPalette;
  end;

  {  TDirectDrawSurfaceCanvas  }
  TDirectDrawSurfaceCanvas = class(TCanvas)
  private
    FDC: HDC;
    FSurface: TDirectDrawSurface;
  protected
    procedure CreateHandle; override;
  public
    constructor Create(ASurface: TDirectDrawSurface);
    destructor Destroy; override;
    procedure Release;
  end;

//新加

  pTFastDIBFont = ^TFastDIBFont;
  TFastDIBFont = packed record
    Data: PByte;
    Text: string;
    Time: LongWord;
    Name: TFontName;
    Size: Integer;
    Style: TFontStyles;
    Width: Integer;
    Height: Integer;
  end;

  pTFontText = ^TFontText;
  TFontText = packed record
    Font: TDirectDrawSurface;
    Text: string;
    Time: LongWord;
    Name: TFontName;
    Size: Integer;
    Style: TFontStyles;
    FColor: TColor;
    Bcolor: TColor;
  end;

  TImageFont = class
  private
    FontList: TList;
    FontTextList: TList;
    FreeOutTimeTick: LongWord;
    FreeFontTextOutTimeTick: LongWord;
    procedure FreeOutTime;
    procedure FreeFontTextOutTime;
    function GetCount: Integer;
    function GetTextData(Text: string): pTFastDIBFont;
    procedure DrawFont(pSrc, pDst: PByte; nPitch, nWidth, nHeight: Integer; Color: TColor);
    function ClipRect(var DestRect: TRect; const DestRect2: TRect): Boolean;
  public
    constructor Create();
    destructor Destroy; override;
    procedure Clear;
    function TextHeight(const Text: string): Integer;
    function TextWidth(const Text: string): Integer;

    procedure DrawRect(DIB: TDirectDrawSurface; Rect: TRect; X, Y: Integer; const Text: string;
      FColor: TColor = clWhite; BColor: TColor = clBlack); overload;

    procedure DrawRect(DIB: TDirectDrawSurface; X, Y: Integer; Rect: TRect; const Text: string;
      FColor: TColor = clWhite; BColor: TColor = clBlack); overload;

    procedure BoldDrawRect(DIB: TDirectDrawSurface;
      Rect: TRect; X, Y: Integer; const Text: string;
      FColor: TColor = clWhite; BColor: TColor = clBlack); overload;

    procedure BoldDrawRectAlpha(DIB: TDirectDrawSurface;
      Rect: TRect; X, Y: Integer; const Text: string;
      FColor: TColor = clWhite; BColor: TColor = clBlack; Alpha: Integer = 255); overload;

    procedure BoldDrawRect(DIB: TDirectDrawSurface; X, Y: Integer; Rect: TRect;
      const Text: string; FColor: TColor; BColor: TColor); overload;



    procedure Draw(DIB: TDirectDrawSurface; X, Y: Integer; const Text: string; FColor: TColor = clWhite; BColor: TColor = clBlack);
    procedure BoldDraw(DIB: TDirectDrawSurface; X, Y: Integer; const Text: string; FColor: TColor = clWhite; BColor: TColor = clBlack);

    function GetTextDIB(Text: string; FColor, BColor: TColor): TDirectDrawSurface;
    property Count: Integer read GetCount;
  end;

  {  TDirectDrawSurface  }

  TDirectDrawSurface = class(TDirectX)
  private
    FCanvas: TDirectDrawSurfaceCanvas;
    FHasClipper: Boolean;
    FDDraw: TDirectDraw;
    FIDDSurface: IDirectDrawSurface7;
    FSystemMemory: Boolean;
    FStretchDrawClipper: IDirectDrawClipper;
    FSurfaceDesc: TDDSurfaceDesc2;
    FGammaControl: IDirectDrawGammaControl;
    FLockSurfaceDesc: TDDSurfaceDesc2;
    FLockCount: Integer;
    function GetBitCount: Integer;
    function GetCanvas: TDirectDrawSurfaceCanvas;
    function GetClientRect: TRect;
    function GetHeight: Integer;
    function GetIDDSurface7: IDirectDrawSurface7;
    function GetISurface7: IDirectDrawSurface7;
    function GetPixel(X, Y: Integer): Longint;
{------------------------------------------------------------------------}
    function GetPixel16(X, Y: Integer): Word;
    procedure SetPixel16(X, Y: Integer; Value: Word);
{------------------------------------------------------------------------}
    function GetWidth: Integer;
    procedure SetClipper(Value: TDirectDrawClipper);
    procedure SetColorKey(Flags: DWORD; const Value: TDDColorKey);
    procedure SetIDDSurface7(Value: IDirectDrawSurface7);
    procedure SetPalette(Value: TDirectDrawPalette);
    procedure SetPixel(X, Y: Integer; Value: Longint);
    procedure SetTransparentColor(Col: Longint);
  public
    constructor Create(ADirectDraw: TDirectDraw);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;
    function Blt(const DestRect, SrcRect: TRect; Flags: DWORD;
      const DF: TDDBltFX; Source: TDirectDrawSurface): Boolean;
    function BltFast(X, Y: Integer; const SrcRect: TRect;
      Flags: DWORD; Source: TDirectDrawSurface): Boolean;
    function ColorMatch(Col: TColor): Integer;

    function CreateSurface(const SurfaceDesc: TDDSurfaceDesc2): Boolean;
    procedure TextOut(X, Y, Color: Integer; str:string);
    procedure BoldTextOut(x, y, fcolor, bcolor: Integer; str:string); overload;
    procedure BoldTextOut(x, y, fcolor, bcolor: Integer; str:string; Alpha: Integer); overload;
    procedure Draw(X, Y: Integer; SrcRect: TRect; Source: TDirectDrawSurface; Transparent: Boolean = True); overload;
    procedure Draw(X, Y: Integer; Source: TDirectDrawSurface; Transparent: Boolean = True); overload;
    procedure StretchDraw(const DestRect, SrcRect: TRect; Source: TDirectDrawSurface;
      Transparent: Boolean = True); overload;
    procedure StretchDraw(const DestRect: TRect; Source: TDirectDrawSurface;
      Transparent: Boolean = True); overload;

    procedure DrawAdd(const DestRect, SrcRect: TRect; Source: TDirectDrawSurface;
      Transparent: Boolean; Alpha: Integer = 255);
    procedure DrawAlpha(const DestRect, SrcRect: TRect; Source: TDirectDrawSurface;
      Transparent: Boolean; Alpha: Integer);
    procedure DrawSub(const DestRect, SrcRect: TRect; Source: TDirectDrawSurface;
      Transparent: Boolean; Alpha: Integer = 255);
    procedure DrawRotate(X, Y, Width, Height: Integer; const SrcRect: TRect;
      Source: TDirectDrawSurface; CenterX, CenterY: Double; Transparent: Boolean; Angle: Integer);
    procedure DrawRotateAdd(X, Y, Width, Height: Integer; const SrcRect: TRect;
      Source: TDirectDrawSurface; CenterX, CenterY: Double; Transparent: Boolean; Angle: Integer;
      Alpha: Integer = 255);
    procedure DrawRotateAlpha(X, Y, Width, Height: Integer; const SrcRect: TRect;
      Source: TDirectDrawSurface; CenterX, CenterY: Double; Transparent: Boolean; Angle: Integer;
      Alpha: Integer);
    procedure DrawRotateSub(X, Y, Width, Height: Integer; const SrcRect: TRect;
      Source: TDirectDrawSurface; CenterX, CenterY: Double; Transparent: Boolean; Angle: Integer;
      Alpha: Integer = 255);
    procedure DrawWaveX(X, Y, Width, Height: Integer; const SrcRect: TRect;
      Source: TDirectDrawSurface; Transparent: Boolean; amp, Len, ph: Integer);
    procedure DrawWaveXAdd(X, Y, Width, Height: Integer; const SrcRect: TRect;
      Source: TDirectDrawSurface; Transparent: Boolean; amp, Len, ph: Integer;
      Alpha: Integer = 255);
    procedure DrawWaveXAlpha(X, Y, Width, Height: Integer; const SrcRect: TRect;
      Source: TDirectDrawSurface; Transparent: Boolean; amp, Len, ph: Integer;
      Alpha: Integer);
    procedure DrawWaveXSub(X, Y, Width, Height: Integer; const SrcRect: TRect;
      Source: TDirectDrawSurface; Transparent: Boolean; amp, Len, ph: Integer;
      Alpha: Integer = 255);
    //-----------------------------------------------------------------------------
    procedure FastDrawAlpha(const Dest, Src: TRect; Source: TDirectDrawSurface; TRANSPARENT: Boolean = True); overload;
    procedure FastDrawAlpha(const Dest, Src: TRect; Source: TDirectDrawSurface; TRANSPARENT: Boolean; Alpha: Integer); overload;
    procedure FastFill(DevColor: TColor);
    procedure FastFillRect(const Rect: TRect; DevColor: TColor);
    procedure FastFillRectAlpha(const Rect: TRect; Color: TColor; Alpha: Integer);
    procedure FastFrameRect(const Rect: TRect; DevColor: TColor);
    procedure FastLine(X1, Y1, X2, Y2: Integer; DevColor: TColor);
    //-------------------------------------------------------------------------------



    procedure Fill(DevColor: Longint);
    procedure FillRect(const Rect: TRect; DevColor: Longint);
    procedure FillRectAdd(const DestRect: TRect; Color: TColor);
    procedure FillRectAlpha(const DestRect: TRect; Color: TColor; Alpha: Integer);
    procedure FillRectSub(const DestRect: TRect; Color: TColor);
    procedure LoadFromDIB(DIB: TDIB);
    procedure LoadFromDIBRect(DIB: TDIB; AWidth, AHeight: Integer; const SrcRect: TRect);
    procedure LoadFromGraphic(Graphic: TGraphic);
    procedure LoadFromGraphicRect(Graphic: TGraphic; AWidth, AHeight: Integer; const SrcRect: TRect);
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream);

    function Lock(const Rect: TRect; var SurfaceDesc: TDDSurfaceDesc2): Boolean;

    procedure UnLock;
    function Restore: Boolean;
    procedure SetSize(AWidth, AHeight: Integer);
    property BitCount: Integer read GetBitCount;
    property Canvas: TDirectDrawSurfaceCanvas read GetCanvas;
    property ClientRect: TRect read GetClientRect;
    property Clipper: TDirectDrawClipper write SetClipper;
    property ColorKey[Flags: DWORD]: TDDColorKey write SetColorKey;
    property DDraw: TDirectDraw read FDDraw;
    property GammaControl: IDirectDrawGammaControl read FGammaControl;
    property Height: Integer read GetHeight;
    property IDDSurface: IDirectDrawSurface7 read GetIDDSurface7 write SetIDDSurface7;

    property ISurface: IDirectDrawSurface7 read GetISurface7;
    property Palette: TDirectDrawPalette write SetPalette;
    property Pixels[X, Y: Integer]: Longint read GetPixel write SetPixel;
    property Pixels16[X, Y: Integer]: Word read GetPixel16 write SetPixel16; //后加真彩
    property SurfaceDesc: TDDSurfaceDesc2 read FSurfaceDesc;
    property SystemMemory: Boolean read FSystemMemory write FSystemMemory;
    property TransparentColor: Longint write SetTransparentColor;
    property Width: Integer read GetWidth;
  end;

  {  TDXDrawDisplay  }

  TCustomDXDraw = class;

  TDXDrawDisplayMode = class(TCollectionItem)
  private
    FSurfaceDesc: TDDSurfaceDesc;
    function GetBitCount: Integer;
    function GetHeight: Integer;
    function GetWidth: Integer;
  public
    property BitCount: Integer read GetBitCount;
    property Height: Integer read GetHeight;
    property SurfaceDesc: TDDSurfaceDesc read FSurfaceDesc;
    property Width: Integer read GetWidth;
  end;

  TDXDrawDisplay = class(TPersistent)
  private
    FBitCount: Integer;
    FDXDraw: TCustomDXDraw;
    FHeight: Integer;
    FModes: TCollection;
    FWidth: Integer;
    FFixedBitCount: Boolean;
    FFixedRatio: Boolean;
    FFixedSize: Boolean;
    function GetCount: Integer;
    function GetMode: TDXDrawDisplayMode;
    function GetMode2(Index: Integer): TDXDrawDisplayMode;
    procedure LoadDisplayModes;
    procedure SetBitCount(Value: Integer);
    procedure SetHeight(Value: Integer);
    procedure SetWidth(Value: Integer);
    function SetSize(AWidth, AHeight, ABitCount: Integer): Boolean;
    function DynSetSize(AWidth, AHeight, ABitCount: Integer): Boolean;
  public
    constructor Create(ADXDraw: TCustomDXDraw);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function IndexOf(Width, Height, BitCount: Integer): Integer;
    property Count: Integer read GetCount;
    property Mode: TDXDrawDisplayMode read GetMode;
    property Modes[Index: Integer]: TDXDrawDisplayMode read GetMode2; default;
  published
    property BitCount: Integer read FBitCount write SetBitCount default 8;
    property FixedBitCount: Boolean read FFixedBitCount write FFixedBitCount;
    property FixedRatio: Boolean read FFixedRatio write FFixedRatio;
    property FixedSize: Boolean read FFixedSize write FFixedSize;
    property Height: Integer read FHeight write SetHeight default 480;
    property Width: Integer read FWidth write SetWidth default 640;
  end;

  TDirectDrawDisplay = TDXDrawDisplay;
  TDirectDrawDisplayMode = TDXDrawDisplayMode;

  {  EDXDrawError  }

  EDXDrawError = class(Exception);

  {  TCustomDXDraw  }

  TDXDrawOption = (doFullScreen, doNoWindowChange, doAllowReboot, doWaitVBlank,
    doAllowPalette256, doSystemMemory, doStretch, doCenter, doFlip,
    do3D, doDirectX7Mode, doRetainedMode, doHardware, doSelectDriver, doZBuffer);

  TDXDrawOptions = set of TDXDrawOption;

  TDXDrawNotifyType = (dxntDestroying, dxntInitializing, dxntInitialize, dxntInitializeSurface,
    dxntFinalize, dxntFinalizeSurface, dxntRestore, dxntSetSurfaceSize);

  TDXDrawNotifyEvent = procedure(Sender: TCustomDXDraw; NotifyType: TDXDrawNotifyType) of object;

  TCustomDXDraw = class(TCustomControl)
  private
    FAutoInitialize: Boolean;
    FAutoSize: Boolean;
    FCalledDoInitialize: Boolean;
    FCalledDoInitializeSurface: Boolean;
    FForm: TCustomForm;
    FNotifyEventList: TList;
    FInitialized: Boolean;
    FInitialized2: Boolean;
    FInternalInitialized: Boolean;
    FUpdating: Boolean;
    FSubClass: TControlSubClass;
    FNowOptions: TDXDrawOptions;
    FOptions: TDXDrawOptions;
    FOnFinalize: TNotifyEvent;
    FOnFinalizeSurface: TNotifyEvent;
    FOnInitialize: TNotifyEvent;
    FOnInitializeSurface: TNotifyEvent;
    FOnInitializing: TNotifyEvent;
    FOnRestoreSurface: TNotifyEvent;
    FOffNotifyRestore: Integer;
    { DirectDraw }
    FDXDrawDriver: TObject;
    FDriver: PGUID;
    FDriverGUID: TGUID;
    FDDraw: TDirectDraw;
    FDisplay: TDXDrawDisplay;
    FClipper: TDirectDrawClipper;
    FPalette: TDirectDrawPalette;
    FPrimary: TDirectDrawSurface;
    FSurface: TDirectDrawSurface;
    FSurfaceWidth: Integer;
    FSurfaceHeight: Integer;

    procedure FormWndProc(var Message: TMessage; DefWindowProc: TWndMethod);
    function GetCanDraw: Boolean;
    function GetCanPaletteAnimation: Boolean;
    function GetSurfaceHeight: Integer;
    function GetSurfaceWidth: Integer;
    procedure NotifyEventList(NotifyType: TDXDrawNotifyType);
    procedure SetAutoSize(Value: Boolean);
    procedure SetColorTable(const ColorTable: TRGBQuads);
    procedure SetCooperativeLevel;
    procedure SetDisplay(Value: TDXDrawDisplay);
    procedure SetDriver(Value: PGUID);
    procedure SetOptions(Value: TDXDrawOptions);
    procedure SetSurfaceHeight(Value: Integer);
    procedure SetSurfaceWidth(Value: Integer);
    function TryRestore: Boolean;
    procedure WMCreate(var Message: TMessage); message WM_CREATE;
  protected
    procedure DoFinalize; virtual;
    procedure DoFinalizeSurface; virtual;
    procedure DoInitialize; virtual;
    procedure DoInitializeSurface; virtual;
    procedure DoInitializing; virtual;
    procedure DoRestoreSurface; virtual;
    procedure Loaded; override;
    procedure Paint; override;
    function PaletteChanged(Foreground: Boolean): Boolean; override;
    procedure SetParent(AParent: TWinControl); override;
  public
    ColorTable: TRGBQuads;
    DefColorTable: TRGBQuads;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function Drivers: TDirectXDrivers;
    procedure CreateParams(var Params:TCreateParams);override;//设置程序的类名 20080412
    procedure Finalize;
    procedure Flip;
    procedure Initialize;
    procedure Render;
    procedure Restore;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure SetSize(ASurfaceWidth, ASurfaceHeight: Integer);
    procedure UpdatePalette;
    procedure RegisterNotifyEvent(NotifyEvent: TDXDrawNotifyEvent);
    procedure UnRegisterNotifyEvent(NotifyEvent: TDXDrawNotifyEvent);

    property AutoInitialize: Boolean read FAutoInitialize write FAutoInitialize;
    property AutoSize: Boolean read FAutoSize write SetAutoSize;

    property CanDraw: Boolean read GetCanDraw;
    property CanPaletteAnimation: Boolean read GetCanPaletteAnimation;
    property Clipper: TDirectDrawClipper read FClipper;
    property Color;

    property DDraw: TDirectDraw read FDDraw;
    property Display: TDXDrawDisplay read FDisplay write SetDisplay;
    property Driver: PGUID read FDriver write SetDriver;
    property Initialized: Boolean read FInitialized;
    property NowOptions: TDXDrawOptions read FNowOptions;
    property OnFinalize: TNotifyEvent read FOnFinalize write FOnFinalize;
    property OnFinalizeSurface: TNotifyEvent read FOnFinalizeSurface write FOnFinalizeSurface;
    property OnInitialize: TNotifyEvent read FOnInitialize write FOnInitialize;
    property OnInitializeSurface: TNotifyEvent read FOnInitializeSurface write FOnInitializeSurface;
    property OnInitializing: TNotifyEvent read FOnInitializing write FOnInitializing;
    property OnRestoreSurface: TNotifyEvent read FOnRestoreSurface write FOnRestoreSurface;
    property Options: TDXDrawOptions read FOptions write SetOptions;
    property Palette: TDirectDrawPalette read FPalette;
    property Primary: TDirectDrawSurface read FPrimary;
    property Surface: TDirectDrawSurface read FSurface;
    property SurfaceHeight: Integer read GetSurfaceHeight write SetSurfaceHeight default 480;
    property SurfaceWidth: Integer read GetSurfaceWidth write SetSurfaceWidth default 640;
  end;

  {  TDXDraw  }

  TDXDraw = class(TCustomDXDraw)
  published
    property AutoInitialize;
    property AutoSize;
    property Color;
    property Display;
    property Options;
    property SurfaceHeight;
    property SurfaceWidth;
    property OnFinalize;
    property OnFinalizeSurface;
    property OnInitialize;
    property OnInitializeSurface;
    property OnInitializing;
    property OnRestoreSurface;

    property Align;
    property Anchors;
    property Constraints;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
  end;


  {  EPictureCollectionError  }

  EPictureCollectionError = class(Exception);

  {  TPictureCollectionItem  }

  TPictureCollection = class;

  TPictureCollectionItem = class(THashCollectionItem)
  private
    FPicture: TPicture;
    FInitialized: Boolean;
    FPatternHeight: Integer;
    FPatternWidth: Integer;
    FPatterns: TCollection;
    FSkipHeight: Integer;
    FSkipWidth: Integer;
    FSurfaceList: TList;
    FSystemMemory: Boolean;
    FTransparent: Boolean;
    FTransparentColor: TColor;
    procedure ClearSurface;
    procedure Finalize;
    procedure Initialize;
    function GetHeight: Integer;
    function GetPictureCollection: TPictureCollection;
    function GetPatternRect(Index: Integer): TRect;
    function GetPatternSurface(Index: Integer): TDirectDrawSurface;
    function GetPatternCount: Integer;
    function GetWidth: Integer;
    procedure SetPicture(Value: TPicture);
    procedure SetTransparentColor(Value: TColor);
  public
    dwLatestTime: LongWord;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(Dest: TDirectDrawSurface; X, Y: Integer; PatternIndex: Integer);
    procedure StretchDraw(Dest: TDirectDrawSurface; const DestRect: TRect; PatternIndex: Integer);
    procedure DrawAdd(Dest: TDirectDrawSurface; const DestRect: TRect; PatternIndex: Integer;
      Alpha: Integer = 255);
    procedure DrawAlpha(Dest: TDirectDrawSurface; const DestRect: TRect; PatternIndex: Integer;
      Alpha: Integer);
    procedure DrawSub(Dest: TDirectDrawSurface; const DestRect: TRect; PatternIndex: Integer;
      Alpha: Integer = 255);
    procedure DrawRotate(Dest: TDirectDrawSurface; X, Y, Width, Height: Integer; PatternIndex: Integer;
      CenterX, CenterY: Double; Angle: Integer);
    procedure DrawRotateAdd(Dest: TDirectDrawSurface; X, Y, Width, Height: Integer; PatternIndex: Integer;
      CenterX, CenterY: Double; Angle: Integer;
      Alpha: Integer = 255);
    procedure DrawRotateAlpha(Dest: TDirectDrawSurface; X, Y, Width, Height: Integer; PatternIndex: Integer;
      CenterX, CenterY: Double; Angle: Integer;
      Alpha: Integer);
    procedure DrawRotateSub(Dest: TDirectDrawSurface; X, Y, Width, Height: Integer; PatternIndex: Integer;
      CenterX, CenterY: Double; Angle: Integer;
      Alpha: Integer = 255);
    procedure DrawWaveX(Dest: TDirectDrawSurface; X, Y, Width, Height: Integer; PatternIndex: Integer;
      amp, Len, ph: Integer);
    procedure DrawWaveXAdd(Dest: TDirectDrawSurface; X, Y, Width, Height: Integer; PatternIndex: Integer;
      amp, Len, ph: Integer; Alpha: Integer = 255);
    procedure DrawWaveXAlpha(Dest: TDirectDrawSurface; X, Y, Width, Height, PatternIndex: Integer;
      amp, Len, ph: Integer; Alpha: Integer);
    procedure DrawWaveXSub(Dest: TDirectDrawSurface; X, Y, Width, Height: Integer; PatternIndex: Integer;
      amp, Len, ph: Integer; Alpha: Integer = 255);
    procedure Restore;
    property Height: Integer read GetHeight;
    property Initialized: Boolean read FInitialized;
    property PictureCollection: TPictureCollection read GetPictureCollection;
    property PatternCount: Integer read GetPatternCount;
    property PatternRects[Index: Integer]: TRect read GetPatternRect;
    property PatternSurfaces[Index: Integer]: TDirectDrawSurface read GetPatternSurface;
    property Width: Integer read GetWidth;
  published
    property PatternHeight: Integer read FPatternHeight write FPatternHeight;
    property PatternWidth: Integer read FPatternWidth write FPatternWidth;
    property Picture: TPicture read FPicture write SetPicture;
    property SkipHeight: Integer read FSkipHeight write FSkipHeight default 0;
    property SkipWidth: Integer read FSkipWidth write FSkipWidth default 0;
    property SystemMemory: Boolean read FSystemMemory write FSystemMemory;
    property Transparent: Boolean read FTransparent write FTransparent;
    property TransparentColor: TColor read FTransparentColor write SetTransparentColor;
  end;

  {  TPictureCollection  }

  TPictureCollection = class(THashCollection)
  private
    FDXDraw: TCustomDXDraw;
    FOwner: TPersistent;
    function GetItem(Index: Integer): TPictureCollectionItem;
    procedure ReadColorTable(Stream: TStream);
    procedure WriteColorTable(Stream: TStream);
    function Initialized: Boolean;
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetOwner: TPersistent; override;
  public
    ColorTable: TRGBQuads;
    constructor Create(AOwner: TPersistent);
    destructor Destroy; override;
    function Find(const Name: string): TPictureCollectionItem;
    procedure Finalize;
    procedure Initialize(DXDraw: TCustomDXDraw);
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure MakeColorTable;
    procedure Restore;
    procedure SaveToFile(const FileName: string);
    procedure SaveToStream(Stream: TStream);
    property DXDraw: TCustomDXDraw read FDXDraw;
    property Items[Index: Integer]: TPictureCollectionItem read GetItem; default;
  end;

  {  TCustomDXImageList  }

  TCustomDXImageList = class(TComponent)
  private
    FDXDraw: TCustomDXDraw;
    FItems: TPictureCollection;
    procedure DXDrawNotifyEvent(Sender: TCustomDXDraw; NotifyType: TDXDrawNotifyType);
    procedure SetDXDraw(Value: TCustomDXDraw);
    procedure SetItems(Value: TPictureCollection);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOnwer: TComponent); override;
    destructor Destroy; override;
    property DXDraw: TCustomDXDraw read FDXDraw write SetDXDraw;
    property Items: TPictureCollection read FItems write SetItems;
  end;

  {  TDXImageList  }

  TDXImageList = class(TCustomDXImageList)
  published
    property DXDraw;
    property Items;
  end;

  {  EDirectDrawOverlayError  }

  EDirectDrawOverlayError = class(Exception);

  {  TDirectDrawOverlay  }

  TDirectDrawOverlay = class
  private
    FDDraw: TDirectDraw;
    FTargetSurface: TDirectDrawSurface;
    FDDraw2: TDirectDraw;
    FTargetSurface2: TDirectDrawSurface;
    FSurface: TDirectDrawSurface;
    FBackSurface: TDirectDrawSurface;
    FOverlayColorKey: TColor;
    FOverlayRect: TRect;
    FVisible: Boolean;
    procedure SetOverlayColorKey(Value: TColor);
    procedure SetOverlayRect(const Value: TRect);
    procedure SetVisible(Value: Boolean);
  public
    constructor Create(DDraw: TDirectDraw; TargetSurface: TDirectDrawSurface);
    constructor CreateWindowed(WindowHandle: HWND);
    destructor Destroy; override;
    procedure Finalize;
    procedure Initialize(const SurfaceDesc: TDDSurfaceDesc2);
    procedure Flip;
    property OverlayColorKey: TColor read FOverlayColorKey write SetOverlayColorKey;
    property OverlayRect: TRect read FOverlayRect write SetOverlayRect;
    property Surface: TDirectDrawSurface read FSurface;
    property BackSurface: TDirectDrawSurface read FBackSurface;
    property Visible: Boolean read FVisible write SetVisible;
  end;
var
  CreateHandleCount:Int64=0;
  ImageFont: TImageFont = nil;
  MainForm: TForm = nil;
  MainFormDxDraw: TDxDraw;
  IsMMX: Boolean;
  IsSSE: Boolean;
implementation

uses DXConsts, DXRender;

var
  mask_r: Int64 = $F800F800F800F800; // 红色掩码
  mask_g: Int64 = $07E007E007E007E0; // 绿色掩码
  mask_b: Int64 = $001F001F001F001F; // 蓝色掩码
  maskh: Int64 = $7FE07FE07FE07FE0; // 高位掩码, 0111111111100000
  maskl: Int64 = $001F001F001F001F; // 低位掩码, 0000000000011111


function RGB16(c: TColor): Word;
begin
  Result := Word((c shl 8 and $F800) or (c shr 5 and $7E0) or (c shr 19 and $1F));
end;
function Bit16To64(Val: Word): Int64;
var
  bit64: Int64;
begin
  bit64 := Val;
  Result := bit64 or (bit64 shl 16) or (bit64 shl 32) or (bit64 shl 48);
end;

function DXDirectDrawEnumerate(lpCallback: TDDEnumCallbackA;
  lpContext: Pointer): HRESULT;
type
  TDirectDrawEnumerate = function(lpCallback: TDDEnumCallbackA;
    lpContext: Pointer): HRESULT; stdcall;
begin
  Result := TDirectDrawEnumerate(DXLoadLibrary('DDraw.dll', 'DirectDrawEnumerateA'))
    (lpCallback, lpContext);
end;

var
  DirectDrawDrivers: TDirectXDrivers;


function EnumDirectDrawDrivers: TDirectXDrivers;

  function DDENUMCALLBACK(lpGuid: PGUID; lpstrDescription: LPCSTR;
    lpstrModule: LPCSTR; lpContext: Pointer): BOOL; stdcall;
  begin
    Result := True;
    with TDirectXDriver.Create(TDirectXDrivers(lpContext)) do
    begin
      GUID := lpGuid;
      Description := lpstrDescription;
      DriverName := lpstrModule;
    end;
  end;

begin
  if DirectDrawDrivers = nil then
  begin
    DirectDrawDrivers := TDirectXDrivers.Create;
    try
      DXDirectDrawEnumerate(@DDENUMCALLBACK, DirectDrawDrivers);
    except
      DirectDrawDrivers.Free;
      raise;
    end;
  end;

  Result := DirectDrawDrivers;
end;

function ClipRect(var DestRect: TRect; const DestRect2: TRect): Boolean;
begin
  with DestRect do
  begin
    Left := Max(Left, DestRect2.Left);
    Right := Min(Right, DestRect2.Right);
    Top := Max(Top, DestRect2.Top);
    Bottom := Min(Bottom, DestRect2.Bottom);

    Result := (Left < Right) and (Top < Bottom);
  end;
end;

function ClipRect2(var DestRect, SrcRect: TRect; const DestRect2, SrcRect2: TRect): Boolean;
begin
  if DestRect.Left < DestRect2.Left then
  begin
    SrcRect.Left := SrcRect.Left + (DestRect2.Left - DestRect.Left);
    DestRect.Left := DestRect2.Left;
  end;

  if DestRect.Top < DestRect2.Top then
  begin
    SrcRect.Top := SrcRect.Top + (DestRect2.Top - DestRect.Top);
    DestRect.Top := DestRect2.Top;
  end;

  if SrcRect.Left < SrcRect2.Left then
  begin
    DestRect.Left := DestRect.Left + (SrcRect2.Left - SrcRect.Left);
    SrcRect.Left := SrcRect2.Left;
  end;

  if SrcRect.Top < SrcRect2.Top then
  begin
    DestRect.Top := DestRect.Top + (SrcRect2.Top - SrcRect.Top);
    SrcRect.Top := SrcRect2.Top;
  end;

  if DestRect.Right > DestRect2.Right then
  begin
    SrcRect.Right := SrcRect.Right - (DestRect.Right - DestRect2.Right);
    DestRect.Right := DestRect2.Right;
  end;

  if DestRect.Bottom > DestRect2.Bottom then
  begin
    SrcRect.Bottom := SrcRect.Bottom - (DestRect.Bottom - DestRect2.Bottom);
    DestRect.Bottom := DestRect2.Bottom;
  end;

  if SrcRect.Right > SrcRect2.Right then
  begin
    DestRect.Right := DestRect.Right - (SrcRect.Right - SrcRect2.Right);
    SrcRect.Right := SrcRect2.Right;
  end;

  if SrcRect.Bottom > SrcRect2.Bottom then
  begin
    DestRect.Bottom := DestRect.Bottom - (SrcRect.Bottom - SrcRect2.Bottom);
    SrcRect.Bottom := SrcRect2.Bottom;
  end;

  Result := (DestRect.Left < DestRect.Right) and (DestRect.Top < DestRect.Bottom) and
    (SrcRect.Left < SrcRect.Right) and (SrcRect.Top < SrcRect.Bottom);
end;

{  TDirectDraw  }

constructor TDirectDraw.Create(GUID: PGUID);
begin
  CreateEx(GUID, True);
end;

constructor TDirectDraw.CreateEx(GUID: PGUID; DirectX7Mode: Boolean);
type
  TDirectDrawCreate = function(lpGuid: PGUID; out lplpDD: IDirectDraw;
    pUnkOuter: IUnknown): HRESULT; stdcall;

  TDirectDrawCreateEx = function(lpGuid: PGUID; out lplpDD: IDirectDraw7; const iid: TGUID;
    pUnkOuter: IUnknown): HRESULT; stdcall;
begin
  inherited Create;
  FClippers := TList.Create;
  FPalettes := TList.Create;
  FSurfaces := TList.Create;

    { DirectX 7 }
  if TDirectDrawCreateEx(DXLoadLibrary('DDraw.dll', 'DirectDrawCreateEx'))(GUID, FIDDraw, IID_IDirectDraw7, nil) <> DD_OK then
    raise EDirectDrawError.CreateFmt(SCannotInitialized, [SDirectDraw]);
  try
   { FIDDraw := FIDDraw7 as IDirectDraw;
    FIDDraw4 := FIDDraw7 as IDirectDraw4;    }
  except
    raise EDirectDrawError.Create(SSinceDirectX7);
  end;

  FDriverCaps.dwSize := SizeOf(FDriverCaps);
  FHELCaps.dwSize := SizeOf(FHELCaps);
  FIDDraw.GetCaps(FDriverCaps, FHELCaps);
end;

destructor TDirectDraw.Destroy;
begin
  while SurfaceCount > 0 do
    Surfaces[SurfaceCount - 1].Free;

  while PaletteCount > 0 do
    Palettes[PaletteCount - 1].Free;

  while ClipperCount > 0 do
    Clippers[ClipperCount - 1].Free;

  FSurfaces.Free;
  FPalettes.Free;
  FClippers.Free;
  inherited Destroy;
end;

class function TDirectDraw.Drivers: TDirectXDrivers;
begin
  Result := EnumDirectDrawDrivers;
end;

function TDirectDraw.GetClipper(Index: Integer): TDirectDrawClipper;
begin
  Result := FClippers[Index];
end;

function TDirectDraw.GetClipperCount: Integer;
begin
  Result := FClippers.Count;
end;

function TDirectDraw.GetDisplayMode: TDDSurfaceDesc2;
begin
  Result.dwSize := SizeOf(Result);
  DXResult := IDraw.GetDisplayMode(Result);
  if DXResult <> DD_OK then
    FillChar(Result, SizeOf(Result), 0);
end;

function TDirectDraw.GetIDDraw7: IDirectDraw7;
begin
  if Self <> nil then
    Result := FIDDraw
  else
    Result := nil;
end;

function TDirectDraw.GetIDraw7: IDirectDraw7;
begin
  Result := IDDraw;
  if Result = nil then
    raise EDirectDrawError.CreateFmt(SNotMade, ['IDirectDraw7']);
end;

function TDirectDraw.GetPalette(Index: Integer): TDirectDrawPalette;
begin
  Result := FPalettes[Index];
end;

function TDirectDraw.GetPaletteCount: Integer;
begin
  Result := FPalettes.Count;
end;

function TDirectDraw.GetSurface(Index: Integer): TDirectDrawSurface;
begin
  Result := FSurfaces[Index];
end;

function TDirectDraw.GetSurfaceCount: Integer;
begin
  Result := FSurfaces.Count;
end;

{  TDirectDrawPalette  }

constructor TDirectDrawPalette.Create(ADirectDraw: TDirectDraw);
begin
  inherited Create;
  FDDraw := ADirectDraw;
  FDDraw.FPalettes.Add(Self);
end;

destructor TDirectDrawPalette.Destroy;
begin
  FDDraw.FPalettes.Remove(Self);
  inherited Destroy;
end;

function TDirectDrawPalette.CreatePalette(Caps: DWORD; const Entries): Boolean;
var
  TempPalette: IDirectDrawPalette;
begin
  IDDPalette := nil;

  FDDraw.DXResult := FDDraw.IDraw.CreatePalette(Caps, @Entries, TempPalette, nil);
  FDXResult := FDDraw.DXResult;
  Result := FDDraw.DXResult = DD_OK;
  if Result then
    IDDPalette := TempPalette;
end;

procedure TDirectDrawPalette.LoadFromDIB(DIB: TDIB);
var
  Entries: TPaletteEntries;
begin
  Entries := RGBQuadsToPaletteEntries(DIB.ColorTable);
  CreatePalette(DDPCAPS_8BIT, Entries);
end;

procedure TDirectDrawPalette.LoadFromFile(const FileName: string);
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TDirectDrawPalette.LoadFromStream(Stream: TStream);
var
  DIB: TDIB;
begin
  DIB := TDIB.Create;
  try
    DIB.LoadFromStream(Stream);
    if DIB.Size > 0 then
      LoadFromDIB(DIB);
  finally
    DIB.Free;
  end;
end;

function TDirectDrawPalette.GetEntries(StartIndex, NumEntries: Integer;
  var Entries): Boolean;
begin
  if IDDPalette <> nil then
  begin
    DXResult := IPalette.GetEntries(0, StartIndex, NumEntries, @Entries);
    Result := DXResult = DD_OK;
  end else
    Result := False;
end;

function TDirectDrawPalette.GetEntry(Index: Integer): TPaletteEntry;
begin
  GetEntries(Index, 1, Result);
end;

function TDirectDrawPalette.GetIDDPalette: IDirectDrawPalette;
begin
  if Self <> nil then
    Result := FIDDPalette
  else
    Result := nil;
end;

function TDirectDrawPalette.GetIPalette: IDirectDrawPalette;
begin
  Result := IDDPalette;
  if Result = nil then
    raise EDirectDrawPaletteError.CreateFmt(SNotMade, ['IDirectDrawPalette']);
end;

function TDirectDrawPalette.SetEntries(StartIndex, NumEntries: Integer;
  const Entries): Boolean;
begin
  if IDDPalette <> nil then
  begin
    DXResult := IPalette.SetEntries(0, StartIndex, NumEntries, @Entries);
    Result := DXResult = DD_OK;
  end else
    Result := False;
end;

procedure TDirectDrawPalette.SetEntry(Index: Integer; Value: TPaletteEntry);
begin
  SetEntries(Index, 1, Value);
end;

procedure TDirectDrawPalette.SetIDDPalette(Value: IDirectDrawPalette);
begin
  if FIDDPalette = Value then Exit;
  FIDDPalette := Value;
end;

{  TDirectDrawClipper  }

constructor TDirectDrawClipper.Create(ADirectDraw: TDirectDraw);
begin
  inherited Create;
  FDDraw := ADirectDraw;
  FDDraw.FClippers.Add(Self);

  FDDraw.DXResult := FDDraw.IDraw.CreateClipper(0, FIDDClipper, nil);
  if FDDraw.DXResult <> DD_OK then
    raise EDirectDrawClipperError.CreateFmt(SCannotMade, [SDirectDrawClipper]);
end;

destructor TDirectDrawClipper.Destroy;
begin
  FDDraw.FClippers.Remove(Self);
  inherited Destroy;
end;

function TDirectDrawClipper.GetIDDClipper: IDirectDrawClipper;
begin
  if Self <> nil then
    Result := FIDDClipper
  else
    Result := nil;
end;

function TDirectDrawClipper.GetIClipper: IDirectDrawClipper;
begin
  Result := IDDClipper;
  if Result = nil then
    raise EDirectDrawClipperError.CreateFmt(SNotMade, ['IDirectDrawClipper']);
end;

procedure TDirectDrawClipper.SetClipRects(const Rects: array of TRect);
type
  PArrayRect = ^TArrayRect;
  TArrayRect = array[0..0] of TRect;
var
  RgnData: PRgnData;
  I: Integer;
  BoundsRect: TRect;
begin
  BoundsRect := Rect(MaxInt, MaxInt, -MaxInt, -MaxInt);
  for I := Low(Rects) to High(Rects) do
  begin
    with BoundsRect do
    begin
      Left := Min(Rects[I].Left, Left);
      Right := Max(Rects[I].Right, Right);
      Top := Min(Rects[I].Top, Top);
      Bottom := Max(Rects[I].Bottom, Bottom);
    end;
  end;

  GetMem(RgnData, SizeOf(TRgnDataHeader) + SizeOf(TRect) * (High(Rects) - Low(Rects) + 1));
  try
    with RgnData^.rdh do
    begin
      dwSize := SizeOf(TRgnDataHeader);
      iType := RDH_RECTANGLES;
      nCount := High(Rects) - Low(Rects) + 1;
      nRgnSize := nCount * SizeOf(TRect);
      rcBound := BoundsRect;
    end;
    for I := Low(Rects) to High(Rects) do
      PArrayRect(@RgnData^.Buffer)^[I - Low(Rects)] := Rects[I];
    DXResult := IClipper.SetClipList(RgnData, 0);
  finally
    FreeMem(RgnData);
  end;
end;

procedure TDirectDrawClipper.SetHandle(Value: THandle);
begin
  DXResult := IClipper.SetHWnd(0, Value);
end;

procedure TDirectDrawClipper.SetIDDClipper(Value: IDirectDrawClipper);
begin
  if FIDDClipper = Value then Exit;
  FIDDClipper := Value;
end;

{  TDirectDrawSurfaceCanvas  }

constructor TDirectDrawSurfaceCanvas.Create(ASurface: TDirectDrawSurface);
begin
  inherited Create;
  FSurface := ASurface;
end;

destructor TDirectDrawSurfaceCanvas.Destroy;
begin
  Release;
  //FSurface.FCanvas := nil;
  inherited Destroy;
end;

procedure TDirectDrawSurfaceCanvas.CreateHandle;
begin
  FSurface.DXResult := FSurface.ISurface.GetDC(FDC);
  if FSurface.DXResult = DD_OK then begin
    Handle := FDC;
    Inc(CreateHandleCount);
  end;
end;

procedure TDirectDrawSurfaceCanvas.Release;
begin
  if (FSurface.IDDSurface <> nil) and (FDC <> 0) then
  begin
    Handle := 0;
    FSurface.IDDSurface.ReleaseDC(FDC);
    FDC := 0;
    Dec(CreateHandleCount);
  end;
end;

{  TDirectDrawSurface  }

constructor TDirectDrawSurface.Create(ADirectDraw: TDirectDraw);
begin
  inherited Create;
  FDDraw := ADirectDraw;
  FDDraw.FSurfaces.Add(Self);
end;

destructor TDirectDrawSurface.Destroy;
begin
  FCanvas.Free;
  IDDSurface := nil;
  FDDraw.FSurfaces.Remove(Self);
  inherited Destroy;
end;

function TDirectDrawSurface.GetIDDSurface7: IDirectDrawSurface7;
begin
  if Self <> nil then
    Result := FIDDSurface
  else
    Result := nil;
end;

function TDirectDrawSurface.GetISurface7: IDirectDrawSurface7;
begin
  Result := IDDSurface;
  if Result = nil then
    raise EDirectDrawSurfaceError.CreateFmt(SNotMade, ['IDirectDrawSurface7']);
end;

procedure TDirectDrawSurface.SetIDDSurface7(Value: IDirectDrawSurface7);
var
  Clipper: IDirectDrawClipper;
begin
  if Value = nil then Exit;
  if Value = FIDDSurface then Exit;

  FIDDSurface := nil;

  FStretchDrawClipper := nil;
  FGammaControl := nil;
  FHasClipper := False;
  FLockCount := 0;
  FillChar(FSurfaceDesc, SizeOf(FSurfaceDesc), #0);

  if Value <> nil then
  begin
    FIDDSurface := Value;

    FHasClipper := (FIDDSurface.GetClipper(Clipper) = DD_OK) and (Clipper <> nil);

    FSurfaceDesc.dwSize := SizeOf(FSurfaceDesc);
    FIDDSurface.GetSurfaceDesc(FSurfaceDesc);

    {if FDDraw.DriverCaps.dwCaps2 and DDCAPS2_PRIMARYGAMMA <> 0 then    //卡
      FIDDSurface.QueryInterface(IID_IDirectDrawGammaControl, FGammaControl); }
  end;
end;

procedure TDirectDrawSurface.Assign(Source: TPersistent);
var
  TempSurface: IDirectDrawSurface7;
begin
  if Source = nil then
    IDDSurface := nil
  else if Source is TGraphic then
    LoadFromGraphic(TGraphic(Source))
  else if Source is TPicture then
    LoadFromGraphic(TPicture(Source).Graphic)
  else if Source is TDirectDrawSurface then
  begin
    if TDirectDrawSurface(Source).IDDSurface = nil then
      IDDSurface := nil
    else begin
      FDDraw.DXResult := FDDraw.IDraw.DuplicateSurface(TDirectDrawSurface(Source).IDDSurface,
        TempSurface);
      if FDDraw.DXResult = 0 then
      begin
        IDDSurface := TempSurface;
      end;
    end;
  end else
    inherited Assign(Source);
end;

procedure TDirectDrawSurface.AssignTo(Dest: TPersistent);
begin
  if Dest is TDIB then
  begin
    TDIB(Dest).SetSize(Width, Height, 24);
    TDIB(Dest).Canvas.CopyRect(Rect(0, 0, TDIB(Dest).Width, TDIB(Dest).Height), Canvas, ClientRect);
    Canvas.Release;
  end else
    inherited AssignTo(Dest);
end;

function TDirectDrawSurface.Blt(const DestRect, SrcRect: TRect; Flags: DWORD;
  const DF: TDDBltFX; Source: TDirectDrawSurface): Boolean;
begin
  if IDDSurface <> nil then
  begin
    DXResult := ISurface.Blt(DestRect, Source.IDDSurface, SrcRect, DWORD(Flags), DF);
    Result := DXResult = DD_OK;
  end else
    Result := False;
end;

function TDirectDrawSurface.BltFast(X, Y: Integer; const SrcRect: TRect;
  Flags: DWORD; Source: TDirectDrawSurface): Boolean;
begin
  if IDDSurface <> nil then
  begin
    DXResult := ISurface.BltFast(X, Y, Source.IDDSurface, SrcRect, DWORD(Flags));
    Result := DXResult = DD_OK;
  end else
    Result := False;
end;

function TDirectDrawSurface.ColorMatch(Col: TColor): Integer;
var
  DIB: TDIB;
  I, oldc: Integer;
begin
  if IDDSurface <> nil then
  begin
    oldc := Pixels[0, 0];

    DIB := TDIB.Create;
    try
      I := ColorToRGB(Col);
      DIB.SetSize(1, 1, 8);
      DIB.ColorTable[0] := RGBQuad(GetRValue(I), GetGValue(I), GetBValue(I));
      DIB.UpdatePalette;
      DIB.Pixels[0, 0] := 0;

      with Canvas do
      begin
        Draw(0, 0, DIB);
        Release;
      end;
    finally
      DIB.Free;
    end;
    Result := Pixels[0, 0];
    Pixels[0, 0] := oldc;
  end else
    Result := 0;

end;

function TDirectDrawSurface.CreateSurface(const SurfaceDesc: TDDSurfaceDesc2): Boolean;
var
  TempSurface: IDirectDrawSurface7;
begin
  IDDSurface := nil;
  FDDraw.DXResult := FDDraw.IDraw.CreateSurface(SurfaceDesc, TempSurface, nil);
  FDXResult := FDDraw.DXResult;
  Result := FDDraw.DXResult = DD_OK;
  if Result then
  begin
    IDDSurface := TempSurface;
    TransparentColor := 0;
  end;
end;

procedure TDirectDrawSurface.TextOut(X, Y, Color: Integer; str:string);
begin
  ImageFont.Draw(Self, X, Y, str, Color);
end;

procedure TDirectDrawSurface.BoldTextOut(x, y, fcolor, bcolor: Integer;
  str: string);
begin
  ImageFont.BoldDrawRect(Self, Self.ClientRect, X, Y, str, FColor, Bcolor);
end;

procedure TDirectDrawSurface.BoldTextOut(x, y, fcolor, bcolor: Integer;
  str: string; Alpha: Integer);
begin
  ImageFont.BoldDrawRectAlpha(Self, Self.ClientRect, X, Y, str, FColor, Bcolor, Alpha);
end;

procedure TDirectDrawSurface.Draw(X, Y: Integer; SrcRect: TRect; Source: TDirectDrawSurface;
  Transparent: Boolean);
const
  BltFastFlags: array[Boolean] of Integer =
  (DDBLTFAST_NOCOLORKEY or DDBLTFAST_WAIT, DDBLTFAST_SRCCOLORKEY or DDBLTFAST_WAIT);
  BltFlags: array[Boolean] of Integer =
  (DDBLT_WAIT, DDBLT_KEYSRC or DDBLT_WAIT);
var
  DestRect: TRect;
  DF: TDDBltFX;
  Clipper: IDirectDrawClipper;
  I: Integer;
begin
  if Source <> nil then
  begin
    if (X > Width) or (Y > Height) then Exit;

    if (SrcRect.Left > SrcRect.Right) or (SrcRect.Top > SrcRect.Bottom) then
    begin
      {  Mirror  }
      if ((X + Abs(SrcRect.Left - SrcRect.Right)) <= 0) or
        ((Y + Abs(SrcRect.Top - SrcRect.Bottom)) <= 0) then Exit;

      DF.dwSize := SizeOf(DF);
      DF.dwDDFX := 0;

      if SrcRect.Left > SrcRect.Right then
      begin
        I := SrcRect.Left; SrcRect.Left := SrcRect.Right; SrcRect.Right := I;
        DF.dwDDFX := DF.dwDDFX or DDBLTFX_MIRRORLEFTRIGHT;
      end;

      if SrcRect.Top > SrcRect.Bottom then
      begin
        I := SrcRect.Top; SrcRect.Top := SrcRect.Bottom; SrcRect.Bottom := I;
        DF.dwDDFX := DF.dwDDFX or DDBLTFX_MIRRORUPDOWN;
      end;

      with SrcRect do
        DestRect := Bounds(X, Y, Right - Left, Bottom - Top);

      if ClipRect2(DestRect, SrcRect, ClientRect, Source.ClientRect) then
      begin
        if DF.dwDDFX and DDBLTFX_MIRRORLEFTRIGHT <> 0 then
        begin
          I := SrcRect.Left;
          SrcRect.Left := Source.Width - SrcRect.Right;
          SrcRect.Right := Source.Width - I;
        end;

        if DF.dwDDFX and DDBLTFX_MIRRORUPDOWN <> 0 then
        begin
          I := SrcRect.Top;
          SrcRect.Top := Source.Height - SrcRect.Bottom;
          SrcRect.Bottom := Source.Height - I;
        end;

        Blt(DestRect, SrcRect, BltFlags[Transparent] or DDBLT_DDFX, DF, Source);
      end;
    end else
    begin
      with SrcRect do
        DestRect := Bounds(X, Y, Right - Left, Bottom - Top);

      if ClipRect2(DestRect, SrcRect, ClientRect, Source.ClientRect) then
      begin
        if FHasClipper then
        begin
          DF.dwSize := SizeOf(DF);
          DF.dwDDFX := 0;
          Blt(DestRect, SrcRect, BltFlags[Transparent], DF, Source);
        end else
        begin
          BltFast(DestRect.Left, DestRect.Top, SrcRect, BltFastFlags[Transparent], Source);
          if DXResult = DDERR_BLTFASTCANTCLIP then
          begin
            ISurface.GetClipper(Clipper);
            if Clipper <> nil then FHasClipper := True;

            DF.dwSize := SizeOf(DF);
            DF.dwDDFX := 0;
            Blt(DestRect, SrcRect, BltFlags[Transparent], DF, Source);
          end;
        end;
      end;
    end;
  end;
end;

//{$IFDEF DelphiX_Spt4}

procedure TDirectDrawSurface.Draw(X, Y: Integer; Source: TDirectDrawSurface; Transparent: Boolean);
const
  BltFastFlags: array[Boolean] of Integer =
  (DDBLTFAST_NOCOLORKEY or DDBLTFAST_WAIT, DDBLTFAST_SRCCOLORKEY or DDBLTFAST_WAIT);
  BltFlags: array[Boolean] of Integer =
  (DDBLT_WAIT, DDBLT_KEYSRC or DDBLT_WAIT);
var
  DestRect, SrcRect: TRect;
  DF: TDDBltFX;
  Clipper: IDirectDrawClipper;
begin
  if Source <> nil then
  begin
    SrcRect := Source.ClientRect;
    DestRect := Bounds(X, Y, Source.Width, Source.Height);

    if ClipRect2(DestRect, SrcRect, ClientRect, Source.ClientRect) then
    begin
      if FHasClipper then
      begin
        DF.dwSize := SizeOf(DF);
        DF.dwDDFX := 0;
        Blt(DestRect, SrcRect, BltFlags[Transparent], DF, Source);
      end else
      begin
        BltFast(DestRect.Left, DestRect.Top, SrcRect, BltFastFlags[Transparent], Source);
        if DXResult = DDERR_BLTFASTCANTCLIP then
        begin
          ISurface.GetClipper(Clipper);
          if Clipper <> nil then FHasClipper := True;

          DF.dwSize := SizeOf(DF);
          DF.dwDDFX := 0;
          Blt(DestRect, SrcRect, BltFlags[Transparent], DF, Source);
        end;
      end;
    end;
  end;
end;
//{$ENDIF}

procedure TDirectDrawSurface.StretchDraw(const DestRect, SrcRect: TRect; Source: TDirectDrawSurface;
  Transparent: Boolean);
const
  BltFlags: array[Boolean] of Integer =
  (DDBLT_WAIT, DDBLT_KEYSRC or DDBLT_WAIT);
var
  DF: TDDBltFX;
  OldClipper: IDirectDrawClipper;
  Clipper: TDirectDrawClipper;
begin
  if Source <> nil then
  begin
    if (DestRect.Bottom <= DestRect.Top) or (DestRect.Right <= DestRect.Left) then Exit;
    if (SrcRect.Bottom <= SrcRect.Top) or (SrcRect.Right <= SrcRect.Left) then Exit;

    if FHasClipper then
    begin
      DF.dwSize := SizeOf(DF);
      DF.dwDDFX := 0;
      Blt(DestRect, SrcRect, BltFlags[Transparent], DF, Source);
    end else
    begin
      if FStretchDrawClipper = nil then
      begin
        Clipper := TDirectDrawClipper.Create(DDraw);
        try
          Clipper.SetClipRects([ClientRect]);
          FStretchDrawClipper := Clipper.IClipper;
        finally
          Clipper.Free;
        end;
      end;

      ISurface.GetClipper(OldClipper);
      ISurface.SetClipper(FStretchDrawClipper);
      DF.dwSize := SizeOf(DF);
      DF.dwDDFX := 0;
      Blt(DestRect, SrcRect, BltFlags[Transparent], DF, Source);
      ISurface.SetClipper(nil);
    end;
  end;
end;

//{$IFDEF DelphiX_Spt4}

procedure TDirectDrawSurface.StretchDraw(const DestRect: TRect; Source: TDirectDrawSurface;
  Transparent: Boolean);
const
  BltFlags: array[Boolean] of Integer =

  (DDBLT_WAIT, DDBLT_KEYSRC or DDBLT_WAIT);
var
  DF: TDDBltFX;
  OldClipper: IDirectDrawClipper;
  Clipper: TDirectDrawClipper;
  SrcRect: TRect;
begin
  if Source <> nil then
  begin
    if (DestRect.Bottom <= DestRect.Top) or (DestRect.Right <= DestRect.Left) then Exit;
    SrcRect := Source.ClientRect;

    if ISurface.GetClipper(OldClipper) = DD_OK then
    begin
      DF.dwSize := SizeOf(DF);
      DF.dwDDFX := 0;
      Blt(DestRect, SrcRect, BltFlags[Transparent], DF, Source);
    end else
    begin
      if FStretchDrawClipper = nil then
      begin
        Clipper := TDirectDrawClipper.Create(DDraw);
        try
          Clipper.SetClipRects([ClientRect]);
          FStretchDrawClipper := Clipper.IClipper;
        finally
          Clipper.Free;
        end;
      end;

      ISurface.SetClipper(FStretchDrawClipper);
      try
        DF.dwSize := SizeOf(DF);
        DF.dwDDFX := 0;
        Blt(DestRect, SrcRect, BltFlags[Transparent], DF, Source);
      finally
        ISurface.SetClipper(nil);
      end;
    end;
  end;
end;
//{$ENDIF}

procedure TDirectDrawSurface.DrawAdd(const DestRect, SrcRect: TRect; Source: TDirectDrawSurface;
  Transparent: Boolean; Alpha: Integer);
var
  Src_ddsd: TDDSurfaceDesc2;
  DestSurface, SrcSurface: TDXR_Surface;
  Blend: TDXR_Blend;
begin
  if (Self.Width = 0) or (Self.Height = 0) then Exit;
  if (Width = 0) or (Height = 0) then Exit;
  if Source = nil then Exit;
  if (Source.Width = 0) or (Source.Height = 0) then Exit;

  if Alpha <= 0 then Exit;

  if dxrDDSurfaceLock(ISurface, DestSurface) then
  begin
    try
      if dxrDDSurfaceLock2(Source.ISurface, Src_ddsd, SrcSurface) then
      begin
        try
          if DestSurface.ColorType = DXR_COLORTYPE_INDEXED then
          begin
            Blend := DXR_BLEND_ONE1;
          end else
            if Alpha >= 255 then
          begin
            Blend := DXR_BLEND_ONE1_ADD_ONE2;
          end else
          begin
            Blend := DXR_BLEND_SRCALPHA1_ADD_ONE2;
          end;

          dxrCopyRectBlend(DestSurface, SrcSurface,
            DestRect, SrcRect, Blend, Alpha, Transparent, Src_ddsd.ddckCKSrcBlt.dwColorSpaceLowValue);
        finally
          dxrDDSurfaceUnLock(Source.ISurface, SrcSurface)
        end;
      end;
    finally
      dxrDDSurfaceUnLock(ISurface, DestSurface)
    end;
  end;
end;

procedure TDirectDrawSurface.DrawAlpha(const DestRect, SrcRect: TRect; Source: TDirectDrawSurface;
  Transparent: Boolean; Alpha: Integer);
var
  Src_ddsd: TDDSurfaceDesc2;
  DestSurface, SrcSurface: TDXR_Surface;
  Blend: TDXR_Blend;
begin
  if (Self.Width = 0) or (Self.Height = 0) then Exit;
  if (Width = 0) or (Height = 0) then Exit;
  if Source = nil then Exit;
  if (Source.Width = 0) or (Source.Height = 0) then Exit;

  if Alpha <= 0 then Exit;

  if dxrDDSurfaceLock(ISurface, DestSurface) then
  begin
    try
      if dxrDDSurfaceLock2(Source.ISurface, Src_ddsd, SrcSurface) then
      begin
        try
          if DestSurface.ColorType = DXR_COLORTYPE_INDEXED then
          begin
            Blend := DXR_BLEND_ONE1;
          end else
            if Alpha >= 255 then
          begin
            Blend := DXR_BLEND_ONE1;
          end else
          begin
            Blend := DXR_BLEND_SRCALPHA1_ADD_INVSRCALPHA2;
          end;

          dxrCopyRectBlend(DestSurface, SrcSurface,
            DestRect, SrcRect, Blend, Alpha, Transparent, Src_ddsd.ddckCKSrcBlt.dwColorSpaceLowValue);
        finally
          dxrDDSurfaceUnLock(Source.ISurface, SrcSurface)
        end;
      end;
    finally
      dxrDDSurfaceUnLock(ISurface, DestSurface)
    end;
  end;
end;

procedure TDirectDrawSurface.DrawSub(const DestRect, SrcRect: TRect; Source: TDirectDrawSurface;
  Transparent: Boolean; Alpha: Integer);
var
  Src_ddsd: TDDSurfaceDesc2;
  DestSurface, SrcSurface: TDXR_Surface;
  Blend: TDXR_Blend;
begin
  if (Self.Width = 0) or (Self.Height = 0) then Exit;
  if (Width = 0) or (Height = 0) then Exit;
  if Source = nil then Exit;
  if (Source.Width = 0) or (Source.Height = 0) then Exit;

  if Alpha <= 0 then Exit;

  if dxrDDSurfaceLock(ISurface, DestSurface) then
  begin
    try
      if dxrDDSurfaceLock2(Source.ISurface, Src_ddsd, SrcSurface) then
      begin
        try
          if DestSurface.ColorType = DXR_COLORTYPE_INDEXED then
          begin
            Blend := DXR_BLEND_ONE1;
          end else
            if Alpha >= 255 then
          begin
            Blend := DXR_BLEND_ONE2_SUB_ONE1;
          end else
          begin
            Blend := DXR_BLEND_ONE2_SUB_SRCALPHA1;
          end;

          dxrCopyRectBlend(DestSurface, SrcSurface,
            DestRect, SrcRect, Blend, Alpha, Transparent, Src_ddsd.ddckCKSrcBlt.dwColorSpaceLowValue);
        finally
          dxrDDSurfaceUnLock(Source.ISurface, SrcSurface)
        end;
      end;
    finally
      dxrDDSurfaceUnLock(ISurface, DestSurface)
    end;
  end;
end;

procedure TDirectDrawSurface.DrawRotate(X, Y, Width, Height: Integer; const SrcRect: TRect;
  Source: TDirectDrawSurface; CenterX, CenterY: Double; Transparent: Boolean; Angle: Integer);
var
  Src_ddsd: TDDSurfaceDesc2;
  DestSurface, SrcSurface: TDXR_Surface;
begin
  if (Self.Width = 0) or (Self.Height = 0) then Exit;
  if (Width = 0) or (Height = 0) then Exit;
  if Source = nil then Exit;
  if (Source.Width = 0) or (Source.Height = 0) then Exit;

  if dxrDDSurfaceLock(ISurface, DestSurface) then
  begin
    try
      if dxrDDSurfaceLock2(Source.ISurface, Src_ddsd, SrcSurface) then
      begin
        try
          dxrDrawRotateBlend(DestSurface, SrcSurface,
            X, Y, Width, Height, SrcRect, CenterX, CenterY, Angle, DXR_BLEND_ONE1, 0,
            Transparent, Src_ddsd.ddckCKSrcBlt.dwColorSpaceLowValue);
        finally
          dxrDDSurfaceUnLock(Source.ISurface, SrcSurface)
        end;
      end;
    finally
      dxrDDSurfaceUnLock(ISurface, DestSurface)
    end;
  end;
end;

procedure TDirectDrawSurface.DrawRotateAdd(X, Y, Width, Height: Integer; const SrcRect: TRect;
  Source: TDirectDrawSurface; CenterX, CenterY: Double; Transparent: Boolean; Angle, Alpha: Integer);
var
  Src_ddsd: TDDSurfaceDesc2;
  DestSurface, SrcSurface: TDXR_Surface;
  Blend: TDXR_Blend;
begin
  if Alpha <= 0 then Exit;

  if (Self.Width = 0) or (Self.Height = 0) then Exit;
  if (Width = 0) or (Height = 0) then Exit;
  if Source = nil then Exit;
  if (Source.Width = 0) or (Source.Height = 0) then Exit;

  if dxrDDSurfaceLock(ISurface, DestSurface) then
  begin
    try
      if dxrDDSurfaceLock2(Source.ISurface, Src_ddsd, SrcSurface) then
      begin
        try
          if DestSurface.ColorType = DXR_COLORTYPE_INDEXED then
          begin
            Blend := DXR_BLEND_ONE1;
          end else
            if Alpha >= 255 then
          begin
            Blend := DXR_BLEND_ONE1_ADD_ONE2;
          end else
          begin
            Blend := DXR_BLEND_SRCALPHA1_ADD_ONE2;
          end;

          dxrDrawRotateBlend(DestSurface, SrcSurface,
            X, Y, Width, Height, SrcRect, CenterX, CenterY, Angle, Blend, Alpha,
            Transparent, Src_ddsd.ddckCKSrcBlt.dwColorSpaceLowValue);
        finally
          dxrDDSurfaceUnLock(Source.ISurface, SrcSurface)
        end;
      end;
    finally
      dxrDDSurfaceUnLock(ISurface, DestSurface)
    end;
  end;
end;

procedure TDirectDrawSurface.DrawRotateAlpha(X, Y, Width, Height: Integer; const SrcRect: TRect;
  Source: TDirectDrawSurface; CenterX, CenterY: Double; Transparent: Boolean; Angle, Alpha: Integer);
var
  Src_ddsd: TDDSurfaceDesc2;
  DestSurface, SrcSurface: TDXR_Surface;
  Blend: TDXR_Blend;
begin
  if Alpha <= 0 then Exit;

  if (Self.Width = 0) or (Self.Height = 0) then Exit;
  if (Width = 0) or (Height = 0) then Exit;
  if Source = nil then Exit;
  if (Source.Width = 0) or (Source.Height = 0) then Exit;

  if dxrDDSurfaceLock(ISurface, DestSurface) then
  begin
    try
      if dxrDDSurfaceLock2(Source.ISurface, Src_ddsd, SrcSurface) then
      begin
        try
          if DestSurface.ColorType = DXR_COLORTYPE_INDEXED then
          begin
            Blend := DXR_BLEND_ONE1;
          end else
            if Alpha >= 255 then
          begin
            Blend := DXR_BLEND_ONE1;
          end else
          begin
            Blend := DXR_BLEND_SRCALPHA1_ADD_INVSRCALPHA2;
          end;

          dxrDrawRotateBlend(DestSurface, SrcSurface,
            X, Y, Width, Height, SrcRect, CenterX, CenterY, Angle, Blend, Alpha,
            Transparent, Src_ddsd.ddckCKSrcBlt.dwColorSpaceLowValue);
        finally
          dxrDDSurfaceUnLock(Source.ISurface, SrcSurface)
        end;
      end;
    finally
      dxrDDSurfaceUnLock(ISurface, DestSurface)
    end;
  end;
end;

procedure TDirectDrawSurface.DrawRotateSub(X, Y, Width, Height: Integer; const SrcRect: TRect;
  Source: TDirectDrawSurface; CenterX, CenterY: Double; Transparent: Boolean; Angle, Alpha: Integer);
var
  Src_ddsd: TDDSurfaceDesc2;
  DestSurface, SrcSurface: TDXR_Surface;
  Blend: TDXR_Blend;
begin
  if Alpha <= 0 then Exit;

  if (Self.Width = 0) or (Self.Height = 0) then Exit;
  if (Width = 0) or (Height = 0) then Exit;
  if Source = nil then Exit;
  if (Source.Width = 0) or (Source.Height = 0) then Exit;

  if dxrDDSurfaceLock(ISurface, DestSurface) then
  begin
    try
      if dxrDDSurfaceLock2(Source.ISurface, Src_ddsd, SrcSurface) then
      begin
        try
          if DestSurface.ColorType = DXR_COLORTYPE_INDEXED then
          begin
            Blend := DXR_BLEND_ONE1;
          end else
            if Alpha >= 255 then
          begin
            Blend := DXR_BLEND_ONE2_SUB_ONE1;
          end else
          begin
            Blend := DXR_BLEND_ONE2_SUB_SRCALPHA1;
          end;

          dxrDrawRotateBlend(DestSurface, SrcSurface,
            X, Y, Width, Height, SrcRect, CenterX, CenterY, Angle, Blend, Alpha,
            Transparent, Src_ddsd.ddckCKSrcBlt.dwColorSpaceLowValue);
        finally
          dxrDDSurfaceUnLock(Source.ISurface, SrcSurface)
        end;
      end;
    finally
      dxrDDSurfaceUnLock(ISurface, DestSurface)
    end;
  end;
end;

procedure TDirectDrawSurface.DrawWaveX(X, Y, Width, Height: Integer; const SrcRect: TRect;
  Source: TDirectDrawSurface; Transparent: Boolean; amp, Len, ph: Integer);
var
  Src_ddsd: TDDSurfaceDesc2;
  DestSurface, SrcSurface: TDXR_Surface;
begin
  if (Self.Width = 0) or (Self.Height = 0) then Exit;
  if (Width = 0) or (Height = 0) then Exit;
  if Source = nil then Exit;
  if (Source.Width = 0) or (Source.Height = 0) then Exit;

  if dxrDDSurfaceLock(ISurface, DestSurface) then
  begin
    try
      if dxrDDSurfaceLock2(Source.ISurface, Src_ddsd, SrcSurface) then
      begin
        try
          dxrDrawWaveXBlend(DestSurface, SrcSurface,
            X, Y, Width, Height, SrcRect, amp, Len, ph, DXR_BLEND_ONE1, 0,
            Transparent, Src_ddsd.ddckCKSrcBlt.dwColorSpaceLowValue);
        finally
          dxrDDSurfaceUnLock(Source.ISurface, SrcSurface)
        end;
      end;
    finally
      dxrDDSurfaceUnLock(ISurface, DestSurface)
    end;
  end;
end;

procedure TDirectDrawSurface.DrawWaveXAdd(X, Y, Width, Height: Integer; const SrcRect: TRect;
  Source: TDirectDrawSurface; Transparent: Boolean; amp, Len, ph, Alpha: Integer);
var
  Src_ddsd: TDDSurfaceDesc2;
  DestSurface, SrcSurface: TDXR_Surface;
  Blend: TDXR_Blend;
begin
  if Alpha <= 0 then Exit;

  if (Self.Width = 0) or (Self.Height = 0) then Exit;
  if (Width = 0) or (Height = 0) then Exit;
  if Source = nil then Exit;
  if (Source.Width = 0) or (Source.Height = 0) then Exit;

  if dxrDDSurfaceLock(ISurface, DestSurface) then
  begin
    try
      if dxrDDSurfaceLock2(Source.ISurface, Src_ddsd, SrcSurface) then
      begin
        try
          if DestSurface.ColorType = DXR_COLORTYPE_INDEXED then
          begin
            Blend := DXR_BLEND_ONE1;
          end else
            if Alpha >= 255 then
          begin
            Blend := DXR_BLEND_ONE1_ADD_ONE2;
          end else
          begin
            Blend := DXR_BLEND_SRCALPHA1_ADD_ONE2;
          end;

          dxrDrawWaveXBlend(DestSurface, SrcSurface,
            X, Y, Width, Height, SrcRect, amp, Len, ph, Blend, Alpha,
            Transparent, Src_ddsd.ddckCKSrcBlt.dwColorSpaceLowValue);
        finally
          dxrDDSurfaceUnLock(Source.ISurface, SrcSurface)
        end;
      end;
    finally
      dxrDDSurfaceUnLock(ISurface, DestSurface)
    end;
  end;
end;

procedure TDirectDrawSurface.DrawWaveXAlpha(X, Y, Width, Height: Integer; const SrcRect: TRect;
  Source: TDirectDrawSurface; Transparent: Boolean; amp, Len, ph, Alpha: Integer);
var
  Src_ddsd: TDDSurfaceDesc2;
  DestSurface, SrcSurface: TDXR_Surface;
  Blend: TDXR_Blend;
begin
  if Alpha <= 0 then Exit;

  if (Self.Width = 0) or (Self.Height = 0) then Exit;
  if (Width = 0) or (Height = 0) then Exit;
  if Source = nil then Exit;
  if (Source.Width = 0) or (Source.Height = 0) then Exit;

  if dxrDDSurfaceLock(ISurface, DestSurface) then
  begin
    try
      if dxrDDSurfaceLock2(Source.ISurface, Src_ddsd, SrcSurface) then
      begin
        try
          if DestSurface.ColorType = DXR_COLORTYPE_INDEXED then
          begin
            Blend := DXR_BLEND_ONE1;
          end else
            if Alpha >= 255 then
          begin
            Blend := DXR_BLEND_ONE1;
          end else
          begin
            Blend := DXR_BLEND_SRCALPHA1_ADD_INVSRCALPHA2;
          end;

          dxrDrawWaveXBlend(DestSurface, SrcSurface,
            X, Y, Width, Height, SrcRect, amp, Len, ph, Blend, Alpha,
            Transparent, Src_ddsd.ddckCKSrcBlt.dwColorSpaceLowValue);
        finally
          dxrDDSurfaceUnLock(Source.ISurface, SrcSurface)
        end;
      end;
    finally
      dxrDDSurfaceUnLock(ISurface, DestSurface)
    end;
  end;
end;

procedure TDirectDrawSurface.DrawWaveXSub(X, Y, Width, Height: Integer; const SrcRect: TRect;
  Source: TDirectDrawSurface; Transparent: Boolean; amp, Len, ph, Alpha: Integer);
var
  Src_ddsd: TDDSurfaceDesc2;
  DestSurface, SrcSurface: TDXR_Surface;
  Blend: TDXR_Blend;
begin
  if Alpha <= 0 then Exit;

  if (Self.Width = 0) or (Self.Height = 0) then Exit;
  if (Width = 0) or (Height = 0) then Exit;
  if Source = nil then Exit;
  if (Source.Width = 0) or (Source.Height = 0) then Exit;

  if dxrDDSurfaceLock(ISurface, DestSurface) then
  begin
    try
      if dxrDDSurfaceLock2(Source.ISurface, Src_ddsd, SrcSurface) then
      begin
        try
          if DestSurface.ColorType = DXR_COLORTYPE_INDEXED then
          begin
            Blend := DXR_BLEND_ONE1;
          end else
            if Alpha >= 255 then
          begin
            Blend := DXR_BLEND_ONE2_SUB_ONE1;
          end else
          begin
            Blend := DXR_BLEND_ONE2_SUB_SRCALPHA1;
          end;

          dxrDrawWaveXBlend(DestSurface, SrcSurface,
            X, Y, Width, Height, SrcRect, amp, Len, ph, Blend, Alpha,
            Transparent, Src_ddsd.ddckCKSrcBlt.dwColorSpaceLowValue);
        finally
          dxrDDSurfaceUnLock(Source.ISurface, SrcSurface)
        end;
      end;
    finally
      dxrDDSurfaceUnLock(ISurface, DestSurface)
    end;
  end;
end;

function TDirectDrawSurface.GetPixel16(X, Y: Integer): Word;
var
  ddsd: TDDSurfaceDesc2;
begin
  Result := 0;
  if (IDDSurface <> nil) and (X >= 0) and (X < Width) and (Y >= 0) and (Y < Height) then begin
    if Lock(PRect(nil)^, ddsd) then begin
      try
        Result := PWord(Integer(ddsd.lpSurface) + Y * ddsd.lPitch + X * 2)^;
      finally
        UnLock;
      end;
    end;
  end;
end;

procedure TDirectDrawSurface.SetPixel16(X, Y: Integer; Value: Word);
var
  ddsd: TDDSurfaceDesc2;
  P: PByte;
begin
  if (IDDSurface <> nil) and (X >= 0) and (X < Width) and (Y >= 0) and (Y < Height) then begin
    if Lock(PRect(nil)^, ddsd) then begin
      try
        PWord(Integer(ddsd.lpSurface) + Y * ddsd.lPitch + X * 2)^ := Value;
      finally
        UnLock;
      end;
    end;
  end;
end;

procedure TDirectDrawSurface.FastDrawAlpha(const Dest, Src: TRect; Source: TDirectDrawSurface; TRANSPARENT: Boolean = True);
var
  DestRect, SrcRect: TRect;
  pSrc, pDst: PByte;
  nWidth: Integer;
  nHeight: Integer;
  j, k, L: Integer;
  nX, nY: Integer;
  nCol64: Int64;
  wColor: Word;
  Mask: Int64;
  wSP, wDP: Word;
  nSPitch, nDPitch: Integer;
  r, G, b: byte;
  nSLeft: Integer;
  nDLeft: Integer;

  nMMXM: Integer;
  nSSEM: Integer;
  nMMXW: Integer;
  nSSEW: Integer;
  SouDDSD,DstDDSD: TDDSurfaceDesc2;
begin
  SouDDSD.dwSize := SizeOf(SouDDSD);
  DstDDSD.dwSize := SizeOf(DstDDSD);
  Source.Lock(TRect(nil^), SouDDSD);
  Lock(TRect(nil^), DstDDSD);
  try
    if Source <> nil then begin
      DestRect := Dest;
      SrcRect := Src;
      nSPitch := SouDDSD.lPitch;
      nDPitch := DstDDSD.lPitch;
      if ClipRect2(DestRect, SrcRect, ClientRect, Source.ClientRect) then begin
        Mask := $7BEF7BEF7BEF7BEF;
        nWidth := SrcRect.Right - SrcRect.Left;
        nHeight := SrcRect.Bottom - SrcRect.Top;
        if TRANSPARENT then begin
          wColor := 0;//RGB16(Source.TransparentColor);
          nCol64 := Bit16To64(wColor);
          nSLeft := SrcRect.Left * 2;
          nDLeft := DestRect.Left * 2;
          k := nWidth mod 4;

          if IsSSE then begin
            nSSEM := nWidth mod 8;
            nSSEW := nWidth div 8;
          end else begin
            nSSEM := 0;
            nSSEW := 0;
          end;

          if nSSEW > 0 then begin
            nMMXM := nSSEM mod 4;
            nMMXW := nSSEM div 4;
          end else begin
            nMMXM := nWidth mod 4;
            nMMXW := nWidth div 4;
          end;

          for nY := 0 to nHeight - 1 do begin
            pSrc := PByte(Integer(SouDDSD.lpSurface) + (SrcRect.Top + nY) * SouDDSD.lPitch + nSLeft);
            pDst := PByte(Integer(DstDDSD.lpSurface) + (DestRect.Top + nY) * DstDDSD.lPitch + nDLeft);
            k := nWidth;

            if IsSSE then begin
              for nX := 0 to nSSEW - 1 do begin
                asm
                 mov ecx, pDst
                 mov eax, pSrc

                 movlps xmm6, nCol64
                 movhps xmm6, nCol64
                 movlps xmm7, mask
                 movhps xmm7, mask

                 movdqu xmm0, [eax]
                 movdqu xmm1, [ecx]
                 movdqu xmm5, xmm0
                 movdqu xmm2, xmm1
                 pcmpeqw xmm5, xmm6	// xmm5为透明掩码
                 psrlq xmm2, 1
                 psrlq xmm0, 1
                 pand xmm2, xmm7
                 pand xmm0, xmm7
                 paddw xmm2, xmm0		// xmm2为混合结果
                 pand xmm1, xmm5		// 目的数据非透明点置0
                 psubusw xmm2, xmm5	// 混合结果透明点置0
                 por xmm1, xmm2		// 相或得最终结果
                 movdqu [ecx], xmm1

                 add eax, 16
                 add ecx, 16
                 sub k, 8
                 mov integer ptr[pSrc],eax
                 mov integer ptr[pDst],ecx
                end;
              end;
            end;

            for nX := 0 to nMMXW - 1 do begin
              asm
                 mov ecx, pDst
                 mov eax, pSrc
                 movq mm6, nCol64
                 movq mm7, mask
                 movlps xmm6, nCol64
                 movhps xmm6, nCol64
                 movlps xmm7, mask
                 movhps xmm7, mask
                 movd   edx, mm6

                 cmp [eax], edx
                 jnz @notequal
                 cmp [eax+4], edx
                 jnz @notequal
                 jmp @finishone
              @notequal:
                 movq mm0, [eax]
                 movq mm1, [ecx]
                 movq mm5, mm0
                 movq mm2, mm1
                 pcmpeqw mm5, mm6	// mm5为透明掩码
                 psrlq mm2, 1
                 psrlq mm0, 1
                 pand mm2, mm7
                 pand mm0, mm7
                 paddw mm2, mm0		// mm2为混合结果
                 pand mm1, mm5		// 目的数据非透明点置0
                 psubusw mm2, mm5	// 混合结果透明点置0
                 por mm1, mm2		// 相或得最终结果
                 movq [ecx], mm1
              @finishone:
                 add eax, 8
                 add ecx, 8
                 sub k,   4
                 mov integer ptr[pSrc],eax
                 mov integer ptr[pDst],ecx
              end;
            end;

            asm
               emms
            end;

            for nX := 0 to k - 1 do begin //剩余处理
              if wColor <> PWord(pSrc)^ then begin
                wSP := PWord(pSrc)^ shr 1 and $7BEF;
                wDP := PWord(pDst)^ shr 1 and $7BEF;
                r := (wSP shr 11) + (wDP shr 11);
                G := (wSP shr 5 and $3F) + (wDP shr 5 and $3F);
                b := (wSP and $1F) + (wDP and $1F);
                PWord(pDst)^ := (r shl 11) or (G shl 5) or b;
              end;
              Inc(pSrc, 2);
              Inc(pDst, 2);
            end;
          end;
        end else begin
          nSLeft := SrcRect.Left * 2;
          nDLeft := DestRect.Left * 2;
          k := nWidth mod 4;

          if IsSSE then begin
            nSSEM := nWidth mod 8;
            nSSEW := nWidth div 8;
          end else begin
            nSSEM := 0;
            nSSEW := 0;
          end;

          if nSSEW > 0 then begin
            nMMXM := nSSEM mod 4;
            nMMXW := nSSEM div 4;
          end else begin
            nMMXM := nWidth mod 4;
            nMMXW := nWidth div 4;
          end;

          for nY := 0 to nHeight - 1 do begin
            pSrc := PByte(Integer(SouDDSD.lpSurface) + (SrcRect.Top + nY) * SouDDSD.lPitch + nSLeft);
            pDst := PByte(Integer(DstDDSD.lpSurface) + (DestRect.Top + nY) * DstDDSD.lPitch + nDLeft);
            k := nWidth;
            if IsSSE then begin
              for nX := 0 to nSSEW - 1 do begin
                asm
                 mov edx, pDst		// edi = 目的指针
                 mov ecx, pSrc		// esi = 源指针
                 movlps xmm7, mask
                 movhps xmm7, mask

                 movdqu xmm0, [ecx]		// 取源数据到mm0
                 movdqu xmm1, [edx]		// 取目的数据到mm1
                 psrlq xmm0, 1		// src? = 0rrrrrggggggbbbb
                 psrlq xmm1, 1		// dst? = 0rrrrrggggggbbbb
                 pand xmm0, xmm7		// src? = 0rrrr0ggggg0bbbb
                 pand xmm1, xmm7		// dst? = 0rrrr0ggggg0bbbb
                 paddw xmm0, xmm1		// result? = rrrrrggggggbbbbb
                 add ecx, 16
                 movdqu [edx], xmm0		// 写回目的地址
                 add edx, 16
                 sub k, 8
                 mov integer ptr[pSrc],ecx
                 mov integer ptr[pDst],edx
                end;
              end;
            end;

            for nX := 0 to nMMXW - 1 do begin
              asm
                 mov edx, pDst		// edi = 目的指针
                 mov ecx, pSrc		// esi = 源指针
                 movq mm7, mask		// 64位掩码
                 movq mm0, [ecx]		// 取源数据到mm0
                 movq mm1, [edx]		// 取目的数据到mm1
                 psrlq mm0, 1		// src? = 0rrrrrggggggbbbb
                 psrlq mm1, 1		// dst? = 0rrrrrggggggbbbb
                 pand mm0, mm7		// src? = 0rrrr0ggggg0bbbb
                 pand mm1, mm7		// dst? = 0rrrr0ggggg0bbbb
                 paddw mm0, mm1		// result? = rrrrrggggggbbbbb
                 add ecx, 8
                 movq [edx], mm0		// 写回目的地址
                 add edx, 8
                 sub k, 4
                 mov integer ptr[pSrc],ecx
                 mov integer ptr[pDst],edx
              end;
            end;

            asm
               emms
            end;

            for nX := 0 to k - 1 do begin //剩余处理
              wSP := PWord(pSrc)^ shr 1 and $7BEF;
              wDP := PWord(pDst)^ shr 1 and $7BEF;
              r := (wSP shr 11) + (wDP shr 11);
              G := (wSP shr 5 and $3F) + (wDP shr 5 and $3F);
              b := (wSP and $1F) + (wDP and $1F);
              PWord(pDst)^ := (r shl 11) or (G shl 5) or b;

              Inc(pSrc, 2);
              Inc(pDst, 2);
            end;
          end;
   // 算法: 将颜色值全部右移一位, 再与掩码做且运算, 则三色分量均除以2
   // 源数据和目的数据均做上述操作, 再相加即实现半透明
        end;
      end;
    end;
  finally
    Source.UnLock();
    UnLock();
  end;
end;

procedure TDirectDrawSurface.FastDrawAlpha(const Dest, Src: TRect; Source: TDirectDrawSurface; TRANSPARENT: Boolean; Alpha: Integer);
var
  DestRect, SrcRect: TRect;
  nX, nY, j, k, L: Integer;
  pSrc, pDst: PByte;
  nWidth: Integer;
  nHeight: Integer;
  nCol64: Int64;
  wColor: Word;
  nAlpha64: Int64;
  nSLeft: Integer;
  nDLeft: Integer;
  r, G, b, dr, dg, db: byte;

  nMMXM: Integer;
  nSSEM: Integer;
  nMMXW: Integer;
  nSSEW: Integer;
  SouDDSD,DstDDSD: TDDSurfaceDesc2;
begin
if Alpha > 256 then Alpha := 256;
  SouDDSD.dwSize := SizeOf(SouDDSD);
  DstDDSD.dwSize := SizeOf(DstDDSD);
  Source.Lock(TRect(nil^), SouDDSD);
  Lock(TRect(nil^), DstDDSD);
  try
    if Source <> nil then begin
      DestRect := Dest;
      SrcRect := Src;
      if ClipRect2(DestRect, SrcRect, ClientRect, Source.ClientRect) then begin
        if (Alpha >= 0) and (Alpha <= 256) then begin
          wColor := 0;//RGB16(Source.TransparentColor);
          nCol64 := Bit16To64(wColor);
          nAlpha64 := Bit16To64(Alpha shr 3);
          nWidth := SrcRect.Right - SrcRect.Left;
          nHeight := SrcRect.Bottom - SrcRect.Top;

          if TRANSPARENT then begin
            k := nWidth mod 4;
            nSLeft := SrcRect.Left * 2;
            nDLeft := DestRect.Left * 2;

            if IsSSE then begin
              nSSEM := nWidth mod 8;
              nSSEW := nWidth div 8;
            end else begin
              nSSEM := 0;
              nSSEW := 0;
            end;

            if nSSEW > 0 then begin
              nMMXM := nSSEM mod 4;
              nMMXW := nSSEM div 4;
            end else begin
              nMMXM := nWidth mod 4;
              nMMXW := nWidth div 4;
            end;

            for nY := 0 to nHeight - 1 do begin
              pSrc := PByte(Integer(SouDDSD.lpSurface) + (SrcRect.Top + nY) * SouDDSD.lPitch + nSLeft);
              pDst := PByte(Integer(DstDDSD.lpSurface) + (DestRect.Top + nY) * DstDDSD.lPitch + nDLeft);
              k := nWidth;

              if IsSSE then begin
                for nX := 0 to nSSEW - 1 do begin
                  asm
                     mov edx, pDst		// edx = 目的指针
                     mov ecx, pSrc		// ecx = 源指针
                     movlps xmm1, nCol64
                     movhps xmm1, nCol64

                   {  movd eax, xmm1
                     cmp [ecx], eax
                     jnz @notequal_sse
                     cmp [ecx+8], eax
                     jnz @notequal_sse
                     jmp @finishone_sse   }

               //  @notequal_sse:
                     movdqu xmm3, [edx]
                     movdqu xmm0, [ecx]
                     movlps xmm7, nAlpha64
                     movhps xmm7, nAlpha64
                     pcmpeqw xmm1, xmm0
                     psubusw xmm7, xmm1
                     // 调用Alpha混合
                     {$include SSE.inc}
                     movdqu [edx], xmm0
                 //@finishone_sse:
                     add ecx, 16
                     add edx, 16
                     sub k, 8
                     mov integer ptr[pSrc],ecx
                     mov integer ptr[pDst],edx
                  end;
                end;
              end;

              for nX := 0 to nMMXW - 1 do begin
                asm
                   mov edx, pDst		// edx = 目的指针
                   mov ecx, pSrc		// ecx = 源指针
                   movq mm1, nCol64
                   movd eax, mm1
                   cmp [ecx], eax
                   jnz @notequal
                   cmp[ecx + 4], eax
                   jnz @notequal
                   jmp @finishone
               @notequal:
                   movq mm3, [edx]
                   movq mm0, [ecx]
                   movq mm7, nAlpha64
                   pcmpeqw mm1, mm0
                   psubusw mm7, mm1
                   {$INCLUDE MMX.inc}
                   movq[edx], mm0
               @finishone:
                   add ecx, 8
                   add edx, 8
                   sub k, 4
                   mov integer ptr[pSrc],ecx
                   mov integer ptr[pDst],edx
                end;
              end;

              asm
                 emms
              end;

              for nX := 0 to k - 1 do begin //剩余处理
                if PWord(pSrc)^ <> wColor then begin
                  r := PWord(pSrc)^ and $F800 shr 8;
                  G := PWord(pSrc)^ and $07E0 shr 3;
                  b := PWord(pSrc)^ and $001F shl 3;

                  dr := PWord(pDst)^ and $F800 shr 8;
                  dg := PWord(pDst)^ and $07E0 shr 3;
                  db := PWord(pDst)^ and $001F shl 3;

                  r := (r * (Alpha) + dr * (256 - Alpha)) shr 8;
                  G := (G * (Alpha) + dg * (256 - Alpha)) shr 8;
                  b := (b * (Alpha) + db * (256 - Alpha)) shr 8;

                  PWord(pDst)^ := (r shl 8 and $F800) or (G shl 3 and $07E0) or (b shr 3 and $001F);
                end;
                Inc(pSrc, 2);
                Inc(pDst, 2);
              end;
            end;

          end else begin
            nSLeft := SrcRect.Left * 2;
            nDLeft := DestRect.Left * 2;
            k := nWidth mod 4;

            if IsSSE then begin
              nSSEM := nWidth mod 8;
              nSSEW := nWidth div 8;
            end else begin
              nSSEM := 0;
              nSSEW := 0;
            end;

            if nSSEW > 0 then begin
              nMMXM := nSSEM mod 4;
              nMMXW := nSSEM div 4;
            end else begin
              nMMXM := nWidth mod 4;
              nMMXW := nWidth div 4;
            end;

            for nY := 0 to nHeight - 1 do begin
              pSrc := PByte(Integer(SouDDSD.lpSurface) + (SrcRect.Top + nY) * SouDDSD.lPitch + nSLeft);
              pDst := PByte(Integer(DstDDSD.lpSurface) + (DestRect.Top + nY) * DstDDSD.lPitch + nDLeft);
              k := nWidth;

              if IsSSE then begin
                for nX := 0 to nSSEW - 1 do begin
                  asm
                    mov edx, pDst		// edi = 目的指针
                    mov ecx, pSrc		// esi = 源指针

                    movlps xmm7, nAlpha64
                    movhps xmm7, nAlpha64

                    movdqu xmm3, [edx]
                    movdqu xmm0, [ecx]

                    {$include SSE.inc}

                    add ecx, 16
                    movdqu [edx], xmm0
                    add edx, 16
                    sub k, 8
                    mov integer ptr[pSrc],ecx
                    mov integer ptr[pDst],edx
                  end;
                end;
              end;

              for nX := 0 to nMMXW - 1 do begin
                asm
                  mov edx, pDst		// edi = 目的指针
                  mov ecx, pSrc		// esi = 源指针

                  movq mm7, nAlpha64		// 透明度
                  movq mm3, [edx]
                  movq mm0, [ecx]

                  {$include MMX.inc}

                  add ecx, 8
                  movq [edx], mm0
                  add edx, 8
                  sub k, 4
                  mov integer ptr[pSrc],ecx
                  mov integer ptr[pDst],edx
                end;
              end;

              asm
                 emms
              end;

              for nX := 0 to k - 1 do begin //剩余处理
                r := PWord(pSrc)^ and $F800 shr 8;
                G := PWord(pSrc)^ and $07E0 shr 3;
                b := PWord(pSrc)^ and $001F shl 3;

                dr := PWord(pDst)^ and $F800 shr 8;
                dg := PWord(pDst)^ and $07E0 shr 3;
                db := PWord(pDst)^ and $001F shl 3;

                r := (r * (Alpha) + dr * (256 - Alpha)) shr 8;
                G := (G * (Alpha) + dg * (256 - Alpha)) shr 8;
                b := (b * (Alpha) + db * (256 - Alpha)) shr 8;

                PWord(pDst)^ := (r shl 8 and $F800) or (G shl 3 and $07E0) or (b shr 3 and $001F);

                Inc(pSrc, 2);
                Inc(pDst, 2);
              end;
            end;

          end;
        end else begin
          Draw(DestRect.Left, DestRect.Top, SrcRect, Source, TRANSPARENT);
        end;
      end;
    end;
  finally
    Source.UnLock();
    UnLock();
  end;
end;

procedure TDirectDrawSurface.Fill(DevColor: Longint);
var
  DBltEx: TDDBltFX;
begin
  DBltEx.dwSize := SizeOf(DBltEx);
  DBltEx.dwFillColor := DevColor;
  Blt(TRect(nil^), TRect(nil^), DDBLT_COLORFILL or DDBLT_WAIT, DBltEx, nil);
end;

procedure TDirectDrawSurface.FastFill(DevColor: TColor);
var
  pDst: PByte;
  nX, nY, k: Integer;
  nWidth: Integer;
  nHeight: Integer;

  maskkey: Int64;
  wColor: Word;

  nMMXM: Integer;
  nSSEM: Integer;
  nMMXW: Integer;
  nSSEW: Integer;
  SouDDSD,DstDDSD: TDDSurfaceDesc2;
begin
  DstDDSD.dwSize := SizeOf(DstDDSD);
  Lock(TRect(nil^), DstDDSD);
  try
    pDst := PByte(Integer(DstDDSD.lpSurface));
    nWidth := Width;
    nHeight := Height;
    wColor := RGB16(DevColor);
    maskkey := Bit16To64(wColor);

    k := nWidth mod 4;

    if IsSSE then begin
      nSSEM := nWidth mod 8;
      nSSEW := nWidth div 8;
    end else begin
      nSSEM := 0;
      nSSEW := 0;
    end;

    if nSSEW > 0 then begin
      nMMXM := nSSEM mod 4;
      nMMXW := nSSEM div 4;
    end else begin
      nMMXM := nWidth mod 4;
      nMMXW := nWidth div 4;
    end;

    for nY := 0 to nHeight - 1 do begin
      pDst := PByte(Integer(DstDDSD.lpSurface) + nY * DstDDSD.lPitch);
      k := nWidth;

      if IsSSE then begin
        for nX := 0 to nSSEW - 1 do begin
          asm
             mov     edx,  pDst		// edx = 目的指针
             movlps xmm0, maskkey
             movhps xmm0, maskkey
             movdqu  [edx],xmm0		// 直接写入目的地址
             add     edx,  16
             sub     k,   8
             mov     integer ptr[pDst], edx
          end;
        end;
      end;

      for nX := 0 to nMMXW - 1 do begin
        asm
             mov     edx,  pDst		// edx = 目的指针
             movq    mm0,  maskkey		// 从源地址取4象素数据
             movq    [edx],mm0		// 直接写入目的地址
             add     edx,  8
             sub     k,   4
             mov     integer ptr[pDst], edx
        end;
      end;

      asm
         emms
      end;

      for nX := 0 to k - 1 do begin //剩余处理
        PWord(pDst)^ := wColor;
        Inc(pDst, 2);
      end;
    end;
  finally
    UnLock();
  end;
end;

procedure TDirectDrawSurface.FastFillRect(const Rect: TRect; DevColor: TColor);
var
  DestRect: TRect;
  pDst: PByte;
  nX, nY, k: Integer;
  nWidth: Integer;
  nHeight: Integer;
  nLeft: Integer;
  maskkey: Int64;
  wColor: Word;

  nMMXM: Integer;
  nSSEM: Integer;
  nMMXW: Integer;
  nSSEW: Integer;
  SouDDSD,DstDDSD: TDDSurfaceDesc2;
begin
  DstDDSD.dwSize := SizeOf(DstDDSD);
  Lock(TRect(nil^), DstDDSD);
  try
    DestRect := Rect;
    if ClipRect(DestRect, ClientRect) then begin
      pDst := PByte(Integer(DstDDSD.lpSurface) + DstDDSD.lPitch * DestRect.Top + DestRect.Left * 2);
      nWidth := DestRect.Right - DestRect.Left;
      nHeight := DestRect.Bottom - DestRect.Top;
      wColor := RGB16(DevColor);
      maskkey := Bit16To64(wColor);
      nLeft := DestRect.Left * 2;
      k := nWidth mod 4;

      if IsSSE then begin
        nSSEM := nWidth mod 8;
        nSSEW := nWidth div 8;
      end else begin
        nSSEM := 0;
        nSSEW := 0;
      end;

      if nSSEW > 0 then begin
        nMMXM := nSSEM mod 4;
        nMMXW := nSSEM div 4;
      end else begin
        nMMXM := nWidth mod 4;
        nMMXW := nWidth div 4;
      end;

      for nY := 0 to nHeight - 1 do begin
        pDst := PByte(Integer(DstDDSD.lpSurface) + (DestRect.Top + nY) * DstDDSD.lPitch + nLeft);
        k := nWidth;

        if IsSSE then begin
          for nX := 0 to nSSEW - 1 do begin
            asm
               mov     edx,  pDst		// edx = 目的指针
               movlps xmm0, maskkey
               movhps xmm0, maskkey
               movdqu  [edx],xmm0		// 直接写入目的地址
               add     edx,  16
               sub     k,   8
               mov     integer ptr[pDst], edx
            end;
          end;
        end;

        for nX := 0 to nMMXW - 1 do begin
          asm
             mov     edx,  pDst		// edx = 目的指针
             movq    mm0,  maskkey		// 从源地址取4象素数据
             movq    [edx],mm0		// 直接写入目的地址
             add     edx,  8
             sub     k,   4
             mov     integer ptr[pDst], edx
          end;
        end;

        asm
           emms
        end;

        for nX := 0 to k - 1 do begin //剩余处理
          PWord(pDst)^ := wColor;
          Inc(pDst, 2);
        end;
      end;
    end;
  finally
    UnLock();
  end;
end;

procedure TDirectDrawSurface.FastFillRectAlpha(const Rect: TRect; Color: TColor; Alpha: Integer);
var
  DestRect: TRect;
  nX, nY: Integer;
  pSrc, pDst: PByte;
  nWidth: Integer;
  nHeight: Integer;
  nLeft: Integer;
  nCol64: Int64;
  nAlpha64: Int64;
  wColor: Word;
  j, k, L: Integer;
  r, G, b, dr, dg, db: byte;
  nMMXM: Integer;
  nSSEM: Integer;
  nMMXW: Integer;
  nSSEW: Integer;
  SouDDSD,DstDDSD: TDDSurfaceDesc2;
begin
  DstDDSD.dwSize := SizeOf(DstDDSD);
  Lock(TRect(nil^), DstDDSD);
  try
    DestRect := Rect;
    if ClipRect(DestRect, ClientRect) then begin
      if (Alpha < 0) or (Alpha > 256) then begin
        FastFillRect(Rect, Color);
      end else begin
        wColor := RGB16(Color);
        nCol64 := Bit16To64(wColor);
        nAlpha64 := Bit16To64(Alpha shr 3);
        nWidth := DestRect.Right - DestRect.Left;
        nHeight := DestRect.Bottom - DestRect.Top;
        pSrc := PByte(@nCol64);
        k := nWidth mod 4;
        nLeft := DestRect.Left * 2;

        if IsSSE then begin
          nSSEM := nWidth mod 8;
          nSSEW := nWidth div 8;
        end else begin
          nSSEM := 0;
          nSSEW := 0;
        end;

        if nSSEW > 0 then begin
          nMMXM := nSSEM mod 4;
          nMMXW := nSSEM div 4;
        end else begin
          nMMXM := nWidth mod 4;
          nMMXW := nWidth div 4;
        end;

        for nY := 0 to nHeight - 1 do begin
          pDst := PByte(Integer(DstDDSD.lpSurface) + (DestRect.Top + nY) * DstDDSD.lPitch + nLeft);
          k := nWidth;

          if IsSSE then begin
            for nX := 0 to nSSEW - 1 do begin
              asm
                 mov edx, pDst		// edi = 目的指针
                 mov ecx, pSrc		// esi = 源指针
                 movlps xmm7, nAlpha64
                 movhps xmm7, nAlpha64
                 movlps xmm0, nCol64
                 movhps xmm0, nCol64
                 movdqu xmm3, [edx]

                 {$include SSE.inc}

                 movdqu[edx], xmm0
                 add edx, 16
                 sub k, 8
                 mov Integer ptr[pDst], edx
              end;
            end;
          end;

          for nX := 0 to nMMXW - 1 do begin
            asm
               mov edx, pDst		// edi = 目的指针
               mov ecx, pSrc		// esi = 源指针
               movq mm7, nAlpha64		// 透明度
               movq mm3, [edx]
               movq mm0, [ecx]

               {$INCLUDE MMX.inc}

               movq[edx], mm0
               add edx, 8
               sub k, 4
               mov Integer ptr[pDst], edx
            end;
          end;

          asm
             emms
          end;

          for nX := 0 to k - 1 do begin //剩余处理
            r := wColor and $F800 shr 8;
            G := wColor and $07E0 shr 3;
            b := wColor and $001F shl 3;

            dr := PWord(pDst)^ and $F800 shr 8;
            dg := PWord(pDst)^ and $07E0 shr 3;
            db := PWord(pDst)^ and $001F shl 3;

            r := (r * (Alpha) + dr * (256 - Alpha)) shr 8;
            G := (G * (Alpha) + dg * (256 - Alpha)) shr 8;
            b := (b * (Alpha) + db * (256 - Alpha)) shr 8;

            PWord(pDst)^ := (r shl 8 and $F800) or (G shl 3 and $07E0) or (b shr 3 and $001F);

            Inc(pDst, 2);
          end;
        end;
      end;
    end;
  finally
    UnLock();
  end;
end;

procedure TDirectDrawSurface.FastFrameRect(const Rect: TRect; DevColor: TColor);
var
  DestRect: TRect;
  DRect: TRect;
begin
  DestRect := Rect;
  if ClipRect(DestRect, ClientRect) then begin
    DRect := DestRect;
    DRect.Bottom := DRect.Top + 1;
    FillRect(DRect, DevColor);

    DRect := DestRect;
    DRect.Top := DRect.Bottom - 1;
    FillRect(DRect, DevColor);

    DRect := DestRect;
    DRect.Right := DRect.Left + 1;
    FillRect(DRect, DevColor);

    DRect := DestRect;
    DRect.Left := DRect.Right - 1;
    FillRect(DRect, DevColor);
  end;
end;

procedure TDirectDrawSurface.FastLine(X1, Y1, X2, Y2: Integer; DevColor: TColor);
var
  d, ax, ay, sx, sy, dx, dy: Integer;
  C: Word;
begin
  C := RGB16(DevColor);
  dx := X2 - X1;
  ax := Abs(dx) shl 1;
  if dx < 0 then
    sx := -1
  else
    sx := 1;
  dy := Y2 - Y1;
  ay := Abs(dy) shl 1;
  if dy < 0 then
    sy := -1
  else
    sy := 1;
  Pixels16[X1, Y1] := C;
  if ax > ay then
  begin
    d := ay - (ax shr 1);
    while X1 <> X2 do
    begin
      if d > -1 then
      begin
        Inc(Y1, sy);
        Dec(d, ax);
      end;
      Inc(X1, sx);
      Inc(d, ay);
      Pixels16[X1, Y1] := C;
    end;
  end
  else
  begin
    d := ax - (ay shr 1);
    while Y1 <> Y2 do
    begin
      if d >= 0 then
      begin
        Inc(X1, sx);
        Dec(d, ay);
      end;
      Inc(Y1, sy);
      Inc(d, ax);
      Pixels16[X1, Y1] := C;
    end;
  end;
end;

procedure TDirectDrawSurface.FillRect(const Rect: TRect; DevColor: Longint);
{var
  DBltEx: TDDBltFX;
  DestRect: TRect;
begin
  DBltEx.dwSize := SizeOf(DBltEx);
  DBltEx.dwFillColor := DevColor;
  DestRect := Rect;
  if ClipRect(DestRect, ClientRect) then
    Blt(DestRect, TRect(nil^), DDBLT_COLORFILL or DDBLT_WAIT, DBltEx, nil);
end; }
// 将32位GDI颜色值转换为COLOR

function RGB16(c: TColor): Word;
begin
  Result := Word((c shl 8 and $F800) or (c shr 5 and $7E0) or (c shr 19 and $1F));
end;

function Bit16To64(Val: Word): Int64;
var
  bit64: Int64;
begin
  bit64 := Val;
  Result := bit64 or (bit64 shl 16) or (bit64 shl 32) or (bit64 shl 48);
end;

var
  DestRect: TRect;
  pDst: PByte;
  nX, nY, k: Integer;
  nWidth: Integer;
  nHeight: Integer;
  nLeft: Integer;
  maskkey: Int64;
  wColor: Word;

  nMMXM: Integer;
  nSSEM: Integer;
  nMMXW: Integer;
  nSSEW: Integer;
  DstDDSD: TDDSurfaceDesc2;
begin
  DestRect := Rect;
  if ClipRect(DestRect, ClientRect) then begin
    DstDDSD.dwSize := SizeOf(DstDDSD);
    Lock(TRect(nil^), DstDDSD);
    try
      pDst := PByte(Integer(DstDDSD.lpSurface) + DstDDSD.lPitch * DestRect.Top + DestRect.Left * 2);
      nWidth := DestRect.Right - DestRect.Left;
      nHeight := DestRect.Bottom - DestRect.Top;
      wColor := RGB16(DevColor);
      maskkey := Bit16To64(wColor);
      nLeft := DestRect.Left * 2;
      k := nWidth mod 4;

      if IsSSE then begin
        nSSEM := nWidth mod 8;
        nSSEW := nWidth div 8;
      end else begin
        nSSEM := 0;
        nSSEW := 0;
      end;

      if nSSEW > 0 then begin
        nMMXM := nSSEM mod 4;
        nMMXW := nSSEM div 4;
      end else begin
        nMMXM := nWidth mod 4;
        nMMXW := nWidth div 4;
      end;

      for nY := 0 to nHeight - 1 do begin
        pDst := PByte(Integer(DstDDSD.lpSurface) + (DestRect.Top + nY) * DstDDSD.lPitch + nLeft);
        k := nWidth;

        if IsSSE then begin
          for nX := 0 to nSSEW - 1 do begin
            asm
             mov     edx,  pDst		// edx = 目的指针
             movlps xmm0, maskkey
             movhps xmm0, maskkey
             movdqu  [edx],xmm0		// 直接写入目的地址
             add     edx,  16
             sub     k,   8
             mov     integer ptr[pDst], edx
            end;
          end;
        end;

        for nX := 0 to nMMXW - 1 do begin
          asm
             mov     edx,  pDst		// edx = 目的指针
             movq    mm0,  maskkey		// 从源地址取4象素数据
             movq    [edx],mm0		// 直接写入目的地址
             add     edx,  8
             sub     k,   4
             mov     integer ptr[pDst], edx
          end;
        end;

        asm
           emms
        end;

        for nX := 0 to k - 1 do begin //剩余处理
          PWord(pDst)^ := wColor;
          Inc(pDst, 2);
        end;
      end;
    finally
      UnLock();
    end;
  end;
end;

procedure TDirectDrawSurface.FillRectAdd(const DestRect: TRect; Color: TColor);
var
  DestSurface: TDXR_Surface;
begin
  if Color and $FFFFFF = 0 then Exit;
  if (Self.Width = 0) or (Self.Height = 0) then Exit;
  if SurfaceDesc.ddpfPixelFormat.dwFlags and (DDPF_PALETTEINDEXED1 or DDPF_PALETTEINDEXED2 or
    DDPF_PALETTEINDEXED4 or DDPF_PALETTEINDEXED8) <> 0 then Exit;

  if dxrDDSurfaceLock(ISurface, DestSurface) then
  begin
    try
      dxrFillRectColorBlend(DestSurface, DestRect, DXR_BLEND_ONE1_ADD_ONE2, ColorToRGB(Color));
    finally
      dxrDDSurfaceUnLock(ISurface, DestSurface)
    end;
  end;
end;

procedure TDirectDrawSurface.FillRectAlpha(const DestRect: TRect; Color: TColor;
  Alpha: Integer);
var
  DestSurface: TDXR_Surface;
begin
  if (Self.Width = 0) or (Self.Height = 0) then Exit;
  if SurfaceDesc.ddpfPixelFormat.dwFlags and (DDPF_PALETTEINDEXED1 or DDPF_PALETTEINDEXED2 or
    DDPF_PALETTEINDEXED4 or DDPF_PALETTEINDEXED8) <> 0 then Exit;

  if dxrDDSurfaceLock(ISurface, DestSurface) then
  begin
    try
      dxrFillRectColorBlend(DestSurface, DestRect, DXR_BLEND_SRCALPHA1_ADD_INVSRCALPHA2, ColorToRGB(Color) or (Byte(Alpha) shl 24));
    finally
      dxrDDSurfaceUnLock(ISurface, DestSurface)
    end;
  end;
end;

procedure TDirectDrawSurface.FillRectSub(const DestRect: TRect; Color: TColor);
var
  DestSurface: TDXR_Surface;
begin
  if Color and $FFFFFF = 0 then Exit;
  if (Self.Width = 0) or (Self.Height = 0) then Exit;
  if SurfaceDesc.ddpfPixelFormat.dwFlags and (DDPF_PALETTEINDEXED1 or DDPF_PALETTEINDEXED2 or
    DDPF_PALETTEINDEXED4 or DDPF_PALETTEINDEXED8) <> 0 then Exit;

  if dxrDDSurfaceLock(ISurface, DestSurface) then
  begin
    try
      dxrFillRectColorBlend(DestSurface, DestRect, DXR_BLEND_ONE2_SUB_ONE1, ColorToRGB(Color));
    finally
      dxrDDSurfaceUnLock(ISurface, DestSurface)
    end;
  end;
end;

function TDirectDrawSurface.GetBitCount: Integer;
begin
  Result := SurfaceDesc.ddpfPixelFormat.dwRGBBitCount;
end;

function TDirectDrawSurface.GetCanvas: TDirectDrawSurfaceCanvas;
begin
  if FCanvas = nil then
    FCanvas := TDirectDrawSurfaceCanvas.Create(Self);
  Result := FCanvas;
end;

function TDirectDrawSurface.GetClientRect: TRect;
begin
  Result := Rect(0, 0, Width, Height);
end;

function TDirectDrawSurface.GetHeight: Integer;
begin
  Result := SurfaceDesc.dwHeight;
end;

type
  PRGB = ^TRGB;
  TRGB = packed record
    R, G, B: Byte;
  end;

function TDirectDrawSurface.GetPixel(X, Y: Integer): Longint;
var
  ddsd: TDDSurfaceDesc2;
begin
  Result := 0;
  if (IDDSurface <> nil) and (X >= 0) and (X < Width) and (Y >= 0) and (Y < Height) then
    if Lock(PRect(nil)^, ddsd) then
    begin
      try
        case ddsd.ddpfPixelFormat.dwRGBBitCount of
          1: Result := Integer(PByte(Integer(ddsd.lpSurface) +
              Y * ddsd.lPitch + (X shr 3))^ and (1 shl (X and 7)) <> 0);
          4: begin
              if X and 1 = 0 then
                Result := PByte(Integer(ddsd.lpSurface) + Y * ddsd.lPitch + (X shr 1))^ shr 4
              else
                Result := PByte(Integer(ddsd.lpSurface) + Y * ddsd.lPitch + (X shr 1))^ and $0F;
            end;
          8: Result := PByte(Integer(ddsd.lpSurface) + Y * ddsd.lPitch + X)^;
          16: Result := PWord(Integer(ddsd.lpSurface) + Y * ddsd.lPitch + X * 2)^;
          24: with PRGB(Integer(ddsd.lpSurface) + Y * ddsd.lPitch + X * 3)^ do
              Result := R or (G shl 8) or (B shl 16);
          32: Result := PInteger(Integer(ddsd.lpSurface) + Y * ddsd.lPitch + X * 4)^;
        end;
      finally
        UnLock;
      end;
    end;
end;

function TDirectDrawSurface.GetWidth: Integer;
begin
  Result := SurfaceDesc.dwWidth;
end;

procedure TDirectDrawSurface.LoadFromDIB(DIB: TDIB);
begin
  LoadFromGraphic(DIB);
end;

procedure TDirectDrawSurface.LoadFromDIBRect(DIB: TDIB; AWidth, AHeight: Integer; const SrcRect: TRect);
begin
  LoadFromGraphicRect(DIB, AWidth, AHeight, SrcRect);
end;

procedure TDirectDrawSurface.LoadFromGraphic(Graphic: TGraphic);
begin
  LoadFromGraphicRect(Graphic, 0, 0, Bounds(0, 0, Graphic.Width, Graphic.Height));
end;

procedure TDirectDrawSurface.LoadFromGraphicRect(Graphic: TGraphic; AWidth, AHeight: Integer; const SrcRect: TRect);
var
  Temp: TDIB;
begin
  if AWidth = 0 then
    AWidth := SrcRect.Right - SrcRect.Left;
  if AHeight = 0 then
    AHeight := SrcRect.Bottom - SrcRect.Top;

  SetSize(AWidth, AHeight);

  with SrcRect do
    if Graphic is TDIB then
    begin
      with Canvas do
      begin
        StretchBlt(Handle, 0, 0, AWidth, AHeight, TDIB(Graphic).Canvas.Handle,
          Left, Top, Right - Left, Bottom - Top, SRCCOPY);
        Release;
      end;
    end else if (Right - Left = AWidth) and (Bottom - Top = AHeight) then
    begin
      with Canvas do
      begin
        Draw(-Left, -Top, Graphic);
        Release;
      end;
    end else
    begin
      Temp := TDIB.Create;
      try
        Temp.SetSize(Right - Left, Bottom - Top, 24);
        Temp.Canvas.Draw(-Left, -Top, Graphic);

        with Canvas do
        begin
          StretchDraw(Bounds(0, 0, AWidth, AHeight), Temp);
          Release;
        end;
      finally
        Temp.Free;
      end;
    end;
end;

procedure TDirectDrawSurface.SaveToFile(const FileName: string);
var
  I: Integer;
  ddsd: TDDSurfaceDesc2;
  DIB: TDIB;
  PSrc, PDset: PByte;
begin
  DIB := TDIB.Create;
  try
    DIB.Width := Width;
    DIB.Height := Height;
    case BitCount of
      8: begin
          DIB.BitCount := 8;
        end;
      16: begin
          DIB.PixelFormat := MakeDIBPixelFormat(5, 6, 5);
          DIB.BitCount := 16;
        end;
      24: begin
          DIB.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
          DIB.BitCount := 24;
        end;
      32: begin
          DIB.PixelFormat := MakeDIBPixelFormat(8, 8, 8);
          DIB.BitCount := 32;
        end;
    end;
    ddsd.dwSize := SizeOf(ddsd);
    Lock(TRect(nil^), ddsd);
    try
      if BitCount = 16 then begin
        if ddsd.ddpfPixelFormat.dwRBitMask <> $F800 then begin
          DIB.PixelFormat := MakeDIBPixelFormat(5, 5, 5);
          DIB.BitCount := 16;
        end;
      end;
      for I := 0 to Height - 1 do begin
        PSrc := PByte(Integer(ddsd.lpSurface) + (Height - 1 - I) * ddsd.lPitch);
        PDset := PByte(Integer(DIB.PBits) + I * Width * (BitCount div 8));
        Move(PSrc^, PDset^, Width * (BitCount div 8));
      end;
    finally
      UnLock();
    end;
    DIB.SaveToFile(FileName);
  finally
    DIB.Free;
  end;
end;

procedure TDirectDrawSurface.LoadFromFile(const FileName: string);
var
  Picture: TPicture;
begin
  Picture := TPicture.Create;
  try
    Picture.LoadFromFile(FileName);
    LoadFromGraphic(Picture.Graphic);
  finally
    Picture.Free;
  end;
end;

procedure TDirectDrawSurface.LoadFromStream(Stream: TStream);
var
  DIB: TDIB;
begin
  DIB := TDIB.Create;
  try
    DIB.LoadFromStream(Stream);
    if DIB.Size > 0 then
      LoadFromGraphic(DIB);
  finally
    DIB.Free;
  end;
end;

function TDirectDrawSurface.Lock(const Rect: TRect; var SurfaceDesc: TDDSurfaceDesc2): Boolean;
begin
  Result := False;
  if IDDSurface = nil then Exit;

  if FLockCount > 0 then Exit;

  FillChar(FLockSurfaceDesc, SizeOf(FLockSurfaceDesc), 0);

  FLockSurfaceDesc.dwSize := SizeOf(FLockSurfaceDesc);

  if (@Rect <> nil) and ((Rect.Left <> 0) or (Rect.Top <> 0) or (Rect.Right <> Width) or (Rect.Bottom <> Height)) then
    DXResult := ISurface.Lock(@Rect, FLockSurfaceDesc, DDLOCK_WAIT, 0)
  else
    DXResult := ISurface.Lock(nil, FLockSurfaceDesc, DDLOCK_WAIT, 0);
  if DXResult <> DD_OK then Exit;

  Inc(FLockCount);
  SurfaceDesc := FLockSurfaceDesc;

  Result := True;
end;

procedure TDirectDrawSurface.UnLock;
begin
  if IDDSurface = nil then Exit;

  if FLockCount > 0 then
  begin
    Dec(FLockCount);
    if FLockCount = 0 then
      DXResult := ISurface.UnLock(FLockSurfaceDesc.lpSurface);
  end;
end;

function TDirectDrawSurface.Restore: Boolean;
begin
  if IDDSurface <> nil then
  begin
    DXResult := ISurface.Restore;
    Result := DXResult = DD_OK;
  end else
    Result := False;
end;

procedure TDirectDrawSurface.SetClipper(Value: TDirectDrawClipper);
begin
  if IDDSurface <> nil then
    DXResult := ISurface.SetClipper(Value.IDDClipper);
  FHasClipper := (Value <> nil) and (DXResult = DD_OK);
end;

procedure TDirectDrawSurface.SetColorKey(Flags: DWORD; const Value: TDDColorKey);
begin
  if IDDSurface <> nil then
    DXResult := ISurface.SetColorKey(Flags, Value);
end;

procedure TDirectDrawSurface.SetPalette(Value: TDirectDrawPalette);
begin
  if IDDSurface <> nil then
    DXResult := ISurface.SetPalette(Value.IDDPalette);
end;

procedure TDirectDrawSurface.SetPixel(X, Y: Integer; Value: Longint);
var
  ddsd: TDDSurfaceDesc2;
  P: PByte;
begin
  if (IDDSurface <> nil) and (X >= 0) and (X < Width) and (Y >= 0) and (Y < Height) then
    if Lock(PRect(nil)^, ddsd) then
    begin
      try
        case ddsd.ddpfPixelFormat.dwRGBBitCount of
          1: begin
              P := PByte(Integer(ddsd.lpSurface) + Y * ddsd.lPitch + (X shr 3));
              if Value = 0 then
                P^ := P^ and (not (1 shl (7 - (X and 7))))
              else
                P^ := P^ or (1 shl (7 - (X and 7)));
            end;
          4: begin
              P := PByte(Integer(ddsd.lpSurface) + Y * ddsd.lPitch + (X shr 1));
              if X and 1 = 0 then
                P^ := (P^ and $0F) or (Value shl 4)
              else
                P^ := (P^ and $F0) or (Value and $0F);
            end;
          8: PByte(Integer(ddsd.lpSurface) + Y * ddsd.lPitch + X)^ := Value;
          16: PWord(Integer(ddsd.lpSurface) + Y * ddsd.lPitch + X * 2)^ := Value;
          24: with PRGB(Integer(ddsd.lpSurface) + Y * ddsd.lPitch + X * 3)^ do
            begin
              R := Byte(Value);
              G := Byte(Value shr 8);
              B := Byte(Value shr 16);
            end;
          32: PInteger(Integer(ddsd.lpSurface) + Y * ddsd.lPitch + X * 4)^ := Value;
        end;
      finally
        UnLock;
      end;
    end;
end;

procedure TDirectDrawSurface.SetSize(AWidth, AHeight: Integer);
var
  ddsd: TDDSurfaceDesc2;
begin
  if (AWidth <= 0) or (AHeight <= 0) then
  begin
    IDDSurface := nil;
    Exit;
  end;
  FillChar(ddsd, SizeOf(ddsd), #0);
  with ddsd do
  begin
    dwSize := SizeOf(ddsd);
    dwFlags := DDSD_CAPS or DDSD_WIDTH or DDSD_HEIGHT;
    ddsCaps.dwCaps := DDSCAPS_OFFSCREENPLAIN;
    if FSystemMemory then
      ddsCaps.dwCaps := ddsCaps.dwCaps or DDSCAPS_SYSTEMMEMORY;
    dwHeight := AHeight;
    dwWidth := AWidth;
  end;

  if CreateSurface(ddsd) then Exit;

  {  When the Surface cannot be made,  making is attempted to the system memory.  }
  if ddsd.ddsCaps.dwCaps and DDSCAPS_SYSTEMMEMORY = 0 then
  begin
    ddsd.ddsCaps.dwCaps := (ddsd.ddsCaps.dwCaps and (not DDSCAPS_VIDEOMEMORY)) or DDSCAPS_SYSTEMMEMORY;
    if CreateSurface(ddsd) then
    begin
      FSystemMemory := True;
      Exit;
    end;
  end;

  raise EDirectDrawSurfaceError.CreateFmt(SCannotMade, [SDirectDrawSurface]);
end;

procedure TDirectDrawSurface.SetTransparentColor(Col: Longint);
var
  ddck: TDDColorKey;
begin
  ddck.dwColorSpaceLowValue := Col;
  ddck.dwColorSpaceHighValue := Col;
  ColorKey[DDCKEY_SRCBLT] := ddck;
end;

{  TDXDrawDisplayMode  }

function TDXDrawDisplayMode.GetBitCount: Integer;
begin
  Result := FSurfaceDesc.ddpfPixelFormat.dwRGBBitCount;
end;

function TDXDrawDisplayMode.GetHeight: Integer;
begin
  Result := FSurfaceDesc.dwHeight;
end;

function TDXDrawDisplayMode.GetWidth: Integer;
begin
  Result := FSurfaceDesc.dwWidth;
end;

{  TDXDrawDisplay  }

constructor TDXDrawDisplay.Create(ADXDraw: TCustomDXDraw);
begin
  inherited Create;
  FDXDraw := ADXDraw;
  FModes := TCollection.Create(TDXDrawDisplayMode);
  FWidth := 640;
  FHeight := 480;
  FBitCount := 8;
  FFixedBitCount := True;
  FFixedRatio := True;
  FFixedSize := False;
end;

destructor TDXDrawDisplay.Destroy;
begin
  FModes.Free;
  inherited Destroy;
end;

procedure TDXDrawDisplay.Assign(Source: TPersistent);
begin
  if Source is TDXDrawDisplay then
  begin
    if Source <> Self then
    begin
      FBitCount := TDXDrawDisplay(Source).BitCount;
      FHeight := TDXDrawDisplay(Source).Height;
      FWidth := TDXDrawDisplay(Source).Width;

      FFixedBitCount := TDXDrawDisplay(Source).FFixedBitCount;
      FFixedRatio := TDXDrawDisplay(Source).FFixedRatio;
      FFixedSize := TDXDrawDisplay(Source).FFixedSize;
    end;
  end else
    inherited Assign(Source);
end;

function TDXDrawDisplay.GetCount: Integer;
begin
  if FModes.Count = 0 then
    LoadDisplayModes;
  Result := FModes.Count;
end;

function TDXDrawDisplay.GetMode: TDXDrawDisplayMode;
var
  I: Integer;
  ddsd: TDDSurfaceDesc2;
begin
  Result := nil;
  if FDXDraw.DDraw <> nil then
  begin
    ddsd := FDXDraw.DDraw.DisplayMode;
    with ddsd do
      I := IndexOf(dwWidth, dwHeight, ddpfPixelFormat.dwRGBBitCount);
    if I <> -1 then
      Result := Modes[I];
  end;
  if Result = nil then
    raise EDirectDrawError.Create(SDisplayModeCannotAcquired);
end;

function TDXDrawDisplay.GetMode2(Index: Integer): TDXDrawDisplayMode;
begin
  if FModes.Count = 0 then
    LoadDisplayModes;
  Result := TDXDrawDisplayMode(FModes.Items[Index]);
end;

function TDXDrawDisplay.IndexOf(Width, Height, BitCount: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if (Modes[I].Width = Width) and (Modes[I].Height = Height) and (Modes[I].BitCount = BitCount) then
    begin
      Result := I;
      Exit;
    end;
end;

procedure TDXDrawDisplay.LoadDisplayModes;

  function EnumDisplayModesProc(const lpTDDSurfaceDesc: TDDSurfaceDesc;
    lpContext: Pointer): HRESULT; stdcall;
  begin
    with TDXDrawDisplayMode.Create(TCollection(lpContext)) do
      FSurfaceDesc := lpTDDSurfaceDesc;
    Result := DDENUMRET_OK;
  end;

  function Compare(Item1, Item2: TDXDrawDisplayMode): Integer;
  begin
    if Item1.Width <> Item2.Width then
      Result := Item1.Width - Item2.Width
    else if Item1.Height <> Item2.Height then
      Result := Item1.Height - Item2.Height
    else
      Result := Item1.BitCount - Item2.BitCount;
  end;

var
  DDraw: TDirectDraw;
  TempList: TList;
  I: Integer;
begin
  FModes.Clear;

  if FDXDraw.DDraw <> nil then
  begin
    FDXDraw.DDraw.DXResult := FDXDraw.DDraw.IDraw.EnumDisplayModes(0, PDDSurfaceDesc2(nil)^,
      FModes, @EnumDisplayModesProc);
  end else
  begin
    DDraw := TDirectDraw.Create(PGUID(FDXDraw.FDriver));
    try
      DDraw.IDraw.EnumDisplayModes(0, PDDSurfaceDesc2(nil)^, FModes, @EnumDisplayModesProc);
    finally
      DDraw.Free;
    end;
  end;

  TempList := TList.Create;
  try
    for I := 0 to FModes.Count - 1 do
      TempList.Add(FModes.Items[I]);
    TempList.Sort(@Compare);

    for I := FModes.Count - 1 downto 0 do
      TDXDrawDisplayMode(TempList[I]).Index := I;
  finally
    TempList.Free;
  end;
end;

function TDXDrawDisplay.SetSize(AWidth, AHeight, ABitCount: Integer): Boolean;
begin
  Result := False;
  if FDXDraw.DDraw <> nil then
  begin
    FDXDraw.DDraw.DXResult := FDXDraw.DDraw.IDraw.SetDisplayMode(AWidth, AHeight, ABitCount, 0, 0);
    Result := FDXDraw.DDraw.DXResult = DD_OK;

    if Result then
    begin
      FWidth := AWidth;
      FHeight := AHeight;
      FBitCount := ABitCount;
    end;
  end;
end;

function TDXDrawDisplay.DynSetSize(AWidth, AHeight, ABitCount: Integer): Boolean;

  function TestBitCount(BitCount, ABitCount: Integer): Boolean;
  begin
    if (BitCount > 8) and (ABitCount > 8) then
    begin
      Result := True;
    end else
    begin
      Result := BitCount >= ABitCount;
    end;
  end;

  function SetSize2(Ratio: Boolean): Boolean;
  var
    DWidth, DHeight, DBitCount, I: Integer;
    Flag: Boolean;
  begin
    Result := False;

    DWidth := MaxInt;
    DHeight := MaxInt;
    DBitCount := ABitCount;

    Flag := False;
    for I := 0 to Count - 1 do
      with Modes[I] do
      begin
        if ((DWidth >= Width) and (DHeight >= Width) and
          ((not Ratio) or (Width / Height = AWidth / AHeight)) and
          ((FFixedSize and (Width = AWidth) and (Height = Height)) or
          ((not FFixedSize) and (Width >= AWidth) and (Height >= AHeight))) and

          ((FFixedBitCount and (BitCount = ABitCount)) or
          ((not FFixedBitCount) and TestBitCount(BitCount, ABitCount)))) then
        begin
          DWidth := Width;
          DHeight := Height;
          DBitCount := BitCount;
          Flag := True;
        end;
      end;

    if Flag then
    begin
      if (DBitCount <> ABitCount) then
      begin
        if IndexOf(DWidth, DHeight, ABitCount) <> -1 then
          DBitCount := ABitCount;
      end;

      Result := SetSize(DWidth, DHeight, DBitCount);
    end;
  end;

begin
  Result := False;

  if (AWidth <= 0) or (AHeight <= 0) or (not (ABitCount in [8, 16, 24, 32])) then Exit;

  {  The change is attempted by the size of default.  }
  if SetSize(AWidth, AHeight, ABitCount) then
  begin
    Result := True;
    Exit;
  end;

  {  The change is attempted by the screen ratio fixation.  }
  if FFixedRatio then
    if SetSize2(True) then
    begin
      Result := True;
      Exit;
    end;

  {  The change is unconditionally attempted.  }
  if SetSize2(False) then
  begin
    Result := True;
    Exit;
  end;
end;

procedure TDXDrawDisplay.SetBitCount(Value: Integer);
begin
  if not (Value in [8, 16, 24, 32]) then
    raise EDirectDrawError.Create(SInvalidDisplayBitCount);
  FBitCount := Value;
end;

procedure TDXDrawDisplay.SetHeight(Value: Integer);
begin
  FHeight := Max(Value, 0);
end;

procedure TDXDrawDisplay.SetWidth(Value: Integer);
begin
  FWidth := Max(Value, 0);
end;

{  TCustomDXDraw  }

function BPPToDDBD(BPP: DWORD): DWORD;
begin
  case BPP of
    1: Result := DDBD_1;
    2: Result := DDBD_2;
    4: Result := DDBD_4;
    8: Result := DDBD_8;
    16: Result := DDBD_16;
    24: Result := DDBD_24;
    32: Result := DDBD_32;
  else
    Result := 0;
  end;
end;


type
  {  TDXDrawDriver  }

  TDXDrawDriver = class
  private
    FDXDraw: TCustomDXDraw;
    constructor Create(ADXDraw: TCustomDXDraw); virtual;
    destructor Destroy; override;
    procedure Finalize; virtual;
    procedure Flip; virtual; abstract;
    procedure Initialize; virtual; abstract;
    function SetSize(AWidth, AHeight: Integer): Boolean; virtual;
    function Restore: Boolean;
  end;

  TDXDrawDriverBlt = class(TDXDrawDriver)
  private
    procedure Flip; override;
    procedure Initialize; override;
    procedure InitializeSurface;
    function SetSize(AWidth, AHeight: Integer): Boolean; override;
  end;

  TDXDrawDriverFlip = class(TDXDrawDriver)
  private
    procedure Flip; override;
    procedure Initialize; override;
  end;

{  TDXDrawDriver  }

constructor TDXDrawDriver.Create(ADXDraw: TCustomDXDraw);
begin
  inherited Create;
  FDXDraw := ADXDraw;

  if FDXDraw.Options * [doFullScreen, doHardware, doSystemMemory] = [doFullScreen, doHardware] then
    FDXDraw.FDDraw := TDirectDraw.CreateEx(PGUID(FDXDraw.FDriver), doDirectX7Mode in FDXDraw.Options)
  else
    FDXDraw.FDDraw := TDirectDraw.CreateEx(nil, doDirectX7Mode in FDXDraw.Options);
end;

destructor TDXDrawDriver.Destroy;
begin
  Finalize;
  FDXDraw.FDDraw.Free;
  inherited Destroy;
end;

procedure TDXDrawDriver.Finalize;
begin
  with FDXDraw do
  begin

    FClipper.Free; FClipper := nil;
    FPalette.Free; FPalette := nil;
    FSurface.Free; FSurface := nil;
    FPrimary.Free; FPrimary := nil;
  end;
end;

function TDXDrawDriver.Restore: Boolean;
begin
  Result := FDXDraw.FPrimary.Restore and FDXDraw.FSurface.Restore;
  if Result then
  begin
    FDXDraw.FPrimary.Fill(0);
    FDXDraw.FSurface.Fill(0);
  end;
end;

function TDXDrawDriver.SetSize(AWidth, AHeight: Integer): Boolean;
begin
  Result := False;
end;

{  TDXDrawDriverBlt  }

function TDXDrawRGBQuadsToPaletteEntries(const RGBQuads: TRGBQuads;
  AllowPalette256: Boolean): TPaletteEntries;
var
  Entries: TPaletteEntries;
  dc: THandle;
  I: Integer;
begin
  Result := RGBQuadsToPaletteEntries(RGBQuads);

  if not AllowPalette256 then
  begin
    dc := GetDC(0);
    GetSystemPaletteEntries(dc, 0, 256, Entries);
    ReleaseDC(0, dc);

    for I := 0 to 9 do
      Result[I] := Entries[I];

    for I := 256 - 10 to 255 do
      Result[I] := Entries[I];
  end;

  for I := 0 to 255 do
    Result[I].peFlags := D3DPAL_READONLY;
end;

procedure TDXDrawDriverBlt.Flip;
var
  pt: TPoint;
  Dest: TRect;
  DF: TDDBltFX;
begin
  pt := FDXDraw.ClientToScreen(Point(0, 0));

  if doStretch in FDXDraw.NowOptions then
  begin
    Dest := Bounds(pt.X, pt.Y, FDXDraw.Width, FDXDraw.Height);
  end else
  begin
    if doCenter in FDXDraw.NowOptions then
    begin
      Inc(pt.X, (FDXDraw.Width - FDXDraw.FSurface.Width) div 2);
      Inc(pt.Y, (FDXDraw.Height - FDXDraw.FSurface.Height) div 2);
    end;

    Dest := Bounds(pt.X, pt.Y, FDXDraw.FSurface.Width, FDXDraw.FSurface.Height);
  end;

  if doWaitVBlank in FDXDraw.NowOptions then
    FDXDraw.FDDraw.DXResult := FDXDraw.FDDraw.IDraw.WaitForVerticalBlank(DDWAITVB_BLOCKBEGIN, 0);

  DF.dwSize := SizeOf(DF);
  DF.dwDDFX := 0;

  FDXDraw.FPrimary.Blt(Dest, FDXDraw.FSurface.ClientRect, DDBLT_WAIT, DF, FDXDraw.FSurface);
end;

procedure TDXDrawDriverBlt.Initialize;
{const
  PrimaryDesc: TDDSurfaceDesc2 = (
    dwSize: SizeOf(PrimaryDesc);
    dwFlags: DDSD_CAPS;
    ddsCaps: (dwCaps: DDSCAPS_PRIMARYSURFACE)
    ); }
var
  PrimaryDesc: TDDSurfaceDesc2;
  Entries: TPaletteEntries;
  PaletteCaps: Integer;
begin
  FillChar(PrimaryDesc, SizeOf(PrimaryDesc), #0);
  PrimaryDesc.dwSize := SizeOf(PrimaryDesc);
  PrimaryDesc.dwFlags := DDSD_CAPS;
  PrimaryDesc.ddsCaps.dwCaps := DDSCAPS_PRIMARYSURFACE;

  {  Surface making  }
  FDXDraw.FPrimary := TDirectDrawSurface.Create(FDXDraw.FDDraw);
  if not FDXDraw.FPrimary.CreateSurface(PrimaryDesc) then
    raise EDXDrawError.CreateFmt(SCannotMade, [SDirectDrawPrimarySurface]);

  FDXDraw.FSurface := TDirectDrawSurface.Create(FDXDraw.FDDraw);

  {  Clipper making  }
  FDXDraw.FClipper := TDirectDrawClipper.Create(FDXDraw.FDDraw);
  FDXDraw.FClipper.Handle := FDXDraw.Handle;
  FDXDraw.FPrimary.Clipper := FDXDraw.FClipper;

  {  Palette making  }
  PaletteCaps := DDPCAPS_8BIT or DDPCAPS_INITIALIZE;
  if doAllowPalette256 in FDXDraw.NowOptions then
    PaletteCaps := PaletteCaps or DDPCAPS_ALLOW256;

  FDXDraw.FPalette := TDirectDrawPalette.Create(FDXDraw.FDDraw);
  Entries := TDXDrawRGBQuadsToPaletteEntries(FDXDraw.ColorTable,
    doAllowPalette256 in FDXDraw.NowOptions);
  FDXDraw.FPalette.CreatePalette(PaletteCaps, Entries);

  FDXDraw.FPrimary.Palette := FDXDraw.Palette;

  InitializeSurface;
end;

procedure TDXDrawDriverBlt.InitializeSurface;
var
  ddsd: TDDSurfaceDesc2;
begin
  FDXDraw.FSurface.IDDSurface := nil;

  {  Surface making  }
  FDXDraw.FNowOptions := FDXDraw.FNowOptions - [doSystemMemory];

  FillChar(ddsd, SizeOf(ddsd), 0);
  with ddsd do
  begin
    dwSize := SizeOf(ddsd);
    dwFlags := DDSD_WIDTH or DDSD_HEIGHT or DDSD_CAPS;
    dwWidth := Max(FDXDraw.FSurfaceWidth, 1);
    dwHeight := Max(FDXDraw.FSurfaceHeight, 1);
    ddsCaps.dwCaps := DDSCAPS_OFFSCREENPLAIN;
    if doSystemMemory in FDXDraw.Options then
      ddsCaps.dwCaps := ddsCaps.dwCaps or DDSCAPS_SYSTEMMEMORY;
    if do3D in FDXDraw.FNowOptions then
      ddsCaps.dwCaps := ddsCaps.dwCaps or DDSCAPS_3DDEVICE;
  end;

  if not FDXDraw.FSurface.CreateSurface(ddsd) then
  begin
    ddsd.ddsCaps.dwCaps := ddsd.ddsCaps.dwCaps or DDSCAPS_SYSTEMMEMORY;
    if not FDXDraw.FSurface.CreateSurface(ddsd) then
      raise EDXDrawError.CreateFmt(SCannotMade, [SDirectDrawSurface]);
  end;

  if FDXDraw.FSurface.SurfaceDesc.ddsCaps.dwCaps and DDSCAPS_VIDEOMEMORY = 0 then
    FDXDraw.FNowOptions := FDXDraw.FNowOptions + [doSystemMemory];

  FDXDraw.FSurface.Palette := FDXDraw.Palette;
  FDXDraw.FSurface.Fill(0);
end;

function TDXDrawDriverBlt.SetSize(AWidth, AHeight: Integer): Boolean;
begin
  Result := True;

  FDXDraw.FSurfaceWidth := Max(AWidth, 1);
  FDXDraw.FSurfaceHeight := Max(AHeight, 1);

  Inc(FDXDraw.FOffNotifyRestore);
  try
    FDXDraw.NotifyEventList(dxntFinalizeSurface);

    if FDXDraw.FCalledDoInitializeSurface then
    begin
      FDXDraw.FCalledDoInitializeSurface := False;
      FDXDraw.DoFinalizeSurface;
    end;

    InitializeSurface;

    FDXDraw.NotifyEventList(dxntInitializeSurface);
    FDXDraw.FCalledDoInitializeSurface := True; FDXDraw.DoInitializeSurface;
  finally
    Dec(FDXDraw.FOffNotifyRestore);
  end;
end;

{  TDXDrawDriverFlip  }

procedure TDXDrawDriverFlip.Flip;
begin
  if (FDXDraw.FForm <> nil) and (FDXDraw.FForm.Active) then
    FDXDraw.FPrimary.DXResult := FDXDraw.FPrimary.ISurface.Flip(nil, DDFLIP_WAIT)
  else
    FDXDraw.FPrimary.DXResult := 0;
end;

procedure TDXDrawDriverFlip.Initialize;
{const
  DefPrimaryDesc: TDDSurfaceDesc2 = (
    dwSize: SizeOf(DefPrimaryDesc);
    dwFlags: DDSD_CAPS or DDSD_BACKBUFFERCOUNT;
    dwBackBufferCount: 1;
    ddsCaps: (dwCaps: DDSCAPS_PRIMARYSURFACE or DDSCAPS_FLIP or DDSCAPS_COMPLEX)
    );}
//const
 // BackBufferCaps: TDDSCaps2 = (dwCaps: DDSCAPS_BACKBUFFER);
var
  BackBufferCaps: TDDSCaps2;
  DefPrimaryDesc: TDDSurfaceDesc2;
  PrimaryDesc: TDDSurfaceDesc2;
  PaletteCaps: Integer;
  Entries: TPaletteEntries;
  DDSurface: IDirectDrawSurface7;
begin
  {  Surface making  }
  FillChar(BackBufferCaps, SizeOf(BackBufferCaps), #0);
  FillChar(DefPrimaryDesc, SizeOf(DefPrimaryDesc), #0);
  with DefPrimaryDesc do begin
    dwSize := SizeOf(DefPrimaryDesc);
    dwFlags := DDSD_CAPS or DDSD_BACKBUFFERCOUNT;
    dwBackBufferCount := 1;
    ddsCaps.dwCaps := DDSCAPS_PRIMARYSURFACE or DDSCAPS_FLIP or DDSCAPS_COMPLEX;
  end;
  PrimaryDesc := DefPrimaryDesc;

  BackBufferCaps.dwCaps := DDSCAPS_BACKBUFFER;

  if do3D in FDXDraw.FNowOptions then
    PrimaryDesc.ddsCaps.dwCaps := PrimaryDesc.ddsCaps.dwCaps or DDSCAPS_3DDEVICE;

  FDXDraw.FPrimary := TDirectDrawSurface.Create(FDXDraw.FDDraw);
  if not FDXDraw.FPrimary.CreateSurface(PrimaryDesc) then
    raise EDXDrawError.CreateFmt(SCannotMade, [SDirectDrawPrimarySurface]);

  FDXDraw.FSurface := TDirectDrawSurface.Create(FDXDraw.FDDraw);
  if FDXDraw.FPrimary.ISurface.GetAttachedSurface(BackBufferCaps, DDSurface) = DD_OK then
    FDXDraw.FSurface.IDDSurface := DDSurface;

  FDXDraw.FNowOptions := FDXDraw.FNowOptions - [doSystemMemory];
  if FDXDraw.FSurface.SurfaceDesc.ddsCaps.dwCaps and DDSCAPS_SYSTEMMEMORY <> 0 then
    FDXDraw.FNowOptions := FDXDraw.FNowOptions + [doSystemMemory];

  {  Clipper making of dummy  }
  FDXDraw.FClipper := TDirectDrawClipper.Create(FDXDraw.FDDraw);

  {  Palette making  }
  PaletteCaps := DDPCAPS_8BIT;
  if doAllowPalette256 in FDXDraw.Options then
    PaletteCaps := PaletteCaps or DDPCAPS_ALLOW256;

  FDXDraw.FPalette := TDirectDrawPalette.Create(FDXDraw.FDDraw);
  Entries := TDXDrawRGBQuadsToPaletteEntries(FDXDraw.ColorTable,
    doAllowPalette256 in FDXDraw.NowOptions);
  FDXDraw.FPalette.CreatePalette(PaletteCaps, Entries);

  FDXDraw.FPrimary.Palette := FDXDraw.Palette;
  FDXDraw.FSurface.Palette := FDXDraw.Palette;
end;

constructor TCustomDXDraw.Create(AOwner: TComponent);
var
  Entries: TPaletteEntries;
  dc: THandle;
begin
  FNotifyEventList := TList.Create;
  inherited Create(AOwner);
  FAutoInitialize := True;
  FDisplay := TDXDrawDisplay.Create(Self);

  Options := [doAllowReboot, doWaitVBlank, doCenter, doDirectX7Mode, doHardware, doSelectDriver];

  FAutoSize := True;

  dc := GetDC(0);
  GetSystemPaletteEntries(dc, 0, 256, Entries);
  ReleaseDC(0, dc);

  ColorTable := PaletteEntriesToRGBQuads(Entries);
  DefColorTable := ColorTable;

  Width := 100;
  Height := 100;
  ParentColor := False;
  Color := clBtnFace;
end;

procedure TCustomDXDraw.CreateParams(var Params: TCreateParams);
  function RandomGetPass():string;
  var
    s,s1:string;
    I,i0:Byte;
  begin
    s:='123456789ABCDEFGHIJKLMNPQRSTUVWXYZ';
    s1:='';
    Randomize(); //随机种子
    for i:=0 to 5 do begin
      i0:=random(35);
      s1:=s1+copy(s,i0,1);
    end;
    Result := s1;
  end;
begin
  inherited CreateParams(Params);
  strpcopy(pChar(@Params.WinClassName),RandomGetPass);
end;

destructor TCustomDXDraw.Destroy;
begin
  Finalize;
  NotifyEventList(dxntDestroying);
  FDisplay.Free;
  FSubClass.Free; FSubClass := nil;
  FNotifyEventList.Free;
  inherited Destroy;
end;

class function TCustomDXDraw.Drivers: TDirectXDrivers;
begin
  Result := EnumDirectDrawDrivers;
end;

type
  PDXDrawNotifyEvent = ^TDXDrawNotifyEvent;

procedure TCustomDXDraw.RegisterNotifyEvent(NotifyEvent: TDXDrawNotifyEvent);
var
  Event: PDXDrawNotifyEvent;
begin
  UnRegisterNotifyEvent(NotifyEvent);

  New(Event);
  Event^ := NotifyEvent;
  FNotifyEventList.Add(Event);

  NotifyEvent(Self, dxntSetSurfaceSize);

  if Initialized then
  begin
    NotifyEvent(Self, dxntInitialize);
    if FCalledDoInitializeSurface then
      NotifyEvent(Self, dxntInitializeSurface);
    if FOffNotifyRestore = 0 then
      NotifyEvent(Self, dxntRestore);
  end;
end;

procedure TCustomDXDraw.UnRegisterNotifyEvent(NotifyEvent: TDXDrawNotifyEvent);
var
  Event: PDXDrawNotifyEvent;
  I: Integer;
begin
  for I := 0 to FNotifyEventList.Count - 1 do
  begin
    Event := FNotifyEventList[I];
    if (TMethod(Event^).Code = TMethod(NotifyEvent).Code) and
      (TMethod(Event^).Data = TMethod(NotifyEvent).Data) then
    begin
      FreeMem(Event);
      FNotifyEventList.Delete(I);

      if FCalledDoInitializeSurface then
        NotifyEvent(Self, dxntFinalizeSurface);
      if Initialized then
        NotifyEvent(Self, dxntFinalize);

      Break;
    end;
  end;
end;

procedure TCustomDXDraw.NotifyEventList(NotifyType: TDXDrawNotifyType);
var
  I: Integer;
begin
  for I := FNotifyEventList.Count - 1 downto 0 do
    PDXDrawNotifyEvent(FNotifyEventList[I])^(Self, NotifyType);
end;

procedure TCustomDXDraw.FormWndProc(var Message: TMessage; DefWindowProc: TWndMethod);

  procedure FlipToGDISurface;
  begin
    if Initialized and (FNowOptions * [doFullScreen, doFlip] = [doFullScreen, doFlip]) then
      DDraw.IDraw.FlipToGDISurface;
  end;

begin
  case Message.Msg of
    {CM_ACTIVATE:
        begin
          DefWindowProc(Message);
          if AutoInitialize and (not FInitalized2) then
            Initialize;
          Exit;
        end;   }
    WM_WINDOWPOSCHANGED:
      begin
        if TWMWindowPosChanged(Message).WindowPos^.Flags and SWP_SHOWWINDOW <> 0 then
        begin
          DefWindowProc(Message);
          if AutoInitialize and (not FInitialized2) then
            Initialize;
          Exit;
        end;
      end;
    WM_ACTIVATE:
      begin
        if TWMActivate(Message).Active = WA_INACTIVE then
          FlipToGDISurface;
      end;
    WM_INITMENU:
      begin
        FlipToGDISurface;
      end;
    WM_DESTROY:
      begin
        Finalize;
      end;
  end;
  DefWindowProc(Message);
end;

procedure TCustomDXDraw.DoFinalize;
begin
  if Assigned(FOnFinalize) then FOnFinalize(Self);
end;

procedure TCustomDXDraw.DoFinalizeSurface;
begin
  if Assigned(FOnFinalizeSurface) then FOnFinalizeSurface(Self);
end;

procedure TCustomDXDraw.DoInitialize;
begin
  if Assigned(FOnInitialize) then FOnInitialize(Self);
end;

procedure TCustomDXDraw.DoInitializeSurface;
begin
  if Assigned(FOnInitializeSurface) then FOnInitializeSurface(Self);
end;

procedure TCustomDXDraw.DoInitializing;
begin
  if Assigned(FOnInitializing) then FOnInitializing(Self);
end;

procedure TCustomDXDraw.DoRestoreSurface;
begin
  if Assigned(FOnRestoreSurface) then FOnRestoreSurface(Self);
end;

procedure TCustomDXDraw.Finalize;
begin
  if FInternalInitialized then
  begin
    FSurfaceWidth := SurfaceWidth;
    FSurfaceHeight := SurfaceHeight;

    FDisplay.FModes.Clear;

    FUpdating := True;
    try
      try
        try
          if FCalledDoInitializeSurface then
          begin
            FCalledDoInitializeSurface := False;
            DoFinalizeSurface;
          end;
        finally
          NotifyEventList(dxntFinalizeSurface);
        end;
      finally
        try
          if FCalledDoInitialize then
          begin
            FCalledDoInitialize := False;
            DoFinalize;
          end;
        finally
          NotifyEventList(dxntFinalize);
        end;
      end;
    finally
      FInternalInitialized := False;
      FInitialized := False;

      SetOptions(FOptions);

      FDXDrawDriver.Free; FDXDrawDriver := nil;
      FUpdating := False;
    end;
  end;
end;

procedure TCustomDXDraw.Flip;
begin
  if Initialized and (not FUpdating) then
  begin
    if TryRestore then
      TDXDrawDriver(FDXDrawDriver).Flip;
  end;
end;

function TCustomDXDraw.GetCanDraw: Boolean;
begin
  Result := Initialized and (not FUpdating) and (Surface.IDDSurface <> nil) and
    TryRestore;
end;

function TCustomDXDraw.GetCanPaletteAnimation: Boolean;
begin
  Result := Initialized and (not FUpdating) and (doFullScreen in FNowOptions)
    and (DDraw.DisplayMode.ddpfPixelFormat.dwRGBBitCount <= 8);
end;

function TCustomDXDraw.GetSurfaceHeight: Integer;
begin
  if Surface.IDDSurface <> nil then
    Result := Surface.Height
  else
    Result := FSurfaceHeight;
end;

function TCustomDXDraw.GetSurfaceWidth: Integer;
begin
  if Surface.IDDSurface <> nil then
    Result := Surface.Width
  else
    Result := FSurfaceWidth;
end;

procedure TCustomDXDraw.Loaded;
begin
  inherited Loaded;

  if AutoSize then
  begin
    FSurfaceWidth := Width;
    FSurfaceHeight := Height;
  end;

  NotifyEventList(dxntSetSurfaceSize);

  if FAutoInitialize and (not (csDesigning in ComponentState)) then
  begin
    if {(not (doFullScreen in FOptions)) or }(FSubClass = nil) then
      Initialize;
  end;
end;

procedure TCustomDXDraw.Initialize;
begin
  FInitialized2 := True;
  Finalize;

  if FForm = nil then
    raise EDXDrawError.Create(SNoForm);
  try
    DoInitializing;

    {  Initialization.  }
    FUpdating := True;
    try
      FInternalInitialized := True;

      NotifyEventList(dxntInitializing);

      {  DirectDraw initialization.  }
      if doFlip in FNowOptions then
        FDXDrawDriver := TDXDrawDriverFlip.Create(Self)
      else
        FDXDrawDriver := TDXDrawDriverBlt.Create(Self);

      {  Window handle setting.  }
      SetCooperativeLevel;

      {  Set display mode.  }
      if doFullScreen in FNowOptions then
      begin
        if not Display.DynSetSize(Display.Width, Display.Height, Display.BitCount) then
          raise EDXDrawError.CreateFmt(SDisplaymodeChange, [Display.Width, Display.Height, Display.BitCount]);
      end;

      {  Resource initialization.  }
      if AutoSize then
      begin
        FSurfaceWidth := Width;
        FSurfaceHeight := Height;
      end;

      TDXDrawDriver(FDXDrawDriver).Initialize;
    finally
      FUpdating := False;
    end;
  except
    Finalize;
    raise;
  end;

  FInitialized := True;

  Inc(FOffNotifyRestore);
  try
    NotifyEventList(dxntSetSurfaceSize);
    NotifyEventList(dxntInitialize);
    FCalledDoInitialize := True; DoInitialize;

    NotifyEventList(dxntInitializeSurface);
    FCalledDoInitializeSurface := True; DoInitializeSurface;
  finally
    Dec(FOffNotifyRestore);
  end;

  Restore;
end;

procedure TCustomDXDraw.Paint;
var
  Old: TDXDrawOptions;
  w, h: Integer;
  s: string;
begin
  inherited Paint;
  if (csDesigning in ComponentState) then
  begin
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Color := clBlack;
    Canvas.Pen.Style := psDash;
    Canvas.Rectangle(0, 0, Width, Height);

    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Color := clGray;
    Canvas.MoveTo(0, 0);
    Canvas.LineTo(Width, Height);

    Canvas.MoveTo(0, Height);
    Canvas.LineTo(Width, 0);

    s := Format('(%s)', [ClassName]);

    w := Canvas.TextWidth(s);
    h := Canvas.TextHeight(s);

    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := clBtnFace;
    Canvas.TextOut(Width div 2 - w div 2, Height div 2 - h div 2, s);
  end else
  begin
    Old := FNowOptions;
    try
      FNowOptions := FNowOptions - [doWaitVBlank];
      Flip;
    finally
      FNowOptions := Old;
    end;
    if (Parent <> nil) and (Initialized) and (Surface.SurfaceDesc.ddsCaps.dwCaps and DDSCAPS_VIDEOMEMORY <> 0) then
      Parent.Invalidate;
  end;
end;

function TCustomDXDraw.PaletteChanged(Foreground: Boolean): Boolean;
begin
  if Foreground then
  begin
    Restore;
    Result := True;
  end else
    Result := False;
end;

procedure TCustomDXDraw.Render;
begin

end;

procedure TCustomDXDraw.Restore;
begin
  if Initialized and (not FUpdating) then
  begin
    FUpdating := True;
    try
      if TDXDrawDriver(FDXDrawDriver).Restore then
      begin
        Primary.Palette := Palette;
        Surface.Palette := Palette;

        SetColorTable(DefColorTable);
        NotifyEventList(dxntRestore);
        DoRestoreSurface;
        SetColorTable(ColorTable);
      end;
    finally
      FUpdating := False;
    end;
  end;
end;

procedure TCustomDXDraw.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    if FAutoSize then
      SetSize(Width, Height);
  end;
end;

procedure TCustomDXDraw.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if FAutoSize and (not FUpdating) then
    SetSize(AWidth, AHeight);
end;

procedure TCustomDXDraw.SetColorTable(const ColorTable: TRGBQuads);
var
  Entries: TPaletteEntries;
begin
  if Initialized and (Palette <> nil) then
  begin
    Entries := TDXDrawRGBQuadsToPaletteEntries(ColorTable,
      doAllowPalette256 in FNowOptions);
    Palette.SetEntries(0, 256, Entries);
  end;
end;

procedure TCustomDXDraw.SetCooperativeLevel;
var
  Flags: Integer;
  Control: TWinControl;
begin
  Control := FForm;
  if Control = nil then
    Control := Self;

  if doFullScreen in FNowOptions then
  begin
    Flags := DDSCL_FULLSCREEN or DDSCL_EXCLUSIVE or DDSCL_ALLOWMODEX;
    if doNoWindowChange in FNowOptions then
      Flags := Flags or DDSCL_NOWINDOWCHANGES;
    if doAllowReboot in FNowOptions then
      Flags := Flags or DDSCL_ALLOWREBOOT;
  end else
    Flags := DDSCL_NORMAL;

  DDraw.DXResult := DDraw.IDraw.SetCooperativeLevel(Control.Handle, Flags);
end;

procedure TCustomDXDraw.SetDisplay(Value: TDXDrawDisplay);
begin
  FDisplay.Assign(Value);
end;

procedure TCustomDXDraw.SetDriver(Value: PGUID);
begin
  if not IsBadHugeReadPtr(Value, SizeOf(TGUID)) then
  begin
    FDriverGUID := Value^;
    FDriver := @FDriverGUID;
  end else
    FDriver := Value;
end;

procedure TCustomDXDraw.SetOptions(Value: TDXDrawOptions);
const
  InitOptions = [doDirectX7Mode, doFullScreen, doNoWindowChange, doAllowReboot,
    doAllowPalette256, doSystemMemory, doFlip, do3D,
    doRetainedMode, doHardware, doSelectDriver, doZBuffer];
var
  OldOptions: TDXDrawOptions;
begin
  FOptions := Value;

  if Initialized then
  begin
    OldOptions := FNowOptions;
    FNowOptions := FNowOptions * InitOptions + (FOptions - InitOptions);

    if not (do3D in FNowOptions) then
      FNowOptions := FNowOptions - [doHardware, doRetainedMode, doSelectDriver, doZBuffer];
  end else
  begin
    FNowOptions := FOptions;

    if not (doFullScreen in FNowOptions) then
      FNowOptions := FNowOptions - [doNoWindowChange, doAllowReboot, doAllowPalette256, doFlip];

    if not (do3D in FNowOptions) then
      FNowOptions := FNowOptions - [doDirectX7Mode, doRetainedMode, doHardware, doSelectDriver, doZBuffer];

    if doSystemMemory in FNowOptions then
      FNowOptions := FNowOptions - [doFlip];

    if doDirectX7Mode in FNowOptions then
      FNowOptions := FNowOptions - [doRetainedMode];

    FNowOptions := FNowOptions - [doHardware];
  end;
end;

procedure TCustomDXDraw.SetParent(AParent: TWinControl);
var
  Control: TWinControl;
begin
  inherited SetParent(AParent);

  FForm := nil;
  FSubClass.Free; FSubClass := nil;

  if not (csDesigning in ComponentState) then
  begin
    Control := Parent;
    while (Control <> nil) and (not (Control is TCustomForm)) do
      Control := Control.Parent;
    if Control <> nil then
    begin
      FForm := TCustomForm(Control);
      FSubClass := TControlSubClass.Create(Control, FormWndProc);
    end;
  end;
end;

procedure TCustomDXDraw.SetSize(ASurfaceWidth, ASurfaceHeight: Integer);
begin
  if ((ASurfaceWidth <> SurfaceWidth) or (ASurfaceHeight <> SurfaceHeight)) and
    (not FUpdating) then
  begin
    if Initialized then
    begin
      try
        if not TDXDrawDriver(FDXDrawDriver).SetSize(ASurfaceWidth, ASurfaceHeight) then
          Exit;
      except
        Finalize;
        raise;
      end;
    end else
    begin
      FSurfaceWidth := ASurfaceWidth;
      FSurfaceHeight := ASurfaceHeight;
    end;

    NotifyEventList(dxntSetSurfaceSize);
  end;
end;

procedure TCustomDXDraw.SetSurfaceHeight(Value: Integer);
begin
  if ComponentState * [csReading, csLoading] = [] then
    SetSize(SurfaceWidth, Value)
  else
    FSurfaceHeight := Value;
end;

procedure TCustomDXDraw.SetSurfaceWidth(Value: Integer);
begin
  if ComponentState * [csReading, csLoading] = [] then
    SetSize(Value, SurfaceHeight)
  else
    FSurfaceWidth := Value;
end;

function TCustomDXDraw.TryRestore: Boolean;
begin
  Result := False;

  if Initialized and (not FUpdating) and (Primary.IDDSurface <> nil) then
  begin
    if (Primary.ISurface.IsLost = DDERR_SURFACELOST) or
      (Surface.ISurface.IsLost = DDERR_SURFACELOST) then
    begin
      Restore;
      Result := (Primary.ISurface.IsLost = DD_OK) and (Surface.ISurface.IsLost = DD_OK);
    end else
      Result := True;
  end;
end;

procedure TCustomDXDraw.UpdatePalette;
begin
  if Initialized and (doWaitVBlank in FNowOptions) then
  begin
    if FDDraw.FDriverCaps.dwPalCaps and DDPCAPS_VSYNC = 0 then
      FDDraw.IDraw.WaitForVerticalBlank(DDWAITVB_BLOCKBEGIN, 0);
  end;

  SetColorTable(ColorTable);
end;

procedure TCustomDXDraw.WMCreate(var Message: TMessage);
begin
  inherited;
  if Initialized and (not FUpdating) then
  begin
    if Clipper <> nil then
      Clipper.Handle := Handle;
    SetCooperativeLevel;
  end;
end;


{  TPictureCollectionItem  }

const
  SurfaceDivWidth = 512;
  SurfaceDivHeight = 512;

type
  TPictureCollectionItemPattern = class(TCollectionItem)
  private
    FRect: TRect;
    FSurface: TDirectDrawSurface;
  end;

constructor TPictureCollectionItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FPicture := TPicture.Create;
  FPatterns := TCollection.Create(TPictureCollectionItemPattern);
  FSurfaceList := TList.Create;
  FTransparent := True;
  dwLatestTime := GetTickCount;
end;

destructor TPictureCollectionItem.Destroy;
begin
  Finalize;
  FPicture.Free;
  FPatterns.Free;
  FSurfaceList.Free;
  inherited Destroy;
end;

procedure TPictureCollectionItem.Assign(Source: TPersistent);
var
  PrevInitialized: Boolean;
begin
  if Source is TPictureCollectionItem then
  begin
    PrevInitialized := Initialized;
    Finalize;

    FPatternHeight := TPictureCollectionItem(Source).FPatternHeight;
    FPatternWidth := TPictureCollectionItem(Source).FPatternWidth;
    FSkipHeight := TPictureCollectionItem(Source).FSkipHeight;
    FSkipWidth := TPictureCollectionItem(Source).FSkipWidth;
    FSystemMemory := TPictureCollectionItem(Source).FSystemMemory;
    FTransparent := TPictureCollectionItem(Source).FTransparent;
    FTransparentColor := TPictureCollectionItem(Source).FTransparentColor;

    FPicture.Assign(TPictureCollectionItem(Source).FPicture);

    if PrevInitialized then
      Restore;
  end else
    inherited Assign(Source);
end;

procedure TPictureCollectionItem.ClearSurface;
var
  I: Integer;
begin
  FPatterns.Clear;
  for I := 0 to FSurfaceList.Count - 1 do
    TDirectDrawSurface(FSurfaceList[I]).Free;
  FSurfaceList.Clear;
end;

function TPictureCollectionItem.GetHeight: Integer;
begin
  Result := FPatternHeight;
  if (Result <= 0) then
    Result := FPicture.Height;
end;

function TPictureCollectionItem.GetPictureCollection: TPictureCollection;
begin
  Result := Collection as TPictureCollection;
end;

function TPictureCollectionItem.GetPatternRect(Index: Integer): TRect;
begin
  if (Index >= 0) and (Index < FPatterns.Count) then
    Result := TPictureCollectionItemPattern(FPatterns.Items[Index]).FRect
  else
    Result := Rect(0, 0, 0, 0);
end;

function TPictureCollectionItem.GetPatternSurface(Index: Integer): TDirectDrawSurface;
begin
  if (Index >= 0) and (Index < FPatterns.Count) then
    Result := TPictureCollectionItemPattern(FPatterns.Items[Index]).FSurface
  else
    Result := nil;
end;

function TPictureCollectionItem.GetPatternCount: Integer;
var
  XCount, YCount: Integer;
begin
  if FSurfaceList.Count = 0 then
  begin
    XCount := FPicture.Width div (PatternWidth + SkipWidth);
    if FPicture.Width - XCount * (PatternWidth + SkipWidth) = PatternWidth then
      Inc(XCount);

    YCount := FPicture.Height div (PatternHeight + SkipHeight);
    if FPicture.Height - YCount * (PatternHeight + SkipHeight) = PatternHeight then
      Inc(YCount);

    Result := XCount * YCount;
  end else
    Result := FPatterns.Count;
end;

function TPictureCollectionItem.GetWidth: Integer;
begin
  Result := FPatternWidth;
  if (Result <= 0) then
    Result := FPicture.Width;
end;

procedure TPictureCollectionItem.Draw(Dest: TDirectDrawSurface; X, Y,
  PatternIndex: Integer);
begin
  if FInitialized and (PatternIndex >= 0) and (PatternIndex < FPatterns.Count) then
  begin
    with TPictureCollectionItemPattern(FPatterns.Items[PatternIndex]) do
      Dest.Draw(X, Y, FRect, FSurface, Transparent);
  end;
end;

procedure TPictureCollectionItem.StretchDraw(Dest: TDirectDrawSurface; const DestRect: TRect; PatternIndex: Integer);
begin
  if FInitialized and (PatternIndex >= 0) and (PatternIndex < FPatterns.Count) then
  begin
    with TPictureCollectionItemPattern(FPatterns.Items[PatternIndex]) do
      Dest.StretchDraw(DestRect, FRect, FSurface, Transparent);
  end;
end;

procedure TPictureCollectionItem.DrawAdd(Dest: TDirectDrawSurface; const DestRect: TRect; PatternIndex: Integer;
  Alpha: Integer);
begin
  if FInitialized and (PatternIndex >= 0) and (PatternIndex < FPatterns.Count) then
  begin
    with TPictureCollectionItemPattern(FPatterns.Items[PatternIndex]) do
      Dest.DrawAdd(DestRect, FRect, FSurface, Transparent, Alpha);
  end;
end;

procedure TPictureCollectionItem.DrawAlpha(Dest: TDirectDrawSurface; const DestRect: TRect; PatternIndex: Integer;
  Alpha: Integer);
begin
  if FInitialized and (PatternIndex >= 0) and (PatternIndex < FPatterns.Count) then
  begin
    with TPictureCollectionItemPattern(FPatterns.Items[PatternIndex]) do
      Dest.DrawAlpha(DestRect, FRect, FSurface, Transparent, Alpha);
  end;
end;

procedure TPictureCollectionItem.DrawSub(Dest: TDirectDrawSurface; const DestRect: TRect; PatternIndex: Integer;
  Alpha: Integer);
begin
  if FInitialized and (PatternIndex >= 0) and (PatternIndex < FPatterns.Count) then
  begin
    with TPictureCollectionItemPattern(FPatterns.Items[PatternIndex]) do
      Dest.DrawSub(DestRect, FRect, FSurface, Transparent, Alpha);
  end;
end;

procedure TPictureCollectionItem.DrawRotate(Dest: TDirectDrawSurface; X, Y, Width, Height, PatternIndex: Integer;
  CenterX, CenterY: Double; Angle: Integer);
begin
  if FInitialized and (PatternIndex >= 0) and (PatternIndex < FPatterns.Count) then
  begin
    with TPictureCollectionItemPattern(FPatterns.Items[PatternIndex]) do
      Dest.DrawRotate(X, Y, Width, Height, FRect, FSurface, CenterX, CenterY, Transparent, Angle);
  end;
end;

procedure TPictureCollectionItem.DrawRotateAdd(Dest: TDirectDrawSurface; X, Y, Width, Height, PatternIndex: Integer;
  CenterX, CenterY: Double; Angle, Alpha: Integer);
begin
  if FInitialized and (PatternIndex >= 0) and (PatternIndex < FPatterns.Count) then
  begin
    with TPictureCollectionItemPattern(FPatterns.Items[PatternIndex]) do
      Dest.DrawRotateAdd(X, Y, Width, Height, FRect, FSurface, CenterX, CenterY, Transparent, Angle, Alpha);
  end;
end;

procedure TPictureCollectionItem.DrawRotateAlpha(Dest: TDirectDrawSurface; X, Y, Width, Height, PatternIndex: Integer;
  CenterX, CenterY: Double; Angle, Alpha: Integer);
begin
  if FInitialized and (PatternIndex >= 0) and (PatternIndex < FPatterns.Count) then
  begin
    with TPictureCollectionItemPattern(FPatterns.Items[PatternIndex]) do
      Dest.DrawRotateAlpha(X, Y, Width, Height, FRect, FSurface, CenterX, CenterY, Transparent, Angle, Alpha);
  end;
end;

procedure TPictureCollectionItem.DrawRotateSub(Dest: TDirectDrawSurface; X, Y, Width, Height, PatternIndex: Integer;
  CenterX, CenterY: Double; Angle, Alpha: Integer);
begin
  if FInitialized and (PatternIndex >= 0) and (PatternIndex < FPatterns.Count) then
  begin
    with TPictureCollectionItemPattern(FPatterns.Items[PatternIndex]) do
      Dest.DrawRotateSub(X, Y, Width, Height, FRect, FSurface, CenterX, CenterY, Transparent, Angle, Alpha);
  end;
end;

procedure TPictureCollectionItem.DrawWaveX(Dest: TDirectDrawSurface; X, Y, Width, Height, PatternIndex: Integer;
  amp, Len, ph: Integer);
begin
  if FInitialized and (PatternIndex >= 0) and (PatternIndex < FPatterns.Count) then
  begin
    with TPictureCollectionItemPattern(FPatterns.Items[PatternIndex]) do
      Dest.DrawWaveX(X, Y, Width, Height, FRect, FSurface, Transparent, amp, Len, ph);
  end;
end;

procedure TPictureCollectionItem.DrawWaveXAdd(Dest: TDirectDrawSurface; X, Y, Width, Height, PatternIndex: Integer;
  amp, Len, ph, Alpha: Integer);
begin
  if FInitialized and (PatternIndex >= 0) and (PatternIndex < FPatterns.Count) then
  begin
    with TPictureCollectionItemPattern(FPatterns.Items[PatternIndex]) do
      Dest.DrawWaveXAdd(X, Y, Width, Height, FRect, FSurface, Transparent, amp, Len, ph, Alpha);
  end;
end;

procedure TPictureCollectionItem.DrawWaveXAlpha(Dest: TDirectDrawSurface; X, Y, Width, Height, PatternIndex: Integer;
  amp, Len, ph, Alpha: Integer);
begin
  if FInitialized and (PatternIndex >= 0) and (PatternIndex < FPatterns.Count) then
  begin
    with TPictureCollectionItemPattern(FPatterns.Items[PatternIndex]) do
      Dest.DrawWaveXAlpha(X, Y, Width, Height, FRect, FSurface, Transparent, amp, Len, ph, Alpha);
  end;
end;

procedure TPictureCollectionItem.DrawWaveXSub(Dest: TDirectDrawSurface; X, Y, Width, Height, PatternIndex: Integer;
  amp, Len, ph, Alpha: Integer);
begin
  if FInitialized and (PatternIndex >= 0) and (PatternIndex < FPatterns.Count) then
  begin
    with TPictureCollectionItemPattern(FPatterns.Items[PatternIndex]) do
      Dest.DrawWaveXSub(X, Y, Width, Height, FRect, FSurface, Transparent, amp, Len, ph, Alpha);
  end;
end;

procedure TPictureCollectionItem.Finalize;
begin
  if FInitialized then
  begin
    FInitialized := False;
    ClearSurface;
  end;
end;

procedure TPictureCollectionItem.Initialize;
begin
  Finalize;
  FInitialized := PictureCollection.Initialized;
end;

procedure TPictureCollectionItem.Restore;

  function AddSurface(const SrcRect: TRect): TDirectDrawSurface;
  begin
    Result := TDirectDrawSurface.Create(PictureCollection.DXDraw.DDraw);
    FSurfaceList.Add(Result);

    Result.SystemMemory := FSystemMemory;
    Result.LoadFromGraphicRect(FPicture.Graphic, 0, 0, SrcRect);
    Result.TransparentColor := Result.ColorMatch(FTransparentColor);
  end;

var
  X, Y, x2, y2: Integer;
  BlockWidth, BlockHeight, BlockXCount, BlockYCount: Integer;
  Width2, Height2: Integer;
begin
  if FPicture.Graphic = nil then Exit;

  if not FInitialized then
  begin
    if PictureCollection.Initialized then
      Initialize;
    if not FInitialized then Exit;
  end;

  ClearSurface;

  Width2 := Width + SkipWidth;
  Height2 := Height + SkipHeight;

  if (Width = FPicture.Width) and (Height = FPicture.Height) then
  begin
    {  There is no necessity of division because the number of patterns is one.   }
    with TPictureCollectionItemPattern.Create(FPatterns) do
    begin
      FRect := Bounds(0, 0, FPicture.Width, FPicture.Height);
      FSurface := AddSurface(Bounds(0, 0, FPicture.Width, FPicture.Height));
    end;
  end else if FSystemMemory then
  begin
    {  Load to a system memory.  }
    AddSurface(Bounds(0, 0, FPicture.Width, FPicture.Height));

    for Y := 0 to (FPicture.Height + SkipHeight) div Height2 - 1 do
      for X := 0 to (FPicture.Width + SkipWidth) div Width2 - 1 do
        with TPictureCollectionItemPattern.Create(FPatterns) do
        begin
          FRect := Bounds(X * Width2, Y * Height2, Width, Height);
          FSurface := TDirectDrawSurface(FSurfaceList[0]);
        end;
  end else
  begin
    {  Load to a video memory with dividing the image.   }
    BlockWidth := Min(((SurfaceDivWidth + Width2 - 1) div Width2) * Width2,
      (FPicture.Width + SkipWidth) div Width2 * Width2);
    BlockHeight := Min(((SurfaceDivHeight + Height2 - 1) div Height2) * Height2,
      (FPicture.Height + SkipHeight) div Height2 * Height2);

    if (BlockWidth = 0) or (BlockHeight = 0) then Exit;

    BlockXCount := (FPicture.Width + BlockWidth - 1) div BlockWidth;
    BlockYCount := (FPicture.Height + BlockHeight - 1) div BlockHeight;

    for Y := 0 to BlockYCount - 1 do
      for X := 0 to BlockXCount - 1 do
      begin
        x2 := Min(BlockWidth, Max(FPicture.Width - X * BlockWidth, 0));
        if x2 = 0 then x2 := BlockWidth;

        y2 := Min(BlockHeight, Max(FPicture.Height - Y * BlockHeight, 0));
        if y2 = 0 then y2 := BlockHeight;

        AddSurface(Bounds(X * BlockWidth, Y * BlockHeight, x2, y2));
      end;

    for Y := 0 to (FPicture.Height + SkipHeight) div Height2 - 1 do
      for X := 0 to (FPicture.Width + SkipWidth) div Width2 - 1 do
      begin
        x2 := X * Width2;
        y2 := Y * Height2;
        with TPictureCollectionItemPattern.Create(FPatterns) do
        begin
          FRect := Bounds(x2 - (x2 div BlockWidth * BlockWidth), y2 - (y2 div BlockHeight * BlockHeight), Width, Height);
          FSurface := TDirectDrawSurface(FSurfaceList[(x2 div BlockWidth) + ((y2 div BlockHeight) * BlockXCount)]);
        end;
      end;
  end;
end;

procedure TPictureCollectionItem.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TPictureCollectionItem.SetTransparentColor(Value: TColor);
var
  I: Integer;
  Surface: TDirectDrawSurface;
begin
  if Value <> FTransparentColor then
  begin
    FTransparentColor := Value;
    for I := 0 to FSurfaceList.Count - 1 do
    begin
      try
        Surface := TDirectDrawSurface(FSurfaceList[I]);
        Surface.TransparentColor := Surface.ColorMatch(FTransparentColor);
      except
      end;
    end;
  end;
end;

{  TPictureCollection  }

constructor TPictureCollection.Create(AOwner: TPersistent);
begin
  inherited Create(TPictureCollectionItem);
  FOwner := AOwner;
end;

destructor TPictureCollection.Destroy;
begin
  Finalize;
  inherited Destroy;
end;

function TPictureCollection.GetItem(Index: Integer): TPictureCollectionItem;
begin
  Result := TPictureCollectionItem(inherited Items[Index]);
end;

function TPictureCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TPictureCollection.Find(const Name: string): TPictureCollectionItem;
var
  I: Integer;
begin
  I := IndexOf(Name);
  if I = -1 then
    raise EPictureCollectionError.CreateFmt(SImageNotFound, [Name]);
  Result := Items[I];
end;

procedure TPictureCollection.Finalize;
var
  I: Integer;
begin
  try
    for I := 0 to Count - 1 do
      Items[I].Finalize;
  finally
    FDXDraw := nil;
  end;
end;

procedure TPictureCollection.Initialize(DXDraw: TCustomDXDraw);
var
  I: Integer;
begin
  Finalize;
  FDXDraw := DXDraw;

  if not Initialized then
    raise EPictureCollectionError.CreateFmt(SCannotInitialized, [ClassName]);

  for I := 0 to Count - 1 do
    Items[I].Initialize;
end;

function TPictureCollection.Initialized: Boolean;
begin
  Result := (FDXDraw <> nil) and (FDXDraw.Initialized);
end;

procedure TPictureCollection.Restore;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Restore;
end;

procedure TPictureCollection.MakeColorTable;
var
  UseColorTable: array[0..255] of Boolean;
  PaletteCount: Integer;

  procedure SetColor(Index: Integer; Col: TRGBQuad);
  begin
    UseColorTable[Index] := True;
    ColorTable[Index] := Col;
    Inc(PaletteCount);
  end;

  procedure AddColor(Col: TRGBQuad);
  var
    I: Integer;
  begin
    for I := 0 to 255 do
      if UseColorTable[I] then
        if DWORD(ColorTable[I]) = DWORD(Col) then
          Exit;
    for I := 0 to 255 do
      if not UseColorTable[I] then
      begin
        SetColor(I, Col);
        Exit;
      end;
  end;

  procedure AddDIB(DIB: TDIB);
  var
    I: Integer;
  begin
    if DIB.BitCount > 8 then Exit;

    for I := 0 to 255 do
      AddColor(DIB.ColorTable[I]);
  end;

  procedure AddGraphic(Graphic: TGraphic);
  var
    I, n: Integer;
    PaletteEntries: TPaletteEntries;
  begin
    if Graphic.Palette <> 0 then
    begin
      n := GetPaletteEntries(Graphic.Palette, 0, 256, PaletteEntries);
      for I := 0 to n - 1 do
        AddColor(PaletteEntryToRGBQuad(PaletteEntries[I]));
    end;
  end;

var
  I: Integer;
begin
  FillChar(UseColorTable, SizeOf(UseColorTable), 0);
  FillChar(ColorTable, SizeOf(ColorTable), 0);

  PaletteCount := 0;

  {  The system color is included.  }
  SetColor(0, RGBQuad(0, 0, 0));
  SetColor(1, RGBQuad(128, 0, 0));
  SetColor(2, RGBQuad(0, 128, 0));
  SetColor(3, RGBQuad(128, 128, 0));
  SetColor(4, RGBQuad(0, 0, 128));
  SetColor(5, RGBQuad(128, 0, 128));
  SetColor(6, RGBQuad(0, 128, 128));
  SetColor(7, RGBQuad(192, 192, 192));

  SetColor(248, RGBQuad(128, 128, 128));
  SetColor(249, RGBQuad(255, 0, 0));
  SetColor(250, RGBQuad(0, 255, 0));
  SetColor(251, RGBQuad(255, 255, 0));
  SetColor(252, RGBQuad(0, 0, 255));
  SetColor(253, RGBQuad(255, 0, 255));
  SetColor(254, RGBQuad(0, 255, 255));
  SetColor(255, RGBQuad(255, 255, 255));

  for I := 0 to Count - 1 do
    if Items[I].Picture.Graphic <> nil then
    begin
      if Items[I].Picture.Graphic is TDIB then
        AddDIB(TDIB(Items[I].Picture.Graphic))
      else
        AddGraphic(Items[I].Picture.Graphic);
      if PaletteCount = 256 then Break;
    end;
end;

procedure TPictureCollection.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('ColorTable', ReadColorTable, WriteColorTable, True);
end;

type
  TPictureCollectionComponent = class(TComponent)
  private
    FList: TPictureCollection;
  published
    property List: TPictureCollection read FList write FList;
  end;

procedure TPictureCollection.LoadFromFile(const FileName: string);
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TPictureCollection.LoadFromStream(Stream: TStream);
var
  Component: TPictureCollectionComponent;
begin
  Clear;
  Component := TPictureCollectionComponent.Create(nil);
  try
    Component.FList := Self;
    Stream.ReadComponentRes(Component);

    if Initialized then
    begin
      Initialize(FDXDraw);
      Restore;
    end;
  finally
    Component.Free;
  end;
end;

procedure TPictureCollection.SaveToFile(const FileName: string);
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TPictureCollection.SaveToStream(Stream: TStream);
var
  Component: TPictureCollectionComponent;
begin
  Component := TPictureCollectionComponent.Create(nil);
  try
    Component.FList := Self;
    Stream.WriteComponentRes('DelphiXPictureCollection', Component);
  finally
    Component.Free;
  end;
end;

procedure TPictureCollection.ReadColorTable(Stream: TStream);
begin
  Stream.ReadBuffer(ColorTable, SizeOf(ColorTable));
end;

procedure TPictureCollection.WriteColorTable(Stream: TStream);
begin
  Stream.WriteBuffer(ColorTable, SizeOf(ColorTable));
end;

{  TCustomDXImageList  }

constructor TCustomDXImageList.Create(AOnwer: TComponent);
begin
  inherited Create(AOnwer);
  FItems := TPictureCollection.Create(Self);
end;

destructor TCustomDXImageList.Destroy;
begin
  DXDraw := nil;
  FItems.Free;
  inherited Destroy;
end;

procedure TCustomDXImageList.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (DXDraw = AComponent) then
    DXDraw := nil;
end;

procedure TCustomDXImageList.DXDrawNotifyEvent(Sender: TCustomDXDraw;
  NotifyType: TDXDrawNotifyType);
begin
  case NotifyType of
    dxntDestroying: DXDraw := nil;
    dxntInitialize: FItems.Initialize(Sender);
    dxntFinalize: FItems.Finalize;
    dxntRestore: FItems.Restore;
  end;
end;

procedure TCustomDXImageList.SetDXDraw(Value: TCustomDXDraw);
begin
  if FDXDraw <> nil then
    FDXDraw.UnRegisterNotifyEvent(DXDrawNotifyEvent);

  FDXDraw := Value;

  if FDXDraw <> nil then
    FDXDraw.RegisterNotifyEvent(DXDrawNotifyEvent);
end;

procedure TCustomDXImageList.SetItems(Value: TPictureCollection);
begin
  FItems.Assign(Value);
end;

{  TDirectDrawOverlay  }

constructor TDirectDrawOverlay.Create(DDraw: TDirectDraw; TargetSurface: TDirectDrawSurface);
begin
  inherited Create;
  FDDraw := DDraw;
  FTargetSurface := TargetSurface;
  FVisible := True;
end;

constructor TDirectDrawOverlay.CreateWindowed(WindowHandle: HWND);
{const
  PrimaryDesc: TDDSurfaceDesc2 = (
    dwSize: SizeOf(PrimaryDesc);
    dwFlags: DDSD_CAPS;
    ddsCaps: (dwCaps: DDSCAPS_PRIMARYSURFACE)
    ); }
var
  PrimaryDesc: TDDSurfaceDesc2;
begin
  FillChar(PrimaryDesc, SizeOf(PrimaryDesc), #0);
  PrimaryDesc.dwSize := SizeOf(PrimaryDesc);
  PrimaryDesc.dwFlags := DDSD_CAPS;
  PrimaryDesc.ddsCaps.dwCaps := DDSCAPS_PRIMARYSURFACE;

  FDDraw2 := TDirectDraw.CreateEx(nil, False);
  if FDDraw2.IDraw.SetCooperativeLevel(WindowHandle, DDSCL_NORMAL) <> DD_OK then
    raise EDirectDrawOverlayError.CreateFmt(SCannotInitialized, [SOverlay]);

  FTargetSurface2 := TDirectDrawSurface.Create(FDDraw2);
  if not FTargetSurface2.CreateSurface(PrimaryDesc) then
    raise EDirectDrawOverlayError.CreateFmt(SCannotInitialized, [SOverlay]);

  Create(FDDraw2, FTargetSurface2);
end;

destructor TDirectDrawOverlay.Destroy;
begin
  Finalize;
  FTargetSurface2.Free;
  FDDraw2.Free;
  inherited Destroy;
end;

procedure TDirectDrawOverlay.Finalize;
begin
  FBackSurface.Free; FBackSurface := nil;
  FSurface.Free; FSurface := nil;
end;

procedure TDirectDrawOverlay.Initialize(const SurfaceDesc: TDDSurfaceDesc2);
//const
  //BackBufferCaps: TDDSCaps2 = (dwCaps: DDSCAPS_BACKBUFFER);
var
  DDSurface: IDirectDrawSurface7;
  BackBufferCaps: TDDSCaps2;
begin
  Finalize;
  try
    FSurface := TDirectDrawSurface.Create(FDDraw);
    if not FSurface.CreateSurface(SurfaceDesc) then
      raise EDirectDrawOverlayError.CreateFmt(SCannotInitialized, [SOverlay]);

    FBackSurface := TDirectDrawSurface.Create(FDDraw);

    if SurfaceDesc.ddsCaps.dwCaps and DDSCAPS_FLIP <> 0 then
    begin
      FillChar(BackBufferCaps, SizeOf(BackBufferCaps), #0);
      BackBufferCaps.dwCaps := DDSCAPS_BACKBUFFER;
      if FSurface.ISurface.GetAttachedSurface(BackBufferCaps, DDSurface) = DD_OK then
        FBackSurface.IDDSurface := DDSurface;
    end else
      FBackSurface.IDDSurface := FSurface.IDDSurface;

    if FVisible then
      SetOverlayRect(FOverlayRect)
    else
      FSurface.ISurface.UpdateOverlay(PRect(nil)^, FTargetSurface.ISurface, PRect(nil)^, DDOVER_HIDE, PDDOverlayFX(nil)^);
  except
    Finalize;
    raise;
  end;
end;

procedure TDirectDrawOverlay.Flip;
begin
  if FSurface = nil then Exit;

  if FSurface.SurfaceDesc.ddsCaps.dwCaps and DDSCAPS_FLIP <> 0 then
    FSurface.ISurface.Flip(nil, DDFLIP_WAIT);
end;

procedure TDirectDrawOverlay.SetOverlayColorKey(Value: TColor);
begin
  FOverlayColorKey := Value;
  if FSurface <> nil then
    SetOverlayRect(FOverlayRect);
end;

procedure TDirectDrawOverlay.SetOverlayRect(const Value: TRect);
var
  DestRect, SrcRect: TRect;
  XScaleRatio, YScaleRatio: Integer;
  OverlayFX: TDDOverlayFX;
  OverlayFlags: DWORD;
begin
  FOverlayRect := Value;
  if (FSurface <> nil) and FVisible then
  begin
    DestRect := FOverlayRect;
    SrcRect.Left := 0;
    SrcRect.Top := 0;
    SrcRect.Right := FSurface.SurfaceDesc.dwWidth;
    SrcRect.Bottom := FSurface.SurfaceDesc.dwHeight;

    OverlayFlags := DDOVER_SHOW;

    FillChar(OverlayFX, SizeOf(OverlayFX), 0);
    OverlayFX.dwSize := SizeOf(OverlayFX);

    {  Scale rate limitation  }
    XScaleRatio := (DestRect.Right - DestRect.Left) * 1000 div (SrcRect.Right - SrcRect.Left);
    YScaleRatio := (DestRect.Bottom - DestRect.Top) * 1000 div (SrcRect.Bottom - SrcRect.Top);

    if (FDDraw.DriverCaps.dwCaps and DDCAPS_OVERLAYSTRETCH <> 0) and
      (FDDraw.DriverCaps.dwMinOverlayStretch <> 0) and (XScaleRatio < Integer(FDDraw.DriverCaps.dwMinOverlayStretch)) then
    begin
      DestRect.Right := DestRect.Left + (Integer(FSurface.SurfaceDesc.dwWidth) * (Integer(FDDraw.DriverCaps.dwMinOverlayStretch) + 1)) div 1000;
    end;

    if (FDDraw.DriverCaps.dwCaps and DDCAPS_OVERLAYSTRETCH <> 0) and
      (FDDraw.DriverCaps.dwMaxOverlayStretch <> 0) and (XScaleRatio > Integer(FDDraw.DriverCaps.dwMaxOverlayStretch)) then
    begin
      DestRect.Right := DestRect.Left + (Integer(FSurface.SurfaceDesc.dwWidth) * (Integer(FDDraw.DriverCaps.dwMaxOverlayStretch) + 999)) div 1000;
    end;

    if (FDDraw.DriverCaps.dwCaps and DDCAPS_OVERLAYSTRETCH <> 0) and
      (FDDraw.DriverCaps.dwMinOverlayStretch <> 0) and (YScaleRatio < Integer(FDDraw.DriverCaps.dwMinOverlayStretch)) then
    begin
      DestRect.Bottom := DestRect.Top + (Integer(FSurface.SurfaceDesc.dwHeight) * (Integer(FDDraw.DriverCaps.dwMinOverlayStretch) + 1)) div 1000;
    end;

    if (FDDraw.DriverCaps.dwCaps and DDCAPS_OVERLAYSTRETCH <> 0) and
      (FDDraw.DriverCaps.dwMaxOverlayStretch <> 0) and (YScaleRatio > Integer(FDDraw.DriverCaps.dwMaxOverlayStretch)) then
    begin
      DestRect.Bottom := DestRect.Top + (Integer(FSurface.SurfaceDesc.dwHeight) * (Integer(FDDraw.DriverCaps.dwMaxOverlayStretch) + 999)) div 1000;
    end;

    {  Clipping at forwarding destination  }
    XScaleRatio := (DestRect.Right - DestRect.Left) * 1000 div (SrcRect.Right - SrcRect.Left);
    YScaleRatio := (DestRect.Bottom - DestRect.Top) * 1000 div (SrcRect.Bottom - SrcRect.Top);

    if DestRect.Top < 0 then
    begin
      SrcRect.Top := -DestRect.Top * 1000 div YScaleRatio;
      DestRect.Top := 0;
    end;

    if DestRect.Left < 0 then
    begin
      SrcRect.Left := -DestRect.Left * 1000 div XScaleRatio;
      DestRect.Left := 0;
    end;

    if DestRect.Right > Integer(FTargetSurface.SurfaceDesc.dwWidth) then
    begin
      SrcRect.Right := Integer(FSurface.SurfaceDesc.dwWidth) - ((DestRect.Right - Integer(FTargetSurface.SurfaceDesc.dwWidth)) * 1000 div XScaleRatio);
      DestRect.Right := FTargetSurface.SurfaceDesc.dwWidth;
    end;

    if DestRect.Bottom > Integer(FTargetSurface.SurfaceDesc.dwHeight) then
    begin
      SrcRect.Bottom := Integer(FSurface.SurfaceDesc.dwHeight) - ((DestRect.Bottom - Integer(FTargetSurface.SurfaceDesc.dwHeight)) * 1000 div YScaleRatio);
      DestRect.Bottom := FTargetSurface.SurfaceDesc.dwHeight;
    end;

    {  Forwarding former arrangement  }
    if (FDDraw.DriverCaps.dwCaps and DDCAPS_ALIGNBOUNDARYSRC <> 0) and (FDDraw.DriverCaps.dwAlignBoundarySrc <> 0) then
    begin
      SrcRect.Left := (SrcRect.Left + Integer(FDDraw.DriverCaps.dwAlignBoundarySrc) div 2) div
        Integer(FDDraw.DriverCaps.dwAlignBoundarySrc) * Integer(FDDraw.DriverCaps.dwAlignBoundarySrc);
    end;

    if (FDDraw.DriverCaps.dwCaps and DDCAPS_ALIGNSIZESRC <> 0) and (FDDraw.DriverCaps.dwAlignSizeSrc <> 0) then
    begin
      SrcRect.Right := SrcRect.Left + (SrcRect.Right - SrcRect.Left + Integer(FDDraw.DriverCaps.dwAlignSizeSrc) div 2) div
        Integer(FDDraw.DriverCaps.dwAlignSizeSrc) * Integer(FDDraw.DriverCaps.dwAlignSizeSrc);
    end;

    {  Forwarding destination arrangement  }
    if (FDDraw.DriverCaps.dwCaps and DDCAPS_ALIGNBOUNDARYDEST <> 0) and (FDDraw.DriverCaps.dwAlignBoundaryDest <> 0) then
    begin
      DestRect.Left := (DestRect.Left + Integer(FDDraw.DriverCaps.dwAlignBoundaryDest) div 2) div
        Integer(FDDraw.DriverCaps.dwAlignBoundaryDest) * Integer(FDDraw.DriverCaps.dwAlignBoundaryDest);
    end;

    if (FDDraw.DriverCaps.dwCaps and DDCAPS_ALIGNSIZEDEST <> 0) and (FDDraw.DriverCaps.dwAlignSizeDest <> 0) then
    begin
      DestRect.Right := DestRect.Left + (DestRect.Right - DestRect.Left) div
        Integer(FDDraw.DriverCaps.dwAlignSizeDest) * Integer(FDDraw.DriverCaps.dwAlignSizeDest);
    end;

    {  Color key setting  }
    if FDDraw.DriverCaps.dwCKeyCaps and DDCKEYCAPS_DESTOVERLAY <> 0 then
    begin
      OverlayFX.dckDestColorkey.dwColorSpaceLowValue := FTargetSurface.ColorMatch(FOverlayColorKey);
      OverlayFX.dckDestColorkey.dwColorSpaceHighValue := OverlayFX.dckDestColorkey.dwColorSpaceLowValue;

      OverlayFlags := OverlayFlags or (DDOVER_KEYDESTOVERRIDE or DDOVER_DDFX);
    end;

    FSurface.ISurface.UpdateOverlay(SrcRect, FTargetSurface.ISurface, DestRect, OverlayFlags, OverlayFX);
  end;
end;

procedure TDirectDrawOverlay.SetVisible(Value: Boolean);
begin
  FVisible := False;
  if FSurface <> nil then
  begin
    if FVisible then
      SetOverlayRect(FOverlayRect)
    else
      FSurface.ISurface.UpdateOverlay(PRect(nil)^, FTargetSurface.ISurface, PRect(nil)^, DDOVER_HIDE, PDDOverlayFX(nil)^);
  end;
end;

//新加


{---------------------------------TFastDIBFontList----------------------------------}

constructor TImageFont.Create();
begin
  FreeOutTimeTick := GetTickCount;
  FreeFontTextOutTimeTick := GetTickCount;
  FontList := TList.Create;
  FontTextList := TList.Create;
end;

destructor TImageFont.Destroy;
begin
  Clear;
  FontList.Free;
  FontTextList.Free;
  inherited;
end;

procedure TImageFont.Clear;
var
  I: Integer;
  TextureFont: pTFastDIBFont;
  FontText: pTFontText;
begin
  for I := 0 to FontList.Count - 1 do begin
    TextureFont := FontList.Items[I];
    FreeMem(TextureFont.Data);
    Dispose(TextureFont);
  end;
  FontList.Clear;

  for I := 0 to FontTextList.Count - 1 do begin
    FontText := FontTextList.Items[I];
    FontText.Font.Free;
    Dispose(FontText);
  end;
  FontTextList.Clear;
end;

function TImageFont.GetCount: Integer;
begin
  Result := FontList.Count;
end;

procedure TImageFont.FreeOutTime;
var
  I: Integer;
  TextureFont: pTFastDIBFont;
  FontText: pTFontText;
begin
  if (GetTickCount - FreeOutTimeTick > 1000 * 30) then begin
    FreeOutTimeTick := GetTickCount;
    for I := FontList.Count - 1 downto 0 do begin
      TextureFont := FontList.Items[I];
      if (GetTickCount - TextureFont.Time > 1000 * 60 * 5) then begin    //2分钟释放
        FontList.Delete(I);
        FreeMem(TextureFont.Data);
        Dispose(TextureFont);
      end;
    end;
  end;
end;

procedure TImageFont.FreeFontTextOutTime;
var
  I: Integer;
  FontText: pTFontText;
begin
  if (GetTickCount - FreeFontTextOutTimeTick > 1000 * 30) then begin
    FreeFontTextOutTimeTick := GetTickCount;

    for I := FontTextList.Count - 1 downto 0 do begin
      FontText := FontTextList.Items[I];
      if (GetTickCount - FontText.Time > 1000 * 60 * 5) then begin
        FontTextList.Delete(I);
        FontText.Font.Free;
        Dispose(FontText);
      end;
    end;
  end;
end;

function TImageFont.TextWidth(const Text: string): Integer;
var
  tm: TEXTMETRIC;
  HHDC: hdc;
  tempDC: hdc;
  Point: Size;
begin
 // 创建兼容DC并选入字体          TextWidth(Text), DIB.TextHeight
  tempDC := GetDC(MainForm.Handle);
  HHDC := CreateCompatibleDC(tempDC);

  SelectObject(HHDC, MainForm.Canvas.Font.Handle);

  Windows.GetTextExtentPoint32(HHDC, PChar(Text), Length(Text), Point);
  Result := Point.cx;
  //nHeight := Point.cy;
  DeleteDC(HHDC);
  ReleaseDC(0, tempDC);
end;

function TImageFont.TextHeight(const Text: string): Integer;
var
  HHDC: hdc;
  tempDC: hdc;
  Point: Size;
begin
 // 创建兼容DC并选入字体          TextWidth(Text), DIB.TextHeight
  tempDC := GetDC(MainForm.Handle);
  HHDC := CreateCompatibleDC(tempDC);

  SelectObject(HHDC, MainForm.Canvas.Font.Handle);

  Windows.GetTextExtentPoint32(HHDC, PChar(Text), Length(Text), Point);
  // Point.cx;
  Result := Point.cy;
  DeleteDC(HHDC);
  ReleaseDC(0, tempDC);
end;

function TImageFont.GetTextDIB(Text: string; FColor, Bcolor: TColor): TDirectDrawSurface;
var
  I: Integer;
  FontText: pTFontText;
begin
  Result := nil;
  for I := 0 to FontTextList.Count - 1 do begin
    FontText := FontTextList.Items[I];
    if (CompareStr(FontText.Text, Text) = 0) and
      (CompareText(MainForm.Canvas.Font.Name, FontText.Name) = 0) and
      (MainForm.Canvas.Font.Size = FontText.Size) and
      (MainForm.Canvas.Font.Style = FontText.Style) and
      (FColor = FontText.FColor) and
      (BColor = FontText.BColor) then begin
      FontText.Time := GetTickCount;
      Result := FontText.Font;
    end;
  end;
  FreeFontTextOutTime;
end;

function TImageFont.GetTextData(Text: string): pTFastDIBFont;
var
  BitmapInfo: TBitmapInfo;
  Data: Pointer;
  HHBitmap: HBitmap;
  HHDC: hdc;
  tempDC: hdc;
  Point: Size;
  nWidth, nHeight: Integer;
  I, II: Integer;
  DstP: PByte;
  RGBQuad: PRGBQuad;
  TextureFont: pTFastDIBFont;

  FontStyle: TFontStyles;
begin
  Result := nil;
  FontStyle := MainForm.Canvas.Font.Style;
  if fsUnderline in MainForm.Canvas.Font.Style then begin
    MainForm.Canvas.Font.Style := MainForm.Canvas.Font.Style - [fsUnderline];
  end;

  for I := 0 to FontList.Count - 1 do begin
    TextureFont := FontList.Items[I];
    if (CompareStr(TextureFont.Text, Text) = 0) and
      (CompareText(MainForm.Canvas.Font.Name, TextureFont.Name) = 0) and
      (MainForm.Canvas.Font.Size = TextureFont.Size) and (MainForm.Canvas.Font.Style = TextureFont.Style) then begin
      TextureFont.Time := GetTickCount;
      if fsUnderline in FontStyle then begin
        MainForm.Canvas.Font.Style := MainForm.Canvas.Font.Style + [fsUnderline];
      end;
      Result := TextureFont;
      Exit;
    end;
  end;

  FreeOutTime; //释放5分钟没有使用的数据

 // 创建兼容DC并选入字体


  tempDC := GetDC(MainForm.Handle);
  HHDC := CreateCompatibleDC(tempDC);

  SelectObject(HHDC, MainForm.Canvas.Font.Handle);

  Windows.GetTextExtentPoint32(HHDC, PChar(Text), Length(Text), Point);
  nWidth := Point.cx;
  nHeight := Point.cy;

  with BitmapInfo.bmiHeader do begin
  //位图信息头
    biSize := SizeOf(BitmapInfo.bmiHeader);
    biWidth := nWidth;
    biHeight := nHeight;
    biPlanes := 1;
    biBitCount := 32;
    biCompression := BI_RGB;
    biSizeImage := 0;
    biXPelsPerMeter := 0;
    biYPelsPerMeter := 0;
    biClrUsed := 0;
    biClrImportant := 0;
  end;

  //创建字符位图
  HHBitmap := CreateDIBSection(HHDC, BitmapInfo, DIB_RGB_COLORS, Data, 0, 0);
  SelectObject(HHDC, HHBitmap); //将字符位图选入DC
  SetTextColor(HHDC, RGB(255, 255, 255)); //设文字颜色为白色
  SetBkColor(HHDC, RGB(0, 0, 0)); //设背景颜色为黑色
  Windows.TextOut(HHDC, 0, 0, PChar(Text), Length(Text));

  New(Result);
  Result.Name := MainForm.Canvas.Font.Name;
  Result.Size := MainForm.Canvas.Font.Size;
  Result.Style := MainForm.Canvas.Font.Style;

  GetMem(Result.Data, nWidth * nHeight + 4);
  Result.Text := Text;
  Result.Width := nWidth;
  Result.Height := nHeight;
  Result.Time := GetTickCount;

  for I := nHeight - 1 downto 0 do begin //32位转换成8位的数据
    RGBQuad := PRGBQuad(Integer(Data) + (nHeight - 1 - I) * nWidth * 4);
    DstP := PByte(Integer(Result.Data) + I * nWidth);
    for II := 0 to nWidth - 1 do begin
      if not (Integer(RGBQuad^) = 0) then begin
        PByte(DstP)^ := 255;
      end else begin
        PByte(DstP)^ := 0;
      end;
      Inc(RGBQuad);
      Inc(DstP);
    end;
  end;

  DeleteObject(HHBitmap);
  DeleteDC(HHDC);
  ReleaseDC(0, tempDC);
  FontList.Add(Result);
  if fsUnderline in FontStyle then begin
    MainForm.Canvas.Font.Style := MainForm.Canvas.Font.Style + [fsUnderline];
  end;
end;

//8位字符点阵数据绘制到16位数据

procedure TImageFont.DrawFont(pSrc, pDst: PByte; nPitch, nWidth, nHeight: Integer; Color: TColor);
var
  nX, nY, I, k: Integer;
  SrcP: PByte;
  DstP: PWord;
  nCol64: Int64;
  wColor: Word;

  nSSEM, nSSEW: Integer;
  nMMXM, nMMXW: Integer;
begin
  wColor := RGB16(Color);
  nCol64 := Bit16To64(wColor);

  if IsSSE then begin
    nSSEM := nWidth mod 8;
    nSSEW := nWidth div 8;
  end else begin
    nSSEM := 0;
    nSSEW := 0;
  end;

  if nSSEW > 0 then begin
    nMMXM := nSSEM mod 4;
    nMMXW := nSSEM div 4;
  end else begin
    nMMXM := nWidth mod 4;
    nMMXW := nWidth div 4;
  end;

  for nY := 0 to nHeight - 1 do begin
    SrcP := PByte(Integer(pSrc) + nWidth * nY);
    DstP := PWord(Integer(pDst) + nPitch * nY);
    k := nWidth;

    if IsSSE then begin
      for nX := 0 to nSSEW - 1 do begin
        asm
         mov edx, DstP // edx = 目的指针
         mov ecx, SrcP // ecx = 字符点阵数据指针
         movdqu xmm0, [edx] // 目的颜色
         movq xmm7, [ecx] // mm7 = 8位字符点阵数据
         movlps xmm1, nCol64		// 64位颜色键
         movhps xmm1, nCol64		// 64位颜色键
         punpcklbw xmm7, xmm7 // 8位点阵数据扩展为128位

         pand xmm1, xmm7 // 不绘点的源颜色值清0
         psubusw xmm0, xmm7 // 待绘点的目的颜色清0
         por xmm0, xmm1 // 相或得结果颜色

         add ecx, 8
         movdqu [edx], xmm0 // 写入4个象素
         add edx, 16
         sub k, 8

         mov integer ptr[SrcP], ecx
         mov integer ptr[DstP], edx

        end;
      end;
    end;

    for nX := 0 to nMMXW - 1 do begin
      asm
         mov edx, DstP // edx = 目的指针
         mov ecx, SrcP // ecx = 字符点阵数据指针
         movq mm0, [edx] // 目的颜色
         movd mm7, [ecx] // mm7 = 8位字符点阵数据
         movq mm1, nCol64 // mm1 = 64位颜色值
         punpcklbw mm7, mm7 // 8位点阵数据扩展为16位

         pand mm1, mm7 // 不绘点的源颜色值清0
         psubusw mm0, mm7 // 待绘点的目的颜色清0
         por mm0, mm1 // 相或得结果颜色

         add ecx, 4
         movq [edx], mm0 // 写入4个象素
         add edx, 8
         sub k, 4

         mov integer ptr[SrcP], ecx
         mov integer ptr[DstP], edx
      end;
    end;

    asm
       emms
    end;
    for I := 0 to k - 1 do begin //剩余处理
      if SrcP^ <> 0 then DstP^ := wColor;
      Inc(SrcP);
      Inc(DstP);
    end;
  end;

end;
function TImageFont.ClipRect(var DestRect: TRect; const DestRect2: TRect): Boolean;
begin
  with DestRect do
  begin
    Left := Max(Left, DestRect2.Left);
    Right := Min(Right, DestRect2.Right);
    Top := Max(Top, DestRect2.Top);
    Bottom := Min(Bottom, DestRect2.Bottom);

    Result := (Left < Right) and (Top < Bottom);
  end;
end;
procedure TImageFont.DrawRect(DIB: TDirectDrawSurface;
  Rect: TRect; X, Y: Integer; const Text: string;
  FColor: TColor; BColor: TColor);
var
  I: Integer;
  S: string;
  sText: WideString;

  nX, nWidth, nHeight, nPitch: Integer;

  TextureFont: pTFastDIBFont;
  AChar: Char;

  SourceRect, SrcRect, DestRect: TRect;
  pSrc: PByte;
  pDst: PByte;
  SrcP: PByte;
  DstP: PByte;

  Source: TDirectDrawSurface;
  FontText: pTFontText;
  SrcDDSD: TDDSurfaceDesc2;
begin
  if Text = '' then Exit;
  SourceRect := Rect;
  if ClipRect(SourceRect, DIB.ClientRect) then begin
    if FColor = clBlack then FColor := $00050505;

    Source := GetTextDIB(Text, FColor, Bcolor);
    if Source = nil then begin
      nX := 0;
      sText := Text;

      Source := TDirectDrawSurface.Create(MainFormDxDraw.DDraw);
      Source.SystemMemory := True;
      Source.SetSize(TextWidth(Text), TextHeight('0'));
      New(FontText);
      FontText.Font := Source;
      FontText.Text := Text;
      FontText.Time := GetTickCount;
      FontText.Name := MainForm.Canvas.Font.Name;
      FontText.Size := MainForm.Canvas.Font.Size;
      FontText.Style := MainForm.Canvas.Font.Style;
      FontText.FColor := FColor;
      FontText.BColor := BColor;
      FontTextList.Add(FontText);

      SrcDDSD.dwSize := SizeOf(SrcDDSD);
      Source.Lock(TRect(nil^), SrcDDSD);
      try
        pDst := SrcDDSD.lpSurface;
        nPitch := SrcDDSD.lPitch;
        DestRect := Source.ClientRect;
        if BColor <> clBlack then Source.FastFill(BColor);

        for I := 1 to Length(sText) do begin
          S := sText[I];
          AChar := S[1];
          if (Ord(AChar) > 32) then begin //可见字符
            TextureFont := GetTextData(S);
            pSrc := TextureFont.Data;
            SrcRect := Bounds(0, 0, TextureFont.Width, TextureFont.Height);

            nWidth := SrcRect.Right - SrcRect.Left;
            nHeight := SrcRect.Bottom - SrcRect.Top;
            SrcP := PByte(Integer(pSrc) + SrcRect.Top * TextureFont.Width + SrcRect.Left);
            DstP := PByte(Integer(pDst) + (DestRect.Left + nX) * 2);

            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, FColor);
            Inc(nX, nWidth);

          end else begin
            Inc(nX, TextWidth(S));
          end;
        end;
      finally
        Source.UnLock();
      end;
      if fsUnderline in MainForm.Canvas.Font.Style then begin
        Source.FastFillRect(Bounds(0, Source.Height - 1, Source.Width, Source.Height), FColor);
      end;
    end;

    DIB.Draw(SourceRect.Left, Y, Bounds(SourceRect.Left - X, 0, SourceRect.Right - SourceRect.Left, SourceRect.Bottom - SourceRect.Top), Source);
  end;
end;

procedure TImageFont.DrawRect(DIB: TDirectDrawSurface;
  X, Y: Integer; Rect: TRect; const Text: string;
  FColor: TColor; BColor: TColor);
var
  I: Integer;
  S: string;
  sText: WideString;

  nX, nWidth, nHeight, nPitch: Integer;

  TextureFont: pTFastDIBFont;
  AChar: Char;

  SourceRect, SrcRect, DestRect: TRect;
  pSrc: PByte;
  pDst: PByte;
  SrcP: PByte;
  DstP: PByte;

  Source: TDirectDrawSurface;
  FontText: pTFontText;
  SrcDDSD: TDDSurfaceDesc2;
begin
  if Text = '' then Exit;
  SourceRect := Rect;
  //if ClipRect(SourceRect, DIB.ClientRect) then begin
    if FColor = clBlack then FColor := $00050505;

    Source := GetTextDIB(Text, FColor, Bcolor);
    if Source = nil then begin
      nX := 0;
      sText := Text;

      Source := TDirectDrawSurface.Create(MainFormDxDraw.DDraw);
      Source.SystemMemory := True;
      Source.SetSize(TextWidth(Text), TextHeight('0'));
      New(FontText);
      FontText.Font := Source;
      FontText.Text := Text;
      FontText.Time := GetTickCount;
      FontText.Name := MainForm.Canvas.Font.Name;
      FontText.Size := MainForm.Canvas.Font.Size;
      FontText.Style := MainForm.Canvas.Font.Style;
      FontText.FColor := FColor;
      FontText.BColor := BColor;
      FontTextList.Add(FontText);
      {pDst := Source.PBits;
      nPitch := Source.Pitch; }
      SrcDDSD.dwSize := SizeOf(SrcDDSD);
      Source.Lock(TRect(nil^), SrcDDSD);
      try
        pDst := SrcDDSD.lpSurface;
        nPitch := SrcDDSD.lPitch;

        DestRect := Source.ClientRect;
        if BColor <> clBlack then Source.FastFill(BColor);

        for I := 1 to Length(sText) do begin
          S := sText[I];
          AChar := S[1];
          if (Ord(AChar) > 32) then begin //可见字符
            TextureFont := GetTextData(S);
            pSrc := TextureFont.Data;
            SrcRect := Bounds(0, 0, TextureFont.Width, TextureFont.Height);

            nWidth := SrcRect.Right - SrcRect.Left;
            nHeight := SrcRect.Bottom - SrcRect.Top;
            SrcP := PByte(Integer(pSrc) + SrcRect.Top * TextureFont.Width + SrcRect.Left);
            DstP := PByte(Integer(pDst) + (DestRect.Left + nX) * 2);

            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, FColor);
            Inc(nX, nWidth);

          end else begin
            Inc(nX, TextWidth(S));
          end;
        end;
      finally
        Source.UnLock();
      end;
      if fsUnderline in MainForm.Canvas.Font.Style then begin
        Source.FastFillRect(Bounds(0, Source.Height - 1, Source.Width, Source.Height), FColor);
      end;
    end;
    DIB.Draw(X, Y, SourceRect, Source);
//end;
end;

procedure TImageFont.BoldDrawRect(DIB: TDirectDrawSurface;
  Rect: TRect; X, Y: Integer; const Text: string;
  FColor: TColor; BColor: TColor);
var
  I: Integer;
  S: string;
  sText: WideString;

  nX, nWidth, nHeight, nPitch: Integer;

  TextureFont: pTFastDIBFont;
  AChar: Char;

  SourceRect, SrcRect, DestRect, ClientRect: TRect;
  pSrc: PByte;
  pDst: PByte;
  SrcP: PByte;
  DstP: PByte;

  Source: TDirectDrawSurface;
  FontText: pTFontText;
  SrcDDSD: TDDSurfaceDesc2;
begin
  if Text = '' then Exit;
  SourceRect := Rect;
  if ClipRect(SourceRect, DIB.ClientRect) then begin
    if FColor = clBlack then FColor := $00202020;
    if BColor = clBlack then BColor := $00202020;

    Source := GetTextDIB(Text, FColor, Bcolor);
    if Source = nil then begin
      sText := Text;
      nX := 0;
      Source := TDirectDrawSurface.Create(MainFormDxDraw.DDraw);
      Source.SystemMemory := True;
      Source.SetSize(TextWidth(Text) + 2, TextHeight('0') + 2);
      New(FontText);
      FontText.Font := Source;
      FontText.Text := Text;
      FontText.Time := GetTickCount;
      FontText.Name := MainForm.Canvas.Font.Name;
      FontText.Size := MainForm.Canvas.Font.Size;
      FontText.Style := MainForm.Canvas.Font.Style;
      FontText.FColor := FColor;
      FontText.BColor := BColor;
      FontTextList.Add(FontText);

      {pDst := Source.PBits;
      nPitch := Source.Pitch;  }
      SrcDDSD.dwSize := SizeOf(SrcDDSD);
      Source.Lock(TRect(nil^), SrcDDSD);
      try
        pDst := SrcDDSD.lpSurface;
        nPitch := SrcDDSD.lPitch;

        DestRect := Source.ClientRect;

        for I := 1 to Length(sText) do begin
          S := sText[I];
          AChar := S[1];
          if (Ord(AChar) > 32) then begin //可见字符
            TextureFont := GetTextData(S);
            pSrc := TextureFont.Data;
            SrcRect := Bounds(0, 0, TextureFont.Width, TextureFont.Height);
            ClientRect := SrcRect;

            nWidth := SrcRect.Right - SrcRect.Left;
            nHeight := SrcRect.Bottom - SrcRect.Top;

            SrcP := PByte(Integer(pSrc) + SrcRect.Top * TextureFont.Width + SrcRect.Left);

            DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX) * 2);
            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

            DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX + 2) * 2);
            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

            DstP := PByte(Integer(pDst) + DestRect.Top * nPitch + (DestRect.Left + nX + 1) * 2);
            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

            DstP := PByte(Integer(pDst) + (DestRect.Top + 2) * nPitch + (DestRect.Left + nX + 1) * 2);
            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

            DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX + 1) * 2);
            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, FColor);

            Inc(nX, nWidth);

          end else begin
            Inc(nX, TextWidth(S));
          end;
        end;
      finally
        Source.UnLock();
      end;
      if fsUnderline in MainForm.Canvas.Font.Style then begin
        Source.FastFillRect(Bounds(0, Source.Height - 1, Source.Width, Source.Height), FColor);
      end;
    end;
    DIB.Draw(SourceRect.Left, Y, Bounds(SourceRect.Left - X, 0, SourceRect.Right - SourceRect.Left, SourceRect.Bottom - SourceRect.Top), Source);
    //DIB.Draw(X, Y, Source.ClientRect, Source);
  end;
end;


procedure TImageFont.BoldDrawRectAlpha(DIB: TDirectDrawSurface;
  Rect: TRect; X, Y: Integer; const Text: string;
  FColor: TColor; BColor: TColor; Alpha: Integer);
var
  I: Integer;
  S: string;
  sText: WideString;

  nX, nWidth, nHeight, nPitch: Integer;

  TextureFont: pTFastDIBFont;
  AChar: Char;

  SourceRect, SrcRect, DestRect, ClientRect: TRect;
  pSrc: PByte;
  pDst: PByte;
  SrcP: PByte;
  DstP: PByte;

  Source: TDirectDrawSurface;
  FontText: pTFontText;
  SrcDDSD: TDDSurfaceDesc2;
begin
  if Text = '' then Exit;
  SourceRect := Rect;
  if ClipRect(SourceRect, DIB.ClientRect) then begin
    if FColor = clBlack then FColor := $00202020;
    if BColor = clBlack then BColor := $00202020;

    Source := GetTextDIB(Text, FColor, Bcolor);
    if Source = nil then begin
      sText := Text;
      nX := 0;
      Source := TDirectDrawSurface.Create(MainFormDxDraw.DDraw);
      Source.SystemMemory := True;
      Source.SetSize(TextWidth(Text) + 2, TextHeight('0') + 2);
      New(FontText);
      FontText.Font := Source;
      FontText.Text := Text;
      FontText.Time := GetTickCount;
      FontText.Name := MainForm.Canvas.Font.Name;
      FontText.Size := MainForm.Canvas.Font.Size;
      FontText.Style := MainForm.Canvas.Font.Style;
      FontText.FColor := FColor;
      FontText.BColor := BColor;
      FontTextList.Add(FontText);

      {pDst := Source.PBits;
      nPitch := Source.Pitch;  }
      SrcDDSD.dwSize := SizeOf(SrcDDSD);
      Source.Lock(TRect(nil^), SrcDDSD);
      try
        pDst := SrcDDSD.lpSurface;
        nPitch := SrcDDSD.lPitch;

        DestRect := Source.ClientRect;

        for I := 1 to Length(sText) do begin
          S := sText[I];
          AChar := S[1];
          if (Ord(AChar) > 32) then begin //可见字符
            TextureFont := GetTextData(S);
            pSrc := TextureFont.Data;
            SrcRect := Bounds(0, 0, TextureFont.Width, TextureFont.Height);
            ClientRect := SrcRect;

            nWidth := SrcRect.Right - SrcRect.Left;
            nHeight := SrcRect.Bottom - SrcRect.Top;

            SrcP := PByte(Integer(pSrc) + SrcRect.Top * TextureFont.Width + SrcRect.Left);

            DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX) * 2);
            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

            DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX + 2) * 2);
            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

            DstP := PByte(Integer(pDst) + DestRect.Top * nPitch + (DestRect.Left + nX + 1) * 2);
            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

            DstP := PByte(Integer(pDst) + (DestRect.Top + 2) * nPitch + (DestRect.Left + nX + 1) * 2);
            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

            DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX + 1) * 2);
            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, FColor);

            Inc(nX, nWidth);

          end else begin
            Inc(nX, TextWidth(S));
          end;
        end;
      finally
        Source.UnLock();
      end;
      if fsUnderline in MainForm.Canvas.Font.Style then begin
        Source.FastFillRect(Bounds(0, Source.Height - 1, Source.Width, Source.Height), FColor);
      end;
    end;
    DIB.FastDrawAlpha(Bounds(x, y, Source.Width, Source.Height), Source.ClientRect, Source, True, Alpha);
  end;
end;

procedure TImageFont.BoldDrawRect(DIB: TDirectDrawSurface; X, Y: Integer; Rect: TRect;
  const Text: string; FColor: TColor; BColor: TColor);
var
  I: Integer;
  S: string;
  sText: WideString;

  nX, nWidth, nHeight, nPitch: Integer;

  TextureFont: pTFastDIBFont;
  AChar: Char;

  SourceRect, SrcRect, DestRect, ClientRect: TRect;
  pSrc: PByte;
  pDst: PByte;
  SrcP: PByte;
  DstP: PByte;

  Source: TDirectDrawSurface;
  FontText: pTFontText;
  SrcDDSD: TDDSurfaceDesc2;
begin
  if Text = '' then Exit;
  SourceRect := Rect;
  if ClipRect(SourceRect, DIB.ClientRect) then begin
    if FColor = clBlack then FColor := $00202020;

    Source := GetTextDIB(Text, FColor, Bcolor);
    if Source = nil then begin
      sText := Text;
      nX := 0;
      Source := TDirectDrawSurface.Create(MainFormDxDraw.DDraw);
      Source.SystemMemory := True;
      Source.SetSize(TextWidth(Text) + 2, TextHeight('0') + 2);
      New(FontText);
      FontText.Font := Source;
      FontText.Text := Text;
      FontText.Time := GetTickCount;
      FontText.Name := MainForm.Canvas.Font.Name;
      FontText.Size := MainForm.Canvas.Font.Size;
      FontText.Style := MainForm.Canvas.Font.Style;
      FontText.FColor := FColor;
      FontText.BColor := BColor;
      FontTextList.Add(FontText);

      {pDst := Source.PBits;
      nPitch := Source.Pitch; }
      SrcDDSD.dwSize := SizeOf(SrcDDSD);
      Source.Lock(TRect(nil^), SrcDDSD);
      try
        pDst := SrcDDSD.lpSurface;
        nPitch := SrcDDSD.lPitch;

        DestRect := Source.ClientRect;

        for I := 1 to Length(sText) do begin
          S := sText[I];
          AChar := S[1];
          if (Ord(AChar) > 32) then begin //可见字符
            TextureFont := GetTextData(S);
            pSrc := TextureFont.Data;
            SrcRect := Bounds(0, 0, TextureFont.Width, TextureFont.Height);
            ClientRect := SrcRect;

            nWidth := SrcRect.Right - SrcRect.Left;
            nHeight := SrcRect.Bottom - SrcRect.Top;

            SrcP := PByte(Integer(pSrc) + SrcRect.Top * TextureFont.Width + SrcRect.Left);

            DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX) * 2);
            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

            DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX + 2) * 2);
            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

            DstP := PByte(Integer(pDst) + DestRect.Top * nPitch + (DestRect.Left + nX + 1) * 2);
            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

            DstP := PByte(Integer(pDst) + (DestRect.Top + 2) * nPitch + (DestRect.Left + nX + 1) * 2);
            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

            DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX + 1) * 2);
            DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, FColor);

            Inc(nX, nWidth);

          end else begin
            Inc(nX, TextWidth(S));
          end;
        end;
      finally
        Source.UnLock();
      end;
      if fsUnderline in MainForm.Canvas.Font.Style then begin
        Source.FastFillRect(Bounds(0, Source.Height - 1, Source.Width, Source.Height), FColor);
      end;
    end;
    DIB.Draw(X, Y, SourceRect, Source);
  end;
end;

procedure TImageFont.Draw(DIB: TDirectDrawSurface; X, Y: Integer; const Text: string; FColor: TColor; BColor: TColor);
var
  I: Integer;
  S: string;
  sText: WideString;

  nX, nWidth, nHeight, nPitch: Integer;

  TextureFont: pTFastDIBFont;
  AChar: Char;

  SrcRect, DestRect: TRect;
  pSrc: PByte;
  pDst: PByte;
  SrcP: PByte;
  DstP: PByte;

  Source: TDirectDrawSurface;
  FontText: pTFontText;
  SrcDDSD: TDDSurfaceDesc2;
begin
  if Text = '' then Exit;

  if FColor = clBlack then FColor := $00050505;

  Source := GetTextDIB(Text, FColor, Bcolor);
  if Source = nil then begin
    nX := 0;
    sText := Text;

    Source := TDirectDrawSurface.Create(MainFormDxDraw.DDraw);
    Source.SystemMemory := True;
    Source.SetSize(TextWidth(Text), TextHeight('0'));
    New(FontText);
    FontText.Font := Source;
    FontText.Text := Text;
    FontText.Time := GetTickCount;
    FontText.Name := MainForm.Canvas.Font.Name;
    FontText.Size := MainForm.Canvas.Font.Size;
    FontText.Style := MainForm.Canvas.Font.Style;
    FontText.FColor := FColor;
    FontText.BColor := BColor;
    FontTextList.Add(FontText);
    {pDst := Source.PBits;
    nPitch := Source.Pitch;  }
    SrcDDSD.dwSize := SizeOf(SrcDDSD);
    Source.Lock(TRect(nil^), SrcDDSD);
    try
      pDst := SrcDDSD.lpSurface;
      nPitch := SrcDDSD.lPitch;

      DestRect := Source.ClientRect;
      if BColor <> clBlack then Source.Fill(BColor);

      for I := 1 to Length(sText) do begin
        S := sText[I];
        AChar := S[1];
        if (Ord(AChar) > 32) then begin //可见字符
          TextureFont := GetTextData(S);
          pSrc := TextureFont.Data;
          SrcRect := Bounds(0, 0, TextureFont.Width, TextureFont.Height);

          nWidth := SrcRect.Right - SrcRect.Left;
          nHeight := SrcRect.Bottom - SrcRect.Top;
          SrcP := PByte(Integer(pSrc) + SrcRect.Top * TextureFont.Width + SrcRect.Left);
          DstP := PByte(Integer(pDst) + (DestRect.Left + nX) * 2);

          DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, FColor);
          Inc(nX, nWidth);

        end else begin
          Inc(nX, TextWidth(S));
        end;
      end;
    finally
      Source.UnLock();
    end;
    if fsUnderline in MainForm.Canvas.Font.Style then begin
      Source.FastFillRect(Bounds(0, Source.Height - 1, Source.Width, Source.Height), FColor);
    end;
  end;

  DIB.Draw(X, Y, Source.ClientRect, Source);
end;

procedure TImageFont.BoldDraw(DIB: TDirectDrawSurface; X, Y: Integer; const Text: string; FColor: TColor = clWhite; Bcolor: TColor = clBlack);
var
  I: Integer;
  S: string;
  sText: WideString;

  nX, nWidth, nHeight, nPitch: Integer;

  TextureFont: pTFastDIBFont;
  AChar: Char;

  SrcRect, DestRect, ClientRect: TRect;
  pSrc: PByte;
  pDst: PByte;
  SrcP: PByte;
  DstP: PByte;

  Source: TDirectDrawSurface;
  FontText: pTFontText;
  SrcDDSD: TDDSurfaceDesc2;
begin
  if Text = '' then Exit;

  if FColor = clBlack then FColor := $00050505;

  Source := GetTextDIB(Text, FColor, Bcolor);
  if Source = nil then begin
    sText := Text;
    nX := 0;
    Source := TDirectDrawSurface.Create(MainFormDxDraw.DDraw);
    Source.SystemMemory := True;
    Source.SetSize(TextWidth(Text) + 2, TextHeight('0') + 2);
    New(FontText);
    FontText.Font := Source;
    FontText.Text := Text;
    FontText.Time := GetTickCount;
    FontText.Name := MainForm.Canvas.Font.Name;
    FontText.Size := MainForm.Canvas.Font.Size;
    FontText.Style := MainForm.Canvas.Font.Style;
    FontText.FColor := FColor;
    FontText.BColor := BColor;
    FontTextList.Add(FontText);

    {pDst := Source.PBits;
    nPitch := Source.Pitch;   }
    SrcDDSD.dwSize := SizeOf(SrcDDSD);
    Source.Lock(TRect(nil^), SrcDDSD);
    try
      pDst := SrcDDSD.lpSurface;
      nPitch := SrcDDSD.lPitch;

      DestRect := Source.ClientRect;

      for I := 1 to Length(sText) do begin
        S := sText[I];
        AChar := S[1];
        if (Ord(AChar) > 32) then begin //可见字符
          TextureFont := GetTextData(S);
          pSrc := TextureFont.Data;
          SrcRect := Bounds(0, 0, TextureFont.Width, TextureFont.Height);
          ClientRect := SrcRect;

          nWidth := SrcRect.Right - SrcRect.Left;
          nHeight := SrcRect.Bottom - SrcRect.Top;

          SrcP := PByte(Integer(pSrc) + SrcRect.Top * TextureFont.Width + SrcRect.Left);

          DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX) * 2);
          DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

          DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX + 2) * 2);
          DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

          DstP := PByte(Integer(pDst) + DestRect.Top * nPitch + (DestRect.Left + nX + 1) * 2);
          DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

          DstP := PByte(Integer(pDst) + (DestRect.Top + 2) * nPitch + (DestRect.Left + nX + 1) * 2);
          DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, Bcolor);

          DstP := PByte(Integer(pDst) + (DestRect.Top + 1) * nPitch + (DestRect.Left + nX + 1) * 2);
          DrawFont(SrcP, DstP, nPitch, nWidth, nHeight, FColor);

          Inc(nX, nWidth);

        end else begin
          Inc(nX, TextWidth(S));
        end;
      end;
    finally
      Source.UnLock();
    end;
    if fsUnderline in MainForm.Canvas.Font.Style then begin
      Source.FastFillRect(Bounds(0, Source.Height - 1, Source.Width, Source.Height), FColor);
    end;
  end;

  DIB.Draw(X, Y, Source.ClientRect, Source);
end;


initialization
finalization
  DirectDrawDrivers.Free;
end.

