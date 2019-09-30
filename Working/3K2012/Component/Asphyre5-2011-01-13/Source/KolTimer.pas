unit KolTimer;
//---------------------------------------------------------------------------
// Kol.pas                                              Modified: 24-Oct-2007
// Single-Core Timer based on Idle event                          Version 1.0
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
// The Original Code is AbstractCanvas.pas.
//
// The Initial Developer of the Original Code is M. Sc. Yuriy Kotsarenko.
// Portions created by M. Sc. Yuriy Kotsarenko are Copyright (C) 2007,
// M. Sc. Yuriy Kotsarenko. All Rights Reserved.
//---------------------------------------------------------------------------
interface

//---------------------------------------------------------------------------
uses
 Windows, Math, MMSystem;

//---------------------------------------------------------------------------
type
 TPerformancePrecision = (ppLow, ppHigh);

//---------------------------------------------------------------------------
 TNotifyEvent = procedure(Sender: TObject) of object;

//---------------------------------------------------------------------------
 TAsphyreTimer = class
 private
  FMaxFPS : Integer;
  FSpeed  : Real;
  FEnabled: Boolean;
  FOnTimer: TNotifyEvent;

  FFrameRate: Integer;

  FPrecision : TPerformancePrecision;
  PrevTime  : Cardinal;
  PrevTime64: Int64;
  FOnProcess: TNotifyEvent;
  Processed : Boolean;

  LatencyFP : Integer;
  DeltaFP   : Integer;
  HighFreq  : Int64;
  MinLatency: Integer;
  SpeedLatcy: Integer;
  FixedDelta: Integer;

  SampleLatency: Integer;
  SampleIndex: Integer;

  function RetreiveLatency(): Integer;
  procedure SetSpeed(const Value: Real);
  procedure SetMaxFPS(const Value: Integer);
  function GetDelta(): Real;
  function GetLatency(): Real;
 public
  property Delta  : Real read GetDelta;
  property Latency: Real read GetLatency;
  property FrameRate: Integer read FFrameRate;

  // The speed at which processing will be made.
  property Speed: Real read FSpeed write SetSpeed;
  // The maximum allowed frame rate.
  property MaxFPS: Integer read FMaxFPS write SetMaxFPS;
  // Whether this timer is active or not.
  property Enabled: Boolean read FEnabled write FEnabled;
  // The precision of timer's calculations.
  property Precision: TPerformancePrecision read FPrecision;

  property OnTimer  : TNotifyEvent read FOnTimer write FOnTimer;
  property OnProcess: TNotifyEvent read FOnProcess write FOnProcess;

  procedure InvokeIdle();
  procedure Process();

  procedure Reset();

  constructor Create();
 end;

//---------------------------------------------------------------------------
var
 Timer: TAsphyreTimer = nil;

//---------------------------------------------------------------------------
implementation

//---------------------------------------------------------------------------
const
 FixedHigh = $100000;
 DeltaLimit = 32 * FixedHigh;

//---------------------------------------------------------------------------
constructor TAsphyreTimer.Create();
begin
 inherited;

 Speed := 60.0;
 MaxFPS:= 100;

 FPrecision:= ppLow;
 if (QueryPerformanceFrequency(HighFreq)) then FPrecision:= ppHigh;

 if (FPrecision = ppHigh) then
  QueryPerformanceCounter(PrevTime64) else PrevTime:= GetTickCount;

 timeBeginPeriod(1);

 FixedDelta := 0;
 FFrameRate := 0;
 SampleLatency:= 0;
 SampleIndex  := 0;
 Processed    := False;
end;

//---------------------------------------------------------------------------
procedure TAsphyreTimer.SetSpeed(const Value: Real);
begin
 FSpeed:= Value;
 if (FSpeed < 1.0) then FSpeed:= 1.0;
 SpeedLatcy:= Round(FixedHigh * 1000.0 / FSpeed);
end;

