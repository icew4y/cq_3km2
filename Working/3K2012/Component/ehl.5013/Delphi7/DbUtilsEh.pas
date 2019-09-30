{*******************************************************}
{                                                       }
{                       EhLib v5.0                      }
{       Utilities to sort, filter data in DataSet       }
{                      Build 5.0.01                     }
{                                                       }
{      Copyright (c) 2002-2008 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DbUtilsEh;

interface

uses
{$IFDEF EH_LIB_6} Variants, {$ENDIF}

{$IFDEF CIL}
  EhLibVCLNET,
  System.Runtime.InteropServices, System.Reflection,
{$ELSE}
  EhLibVCL,
 {$IFDEF EH_LIB_9} WideStrings, {$ENDIF}
{$ENDIF}

  DBGridEh, Db, SysUtils, Classes, TypInfo, Windows, Messages, ToolCtrlsEh;

type

  TDateValueToSQLStringProcEh = function(DataSet: TDataSet; Value: Variant): String;

var

  STFilterOperatorsStrMapEh: array[TSTFilterOperatorEh] of String =
  ('', '=', '<>',
    '>', '<', '>=', '<=',
    '~', '!~',
    'In', '!In',
    {=}'Null', {<>}'Null',
    'AND', 'OR',
    '');

const

  STFldTypeMapEh: array[TFieldType] of TSTOperandTypeEh = (
    botNon, botString, botNumber, botNumber, botNumber,
    botBoolean, botNumber, botNumber, botNumber, botDateTime, botDateTime, botDateTime,
    botNon, botNon, botNumber, botNon, botString, botNon, botString,
    botNon, botNon, botNon, botNon, botString, botString,
    botNumber, botNon, botNon, botNon, botNon
{$IFDEF EH_LIB_5}
    ,botNon, botNon, botNon, botNon, botNon, botString
{$ENDIF}
{$IFDEF EH_LIB_6}, botDateTime, botNumber{$ENDIF}
{$IFDEF EH_LIB_10}
    ,botString, botString, botNon, botString
{$ENDIF}
{$IFDEF EH_LIB_12}
    ,botNumber, botNumber, botNumber, botNumber, botNon, botNon, botNon
{$ENDIF}
{$IFDEF EH_LIB_13}
    ,botNon, botNon, botNon
{$ENDIF}
    );

  STFilterOperatorsSQLStrMapEh: array[TSTFilterOperatorEh] of String =
  ('', '=', '<>',
    '>', '<', '>=', '<=',
    'LIKE', 'NOT LIKE',
    'IN', 'NOT IN',
    'IS NULL', 'IS NOT NULL',
    'AND', 'OR',
    '');

procedure InitSTFilterOperatorsStrMap;

{ FilterExpression }

function ParseSTFilterExpressionEh(Exp: String; var FExpression: TSTFilterExpressionEh): Boolean;
procedure ClearSTFilterExpression(var FExpression: TSTFilterExpressionEh);

type
  TOneExpressionFilterStringProcEh = function(O: TSTFilterOperatorEh; v: Variant;
    FieldName: String; DataSet: TDataSet;
    DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
    SupportsLike: Boolean): String;

{ Useful routines to form filter string for dataset }

function GetExpressionAsFilterString(AGrid: TCustomDBGridEh;
  OneExpressionProc: TOneExpressionFilterStringProcEh;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
  UseFieldOrigin: Boolean = False;
  SupportsLocalLike: Boolean = False): String;

function GetOneExpressionAsLocalFilterString(O: TSTFilterOperatorEh;
  v: Variant; FieldName: String; DataSet: TDataSet;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
  SupportsLike: Boolean): String;

function GetOneExpressionAsSQLWhereString(O: TSTFilterOperatorEh; v: Variant;
  FieldName: String; DataSet: TDataSet;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh; SupportsLike: Boolean): String;

function DateValueToDataBaseSQLString(DataBaseName: String; v: Variant): String;

procedure ApplyFilterSQLBasedDataSet(Grid: TCustomDBGridEh;
  DateValueToSQLString: TDateValueToSQLStringProcEh; IsReopen: Boolean;
  SQLPropName: String);

{ DatasetFeatures }

type

  TDataSetClass = class of TDataSet;

  TDatasetFeaturesEh = class
  private
    FDataSetClass: TDataSetClass;
  public
    constructor Create; virtual;
    function LocateText(AGrid: TCustomDBGridEh; const FieldName: string;
      const Text: String; AOptions: TLocateTextOptionsEh; Direction: TLocateTextDirectionEh;
      Matching: TLocateTextMatchingEh; TreeFindRange: TLocateTextTreeFindRangeEh): Boolean; virtual;
    function MoveRecords(Sender: TObject; BookmarkList: TBMListEh; ToRecNo: Longint; CheckOnly: Boolean): Boolean; virtual;
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); virtual;
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); virtual;
    procedure ExecuteFindDialog(Sender: TObject; Text, FieldName: String; Modal: Boolean); virtual;
  end;

  TSQLDatasetFeaturesEh = class(TDatasetFeaturesEh)
  private
    FSortUsingFieldName: Boolean;
    FSQLPropName: String;
    FDateValueToSQLString: TDateValueToSQLStringProcEh;
    FSupportsLocalLike: Boolean;
  public
    constructor Create; override;
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    property SortUsingFieldName: Boolean read FSortUsingFieldName write FSortUsingFieldName;
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    property SQLPropName: String read FSQLPropName  write FSQLPropName;
    property DateValueToSQLString: TDateValueToSQLStringProcEh read
      FDateValueToSQLString write FDateValueToSQLString;
    property SupportsLocalLike: Boolean read FSupportsLocalLike write FSupportsLocalLike;
  end;

  TCommandTextDatasetFeaturesEh = class(TSQLDatasetFeaturesEh)
  public
    constructor Create; override;
  end;

  TDatasetFeaturesEhClass = class of TDatasetFeaturesEh;

{ Register/Unregister DatasetFeatures }

procedure RegisterDatasetFeaturesEh(DatasetFeaturesClass: TDatasetFeaturesEhClass;
  DataSetClass: TDataSetClass);
procedure UnregisterDatasetFeaturesEh(DataSetClass: TDataSetClass);
function GetDatasetFeaturesForDataSet(DataSet: TDataSet): TDatasetFeaturesEh;
function GetDatasetFeaturesForDataSetClass(DataSetClass: TClass): TDatasetFeaturesEh;


function IsSQLBasedDataSet(DataSet: TDataSet; var SQL: TStrings): Boolean;
function IsDataSetHaveSQLLikeProp(DataSet: TDataSet; SQLPropName: String; var SQLPropValue: WideString): Boolean;

procedure ApplySortingForSQLBasedDataSet(Grid: TCustomDBGridEh; DataSet: TDataSet;
  UseFieldName: Boolean; IsReopen: Boolean; SQLPropName: String);

function LocateDatasetTextEh(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TreeFindRange: TLocateTextTreeFindRangeEh): Boolean;

var
  SQLFilterMarker: String = '/*FILTER*/';

