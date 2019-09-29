unit u_QuickSort;

{LTist 快速排序}
interface

uses
  sysUtils,classes,Dialogs;

type
  TtdCompareFunc = function (aData1, aData2 : pointer) : Longint;   {函数类型}

procedure QSS(aList : TList; aFirst : Longint; aLast : Longint; aCompare : TtdCompareFunc);
{-基本QuickSort}
procedure TDQuickSortStd(aList : TList; aFirst : Longint; aLast : Longint; aCompare : TtdCompareFunc);
{-基本QuickSort的驱动过程}
procedure QSNR(aList: TList; aFirst: Longint; aLast: Longint; aCompare : TtdCompareFunc);
{-非递归QuickSort}
procedure TDQuickSortNoRecurse(aList: TList; aFirst: Longint;aLast: Longint;aCompare: TtdCompareFunc);
{-非递归QuickSort的驱动过程}
procedure QSR(aList : TList;aFirst: Longint;aLast: Longint;aCompare : TtdCompareFunc);
{-随机支点的Quicksort}
procedure TDQuickSortRandom(aList: TList;aFirst: Longint;aLast: Longint;aCompare : TtdCompareFunc);
{-随机支点的Quicksort的驱动过程}
procedure TDQuickSortMedian(aList : TList;aFirst: Longint;aLast: Longint;aCompare : TtdCompareFunc);
{-3个支点QuickSort的驱动过程}
procedure QSInsertionSort(aList : TList;aFirst: Longint;aLast : Longint;aCompare : TtdCompareFunc);
{-为究极QuickSort服务的InsertionSort}
procedure QS(aList : TList; aFirst: Longint;aLast : Longint;aCompare : TtdCompareFunc);
{-究极QuickSort}
procedure TDQuickSort(aList : TList; aFirst: Longint; aLast : Longint; aCompare : TtdCompareFunc);
{-究极QuickSort的驱动过程}

{检查范围是否合法}
procedure TDValidateListRange(aList : TList; aStart, aEnd : Longint);

implementation
{===基本QuickSort===============================================}
procedure QSS(aList : TList; aFirst: Longint;aLast : Longint;aCompare : TtdCompareFunc);
var
  L, R  : Longint;
  Pivot : pointer;
  Temp  : pointer;
begin
  {若至少有两个元素}
  while (aFirst < aLast) do begin
    {支点为中点元素}
    Pivot := aList.List[(aFirst+aLast) div 2];
    {设置引索进行划分}
    L := pred(aFirst);
    R := succ(aLast);
    while true do begin
      repeat dec(R); until (aCompare(aList.List[R], Pivot) <= 0);
      repeat inc(L); until (aCompare(aList.List[L], Pivot) >= 0);
      if (L >= R) then Break;
      Temp := aList.List[L];
      aList.List[L] := aList.List[R];
      aList.List[R] := Temp;
    end;
    {对第一个子集进行quicksort}
    if (aFirst < R) then QSS(aList, aFirst, R, aCompare);
    {对第二个子集进行quicksort}
    aFirst := succ(R);
  end;
end;

procedure TDQuickSortStd(aList : TList; aFirst: Longint; aLast: Longint; aCompare : TtdCompareFunc);
begin
  TDValidateListRange(aList, aFirst, aLast);
  QSS(aList, aFirst, aLast, aCompare);
end;
{====================================================================}
procedure QSNR(aList : TList; aFirst: Longint; aLast: Longint; aCompare : TtdCompareFunc);
var
  L, R  : Longint;
  Pivot : pointer;
  Temp  : pointer;
  Stack : array [0..63] of Longint;
  SP    : Longint;
begin
  {初始化栈}
  Stack[0] := aFirst;
  Stack[1] := aLast;
  SP := 2;
  while (SP <> 0) do begin
    {弹出栈顶子表}
    dec(SP, 2);
    aFirst := Stack[SP];
    aLast := Stack[SP+1];
    {若至少有两个元素}
    while (aFirst < aLast) do begin
      {支点为中间元素}
      Pivot := aList.List[(aFirst+aLast) div 2];
      {设置引索并进行划分}
      L := pred(aFirst);
      R := succ(aLast);
      while true do begin
        repeat dec(R); until (aCompare(aList.List[R], Pivot) <= 0);
        repeat inc(L); until (aCompare(aList.List[L], Pivot) >= 0);
        if (L >= R) then Break;
        Temp := aList.List[L];
        aList.List[L] := aList.List[R];
        aList.List[R] := Temp;
      end;
      {将大一些的子表压入栈，并对小子表处理}
      if (R - aFirst) < (aLast - R) then begin
        Stack[SP] := succ(R);
        Stack[SP+1] := aLast;
        inc(SP, 2);
        aLast := R;
      end else begin
        Stack[SP] := aFirst;
        Stack[SP+1] := R;
        inc(SP, 2);
        aFirst := succ(R);
      end;
    end;
  end;
