unit Unit1;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_7} XPMan, {$ENDIF}
  Dialogs, DB, MemTableEh, DBGridEh, ComCtrls, MemTableDataEh,
  PropFilerEh, PropStorageEh, DataDriverEh, Buttons, EhLibMTE, ExtCtrls,
  DBCtrls, ImgList, ShlObj, ComObj, ShellAPI, GridsEh, EhLibVCL;

type
  TForm1 = class(TForm)
    DBGridEh1: TDBGridEh;
    MemTableEh1: TMemTableEh;
    MemTableEh1FileDirName: TStringField;
    MemTableEh1FileDirPath: TStringField;
    MemTableEh1FileDirAttributes: TIntegerField;
    DataSource1: TDataSource;
    MemTableEh1IsDir: TBooleanField;
    MemTableEh1Id: TAutoIncField;
    MemTableEh1RefParent: TIntegerField;
    DBNavigator1: TDBNavigator;
    TreeImages: TImageList;
    DBGridEh2: TDBGridEh;
    mtFileList: TMemTableEh;
    dsFileList: TDataSource;
    mtFileListId: TAutoIncField;
    mtFileListFileDirName: TStringField;
    mtFileListFileDirPath: TStringField;
    mtFileListFileDirAttributes: TIntegerField;
    mtFileListFileSize: TIntegerField;
    mtFileListBooleanField: TBooleanField;
    SpeedButton1: TSpeedButton;
    MemTableEh1SubcLoaded: TBooleanField;
    ToolbarImages: TImageList;
    mtFileListImageIndex: TIntegerField;
    MemTableEh1IntegerField: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DBGridEh1Columns0GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DBGridEh2GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure MemTableEh1AfterScroll(DataSet: TDataSet);
    procedure DBGridEh2Columns0GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
  private
    { Private declarations }
  public
    { Public declarations }
    CurPath: String;
    InAfterScroll: Boolean;
    Roots: TStringList;
    FIDesktopFolder: IShellFolder;
    function AddDir(APath: String; RefParent: Variant): Integer;
    function AddFiles(APath: String): Integer;
    procedure CreateRoot();
    procedure MemTableEh1Expanding(Sender: TObject; RecordNumber: Integer; var AllowExpansion: Boolean);
    procedure RecordsViewTreeNodeExpanding(Sender: TObject; Node: TMemRecViewEh; var AllowExpansion: Boolean);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function GetShellImage(Path: String; Large, Open: Boolean): Integer;
var
  FileInfo: TSHFileInfo;
  Flags: Integer;
