unit MainService;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TMainForm = class(TForm)
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    E0: TRadioButton;
    E1: TRadioButton;
    E2: TRadioButton;
    E3: TRadioButton;
    E4: TRadioButton;
    E5: TRadioButton;
    E6: TRadioButton;
    EurekaActive: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

uses ExceptionLog;

procedure MyNotify(ExcRecord: TEurekaExceptionRecord; var Handled: Boolean);
begin
  Handled := MainForm.EurekaActive.Checked;
end;

procedure Run_DLL_Error;
var
  DLL_Error: procedure;
  Handle: THandle;
begin
  Handle := LoadLibrary('DLL.DLL');
  if Handle <> 0 then
  begin
    @DLL_Error := GetProcAddress(Handle, 'DLL_Error');
    if @DLL_Error <> nil then
      DLL_Error
    else
      MessageBox(0,
        'Cannot found "DLL_Error" procedure into DLL.DLL library.',
        'Error.', MB_OK or MB_ICONERROR);
  end
  else
    MessageBox(0,
      'Cannot found DLL.DLL library.', 'Error.', MB_OK or MB_ICONERROR);
end;

procedure RunError(idx: integer);
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
    6:
      begin
        Run_DLL_Error;
      end;
  end;
end;

procedure Error(i:integer);
begin
  RunError(i);
end;

procedure RaiseException (i:integer);
begin
  Error (i);
end;

// -----------------------------------------------------------------------------

procedure TMainForm.BitBtn1Click(Sender: TObject);
var
  i: integer;
  RB: TRadioButton;
begin
  i := 0;
  repeat
    RB := TRadioButton(FindComponent('E'+IntToStr(i)));
    if not RB.Checked then inc(i);
  until RB.Checked;
  RaiseException (i);
end;

initialization
  ExceptionNotify := MyNotify;

end.

