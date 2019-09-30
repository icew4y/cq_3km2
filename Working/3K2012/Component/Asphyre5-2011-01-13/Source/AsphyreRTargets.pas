unit AsphyreRTargets;

//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 SysUtils, AsphyreTypes, AbstractTextures;

//---------------------------------------------------------------------------
type
 TAsphyreRenderTargets = class
 private
  Textures: array of TAsphyreRenderTargetTexture;

  DestroyHandle : Cardinal;
  ResetHandle   : Cardinal;
  LostHandle    : Cardinal;

  function GetTexture(Index: Integer): TAsphyreRenderTargetTexture;
  function GetCount(): Integer;

  procedure OnDeviceDestroy(Sender: TObject; Param: Pointer;
   var Handled: Boolean);
  procedure OnDeviceReset(Sender: TObject; Param: Pointer;
   var Handled: Boolean);
  procedure OnDeviceLost(Sender: TObject; Param: Pointer;
   var Handled: Boolean);
 public
  property Texture[Index: Integer]: TAsphyreRenderTargetTexture
   read GetTexture; default;
  property Count: Integer read GetCount;

  function Insert(): Integer;
  function IndexOf(Element: TAsphyreRenderTargetTexture): Integer; overload;
  procedure Remove(Index: Integer);

  function Add(Count, Width, Height: Integer; Format: TAsphyrePixelFormat;
   DepthStencil: Boolean = False; MipMapping: Boolean = False): Integer;

  procedure RemoveAll();

  constructor Create();
  destructor Destroy(); override;
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
 AbstractDevices, AsphyreFactory;

//---------------------------------------------------------------------------
constructor TAsphyreRenderTargets.Create();
begin
 inherited;

 DestroyHandle:= EventDeviceDestroy.Subscribe(OnDeviceDestroy, -1);
 ResetHandle  := EventDeviceReset.Subscribe(OnDeviceReset, -1);
 LostHandle   := EventDeviceLost.Subscribe(OnDeviceLost, -1);
end;

//---------------------------------------------------------------------------
destructor TAsphyreRenderTargets.Destroy();
begin
 EventDeviceDestroy.Unsubscribe(LostHandle);
 EventDeviceDestroy.Unsubscribe(ResetHandle);
 EventDeviceDestroy.Unsubscribe(DestroyHandle);

 RemoveAll();

 inherited;
end;

//---------------------------------------------------------------------------
function TAsphyreRenderTargets.GetTexture(
 Index: Integer): TAsphyreRenderTargetTexture;
begin
 if (Index >= 0)and(Index < Length(Textures)) then
  Result:= Textures[Index] else Result:= nil;
end;

//---------------------------------------------------------------------------
function TAsphyreRenderTargets.GetCount(): Integer;
begin
 Result:= Length(Textures);
end;

//---------------------------------------------------------------------------
function TAsphyreRenderTargets.Insert(): Integer;
var
 Texture: TAsphyreRenderTargetTexture;
 Index: Integer;
begin
 Texture:= Factory.CreateRenderTargetTexture();
 if (Texture = nil) then
  begin
   Result:= -1;
   Exit;
  end;

 Index:= Length(Textures);
 SetLength(Textures, Index + 1);

 Textures[Index]:= Texture;
 Result:= Index;
end;

//---------------------------------------------------------------------------
function TAsphyreRenderTargets.IndexOf(
 Element: TAsphyreRenderTargetTexture): Integer;
var
 i: Integer;
begin
 Result:= -1;

 for i:= 0 to Length(Textures) - 1 do
  if (Textures[i] = Element) then
   begin
    Result:= i;
    Break;
   end;
end;

//---------------------------------------------------------------------------
procedure TAsphyreRenderTargets.RemoveAll();
var
 i: Integer;
begin
 for i:= 0 to Length(Textures) - 1 do
  if (Textures[i] <> nil) then
   FreeAndNil(Textures[i]);

 SetLength(Textures, 0);
end;

//---------------------------------------------------------------------------
procedure TAsphyreRenderTargets.OnDeviceDestroy(Sender: TObject;
 Param: Pointer; var Handled: Boolean);
begin
 RemoveAll();
end;

//---------------------------------------------------------------------------
procedure TAsphyreRenderTargets.OnDeviceReset(Sender: TObject; Param: Pointer;
 var Handled: Boolean);
var
 i: Integer;
begin
 for i:= 0 to Length(Textures) - 1 do
  if (Textures[i] <> nil) then Textures[i].HandleDeviceReset();
end;

//---------------------------------------------------------------------------
procedure TAsphyreRenderTargets.OnDeviceLost(Sender: TObject; Param: Pointer;
 var Handled: Boolean);
var
 i: Integer;
begin
 for i:= 0 to Length(Textures) - 1 do
  if (Textures[i] <> nil) then Textures[i].HandleDeviceLost();
end;

//---------------------------------------------------------------------------
procedure TAsphyreRenderTargets.Remove(Index: Integer);
var
 i: Integer;
begin
 if (Index < 0)or(Index >= Length(Textures)) then Exit;

 if (Textures[Index] <> nil) then FreeAndNil(Textures[Index]);

 for i:= Index to Length(Textures) - 2 do
  Textures[i]:= Textures[i + 1];

 SetLength(Textures, Length(Textures) - 1);
end;

//---------------------------------------------------------------------------
function TAsphyreRenderTargets.Add(Count, Width, Height: Integer;
 Format: TAsphyrePixelFormat; DepthStencil, MipMapping: Boolean): Integer;
var
 i, Index: Integer;
begin
 Result:= -1;

 for i:= 0 to Count - 1 do
  begin
   Index:= Insert();
   if (Index = -1) then Break;
   if (Result = -1) then Result:= Index;

   Textures[Index].Width := Width;
   Textures[Index].Height:= Height;
   Textures[Index].Format:= Format;
   Textures[Index].DepthStencil:= DepthStencil;
   Textures[Index].Mipmapping  := MipMapping;

   if (not Textures[Index].Initialize()) then
    begin
     if (Result = Index) then Result:= -1;
     Remove(Index);
     Break;
    end;
  end;
end;

//---------------------------------------------------------------------------
end.
