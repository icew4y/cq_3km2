// CodeGear C++ Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Memtabledataeh.pas' rev: 11.00

#ifndef MemtabledataehHPP
#define MemtabledataehHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Ehlibvcl.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Maskutils.hpp>	// Pascal unit
#include <Sqltimst.hpp>	// Pascal unit
#include <Fmtbcd.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit
#include <Dbcommon.hpp>	// Pascal unit
#include <Memtreeeh.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Memtabledataeh
{
//-- type declarations -------------------------------------------------------
typedef DynamicArray<int >  TIntArray;

class DELPHICLASS TAutoIncrementEh;
class PASCALIMPLEMENTATION TAutoIncrementEh : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	int FStep;
	int FInitValue;
	void __fastcall SetInitValue(const int Value);
	
protected:
	int FCurValue;
	
public:
	__fastcall TAutoIncrementEh(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property int CurValue = {read=FCurValue, nodefault};
	int __fastcall Promote(void);
	void __fastcall Reset(void);
	
__published:
	__property int InitValue = {read=FInitValue, write=SetInitValue, default=-1};
	__property int Step = {read=FStep, write=FStep, default=-1};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TAutoIncrementEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TUpdateErrorEh;
class PASCALIMPLEMENTATION TUpdateErrorEh : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Sysutils::Exception* FException;
	
public:
	__fastcall TUpdateErrorEh(Sysutils::Exception* AException);
	__fastcall virtual ~TUpdateErrorEh(void);
	__property Sysutils::Exception* ExceptionObject = {read=FException};
};


#pragma option push -b-
enum TDataSetExprParserTypeEh { dsptFilterEh, dsptAggregateEh };
#pragma option pop

class DELPHICLASS TDataSetExprParserEh;
class DELPHICLASS TMemoryRecordEh;
class DELPHICLASS TRecordsViewEh;
class PASCALIMPLEMENTATION TDataSetExprParserEh : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Db::TDataSet* FDataSet;
	DynamicArray<Byte >  FExprData;
	int FExprDataSize;
	TDataSetExprParserTypeEh FExprParserType;
	
public:
	__fastcall TDataSetExprParserEh(Db::TDataSet* ADataSet, TDataSetExprParserTypeEh ExprParserType);
	void __fastcall ParseExpression(AnsiString Expr);
	bool __fastcall IsCurRecordInFilter(TMemoryRecordEh* Rec);
	Variant __fastcall CalcAggregateValue(TRecordsViewEh* RecordsView);
	bool __fastcall HasData(void);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TDataSetExprParserEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TMTDataFieldEh;
class DELPHICLASS TMTDataStructEh;
class DELPHICLASS TMemTableDataEh;
class DELPHICLASS TRecordsListEh;
class DELPHICLASS TMTIndexesEh;
class DELPHICLASS TMTIndexEh;
#pragma option push -b-
enum TRecordsListNotification { rlnRecAddingEh, rlnRecAddedEh, rlnRecChangingEh, rlnRecChangedEh, rlnRecDeletingEh, rlnRecDeletedEh, rlnListChangingEh, rlnListChangedEh, rlnRecMarkingForDelEh, rlnRecMarkedForDelEh };
#pragma option pop

class PASCALIMPLEMENTATION TMTIndexesEh : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
private:
	TRecordsListEh* FRecList;
	HIDESBASE TMTIndexEh* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TMTIndexEh* Value);
	
protected:
	virtual void __fastcall RecordMoved(TMemoryRecordEh* Item, int OldIndex, int NewIndex);
	void __fastcall RLDataEvent(TMemoryRecordEh* MemRec, int Index, TRecordsListNotification Action);
	
public:
	__fastcall TMTIndexesEh(TRecordsListEh* ARecList);
	__fastcall virtual ~TMTIndexesEh(void);
	HIDESBASE TMTIndexEh* __fastcall Add(void);
	TMTIndexEh* __fastcall GetIndexForFields(AnsiString Fields);
	__property TMTIndexEh* Items[int Index] = {read=GetItem, write=SetItem};
};


typedef TMetaClass* TMemoryRecordEhClass;

typedef DynamicArray<Variant >  TRecDataValues;

typedef int __fastcall (__closure *TCompareRecords)(TMemoryRecordEh* Rec1, TMemoryRecordEh* Rec2, System::TObject* ParamSort);

class PASCALIMPLEMENTATION TRecordsListEh : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
public:
	TMemoryRecordEh* operator[](int Index) { return Rec[Index]; }
	
private:
	bool FCachedUpdates;
	Contnrs::TObjectList* FDeletedList;
	Contnrs::TObjectList* FDeltaList;
	TMTIndexesEh* FIndexes;
	TMetaClass* FItemClass;
	TMemTableDataEh* FMemTableData;
	unsigned FNewHashCode;
	Contnrs::TObjectList* FRecList;
	int FUpdateCount;
	int __fastcall GeRecValCount(void);
	int __fastcall GetCount(void);
	TMTDataStructEh* __fastcall GetDataStruct(void);
	TMemoryRecordEh* __fastcall GetRec(int Index);
	Variant __fastcall GetValue(int RecNo, int ValNo);
	bool __fastcall IsEmpty(void);
	void __fastcall ReadData(Classes::TReader* Reader);
	void __fastcall SetCachedUpdates(const bool Value);
	void __fastcall SetRec(int Index, const TMemoryRecordEh* Value);
	void __fastcall SetValue(int RecNo, int ValNo, const Variant &Value);
	void __fastcall WriteData(Classes::TWriter* Writer);
	
protected:
	int __fastcall AddInsertRecord(TMemoryRecordEh* Rec, int Index, bool Append, bool Fetching);
	TMemoryRecordEh* __fastcall Delete(int Index);
	unsigned __fastcall NewHashCode(void);
	void __fastcall ApplyUpdateFor(TMemoryRecordEh* Rec, Db::TUpdateStatus UpdateStatus);
	void __fastcall ApplyUpdates(TMemTableDataEh* AMemTableData);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	void __fastcall InitRecord(TRecDataValues RecValues);
	virtual void __fastcall Notify(TMemoryRecordEh* MemRec, int Index, TRecordsListNotification Action);
	virtual void __fastcall RecordMoved(TMemoryRecordEh* Item, int OldIndex, int NewIndex);
	void __fastcall ReIndexRecs(int FromIndex, int ToIndex);
	void __fastcall CheckForDestroyRecord(TMemoryRecordEh* Rec);
	void __fastcall FreeDeletedRecords(void);
	
public:
	__fastcall TRecordsListEh(TMemTableDataEh* AMemTableData);
	__fastcall virtual ~TRecordsListEh(void);
	int __fastcall AddRecord(TMemoryRecordEh* Rec);
	int __fastcall FetchRecord(TMemoryRecordEh* Rec);
	bool __fastcall HasCachedChanges(void);
	int __fastcall IndexOf(TMemoryRecordEh* Item);
	TMemoryRecordEh* __fastcall NewRecord(void);
	virtual void __fastcall BeginUpdate(void);
	void __fastcall CancelUpdates(void);
	void __fastcall CleanupChangedRecs(void);
	void __fastcall Clear(void);
	void __fastcall DeleteRecord(int Index);
	virtual void __fastcall EndUpdate(void);
	void __fastcall InsertRecord(int Index, TMemoryRecordEh* Rec);
	void __fastcall MergeChangeLog(void);
	void __fastcall Move(int CurIndex, int NewIndex);
	void __fastcall PersistDeleteRecord(int Index);
	void __fastcall PersistRemoveRecord(int Index);
	void __fastcall QuickSort(int L, int R, TCompareRecords Compare, System::TObject* ParamSort);
	void __fastcall RefreshRecord(int Index, TMemoryRecordEh* FromRec);
	void __fastcall RevertRecord(int Index);
	void __fastcall SetAutoIncValue(TMemoryRecordEh* Rec);
	void __fastcall SortData(TCompareRecords Compare, System::TObject* ParamSort);
	__property bool CachedUpdates = {read=FCachedUpdates, write=SetCachedUpdates, nodefault};
	__property int Count = {read=GetCount, nodefault};
	__property TMTDataStructEh* DataStruct = {read=GetDataStruct};
	__property Contnrs::TObjectList* DeltaList = {read=FDeltaList};
	__property TMTIndexesEh* Indexes = {read=FIndexes};
	__property TMemTableDataEh* MemTableData = {read=FMemTableData};
	__property TMemoryRecordEh* Rec[int Index] = {read=GetRec, write=SetRec/*, default*/};
	__property int RecValCount = {read=GeRecValCount, nodefault};
	__property Variant Value[int RecNo][int ValNo] = {read=GetValue, write=SetValue};
};


