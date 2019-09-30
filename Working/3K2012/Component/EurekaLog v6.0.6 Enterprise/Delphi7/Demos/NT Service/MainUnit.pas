unit MainUnit;

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
    E7: TRadioButton;
    EurekaActive: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TMyThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

var
  MainForm: TMainForm;
  Typ: Integer;

implementation

{$R *.DFM}

uses ExceptionLog;

procedure MyNotify(ExcRecord: TEurekaExceptionRecord; var Handled: Boolean);
begin
  Handled := MainForm.EurekaActive.Checked;
end;

procedure DLL_Error; external 'DLL.DLL';

procedure RunError(idx: integer);
var
  A, B: integer;
  C: variant;
  L: TList;
  Thread: TMyThread;
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
        Thread := TMyThread.Create(True);
        Thread.FreeOnTerminate := True;
        Thread.Resume;
      end;
    7:
      begin
        DLL_Error;
      end;
  end;
end;

procedure Error(i: integer);
begin
  RunError(i);
end;

procedure RaiseException(i: integer);
begin
  Error(i);
end;

{ TMyThread }

procedure TMyThread.Execute;
begin
  PByte(nil)^ := 0;
end;

// -----------------------------------------------------------------------------

procedure TMainForm.BitBtn1Click(Sender: TObject);
var
  i: integer;
  RB: TRadioButton;
begin
  i := 0;
  repeat
    RB := TRadioButton(FindComponent('E' + IntToStr(i)));
    if not RB.Checked then
      inc(i);
  until RB.Checked;
  RaiseException(i);
end;

initialization
  ExceptionNotify := MyNotify;

end.

