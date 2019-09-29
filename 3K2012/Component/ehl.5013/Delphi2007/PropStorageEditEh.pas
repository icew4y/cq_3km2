{*******************************************************}
{                                                       }
{                       EhLib v5.0                      }
{                                                       }
{                   PropStorage editor                  }
{                                                       }
{       Copyright (c) 2002-2008 by Dmitry V. Bolshakov  }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}
//{$I EhLibClx.Inc}

{$IFDEF EH_LIB_CLX}
unit QPropStorageEditEh;
{$ELSE}
unit PropStorageEditEh {$IFDEF CIL} platform {$ENDIF};
{$ENDIF}

interface

uses
{$IFDEF EH_LIB_CLX}
  QPropStorageEh, QPropFilerEh, QStdCtrls, QComCtrls, QButtons,
  QControls, QForms, QImgList, QCheckLst, QExtCtrls,
{$ELSE}
  PropStorageEh, PropFilerEh, StdCtrls, ComCtrls, Buttons,
  Controls, Forms, ImgList, CheckLst, ExtCtrls, Windows,

{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}

{$ENDIF}
  SysUtils, TypInfo, Classes;

type
  TNodeTypeEh = (nthProperty, nthControl, nthPropNode);

  TNodeInfoEh = class
    Checked: Integer; //0 - No or 1 - Yes or 2 - Partially yes
    Instance: TObject;
    NodeType: TNodeTypeEh;
    IsVoidProperty: Boolean;
    Name: String;
    Path: String;
  end;