class DELPHICLASS TRecordsListNotificatorEh;
class PASCALIMPLEMENTATION TMemTableDataEh : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TAutoIncrementEh* FAutoIncrement;
	TMTDataStructEh* FDataStruct;
	DynamicArray<int >  FIncFieldIndexes;
	TMTDataStructEh* FNewDataStruct;
	Contnrs::TObjectList* FNotificators;
	TRecordsListEh* FRecordsList;
	bool FRestructMode;
	bool __fastcall GetIsEmpty(void);
	void __fastcall AncestorNotFound(Classes::TReader* Reader, const AnsiString ComponentName, TMetaClass* ComponentClass, Classes::TComponent* &Component);
	void __fastcall CreateComponent(Classes::TReader* Reader, TMetaClass* ComponentClass, Classes::TComponent* &Component);
	void __fastcall ReadAutoIncCurValue(Classes::TReader* Reader);
	void __fastcall WriteAutoIncCurValue(Classes::TWriter* Writer);
	
protected:
	virtual TAutoIncrementEh* __fastcall GetAutoIncrement(void);
	virtual TMTDataStructEh* __fastcall GetDataStruct(void);
	virtual TRecordsListEh* __fastcall GetRecordsList(void);
	virtual void __fastcall AddNotificator(TRecordsListNotificatorEh* RecordsList);
	virtual void __fastcall ApplyUpdates(TMemTableDataEh* AMemTableData);
	virtual void __fastcall CheckInactive(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	virtual void __fastcall Notify(TMemoryRecordEh* MemRec, int Index, TRecordsListNotification Action);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual void __fastcall RecordMoved(TMemoryRecordEh* Item, int OldIndex, int NewIndex);
	void __fastcall RemoveNotificator(TRecordsListNotificatorEh* RecordsList);
	void __fastcall Restruct(void);
	virtual void __fastcall SetAutoIncrement(const TAutoIncrementEh* Value);
	virtual void __fastcall SetAutoIncValue(TMemoryRecordEh* Rec);
	virtual void __fastcall StructChanged(void);
	
public:
	__fastcall virtual TMemTableDataEh(Classes::TComponent* AOwner);
	__fastcall virtual ~TMemTableDataEh(void);
	virtual TMTDataStructEh* __fastcall BeginRestruct(void);
	virtual int __fastcall FetchRecords(int Count);
	virtual void __fastcall CancelRestruct(void);
	virtual void __fastcall CommitRestruct(void);
	virtual void __fastcall DestroyTable(void);
	__property TAutoIncrementEh* AutoIncrement = {read=GetAutoIncrement, write=SetAutoIncrement};
	__property TMTDataStructEh* DataStruct = {read=GetDataStruct};
	__property bool IsEmpty = {read=GetIsEmpty, nodefault};
	__property TRecordsListEh* RecordsList = {read=GetRecordsList};
};


typedef TMetaClass* TMTDataFieldClassEh;

class PASCALIMPLEMENTATION TMTDataStructEh : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
public:
	TMTDataFieldEh* operator[](int Index) { return DataFields[Index]; }
	
private:
	Contnrs::TObjectList* FList;
	TMemTableDataEh* FMemTableData;
	__int64 FNextFieldId;
	int __fastcall GetCount(void);
	TMTDataFieldEh* __fastcall GetDataField(int Index);
	
protected:
	DYNAMIC Classes::TComponent* __fastcall GetChildOwner(void);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	
public:
	__fastcall TMTDataStructEh(TMemTableDataEh* AMemTableData);
	__fastcall virtual ~TMTDataStructEh(void);
	TMTDataFieldEh* __fastcall CreateField(TMetaClass* FieldClass);
	TMTDataFieldEh* __fastcall FieldByName(const AnsiString FieldName);
	int __fastcall FieldIndex(const AnsiString FieldName);
	TIntArray __fastcall FieldsIndex(const AnsiString FieldNames);
	TMTDataFieldEh* __fastcall FindField(const AnsiString FieldName);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall BuildFieldDefsFromStruct(Db::TFieldDefs* FieldDefs);
	void __fastcall BuildStructFromFieldDefs(Db::TFieldDefs* FieldDefs);
	void __fastcall BuildStructFromFields(Db::TFields* Fields);
	void __fastcall CheckFieldName(const AnsiString FieldName);
	void __fastcall Clear(void);
	void __fastcall GetFieldList(Contnrs::TObjectList* List, const AnsiString FieldNames);
	void __fastcall InsertField(TMTDataFieldEh* Field);
	void __fastcall RemoveField(TMTDataFieldEh* Field);
	__property int Count = {read=GetCount, nodefault};
	__property TMTDataFieldEh* DataFields[int Index] = {read=GetDataField/*, default*/};
	__property TMemTableDataEh* MemTableData = {read=FMemTableData};
};


class PASCALIMPLEMENTATION TMTDataFieldEh : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Classes::TAlignment FAlignment;
	bool FAutoIncrement;
	TMTDataStructEh* FDataStruct;
	AnsiString FDefaultExpression;
	AnsiString FDisplayLabel;
	int FDisplayWidth;
	AnsiString FEditMask;
	__int64 FFieldId;
	AnsiString FFieldName;
	bool FReadOnly;
	bool FRequired;
	int FSize;
	bool FVisible;
	void __fastcall SetDataStruct(const TMTDataStructEh* Value);
	int __fastcall GetIndex(void);
	
protected:
	virtual int __fastcall DefaultSize(void);
	virtual Classes::TAlignment __fastcall DefaultAlignment(void);
	virtual AnsiString __fastcall DefValueForDefaultExpression();
	virtual AnsiString __fastcall DefaultDisplayLabel();
	virtual int __fastcall DefaultDisplayWidth(void);
	virtual AnsiString __fastcall DefaultEditMask();
	virtual bool __fastcall DefaultRequired(void);
	virtual bool __fastcall DefaultVisible(void);
	virtual Classes::TAlignment __fastcall GetAlignment(void);
	virtual bool __fastcall GetAutoIncrement(void);
	virtual Db::TFieldType __fastcall GetDataType(void);
	virtual AnsiString __fastcall GetDefaultExpression();
	virtual AnsiString __fastcall GetDisplayLabel();
	virtual int __fastcall GetDisplayWidth(void);
	virtual AnsiString __fastcall GetEditMask();
	virtual AnsiString __fastcall GetFieldName();
	virtual bool __fastcall GetReadOnly(void);
	virtual bool __fastcall GetRequired(void);
	virtual int __fastcall GetSize(void);
	virtual bool __fastcall GetVisible(void);
	AnsiString __fastcall CreateUniqueName(const AnsiString FieldName);
	virtual void __fastcall SetAlignment(const Classes::TAlignment Value);
	virtual void __fastcall SetAutoIncrement(const bool Value);
	virtual void __fastcall SetDefaultExpression(const AnsiString Value);
	virtual void __fastcall SetDisplayLabel(const AnsiString Value);
	virtual void __fastcall SetDisplayWidth(const int Value);
	virtual void __fastcall SetEditMask(const AnsiString Value);
	virtual void __fastcall SetFieldName(const AnsiString Value);
	virtual void __fastcall SetReadOnly(const bool Value);
	virtual void __fastcall SetRequired(const bool Value);
	virtual void __fastcall SetSize(const int Value);
	virtual void __fastcall SetVisible(const bool Value);
	void __fastcall CheckInactive(void);
	DYNAMIC void __fastcall SetParentComponent(Classes::TComponent* AParent);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	
