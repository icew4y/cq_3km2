{*******************************************************}
{                                                       }
{                        EhLib                          }
{    Copyright (c) 2002 - 2004 by Dmitry V. Bolshakov   }
{                                                       }
{  Register object that sort and filtering data in      }
{      TVirtualTable v.6.0.0.1 from CoreLab             }
{             (http://www.crlab.com)                    }
{      Copyright (c) 2007 by Matvey Karpushin           }
{                                                       }
{*******************************************************}

{*******************************************************}
{ Add this unit to 'uses' clause of any unit of your    }
{ project to allow TDBGridEh to sort data in            }
{ TVirtualTable automatically after sorting markers     }
{ will be changed.                                      }
{*******************************************************}

unit EhLibMemDS;

{$I EhLib.Inc}

interface

uses
  DbUtilsEh, DBGridEh, Db, MemDS;

type
  TMemDatasetFeaturesEh = class(TDatasetFeaturesEh)
  public
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
  end;

implementation

{ TVirtualTableDatasetFeaturesEh }

procedure TMemDatasetFeaturesEh.ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
begin
  { This feature work only with DBGridEh }
  if not(Sender is TCustomDBGridEh) then exit;
  { Only local filtering is allowed }
  if not TDBGridEh(Sender).STFilter.Local then exit;

  DataSet.Filter := GetExpressionAsFilterString(TDBGridEh(Sender), GetOneExpressionAsLocalFilterString, nil);
  DataSet.Filtered := DataSet.Filter <> '';
end;

procedure TMemDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
var
  i: Integer;
  IndexFieldNames: String;
begin
  { This feature work only with DBGridEh }
  if not(Sender is TCustomDBGridEh) then exit;
  { Only local sorting is allowed }
  if not TDBGridEh(Sender).SortLocal then exit;
  if not(DataSet is TMemDataSet) then exit;

  with TCustomDBGridEh(Sender) do
    begin
     IndexFieldNames := '';
     for i := 0 to SortMarkedColumns.Count - 1 do
     begin
       IndexFieldNames := IndexFieldNames + SortMarkedColumns[i].FieldName;
       if SortMarkedColumns[i].Title.SortMarker = smUpEh then
         IndexFieldNames := IndexFieldNames + ' DESC';
       if i < SortMarkedColumns.Count - 1 then
         IndexFieldNames := IndexFieldNames + ','
     end;
    (DataSet as TMemDataSet).IndexFieldNames := IndexFieldNames;
    end
end;

initialization
  RegisterDatasetFeaturesEh(TMemDatasetFeaturesEh, TMemDataSet);
end.