resourcestring

  // Filter expression operators
  SNotOperatorEh = 'Not';
  SAndOperatorEh = 'AND';
  SOrOperatorEh = 'OR';
  SLikePredicatEh = ''; // 'Like sign' //Use default sign '~'
  SInPredicatEh = 'In';
  SNullConstEh = 'Null';

  // Error message
  SQuoteIsAbsentEh = 'Quote is absent: ';
  SLeftBracketExpectedEh = '''('' expected: ';
  SRightBracketExpectedEh = ''')'' expected: ';
  SErrorInExpressionEh = 'Error in expression: ';
  SUnexpectedExpressionBeforeNullEh = 'Unexpected expression before Null: ';
  SUnexpectedExpressionAfterOperatorEh = 'Unexpected expression after operator: ';
  SIncorrectExpressionEh = 'Incorrect expression: ';
  SUnexpectedANDorOREh = 'Unexpected AND or OR: ';

implementation

uses
  DBConsts, DBGridEhFindDlgs, Contnrs;
  
procedure SetDataSetSQLLikeProp(DataSet: TDataSet; SQLPropName: String; SQLPropValue: WideString);
var
  FPropInfo: PPropInfo;
begin
  FPropInfo := GetPropInfo(DataSet.ClassInfo, SQLPropName);
  if FPropInfo = nil then Exit;
  if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkString then
    SetStrProp(DataSet, FPropInfo, SQLPropValue)
{$IFDEF EH_LIB_6}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkWString then
    SetWideStrProp(DataSet, FPropInfo, SQLPropValue)
{$ELSE}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkWString then
    SetStrProp(DataSet, FPropInfo, SQLPropValue)
{$ENDIF}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkClass then
    if (TObject(GetOrdProp(DataSet, FPropInfo)) as TStrings) <> nil then
      (TObject(GetOrdProp(DataSet, FPropInfo)) as TStrings).Text := SQLPropValue
{$IFDEF CIL}
{$ELSE}
  {$IFDEF EH_LIB_9}
    else if (TObject(GetOrdProp(DataSet, FPropInfo)) as TWideStrings) <> nil then
      (TObject(GetOrdProp(DataSet, FPropInfo)) as TWideStrings).Text := SQLPropValue
  {$ENDIF}
{$ENDIF}
    ;
end;

procedure ClearSTFilterExpression(var FExpression: TSTFilterExpressionEh);
begin
  FExpression.Operator1 := foNon;
  FExpression.Operand1 := Null;
  FExpression.Relation := foNon;
  FExpression.Operator2 := foNon;
  FExpression.Operand2 := Null;
end;

procedure InitSTFilterOperatorsStrMap;
var
  NotOperator: String;
begin
  if SNotOperatorEh <> ''
    then NotOperator := SNotOperatorEh + ' '
    else NotOperator := 'Not ';
  if SLikePredicatEh <> '' then
  begin
    STFilterOperatorsStrMapEh[foLike] := SLikePredicatEh;
    STFilterOperatorsStrMapEh[foNotLike] := NotOperator + SLikePredicatEh;
  end;
  if SInPredicatEh <> '' then
  begin
    STFilterOperatorsStrMapEh[foIn] := SInPredicatEh;
    STFilterOperatorsStrMapEh[foNotIn] := NotOperator + SInPredicatEh;
  end;
  if SNullConstEh <> '' then
  begin
    STFilterOperatorsStrMapEh[foNull] := SNullConstEh;
    STFilterOperatorsStrMapEh[foNotNull] := SNullConstEh;
  end;
  if SAndOperatorEh <> '' then
    STFilterOperatorsStrMapEh[foAND] := SAndOperatorEh;
  if SOrOperatorEh <> '' then
    STFilterOperatorsStrMapEh[foOR] := SOrOperatorEh;
end;

{$IFNDEF EH_LIB_6}
function StrCharLength(const Str: PChar): Integer;
begin
  if SysLocale.FarEast then
    Result := Integer(CharNext(Str)) - Integer(Str)
  else
    Result := 1;
end;

function NextCharIndex(const S: string; Index: Integer): Integer;
begin
  Result := Index + 1;
  assert((Index > 0) and (Index <= Length(S)));
  if SysLocale.FarEast and (S[Index] in LeadBytes) then
    Result := Index + StrCharLength(PChar(S) + Index - 1);
end;
{$ENDIF}

{ ParseSTFilterExpression }

type
  TOperator = (
    opNon, opEqual, opNotEqual,
    opGreaterThan, opLessThan, opGreaterOrEqual, opLessOrEqual,
    opLike,
    opIn,
    opAND, opOR,
    opValue,
    opNot, opComma, opOpenBracket, opCloseBracket, opQuote, opNullConst);

const
  OperatorAdvFilterOperatorMap: array[TOperator] of TSTFilterOperatorEh = (
    foNon, foEqual, foNotEqual,
    foGreaterThan, foLessThan, foGreaterOrEqual, foLessOrEqual,
    foLike,
    foIn,
    foAND, foOR,
    foValue,
    foNon, foNon, foNon, foNon, foNon, foNull);


function GetLexeme(S: String; var Pos: Integer; var Operator: TSTFilterOperatorEh;
  PreferCommaForList: Boolean): Variant; forward;

function GetOperatorByWord(TheWord: String): TOperator;
begin
  Result := opNon;
  TheWord := AnsiUpperCase(TheWord);
  if (TheWord = 'NOT') or
     ((SNotOperatorEh <> '') and (TheWord = AnsiUpperCase(SNotOperatorEh))) then
    Result := opNot
  else if (TheWord = 'AND') or
          ((SAndOperatorEh <> '') and (TheWord = AnsiUpperCase(SAndOperatorEh))) then
    Result := opAND
  else if (TheWord = 'OR') or
          ((SOrOperatorEh <> '') and (TheWord = AnsiUpperCase(SOrOperatorEh))) then
    Result := opOR
  else if (TheWord = 'LIKE') or
          ((SLikePredicatEh <> '') and (TheWord = AnsiUpperCase(SLikePredicatEh))) then
    Result := opLIKE
  else if (TheWord = 'IN') or
          ((SInPredicatEh <> '') and (TheWord = AnsiUpperCase(SInPredicatEh))) then
    Result := opIN
  else if (TheWord = 'NULL') or
          ((SNullConstEh <> '') and (TheWord = AnsiUpperCase(SNullConstEh))) then
    Result := opNullConst;
end;

procedure ConvertVarStrValues(var v: Variant; ot: TSTOperandTypeEh);
var
  i: Integer;

  function StrToDateTimeEh(s: String): Variant;
  begin
    if  SameText(s, 'NOW')
      then Result := s
      else Result := StrToDateTime(s);
  end;

begin
  if ot = botNumber then
  begin
    if not VarIsNull(v) then
      if VarIsArray(v) then
        for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
          v[i] := StrToFloat(v[i])
      else
        v := StrToFloat(v);
  end
  else if ot = botDateTime then
  begin
    if not VarIsNull(v) then
      if VarIsArray(v) then
        for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
          v[i] := StrToDateTimeEh(v[i])
      else
        v := StrToDateTimeEh(v);
  end;
