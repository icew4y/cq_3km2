{------------------------------------------------------------------------------}
{ 单元名称: GClearServer.pas                                                   }
{                                                                              }
{ 创建日期: 2008-02-22 20:30:00                                                }
{                                                                              }
{ 功能介绍:                                                                    }
{   实现开区清空服务器数据                                                     }
{                                                                              }
{ 使用说明:                                                                    }
{                                                                              }
{                                                                              }
{ 更新历史:                                                                    }
{                                                                              }
{ 尚存问题:                                                                    }
{                                                                              }
{                                                                              }
{------------------------------------------------------------------------------}
unit GClearServer;

interface
uses StdCtrls, Windows, forms, Inifiles, SysUtils, GShare, GMain , Dialogs,ShellApi;

procedure ListBoxAdd(ListBox: TListBox; AddStr:string);  //增加ListBox记录
procedure ListBoxDel(ListBox: TListBox);   //删除ListBox某条记录
function ClearGlobal(FileName: string):Boolean;//清全局变量
function DeleteTree(s: string):Boolean;//删除目录
function ClearWriteINI(FileName,ini1,ini2,ini3:string):Boolean; //写INI文件
procedure ClearTxt(TxtName: string); //清空TXT文件
procedure ListBoxClearTxtFile(ListBox: TListBox); //清空ListBox里的Txt文件
procedure ListBoxDelFile(ListBox: TListBox);      //删除ListBox里的文件
function ListBoxDelDir(ListBox: TListBox):Boolean; //清空ListBod里的目录
function Clear_IniConf(): Boolean;      //写配置信息
procedure Clear_LoadIniConf();  //读取配置信息

procedure ClearModValue();  //使保存按钮正常使用

var
  GlobalVal:  array[0..999] of Integer;
  GlobalAVal: array[0..999] of string;
  g_sClearError: string;
implementation

procedure ClearModValue();
begin
  frmMain.ClearSaveBtn.Enabled := True;
end;

function ClearGlobal(FileName: string):Boolean;
var
  Config: TIniFile;
  I:integer;
begin
  Result := False;
  Config := TIniFile.Create(FileName);
  try
    for I := Low(GlobalVal) to High(GlobalVal) do begin
      Config.WriteInteger('Setup', 'GlobalVal' + IntToStr(I), 0);
      Config.WriteString('Setup', 'GlobalStrVal' + IntToStr(I), '');
    end;
    {for I := Low(GlobalAVal) to High(GlobalAVal) do begin
      Config.WriteString('Setup', 'GlobalStrVal' + IntToStr(I), '');
    end;}
  finally
    Config.Free;
  end;
  //sleep(2000);
  Result := True;
end;

procedure ListBoxAdd(ListBox: TListBox; AddStr:string);
var i: Integer;
begin
    for i:=0 to ListBox.Items.Count - 1 do
    begin
      if ListBox.Items.Strings [i] = AddStr then
      begin
        application.MessageBox('此文件路径已在列表中，请重新选择！！','提示信息',MB_ICONASTERISK);
        Exit;
      end;
    end;
    ListBox.Items.Add(AddStr);
end;

procedure ListBoxDel(ListBox: TListBox);
begin
    ListBox.Items.BeginUpdate;
  try
    ListBox.DeleteSelected;
  finally
    ListBox.Items.EndUpdate;
  end;
end;


//删除目录到回收站
function DeleteFileWithUndo(sFileName : string): boolean;
var
  T : TSHFileOpStruct;
begin 
  FillChar(T, SizeOf(T), 0 );
  with T do begin
   wFunc  := FO_DELETE;
   pFrom  := PChar(sFileName);
   fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION or FOF_SILENT;
  end;
  Result := ( 0 = ShFileOperation(T));
end;