//  PNodeInfoEh = ^TNodeInfoEh;

  TPropStorageEditEhForm = class(TForm)
    spAddProp: TSpeedButton;
    sbRemoveAllProps: TSpeedButton;
    sbRemoveProp: TSpeedButton;
    TreeView1: TTreeView;
    TreeView2: TTreeView;
    bOk: TButton;
    bCancel: TButton;
    Bevel1: TBevel;
    ImageList1: TImageList;
    cbPredifinedProps: TCheckListBox;
    lCompsAndProps: TLabel;
    lStoredProps: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    spSynchTrees: TSpeedButton;
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreeView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TreeView1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreeView1GetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Deletion(Sender: TObject; Node: TTreeNode);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure spAddPropClick(Sender: TObject);
    procedure sbRemovePropClick(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbRemoveAllPropsClick(Sender: TObject);
    procedure cbPredifinedPropsClickCheck(Sender: TObject);
    procedure TreeView1Compare(Sender: TObject; Node1, Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
    procedure TreeView1Expanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure spSynchTreesClick(Sender: TObject);
  protected
    function AddSortedChildObject(Parent: TTreeNode; const S: string; Data: TNodeInfoEh): TTreeNode;
    function CompareNode(Node1, Node2: TTreeNode): Integer;
    function CompareNodeData(Data1, Data2: TNodeInfoEh): Integer;
    function CreateNodeInfo(Component: TComponent; Name, Path: String;
      NodeType: TNodeTypeEh; IsVoidProperty: Boolean): TNodeInfoEh;
    function FindChildNodeInfo(N2, N1: TTreeNode): TTreeNode;
    function GetChildNodeByText(ParentNode: TTreeNode; Text: String): TTreeNode;
    function GetObjectPropList(AObject: TObject; var ObjPropCount: Integer): TPropListArray;//PPropList;
    function HaveCheckedChilds(N: TTreeNode): Boolean;
    procedure AddCollectionProperties(N: TTreeNode; O: TCollection; Path: String);
    procedure AddComponents(N: TTreeNode; O: TComponent; Path: String);
    procedure AddParentChecked(N: TTreeNode);
    procedure AddProperties(N: TTreeNode; O: TObject; Path: String; IsAddPropNode: Boolean);
    procedure AddPropertyNode(N: TTreeNode);
    procedure AddVoidProperty(N: TTreeNode);
    procedure ExchangeNode(Parent: TTreeNode; L, R: Integer);
    procedure MainAddPropertyNode(N: TTreeNode); overload;
    procedure MainAddPropertyNode(Path: String); overload;
    procedure MainDeletePropertyNode(N: TTreeNode); overload;
    procedure MainDeletePropertyNode(Path: String); overload;
    procedure MainToggle(N: TTreeNode);
    procedure QuickSort(Parent: TTreeNode; L, R: Integer);
    procedure RemovePropertyNode(N: TTreeNode);
    procedure ResetChildNodes(N: TTreeNode);
    procedure ResetParentNodes(N: TTreeNode);
    procedure SlaveDeleteNode(SN: TTreeNode);
  public
    LeftBorderWidth, RightBorderWidth, ButtonSize, VBottomMargin: Integer;
    OnIconDownNode: TTreeNode;
    PropStorage: TPropStorageEh;
    RootNode: TTreeNode;
    StartBuildTicks: LongWord;


    procedure BuildPredifinedProps;
    procedure BuildPropertyList;
    procedure BuildStoringPropertyList(PropList: TStrings);
    procedure GetStoringPorps(PropList: TStrings);
    procedure PropertyAdded(DN: TTreeNode);
    procedure PropertyDeleting(DN: TTreeNode);
    procedure UpdateButtonState;
  end;

{ TPredifinedPropsEh }

  TPredifinedPropsEh = class
  protected
    FCkecked: Boolean;
    FEditForm: TPropStorageEditEhForm;
    function Caption: String; virtual;
    function PropertyAdded(Component: TComponent; PropPath: String): Boolean; virtual;
    function PropertyDeleted(Component: TComponent; PropPath: String): Boolean; virtual;
    procedure SetCkecked(AChecked: Boolean); virtual;
    constructor Create(EditForm: TPropStorageEditEhForm); virtual;
  end;

  TPredifinedPropsEhClass = class of TPredifinedPropsEh;

{ TPredifinedActiveControlEh }

  TPredifinedActiveControlEh = class(TPredifinedPropsEh)
  protected
    FActiveControlAdded: Boolean;
    function Caption: String; override;
    function PropertyAdded(Component: TComponent; PropPath: String): Boolean; override;
    function PropertyDeleted(Component: TComponent; PropPath: String): Boolean; override;
    procedure SetCkecked(AChecked: Boolean); override;
  end;

{ TPredifinedPosPropertiesEh }

  TPredifinedPosPropertiesEh = class(TPredifinedPropsEh)
  protected
    FLeftAdded: Boolean;
    FTopAdded: Boolean;
    function Caption: String; override;
    function PropertyAdded(Component: TComponent; PropPath: String): Boolean; override;
    function PropertyDeleted(Component: TComponent; PropPath: String): Boolean; override;
    procedure SetCkecked(AChecked: Boolean); override;
  end;

{ TPredifinedSizePropertiesEh }

  TPredifinedSizePropertiesEh = class(TPredifinedPropsEh)
  protected
    FHeightAdded: Boolean;
    FPixelsPerInchAdded: Boolean;
    FWidthAdded: Boolean;
    function Caption: String; override;
    function PropertyAdded(Component: TComponent; PropPath: String): Boolean; override;
    function PropertyDeleted(Component: TComponent; PropPath: String): Boolean; override;
    procedure SetCkecked(AChecked: Boolean); override;
  end;

{ TPredifinedSizePropertiesEh }

  TPredifinedStatePropertiesEh = class(TPredifinedPropsEh)
  protected
    FStateAdded: Boolean;
    function Caption: String; override;
    function PropertyAdded(Component: TComponent; PropPath: String): Boolean; override;
    function PropertyDeleted(Component: TComponent; PropPath: String): Boolean; override;
    procedure SetCkecked(AChecked: Boolean); override;
  end;

procedure RegisterPredifinedPropsClass(PropsClass: TPredifinedPropsEhClass);

function EditPropStorage(PropStorage: TPropStorageEh): Boolean;

implementation

{$IFNDEF EH_LIB_CLX}
{$R *.dfm}
{$ELSE}
{$R *.xfm}
{$ENDIF}

var
  PredifinedPropsClassList: TList;

function EditPropStorage(PropStorage: TPropStorageEh): Boolean;
var
  PropStorageEditor: TPropStorageEditEhForm;
  OldCursor: TCursor;
{$IFNDEF EH_LIB_CLX}
  ticks: LongWord;
{$ENDIF}
begin
{$IFNDEF EH_LIB_CLX}
  ticks := GetTickCount;
{$ENDIF}
  Result := False;
  PropStorageEditor := TPropStorageEditEhForm.Create(Application);
  PropStorageEditor.PropStorage := PropStorage;
  OldCursor := Screen.Cursor;
  try
{$IFNDEF EH_LIB_CLX}
    PropStorageEditor.StartBuildTicks := GetTickCount;
{$ENDIF}
    PropStorageEditor.BuildPropertyList;
    PropStorageEditor.BuildPredifinedProps;
    PropStorageEditor.BuildStoringPropertyList(PropStorage.StoredProps);
  finally
    Screen.Cursor := OldCursor;
  end;
{$IFNDEF EH_LIB_CLX}
  PropStorageEditor.Edit1.Text := IntToStr(GetTickCount-ticks);
{$ENDIF}
  try
    if PropStorageEditor.ShowModal = mrOk then
    begin
      PropStorageEditor.GetStoringPorps(PropStorage.StoredProps);
      Result := True;
    end;
  finally
    PropStorageEditor.Free;
  end;
end;

procedure RegisterPredifinedPropsClass(PropsClass: TPredifinedPropsEhClass);
begin
  PredifinedPropsClassList.Add(TObject(PropsClass));
end;

function CompareNodeInfo(Pni1, Pni2: TNodeInfoEh): Boolean;
begin
  Result := (Pni1.Name = Pni2.Name) and (Pni1.NodeType = Pni2.NodeType)
end;

procedure TPropStorageEditEhForm.TreeView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
{$IFNDEF EH_LIB_CLX}
 if (htOnIcon in TreeView1.GetHitTestInfoAt(X, Y)) {and not (ssDouble in Shift)} then
 begin
  OnIconDownNode := TreeView1.GetNodeAt(X, Y);
  if OnIconDownNode.ImageIndex < 8 then
  begin
    OnIconDownNode.ImageIndex := TNodeInfoEh(OnIconDownNode.Data).Checked + 4;
    OnIconDownNode.SelectedIndex := TNodeInfoEh(OnIconDownNode.Data).Checked + 4;
  end else
    OnIconDownNode := nil;
//  TreeView1.Invalidate;
 end else
  OnIconDownNode := nil;
{$ENDIF}
end;

procedure TPropStorageEditEhForm.TreeView1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
{$IFNDEF EH_LIB_CLX}
  if (OnIconDownNode <> nil) then
    if (htOnIcon in TreeView1.GetHitTestInfoAt(X, Y)) and
      (TreeView1.GetNodeAt(X, Y) = OnIconDownNode) then
    begin
      OnIconDownNode.ImageIndex := TNodeInfoEh(OnIconDownNode.Data).Checked + 4;
      OnIconDownNode.SelectedIndex := TNodeInfoEh(OnIconDownNode.Data).Checked + 4;
    end else
    begin
      OnIconDownNode.ImageIndex := TNodeInfoEh(OnIconDownNode.Data).Checked;
      OnIconDownNode.SelectedIndex := TNodeInfoEh(OnIconDownNode.Data).Checked;
    end;
{$ENDIF}
end;

procedure TPropStorageEditEhForm.TreeView1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (OnIconDownNode <> nil) then
{$IFNDEF EH_LIB_CLX}
    if (htOnIcon in TreeView1.GetHitTestInfoAt(X, Y)) and
      (TreeView1.GetNodeAt(X, Y) = OnIconDownNode) then
{$ENDIF}
    begin
      MainToggle(OnIconDownNode);
      TreeView1.Invalidate;
      OnIconDownNode := nil;
    end;
end;

procedure TPropStorageEditEhForm.MainToggle(N: TTreeNode);
begin
  if not (TNodeInfoEh(N.Data).NodeType = nthProperty) then Exit;
  if TNodeInfoEh(N.Data).Checked <> 1
    then MainAddPropertyNode(N)
    else MainDeletePropertyNode(N);
end;

procedure TPropStorageEditEhForm.MainAddPropertyNode(N: TTreeNode);
begin
  if not (TNodeInfoEh(N.Data).NodeType = nthProperty) or
    (TNodeInfoEh(N.Data).Checked = 1) then Exit;
//  TreeView1.Items.BeginUpdate;
//  TreeView2.Items.BeginUpdate;
  try
    N.ImageIndex := 1;
    N.SelectedIndex := 1;
    TNodeInfoEh(N.Data).Checked := 1;
    AddPropertyNode(N);
    AddParentChecked(N);
//    ResetParentNodes(N);
    ResetChildNodes(N);
  finally
//    TreeView1.Items.EndUpdate;
//    TreeView2.Items.EndUpdate;
  end;
  UpdateButtonState;
end;

procedure TPropStorageEditEhForm.MainAddPropertyNode(Path: String);
var
  Token, PTerm: String;
  Node: TTreeNode;
  NodeType: TNodeTypeEh;
begin
  Token := GetNextPointSeparatedToken(Path);
  Node := TreeView1.Items.GetFirstNode;
  NodeType := nthControl;
  if NlsUpperCase(Token) = '<P>' then
    Token := '<Form>'
  else
  begin
    Delete(Path, 1, Length(Token)+1);
    if (Node.Count > 0)
      then Node := Node.Item[0]
      else raise Exception.Create('Can not expand path - "' + Path + '"');
  end;
  while Token <> '' do
  begin
    while True do
    begin
      if Node = nil then Exit;
      if (NlsCompareText(TNodeInfoEh(Node.Data).Name, Token) = 0) and
         (TNodeInfoEh(Node.Data).NodeType = NodeType) then
      begin
        if Path <> '' then
        begin
          if (Node.Count > 0) and TNodeInfoEh(Node.Item[0].Data).IsVoidProperty then
          begin
            Node.Item[0].Free;
            PTerm := '';

            AddProperties(Node, TNodeInfoEh(Node.Data).Instance,
              TNodeInfoEh(Node.Data).Path + PTerm,
              not (TNodeInfoEh(Node.Data).NodeType = nthProperty));
            if not (TNodeInfoEh(Node.Data).NodeType = nthProperty) then
              AddComponents(Node, TComponent(TNodeInfoEh(Node.Data).Instance),
                TNodeInfoEh(Node.Data).Path + PTerm);
          end;
          if (Node.Count > 0)
            then Node := Node.Item[0]
            else raise Exception.Create('Can not expand path - "' + Path + '"');
        end;
        Break;
      end;
      Node := Node.GetNextSibling();
      if Node = nil then
        Exit;
    end;
    Token := GetNextPointSeparatedToken(Path);
    Delete(Path, 1, Length(Token)+1);
    if NlsUpperCase(Token) = '<P>' then
    begin
      if TNodeInfoEh(Node.Data).NodeType = nthPropNode then
        if (Node.Count > 0)
          then Node := Node.Item[0]
          else raise Exception.Create('Can not expand path - "' + Path + '"');
      NodeType := nthProperty;
      Token := GetNextPointSeparatedToken(Path);
      Delete(Path, 1, Length(Token)+1);
    end;
  end;
  MainAddPropertyNode(Node);
end;

procedure TPropStorageEditEhForm.MainDeletePropertyNode(N: TTreeNode);
begin
  if not (TNodeInfoEh(N.Data).NodeType = nthProperty) or
    (TNodeInfoEh(N.Data).Checked = 0) then Exit;
//  TreeView1.Items.BeginUpdate;
  try
    N.ImageIndex := 0;
    N.SelectedIndex := 0;
    TNodeInfoEh(N.Data).Checked := 0;
    RemovePropertyNode(N);
    ResetParentNodes(N);
    ResetChildNodes(N);
  finally
//    TreeView1.Items.EndUpdate;
  end;
  UpdateButtonState;
end;

procedure TPropStorageEditEhForm.MainDeletePropertyNode(Path: String);
var
  i: Integer;
begin
  for i := 0 to TreeView2.Items.Count-1 do
    if AnsiCompareText(Path,
      TNodeInfoEh(TTreeNode(TreeView2.Items[i].Data).Data).Path) = 0 then
    begin
      MainDeletePropertyNode(TTreeNode(TreeView2.Items[i].Data));
      Exit;
    end;
end;

procedure TPropStorageEditEhForm.AddPropertyNode(N: TTreeNode);
var
  i,j: Integer;
  NC: TTreeNode;
  NList: TList;
begin
  if Assigned(N) then
  begin
    NList := TList.Create;
    while N <> nil do
    begin
      NList.Add(N);
      N := N.Parent;
    end;

    N := nil;

    for i := 0 to TreeView2.Items.Count-1 do
      if (TreeView2.Items[i].Parent = nil) and
          CompareNodeInfo(TNodeInfoEh(TTreeNode(TreeView2.Items[i].Data).Data),
                          TNodeInfoEh((TTreeNode(NList[NList.Count-1]).Data))) then
      begin
        N := TreeView2.Items[i];
        Break;
      end;

    try
      if N = nil then
      begin
        for i := 0 to TreeView2.Items.Count-1 do
          if (TreeView2.Items[i].Parent = nil) and
             (TTreeNode(TreeView2.Items[i].Data).Index > TTreeNode(NList[NList.Count-1]).Index) then
          begin
{$IFDEF EH_LIB_CLX} // Clx BUG of InsertObject
            N := TreeView2.Items.Insert(TreeView2.Items[i], TTreeNode(NList[NList.Count-1]).Text);
            N.Data := NList[NList.Count-1];
{$ELSE}
            N := TreeView2.Items.InsertObject(TreeView2.Items[i], TTreeNode(NList[NList.Count-1]).Text, NList[NList.Count-1]);
{$ENDIF}
            PropertyAdded(N);
            Abort;
          end;
        N := TreeView2.Items.AddObject(nil, TTreeNode(NList[NList.Count-1]).Text, NList[NList.Count-1]);
        PropertyAdded(N);
      end;
    except
     on EAbort do
     else raise;
    end;

    for i := NList.Count - 2 downto 0 do
    begin
      NC := FindChildNodeInfo(N, TTreeNode(NList[i]));
      if NC <> nil then
        N := NC
      else
      begin
        try
          for j := 0 to N.Count-1 do
            if (TTreeNode(N.Item[j].Data).Index > TTreeNode(NList[i]).Index) then
            begin
{$IFDEF EH_LIB_CLX} // Clx BUG of InsertObject
              N := TreeView2.Items.Insert(N.Item[j], TTreeNode(NList[i]).Text);
              N.Data := NList[i];
{$ELSE}
              N := TreeView2.Items.InsertObject(N.Item[j], TTreeNode(NList[i]).Text, NList[i]);
{$ENDIF}
              PropertyAdded(N);
              Abort;
            end;
          N := TreeView2.Items.AddChildObject(N, TTreeNode(NList[i]).Text, NList[i]);
          PropertyAdded(N);
        except
         on EAbort do
         else raise;
        end;
      end;
    end;
    NList.Free;
  end;
  if N <> nil then
    N.Selected := True;
end;

procedure TPropStorageEditEhForm.AddParentChecked(N: TTreeNode);
begin
  N := N.Parent;
  while (N <> nil) and (TNodeInfoEh(N.Data).NodeType = nthProperty) do
  begin
    N.ImageIndex := 2;
    N.SelectedIndex := 2;
    TNodeInfoEh(N.Data).Checked := 2;
    N := N.Parent;
  end;
end;

procedure TPropStorageEditEhForm.ResetParentNodes(N: TTreeNode);
begin
  N := N.Parent;
  if N = nil then Exit;
  if not HaveCheckedChilds(N) then
    RemovePropertyNode(N);
  if (TNodeInfoEh(N.Data).NodeType = nthProperty) then
    if HaveCheckedChilds(N) then
    begin
      N.ImageIndex := 2;
      N.SelectedIndex := 2;
      TNodeInfoEh(N.Data).Checked := 2;
    end else
    begin
      N.ImageIndex := 0;
      N.SelectedIndex := 0;
      TNodeInfoEh(N.Data).Checked := 0;
      RemovePropertyNode(N);
    end;
  ResetParentNodes(N);
end;

procedure TPropStorageEditEhForm.ResetChildNodes(N: TTreeNode);
var
  i: Integer;
begin
  if TNodeInfoEh(N.Data).Checked <> 0 then
    for i := 0 to N.Count-1 do
    begin
      ResetChildNodes(N.Item[i]);
      if TNodeInfoEh(N.Item[i].Data).Checked <> 0 then
      begin
        N.Item[i].ImageIndex := 0;
        N.Item[i].SelectedIndex := 0;
        TNodeInfoEh(N.Item[i].Data).Checked := 0;
        RemovePropertyNode(N.Item[i]);
      end;
    end;
end;

procedure TPropStorageEditEhForm.RemovePropertyNode(N: TTreeNode);
var
  PN: TTreeNode;
  i: Integer;
begin
  PN := N.Parent;
  if Assigned(N) then
    for i := 0 to TreeView2.Items.Count-1 do
      if TreeView2.Items[i].Data = N then
      begin
        PropertyDeleting(TreeView2.Items[i]);
        TreeView2.Items[i].Delete;
        Break;
      end;
  while (PN <> nil) and (PN.Count = 0) do
  begin
    N := PN;
    PN := PN.Parent;
    if N.GetPrevChild(N) <> nil then
      TreeView2.Selected := N.GetPrevChild(N)
    else if N.GetNextChild(N) <> nil then
      TreeView2.Selected := N.GetNextChild(N)
    else
      TreeView2.Selected := N.Parent;
    for i := 0 to TreeView2.Items.Count-1 do
      if TreeView2.Items[i].Data = N then
      begin
        PropertyDeleting(TreeView2.Items[i]);
        TreeView2.Items[i].Delete;
        Break;
      end;
  end;
end;

function TPropStorageEditEhForm.FindChildNodeInfo(N2: TTreeNode; N1: TTreeNode): TTreeNode;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to N2.Count-1 do
    if (TTreeNode(N2.Item[i].Data).Data) = N1.Data then
    begin
      Result := N2.Item[i];
      Exit;
    end;
end;

function TPropStorageEditEhForm.HaveCheckedChilds(N: TTreeNode): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to N.Count-1 do
    if (TNodeInfoEh(N.Item[i].Data).NodeType = nthProperty) then
    begin
      if TNodeInfoEh(N.Item[i].Data).Checked <> 0 then
      begin
        Result := True;
        Exit;
      end;
    end else if (TNodeInfoEh(N.Item[i].Data).NodeType = nthPropNode) then
    begin
      Result := HaveCheckedChilds(N.Item[i]);
      if Result then Exit;
    end else if TNodeInfoEh(N.Item[i].Data).Instance <> nil then
    begin
      if HaveCheckedChilds(N.Item[i]) then
      begin
        Result := True;
        Exit;
      end;
    end;
end;

function TPropStorageEditEhForm.AddSortedChildObject(Parent: TTreeNode;
  const S: string; Data: TNodeInfoEh): TTreeNode;
var
  Node: TTreeNode;
begin
  if Parent = nil
    then Node := TreeView1.Items.GetFirstNode
    else Node := Parent.getFirstChild;
  if Node = nil then
  begin
    Result := TreeView1.Items.AddChildObject(Parent, S, Data);
    Exit;
  end;
  while Node <> nil do
  begin
    if CompareNodeData(TNodeInfoEh(Node.Data), Data) > 0 then
    begin
{$IFDEF EH_LIB_CLX} // Clx BUG of InsertObject
      Result := TreeView1.Items.Insert(Node, S);
      Result.Data := Data;
{$ELSE}
      Result := TreeView1.Items.InsertObject(Node, S, Data);
{$ENDIF}
      Exit;
    end;
    Node := Node.GetNextSibling;
  end;
  Result := TreeView1.Items.AddChildObject(Parent, S, Data);
end;

function TPropStorageEditEhForm.CompareNodeData(Data1, Data2: TNodeInfoEh): Integer;
begin
  if Data1.NodeType = Data2.NodeType then
    if Data1.NodeType = nthProperty then
      if (Copy(Data1.Name, 1, 1) = '<') and
         (Copy(Data2.Name, 1, 1) <> '<')
      then
        Result := 1
      else if (Copy(Data2.Name, 1, 1) = '<') and
              (Copy(Data1.Name, 1, 1) <> '<')
      then
        Result := -1
      else
        Result := CompareText(Data1.Name, Data2.Name)
    else
      Result := CompareText(Data1.Name, Data2.Name)
  else if Data1.NodeType = nthProperty then
    Result := -1
  else if Data1.NodeType = nthPropNode then
    Result := -1
  else
    Result := 1;
end;

function TPropStorageEditEhForm.CompareNode(Node1, Node2: TTreeNode): Integer;
begin
  Result := CompareNodeData(TNodeInfoEh(Node1.Data), TNodeInfoEh(Node2.Data));
end;

procedure TPropStorageEditEhForm.ExchangeNode(Parent: TTreeNode; L, R: Integer);
var
  N: TTreeNode;
begin
  N := TTreeNode.Create(nil);
  N.Assign(Parent.Item[L]);
  Parent.Item[L] := Parent.Item[R];
  Parent.Item[R] := N;
  N.Free;
end;

procedure TPropStorageEditEhForm.QuickSort(Parent: TTreeNode; L, R: Integer);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while CompareNode(Parent.Item[I], Parent.Item[P]) < 0 do Inc(I);
      while CompareNode(Parent.Item[J], Parent.Item[P]) > 0 do Dec(J);
      if I <= J then
      begin
        ExchangeNode(Parent, I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(Parent, L, J);
    L := I;
  until I >= R;
end;

procedure TPropStorageEditEhForm.BuildPropertyList;
var
  N: TTreeNode;
  ChildList: TStringList;
begin
  TreeView1.Items.BeginUpdate;
  TreeView1.Items.Clear;
  ChildList := nil;
  try
    N := TreeView1.Items.Add(nil, '<Form>: ' + PropStorage.Owner.ClassName);
    N.ImageIndex := 8;
    N.SelectedIndex := 8;
    N.Data := CreateNodeInfo(PropStorage.Owner, '<Form>', '', nthControl, False);
    RootNode := N;
    AddVoidProperty(N);
    N.Expanded := True;
(*
    ChildList := TStringList.Create;
    GetChildList(PropStorage.Owner, PropStorage.Owner, ChildList);
    for i := 0 to ChildList.Count - 1{PropStorage.Owner.ComponentCount - 1} do
    begin
      C := TComponent(ChildList.Objects[i]); //PropStorage.Owner.Components[I];
      if C.Name = '' then Continue;
      N := AddSortedChildObject(nil, C.Name + ': ' + C.ClassName,
        CreateNodeInfo(C, C.Name, C.Name, nthControl, False));
      //N := TreeView1.Items.AddObject(nil, C.Name + ': ' + C.ClassName, Pointer(0));
      //N.Data := CreateNodeInfo(C, C.Name, C.Name, False, False);
      if C is TWinControl
        then N.ImageIndex := 9
        else N.ImageIndex := 10;
      N.SelectedIndex := N.ImageIndex;
      AddVoidProperty(N);

{$IFDEF EH_LIB_5}
      if csInline in C.ComponentState then
      begin
        N.ImageIndex := 11;
        N.SelectedIndex := 11;
//        AddComponents(N, C, C.Name);
      end;
{$ENDIF}

    end;
*)
  finally
    TreeView1.Items.EndUpdate;
    ChildList.Free;
  end;

end;

procedure TPropStorageEditEhForm.BuildStoringPropertyList(PropList: TStrings);
var
  i: Integer;
begin
  for i := 0 to PropList.Count-1 do
    MainAddPropertyNode(PropList[i]);
//  TreeView1.AlphaSort;
  TreeView2.FullExpand;
end;

function TPropStorageEditEhForm.CreateNodeInfo(Component: TComponent; Name, Path: String;
  NodeType: TNodeTypeEh; IsVoidProperty: Boolean): TNodeInfoEh;
var
  PNi: TNodeInfoEh;
begin
//  New(PNi);
  PNi := TNodeInfoEh.Create;
  PNi.Instance := Component;
  PNi.Name := Name;
  PNi.Path := Path;
  PNi.NodeType := NodeType;
  PNi.IsVoidProperty :=  IsVoidProperty;
  PNi.Checked := 0;
  Result := PNi;
end;

procedure TPropStorageEditEhForm.AddVoidProperty(N: TTreeNode);
var
  NC: TTreeNode;
begin
  NC := TreeView1.Items.AddChildObjectFirst(N, 'VoidProperty', nil);
  NC.Data := CreateNodeInfo(nil, 'VoidProperty', 'VoidProperty', nthProperty, True);
end;

function TPropStorageEditEhForm.GetObjectPropList(AObject: TObject; var ObjPropCount: Integer): TPropListArray;//PPropList;
var
  InterClass: TReadPropertyInterceptorClass;
//  PropList, InterPropList, ObjPropList: PPropList;
  PropList, InterPropList, ObjPropList: TPropListArray;
  PropCount, InterPropCount, {FInterSize, FSize,} i, j, Comp: Integer;
  List: TList;
begin
{  PropCount := GetPropList(AObject.ClassInfo, tkProperties, nil);
  FSize := PropCount * SizeOf(Pointer);
  GetMem(PropList, FSize);
  GetPropList(AObject.ClassInfo, tkProperties, PropList);}
  Result := nil;
  InterPropList := nil;
  PropList := GetPropListAsArray(AObject.ClassInfo, tkProperties);
  PropCount := Length(PropList);
  ObjPropCount := PropCount;
  Result := PropList;

  InterClass := GetInterceptorForTarget(AObject.ClassType);
  if InterClass = nil then Exit;

{  InterPropCount := GetPropList(InterClass.ClassInfo, tkProperties, nil);
  FInterSize := InterPropCount * SizeOf(Pointer);
  GetMem(InterPropList, FInterSize);
  GetPropList(InterClass.ClassInfo, tkProperties, InterPropList);}
  InterPropList := GetPropListAsArray(InterClass.ClassInfo, tkProperties);
  InterPropCount := Length(InterPropList);

  List := TList.Create;
  j := 0;
  for i := 0 to PropCount-1 do
  begin
    if j < InterPropCount then
    begin
      Comp := CompareText(String(PropList[i].Name), String(InterPropList[j].Name));
      if Comp = 0 then
      begin
        Inc(j);
        List.Add(PropList[i]);
      end else if Comp < 0 then
        List.Add(PropList[i])
      else //Comp > 0
      begin
        List.Add(InterPropList[j]);
        Inc(j);
      end
    end else
      List.Add(PropList[i]);
  end;

  for i := j to InterPropCount-1 do
  begin
    List.Add(InterPropList[i]);
  end;

//  GetMem(ObjPropList, List.Count * SizeOf(Pointer));
  SetLength(ObjPropList, List.Count);
  for i := 0 to List.Count - 1 do
    ObjPropList[i] := PPropInfo(List[i]);

  ObjPropCount := List.Count;
  Result := ObjPropList;

  List.Free;
//  FreeMem(PropList, FSize);
//  FreeMem(InterPropList, FInterSize);
end;

procedure TPropStorageEditEhForm.AddProperties(N: TTreeNode; O: TObject;
  Path: String; IsAddPropNode: Boolean);
var
//  PropList: PPropList;
  PropList: TPropListArray;
  PropCount: Integer;
  i, j: Integer;
  NC: TTreeNode;
  SubO: TObject;
  DefinePropList: TStringList;
begin
  PropList := GetObjectPropList(O, PropCount);
  if Path <> '' then Path := Path + '.';
  if IsAddPropNode then
  begin
    Path := Path + '<P>';
    N := AddSortedChildObject(N, '<Properties>',
        CreateNodeInfo(nil, '<P>', Path, nthPropNode, False));
    N.ImageIndex := 12;
    N.SelectedIndex := 12;
    Path := Path + '.';
  end;
  for i := 0 to PropCount - 1 do
  begin
    NC := AddSortedChildObject(N, String(PropList[i].Name) {+ ': ' + PropList^[i].PropType^.Name},
      CreateNodeInfo(nil, String(PropList[i].Name), Path + String(PropList[i].Name), nthProperty, False));
    NC.ImageIndex := 0;
    NC.SelectedIndex := 0;
{$IFDEF CIL}
    if PropList[i].PropType.Kind = tkClass then
{$ELSE}
    if PropList[i].PropType^.Kind = tkClass then
{$ENDIF}
    begin
      SubO := GetObjectProp(O, PropList[i]);
      if Assigned(SubO) then
      begin
        TNodeInfoEh(NC.Data).Instance := SubO;
        if not (SubO is TComponent)
{$IFDEF EH_LIB_6}
          or ((SubO is TComponent) and (csSubComponent in TComponent(SubO).ComponentStyle))
{$ENDIF}
        then
          AddVoidProperty(NC);
      end;
    end;
{$IFNDEF EH_LIB_CLX}
    if (GetTickCount - StartBuildTicks) > 250 then
      Screen.Cursor := crHourGlass;
{$ENDIF}
  end;

  if O is TPersistent then
  begin
    DefinePropList := TStringList.Create;
    GetDefinePropertyList(TPersistent(O), DefinePropList);
    for j := 0 to DefinePropList.Count - 1 do
      if GetChildNodeByText(N, DefinePropList[j]) = nil then
      begin
        NC := AddSortedChildObject(N, DefinePropList[j],
          CreateNodeInfo(nil, DefinePropList[j], Path + DefinePropList[j], nthProperty, False));
        NC.ImageIndex := 0;
        NC.SelectedIndex := 0;
      end;
    DefinePropList.Free;
  end;

  if (O is TCollection) then
    AddCollectionProperties(N, TCollection(O), Path);

//  FreeMem(PropList, PropCount * SizeOf(Pointer));
end;

procedure TPropStorageEditEhForm.AddComponents(N: TTreeNode; O: TComponent; Path: String);
var
  i: Integer;
  C: TComponent;
  NC: TTreeNode;
  ChildList: TStringList;
begin
  if Path <> '' then Path := Path + '.';
  ChildList := TStringList.Create;
  GetComponentChildListEh(O, PropStorage.Owner, ChildList, True);
  for i := 0 to ChildList.Count - 1 do
  begin
    C := TComponent(ChildList.Objects[i]);
    if C.Name = '' then Continue;
    NC := AddSortedChildObject(N, C.Name + ': ' + C.ClassName,
      CreateNodeInfo(C, C.Name, Path + C.Name, nthControl, False));
    if C is TWinControl
      then NC.ImageIndex := 9
      else NC.ImageIndex := 10;
    NC.SelectedIndex := NC.ImageIndex;
    AddVoidProperty(NC);
{$IFDEF EH_LIB_5}
    if csInline in C.ComponentState then
    begin
      NC.ImageIndex := 11;
      NC.SelectedIndex := 11;
    end;
{$ENDIF}
  end;
  ChildList.Free;
end;

procedure TPropStorageEditEhForm.AddCollectionProperties(N: TTreeNode; O: TCollection; Path: String);
var
  I: Integer;
  NC: TTreeNode;
begin
  if O.Count = 0 then Exit;
  NC := AddSortedChildObject(N, '<ForAllItems>',
    CreateNodeInfo(nil, '<ForAllItems>', Path + '<ForAllItems>', nthProperty, False));
  NC.ImageIndex := 0;
  NC.SelectedIndex := 0;
  AddProperties(NC, O.Items[0], Path + '<ForAllItems>', False);
  if O.Count > 0 then
  begin
    for I := 0 to O.Count - 1 do
    begin
      NC := AddSortedChildObject(N, '<Item' + IntToStr(I) + '>',
        CreateNodeInfo(nil, '<Item' + IntToStr(I) + '>', Path + '<Item' + IntToStr(I) + '>',  nthProperty, False));
      NC.ImageIndex := 0;
      NC.SelectedIndex := 0;
      AddProperties(NC, O.Items[I], Path + '<Item' + IntToStr(I) + '>', False);
    end;
  end;
end;

procedure TPropStorageEditEhForm.GetStoringPorps(PropList: TStrings);
var
  i: Integer;
begin
  PropList.Clear;
  for i := 0 to TreeView2.Items.Count-1 do
    if TreeView2.Items[i].Count = 0 then
      PropList.Add(TNodeInfoEh(TTreeNode(TreeView2.Items[i].Data).Data).Path);
end;

procedure TPropStorageEditEhForm.TreeView1GetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
  Node.SelectedIndex := Node.ImageIndex;
end;

procedure TPropStorageEditEhForm.TreeView1Deletion(Sender: TObject; Node: TTreeNode);
begin
  if Node.Data <> nil then
//    Dispose(TNodeInfoEh(Node.Data));
    TNodeInfoEh(Node.Data).Free;
end;

procedure TPropStorageEditEhForm.FormCreate(Sender: TObject);
begin
  LeftBorderWidth := TreeView1.Left;
  RightBorderWidth := ClientWidth div 2 - TreeView1.Width - TreeView1.Left;
  ButtonSize := spAddProp.Width;
  VBottomMargin := ClientHeight - Bevel1.Top;
{$IFDEF EH_LIB_9}
// To prevent RecreateWnd and Nodes
  PopupMode := pmAuto;
{$ENDIF}
end;

procedure TPropStorageEditEhForm.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to cbPredifinedProps.Items.Count - 1 do
    cbPredifinedProps.Items.Objects[i].Free;
end;

procedure TPropStorageEditEhForm.FormResize(Sender: TObject);
begin
  TreeView1.Width := ClientWidth div 2 - LeftBorderWidth - RightBorderWidth;
  spAddProp.Left := ClientWidth div 2 - 11;
  spAddProp.Top := (ClientHeight - VBottomMargin) div 2 - ButtonSize - 5 - ButtonSize div 2;
  sbRemoveProp.Left := ClientWidth div 2 - 11;
  sbRemoveProp.Top := (ClientHeight - VBottomMargin) div 2 - ButtonSize div 2;
  sbRemoveAllProps.Left := ClientWidth div 2 - 11;
  sbRemoveAllProps.Top := (ClientHeight - VBottomMargin) div 2 + ButtonSize div 2 + 5;
  spSynchTrees.Left := ClientWidth div 2 - 11;
  spSynchTrees.Top := (ClientHeight - VBottomMargin) div 2 + ButtonSize div 2 + ButtonSize + 10;
  TreeView2.Left := ClientWidth div 2 + RightBorderWidth;
  lStoredProps.Left := TreeView2.Left;
  TreeView2.Width := TreeView1.Width;
end;

procedure TPropStorageEditEhForm.spAddPropClick(Sender: TObject);
begin
  MainAddPropertyNode(TreeView1.Selected);
end;

procedure TPropStorageEditEhForm.sbRemovePropClick(Sender: TObject);
begin
  if TreeView2.Selected <> nil then
    SlaveDeleteNode(TreeView2.Selected);
end;

procedure TPropStorageEditEhForm.sbRemoveAllPropsClick(Sender: TObject);
var
  i: Integer;
begin
//  TreeView1.Items.BeginUpdate;
//  TreeView2.Items.BeginUpdate;
  try
    while TreeView2.Items.Count > 0 do
      for i := TreeView2.Items.Count-1 downto 0 do
        if TreeView2.Items[i].Parent = nil then
        begin
          SlaveDeleteNode(TreeView2.Items[i]);
          Break;
        end;
  finally
//    TreeView1.Items.EndUpdate;
//    TreeView2.Items.EndUpdate;
  end;
end;

procedure TPropStorageEditEhForm.spSynchTreesClick(Sender: TObject);
{$IFDEF EH_LIB_CLX}
var
  tn: TTreeNode;
{$ENDIF}
begin
  if TreeView2.Selected = nil then Exit;
  TTreeNode(TreeView2.Selected.Data).Selected := True;
{$IFDEF EH_LIB_CLX}
  tn := TTreeNode(TreeView2.Selected.Data).Parent;
  while tn.Parent <> nil do
  begin
    tn.Expand(False);
    tn := tn.Parent;
  end;
  TreeView1.TopItem := TTreeNode(TreeView2.Selected.Data);
{$ENDIF}
end;

procedure TPropStorageEditEhForm.SlaveDeleteNode(SN: TTreeNode);
var
  i: Integer;
begin
//  TreeView1.Items.BeginUpdate;
//  TreeView2.Items.BeginUpdate;
  try
    if SN.Count = 0 then
      MainDeletePropertyNode(TTreeNode((SN).Data))
    else
      for i := SN.Count-1 downto 0 do
        SlaveDeleteNode(SN.Item[i]);
  finally
//    TreeView1.Items.EndUpdate;
//    TreeView2.Items.EndUpdate;
  end;
end;

procedure TPropStorageEditEhForm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  UpdateButtonState;
  if (TreeView1.Selected <> nil) and (TreeView1.Selected.Data <> nil) then
    Edit2.Text :=  TNodeInfoEh(TreeView1.Selected.Data).Path;
end;

procedure TPropStorageEditEhForm.UpdateButtonState;
begin
  spAddProp.Enabled := (TreeView1.Selected <> nil) and
                       (TreeView1.Selected.Data <> nil) and
                       (TNodeInfoEh(TreeView1.Selected.Data).NodeType = nthProperty) and
                       (TNodeInfoEh(TreeView1.Selected.Data).Checked <> 1);
  sbRemoveProp.Enabled := (TreeView2.Selected <> nil) and
                       (TreeView2.Selected.Data <> nil);
  spSynchTrees.Enabled := sbRemoveProp.Enabled;
  sbRemoveAllProps.Enabled := (TreeView2.Items.Count > 0);
end;

procedure TPropStorageEditEhForm.TreeView2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DownNode: TTreeNode;
begin
  if ssDouble in Shift then
  begin
    DownNode := TreeView2.GetNodeAt(X, Y);
    if (DownNode <> nil) and (TNodeInfoEh(TTreeNode(DownNode.Data).Data).NodeType = nthProperty) then
      MainDeletePropertyNode(TTreeNode(DownNode.Data));
  end;
end;

procedure TPropStorageEditEhForm.cbPredifinedPropsClickCheck(Sender: TObject);
var
  i: Integer;
  OldCursor: TCursor;
begin
  OldCursor := Screen.Cursor;
  try
    for i := 0 to cbPredifinedProps.Items.Count-1 do
      if cbPredifinedProps.Items.Objects[i] <> nil then
        TPredifinedPropsEh(cbPredifinedProps.Items.Objects[i]).
          SetCkecked(cbPredifinedProps.Checked[i]);
  finally
    Screen.Cursor := OldCursor;
  end;
end;

procedure TPropStorageEditEhForm.TreeView1Compare(Sender: TObject; Node1,
  Node2: TTreeNode; Data: Integer; var Compare: Integer);
begin
  if TNodeInfoEh(Node1.Data).NodeType = TNodeInfoEh(Node2.Data).NodeType then
    Compare := CompareText(TNodeInfoEh(Node1.Data).Name, TNodeInfoEh(Node2.Data).Name)
  else if TNodeInfoEh(Node1.Data).NodeType = nthProperty then
    Compare := -1
  else
    Compare := 1;
end;

function TPropStorageEditEhForm.GetChildNodeByText(ParentNode: TTreeNode; Text: String): TTreeNode;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to ParentNode.Count-1 do
    if NlsCompareText(ParentNode.Item[i].Text, Text) = 0 then
    begin
      Result := ParentNode.Item[i];
      Exit;
    end;
end;

procedure TPropStorageEditEhForm.TreeView1Expanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
var
  OldCursor: TCursor;
  TopNode: TTreeNode;
  PTerm: String;
begin
  TopNode := TreeView1.TopItem;
  if (Node.Count > 0) and TNodeInfoEh(Node.Item[0].Data).IsVoidProperty then
  begin
    Node.Item[0].Free;
{$IFNDEF EH_LIB_CLX}
    StartBuildTicks := GetTickCount;
{$ENDIF}
    OldCursor := Screen.Cursor;
    try
      PTerm := '';

      AddProperties(Node, TNodeInfoEh(Node.Data).Instance,
        TNodeInfoEh(Node.Data).Path + PTerm,
        not (TNodeInfoEh(Node.Data).NodeType = nthProperty));
      if not (TNodeInfoEh(Node.Data).NodeType = nthProperty) then
        AddComponents(Node, TComponent(TNodeInfoEh(Node.Data).Instance), TNodeInfoEh(Node.Data).Path + PTerm);
//      TreeView1.AlphaSort;
    finally
      Screen.Cursor := OldCursor;
    end;
  end;
  if Node.Count = 1 then
    Node[0].Expanded := True;
  TreeView1.TopItem := TopNode;
end;

procedure TPropStorageEditEhForm.BuildPredifinedProps;
var
  i: Integer;
  PreProp: TPredifinedPropsEh;
begin
  for i := 0 to PredifinedPropsClassList.Count-1 do
  begin
    PreProp :=  TPredifinedPropsEhClass(PredifinedPropsClassList[i]).Create(Self);
    cbPredifinedProps.Items.AddObject(PreProp.Caption, PreProp);
  end;
end;

{ TPredifinedPropsEh }

function TPredifinedPropsEh.Caption: String;
begin
end;

constructor TPredifinedPropsEh.Create(EditForm: TPropStorageEditEhForm);
begin
  inherited Create;
  FEditForm := EditForm;
end;

function TPredifinedPropsEh.PropertyAdded(Component: TComponent; PropPath: String): Boolean;
begin
  Result := False;
end;

function TPredifinedPropsEh.PropertyDeleted(Component: TComponent; PropPath: String): Boolean;
begin
  Result := False;
end;

procedure TPredifinedPropsEh.SetCkecked(AChecked: Boolean);
begin
  FCkecked := AChecked;
end;

{ TPredifinedActiveControlEh }

function TPredifinedActiveControlEh.Caption: String;
begin
  Result := 'Form ActiveControl';
end;

function TPredifinedActiveControlEh.PropertyAdded(Component: TComponent; PropPath: String): Boolean;
begin
  if PropPath = '<P>.ActiveControl'
    then FActiveControlAdded := True;
  FCkecked := FActiveControlAdded;
  Result := FCkecked;
end;

function TPredifinedActiveControlEh.PropertyDeleted(Component: TComponent; PropPath: String): Boolean;
begin
  if PropPath = '<P>.ActiveControl'
    then FActiveControlAdded := False;
  FCkecked := FActiveControlAdded;
  Result := FCkecked;
end;

procedure TPropStorageEditEhForm.PropertyAdded(DN: TTreeNode);
var
  i: Integer;
begin
  for i := 0 to cbPredifinedProps.Items.Count-1 do
    if cbPredifinedProps.Items.Objects[i] <> nil then
      cbPredifinedProps.Checked[i] :=
        TPredifinedPropsEh(cbPredifinedProps.Items.Objects[i]).
          PropertyAdded(nil, TNodeInfoEh(TTreeNode(DN.Data).Data).Path )
end;

procedure TPropStorageEditEhForm.PropertyDeleting(DN: TTreeNode);
var
  i: Integer;
begin
  for i := 0 to cbPredifinedProps.Items.Count-1 do
    if cbPredifinedProps.Items.Objects[i] <> nil then
      cbPredifinedProps.Checked[i] :=
        TPredifinedPropsEh(cbPredifinedProps.Items.Objects[i]).
          PropertyDeleted(nil, TNodeInfoEh(TTreeNode(DN.Data).Data).Path)
end;

procedure TPredifinedActiveControlEh.SetCkecked(AChecked: Boolean);
begin
  if AChecked <> FCkecked then
  begin
    if AChecked
      then FEditForm.MainAddPropertyNode('<P>.ActiveControl')
      else FEditForm.MainDeletePropertyNode('<P>.ActiveControl');
    inherited SetCkecked(AChecked);
  end;
end;

{ TPredifinedPosPropertiesEh }

function TPredifinedPosPropertiesEh.Caption: String;
begin
  Result := 'Form Pos';
end;

function TPredifinedPosPropertiesEh.PropertyAdded(Component: TComponent; PropPath: String): Boolean;
begin
  if PropPath = '<P>.Top'
    then FTopAdded := True;
  if PropPath = '<P>.Left'
    then FLeftAdded := True;
  FCkecked := FTopAdded and FLeftAdded;
  Result := FCkecked;
end;

function TPredifinedPosPropertiesEh.PropertyDeleted(Component: TComponent; PropPath: String): Boolean;
begin
  if PropPath = '<P>.Top'
    then FTopAdded := False;
  if PropPath = '<P>.Left'
    then FLeftAdded := False;
  FCkecked := FTopAdded and FLeftAdded;
  Result := FCkecked;
end;

procedure TPredifinedPosPropertiesEh.SetCkecked(AChecked: Boolean);
begin
  if AChecked <> FCkecked then
  begin
    if AChecked then
    begin
      FEditForm.MainAddPropertyNode('<P>.Top');
      FEditForm.MainAddPropertyNode('<P>.Left');
    end else
    begin
      FEditForm.MainDeletePropertyNode('<P>.Top');
      FEditForm.MainDeletePropertyNode('<P>.Left');
    end;
    inherited SetCkecked(AChecked);
  end;
end;

{ TPredifinedSizePropertiesEh }

function TPredifinedSizePropertiesEh.Caption: String;
begin
  Result := 'Form Size';
end;

function TPredifinedSizePropertiesEh.PropertyAdded(Component: TComponent;
  PropPath: String): Boolean;
begin
  if PropPath = '<P>.Height'
    then FHeightAdded := True;
  if PropPath = '<P>.Width'
    then FWidthAdded := True;
  if PropPath = '<P>.PixelsPerInch'
    then FPixelsPerInchAdded := True;
  FCkecked := FHeightAdded and FWidthAdded and FPixelsPerInchAdded;
  Result := FCkecked;
end;

function TPredifinedSizePropertiesEh.PropertyDeleted(Component: TComponent;
  PropPath: String): Boolean;
begin
  if PropPath = '<P>.Height'
    then FHeightAdded := False;
  if PropPath = '<P>.Width'
    then FWidthAdded := False;
  if PropPath = '<P>.PixelsPerInch'
    then FPixelsPerInchAdded := False;
  FCkecked := FHeightAdded and FWidthAdded and FPixelsPerInchAdded;
  Result := FCkecked;
end;

procedure TPredifinedSizePropertiesEh.SetCkecked(AChecked: Boolean);
begin
  if AChecked <> FCkecked then
  begin
    if AChecked then
    begin
      FEditForm.MainAddPropertyNode('<P>.Height');
      FEditForm.MainAddPropertyNode('<P>.Width');
      FEditForm.MainAddPropertyNode('<P>.PixelsPerInch');
    end else
    begin
      FEditForm.MainDeletePropertyNode('<P>.Height');
      FEditForm.MainDeletePropertyNode('<P>.Width');
      FEditForm.MainDeletePropertyNode('<P>.PixelsPerInch');
    end;
    inherited SetCkecked(AChecked);
  end;
end;

{ TPredifinedStatePropertiesEh }

function TPredifinedStatePropertiesEh.Caption: String;
begin
  Result := 'Form State';
end;

function TPredifinedStatePropertiesEh.PropertyAdded(Component: TComponent;
  PropPath: String): Boolean;
begin
  if PropPath = '<P>.WindowState'
    then FStateAdded := True;
  FCkecked := FStateAdded;
  Result := FCkecked;
end;

function TPredifinedStatePropertiesEh.PropertyDeleted(
  Component: TComponent; PropPath: String): Boolean;
begin
  if PropPath = '<P>.WindowState'
    then FStateAdded := False;
  FCkecked := FStateAdded;
  Result := FCkecked;
end;

procedure TPredifinedStatePropertiesEh.SetCkecked(AChecked: Boolean);
begin
  if AChecked <> FCkecked then
  begin
    if AChecked
      then FEditForm.MainAddPropertyNode('<P>.WindowState')
      else FEditForm.MainDeletePropertyNode('<P>.WindowState');
    inherited SetCkecked(AChecked);
  end;
end;

initialization
  PredifinedPropsClassList := TList.Create;
  RegisterPredifinedPropsClass(TPredifinedActiveControlEh);
  RegisterPredifinedPropsClass(TPredifinedPosPropertiesEh);
  RegisterPredifinedPropsClass(TPredifinedSizePropertiesEh);
  RegisterPredifinedPropsClass(TPredifinedStatePropertiesEh);
finalization
  FreeAndNil(PredifinedPropsClassList);
end.
