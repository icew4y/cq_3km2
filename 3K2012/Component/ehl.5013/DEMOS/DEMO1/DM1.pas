unit DM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, PrnDbgeh, Db, DBTables, ImgList, MemTableEh, DataDriverEh,
  EhLibMTE, MemTableDataEh;

type
  TDataModule1 = class(TDataModule)
    Table1: TTable;
    DataSource2: TDataSource;
    Table2: TTable;
    DataSource3: TDataSource;
    ImageList2: TImageList;
    ilArrows: TImageList;
    ImageList1: TImageList;
    Query1: TQuery;
    Query1VNo: TFloatField;
    Query1VName: TStringField;
    Query1PNo: TFloatField;
    Query1PDescription: TStringField;
    Query1PCost: TCurrencyField;
    Query1IQty: TIntegerField;
    Query1VName1: TStringField;
    Query1VPreferred: TBooleanField;
    DataSource1: TDataSource;
    qrVendors: TQuery;
    qrVendorsVendorNo: TFloatField;
    qrVendorsVendorName: TStringField;
    qrVendorsAddress1: TStringField;
    qrVendorsAddress2: TStringField;
    qrVendorsCity: TStringField;
    qrVendorsState: TStringField;
    qrVendorsZip: TStringField;
    qrVendorsCountry: TStringField;
    qrVendorsPhone: TStringField;
    qrVendorsFAX: TStringField;
    qrVendorsPreferred: TBooleanField;
    dsVendors: TDataSource;
    tCustomer: TTable;
    dstCustomer: TDataSource;
    tEmployee: TTable;
    tEmployeeEmpNo: TIntegerField;
    tEmployeeLastName: TStringField;
    tEmployeeFirstName: TStringField;
    tEmployeePhoneExt: TStringField;
    tEmployeeHireDate: TDateTimeField;
    tEmployeeSalary: TFloatField;
    tEmployeeSalaryType: TIntegerField;
    qCustomer: TQuery;
    qCustomer2: TQuery;
    dsCustomer2: TDataSource;
    dsCustomer: TDataSource;
    dsEmployee: TDataSource;
    dsPartsDescriprion: TDataSource;
    qrPartsDescriprion: TQuery;
    ilYesNo: TImageList;
    mtQuery1: TMemTableEh;
    mtTable1: TMemTableEh;
    mtTable2: TMemTableEh;
    mttEmployee: TMemTableEh;
    mtqCustomer: TMemTableEh;
    mtqCustomer2: TMemTableEh;
    dsdTable1: TDataSetDriverEh;
    dsdTable2: TDataSetDriverEh;
    dsdtEmployee: TDataSetDriverEh;
    dsdqCustomer: TDataSetDriverEh;
    dsdqCustomer2: TDataSetDriverEh;
    dsdQuery1: TDataSetDriverEh;
    mtQuery1VNo: TFloatField;
    mtQuery1VName: TStringField;
    mtQuery1PNo: TFloatField;
    mtQuery1PDescription: TStringField;
    mtQuery1PCost: TCurrencyField;
    mtQuery1IQty: TIntegerField;
    mtQuery1VPreferred: TBooleanField;
    mtQuery1VName1: TStringField;
    tFish: TTable;
    mtFish: TMemTableEh;
    mtFishSpeciesNo: TFloatField;
    mtFishCategory: TStringField;
    mtFishCommon_Name: TStringField;
    mtFishSpeciesName: TStringField;
    mtFishLengthcm: TFloatField;
    mtFishLength_In: TFloatField;
    mtFishNotes: TMemoField;
    mtFishGraphic: TGraphicField;
    ddFish: TDataSetDriverEh;
    dsFish: TDataSource;
    ilPaymentType: TImageList;
    mttEmployeeEmpNo: TIntegerField;
    mttEmployeeLastName: TStringField;
    mttEmployeeFirstName: TStringField;
    mttEmployeePhoneExt: TStringField;
    mttEmployeeHireDate: TDateTimeField;
    mttEmployeeSalary: TFloatField;
    mttEmployeeSalaryType: TIntegerField;
    dsCustomersRDP: TDataSource;
    tCustomersRDP: TTable;
    ddrCustomersRDP: TDataSetDriverEh;
    mtCustomersRDP: TMemTableEh;
    mtOrdersRDP: TMemTableEh;
    ddOrdersRDP: TDataSetDriverEh;
    tOrdersRDP: TTable;
    dsOrdersRDP: TDataSource;
    mtTreeView: TMemTableEh;
    mtTreeViewExpCount: TAggregateField;
    dsTreeView: TDataSource;
    procedure tEmployeeCalcFields(DataSet: TDataSet);
    procedure Query1UpdateRecord(DataSet: TDataSet;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure qCustomerUpdateRecord(DataSet: TDataSet;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure qCustomer2UpdateRecord(DataSet: TDataSet;
      UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
    procedure mttEmployeeCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.DFM}

procedure TDataModule1.tEmployeeCalcFields(DataSet: TDataSet);
begin
  if (tEmployeeSalary.AsFloat < 15000) then
    tEmployeeSalaryType.AsFloat := 5
  else if (tEmployeeSalary.AsFloat < 20000) then
    tEmployeeSalaryType.AsFloat := 4
  else if (tEmployeeSalary.AsFloat < 25000) then
    tEmployeeSalaryType.AsFloat := 3
  else if (tEmployeeSalary.AsFloat < 30000) then
    tEmployeeSalaryType.AsFloat := 2
  else if (tEmployeeSalary.AsFloat < 50000) then
    tEmployeeSalaryType.AsFloat := 1
  else
    tEmployeeSalaryType.AsFloat := 0;
end;

procedure TDataModule1.mttEmployeeCalcFields(DataSet: TDataSet);
begin
  if (mttEmployee.FieldByName('Salary').AsFloat < 15000) then
    mttEmployee.FieldByName('SalaryType').AsFloat := 5
  else if (mttEmployee.FieldByName('Salary').AsFloat < 20000) then
    mttEmployee.FieldByName('SalaryType').AsFloat := 4
  else if (mttEmployee.FieldByName('Salary').AsFloat < 25000) then
    mttEmployee.FieldByName('SalaryType').AsFloat := 3
  else if (mttEmployee.FieldByName('Salary').AsFloat < 30000) then
    mttEmployee.FieldByName('SalaryType').AsFloat := 2
  else if (mttEmployee.FieldByName('Salary').AsFloat < 50000) then
    mttEmployee.FieldByName('SalaryType').AsFloat := 1
  else
    mttEmployee.FieldByName('SalaryType').AsFloat := 0;
end;

procedure TDataModule1.Query1UpdateRecord(DataSet: TDataSet;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
begin
  //
end;

procedure TDataModule1.qCustomerUpdateRecord(DataSet: TDataSet;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
begin
//
end;

procedure TDataModule1.qCustomer2UpdateRecord(DataSet: TDataSet;
  UpdateKind: TUpdateKind; var UpdateAction: TUpdateAction);
begin
//
end;

end.