//---------------------------------------------------------------------------
procedure TAsphyreTimer.SetMaxFPS(const Value: Integer);
begin
 FMaxFPS:= Value;
 if (FMaxFPS < 1) then FMaxFPS:= 1;
 MinLatency:= Round(FixedHigh * 1000.0 / FMaxFPS);
end;

//---------------------------------------------------------------------------
function TAsphyreTimer.GetDelta(): Real;
begin
 Result:= DeltaFP / FixedHigh;
end;

//---------------------------------------------------------------------------
function TAsphyreTimer.GetLatency(): Real;
begin
 Result:= LatencyFP / FixedHigh;
end;

//---------------------------------------------------------------------------
function TAsphyreTimer.RetreiveLatency(): Integer;
var
 CurTime  : Cardinal;
 CurTime64: Int64;
begin
 if (FPrecision = ppHigh) then
  begin
   QueryPerformanceCounter(CurTime64);
   Result:= ((CurTime64 - PrevTime64) * FixedHigh * 1000) div HighFreq;
   PrevTime64:= CurTime64;
  end else
  begin
   CurTime := GetTickCount;
   Result  := (CurTime - PrevTime) * FixedHigh;
   PrevTime:= CurTime;
  end;
end;

//---------------------------------------------------------------------------
procedure TAsphyreTimer.InvokeIdle();
var
 WaitAmount: Integer;
 SampleMax : Integer;
begin
 // (1) Retreive current latency.
 LatencyFP:= RetreiveLatency();

 // (2) If Timer is disabled, wait a little to avoid using 100% of CPU.
 if (not FEnabled) then
  begin
   SleepEx(5, True);
   Exit;
  end;

 // (3) Adjust to maximum FPS, if necessary.
 if (LatencyFP < MinLatency) then
  begin
   WaitAmount:= (MinLatency - LatencyFP) div FixedHigh;
   if WaitAmount < 0 then WaitAmount:= 5;
   SleepEx(WaitAmount, True);
  end else WaitAmount:= 0;

 // (4) The running speed ratio.
 DeltaFP:= (Int64(LatencyFP) * FixedHigh) div SpeedLatcy;
 // -> provide Delta limit to prevent auto-loop lockup.
 if (DeltaFP > DeltaLimit) then DeltaFP:= DeltaLimit;

 // (5) Calculate Frame Rate every second.
 SampleLatency:= SampleLatency + LatencyFP + (WaitAmount * FixedHigh);
 if (LatencyFP <= 0) then SampleMax:= 4
  else SampleMax:= (Int64(FixedHigh) * 1000) div LatencyFP;

 Inc(SampleIndex);
 if (SampleIndex >= SampleMax) then
  begin
   FFrameRate   := (Int64(SampleIndex) * FixedHigh * 1000) div SampleLatency;
   SampleLatency:= 0;
   SampleIndex  := 0;
  end;

 // (6) Increase processing queque, if processing was made last time.
 if (Processed) then
  begin
   Inc(FixedDelta, DeltaFP);
   Processed:= False;
  end;

 // (7) Call timer event.
 if (Assigned(FOnTimer)) then FOnTimer(Self);
end;

//---------------------------------------------------------------------------
procedure TAsphyreTimer.Process();
var
 i, Amount: Integer;
begin
 Processed:= True;

 Amount:= FixedDelta div FixedHigh;
 if (Amount < 1) then Exit;

 if (Assigned(FOnProcess)) then
  for i:= 1 to Amount do
   FOnProcess(Self);

 FixedDelta:= FixedDelta and (FixedHigh - 1);
end;

//---------------------------------------------------------------------------
procedure TAsphyreTimer.Reset();
begin
 FixedDelta:= 0;
end;

//---------------------------------------------------------------------------
initialization
 Timer:= TAsphyreTimer.Create();

//---------------------------------------------------------------------------
finalization
 Timer.Free();

//---------------------------------------------------------------------------
end.

