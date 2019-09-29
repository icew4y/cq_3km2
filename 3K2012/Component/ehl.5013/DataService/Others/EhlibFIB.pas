{
                EhLib v4.2
                FIBPlus 6.41
    Register object that sort data in TpFIBDataset

      Copyright (c) 2005-2006 by Roman V. Babenko
 e-mail: romb@devrace.com
}

{*******************************************************}
{ Add this unit to 'uses' clause of any unit of your    }
{ project to allow TDBGridEh to sort data in            }
{ TpFIBDataset automatically after sorting markers      }
{ will be changed.                                      }
{ TFIBDatasetFeaturesEh will sort data locally          }
{ using DoSort procedure of TpFIBDataset                }
{ [+] SortLocal                                         }
{ [+] FilterLocal                                       }
{ [+] SortServer                                        }
{ [+] FilterServer                                      }
{*******************************************************}

unit EhLibFIB;

interface

{$I EhLib.Inc}

implementation

uses
 DBUtilsEh, pFIBDataSet, DB, DBGridEh, Classes, SysUtils;

type
  TpFIBDatasetFeaturesEh = class(TDatasetFeaturesEh)
  public
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
  end;


{ TpFIBDatasetFeaturesEh }

procedure TpFIBDatasetFeaturesEh.ApplyFilter(Sender: TObject;
  DataSet: TDataSet; IsReopen: Boolean);
var
  vDBGridEh   : TCustomDBGridEh;
begin
  if (Sender is TDBGridEh)then
  begin
    if (Sender as TDBGridEh).STFilter.Local then
    begin
      TpFIBDataSet(DataSet).Filter :=
        GetExpressionAsFilterString((Sender as TCustomDBGridEh),
        GetOneExpressionAsLocalFilterString, nil, False, True);
      TpFIBDataSet(DataSet).Filtered := True;
    end else
    begin
     ApplyFilterSQLBasedDataSet(( Sender as TCustomDBGridEh ), nil,
       IsReopen, 'SelectSQL');
    end;
  end;
end;
{
procedure TpFIBDatasetFeaturesEh.ApplySorting(Sender: TObject;
  DataSet: TDataSet; IsReopen: Boolean);
var
 vSort: array of boolean;
 I, J: integer;
 vGrid: TCustomDBGridEh;
 vFields: TStrings;
begin
  if (Sender is TCustomDBGridEh) then
  begin
    if (Sender as TCustomDBGridEh).SortLocal then
    begin
      vGrid := TCustomDBGridEh(Sender);
      J := vGrid.SortMarkedColumns.Count;
      vFields := TStringList.Create;
      try
        Setlength(vSort, J);
        for i := 0 to J - 1 do
        begin
          vFields.Add(vGrid.SortMarkedColumns[I].FieldName);
          vSort[I] := vGrid.SortMarkedColumns[I].Title.SortMarker = smDownEh;
        end;
        TpFIBDataSet(DataSet).DoSortEx(vFields, vSort);
      finally
        FreeAndNil(vFields);
      end
    end else
    begin
      ApplySortingForSQLBasedDataSet((Sender as TCustomDBGridEh),
        TpFIBDataSet(DataSet), True, IsReopen, 'SelectSQL');
    end;
  end;
end;
}


procedure TpFIBDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
var FLD  : array of TVarRec ;
    sort : array of boolean;
    I,J  : integer;
    Grid : TCustomDBGridEh;
begin
  if Sender is TCustomDBGridEh then begin
    Grid:=TCustomDBGridEh(Sender);
    J:=Grid.SortMarkedColumns.Count;
    setlength(fld,J);setlength(sort,J);
    for i:=0 to pred(j) do
      begin
       fld[i].VType:=vtAnsiString;
       string(fld[i].VString):=Grid.SortMarkedColumns[i].fieldname;
       sort[i]:=Grid.SortMarkedColumns[i].Title.SortMarker=smDownEh;
      end;
      TpFibDataset(Dataset).DoSort(fld,sort);
    end;
end;

initialization
  RegisterDatasetFeaturesEh(TpFIBDatasetFeaturesEh, TpFIBDataSet);
end.

