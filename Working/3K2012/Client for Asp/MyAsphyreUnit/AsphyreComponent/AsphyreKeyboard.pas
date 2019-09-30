unit AsphyreKeyboard;
//---------------------------------------------------------------------------
// AsphyreKeyboard.pas                                  Modified: 28-Jan-2007
// Keyboard DirectInput wrapper for Asphyre                      Version 1.02
//---------------------------------------------------------------------------
// Important Notice:
//
// If you modify/use this code or one of its parts either in original or
// modified form, you must comply with Mozilla Public License v1.1,
// specifically section 3, "Distribution Obligations". Failure to do so will
// result in the license breach, which will be resolved in the court.
// Remember that violating author's rights is considered a serious crime in
// many countries. Thank you!
//
// !! Please *read* Mozilla Public License 1.1 document located at:
//  http://www.mozilla.org/MPL/
//
// If you require any clarifications about the license, feel free to contact
// us or post your question on our forums at: http://www.afterwarp.net
//---------------------------------------------------------------------------
// The contents of this file are subject to the Mozilla Public License
// Version 1.1 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/
//
// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
//
// The Original Code is AsphyreKeyboard.pas.
//
// The Initial Developer of the Original Code is M. Sc. Yuriy Kotsarenko.
// Portions created by M. Sc. Yuriy Kotsarenko are Copyright (C) 2007,
// M. Sc. Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Windows, DirectInput;

//---------------------------------------------------------------------------
type
 TDIKeyBuf = array[0..255] of Byte;

//---------------------------------------------------------------------------
 TAsphyreKeyboard = class
 private
  FOwnerInput : TObject;
  FInputDevice: IDirectInputDevice7;
  FForeground : Boolean;
  FInitialized: Boolean;

  Buffer : TDIKeyBuf;
  PrevBuf: TDIKeyBuf;
  FWindowHandle: THandle;

  function CreateDirectInput(): Boolean;

  procedure SetForeground(const Value: Boolean);
  function GetKeyBuffer(): Pointer;
  function GetKey(KeyNum: Integer): Boolean;
  function GetKeyPressed(KeyNum: Integer): Boolean;
  function GetKeyReleased(KeyNum: Integer): Boolean;
  function GetKeyName(KeyNum: Integer): string;
  function VKeyToNum(VCode: Cardinal): Integer;
  function GetVKey(VCode: Cardinal): Boolean;
  function GetVKeyPressed(VCode: Cardinal): Boolean;
  function GetVKeyReleased(VCode: Cardinal): Boolean;
  function GetVKeyName(VCode: Cardinal): string;
 public
  property WindowHandle: THandle read FWindowHandle write FWindowHandle;

  // Interface to DirectInput 7 device.
  property InputDevice: IDirectInputDevice7 read FInputDevice;

  // The pointer to current key buffer.
  property KeyBuffer : Pointer read GetKeyBuffer;

  // Indicates whether the component has been initialized properly.
  property Initialized: Boolean read FInitialized;

  // This indicates whether the component should have keyboard acquired
  // even when the application has no focus.
  property Foreground: Boolean read FForeground write SetForeground;

  // Retreives key status using scancodes (DIK_[key] constants)
  property Key[KeyNum: Integer]: Boolean read GetKey;

  // Retreives the name of the key for the specific scancode
  property KeyName[KeyNum: Integer]: string read GetKeyName;

  // Retreives key status using virtual codes (VK_[key] constants)
  // Note: not all keys can be obtained this way!
  property VKey[VCode: Cardinal]: Boolean read GetVKey;

  // Retreives the name of the key for the specific virtual code
  property VKeyName[VCode: Cardinal]: string read GetVKeyName;

  // Note: The following functions try to detect key presses and releases,
  // but they are limited to the resolution of Update() calls and may miss
  // some key presses.

  // Checks whether a key with the specific scancode has been pressed
  // or released recently.
  property KeyPressed[KeyNum: Integer]: Boolean read GetKeyPressed;
  property KeyReleased[KeyNum: Integer]: Boolean read GetKeyReleased;

  // Checks whether a key with the specific virtual code has been pressed
  // or released recently.
  property VKeyPressed[VCode: Cardinal]: Boolean read GetVKeyPressed;
  property VKeyReleased[VCode: Cardinal]: Boolean read GetVKeyReleased;

  function Initialize(): Boolean;
  procedure Finalize();

  function Update(): Boolean;

  constructor Create(AOwnerInput: TObject);
  destructor Destroy(); override;
 end;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
uses
 DX7Types;

//---------------------------------------------------------------------------
constructor TAsphyreKeyboard.Create(AOwnerInput: TObject);
begin
 inherited Create();

 FOwnerInput:= AOwnerInput;

 FForeground := True;
 FInitialized:= False;
end;

//---------------------------------------------------------------------------
destructor TAsphyreKeyboard.Destroy();
begin
 if (FInitialized) then Finalize();

 inherited;
end;

//---------------------------------------------------------------------------
function TAsphyreKeyboard.CreateDirectInput(): Boolean;
begin
 if (DInput7 <> nil) then
  begin
   Result:= True;
   Exit;
  end;

 Result:= Succeeded(DirectInputCreateEx(hInstance, DIRECTINPUT_VERSION,
  IID_IDirectInput7, DInput7, nil));
end;

