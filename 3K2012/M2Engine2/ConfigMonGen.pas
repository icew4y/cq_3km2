unit ConfigMonGen;

interface

uses
  SysUtils, Classes, Controls, Forms,
  StdCtrls;

type
  TfrmConfigMonGen = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    Button1: TButton;
    Button3: TButton;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    GroupBox3: TGroupBox;
    ListBoxMonGen: TListBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmConfigMonGen: TfrmConfigMonGen;

implementation

uses UsrEngn, M2Share;

{$R *.dfm}

{ TfrmConfigMonGen }
function FindFile(AList: TStrings; const APath: TFileName;
    const Ext: String; const Recurisive: Boolean): Integer;
var
  FSearchRec: TSearchRec;
  FPath: TFileName;
  str: string;
begin
  Result := -1;
  Application.ProcessMessages;
  if Assigned(AList) then
  try
    FPath := IncludeTrailingPathDelimiter(APath);
    if FindFirst(FPath + '*.*', faAnyFile, FSearchRec) = 0 then
      repeat
        if (FSearchRec.Attr and faDirectory) = faDirectory then begin
         if Recurisive and (FSearchRec.Name <> '.') and (FSearchRec.Name <> '..') then
            FindFile(AList, FPath + FSearchRec.Name, Ext, Recurisive);
        end
        else if SameText(Ext, '.*') or
          SameText(LowerCase(Ext), LowerCase(ExtractFileExt(FSearchRec.Name))) then begin
            str:= copy(FPath + FSearchRec.Name,pos('MonItems',FPath + FSearchRec.Name)+9,Length(FPath + FSearchRec.Name));
            AList.Add(str);
         end;
      until FindNext(FSearchRec) <> 0;
  finally
    SysUtils.FindClose(FSearchRec);
    Result := AList.Count;
  end;
end;

procedure TfrmConfigMonGen.Open;
var
  I: Integer;
  MonGen: pTMonGenInfo;
begin
  for I := 0 to UserEngine.m_MonGenList.Count - 1 do begin
    MonGen := UserEngine.m_MonGenList.Items[I];
    if MonGen.sMapName <> '' then begin//20110527 Ôö¼Ó
      ListBoxMonGen.Items.AddObject(MonGen.sMapName + '(' + IntToStr(MonGen.nX) + ':' + IntToStr(MonGen.nY) + ')' + '-' + MonGen.sMonName+'('+IntToStr(UserEngine.GetGenMonCount(MonGen))+'/'+IntToStr(MonGen.nCount)+')', TObject(MonGen));
    end;
  end;
  Self.ShowModal;
end;

procedure TfrmConfigMonGen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;//20080119
end;

procedure TfrmConfigMonGen.FormDestroy(Sender: TObject);
begin
  frmConfigMonGen:=nil;//20080119
end;

procedure TfrmConfigMonGen.Button1Click(Sender: TObject);
begin
  Listbox1.Items.Clear;
  FindFile(ListBox1.Items, g_Config.sEnvirDir + 'MonItems','.Txt',True);
end;

procedure TfrmConfigMonGen.Button3Click(Sender: TObject);
var
  LoadList : TStringList;
  i :Integer;
  sMonGenFile	: String;
begin
  if ListBox1.ItemIndex < 0 then ListBox1.ItemIndex:= 0;
  sMonGenFile:= g_Config.sEnvirDir + 'MonItems\' + ListBox1.Items.Strings [ListBox1.ItemIndex];
  LoadList:=TStringList.Create;
  try
    for i:=0 to  Memo1.Lines.Count - 1 do LoadList.Add(Memo1.Lines.Strings[i]);
    LoadList.SaveToFile(sMonGenFile);
  finally
    LoadList.free;
  end;
end;

procedure TfrmConfigMonGen.ListBox1Click(Sender: TObject);
var
  LoadList: TStringList;
  I: Integer;
  LineText, sMonGenFile: String;
begin
  Memo1.Clear;
  sMonGenFile:=g_Config.sEnvirDir + 'MonItems\' + ListBox1.Items.Strings [ListBox1.ItemIndex];
  if FileExists(sMonGenFile) then begin
    LoadList:=TStringList.Create;
    try
      LoadList.LoadFromFile(sMonGenFile);
      for I := 0 to LoadList.Count - 1 do begin
        LineText:=LoadList.Strings[I];
        if (LineText = '') or (LineText[1] = ';') then Continue;
        Memo1.Lines.Add(LineText);
      end;
    finally
      LoadList.Free;
    end;
  end;
end;

end.
