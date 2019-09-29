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

unit bsPngImageList;

interface

uses
  Windows, Classes, SysUtils, Controls, Graphics, CommCtrl, ImgList, PngImage;

type
  TbsPNGImageList = class;

  TbsPngImageItem = class(TCollectionItem)
   private
    FPngImage: TPNGObject;
    FName: string;
    procedure SetPngImage(const Value: TPNGObject);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property PngImage: TPNGObject read FPngImage write SetPngImage;
    property Name: string read FName write FName;
  end;

  TbsPngImageItems = class(TCollection)
  private
    function GetItem(Index: Integer): TbsPngImageItem;
    procedure SetItem(Index: Integer; Value:  TbsPngImageItem);
  protected
    function GetOwner: TPersistent; override;
  public
    FPngImageList: TbsPNGImageList;
    constructor Create(APNGImageList: TbsPNGImageList);
    property Items[Index: Integer]:  TbsPngImageItem read GetItem write SetItem; default;
  end;

  TbsPNGImageList = class(TCustomImageList)
  private
    FPngImages: TbsPngImageItems;
    function GetPngWidth: Integer;
    function GetPngHeight: Integer;
    procedure SetPngWidth(Value: Integer);
    procedure SetPngHeight(Value: Integer);
    procedure SetPngImages(Value: TbsPngImageItems);
  protected
    procedure DoDraw(Index: Integer; Canvas: TCanvas; X, Y: Integer; Style: Cardinal; Enabled: Boolean = True); override;
    procedure InsertBitMap(Index: Integer);
    procedure DeleteBitMap(Index: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property PngImages: TbsPngImageItems read FPngImages write SetPngImages;
    property PngWidth: Integer read GetPngWidth write SetPngWidth;
    property PngHeight: Integer read GetPngHeight write SetPngHeight;
  end;

  procedure Register;

implementation


  procedure Register;
  begin
    RegisterComponents('BusinessSkinForm VCL', [TbsPNGImageList]);
  end;

procedure TbsPngImageItem.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if (Dest is TbsPngImageItem)
  then
    TbsPngImageItem(Dest).PngImage := PngImage;
end;

constructor TbsPngImageItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FPngImage := TPNGObject.Create;
  FName := Format('PngImage%d', [Index]);
  TbsPngImageItems(Self.Collection).FPngImageList.InsertBitmap(Index);
end;

destructor TbsPngImageItem.Destroy;
begin
  FPngImage.Free;
  if TbsPngImageItems(Self.Collection).FPngImageList.Count > Index
  then
    TbsPngImageItems(Self.Collection).FPngImageList.DeleteBitmap(Index);
  inherited Destroy;
end;

procedure TbsPngImageItem.Assign(Source: TPersistent);
begin
  if Source is TbsPngImageItem
  then
    begin
      PngImage.Assign(TbsPngImageItem(Source).PngImage);
      Name := TbsPngImageItem(Source).Name;
   end
  else
    inherited Assign(Source);
end;

function TbsPngImageItem.GetDisplayName: string;
begin
  if Length(FName) = 0
  then Result := inherited GetDisplayName
  else Result := FName;
end;

procedure TbsPngImageItem.SetPngImage(const Value: TPNGObject);
begin
  FPngImage.Assign(Value);
  Changed(False);
end;

constructor TbsPngImageItems.Create;
begin
  inherited Create(TbsPngImageItem);
  FPngImageList := APngImageList;
end;


function TbsPngImageItems.GetOwner: TPersistent;
begin
  Result := FPngImageList;
end;

function TbsPngImageItems.GetItem(Index: Integer): TbsPngImageItem;
begin
  Result := TbsPngImageItem(inherited GetItem(Index));
end;

procedure TbsPngImageItems.SetItem;
begin
  inherited SetItem(Index, Value);
end;

constructor TbsPNGImageList.Create(AOwner: TComponent);
begin
  inherited;
  FPngImages := TbsPngImageItems.Create(Self);
end;

destructor TbsPNGImageList.Destroy;
begin
  FPngImages.Free;
  FPngImages := nil;
  inherited;
end;

function TbsPNGImageList.GetPngWidth: Integer;
begin
  Result := Width;
end;

function TbsPNGImageList.GetPngHeight: Integer;
begin
  Result := Height;
end;

procedure TbsPNGImageList.SetPngWidth(Value: Integer);
begin
  if Width <> Value
  then
    begin
      Width := Value;
      if not (csLoading in ComponentState)
      then
        FPngImages.Clear;
    end;
end;

procedure TbsPNGImageList.SetPngHeight(Value: Integer);
begin
  if Height <> Value
  then
    begin
      Height := Value;
      if not (csLoading in ComponentState)
      then
      FPngImages.Clear;
    end;
end;


procedure TbsPNGImageList.SetPngImages(Value: TbsPngImageItems);
begin
  FPngImages.Assign(Value);
end;

procedure TbsPNGImageList.DoDraw(Index: Integer; Canvas: TCanvas; X, Y: Integer; Style: Cardinal; Enabled: Boolean);

procedure MakeImageBlended(Image: TPNGObject; Amount: Byte = 127);

  procedure ForceAlphachannel(BitTransparency: Boolean; TransparentColor: TColor);
  var
     Assigner: TBitmap;
     Temp: TPNGObject;
     X, Y: Integer;
     Line: pngimage.PByteArray;
     Current: TColor;
  begin
  Temp := TPNGObject.Create;
  try
    Assigner := TBitmap.Create;
    try
      Assigner.Width := Image.Width;
      Assigner.Height := Image.Height;
      Temp.Assign(Assigner);
    finally
      Assigner.Free;
     end;
    Temp.CreateAlpha;
    for Y := 0 to Image.Height - 1
    do begin
       Line := Temp.AlphaScanline[Y];
       for X := 0 to Image.Width - 1
       do begin
          Current := Image.Pixels[X, Y];
          Temp.Pixels[X, Y] := Current;
          if BitTransparency and (Current = TransparentColor)
          then Line^[X] := 0
          else Line^[X] := Amount;
          end;
       end;
    Image.Assign(Temp);
  finally
    Temp.Free;
   end;
  end;

var
   X, Y: Integer;
   Line: pngimage.PByteArray;
   Forced: Boolean;
   TransparentColor: TColor;
   BitTransparency: Boolean;
begin
  BitTransparency := Image.TransparencyMode = ptmBit;
  TransparentColor := Image.TransparentColor;
  if not (Image.Header.ColorType in [COLOR_RGBALPHA, COLOR_GRAYSCALEALPHA])
  then
    begin
      Forced := Image.Header.ColorType in [COLOR_GRAYSCALE, COLOR_PALETTE];
      if Forced
      then
        ForceAlphachannel(BitTransparency, TransparentColor)
      else
        Image.CreateAlpha;
    end
  else
   Forced := False;

  if not Forced and (Image.Header.ColorType in [COLOR_RGBALPHA, COLOR_GRAYSCALEALPHA])
  then
     for Y := 0 to Image.Height - 1 do
     begin
       Line := Image.AlphaScanline[Y];
       for X := 0 to Image.Width - 1 do
         if BitTransparency and (Image.Pixels[X, Y] = TransparentColor)
         then
           Line^[X] := 0
         else
           Line^[X] := Round(Line^[X] / 256 * (Amount + 1));
     end;
end;

procedure DrawPNG(Png: TPNGObject; Canvas: TCanvas; const Rect: TRect; AEnabled: Boolean);
var
  PngCopy: TPNGObject;
begin
  if not AEnabled
  then
   begin
     PngCopy := TPNGObject.Create;
     try
       PngCopy.Assign(Png);
       MakeImageBlended(PngCopy);
       PngCopy.Draw(Canvas, Rect);
     finally
       PngCopy.Free;
      end;
    end
  else
    Png.Draw(Canvas, Rect);
end;


var
  PaintRect: TRect;
  Png: TbsPngImageItem;
begin
  PaintRect := Rect(X, Y, X + Width, Y + Height);
  Png := TbsPngImageItem(FPngImages.Items[Index]);
  if Png <> nil
  then
    DrawPNG(Png.PngImage, Canvas, PaintRect, Enabled);
end;

procedure TbsPNGImageList.InsertBitMap(Index: Integer);
var
  B: TBitMap;
begin
  B := TBitMap.Create;
  B.Monochrome := True;
  B.Width := Width;
  B.height := Height;
  Insert(Index, B, nil);
  B.Free;
end;

procedure TbsPNGImageList.DeleteBitMap(Index: Integer);
begin
  Delete(Index);
end;

end.