end;

function SkipBlanks(s: String; Pos: Integer): Integer;
var
  i: Integer;
begin
  Result := Pos;
  for i := Pos to Length(s) do
    if s[i] <> ' ' then
    begin
      Result := i;
      Break;
    end
end;

procedure SetOperatorPos(var Pos: Integer; Increment: Integer; var Op: TOperator; NewOp: TOperator);
begin
  Inc(Pos, Increment);
  Op := NewOp;
end;

function CharAtPos(S: String; Pos: Integer): Char;
begin
  if Length(S) < Pos then
    Result := #0
  else
    Result := S[Pos];
end;

function ReadValue(S: String; var Pos: Integer; PreferCommaForList: Boolean): Variant;

  function CheckForOperand(S: String; Pos: Integer): Boolean;
  var
    Operator: TSTFilterOperatorEh;
  begin
    GetLexeme(S, Pos, Operator, PreferCommaForList);
    if Operator in [foEqual..foOR] then
      Result := True
    else
      Result := False;
  end;

var
  i: Integer;
begin
  Result := Null;
  if Pos > Length(S) then
    Exit;
  if S[Pos] = '''' then
  begin
    for i := Pos + 1 to Length(S) do
      if S[i] = '''' then
      begin
        Result := Copy(S, Pos + 1, i - Pos - 1);
        Pos := i + 1;
        Exit;
      end;
    raise Exception.Create(SQuoteIsAbsentEh + S);
  end
  else
  begin
    for i := Pos to Length(S) do
    begin
      if ( CharInSetEh(S[i], [' ']) and CheckForOperand(S, SkipBlanks(S, i))) or
        ( CharInSetEh(S[i], [')', '(']) ) or
        (PreferCommaForList and (S[i] = ',')) then
      begin
        Result := Copy(S, Pos, i - Pos);
        Pos := i;
        Exit;
      end;
    end;
    Result := Copy(S, Pos, MAXINT);
    Pos := Length(S) + 1;
  end;
end;

function ReadValues(S: String; var Pos: Integer; PreferCommaForList: Boolean): Variant;
var
  i: Integer;
  vArr: Variant;
begin
  i := 0;
  vArr := VarArrayCreate([0, 0], varVariant);
  while True do
  begin
    vArr[i] := ReadValue(S, Pos, PreferCommaForList);
    if vArr[i] = Null then
      Break;
    if PreferCommaForList and (CharAtPos(S, Pos) = ',') then
      Inc(Pos)
    else
      Break;
    Inc(i);
    VarArrayRedimEh(vArr, i);
  end;
  if i = 0 then
    Result := vArr[0]
  else
    Result := vArr;
end;

function GetLexeme(S: String; var Pos: Integer; var Operator: TSTFilterOperatorEh;
  PreferCommaForList: Boolean): Variant;
