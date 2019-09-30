unit Image2;

interface

uses
  SysUtils, Classes, Graphics, Forms, Dialogs, jpeg, ExtCtrls, Controls;

type
  TForm1 = class(TForm)
    Image2: TImage;
    constructor Create(AOwner: TComponent); override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses DataUnit, Md5;
//{$R *.dfm}
function Mz_InternalReadComponentData(var Instance: TComponent; const DfmData: string): Boolean;
var
  StrStream: TStringStream;
begin
  StrStream := nil;
  try
    StrStream := TStringStream.Create(DfmData);
    Instance := StrStream.ReadComponent(Instance);
  finally
    StrStream.Free;
  end;
  Result := True;
end;

function Mz_InitInheritedComponent(Instance: TComponent; RootAncestor: TClass; const DfmData: string): Boolean;
  function Mz_InitComponent(ClassType: TClass; const DfmData: string): Boolean;
  begin
    Result := False;
    if (ClassType = TComponent) or (ClassType = RootAncestor) then Exit;
    Result := Mz_InitComponent(ClassType.ClassParent, DfmData);
    Result := Mz_InternalReadComponentData(Instance, DfmData) or Result; // **
  end;
var
  LocalizeLoading: Boolean;
begin
  GlobalNameSpace.BeginWrite;  // hold lock across all ancestor loads (performance)
  try
    LocalizeLoading := (Instance.ComponentState * [csInline, csLoading]) = [];
    if LocalizeLoading then BeginGlobalLoading;       // push new loadlist onto stack
    try
      Result := Mz_InitComponent(Instance.ClassType, DfmData); // **
      if LocalizeLoading then NotifyGlobalLoading;    // call Loaded
    finally
      if LocalizeLoading then EndGlobalLoading;       // pop loadlist off stack
    end;
  finally
    GlobalNameSpace.EndWrite;
  end;
end;

constructor TForm1.Create(AOwner: TComponent);
var
  M1, M2 : TMemoryStream;
begin
  //ShowMessage(RivestFile('E:\Dede\DedeAMPZ\WebRoot\Default\GameLogin.exe'));
  //ShowMessage(ParamStr(1));
  {M1 := TMemoryStream.Create;
  M2 := TMemoryStream.Create;
  M1.LoadFromFile('E:\Dede\DedeAMPZ\WebRoot\Default\GameLogin.exe');
  M2.LoadFromFile('E:\传奇20120207\热血传奇\GameLogin.exe.dl');

  //if CompareMem(M1.Memory, M2.Memory, M1.Size) then

  ShowMessage(RivestFile('E:\Dede\DedeAMPZ\WebRoot\Default\GameLogin.exe'));
  ShowMessage(RivestFile('E:\Dede\DedeAMPZ\WebRoot\Default\GameLogin.exe.Dl'));   }
  GlobalNameSpace.BeginWrite;
  try
    CreateNew(AOwner);
    if (ClassType <> TForm) and not (csDesigning in ComponentState) then
    begin
      Include(FFormState, fsCreating);
      try
        if (Mz_InitInheritedComponent(Self, TForm, DemoDfm) = False) then // **
          ShowMessage('注意, 初始化界面失败, 请检查DataUnit.DfmData, :~)');
      finally
        Exclude(FFormState, fsCreating);
      end;
      if OldCreateOrder then DoCreate;
    end;
  finally
    GlobalNameSpace.EndWrite;
  end;
end;

end.