end;
procedure TDQuickSortNoRecurse(aList: TList; aFirst : Longint;aLast: Longint;aCompare : TtdCompareFunc);
begin
  TDValidateListRange(aList, aFirst, aLast);
  QSNR(aList, aFirst, aLast, aCompare);
end;
{====================================================================}
procedure QSR(aList : TList;aFirst: Longint;aLast : Longint;aCompare : TtdCompareFunc);
var
  L, R  : Longint;
  Pivot : pointer;
  Temp  : pointer;
begin
  while (aFirst < aLast) do begin
    {选择一个随机元素做支点}
    R := aFirst + Random(aLast - aFirst + 1);
    L := (aFirst + aLast) div 2;
    Pivot := aList.List[R];
    aList.List[R] := aList.List[L];
    aList.List[L] := Pivot;
    {设置引索并进行划分}
    L := pred(aFirst);
    R := succ(aLast);
    while true do begin
      repeat dec(R); until (aCompare(aList.List[R], Pivot) <= 0);
      repeat inc(L); until (aCompare(aList.List[L], Pivot) >= 0);
      if (L >= R) then Break;
      Temp := aList.List[L];
      aList.List[L] := aList.List[R];
      aList.List[R] := Temp;
    end;
    {对第一个子集进行quicksort}
    if (aFirst < R) then QSR(aList, aFirst, R, aCompare);
    {对第二个子集进行quicksort}
    aFirst := succ(R);
  end;
end;

procedure TDQuickSortRandom(aList : TList; aFirst: Longint; aLast: Longint; aCompare : TtdCompareFunc);
begin
  TDValidateListRange(aList, aFirst, aLast);
  QSR(aList, aFirst, aLast, aCompare);
end;
{====================================================================}
procedure QSM(aList: TList; aFirst: Longint; aLast: Longint; aCompare : TtdCompareFunc);
var
  L, R  : Longint;
  Pivot : pointer;
  Temp  : pointer;
begin
  while (aFirst < aLast) do begin
    {若有3个或更多的元素，选择第一个元素，最后一个元素，中间元素做支点}
    if (aLast - aFirst) >= 2 then begin
      R := (aFirst + aLast) div 2;
      if (aCompare(aList.List[aFirst], aList.List[R]) > 0) then begin
        Temp := aList.List[aFirst];
        aList.List[aFirst] := aList.List[R];
        aList.List[R] := Temp;
      end;
      if (aCompare(aList.List[aFirst], aList.List[aLast]) > 0) then begin
        Temp := aList.List[aFirst];
        aList.List[aFirst] := aList.List[aLast];
        aList.List[aLast] := Temp;
      end;
      if (aCompare(aList.List[R], aList.List[aLast]) > 0) then begin
        Temp := aList.List[R];
        aList.List[R] := aList.List[aLast];
        aList.List[aLast] := Temp;
      end;
      Pivot := aList.List[R];
    end
    {若只有两个元素，选第一个做支点}
    else
      Pivot := aList.List[aFirst];
    {设置引索并进行划分}
    L := pred(aFirst);
    R := succ(aLast);
    while true do begin
      repeat dec(R); until (aCompare(aList.List[R], Pivot) <= 0);
      repeat inc(L); until (aCompare(aList.List[L], Pivot) >= 0);
      if (L >= R) then Break;
      Temp := aList.List[L];
      aList.List[L] := aList.List[R];
      aList.List[R] := Temp;
    end;
    { 对第一个子集进行quicksort}
    if (aFirst < R) then QSM(aList, aFirst, R, aCompare);
    {对第二个子集进行quicksort}
    aFirst := succ(R);
  end;
end;
{--------}
procedure TDQuickSortMedian(aList: TList;aFirst: Longint;aLast: Longint; aCompare : TtdCompareFunc);
begin
  TDValidateListRange(aList, aFirst, aLast);
  QSM(aList, aFirst, aLast, aCompare);