function DeleteTree(s: string):Boolean;
var searchRec:TSearchRec;
begin
  Result := True;
  if FindFirst(s+'\*.*', faAnyFile, SearchRec)=0 then
  repeat
  if (SearchRec.Name<>'.') and (SearchRec.Name<>'..') then
  begin
    if (SearchRec.Attr and faDirectory >0) then
    begin
      Result := DeleteTree(s+'\'+SearchRec.Name);
    end else begin
      try
        FileSetAttr(s+'\'+SearchRec.Name,faArchive);
        //DeleteFile(s+'\'+SearchRec.Name);
        if not DeleteFileWithUndo(s+'\'+SearchRec.Name) then//少部分文件没能清理掉,想不通 20080928
        DeleteFile(s+'\'+SearchRec.Name);
      except
        g_sClearError := '删除文件:'+s+'\'+SearchRec.Name+'错误!';
        Result := False;
      end;
    end;
  end;      
  until (FindNext(SearchRec)<>0);
  FindClose(SearchRec);
end;

function ClearWriteINI(FileName,ini1,ini2,ini3:string):Boolean;
var
  Myinifile: TIniFile;
begin
  Result := False;
  Myinifile:=Tinifile.Create(FileName);
  try
    if Myinifile <> nil then begin
      Myinifile.WriteString(ini1,ini2,ini3);
      Myinifile.WriteString(ini1,'ChangeDate', DateTimeToStr(Now));//20090305 设置沙占领时间
    end;
  finally
    Myinifile.Free;
  end;
  //sleep(2000);
  Result := True;
end;

procedure ClearTxt(TxtName: string);
var
  f:textfile;
begin
  assignfile(f,TxtName);
  rewrite(f);
  closefile(f);
end;


procedure ListBoxClearTxtFile(ListBox: TListBox);
var
  I: Integer;
begin
  for I:=0 to ListBox.Items.Count -1 do
  begin
     ClearTxt(ListBox.Items.Strings [I]);
  end;
end;


procedure ListBoxDelFile(ListBox: TListBox);
var
  I: Integer;
begin
  for I:=0 to ListBox.Items.Count -1 do
  begin
     DeleteFile(ListBox.Items.Strings [I]);
  end;
end;

function ListBoxDelDir(ListBox: TListBox):Boolean;
var
  I: Integer;
begin
  Result := False;
  for I:=0 to ListBox.Items.Count -1 do
  begin
     DeleteTree(ListBox.Items.Strings [I]);
  end;
  Result := True;
end;

function Clear_IniConf(): Boolean;
var
  I: Integer;
begin
    Result := False;
    g_IniConf.WriteString('ClearServer', 'IDDB', frmMain.IDEd.Text);
    g_IniConf.WriteString('ClearServer', 'FDB', frmMain.DBed.Text);
    g_IniConf.WriteString('ClearServer', 'BaseDir', frmMain.LogEd.Text);
    g_IniConf.WriteString('ClearServer', 'Castle', frmMain.CsEd.Text);
    g_IniConf.WriteString('ClearServer', 'GuildBase', frmMain.CBed.Text);
    g_IniConf.WriteString('ClearServer', 'DivisionDir', frmMain.DivisionDirEdt.Text);
    g_IniConf.WriteString('ClearServer', 'ConLog', frmMain.CLed.Text);
    g_IniConf.WriteString('ClearServer', 'market_upg', frmMain.upged.Text);
    g_IniConf.WriteString('ClearServer', 'Market_SellOff', frmMain.Soed.Text);
    g_IniConf.WriteString('ClearServer', 'ChrLog', frmMain.ChrLog.Text);
    g_IniConf.WriteString('ClearServer', 'CountLog', frmMain.CountLog.Text);
    g_IniConf.WriteString('ClearServer', 'Log', frmMain.M2Log.Text);
    g_IniConf.WriteString('ClearServer', 'Market_prices', frmMain.sred1.Text);
    g_IniConf.WriteString('ClearServer', 'Market_saved', frmMain.sred2.Text);
    g_IniConf.WriteString('ClearServer', 'Sort', frmMain.EdtSort.Text);
    g_IniConf.WriteBool('ClearServer', 'Global', frmMain.CheckBoxGlobal.Checked);
    g_IniConf.WriteBool('ClearServer', 'UserData', frmMain.CheckBoxUserData.Checked);
    g_IniConf.WriteBool('ClearServer', 'MasterNo', frmMain.CheckBoxMasterNo.Checked);
    g_IniConf.WriteInteger('ClearServer', 'MyGetTxtNum', frmMain.ListBoxMyGetTXT.Items.Count);
    if frmMain.ListBoxMyGetTXT.Items.Count <> 0 then begin
      for I:=0 to frmMain.ListBoxMyGetTXT.Items.Count - 1 do
      begin
        g_IniConf.WriteString('ClearServer','MyGetTxt'+IntToStr(i),frmMain.ListBoxMyGetTXT.Items.Strings[i]);
      end;
    end;

    g_IniConf.WriteInteger('ClearServer', 'MyGetFileNum', frmMain.ListBoxMyGetFile.Items.Count);
    if frmMain.ListBoxMyGetFile.Items.Count <> 0 then begin
      for I:=0 to frmMain.ListBoxMyGetFile.Items.Count -1 do
      begin
        g_IniConf.WriteString('ClearServer','MyGetFile'+IntToStr(i),frmMain.ListBoxMyGetFile.Items.Strings[i]);
      end;
    end;

    g_IniConf.WriteInteger('ClearServer', 'MyGetDirNum', frmMain.ListBoxMyGetDir.Items.Count);
    if frmMain.ListBoxMyGetDir.Items.Count <> 0 then begin
      for I:=0 to frmMain.ListBoxMyGetDir.Items.Count -1 do
      begin
        g_IniConf.WriteString('ClearServer','MyGetDir'+IntToStr(i),frmMain.ListBoxMyGetDir.Items.Strings[i]);
      end;
    end;
    Result := True;
end;

procedure Clear_LoadIniConf();
var
  nMyGetTxtNum, nMyGetFileNum, nMyGetDirNum, I: Integer;
  sStr: String;
begin
   //200090705 增加
   g_nSelGate_ShowLogLevel:= g_IniConf.ReadInteger('SelGate', 'ShowLogLevel', g_nSelGate_ShowLogLevel);
   g_nSelGate_MaxConnOfIPaddr:= g_IniConf.ReadInteger('SelGate', 'MaxConnOfIPaddr', g_nSelGate_MaxConnOfIPaddr);
   g_nSelGate_BlockMethod:= g_IniConf.ReadInteger('SelGate', 'BlockMethod', g_nSelGate_BlockMethod);
   g_nSelGate_KeepConnectTimeOut:= g_IniConf.ReadInteger('SelGate', 'KeepConnectTimeOut', g_nSelGate_KeepConnectTimeOut);

   frmMain.SelGate_KeepConnectTimeOutEdit.Value := g_nSelGate_KeepConnectTimeOut;
   frmMain.EditMaxConnect.Value := g_nSelGate_MaxConnOfIPaddr;
   frmMain.SpinEditShowLogLevel.Value := g_nSelGate_ShowLogLevel;
   frmMain.SpinEditBlockMethod.Value := g_nSelGate_BlockMethod;

   frmMain.IDEd.Text := g_IniConf.ReadString('ClearServer', 'IDDB',frmMain.IDEd.Text);
   frmMain.DBed.Text := g_IniConf.ReadString('ClearServer', 'FDB', frmMain.DBed.Text);
   frmMain.LogEd.Text := g_IniConf.ReadString('ClearServer', 'BaseDir', frmMain.LogEd.Text);
   frmMain.CsEd.Text := g_IniConf.ReadString('ClearServer', 'Castle', frmMain.CsEd.Text);
   frmMain.CBed.Text := g_IniConf.ReadString('ClearServer', 'GuildBase', frmMain.CBed.Text);
   frmMain.DivisionDirEdt.Text:= g_IniConf.ReadString('ClearServer', 'DivisionDir', frmMain.DivisionDirEdt.Text);
   frmMain.CLed.Text := g_IniConf.ReadString('ClearServer', 'ConLog', frmMain.CLed.Text);
   frmMain.upged.Text := g_IniConf.ReadString('ClearServer', 'market_upg', frmMain.upged.Text);
   frmMain.Soed.Text := g_IniConf.ReadString('ClearServer', 'Market_SellOff', frmMain.Soed.Text);
   frmMain.ChrLog.Text := g_IniConf.ReadString('ClearServer', 'ChrLog', frmMain.ChrLog.Text);
   frmMain.CountLog.Text := g_IniConf.ReadString('ClearServer', 'CountLog', frmMain.CountLog.Text);
   frmMain.M2Log.Text := g_IniConf.ReadString('ClearServer', 'Log', frmMain.M2Log.Text);
   frmMain.sred1.Text := g_IniConf.ReadString('ClearServer', 'Market_prices', frmMain.sred1.Text);
   frmMain.sred2.Text := g_IniConf.ReadString('ClearServer', 'Market_saved', frmMain.sred2.Text);
   frmMain.EdtSort.Text := g_IniConf.ReadString('ClearServer', 'Sort', frmMain.EdtSort.Text);
   frmMain.CheckBoxGlobal.Checked := g_IniConf.ReadBool('ClearServer', 'Global', frmMain.CheckBoxGlobal.Checked);
   frmMain.CheckBoxUserData.Checked :=  g_IniConf.ReadBool('ClearServer', 'UserData', frmMain.CheckBoxUserData.Checked);
   frmMain.CheckBoxMasterNo.Checked :=  g_IniConf.ReadBool('ClearServer', 'MasterNo', frmMain.CheckBoxMasterNo.Checked);
   nMyGetTxtNum := g_IniConf.ReadInteger('ClearServer', 'MyGetTxtNum', 0);
   nMyGetFileNum := g_IniConf.ReadInteger('ClearServer', 'MyGetFileNum', 0);
   nMyGetDirNum := g_IniConf.ReadInteger('ClearServer', 'MyGetDirNum', 0);

   if nMyGetTxtNum <> 0 then begin
     frmMain.ListBoxMyGetTXT.Items.Clear;
     for I:=0 to nMyGetTxtNum - 1 do begin
       sStr:= g_IniConf.ReadString('ClearServer','MyGetTxt'+IntToStr(I),'');
       if sStr <> '' then frmMain.ListBoxMyGetTXT.Items.Add(sStr);
     end;
   end;
   if nMyGetFileNum <> 0 then begin
     frmMain.ListBoxMyGetFile.Items.Clear;
     for I:=0 to nMyGetFileNum - 1 do begin
       sStr:= g_IniConf.ReadString('ClearServer','MyGetFile'+IntToStr(I),'');
       if sStr <> '' then frmMain.ListBoxMyGetFile.Items.Add(sStr);
     end;
   end;
   if nMyGetDirNum <> 0 then begin
     frmMain.ListBoxMyGetDir.Items.Clear;
     for I:=0 to nMyGetDirNum - 1 do begin
       sStr:= g_IniConf.ReadString('ClearServer','MyGetDir'+IntToStr(I),'');
       if sStr <> '' then frmMain.ListBoxMyGetDir.Items.Add(sStr);
     end;
   end;
end;

end.
