{*******************************************************}
{                                                       }
{                      EhLib v5.0                       }
{                    (Build 5.0.00)                     }
{                                                       }
{                TSQLDataEditWin form                   }
{                                                       }
{     Copyright (c) 2004-2009 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit SQLDriverEditEh;

{$I EHLIB.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, DBGridEh, ExtCtrls, Buttons, Mask,
  DBCtrlsEh, DataDriverEh, DB, MemTableEh, MemTableDataEh, SQLEditFrameEh,
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}
{$IFDEF EH_LIB_6}
  Variants,
{$ENDIF}
  Contnrs, Menus, ImgList, StdActns, ActnList, ToolWin, GridsEh;

type

{ TSQLDataEditWin }
  TSQLTreeNode = class;
  TCustomDBService = class;
  TDesignDataBaseEh = class;
  TCustomDBServiceClass = class of TCustomDBService;

(*  IGetSQLTreeNode = interface
  ['{48BFF91A-8FD5-4F69-8938-8251C1B11C3A}']
    function GetSQLTreeNode: TSQLTreeNode;
  end;
*)

  TSQLDataEditWin = class(TForm)
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    Button1: TButton;
    Button2: TButton;
    Splitter1: TSplitter;
    Splitter3: TSplitter;
    Panel6: TPanel;
    Panel7: TPanel;
    DBEditEh1: TDBEditEh;
    sbRefreshTree: TSpeedButton;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    mtParams: TMemTableEh;
    dsParams: TDataSource;
    mtParamsParName: TStringField;
    mtParamsParType: TStringField;
    mtParamsParValue: TStringField;
    gridTreeDetail: TDBGridEh;
    mtTreeDetail: TMemTableEh;
    dsTreeDetail: TDataSource;
    Splitter4: TSplitter;
    Panel3: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Splitter2: TSplitter;
    PanelParams: TPanel;
    gridParams: TDBGridEh;
    Panel5: TPanel;
    Memo1: TMemo;
    Panel8: TPanel;
    bExecute: TButton;
    Panel9: TPanel;
    SpeedButton2: TSpeedButton;
    TabSheet2: TTabSheet;
    FrameInsertSQL: TSQLEditFrame;
    TabSheet3: TTabSheet;
    FrameUpdateSQL: TSQLEditFrame;
    TabSheet4: TTabSheet;
    FrameDeleteSQL: TSQLEditFrame;
    bBuildUpdates: TButton;
    Image1: TImage;
    Panel4: TPanel;
    sbRefresh: TSpeedButton;
    PopupMenu1: TPopupMenu;
    Ggg1: TMenuItem;
    gridDBTree: TDBGridEh;
    dsDBTree: TDataSource;
    mtDBTree: TMemTableEh;
    mtDBTreeName: TStringField;
    mtDBTreeChieldCount: TIntegerField;
    mtDBTreeDescription: TStringField;
    mtDBTreeId: TAutoIncField;
    mtDBTreeRefParent: TIntegerField;
    bCheck: TButton;
    bQueryPlan: TButton;
    spCut: TSpeedButton;
    sbCopy: TSpeedButton;
    spPaste: TSpeedButton;
    sbSelectAll: TSpeedButton;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    ImageList1: TImageList;
    ImageList2: TImageList;
    mtDBTreeImageIndex: TIntegerField;
    TabSheet5: TTabSheet;
    FrameGetRecSQL: TSQLEditFrame;
    tsSpecParams: TTabSheet;
    Panel11: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    MemoUpdateFields: TMemo;
    MemoKeyFields: TMemo;
    Bevel1: TBevel;
    Bevel2: TBevel;
    dbeUpdateTable: TDBEditEh;
    Label3: TLabel;
    Bevel3: TBevel;
    GroupBox1: TGroupBox;
    cbDinaDeleteSQL: TCheckBox;
    cbDinaInsertSQL: TCheckBox;
    cbDinaUpdateSQL: TCheckBox;
    Panel12: TPanel;
    mSpecParams: TMemo;
    Panel10: TPanel;
    Label4: TLabel;
    Bevel4: TBevel;
    bLoadSpecString: TButton;
    Bevel5: TBevel;
    mtDBTreeRefData: TRefObjectField;
    procedure sbRefreshTreeClick(Sender: TObject);
    procedure bExecuteClick(Sender: TObject);
    procedure sbHideShowClick(Sender: TObject);
    procedure Splitter2CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure bBuildUpdatesClick(Sender: TObject);
    procedure MemTableEh1AfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Memo1Exit(Sender: TObject);
    procedure Memo1Enter(Sender: TObject);
    procedure sbRefreshClick(Sender: TObject);
    procedure DBEditEh1EditButtons0Click(Sender: TObject;
      var Handled: Boolean);
    procedure DBEditEh1EditButtons1Click(Sender: TObject;
      var Handled: Boolean);
    procedure Memo1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Memo1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Ggg1Click(Sender: TObject);
    procedure dsDBTreeDataChange(Sender: TObject; Field: TField);
    procedure gridDBTreeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure gridDBTreeStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure bQueryPlanClick(Sender: TObject);
    procedure gridDBTreeColumns0GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
    procedure bLoadSpecStringClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridParamsColumns0UpdateData(Sender: TObject; var Text: string;
      var Value: Variant; var UseText, Handled: Boolean);
  private
    FCharHeight: Integer;
    FSQLCanvas: TControlCanvas;
    FDesignDriver: TCustomSQLDataDriverEh;
    FDataDriver: TCustomSQLDataDriverEh;
    FDesignDataBase: TDesignDataBaseEh;
    procedure SetDesignDataBase(const Value: TDesignDataBaseEh);
//    procedure InsertText(Text: string; AddComma: Boolean = True);
    procedure DrawCaretPosIndicator;
//    procedure SetDataDriver(const Value: TCustomSQLDataDriverEh);
    property DesignDriver: TCustomSQLDataDriverEh read FDesignDriver write FDesignDriver;
    procedure SetObjectTreeParams;
    procedure ResetObjectTreeParams;
//    procedure BuildObjectTree;
    function ExecuteCommand(DataDriver: TCustomSQLDataDriverEh;
      Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
//    function DesignDataBase: TDesignDataBaseEh;
    procedure DesignDatabaseChanged();
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    Panel3Width: Integer;
//    DragSQLTreeNode: IGetSQLTreeNode;
    DragSQLTreeNode: TSQLTreeNode;
    mtDBTreeLoading: Boolean;
    destructor Destroy; override;
    procedure AssignToDesignDriver;
    procedure AssignToDesignControls;
    procedure mtDBTreeExpanding(Sender: TObject; RecordNumber: Integer; var AllowExpansion: Boolean);
    procedure gridTreeDetailColumns0GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
    property DataDriver: TCustomSQLDataDriverEh read FDataDriver write FDataDriver;
    property DesignDataBase: TDesignDataBaseEh read FDesignDataBase write SetDesignDataBase;
  end;

  TParamsArr = array of Variant;

{ TDesignDataBaseEh }

  TDesignDataBaseEh = class(TComponent, IDesignDataBaseEh
{$IFNDEF EH_LIB_6}, IInterfaceComponentReference, IUnknown {$ENDIF}
    )
  protected
    FTreeDataSet: TMemTableEh;
    procedure RemoveFromDesignDataBaseList;
    function GetConnected: Boolean; virtual;
    procedure SetConnected(const Value: Boolean); virtual;
{$IFNDEF EH_LIB_6}
    { IInterfaceComponentReference }
    function IInterfaceComponentReference.GetComponent = IntfGetComponent;
    function IntfGetComponent: TComponent;
{$ENDIF}
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    function BuildObjectTree(List: TList): Boolean; virtual;
    function BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean; virtual;
//    function Connected: Boolean; virtual; abstract;
    function CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh; virtual;
    function CreateReader(SQL: String; FParams: TParamsArr): TDataSet; virtual;
    function DesignDataBaseConnetionEqual(DataDriver: TCustomSQLDataDriverEh): Boolean; virtual;
    function Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; overload; virtual;
    function Execute(SQLText: String; CommandType: TSQLCommandTypeEh; VarParams: Variant; var Cursor: TDataSet): Integer; overload; virtual;
    function GetEngineName: String; virtual;
    function GetServerTypeName: String; virtual;
    function GetFieldList(const TableName: string; DataSet: TDataSet): Boolean; virtual;
    function GetSpecParamsList: String; virtual;
    function SupportCustomSQLDataDriver: Boolean; virtual; abstract;
    function GetCustomDBService: TCustomDBService; virtual;
    function GetIncrementObjectsList: TStrings; virtual;
    function GetObjectTreeDataSet: TDataSet; virtual;
    function CreateTreeDataSet: TMemTableEh; virtual;
    procedure mtDBTreeExpanding(Sender: TObject; RecordNumber: Integer; var AllowExpansion: Boolean);
    procedure BuildQueryPlan(PlanTable: TMemTableEh; Command: TCustomSQLCommandEh); virtual;
    procedure EditDatabaseParams; virtual;
    procedure ResetDesignInfo; virtual;
    procedure AssignFromDesignDataDriver(DesignDataDriver, RuntimeDataDriver: TCustomSQLDataDriverEh); virtual;
    procedure AssignToDesignDataDriver(DesignDataDriver, RuntimeDataDriver: TCustomSQLDataDriverEh); virtual;
    property Connected: Boolean read GetConnected write SetConnected;
  end;

  TDesignDataBaseClassEh = class of TDesignDataBaseEh;

{ Engines unils }

  TAccessEngineEh = class(TObject)
    function AccessEngineName: String; virtual; abstract;
    function CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh;
      DBServiceClass: TCustomDBServiceClass; DataBaseName: String): TDesignDataBaseEh;
        virtual; abstract;
  end;

  TSQLTreeNodeTemplate = class;

  TColumnAtribute = record
    FieldName: String;
    Title: String;
    Width: Integer;
  end;

  TFieldAtribute = record
    FieldName: String;
    FieldType: TMTDataFieldEh;
    Size: Integer;
  end;

  TGetTextEvent = function(Sender: TObject): String of object;

  TServicePopupParam = record
    Text: String;
    OnSelect: TNotifyEvent;
    OnGetMenuText: TGetTextEvent;
    OnGetDataText: TGetTextEvent;
  end;

  TServicePopupParams = array of TServicePopupParam;

  TColumnAttributes = array of TColumnAtribute;

  TFieldAtributesEh = array of TFieldAtribute;

//  TSQLTreeNode = class(TObject, IInterface, IGetSQLTreeNode)
//  TSQLTreeNode = class(TInterfacedObject, IGetSQLTreeNode)
  TSQLTreeNode = class(TObject)
  private
    FOnDragDrop: TDragDropEvent;
    function GetSQLTreeNode: TSQLTreeNode;
  protected
(*
{$IFNDEF CIL}
    { IInterface }
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
{$ENDIF}
*)
  public
    FFullName: String;
    FImageIndex: Integer;
    FMemRec: TMemoryRecordEh;
    FName: String;
    FNodes: TObjectList;
//    FNodes: TInterfaceList;
    FNodesLoaded: Boolean;
    FNodesSelect: String;
    FNodesTemplate: TSQLTreeNodeTemplate;
    FObjId: String;
//    FParent: IGetSQLTreeNode;
    FParent: TSQLTreeNode;
    FTable: TMemTableEh;
    FTableFields: String;
    FTableFilter: String;
    FTypeId: String;
    FParentRecordToTableMode: Boolean;
    PopupParams: TServicePopupParams;
    constructor Create;
    destructor Destroy; override;
//    procedure AddChild(Node: IGetSQLTreeNode);
    procedure AddChild(Node: TSQLTreeNode);
    function GetTable: TMemTableEh;
    property OnDragDrop: TDragDropEvent read FOnDragDrop write FOnDragDrop;
  end;

//  TSQLTreeNodeManager = class;

  TSQLTreeNodeTemplate = class(TObject)
  private
    FName: String;
    FMasterTemplateName: String;
    FNodesMemTableName: String;
    FParams: TParamsArr;
    FNodeManager: TCustomDBService;
    FObjIdFieldName: String;
    FInTreeTextFieldName: String;
    FNodesFilter: String;
//    FNodesFieldsInGrid: String;
    FNodesSQLClassName: String;
//    FFieldAttributes: TFieldAtributesEh;
    FColumnAttributes: TColumnAttributes;
    FOnNodeDragDrop: TDragDropEvent;
    FNodeDropMenuParams: TServicePopupParams;
    FTableNodeDropMenuParams: TServicePopupParams;
    FHasNodes: Boolean;
    FSelectedIndex: Integer;
    FAdditionalLoadSQL: String;
    FColumnAttributesStr: String;
    FAdditionalFielsInfo: String;
    procedure SetColumnAttributes(const Value: String);
  public
    constructor Create(ANodeManager: TCustomDBService;
                       AName: String
{                       ANodesSQLClassName: String;
                       AMasterTemplateName: String;
                       ANodesMemTableName: String;
//                       AParams: TParamsArr;
                       AParams: array of Variant;
                       AObjIdFieldName: String;
                       AInTreeTextFieldName: String;
                       AHasNodes: Boolean;
                       ANodesFilter: String;
                       ANodesFieldsInGrid: String;
                       AColumnAttributes: String = ''; // FieldName, Caption, Width
                       AAdditionalLoadSQL: String = '';
                       AAdditionalFielsInfo: String = '' // FieldName, Type, Width
}
    );
    destructor Destroy; override;
//    function CreateNodes(Parent: TSQLTreeNode): TList; virtual;
//    function CreateNode: IGetSQLTreeNode; virtual;
    function CreateNode: TSQLTreeNode; virtual;
    function DropMenuNodeText(Sender: TObject): String;
    function DropMenuNlCommaNodeText(Sender: TObject): String;
    function DropMenuSelectAstFromName(Sender: TObject): String;
    function DropMenuSelectAllFieldsFromName(Sender: TObject): String;
    function DropDataSelectAllFieldsFromName(Sender: TObject): String;

    function ShowPopup(Source: TObject; Coord: TPoint; Params: TServicePopupParams): Integer;
    procedure TableEditorDrop(Sender, Source: TObject; X, Y: Integer);
    procedure OnPopupClick(Sender: TObject);

    property OnNodeDragDrop: TDragDropEvent read FOnNodeDragDrop write FOnNodeDragDrop;
    property NodeDropMenuParams: TServicePopupParams read FNodeDropMenuParams write FNodeDropMenuParams;

    property NodesSQLClassName: String read FNodesSQLClassName write FNodesSQLClassName;
    property MasterTemplateName: String read FMasterTemplateName write FMasterTemplateName;
    property NodesMemTableName: String read fNodesMemTableName write FNodesMemTableName;
//    property Params: array of Variant read FParams write FParams;
    property ObjIdFieldName: String read FObjIdFieldName write FObjIdFieldName;
    property InTreeTextFieldName: String read FInTreeTextFieldName write FInTreeTextFieldName;
    property HasNodes: Boolean read FHasNodes write FHasNodes;
    property NodesFilter: String read FNodesFilter write FNodesFilter;
//    property NodesFieldsInGrid: String read FNodesFieldsInGrid write FNodesFieldsInGrid;
    property ColumnAttributesStr: String read FColumnAttributesStr write SetColumnAttributes;
    property AdditionalLoadSQL: String read FAdditionalLoadSQL write FAdditionalLoadSQL;
    property AdditionalFielsInfo: String read FAdditionalFielsInfo write FAdditionalFielsInfo;

  end;

{ TDesignUpdateParamsEh }

  TDesignUpdateParamsEh = class(TPersistent)
  private
    FIncremenField: String;
    FIncremenObject: String;
    FTableName: String;
    FKeyFields: TStrings;
    FUpdateFields: TStrings;
    FSelectSQL: TStrings;
    procedure SetKeyFields(const Value: TStrings);
    procedure SetUpdateFields(const Value: TStrings);
    procedure SetSelectSQL(const Value: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    property TableName: String read FTableName write FTableName;
    property IncremenField: String read FIncremenField write FIncremenField;
    property IncremenObject: String read FIncremenObject write FIncremenObject;
    property KeyFields: TStrings read FKeyFields write SetKeyFields;
    property UpdateFields: TStrings read FUpdateFields write SetUpdateFields;
    property SelectSQL: TStrings read FSelectSQL write SetSelectSQL;
  end;

{ TDesignUpdateInfoEh }

  TDesignUpdateInfoEh = class(TPersistent)
  private
    FTableName: String;
    FDeleteSQL: TStrings;
    FGetRecSQL: TStrings;
    FUpdateSQL: TStrings;
    FInsertSQL: TStrings;
    FSpecParams: TStrings;
    FUpdateFields: TStrings;
    FKeyFields: TStrings;
    procedure SetDeleteSQL(const Value: TStrings);
    procedure SetGetRecSQL(const Value: TStrings);
    procedure SetUpdateSQL(const Value: TStrings);
    procedure SetInsertSQL(const Value: TStrings);
    procedure SetSpecParams(const Value: TStrings);
    procedure SetKeyFields(const Value: TStrings);
    procedure SetUpdateFields(const Value: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    property TableName: String read FTableName write FTableName;
    property DeleteSQL: TStrings read FDeleteSQL write SetDeleteSQL;
    property InsertSQL: TStrings read FInsertSQL write SetInsertSQL;
    property UpdateSQL: TStrings read FUpdateSQL write SetUpdateSQL;
    property GetRecSQL: TStrings read FGetRecSQL write SetGetRecSQL;
    property SpecParams: TStrings read FSpecParams write SetSpecParams;
    property UpdateFields: TStrings read FUpdateFields write SetUpdateFields;
    property KeyFields: TStrings read FKeyFields write SetKeyFields;
  end;

{ TCustomDBService }

  TCustomDBService = class(TPersistent)
  private
    FMTList: TStringList;
    FTempateList: TStringList;
    FSQLRoot: TSQLTreeNode;
    FSQLClassListNames: TStringList;
    FSQLClassListTexts: TStringList;
    FLoadedSQLClasses: TStringList;
  protected
    FDesignDB: TDesignDataBaseEh;
    FIncrementObjectsList: TStrings;
    SelectedIndex: Integer;
//    function CreateNode: IGetSQLTreeNode; virtual;
    function CreateNode: TSQLTreeNode; virtual;
    function CreateReader(SQL: String; FParams: TParamsArr): TDataSet; virtual;
    function GetMemTable(TableName: String): TMemTableEh;
    function GetTemplate(TemplateName: String): TSQLTreeNodeTemplate;
    function LoadText(TextName: String): String;
    function LoadMemTable(MemTable: TMemTableEh; Source: TDataSet; Mode: TLoadMode; Fetch: Boolean): Integer; virtual;
    function SQLClassTextByName(ClassName: String): String;
    procedure AddTemplate(Template: TSQLTreeNodeTemplate);
    procedure AssignRecord(Source, Destinate: TDataSet); virtual;
    procedure OnPopupClick(Sender: TObject);
    procedure AddSQLClass(Name, SQLText: String);
    procedure MemTableBuildStruct(MemTable: TMemTableEh; Source: TDataSet); virtual;
    procedure GenWhereClause(DesignUpdateParams: TDesignUpdateParamsEh; SQL: TStrings); virtual;
    procedure GenInsertSQL(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh); virtual;
    procedure GenModifySQL(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh); virtual;
    procedure GenDeleteSQL(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh); virtual;
    procedure GenGetRecSQL(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh); virtual;
  public
    constructor Create(ADesignDB: TDesignDataBaseEh); virtual;
    destructor Destroy; override;
    function CheckSqlTextFile: Boolean;
    function CreateRootNodes: TList; virtual;
//    function CreateNodes(Parent: IGetSQLTreeNode): TList; virtual;
    function CreateNodes(Parent: TSQLTreeNode): TList; virtual;
    function ShowPopup(Source: TObject; Coord: TPoint; Params: TServicePopupParams): Integer; virtual;
    function GetSpecParamsList: String; virtual;
    function GetIncrementObjectsList: TStrings; virtual;
    function GetUpdateSQLCommand(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh): Boolean; virtual;
    procedure GenGetSpecParams(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh); virtual;
    class function GetDBServiceName: String; virtual;
//    procedure MemTablePutRecord(MemTable: TMemTableEh; DataSet: TDataSet); virtual;
//    procedure MemTablePutFieldValue(MemTable: TMemTableEh; DataSet: TDataSet; MemTableField: TField; Rec: TMemoryRecordEh); virtual;
  end;

{ TInterbaseDBService }

  TInterbaseDBService = class(TCustomDBService)
  protected
    procedure AssignRecord(Source, Destinate: TDataSet); override;
  public
    constructor Create(ADesignDB: TDesignDataBaseEh); override;
    function GetSpecParamsList: String; override;
    function GetIncrementObjectsList: TStrings; override;
    procedure GenInsertSQL(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh); override;
    procedure GenGetSpecParams(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh); override;
    class function GetDBServiceName: String; override;
//    procedure TableEditorDrop(Sender, Source: TObject; X, Y: Integer);
  end;

{ TInformixDBService }

  TInformixDBService = class(TCustomDBService)
  public
    constructor Create(ADesignDB: TDesignDataBaseEh); override;
    function GetSpecParamsList: String; override;
    procedure TableEditorDrop(Sender, Source: TObject; X, Y: Integer);
    procedure MemTableBuildStruct(MemTable: TMemTableEh; Source: TDataSet); override;
    procedure GenGetSpecParams(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh); override;
    class function GetDBServiceName: String; override;
  end;

{ TMSAccessDBService }

  TMSAccessDBService = class(TCustomDBService)
  public
    constructor Create(ADesignDB: TDesignDataBaseEh); override;
    function GetSpecParamsList: String; override;
    procedure GenGetSpecParams(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh); override;
    class function GetDBServiceName: String; override;
  end;

{ TOracleDBService }

  TOracleDBService = class(TCustomDBService)
  public
    constructor Create(ADesignDB: TDesignDataBaseEh); override;
    function GetSpecParamsList: String; override;
    procedure GenGetSpecParams(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh); override;
    class function GetDBServiceName: String; override;
  end;

{ TMSSQLDBService }

  TMSSQLDBService = class(TCustomDBService)
  public
    constructor Create(ADesignDB: TDesignDataBaseEh); override;
    function GetSpecParamsList: String; override;
    procedure GenGetSpecParams(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh); override;
    class function GetDBServiceName: String; override;
  end;

(*{ TCustomDBService }

  TCustomDBService = class(TObject)
  private
    FDesignDataBase: TDesignDataBaseEh;
  public
    constructor Create(DesignDataBase: TDesignDataBaseEh);
    function BuildObjectTree(TreeView: TTreeView): Boolean; virtual; abstract;
  end;

  TInterbaseDBService = class(TCustomDBService)
  public
    function BuildObjectTree(TreeView: TTreeView): Boolean; override;
  end;

  TMySQLDBService = class(TCustomDBService)
  public
    function BuildObjectTree(TreeView: TTreeView): Boolean; override;
  end;
*)

{ DesignDataBase unils }

procedure RegisterDesignDataBaseClass(EngineName: String; DesignDBClass: TDesignDataBaseClassEh);
procedure UnregisterDesignDataBaseClass(EngineName: String);
function GetDesignDataBaseClassByName(EngineName: String): TDesignDataBaseClassEh;
function GUISelectDesignDataBaseClass: TDesignDataBaseClassEh;

type
  TSelectDBService = class(TObject)
    DBServiceClass: TCustomDBServiceClass;
    AccessEngine: TAccessEngineEh;
    DBName: String;
  end;

{ Engines unils }

var
  AccessEngineList: TStringList = nil;

procedure RegisterAccessEngine(EngineName: String; Engine: TAccessEngineEh);
procedure UnregisterAccessEngine(EngineName: String);
function GetAccessEngineByName(EngineName: String): TAccessEngineEh;
function GUISelectAccessEngine(SelectDBService: TSelectDBService): Boolean;

//function GUISelectAccessEngine: TAccessEngineEh;

{ DBService unils }

function GetDBServiceList: TStringList;
procedure RegisterDBService(ServerName: String; DBService: TCustomDBServiceClass);
procedure UnregisterDBService(ServerName: String);
function GetDBServiceByName(ServerName: String): TCustomDBServiceClass;
function GUISelectDBService(SelectDBService: TSelectDBService): Boolean;
procedure RegisterDefaultDBService;

{ DBServiceEngines unils }

type
  TDBServiceItem = class
    AccessEngine: TAccessEngineEh;
    DBService: TCustomDBServiceClass;
  end;

procedure RegisterDBServiceEngine(AccessEngine: TAccessEngineEh; DBService: TCustomDBServiceClass);
procedure UnregisterDBServiceEngine(DBService: TCustomDBServiceClass);

 { DesignDataBaseList }

var
  DesignDataBaseList: TObjectList = nil;

function GetDesignDataBaseList: TObjectList;
function GetDBServiceEngineList: TObjectList;

const
  SSelect = 'select'; { Do not localize }
  SFrom = 'from'; { Do not localize }

var
  SQLDataEditWin: TSQLDataEditWin;
  SqlTextPathFileName: String = 'C:\Program Files\Common Files\Borland Shared\Data\sql_text.sql';

function EditSQLDataDriverEh(DataDriver: TCustomSQLDataDriverEh): Integer;

procedure ReleaseDesignDataBaseList;

implementation

{$R *.dfm}

uses
{$IFDEF EH_LIB_6} Types,  {$ENDIF}
  FormSelectFromList, DesignConnectionListEh, ToolCtrlsEh,
{$IFDEF DESIGNTIME}
{$IFDEF EH_LIB_6}
{$IFDEF CIL}
  Borland.Vcl.Design.ComponentDesigner,
{$ELSE}
  ComponentDesigner,
{$ENDIF}
{$ELSE}
  LibIntf,
{$ENDIF}
{$ENDIF}
  Registry;


{ DBService unils }

var
  DBServiceList: TStringListEh = nil;

procedure InitDBServiceList();
begin
  if DBServiceList = nil then
  begin
    DBServiceList := TStringListEh.Create;
    DBServiceList.CaseSensitive := False;
  end;
end;

function GetDBServiceList: TStringList;
begin
  InitDBServiceList;
  Result := DBServiceList;
end;

procedure ReleaseDBServiceList;
//var
//  i: Integer;
begin
  if DBServiceList <> nil then
    FreeAndNil(DBServiceList);
//  begin
{    for i := 0 to DBServiceList.Count-1 do
    begin
      TCustomDBService(DBServiceList).Free;
    end;}
//  end;
end;

procedure RegisterDBService(ServerName: String; DBService: TCustomDBServiceClass);
var
  OldDBService: TCustomDBServiceClass;
begin
  InitDBServiceList();
  OldDBService := GetDBServiceByName(ServerName);
  if OldDBService <> nil then
    UnregisterDBService(ServerName);
  DBServiceList.AddObject(ServerName, TObject(DBService));
end;

procedure UnregisterDBService(ServerName: String);
var
  DBServiceInx: Integer;
begin
  if DBServiceList = nil then
    Exit;
  DBServiceInx := DBServiceList.IndexOf(ServerName);
  if DBServiceInx > -1 then
  begin
//    DBServiceList.Objects[DBServiceInx].Free; Does not need to delete ref Class.
    DBServiceList.Delete(DBServiceInx);
  end;
end;

function GetDBServiceByName(ServerName: String): TCustomDBServiceClass;
var
  DBServiceInx: Integer;
begin
  Result := nil;
  if DBServiceList = nil then
    Exit;
  DBServiceInx := DBServiceList.IndexOf(ServerName);
  if DBServiceInx >= 0 then
    Result := TCustomDBServiceClass(DBServiceList.Objects[DBServiceInx]);
end;

function GUISelectDBService(SelectDBService: TSelectDBService): Boolean;
//function GUISelectDBService: TCustomDBServiceClass;
var
//  Index: Integer;
  f: TfSelectFromList;
begin
  Result := False;
  f := TfSelectFromList.Create(Application);
  f.cbEngine.Items := DBServiceList;
  f.cbDBService.Items := AccessEngineList;
  f.eDataBaseName.Text := SelectDBService.DBName;
  if f.ShowModal = mrOk then
  begin
    if f.cbEngine.ItemIndex >= 0
      then SelectDBService.AccessEngine := TAccessEngineEh(AccessEngineList.Objects[f.cbEngine.ItemIndex])
      else SelectDBService.AccessEngine := nil;
    if f.cbDBService.ItemIndex >= 0
      then SelectDBService.DBServiceClass := TCustomDBServiceClass(DBServiceList.Objects[f.cbEngine.ItemIndex])
      else SelectDBService.DBServiceClass := nil;
    SelectDBService.DBName := f.eDataBaseName.Text;
    Result := True;
  end;
  f.Free;

//  Index := SelectFromList(DBServiceList);
//  if Index >=0 then
//    Result := TCustomDBServiceClass(DBServiceList.Objects[Index]);
end;

procedure RegisterDefaultDBService();
begin
//  RegisterDBService('Oracle', TOracleDBService);
  RegisterDBService('Interbase', TInterbaseDBService);
  RegisterDBService('Informix', TInformixDBService);
//  RegisterDBService('MSSQL', TMSSQLDBService);
//  RegisterDBService('MSAccess', TMSAccessDBService);
//  RegisterDBService('MySQL', TMySQLDBService);
end;

{ Engines unils }

procedure InitAccessEngineList();
begin
  if AccessEngineList = nil then
    AccessEngineList := TStringList.Create;
end;

procedure ReleaseAccessEngineList;
var
  i: Integer;
begin
  if AccessEngineList <> nil then
  begin
    for i := 0 to AccessEngineList.Count-1 do
      TAccessEngineEh(AccessEngineList.Objects[i]).Free;
    FreeAndNil(AccessEngineList);
  end;
end;

procedure RegisterAccessEngine(EngineName: String; Engine: TAccessEngineEh);
var
  OldEngine: TAccessEngineEh;
begin
  InitAccessEngineList();
  OldEngine := GetAccessEngineByName(EngineName);
  if OldEngine <> nil then
    UnregisterAccessEngine(EngineName);
  AccessEngineList.AddObject(EngineName, Engine);
//  ShowMessage('AccessEngineList.Count = ' +  IntToStr(AccessEngineList.Count));
end;

procedure UnregisterAccessEngine(EngineName: String);
var
  DBEngineInx: Integer;
begin
// Realy need to release all DesignDataBases for every unit.finalization that have TXXXDesignDataBase.
// but now every unit have UnregisterAccessEngine
  ReleaseDesignDataBaseList;
  if AccessEngineList = nil then
    Exit;
  DBEngineInx := AccessEngineList.IndexOf(EngineName);
  if DBEngineInx > -1 then
  begin
    AccessEngineList.Objects[DBEngineInx].Free;
    AccessEngineList.Delete(DBEngineInx);
  end;
end;

function GetAccessEngineByName(EngineName: String): TAccessEngineEh;
var
  DBEngineInx: Integer;
begin
  Result := nil;
  if AccessEngineList = nil then
    Exit;
  DBEngineInx := AccessEngineList.IndexOf(EngineName);
  if DBEngineInx > -1 then
    Result := TAccessEngineEh(AccessEngineList.Objects[DBEngineInx]);
end;

(*function GUISelectAccessEngine(SelectDBService: TSelectDBService): Boolean;
var
  f: TfSelectFromList;
begin
  Result := False;
  f := TfSelectFromList.Create(Application);
  f.cbEngine.Items := AccessEngineList;
  f.cbDBService.Items := DBServiceList;
  f.eDataBaseName.Text := SelectDBService.DBName;
  if f.ShowModal = mrOk then
  begin
    if f.cbEngine.ItemIndex >= 0
      then SelectDBService.AccessEngine := TAccessEngineEh(AccessEngineList.Objects[f.cbEngine.ItemIndex])
      else SelectDBService.AccessEngine := nil;
    if f.cbDBService.ItemIndex >= 0
      then SelectDBService.DBServiceClass := TCustomDBServiceClass(DBServiceList.Objects[f.cbDBService.ItemIndex])
      else SelectDBService.DBServiceClass := nil;
    SelectDBService.DBName := f.eDataBaseName.Text;
    Result := True;
  end;
  f.Free;
end;*)

function GUISelectAccessEngine(SelectDBService: TSelectDBService): Boolean;
var
  f: TfSelectFromList;
begin
  Result := False;
  f := TfSelectFromList.Create(Application);
  if AccessEngineList <> nil then
    f.cbEngine.Items := AccessEngineList;
  if DBServiceList <> nil then
    f.cbDBService.Items := DBServiceList;
  f.eDataBaseName.Text := SelectDBService.DBName;
  f.DBServiceEngineList := GetDBServiceEngineList;
  if f.ShowModal = mrOk then
  begin
    if f.cbEngine.ItemIndex >= 0
      then SelectDBService.AccessEngine := TAccessEngineEh(AccessEngineList.Objects[f.cbEngine.ItemIndex])
      else SelectDBService.AccessEngine := nil;
    if f.cbDBService.ItemIndex >= 0
      then SelectDBService.DBServiceClass := TCustomDBServiceClass(f.cbDBService.Items.Objects[f.cbDBService.ItemIndex])
//      then SelectDBService.DBServiceClass := TCustomDBServiceClass(DBServiceList.Objects[f.cbDBService.ItemIndex])
      else SelectDBService.DBServiceClass := nil;
    SelectDBService.DBName := f.eDataBaseName.Text;
    Result := True;
  end;
  f.Free;
end;


procedure SetDesignSQLDataBaseProcEh(DataDriver: TCustomSQLDataDriverEh);
var
  sdb: TSelectDBService;
  DesignDataBase: TComponent;
begin
  if DataDriver.DesignDataBase <> nil then Exit;
  if GetDesignDataBaseList.Count > 0 then
  begin
    DesignDataBase := SelectDesignConnectionListEh(DesignDataBaseList);
    if (DesignDataBase <> nil) and (DesignDataBase <> DataDriver.DesignDataBase) then
      DataDriver.DesignDataBase := DesignDataBase;
  end else
  begin
    sdb := TSelectDBService.Create;
    if GUISelectAccessEngine(sdb) and (sdb.AccessEngine <> nil) then
      DataDriver.DesignDataBase := sdb.AccessEngine.CreateDesignDataBase(DataDriver, sdb.DBServiceClass, sdb.DBName);
    sdb.Free;
  end;
end;

{ DBServiceEngines unils }

var
  DBServiceEngineList: TObjectList = nil;

function GetDBServiceEngineList: TObjectList;
begin
  Result := DBServiceEngineList;
end;

procedure RegisterDBServiceEngine(AccessEngine: TAccessEngineEh; DBService: TCustomDBServiceClass);
var
  i: Integer;
begin
  if DBServiceEngineList = nil then
    DBServiceEngineList := TObjectList.Create(True);
  for i := 0 to DBServiceEngineList.Count-1 do
  begin
    if (TDBServiceItem(DBServiceEngineList[i]).AccessEngine = AccessEngine) and
       (TDBServiceItem(DBServiceEngineList[i]).DBService = DBService)
    then
    begin
      TDBServiceItem(DBServiceEngineList[i]).AccessEngine := AccessEngine;
      TDBServiceItem(DBServiceEngineList[i]).DBService := DBService;
      Exit;
    end;
  end;
  DBServiceEngineList.Add(TDBServiceItem.Create);
  TDBServiceItem(DBServiceEngineList[DBServiceEngineList.Count-1]).AccessEngine := AccessEngine;
  TDBServiceItem(DBServiceEngineList[DBServiceEngineList.Count-1]).DBService := DBService;
end;

procedure UnregisterDBServiceEngine(DBService: TCustomDBServiceClass);
var
  i: Integer;
begin
  if DBServiceEngineList = nil then
    DBServiceEngineList := TObjectList.Create(True);
  for i := 0 to DBServiceEngineList.Count-1 do
  begin
    if {(TDBServiceItem(DBServiceEngineList[i]).AccessEngine = AccessEngine) and}
       (TDBServiceItem(DBServiceEngineList[i]).DBService = DBService)
    then
    begin
      TObject(DBServiceEngineList.Extract(DBServiceEngineList[i])).Free;
      Exit;
    end;
  end;
end;

procedure ReleaseDBServiceEngineList;
begin
  if DBServiceEngineList <> nil then
    FreeAndNil(DBServiceEngineList);
end;

{ DesignDataBaseList }

function GetDesignDataBaseList: TObjectList;
begin
  if DesignDataBaseList = nil then
    DesignDataBaseList := TObjectList.Create(False);
  Result := DesignDataBaseList;
end;

procedure ReleaseDesignDataBaseList;
begin
  if DesignDataBaseList = nil then
    Exit;

  while DesignDataBaseList.Count > 0 do
    DesignDataBaseList[0].Free;

//  for i := 0 to DesignDataBaseList.Count-1 do
//    DesignDataBaseList[i] := nil; // Free as
  FreeAndNil(DesignDataBaseList);
end;

{ DesignDataBase unils }

var
  DesignDBClassList: TStringList = nil;

procedure InitDesignDBClassList();
begin
  if DesignDBClassList = nil then
    DesignDBClassList := TStringList.Create;
end;

procedure RegisterDesignDataBaseClass(EngineName: String; DesignDBClass: TDesignDataBaseClassEh);
var
  OldDesignClass: TDesignDataBaseClassEh;
begin
  InitDesignDBClassList();
  OldDesignClass := GetDesignDataBaseClassByName(EngineName);
  if OldDesignClass <> nil then
    UnregisterDesignDataBaseClass(EngineName);
  DesignDBClassList.AddObject(EngineName, TObject(DesignDBClass));
end;

procedure UnregisterDesignDataBaseClass(EngineName: String);
var
  DesignClassIdx: Integer;
begin
  if DesignDBClassList = nil then
    Exit;
  DesignClassIdx := DesignDBClassList.IndexOf(EngineName);
  if DesignClassIdx > -1 then
  begin
    DesignDBClassList.Objects[DesignClassIdx].Free;
    DesignDBClassList.Delete(DesignClassIdx);
  end;
end;

function GetDesignDataBaseClassByName(EngineName: String): TDesignDataBaseClassEh;
var
  DesignClassIdx: Integer;
begin
  Result := nil;
  if DesignDBClassList = nil then
    Exit;
  DesignClassIdx := DesignDBClassList.IndexOf(EngineName);
  if DesignClassIdx > -1 then
    Result := TDesignDataBaseClassEh(DesignDBClassList.Objects[DesignClassIdx]);
end;

function GUISelectDesignDataBaseClass: TDesignDataBaseClassEh;
begin
  Result := nil;
  if DesignDBClassList = nil then
    Exit;
end;

{ TDesignDataBaseEh }

constructor TDesignDataBaseEh.Create;
begin
  inherited Create(nil);
  GetDesignDataBaseList.Add(Self);
  FTreeDataSet := CreateTreeDataSet;
//  FTreeDataSet.Open;
end;

destructor TDesignDataBaseEh.Destroy;
begin
//  ShowMessage('TBDEDesignDataBaseEh.Destring');
  GetDesignDataBaseList.Remove(Self);
  FTreeDataSet.Close;
  FreeAndNil(FTreeDataSet);
  inherited Destroy;
//  ShowMessage('TBDEDesignDataBaseEh.Destred');
end;

{$IFNDEF EH_LIB_6}

function TDesignDataBaseEh.IntfGetComponent: TComponent;
begin
  Result := Self;
end;

{$ENDIF}

{
function TDesignDataBaseEh._AddRef: Integer;
begin
  Result := inherited _AddRef;
end;

function TDesignDataBaseEh._Release: Integer;
//var
//  OldRefCount: Integer;
begin
//  OldRefCount := RefCount;
  Result := inherited _Release;
//  if OldRefCount = 2 then
//    RemoveFromDesignDataBaseList;
end;

function TDesignDataBaseEh.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  Result := inherited QueryInterface(IID, Obj);
end;
}

procedure TDesignDataBaseEh.RemoveFromDesignDataBaseList;
begin
  GetDesignDataBaseList.Remove(Self);
end;

procedure TDesignDataBaseEh.EditDatabaseParams;
begin

end;

function TDesignDataBaseEh.GetEngineName: String;
begin
  Result := '';
end;

function TDesignDataBaseEh.GetFieldList(const TableName: string; DataSet: TDataSet): Boolean;
begin
  Result := False;
end;

function TDesignDataBaseEh.GetServerTypeName: String;
begin
  Result := '';
end;

procedure TDesignDataBaseEh.BuildQueryPlan(PlanTable: TMemTableEh;
  Command: TCustomSQLCommandEh);
begin
 //
end;

function TDesignDataBaseEh.GetConnected: Boolean;
begin
  Result := False;
end;

procedure TDesignDataBaseEh.SetConnected(const Value: Boolean);
begin
end;

function TDesignDataBaseEh.GetSpecParamsList: String;
begin
  Result := '';
end;

function TDesignDataBaseEh.GetCustomDBService: TCustomDBService;
begin
  Result := nil;
end;

function TDesignDataBaseEh.GetIncrementObjectsList: TStrings;
begin
  Result := nil;
end;

procedure TDesignDataBaseEh.AssignFromDesignDataDriver(DesignDataDriver,
  RuntimeDataDriver: TCustomSQLDataDriverEh);
begin
  RuntimeDataDriver.SelectCommand := DesignDataDriver.SelectCommand;
  RuntimeDataDriver.UpdateCommand := DesignDataDriver.UpdateCommand;
  RuntimeDataDriver.InsertCommand := DesignDataDriver.InsertCommand;
  RuntimeDataDriver.DeleteCommand := DesignDataDriver.DeleteCommand;
  RuntimeDataDriver.GetrecCommand := DesignDataDriver.GetrecCommand;
  if DesignDataDriver is TCustomSQLDataDriverEh then
  begin
    TCustomSQLDataDriverEh(RuntimeDataDriver).SpecParams := TCustomSQLDataDriverEh(DesignDataDriver).SpecParams;
    TCustomSQLDataDriverEh(RuntimeDataDriver).DynaSQLParams := TCustomSQLDataDriverEh(DesignDataDriver).DynaSQLParams;
  end;
end;

procedure TDesignDataBaseEh.AssignToDesignDataDriver(DesignDataDriver,
  RuntimeDataDriver: TCustomSQLDataDriverEh);
begin
  DesignDataDriver.SelectCommand := RuntimeDataDriver.SelectCommand;
  DesignDataDriver.UpdateCommand := RuntimeDataDriver.UpdateCommand;
  DesignDataDriver.InsertCommand := RuntimeDataDriver.InsertCommand;
  DesignDataDriver.DeleteCommand := RuntimeDataDriver.DeleteCommand;
  DesignDataDriver.GetrecCommand := RuntimeDataDriver.GetrecCommand;
  if DesignDataDriver is TCustomSQLDataDriverEh then
  begin
    TCustomSQLDataDriverEh(DesignDataDriver).SpecParams := TCustomSQLDataDriverEh(RuntimeDataDriver).SpecParams;
    TCustomSQLDataDriverEh(DesignDataDriver).DynaSQLParams := TCustomSQLDataDriverEh(RuntimeDataDriver).DynaSQLParams;
  end;
end;

function TDesignDataBaseEh.BuildObjectTree(List: TList): Boolean;
begin
  Result := False;
end;

function TDesignDataBaseEh.BuildUpdates(
  DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := False;
end;

function TDesignDataBaseEh.CreateDesignCopy(
  RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh;
begin
  Result := nil;
end;

function TDesignDataBaseEh.CreateReader(SQL: String;
  FParams: TParamsArr): TDataSet;
begin
  Result := nil;
end;

function TDesignDataBaseEh.DesignDataBaseConnetionEqual(
  DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := False;
end;

function TDesignDataBaseEh.Execute(Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
begin
  Result := 0;
end;

function TDesignDataBaseEh.Execute(SQLText: String;
  CommandType: TSQLCommandTypeEh; VarParams: Variant;
  var Cursor: TDataSet): Integer;
begin
  Result := 0;
end;

function TDesignDataBaseEh.CreateTreeDataSet: TMemTableEh;
begin
  Result := TMemTableEh.Create(Self);
  with Result do
  begin
    Name := 'mtDBTree';
    FieldDefs.Add('Id', ftAutoInc);
    FieldDefs.Add('RefParent', ftInteger);
    FieldDefs.Add('Name', ftString, 500);
    FieldDefs.Add('ChieldCount', ftInteger);
    FieldDefs.Add('Description', ftString, 500);
    FieldDefs.Add('RefData', ftUnknown);
    FieldDefs.Add('ImageIndex', ftInteger);

    TreeList.KeyFieldName := 'Id';
    TreeList.RefParentFieldName := 'RefParent';
    TreeList.DefaultNodeExpanded := False;
    TreeList.DefaultNodeHasChildren := True;
    TreeList.Active := True;
    OnTreeNodeExpanding := mtDBTreeExpanding;
    CreateDataSet;
  end;
end;

function TDesignDataBaseEh.GetObjectTreeDataSet: TDataSet;
var
  List: TObjectList;
  i: Integer;
begin
  if not FTreeDataSet.IsEmpty then
  begin
    Result := FTreeDataSet;
    Exit;
  end;
  FTreeDataSet.TreeList.DefaultNodeHasChildren := True;
  List := TObjectList.Create(False);
  try
    try
      if not GetConnected then
        SetConnected(True);

      BuildObjectTree(List);
    except
      on E: Exception do
        Application.HandleException(E);
    end;

    FTreeDataSet.DisableControls;
    try
//      mtDBTreeLoading := True;
      for i := 0 to List.Count-1 do
      begin
        FTreeDataSet.Append;
        FTreeDataSet.Fields[0].Value := Null;
        FTreeDataSet.Fields[1].Value := Null;
        FTreeDataSet.Fields[2].Value := TSQLTreeNode(List[i]).FName;
        FTreeDataSet.Fields[3].Value := 0;
        FTreeDataSet.Fields[4].Value := TSQLTreeNode(List[i]).FName;
        FTreeDataSet.Fields[5].Value := RefObjectToVariant(List[i]);
        FTreeDataSet.Fields[6].Value := TSQLTreeNode(List[i]).FImageIndex;
        FTreeDataSet.Post;
      end;
      FTreeDataSet.First;
    finally
      FTreeDataSet.EnableControls;
    end;
    Result := FTreeDataSet;
  finally
//  mtDBTreeLoading := False;
    List.Free;
  end;
end;

procedure TDesignDataBaseEh.mtDBTreeExpanding(Sender: TObject;
  RecordNumber: Integer; var AllowExpansion: Boolean);

  function AddChilds(Node: TObject; RefParent: Variant): Integer;
  var
    List: Tlist;
    i: Integer;
  begin
    Result := 0;
    if (Node <> nil) and ((Node as TSQLTreeNode) <> nil) then
      with Node as TSQLTreeNode do
      begin
        if not FNodesLoaded and (FNodesTemplate <> nil) then
        begin
          List := FNodesTemplate.FNodeManager.CreateNodes(Node as TSQLTreeNode);
//          mtDBTreeLoading := True;
          FTreeDataSet.TreeList.DefaultNodeHasChildren := FNodesTemplate.FHasNodes;
          for i := 0 to List.Count-1 do
          begin
            FTreeDataSet.Append;
            FTreeDataSet.Fields[0].Value := Null;
            FTreeDataSet.Fields[1].Value := RefParent;
            FTreeDataSet.Fields[2].Value := TSQLTreeNode(List[i]).FName;
            FTreeDataSet.Fields[3].Value := 0;
            FTreeDataSet.Fields[4].Value := TSQLTreeNode(List[i]).FName;
            FTreeDataSet.Fields[5].Value := RefObjectToVariant(List[i]);
            FTreeDataSet.Fields[6].Value := TSQLTreeNode(List[i]).FImageIndex;
            FTreeDataSet.Post;

            Inc(Result);
          end;
          List.Free;
        end;
        FNodesLoaded := True;
//        mtDBTreeLoading := False;
      end;
  end;

var
  Id, ChildCount: Integer;
  OldBM, RNBM: TUniBookmarkEh;
begin
  FTreeDataSet.DisableControls;
  try
//  mtDBTreeLoading := True;
  OldBM := FTreeDataSet.Bookmark;
  FTreeDataSet.RecNo := RecordNumber;
  RNBM := FTreeDataSet.Bookmark;
  Id := FTreeDataSet['ID'];

  if FTreeDataSet.TreeNodeHasChildren and (FTreeDataSet.TreeNodeChildCount = 0) then
  begin
    ChildCount := AddChilds(VariantToRefObject(FTreeDataSet['RefData']), Id);
    FTreeDataSet.Bookmark := RNBM;
    FTreeDataSet.TreeNodeHasChildren := (ChildCount > 0);
    FTreeDataSet.Edit;
    FTreeDataSet['ChieldCount'] := ChildCount;
    FTreeDataSet.Post;
  end;
  if DataSetBookmarkValid(FTreeDataSet, OldBM) then
    FTreeDataSet.Bookmark := OldBM;
  finally
    FTreeDataSet.EnableControls;
//    mtDBTreeLoading := False;
  end;
end;

procedure TDesignDataBaseEh.ResetDesignInfo;
begin
  FTreeDataSet.EmptyTable;
end;

{ TSQLDataEditWin }

var
  DataTypeNames :array [TFieldType] of String = (
    'ftUnknown', 'ftString', 'ftSmallint', 'ftInteger', 'ftWord',
    'ftBoolean', 'ftFloat', 'ftCurrency', 'ftBCD', 'ftDate', 'ftTime', 'ftDateTime',
    'ftBytes', 'ftVarBytes', 'ftAutoInc', 'ftBlob', 'ftMemo', 'ftGraphic', 'ftFmtMemo',
    'ftParadoxOle', 'ftDBaseOle', 'ftTypedBinary', 'ftCursor', 'ftFixedChar', 'ftWideString',
    'ftLargeint', 'ftADT', 'ftArray', 'ftReference', 'ftDataSet', 'ftOraBlob', 'ftOraClob',
    'ftVariant', 'ftInterface', 'ftIDispatch', 'ftGuid'
{$IFDEF EH_LIB_6},  'ftTimeStamp', 'ftFMTBcd'{$ENDIF}
{$IFDEF EH_LIB_10},  'ftFixedWideChar', 'ftWideMemo', 'ftOraTimeStamp', 'ftOraInterval'{$ENDIF}
{$IFDEF EH_LIB_12}, 'ftLongWord', 'ftShortint', 'ftByte', 'ftExtended', 'ftConnection', 'ftParams', 'ftStream' {$ENDIF}
{$IFDEF EH_LIB_13}, 'ftTimeStampOffset', 'ftObject', 'ftSingle' {$ENDIF}
    );

function EditSQLDataDriverEh(DataDriver: TCustomSQLDataDriverEh): Integer;
var
  Win: TSQLDataEditWin;
//  IDDB: IDesignDataBaseEh;
begin
  Result := 0;
  Win := TSQLDataEditWin.Create(Application);
  SQLDataEditWin := Win;

  if DataDriver.GetDesignDataBase = nil then Exit;

  Win.DataDriver := DataDriver;
  Win.DesignDriver := TDesignDataBaseEh(Win.DataDriver.DesignDataBase).CreateDesignCopy(DataDriver);
//  Win.DesignDriver := IDDB.CreateDesignCopy(DataDriver);
//  IDDB := nil;
  Win.DesignDriver.OnExecuteCommand := Win.ExecuteCommand;
  Win.DesignDriver.DesignDataBase := DataDriver.GetDesignDataBase;
  Win.DesignDataBase := TDesignDataBaseEh(DataDriver.GetDesignDataBase);
  Win.DesignDataBase.AssignToDesignDataDriver(Win.DesignDriver, Win.DataDriver);

//  Win.BuildObjectTree;
//  ShowMessage('Win.SetObjectTreeParams');
  Win.SetObjectTreeParams;

  Win.MemTableEh1.DataDriver := Win.DesignDriver;
  Win.AssignToDesignControls;

  Result := Win.ShowModal;
  if Result = mrOk then
  begin
    if Win.DesignDataBase = nil then
      DataDriver.GetDesignDataBase;
    if Win.DesignDataBase <> nil then
      Win.DesignDataBase.AssignFromDesignDataDriver(Win.DesignDriver, Win.DataDriver);
    if (DataDriver.Owner is TForm) and (TForm(DataDriver.Owner).Designer <> nil) then
      TForm(DataDriver.Owner).Designer.Modified;
  end;

  Win.DesignDriver.Free;
  Win.Free;
end;

procedure TSQLDataEditWin.FormCreate(Sender: TObject);
begin
  Font := Screen.IconFont;
  FrameInsertSQL.mtParams.CreateDataSet;
  FrameInsertSQL.Created;
  FrameUpdateSQL.mtParams.CreateDataSet;
  FrameUpdateSQL.Created;
  FrameDeleteSQL.mtParams.CreateDataSet;
  FrameDeleteSQL.Created;
  FrameGetRecSQL.mtParams.CreateDataSet;
  FrameGetRecSQL.Created;

(*  mtDBTree.TreeList.KeyFieldName := 'Id';
  mtDBTree.TreeList.RefParentFieldName := 'RefParent';
  mtDBTree.TreeList.DefaultNodeExpanded := False;
  mtDBTree.TreeList.DefaultNodeHasChildren := True;
  mtDBTree.TreeList.Active := True;
  mtDBTree.OnTreeNodeExpanding := mtDBTreeExpanding;
*)  
end;

destructor TSQLDataEditWin.Destroy;
begin
  mtTreeDetail.DestroyTable;
  mtDBTree.DestroyTable;
  MemTableEh1.DestroyTable;
  inherited Destroy;
end;

function TSQLDataEditWin.ExecuteCommand(DataDriver: TCustomSQLDataDriverEh;
 Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
begin
//  FreeOnEof := True;
//  Result := (DesignDriver.DesignDataBase as IDesignDataBaseEh).Execute(Command, Cursor);
  Result := TDesignDataBaseEh(DesignDriver.DesignDataBase).Execute(Command, Cursor, FreeOnEof);

end;

{
procedure TSQLDataEditWin.SetDataDriver(const Value: TCustomSQLDataDriverEh);
var
  i: Integer;
begin
  FDataDriver := Value;
  if FDataDriver.DesignDataBase = nil then
  begin
    for i := 0 to GetDesignDataBaseList.Count-1 do
      if TDesignDataBaseEh(GetDesignDataBaseList[i]).DesignDataBaseConnetionEqual(DataDriver) then
      begin
        DataDriver.DesignDataBase := IDesignDataBaseEh(GetDesignDataBaseList[i]);
        Exit;
      end;

    DataDriver.DesignDataBase := DataDriver.CreateDesignDataBase;
  end;
end;
}

procedure TSQLDataEditWin.bExecuteClick(Sender: TObject);
//var
//  ds: TDataSet;
begin
//  DataDriver.DesignDataBase.Execute(DataDriver.SelectCommand, ds);
  mtParams.CheckBrowseMode;
  MemTableEh1.Close;
  AssignToDesignDriver;
//  MemTableEh1.ProviderDataSet := ds;
  MemTableEh1.Open;
end;

procedure TSQLDataEditWin.AssignToDesignControls;
var
  i: Integer;
  Params: TParams;
begin
  if DesignDriver <> nil then
  begin
    mtParams.EmptyTable;
    Memo1.Lines.Text := DesignDriver.SelectCommand.CommandText.Text;
//    Params := TParams.Create;
    try
      Params := DesignDriver.SelectCommand.GetParams;//(Params);
      for i := 0 to Params.Count-1 do
      begin
        mtParams.AppendRecord(
          [Params[i].Name,
           DataTypeNames[Params[i].DataType],
           Params[i].Text
          ]);
      end;
    finally
//      Params.Free;
    end;
    FrameInsertSQL.AssignToDesignControls(DesignDriver.InsertCommand);
    FrameUpdateSQL.AssignToDesignControls(DesignDriver.UpdateCommand);
    FrameDeleteSQL.AssignToDesignControls(DesignDriver.DeleteCommand);
    FrameGetRecSQL.AssignToDesignControls(DesignDriver.GetRecCommand);
    mSpecParams.Lines := TCustomSQLDataDriverEh(DesignDriver).SpecParams;
    MemoUpdateFields.Lines.CommaText := TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.UpdateFields;
    MemoKeyFields.Lines.CommaText := TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.KeyFields;
    dbeUpdateTable.Text := TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.UpdateTable;
    cbDinaUpdateSQL.Checked := dsoDynamicSQLUpdateEh in TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.Options;
    cbDinaInsertSQL.Checked := dsoDynamicSQLInsertEh in TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.Options;
    cbDinaDeleteSQL.Checked := dsoDynamicSQLDeleteEh in TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.Options;
  end;
end;

procedure TSQLDataEditWin.AssignToDesignDriver;
var
  i: Integer;
  Params: TParams;
begin
  if DesignDriver <> nil then
  begin
    Params := TParams.Create;
    try
    //Select
      DesignDriver.SelectCommand.CommandText.Text := Memo1.Lines.Text;

      for i := 1 to mtParams.RecordCount do
      begin
        mtParams.RecNo := i;
        Params.CreateParam(
          ftString, mtParams['ParName'], ptInput).Text := mtParams['ParValue'];
      end;
      DesignDriver.SelectCommand.SetParams(Params);

      //Insert
      DesignDriver.InsertCommand.CommandText.Text := FrameInsertSQL.RichEdit1.Lines.Text;
      Params.Clear;
      for i := 1 to FrameInsertSQL.mtParams.RecordCount do
      begin
        FrameInsertSQL.mtParams.RecNo := i;
        Params.CreateParam(
          ftString, FrameInsertSQL.mtParams['ParName'], ptInput).Text := VarToStr(FrameInsertSQL.mtParams['ParValue']);
      end;
      DesignDriver.InsertCommand.SetParams(Params);

      //Update
      DesignDriver.UpdateCommand.CommandText.Text := FrameUpdateSQL.RichEdit1.Lines.Text;
      Params.Clear;
      for i := 1 to FrameUpdateSQL.mtParams.RecordCount do
      begin
        FrameUpdateSQL.mtParams.RecNo := i;
        Params.CreateParam(
          ftString, FrameUpdateSQL.mtParams['ParName'], ptInput).Text := VarToStr(FrameUpdateSQL.mtParams['ParValue']);
      end;
      DesignDriver.UpdateCommand.SetParams(Params);

      //Delete
      DesignDriver.DeleteCommand.CommandText.Text := FrameDeleteSQL.RichEdit1.Lines.Text;
      Params.Clear;
      for i := 1 to FrameDeleteSQL.mtParams.RecordCount do
      begin
        FrameDeleteSQL.mtParams.RecNo := i;
        Params.CreateParam(
          ftString, FrameDeleteSQL.mtParams['ParName'], ptInput).Text := VarToStr(FrameDeleteSQL.mtParams['ParValue']);
      end;
      DesignDriver.DeleteCommand.SetParams(Params);

      //GetRec
      DesignDriver.GetRecCommand.CommandText.Text := FrameGetRecSQL.RichEdit1.Lines.Text;
      Params.Clear;
      for i := 1 to FrameGetRecSQL.mtParams.RecordCount do
      begin
        FrameGetRecSQL.mtParams.RecNo := i;
        Params.CreateParam(
          ftString, FrameGetRecSQL.mtParams['ParName'], ptInput).Text := VarToStr(FrameGetRecSQL.mtParams['ParValue']);
      end;
      DesignDriver.GetRecCommand.SetParams(Params);

      TCustomSQLDataDriverEh(DesignDriver).SpecParams := mSpecParams.Lines;
      TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.UpdateFields := MemoUpdateFields.Lines.CommaText;
      TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.KeyFields := MemoKeyFields.Lines.CommaText;
      TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.UpdateTable := dbeUpdateTable.Text;
      TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.Options := [];
      if cbDinaUpdateSQL.Checked then
        TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.Options :=
          TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.Options + [dsoDynamicSQLUpdateEh];
      if cbDinaInsertSQL.Checked then
        TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.Options :=
          TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.Options + [dsoDynamicSQLInsertEh];
      if cbDinaDeleteSQL.Checked then
        TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.Options :=
          TCustomSQLDataDriverEh(DesignDriver).DynaSQLParams.Options + [dsoDynamicSQLDeleteEh];
    finally
      Params.Free;
    end;
  end;
end;

procedure TSQLDataEditWin.sbHideShowClick(Sender: TObject);
begin
  TabSheet1.DisableAlign;
  try
    if Panel3Width > 0 then
    begin
      PanelParams.Left := PanelParams.Left + (PanelParams.Width - Panel3Width);
      PanelParams.Width := Panel3Width;
      Panel3Width := -1;
    end else
    begin
      Panel3Width := PanelParams.Width;
      PanelParams.Left := PanelParams.Left + PanelParams.Width;
      PanelParams.Width := 0;
    end;
  finally
    TabSheet1.EnableAlign;
  end;
end;

procedure TSQLDataEditWin.Splitter2CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Panel3Width := -1;
end;

procedure TSQLDataEditWin.bBuildUpdatesClick(Sender: TObject);
begin
  AssignToDesignDriver;
  if Assigned(DataDriver.DesignDataBase) then
//    if (DataDriver.DesignDataBase as IDesignDataBaseEh).BuildUpdates(DesignDriver) then
    if TDesignDataBaseEh(DataDriver.DesignDataBase).BuildUpdates(DesignDriver) then
    begin
      AssignToDesignControls;
    end;
end;

procedure TSQLDataEditWin.MemTableEh1AfterOpen(DataSet: TDataSet);
var
  i: Integer;
begin
  for i := 0 to DBGridEh1.Columns.Count-1 do
  begin
    DBGridEh1.Columns[i].MaxWidth := 200;
    DBGridEh1.Columns[i].MaxWidth := 0;
  end;
end;

function SubstitueFileds(FMemRec: TMemoryRecordEh; FTableFilter: String): String;
var
  i: Integer;
begin
  Result := FTableFilter;
  for i := 0 to FMemRec.DataStruct.Count-1 do
  begin
    Result := StringReplace(Result, '%[' + FMemRec.DataStruct[i].FieldName + ']',
      VarToStr(FMemRec.DataValues[FMemRec.DataStruct[i].FieldName, dvvValueEh]),
      [rfReplaceAll, rfIgnoreCase]);
  end;
end;

procedure TSQLDataEditWin.DrawCaretPosIndicator;
var
  XPos, YPos: Integer;
begin
  with Memo1.CaretPos do
  begin
    FSQLCanvas.Control := Memo1;
    FSQLCanvas.Font := Memo1.Font;
    YPos := (Y+1) * FCharHeight;
    XPos := FSQLCanvas.TextWidth(Copy(Memo1.Lines[Y], 1, X)) - 3 ;
    FSQLCanvas.Draw(XPos ,YPos, Image1.Picture.Graphic);
  end;
end;

procedure TSQLDataEditWin.FormShow(Sender: TObject);
begin
  FSQLCanvas := TControlCanvas.Create;
  FSQLCanvas.Control := Memo1;
  FCharHeight := FSQLCanvas.TextHeight('0');
end;

procedure TSQLDataEditWin.FormDestroy(Sender: TObject);
begin
  mtDBTree.Close;
  mtTreeDetail.Close;
  MemTableEh1.Close;
  FSQLCanvas.Free;
  gridTreeDetail.DataSource := nil;
  gridTreeDetail.Free; gridTreeDetail := nil;
end;

procedure TSQLDataEditWin.Memo1Exit(Sender: TObject);
begin
  DrawCaretPosIndicator;
end;

procedure TSQLDataEditWin.Memo1Enter(Sender: TObject);
begin
  Memo1.Invalidate;
end;

(*procedure TSQLDataEditWin.InsertText(Text: string; AddComma: Boolean);
var
  StartSave: Integer;
  S: string;
begin
  S := Memo1.Text;
  StartSave := Memo1.SelStart;
  if (S <> '') and (StartSave > 0) and not (S[StartSave] in [' ','(']) and
    not (Text[1] = ' ') then
  begin
    if AddComma and (S[StartSave] <> ',') then
      Text := ', '+Text else
      Text := ' ' + Text;
  end;
  System.Insert(Text, S, StartSave+1);
  Memo1.Lines.Text := S;
  Memo1.SelStart := StartSave + Length(Text);
  Memo1.Update;
  DrawCaretPosIndicator;
end;
*)

procedure TSQLDataEditWin.mtDBTreeExpanding(Sender: TObject;
  RecordNumber: Integer; var AllowExpansion: Boolean);
var
  vDBTree: TMemTableEh;

  function AddChilds(Node: TObject; RefParent: Variant): Integer;
  var
    List: Tlist;
    i: Integer;
//    TreeNode: TTreeNode;
  begin
    Result := 0;
    if (Node <> nil) and ((Node as TSQLTreeNode) <> nil) then
      with Node as TSQLTreeNode do
      begin
        if not FNodesLoaded and (FNodesTemplate <> nil) then
        begin
          List := FNodesTemplate.FNodeManager.CreateNodes(Node as TSQLTreeNode);
          mtDBTreeLoading := True;
          vDBTree.TreeList.DefaultNodeHasChildren := FNodesTemplate.FHasNodes;
          for i := 0 to List.Count-1 do
          begin
            vDBTree.Append;
            vDBTree.Fields[0].Value := Null;
            vDBTree.Fields[1].Value := RefParent;
            vDBTree.Fields[2].Value := TSQLTreeNode(List[i]).FName;
            vDBTree.Fields[3].Value := 0;
            vDBTree.Fields[4].Value := TSQLTreeNode(List[i]).FName;
            vDBTree.Fields[5].Value := RefObjectToVariant(List[i]);
            vDBTree.Fields[6].Value := TSQLTreeNode(List[i]).FImageIndex;
            vDBTree.Post;

//            TreeNode := TreeView1.Items.AddChild(Node, TSQLTreeNode(List[i]).FName);
//            TreeNode.HasChildren := (TSQLTreeNode(List[i]).FNodesTemplate <> nil);
//            TreeNode.Data := List[i];
            Inc(Result);
          end;
          List.Free;
        end;
        FNodesLoaded := True;
        mtDBTreeLoading := False;
//        Node.HasChildren := (Node.Count > 0);
      end;
  end;

var
  Id, ChildCount: Integer;
//  Path: String;
  OldBM, RNBM: TUniBookmarkEh;
begin
  vDBTree := TMemTableEh(dsDBTree.DataSet);
  vDBTree.DisableControls;
  try
  mtDBTreeLoading := True;
  OldBM := vDBTree.Bookmark;
  vDBTree.RecNo := RecordNumber;
  RNBM := vDBTree.Bookmark;
  Id := vDBTree['ID'];
//  Path := vDBTree['FileDirPath'];

  if vDBTree.TreeNodeHasChildren and (vDBTree.TreeNodeChildCount = 0) then
  begin
    ChildCount := AddChilds(VariantToRefObject(vDBTree['RefData']), Id);
    vDBTree.Bookmark := RNBM;
//    vDBTree.TreeNode.SortByFields('IsDir Desc, FileDirName');
    vDBTree.TreeNodeHasChildren := (ChildCount > 0);
    vDBTree.Edit;
    vDBTree['ChieldCount'] := ChildCount;
    vDBTree.Post;
  end;
  if DataSetBookmarkValid(vDBTree, OldBM) then
    vDBTree.Bookmark := OldBM;
  finally
    vDBTree.EnableControls;
    mtDBTreeLoading := False;
  end;
end;

{function TSQLDataEditWin.DesignDataBase: TDesignDataBaseEh;
begin
  Result := nil;
  if Assigned(DataDriver) and Assigned(DataDriver.DesignDataBase) then
    Result := DataDriver.DesignDataBase as TDesignDataBaseEh;
end;}

procedure TSQLDataEditWin.SetDesignDataBase(const Value: TDesignDataBaseEh);
begin
  if FDesignDataBase <> Value then
  begin
    FDesignDataBase := Value;
    if Value <> nil then Value.FreeNotification(Self);
    DesignDatabaseChanged();
  end;
end;

procedure TSQLDataEditWin.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (FDesignDataBase = AComponent)
  then
  begin
    FDesignDataBase := nil;
    DesignDatabaseChanged;
  end;
end;

procedure TSQLDataEditWin.DesignDatabaseChanged;
begin
//  bExecute.Enabled := (DesignDataBase <> nil) and DesignDataBase.Connected;
  if (DesignDataBase <> nil) and DesignDataBase.Connected then
    SetObjectTreeParams;
(*  mtDBTree.EmptyTable;
  mtDBTree.Close;
  mtTreeDetail.EmptyTable;
  if (DesignDataBase <> nil) and DesignDataBase.Connected then
    BuildObjectTree;*)
end;

{ TCustomDBService }

constructor TCustomDBService.Create(ADesignDB: TDesignDataBaseEh);
begin
  inherited Create;
  FDesignDB := ADesignDB;
  FMTList := TStringList.Create;
//  FTempateList := ATempateList;
  FTempateList := TStringList.Create;
  FSQLRoot := CreateNode;// TSQLTreeNode.Create;
  FSQLClassListNames := TStringList.Create;
  FSQLClassListTexts := TStringList.Create;
  FLoadedSQLClasses := TStringList.Create;
end;

destructor TCustomDBService.Destroy;
var
  i: Integer;
begin
  for i := 0 to FMTList.Count-1 do
    FMTList.Objects[i].Free;
  FreeAndNil(FMTList);
  FreeAndNil(FSQLRoot);
  FreeAndNil(FSQLClassListNames);
  FreeAndNil(FSQLClassListTexts);
  for i := 0 to FTempateList.Count-1 do
    FTempateList.Objects[i].Free;
  FreeAndNil(FTempateList);
  FreeAndNil(FLoadedSQLClasses);
  FreeAndNil(FIncrementObjectsList);
  inherited Destroy;
end;

function TCustomDBService.CreateReader(SQL: String;
  FParams: TParamsArr): TDataSet;
begin
  Result := nil;
  if FDesignDB <> nil then
    Result := FDesignDB.CreateReader(SQL, FParams);
end;

procedure TCustomDBService.AddTemplate(Template: TSQLTreeNodeTemplate);
begin
  FTempateList.AddObject(Template.FName, Template);
end;

function TCustomDBService.GetTemplate(TemplateName: String): TSQLTreeNodeTemplate;
begin
  Result := nil;
  if UpperCase(TemplateName) = UpperCase('_RecordAsList') then
    Result := nil //RecordAsListTempate
  else if FTempateList.IndexOf(TemplateName) > -1 then
    Result := TSQLTreeNodeTemplate(FTempateList.Objects
      [FTempateList.IndexOf(TemplateName)]);
end;

function TCustomDBService.CreateRootNodes: TList;
var
  MemTable: TMemTableEh;
  Reader: TDataSet;
//  Node: IGetSQLTreeNode;
  Node: TSQLTreeNode;
  Template: TSQLTreeNodeTemplate;
begin
  Result := TList.Create;
  if FTempateList.Count = 0 then Exit;
  Template := TSQLTreeNodeTemplate(FTempateList.Objects[0]);
  MemTable := GetMemTable(Template.FNodesMemTableName);
  Reader := CreateReader(SQLClassTextByName(Template.FNodesSQLClassName), Template.FParams);
  if Reader = nil then Exit;
//  if MemTable.Active
//    then MemTable.LoadFromDataSet(Reader, -1, lmAppend, False)
//    else MemTable.LoadFromDataSet(Reader, -1, lmCopy, False);
  if MemTable.Active
    then LoadMemTable(MemTable, Reader, lmAppend, False)
    else LoadMemTable(MemTable, Reader, lmCopy, False);

  Reader.Free;
  //ProviderDataSet := Reader;
  //MemTable.ProviderEOF := False;
  //if not MemTable.Active then
  //  MemTable.Open;
  //MemTable.FetchRecords(-1);
  MemTable.First;
  while not MemTable.Eof do
  begin
    Node := CreateNode;
//    Parent.AddChild(Node);
    with Node.GetSQLTreeNode do
    begin
      FObjId := VarToStr(MemTable[Template.FObjIdFieldName]);
//      FTable := MemTable;
      FName := VarToStr(MemTable[Template.FInTreeTextFieldName]);
      FImageIndex := MemTable['IMAGE_INDEX'];
      FMemRec := MemTable.RecordsView[MemTable.RecNo-1];
      FNodesTemplate := GetTemplate(MemTable['TEMPLATE_NAME']);
{      if FTempateList.IndexOf(MemTable['TEMPLATE_NAME']) > -1 then
        FNodesTemplate := TSQLTreeNodeTemplate(FTempateList.Objects
          [FTempateList.IndexOf(MemTable['TEMPLATE_NAME'])]);}
      if FNodesTemplate <> nil then
      begin
        FTableFilter := FNodesTemplate.FNodesFilter;
      end;
      FNodesLoaded := False;
    end;
    FSQLRoot.GetSQLTreeNode.AddChild(Node);
    Result.Add(Node.GetSQLTreeNode);
    MemTable.Next;
  end;
end;

function TCustomDBService.GetMemTable(TableName: String): TMemTableEh;
begin
  Result := nil;
  if FMTList.IndexOf(TableName) >= 0 then
    Result := TMemTableEh(FMTList.Objects[
      FMTList.IndexOf(TableName)]);
  if Result = nil then
  begin
    Result := TMemTableEh.Create(nil);
    Result.Name := TableName;
    Result.Filtered := True;
    FMTList.AddObject(TableName, Result);
  end;
end;

function TCustomDBService.CreateNode: TSQLTreeNode;
begin
  Result := TSQLTreeNode.Create;
end;

function TCustomDBService.SQLClassTextByName(ClassName: String): String;
var
  Index: Integer;
begin
  Index := FSQLClassListNames.IndexOf(ClassName);
  if Index >= 0
    then Result := FSQLClassListTexts[Index]
    else Result := '';
end;

procedure TCustomDBService.AddSQLClass(Name, SQLText: String);
begin
  FSQLClassListNames.Add(Name);
  FSQLClassListTexts.Add(SQLText);
end;

function TCustomDBService.ShowPopup(Source: TObject; Coord: TPoint; Params: TServicePopupParams): Integer;
var
  ppm: TPopupMenu;
  ppmi: TMenuItem;
  i: Integer;
begin
  ppm := TPopupMenu.Create(SQLDataEditWin);
  for i := 0 to Length(Params)-1 do
  begin
    ppmi := TMenuItem.Create(SQLDataEditWin);
    ppmi.Caption := Params[i].OnGetMenuText(Source);
    ppmi.OnClick := OnPopupClick;
    ppmi.Tag := i;
    ppm.Items.Add(ppmi);
  end;
  SelectedIndex := -1;
  SQLDataEditWin.Memo1.PopupMenu := ppm;
  ppm.Popup(Coord.X, Coord.Y);
  Application.ProcessMessages;
  Result := SelectedIndex;
  ppm.Free;
end;

procedure TCustomDBService.OnPopupClick(Sender: TObject);
begin
  SelectedIndex := TMenuItem(Sender).Tag;
end;

function TCustomDBService.CheckSqlTextFile: Boolean;
begin
  Result := False;
{$IFDEF DESIGNTIME}
{$IFDEF EH_LIB_6}
  with TRegIniFile.Create(ActiveDesigner.Environment.GetBaseRegKey + '\' + EhLibRegKey) do
{$ELSE}
  with TRegIniFile.Create(DelphiIDE.GetBaseRegKey + '\' + EhLibRegKey) do
{$ENDIF}
  try
    SqlTextPathFileName := ReadString('', 'sql_text', SqlTextPathFileName);
  finally
    Free;
  end;
{$ENDIF}
  if FileExists(SqlTextPathFileName)
  then
    Result := True
  else
  begin
    ShowMessage('File sql_text.sql does not exists in path: ' + SqlTextPathFileName + #10#13 +
      'Please specify new path.');

    with TOpenDialog.Create(nil) do
    begin
      if Execute then
      begin
        SqlTextPathFileName := FileName;
        Result := True;
{$IFDEF DESIGNTIME}
  {$IFDEF EH_LIB_6}
        with TRegIniFile.Create(ActiveDesigner.Environment.GetBaseRegKey + '\' + EhLibRegKey) do
  {$ELSE}
        with TRegIniFile.Create(DelphiIDE.GetBaseRegKey + '\' + EhLibRegKey) do
  {$ENDIF}
        try
          WriteString('', 'sql_text', SqlTextPathFileName);
        finally
          Free;
        end;
{$ENDIF}
      end;
    end;
  end;
end;

function TCustomDBService.LoadText(TextName: String): String;
var
  ss: TStringList;
  i: Integer;
  InString: Boolean;
begin
  Result := '';
  ss := TStringList.Create;

  if not CheckSqlTextFile then Exit;
  
  ss.LoadFromFile(SqlTextPathFileName);
  try
    InString := False;
    for i := 0 to ss.Count-1 do
    begin
      if InString and (Copy(ss[i],1,1) <> '#') then
        Result := Result + ss[i] + sLineBreak
      else if not InString and (ss[i] = '#' + TextName) then
        InString := True
      else if InString then
        Break;
    end;

  finally
    ss.Free;
  end;
end;

function TCustomDBService.CreateNodes(Parent: TSQLTreeNode): TList;
var
  MemTable: TMemTableEh;
  Reader: TDataSet;
//  Node: IGetSQLTreeNode;
  Node: TSQLTreeNode;
  ANodesTemplate: TSQLTreeNodeTemplate;
begin
  Result := TList.Create;
  MemTable := nil;
  if Parent.GetSQLTreeNode.FNodesTemplate.FNodesMemTableName = '' then Exit;
  ANodesTemplate := Parent.GetSQLTreeNode.FNodesTemplate;
  if FMTList.IndexOf(ANodesTemplate.FNodesMemTableName) >= 0 then
    MemTable := TMemTableEh(FMTList.Objects[FMTList.IndexOf(ANodesTemplate.FNodesMemTableName)]);
  if MemTable = nil then
  begin
    MemTable := TMemTableEh.Create(nil);
    MemTable.Name := ANodesTemplate.FNodesMemTableName;
    MemTable.Filtered := True;
    FMTList.AddObject(ANodesTemplate.FNodesMemTableName, MemTable);
  end;
  Parent.GetSQLTreeNode.FTable := MemTable;

  if FLoadedSQLClasses.IndexOf(ANodesTemplate.FNodesSQLClassName) < 0 then
  begin
    FLoadedSQLClasses.Add(ANodesTemplate.FNodesSQLClassName);
    Reader := CreateReader(SQLClassTextByName(ANodesTemplate.FNodesSQLClassName), ANodesTemplate.FParams);
    if Reader = nil then Exit;
//    if MemTable.Active
//      then MemTable.LoadFromDataSet(Reader, -1, lmAppend, False)
//      else MemTable.LoadFromDataSet(Reader, -1, lmCopy, False);
    if MemTable.Active
      then LoadMemTable(MemTable, Reader, lmAppend, False)
      else LoadMemTable(MemTable, Reader, lmCopy, False);
    Reader.Free;
  end;
  MemTable.DisableControls;
  try
  MemTable.Filter := Parent.GetSQLTreeNode.FTableFilter;
  MemTable.First;
  while not MemTable.Eof do
  begin
    Node := CreateNode;
    Parent.GetSQLTreeNode.AddChild(Node);
    with Node.GetSQLTreeNode do
    begin
      FObjId := VarToStr(MemTable[ANodesTemplate.FObjIdFieldName]);
      FName := VarToStr(MemTable[ANodesTemplate.FInTreeTextFieldName]);
      if (MemTable.FindField('IMAGE_INDEX') <> nil) and not VarIsNull(MemTable['IMAGE_INDEX']) then
        FImageIndex := MemTable['IMAGE_INDEX'];
      FMemRec := MemTable.RecordsView[MemTable.RecNo-1];
      FNodesTemplate := GetTemplate(MemTable['TEMPLATE_NAME']);
      if FNodesTemplate <> nil then
      begin
        FTableFilter := VarToStr(MemTable[ANodesTemplate.FObjIdFieldName]);
        FTableFilter := SubstitueFileds(FMemRec, FNodesTemplate.FNodesFilter);
      end;
      if ANodesTemplate <> nil then
      begin
        OnDragDrop := ANodesTemplate.OnNodeDragDrop;
        PopupParams := ANodesTemplate.NodeDropMenuParams;
      end;
      FNodesLoaded := False;
      if UpperCase(MemTable['TEMPLATE_NAME']) = UpperCase('_RecordAsList') then
      begin
        FParentRecordToTableMode := True;
        FTable := GetMemTable('_RecordAsList');
        FNodesLoaded := True;
      end;
    end;
    Result.Add(Node.GetSQLTreeNode);
    MemTable.Next;
  end;
  MemTable.First;
  finally
    MemTable.EnableControls;
  end;
end;

function TCustomDBService.LoadMemTable(MemTable: TMemTableEh;
  Source: TDataSet; Mode: TLoadMode; Fetch: Boolean): Integer;
var
  SourceActive: Boolean;
  MovedCount: Integer;
begin
  Result := 0;
  if Source = MemTable then Exit;
  SourceActive := Source.Active;
  Source.DisableControls;
  try
    MemTable.DisableControls;
    try
      with Source do
      begin
        Open;
        CheckBrowseMode;
        UpdateCursorPos;
      end;
      if Mode = lmCopy then
      begin
        MemTable.Close;
        MemTable.RecordsView.MemTableData.DestroyTable;
        MemTableBuildStruct(MemTable, Source);
      end;
      if not MemTable.Active then MemTable.Open;
      MemTable.CheckBrowseMode;
      if MemTable.RecordCount > 0 then
        MovedCount := MemTable.RecordCount
      else
      begin
        Source.First;
        MovedCount := MaxInt;
      end;
      try
        while not Source.EOF do
        begin
          if Fetch then
//            MemTable.FetchRecord(Source)
            MemTable.LoadFromDataSet(Source, 1, lmAppend, False)
          else
          begin
            MemTable.Append;
            AssignRecord(Source, MemTable);
            MemTable.Post;
          end;
          Inc(Result);
          if Result >= MovedCount then Break;
          Source.Next;
        end;
      finally
        MemTable.First;
      end;
    finally
      MemTable.EnableControls;
    end;
  finally
    if not SourceActive then
      Source.Close;
    Source.EnableControls;
  end;
end;

procedure TCustomDBService.AssignRecord(Source, Destinate: TDataSet);
begin
  MemTableEh.AssignRecord(Source, Destinate);
end;

procedure TCustomDBService.MemTableBuildStruct(MemTable: TMemTableEh;
  Source: TDataSet);
begin
  MemTable.RecordsView.MemTableData.DataStruct.BuildStructFromFields(Source.Fields);
end;

(*
procedure TCustomDBService.MemTablePutRecord(MemTable: TMemTableEh; DataSet: TDataSet);
var
  Rec: TMemoryRecordEh;
  i: Integer;
//  Field: TField;
begin
  MemTable.CheckBrowseMode;

  Rec := MemTable.RecordsView.NewRecord;

  for i := 0 to MemTable.FieldCount-1 do
    if MemTable.Fields[i].FieldNo > 0 then
    begin
      MemTablePutFieldValue(MemTable, DataSet, MemTable.Fields[i], Rec);
//      Field := DataSet.FindField(MemTable.Fields[i].FieldName);
//      if Field <> nil then
//        Rec.Value[MemTable.Fields[i].FieldNo-1, dvvValueEh] := Field.Value;
    end;

  MemTable.RecordsView.MemTableData.RecordsList.FetchRecord(Rec);
end;

procedure TCustomDBService.MemTablePutFieldValue(MemTable: TMemTableEh;
  DataSet: TDataSet; MemTableField: TField; Rec: TMemoryRecordEh);
var
  Field: TField;
begin
  Field := DataSet.FindField(MemTableField.FieldName);
  if Field <> nil then
    Rec.Value[MemTableField.FieldNo-1, dvvValueEh] := Field.Value;
end;
*)

class function TCustomDBService.GetDBServiceName: String;
begin
  Result := '';
end;

function TCustomDBService.GetSpecParamsList: String;
begin
  Result := '';
end;

function TCustomDBService.GetIncrementObjectsList: TStrings;
begin
  Result := nil;
end;

function TCustomDBService.GetUpdateSQLCommand(
  DesignUpdateParams: TDesignUpdateParamsEh;
  DesignUpdateInfo: TDesignUpdateInfoEh): Boolean;
begin
  Result := True;
  GenInsertSQL(DesignUpdateParams, DesignUpdateInfo);
  GenModifySQL(DesignUpdateParams, DesignUpdateInfo);
  GenDeleteSQL(DesignUpdateParams, DesignUpdateInfo);
  GenGetRecSQL(DesignUpdateParams, DesignUpdateInfo);
  GenGetSpecParams(DesignUpdateParams, DesignUpdateInfo);
  DesignUpdateInfo.UpdateFields := DesignUpdateParams.UpdateFields;
  DesignUpdateInfo.KeyFields := DesignUpdateParams.KeyFields;
  DesignUpdateInfo.TableName := DesignUpdateParams.TableName;
end;

procedure TCustomDBService.GenDeleteSQL(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh);
begin
  DesignUpdateInfo.DeleteSQL.Clear;
  DesignUpdateInfo.DeleteSQL.Add(Format('delete from %s', [DesignUpdateParams.TableName])); { Do not localize }
  GenWhereClause(DesignUpdateParams, DesignUpdateInfo.DeleteSQL);
end;

procedure TCustomDBService.GenGetRecSQL(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh);
var
  BindText, FieldName, TabAlias: String;
  I: Integer;
begin
  BindText := '';
  DesignUpdateInfo.GetRecSQL.Assign(DesignUpdateParams.SelectSQL);
  TabAlias := '';
  for I := 0 to DesignUpdateParams.KeyFields.Count - 1 do
  begin
    FieldName := DesignUpdateParams.KeyFields[I];
    BindText := Format('  %s%s%s%1:s = :%1:sOLD_%2:s%1:s', { Do not localize }
      [TabAlias, '', FieldName]);
    if I < DesignUpdateParams.KeyFields.Count - 1 then
      BindText := Format('%s and',[BindText]); { Do not localize }
    DesignUpdateInfo.GetRecSQL.Add(BindText);
  end;
end;

procedure TCustomDBService.GenInsertSQL(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh);

  procedure GenFieldList(const TabName, ParamChar, QuoteChar: String);
  var
    L: string;
    I: integer;
    Comma: string;
  begin
    L := '  (';
    Comma := ', ';
    for I := 0 to DesignUpdateParams.UpdateFields.Count - 1 do
    begin
      if I = DesignUpdateParams.UpdateFields.Count - 1 then Comma := '';
      L := Format('%s%s%s%s%s%3:s%5:s',
        [L, TabName, ParamChar, QuoteChar, DesignUpdateParams.UpdateFields[I], Comma]);
      if (Length(L) > 70) and (I <> DesignUpdateParams.UpdateFields.Count - 1) then
      begin
        DesignUpdateInfo.InsertSQL.Add(L);
        L := '   ';
      end;
    end;
    DesignUpdateInfo.InsertSQL.Add(L+')');
  end;

begin
  DesignUpdateInfo.InsertSQL.Clear;
  DesignUpdateInfo.InsertSQL.Add(Format('insert into %s', [DesignUpdateParams.TableName])); { Do not localize }
  GenFieldList('', '', '');
  DesignUpdateInfo.InsertSQL.Add('values'); { Do not localize }
  GenFieldList('', ':', '');
end;

procedure TCustomDBService.GenModifySQL(DesignUpdateParams: TDesignUpdateParamsEh;
      DesignUpdateInfo: TDesignUpdateInfoEh);
var
  I: integer;
  Comma: string;
  TableRef: string;
begin
  DesignUpdateInfo.UpdateSQL.Clear;
  DesignUpdateInfo.UpdateSQL.Add(Format('update %s', [DesignUpdateParams.TableName]));  { Do not localize }
  DesignUpdateInfo.UpdateSQL.Add('set');                             { Do not localize }
  Comma := ',';
  TableRef := '';//DesignUpdateParams.TableName;
  for I := 0 to DesignUpdateParams.UpdateFields.Count - 1 do
  begin
    if I = DesignUpdateParams.UpdateFields.Count -1 then Comma := '';
    DesignUpdateInfo.UpdateSQL.Add(Format('  %s%s%s%1:s = :%1:s%2:s%1:s%3:s',
      [TableRef, '', DesignUpdateParams.UpdateFields[I], Comma]));
  end;
  GenWhereClause(DesignUpdateParams, DesignUpdateInfo.UpdateSQL);
end;

procedure TCustomDBService.GenWhereClause(
  DesignUpdateParams: TDesignUpdateParamsEh; SQL: TStrings);
var
  I: Integer;
  BindText: string;
  FieldName: string;
begin
  SQL.Add('where'); { Do not localize }
  for I := 0 to DesignUpdateParams.KeyFields.Count - 1 do
  begin
    FieldName := DesignUpdateParams.KeyFields[I];
    BindText := Format('  %s%s%s%1:s = :%1:sOLD_%2:s%1:s', { Do not localize }
      ['', '', FieldName]);
    if I <  DesignUpdateParams.KeyFields.Count - 1 then
      BindText := Format('%s and',[BindText]); { Do not localize }
    SQL.Add(BindText);
  end;
end;

procedure TCustomDBService.GenGetSpecParams(
  DesignUpdateParams: TDesignUpdateParamsEh;
  DesignUpdateInfo: TDesignUpdateInfoEh);
begin
end;

{ TSQLTreeNode }

procedure TSQLTreeNode.AddChild(Node: TSQLTreeNode);
begin
  FNodes.Add(Node);
end;

constructor TSQLTreeNode.Create;
begin
  inherited Create;
  FNodes := TObjectList.Create(True);
//  FNodes := TInterfaceList.Create;
end;

destructor TSQLTreeNode.Destroy;
begin
  FNodes.Free;
  inherited Destroy;
end;

function TSQLTreeNode.GetSQLTreeNode: TSQLTreeNode;
begin
  Result := Self;
end;

function TSQLTreeNode.GetTable: TMemTableEh;
var
  i: Integer;
begin
  Result := nil;
  if FParentRecordToTableMode then
  begin
    if FTable <> nil
      then FTable.EmptyTable
      else Exit;
    if not FTable.Active then
    begin
      FTable.FieldDefs.Add('Name', ftString, 100, False);
      FTable.FieldDefs.Add('Value', ftString, 100, False);
      FTable.CreateDataSet;
    end;
    if FMemRec <> nil then
      for i := 0 to FMemRec.DataStruct.Count-1 do
      begin
        FTable.AppendRecord(
          [FMemRec.DataStruct[i].FieldName, VarToStr(FMemRec.Value[i, dvvValueEh])]
        );
      end;
    FTable.First;
    Result := FTable;
  end else
  begin
    Result := FTable;
    if Result <> nil then
    begin
      Result.Filter := FTableFilter;
      Result.First;
    end;
  end;
end;

(*
function TSQLTreeNode.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj)
    then Result := 0
    else Result := E_NOINTERFACE;
end;

function TSQLTreeNode._AddRef: Integer;
begin
  Result := -1;
end;

function TSQLTreeNode._Release: Integer;
begin
  Result := -1;
end;
*)

{ TSQLTreeNodeTemplate }

constructor TSQLTreeNodeTemplate.Create(
                       ANodeManager: TCustomDBService;
                       AName: String
{                       ANodesSQLClassName: String;
                       AMasterTemplateName: String;
                       ANodesMemTableName: String;
//                       AParams: TParamsArr;
                       AParams: array of Variant;
                       AObjIdFieldName: String;
                       AInTreeTextFieldName: String;
                       AHasNodes: Boolean;
                       ANodesFilter: String;
                       ANodesFieldsInGrid: String;
                       AColumnAttributes: String = ''; // FieldName, Caption, Width
                       AAdditionalLoadSQL: String = '';
                       AAdditionalFielsInfo: String = '' // FieldName, Type, Width
}
    );
//var
//  I: Integer;
//  AtribStrList: TStringList;
begin
  inherited Create;
  FNodeManager := ANodeManager;

  FName := AName;
//  AtribStrList := TStringList.Create;
{  FNodesSQLClassName := ANodesSQLClassName;
  FMasterTemplateName := AMasterTemplateName;
  FNodesMemTableName := ANodesMemTableName;
  SetLength(FParams, Length(AParams));
  for I := 0 to High(AParams) do
    FParams[I] := AParams[I];
  FObjIdFieldName := AObjIdFieldName;
  FInTreeTextFieldName := AInTreeTextFieldName;
  FNodesFilter := ANodesFilter;
  FNodesFieldsInGrid := ANodesFieldsInGrid;
  FHasNodes := AHasNodes;

  AtribStrList.CommaText := AColumnAttributes;
  for i := 0 to AtribStrList.Count div 3 - 1 do
  begin
    SetLength(FColumnAttributes, i+1);
    FColumnAttributes[i].FieldName := AtribStrList[i*3];
    FColumnAttributes[i].Title := AtribStrList[i*3 + 1];
    FColumnAttributes[i].Width := StrToInt(AtribStrList[i*3 + 2]);
  end;

  AtribStrList.CommaText := AAdditionalFielsInfo;
}
(*  for i := 0 to AtribStrList.Count div 3 - 1 do
  begin
    SetLength(FFieldAttributes, i+1);
    FFieldAttributes[i].FieldName := AtribStrList[i*3];
{ TODO : Realize and use }
//    FFieldAttributes[i].FieldType := FieldTypeByName(AtribStrList[i*3 + 1]);
    FFieldAttributes[i].Size := StrToInt(AtribStrList[i*3 + 2]);
  end;

  AtribStrList.Free;*)

  FNodeManager.AddTemplate(Self);

  SetLength(FTableNodeDropMenuParams, 4);
  FTableNodeDropMenuParams[0].OnGetMenuText := DropMenuNodeText;
  FTableNodeDropMenuParams[0].OnGetDataText := DropMenuNodeText;
  FTableNodeDropMenuParams[1].OnGetMenuText := DropMenuNlCommaNodeText;
  FTableNodeDropMenuParams[1].OnGetDataText := DropMenuNlCommaNodeText;
  FTableNodeDropMenuParams[2].OnGetMenuText := DropMenuSelectAstFromName;
  FTableNodeDropMenuParams[2].OnGetDataText := DropMenuSelectAstFromName;
  FTableNodeDropMenuParams[3].OnGetMenuText := DropMenuSelectAllFieldsFromName;
  FTableNodeDropMenuParams[3].OnGetDataText := DropDataSelectAllFieldsFromName;

end;

function TSQLTreeNodeTemplate.CreateNode: TSQLTreeNode;
begin
  Result := TSQLTreeNode.Create;
end;

destructor TSQLTreeNodeTemplate.Destroy;
begin
  
  inherited Destroy;
end;

procedure TSQLDataEditWin.sbRefreshClick(Sender: TObject);
var
  i: Integer;
  Par: TParam;
  Params: TParams;
begin

  DesignDriver.SelectCommand.CommandText.Text := Memo1.Lines.Text;
//  Params := TParams.Create;
  try
    Params := DesignDriver.SelectCommand.GetParams;//(Params);
    for i := 1 to mtParams.RecordCount do
    begin
      mtParams.RecNo := i;
      Par := Params.FindParam(mtParams['ParName']);
      if Par <> nil then
      begin
        Par.Value := mtParams['ParValue']
      end;
    end;
    DesignDriver.SelectCommand.SetParams(Params);
  finally
//    Params.Free;
  end;

  AssignToDesignControls;
end;

procedure TSQLDataEditWin.DBEditEh1EditButtons0Click(Sender: TObject;
  var Handled: Boolean);
begin
  if Assigned(DataDriver.DesignDataBase) then
//   (DataDriver.DesignDataBase as IDesignDataBaseEh).EditDatabaseParams;
   TDesignDataBaseEh(DataDriver.DesignDataBase).EditDatabaseParams;
end;

(*
{ TCustomDBService }

constructor TCustomDBService.Create(DesignDataBase: TDesignDataBaseEh);
begin
  inherited Create;
  FDesignDataBase := DesignDataBase;
end;


{ TOracleDBService }

function TOracleDBService.BuildObjectTree(TreeView: TTreeView): Boolean;
begin
  Result := False;
end;

{ TInterbaseDBService }

function TInterbaseDBService.BuildObjectTree(TreeView: TTreeView): Boolean;
begin
  Result := False;
end;

{ TMSSQLDBService }

function TMSSQLDBService.BuildObjectTree(TreeView: TTreeView): Boolean;
begin
  Result := False;
end;

{ TMSAccessDBService }

function TMSAccessDBService.BuildObjectTree(TreeView: TTreeView): Boolean;
begin
  Result := False;
end;

{ TMySQLDBService }

function TMySQLDBService.BuildObjectTree(TreeView: TTreeView): Boolean;
begin
  Result := False;
end;

*)

function TSQLTreeNodeTemplate.DropMenuNlCommaNodeText(Sender: TObject): String;
begin
  Result := TSQLTreeNode(Sender).FName;
end;

function TSQLTreeNodeTemplate.DropMenuNodeText(Sender: TObject): String;
begin
  Result :=  #13#10 + '  ,' + TSQLTreeNode(Sender).FName;
end;

function TSQLTreeNodeTemplate.DropMenuSelectAllFieldsFromName(
  Sender: TObject): String;
begin
  Result :=  'select <All Fields> from ' + TSQLTreeNode(Sender).FName;
end;

function TSQLTreeNodeTemplate.DropDataSelectAllFieldsFromName(
  Sender: TObject): String;
var
  i: Integer;
  Comma: String;
begin
  Result :=  'select'#13#10;
  Comma := '';
  if TSQLTreeNode(Sender).FNodes = nil then Exit;
  for i := 0 to TSQLTreeNode(Sender).FNodes.Count-1  do
  begin
    Result := Result + '  ' + Comma +
//      IGetSQLTreeNode(TSQLTreeNode(Sender).FNodes[i]).GetSQLTreeNode.FName + #13#10;
      TSQLTreeNode(TSQLTreeNode(Sender).FNodes[i]).FName + #13#10;
    Comma := ',';
  end;
  Result := Result + 'from' + #13#10 + '  ' + TSQLTreeNode(Sender).FName;
end;

function TSQLTreeNodeTemplate.DropMenuSelectAstFromName(Sender: TObject): String;
begin
  Result :=  'select *' + #13#10 + 'from' + #13#10 + '  ' + TSQLTreeNode(Sender).FName;
end;

type
{$IFDEF CIL}
  TSQLTreeDragObjectEx = class(TDragObject)
{$ELSE}
  TSQLTreeDragObjectEx = class(TDragObjectEx)
{$ENDIF}
  public
//    SQLTreeNode: IGetSQLTreeNode;
    SQLTreeNode: TSQLTreeNode;
  end;

procedure TSQLTreeNodeTemplate.OnPopupClick(Sender: TObject);
begin
  FSelectedIndex := TMenuItem(Sender).Tag;
end;

function TSQLTreeNodeTemplate.ShowPopup(Source: TObject; Coord: TPoint;
  Params: TServicePopupParams): Integer;
var
  ppm: TPopupMenu;
  ppmi: TMenuItem;
  i: Integer;
begin
  ppm := TPopupMenu.Create(SQLDataEditWin);
  for i := 0 to Length(Params)-1 do
  begin
    ppmi := TMenuItem.Create(SQLDataEditWin);
    ppmi.Caption := Params[i].OnGetMenuText(Source);
    ppmi.OnClick := OnPopupClick;
    ppmi.Tag := i;
    ppm.Items.Add(ppmi);
  end;
  FSelectedIndex := -1;
  SQLDataEditWin.Memo1.PopupMenu := ppm;
  ppm.Popup(Coord.X, Coord.Y);
  Application.ProcessMessages;
  Result := FSelectedIndex;
  ppm.Free;
end;

procedure TSQLTreeNodeTemplate.TableEditorDrop(Sender, Source: TObject; X, Y: Integer);
var
  re: TMemo;
  node: TSQLTreeNode;
  ppi: Integer;
  Text: String;
  Pos, PosY: Integer;
begin
  if Sender is TMemo
    then re := (Sender as TMemo)
    else Exit;
  if Source is TSQLTreeDragObjectEx
    then node := (Source as TSQLTreeDragObjectEx).SQLTreeNode.GetSQLTreeNode
    else Exit;
//  if Length(node.PopupParams) = 0 then
//    Exit;
  ppi := -1;
  if Length(FTableNodeDropMenuParams) > 1 then
  begin
    ppi := ShowPopup(node, re.ClientToScreen(Point(X,Y)), FTableNodeDropMenuParams);
  end;
  Text := #13#10 + ' ,' + AnsiLowerCase(node.FName);
  if ppi < 0 then Exit;
  if Assigned(FTableNodeDropMenuParams[ppi].OnGetDataText) then
    Text := FTableNodeDropMenuParams[ppi].OnGetDataText(node);

  Pos := SendMessage(re.Handle, EM_CHARFROMPOS, 0, MakeLong(Word(X), Word(Y)));
//  PosX := HiWord(Pos);
  PosY := Word(Pos);
  re.SelStart := PosY;
  re.SelText := Text;
end;

procedure TSQLTreeNodeTemplate.SetColumnAttributes(const Value: String);
var
  AtribStrList: TStringList;
  i: Integer;
begin
  AtribStrList := TStringList.Create;
  try
    AtribStrList.CommaText := Value;
    for i := 0 to AtribStrList.Count div 3 - 1 do
    begin
      SetLength(FColumnAttributes, i+1);
      FColumnAttributes[i].FieldName := AtribStrList[i*3];
      FColumnAttributes[i].Title := AtribStrList[i*3 + 1];
      FColumnAttributes[i].Width := StrToInt(AtribStrList[i*3 + 2]);
    end;
    FColumnAttributesStr := Value;
  finally
    AtribStrList.Free;
  end;
end;

{ TInformixDBService }

constructor TInformixDBService.Create(ADesignDB: TDesignDataBaseEh);
//var
//  SysNode, Node: TTreeNode;
var
  Template: TSQLTreeNodeTemplate;
begin
  inherited Create(ADesignDB);

  //FieldName, Caption, Width
  AddSQLClass('ServerItems', LoadText('INFORMIX.ServerItems'));
  AddSQLClass('TableObjects',LoadText('INFORMIX.Tables'));
  AddSQLClass('Columns', LoadText('INFORMIX.Tables.Columns'));
//  AddSQLClass('Views',LoadText('INFORMIX.Views'));
  AddSQLClass('Procedures',LoadText('INFORMIX.Procedures'));

  AddSQLClass('SysInfo',LoadText('INFORMIX.SysInfo.ServerItems'));
  AddSQLClass('SysTables',LoadText('INFORMIX.SysTables'));
  AddSQLClass('SysTables.Columns',LoadText('INFORMIX.SysTables.Columns'));
  AddSQLClass('SysProcedures',LoadText('INFORMIX.SysProcedures'));
//// TSQLTreeNodeTemplate's

//Informix Server
  with TSQLTreeNodeTemplate.Create(Self, 'Informix Server') do
  begin
    NodesSQLClassName :=    'ServerItems';
    MasterTemplateName :=   '';
    NodesMemTableName :=    'ServerItems';
//    Params                [], //Params
    ObjIdFieldName :=       'OBJ_NAME';
    InTreeTextFieldName :=  'OBJ_NAME';
    HasNodes :=             True;
    NodesFilter :=          'aowner <> ''informix''';
//    NodesFieldsInGrid :=    'name;id';
//    ColumnAttributesStr :=
//    AdditionalLoadSQL :=
//    AdditionalFielsInfo :=
  end;

//Tables
  Template := TSQLTreeNodeTemplate.Create(Self, 'Tables');
  with Template do
  begin
    NodesSQLClassName :=    'TableObjects';
    MasterTemplateName :=   'Tables';
    NodesMemTableName :=    'TableObjects';
//      Params                //[], //Params
    ObjIdFieldName :=       'tabid';
    InTreeTextFieldName :=  'name';
    HasNodes :=             True;
    NodesFilter :=          'atype = ''T'' and owner <> ''informix''';
//    NodesFieldsInGrid :=    'name;id';
    ColumnAttributesStr :=  '"TypeName", "Type", "100", '+ '"Description",  "Description", "200"';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;


//TableColumns
  Template := TSQLTreeNodeTemplate.Create(Self, 'TableColumns');
  with Template do
  begin
    NodesSQLClassName :=    'Columns';
    MasterTemplateName :=   '';
    NodesMemTableName :=    'TableColumns';
    // Params               [], //Params
    ObjIdFieldName :=       'colno';
    InTreeTextFieldName :=  'colname';
    HasNodes :=             False;
    NodesFilter :=          '[tabid] = ''%[tabid]''';
//    NodesFieldsInGrid :=    'name;id';
    ColumnAttributesStr :=  '"colname", "Column name", "100", '+
      '"",  "Domain", "100", '+
      '"",  "Description", "100"';
    OnNodeDragDrop := TableEditorDrop;
  end;

//Views
  Template := TSQLTreeNodeTemplate.Create(Self,'Views');
  with Template do
  begin
    NodesSQLClassName :=    'TableObjects';
    MasterTemplateName :=   'Views';
    NodesMemTableName :=    'TableObjects';
    // Params               [], //Params
    ObjIdFieldName :=       'tabid';
    InTreeTextFieldName :=  'name';
    HasNodes :=             True;
    NodesFilter :=          'atype IN (''V'') and owner <> ''informix''';
//    NodesFieldsInGrid :=    'name;id';
    ColumnAttributesStr :=  '"Name", "Table name", "100", '+
    '"Description",  "Description", "200"';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//ViewColumns
  Template := TSQLTreeNodeTemplate.Create(Self, 'ViewColumns');
  with Template do
  begin
    NodesSQLClassName :=    'Columns';
    MasterTemplateName :=   '';
    NodesMemTableName :=    'TableColumns';
    // Params               [], //P
    ObjIdFieldName :=       'colno';
    InTreeTextFieldName :=  'colname';
    HasNodes :=             False;
    NodesFilter :=          '[tabid] = ''%[tabid]''';
//    NodesFieldsInGrid :=    'name;id';
    ColumnAttributesStr :=  '"colname", "Column name", "100", '+
      '"",  "Domain", "100", '+
      '"",  "Description", "100"';
    OnNodeDragDrop := TableEditorDrop;
  end;

//Sinonims
  Template := TSQLTreeNodeTemplate.Create(Self, 'Sinonims');
  with Template do
  begin
    NodesSQLClassName :=    'TableObjects';
    MasterTemplateName :=   'Sinonims';
    NodesMemTableName :=    'TableObjects';
    // Params               [], //Params;
    ObjIdFieldName :=       'tabid';
    InTreeTextFieldName :=  'name';
    HasNodes :=             False;
    NodesFilter :=          'atype IN (''P'', ''S'') and owner <> ''informix''';
//    NodesFieldsInGrid :=    'name;id';
    ColumnAttributesStr :=  '"Name", "Table name", "100", '+
    '"Description",  "Description", "200"';
    OnNodeDragDrop := TableEditorDrop;
  end;

//Procedures
  Template := TSQLTreeNodeTemplate.Create(Self, 'Procedures');
  with Template do
  begin
    NodesSQLClassName :=    'Procedures';
    MasterTemplateName :=   'Procedures';
    NodesMemTableName :=    'Procedures';
    // Params               [], //Params;
    ObjIdFieldName :=       'objname';
    InTreeTextFieldName :=  'name';
    HasNodes :=             False;
    NodesFilter :=          '';
//    NodesFieldsInGrid :=    'name';
    ColumnAttributesStr :=  '"TypeName", "Type", "100" ';
    OnNodeDragDrop := TableEditorDrop;
  end;

//SysInfo.ServerItems
  Template := TSQLTreeNodeTemplate.Create(Self, 'SysInfo');
  with Template do
  begin
    NodesSQLClassName :=    'SysInfo';
    MasterTemplateName :=   'SysInfo';
    NodesMemTableName :=    'ServerItems';
    // Params               [], //Params
    ObjIdFieldName :=       'OBJ_NAME';
    InTreeTextFieldName :=  'OBJ_NAME';
    HasNodes :=             True;
    NodesFilter :=          'aowner = ''informix''';
//    NodesFieldsInGrid :=    'name;id';
  end;

//SysTables
  Template := TSQLTreeNodeTemplate.Create(Self, 'SysTables');
  with Template do
  begin
    NodesSQLClassName :=    'SysTables';
    MasterTemplateName :=   'Tables';
    NodesMemTableName :=    'TableObjects';
    // Params               [], //Params
    ObjIdFieldName :=       'tabid';
    InTreeTextFieldName :=  'name';
    HasNodes :=             True;
    NodesFilter :=          'atype = ''T'' and owner = ''informix''';
//    NodesFieldsInGrid :=    'name;id';
    ColumnAttributesStr := '"TypeName", "Type", "100", '+
    '"Description",  "Description", "200"';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//SysViews
  Template := TSQLTreeNodeTemplate.Create(Self, 'SysViews');
  with Template do
  begin
    NodesSQLClassName :=    'SysTables';
    MasterTemplateName :=   'Views';
    NodesMemTableName :=    'TableObjects';
    // Params               [], //Params
    ObjIdFieldName :=       'tabid';
    InTreeTextFieldName :=  'name';
    HasNodes :=             True;
    NodesFilter :=          'atype IN (''V'') and owner = ''informix''';
//    NodesFieldsInGrid :=    'name;id';
    ColumnAttributesStr :=  '"Name", "Table name", "100", '+
    '"Description",  "Description", "200"';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//SysSinonims
  Template := TSQLTreeNodeTemplate.Create(Self, 'SysSinonims');
  with Template do
  begin
    NodesSQLClassName :=    'SysTables';
    MasterTemplateName :=   'Sinonims';
    NodesMemTableName :=    'TableObjects';
    // Params               [], //Params
    ObjIdFieldName :=       'tabid';
    InTreeTextFieldName :=  'name';
    HasNodes :=             False;
    NodesFilter :=          'atype IN (''P'', ''S'') and owner = ''informix''';
//    NodesFieldsInGrid :=    'name;id';
    ColumnAttributesStr :=  '"Name", "Table name", "100", '+
    '"Description",  "Description", "200"';
    OnNodeDragDrop := TableEditorDrop;
  end;

//SysProcedures
  Template := TSQLTreeNodeTemplate.Create(Self, 'SysProcedures');
  with Template do
  begin
    NodesSQLClassName :=    'SysProcedures';
    MasterTemplateName :=   'SysProcedures';
    NodesMemTableName :=    'SysProcedures';
    // Params               [], //Params
    ObjIdFieldName :=       'objname';
    InTreeTextFieldName :=  'name';
    HasNodes :=             False;
    NodesFilter :=          '';
//    NodesFieldsInGrid :=    'name';
    ColumnAttributesStr :=  '"TypeName", "Type", "100" ';
    OnNodeDragDrop := TableEditorDrop;
  end;
end;

procedure TInformixDBService.GenGetSpecParams(
  DesignUpdateParams: TDesignUpdateParamsEh;
  DesignUpdateInfo: TDesignUpdateInfoEh);
begin
  DesignUpdateInfo.SpecParams.Clear;
  if DesignUpdateParams.IncremenField <> '' then
    DesignUpdateInfo.SpecParams.Add('AUTO_INCREMENT_FIELD=' + DesignUpdateParams.IncremenField);
end;

class function TInformixDBService.GetDBServiceName: String;
begin
  Result := 'Informix';
end;

function TInformixDBService.GetSpecParamsList: String;
begin
  Result := 'AUTO_INCREMENT_FIELD =';
end;

procedure TInformixDBService.MemTableBuildStruct(MemTable: TMemTableEh;
  Source: TDataSet);
begin
  inherited MemTableBuildStruct(MemTable, Source);
  if MemTable.Name = 'ServerItems' then
  begin
    MemTable.RecordsView.MemTableData.DataStruct.FieldByName('OBJ_NAME').Size := 50;
    MemTable.RecordsView.MemTableData.DataStruct.FieldByName('TEMPLATE_NAME').Size := 50;
    MemTable.RecordsView.MemTableData.DataStruct.FieldByName('NODES_SQLCLASS_NAME').Size := 50;
    MemTable.RecordsView.MemTableData.DataStruct.FieldByName('LOCAL_FILTER').Size := 250;
  end;
end;

procedure TInformixDBService.TableEditorDrop(Sender, Source: TObject; X, Y: Integer);
var
  re: TMemo;
  node: TSQLTreeNode;
  ppi: Integer;
  Text: String;
  Pos, {PosX, }PosY: Integer;
begin
  if Sender is TMemo
    then re := (Sender as TMemo)
    else Exit;
  if Source is TSQLTreeDragObjectEx
    then node := (Source as TSQLTreeDragObjectEx).SQLTreeNode.GetSQLTreeNode
    else Exit;
//  if Length(node.PopupParams) = 0 then
//    Exit;
  ppi := -1;
  if Length(node.PopupParams) > 1 then
  begin
    ppi := ShowPopup(node, re.ClientToScreen(Point(X,Y)), node.PopupParams);
  end;
  Text := #13#10 + ' ,' + AnsiLowerCase(node.FName);
  if ppi >= 0 then
    if Assigned(node.PopupParams[ppi].OnGetDataText) then
      Text := node.PopupParams[ppi].OnGetDataText(node);

  Pos := SendMessage(re.Handle, EM_CHARFROMPOS, 0, MakeLong(Word(X), Word(Y)));
//  PosX := HiWord(Pos);
  PosY := Word(Pos);
  re.SelStart := PosY;
  re.SelText := Text;
end;

{ TInterbaseDBService }

constructor TInterbaseDBService.Create(ADesignDB: TDesignDataBaseEh);
//var
//  BDEInterbaseManager: TCustomDBService;
var
  Template: TSQLTreeNodeTemplate;
begin
  inherited Create(ADesignDB);

  AddSQLClass('ServerItems', LoadText('Interbase.ServerItems'));
  AddSQLClass('Tables.Views',LoadText('Interbase.Tables.Views'));
  AddSQLClass('TableColumns',LoadText('Interbase.TableColumns'));
  AddSQLClass('Procedures',LoadText('Interbase.Procedures'));
  AddSQLClass('ProcedureParameters',LoadText('Interbase.ProcedureParameters'));
  AddSQLClass('Functions',LoadText('Interbase.Functions'));
  AddSQLClass('FunctionParameters',LoadText('Interbase.FunctionParameters'));
  AddSQLClass('Generators',LoadText('Interbase.Generators'));

//  BDEInterbaseManager := TCustomDBService.Create(nil);
{ ANodeManager: TCustomDBService;
  ANodesSQLText: String;
  AMasterTemplateName: String;
  ANodesMemTableName: String;
  AParams: TParamsArr;
  AObjIdFieldName: String;
  AInTreeTextFieldName: String;
  ANodesFilter: String;
//  ANodesFieldsInGrid: String
}

//Interbase Server
  Template := TSQLTreeNodeTemplate.Create(Self, 'Interbase Server');
  with Template do
  begin
    NodesSQLClassName :=    'ServerItems';
    MasterTemplateName :=   '';
    NodesMemTableName :=    'ServerItems';
    // Params               [], //Params
    ObjIdFieldName :=       'OBJ_NAME';
    InTreeTextFieldName :=  'OBJ_NAME';
    HasNodes :=             True;
    NodesFilter :=          '';
//    NodesFieldsInGrid :=    'name;id';
    //ColumnAttributesStr :=
  end;

//Tables
  Template := TSQLTreeNodeTemplate.Create(Self, 'Tables');
  with Template do
  begin
    NodesSQLClassName :=    'Tables.Views';
    MasterTemplateName :=   'Tables';
    NodesMemTableName :=    'Table';
    // Params               [], //Params
    ObjIdFieldName :=       'tabid';
    InTreeTextFieldName :=  'name';
    HasNodes :=             True;
    NodesFilter :=          '[RDB$VIEW_SOURCE] IS NULL';
//    NodesFieldsInGrid :=    'name;id';
    ColumnAttributesStr :=  '"Name", "Table name", "100", '+
    '"Description",  "Description", "200"';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//Views
  Template := TSQLTreeNodeTemplate.Create(Self, 'Views');
  with Template do
  begin
    NodesSQLClassName :=    'Tables.Views';
    MasterTemplateName :=   'Views';
    NodesMemTableName :=    'Table';
    // Params               [], //Params
    ObjIdFieldName :=       'tabid';
    InTreeTextFieldName :=  'name';
    HasNodes :=             True;
    NodesFilter :=          '[RDB$VIEW_SOURCE] IS NOT NULL';
//    NodesFieldsInGrid :=    'name;id';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//TableColumns
  Template := TSQLTreeNodeTemplate.Create(Self, 'TableColumns');
  with Template do
  begin
    NodesSQLClassName :=    'TableColumns';
    MasterTemplateName :=   '';
    NodesMemTableName :=    'TableColumns';
    // Params               [], //Params
    ObjIdFieldName :=       'colno';
    InTreeTextFieldName :=  'colname';
    HasNodes :=             False;
    NodesFilter :=          '[tabid] = ''%[name]''';
//    NodesFieldsInGrid :=    'name;id';
    ColumnAttributesStr :=  '';
//    '"colname", "Column name", "100", '+
//      '"RDB$FIELD_SOURCE",  "Domain", "100", '+
//      '"RDB$DESCRIPTION",  "Description", "100"'
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//TableColumnsProps
  Template := TSQLTreeNodeTemplate.Create(Self, 'TableColumnsProps');
  with Template do
  begin
    NodesSQLClassName :=    '';
    MasterTemplateName :=   'TableColumns';
    NodesMemTableName :=    '';
    // Params               [], //Params
    ObjIdFieldName :=       '';
    InTreeTextFieldName :=  '';
    HasNodes :=             False;
    NodesFilter :=          '';
//    NodesFieldsInGrid :=    '';
    ColumnAttributesStr :=  '';
  end;

//Procedures
  Template := TSQLTreeNodeTemplate.Create(Self, 'Procedures');
  with Template do
  begin
    NodesSQLClassName :=    'Procedures';
    MasterTemplateName :=   'ServerItems';
    NodesMemTableName :=    'Procedures';
    // Params               [], //Params
    ObjIdFieldName :=       'RDB$PROCEDURE_NAME';
    InTreeTextFieldName :=  'RDB$PROCEDURE_NAME';
    HasNodes :=             True;
    NodesFilter :=          '';
///    NodesFieldsInGrid :=    'name;id';
//    ColumnAttributesStr :=
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//ProcedureParameters
  Template := TSQLTreeNodeTemplate.Create(Self, 'ProcedureParameters');
  with Template do
  begin
    NodesSQLClassName :=    'ProcedureParameters';
    MasterTemplateName :=   'Procedures';
    NodesMemTableName :=    'ProcedureParameters';
    // Params               [], //Params
    ObjIdFieldName :=       'RDB$PARAMETER_NAME';
    InTreeTextFieldName :=  'RDB$PARAMETER_NAME';
    HasNodes :=             False;
    NodesFilter :=          '[RDB$PROCEDURE_NAME] = ''%[RDB$PROCEDURE_NAME]''';
//    NodesFieldsInGrid :=    'name;id';
    //ColumnAttributesStr :=
  end;

//Functions
  Template := TSQLTreeNodeTemplate.Create(Self, 'Functions');
  with Template do
  begin
    NodesSQLClassName :=    'Functions';
    MasterTemplateName :=   'ServerItems';
    NodesMemTableName :=    'Functions';
    // Params               [], //Params
    ObjIdFieldName :=       'RDB$FUNCTION_NAME';
    InTreeTextFieldName :=  'RDB$FUNCTION_NAME';
    HasNodes :=             True;
    NodesFilter :=          '';
//    NodesFieldsInGrid :=    'name;id';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//FunctionParameters
  Template := TSQLTreeNodeTemplate.Create(Self, 'FunctionParameters');
  with Template do
  begin
    NodesSQLClassName :=    'FunctionParameters';
    MasterTemplateName :=   'Functions';
    NodesMemTableName :=    'FunctionParameters';
    // Params               [], //Params
    ObjIdFieldName :=       'RDB$ARGUMENT_POSITION';
    InTreeTextFieldName :=  'RDB$ARGUMENT_POSITION';
    HasNodes :=             False;
    NodesFilter :=          '[RDB$FUNCTION_NAME] = ''%[RDB$FUNCTION_NAME]''';
//    NodesFieldsInGrid :=    'name;id';
    //ColumnAttributesStr :=
  end;

//Generators
  Template := TSQLTreeNodeTemplate.Create(Self, 'Generators');
  with Template do
  begin
    NodesSQLClassName :=    'Generators';
    MasterTemplateName :=   'ServerItems';
    NodesMemTableName :=    'Generators';
    // Params               [], //Params
    ObjIdFieldName :=       'RDB$GENERATOR_NAME';
    InTreeTextFieldName :=  'RDB$GENERATOR_NAME';
    HasNodes :=             False;
    NodesFilter :=          '';
//    NodesFieldsInGrid :=    'name;id';
    //ColumnAttributesStr :=
    OnNodeDragDrop := Template.TableEditorDrop;
  end;
end;

procedure TInterbaseDBService.AssignRecord(Source, Destinate: TDataSet);
var
  i: Integer;
  Field: TField;
begin
  for i := 0 to Destinate.FieldCount-1 do
    if Destinate.Fields[i].FieldNo > 0 then
    begin
      Field := Source.FindField(Destinate.Fields[i].FieldName);
      if Field <> nil then
        if Field is TStringField and not Field.IsNull then
          Destinate.Fields[i].Value := TrimRight(VarToStr(Field.Value))
        else
          Destinate.Fields[i].Value := Field.Value;
    end;
end;

procedure TSQLDataEditWin.DBEditEh1EditButtons1Click(Sender: TObject; var Handled: Boolean);
var
  DesignDataBase: TComponent;
begin
  DesignDataBase := SelectDesignConnectionListEh(DesignDataBaseList);
  if (DesignDataBase <> nil) and (DesignDataBase <> DataDriver.DesignDataBase) then
  begin
    DesignDriver.DesignDataBase := DesignDataBase;
    DataDriver.DesignDataBase := DesignDataBase;
    Self.DesignDataBase := TDesignDataBaseEh(DataDriver.GetDesignDataBase);
//    BuildObjectTree;
    SetObjectTreeParams;
  end;
end;

(*
procedure TSQLDataEditWin.TreeView1StartDrag(Sender: TObject;
  var DragObject: TDragObject);
//var
//  SQLTreeNode: TSQLTreeNode;
begin
//  if TreeView1.GetNodeAt(DragObject.DragTargetPos.X, DragObject.DragTargetPos.Y) = nil then
//    Exit;
//  SQLTreeNode := TSQLTreeNode(TreeView1.GetNodeAt(DragObject.DragTargetPos.X, DragObject.DragTargetPos.Y).Data);
//  if @SQLTreeNode.FNodesTemplate.OnDragDrop <> nil then
  begin
    DragObject := TSQLTreeDragObjectEx.Create;
    TSQLTreeDragObjectEx(DragObject).SQLTreeNode := DragSQLTreeNode;
//    DragObject.
//    SQLTreeNode.FNodesTemplate.
  end;
end;

procedure TSQLDataEditWin.TreeView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  SQLTreeNode: TSQLTreeNode;
begin
  if TreeView1.GetNodeAt(X, Y) = nil then
    Exit;
  SQLTreeNode := TSQLTreeNode(TreeView1.GetNodeAt(X, Y).Data);
  if (SQLTreeNode = nil) or (SQLTreeNode.FNodesTemplate = nil) then
    Exit;
  if @SQLTreeNode.OnDragDrop <> nil then
  begin
    DragSQLTreeNode := SQLTreeNode;
    TreeView1.BeginDrag(False);
  end;
end;
*)

(*procedure TInterbaseDBService.TableEditorDrop(Sender, Source: TObject; X, Y: Integer);
var
  re: TMemo;
  node: TSQLTreeNode;
  ppi: Integer;
  Text: String;
  Pos, {PosX, }PosY: Integer;
begin
  if Sender is TMemo
    then re := (Sender as TMemo)
    else Exit;
  if Source is TSQLTreeDragObjectEx
    then node := (Source as TSQLTreeDragObjectEx).SQLTreeNode
    else Exit;
//  if Length(node.PopupParams) = 0 then
//    Exit;
  ppi := -1;
  if Length(node.PopupParams) > 1 then
  begin
    ppi := ShowPopup(node, re.ClientToScreen(Point(X,Y)), node.PopupParams);
  end;
  Text := #13#10 + ' ,' + AnsiLowerCase(node.FName);
  if ppi >= 0 then
    if Assigned(node.PopupParams[ppi].OnGetDataText) then
      Text := node.PopupParams[ppi].OnGetDataText(node);

  Pos := SendMessage(re.Handle, EM_CHARFROMPOS, 0, MakeLong(Word(X), Word(Y)));
//  PosX := HiWord(Pos);
  PosY := Word(Pos);
  re.SelStart := PosY;
  re.SelText := Text;
end;*)

procedure TSQLDataEditWin.Memo1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Source is TSQLTreeDragObjectEx then
    Accept := True;
end;

procedure TSQLDataEditWin.Memo1DragDrop(Sender, Source: TObject; X, Y: Integer);
//var
//  Pos, {PosX, }PosY: Integer;
//  SP: TPoint;
begin
  if Assigned(TSQLTreeDragObjectEx(Source).SQLTreeNode.GetSQLTreeNode.OnDragDrop) then
  begin
//    SP := ClientToScreen(Point(X,Y));
    TSQLTreeDragObjectEx(Source).SQLTreeNode.GetSQLTreeNode.OnDragDrop(Sender, Source, X, Y);
  end;
{  Pos := SendMessage(Memo1.Handle, EM_CHARFROMPOS, 0, MakeLong(Word(X), Word(Y)));
//  PosX := HiWord(Pos);
  PosY := Word(Pos);
  Memo1.SelStart := PosY;
  Memo1.SelText := #13#10+' ,' +
    AnsiLowerCase(TSQLTreeDragObjectEx(Source).SQLTreeNode.FName);}
end;

procedure TSQLDataEditWin.Ggg1Click(Sender: TObject);
begin
//
end;

procedure TInterbaseDBService.GenGetSpecParams(
  DesignUpdateParams: TDesignUpdateParamsEh;
  DesignUpdateInfo: TDesignUpdateInfoEh);
begin
  DesignUpdateInfo.SpecParams.Clear;
  if DesignUpdateParams.IncremenField <> '' then
  begin
    DesignUpdateInfo.SpecParams.Add('AUTO_INCREMENT_FIELD=' + DesignUpdateParams.IncremenField);
    DesignUpdateInfo.SpecParams.Add('GENERATOR_FIELD=' + DesignUpdateParams.IncremenField);
  end;
  if DesignUpdateParams.IncremenObject <> '' then
    DesignUpdateInfo.SpecParams.Add('GENERATOR=' + DesignUpdateParams.IncremenObject);
end;

procedure TInterbaseDBService.GenInsertSQL(
  DesignUpdateParams: TDesignUpdateParamsEh;
  DesignUpdateInfo: TDesignUpdateInfoEh);

  procedure GenFieldList(const TabName, ParamChar, QuoteChar, GenFieldName, GenObjName: String);
  var
    L: string;
    I: integer;
    Comma: string;
  begin
    L := '  (';
    Comma := ', ';
    if GenFieldName <> '' then
    begin
      if DesignUpdateParams.UpdateFields.Count = 0 then Comma := '';
      L := Format('%s%s%s%s%s%3:s%5:s',
        [L, TabName, ParamChar, QuoteChar, GenFieldName, Comma]);
    end;
    if GenObjName <> '' then
    begin
      if DesignUpdateParams.UpdateFields.Count = 0 then Comma := '';
      L := Format('%s%s%s%s%s%3:s%5:s',
//        [L, TabName, '', QuoteChar, 'GEN_ID('+GenObjName+', 0)', Comma]);
        [L, TabName, '', QuoteChar, GenFieldName, Comma]);
    end;
    for I := 0 to DesignUpdateParams.UpdateFields.Count - 1 do
    begin
      if I = DesignUpdateParams.UpdateFields.Count - 1 then Comma := '';
      L := Format('%s%s%s%s%s%3:s%5:s',
        [L, TabName, ParamChar, QuoteChar, DesignUpdateParams.UpdateFields[I], Comma]);
      if (Length(L) > 70) and (I <> DesignUpdateParams.UpdateFields.Count - 1) then
      begin
        DesignUpdateInfo.InsertSQL.Add(L);
        L := '   ';
      end;
    end;
    DesignUpdateInfo.InsertSQL.Add(L+')');
  end;

begin
  DesignUpdateInfo.InsertSQL.Clear;
  DesignUpdateInfo.InsertSQL.Add(Format('insert into %s', [DesignUpdateParams.TableName])); { Do not localize }
  GenFieldList('', '', '', DesignUpdateParams.IncremenField, '');
  DesignUpdateInfo.InsertSQL.Add('values'); { Do not localize }
  GenFieldList('', ':', '', '', DesignUpdateParams.IncremenObject);
end;

class function TInterbaseDBService.GetDBServiceName: String;
begin
  Result := 'Interbase';
end;

function TInterbaseDBService.GetIncrementObjectsList: TStrings;
var
  s: String;
  ds: TDataSet;
begin
  if FIncrementObjectsList = nil then
    FIncrementObjectsList := TStringList.Create;
  s := LoadText('Interbase.Generators');
  ds := FDesignDB.CreateReader(s, nil);
  FIncrementObjectsList.Clear;
  while not ds.Eof do
  begin
    FIncrementObjectsList.Add(VarToStr(ds['RDB$GENERATOR_NAME']));
    ds.Next;
  end;
  Result := FIncrementObjectsList;
end;

function TInterbaseDBService.GetSpecParamsList: String;
begin
  Result := 'GENERATOR ='#13#10'GENERATOR_FIELD ='#13#10'AUTO_INCREMENT_FIELD =';
end;

{ TMSAccessDBService }

constructor TMSAccessDBService.Create(ADesignDB: TDesignDataBaseEh);
var
  Template: TSQLTreeNodeTemplate;
begin
  inherited Create(ADesignDB);

  //FieldName, Caption, Width
  AddSQLClass('ServerItems',     ' SELECT '#13+
    ' "Tables" As OBJ_NAME,'#13+
    ' "Tables" As TEMPLATE_NAME,'#13+
    ' count(*) As SUB_OBJ_NAME,'#13+
    ' "TableObjects" As NODES_SQLCLASS_NAME,'#13+
    ' "" As LOCAL_FILTER,'#13+
    ' 0  As IMAGE_INDEX'#13+
    'FROM MSysObjects s '#13+
    'WHERE type = 1 '#13    //Tables
    //SQL
  );

  AddSQLClass('TableObjects',
    'select'#13+
    '  Name As objname,'#13+
    '  type As tabid '#13+
    ', "TableColumns" As NODES_SQLCLASS_NAME'#13+
    ', "TableColumns" As TEMPLATE_NAME'#13+
    ', "" As LOCAL_FILTER'#13+
    ', 0  As IMAGE_INDEX'#13+
    'from MSysObjects s'#13+
    'where type = 1'#13+
    'order by 1,2 '#13
  );

//// TSQLTreeNodeTemplate's

//MSAccess Server
  Template := TSQLTreeNodeTemplate.Create(Self, 'MSAccess');
  with Template do
  begin
    NodesSQLClassName :=    'ServerItems';
    MasterTemplateName :=   '';
    NodesMemTableName :=    'ServerItems';
    // Params               [], //Params
    ObjIdFieldName :=       'OBJ_NAME';
    InTreeTextFieldName :=  'OBJ_NAME';
    HasNodes :=             True;
    NodesFilter :=          '';
//    NodesFieldsInGrid :=    'name;id';
    //ColumnAttributesStr :=
  end;

//Tables
  Template := TSQLTreeNodeTemplate.Create(Self, 'Tables');
  with Template do
  begin
    NodesSQLClassName :=    'TableObjects';
    MasterTemplateName :=   'Tables';
    NodesMemTableName :=    'TableObjects';
    // Params               [], //Params
    ObjIdFieldName :=       'tabid';
    InTreeTextFieldName :=  'objname';
    HasNodes :=             False;
    NodesFilter :=          '';
//    NodesFieldsInGrid :=    'objname;tabid';
    ColumnAttributesStr :='"objname", "Name", "100", '+
    '"Description",  "Description", "200"';
  end;

end;

procedure TMSAccessDBService.GenGetSpecParams(
  DesignUpdateParams: TDesignUpdateParamsEh;
  DesignUpdateInfo: TDesignUpdateInfoEh);
begin
  DesignUpdateInfo.SpecParams.Clear;
  if DesignUpdateParams.IncremenField <> '' then
    DesignUpdateInfo.SpecParams.Add('AUTO_INCREMENT_FIELD=' + DesignUpdateParams.IncremenField);
end;

class function TMSAccessDBService.GetDBServiceName: String;
begin
  Result := 'MSAccess';
end;

function TMSAccessDBService.GetSpecParamsList: String;
begin
  Result := 'AUTO_INCREMENT_FIELD =';
end;

{ TOracleDBService }

constructor TOracleDBService.Create(ADesignDB: TDesignDataBaseEh);
var
  Template: TSQLTreeNodeTemplate;
begin
  inherited Create(ADesignDB);

  //FieldName, Caption, Width
  AddSQLClass('ServerItems', LoadText('ORACLE.ServerItems'));
  AddSQLClass('Tables',LoadText('ORACLE.Tables'));
  AddSQLClass('TableColumns', LoadText('ORACLE.Tables.Columns'));
  AddSQLClass('Views',LoadText('ORACLE.Views'));
  AddSQLClass('Sequences',LoadText('ORACLE.Sequences'));

//Oracle Server
  Template := TSQLTreeNodeTemplate.Create(Self, 'Oracle Server');
  with Template do
  begin
    NodesSQLClassName :=  'ServerItems';
    MasterTemplateName := '';
    NodesMemTableName :=  'ServerItems';
    // Params             [], //Params
    ObjIdFieldName :=     'OBJ_NAME';
    InTreeTextFieldName :='OBJ_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid :=  'OBJ_NAME';
    //ColumnAttributesStr :=
  end;

//Tables
  Template := TSQLTreeNodeTemplate.Create(Self, 'Tables');
  with Template do
  begin
    NodesSQLClassName :=  'Tables';
    MasterTemplateName := 'Tables';
    NodesMemTableName :=  'TableObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'OWNER_TABLE_NAME';
    InTreeTextFieldName :='VIS_TABLE_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid :=  'VIS_TABLE_NAME;DESCRIPTION';
    ColumnAttributesStr :='"VIS_TABLE_NAME", "Table Name", "100" ' +
      '"DESCRIPTION",  "Description", "300", '
  end;


//TableColumns
  Template := TSQLTreeNodeTemplate.Create(Self, 'TableColumns');
  with Template do
  begin
    NodesSQLClassName :=  'TableColumns';
    MasterTemplateName := '';
    NodesMemTableName :=  'TableColumns';
    // Params             [], //Params
    ObjIdFieldName :=     'ID';
    InTreeTextFieldName :='COLUMN_NAME';
    HasNodes :=           False;
    NodesFilter :=        '[OWNER_TABLE_NAME] = ''%[OWNER_TABLE_NAME]''';
//    NodesFieldsInGrid :=  'COLUMN_NAME;ID';
    ColumnAttributesStr :='"COLUMN_NAME", "Column name", "100", '+
      '"ID",  "ID", "50", '+
      '"",  "Description", "100"';
  end;

//Views
  Template := TSQLTreeNodeTemplate.Create(Self, 'Views');
  with Template do
  begin
    NodesSQLClassName :=  'Views';
    MasterTemplateName := 'Views';
    NodesMemTableName :=  'ViewsObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'ID';
    InTreeTextFieldName :='VIS_OBJECT_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid :=  'VIS_OBJECT_NAME';
    ColumnAttributesStr :='"VIS_OBJECT_NAME", "View name", "200", ';
  end;

//Sequences
  Template := TSQLTreeNodeTemplate.Create(Self, 'Sequences');
  with Template do
  begin
    NodesSQLClassName :=  'Sequences';
    MasterTemplateName := 'Sequences';
    NodesMemTableName :=  'SequencesObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'ID';
    InTreeTextFieldName :='VIS_SEQUENCE_NAME';
    HasNodes :=           False;
    NodesFilter :=        '';
//    NodesFieldsInGrid :=  'VIS_SEQUENCE_NAME';
    ColumnAttributesStr :='"VIS_SEQUENCE_NAME", "Sequence name", "200" ';
  end;

end;

procedure TOracleDBService.GenGetSpecParams(
  DesignUpdateParams: TDesignUpdateParamsEh;
  DesignUpdateInfo: TDesignUpdateInfoEh);
begin
  DesignUpdateInfo.SpecParams.Clear;
  if DesignUpdateParams.IncremenField <> '' then
  begin
    DesignUpdateInfo.SpecParams.Add('AUTO_INCREMENT_FIELD=' + DesignUpdateParams.IncremenField);
    DesignUpdateInfo.SpecParams.Add('SEQUENCE_FIELD=' + DesignUpdateParams.IncremenField);
  end;
  if DesignUpdateParams.IncremenObject <> '' then
    DesignUpdateInfo.SpecParams.Add('SEQUENCE=' + DesignUpdateParams.IncremenObject);
end;

class function TOracleDBService.GetDBServiceName: String;
begin
  Result := 'Oralce';
end;

function TOracleDBService.GetSpecParamsList: String;
begin
  Result := 'SEQUENCE ='#13#10'SEQUENCE_FIELD ='#13#10'AUTO_INCREMENT_FIELD =';
end;

{ TMSSQLDBService }

constructor TMSSQLDBService.Create(ADesignDB: TDesignDataBaseEh);
var
  Template: TSQLTreeNodeTemplate;
begin
  inherited Create(ADesignDB);

  //FieldName, Caption, Width
  AddSQLClass('ServerItems', LoadText('MSSQL.ServerItems'));
  AddSQLClass('Tables',LoadText('MSSQL.Tables'));
  AddSQLClass('TableColumns', LoadText('MSSQL.Columns'));
  AddSQLClass('Views',LoadText('MSSQL.Views'));
//  AddSQLClass('Sequences',LoadText('MSSQL.Sequences'));
  AddSQLClass('Procedures',LoadText('MSSQL.Procedures'));
  AddSQLClass('Functions',LoadText('MSSQL.Functions'));
  AddSQLClass('Parameters',LoadText('MSSQL.Parameters'));

//MSSQL.ServerItems
  Template := TSQLTreeNodeTemplate.Create(Self, 'MSSQL Server');
  with Template do
  begin
    NodesSQLClassName :=  'ServerItems';
    MasterTemplateName := '';
    NodesMemTableName :=  'ServerItems';
    // Params             [], //Params
    ObjIdFieldName :=     'OBJ_NAME';
    InTreeTextFieldName :='OBJ_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid :=  'OBJ_NAME';
    //ColumnAttributesStr :=
  end;

//Tables
  Template := TSQLTreeNodeTemplate.Create(Self, 'Tables');
  with Template do
  begin
    NodesSQLClassName :=  'Tables';
    MasterTemplateName := 'Tables';
    NodesMemTableName :=  'TableObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'TABLE_NAME';
    InTreeTextFieldName :='TABLE_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid :=  'TABLE_NAME';
    ColumnAttributesStr :='"TABLE_NAME", "Table Name", "100" ';
  end;


//TableColumns
  Template := TSQLTreeNodeTemplate.Create(Self, 'TableColumns');
  with Template do
  begin
    NodesSQLClassName :=  'TableColumns';
    MasterTemplateName := '';
    NodesMemTableName :=  'TableColumns';
    // Params             [], //Params
    ObjIdFieldName :=     'ID';
    InTreeTextFieldName :='COLUMN_NAME';
    HasNodes :=           False;
    NodesFilter :=        '[TABLE_NAME] = ''%[TABLE_NAME]''';
//    NodesFieldsInGrid :=  'COLUMN_NAME;DATA_TYPE;IS_NULLABLE;COLUMN_DEFAULT';
    ColumnAttributesStr :='"COLUMN_NAME", "Column name", "100", '+
      '"DATA_TYPE",  "Type", "50", '+
      '"IS_NULLABLE", "Can Null", "20", ' +
      '"COLUMN_DEFAULT", "Def. Value", "50" ';
  end;

//Views
  Template := TSQLTreeNodeTemplate.Create(Self, 'Views');
  with Template do
  begin
    NodesSQLClassName :=  'Views';
    MasterTemplateName := 'Views';
    NodesMemTableName :=  'ViewsObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'TABLE_NAME';
    InTreeTextFieldName :='TABLE_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid :=  'TABLE_NAME';
    ColumnAttributesStr :='"TABLE_NAME", "View name", "200" ';
  end;

//Procedures
  Template := TSQLTreeNodeTemplate.Create(Self, 'Procedures');
  with Template do
  begin
    NodesSQLClassName :=  'Procedures';
    MasterTemplateName := 'Procedures';
    NodesMemTableName :=  'ProceduresObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'ROUTINE_NAME';
    InTreeTextFieldName :='ROUTINE_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid :=  'ROUTINE_NAME';
    ColumnAttributesStr :='"ROUTINE_NAME", "Routine name", "200" ';
  end;

//Functions
  Template := TSQLTreeNodeTemplate.Create(Self, 'Functions');
  with Template do
  begin
    NodesSQLClassName :=  'Functions';
    MasterTemplateName := 'Functions';
    NodesMemTableName :=  'FunctionsObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'ROUTINE_NAME';
    InTreeTextFieldName :='ROUTINE_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid :=  'ROUTINE_NAME';
    ColumnAttributesStr :='"ROUTINE_NAME", "Routine name", "200" ';
  end;

//Parameters
  Template := TSQLTreeNodeTemplate.Create(Self, 'Parameters');
  with Template do
  begin
    NodesSQLClassName :=  'Parameters';
    MasterTemplateName := '';
    NodesMemTableName :=  'Parameters';
    // Params             [], //Param
    ObjIdFieldName :=     'ID';
    InTreeTextFieldName :='PARAMETER_NAME';
    HasNodes :=           False;
    NodesFilter :=        '[SPECIFIC_NAME] = ''%[ROUTINE_NAME]''';
//    NodesFieldsInGrid :=  'PARAMETER_NAME;DATA_TYPE;IS_RESULT';
    ColumnAttributesStr :='"PARAMETER_NAME", "Param name", "100", '+
      '"DATA_TYPE",  "Type", "50", '+
      '"IS_RESULT", "Is Result", "20"';
  end;

end;

procedure TSQLDataEditWin.dsDBTreeDataChange(Sender: TObject; Field: TField);
var
//  List: Tlist;
  i: Integer;
//  TreeNode: TTreeNode;
  ATable, OldTable: TDataSet;
  Node: TSQLTreeNode;
  AllowExpansion: Boolean;
  vDBTree: TMemTableEh;
begin
  vDBTree := TMemTableEh(dsDBTree.DataSet);
  if mtDBTreeLoading or not (vDBTree.State = dsBrowse) then
    Exit;
  if not VarIsNull(vDBTree['RefData']) and (VariantToRefObject(vDBTree['RefData']) <> nil)
    then Node := TSQLTreeNode(VariantToRefObject(vDBTree['RefData']))
    else Exit;
  if (Node <> nil) then
    with Node do
    begin
      mtDBTreeExpanding(Sender, vDBTree.RecNo, AllowExpansion);

      OldTable := dsTreeDetail.DataSet;
      if OldTable <> nil then
        OldTable.DisableControls;
      try
        ATable := GetTable;
        if (ATable <> nil) and ATable.Active then
        begin
          if dsTreeDetail.DataSet <> ATable then
            dsTreeDetail.DataSet := ATable;
          gridTreeDetail.Columns.Clear;
          gridTreeDetail.Columns.BeginUpdate;
          try
//            gridTreeDetail.Columns.Clear;
            if (FNodesTemplate <> nil) and (Length(FNodesTemplate.FColumnAttributes) > 0) then
            begin
              for i := 0 to Length(FNodesTemplate.FColumnAttributes)-1  do
              begin
                with gridTreeDetail.Columns.Add do
                begin
                  FieldName := FNodesTemplate.FColumnAttributes[i].FieldName;
                  Title.Caption := FNodesTemplate.FColumnAttributes[i].Title;
                  Width := FNodesTemplate.FColumnAttributes[i].Width;
                  if i = 0 then
                  begin
                    ImageList := ImageList2;
                    ShowImageAndText := True;
                    if dsTreeDetail.DataSet.FindField('Image_Index') <> nil then
                      OnGetCellParams := gridTreeDetailColumns0GetCellParams;
                  end;
                end;
              end;
            end else
              gridTreeDetail.Columns.RebuildColumns;
            if (dsTreeDetail.DataSet.FindField('Image_Index') <> nil) and
               (gridTreeDetail.Columns.Count > 0) then
              with gridTreeDetail.Columns[0] do
              begin
                ImageList := ImageList2;
                ShowImageAndText := True;
                OnGetCellParams := gridTreeDetailColumns0GetCellParams;
              end;
          finally
            gridTreeDetail.Columns.EndUpdate;
          end;

//          dsTreeDetail.DataSet.Filter := SubstitueFileds(FMemRec, FTableFilter);
//          dsTreeDetail.DataSet.Filter := FTableFilter;
        end;
      finally
        if OldTable <> nil then
          OldTable.EnableControls;
      end;
    end;
end;

procedure TSQLDataEditWin.gridDBTreeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Node: TSQLTreeNode;
  vDBTree: TMemTableEh;
begin
  vDBTree := TMemTableEh(dsDBTree.DataSet);
  if mtDBTreeLoading or not (vDBTree.State = dsBrowse) then
    Exit;
  if not VarIsNull(vDBTree['RefData']) and (VariantToRefObject(vDBTree['RefData']) <> nil)
    then Node := TSQLTreeNode(VariantToRefObject(vDBTree['RefData']))
    else Exit;
  if not PtInRect(gridDBTree.DataRect, Point(X, Y)) then
    Exit;
//  SQLTreeNode := TSQLTreeNode(gridDBTree.DataSource.DataSet [''] TreeView1.GetNodeAt(X, Y).Data);
  if (Node = nil) {or (Node.FNodesTemplate = nil)} then
    Exit;
  if @Node.OnDragDrop <> nil then
  begin
    DragSQLTreeNode := Node;
    gridDBTree.BeginDrag(False);
  end;
end;

procedure TSQLDataEditWin.gridDBTreeStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  DragObject := TSQLTreeDragObjectEx.Create;
  TSQLTreeDragObjectEx(DragObject).SQLTreeNode := DragSQLTreeNode;
end;

procedure TSQLDataEditWin.gridParamsColumns0UpdateData(Sender: TObject;
  var Text: string; var Value: Variant; var UseText, Handled: Boolean);
begin
  (Sender as TColumnEh).Field.DataSet.Edit;
  (Sender as TColumnEh).Field.Text := Text;
  (Sender as TColumnEh).Field.DataSet.Post;
  Handled := True;
end;

procedure TSQLDataEditWin.SetObjectTreeParams;
begin
  try
    if (DataDriver.DesignDataBase <> nil) then
    begin
      if not TDesignDataBaseEh(DataDriver.DesignDataBase).GetConnected then
        TDesignDataBaseEh(DataDriver.DesignDataBase).SetConnected(True);
      if not TDesignDataBaseEh(DataDriver.DesignDataBase).GetConnected then
        Exit;
      dsDBTree.DataSet := TDesignDataBaseEh(DataDriver.DesignDataBase).GetObjectTreeDataSet;
    end;
  except
    on EDatabaseError do Application.HandleException(Self);
  end;
end;

procedure TSQLDataEditWin.ResetObjectTreeParams;
begin
  if (DataDriver.DesignDataBase <> nil) then
  begin
    if not TDesignDataBaseEh(DataDriver.DesignDataBase).GetConnected then
      TDesignDataBaseEh(DataDriver.DesignDataBase).SetConnected(True);
    if not TDesignDataBaseEh(DataDriver.DesignDataBase).GetConnected then
      Exit;
    TDesignDataBaseEh(DataDriver.DesignDataBase).ResetDesignInfo;
    dsDBTree.DataSet := TDesignDataBaseEh(DataDriver.DesignDataBase).GetObjectTreeDataSet;
  end;
end;

(*
procedure TSQLDataEditWin.BuildObjectTree;
var
  List: TObjectList;
  i: Integer;
//  TreeNode: TTreeNode;
//  ic: IInterface;
begin
//  TreeView1.Items.Clear;
  mtDBTree.Open;
  mtDBTree.EmptyTable;
  mtDBTree.TreeList.DefaultNodeHasChildren := True;
  List := TObjectList.Create(False);
  try
    try
//      if not (DataDriver.DesignDataBase as IDesignDataBaseEh).GetConnected then
      if not TDesignDataBaseEh(DataDriver.DesignDataBase).GetConnected then
//        (DataDriver.DesignDataBase as IDesignDataBaseEh).SetConnected(True);
        TDesignDataBaseEh(DataDriver.DesignDataBase).SetConnected(True);

//      (DataDriver.DesignDataBase as IDesignDataBaseEh).BuildObjectTree(List);
      TDesignDataBaseEh(DataDriver.DesignDataBase).BuildObjectTree(List);
    except
//      on E: EDatabaseError do
      on E: Exception do
          Application.HandleException(E);
    end;
    mtDBTree.DisableControls;
    try
      mtDBTreeLoading := True;
      for i := 0 to List.Count-1 do
      begin
//        ic := TSQLTreeNode(List[i]) as IInterface;
        mtDBTree.Append;
        mtDBTree.Fields[0].Value := Null;
        mtDBTree.Fields[1].Value := Null;
        mtDBTree.Fields[2].Value := TSQLTreeNode(List[i]).FName;
        mtDBTree.Fields[3].Value := 0;
        mtDBTree.Fields[4].Value := TSQLTreeNode(List[i]).FName;
        mtDBTree.Fields[5].Value := RefObjectToVariant(List[i]);
        mtDBTree.Fields[6].Value := TSQLTreeNode(List[i]).FImageIndex;
        mtDBTree.Post;
      end;
      mtDBTree.First;
    finally
      mtDBTree.EnableControls;
    end;  

  finally
    mtDBTreeLoading := False;
    List.Free;
  end;
end;
*)

procedure TSQLDataEditWin.bQueryPlanClick(Sender: TObject);
begin
  AssignToDesignDriver;
  DesignDataBase.BuildQueryPlan(MemTableEh1, DesignDriver.SelectCommand);
  //
end;

procedure TSQLDataEditWin.gridDBTreeColumns0GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  Params.ImageIndex := TDBGridColumnEh(Sender).Grid.DataSource.DataSet.FieldByName('ImageIndex').AsInteger;
end;

procedure TSQLDataEditWin.gridTreeDetailColumns0GetCellParams(
  Sender: TObject; EditMode: Boolean; Params: TColCellParamsEh);
begin
  Params.ImageIndex := TDBGridColumnEh(Sender).Grid.DataSource.DataSet.FieldByName('Image_Index').AsInteger;
end;

procedure TSQLDataEditWin.sbRefreshTreeClick(Sender: TObject);
begin
  mtDBTree.EmptyTable;
  mtDBTree.Close;
  mtTreeDetail.EmptyTable;
  if (DesignDataBase <> nil) then
  begin
    if not DesignDataBase.Connected then
      DesignDataBase.Connected := True;
//    BuildObjectTree;
    ResetObjectTreeParams;
    SetObjectTreeParams;
  end;
end;

procedure TMSSQLDBService.GenGetSpecParams(
  DesignUpdateParams: TDesignUpdateParamsEh;
  DesignUpdateInfo: TDesignUpdateInfoEh);
begin
  DesignUpdateInfo.SpecParams.Clear;
  if DesignUpdateParams.IncremenField <> '' then
    DesignUpdateInfo.SpecParams.Add('AUTO_INCREMENT_FIELD=' + DesignUpdateParams.IncremenField);
end;

class function TMSSQLDBService.GetDBServiceName: String;
begin
  Result := 'MSSQL';
end;

procedure TSQLDataEditWin.bLoadSpecStringClick(Sender: TObject);
begin
  if mSpecParams.Text <> '' then
    case MessageDlg('SpecString have data. Do you want to clear exisiting data before filling?',
        mtWarning, [mbYes, mbNo, mbCancel], -1) of
      mrYes: mSpecParams.Clear;
      mrNo: ;
      mrCancel: Exit;
    end;

  if (mSpecParams.Text = '') then
    mSpecParams.Text := DesignDataBase.GetSpecParamsList
  else
  begin
    if (mSpecParams.Text[Length(mSpecParams.Text)] <> #10) then
      mSpecParams.Text := mSpecParams.Text + #13#10;
    mSpecParams.Text := mSpecParams.Text + DesignDataBase.GetSpecParamsList;
  end;
end;

function TMSSQLDBService.GetSpecParamsList: String;
begin
  Result := 'AUTO_INCREMENT_FIELD =';
end;

{ TDesignUpdateParamsEh }

constructor TDesignUpdateParamsEh.Create;
begin
  inherited Create;
  FKeyFields := TStringList.Create;
  FUpdateFields := TStringList.Create;
  FSelectSQL := TStringList.Create;
end;

destructor TDesignUpdateParamsEh.Destroy;
begin
  FKeyFields.Free;
  FUpdateFields.Free;
  FSelectSQL.Free;
  inherited Destroy;
end;

procedure TDesignUpdateParamsEh.SetKeyFields(const Value: TStrings);
begin
  FKeyFields.Assign(Value);
end;

procedure TDesignUpdateParamsEh.SetSelectSQL(const Value: TStrings);
begin
  FSelectSQL.Assign(Value);
end;

procedure TDesignUpdateParamsEh.SetUpdateFields(const Value: TStrings);
begin
  FUpdateFields.Assign(Value);
end;

{ TDesignUpdateInfoEh }

constructor TDesignUpdateInfoEh.Create;
begin
  inherited Create;
  FDeleteSQL := TStringList.Create;
  FGetRecSQL := TStringList.Create;
  FUpdateSQL := TStringList.Create;
  FInsertSQL := TStringList.Create;
  FSpecParams := TStringList.Create;
  FUpdateFields := TStringList.Create;
  FKeyFields := TStringList.Create;
end;

destructor TDesignUpdateInfoEh.Destroy;
begin
  FDeleteSQL.Free;
  FGetRecSQL.Free;
  FUpdateSQL.Free;
  FInsertSQL.Free;
  FSpecParams.Free;
  FUpdateFields.Free;
  FKeyFields.Free;
  inherited Destroy;
end;

procedure TDesignUpdateInfoEh.SetDeleteSQL(const Value: TStrings);
begin
  FDeleteSQL.Assign(Value);
end;

procedure TDesignUpdateInfoEh.SetGetRecSQL(const Value: TStrings);
begin
  FGetRecSQL.Assign(Value);
end;

procedure TDesignUpdateInfoEh.SetInsertSQL(const Value: TStrings);
begin
  FInsertSQL.Assign(Value);
end;

procedure TDesignUpdateInfoEh.SetKeyFields(const Value: TStrings);
begin
  FKeyFields.Assign(Value);
end;

procedure TDesignUpdateInfoEh.SetSpecParams(const Value: TStrings);
begin
  FSpecParams.Assign(Value);
end;

procedure TDesignUpdateInfoEh.SetUpdateFields(const Value: TStrings);
begin
  FUpdateFields.Assign(Value);
end;

procedure TDesignUpdateInfoEh.SetUpdateSQL(const Value: TStrings);
begin
  FUpdateSQL.Assign(Value);
end;

procedure TSQLDataEditWin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  AssignToDesignDriver;
end;

initialization
  RegisterDesignDataBuilderProcEh(TSQLDataDriverEh, SetDesignSQLDataBaseProcEh);
  RegisterDBService('Interbase', TInterbaseDBService);
  RegisterDBService('Informix', TInformixDBService);
  RegisterDBService('MSAccess', TMSAccessDBService);
  RegisterDBService('Oracle', TOracleDBService);
  RegisterDBService('MSSQL', TMSSQLDBService);
//  RegisterDBService('MSSQL', TMSSQLDBService);
//  RegisterDBService('DB2', TMSAccessDBService);
//  PostgreSQL
//  Sybase
finalization
//  ShowMessage('UnRegistering SQLDriverEditEh >');
  UnregisterDesignDataBuilderProcEh(TSQLDataDriverEh);
//  ShowMessage('UnRegistering SQLDriverEditEh1');
  ReleaseDesignDataBaseList;
//  ShowMessage('UnRegistering SQLDriverEditEh2');
  ReleaseDBServiceList;
//  ShowMessage('UnRegistering SQLDriverEditEh3');
  ReleaseAccessEngineList;
//  ShowMessage('UnRegistering SQLDriverEditEh4');
  ReleaseDBServiceEngineList;
//  ShowMessage('UnRegistering SQLDriverEditEh5');
  DesignDataBaseList := nil;
//  ShowMessage('UnRegistered SQLDriverEditEh <');
end.
