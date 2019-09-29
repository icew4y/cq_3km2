The directory EhLib\Common contains files with objects that will allow 
the developer to SORT and FILTER data in various types of different datasets. 
TDBGridEh uses these objects to sort the data when sort markers are changed and 
to filter data when subtitle filter (STFitler) is visible.

The directory EhLib\DataService\Others contains files to sort and filter data
in third party DataSets.

If you change the grid title for sortmarking, but don't write an
OnSortMarkingChanged event, the grid will attempt to sort the 
data automatically. 

DBGridEhDataService will attempt to find the special object that can sorts 
data in the specified type of TDatsetSet using function GetDatasetFeaturesForDataSet. 
As you know, TDataSet does not support sorting data, but descendant objects 
such as TQuery or TClientDataSet allows you to do it. 

By using the procedure RegisterDatasetFeaturesEh, you can register the 
TDatasetFeaturesEhClass class that can sort data in the specified type of DataSet. 

EhLib already has classes that can sort data in TQuery, TADOQuery and 
TClientDataSet objects. Simply add one of the units EhLib... 
(EhLibBDE, EhLibADO, EhLibCDS) to the 'uses' clause of the unit containing the DBGridEh
of your project and the grid will automatically sort the data in a DataSet.
EhLib... unit have code in the initialization part of the unit that
register T...DatasetFeaturesEhClass for according to the type of the DataSet.
EX. TBDEDatasetFeaturesEh for TQuery.

For other types of datasets, you need to write and register a new object that will 
enable you to sort data in that DataSet. Writing a procedure 
T[YouDataSet]DatasetFeaturesEh.ApplySorting, you can access a list of 
columns whose sortmarkers have up/down direction using the SortMarkedColumns 
property.  See the DbUtilsEh unit to understand  how to write the
T[YouDataSet]DatasetFeaturesEh class. See the EhLibBDE unit  to 
see how to register T[YouDataSet]DatasetFeaturesEh class. 


Engine            DataSet           FileName     

BDE               TQuery            EhLibBDE.Pas
ADO               TADOQuery         EhLibADO.Pas     
ClientDataSet     TClientDataSet    EhLibCDS.Pas
DBExpress         TSQLQuery         EhLibDBX.Pas
InterBase Express TIBQuery          EhLibIBX.Pas