var
  Oper: TOperator;
  Operator1: TSTFilterOperatorEh;
  TheWord: String;

  function ReadWord(S: String; Pos: Integer): String;
  var
    c: Char;
    NextPos: Integer;
  begin
    Result := '';
    while True do
    begin
      c := CharAtPos(S, Pos);
      if (c < #32) or CharInSetEh(c, [' ','(',')','>','<','=','!','~','&','|','.',',','''','"','+','-']) then
        Exit;
      NextPos := NextCharIndex(S,Pos);
      Result := Result + Copy(S,Pos,NextPos-Pos);
      Pos := NextPos;
    end;
  end;

begin
  Operator := foNon;
  Oper := opNon;
  Result := '';
  if Length(S) < Pos then
    Exit;
  if S[Pos] = '''' then
  begin
    Result := ReadValues(S, Pos, PreferCommaForList);
    Operator := foValue;
  end
  else
  begin
    case S[Pos] of

      '!':
        if CharAtPos(S, Pos + 1) = '=' then
          SetOperatorPos(Pos, 2, Oper, opNotEqual)
        else
          SetOperatorPos(Pos, 1, Oper, opNot);
      '=':
        SetOperatorPos(Pos, 1, Oper, opEqual);
      '(':
        SetOperatorPos(Pos, 1, Oper, opOpenBracket);

      '>':
        if CharAtPos(S, Pos + 1) = '=' then
          SetOperatorPos(Pos, 2, Oper, opGreaterOrEqual)
        else
          SetOperatorPos(Pos, 1, Oper, opGreaterThan);
      '<':
        if CharAtPos(S, Pos + 1) = '=' then
          SetOperatorPos(Pos, 2, Oper, opLessOrEqual)
        else if CharAtPos(S, Pos + 1) = '>' then
          SetOperatorPos(Pos, 2, Oper, opNotEqual)
        else
          SetOperatorPos(Pos, 1, Oper, opLessThan);
      '~':
        SetOperatorPos(Pos, 1, Oper, opLike);
      '&':
        SetOperatorPos(Pos, 1, Oper, opAnd); //And
      '|':
        SetOperatorPos(Pos, 1, Oper, opOr); // Or
    else
      TheWord := ReadWord(S,Pos);
      Oper := GetOperatorByWord(TheWord);
      if Oper <> opNon then
        Inc(Pos, Length(TheWord));
    end; //case

    if Oper = opNon then
    begin
      Result := ReadValues(S, Pos, PreferCommaForList);
      if VarIsNull(Result) then
        Operator := foNon
      else
        Operator := foValue;
      Exit;
    end;

    Pos := SkipBlanks(S, Pos);

    if Oper = opNot then
    begin
      GetLexeme(S, Pos, Operator1, PreferCommaForList);
      case Operator1 of
        foLike: Operator := foNotLike;
        foIn: Operator := foNotIn;
        foNull: Operator := foNotNull;
      end
    end
    else if Oper = opIn then
    begin
      if CharAtPos(S, Pos) = '(' then
        Inc(Pos)
      else
        raise Exception.Create(SLeftBracketExpectedEh + S);
      Operator := foIn;
    end
    else
      Operator := OperatorAdvFilterOperatorMap[Oper];
  end;
end;

function ParseSTFilterExpression(Exp: String; var FExpression: TSTFilterExpressionEh): Boolean;

var
  PreferCommaForList: Boolean;

  procedure ResetPreferCommaForList;
  begin
    if (FExpression.ExpressionType = botNumber) and (DecimalSeparator = ',') then
      PreferCommaForList := False
    else
      PreferCommaForList := True;
  end;

var
  v: Variant;
  op, op1: TSTFilterOperatorEh;
  p: Integer;
begin
  Result := False;

  ResetPreferCommaForList;

  FExpression.Operator1 := foNon;
  FExpression.Operand1 := Null;
  FExpression.Relation := foNon;
  FExpression.Operator2 := foNon;
  FExpression.Operand2 := Null;

  Exp := Trim(Exp);
  if Exp = '' then
    Exit;
  // 1 [Oper] + Values
  p := SkipBlanks(Exp, 1);
  v := GetLexeme(Exp, p, op, PreferCommaForList);
  if op = foValue then
  begin
    if VarIsArray(v) then
      FExpression.Operator1 := foIn
    else if FExpression.ExpressionType = botString then
      FExpression.Operator1 := foLike
    else
      FExpression.Operator1 := foEqual;
    FExpression.Operand1 := v;
  end
  else if (op = foNon) and (Length(Exp) <> 0) then
    raise Exception.Create(SErrorInExpressionEh + Exp)
  else
  begin
    if op in [foIn, foNotIn] then
      PreferCommaForList := True;
    p := SkipBlanks(Exp, p);
    v := GetLexeme(Exp, p, op1, PreferCommaForList);
    FExpression.Operator1 := op;
    if op1 = foNull then
      if op = foEqual then
        FExpression.Operator1 := foNull
      else if op = foNotEqual then
        FExpression.Operator1 := foNotNull
      else
        raise Exception.Create(SUnexpectedExpressionBeforeNullEh + Exp)
    else if op1 <> foValue then
      raise Exception.Create(SUnexpectedExpressionAfterOperatorEh + Exp);
    FExpression.Operand1 := v;
    if op in [foIn, foNotIn] then
    begin
      p := SkipBlanks(Exp, p);
      if CharAtPos(Exp, p) = ')' then
        Inc(p)
      else
        raise Exception.Create(SRightBracketExpectedEh + Exp);
      ResetPreferCommaForList;
    end;
  end;

  while True do
  begin
    // 2 And or Or
    p := SkipBlanks(Exp, p);
    v := GetLexeme(Exp, p, op, PreferCommaForList);
    if op = foNon then
      if p <> Length(Exp) + 1 then
        raise Exception.Create(SIncorrectExpressionEh + Exp)
      else
        Break;
    if not (op in [foAND, foOR]) then
      raise Exception.Create(SUnexpectedANDorOREh + Exp);
    FExpression.Relation := op;

    // 3 [Oper] + Values
    p := SkipBlanks(Exp, p);
    v := GetLexeme(Exp, p, op, PreferCommaForList);
    if op = foNon then
      if p <> Length(Exp) + 1 then
        raise Exception.Create(SIncorrectExpressionEh + Exp)
      else
        Break;
    if op = foValue then
    begin
      if VarIsArray(v) then
        FExpression.Operator2 := foIn
      else if FExpression.ExpressionType = botString then
        FExpression.Operator2 := foLike
      else
        FExpression.Operator2 := foEqual;
      FExpression.Operand2 := v;
    end
    else if (op = foNon) and (Length(Exp) <> 0) then
      raise Exception.Create(SErrorInExpressionEh + Exp)
    else
    begin
      if op in [foIn, foNotIn] then
        PreferCommaForList := True;
      p := SkipBlanks(Exp, p);
      v := GetLexeme(Exp, p, op1, PreferCommaForList);
      FExpression.Operator2 := op;
      if op1 = foNull then
        if op = foEqual then
          FExpression.Operator2 := foNull
        else if op = foNotEqual then
          FExpression.Operator2 := foNotNull
        else
          raise Exception.Create(SUnexpectedExpressionBeforeNullEh + Exp)
      else if op1 <> foValue then
        raise Exception.Create(SUnexpectedExpressionAfterOperatorEh + Exp);
      FExpression.Operand2 := v;
      ResetPreferCommaForList;
    end;
    Result := True;
    Break;
  end;

  if FExpression.Operator1 in [foEqual..foNotIn] then
    ConvertVarStrValues(FExpression.Operand1, FExpression.ExpressionType)
  else
    FExpression.Operand1 := Null;

  if FExpression.Operator2 in [foEqual..foNotIn] then
    ConvertVarStrValues(FExpression.Operand2, FExpression.ExpressionType)
  else
    FExpression.Operand2 := Null;
end;

function ParseSTFilterExpressionEh(Exp: String; var FExpression: TSTFilterExpressionEh): Boolean;

var
  PreferCommaForList: Boolean;

  procedure ResetPreferCommaForList;
  begin
    if (FExpression.ExpressionType = botNumber) and (DecimalSeparator = ',') then
      PreferCommaForList := False
    else
      PreferCommaForList := True;
  end;

var
  v: Variant;
  op, op1: TSTFilterOperatorEh;
  p: Integer;
begin
  Result := False;

  ResetPreferCommaForList;

  FExpression.Operator1 := foNon;
  FExpression.Operand1 := Null;
  FExpression.Relation := foNon;
  FExpression.Operator2 := foNon;
  FExpression.Operand2 := Null;

  Exp := Trim(Exp);
  if Exp = '' then
    Exit;
  // 1 [Oper] + Values
  p := SkipBlanks(Exp, 1);
  v := GetLexeme(Exp, p, op, PreferCommaForList);
  if op = foValue then
  begin
    if VarIsArray(v) then
      FExpression.Operator1 := foIn
    else if FExpression.ExpressionType = botString then
      FExpression.Operator1 := foLike
    else
      FExpression.Operator1 := foEqual;
    FExpression.Operand1 := v;
  end
  else if (op = foNon) and (Length(Exp) <> 0) then
    raise Exception.Create(SErrorInExpressionEh + Exp)
  else
  begin
    if op in [foIn, foNotIn] then
      PreferCommaForList := True;
    p := SkipBlanks(Exp, p);
    v := GetLexeme(Exp, p, op1, PreferCommaForList);
    FExpression.Operator1 := op;
    if op1 = foNull then
      if op = foEqual then
        FExpression.Operator1 := foNull
      else if op = foNotEqual then
        FExpression.Operator1 := foNotNull
      else
        raise Exception.Create(SUnexpectedExpressionBeforeNullEh + Exp)
    else if op1 <> foValue then
      raise Exception.Create(SUnexpectedExpressionAfterOperatorEh + Exp);
    FExpression.Operand1 := v;
    if op in [foIn, foNotIn] then
    begin
      p := SkipBlanks(Exp, p);
      if CharAtPos(Exp, p) = ')' then
        Inc(p)
      else
        raise Exception.Create(SRightBracketExpectedEh + Exp);
      ResetPreferCommaForList;
    end;
  end;

  while True do
  begin
    // 2 And or Or
    p := SkipBlanks(Exp, p);
    v := GetLexeme(Exp, p, op, PreferCommaForList);
    if op = foNon then
      if p <> Length(Exp) + 1 then
        raise Exception.Create(SIncorrectExpressionEh + Exp)
      else
        Break;
    if not (op in [foAND, foOR]) then
      raise Exception.Create(SUnexpectedANDorOREh + Exp);
    FExpression.Relation := op;

    // 3 [Oper] + Values
    p := SkipBlanks(Exp, p);
    v := GetLexeme(Exp, p, op, PreferCommaForList);
    if op = foNon then
      if p <> Length(Exp) + 1 then
        raise Exception.Create(SIncorrectExpressionEh + Exp)
      else
        Break;
    if op = foValue then
    begin
      if VarIsArray(v) then
        FExpression.Operator2 := foIn
      else if FExpression.ExpressionType = botString then
        FExpression.Operator2 := foLike
      else
        FExpression.Operator2 := foEqual;
      FExpression.Operand2 := v;
    end
    else if (op = foNon) and (Length(Exp) <> 0) then
      raise Exception.Create(SErrorInExpressionEh + Exp)
    else
    begin
      if op in [foIn, foNotIn] then
        PreferCommaForList := True;
      p := SkipBlanks(Exp, p);
      v := GetLexeme(Exp, p, op1, PreferCommaForList);
      FExpression.Operator2 := op;
      if op1 = foNull then
        if op = foEqual then
          FExpression.Operator2 := foNull
        else if op = foNotEqual then
          FExpression.Operator2 := foNotNull
        else
          raise Exception.Create(SUnexpectedExpressionBeforeNullEh + Exp)
      else if op1 <> foValue then
        raise Exception.Create(SUnexpectedExpressionAfterOperatorEh + Exp);
      FExpression.Operand2 := v;
      ResetPreferCommaForList;
    end;
    Result := True;
    Break;
  end;

  if FExpression.Operator1 in [foEqual..foNotIn] then
    ConvertVarStrValues(FExpression.Operand1, FExpression.ExpressionType)
  else
    FExpression.Operand1 := Null;

  if FExpression.Operator2 in [foEqual..foNotIn] then
    ConvertVarStrValues(FExpression.Operand2, FExpression.ExpressionType)
  else
    FExpression.Operand2 := Null;
end;

function GetExpressionAsFilterString(AGrid: TCustomDBGridEh;
  OneExpressionProc: TOneExpressionFilterStringProcEh;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
  UseFieldOrigin: Boolean = False;
  SupportsLocalLike: Boolean = False): String;

  function GetExpressionAsString(Column: TColumnEh): String;
  var
    FieldName: String;
  begin
    if Column.Field = nil then
      FieldName := ''
    else if UseFieldOrigin and (Column.Field.Origin <> '') and (Column.STFilter.DataField = '') then
      FieldName := Column.Field.Origin
//    else if (Column.STFilter.ListSource <> nil) or (Column.Filter.DataField <> '') then
//      FieldName := Column.Filter.DataField
    else
//      FieldName := Column. Field.FieldName;
      FieldName := Column.STFilter.GetFilterFieldName;
    Result := '';
    with Column.STFilter do
    begin
      if (Expression.ExpressionType = botNon) or (Column.Field = nil) or (Expression.Operator1 = foNon) then
        Exit;
//      if KeyField <> '' then
//        Result := OneExpressionProc(Expression.Operator1, FKeyValues, FieldName, AGrid.DataSource.DataSet, DateValueToSQLStringProc)
//      else
      begin
        Result := OneExpressionProc(Expression.Operator1, GetOperand1, FieldName,
          AGrid.DataSource.DataSet, DateValueToSQLStringProc, SupportsLocalLike);
        if Expression.Relation <> foNon then
        begin
          Result := Result + ' ' + STFilterOperatorsSQLStrMapEh[Expression.Relation];
          Result := Result + OneExpressionProc(Expression.Operator2, GetOperand2,
            FieldName, AGrid.DataSource.DataSet, DateValueToSQLStringProc, SupportsLocalLike);
        end
      end;
      if Expression.Relation = foOR then
        Result := '(' + Result + ')';
    end;
  end;
var
  i: Integer;
  s: String;
begin
  Result := '';
  if (AGrid.DataSource <> nil) and (AGrid.DataSource.DataSet <> nil)
//    and AGrid.DataSource.DataSet.Active KMV #4
  then
  begin
    for i := 0 to AGrid.Columns.Count - 1 do
    begin
      s := GetExpressionAsString(TColumnEh(AGrid.Columns[i]));
      if s <> '' then
        Result := Result + s + ' AND ';
    end;
    Delete(Result, Length(Result) - 3, 4);
  end;
end;

function GetOneExpressionAsLocalFilterString(O: TSTFilterOperatorEh; v: Variant;
  FieldName: String; DataSet: TDataSet;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh; SupportsLike: Boolean): String;

  function VarValueAsFilterStr(v: Variant): String;
  begin
    if VarType(v) = varDouble then
      Result := FloatToStr(v)
    else if VarType(v) = varDate then
      if @DateValueToSQLStringProc <> nil then
        Result := DateValueToSQLStringProc(Dataset, v)
      else
        Result := '''' + DateTimeToStr(v) + ''''
    else
      Result := '''' + VarToStr(v) + '''';
  end;

var
  i: Integer;
begin
  if O in [foIn, foNotIn] then
  begin
    Result := Result + ' (';
    if VarIsArray(v) then
      for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
        Result := Result + '[' + FieldName + '] = ' + VarValueAsFilterStr(v[i]) + ' OR '
    else
      Result := Result + '[' +FieldName + '] = ' + VarValueAsFilterStr(v) + ' OR ';
    Delete(Result, Length(Result) - 3, 4);
    Result := Result + ')';
  end
  else if O in [foLike, foNotLike] then
  begin
    Result := Result +  ' [' + FieldName;
    if SupportsLike then
      if O = foLike
        then Result := Result + '] Like '
        else Result := Result + '] Not Like '
    else
      if O = foLike
        then Result := Result + '] = '
        else Result := Result + '] <> ';
    Result := Result + VarValueAsFilterStr(v);
  end else
  begin
    Result := Result +  ' [' + FieldName +  '] ' + STFilterOperatorsSQLStrMapEh[O];
    if not (O in [foNull, foNotNull]) then
      Result := Result + ' ' + VarValueAsFilterStr(v);
  end;
end;

function GetOneExpressionAsSQLWhereString(O: TSTFilterOperatorEh; v: Variant;
  FieldName: String; DataSet: TDataSet;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh; SupportsLike: Boolean): String;

  function VarValueAsFilterStr(v: Variant): String;
  var
{$IFDEF CIL}
    OldDecimalSeparator: String;
{$ELSE}
    OldDecimalSeparator: Char;
{$ENDIF}
  begin
    if VarType(v) = varDouble then
    begin
      OldDecimalSeparator := DecimalSeparator;
      DecimalSeparator := '.';
      try
        Result := FloatToStr(v);
      finally
        DecimalSeparator := OldDecimalSeparator;
      end;
    end
    else if VarType(v) = varDate then
      if @DateValueToSQLStringProc <> nil then
        Result := DateValueToSQLStringProc(DataSet, v)
      else
        Result := '''' + VarToStr(v) + ''''
    else
      Result := '''' + VarToStr(v) + '''';
  end;

var
  i: Integer;
  theNOT: String;
begin
  if O in [foIn, foNotIn] then
  begin
    if O = foNotIn then
      theNOT := ' NOT'
    else
      theNOT := '';
    Result := Result + FieldName + theNOT + ' IN (';
    if VarIsArray(v) then
      for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
        Result := Result + VarValueAsFilterStr(v[i]) + ','
    else
      Result := Result + VarValueAsFilterStr(v) + ',';
    Delete(Result, Length(Result), 1);
    Result := Result + ')';
  end else
  begin
    Result := Result + ' ' + FieldName + ' ' + STFilterOperatorsSQLStrMapEh[O];
    if not (O in [foNull, foNotNull]) then
      Result := Result + ' ' + VarValueAsFilterStr(v);
  end;
end;

function DateValueToDataBaseSQLString(DataBaseName: String; v: Variant): String;
var
{$IFDEF CIL}
  OldDateSeparator: String;
{$ELSE}
  OldDateSeparator: Char;
{$ENDIF}
begin
  DataBaseName := UpperCase(DataBaseName);
  if DataBaseName = 'STANDARD' then
    Result := '''' + VarToStr(v) + ''''
  else if DataBaseName = 'ORACLE' then
    Result := 'TO_DATE(''' + FormatDateTime(ShortDateFormat, v) + ''',''' + ShortDateFormat + ''')'
  else if DataBaseName = 'INTRBASE' then
    Result := '''' + VarToStr(v) + ''''
  else if DataBaseName = 'INFORMIX' then
    Result := '''' + VarToStr(v) + ''''
  else if DataBaseName = 'MSACCESS' then
  begin
    OldDateSeparator := DateSeparator;
    try
      DateSeparator := '/';
      Result := '#' + FormatDateTime('MM/DD/YYYY', v) + '#';
    finally
      DateSeparator := OldDateSeparator;
    end;
  end
  else if DataBaseName = 'MSSQL' then
    Result := '''' + VarToStr(v) + ''''
  else if DataBaseName = 'SYBASE' then
    Result := '''' + VarToStr(v) + ''''
  else if DataBaseName = 'DB2' then
    Result := '''' + VarToStr(v) + ''''
  else
    Result := '''' + VarToStr(v) + '''';
end;

procedure ApplyFilterSQLBasedDataSet(Grid: TCustomDBGridEh;
  DateValueToSQLString: TDateValueToSQLStringProcEh; IsReopen: Boolean;
  SQLPropName: String);
var
  i, OrderLine: Integer;
  s: String;
  SQL: TStrings;
  SQLPropValue: WideString;
begin
  if not IsDataSetHaveSQLLikeProp(Grid.DataSource.DataSet, SQLPropName, SQLPropValue) then
    raise Exception.Create(Grid.DataSource.DataSet.ClassName + ' is not SQL based dataset');

  SQL := TStringList.Create;
  try
    SQL.Text := SQLPropValue;

    OrderLine := -1;
    for i := 0 to SQL.Count - 1 do
      if UpperCase(Copy(SQL[i], 1, Length(SQLFilterMarker))) = UpperCase(SQLFilterMarker) then
      begin
        OrderLine := i;
        Break;
      end;
    s := GetExpressionAsFilterString(Grid, GetOneExpressionAsSQLWhereString, DateValueToSQLString, True);
    if s = '' then
      s := '1=1';
    if OrderLine = -1 then
      Exit;
    Grid.DataSource.DataSet.DisableControls;
    try
      if Grid.DataSource.DataSet.Active then
        Grid.DataSource.DataSet.Close;
      SQL.Strings[OrderLine] := SQLFilterMarker + ' (' + s + ')';
      SetDataSetSQLLikeProp(Grid.DataSource.DataSet, SQLPropName, SQL.Text);
      if IsReopen then
        Grid.DataSource.DataSet.Open;
    finally
      Grid.DataSource.DataSet.EnableControls;
    end;

  finally
    SQL.Free;
  end;
end;

{ Sorting }

function IsSQLBasedDataSet(DataSet: TDataSet; var SQL: TStrings): Boolean;
var
  FPropInfo: PPropInfo;
begin
  Result := False;
  SQL := nil;
  FPropInfo := GetPropInfo(DataSet.ClassInfo, 'SQL');
  if FPropInfo = nil then Exit;
  if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkClass then
  try
    SQL := (TObject(GetOrdProp(DataSet, FPropInfo)) as TStrings);
  except // if PropInfo is not TStrings or not inherited of
  end;

  if SQL <> nil then
    Result := True;
end;

function IsDataSetHaveSQLLikeProp(DataSet: TDataSet; SQLPropName: String; var SQLPropValue: WideString): Boolean;
var
  FPropInfo: PPropInfo;
begin
  Result := False;
  SQLPropValue := '';
  FPropInfo := GetPropInfo(DataSet.ClassInfo, SQLPropName);
  if FPropInfo = nil then Exit;
  if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkString then
    SQLPropValue := GetStrProp(DataSet, FPropInfo)
{$IFDEF EH_LIB_6}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkWString then
    SQLPropValue := GetWideStrProp(DataSet, FPropInfo)
{$ELSE}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkWString then
    SQLPropValue := GetStrProp(DataSet, FPropInfo)
{$ENDIF}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkClass then
    try
      if (TObject(GetOrdProp(DataSet, FPropInfo)) as TStrings) <> nil then
        SQLPropValue := (TObject(GetOrdProp(DataSet, FPropInfo)) as TStrings).Text
{$IFDEF CIL}
{$ELSE}
  {$IFDEF EH_LIB_9}
      else if (TObject(GetOrdProp(DataSet, FPropInfo)) as TWideStrings) <> nil then
        SQLPropValue := (TObject(GetOrdProp(DataSet, FPropInfo)) as TWideStrings).Text
  {$ENDIF}
{$ENDIF}
      else
        Exit;
    except // if PropInfo is not TStrings or not inherited of
    end
  else Exit;
  Result := True;
end;

procedure ApplySortingForSQLBasedDataSet(Grid: TCustomDBGridEh; DataSet: TDataSet;
   UseFieldName: Boolean; IsReopen: Boolean; SQLPropName: String);

  function DeleteStr(str: String; sunstr: String): String;
  var
    i: Integer;
  begin
    i := Pos(sunstr, str);
    if i <> 0 then
      Delete(str, i, Length(sunstr));
    Result := str;
  end;

var
  i, OrderLine: Integer;
  s: String;
  SQL: TStrings;
  SQLPropValue: WideString;
begin
  if not IsDataSetHaveSQLLikeProp(DataSet, SQLPropName, SQLPropValue) then
    raise Exception.Create(DataSet.ClassName + ' is not SQL based dataset');

  SQL := TStringList.Create;
  try
    SQL.Text := SQLPropValue;

    s := '';
    for i := 0 to Grid.SortMarkedColumns.Count - 1 do
    begin
      if UseFieldName
        then s := s + Grid.SortMarkedColumns[i].FieldName
        else s := s + IntToStr(Grid.SortMarkedColumns[i].Field.FieldNo);
      if Grid.SortMarkedColumns[i].Title.SortMarker = smUpEh
        then s := s + ' DESC, '
        else s := s + ', ';
    end;

    if s <> '' then
      s := 'ORDER BY ' + Copy(s, 1, Length(s) - 2);

    OrderLine := -1;
    for i := 0 to SQL.Count - 1 do
      if UpperCase(Copy(SQL[i], 1, Length('ORDER BY'))) = 'ORDER BY' then
      begin
        OrderLine := i;
        Break;
      end;
    if OrderLine = -1 then
    begin
      SQL.Add('');
      OrderLine := SQL.Count-1;
    end;

    SQL.Strings[OrderLine] := s;

    DataSet.DisableControls;
    try
      if DataSet.Active then
        DataSet.Close;
      SetDataSetSQLLikeProp(DataSet, SQLPropName, SQL.Text);
      if IsReopen then
        DataSet.Open;
    finally
      DataSet.EnableControls;
    end;

  finally
    SQL.Free;
  end;
end;

function LocateDatasetTextEh(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TreeFindRange: TLocateTextTreeFindRangeEh): Boolean;
var
  FCurInListColIndex: Integer;

  function CheckEofBof: Boolean;
  begin
    if (Direction = ltdUpEh)
      then Result := AGrid.DataSource.DataSet.Bof
      else Result := AGrid.DataSource.DataSet.Eof;
  end;

  procedure ToNextRec;
  begin
    if ltoAllFieldsEh in AOptions then
      if (Direction = ltdUpEh) then
      begin
        if FCurInListColIndex > 0 then
          Dec(FCurInListColIndex)
        else
        begin
          AGrid.DataSource.DataSet.Prior;
          FCurInListColIndex := AGrid.VisibleColCount-1;
        end;
      end else
      begin
        if FCurInListColIndex < AGrid.VisibleColCount-1 then
          Inc(FCurInListColIndex)
        else
        begin
          AGrid.DataSource.DataSet.Next;
          FCurInListColIndex := 0;
        end;
      end
    else if (Direction = ltdUpEh) then
      AGrid.DataSource.DataSet.Prior
    else
      AGrid.DataSource.DataSet.Next;
  end;

  function ColText(Col: TColumnEh): String;
  begin
    if ltoMatchFormatEh in AOptions then
      Result := Col.DisplayText
    else if Col.Field <> nil then
      Result := Col.Field.AsString
    else
      Result := '';
  end;

  function AnsiContainsText(const AText, ASubText: string): Boolean;
  begin
    Result := AnsiPos(AnsiUppercase(ASubText), AnsiUppercase(AText)) > 0;
  end;

  function AnsiContainsStr(const AText, ASubText: string): Boolean;
  begin
    Result := AnsiPos(ASubText, AText) > 0;
  end;

  function IsEscapeInPressed: Boolean;
  var Msg: TMsg;
  begin
    Result := False;
    if PeekMessage(Msg, AGrid.Handle, WM_KEYDOWN, WM_KEYDOWN, PM_NOREMOVE) then
      if Msg.wParam = VK_ESCAPE then
        Result := True;
  end;

var
  DataText: String;
begin
  Result := False;
  if Assigned(AGrid) and Assigned(AGrid.DataSource) and Assigned(AGrid.DataSource.DataSet)
    and AGrid.DataSource.DataSet.Active
  then
  begin
//    FCurInListColIndex := AGrid.SelectedIndex;
    if FieldName <> '' then
      FCurInListColIndex := AGrid.VisibleColumns.IndexOf(AGrid.FieldColumns[FieldName])
    else
      FCurInListColIndex := AGrid.VisibleColumns.IndexOf(AGrid.Columns[AGrid.SelectedIndex]);
    if (dgRowSelect in AGrid.Options) and (FieldName = '') then
    begin
{      if (Direction = ltdUpEh)
        then FCurInListColIndex := 0
        else FCurInListColIndex := AGrid.VisibleColCount-1;}
      FCurInListColIndex := AGrid.VisibleColumns.IndexOf(
          AGrid.Columns[AGrid.LeftCol-AGrid.IndicatorOffset]);
    end;
    if (AGrid.VisibleColCount = 0) then Exit;
    with AGrid do
    begin
      AGrid.DataSource.DataSet.DisableControls;
      try
        SaveBookmark;
//        if (Direction = ltdAllEh) and IsFirstTry then
        if (Direction = ltdAllEh) then
          AGrid.DataSource.DataSet.First
//        if not IsFirstTry then
//        if ltoIgnoteCurrentPosEh in AOptions then
        else
          ToNextRec;
        while not CheckEofBof do
        begin
          DataText := ColText(AGrid.VisibleColumns[FCurInListColIndex]);
          //CharCase
          if not (ltoCaseInsensitiveEh in AOptions) then
          begin
            //From any part of field
            if ( (Matching = ltmAnyPartEh) and (
                AnsiContainsStr(DataText, Text) )
               ) or (
            //Whole field
              (Matching = ltmWholeEh) and (DataText = Text)
              ) or ((Matching = ltmFromBegingEh) and
            //From beging of field
              (Copy(DataText, 1, Length(Text)) = Text) )
            then
            begin
              Result := True;
//              IsFirstTry := False;
              Break;
            end
          end else
          //From any part of field
          if ( (Matching = ltmAnyPartEh) and (
              AnsiContainsText(DataText, Text) )
             ) or (
          //Whole field
            (Matching = ltmWholeEh) and (
            AnsiUpperCase(DataText) =
            AnsiUpperCase(Text))
            ) or ((Matching = ltmFromBegingEh) and
          //From beging of field
            (AnsiUpperCase(Copy(DataText, 1, Length(Text))) =
            AnsiUpperCase(Text)) ) then
          begin
            Result := True;
            AGrid.SelectedIndex := AGrid.VisibleColumns[FCurInListColIndex].Index;
//            IsFirstTry := False;
            Break;
          end;
          if (ltoStopOnEscape in AOptions) and
             IsEscapeInPressed
          then
            Break;
          ToNextRec;
        end;
        if not Result then RestoreBookmark;
      finally
        AGrid.DataSource.DataSet.EnableControls;
      end;
//      if not RecordFounded then
//        ShowMessage(Format(SFindDialogStringNotFoundMessageEh, [cbText.Text]));
    end;
  end;
end;

{ Dataset Features }

var
  DatasetFeaturesList: TStringList;

procedure RegisterDatasetFeaturesEh(DatasetFeaturesClass: TDatasetFeaturesEhClass;
  DataSetClass: TDataSetClass);
var
  DatasetFeatures: TDatasetFeaturesEh;
  ClassIndex: Integer;
begin
  DatasetFeatures := DatasetFeaturesClass.Create;
  DatasetFeatures.FDataSetClass := DataSetClass;
  if DatasetFeatures.FDataSetClass = nil then
    Exit;
  ClassIndex := DatasetFeaturesList.IndexOf(DatasetFeatures.FDataSetClass.ClassName);
  if ClassIndex >= 0
    then DatasetFeaturesList.Objects[ClassIndex] := DatasetFeatures
    else DatasetFeaturesList.AddObject(DatasetFeatures.FDataSetClass.ClassName,
            DatasetFeatures);
end;

procedure UnregisterDatasetFeaturesEh(DataSetClass: TDataSetClass);
var
  idx: Integer;
begin
  idx := DatasetFeaturesList.IndexOf(DataSetClass.ClassName);
  if idx >= 0 then
  begin
//    Dispose(Pointer(DatasetFeaturesList.Objects[idx]));
    TObject(DatasetFeaturesList.Objects[idx]).Free;
    DatasetFeaturesList.Delete(idx);
  end;
end;

function GetDatasetFeaturesForDataSetClass(DataSetClass: TClass): TDatasetFeaturesEh;

  function GetDatasetFeaturesDeep(DataSetClass: TClass; DataSetClassName: String): Integer;
  begin
    Result := 0;
    while True do
    begin
      if UpperCase(DataSetClass.ClassName) = UpperCase(DataSetClassName) then
        Exit;
      Inc(Result);
      DataSetClass := DataSetClass.ClassParent;
      if DataSetClass = nil then
      begin
        Result := MAXINT;
        Exit;
      end;
    end;
  end;

var
  Deep, MeenDeep, i: Integer;
  ClassName: String;
begin
  Result := nil;
  MeenDeep := MAXINT;
  for i := 0 to DatasetFeaturesList.Count - 1 do
  begin
    if DataSetClass.InheritsFrom(TDatasetFeaturesEh(DatasetFeaturesList.Objects[i]).FDataSetClass) then
    begin
      ClassName := TDatasetFeaturesEh(DatasetFeaturesList.Objects[i]).FDataSetClass.ClassName;
      Deep := GetDatasetFeaturesDeep(DataSetClass, ClassName);
      if Deep < MeenDeep then
      begin
        MeenDeep := Deep;
        Result := TDatasetFeaturesEh(DatasetFeaturesList.Objects[i]);
      end;
    end;
  end;
end;

function GetDatasetFeaturesForDataSet(DataSet: TDataSet): TDatasetFeaturesEh;
begin
  Result := GetDatasetFeaturesForDataSetClass(DataSet.ClassType);
end;

procedure DisposeDatasetFeaturesList;
begin
  while DatasetFeaturesList.Count > 0 do
  begin
//    Dispose(Pointer(DatasetFeaturesList.Objects[0]));
    TObject(DatasetFeaturesList.Objects[0]).Free;
    DatasetFeaturesList.Delete(0);
  end;
  FreeAndNil(DatasetFeaturesList);
//  DatasetFeaturesList := nil;
end;

{ TDatasetFeaturesEh }

procedure TDatasetFeaturesEh.ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
begin
end;

procedure TDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
begin
end;

constructor TDatasetFeaturesEh.Create;
begin
  inherited Create;
end;

function TDatasetFeaturesEh.LocateText(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TreeFindRange: TLocateTextTreeFindRangeEh): Boolean;
begin
  Result := LocateDatasetTextEh(AGrid, FieldName, Text, AOptions, Direction, Matching, TreeFindRange);
end;

function TDatasetFeaturesEh.MoveRecords(Sender: TObject; BookmarkList: TBMListEh;
  ToRecNo: Integer; CheckOnly: Boolean): Boolean;
var
  va: array of Variant;
  vs: array of Boolean;
//  bm: TBookmarkStr;
  i, j: Integer;
  IsAppend: Boolean;
  DataSet: TDataSet;
  LocBookmarkList: TBMListEh;
begin
  Result := False;
  LocBookmarkList := nil;
  if (Sender is TDBGridEh)
    then DataSet := TDBGridEh(Sender).DataSource.DataSet
    else Exit;
  Result := DataSet.CanModify;
  if CheckOnly or not Result then Exit;
  DataSet.DisableControls;
  try
    LocBookmarkList := TBMListEh.Create;
//    LocBookmarkList.Assign(BookmarkList);
    for I := 0 to BookmarkList.Count - 1 do
//      LocBookmarkList.AppendItem(BookmarkList[i]);
      LocBookmarkList.InsertItem(0, BookmarkList[i]);

    if ToRecNo >= DataSet.RecordCount
      then IsAppend := True
      else IsAppend := False;
//    bm := DataSet.Bookmark;
    SetLength(va, BookmarkList.Count);
    SetLength(vs, BookmarkList.Count);
    for i := 0 to LocBookmarkList.Count-1 do
    begin
      DataSet.Bookmark := LocBookmarkList[i];
      va[i] := VarArrayCreate([0, DataSet.Fields.Count], varVariant);
      for j := 0 to DataSet.Fields.Count-1 do
        va[i][j] := DataSet.Fields[j].Value;
      if (i > 0) and (ToRecNo > DataSet.RecNo) then
        Dec(ToRecNo);
      vs[i] := TDBGridEh(Sender).SelectedRows.CurrentRowSelected;
      TDBGridEh(Sender).SelectedRows.CurrentRowSelected := False;
    end;
    for i := 0 to LocBookmarkList.Count-1 do
    begin
      DataSet.Bookmark := LocBookmarkList[i];
      DataSet.Delete;
    end;
    for i := Length(va)-1 downto 0 do
    begin
      if IsAppend then
        DataSet.Append
      else
      begin
        if i < Length(va)-1
          then DataSet.Next
          else DataSet.RecNo := ToRecNo;
        DataSet.Insert;
      end;
      for j := 0 to DataSet.Fields.Count-1 do
        if DataSet.Fields[j].CanModify then
          DataSet.Fields[j].Value := va[i][j];
      DataSet.Post;
      TDBGridEh(Sender).SelectedRows.CurrentRowSelected := vs[i];
    end;
//    DataSet.Bookmark := bm;
  finally
    LocBookmarkList.Free;
    DataSet.EnableControls;
  end;
end;

procedure TDatasetFeaturesEh.ExecuteFindDialog(Sender: TObject;
  Text, FieldName: String; Modal: Boolean);
begin
  if (Sender is TDBGridEh) then
    ExecuteDBGridEhFindDialogProc(TDBGridEh(Sender), Text, '', nil, Modal);
end;

{ TSQLDatasetFeaturesEh }

procedure TSQLDatasetFeaturesEh.ApplyFilter(Sender: TObject;
  DataSet: TDataSet; IsReopen: Boolean);
begin
  if TDBGridEh(Sender).STFilter.Local then
  begin
    TDBGridEh(Sender).DataSource.DataSet.Filter :=
      GetExpressionAsFilterString(TDBGridEh(Sender),
        GetOneExpressionAsLocalFilterString, nil, False, SupportsLocalLike);
    TDBGridEh(Sender).DataSource.DataSet.Filtered := True;        
  end else
    ApplyFilterSQLBasedDataSet(TDBGridEh(Sender), DateValueToSQLString, IsReopen, SQLPropName);
end;

procedure TSQLDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
begin
  if Sender is TCustomDBGridEh then
    if TCustomDBGridEh(Sender).SortLocal then
      raise Exception.Create(Format ('TSQLDatasetFeaturesEh can not sort data ' +
        'in dataset "%s" in local mode', [DataSet.Name]))
    else
      ApplySortingForSQLBasedDataSet(TCustomDBGridEh(Sender), DataSet,
        SortUsingFieldName, IsReopen, SQLPropName);
end;

constructor TSQLDatasetFeaturesEh.Create;
begin
  inherited Create;
  SQLPropName := 'SQL';
end;

{ TCommandTextDatasetFeaturesEh }

constructor TCommandTextDatasetFeaturesEh.Create;
begin
  inherited Create;
  SQLPropName := 'CommandText';
end;

initialization
  DatasetFeaturesList := TStringList.Create;
  //  DatasetFeaturesList.CaseSensitive := False;
  DatasetFeaturesList.Duplicates := dupError;
finalization
  DisposeDatasetFeaturesList;
end.
