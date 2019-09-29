unit BPL_Unit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TBPL_Form = class(TForm)
    Button1: TButton;
    ExceptionsGroup: TRadioGroup;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BPL_Form: TBPL_Form;

implementation

{$R *.DFM}

procedure RunError;
var
  A, B: integer;
  C: variant;
  L: TList;
begin
  case BPL_Form.ExceptionsGroup.ItemIndex of
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

procedure GoError;
begin
  RunError;
end;

procedure TBPL_Form.Button1Click(Sender: TObject);
begin
  GoError;
end;

initialization
  BPL_Form := TBPL_Form.Create(nil);
  BPL_Form.ShowModal;
  BPL_Form.Free;

end.