end;
{====================================================================}

const
  QSCutOff = 15;
procedure QSInsertionSort(aList : TList;aFirst: Longint;aLast : Longint; aCompare : TtdCompareFunc);
var
  i, j       : Longint;
  IndexOfMin : Longint;
  Temp       : pointer;
begin
  {找到最小元素，并将其放到第一位}
  IndexOfMin := aFirst;
  j := QSCutOff;
  if (j > aLast) then j := aLast;
  for i := succ(aFirst) to j do
    if (aCompare(aList.List[i], aList.List[IndexOfMin]) < 0) then IndexOfMin := i;
  if (aFirst <> IndexOfMin) then begin
    Temp := aList.List[aFirst];
    aList.List[aFirst] := aList.List[IndexOfMin];
    aList.List[IndexOfMin] := Temp;
  end;
  {进行quicksort}
  for i := aFirst+2 to aLast do begin
    Temp := aList.List[i];
    j := i;
    while (aCompare(Temp, aList.List[j-1]) < 0) do begin
      aList.List[j] := aList.List[j-1];
      Dec(j);
    end;
    aList.List[j] := Temp;
  end;
end;

{--------}
procedure QS(aList : TList; aFirst: Longint; aLast : Longint; aCompare : TtdCompareFunc);
var
  L, R  : Longint;
  Pivot : pointer;
  Temp  : pointer;
  Stack : array [0..63] of Longint;
  SP    : Longint;
begin
  {初始化栈}
  Stack[0] := aFirst;
  Stack[1] := aLast;
  SP := 2;
  {栈中有子表时}
  while (SP <> 0) do begin
    {弹出栈顶子表}
    dec(SP, 2);
    aFirst := Stack[SP];
    aLast := Stack[SP+1];
    {若子表有足够元素，则进行循环}
    while ((aLast - aFirst) > QSCutOff) do begin
      {若有3个或更多的元素，选择第一个元素，最后一个元素，中间元素做支点}
      R := (aFirst + aLast) div 2;
      if (aCompare(aList.List[aFirst], aList.List[R]) > 0) then begin
        Temp := aList.List[aFirst];
        aList.List[aFirst] := aList.List[R];
        aList.List[R] := Temp;
      end;
      if (aCompare(aList.List[aFirst], aList.List[aLast]) > 0) then begin
        Temp := aList.List[aFirst];
        aList.List[aFirst] := aList.List[aLast];
        aList.List[aLast] := Temp;
      end;
      if (aCompare(aList.List[R], aList.List[aLast]) > 0) then begin
        Temp := aList.List[R];
        aList.List[R] := aList.List[aLast];
        aList.List[aLast] := Temp;
      end;
      Pivot := aList.List[R];
      {设置引索并进行划分}
      L := aFirst;
      R := aLast;
      while true do begin
        repeat dec(R); until (aCompare(aList.List[R], Pivot) <= 0);
        repeat inc(L); until (aCompare(aList.List[L], Pivot) >= 0);
        if (L >= R) then Break;
        Temp := aList.List[L];
        aList.List[L] := aList.List[R];
        aList.List[R] := Temp;
      end;

      {将大一些的子表压入栈，并对小子表处理}
      if (R - aFirst) < (aLast - R) then begin
        Stack[SP] := succ(R);
        Stack[SP+1] := aLast;
        inc(SP, 2);
        aLast := R;
      end else begin
        Stack[SP] := aFirst;
        Stack[SP+1] := R;
        inc(SP, 2);
        aFirst := succ(R);
      end;
    end;
  end;
end;

procedure TDQuickSort(aList: TList; aFirst: Longint; aLast: Longint;aCompare : TtdCompareFunc);
begin
  TDValidateListRange(aList, aFirst, aLast);
  QS(aList, aFirst, aLast, aCompare);
  QSInsertionSort(aList, aFirst, aLast, aCompare);
  QSS(aList, aFirst, aLast, aCompare);
end;

{检查范围是否合法}
procedure TDValidateListRange(aList : TList; aStart, aEnd : Longint);
begin
  if (aList = nil) then Exit;
  if (aStart < 0) or (aStart >= aList.Count) or (aEnd < 0) or (aEnd >= aList.Count) or //检查范围是否越界
     (aStart > aEnd) then Exit;
end;

end.