begin
  FillChar(FileInfo, SizeOf(FileInfo), #0);
  Flags := {SHGFI_PIDL or } SHGFI_SYSICONINDEX or SHGFI_ICON;
  if Open then Flags := Flags or SHGFI_OPENICON;
  if Large then Flags := Flags or SHGFI_LARGEICON
  else Flags := Flags or SHGFI_SMALLICON;
  {Result := }SHGetFileInfo(PChar(Path),
                0,
                FileInfo,
                SizeOf(FileInfo),
                Flags);
  Result := FileInfo.iIcon;
end;

function TForm1.AddDir(APath: String; RefParent: Variant): Integer;
var
  i: Integer;
  LSrch: TSearchRec;
  ImageIndex: Integer;
begin
  Result := 0;

  i := FindFirst(APath + '\*.*', faDirectory, LSrch);
  try
    while i = 0 do
    begin
      if (LSrch.Name <> '.') and (LSrch.Name <> '..') and ((LSrch.Attr and faDirectory) <> 0) then
      begin
//        if (LSrch.Attr and faDirectory) <> 0
//          then MemTableEh1.TreeList.DefaultNodeHasChildren := True
//          else MemTableEh1.TreeList.DefaultNodeHasChildren := False;
        ImageIndex := GetShellImage(APath + '\' + LSrch.Name, False, True);
        MemTableEh1.AppendRecord([Null, RefParent, LSrch.Name,
          APath + '\' + LSrch.Name, LSrch.Attr, (LSrch.Attr and faDirectory) <> 0,
          Null, ImageIndex]);
        Inc(Result);
      end;
      i := FindNext(LSrch);
    end;
  finally
    FindClose(LSrch);
  end;
end;

function TForm1.AddFiles(APath: String): Integer;

  function SafeInt64ToInt(Val64: Int64): Integer;
  begin
    if Val64 > MAXINT
      then Result := -1
      else Result := Val64;
  end;

var
  i: Integer;
  LSrch: TSearchRec;
  ImageIndex: Integer;
begin
  Result := 0;

  i := FindFirst(APath + '\*.*', faAnyFile, LSrch);
  mtFileList.DisableControls;
  try
    while i = 0 do
    begin
      if (LSrch.Name <> '.') and (LSrch.Name <> '..') then
      begin
        ImageIndex := GetShellImage(APath + '\' + LSrch.Name, False, True);
        mtFileList.AppendRecord([Null, LSrch.Name, APath + '\' + LSrch.Name,
          LSrch.Attr, SafeInt64ToInt(LSrch.Size), (LSrch.Attr and faDirectory) <> 0, ImageIndex]);
        Inc(Result);
      end;
      i := FindNext(LSrch);
    end;
    mtFileList.SortByFields('IsDir Desc, FileDirName');
  finally
    mtFileList.First;
    mtFileList.EnableControls;
    FindClose(LSrch);
  end;
end;

const
  Flags = SHCONTF_FOLDERS or SHCONTF_NONFOLDERS or SHCONTF_INCLUDEHIDDEN;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  CreateRoot;
  Roots := TStringList.Create;
  MemTableEh1.Open;
  MemTableEh1.TreeList.KeyFieldName := 'Id';
  MemTableEh1.TreeList.RefParentFieldName := 'RefParent';
  MemTableEh1.TreeList.DefaultNodeExpanded := False;
//  MemTableEh1.TreeList.DefaultNodeHasChildren := False;
  MemTableEh1.TreeList.Active := True;

  AddDir('C:', Null);
  Roots.Clear;
  MemTableEh1.First;
  while not MemTableEh1.Eof do
  begin
    MemTableEh1.Edit;
    MemTableEh1['SubcLoaded'] := False;
    MemTableEh1.Post;
    Roots.AddObject(VarToStr(MemTableEh1['FileDirPath']), TObject(Integer(MemTableEh1['ID'])) );
    MemTableEh1.Next;
  end;
  for i := 0 to Roots.Count-1 do
    AddDir(Roots[i], Integer(Roots.Objects[i]));

  MemTableEh1.SortByFields('IsDir Desc, FileDirName');
  MemTableEh1.First;
//  MemTableEh1.OnTreeNodeExpanding := MemTableEh1Expanding;
  MemTableEh1.OnRecordsViewTreeNodeExpanding := RecordsViewTreeNodeExpanding;
//  AddDir(MemTableEh1['FileDirPath'], MemTableEh1['ID']);
  MemTableEh1.First;
end;

procedure TForm1.DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  if not VarIsNull(MemTableEh1['IsDir']) then
    if MemTableEh1['IsDir'] then
      AFont.Style := AFont.Style + [fsBold];
end;

procedure TForm1.MemTableEh1Expanding(Sender: TObject; RecordNumber: Integer; var AllowExpansion: Boolean);
var
  Id, ChildCount: Integer;
  Path: String;
  OldBM, RNBM: TUniBookmarkEh;
begin
  if MemTableEh1['SubcLoaded'] = True then Exit;
  MemTableEh1.DisableControls;
  try
  OldBM := MemTableEh1.Bookmark;
  MemTableEh1.RecNo := RecordNumber;
  RNBM := MemTableEh1.Bookmark;
  Id := MemTableEh1['ID'];
  Path := MemTableEh1['FileDirPath'];

{
  Roots.Clear;
  MemTableEh1.First;
  while not MemTableEh1.Eof do
  begin
    MemTableEh1.Edit;
    MemTableEh1['SubcLoaded'] := True;
    MemTableEh1.Post;
    Roots.AddObject(VarToStr(MemTableEh1['FileDirPath']), TObject(Integer(MemTableEh1['ID'])) );
    MemTableEh1.Next;
  end;
  for i := 0 to Roots.Count-1 do
    AddDir(Roots[i], Integer(Roots.Objects[i]));
}

  if MemTableEh1.TreeNodeHasChildren and (MemTableEh1.TreeNodeChildCount = 0) then
  begin
    ChildCount := AddDir(Path, Id);
    MemTableEh1.Bookmark := RNBM;
    MemTableEh1.TreeNode.SortByFields('IsDir Desc, FileDirName');
    MemTableEh1.TreeNodeHasChildren := (ChildCount > 0);
  end;
  if MemTableEh1.BookmarkValid(Pointer(OldBM)) then
    MemTableEh1.Bookmark := OldBM;
  finally
    MemTableEh1.EnableControls;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
//  MemTableEh1.DisableControls;
//  MemTableEh1.EnableControls;
  MemTableEh1.TreeList.FullExpand;
end;

procedure TForm1.DBGridEh1Columns0GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
//  Params.ImageIndex := mtFileList.FieldByName('ImageIndex').AsInteger;
  if not VarIsNull(MemTableEh1['IsDir']) then
    if MemTableEh1['IsDir'] then
      if MemTableEh1.TreeNodeExpanded
        then Params.ImageIndex := 5
        else Params.ImageIndex := 5;
end;

procedure TForm1.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  if CurPath <> VarToStr(MemTableEh1['FileDirPath']) then
  begin
    mtFileList.EmptyTable;
    CurPath := VarToStr(MemTableEh1['FileDirPath']);
    AddFiles(CurPath);
  end;
end;

procedure TForm1.DBGridEh2GetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  if not VarIsNull(mtFileList['IsDir']) then
    if mtFileList['IsDir'] then
      AFont.Style := AFont.Style + [fsBold];
end;

procedure TForm1.MemTableEh1AfterScroll(DataSet: TDataSet);
//var
//  AllowExpansion: Boolean;
begin
{  if InAfterScroll then Exit;
  if (MemTableEh1.TreeNodeHasChildren = True) and (MemTableEh1.TreeNodeChildCount = 0) then
  begin
    InAfterScroll := True;
    try
      MemTableEh1Expanding(DataSet, DataSet.RecNo, AllowExpansion);
    finally
      InAfterScroll := False;
    end;
  end;}
end;

procedure TForm1.RecordsViewTreeNodeExpanding(Sender: TObject;
  Node: TMemRecViewEh; var AllowExpansion: Boolean);
var
  i: Integer;
begin
  MemTableEh1.DisableControls;
  if Node.Rec.DataValues['SubcLoaded', dvvValueEh] = True then Exit;
  try
    Roots.Clear;
    for i := 0 to Node.NodesCount-1 do
      Roots.AddObject(VarToStr(Node[i].Rec.DataValues['FileDirPath', dvvValueEh]), TObject(Integer(Node[i].Rec.DataValues['ID', dvvValueEh])) );

    for i := 0 to Roots.Count-1 do
      AddDir(Roots[i], Integer(Roots.Objects[i]));

    Node.Rec.DataValues['SubcLoaded', dvvValueEh] := True;
  finally
    MemTableEh1.EnableControls;
  end;
end;

procedure TForm1.CreateRoot;
var
  EnumList: IEnumIDList;
//  ID: PItemIDList;
//  NumIDs: LongWord;
  FileInfo: TSHFileInfo;
begin
  OLECheck(SHGetDesktopFolder(FIDesktopFolder));
//  FIShellFolder := FIDesktopFolder;

  TreeImages.Handle := SHGetFileInfo('',
                          0,
                          FileInfo,
                          SizeOf(FileInfo),
                          SHGFI_SYSICONINDEX or SHGFI_SMALLICON);

//  ToolbarImages.Clear;
//  ToolbarImages.AddImage(TreeImages,0);

{  TreeImages.Handle := SHGetFileInfo('C:\',
                          0,
                          FileInfo,
                          SizeOf(FileInfo),
                          SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
}
  OleCheck(
    FIDesktopFolder.EnumObjects(
      Application.Handle,
      Flags,
      EnumList)
  );

{  while EnumList.Next(1, ID, NumIDs) = S_OK do
  begin
    ShellItem := New(PShellItem);
    ShellItem.ID := ID;
    ShellItem.DisplayName := GetDisplayName(FIShellFolder, ID, False);
    ShellItem.Empty := True;
    FIDList.Add(ShellItem);
  end;}
end;

procedure TForm1.DBGridEh2Columns0GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  Params.ImageIndex := mtFileList.FieldByName('ImageIndex').AsInteger;
end;

initialization
  DefFontData.Name := 'Microsoft Sans Serif';
end.