//---------------------------------------------------------------------------
procedure TAsphyreKeyboard.SetForeground(const Value: Boolean);
begin
 if (not FInitialized) then FForeground:= Value;
end;

//---------------------------------------------------------------------------
function TAsphyreKeyboard.Initialize(): Boolean;
begin
 Result:= CreateDirectInput();
 if (not Result) then Exit;

 // (3) Create Keyboard DirectInput device.
 Result:= Succeeded(DInput7.CreateDeviceEx(GUID_SysKeyboard,
  IID_IDirectInputDevice7, Pointer(FInputDevice), nil));
 if (not Result) then Exit;

 // (4) Set Keyboard data format.
 Result:= Succeeded(FInputDevice.SetDataFormat(c_dfDIKeyboard));
 if (not Result) then
  begin
   FInputDevice:= nil;
   Exit;
  end;

 // (5) Set cooperative level.
 if (FForeground) then
  begin // foreground cooperative level
   Result:= Succeeded(FInputDevice.SetCooperativeLevel(FWindowHandle,
    DISCL_FOREGROUND or DISCL_NONEXCLUSIVE));
  end else
  begin // background cooperative level
   Result:= Succeeded(FInputDevice.SetCooperativeLevel(FWindowHandle,
    DISCL_BACKGROUND or DISCL_NONEXCLUSIVE));
  end;
 if (not Result) then
  begin
   FInputDevice:= nil;
   Exit;
  end;

 FillChar(Buffer, SizeOf(TDIKeyBuf), 0);
 FillChar(PrevBuf, SizeOf(TDIKeyBuf), 0);
 FInitialized:= True;
end;

//---------------------------------------------------------------------------
procedure TAsphyreKeyboard.Finalize();
begin
 if (FInputDevice <> nil) then
  begin
   FInputDevice.Unacquire();
   FInputDevice:= nil;
  end;

 FInitialized:= False;
end;

//---------------------------------------------------------------------------
function TAsphyreKeyboard.GetKeyBuffer(): Pointer;
begin
 Result:= @Buffer;
end;

//---------------------------------------------------------------------------
function TAsphyreKeyboard.Update(): Boolean;
var
 Res: Integer;
begin
 Result:= True;

 // (1) Make sure the component is initialized.
 if (not FInitialized) then
  begin
   Result:= Initialize();
   if (not Result) then Exit;
  end;

 // (2) Save current buffer state.
 Move(Buffer, PrevBuf, SizeOf(TDIKeyBuf));

 // (3) Attempt to retreive device state.
 Res:= FInputDevice.GetDeviceState(SizeOf(TDIKeyBuf), @Buffer);
 if (Res <> DI_OK) then
  begin
   // -> can the error be corrected?
   if (Res <> DIERR_INPUTLOST)and(Res <> DIERR_NOTACQUIRED) then
    begin
     Result:= False;
     Exit;
    end;

   // -> device might not be acquired!
   Res:= FInputDevice.Acquire();
   if (Res = DI_OK) then
    begin
     // acquired successfully, now try retreiving the state again
     Res:= FInputDevice.GetDeviceState(SizeOf(TDIKeyBuf), @Buffer);
     if (Res <> DI_OK) then Result:= False;
    end else Result:= False;
  end; // if (Res <> DI_OK)
end;

//---------------------------------------------------------------------------
function TAsphyreKeyboard.GetKey(KeyNum: Integer): Boolean;
begin
 Result:= (Buffer[KeyNum] and $80) = $80;
end;

//---------------------------------------------------------------------------
function TAsphyreKeyboard.GetKeyPressed(KeyNum: Integer): Boolean;
begin
 Result:= (PrevBuf[KeyNum] and $80 <> $80) and (Buffer[KeyNum] and $80 = $80);
end;

//---------------------------------------------------------------------------
function TAsphyreKeyboard.GetKeyReleased(KeyNum: Integer): Boolean;
begin
 Result:= (PrevBuf[KeyNum] and $80 = $80) and (Buffer[KeyNum] and $80 <> $80);
end;

//---------------------------------------------------------------------------
function TAsphyreKeyboard.GetKeyName(KeyNum: Integer): string;
var
 KeyName: array[0..255] of Char;
begin
 GetKeyNameText(KeyNum or $800000, @KeyName, 255);
 Result:= string(KeyName);
end;

//---------------------------------------------------------------------------
function TAsphyreKeyboard.VKeyToNum(VCode: Cardinal): Integer;
begin
 Result:= MapVirtualKey(VCode, 0);
end;

//---------------------------------------------------------------------------
function TAsphyreKeyboard.GetVKey(VCode: Cardinal): Boolean;
begin
 Result:= GetKey(VKeyToNum(VCode));
end;

//---------------------------------------------------------------------------
function TAsphyreKeyboard.GetVKeyPressed(VCode: Cardinal): Boolean;
begin
 Result:= GetKeyPressed(VKeyToNum(VCode));
end;

//---------------------------------------------------------------------------
function TAsphyreKeyboard.GetVKeyReleased(VCode: Cardinal): Boolean;
begin
 Result:= GetKeyReleased(VKeyToNum(VCode));
end;

//---------------------------------------------------------------------------
function TAsphyreKeyboard.GetVKeyName(VCode: Cardinal): string;
begin
 Result:= GetKeyName(VKeyToNum(VCode));
end;

//---------------------------------------------------------------------------
end.
