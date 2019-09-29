
  case Who of
    1:begin
      if g_MySelf = nil then exit;
      MouseItem := g_MouseItem;
    end;
    2:begin
      if g_HeroSelf = nil then exit;
      MouseItem := g_HeroMouseItem;
    end;
  end;
  iname := '';
  iname1 := '';
  line1 := '';
  line2 := '';
  line3 := '';
  line4 := '';
  line5 := '';
  sUnKnow1 := '';
  sUnKnow2 := '';
  useable := TRUE;

  if MouseItem.S.Name <> '' then
  begin
    iname := MouseItem.S.Name + ' ';
    sWgt := '重量';
    case MouseItem.S.StdMode of
      0: begin //药品
        case MouseItem.S.Shape of
          3:;
          4:if MouseItem.S.AC > 0 then line1 := '+' + IntToStr(MouseItem.S.AC) + '内力值 ';//内力值
          else begin
            if MouseItem.S.AC > 0 then line1 := '+' + IntToStr(MouseItem.S.AC) + 'HP ';
            if MouseItem.S.MAC > 0 then line1 := line1 + '+' + IntToStr(MouseItem.S.MAC) + 'MP';
          end;
        end;
        line1 := line1 + '重量' + IntToStr(MouseItem.S.Weight);
        str := GetItemDesc(MouseItem.S.Name);
        if str <> '' then begin
          str := GetValidStr3 (str, line2, ['\']);
        end;
      end;

      1..3: begin
        case MouseItem.S.AniCount of
          9: begin
            line1 := line1 + '重量' +  IntToStr(MouseItem.S.Weight);
            line2 := '可累计修复持久'+ IntToStr(Round(MouseItem.Dura / 100))+'点';
          end;
          21: begin
            if (MouseItem.S.StdMode= 2) and (MouseItem.S.Reserved = 56) then begin  //泉水罐 20080624
              line1 := line1 + '重量' +  IntToStr(MouseItem.S.Weight);
              line2 := '容量 '+ GetDura100Str(MouseItem.Dura, MouseItem.DuraMax);
            end else begin
              line1 := line1 + '重量' +  IntToStr(MouseItem.S.Weight);
              line2 := '容量 '+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
            end;
          end;
          22: begin
            line1 := line1 + '重量' +  IntToStr(MouseItem.S.Weight);
            line2 := '容量 '+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
          end;
        else line1 := line1 + '重量' +  IntToStr(MouseItem.S.Weight);
        end;

        if MouseItem.S.StdMode = 2 then begin
          if (MouseItem.S.Reserved <> 56) and (MouseItem.S.Shape in [0..2]) then begin
            line2 := '使用 '+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax)+' 次';
          end else if MouseItem.S.Shape in [4..5,10..12] then begin
            line1 := line1+' 使用 '+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax)+' 次';
            str := GetItemDesc(MouseItem.S.Name);
            if str <> '' then begin
              str := GetValidStr3 (str, line2, ['\']);
              str := GetValidStr3 (str, line3, ['\']);
            end;
          {$IF M2Version <> 2}
          end else if MouseItem.S.Shape = 255 then begin
            line2 := Format('使用 %s 次', [GetDura100Str(MouseItem.Dura, MouseItem.DuraMax)]);//灵气神水
          end else if MouseItem.S.Shape in [253..254] then begin
            str := GetItemDesc(MouseItem.S.Name);
            if str <> '' then begin
              str := GetValidStr3 (str, line2, ['\']);
              str := GetValidStr3 (str, line3, ['\']);
            end;
          {$IFEND}
          end;

        end else if MouseItem.S.StdMode = 3 then begin
          if MouseItem.S.Shape in [13,14] then begin
            str := GetItemDesc(MouseItem.S.Name);
            if str <> '' then begin
              str := GetValidStr3 (str, line2, ['\']);
            end;
          end;
        end;
      end;

      51: begin
        line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight);
        case MouseItem.S.Shape of
         0: begin//聚灵珠
            if MouseItem.Dura = MouseItem.DuraMax then begin
              line2 := '经验值已蓄满('+IntToStr(MouseItem.DuraMax)+'万)  双击释放';
            end else begin
              if MouseItem.S.Need = 0 then begin
                line2 := '累积经验 ' +  IntToStr(MouseItem.Dura)+'/'+IntToStr(MouseItem.DuraMax)+'万';
                line3 := IntToStr(MouseItem.S.AniCount * 24)+'小时后停止累积经验';
              end else begin
                line2 := '累积经验 ' +  IntToStr(MouseItem.Dura  + g_nBeadWinExp)+'/'+IntToStr(MouseItem.DuraMax)+'万';
                line3 := IntToStr(MouseItem.S.Need)+'小时后停止累积经验';
              end;
            end;
          end;
          1: begin//内功珠
            if MouseItem.Dura = MouseItem.DuraMax then begin
              line2 := '内功经验值已蓄满('+FloatToStrFixFmt (MouseItem.DuraMax/10, 4, 1)+'万)  双击释放';
            end else begin
              line2 := '累积内功经验 ' +  FloatToStrFixFmt (MouseItem.Dura/10, 4, 1)+'/'+FloatToStrFixFmt (MouseItem.DuraMax/10, 4, 1)+'万'; //IntToStr(MouseItem.Dura)+'/'+IntToStr(MouseItem.DuraMax)+'万';
            end;
            str := GetItemDesc(MouseItem.S.Name);
            if str <> '' then begin
              str := GetValidStr3 (str, line3, ['\']);
            end;
          end;
          2: begin//英雄聚灵珠
            if MouseItem.Dura = MouseItem.DuraMax then begin
              line2 := '经验值已蓄满('+FloatToStrFixFmt (MouseItem.DuraMax, 4, 1)+'万)  双击释放';
            end else begin
              line2 := '累积经验 ' +  FloatToStrFixFmt (MouseItem.Dura, 4, 1)+'/'+FloatToStrFixFmt (MouseItem.DuraMax, 4, 1)+'万'; //IntToStr(MouseItem.Dura)+'/'+IntToStr(MouseItem.DuraMax)+'万';
            end;
            str := GetItemDesc(MouseItem.S.Name);
            if str <> '' then begin
              str := GetValidStr3 (str, line3, ['\']);
            end;
          end;
          3: begin //主宰者灵珠
            if MouseItem.Dura / 10000 > 1 then begin //亿
              line2 := '放在英雄包裹中双击开启，可获得'+ FloatToStrFixFmt (MouseItem.Dura/10000, 4, 1) +'亿英雄经验';
            end else begin
              line2 := '放在英雄包裹中双击开启，可获得'+ IntToStr(MouseItem.Dura) +'万英雄经验';
            end;
            if MouseItem.S.AniCount > 0 then begin //需要元宝
              if MouseItem.Dura / 10000 > 1 then begin //亿
               // line3 := '放到英雄包裹中双击花费15元宝获得1.8亿英雄经验，英雄200级以上也可使用';
                line3 := Format('放到英雄包裹中双击花费%d%s获得%s亿经验', [MouseItem.S.AniCount, g_sGameGoldName, FloatToStrFixFmt (MouseItem.Dura/10000, 4, 1)]);
              end else begin
                line3 := Format('放到英雄包裹中双击花费%d%s获得%d万经验', [MouseItem.S.AniCount, g_sGameGoldName, MouseItem.DuraMax]);
              end;
            end;
            if MouseItem.S.NeedLevel <> 0 then begin
              if MouseItem.S.Need = 0 then begin    //Need =0 等级达到NeedLevel后可使用
                if MouseItem.S.AniCount > 0 then begin //需要元宝
                  line3 := line3 + '，英雄'+IntToStr(MouseItem.S.NeedLevel)+'级以上也可使用';
                end else begin
                  line3 := '英雄'+IntToStr(MouseItem.S.NeedLevel)+'级以上也可使用';
                end;
              end else if MouseItem.S.Need = 1 then begin //Need =1 等级小于NeedLevel后可使用
                if MouseItem.S.AniCount > 0 then begin //需要元宝
                  line3 := line3 + '，英雄'+IntToStr(MouseItem.S.NeedLevel)+'级以下才可使用';
                end else begin
                  line3 := '英雄'+IntToStr(MouseItem.S.NeedLevel)+'级以下才可使用';
                end;
              end;
            end;
          end;
        end;
      end;
      31: begin //解包和触发物品
        line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight);
        str := GetItemDesc(MouseItem.S.Name);
        if str <> '' then begin
          str := GetValidStr3 (str, line2, ['\']);
          str := GetValidStr3 (str, line3, ['\']);
        end;
      end;
      4: begin //技能书
        line1 := line1 + '重量' +  IntToStr(MouseItem.S.Weight);
        case MouseItem.S.AniCount of
          0: begin
            line3 := '需要等级' + IntToStr(MouseItem.S.DuraMax);
            useable := FALSE;
            case MouseItem.S.Shape of
              0: begin
                line2 := '武士秘籍';
                case Who of
                  1: if (g_MySelf.m_btJob = 0) and (g_MySelf.m_Abil.Level >= MouseItem.S.DuraMax) then useable := TRUE;
                  2: if (g_HeroSelf.m_btJob = 0) and (g_HeroSelf.m_Abil.Level >= MouseItem.S.DuraMax) then useable := TRUE;
                end;
              end;
              1: begin
                line2 := '魔法书';
                case Who of
                  1: if (g_MySelf.m_btJob = 1) and (g_MySelf.m_Abil.Level >= MouseItem.S.DuraMax) then useable := TRUE;
                  2: if (g_HeroSelf.m_btJob = 1) and (g_HeroSelf.m_Abil.Level >= MouseItem.S.DuraMax) then useable := TRUE;
                end;
              end;
              2: begin
                line2 := '道士秘籍';
                case Who of
                  1: if (g_MySelf.m_btJob = 2) and (g_MySelf.m_Abil.Level >= MouseItem.S.DuraMax) then useable := TRUE;
                  2: if (g_HeroSelf.m_btJob = 2) and (g_HeroSelf.m_Abil.Level >= MouseItem.S.DuraMax) then useable := TRUE;
                end;
              end;
              3: begin
                //if g_MouseItem.S.AniCount in [60..65] then begin
                line2 := '合击秘籍';
                case Who of
                  1: if g_MySelf.m_Abil.Level >= MouseItem.S.DuraMax then useable := TRUE;
                  2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.DuraMax then useable := TRUE;
                end;
                //end;
              end;
            end;
          end;
          1: begin
            line3 := '需要内功等级' + IntToStr(MouseItem.S.DuraMax);
            useable := FALSE;
            case MouseItem.S.Shape of
              0: begin
                line2 := '武术秘籍';
                case Who of
                  1: if (g_MySelf.m_btJob = 0) and (g_dwInternalForceLevel >= MouseItem.S.DuraMax) then useable := TRUE;
                  2: if (g_HeroSelf.m_btJob = 0) and (g_dwHeroInternalForceLevel >= MouseItem.S.DuraMax) then useable := TRUE;
                end;
              end;
              1: begin
                line2 := '魔法书';
                case Who of
                  1: if (g_MySelf.m_btJob = 1) and (g_dwInternalForceLevel >= MouseItem.S.DuraMax) then useable := TRUE;
                  2: if (g_HeroSelf.m_btJob = 1) and (g_dwHeroInternalForceLevel >= MouseItem.S.DuraMax) then useable := TRUE;
                end;
              end;
              2: begin
                line2 := '道术秘籍';
                case Who of
                  1: if (g_MySelf.m_btJob = 2) and (g_dwInternalForceLevel >= MouseItem.S.DuraMax) then useable := TRUE;
                  2: if (g_HeroSelf.m_btJob = 2) and (g_dwHeroInternalForceLevel >= MouseItem.S.DuraMax) then useable := TRUE;
                end;
              end;
              99: begin
                line2 := '战士、魔法师、道士均可学习';
                case Who of
                  1: if g_dwInternalForceLevel >= MouseItem.S.DuraMax then useable := TRUE;
                  2: if g_dwHeroInternalForceLevel >= MouseItem.S.DuraMax then useable := TRUE;
                end;
              end;
            end;
          end;
        end;
      end;
      5..6: begin //武器
        useable := FALSE;
        {If MouseItem.s.nHP> 0 then
          Line3:=Line3+'\体力值 +'+IntToStr(MouseItem.s.nHP)+' ';
        If MouseItem.s.nMP> 0 Then
          Line3:=Line3+'\魔法值 +'+IntToStr(MouseItem.s.nMP)+' ';}
        if MouseItem.S.Reserved and $01 <> 0 then
          iname := '(*)' + iname;
        line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight) + ' 持久'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
        if MouseItem.S.DC > 0 then line2 := '\攻击' + IntToStr(LoWord(MouseItem.S.DC)) + '-' + IntToStr(HiWord(MouseItem.S.DC))+' ';
        //if MouseItem.btValue[0]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[0])+')/c=lime> ';
        if MouseItem.S.MC > 0 then line2 := line2 + '\魔法' + IntToStr(LoWord(MouseItem.S.MC)) + '-' + IntToStr(HiWord(MouseItem.S.MC))+' ';
        //if MouseItem.btValue[1]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[1])+')/c=lime> ';
        if MouseItem.S.SC > 0 then line2 := line2 + '\道术' + IntToStr(LoWord(MouseItem.S.SC)) + '-' + IntToStr(HiWord(MouseItem.S.SC))+' ';
        //if MouseItem.btValue[2]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[2])+')/c=lime> ';

        if ((MouseItem.S.Source - 1 - 10) < 0) and (MouseItem.S.Source > 0) then line2 := line2 + '强度+' + IntToStr(MouseItem.S.Source)+' ';
        if (MouseItem.S.Source <= -1) and (MouseItem.S.Source >= -50) then line2 := line2 + '神圣+' + IntToStr(-MouseItem.S.Source)+' ';
        if (MouseItem.S.Source <= -51) and (MouseItem.S.Source >= -100) then line2 := line2 + '神圣-' + IntToStr(-MouseItem.S.Source - 50)+' ';
        if HiWord(MouseItem.S.AC) > 0 then line3 := line3 + '\准确+' + IntToStr(HiWord(MouseItem.S.AC))+' ';
        if HiWord(MouseItem.S.MAC) > 0 then begin
          if HiWord(MouseItem.S.MAC) > 10 then
            line3 := line3 + ' 攻击速度+' + IntToStr(HiWord(MouseItem.S.MAC)-10) + ' '
          else line3 := line3 + ' 攻击速度-' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
        end;
        if LoWord(MouseItem.S.AC) > 0 then line3 := line3 + '\幸运+' + IntToStr(LoWord(MouseItem.S.AC)) + ' ';
        if LoWord(MouseItem.S.MAC) > 0 then line3 := line3 + '\诅咒+' + IntToStr(LoWord(MouseItem.S.MAC)) + ' ';
        

        case MouseItem.S.Need of
          10:begin//修复装备属性显示问题 By TasNat at: 2012-06-24 09:43:25
            case Who of
              1: if (g_MySelf.m_btJob = LoWord(MouseItem.S.NeedLevel)) and (g_MySelf.m_Abil.Level >= HiWord(MouseItem.S.NeedLevel)) then useable := TRUE;
              2: if (g_HeroSelf.m_btJob = LoWord(MouseItem.S.NeedLevel)) and (g_HeroSelf.m_Abil.Level >= HiWord(MouseItem.S.NeedLevel)) then useable := TRUE;
            end;
            line3 := line3 + GetJobName(LoWord(MouseItem.S.NeedLevel)) + '专用:需要等级' + IntToStr(HiWord(MouseItem.S.NeedLevel)) + ' ';
          end;

          11:begin
            case Who of
              1: if (HiWord(g_MySelf.m_Abil.DC) = LoWord(MouseItem.S.NeedLevel)) and (g_MySelf.m_Abil.Level >= HiWord(MouseItem.S.NeedLevel)) then useable := TRUE;
              2: if (HiWord(g_HeroSelf.m_Abil.DC) = LoWord(MouseItem.S.NeedLevel)) and (g_HeroSelf.m_Abil.Level >= HiWord(MouseItem.S.NeedLevel)) then useable := TRUE;
            end;
            line3 := line3 + GetJobName(LoWord(MouseItem.S.NeedLevel)) + '专用:需要攻击' + IntToStr(HiWord(MouseItem.S.NeedLevel)) + ' ';
          end;
          12:begin
            case Who of
              1: if (HiWord(g_MySelf.m_Abil.MC) = LoWord(MouseItem.S.NeedLevel)) and (g_MySelf.m_Abil.Level >= HiWord(MouseItem.S.NeedLevel)) then useable := TRUE;
              2: if (HiWord(g_HeroSelf.m_Abil.MC) = LoWord(MouseItem.S.NeedLevel)) and (g_HeroSelf.m_Abil.Level >= HiWord(MouseItem.S.NeedLevel)) then useable := TRUE;
            end;
            line3 := line3 + GetJobName(LoWord(MouseItem.S.NeedLevel)) + '专用:需要魔法' + IntToStr(HiWord(MouseItem.S.NeedLevel)) + ' ';
          end;
          13:begin
            case Who of
              1: if (HiWord(g_MySelf.m_Abil.SC) = LoWord(MouseItem.S.NeedLevel)) and (g_MySelf.m_Abil.Level >= HiWord(MouseItem.S.NeedLevel)) then useable := TRUE;
              2: if (HiWord(g_HeroSelf.m_Abil.SC) = LoWord(MouseItem.S.NeedLevel)) and (g_HeroSelf.m_Abil.Level >= HiWord(MouseItem.S.NeedLevel)) then useable := TRUE;
            end;
            line3 := line3 + GetJobName(LoWord(MouseItem.S.NeedLevel)) + '专用:需要道术' + IntToStr(HiWord(MouseItem.S.NeedLevel)) + ' ';
          end;
          0, 14: begin
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + '需要等级' + IntToStr(MouseItem.S.NeedLevel) + ' ';
          end;
          1, 15: begin
            case Who of
              1: if HiWord (g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord (g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + '需要攻击' + IntToStr(MouseItem.S.NeedLevel) + ' ';
          end;
          2, 16: begin
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + '需要魔法力' + IntToStr(MouseItem.S.NeedLevel) + ' ';
          end;
          3, 17: begin
            case Who of
              1: if HiWord (g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord (g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + '需要精神力' + IntToStr(MouseItem.S.NeedLevel) + ' ';
          end;
          4: begin
            useable := TRUE;
            line3 := line3 + '需要转生等级' + IntToStr(MouseItem.S.NeedLevel) + ' ';
          end;
          40: begin
            useable := TRUE;
            line3 := line3 + '需要转生&等级' + IntToStr(MouseItem.S.NeedLevel) + ' ';
          end;
          41: begin
            useable := TRUE;
            line3 := line3 + '需要转生&攻击' + IntToStr(MouseItem.S.NeedLevel) + ' ';
          end;
          42: begin
            useable := TRUE;
            line3 := line3 + '需要转生&魔法力' + IntToStr(MouseItem.S.NeedLevel) + ' ';
          end;
          43: begin
            useable := TRUE;
            line3 := line3 + '需要转生&精神力' + IntToStr(MouseItem.S.NeedLevel) + ' ';
          end;
          44: begin
            useable := TRUE;
            line3 := line3 + '需要转生&声望点' + IntToStr(MouseItem.S.NeedLevel) + ' ';
          end;
          5: begin
            useable := TRUE;
            line3 := line3 + '需要声望点' + IntToStr(MouseItem.S.NeedLevel) + ' ';
          end;
          6: begin
            useable := TRUE;
            line3 := line3 + '行会成员专用' + ' ';
          end;
          60: begin
            useable := TRUE;
            line3 := line3 + '行会掌门专用' + ' ';
          end;
          7: begin
            useable := TRUE;
            line3 := line3 + '沙城成员专用' + ' ';
          end;
          70: begin
            useable := TRUE;
            line3 := line3 + '沙城城主专用';
          end;
          8: begin
            useable := TRUE;
            line3 := line3 + '会员专用' + ' ';
          end;
          81: begin
            useable := TRUE;
            line3 := line3 + '会员类型 =' + IntToStr(LoWord(MouseItem.S.NeedLevel)) + '会员等级 >=' + IntToStr(HiWord(MouseItem.S.NeedLevel)) + ' ';
          end;
          82: begin
            useable := TRUE;
            line3 := line3 + '会员类型 >=' + IntToStr(LoWord(MouseItem.S.NeedLevel)) + '会员等级 >=' + IntToStr(HiWord(MouseItem.S.NeedLevel)) + ' ';
          end;
          //----内功相关
          18,22: begin//20090331  需等级  22为不带%号
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                if MouseItem.S.Need = 18 then str := '需要等级%d 内力恢复速度+%d%%'
                else str := '需要等级%d 内力恢复速度+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                if MouseItem.S.Need = 18 then str := '内力恢复速度+%d%%'
                else str := '内力恢复速度+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          19, 23: begin //需攻击力  23为不带%号
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                if MouseItem.S.Need = 19 then str := '需要攻击%d 内力恢复速度+%d%%'
                else str := '需要攻击%d 内力恢复速度+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                if MouseItem.S.Need = 19 then str := '内力恢复速度+%d%%'
                else str := '内力恢复速度+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          20, 24: begin //需魔法 24为不带%号
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                if MouseItem.S.Need = 20 then str := '需要魔法力%d 内力恢复速度+%d%%'
                else str := '需要魔法力%d 内力恢复速度+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                if MouseItem.S.Need = 20 then str := '内力恢复速度+%d%%'
                else str := '内力恢复速度+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          21, 25: begin //需道术 25为不带%号
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                if MouseItem.S.Need = 21 then str := '需要精神力%d 内力恢复速度+%d%%'
                else str := '需要精神力%d 内力恢复速度+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                if MouseItem.S.Need = 21 then str := '内力恢复速度+%d%%'
                else str := '内力恢复速度+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          //---防爆相关
          26: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要等级%d 防爆+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '防爆+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          27: begin //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要攻击%d 防爆+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '防爆+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          28: begin //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要魔法力%d 防爆+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '防爆+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          29: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要精神力%d 防爆+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '防爆+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          //虎威吸血
          30: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要等级%d 吸血0-%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
              end else begin
                str := '吸血0-%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock])
              end;
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          31: begin //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要攻击%d 吸血0-%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '吸血0-%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          32: begin //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要魔法力%d 吸血0-%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '吸血0-%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          33: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要精神力%d 吸血0-%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '吸血0-%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          //内伤等级
          34: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要等级%d 内伤等级+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '内伤等级+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          35: begin //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要攻击%d 内伤等级+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '内伤等级+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          36: begin //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要魔法力%d 内伤等级+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '内伤等级+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          37: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要精神力%d 内伤等级+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '内伤等级+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          //麻痹抗性
          45: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要等级%d 麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          46: begin //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要攻击%d 麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          47: begin //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要魔法力%d 麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          48: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要精神力%d 麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          //暴击等级   英雄物品,即主体不能使用
          49, 53: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + Format('需要等级%d ',[MouseItem.S.NeedLevel]);
          end;
          50, 54: begin  //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          51, 55: begin  //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          52, 56: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          61: begin
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.Stock then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.Stock then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then
            line3 := line3 + '需要等级' + IntToStr(MouseItem.S.Stock) + ' ';
          end;
          62: begin
            case Who of
              1: if HiWord (g_MySelf.m_Abil.DC) >= MouseItem.S.Stock then useable := TRUE;
              2: if HiWord (g_HeroSelf.m_Abil.DC) >= MouseItem.S.Stock then useable := TRUE;
            end;
            line3 := line3 + '需要攻击' + IntToStr(MouseItem.S.Stock) + ' ';
          end;
          63: begin
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.Stock then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.Stock then useable := TRUE;
            end;
            line3 := line3 + '需要魔法力' + IntToStr(MouseItem.S.Stock) + ' ';
          end;
          64: begin
            case Who of
              1: if HiWord (g_MySelf.m_Abil.SC) >= MouseItem.S.Stock then useable := TRUE;
              2: if HiWord (g_HeroSelf.m_Abil.SC) >= MouseItem.S.Stock then useable := TRUE;
            end;
            line3 := line3 + '需要精神力' + IntToStr(MouseItem.S.Stock) + ' ';
          end;
          //目标爆率
          65: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要等级%d 目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          66: begin //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要攻击%d 目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          67: begin //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要魔法力%d 目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          68: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要精神力%d 目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
        end;
        {$IF M2Version <> 2}
        if MouseItem.S.NeedIdentify > 0 then line3 := line3 + Format(' 暴击等级%d',[MouseItem.S.NeedIdentify]);//武器暴击等级 20100708
        if g_boOpenLeiMei then begin
          case MouseItem.btAppraisalLevel of  //是否可鉴定(无星  1－可鉴定 2－一鉴 3-二鉴  4-三鉴 1星: 11-可鉴定 12-一鉴 13-二鉴 14-三鉴..)
            1,11,21,31,41,51: begin //可鉴定
              line5 := '<可鉴定/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                11: line5 := line5 + '\*1';
                21: line5 := line5 + '\*2';
                31: line5 := line5 + '\*3';
                41: line5 := line5 + '\*4';
                51: line5 := line5 + '\*5';
              end;
            end;
            2,12,22,32,42,52: begin//一鉴
              line5 := '<一鉴 (仍可鉴定)/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                12: line5 := line5 + '\*1';
                22: line5 := line5 + '\*2';
                32: line5 := line5 + '\*3';
                42: line5 := line5 + '\*4';
                52: line5 := line5 + '\*5';
              end;
            end;
            3,13,23,33,43,53: begin;//二鉴
              line5 := '<二鉴 (仍可鉴定)/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                13: line5 := line5 + '\*1';
                23: line5 := line5 + '\*2';
                33: line5 := line5 + '\*3';
                43: line5 := line5 + '\*4';
                53: line5 := line5 + '\*5';
              end;
            end;
            4,14,24,34,44,54: begin //三鉴
              line5 := '<三鉴/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                14: line5 := line5 + '\*1';
                24: line5 := line5 + '\*2';
                34: line5 := line5 + '\*3';
                44: line5 := line5 + '\*4';
                54: line5 := line5 + '\*5';
              end;
            end;
          end;
          sUnKnow1 := GetAppendItemValue(MouseItem);
          sUnKnow2 := GetSecretItemValue(MouseItem);
        end;
        {$IFEND}
      end;

      7:begin
        case MouseItem.S.Shape of
          0,4 :begin  //千里传音, 传音筒
            line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);
            line2 := '次数 '+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax)+' 次';
          end;
          1:begin
            line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);
            line2 := 'HP '+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax)+' 万';
          end;
          2:begin
            line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);
            line2 := 'MP '+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax)+' 万';
          end;
          3:begin
            line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);
            line2 := 'HPMP '+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax)+' 万';
          end;
          {$Region '天龙印'}
          5: begin
            line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);
            line2 := 'HPMP '+ GetDuraX10Str(MouseItem.Dura, MouseItem.DuraMax);
            if MouseItem.Dura > 0 then
            begin
              
              if MouseItem.S.DC > 0 then line3 := '\攻击' + IntToStr(LoWord(MouseItem.S.DC)) + '-' + IntToStr(HiWord(MouseItem.S.DC));
              //if (MouseItem.btValue[2]>0) and  then Line3:=Line3+'<(+'+IntToStr(MouseItem.btValue[2])+')/c=lime> ';
              if MouseItem.S.MC > 0 then line3 := line3 + '\魔法' + IntToStr(LoWord(MouseItem.S.MC)) + '-' + IntToStr(HiWord(MouseItem.S.MC));
              //if MouseItem.btValue[3]>0 then Line3:=Line3+'<(+'+IntToStr(MouseItem.btValue[3])+')/c=lime> ';
              if MouseItem.S.SC > 0 then line3 := line3 + '\道术' + IntToStr(LoWord(MouseItem.S.SC)) + '-' + IntToStr(HiWord(MouseItem.S.SC));
              //if MouseItem.btValue[4]>0 then Line3:=Line3+'<(+'+IntToStr(MouseItem.btValue[4])+')/c=lime> ';
              if LoWord(MouseItem.S.AC) > 0 then line3 := line3 + '\\麻痹抗性 +' + IntToStr(LoWord(MouseItem.S.AC));
              if HiWord(MouseItem.S.AC) > 0 then line3 := line3 + '\敏捷+' + IntToStr(HiWord(MouseItem.S.AC));
              if LoWord(MouseItem.S.MAC) > 0 then line3 := line3 + '\合击威力 +' + IntToStr(LoWord(MouseItem.S.MAC));
              if HiWord(MouseItem.S.MAC) > 0 then line3 := line3 + '\准确+' + IntToStr(HiWord(MouseItem.S.MAC));
              case MouseItem.S.Need of
                0, 14: begin
                  case Who of
                    1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.NeedLevel > 0 then
                  line3 := line3 + '\需要等级' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                end;
                1, 15: begin
                  case Who of
                    1: if HiWord (g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord (g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  line3 := line3 + '\需要攻击' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                end;
                2, 16: begin
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  line3 := line3 + '\需要魔法力' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                end;
                3, 17: begin
                  case Who of
                    1: if HiWord (g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord (g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  line3 := line3 + '\需要精神力' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                end;
                4: begin
                  useable := TRUE;
                  line3 := line3 + '\需要转生等级' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                end;
                40: begin
                  useable := TRUE;
                  line3 := line3 + '\需要转生&等级' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                end;
                41: begin
                  useable := TRUE;
                  line3 := line3 + '\需要转生&攻击' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                end;
                42: begin
                  useable := TRUE;
                  line3 := line3 + '\需要转生&魔法力' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                end;
                43: begin
                  useable := TRUE;
                  line3 := line3 + '\需要转生&精神力' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                end;
                44: begin
                  useable := TRUE;
                  line3 := line3 + '\需要转生&声望点' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                end;
                5: begin
                  useable := TRUE;
                  line3 := line3 + '\需要声望点' + IntToStr(MouseItem.S.NeedLevel) + ' ';
                end;
                6: begin
                  useable := TRUE;
                  line3 := line3 + '\行会成员专用' + ' ';
                end;
                60: begin
                  useable := TRUE;
                  line3 := line3 + '\行会掌门专用' + ' ';
                end;
                7: begin
                  useable := TRUE;
                  line3 := line3 + '\沙城成员专用' + ' ';
                end;
                70: begin
                  useable := TRUE;
                  line3 := line3 + '\沙城城主专用';
                end;
                8: begin
                  useable := TRUE;
                  line3 := line3 + '\会员专用' + ' ';
                end;
                81: begin
                  useable := TRUE;
                  line3 := line3 + '\会员类型 =' + IntToStr(LoWord(MouseItem.S.NeedLevel)) + '会员等级 >=' + IntToStr(HiWord(MouseItem.S.NeedLevel)) + ' ';
                end;
                82: begin
                  useable := TRUE;
                  line3 := line3 + '\会员类型 >=' + IntToStr(LoWord(MouseItem.S.NeedLevel)) + '会员等级 >=' + IntToStr(HiWord(MouseItem.S.NeedLevel)) + ' ';
                end;
                //----内功相关
                18,22: begin//20090331  需等级  22为不带%号
                  case Who of
                    1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      if MouseItem.S.Need = 18 then str := '\内力恢复速度 +%d%%\需要等级%d'
                      else str := '\内力恢复速度 +%d\需要等级%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      if MouseItem.S.Need = 18 then str := '\内力恢复速度+%d%%'
                      else str := '\内力恢复速度 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要等级%d',[MouseItem.S.NeedLevel]);
                end;
                19, 23: begin //需攻击力  23为不带%号
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      if MouseItem.S.Need = 19 then str := '\内力恢复速度 +%d%%\需要攻击%d'
                      else str := '\内力恢复速度 +%d\需要攻击%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      if MouseItem.S.Need = 19 then str := '\内力恢复速度+%d%%'
                      else str := '\内力恢复速度 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要攻击%d',[MouseItem.S.NeedLevel]);
                end;
                20, 24: begin //需魔法 24为不带%号
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      if MouseItem.S.Need = 20 then str := '\内力恢复速度 +%d%%\需要魔法力%d'
                      else str := '\内力恢复速度 +%d\需要魔法力%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      if MouseItem.S.Need = 20 then str := '\内力恢复速度+%d%%'
                      else str := '\内力恢复速度 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要魔法力%d',[MouseItem.S.NeedLevel]);
                end;
                21, 25: begin //需道术 25为不带%号
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      if MouseItem.S.Need = 21 then str := '\内力恢复速度+%d%%\需要精神力%d'
                      else str := '\内力恢复速度 +%d\需要精神力%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      if MouseItem.S.Need = 21 then str := '\内力恢复速度+%d%%'
                      else str := '\内力恢复速度 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要精神力%d',[MouseItem.S.NeedLevel]);
                end;
                //---防爆相关
                26: begin //需等级
                  case Who of
                    1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\防爆 +%d\需要等级%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\防爆 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要等级%d',[MouseItem.S.NeedLevel]);
                end;
                27: begin //需攻击力
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\防爆 +%d\需要攻击%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\防爆 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要攻击%d',[MouseItem.S.NeedLevel]);
                end;
                28: begin //需魔法
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\防爆 +%d\需要魔法力%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\防爆 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要魔法力%d',[MouseItem.S.NeedLevel]);
                end;
                29: begin //需道术
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\防爆 +%d\需要精神力%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\防爆 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要精神力%d',[MouseItem.S.NeedLevel]);
                end;
                //虎威吸血
                30: begin //需等级
                  case Who of
                    1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\吸血 0-%d\需要等级%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel])
                    end else begin
                      str := '\吸血 0-%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock])
                    end;
                  end else line3 := line3 + Format('\需要等级%d',[MouseItem.S.NeedLevel]);
                end;
                31: begin //需攻击力
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\吸血 0-%d\需要攻击%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\吸血 0-%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要攻击%d',[MouseItem.S.NeedLevel]);
                end;
                32: begin //需魔法
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\吸血 0-%d\需要魔法力%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\吸血 0-%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要魔法力%d',[MouseItem.S.NeedLevel]);
                end;
                33: begin //需道术
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\吸血 0-%d\需要精神力%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\吸血 0-%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要精神力%d',[MouseItem.S.NeedLevel]);
                end;
                //内伤等级
                34: begin //需等级
                  case Who of
                    1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\内伤等级 +%d\需要等级%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\内伤等级 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要等级%d',[MouseItem.S.NeedLevel]);
                end;
                35: begin //需攻击力
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\内伤等级 +%d\需要攻击%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\内伤等级 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要攻击%d',[MouseItem.S.NeedLevel]);
                end;
                36: begin //需魔法
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\内伤等级 +%d\需要魔法力%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\内伤等级 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要魔法力%d',[MouseItem.S.NeedLevel]);
                end;
                37: begin //需道术
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\内伤等级 +%d\需要精神力%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\内伤等级 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要精神力%d',[MouseItem.S.NeedLevel]);
                end;
                //麻痹抗性
                {45: begin //需等级
                  case Who of
                    1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '需要等级%d \麻痹抗性+%d';
                      line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
                    end else begin
                      str := '\麻痹抗性+%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
                end;
                46: begin //需攻击力
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '需要攻击%d \麻痹抗性+%d';
                      line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
                    end else begin
                      str := '\麻痹抗性+%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
                end;
                47: begin //需魔法
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '需要魔法力%d \麻痹抗性+%d';
                      line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
                    end else begin
                      str := '\麻痹抗性+%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
                end;
                48: begin //需道术
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '需要精神力%d \麻痹抗性+%d';
                      line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
                    end else begin
                      str := '\麻痹抗性+%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
                end;
                }
                //暴击等级   英雄物品,即主体不能使用
                49, 53: begin //需等级
                  case Who of
                    1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  line3 := line3 + Format('\需要等级%d ',[MouseItem.S.NeedLevel]);
                end;
                50, 54: begin  //需攻击力
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  line3 := line3 + Format('\需要攻击%d',[MouseItem.S.NeedLevel]);
                end;
                51, 55: begin  //需魔法
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  line3 := line3 + Format('\需要魔法力%d',[MouseItem.S.NeedLevel]);
                end;
                52, 56: begin //需道术
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  line3 := line3 + Format('\需要精神力%d',[MouseItem.S.NeedLevel]);
                end;
                61: begin
                  case Who of
                    1: if g_MySelf.m_Abil.Level >= MouseItem.S.Stock then useable := TRUE;
                    2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.Stock then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then
                  line3 := line3 + '\需要等级' + IntToStr(MouseItem.S.Stock) + ' ';
                end;
                62: begin
                  case Who of
                    1: if HiWord (g_MySelf.m_Abil.DC) >= MouseItem.S.Stock then useable := TRUE;
                    2: if HiWord (g_HeroSelf.m_Abil.DC) >= MouseItem.S.Stock then useable := TRUE;
                  end;
                  line3 := line3 + '\需要攻击' + IntToStr(MouseItem.S.Stock) + ' ';
                end;
                63: begin
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.Stock then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.Stock then useable := TRUE;
                  end;
                  line3 := line3 + '\需要魔法力' + IntToStr(MouseItem.S.Stock) + ' ';
                end;
                64: begin
                  case Who of
                    1: if HiWord (g_MySelf.m_Abil.SC) >= MouseItem.S.Stock then useable := TRUE;
                    2: if HiWord (g_HeroSelf.m_Abil.SC) >= MouseItem.S.Stock then useable := TRUE;
                  end;
                  line3 := line3 + '\需要精神力' + IntToStr(MouseItem.S.Stock) + ' ';
                end;
                //目标爆率
                65: begin //需等级
                  case Who of
                    1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\目标爆率 +%d\需要等级%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\目标爆率 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要等级%d',[MouseItem.S.NeedLevel]);
                end;
                66: begin //需攻击力
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\目标爆率 +%d\需要攻击%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\目标爆率 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要攻击%d',[MouseItem.S.NeedLevel]);
                end;
                67: begin //需魔法
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\目标爆率 +%d\需要魔法力%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\目标爆率 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要魔法力%d',[MouseItem.S.NeedLevel]);
                end;
                68: begin //需道术
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then
                  begin
                    if MouseItem.S.NeedLevel > 0 then
                    begin
                      str := '\目标爆率 +%d\需要精神力%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else
                    begin
                      str := '\目标爆率 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else
                    line3 := line3 + Format('\需要精神力%d',[MouseItem.S.NeedLevel]);
                end;
                //麻痹强化
                72: begin //需等级
                  case Who of
                    1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                      str := '\麻痹强化 +%d\需要等级%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                  end else line3 := line3 + Format('\需要等级%d',[MouseItem.S.NeedLevel]);
                  line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight) + '\持久'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax)+' ';
                  {//if MouseItem.S.AC > 0 then line2 := '防御' + IntToStr(LoWord(MouseItem.S.AC)) + '-' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
                  //if MouseItem.S.MAC > 0 then line2 := line2 + '魔御' + IntToStr(LoWord(MouseItem.S.MAC)) + '-' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
                  if MouseItem.S.DC > 0 then line2 := line2 + '\攻击' + IntToStr(LoWord(MouseItem.S.DC)) + '-' + IntToStr(HiWord(MouseItem.S.DC))+' ';
                  //if MouseItem.btValue[2]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[2])+')/c=lime> ';
                  if MouseItem.S.MC > 0 then line2 := line2 + '\魔法' + IntToStr(LoWord(MouseItem.S.MC)) + '-' + IntToStr(HiWord(MouseItem.S.MC))+' ';
                  //if MouseItem.btValue[3]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[3])+')/c=lime> ';
                  if MouseItem.S.SC > 0 then line2 := line2 + '\道术' + IntToStr(LoWord(MouseItem.S.SC)) + '-' + IntToStr(HiWord(MouseItem.S.SC))+' ';
                  //if MouseItem.btValue[4]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[4])+')/c=lime> ';
                  }If MouseItem.s.Stock>0 Then Line2 := line2 + '\麻痹强化 +'+IntToStr(MouseItem.s.Stock)+' ';
                  If MouseItem.s.NeedLevel>0 Then
                    Line3 :=line3 + '\需要等级'+IntToStr(MouseItem.s.NeedLevel)+' ';
                end;
                73: begin //需攻击力
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                      str := '\麻痹强化 +%d\需要攻击%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                  end else line3 := line3 + Format('\需要攻击%d',[MouseItem.S.NeedLevel]);
                  If MouseItem.s.Stock>0 Then line2 := line2 + '\麻痹强化 +'+IntToStr(MouseItem.s.Stock)+' ';
                  {??
                  If MouseItem.s.NeedLevel>0 Then
                    Line3 :=line3 + '需要等级'+IntToStr(MouseItem.s.NeedLevel)+' ';}
                end;
                74: begin //需魔法
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                      str := '\麻痹强化 +%d\需要魔法力%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                  end else line3 := line3 + Format('\需要魔法力%d',[MouseItem.S.NeedLevel]);
                  //if MouseItem.S.AC > 0 then line2 := '防御' + IntToStr(LoWord(MouseItem.S.AC)) + '-' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
                  //if MouseItem.S.MAC > 0 then line2 := line2 + '魔御' + IntToStr(LoWord(MouseItem.S.MAC)) + '-' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
                  if MouseItem.S.DC > 0 then line2 := line2 + '\攻击' + IntToStr(LoWord(MouseItem.S.DC)) + '-' + IntToStr(HiWord(MouseItem.S.DC))+' ';
                  //if MouseItem.btValue[2]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[2])+')/c=lime> ';
                  if MouseItem.S.MC > 0 then line2 := line2 + '\魔法' + IntToStr(LoWord(MouseItem.S.MC)) + '-' + IntToStr(HiWord(MouseItem.S.MC))+' ';
                  //if MouseItem.btValue[3]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[3])+')/c=lime> ';
                  if MouseItem.S.SC > 0 then line2 := line2 + '\道术' + IntToStr(LoWord(MouseItem.S.SC)) + '-' + IntToStr(HiWord(MouseItem.S.SC))+' ';
                  //if MouseItem.btValue[4]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[4])+')/c=lime> ';
                  If MouseItem.s.Stock>0 Then line2 := line2 + '\麻痹强化 +'+IntToStr(MouseItem.s.Stock)+' ';
                  {??
                  If MouseItem.s.NeedLevel>0 Then
                    Line6 :=line6 + '需要等级'+IntToStr(MouseItem.s.NeedLevel)+' '; }
                end;
                75: begin //需道术
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                      str := '\麻痹强化 +%d\需要精神力%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                  end else line3 := line3 + Format('\需要精神力%d',[MouseItem.S.NeedLevel]);
                  {//if MouseItem.S.AC > 0 then line2 := '防御' + IntToStr(LoWord(MouseItem.S.AC)) + '-' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
                  //if MouseItem.S.MAC > 0 then line2 := line2 + '魔御' + IntToStr(LoWord(MouseItem.S.MAC)) + '-' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
                  if MouseItem.S.DC > 0 then line2 := line2 + '攻击' + IntToStr(LoWord(MouseItem.S.DC)) + '-' + IntToStr(HiWord(MouseItem.S.DC))+' ';
                  //if MouseItem.btValue[2]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[2])+')/c=lime> ';
                  if MouseItem.S.MC > 0 then line2 := line2 + '魔法' + IntToStr(LoWord(MouseItem.S.MC)) + '-' + IntToStr(HiWord(MouseItem.S.MC))+' ';
                  //if MouseItem.btValue[3]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[3])+')/c=lime> ';
                  if MouseItem.S.SC > 0 then line2 := line2 + '道术' + IntToStr(LoWord(MouseItem.S.SC)) + '-' + IntToStr(HiWord(MouseItem.S.SC))+' ';
                  //if MouseItem.btValue[4]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[4])+')/c=lime> ';
                  }
                  If MouseItem.s.Stock>0 Then line2 := line2 + '\麻痹强化 +'+IntToStr(MouseItem.s.Stock)+' ';
                  //If MouseItem.s.NeedLevel>0 Then Line6 :=line6 + '需要等级'+IntToStr(MouseItem.s.NeedLevel)+' ';
                end;
                //攻击速度
                91: begin //需等级
                  case Who of
                    1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\攻击速度 +%d\需要等级%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\攻击速度 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要等级%d',[MouseItem.S.NeedLevel]);
                end;
                92: begin //需攻击力
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\攻击速度 +%d\需要攻击%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\攻击速度 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要攻击%d',[MouseItem.S.NeedLevel]);
                end;
                93: begin //需魔法
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := ' \攻击速度 +%d\需要魔法力%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\攻击速度 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要魔法力%d',[MouseItem.S.NeedLevel]);
                end;
                94: begin //需道术
                  case Who of
                    1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                    2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
                  end;
                  if MouseItem.S.Stock > 0 then begin
                    if MouseItem.S.NeedLevel > 0 then begin
                      str := '\攻击速度 +%d\需要精神力%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock,MouseItem.S.NeedLevel]);
                    end else begin
                      str := '\攻击速度 +%d';
                      line3 := line3 + Format(str,[MouseItem.S.Stock]);
                    end;
                  end else line3 := line3 + Format('\需要精神力%d',[MouseItem.S.NeedLevel]);
                end;
              end;
            end;
            str:=GetItemDesc(MouseItem.S.Name);
            if str <> '' then line3 := line3 + ' ' + str;
          end;
          {$EndRegion}
        end;
      end;

      8: begin  //制酒材料 20080622
        line1 := line1 + '品质' + IntToStr(MouseItem.S.AC);
        str := GetItemDesc(MouseItem.S.Name);
        if str <> '' then begin
          str := GetValidStr3 (str, line2, ['\']);
          str := GetValidStr3 (str, line3, ['\']);
        end;
      end;
      9: begin  //酿酒水材料
        line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);;
        str := GetItemDesc(MouseItem.S.Name);
        if str <> '' then begin
          str := GetValidStr3 (str, line2, ['\']);
          str := GetValidStr3 (str, line3, ['\']);
        end;
      end;
      12: begin //酒器
        line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);;
        str := GetItemDesc(MouseItem.S.Name);
        if str <> '' then begin
          str := GetValidStr3 (str, line2, ['\']);
          str := GetValidStr3 (str, line3, ['\']);
        end;
      end;
      13: begin //酒曲
        line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);;
        str := GetItemDesc(MouseItem.S.Name);
        if str <> '' then begin
          str := GetValidStr3 (str, line2, ['\']);
          str := GetValidStr3 (str, line3, ['\']);
        end;
      end;
      14: begin //酿酒药材
        line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);;
        str := GetItemDesc(MouseItem.S.Name);
        if str <> '' then begin
          str := GetValidStr3 (str, line2, ['\']);
          str := GetValidStr3 (str, line3, ['\']);
        end;
      end;
      60: begin //酒和烧酒
        if MouseItem.S.Shape <> 0 then begin
          line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight) + ' 容量' + GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
          if MouseItem.S.NeedLevel > 0 then line2 := line2 + '等级' + IntToStr(MouseItem.S.NeedLevel)+' ';
          line2 := line2 + '品质' + IntToStr(MouseItem.S.AC) + ' 酒精度' + IntToStr(MouseItem.S.MAC) + '°';
        end else line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);
        case MouseItem.S.Shape of
          1: line3 := '白酒，酒体醇厚，口感绵长，多为豪侠所喜';
          2: line3 := '白酒，略带甘甜，带有浓厚的乡土气息';
          3: line3 := '白酒，带有高原的独特风情，口感醇和';
          4: line3 := '白酒，以果味入酒，不经意间催人入醉乡';
          5: line3 := '黄酒，酒性柔和，橙黄清亮，有暖胃之功效';
          6: line3 := '黄酒，红曲作引，入口甘甜却无粘稠之感';
          7: line3 := '黄酒，酒色红褐，盈盅不溢，多流传于民间';
          8: line3 := '有强筋健骨之用，需酒量'+IntToStr(MouseItem.S.Need)+'方可饮用';
          9: line3 := '此酒可养心和血，需酒量'+IntToStr(MouseItem.S.Need)+'方可饮用';
          10: line3 := '可使人身手更为灵活，需酒量'+IntToStr(MouseItem.S.Need)+'方可饮用';
          11: line3 := '可坚筋骨，耐寒暑，需酒量'+IntToStr(MouseItem.S.Need)+'方可饮用';
          12: line3 := '可益气补肾，需酒量'+IntToStr(MouseItem.S.Need)+'方可饮用';
          13..16:begin//20100411 增加
            str := GetItemDesc(MouseItem.S.Name);
            if str <> '' then str := GetValidStr3 (str, line3, ['\']);
          end;
        end;
      end;

      10, 11: begin //男衣服, 女衣服
        useable := FALSE;
        {If MouseItem.s.nHP>0 then Line3:=Line3+'\体力值 +'+IntToStr(MouseItem.s.nHP)+' ';
        If MouseItem.s.nMP>0 Then Line3:=Line3+'\魔法值 +'+IntToStr(MouseItem.s.nMP)+' ';
        }line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight) + ' 持久'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
        if MouseItem.S.AC > 0 then line2 := '\防御' + IntToStr(LoWord(MouseItem.S.AC)) + '-' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
        if MouseItem.S.MAC > 0 then line2 := line2 + '\魔御' + IntToStr(LoWord(MouseItem.S.MAC)) + '-' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
        if MouseItem.S.DC > 0 then line2 := line2 + '\攻击' + IntToStr(LoWord(MouseItem.S.DC)) + '-' + IntToStr(HiWord(MouseItem.S.DC))+' ';
        //if MouseItem.btValue[2]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[2])+')/c=lime> ';
        if MouseItem.S.MC > 0 then line2 := line2 + '\魔法' + IntToStr(LoWord(MouseItem.S.MC)) + '-' + IntToStr(HiWord(MouseItem.S.MC))+' ';
        //if MouseItem.btValue[3]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[3])+')/c=lime> ';
        if MouseItem.S.SC > 0 then line2 := line2 + '\道术' + IntToStr(LoWord(MouseItem.S.SC)) + '-' + IntToStr(HiWord(MouseItem.S.SC))+' ';
        //if MouseItem.btValue[4]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[4])+')/c=lime> ';

        if LoByte(MouseItem.S.Source) > 0 then line3 := line3 + '\幸运+' + IntToStr(LoByte(MouseItem.S.Source)) + ' ';
        if HiByte(MouseItem.S.Source) > 0 then line3 := line3 + '\诅咒+' + IntToStr(HiByte(MouseItem.S.Source)) + ' ';

        case MouseItem.S.Need of
          0, 14: begin
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then
                 useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then
                 useable := TRUE;
            end;
            line3 := line3 + '需要等级' + IntToStr(MouseItem.S.NeedLevel);
          end;
          1, 15: begin
            case Who of
              1: if HiWord (g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then
                 useable := TRUE;
              2: if HiWord (g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then
                 useable := TRUE;
            end;
            line3 := line3 + '需要攻击' + IntToStr(MouseItem.S.NeedLevel);
          end;
          2, 16: begin
            case Who of
              1: if HiWord (g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then
                 useable := TRUE;
              2: if HiWord (g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then
                 useable := TRUE;
            end;
            line3 := line3 + '需要魔法力' + IntToStr(MouseItem.S.NeedLevel);
          end;
          3, 17: begin
            case Who of
              1: if HiWord (g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then
                 useable := TRUE;
              2: if HiWord (g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then
                 useable := TRUE;
            end;
            line3 := line3 + '需要精神力' + IntToStr(MouseItem.S.NeedLevel);
          end;
          4: begin
            useable := TRUE;
            line3 := line3 + '需要转生等级' + IntToStr(MouseItem.S.NeedLevel);
          end;
          40: begin
            useable := TRUE;
            line3 := line3 + '需要转生&等级' + IntToStr(MouseItem.S.NeedLevel);
          end;
          41: begin
            useable := TRUE;
            line3 := line3 + '需要转生&攻击力' + IntToStr(MouseItem.S.NeedLevel);
          end;
          42: begin
            useable := TRUE;
            line3 := line3 + '需要转生&魔法力' + IntToStr(MouseItem.S.NeedLevel);
          end;
          43: begin
            useable := TRUE;
            line3 := line3 + '需要转生&精神力' + IntToStr(MouseItem.S.NeedLevel);
          end;
          44: begin
            useable := TRUE;
            line3 := line3 + '需要转生&声望点' + IntToStr(MouseItem.S.NeedLevel);
          end;
          5: begin
            useable := TRUE;
            line3 := line3 + '需要声望点' + IntToStr(MouseItem.S.NeedLevel);
          end;
          6: begin
            useable := TRUE;
            line3 := line3 + '行会成员专用';
          end;
          60: begin
            useable := TRUE;
            line3 := line3 + '行会掌门专用';
          end;
          7: begin
            useable := TRUE;
            line3 := line3 + '沙城成员专用';
          end;
          70: begin
            useable := TRUE;
            line3 := line3 + '沙城城主专用';
          end;
          8: begin
            useable := TRUE;
            line3 := line3 + '会员专用';
          end;
          81: begin
            useable := TRUE;
            line3 := line3 + '会员类型 =' + IntToStr(LoWord(MouseItem.S.NeedLevel)) + '会员等级 >=' + IntToStr(HiWord(MouseItem.S.NeedLevel));
          end;
          82: begin
            useable := TRUE;
            line3 := line3 + '会员类型 >=' + IntToStr(LoWord(MouseItem.S.NeedLevel)) + '会员等级 >=' + IntToStr(HiWord(MouseItem.S.NeedLevel));
          end;
          //----内功相关
          18,22: begin//20090331  需等级  22为不带%号
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin

              if MouseItem.S.Need = 18 then str := '需要等级%d 内力恢复速度+%d%%'
              else str := '需要等级%d 内力恢复速度+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          19, 23: begin //需攻击力  23为不带%号
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.Need = 19 then str := '需要攻击%d 内力恢复速度+%d%%'
              else str := '需要攻击%d 内力恢复速度+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          20, 24: begin //需魔法 24为不带%号
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.Need = 20 then str := '需要魔法力%d 内力恢复速度+%d%%'
              else str := '需要魔法力%d 内力恢复速度+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          21, 25: begin //需道术 25为不带%号
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.Need = 21 then str := '需要精神力%d 内力恢复速度+%d%%'
              else str := '需要精神力%d 内力恢复速度+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          //---防爆相关
          26: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要等级%d 防爆+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          27: begin //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要攻击%d 防爆+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          28: begin //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要魔法力%d 防爆+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          29: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要精神力%d 防爆+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          //虎威吸血
          30: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要等级%d 吸血0-%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          31: begin //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要攻击%d 吸血0-%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          32: begin //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要魔法力%d 吸血0-%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          33: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要精神力%d 吸血0-%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          //内伤等级
          34: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要等级%d 内伤等级+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          35: begin //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要攻击%d 内伤等级+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          36: begin //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要魔法力%d 内伤等级+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          37: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要精神力%d 内伤等级+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          //麻痹抗性
          45: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
                str := '需要等级%d 麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          46: begin //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
                str := '需要攻击%d 麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          47: begin //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
                str := '需要魔法力%d 麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          48: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
                str := '需要精神力%d 麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          //英雄物品,即主体不能使用
          53: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + Format('需要等级%d ',[MouseItem.S.NeedLevel]);
          end;
          54: begin  //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          55: begin  //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          56: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          61: begin
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.Stock then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.Stock then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then
            line3 := line3 + '需要等级' + IntToStr(MouseItem.S.Stock) + ' ';
          end;
          62: begin
            case Who of
              1: if HiWord (g_MySelf.m_Abil.DC) >= MouseItem.S.Stock then useable := TRUE;
              2: if HiWord (g_HeroSelf.m_Abil.DC) >= MouseItem.S.Stock then useable := TRUE;
            end;
            line3 := line3 + '需要攻击' + IntToStr(MouseItem.S.Stock) + ' ';
          end;
          63: begin
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.Stock then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.Stock then useable := TRUE;
            end;
            line3 := line3 + '需要魔法力' + IntToStr(MouseItem.S.Stock) + ' ';
          end;
          64: begin
            case Who of
              1: if HiWord (g_MySelf.m_Abil.SC) >= MouseItem.S.Stock then useable := TRUE;
              2: if HiWord (g_HeroSelf.m_Abil.SC) >= MouseItem.S.Stock then useable := TRUE;
            end;
            line3 := line3 + '需要精神力' + IntToStr(MouseItem.S.Stock) + ' ';
          end;
          //目标爆率
          65: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要等级%d 目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          66: begin //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要攻击%d 目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          67: begin //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要魔法力%d 目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          68: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要精神力%d 目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
        end;
        {$IF M2Version <> 2}
        if g_boOpenLeiMei then begin
          case MouseItem.btAppraisalLevel of  //是否可鉴定(无星  1－可鉴定 2－一鉴 3-二鉴  4-三鉴 1星: 11-可鉴定 12-一鉴 13-二鉴 14-三鉴..)
             1,11,21,31,41,51: begin //可鉴定
              line5 := '<可鉴定/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                11: line5 := line5 + '\*1';
                21: line5 := line5 + '\*2';
                31: line5 := line5 + '\*3';
                41: line5 := line5 + '\*4';
                51: line5 := line5 + '\*5';
              end;
            end;
            2,12,22,32,42,52: begin//一鉴
              line5 := '<一鉴 (仍可鉴定)/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                12: line5 := line5 + '\*1';
                22: line5 := line5 + '\*2';
                32: line5 := line5 + '\*3';
                42: line5 := line5 + '\*4';
                52: line5 := line5 + '\*5';
              end;
            end;
            3,13,23,33,43,53: begin;//二鉴
              line5 := '<二鉴 (仍可鉴定)/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                13: line5 := line5 + '\*1';
                23: line5 := line5 + '\*2';
                33: line5 := line5 + '\*3';
                43: line5 := line5 + '\*4';
                53: line5 := line5 + '\*5';
              end;
            end;
            4,14,24,34,44,54: begin //三鉴
              line5 := '<三鉴/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                14: line5 := line5 + '\*1';
                24: line5 := line5 + '\*2';
                34: line5 := line5 + '\*3';
                44: line5 := line5 + '\*4';
                54: line5 := line5 + '\*5';
              end;
            end;
          end;
          sUnKnow1 := GetAppendItemValue(MouseItem);
          sUnKnow2 := GetSecretItemValue(MouseItem);
        end;
       (* if MouseItem.btUnKnowValue[6] > 0 then begin
          if MouseItem.btUnKnowValue[6] in [231..250] then begin
            if MouseItem.Aura > 0 then begin
              line7 := line7 + Format('<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Round(11.4 * (MouseItem.btUnKnowValue[6]-230){值}) , MouseItem.Aura, MouseItem.MaxAura]);
            end else begin
              line7 := line7 + Format('<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Round(11.4 * (MouseItem.btUnKnowValue[6]-230){值}) , 0, MouseItem.MaxAura]);
            end;
          end;
        end;
        if MouseItem.btUnKnowValue[7] > 0 then begin
          if MouseItem.btUnKnowValue[7] in [231..250] then begin
            if MouseItem.Aura > 0 then begin
              line7 := line7 + Format('<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Round(11.4 * (MouseItem.btUnKnowValue[7]-230){值}) , MouseItem.Aura, MouseItem.MaxAura]);
            end else begin
              line7 := line7 + Format('<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Round(11.4 * (MouseItem.btUnKnowValue[7]-230){值}) , 0, MouseItem.MaxAura]);
            end;
          end;
        end;
        if MouseItem.btUnKnowValue[8] > 0 then begin
          if MouseItem.btUnKnowValue[8] in [231..250] then begin
            if MouseItem.Aura > 0 then begin
              line7 := line7 + Format('<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Round(11.4 * (MouseItem.btUnKnowValue[8]-230){值}) , MouseItem.Aura, MouseItem.MaxAura]);
            end else begin
              line7 := line7 + Format('<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Round(11.4 * (MouseItem.btUnKnowValue[8]-230){值}) , 0, MouseItem.MaxAura]);
            end;
          end;
        end;
        if MouseItem.btUnKnowValue[9] > 0 then begin
          if MouseItem.btUnKnowValue[9] in [231..250] then begin
            if MouseItem.Aura > 0 then begin
              line7 := line7 + Format('<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Round(11.4 * (MouseItem.btUnKnowValue[9]-230){值}) , MouseItem.Aura, MouseItem.MaxAura]);
            end else begin
              line7 := line7 + Format('<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Round(11.4 * (MouseItem.btUnKnowValue[9]-230){值}) , 0, MouseItem.MaxAura]);
            end;
          end;
        end;   *)
        {$IFEND}
      end;
      
      15,30,16,     //头盔,照明物,斗笠
      19,20,21,28,29,  //项链 20100513增加27,28分类  20100628 增加29分类
      22,23,27,  //戒指
      24,26, //手镯
      52,62,   //鞋
      53,63,//宝石
      54,64: begin  //腰带
        useable := FALSE;
        {If MouseItem.s.nHP>0 then Line3:=Line3+'\体力值 +'+IntToStr(MouseItem.s.nHP)+' ';
        If MouseItem.s.nMP>0 Then Line3:=Line3+'\魔法值 +'+IntToStr(MouseItem.s.nMP)+' ';
        }if (MouseItem.S.Shape = 188) and (MouseItem.S.Reserved > 0) then line1 := '等级' + IntToStr(MouseItem.S.Reserved) + ' ';
        line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight) + ' 持久'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
        case MouseItem.S.StdMode of
          19,53{宝石}: begin//项链
            if HiWord(MouseItem.S.AC) > 0 then line2 := line2 + '\魔法躲避+' + IntToStr(HiWord(MouseItem.S.AC) * 10) + '% ';
            if LoWord(MouseItem.S.MAC) > 0 then line2 := line2 + '\诅咒+' + IntToStr(LoWord(MouseItem.S.MAC)) + ' ';
            if HiWord(MouseItem.S.MAC) > 0 then line2 := line2 + '\幸运+' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
          end;
          20, 24, 27: begin//项链 及 手镯: MaxAC -> Hit,  MaxMac -> Speed
            if MouseItem.S.AC > 0 then line2 := line2 + '\准确+' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
            if MouseItem.S.MAC > 0 then line2 := line2 + '\敏捷+' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
          end;
          21: begin //项链
            if HiWord(MouseItem.S.AC) > 0 then line2 := line2 + '\体力恢复+' + IntToStr(HiWord(MouseItem.S.AC) * 10) + '% ';
            if HiWord(MouseItem.S.MAC) > 0 then line2 := line2 + '\魔法恢复+' + IntToStr(HiWord(MouseItem.S.MAC) * 10) + '% ';
            if LoWord(MouseItem.S.AC) > 0 then line2 := line2 + '\攻击速度+' + IntToStr(LoWord(MouseItem.S.AC)) + ' ';
            if LoWord(MouseItem.S.MAC) > 0 then line2 := line2 + '\攻击速度-' + IntToStr(LoWord(MouseItem.S.MAC)) + ' ';
          end;
          23: begin //戒指
            if HiWord(MouseItem.S.AC) > 0 then line2 := line2 + '\毒物躲避+' + IntToStr(HiWord(MouseItem.S.AC) * 10) + '% ';
            if HiWord(MouseItem.S.MAC) > 0 then line2 := line2 + '\中毒恢复+' + IntToStr(HiWord(MouseItem.S.MAC) * 10) + '% ';
            if LoWord(MouseItem.S.AC) > 0 then line2 := line2 + '\攻击速度+' + IntToStr(LoWord(MouseItem.S.AC)) + ' ';
            if LoWord(MouseItem.S.MAC) > 0 then line2 := line2 + '\攻击速度-' + IntToStr(LoWord(MouseItem.S.MAC)) + ' ';
          end;
          28: begin//准确幸运型项链 20100513
            if MouseItem.S.AC > 0 then line2 := line2 + '\准确+' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
            if LoWord(MouseItem.S.MAC) > 0 then line2 := line2 + '\诅咒+' + IntToStr(LoWord(MouseItem.S.MAC)) + ' ';
            if HiWord(MouseItem.S.MAC) > 0 then line2 := line2 + '\幸运+' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
          end;
          29: begin//20100628 敏捷幸运型项链
            if LoWord(MouseItem.S.MAC) > 0 then line2 := line2 + '\诅咒+' + IntToStr(LoWord(MouseItem.S.MAC)) + ' ';
            if HiWord(MouseItem.S.MAC) > 0 then line2 := line2 + '\幸运+' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
            if MouseItem.S.AC > 0 then line2 := line2 + '\敏捷+' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
          end;
          (*28,27{腰带}: begin //靴子  20100513 注释
                if MouseItem.S.AC > 0 then
                   line2 := line2 + '防御' + IntToStr(LoWord(MouseItem.S.AC)) + '-' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
                if MouseItem.S.MAC > 0 then
                   line2 := line2 + '魔御' + IntToStr(LoWord(MouseItem.S.MAC)) + '-' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
          end;   *)
          52,54: begin//腰带，靴子负重 20080325
            if MouseItem.S.AC > 0 then line2 := line2 + '\防御' + IntToStr(LoWord(MouseItem.S.AC)) + '-' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
            if MouseItem.S.MAC > 0 then line2 := line2 + '\魔御' + IntToStr(LoWord(MouseItem.S.MAC)) + '-' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
            if MouseItem.S.AniCount > 0 then line2 := line2 + '\负重+' + IntToStr(MouseItem.S.AniCount) + ' ';
          end;
          63: begin //Charm
            if LoWord(MouseItem.S.AC) > 0 then line2 := line2 + '\HP+' + IntToStr(LoWord(MouseItem.S.AC)) + ' ';
            if HiWord(MouseItem.S.AC) > 0 then line2 := line2 + '\MP+' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
            if LoWord(MouseItem.S.MAC) > 0 then line2 := line2 + '\诅咒+' + IntToStr(LoWord(MouseItem.S.MAC)) + ' ';
            if HiWord(MouseItem.S.MAC) > 0 then line2 := line2 + '\幸运+' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
          end;
          else begin
            if MouseItem.S.AC > 0 then line2 := line2 + '\防御' + IntToStr(LoWord(MouseItem.S.AC)) + '-' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
            if MouseItem.S.MAC > 0 then line2 := line2 + '\魔御' + IntToStr(LoWord(MouseItem.S.MAC)) + '-' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
          end;
        end;
        if MouseItem.S.DC > 0 then line2 := line2 + '\攻击' + IntToStr(LoWord(MouseItem.S.DC)) + '-' + IntToStr(HiWord(MouseItem.S.DC))+' ';
        //if MouseItem.btValue[2]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[2])+')/c=lime> ';
        if MouseItem.S.MC > 0 then line2 := line2 + '\魔法' + IntToStr(LoWord(MouseItem.S.MC)) + '-' + IntToStr(HiWord(MouseItem.S.MC))+' ';
        //if MouseItem.btValue[3]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[3])+')/c=lime> ';
        if MouseItem.S.SC > 0 then line2 := line2 + '\道术' + IntToStr(LoWord(MouseItem.S.SC)) + '-' + IntToStr(HiWord(MouseItem.S.SC))+' ';
        //if MouseItem.btValue[4]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[4])+')/c=lime> ';
        if (MouseItem.S.Source <= -1) and (MouseItem.S.Source >= -50) then line2 := line2 + '神圣+' + IntToStr(-MouseItem.S.Source)+' ';
        if (MouseItem.S.Source <= -51) and (MouseItem.S.Source >= -100) then line2 := line2 + '神圣-' + IntToStr(-MouseItem.S.Source - 50)+' ';

        case MouseItem.S.Need of
          0, 14: begin
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.NeedLevel > 0 then
            line3 := line3 + '需要等级' + IntToStr(MouseItem.S.NeedLevel);
          end;
          1, 15: begin
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + '需要攻击力' + IntToStr(MouseItem.S.NeedLevel);
          end;
          2, 16: begin
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + '需要魔法力' + IntToStr(MouseItem.S.NeedLevel);
          end;
          3, 17: begin
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + '需要精神力' + IntToStr(MouseItem.S.NeedLevel);
          end;
          4: begin
            useable := TRUE;
            line3 := line3 + '需要转生等级' + IntToStr(MouseItem.S.NeedLevel);
          end;
          40: begin
            useable := TRUE;
            line3 := line3 + '需要转生&等级' + IntToStr(MouseItem.S.NeedLevel);
          end;
          41: begin
            useable := TRUE;
            line3 := line3 + '需要转生&攻击' + IntToStr(MouseItem.S.NeedLevel);
          end;
          42: begin
            useable := TRUE;
            line3 := line3 + '需要转生&魔法力' + IntToStr(MouseItem.S.NeedLevel);
          end;
          43: begin
            useable := TRUE;
            line3 := line3 + '需要转生&精神力' + IntToStr(MouseItem.S.NeedLevel);
          end;
          44: begin
            useable := TRUE;
            line3 := line3 + '需要转生&声望点' + IntToStr(MouseItem.S.NeedLevel);
          end;
          5: begin
            useable := TRUE;
            line3 := line3 + '需要声望点' + IntToStr(MouseItem.S.NeedLevel);
          end;
          6: begin
            useable := TRUE;
            line3 := line3 + '行会成员专用';
          end;
          60: begin
            useable := TRUE;
            line3 := line3 + '行会掌门专用';
          end;
          7: begin
            useable := TRUE;
            line3 := line3 + '沙城成员专用';
          end;
          70: begin
            useable := TRUE;
            line3 := line3 + '沙城城主专用';
          end;
          8: begin
            useable := TRUE;
            line3 := line3 + '会员专用';
          end;
          81: begin
            useable := TRUE;
            line3 := line3 + '会员类型=' + IntToStr(LoWord(MouseItem.S.NeedLevel)) + '会员等级 >=' + IntToStr(HiWord(MouseItem.S.NeedLevel));
          end;
          82: begin
            useable := TRUE;
            line3 := line3 + '会员类型>=' + IntToStr(LoWord(MouseItem.S.NeedLevel)) + '会员等级 >=' + IntToStr(HiWord(MouseItem.S.NeedLevel));
          end;
          //----内功相关
          18,22: begin//20090331  需等级  22为不带%号
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.Need = 18 then str := '需要等级%d 内力恢复速度+%d%%'
              else str := '需要等级%d 内力恢复速度+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          19, 23: begin //需攻击力  23为不带%号
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.Need = 19 then str := '需要攻击%d 内力恢复速度+%d%%'
              else str := '需要攻击%d 内力恢复速度+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          20, 24: begin //需魔法 24为不带%号
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.Need = 20 then str := '需要魔法力%d 内力恢复速度+%d%%'
              else str := '需要魔法力%d 内力恢复速度+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          21, 25: begin //需道术 25为不带%号
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.Need = 21 then str := '需要精神力%d 内力恢复速度+%d%%'
              else str := '需要精神力%d 内力恢复速度+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          //---防爆相关
          26: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要等级%d 防爆+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          27: begin //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要攻击%d 防爆+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          28: begin //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要魔法力%d 防爆+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          29: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要精神力%d 防爆+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          //虎威吸血
          30: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要等级%d 吸血0-%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          31: begin //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要攻击%d 吸血0-%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          32: begin //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要魔法力%d 吸血0-%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          33: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要精神力%d 吸血0-%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          //内伤等级
          34: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要等级%d 内伤等级+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          35: begin //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要攻击%d 内伤等级+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          36: begin //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要魔法力%d 内伤等级+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          37: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              str := '需要精神力%d 内伤等级+%d';
              line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock])
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          //麻痹抗性
          45: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
                str := '需要等级%d 麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          46: begin //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
                str := '需要攻击%d 麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          47: begin //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
                str := '需要魔法力%d 麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          48: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
                str := '需要精神力%d 麻痹抗性+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          //英雄物品,即主体不能使用
          53: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + Format('需要等级%d ',[MouseItem.S.NeedLevel]);
          end;
          54: begin  //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          55: begin  //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          56: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
          61: begin
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.Stock then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.Stock then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then
            line3 := line3 + '需要等级' + IntToStr(MouseItem.S.Stock) + ' ';
          end;
          62: begin
            case Who of
              1: if HiWord (g_MySelf.m_Abil.DC) >= MouseItem.S.Stock then useable := TRUE;
              2: if HiWord (g_HeroSelf.m_Abil.DC) >= MouseItem.S.Stock then useable := TRUE;
            end;
            line3 := line3 + '需要攻击' + IntToStr(MouseItem.S.Stock) + ' ';
          end;
          63: begin
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.Stock then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.Stock then useable := TRUE;
            end;
            line3 := line3 + '需要魔法力' + IntToStr(MouseItem.S.Stock) + ' ';
          end;
          64: begin
            case Who of
              1: if HiWord (g_MySelf.m_Abil.SC) >= MouseItem.S.Stock then useable := TRUE;
              2: if HiWord (g_HeroSelf.m_Abil.SC) >= MouseItem.S.Stock then useable := TRUE;
            end;
            line3 := line3 + '需要精神力' + IntToStr(MouseItem.S.Stock) + ' ';
          end;
          //目标爆率
          65: begin //需等级
            case Who of
              1: if g_MySelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if g_HeroSelf.m_Abil.Level >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要等级%d 目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要等级%d',[MouseItem.S.NeedLevel]);
          end;
          66: begin //需攻击力
            case Who of
              1: if HiWord(g_MySelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.DC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要攻击%d 目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要攻击%d',[MouseItem.S.NeedLevel]);
          end;
          67: begin //需魔法
            case Who of
              1: if HiWord(g_MySelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.MC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要魔法力%d 目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要魔法力%d',[MouseItem.S.NeedLevel]);
          end;
          68: begin //需道术
            case Who of
              1: if HiWord(g_MySelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
              2: if HiWord(g_HeroSelf.m_Abil.SC) >= MouseItem.S.NeedLevel then useable := TRUE;
            end;
            if MouseItem.S.Stock > 0 then begin
              if MouseItem.S.NeedLevel > 0 then begin
                str := '需要精神力%d 目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.NeedLevel,MouseItem.S.Stock]);
              end else begin
                str := '目标爆率+%d';
                line3 := line3 + Format(str,[MouseItem.S.Stock]);
              end;
            end else line3 := line3 + Format('需要精神力%d',[MouseItem.S.NeedLevel]);
          end;
        end;
        if (MouseItem.S.Shape = 188) or (MouseItem.S.Shape = 203) then begin
          if MouseItem.S.Source > 0 then line3 := line3 + ' 伤害吸收' + IntToStr(MouseItem.S.Source) + '%';
        end;
        {$IF M2Version <> 2}
        if g_boOpenLeiMei then begin
          case MouseItem.btAppraisalLevel of  //是否可鉴定(无星  1－可鉴定 2－一鉴 3-二鉴  4-三鉴 1星: 11-可鉴定 12-一鉴 13-二鉴 14-三鉴..)
             1,11,21,31,41,51: begin //可鉴定
              line5 := '<可鉴定/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                11: line5 := line5 + '\*1';
                21: line5 := line5 + '\*2';
                31: line5 := line5 + '\*3';
                41: line5 := line5 + '\*4';
                51: line5 := line5 + '\*5';
              end;
            end;
            2,12,22,32,42,52: begin//一鉴
              line5 := '<一鉴 (仍可鉴定)/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                12: line5 := line5 + '\*1';
                22: line5 := line5 + '\*2';
                32: line5 := line5 + '\*3';
                42: line5 := line5 + '\*4';
                52: line5 := line5 + '\*5';
              end;
            end;
            3,13,23,33,43,53: begin;//二鉴
              line5 := '<二鉴 (仍可鉴定)/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                13: line5 := line5 + '\*1';
                23: line5 := line5 + '\*2';
                33: line5 := line5 + '\*3';
                43: line5 := line5 + '\*4';
                53: line5 := line5 + '\*5';
              end;
            end;
            4,14,24,34,44,54: begin //三鉴
              line5 := '<三鉴/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                14: line5 := line5 + '\*1';
                24: line5 := line5 + '\*2';
                34: line5 := line5 + '\*3';
                44: line5 := line5 + '\*4';
                54: line5 := line5 + '\*5';
              end;
            end;
          end;
          sUnKnow1 := GetAppendItemValue(MouseItem);
          sUnKnow2 := GetSecretItemValue(MouseItem);
        end;

       (* if MouseItem.btUnKnowValue[6] > 0 then begin
          if MouseItem.btUnKnowValue[6] in [231..250] then begin
            if MouseItem.Aura > 0 then begin
              line7 := line7 + Format('<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Round(11.4 * (MouseItem.btUnKnowValue[6]-230){值}) , MouseItem.Aura, MouseItem.MaxAura]);
            end else begin
              line7 := line7 + Format('<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Round(11.4 * (MouseItem.btUnKnowValue[6]-230){值}) , 0, MouseItem.MaxAura]);
            end;
          end;
        end;
        if MouseItem.btUnKnowValue[7] > 0 then begin
          if MouseItem.btUnKnowValue[7] in [231..250] then begin
            if MouseItem.Aura > 0 then begin
              line7 := line7 + Format('<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Round(11.4 * (MouseItem.btUnKnowValue[7]-230){值}) , MouseItem.Aura, MouseItem.MaxAura]);
            end else begin
              line7 := line7 + Format('<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Round(11.4 * (MouseItem.btUnKnowValue[7]-230){值}) , 0, MouseItem.MaxAura]);
            end;
          end;
        end;
        if MouseItem.btUnKnowValue[8] > 0 then begin
          if MouseItem.btUnKnowValue[8] in [231..250] then begin
            if MouseItem.Aura > 0 then begin
              line7 := line7 + Format('<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Round(11.4 * (MouseItem.btUnKnowValue[8]-230){值}) , MouseItem.Aura, MouseItem.MaxAura]);
            end else begin
              line7 := line7 + Format('<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Round(11.4 * (MouseItem.btUnKnowValue[8]-230){值}) , 0, MouseItem.MaxAura]);
            end;
          end;
        end;
        if MouseItem.btUnKnowValue[9] > 0 then begin
          if MouseItem.btUnKnowValue[9] in [231..250] then begin
            if MouseItem.Aura > 0 then begin
              line7 := line7 + Format('<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [Round(11.4 * (MouseItem.btUnKnowValue[9]-230){值}) , MouseItem.Aura, MouseItem.MaxAura]);
            end else begin
              line7 := line7 + Format('<宝物灵媒 品质%d/c=Yellow> <灵气值%d/%d/c=Red>', [Round(11.4 * (MouseItem.btUnKnowValue[9]-230){值}) , 0, MouseItem.MaxAura]);
            end;
          end;
        end;  *)
        {$IFEND}
      end;

      25: begin//护身符及毒药
        case MouseItem.S.Shape of
          9: begin  //火龙之心
            line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight);
            line2 := '容量 '+ IntToStr(MouseItem.Dura) +'/'+ IntToStr(MouseItem.DuraMax);
          end;
          10..11: begin
            line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight);
            line2 := '持久 '+ GetDura100Str(MouseItem.Dura, MouseItem.DuraMax);
          end;
        else begin
          line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight);
          line2 := '数量 '+ GetDura100Str(MouseItem.Dura, MouseItem.DuraMax);
        end;
        end;
      end;
      40: begin //肉
        line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight) + ' 品质'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax);
      end;
      41: begin//特殊证书
        line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight);
        str := GetItemDesc(MouseItem.S.Name);
        if str <> '' then begin
          str := GetValidStr3 (str, line2, ['\']);
          str := GetValidStr3 (str, line3, ['\']);
        end;
      end;
      42: begin//药材
        line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight) + ' 药材';
        str := GetItemDesc(MouseItem.S.Name);
        if str <> '' then begin
          str := GetValidStr3 (str, line2, ['\']);
          str := GetValidStr3 (str, line3, ['\']);
        end;
      end;
      43: begin//矿石
        line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight) + ' 纯度'+ IntToStr(Round(MouseItem.Dura/1000));
      end;
      {$IF M2Version <> 2}
      44: begin //特种物品
        case MouseItem.S.Shape of
          253: begin //灵媒
            line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight);
            str := GetItemDesc(MouseItem.S.Name);
            if str <> '' then begin
              str := GetValidStr3 (str, line2, ['\']);
              str := GetValidStr3 (str, line3, ['\']);
            end;
            if MouseItem.Aura > 0 then begin
              line5 := Format('\ \<一鉴/c=Yellow>\ \<附加基础属性/c=Yellow>\ \<宝物灵媒 品质%d 灵气值%d/%d/c=Yellow>', [MouseItem.S.Reserved{值} , MouseItem.Aura, MouseItem.MaxAura]);
            end else line5 := Format('\ \<一鉴/c=Yellow>\ \<附加基础属性/c=Yellow>\ \<宝物灵媒 品质%d/c=Yellow>< 灵气值%d/%d/c=Red>', [MouseItem.S.Reserved{值} ,0,MouseItem.MaxAura]);
          end;
          255: begin //神秘卷轴
            line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight);
            line2 := line2 +  '等级'+ IntToStr(MouseItem.S.NeedIdentify) + '\' + '熟练度'+IntToStr(MouseItem.DuraMax);
          end;
          else begin
            str := GetItemDesc(MouseItem.S.Name);
            if str <> '' then begin
              str := GetValidStr3 (str, line2, ['\']);
              str := GetValidStr3 (str, line3, ['\']);
            end;
            line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight);
          end;
        end;
      end;
      {$IFEND}
      48,49: begin
        case MouseItem.S.StdMode of
          48: begin
            line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);
          end;
          49: begin
            line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight);
            line2 := ' ';
            line3 := '开启宝箱钥匙，移动到宝箱内即可';
          end;
        end;
      end;
      17: begin //叠加物品
        if MouseItem.S.Shape = 237 then begin
          if MouseItem.S.AC > 0 then line1 := '+' + IntToStr(MouseItem.S.AC) + 'HP ';
          if MouseItem.S.MAC > 0 then line1 := line1 + '+' + IntToStr(MouseItem.S.MAC) + 'MP ';
        end;
        str := GetItemDesc(MouseItem.S.Name);
        if str <> '' then begin
          str := GetValidStr3 (str, line2, ['\']);
          str := GetValidStr3 (str, line3, ['\']);
        end;
        if MouseItem.S.Source = 0 then begin
          line1 := line1 + '数量'+ IntToStr(MouseItem.Dura) + ' ' +sWgt + IntToStr(MouseItem.S.Weight);
        end else line1 := line1 + '数量'+ IntToStr(MouseItem.Dura);
      end;
      18: begin //单独物品 读游戏目录的物品注释文件
        str := GetItemDesc(MouseItem.S.Name);
        if str <> '' then begin
          str := GetValidStr3 (str, line2, ['\']);
          str := GetValidStr3 (str, line3, ['\']);
        end;
        line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight);
      end;

      55: begin
      {$IF M2Version <> 2}
        if g_boOpenLeiMei then begin
          case MouseItem.btAppraisalLevel of  //是否可鉴定(无星  1－可鉴定 2－一鉴 3-二鉴  4-三鉴 1星: 11-可鉴定 12-一鉴 13-二鉴 14-三鉴..)
             1,11,21,31,41,51: begin //可鉴定
              line5 := '<可鉴定/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                11: line5 := line5 + '\*1';
                21: line5 := line5 + '\*2';
                31: line5 := line5 + '\*3';
                41: line5 := line5 + '\*4';
                51: line5 := line5 + '\*5';
              end;
            end;
            2,12,22,32,42,52: begin//一鉴
              line5 := '<一鉴 (仍可鉴定)/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                12: line5 := line5 + '\*1';
                22: line5 := line5 + '\*2';
                32: line5 := line5 + '\*3';
                42: line5 := line5 + '\*4';
                52: line5 := line5 + '\*5';
              end;
            end;
            3,13,23,33,43,53: begin;//二鉴
              line5 := '<二鉴 (仍可鉴定)/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                13: line5 := line5 + '\*1';
                23: line5 := line5 + '\*2';
                33: line5 := line5 + '\*3';
                43: line5 := line5 + '\*4';
                53: line5 := line5 + '\*5';
              end;
            end;
            4,14,24,34,44,54: begin //三鉴
              line5 := '<三鉴/c=Yellow>';
              case MouseItem.btAppraisalLevel of
                14: line5 := line5 + '\*1';
                24: line5 := line5 + '\*2';
                34: line5 := line5 + '\*3';
                44: line5 := line5 + '\*4';
                54: line5 := line5 + '\*5';
              end;
            end;
          end;
          sUnKnow1 := GetAppendItemValue(MouseItem);
          sUnKnow2 := GetSecretItemValue(MouseItem);
        end;
        {$IFEND}
        line1 := line1 + sWgt + IntToStr(MouseItem.S.Weight) + ' 持久'+ GetDuraStr(MouseItem.Dura, MouseItem.DuraMax)+' ';
        //if MouseItem.S.AC > 0 then line2 := '防御' + IntToStr(LoWord(MouseItem.S.AC)) + '-' + IntToStr(HiWord(MouseItem.S.AC)) + ' ';
        //if MouseItem.S.MAC > 0 then line2 := line2 + '魔御' + IntToStr(LoWord(MouseItem.S.MAC)) + '-' + IntToStr(HiWord(MouseItem.S.MAC)) + ' ';
        if MouseItem.S.DC > 0 then line2 := line2 + '\攻击' + IntToStr(LoWord(MouseItem.S.DC)) + '-' + IntToStr(HiWord(MouseItem.S.DC))+' ';
        //if MouseItem.btValue[2]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[2])+')/c=lime> ';
        if MouseItem.S.MC > 0 then line2 := line2 + '\魔法' + IntToStr(LoWord(MouseItem.S.MC)) + '-' + IntToStr(HiWord(MouseItem.S.MC))+' ';
        //if MouseItem.btValue[3]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[3])+')/c=lime> ';
        if MouseItem.S.SC > 0 then line2 := line2 + '\道术' + IntToStr(LoWord(MouseItem.S.SC)) + '-' + IntToStr(HiWord(MouseItem.S.SC))+' ';
        //if MouseItem.btValue[4]>0 then Line2:=Line2+'<(+'+IntToStr(MouseItem.btValue[4])+')/c=lime> ';
        If MouseItem.s.Stock>0 Then line2 := line2 + '\麻痹强化 +'+IntToStr(MouseItem.s.Stock)+' ';
        If MouseItem.s.NeedLevel>0 Then
          Line3 :=line3 + '需要等级'+IntToStr(MouseItem.s.NeedLevel)+' ';
      end;

    else  begin
        str := GetItemDesc(MouseItem.S.Name);
        if str <> '' then begin
          str := GetValidStr3 (str, line2, ['\']);
          str := GetValidStr3 (str, line3, ['\']);
        end;
      line1 := line1 + sWgt +  IntToStr(MouseItem.S.Weight);
    end;
    end;
    if MouseItem.s.StdMode in [5,6] then begin
      If MouseItem.s.nHP>0 then
        if MouseItem.s.nHP > 0 Then line2 := line2 + '\麻痹强化 +'+IntToStr(MouseItem.s.nHP);
      //If MouseItem.s.nMP>0 Then
        //if MouseItem.s.nMP > 0 Then line2 := line2 + '\冰冻抗性 +'+IntToStr(MouseItem.s.nMP);
    end else begin
      If MouseItem.s.nHP>0 then
        Line5:='体力值 +'+IntToStr(MouseItem.s.nHP)+'\' + Line5;
      If MouseItem.s.nMP>0 Then
        Line5:='魔法值 +'+IntToStr(MouseItem.s.nMP)+'\' + Line5;
    end;
    case MouseItem.BindValue of
      1..3: begin
        if MouseItem.BindValue = 1 then begin
          line3 := line3 +'\'+'截止时间：'+ FormatDateTime('yyyy年mm月dd日', MouseItem.MaxDate){FormatDateTime('dddddd',MouseItem.MaxDate)};{DateToStr(MouseItem.MaxDate)};
        end;
        iname1 := '(绑定)';
      end;
    end;
  end;

