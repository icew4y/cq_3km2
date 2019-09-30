unit Winskinreg;

interface

{$I Compilers.Inc}

uses Dialogs, Forms, Classes, SysUtils,
{$IFDEF DELPHI_4}
  DsgnIntf,
{$ENDIF DELPHI_4}

{$IFDEF DELPHI_5}
  DsgnIntf,
{$ENDIF DELPHI_5}

{$IFDEF DELPHI_6_UP}
  DesignIntf, DesignEditors,
{$ENDIF DELPHI_6}

{$IFDEF CPPB_5}
  DsgnIntf,
{$ENDIF CPPB_5}

{$IFDEF CPPB_6}
  DesignIntf, DesignEditors,
{$ENDIF CPPB_6}

  winskindata, skinread, winsubclass, winskinform, WinSkinStore;

procedure Register;

implementation

type
{ TWinSkinStore}
  TWinSkinStore = class(TPropertyEditor)
  private
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

procedure TWinSkinStore.Edit;
var
  skindata: TSkindata; //ms
  storeitem: TSkinCollectionItem; //ms

  OpenDialog: TOpenDialog;
begin
  { Execute editor }
  OpenDialog := TOpenDialog.Create(Application);
  OpenDialog.Filter := 'Skin files (*.skn)|*.skn';
  try
    if OpenDialog.Execute then
    begin

      { this entire block by ms }
      storeitem := nil;
      skindata := nil;

      if GetComponent(0) is TSkinCollectionItem then
        storeitem := GetComponent(0) as TSkinCollectionItem;

      if GetComponent(0) is TSkindata then
        skindata := GetComponent(0) as TSkindata;

      if storeitem <> nil then
      begin
        storeitem.LoadFromFile(OpenDialog.FileName);
      end
      else
        if skindata <> nil then
        begin
          skindata.data.clear;
          skindata.data.LoadFromFile(OpenDialog.FileName);
          skindata.SkinFile := '';
        end;
      {
      TSkindata(GetComponent(0)).data.clear;
      TSkindata(GetComponent(0)).data.LoadFromFile(OpenDialog.FileName);
      TSkindata(GetComponent(0)).SkinFile := '';
      }
    end;
    Modified;
  finally
    OpenDialog.Free;
  end;
end;

function TWinSkinStore.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TWinSkinStore.GetValue: string;
var
  skindata: TSkindata; //ms
  storeitem: TSkinCollectionItem; //ms
begin

  // ms
  storeitem := nil;
  skindata := nil;

  if GetComponent(0) is TSkinCollectionItem then
    storeitem := GetComponent(0) as TSkinCollectionItem;

  if GetComponent(0) is TSkindata then
    skindata := GetComponent(0) as TSkindata;

  if storeitem <> nil then
  begin
    if storeitem.DataSize > 0 then
      Result := '(SkinData)'
    else
      Result := '(Empty)'
  end;

  if skindata <> nil then
  begin
    if TSkindata(GetComponent(0)).data.size > 0 then
      Result := '(SkinData)'
    else
      Result := '(Empty)'
  end;

end;

procedure Register;
begin
  RegisterComponents('VCLSkin', [TSkinData, TSkinStore]);
  RegisterPropertyEditor(TypeInfo(string), TSkinData, 'SkinStore', TWinSkinStore);

  // ms
  RegisterPropertyEditor(TypeInfo(string), TSkinCollectionItem, 'SkinData', TWinSkinStore);

end;

end.

