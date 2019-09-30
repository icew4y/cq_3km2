unit Secrch;

interface
uses Classes, SysUtils, GameLoginShare, Forms, Main, Windows, FileCtrl, Reg, Common;
procedure SearchMyDir();
procedure SearchMylient(); //智能搜索客户端
function  DoSearchFile(path: string; var Files: TStringList): Boolean;
implementation
var
  boSearchFinish: Boolean = FALSE;
  boStopSearch: Boolean = FALSE;

procedure SearchMyDir();
begin
  boStopSearch := False;
  m_BoSearchFinish := False;
  if boSearchFinish then Exit;
  SearchMylient();
  if g_sMirPath[Length(g_sMirPath)] <> '\' then
    g_sMirPath := g_sMirPath + '\';
end;

//智能搜索客户端   49
procedure SearchMylient();
var
  I, II: Integer;
  sList, sTempList, List01, List02: TStringList;
  MyDir: String;
begin
  boSearchFinish:=TRUE;
  sList := TStringList.Create;
  sTempList := TStringList.Create;
  List01 := TStringList.Create;
  List02 := TStringList.Create;
  GetdriveName(sList);
  for I := 0 to sList.Count - 1 do begin
    Application.ProcessMessages;
    if m_BoSearchFinish then break;
    if boStopSearch then break;
    FrmMain.StatusColor := $0040BBF1;
    FrmMain.StatusString := {'正在搜索：'}SetDate('隍壅霓镍') + sList.Strings[I];
    if CheckMyDir(sList.Strings[I]) then begin
      g_sMirPath := sList.Strings[I];
      m_BoSearchFinish := True;
      break;
    end;
    if DoSearchFile(sList.Strings[I], sTempList) then begin
      if m_BoSearchFinish then break;
      if boStopSearch then break;
      for II := 0 to sTempList.Count - 1 do begin
        IsNum('123');
        FrmMain.StatusColor := $0040BBF1;
        IsNum('123');
        FrmMain.StatusString := {'正在搜索：'}SetDate('隍壅霓镍') + sTempList.Strings[II];
        IsNum('123');
        if CheckMyDir(sTempList.Strings[II]) then begin
          IsNum('123');
          g_sMirPath := sTempList.Strings[II];
          m_BoSearchFinish := True;
          break;
        end;
      end;
    end;
  end;
  List01.AddStrings(sTempList);
  if (not m_BoSearchFinish) and (not boStopSearch) then begin
    I := 0;
    while True do begin              //从C盘到最后一个盘反复搜索
      if m_BoSearchFinish then break;
      if boStopSearch then break;
      Application.ProcessMessages;
      if List01.Count <=0 then Break;
      sTempList.Clear;
      if DoSearchFile(List01.Strings[I], sTempList) then begin
        if m_BoSearchFinish then break;
        if boStopSearch then break;
        List02.AddStrings(sTempList);
        for II := 0 to sTempList.Count - 1 do begin
          if m_BoSearchFinish then break;
          if boStopSearch then break;
          IsNum('123');
          FrmMain.StatusColor := $0040BBF1;
          IsNum('123');
          FrmMain.StatusString := {'正在搜索：'}SetDate('隍壅霓镍') + sTempList.Strings[II];
          IsNum('123');
          if CheckMyDir(sTempList.Strings[II]) then begin
            g_sMirPath := sTempList.Strings[II];
            m_BoSearchFinish := True;
            break;
          end;
        end;
      end;
      Inc(I);
      if I > List01.Count - 1 then begin
        List01.Clear;
        List01.AddStrings(List02);
        List02.Clear;
        I := 0;
      end;
    end;
  end;
  if m_BoSearchFinish then begin
    FrmMain.StatusColor := $0040BBF1;
    IsNum('123');
    FrmMain.StatusString := {'客户端目录已找到……'}SetDate('奥川鼓税统蒉谳翰');
    IsNum('123');
    FrmMain.SecrchTimer.Enabled := True;
  end else begin
     if Application.MessageBox(PChar(SetDate('檀苓谳翰奥川鼓湃羹刨範芥谳')){'没有找到客户端，是否手动查找？'}, PChar(SetDate('妙疟呤拉')){'提示信息'},MB_YESNO + MB_ICONQUESTION) = IDYES then begin
        IsNum('123');
        if FileCtrl.SelectDirectory({'请选择操作目录'}PChar(SetDate('蠕蕻埝街伉税统')) ,{'请选择传奇目录'}PChar(SetDate('蠕蕻埝护砷税统')) ,MyDir) then begin
          IsNum('123');
          if not CheckMyDir(PChar(MyDir)) then begin
             IsNum('123');
             Application.MessageBox({'你选择的目录不正确！！！'}PChar(SetDate('遂蕻埝核税统酱隍歉')), PChar(SetDate('妙疟呤拉')){'提示信息'}, MB_OK + MB_ICONINFORMATION);
             Application.Terminate;
             Exit;
          end else begin
            g_sMirPath := MyDir;
            IsNum('123');
            AddValue2(HKEY_LOCAL_MACHINE,{'SOFTWARE\BlueYue\Mir'}PChar(SetDate('\@I[XN]JSMczjVzjSBf}')),'Path',PChar(g_sMirPath));
            IsNum('123');
            FrmMain.SecrchTimer.Enabled := True;
          end;
        end else begin
          Application.Terminate;
          Exit;
        end;
     end else begin
        Application.Terminate;
        Exit;
     end;
  end;
  sList.Free;
  sTempList.Free;
  List01.Free;
  List02.Free;
  boSearchFinish:=FALSE;
end;
//搜索文件 44
function DoSearchFile(path: string; var Files: TStringList): Boolean;
var
  Info: TsearchRec;
  s01: string;
{  function IsDir: Boolean;
  begin
    with Info do
      result := (Name <> '.') and (Name <> '..') and ((Attr and faDirectory) = faDirectory);
  end;
  function IsFile: Boolean;
  begin
    result := not ((Info.Attr and faDirectory) = faDirectory);
  end;}
begin
  try
    result := FALSE;
    if findfirst(path + '*.*', faAnyFile, Info) = 0 then begin
      if {IsDir}(Info.Name <> '.') and (Info.Name <> '..') and ((Info.Attr and faDirectory) = faDirectory) then begin
        s01 := path + Info.Name;
        if s01[Length(s01)] <> '\' then s01 := s01 + '\';
        Files.Add(s01);
      end;
      while True do begin
        if m_BoSearchFinish then break;
        if boStopSearch then break;
        s01 := path + Info.Name;
        if s01[Length(s01)] <> '\' then s01 := s01 + '\';
        if {IsDir}(Info.Name <> '.') and (Info.Name <> '..') and ((Info.Attr and faDirectory) = faDirectory) then Files.Add(s01);
        Application.ProcessMessages;
        if findnext(Info) <> 0 then break;
      end;
    end;
    result := True;
  finally
    SysUtils.findclose(Info);
  end;
end;
end.
