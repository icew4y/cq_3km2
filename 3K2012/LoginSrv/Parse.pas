unit Parse;

interface

uses Windows, Classes, SysUtils, MudUtil;

type
  TThreadParseList = class(TThread)
  private
    AccountLoadList: TStringList;
    IPaddrLoadList: TStringList;
    IPaddrCostList: TQuickList;
    bo40: Boolean;
    { Private declarations }

  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
  end;

implementation

uses LSShare, HUtil32, LMain;



{ Important: Methods and properties of objects in VCL or CLX can only be used
  in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure ThreadParseList.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ ThreadParseList }

constructor TThreadParseList.Create(CreateSuspended: Boolean);
begin
  inherited;
  AccountLoadList := TStringList.Create;
  IPaddrLoadList := TStringList.Create;
  IPaddrCostList := TQuickList.Create;
  bo40 := False;
end;

destructor TThreadParseList.Destroy;
begin
  AccountLoadList.Free;
  IPaddrLoadList.Free;
  IPaddrCostList.Free;
  inherited;
end;

procedure TThreadParseList.Execute;
var
  I: Integer;
  dwTick2C: LongWord;
  s18, s1C, s24, s28: string;
  nC, n10, n14: Integer;
  Config: pTConfig;
  AccountCostRcd: pTAccountCostRcd;
begin
  Config := @g_Config;
  dwTick2C := 0;
  while (true) do begin
    if (GetTickCount - dwTick2C) > {5 * }60 * 1000 then begin//每分钟读取
      dwTick2C := GetTickCount();
      try
        if FileExists(Config.sFeedIDList) then begin
          AccountLoadList.Clear;
          AccountLoadList.LoadFromFile(Config.sFeedIDList);
          if AccountLoadList.Count > 0 then begin
            CS_DB.Enter;
            try
              for I := AccountLoadList.Count - 1 downto 0 do begin
                s18 := Trim(AccountLoadList.Strings[I]);
                s18 := GetValidStr3(s18, s1C, [' ', #9]);//账号
                s18 := GetValidStr3(s18, s24, [' ', #9]);//模式 0-小时 1-天数
                s18 := GetValidStr3(s18, s28, [' ', #9]);//小时(天数)
                n10 := Str_ToInt(s24, 0);
                n14 := Str_ToInt(s28, 0);
                if n10 < 2 then begin
                  if n10 = 0 then n14:= n14 * 60;//小时换为分
                  nC := Config.AccountCostList.IndexOf(s1C);
                  if nC > -1 then begin
                    AccountCostRcd:= pTAccountCostRcd(Config.AccountCostList.Objects[nC]);
                    if AccountCostRcd <> nil then begin
                      if AccountCostRcd.boEnable then begin
                        if (AccountCostRcd.nCostType = n10) then begin//模式一致
                          AccountCostRcd.nAccountCost:= _MIN(High(Integer), AccountCostRcd.nAccountCost + n14);
                          AccountLoadList.Delete(I);
                        end;
                      end else begin
                        try
                          Config.AccountCostList.Delete(nC);
                          Dispose(AccountCostRcd);
                        except
                        end;
                        New(AccountCostRcd);
                        AccountCostRcd.sAccount:= s1C;
                        AccountCostRcd.nAccountCost:= n14;
                        AccountCostRcd.nCostType:= n10;
                        AccountCostRcd.boEnable:= True;
                        AccountCostRcd.CreateDate:= Now();
                        Config.AccountCostList.AddObject(s1C, TObject(AccountCostRcd));
                        AccountLoadList.Delete(I);
                      end;
                    end;
                  end else begin
                    New(AccountCostRcd);
                    AccountCostRcd.sAccount:= s1C;
                    AccountCostRcd.nAccountCost:= n14;
                    AccountCostRcd.nCostType:= n10;
                    AccountCostRcd.boEnable:= True;
                    AccountCostRcd.CreateDate:= Now();
                    Config.AccountCostList.AddObject(s1C, TObject(AccountCostRcd));
                    AccountLoadList.Delete(I);
                  end;
                end;
                if not bo40 then begin
                  if (I mod 100) = 0 then Sleep(1);
                end;
              end;
            finally
              CS_DB.Leave;
            end;
            AccountLoadList.SaveToFile(Config.sFeedIDList);
          end;
          //LoadAccountCostList(Config, NewAccountCostList);
        end else begin
          AccountLoadList.Clear;
          AccountLoadList.SaveToFile(Config.sFeedIDList);
        end;
      except
        MainOutMessage('[Exception] loading on IDStrList.');
      end;

      {try
        if FileExists(Config.sFeedIPList) then begin
          IPaddrLoadList.Clear;
          IPaddrLoadList.LoadFromFile(Config.sFeedIPList);
          if IPaddrLoadList.Count > 0 then begin
            IPaddrCostList.Clear;
            for I := 0 to IPaddrLoadList.Count - 1 do begin
              s18 := Trim(IPaddrLoadList.Strings[I]);
              s18 := GetValidStr3(s18, s1C, [' ', #9]);
              s18 := GetValidStr3(s18, s24, [' ', #9]);
              s18 := GetValidStr3(s18, s28, [' ', #9]);
              n10 := Str_ToInt(s24, 0);
              n14 := Str_ToInt(s28, 0);
              nC := MakeLong(_MAX(n14, 0), _MAX(n10, 0));
              IPaddrCostList.AddRecord(s1C, nC);
              if not bo40 then begin
                if (I mod 100) = 0 then Sleep(1);
              end;
            end;
          end;
          LoadIPaddrCostList(Config, IPaddrCostList);
        end;
      except
        MainOutMessage('Exception] loading on IPStrList.');
      end;}
    end;
    Sleep(10);
    if Self.Terminated then break;
  end;
end;

end.
