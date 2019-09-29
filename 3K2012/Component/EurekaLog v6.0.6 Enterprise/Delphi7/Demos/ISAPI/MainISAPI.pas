unit MainISAPI;

interface

uses
  Windows, Messages, SysUtils, Classes, HTTPApp
  {$IFDEF VER140} ,HTTPProd {$ENDIF}
  {$IFDEF VER150} ,HTTPProd {$ENDIF}
  {$IFDEF VER170} ,HTTPProd {$ENDIF}
  ;

type
  TModule = class(TWebModule)
    PageProducer: TPageProducer;
    procedure Action(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Module: TModule;
  idx: integer;

implementation

{$R *.DFM}

uses ExceptionLog;

var
  ActivateEurekaLog: boolean;

procedure MyNotify(ExcRecord: TEurekaExceptionRecord; var Handled: Boolean);
begin
  Handled := ActivateEurekaLog;
end;

procedure Error;
var
  A, B: integer;
  C: variant;
  L: TList;
begin
  case idx of
    0:
      begin
        PByte(nil)^ := 0;
      end;
    1:
      begin
        A := 0;
        B := A div A;
        if B = 0 then
          Halt;
      end;
    2:
      begin
        WriteLn(StrToDateTime('99/99/1998'));
      end;
    3:
      begin
        raise Exception.Create('Custom exception');
      end;
    4:
      begin
        C := 'Hello';
        A := C;
        if A = 0 then
          Halt;
      end;
    5:
      begin
        L := TList.Create;
        try
          if L[0] <> nil then
            Halt;
        finally
          L.Free;
        end;
      end;
  end;
end;

procedure GoToError;
begin
  Error;
end;

procedure RaiseException;
begin
  GoToError;
end;

procedure TModule.Action(Sender: TObject; Request: TWebRequest;
  Response: TWebResponse; var Handled: Boolean);
begin
  if Request.QueryFields.Values['Exception'] <> '' then
  begin
    idx := StrToInt(Request.QueryFields.Values['Exception']);
    if (idx < 0) or (idx > 5) then
      Response.Content := 'Select "Exception" value between 0 and 5.'
    else
    begin
      ActivateEurekaLog := (Request.QueryFields.Values['Active'] <> '');
      RaiseException;
    end;
  end
  else
  begin
    Response.Content := 'Cannot found the "Exception" value.';
  end;
end;

initialization
  ExceptionNotify := MyNotify;

end.