public:
	__fastcall virtual TMTDataFieldEh(Classes::TComponent* AOwner);
	__fastcall virtual ~TMTDataFieldEh(void);
	DYNAMIC Classes::TComponent* __fastcall GetParentComponent(void);
	DYNAMIC bool __fastcall HasParent(void);
	virtual bool __fastcall CanDinaSize(void);
	virtual Word __fastcall GetVarDataType(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall AssignDataType(Db::TFieldType FieldType);
	virtual void __fastcall AssignProps(Db::TField* Field);
	__property TMTDataStructEh* DataStruct = {read=FDataStruct, write=SetDataStruct};
	__property Db::TFieldType DataType = {read=GetDataType, nodefault};
	__property int Size = {read=GetSize, write=SetSize, nodefault};
	__property bool AutoIncrement = {read=GetAutoIncrement, write=SetAutoIncrement, nodefault};
	__property Classes::TAlignment Alignment = {read=GetAlignment, write=SetAlignment, nodefault};
	__property AnsiString DefaultExpression = {read=GetDefaultExpression, write=SetDefaultExpression};
	__property AnsiString DisplayLabel = {read=GetDisplayLabel, write=SetDisplayLabel};
	__property int DisplayWidth = {read=GetDisplayWidth, write=SetDisplayWidth, nodefault};
	__property AnsiString EditMask = {read=GetEditMask, write=SetEditMask};
	__property bool Required = {read=GetRequired, write=SetRequired, nodefault};
	__property bool Visible = {read=GetVisible, write=SetVisible, nodefault};
	__property int Index = {read=GetIndex, nodefault};
	
__published:
	__property AnsiString FieldName = {read=GetFieldName, write=SetFieldName};
};


#pragma option push -b-
enum TStringDataFieldTypesEh { fdtStringEh, fdtFixedCharEh, fdtWideStringEh, fdtGuidEh, fdtFixedWideCharEh, fdtOraIntervalEh };
#pragma option pop

