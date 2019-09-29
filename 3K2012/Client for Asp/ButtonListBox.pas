unit ButtonListBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TButtonListBox = class(TListBox)
  private
      FDepth: integer;
      FNormalColor: TColor;
      FSelectFontColor: TColor;
      FHighLight: TColor;
      FFace: TColor;
      FShadow: TColor;
      //facebmp: TBitmap;
  protected
  public
      constructor Create (AOwner: TComponent); override;
      destructor Destroy; override;
      procedure DrawItem (Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
  published
      property Depth: integer read FDepth write FDepth;
      property NormalFontColor: TColor read FNormalColor write FNormalColor;
      property SelectFontColor: TColor read FSelectFontColor write FSelectFontColor;
      property HighlightColor: TColor read FHighlight write FHighlight;
      property FaceColor: TColor read FFace write FFace;
      property ShadowColor: TColor read FShadow write FShadow;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Zura', [TButtonListBox]);
end;

constructor TButtonListBox.Create (AOwner: TComponent);
begin
   inherited Create (AOwner);
   ItemHeight := 24;
   FNormalColor := Font.Color;
   FSelectFontColor := clWhite;
   FHighlight := clBtnHighlight;
   FFace := clBtnFace;
   FShadow := clBtnShadow;

   //facebmp := TBitmap.Create;
   //facebmp.LoadFromFile ('data\새 폴더\돌색.bmp');
end;

destructor TButtonListBox.Destroy;
begin
   //facebmp.Free;
   inherited Destroy;
end;

//State: odSelected, odGrayed, odDisabled, odChecked, odFocused
procedure TButtonListBox.DrawItem (Index: Integer; Rect: TRect; State: TOwnerDrawState);
   procedure rectangle (paper: TCanvas; rc: TRect; color: TColor);
   var
      i: integer;
      old: TColor;
   begin
      old := paper.Pen.Color;
      paper.Pen.Color := color;
      for i:=rc.Top to rc.Bottom do begin
         paper.MoveTo (rc.Left, i);
         paper.LineTo (rc.Right, i);
      end;
      paper.Pen.Color := old;
   end;
var
   i, fcolor, bcolor, fontcolor, oldcolor: integer;
   srcrc: TRect;
begin
   //srcrc.Left := 0;
   //srcrc.Top := 0;
   //srcrc.Right := Rect.Right - Rect.Left;
   //srcrc.Bottom := Rect.Bottom - Rect.Top;
   //Canvas.CopyRect(Rect, facebmp.Canvas, srcrc);

   if odSelected in State then begin
      fcolor := ShadowColor;
      bcolor := HighlightColor;
      fontcolor := FSelectFontColor;

      Canvas.Brush.Color := ShadowColor; //FaceColor;
      Canvas.FillRect (Rect);
      rectangle (Canvas, Rect, FaceColor);
   end else begin
      fcolor := HighlightColor;
      bcolor := ShadowColor;
      fontcolor := FNormalColor;

      Canvas.Brush.Color := FaceColor;
      Canvas.FillRect (Rect);
      rectangle (Canvas, Rect, FaceColor);
   end;

   Canvas.Pen.Color := fcolor;
   for i:=1 to Depth do begin
      Canvas.MoveTo (Rect.Left+i, Rect.Top+i);
      Canvas.LineTo (Rect.Right-i+1, Rect.Top+i);
      Canvas.MoveTo (Rect.Left+i, Rect.Top+i);
      Canvas.LineTo (Rect.Left+i, Rect.Bottom-i+1);
   end;

   Canvas.Pen.Color := bcolor;
   for i:=1 to Depth do begin
      Canvas.MoveTo (Rect.Left+i, Rect.Bottom-i+1);
      Canvas.LineTo (Rect.Right-i+1, Rect.Bottom-i+1);
      Canvas.MoveTo (Rect.Right-i+1, Rect.Bottom-i+1);
      Canvas.LineTo (Rect.Right-i+1, Rect.Top+i);
   end;

   oldcolor := Canvas.Font.Color;
   SetBkMode (Canvas.Handle, TRANSPARENT);
   Canvas.Font.Color := fontcolor;
   if odSelected in State then
      Canvas.TextOut (Rect.Left + (Rect.Right-Rect.Left - Canvas.TextWidth(Items[Index])) div 2 + 1,
                      Rect.Top + (Rect.Bottom-Rect.Top - Canvas.TextHeight(Items[Index])) div 2 + 1,
                      Items[Index])
   else
      Canvas.TextOut (Rect.Left + (Rect.Right-Rect.Left - Canvas.TextWidth(Items[Index])) div 2,
                      Rect.Top + (Rect.Bottom-Rect.Top - Canvas.TextHeight(Items[Index])) div 2,
                      Items[Index]);
   Canvas.Font.Color := oldcolor;
end;

end.
