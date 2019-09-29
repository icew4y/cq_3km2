{************************************************}
{                                                }
{               EurekaLog v 6.x                  }
{          ListView Unit - EListView             }
{                                                }
{  Copyright (c) 2001 - 2007 by Fabio Dell'Aria  }
{                                                }
{************************************************}

unit EListView;

{$I Exceptions.inc}

interface

uses Windows, SysUtils, Classes;

const
  LVM_FIRST = $1000; { ListView messages }
  LVM_SETEXTENDEDLISTVIEWSTYLE = LVM_FIRST + 54;
  LVM_GETCOUNTPERPAGE = LVM_FIRST + 40;
  LVM_GETHEADER = LVM_FIRST + 31;
  LVM_GETITEM = LVM_FIRST + 5;
  LVM_GETCOLUMN = LVM_FIRST + 25;
  LVM_INSERTCOLUMN = LVM_FIRST + 27;
  LVM_SETIMAGELIST = LVM_FIRST + 3;
  LVM_INSERTITEM = LVM_FIRST + 7;
  LVM_SETITEMTEXT = LVM_FIRST + 46;
  LVM_GETITEMCOUNT = LVM_FIRST + 4;
  LVM_SETTEXTBKCOLOR = LVM_FIRST + 38;
  LVM_SETTEXTCOLOR = LVM_FIRST + 36;
  LVM_SETBKCOLOR = LVM_FIRST + 1;
  LVM_SETCOLUMNWIDTH = LVM_FIRST + 30;
  LVM_GETCOLUMNWIDTH = LVM_FIRST + 29;
  LVM_GETNEXTITEM = LVM_FIRST + 12;
  LVM_GETITEMTEXT = LVM_FIRST + 45;
  LVM_REDRAWITEMS = LVM_FIRST + 21;
  LVM_DELETEITEM = LVM_FIRST + 8;
  LVM_GETITEMRECT = LVM_FIRST + 14;
  LVSIL_SMALL = 1;
  LVCF_FMT = $0001;
  LVCF_WIDTH = $0002;
  LVCF_TEXT = $0004;
  LVCF_SUBITEM = $0008;
  LVCFMT_LEFT = $0000;
  LVCFMT_RIGHT = $0001;
  LVCFMT_CENTER = $0002;
  LVIF_TEXT = $0001;
  LVIF_IMAGE = $0002;
  LVIF_PARAM = $0004;
  HDM_FIRST = $1200; { Header messages }
  HDM_GETITEMCOUNT = HDM_FIRST + 0;
  ILC_COLORDDB = $00FE; { ImageList messages }

  // Resourced IDs...
  //-----------------
  ID_DLL = 'EL_DLL';
  ID_BPL = 'EL_BPL';
  ID_VCL = 'EL_VCL';
  ID_Pas = 'EL_PAS';
  ID_Plus = 'EL_PLUS';
  ID_Minus = 'EL_MINUS';

type
  tagLVCOLUMNA = packed record
    mask: UINT;
    fmt: Integer;
    cx: Integer;
    pszText: PAnsiChar;
    cchTextMax: Integer;
    iSubItem: Integer;
    iImage: Integer;
    iOrder: Integer;
  end;

  tagLVITEMA = packed record
    mask: UINT;
    iItem: Integer;
    iSubItem: Integer;
    state: UINT;
    stateMask: UINT;
    pszText: PAnsiChar;
    cchTextMax: Integer;
    iImage: Integer;
    lParam: LongInt;
    iIndent: Integer;
  end;

  tagTCITEMA = packed record
    mask: UINT;
    dwState: UINT;
    dwStateMask: UINT;
    pszText: PAnsiChar;
    cchTextMax: Integer;
    iImage: Integer;
    lParam: LongInt;
  end;

  PListViewItemRec = ^TListViewItemRec;
  TListViewItemRec = packed record
    hList: THandle;
    Cols: TStrings;
    Bmp, WidthStep: Integer;
    Param: Pointer;
    IsParent, Expanded, Empty, Visible: Boolean;
    Header: string;
    Parent: PListViewItemRec;
  end;

  TListViewItems = class(TList)
  private
    FLastParent: PListViewItemRec;
    FhList: THandle;
    FListDC: HDC;
    BackgroundBrushSelected, BackgroundBrushUnselected,
      FrameBrushSelected, FrameBrushUnselected, BottomBrush, LineBrush: HBrush;
    FFont: HFont;
    FSpaces: string;
    FLevel, FStep: Integer;
    FInitDC: Boolean;
    fBmp: array[0..3] of THandle;
    fPlus, fMinus, fImageList: THandle;
    FColAlign: array [0..15] of DWord;
    FColCount: DWord;
    function GetItem(Index: Integer): PListViewItemRec;
  protected
    function GetItemParam(Index: Integer): PListViewItemRec;
    procedure InsertItem(PItem: PListViewItemRec; Index: Integer);
    procedure DeleteItem(Index: Integer);
    procedure RedrawItems(IdxFirst, IdxLast: Integer);
    procedure InitializeData;
    procedure SetRedrawState(Value: Boolean);
  public
    constructor Create(AhList: THandle);
    destructor Destroy; override;
    procedure Delete(Index: Integer);
    procedure Clear;
{$IFDEF Delphi4Up} override;
{$ENDIF}
    procedure ClickOnItem(Index: Integer; Point: TPoint; OnSign: Boolean);
    procedure AddRow(ACols: array of string; ABmp: Integer;
      AParam: Pointer; AIsParent: Boolean; AHeader: string);
    function DrawList(lParam: DWord): Boolean;
    function DrawItem(Index: Integer; DC: HDC; Selected, Focus: Boolean): Boolean;
    property Items[Index: Integer]: PListViewItemRec read GetItem; default;
  end;

procedure DrawBmp(DC: HDC; hBmp: HBITMAP; xStart, yStart, w, h: integer);

implementation

uses Messages, EConsts;

function GetItemRect(hList: THandle; Item: Integer): TRect;
begin
  FillChar(Result, SizeOf(Result), #0);
  SendMessage(hList, LVM_GETITEMRECT, Item, Longint(@Result));
end;

procedure DrawBmp(DC: HDC; hBmp: HBITMAP; xStart, yStart, w, h: integer);
var
  cTransparentColor, cColor: COLORREF;
  bmAndBack, bmAndObject, bmAndMem, bmSave: HBITMAP;
  bmBackOld, bmObjectOld, bmMemOld, bmSaveOld: HBITMAP;
  hdcMem, hdcBack, hdcObject, hdcTemp, hdcSave: HDC;
  ptSize: TPOINT;
begin
   hdcTemp := CreateCompatibleDC(dc);
   SelectObject(hdcTemp, hBmp); // Select the bitmap
   cTransparentColor := GetPixel(hdcTemp, 0, 0);

   ptSize.x := w;
   ptSize.y := h;

   // Create some DCs to hold temporary data.
   hdcBack := CreateCompatibleDC(dc);
   hdcObject := CreateCompatibleDC(dc);
   hdcMem := CreateCompatibleDC(dc);
   hdcSave := CreateCompatibleDC(dc);

   // Create a bitmap for each DC. DCs are required for a number of GDI functions.

   // Monochrome DC
   bmAndBack := CreateBitmap(ptSize.x, ptSize.y, 1, 1, nil);

   // Monochrome DC
   bmAndObject := CreateBitmap(ptSize.x, ptSize.y, 1, 1, nil);

   bmAndMem := CreateCompatibleBitmap(dc, ptSize.x, ptSize.y);
   bmSave := CreateCompatibleBitmap(dc, ptSize.x, ptSize.y);

   // Each DC must select a bitmap object to store pixel data.
   bmBackOld := SelectObject(hdcBack, bmAndBack);
   bmObjectOld := SelectObject(hdcObject, bmAndObject);
   bmMemOld := SelectObject(hdcMem, bmAndMem);
   bmSaveOld := SelectObject(hdcSave, bmSave);

   // Set proper mapping mode.
   SetMapMode(hdcTemp, GetMapMode(dc));

   // Save the bitmap sent here, because it will be overwritten.
   BitBlt(hdcSave, 0, 0, ptSize.x, ptSize.y, hdcTemp, 0, 0, SRCCOPY);

   // Set the background color of the source DC to the color.
   // contained in the parts of the bitmap that should be transparent
   cColor := SetBkColor(hdcTemp, cTransparentColor);

   // Create the object mask for the bitmap by performing a BitBlt
   // from the source bitmap to a monochrome bitmap.
   BitBlt(hdcObject, 0, 0, ptSize.x, ptSize.y, hdcTemp, 0, 0, SRCCOPY);

   // Set the background color of the source DC back to the original color.
   SetBkColor(hdcTemp, cColor);

   // Create the inverse of the object mask.
   BitBlt(hdcBack, 0, 0, ptSize.x, ptSize.y, hdcObject, 0, 0, NOTSRCCOPY);

   // Copy the background of the main DC to the destination.
   BitBlt(hdcMem, 0, 0, ptSize.x, ptSize.y, dc, xStart, yStart, SRCCOPY);

   // Mask out the places where the bitmap will be placed.
   BitBlt(hdcMem, 0, 0, ptSize.x, ptSize.y, hdcObject, 0, 0, SRCAND);

   // Mask out the transparent colored pixels on the bitmap.
   BitBlt(hdcTemp, 0, 0, ptSize.x, ptSize.y, hdcBack, 0, 0, SRCAND);

   // XOR the bitmap with the background on the destination DC.
   BitBlt(hdcMem, 0, 0, ptSize.x, ptSize.y, hdcTemp, 0, 0, SRCPAINT);

   // Copy the destination to the screen.
   BitBlt(dc, xStart, yStart, ptSize.x, ptSize.y, hdcMem, 0, 0, SRCCOPY);

   // Place the original bitmap back into the bitmap sent here.
   BitBlt(hdcTemp, 0, 0, ptSize.x, ptSize.y, hdcSave, 0, 0, SRCCOPY);

   // Delete the memory bitmaps.
   DeleteObject(SelectObject(hdcBack, bmBackOld));
   DeleteObject(SelectObject(hdcObject, bmObjectOld));
   DeleteObject(SelectObject(hdcMem, bmMemOld));
   DeleteObject(SelectObject(hdcSave, bmSaveOld));

   // Delete the memory DCs.
   DeleteDC(hdcMem);
   DeleteDC(hdcBack);
   DeleteDC(hdcObject);
   DeleteDC(hdcSave);
   DeleteDC(hdcTemp);
end;

function ImageList_Create(CX, CY: Integer; Flags: UINT;
  Initial, Grow: Integer): THandle; stdcall; external 'comctl32.dll';

function ImageList_Add(ImageList: THandle; Image, Mask: HBitmap):
  Integer; stdcall; external 'comctl32.dll';

function ImageList_Destroy(ImageList: THandle): Bool; stdcall;
  external 'comctl32.dll';

{ TListViewItems }

constructor TListViewItems.Create(AhList: THandle);
begin
  inherited Create;
  FInitDC := False;
  FLastParent := nil;
  FhList := AhList;
  FFont := 0;
  FSpaces := '';
  FListDC := GetDC(FhList);
  FStep := 0;
  FLevel := 0;
  fBmp[0] := LoadBitmap(HInstance, ID_DLL);
  fBmp[1] := LoadBitmap(HInstance, ID_BPL);
  fBmp[2] := LoadBitmap(HInstance, ID_VCL);
  fBmp[3] := LoadBitmap(HInstance, ID_Pas);
  fPlus := LoadBitmap(HInstance, ID_Plus);
  fMinus := LoadBitmap(HInstance, ID_Minus);
  fImageList := ImageList_Create(16, 16, ILC_COLORDDB, 4, 4);
  ImageList_Add(fImageList, fBmp[0], 0);
  ImageList_Add(fImageList, fBmp[1], 1);
  ImageList_Add(fImageList, fBmp[2], 2);
  ImageList_Add(fImageList, fBmp[3], 3);
  SendMessage(FhList, LVM_SETIMAGELIST,
    Longint(LVSIL_SMALL), fImageList);
  BackgroundBrushSelected := CreateSolidBrush($F1DACC); //GetSysColor(COLOR_HIGHLIGHT);
  BackgroundBrushUnselected := CreateSolidBrush(color_Back);
  FrameBrushSelected := CreateSolidBrush($C56A31);
  FrameBrushUnselected := CreateSolidBrush($E2B598);
  BottomBrush := CreateSolidBrush($E0A47B);
  LineBrush := CreateSolidBrush($C2CBCE);
end;

destructor TListViewItems.Destroy;
var
  i: Integer;
begin
  DeleteObject(BackgroundBrushSelected);
  DeleteObject(BackgroundBrushUnselected);
  DeleteObject(FrameBrushSelected);
  DeleteObject(FrameBrushUnselected);
  DeleteObject(BottomBrush);
  DeleteObject(LineBrush);
  DeleteObject(fPlus);
  DeleteObject(fMinus);
  ImageList_Destroy(fImageList);
  for i := 0 to 3 do DeleteObject(fBmp[i]);
  ReleaseDC(FhList, FListDC);
  inherited;
end;

procedure TListViewItems.AddRow(ACols: array of string; ABmp: Integer;
  AParam: Pointer; AIsParent: Boolean; AHeader: string);
var
  PItem: PListViewItemRec;
  n: Integer;
begin
  if (FFont = 0) then InitializeData;

  New(PItem);
  with PItem^ do
  begin
    hList := FhList;
    Cols := TStringList.Create;
    for n := low(ACols) to high(ACols) do Cols.Add(ACols[n]);
    Bmp := ABmp;
    IsParent := AIsParent;
    Empty := (not IsParent) and (Trim(Cols.Text) = '');
    Param := AParam;
    Expanded := True;
    Visible := True;
    if (IsParent) then Inc(FLevel)
    else if (Empty) then FLevel := 0;
    if (not Empty) and (FLevel > 1) then
    begin
      Cols[0] := (FSpaces + Cols[0]);
      WidthStep := 1;
    end
    else WidthStep := 0;
    Header := AHeader;
    Parent := FLastParent;
    if (Empty) then FLastParent := nil
    else FLastParent := PItem;
  end;
  Add(PItem);
  InsertItem(PItem, -1);
end;

procedure TListViewItems.InsertItem(PItem: PListViewItemRec; Index: Integer);
var
  Item: tagLVITEMA;
  n: Integer;
begin
  with Item do
  begin
    mask := LVIF_TEXT or LVIF_IMAGE or LVIF_PARAM;
    state := 0;
    iImage := PItem^.Bmp;
    stateMask := 0;
    iIndent := 0;
    lParam := Integer(PItem);
  end;

  if (PItem^.Cols.Count > 0) then
  begin
    with Item do
    begin
      if (Index = -1) then
        iItem := SendMessage(FhList, LVM_GETITEMCOUNT, 0, 0) // Row number.
      else
        iItem := Index;
      iSubItem := 0;
      pszText := PChar(PItem^.Cols[0]);
    end;
    SendMessage(FhList, LVM_INSERTITEM, 0, Longint(@Item));
  end;

  for n := 1 to (PItem^.Cols.Count - 1) do
  begin
    with Item do
    begin
      iSubItem := n; // Col number (zero based).
      pszText := PChar(PItem^.Cols[n]);
    end;
    SendMessage(FhList, LVM_SETITEMTEXT, Item.iItem, Longint(@Item));
  end;
end;

procedure TListViewItems.DeleteItem(Index: Integer);
begin
  SendMessage(FhList, LVM_DELETEITEM, Index, 0);
end;

procedure TListViewItems.RedrawItems(IdxFirst, IdxLast: Integer);
begin
  SendMessage(FhList, LVM_REDRAWITEMS, IdxFirst, IdxLast);
end;

procedure TListViewItems.ClickOnItem(Index: Integer; Point: TPoint; OnSign: Boolean);
var
  n, Idx: Integer;
  PItem: PListViewItemRec;
  OldVisible: Boolean;
  Rc: TRect;

  function ClickOnSign(Master: Boolean): Boolean;
  var
    Dx: Integer;
  begin
    if (Master) then Dx := 0
    else Dx := FStep;
    Result := (Point.X >= 2 + Dx) and (Point.X <= 12 + Dx) and
      (Point.Y >= 2) and (Point.Y <= 12);
  end;

begin
  Rc := GetItemRect(FhList, Index);
  Dec(Point.X, Rc.Left);
  Dec(Point.Y, Rc.Top);
  PItem := GetItemParam(Index);
  with PItem^ do
  begin
    if (not IsParent) then Exit;

    if (OnSign) and (not ClickOnSign(PItem^.Parent = nil)) then Exit;

    Expanded := (not Expanded);

    Idx := (Index + 1);
    n := (Self.IndexOf(PItem) + 1);

    SetRedrawState(False);
    try
      while (n <= Self.Count - 1) and (not Items[n]^.Empty) do
      begin
        OldVisible := Items[n]^.Visible;
        Items[n]^.Visible := Expanded;
        if (not Items[n]^.Visible) then
        begin
          if (OldVisible) then DeleteItem(Idx);
        end
        else
        begin
          InsertItem(Items[n], Idx);
          Inc(Idx);
          if (Items[n]^.IsParent) and (not Items[n]^.Expanded) then Break;
        end;
        Inc(n);
      end;
    finally
      SetRedrawState(True);
    end;
    RedrawItems(Index, Index);
  end;
end;

procedure TListViewItems.Delete(Index: Integer);
var
  PItem: PListViewItemRec;
  Ptr: Pointer;
begin
  Ptr := Items[Index];
  PItem := PListViewItemRec(Ptr);
  PItem^.Cols.Free;
  Dispose(PItem);
  if (FFont <> 0) then DeleteObject(FFont);
  inherited;
end;

procedure TListViewItems.Clear;
var
  i: integer;
begin
  for i := 0 to (Count - 1) do Delete(0);
  inherited;
end;

function TListViewItems.GetItem(Index: Integer): PListViewItemRec;
begin
  Result := PListViewItemRec(TList(Self).Items[Index]);
end;

function TListViewItems.GetItemParam(Index: Integer): PListViewItemRec;
var
  Item: tagLVITEMA;
begin
  Item.mask := LVIF_PARAM;
  Item.iItem := Index;
  Item.iSubItem := 0;
  SendMessage(FhList, LVM_GETITEM, 0, Longint(@Item));
  Result := PListViewItemRec(Item.lParam);
end;

function TListViewItems.DrawList(lParam: DWord): Boolean;
var
  lpdis: PDRAWITEMSTRUCT;

  procedure DrawItem(Selected: Boolean);
  var
    n, left, w: Integer;
    OldColor, SystemColor, TextColor: DWord;
    Item: PListViewItemRec;
    dRect: Trect;
    ExpandBmp: THandle;
    ItemText: string;
    OldFont: HFont;
    LineType: Integer;

    procedure HandleBackgroundState(Selected: Boolean; Step: DWord);
    var
      dRect: TRect;
    begin
      dRect := lpdis^.rcItem;
      Inc(dRect.Left, 2 + Step);
      if (Selected) then
        FillRect(FListDC, dRect, BackgroundBrushSelected)
      else
        FillRect(FListDC, dRect, BackgroundBrushUnselected);
    end;

    procedure DrawFrame(Selected: Boolean; Step: DWord);
    var
      dRect: TRect;
    begin
      dRect := lpdis^.rcItem;
      Inc(dRect.Left, 2 + Step);
      if Selected then
        FrameRect(FListDC, dRect, FrameBrushSelected)
      else
        FrameRect(FListDC, dRect, FrameBrushUnselected);
    end;

    procedure DrawBottom;
    var
      dRect: TRect;
    begin
      dRect := lpdis^.rcItem;
      Inc(dRect.Left, 2);
      dRect.Top := (dRect.Bottom - 2);
      FillRect(FListDC, dRect, BottomBrush);
    end;

    procedure DrawLine(Step: DWord);
    var
      dRect: TRect;
    begin
      dRect := lpdis^.rcItem;
      Inc(dRect.Left, 2 + Step);
      dRect.Top := (dRect.Bottom - 1);
      FillRect(FListDC, dRect, LineBrush);
    end;

  begin
    if (Selected) then SystemColor := 0 //GetSysColor(COLOR_HIGHLIGHTTEXT)
    else SystemColor := color_Text;
    if (not FInitDC) then
    begin
      SelectObject(FListDC, GetCurrentObject(lpdis^.hDC, OBJ_FONT));
      SelectObject(FListDC, GetCurrentObject(lpdis^.hDC, OBJ_PEN));
      SelectObject(FListDC, GetCurrentObject(lpdis^.hDC, OBJ_BRUSH));
      SelectObject(FListDC, GetCurrentObject(lpdis^.hDC, OBJ_PAL));
      SelectObject(FListDC, GetCurrentObject(lpdis^.hDC, OBJ_BITMAP));
      SetBkMode(FListDC, TRANSPARENT);
      FInitDC := True;
    end;
    Item := GetItemParam(lpdis^.itemID);
    HandleBackgroundState(Selected, Item^.WidthStep * FStep);
    OldColor := SetTextColor(FListDC, SystemColor);
    if (not Item^.IsParent) then
    begin
      if (Item^.Bmp <> -1) then
        DrawBmp(FListDC, fBmp[Item^.Bmp],
          (lpdis^.rcItem.Left + 2 + (Item^.WidthStep * FStep)), lpdis^.rcItem.Top, 16, 16);
      Left := (lpdis^.rcItem.Left);
      for n := 0 to (FColCount - 1) do
      begin
        dRect.Left := (Left + 4);
        if (n = 0) then Inc(dRect.Left, 16)
        else Inc(dRect.Left, 2);
        w := Integer(SendMessage(FhList, LVM_GETCOLUMNWIDTH, n, 0));
        Inc(Left, w);
        if (n = 0) then dRect.Right := (Left - 2)
        else dRect.Right := (Left - 6);
        ItemText := Item^.Cols[n];
        dRect.Top := (lpdis^.rcItem.Top);
        dRect.Bottom := (lpdis^.rcItem.Bottom);
        if (not Item^.Empty) then DrawLine( Item^.WidthStep * FStep);
        DrawText(FListDC, PChar(ItemText), Length(ItemText), dRect,
          DT_VCENTER or DT_SINGLELINE or DT_NOPREFIX or DT_END_ELLIPSIS or FColAlign[n]);
      end;
      SetTextColor(FListDC, OldColor);
      if (lpdis^.itemState and ODS_FOCUS > 0) then
        DrawFrame((Selected) and (GetFocus = FhList), Item^.WidthStep * FStep);
    end
    else
    begin
      LineType := Integer(Item^.Param);
      TextColor := $606060;
      case LineType of
        0:
          begin
            TextColor := $606060;
            Inc(lpdis^.rcItem.Left, FStep);
          end;
        1: TextColor := $800000;
        3: TextColor := $000080;
      end;
      DrawBottom();
      dRect := lpdis^.rcItem;
      Inc(dRect.Left, 15);
      Dec(dRect.Top, 1);
      OldColor := SetTextColor(FListDC, TextColor);
      OldFont := SelectObject(FListDC, FFont);
      DrawText(FListDC, PChar(Item^.Header), Length(Item^.Header), dRect,
        DT_VCENTER or DT_SINGLELINE or DT_NOPREFIX or DT_END_ELLIPSIS);
      SelectObject(FListDC, OldFont);
      SetTextColor(FListDC, OldColor);
      Dec(dRect.Left, 14);
      if (Item^.Expanded) then ExpandBmp := fMinus
      else ExpandBmp := fPlus;
      DrawBmp(FListDC, ExpandBmp, (lpdis^.rcItem.Left) + 1, lpdis^.rcItem.Top + 1, 13, 13);
    end;
  end;

begin // DrawListViewItem
  lpdis := PDRAWITEMSTRUCT(lParam);
  DrawItem(lpdis^.itemState and ODS_SELECTED > 0);
  Result := True;
end;

function TListViewItems.DrawItem(Index: Integer; DC: HDC; Selected, Focus: Boolean): Boolean;
var
  lpdis: PDRAWITEMSTRUCT;
begin
  New(lpdis);
  lpdis^.rcItem := GetItemRect(FhList, lpdis^.itemID);
  lpdis^.itemID := Index;
  lpdis^.hDC := DC;
  if Selected then lpdis^.itemState := (lpdis^.itemState or ODS_SELECTED);
  if Focus then lpdis^.itemState := (lpdis^.itemState or ODS_FOCUS);
  Result := DrawList(DWord(lpdis));
end;

procedure TListViewItems.InitializeData;
var
  LogFont: TLogFont;
  Font: HFont;
  DC: HDC;
  Size: TSize;
  n: Integer;

  function GetColumnCount: DWord;
  begin
    Result := SendMessage(SendMessage(FhList, LVM_GETHEADER, 0, 0), HDM_GETITEMCOUNT, 0, 0);
  end;

  function GetColumnAlign(iCol: DWord): DWord;
  var
    pcol: tagLVCOLUMNA;
  begin
    Result := DT_LEFT;
    pcol.mask := LVCF_FMT;
    if Bool(SendMessage(FhList, LVM_GETCOLUMN, iCol, Longint(@pcol))) then
    begin
      case (pcol.fmt and 3) of
        LVCFMT_LEFT: Result := DT_LEFT;
        LVCFMT_CENTER: Result := DT_CENTER;
        LVCFMT_RIGHT: Result := DT_RIGHT;
      end;
    end;
  end;

begin
  FColCount := GetColumnCount;
  for n := 0 to (FColCount - 1) do FColAlign[n] := GetColumnAlign(n);
  Font := SendMessage(FhList, WM_GETFONT, 0, 0);
  DC := GetDC(0);
  try
    SelectObject(DC, Font);
    repeat
      FSpaces := (FSpaces + ' ');
      GetTextExtentPoint32(DC, PChar(FSpaces), Length(FSpaces), Size);
    until (Size.cx >= 14);
    FStep := Size.cx;
  finally
    ReleaseDC(0, DC);
  end;
  GetObject(Font, SizeOf(LogFont), @LogFont);
  LogFont.lfWeight := FW_BOLD;
  FFont := CreateFontIndirect(LogFont);
end;

procedure TListViewItems.SetRedrawState(Value: Boolean);
begin
  SendMessage(FhList, WM_SETREDRAW, Integer(Value), 0);
end;

end.