class DELPHICLASS TMTStringDataFieldEh;
class PASCALIMPLEMENTATION TMTStringDataFieldEh : public TMTDataFieldEh 
{
	typedef TMTDataFieldEh inherited;
	
private:
	bool FFixedChar;
	bool FTransliterate;
	TStringDataFieldTypesEh FStringDataType;
	
protected:
	virtual int __fastcall DefaultSize(void);
	virtual Db::TFieldType __fastcall GetDataType(void);
	
public:
	virtual bool __fastcall CanDinaSize(void);
	virtual void __fastcall AssignProps(Db::TField* Field);
	virtual void __fastcall AssignDataType(Db::TFieldType FieldType);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TStringDataFieldTypesEh StringDataType = {read=FStringDataType, write=FStringDataType, nodefault};
	__property Alignment ;
	__property DefaultExpression ;
	__property DisplayLabel ;
	__property DisplayWidth ;
	__property EditMask ;
	__property Required ;
	__property Visible ;
	__property bool FixedChar = {read=FFixedChar, write=FFixedChar, default=0};
	__property Size ;
	__property bool Transliterate = {read=FTransliterate, write=FTransliterate, default=1};
public:
	#pragma option push -w-inl
	/* TMTDataFieldEh.Create */ inline __fastcall virtual TMTStringDataFieldEh(Classes::TComponent* AOwner) : TMTDataFieldEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TMTDataFieldEh.Destroy */ inline __fastcall virtual ~TMTStringDataFieldEh(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TNumericDataFieldTypesEh { fdtSmallintEh, fdtIntegerEh, fdtWordEh, fdtFloatEh, fdtCurrencyEh, fdtBCDEh, fdtAutoIncEh, fdtLargeintEh, fdtFMTBcdEh };
#pragma option pop

class DELPHICLASS TMTNumericDataFieldEh;
class PASCALIMPLEMENTATION TMTNumericDataFieldEh : public TMTDataFieldEh 
{
	typedef TMTDataFieldEh inherited;
	
private:
	AnsiString FDisplayFormat;
	AnsiString FEditFormat;
	bool FCurrency;
	double FMaxValue;
	double FMinValue;
	int FPrecision;
	TNumericDataFieldTypesEh FNumericDataType;
	
protected:
	virtual Db::TFieldType __fastcall GetDataType(void);
	
public:
	virtual void __fastcall AssignProps(Db::TField* Field);
	virtual void __fastcall AssignDataType(Db::TFieldType FieldType);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TNumericDataFieldTypesEh NumericDataType = {read=FNumericDataType, write=FNumericDataType, nodefault};
	__property Alignment ;
	__property DefaultExpression ;
	__property DisplayLabel ;
	__property DisplayWidth ;
	__property EditMask ;
	__property Required ;
	__property Visible ;
	__property AnsiString DisplayFormat = {read=FDisplayFormat, write=FDisplayFormat};
	__property AnsiString EditFormat = {read=FEditFormat, write=FEditFormat};
	__property bool currency = {read=FCurrency, write=FCurrency, nodefault};
	__property double MaxValue = {read=FMaxValue, write=FMaxValue};
	__property double MinValue = {read=FMinValue, write=FMinValue};
	__property int Precision = {read=FPrecision, write=FPrecision, nodefault};
public:
	#pragma option push -w-inl
	/* TMTDataFieldEh.Create */ inline __fastcall virtual TMTNumericDataFieldEh(Classes::TComponent* AOwner) : TMTDataFieldEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TMTDataFieldEh.Destroy */ inline __fastcall virtual ~TMTNumericDataFieldEh(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TDateTimeDataFieldTypesEh { fdtDateEh, fdtTimeEh, fdtDateTimeEh };
#pragma option pop

class DELPHICLASS TMTDateTimeDataFieldEh;
class PASCALIMPLEMENTATION TMTDateTimeDataFieldEh : public TMTDataFieldEh 
{
	typedef TMTDataFieldEh inherited;
	
private:
	AnsiString FDisplayFormat;
	TDateTimeDataFieldTypesEh FDateTimeDataType;
	
protected:
	virtual Db::TFieldType __fastcall GetDataType(void);
	
public:
	virtual void __fastcall AssignProps(Db::TField* Field);
	virtual void __fastcall AssignDataType(Db::TFieldType FieldType);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TDateTimeDataFieldTypesEh DateTimeDataType = {read=FDateTimeDataType, write=FDateTimeDataType, nodefault};
	__property Alignment ;
	__property DefaultExpression ;
	__property DisplayLabel ;
	__property DisplayWidth ;
	__property EditMask ;
	__property Required ;
	__property Visible ;
	__property AnsiString DisplayFormat = {read=FDisplayFormat, write=FDisplayFormat};
public:
	#pragma option push -w-inl
	/* TMTDataFieldEh.Create */ inline __fastcall virtual TMTDateTimeDataFieldEh(Classes::TComponent* AOwner) : TMTDataFieldEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TMTDataFieldEh.Destroy */ inline __fastcall virtual ~TMTDateTimeDataFieldEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TMTBlobDataFieldEh;
class PASCALIMPLEMENTATION TMTBlobDataFieldEh : public TMTDataFieldEh 
{
	typedef TMTDataFieldEh inherited;
	
private:
	bool FGraphicHeader;
	bool FTransliterate;
	Db::TFieldType FBlobType;
	
protected:
	virtual Db::TFieldType __fastcall GetDataType(void);
	
public:
	virtual void __fastcall AssignProps(Db::TField* Field);
	virtual void __fastcall AssignDataType(Db::TFieldType FieldType);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Alignment ;
	__property DefaultExpression ;
	__property DisplayLabel ;
	__property DisplayWidth ;
	__property EditMask ;
	__property Required ;
	__property Visible ;
	__property Db::TBlobType BlobType = {read=FBlobType, write=FBlobType, nodefault};
	__property bool GraphicHeader = {read=FGraphicHeader, write=FGraphicHeader, nodefault};
	__property bool Transliterate = {read=FTransliterate, write=FTransliterate, nodefault};
public:
	#pragma option push -w-inl
	/* TMTDataFieldEh.Create */ inline __fastcall virtual TMTBlobDataFieldEh(Classes::TComponent* AOwner) : TMTDataFieldEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TMTDataFieldEh.Destroy */ inline __fastcall virtual ~TMTBlobDataFieldEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TMTBooleanDataFieldEh;
class PASCALIMPLEMENTATION TMTBooleanDataFieldEh : public TMTDataFieldEh 
{
	typedef TMTDataFieldEh inherited;
	
private:
	AnsiString FDisplayValues;
	void __fastcall SetDisplayValues(const AnsiString Value);
	
protected:
	virtual Db::TFieldType __fastcall GetDataType(void);
	
public:
	virtual void __fastcall AssignProps(Db::TField* Field);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall AssignDataType(Db::TFieldType FieldType);
	
__published:
	__property Alignment ;
	__property DefaultExpression ;
	__property DisplayLabel ;
	__property DisplayWidth ;
	__property EditMask ;
	__property Required ;
	__property Visible ;
	__property AnsiString DisplayValues = {read=FDisplayValues, write=SetDisplayValues};
public:
	#pragma option push -w-inl
	/* TMTDataFieldEh.Create */ inline __fastcall virtual TMTBooleanDataFieldEh(Classes::TComponent* AOwner) : TMTDataFieldEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TMTDataFieldEh.Destroy */ inline __fastcall virtual ~TMTBooleanDataFieldEh(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TInterfaceDataFieldTypesEh { fdtInterfaceEh, fdtIDispatchEh };
#pragma option pop

class DELPHICLASS TMTInterfaceDataFieldEh;
class PASCALIMPLEMENTATION TMTInterfaceDataFieldEh : public TMTDataFieldEh 
{
	typedef TMTDataFieldEh inherited;
	
private:
	TInterfaceDataFieldTypesEh FInterfaceDataType;
	
protected:
	virtual Db::TFieldType __fastcall GetDataType(void);
	
public:
	virtual void __fastcall AssignDataType(Db::TFieldType FieldType);
	
__published:
	__property Alignment ;
	__property DefaultExpression ;
	__property DisplayLabel ;
	__property DisplayWidth ;
	__property TInterfaceDataFieldTypesEh InterfaceDataType = {read=FInterfaceDataType, write=FInterfaceDataType, nodefault};
	__property Required ;
	__property Visible ;
public:
	#pragma option push -w-inl
	/* TMTDataFieldEh.Create */ inline __fastcall virtual TMTInterfaceDataFieldEh(Classes::TComponent* AOwner) : TMTDataFieldEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TMTDataFieldEh.Destroy */ inline __fastcall virtual ~TMTInterfaceDataFieldEh(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TVariantDataFieldTypesEh { fdtVariant, fdtBytes, fdtVarBytes };
#pragma option pop

class DELPHICLASS TMTVariantDataFieldEh;
class PASCALIMPLEMENTATION TMTVariantDataFieldEh : public TMTDataFieldEh 
{
	typedef TMTDataFieldEh inherited;
	
private:
	TVariantDataFieldTypesEh FVariantDataType;
	
protected:
	virtual Db::TFieldType __fastcall GetDataType(void);
	
public:
	virtual bool __fastcall CanDinaSize(void);
	virtual void __fastcall AssignDataType(Db::TFieldType FieldType);
	
__published:
	__property Alignment ;
	__property DefaultExpression ;
	__property DisplayLabel ;
	__property DisplayWidth ;
	__property TVariantDataFieldTypesEh VariantDataType = {read=FVariantDataType, write=FVariantDataType, nodefault};
	__property Required ;
	__property Visible ;
public:
	#pragma option push -w-inl
	/* TMTDataFieldEh.Create */ inline __fastcall virtual TMTVariantDataFieldEh(Classes::TComponent* AOwner) : TMTDataFieldEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TMTDataFieldEh.Destroy */ inline __fastcall virtual ~TMTVariantDataFieldEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TMTRefObjectFieldEh;
class PASCALIMPLEMENTATION TMTRefObjectFieldEh : public TMTDataFieldEh 
{
	typedef TMTDataFieldEh inherited;
	
protected:
	virtual Db::TFieldType __fastcall GetDataType(void);
	
public:
	virtual bool __fastcall CanDinaSize(void);
	virtual void __fastcall AssignDataType(Db::TFieldType FieldType);
	
__published:
	__property Alignment ;
	__property DisplayLabel ;
	__property DisplayWidth ;
	__property Required ;
	__property Visible ;
public:
	#pragma option push -w-inl
	/* TMTDataFieldEh.Create */ inline __fastcall virtual TMTRefObjectFieldEh(Classes::TComponent* AOwner) : TMTDataFieldEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TMTDataFieldEh.Destroy */ inline __fastcall virtual ~TMTRefObjectFieldEh(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TSQLTimeStampDataFieldTypesEh { fdtTimeStampEh, fdtOraTimeStampEh };
#pragma option pop

class DELPHICLASS TMTSQLTimeStampDataFieldEh;
class PASCALIMPLEMENTATION TMTSQLTimeStampDataFieldEh : public TMTDataFieldEh 
{
	typedef TMTDataFieldEh inherited;
	
private:
	AnsiString FDisplayFormat;
	TSQLTimeStampDataFieldTypesEh FSQLTimeStampDataFieldType;
	
protected:
	virtual Db::TFieldType __fastcall GetDataType(void);
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall AssignDataType(Db::TFieldType FieldType);
	virtual void __fastcall AssignProps(Db::TField* Field);
	
__published:
	__property TSQLTimeStampDataFieldTypesEh SQLTimeStampDataFieldType = {read=FSQLTimeStampDataFieldType, write=FSQLTimeStampDataFieldType, nodefault};
	__property Alignment ;
	__property DefaultExpression ;
	__property DisplayLabel ;
	__property DisplayWidth ;
	__property EditMask ;
	__property Required ;
	__property Visible ;
	__property AnsiString DisplayFormat = {read=FDisplayFormat, write=FDisplayFormat};
public:
	#pragma option push -w-inl
	/* TMTDataFieldEh.Create */ inline __fastcall virtual TMTSQLTimeStampDataFieldEh(Classes::TComponent* AOwner) : TMTDataFieldEh(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TMTDataFieldEh.Destroy */ inline __fastcall virtual ~TMTSQLTimeStampDataFieldEh(void) { }
	#pragma option pop
	
};


typedef TRecDataValues *PRecValues;

typedef Variant TMemBlobData;

typedef void __fastcall (__closure *TRecordsListNotificatorDataEventEh)(TMemoryRecordEh* MemRec, int Index, TRecordsListNotification Action);

#pragma option push -b-
enum TDataValueVersionEh { dvvOldValueEh, dvvCurValueEh, dvvEditValueEh, dvvValueEh, dvvOldestValue, dvvRefreshValue };
#pragma option pop

#pragma option push -b-
enum TRecordEditStateEh { resBrowseEh, resEditEh, resInsertEh };
#pragma option pop

class PASCALIMPLEMENTATION TMemoryRecordEh : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	DynamicArray<Variant >  FData;
	bool FEditChanged;
	TRecordEditStateEh FEditState;
	unsigned FHashCode;
	int FIndex;
	DynamicArray<Variant >  FOldData;
	TRecordsListEh* FRecordsList;
	DynamicArray<Variant >  FTmpOldRecValue;
	TUpdateErrorEh* FUpdateError;
	int FUpdateIndex;
	Db::TUpdateStatus FUpdateStatus;
	bool __fastcall GetAttached(void);
	Variant __fastcall GetDataIndexValues(const TIntArray FieldIndexes, TDataValueVersionEh DataValueVersion);
	TMTDataStructEh* __fastcall GetDataStruct(void);
	Variant __fastcall GetDataValue(const int FieldIndex, TDataValueVersionEh DataValueVersion);
	Variant __fastcall GetDataValues(const AnsiString FieldNames, TDataValueVersionEh DataValueVersion);
	int __fastcall GetIndex(void);
	void __fastcall SetDataIndexValues(const TIntArray FieldIndexes, TDataValueVersionEh DataValueVersion, const Variant &VarValue);
	void __fastcall SetDataValue(const int FieldIndex, TDataValueVersionEh DataValueVersion, const Variant &Value);
	void __fastcall SetDataValues(const AnsiString FieldNames, TDataValueVersionEh DataValueVersion, const Variant &VarValue);
	void __fastcall SetUpdateStatus(const Db::TUpdateStatus Value);
	
protected:
	void __fastcall ReadData(Classes::TReader* Reader);
	void __fastcall SetIndex(int Value);
	void __fastcall WriteData(Classes::TWriter* Writer);
	__property TRecDataValues Data = {read=FData};
	
public:
	__fastcall TMemoryRecordEh(void);
	__fastcall virtual ~TMemoryRecordEh(void);
	TRecordEditStateEh __fastcall EditState(void);
	void __fastcall Cancel(void);
	void __fastcall Edit(void);
	void __fastcall MergeChanges(void);
	void __fastcall Post(void);
	void __fastcall RefreshRecord(TMemoryRecordEh* Rec);
	void __fastcall RevertRecord(void);
	__property int Index = {read=GetIndex, nodefault};
	__property bool Attached = {read=GetAttached, nodefault};
	__property Variant DataValues[AnsiString FieldNames][TDataValueVersionEh DataValueVersion] = {read=GetDataValues, write=SetDataValues};
	__property Variant DataIndexValues[TIntArray FieldIndexes][TDataValueVersionEh DataValueVersion] = {read=GetDataIndexValues, write=SetDataIndexValues};
	__property Variant Value[int FieldIndex][TDataValueVersionEh DataValueVersion] = {read=GetDataValue, write=SetDataValue};
	__property TMTDataStructEh* DataStruct = {read=GetDataStruct};
	__property unsigned HashCode = {read=FHashCode, nodefault};
	__property TRecDataValues OldData = {read=FOldData};
	__property TRecordsListEh* RecordsList = {read=FRecordsList};
	__property TUpdateErrorEh* UpdateError = {read=FUpdateError, write=FUpdateError};
	__property int UpdateIndex = {read=FUpdateIndex, write=FUpdateIndex, nodefault};
	__property Db::TUpdateStatus UpdateStatus = {read=FUpdateStatus, write=SetUpdateStatus, nodefault};
};


typedef int __fastcall (__closure *TRecordsListFetchRecordsEventEh)(int Count);

typedef void __fastcall (__closure *TRecordsListApplyUpdatesEventEh)(TMemTableDataEh* AMemTableData);

typedef void __fastcall (__closure *TRecordsListRecordMovedEventEh)(TMemoryRecordEh* Item, int OldIndex, int NewIndex);

class PASCALIMPLEMENTATION TRecordsListNotificatorEh : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	TMemTableDataEh* FMemTableData;
	TRecordsListNotificatorDataEventEh FOnAfterDataEvent;
	TRecordsListApplyUpdatesEventEh FOnApplyUpdates;
	TRecordsListNotificatorDataEventEh FOnDataEvent;
	TRecordsListFetchRecordsEventEh FOnFetchRecords;
	TRecordsListRecordMovedEventEh FOnRecordMoved;
	Classes::TComponent* FDataObject;
	void __fastcall SetMemTableData(const TMemTableDataEh* Value);
	void __fastcall SetDataObject(const Classes::TComponent* Value);
	
protected:
	virtual int __fastcall FetchRecords(int Count);
	virtual void __fastcall AfterDataEvent(TMemoryRecordEh* MemRec, int Index, TRecordsListNotification Action);
	void __fastcall ApplyUpdates(TMemTableDataEh* AMemTableData);
	virtual void __fastcall DataEvent(TMemoryRecordEh* MemRec, int Index, TRecordsListNotification Action);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall RecordAdded(TMemoryRecordEh* MemRec, int Index);
	virtual void __fastcall RecordChanged(TMemoryRecordEh* MemRec, int Index);
	virtual void __fastcall RecordDeleted(TMemoryRecordEh* MemRec, int Index);
	virtual void __fastcall RecordListChanged(void);
	virtual void __fastcall RecordMoved(TMemoryRecordEh* Item, int OldIndex, int NewIndex);
	
public:
	__fastcall virtual TRecordsListNotificatorEh(Classes::TComponent* AOwner);
	__fastcall virtual ~TRecordsListNotificatorEh(void);
	__property Classes::TComponent* DataObject = {read=FDataObject, write=SetDataObject};
	__property TRecordsListNotificatorDataEventEh OnAfterDataEvent = {read=FOnAfterDataEvent, write=FOnAfterDataEvent};
	__property TRecordsListApplyUpdatesEventEh OnApplyUpdates = {read=FOnApplyUpdates, write=FOnApplyUpdates};
	__property TRecordsListNotificatorDataEventEh OnDataEvent = {read=FOnDataEvent, write=FOnDataEvent};
	__property TRecordsListFetchRecordsEventEh OnFetchRecords = {read=FOnFetchRecords, write=FOnFetchRecords};
	__property TRecordsListRecordMovedEventEh OnRecordMoved = {read=FOnRecordMoved, write=FOnRecordMoved};
};


class DELPHICLASS TMemTableDataShadowEh;
class PASCALIMPLEMENTATION TMemTableDataShadowEh : public TMemTableDataEh 
{
	typedef TMemTableDataEh inherited;
	
private:
	TMemTableDataEh* FMasterTable;
	
protected:
	virtual TMTDataStructEh* __fastcall GetDataStruct(void);
	virtual void __fastcall SetAutoIncValue(TMemoryRecordEh* Rec);
	
public:
	__fastcall virtual TMemTableDataShadowEh(TMemTableDataEh* AMasterTable);
	__fastcall virtual ~TMemTableDataShadowEh(void);
};


class DELPHICLASS TIndexItemEh;
class PASCALIMPLEMENTATION TIndexItemEh : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	Variant Value;
	int RecIndex;
	__fastcall TIndexItemEh(const Variant &AValue, int ARecIndex);
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TIndexItemEh(void) { }
	#pragma option pop
	
};


typedef Exception EUnicalKeyViolationEh;
;

class PASCALIMPLEMENTATION TMTIndexEh : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FActive;
	AnsiString FFields;
	Variant FOldValue;
	bool FPrimary;
	Contnrs::TObjectList* FRecList;
	TRecordsListEh* FRecordsList;
	bool FUnical;
	TIndexItemEh* __fastcall GetItems(int Index);
	Variant __fastcall GetKeyValue(int Index);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetFields(const AnsiString Value);
	void __fastcall SetKeyValue(int Index, const Variant &Value);
	void __fastcall SetPrimary(const bool Value);
	void __fastcall SetUnical(const bool Value);
	
protected:
	__property Contnrs::TObjectList* RecList = {read=FRecList};
	void __fastcall RLDataEvent(TMemoryRecordEh* MemRec, int Index, TRecordsListNotification Action);
	virtual void __fastcall RecordMoved(TMemoryRecordEh* Item, int OldIndex, int NewIndex);
	virtual void __fastcall InsertIndexItemForValue(int InitIndex, const Variant &Value, TIndexItemEh* IndexItem);
	
public:
	__fastcall virtual TMTIndexEh(Classes::TCollection* Collection);
	__fastcall TMTIndexEh(TRecordsListEh* ARecordsList);
	__fastcall virtual ~TMTIndexEh(void);
	int __fastcall Count(void);
	bool __fastcall FindKeyValueIndex(const Variant &Value, int &Index);
	bool __fastcall FindRecordIndexByKey(const Variant &Value, int &Index);
	TRecordsListEh* __fastcall RecordsList(void);
	void __fastcall ClearIndex(void);
	void __fastcall FillMatchedKeyList(const Variant &Value, Contnrs::TObjectList* List);
	void __fastcall FillMatchedRecsList(const Variant &Value, Contnrs::TObjectList* List);
	void __fastcall QuickSort(int L, int R);
	void __fastcall RebuildIndex(void);
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property AnsiString Fields = {read=FFields, write=SetFields};
	__property TIndexItemEh* Item[int Index] = {read=GetItems};
	__property Variant KeyValue[int Index] = {read=GetKeyValue};
	__property bool Primary = {read=FPrimary, write=SetPrimary, default=0};
	__property bool Unical = {read=FUnical, write=SetUnical, default=0};
};


class DELPHICLASS TMTAggregateEh;
class DELPHICLASS TMTAggregatesEh;
class PASCALIMPLEMENTATION TMTAggregateEh : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FActive;
	TDataSetExprParserEh* FAggrExpr;
	Db::TDataSet* FDataSet;
	Db::TFieldType FDataType;
	AnsiString FExpression;
	bool FInUse;
	Variant FValue;
	void __fastcall SetActive(bool Value);
	void __fastcall SetExpression(const AnsiString Text);
	
public:
	__fastcall TMTAggregateEh(TMTAggregatesEh* Aggregates, Db::TDataSet* ADataSet)/* overload */;
	__fastcall virtual ~TMTAggregateEh(void);
	TMTAggregatesEh* __fastcall Aggregates(void);
	virtual AnsiString __fastcall GetDisplayName();
	Variant __fastcall Value();
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Recalc(void);
	void __fastcall Reset(void);
	__property Db::TDataSet* DataSet = {read=FDataSet};
	__property Db::TFieldType DataType = {read=FDataType, nodefault};
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property AnsiString Expression = {read=FExpression, write=SetExpression};
};


class PASCALIMPLEMENTATION TMTAggregatesEh : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	TMTAggregateEh* operator[](int Index) { return Items[Index]; }
	
private:
	bool FActive;
	Classes::TPersistent* FOwner;
	HIDESBASE TMTAggregateEh* __fastcall GetItem(int Index);
	void __fastcall SetActive(const bool Value);
	HIDESBASE void __fastcall SetItem(int Index, TMTAggregateEh* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TMTAggregatesEh(Classes::TPersistent* Owner);
	HIDESBASE TMTAggregateEh* __fastcall Add(void);
	Db::TDataSet* __fastcall DataSet(void);
	HIDESBASE void __fastcall Clear(void);
	void __fastcall Recalc(void);
	void __fastcall Reset(void);
	__property bool Active = {read=FActive, write=SetActive, nodefault};
	__property TMTAggregateEh* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property UpdateCount ;
public:
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TMTAggregatesEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TOrderByItemEh;
class PASCALIMPLEMENTATION TOrderByItemEh : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	int FieldIndex;
	bool Desc;
	bool CaseIns;
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TOrderByItemEh(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TOrderByItemEh(void) { }
	#pragma option pop
	
};


class DELPHICLASS TOrderByList;
class PASCALIMPLEMENTATION TOrderByList : public Contnrs::TObjectList 
{
	typedef Contnrs::TObjectList inherited;
	
public:
	TOrderByItemEh* operator[](int Index) { return Items[Index]; }
	
protected:
	HIDESBASE TOrderByItemEh* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TOrderByItemEh* Value);
	virtual int __fastcall FindFieldIndex(AnsiString FieldName);
	
public:
	AnsiString __fastcall GetToken(AnsiString Exp, int &FromIndex);
	void __fastcall ParseOrderByStr(AnsiString OrderByStr);
	__property TOrderByItemEh* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	#pragma option push -w-inl
	/* TObjectList.Create */ inline __fastcall TOrderByList(void)/* overload */ : Contnrs::TObjectList() { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TOrderByList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TMemoryTreeListOrderByList;
class DELPHICLASS TMemoryTreeListEh;
class DELPHICLASS TMemRecViewEh;
class PASCALIMPLEMENTATION TMemRecViewEh : public Memtreeeh::TBaseTreeNodeEh 
{
	typedef Memtreeeh::TBaseTreeNodeEh inherited;
	
public:
	TMemRecViewEh* operator[](int Index) { return NodeItems[Index]; }
	
private:
	TMemoryRecordEh* __fastcall GetRec(void);
	HIDESBASE TMemRecViewEh* __fastcall GetItem(const int Index);
	TMemoryTreeListEh* __fastcall GetNodeOwner(void);
	TMemRecViewEh* __fastcall GetNodeParent(void);
	void __fastcall SetNodeParent(const TMemRecViewEh* Value);
	bool __fastcall GetNodeExpanded(void);
	bool __fastcall GetNodeHasChildren(void);
	int __fastcall GetNodeIndex(void);
	int __fastcall GetNodeLevel(void);
	bool __fastcall GetNodeVisible(void);
	int __fastcall GetVisibleNodesCount(void);
	int __fastcall GetVisibleNodeIndex(void);
	TMemRecViewEh* __fastcall GetVisibleNodeItem(const int Index);
	void __fastcall SetNodeExpanded(const bool Value);
	int __fastcall GetNodesCount(void);
	void __fastcall SetNodeHasChildren(const bool Value);
	
public:
	__fastcall virtual ~TMemRecViewEh(void);
	void __fastcall SortByFields(const AnsiString SortByStr);
	__property TMemoryRecordEh* Rec = {read=GetRec};
	__property TMemRecViewEh* NodeItems[int Index] = {read=GetItem/*, default*/};
	__property int NodesCount = {read=GetNodesCount, nodefault};
	__property TMemoryTreeListEh* NodeOwner = {read=GetNodeOwner};
	__property TMemRecViewEh* NodeParent = {read=GetNodeParent, write=SetNodeParent};
	__property bool NodeHasChildren = {read=GetNodeHasChildren, write=SetNodeHasChildren, nodefault};
	__property int NodeLevel = {read=GetNodeLevel, nodefault};
	__property bool NodeExpanded = {read=GetNodeExpanded, write=SetNodeExpanded, nodefault};
	__property int VisibleNodesCount = {read=GetVisibleNodesCount, nodefault};
	__property int NodeIndex = {read=GetNodeIndex, nodefault};
	__property bool NodeVisible = {read=GetNodeVisible, nodefault};
	__property TMemRecViewEh* VisibleNodeItems[int Index] = {read=GetVisibleNodeItem};
	__property int VisibleNodeIndex = {read=GetVisibleNodeIndex, nodefault};
public:
	#pragma option push -w-inl
	/* TBaseTreeNodeEh.Create */ inline __fastcall virtual TMemRecViewEh(void) : Memtreeeh::TBaseTreeNodeEh() { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TMemoryTreeListEh : public Memtreeeh::TTreeListEh 
{
	typedef Memtreeeh::TTreeListEh inherited;
	
public:
	TMemRecViewEh* operator[](int Index) { return VisibleItem[Index]; }
	
private:
	bool FDefaultNodeExpanded;
	bool FDefaultNodeHasChildren;
	TMemRecViewEh* FDefaultParentNode;
	bool FFullBuildCheck;
	Contnrs::TObjectList* FInsertedNodeStack;
	Contnrs::TObjectList* FVisibleExpandedItems;
	Contnrs::TObjectList* FVisibleItems;
	bool FVisibleItemsObsolete;
	bool FFilterNodeIfParentVisible;
	AnsiString FSortOrder;
	TMemoryTreeListOrderByList* FOrderByList;
	int __fastcall GetAccountableCount(void);
	TMemRecViewEh* __fastcall GetAccountableItem(const int Index);
	AnsiString __fastcall GetKeyFieldNames();
	AnsiString __fastcall GetParentFieldNames();
	AnsiString __fastcall GetSortOrder();
	void __fastcall SetSortOrder(const AnsiString Value);
	
protected:
	TRecordsViewEh* FRecordsViewEh;
	int __fastcall GetVisibleCount(void);
	virtual TMemRecViewEh* __fastcall GetVisibleItem(const int Index);
	virtual void __fastcall SetChieldVisibleForVisibleParents(TMemRecViewEh* Parent);
	void __fastcall SetChieldsVisible(TMemRecViewEh* Parent, bool Visible, bool ARecurse);
	
public:
	__fastcall TMemoryTreeListEh(TRecordsViewEh* ARecordsViewEh);
	__fastcall virtual ~TMemoryTreeListEh(void);
	HIDESBASE TMemRecViewEh* __fastcall AddChild(const AnsiString Name, TMemRecViewEh* Parent, TMemoryRecordEh* MemRecord);
	TMemRecViewEh* __fastcall AddChildAtKey(const AnsiString Name, const AnsiString KeyFieldNames, const AnsiString ParentFieldNames, TMemoryRecordEh* MemRecord);
	virtual int __fastcall CompareTreeNodes(Memtreeeh::TBaseTreeNodeEh* Rec1, Memtreeeh::TBaseTreeNodeEh* Rec2, System::TObject* ParamSort);
	bool __fastcall CheckReferenceLoop(TMemoryRecordEh* MemRecord, const Variant &NewRefValue);
	TMemRecViewEh* __fastcall GetChildNodesForKey(TMemRecViewEh* StartNode, const AnsiString KeyFieldNames, const AnsiString ParentFieldNames, TMemoryRecordEh* MemRecord, Contnrs::TObjectList* ChildList);
	int __fastcall GetIndexForNode(TMemoryRecordEh* Rec, TMemRecViewEh* ParentNode);
	HIDESBASE TMemRecViewEh* __fastcall GetNode(TMemRecViewEh* StartNode, TMemoryRecordEh* MemRecord);
	TMemRecViewEh* __fastcall GetNodeAtValue(TMemRecViewEh* StartNode, const AnsiString FieldNames, const Variant &Value);
	TMemRecViewEh* __fastcall GetParentNodeAtKey(TMemRecViewEh* StartNode, const AnsiString KeyFieldNames, const AnsiString ParentFieldNames, TMemoryRecordEh* MemRecord);
	TMemRecViewEh* __fastcall GetParentNodeAtKeyValue(TMemRecViewEh* StartNode, const AnsiString KeyFieldNames, const AnsiString ParentFieldNames, const Variant &RefKeyValue);
	TMemRecViewEh* __fastcall GetParentNodeForRec(TMemoryRecordEh* MemRecord);
	TMemRecViewEh* __fastcall GetParentNodeForRefValue(const Variant &RefValue);
	TMemRecViewEh* __fastcall UpdateParent(TMemRecViewEh* Node, const AnsiString KeyFieldNames, const AnsiString ParentFieldNames, TMemoryRecordEh* MemRecord, bool ReIndex);
	void __fastcall BuildVisibleItems(void);
	void __fastcall GetRecordsList(Contnrs::TObjectList* List, TMemRecViewEh* Node, bool ARecurse = true);
	virtual void __fastcall MoveTo(Memtreeeh::TBaseTreeNodeEh* Node, Memtreeeh::TBaseTreeNodeEh* Destination, Memtreeeh::TNodeAttachModeEh Mode, bool ReIndex);
	virtual void __fastcall Resort(void);
	virtual void __fastcall SortData(Memtreeeh::TCompareNodesEh CompareProg, System::TObject* ParamSort, bool ARecurse = true);
	void __fastcall UpdateNodesState(TMemRecViewEh* Parent);
	void __fastcall UpdateNodeState(TMemRecViewEh* Node, bool IsUpdateParent);
	__property int AccountableCount = {read=GetAccountableCount, nodefault};
	__property TMemRecViewEh* AccountableItem[int Index] = {read=GetAccountableItem};
	__property bool DefaultNodeExpanded = {read=FDefaultNodeExpanded, write=FDefaultNodeExpanded, default=0};
	__property bool DefaultNodeHasChildren = {read=FDefaultNodeHasChildren, write=FDefaultNodeHasChildren, default=0};
	__property TMemRecViewEh* DefaultParentNode = {read=FDefaultParentNode, write=FDefaultParentNode};
	__property bool FullBuildCheck = {read=FFullBuildCheck, write=FFullBuildCheck, nodefault};
	__property bool FilterNodeIfParentVisible = {read=FFilterNodeIfParentVisible, write=FFilterNodeIfParentVisible, nodefault};
	__property AnsiString KeyFieldNames = {read=GetKeyFieldNames};
	__property AnsiString ParentFieldNames = {read=GetParentFieldNames};
	__property int VisibleCount = {read=GetVisibleCount, nodefault};
	__property TMemRecViewEh* VisibleItem[int Index] = {read=GetVisibleItem/*, default*/};
	__property Contnrs::TObjectList* VisibleItems = {read=FVisibleExpandedItems};
	__property bool VisibleItemsObsolete = {read=FVisibleItemsObsolete, nodefault};
	__property AnsiString SortOrder = {read=GetSortOrder, write=SetSortOrder};
};


class PASCALIMPLEMENTATION TMemoryTreeListOrderByList : public TOrderByList 
{
	typedef TOrderByList inherited;
	
protected:
	TMemoryTreeListEh* FTreeList;
	virtual int __fastcall FindFieldIndex(AnsiString FieldName);
	
public:
	__fastcall TMemoryTreeListOrderByList(TMemoryTreeListEh* ATreeList);
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TMemoryTreeListOrderByList(void) { }
	#pragma option pop
	
};


class DELPHICLASS TRecordsViewOrderByList;
class PASCALIMPLEMENTATION TRecordsViewOrderByList : public TOrderByList 
{
	typedef TOrderByList inherited;
	
protected:
	TRecordsViewEh* FRecordsView;
	virtual int __fastcall FindFieldIndex(AnsiString FieldName);
	
public:
	__fastcall TRecordsViewOrderByList(TRecordsViewEh* ARecordsView);
public:
	#pragma option push -w-inl
	/* TList.Destroy */ inline __fastcall virtual ~TRecordsViewOrderByList(void) { }
	#pragma option pop
	
};


typedef bool __fastcall (__closure *TRecordsViewFilterEventEh)(TMemoryRecordEh* Rec);

typedef System::TObject* __fastcall (__closure *TParseOrderByStrEventEh)(AnsiString OrderByStr);

typedef Contnrs::TObjectList* __fastcall (__closure *TGetPrefilteredListEventEh)(void);

class PASCALIMPLEMENTATION TRecordsViewEh : public TRecordsListNotificatorEh 
{
	typedef TRecordsListNotificatorEh inherited;
	
public:
	TMemoryRecordEh* operator[](int Index) { return ViewRecord[Index]; }
	
private:
	TMTAggregatesEh* FAggregates;
	bool FCachedUpdates;
	int FCachedUpdatesLockCount;
	bool FCatchChanged;
	Contnrs::TObjectList* FFilteredRecsList;
	TCompareRecords FOnCompareRecords;
	Memtreeeh::TCompareNodesEh FOnCompareTreeNode;
	TRecordsViewFilterEventEh FOnFilterRecord;
	TGetPrefilteredListEventEh FOnGetPrefilteredList;
	TParseOrderByStrEventEh FOnParseOrderByStr;
	TRecordsListNotificatorDataEventEh FOnViewDataEvent;
	TRecordsListRecordMovedEventEh FOnViewRecordMovedEvent;
	TRecordsViewOrderByList* FOrderByList;
	AnsiString FSortOrder;
	AnsiString FTreeViewKeyFieldName;
	DynamicArray<int >  FTreeViewKeyFields;
	AnsiString FTreeViewRefParentFieldName;
	DynamicArray<int >  FTreeViewRefParentFields;
	bool FViewAsTreeList;
	Db::TUpdateStatusSet FStatusFilter;
	Contnrs::TObjectList* FNotificators;
	int __fastcall CompareRecords(TMemoryRecordEh* Rec1, TMemoryRecordEh* Rec2);
	AnsiString __fastcall GetSortOrder();
	int __fastcall SearchNewPos(Contnrs::TObjectList* SortedList, TMemoryRecordEh* MemRec, int OldIndex);
	int __fastcall SearchRec(Contnrs::TObjectList* SortedList, TMemoryRecordEh* MemRec);
	TMemoryRecordEh* __fastcall GetAccountableRecord(int Index);
	int __fastcall GetCount(void);
	TRecDataValues __fastcall GetOldRecVals(int Index);
	TMemoryRecordEh* __fastcall GetRec(int Index);
	Db::TUpdateStatusSet __fastcall GetStatusFilter(void);
	Variant __fastcall GetValue(int RecNo, int ValNo);
	bool __fastcall GetViewAsTreeList(void);
	TMemoryRecordEh* __fastcall GetViewRecord(int Index);
	void __fastcall SetRec(int Index, const TMemoryRecordEh* Value);
	void __fastcall SetSortOrder(const AnsiString Value);
	void __fastcall SetStatusFilter(const Db::TUpdateStatusSet Value);
	void __fastcall SetTreeViewKeyFieldName(const AnsiString Value);
	void __fastcall SetTreeViewRefParentFieldName(const AnsiString Value);
	void __fastcall SetValue(int RecNo, int ValNo, const Variant &Value);
	void __fastcall SetViewAsTreeList(const bool Value);
	TMemTableDataEh* __fastcall GetMemTableData(void);
	HIDESBASE void __fastcall SetMemTableData(const TMemTableDataEh* Value);
	
protected:
	Db::TDataSet* FDataSet;
	int FDisableFilterCount;
	TMemoryTreeListEh* FMemoryTreeList;
	virtual bool __fastcall FilterRecord(TMemoryRecordEh* MemRec, int Index);
	virtual void __fastcall AddNotificator(TRecordsListNotificatorEh* RecordsList);
	void __fastcall RemoveNotificator(TRecordsListNotificatorEh* RecordsList);
	void __fastcall ClearMemoryTreeList(void);
	virtual void __fastcall DataEvent(TMemoryRecordEh* MemRec, int Index, TRecordsListNotification Action);
	virtual void __fastcall Notify(TMemoryRecordEh* MemRec, int Index, TRecordsListNotification Action);
	virtual void __fastcall NotifyRecordMoved(TMemoryRecordEh* MemRec, int OldIndex, int NewIndex);
	virtual void __fastcall RecordMoved(TMemoryRecordEh* Item, int OldIndex, int NewIndex);
	virtual void __fastcall Resort(void);
	
public:
	__fastcall TRecordsViewEh(Db::TDataSet* ADataSet);
	__fastcall virtual ~TRecordsViewEh(void);
	int __fastcall AccountableItemsCount(void);
	int __fastcall AddRecord(TMemoryRecordEh* Rec);
	Variant __fastcall CalcAggrFieldFunc(AnsiString FieldName, AnsiString AggrFuncName);
	int __fastcall IndexOf(TMemoryRecordEh* Rec);
	TMemoryRecordEh* __fastcall NewRecord(void);
	int __fastcall ViewItemsCount(void);
	void __fastcall CancelUpdates(void);
	void __fastcall DeleteRecord(int Index);
	void __fastcall InsertRecord(int Index, TMemoryRecordEh* Rec);
	void __fastcall InstantDisableFilter(void);
	void __fastcall InstantEnableFilter(void);
	void __fastcall LockCachedUpdates(void);
	void __fastcall MergeChangeLog(void);
	void __fastcall RebuildMemoryTreeList(void);
	void __fastcall RefreshFilteredRecsList(void);
	void __fastcall RefreshRecord(int Index, TMemoryRecordEh* Rec);
	void __fastcall RevertRecord(int Index);
	void __fastcall UnlockCachedUpdates(void);
	virtual void __fastcall UpdateFields(void);
	void __fastcall QuickSort(int L, int R, TCompareRecords Compare, System::TObject* ParamSort);
	void __fastcall SortData(TCompareRecords Compare, System::TObject* ParamSort);
	__property TMemoryRecordEh* AccountableRecord[int Index] = {read=GetAccountableRecord};
	__property TMTAggregatesEh* Aggregates = {read=FAggregates};
	__property bool CatchChanged = {read=FCatchChanged, write=FCatchChanged, nodefault};
	__property int Count = {read=GetCount, nodefault};
	__property TMemoryTreeListEh* MemoryTreeList = {read=FMemoryTreeList};
	__property TRecDataValues OldRecVals[int Index] = {read=GetOldRecVals};
	__property TCompareRecords OnCompareRecords = {read=FOnCompareRecords, write=FOnCompareRecords};
	__property Memtreeeh::TCompareNodesEh OnCompareTreeNode = {read=FOnCompareTreeNode, write=FOnCompareTreeNode};
	__property TRecordsViewFilterEventEh OnFilterRecord = {read=FOnFilterRecord, write=FOnFilterRecord};
	__property TGetPrefilteredListEventEh OnGetPrefilteredList = {read=FOnGetPrefilteredList, write=FOnGetPrefilteredList};
	__property TParseOrderByStrEventEh OnParseOrderByStr = {read=FOnParseOrderByStr, write=FOnParseOrderByStr};
	__property TRecordsListNotificatorDataEventEh OnViewDataEvent = {read=FOnViewDataEvent, write=FOnViewDataEvent};
	__property TRecordsListRecordMovedEventEh OnViewRecordMovedEvent = {read=FOnViewRecordMovedEvent, write=FOnViewRecordMovedEvent};
	__property TMemoryRecordEh* Rec[int Index] = {read=GetRec, write=SetRec};
	__property AnsiString TreeViewKeyFieldName = {read=FTreeViewKeyFieldName, write=SetTreeViewKeyFieldName};
	__property TIntArray TreeViewKeyFields = {read=FTreeViewKeyFields};
	__property AnsiString TreeViewRefParentFieldName = {read=FTreeViewRefParentFieldName, write=SetTreeViewRefParentFieldName};
	__property TIntArray TreeViewRefParentFields = {read=FTreeViewRefParentFields};
	__property Variant Value[int RecNo][int ValNo] = {read=GetValue, write=SetValue};
	__property bool ViewAsTreeList = {read=GetViewAsTreeList, write=SetViewAsTreeList, nodefault};
	__property TMemoryRecordEh* ViewRecord[int Index] = {read=GetViewRecord/*, default*/};
	__property AnsiString SortOrder = {read=GetSortOrder, write=SetSortOrder};
	__property Db::TUpdateStatusSet StatusFilter = {read=GetStatusFilter, write=SetStatusFilter, default=7};
	__property TMemTableDataEh* MemTableData = {read=GetMemTableData, write=SetMemTableData};
};


//-- var, const, procedure ---------------------------------------------------
#define mrEditStatesEh (Set<TRecordEditStateEh, resBrowseEh, resInsertEh> () << TRecordEditStateEh(1) << TRecordEditStateEh(2) )
extern PACKAGE Db::TFieldType StringDataFieldsToFields[6];
extern PACKAGE Db::TFieldType NumericDataFieldsToFields[9];
extern PACKAGE Db::TFieldType DateTimeDataFieldsToFields[3];
extern PACKAGE Db::TFieldType InterfaceDataFieldsToFields[2];
extern PACKAGE Db::TFieldType VariantDataFieldsToFields[3];
extern PACKAGE Db::TFieldType SQLTimeStampDataFieldsToFields[2];
extern PACKAGE TMetaClass* DefaultDataFieldClasses[42];
extern PACKAGE Variant __fastcall CalcAggregateValue(TMTAggregateEh* Aggregate, Db::TDataSet* DataSet, TRecordsViewEh* Records);

}	/* namespace Memtabledataeh */
using namespace Memtabledataeh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Memtabledataeh
