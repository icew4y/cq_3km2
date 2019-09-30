unit Share;

interface
uses Classes, Windows, SysUtils, Graphics, Gost,Messages, DateUtils, ZLib, FileUnit;
resourcestring
  sSkinHeaderDesc = '3k登陆器皮肤文件';
type
  //自身信息记录   (登陆器+图片文件+套装文件+经络文件+内挂文件+结构)
  TRecinfo = record
    GameListURL: string[255];
    BakGameListURL: string[255];
    PatchListURL: string[255];
    GameMonListURL: string[255];
    GameESystemUrl: string[255];
    //boGameMon :Boolean;
    boAutoUpData    :Boolean;//使用百度更新
    lnkName: string[20];
    ClientFileName: string[20];
    //GameSdoFilter: array[0..50000] of char;
    //TzHintFile: array[0..5000] of Char;
    //PulsDesc: array[0..10000] of Char;
    GatePass: string[34];
    SourceFileSize: Int64;//登陆器原文件大小
    MainImagesFileSize: Int64;//图片文件大小
    TzHintListFileSize: Int64;//套装文件大小
    PulsDescFileSize: Int64;//经络文件大小
    GameSdoFilterFileSize: Int64;//内挂文件大小
    FDDllFileSize: Int64;//风盾文件大小
  end;

  //自身信息记录
  TRecGateinfo = record
    GatePass: string[34];
  end;

  T3KControlVisible = record
    TreeView: Boolean;
    ComboBox1: Boolean;
    //Btn
    MinimizeBtn: Boolean;
    CloseBtn: Boolean;
    StartButton: Boolean;
    ButtonHomePage: Boolean;
    RzBmpButton1: Boolean;
    RzBmpButton2: Boolean;
    ButtonNewAccount: Boolean;
    ButtonChgPassword: Boolean;
    ButtonGetBackPassword: Boolean;
    ImageButtonClose: Boolean;
    //BtnEnd
    RzCheckBox1: Boolean;
    RzCheckBoxFullScreen: Boolean;
    RzLabelStatus: Boolean;
    RzComboBox1: Boolean;
    WebBrowser1: Boolean;
    RzProgressBar1: Boolean;
    RzProgressBar2: Boolean;
    ProgressBarCurDownload: Boolean;
    ProgressBarAll: Boolean;
  end;

  TSkinFileHeader = packed record
    sDesc: string[$10]; //16
    boServerList: Boolean; //是否为TreeView
    boProgressBarDown: Boolean;
    boProgressBarAll: Boolean;
    boFrmTransparent: Boolean; //窗体是否透明
    ControlVisible: T3KControlVisible; //控件是否可见
    dCreateDate: TDateTime;
  end;
  pTSkinFileHeader = ^TSkinFileHeader;
const
  tMakeServer=1;
  MakeClass: string = 'MakeServer';
  RecInfoSize = Sizeof(TRecinfo);  //返回被TRecinfo所占用的字节数
  RecGateInfoSize = SizeOf(TRecGateinfo);
(*//1.76M2的哈希值
s176CodeString = 'NSI>HreMPp\mWPuDOaMmH?`uLQAiWPqpXAA=X?]bPO=RHoEHVrmSUBuUIbtpJBmgY`hrHrqmHcDtY`MFL_`mIqHrYp\uIPymLcPqX_QMIo@oI``tYPmCN?'+
               '=hXpYkH_YRIQ<lN@dtPPyJI_AHH`EoM_<sH?TuYo\qVBaNI_`rWb]HMRhpJRq`R@AEWo`lYAYqJS<rJRDfURI_XpY=RaACLQADLPA>LPIBLPI?PPUVQoXrMAA=I`]'+
               'MIQIFOq]BNOQRMQLsLOQ?Op]INQUEL`EERQ<sN_UKP`YPO`ULI_YTM_EUO?EVQAY>RPI>QoTpHa@fURI_X@Y>M`ACLQADPPA>LPIBLPI?PPUVQoXrMAA=I`]'+
               'MIQIFOq]BNOQRMQLsLOQ?Op]INQUEL`EERQ<sN_UKP`YPO`ULI_YTM_EUO?EVQAY>RPI>QoTpHaA=PQU=Lp]'+
               'GLQYMNpUTMqQQNpxsNaY?Q_QFQ@m?PPaTNAUVPptpFbQ_TrQbUbU^UbUbT_<nH?@lH?<nJ?'+
               '@tHO<lIrTnUOA^IOToJOQbHrA`IOa_JOHtH?LqIbDtURHlTo]`HBA^URDoTRPtU?'+
               'MbI_TpToY_JOHrJB@nURQ^UOM^URHlIoTuUOA^TrHtIo<nHrLuJ?Y]U_LuUOI]H?A`IrE`HOPuIbHlHrTlURHqJO=]'+
               'UbPtI_HuT_EaH_PtJBPsIRTmTOXnIOLnTrU`HBDsIbI^U?'+
               'XnUBIaUR@oUOLrTrPoIbM^Ub@tTrToJRDsHbLlTo`qHrTuTOXuI_I`UbQ`IRTqJRHlJO<lUOaaTO\mHOa]U?'+
               'I`ToU`I_@pHBTnIoa^UO`qHo@oH_\sU?\mIr@qI?TlUB@uUOI^HbEbHrDtTb@mJO<nH?HlHO<lH?@lH_\mJ?<lURM^HBI]'+
               'HrPuIrToHoXlUOM_HO\mH?IbTRPlJOa]JRI^I_<nU?`mTbE_IOHrJ?I_Ib@sIrLlJBAaJRAaTrPqHO<oIrE]U?'+
               'Y^UBTlHBPpIRDnH_LoJB@oHbE`TrQbTbLuU?LnHoUbH_@rT_<rHbA]IrLtU_XrUbQ^HBDmHo`rU_TmIo=bIOLpUBPuU?LmTo]'+
               '`H_@nHO]^H?HmIBEbJ?`mI_@oHRHsU?`nIb@mURDsIO<pIbE^URTuU_UaUO\pUbIbH_<uJB@tUbLoJ?`lU?\pH_a^IoY_J?'+
               'Y_IO\uJ?@nIoEbH_I]I?a^Ho<tIOTuToIaIrA`HrTtT_a]HRA]U?TqH?DpHBQ`U_TrUBQ^To=`IrMbU?'+
               'U_UO@sIBMaI_`mHbTnUODqTRToIoPsTREaHRTmI?]^TbLrI?QaTbUaIOM`IoQ`TrE_U_E^JO]_ToHpT_QbI_I`J?'+
               '@rHOPsTr@mU_\sUOQ^TRPsU?DrHR@pTOHsI_`mIbI]IbDnH_<lI?<sU_TlUO]`H?DpH?\tU?AbTo]_JO=]U?'+
               '\uHr@mTrPuT_HsHOHrJ?PsJRDsHOHrI?TlI?XtI?E]I?@rT_HtUBTmJRLuHoPnI?DuIO@uI_<mIOI`Ib@qH?<sHoIaTRDtIoQaJ?'+
               'XnHO\tTR@mHrPoU_<sToA_TOI_I_<uIOAbHBAbHBTrUOXqTbQaTrE`H?'+
               'DpHBDuTOU^TRLsI_PqTO\rIrPmIRHsToM^IO=bTRHmJOY]T_`mTOa]I?A^IOLoH?'+
               'HuIRLtIoLoHBI^U_abHO@pIoDsUbA_UOa_IbLsJO=aIo=`U?@oIBM]ToHlToa]IrU^IbDpIB@pI?XsTO\oJ?LrU_]`Io]'+
               '_TbI_HR@tIRHrIRDuH?DpH?=^IoTmTbHoUOE^HbHrU?TmJOTuU_DrH?IbJ?EbTRPuHrLoIB@mI_LmToM_HoQaHbDsJ?'+
               'UaJBTmIbDnI?HrIOaaHOLuH?XnURPuURTuJRDsUBHpHb@lToTtU?DrJOY]JBHrUOPsI?TlH_a`H?'+
               '<oH_I`To@sTRPnHOLlT_Y`IrDuH?DpHO<lIO<qH?=_UBM]J?@sU_\tTRI]T_a]IOIbHo\nHO]'+
               '`JBHtHB@pToLoHRTqTb@uIoXuTOTrUOUbI_HqI_<mT_TrHoXoTrQaHoA_ToU_IO]aIB@lI?]'+
               '_HOPqHRHsHR@pIBPuToQ_IbPqHbQ_URDuU_XpI_a]UBLmJOA]I?HpTbLnH_EbUbUaUbUbUO<nH?@lH?<nJ?DlHO<mH?<qTOXoH?'+
               '<oTo<tTbLqU?@lU?\uI?HlU_PqJOPuIbHuI?HuTrEbUbIbHr@rIoXmIOPnIrLqHRU_ToYbJBPsUbE]IrU^H?\sTO`pJ?'+
               '\oHRHtTOY^I?XmHbU]TOYbU?<mJO<rTbE^ToYbTbDmHrLtUR@sI?PtU?XrTOE`HoLqUbE^UOXnTRHlUOa]Tb@mHrHuHrI_U_LpH?'+
               'UbH_@uUBTsJRLtJOE`JODrIRA_IoMaU_\sHrLmTRU`HOLrIOHrT_DnU_@oI_\pJOLmHBI^HO]aH_Y`TrU_UOPpTrDrU?'+
               'a`HO`sTOMaTOI_HrLmU_PmH?TtI?UbH_<uTrMbU_UbUBLsToA]HoDlJOPtIB@oIbMaUO\nTbHmHo\oH_XtHbTuTR@rJ?'+
               'LuIOI^Io`nT_`uIO<rI?TnU?TtIODtI?DmJ?YbIB@sI_TnIbQaJ?DrUbPpIBDmJOXtUBE_URPqU?`oHRIaUO@tI?'+
               'AaTODrJB@uU_YaTRPqHBLlH_HpU?PsHo`mJBDpTbTnTb@tUBIaU_LrIBUbIRTnHBQ]IRLqHbPtHo\pUBQ`IbE]UBPtHo`tTOXoH?'+
               'XtUBUaTR@oJ?LqU?]^U_@lH_I]I?HtHBPmIOa`UBI^H_=^TRPqHo@sUbIaIoUbHRPrHRTmIrA`T_Q`JBPuIOE`IRM]IRTqU?'+
               'PnI_AaH?IaTrHsIO<nH?HlHO<lH?@lH_\nH?@lH?<qH_@oHo]aH?`rJ?EbU_<tI_DqIBA_H_HnHOaaHrE_T_`lH?U_IOU_U_]'+
               '_IO@qHbU]JB@nU?aaIOU]H_MaTr@tH?DmHOHrHoI`JOPlUO<nIrPuI_Q^U?LqU?'+
               '@qTOHsH_`nHoUaUR@tIbQ_TrE^ToTuJRLnI_LoToI_TrPoIoA^TO\sT_`qURLmURMaHbPmH_@lIO@oHrM_IBQ`IrA^U_AaIOM^J?'+
               'DsTOHlJ?TtTbMbH?a^HOHrIrDlUO@nIbEaUO@mHoTpUO<nToTsJRTsUbLmJR@tHbLoIOLsTRI^H?@mI_HoH_=]'+
               'H_XtTrDlTRHqTbU^H?Q_Ub@uUO@nJOXmT_XnIRI^HRU^T_a^H_I^IRLsTOTsIRLpH?PrTbPqUbU`JRQ]I?I_HbTlU_\rJRDrIOY]'+
               'U_<lJRTqT_A_H_DoI_PrTo@mIo@rUb@nH?`rToHrUBDoUBQ^IOHrJBHlH?=`T_IaIRE]U?M]I?<mI?A]'+
               'Hr@uHo=`H_a`I_UaT_Q`JOTsJBA_HOLsTo<tTOPqH?]_I_\uUBDqJOPsTrMbU_<qHO<sJOA`JOa`U_a^UB@rIBPlURPqTrE`J?A]'+
               'JRQ`UbTuUO`lToHuHR@nHBE_UO@tT_TtUOHsU?=bUbUbIRHpU_DuIRMbT_=_TOY_UbTtJRPuHrHrH_\uTOI^Ub@nJRM_TR@mH?'+
               'DtHO\lJ?@sHOHoU?Q^I?`rH_Y`U_XqTRHpIB@nHrQ^Ho`lH_DlIBTqHO]^TRTqTRHtTRTuU?\oH_TqTr@qUB@nI_a]UOHmU?'+
               '\qIbI]IbPuUBE]UOU`JBU^UOLrTRIbU_Y`TOUbU?TmU?TmJ?DoIOLnJOPlTo`tHo=]T_@tU_DrU?IbURDtHrPmU_MaUOYaH?'+
               'PuU_XsU_\rURLqH?=_URLrUb@lTOLqH_A_HRU_To`nT_DsI_XrHOY^J?LsIO\nIOLuIRLlHo\sJ?IaUOE^HbLlURDmToQ]'+
               'HrDnTRQaHOY_I_PnTOLrI_LnI_TpUOa_TO<tI?EbH_U^TOI]IrPsH_QaT_=^HO<nJ?@tHBDnUODlJ?'+
               'U^HOMaTo<tT_\mI_\lJO=`JBU`HOHtHRDoHBTqJR@nUOI]HoHlU_PpUbPlHrIaIbE_UBQ`JRPtH_LsU?'+
               '<mIODmT_U_IBA^UbHuIrPlIbPnIrIaHrE]I?\pIOQ^UbLmJ?PlTO`pUBDuTOAbHbE`TRUaToa]U_ToJ?'+
               '\sU_DnHO=aJO<tI_XpI_MaH_HnHb@nIoI^UOToIRTqTrE^URDtTRDuHODlH_<sU_`sJRE`JRLnH_aaUODnI_U`T_LuURDnIB@lUbTs'+
               'Ho]_IoLmH?aaJ?@mHRU]IbTnIoI`UO@nU_LtU?a`H?a_JBEbToY_ToI`TbHrIoaaJODuH?PlH_\mJ?@lH?PuHBQ]'+
               'T_a`H_EaTo@pIbQ`J?DqHoYaT_XlTbHqI_HpHoA^JBTsU?M`JRPrI_TtUbLoI?@tJOU^HRE`IBU_I_M_U_<nJBDrI?'+
               'DsJBAbJRPrJBMaU_XlJBPqI?a^T_<sToHqJODrU?QaHB@tTRIaToQ]IO\tH?TtUbLuIbDsIO<tU_EaJRPuIrHuIBLpH?'+
               'PtUB@oHbLtUBU^IB@qHrU]H_<pTRHpHO`mIOXpTrAaUO<sI_=^J?Y_TbUaI?XqJOA_IOY]T_M^H?YbJ?LtTbM_U?'+
               'U`TRTqTrPrJO`qJBMaT_a]HOLtJODrJRPsT_\lTRI^HOM_HoAaHBHlU?E]T_XsI_@lH_\mJ?<oHrTlJ?'+
               'XtT_HtHBQbIBLqH_U_T_Y^ToHqIOXlIOPtIoY`IRHtI?Y_IRPpIBTsUOPuH_XmIrHsJRDtTOXpHbI`IRLsH_\qT_a]'+
               'TRAaUOPuHo<rToA_URUbIrPpTbTsIoDmI?E_JRUaHrHoU?MaTR@nJ?\pUBPqJ?YaJBLnT_XpIOPuUBDuJOPpH?HtI_LrI?'+
               '\uT_PnHrHlI?A^IbAaU?]_JOLoT_DlTRM_JRI^I?QaHBQ]J?E_T_`lHRDoHRPsU_Q]H_HsUO@sHRLmUB@rI_A_To`oTO]'+
               '_T_PtHB@rToXuJODoHB@pTrDsU?aaIrA]J?a_ToQ_HrPoHo@uU_=_I_PqH?DtHO\mH?<sI?I]IoTuJR@mTOYaHOa^J?PtT_HlJ?'+
               'QaJB@pUBDtIBI^HBHtJR@uHoQ`H_U^IO]aH_@oH_DnTOHrHoHtJBA^HOUaUO`tIRTsHo=^U?ToIoTtH_LtJB@sJ?'+
               'E^I_`rJO`rIo\nHoDsIoHrJBDrIbLrIoDtHbQaH?PtIrDmH_DnHbE`TRM_H_HlHo]bTbQaUb@mU?E]'+
               'IOLlIoDoI_U^TR@qUBLqTRE^TbPlH_@oHoDtUBTlHo]aHBTsJ?a^TOToHo\oURLtToa]T_\qU?'+
               '\tHBDnTO<qUBLlURDlURHmTRI`UOTnUbDlJRTmIoTpIOUbU_PoUBAbUb@rI_LpJRTnUBTq';


//M2的希哈值
   CodeString= 'MOUQQcEtMqdrNoQtHbecZ`eGLoMdMsPqJC<oIqUqJSAUZOEtI?LqX?\lIbAGP`EVXCIdM?ToO?ToNPqhIbPqYbyOUBM?'+
               'WoPmX`dpOBdmHpuoQOQOZO]uP@EnNo@mWAQNI?UdJ?]_Y_UMWRELXq@mH_ItQpPlM_XrOSIfH?'+
               'PqRbYsI_=_ZbuNHrTnW_IjLO@pOOMOO_LfURI_XpY=H`ACLQADLPA>LPIBLPI?QPALQaU?'+
               'QPqTRQYIIqEBOpXrIq\nI_ToL_IOO@MJPQ]?IqAAM`MFQq]VNaHsOQUUIaMTRPuPO@aJP@EEQ@mDR`]'+
               'FPOYIPNeaTrIlMpEBPPY=PP]MLPE=LpU=LpIQLQ=RQ`IQOQ]UQppsP`UKMoTsR?'+
               'DrI_I>HqIHM@uMR@HsPPQBM@eSRAeFPoYIQa`rQA]UOaMHNPuLL`aPO@]VN@eMIpqMLpIQLPmLNaI?Lq]DO@aKR_MLOP]'+
               'RMAYNL`qLP@iUNOUPL_QILNeaTrIaUbUbTbUbUbDlH_<mH?<lH_\mJ?=`JO`nU_HsHbQbJ?@sUbAbIBA]'+
               'H_E`HrLtIOTlUbLsU_\mI?XnTRPtTo<qHOY_JOM_JBPrURM`IBEaTRHlI_`pU?<sUOXlJ?=]I_TrHOA`TO=^J?'+
               'TtUOI^U_HsToXmI_LoURM^HBLrIoQbTbPuI_DpIBU]IrHtH_\qT_TmJ?TtHBLtJ?TlUO`lIoXpIoDnUBLrI_<oU?'+
               'XlToI_H_U`URI^UbTqU_I_JR@nU?XmU_HsTrHsIoHuIOE_TREbURTqU_M_HRPuHOI`HB@sUO<sU_TpH_@uU_`oH?DmH?U]'+
               'TO@oHbHuIRDpT_\uIr@rHO`tH?XmJOA]IO\uU?`sIoE^HoToH?DlHo<mH?<lHO<nJ?@tH?HpIoTqHOA]IbLoHbQ]'+
               'HO@qUbQ^H_LlH_Y]HOXpU?XtToA^JBPmU?`qI_]]HbTtH_\rTo=`ToDsHO]_IBI`HRTsHrTtJO=bHo=_IbHsU_HlIoUaIrUaJ?'+
               'EaJOEaJRUbURMaJ?HmUOLoToXqTbPnToHnIRA^UBI_HO@nIbE^U?E`H?@nJBTuIbDmJO\lIrHlIR@mIRQbIO]'+
               '^JRHoIoU^T_DtUB@sTOE_J?E`UOUaHBPsIrEbHOA^JRTlHo@rIbLoJBUbIrLpU?DoHOTpHbHqHO\pHBDuIbLmUODpJOToU?'+
               '`mHBTnJO\rU_PlH?HoH?TnH_]`H_HqU_Y^URQbHbA_H_PlH_LlUBDoU_Q_T_`oIo<nJOTqJ?=]TrHrI_DpIbTmIBLsHO=bJ?'+
               'XuIrU]UOU]UOI_I_<oIbPqJOLtH?Q]TbE_HOLpHRDoJBEaIOPtJBLqH?AbJBE]I?=aIoXqIr@qH?@tH_A]J?'+
               'LrTbU`TrIaHO<mUBPlI_`lToa`HOXlTrToJ?a_HBLlH_LlUbPlTbHrHbM^UOXpTo<rI?HlI?`lHbPmUBHlJRPtI?'+
               'PpJRDtHRQ^HBLpI_AaToDrIRM_H?DuUR@qToXpTrPlURPqUbLnHoPmHoa^TO@sIoU^UODuIBDlTO`tIo=^JO`lJOHmT_HtI?'+
               'XtIo=^HOHtJREbU_\tIO=_HrA^TO<mHbTlH_LlU?LqHRDrHBU^U_PlH?\mToPrTo]^UO`uToQaHBMaTRLmI_`oI?E]'+
               'TrE^UOE^ToQ`JODoU?UbUBE`UO<qJOHsH?PpU?a_HoMaIBUbT_DuT_@rIoI_J?HnH_DoHbTnIBDuIRLpIrMbIBQ_T_=bTRM`U?'+
               '`uU?PsIrDsU?@qIOHrU_`lH_LlH?E]TRE_U_a`UBTqUbE_U_@mIoE^HbHqHBHoTOMaI_QaTbLlHoHlH_LtHo\sURTnH_\nJRI_I?'+
               'U`JO`mTO<qJ?DsT_AbH?a_U_a]UOE]Io=aIBAaHb@pT_\nHbPnTrHpJ?Y_IbLmI_<rURM]IrQaTO<oI?aaJ?'+
               'a^TO\pH_E^TO@lH_LmH?<rI_HuTbA_HO\pHODlHRPsJO`qTRMaI?XrIBLrU?<mIOMbIrM`URI]U_MaIO\oHbLuJOI]'+
               'IBUbU_`oJBUaHo<uHoQaHr@nHoLrHrLoT_A`HBU_HrQ^H?HmU?HmJOEaH_<qJ?HoHR@lH_HoTOa_IoPsUO\qI_UaJOXnU?'+
               '\uUOPqIBUbUbQbUbUaH?DlHO<lH?DtH_<mH?@lH?PsHo`rJ?<nU_PoHrE^ToE^T_XlH?Y_IRDnHbLoUbDqT_]]J?PqU_I^J?'+
               '<nURQ_HrTrUOHtHo\oIRLtHR@pIoY`UO\uIoXmJODnHrAaURTsIbToUBE`IO@oI_\uTrIaHOTuIBHmHRM`HO@rT_HoHBHuHoTqTbHu'+
               'U?DoUOQ^UOA_I?HlHRU`IrE_IrHpHBLrI_LpIrDtH_PoIBA]Ho\uIBU`JOYaTo<rUBLsH_`pIrM]'+
               'HOTrT_HuH_EbU_TsUOU`UbPqHO`uIOXlT_PoHRTrI?DnURU]HrPtJOE]IbTrIRU]HOAaIoDsHR@sHBA_IOLnHoPqHoE`TRTmHo=]'+
               'JBI]J?\tIRIbToQ_TbToJOPtHoTnToHuIoDrTo@nU?XmUBPnHOUbH?'+
               'HrHrUaJBHlIRTmUb@mU_DoURPpU_LtJBDmUBUaTbEaT_U`U?DrU?\rIOQaU?U]H_LnUbE_Io`tJ?'+
               'HnHrDsUBHmIBM_JRPnTrHsUBTtIBQ`UOaaTOa]TrTsIOY`UBPlT_@rJO`uI?QbH?=aU?AbIbLrJBM`Tr@uI?@qUOLoIOU_IBDpI?'+
               'XmIoI`URPnToa^HbLoH_U`IbDpU_U`URHlTrLnIRLrTrI^I?]aTR@sI?LsHo\pHbDtUOXtTrTlU?<sT_M^HRPlHR@sJ?'+
               '`mHO\sT_`nH_a_I?`mI_DlJOTmH?DlHo<mH?<lHO<nJ?DlHO<lHO\sIRLnIBE_I_=_J?\sH_YbHOE`IoHoH_HmJBM]'+
               'IRLsHO@sTrUaIbHqIbDmJOAbHRPqTrHrHOLoH?LpHrDrIOa_H_LlTb@lTODoU_LuTOPqTrQaI?=aJO\qU_LqIRMaTbQ]'+
               'HoDpUbLpToHqT_ToUR@tHOPnIoHpH_<lU?Y_UOXoT_<uIOHqIo<oIoaaHBLnHOPuHOPsI?TqJOMbJBHnHRDrU?'+
               'abT_LsT_DpIoXnTrLqU_U`HO`oToM`To\tTRQbTRM^IODoIoa`I?UaIRAaHoM^IrPpIBI_HrLsJBDtURM_ToPtIo]`J?M]U?A]'+
               'HBLpT_a^U_LqT_I_UO`oUbTmTbEaIb@rIRTuI_I_IrToIRTrToLmIrPpURPoIo@sH?E^T_EbU?TtTbI^I?UaIoDuHRQ^HbA`H?'+
               'I`Toa`IbI]I_\lHBDrHOU]IoHuTO]_UbLqH_PlURLtI?@sU_YaJO<mTODlIRA`UOTuIRDoHoPqJ?'+
               'LmIBLtJRM_HbPoIRPpTbMbHBA_J?@nTO@tI?aaU_@qIo\rIrLrUBPoUbIbJOM]IO\tTrU]J?PsHoTpIbMbIBMaU_Y`HBLtI_Q`I?'+
               'M_JRPrUbTnHrLoIRQ`J?\oJB@pTOPmHrU]H_XtUOYbURTtT_<lI_XmTbU^I_XoTRLlU?PnU?Y^Ho\lIBTlTOEaT_I_U?HlH_\mJ?'+
               '<tH_\oJOI_I?`rHoXpURHpTRTnTRM^T_HmTo`qJ?`qH_XrTOTrToa^UOTrHoA^TODtUbLrJOTsI_I_JOIaJ?QbIbLtT_@oHOI]'+
               'IO\mTO@nHBPpJBTuHOI_HrE]IOa^ToXlHODnJRPnU_LuH?TrHOEaHO<lTo`lI?=aHb@uH_PtJO\mH?'+
               'U`UO\uT_Y`T_TpIO<sJRLrU?TqHoXmIRE]IBLlIB@nH_@nIOPtUOa_IrPuTrHpU_DrHOa`IOI]'+
               'TO@oHO<mIrPtIO<pTbU_Ho`rToY`TOUbTO]_IoDsH?XrH_M_I_=`TO=`H_LtU_Q`I_@tI?`mTO<nI_\oUOM^U?LtHO@oH?'+
               'DtHO\lTRDmI_`sH?\tHBM_T_I`IrE^HrU]JRA]HRPuIoDrIOM`IRQ`TO`oI?`tH_TsU_LsIOY^UBPrIoa_IbA]JBE_JBTpH?'+
               'IbU_Y`I_aaHrTsHb@rU_MaToQaUO@uIBA^ToToJBPrTODqU?UbU?Q^UO=]HoEaTbA^TRQ]TbHnUBDqTo\rIoA`UOM]Ho`nI?YaU?'+
               'E_H?UbTbE`UOPqJOLtHoPlTbPqU_DmH_]aI_\pJRTmH?`oHoM`HOM^Toa_H?TnH?DqIbPsH?'+
               'I_TRU^TO\mIRU^HrTuHbPlUbTmTRLrIRTnIrPuTbPtUb@qIbDqToA]Ho]_HrPpHrEbJOY`Ib@uTrPoT_<nJ?@tH?'+
               '<oH_TlHoXmJOA]H_DmURTqHbEaIo]bH?'+
               'PtHoXnU_LuUOEbTrMaTrU`UbU`U_DmHrDtUBPuIoTlTO=`HoY_JRPuJBDtURDnTbPqH_`oToTrUBE^TrAaUOXpH_@qHRE]'+
               'UBTlIOLmH_XrU?XtU_DpU?XlIB@nHO]bIBHsToHlIbLuTrDqJ?=_HOLpToXlH_`sTOQ^J?TmJ?LoJ?`lU_\uUO`qH?XlJ?'+
               'IbTRDrI_XlI_@nUO\mJOTpTrDsHrLnHrLtIOY_UBPnJBLuTbHrTRTnHo\mHRHtH_XtU?HsHoHqH_U`To]^I?'+
               'TmIrPpT_@sU_<mTo=^IO`uIO\pHoHoI_A_HbDlH_\mJ?<uTOAbI?`tHo`mJ?DpH?LtJO@mJ?HnTO@qTbLuIOAaH?]aTRTlH?'+
               '<pTRTnHrIaU_]`IrPoURHrHRE^I?LmT_`pT_Q]U?Y_IOMaH?HqIB@tU?TmTOLmIbI`UbI`URHpJ?EbHbPnIO=]H?HmT_=^JBLrJ?'+
               'Y`To@oIODnUOabH?UaJOHsIbDpJ?XnToaaUOA`JBE`HRPrTR@mI?`sTRTrH_]]HBDrIOQ_TRPlJBPtToHpJ?LpIrI]'+
               'IRDsJRA`UOHmTrDpI_\sT_`pHoa_ToA^T_@oH?YaH?DpUO=`I?@mTo]^Ir@mIrUaJOHpIrTuTb@rU?XpJR@tH?DpTR@tI?'+
               '\rHrI`H?DtHO\mH?<sH?]^IoDnI?`pHoQ`IrHuHBA`HoPsHbU]UOaaJO]`UOXpJO\qTbTrIBM`To]_JO<sH?\rJ?HnIOLqHRQ_U?'+
               'AbH?HqUbDlIRE^UOYaTrI^HRU^IOXrHOE`UOE]HrHuTRHrI?PrT_I]UOTqH_\lTo@oH_UaIo@qHbDlU?=aU_@oIBHqI?'+
               'PlUOI_T_XqIoXuHo<tHbPoURDnJBPnIrHsJOEaTOQaHrPtU_@lIO<nU_HqIoQ`HRDuUbE]URQ]'+
               'UBDqT_M_URLmHBLmIoToHBUaIoPrHOYbT_PpJ?LlJBHrHBTrI_MaUOXrH?DtI_\rHRMaI?TpIrIaHoDuUO<tH_HpHRIb';   *)

var
  g_MainMsgList: TStringList;
  g_OutMessageCS: TRTLCriticalSection;
  MakeMsgList: TStringList;
  boConnectServer: Boolean = False;
  dwReConnetServerTick: LongWord;
  User_sRemoteAddress: string;
  User_nRemotePort: Integer;
  g_sServerAddr: string = '0.0.0.0';
  g_nServerPort: Integer = 37002;
  g_nMakeLoginAddSign: Integer = 0;
  g_nMakeLoginUsesShell: Integer = 0;
  g_nMakeLoginNum: Integer;
  g_nMakeGateNum: Integer;
  g_nMakeM2RegNum: Integer;
  g_nUserOneTimeMake: Integer = 10;
  g_nNowMakeUserNum: Integer = 0; //现在有多少个用户在生成

  g_LoginSkinFile: string;
  g_0627LoginExe: string;
  g_0627GateExe: string;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//连击登陆器
  g_LoginExe: string;
  g_GateExe: string;
//预留版本1
  g_Unknown1LoginExe: string = 'D:\商业登陆器和网关\Unknown1\GameLogin.exe';
  g_Unknown1GateExe: string = 'D:\商业登陆器和网关\Unknown1\LoginGate.exe';
//预留版本2
  g_Unknown2LoginExe: string = 'D:\商业登陆器和网关\Unknown2\GameLogin.exe';
  g_Unknown2GateExe: string = 'D:\商业登陆器和网关\Unknown2\LoginGate.exe';
//预留版本3
  g_Unknown3LoginExe: string = 'D:\商业登陆器和网关\Unknown3\GameLogin.exe';
  g_Unknown3GateExe: string = 'D:\商业登陆器和网关\Unknown3\LoginGate.exe';
//预留版本4
  g_Unknown4LoginExe: string = 'D:\商业登陆器和网关\Unknown4\GameLogin.exe';
  g_Unknown4GateExe: string = 'D:\商业登陆器和网关\Unknown4\LoginGate.exe';
//预留版本5
  g_Unknown5LoginExe: string = 'D:\商业登陆器和网关\Unknown5\GameLogin.exe';
  g_Unknown5GateExe: string = 'D:\商业登陆器和网关\Unknown5\LoginGate.exe';
//预留版本6
  g_Unknown6LoginExe: string = 'D:\商业登陆器和网关\Unknown6\GameLogin.exe';
  g_Unknown6GateExe: string = 'D:\商业登陆器和网关\Unknown6\LoginGate.exe';
//预留版本7
  g_Unknown7LoginExe: string = 'D:\商业登陆器和网关\Unknown7\GameLogin.exe';
  g_Unknown7GateExe: string = 'D:\商业登陆器和网关\Unknown7\LoginGate.exe';
//预留版本8
  g_Unknown8LoginExe: string = 'D:\商业登陆器和网关\Unknown8\GameLogin.exe';
  g_Unknown8GateExe: string = 'D:\商业登陆器和网关\Unknown8\LoginGate.exe';

////////////////////////////////////////////////////////////////////////////////////////////////
//1.76登陆器
  g_176LoginExe: string;
  g_176GateExe: string;
  g_176LoginSkinFile: string;
//预留版本1
  g_176Unknown1LoginExe: string = 'D:\商业登陆器和网关\176\Unknown1\GameLogin.exe';
  g_176Unknown1GateExe: string = 'D:\商业登陆器和网关\176\Unknown1\LoginGate.exe';
//预留版本2
  g_176Unknown2LoginExe: string = 'D:\商业登陆器和网关\176\Unknown2\GameLogin.exe';
  g_176Unknown2GateExe: string = 'D:\商业登陆器和网关\176\Unknown2\LoginGate.exe';
//预留版本3
  g_176Unknown3LoginExe: string = 'D:\商业登陆器和网关\176\Unknown3\GameLogin.exe';
  g_176Unknown3GateExe: string = 'D:\商业登陆器和网关\176\Unknown3\LoginGate.exe';
//预留版本4
  g_176Unknown4LoginExe: string = 'D:\商业登陆器和网关\176\Unknown4\GameLogin.exe';
  g_176Unknown4GateExe: string = 'D:\商业登陆器和网关\176\Unknown4\LoginGate.exe';
//预留版本5
  g_176Unknown5LoginExe: string = 'D:\商业登陆器和网关\176\Unknown5\GameLogin.exe';
  g_176Unknown5GateExe: string = 'D:\商业登陆器和网关\176\Unknown5\LoginGate.exe';
//预留版本6
  g_176Unknown6LoginExe: string = 'D:\商业登陆器和网关\176\Unknown6\GameLogin.exe';
  g_176Unknown6GateExe: string = 'D:\商业登陆器和网关\176\Unknown6\LoginGate.exe';
//预留版本7
  g_176Unknown7LoginExe: string = 'D:\商业登陆器和网关\176\Unknown7\GameLogin.exe';
  g_176Unknown7GateExe: string = 'D:\商业登陆器和网关\176\Unknown7\LoginGate.exe';
//预留版本8
  g_176Unknown8LoginExe: string = 'D:\商业登陆器和网关\176\Unknown8\GameLogin.exe';
  g_176Unknown8GateExe: string = 'D:\商业登陆器和网关\176\Unknown8\LoginGate.exe';
//预留版本9
  g_176Unknown9LoginExe: string = 'D:\商业登陆器和网关\176\Unknown9\GameLogin.exe';
  g_176Unknown9GateExe: string = 'D:\商业登陆器和网关\176\Unknown9\LoginGate.exe';
//测试生成DLQ需要的数据By TasNat at: 2012-05-09 20:09:59 
  g_sTestMakeLoginData : string = '*,123,GameListURL,BakGameListUrl,PatchListUrl,GameMonListUrl,GameESystemUrl,Pass,LoginName,ClientFileName,1,0,0,0,0';
  g_Http: string;
  g_MakeDir: string;
  g_UpFileDir: string;
  g_dwGameCenterHandle:THandle;
  g_ClientServer: string ='127.0.0.1';
  g_boLockMakeGameLogin : Boolean = True; //一次只受理一个
procedure MainOutMessage(sMsg: string);
function Encrypt(const s:string; skey:string):string;
function CertKey(key: string): string;
function WriteInfo(const FilePath: string; MyRecInfo: TRecInfo): Boolean;
function WriteGateInfo(const FilePath: string; MyRecInfo: TRecGateInfo): Boolean;

//-----------------------------------------------------------------------------
//function LoginMainImagesA(aStr: string; acKey: string): string;//加密1
function LoginMainImagesB(aStr: string; acKey: string): string;//解密1

//function LoginMainImagesC(Source, Key: string): string;//加密2(gost)
function LoginMainImagesD(Source, Key: string): string;//解密2(gost)
//-----------------------------------------------------------------------------
procedure SendGameCenterMsg(wIdent:Word;sSendMsg:String);

function CheckValidPE(F: string): Byte;//检查PE文件有效性
function ProcessRandomSectionNames(F: string{; Memo:TMemo}): Boolean;//处理随机区段名
procedure EnCompressStream(CompressedStream: TMemoryStream);//流压缩

function RunApp(AppName, g_MakeDir, sData, sType : string): Integer;//内存运行EXE文件
implementation

type
  TByte32 = array[1..32] of byte;
  TSData = array[0..63] of byte;
  TBlock = array[0..7] of byte;
  
const
  SA1: TSData =
  (1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1,
    0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1);
  SA2: TSData =
  (1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0,
    0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1);
  SA3: TSData =
  (1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0,
    1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1);
  SA4: TSData =
  (0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1,
    1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1);
  SA5: TSData =
  (0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0,
    0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0);
  SA6: TSData =
  (1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1,
    1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1);
  SA7: TSData =
  (0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
    0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1);
  SA8: TSData =
  (1, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0,
    0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1);
  SB1: TSData =
  (1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0,
    1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1);
  SB2: TSData =
  (1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1,
    0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0);
  SB3: TSData =
  (0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 1, 0,
    1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1);
  SB4: TSData =
  (1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0,
    0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1);
  SB5: TSData =
  (0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0);
  SB6: TSData =
  (1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0,
    0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1);
  SB7: TSData =
  (1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1,
    0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1);
  SB8: TSData =
  (1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0,
    1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0);
  SC1: TSData =
  (1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0,
    0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0);
  SC2: TSData =
  (1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0,
    0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0);
  SC3: TSData =
  (1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 0,
    0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0);
  SC4: TSData =
  (1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0,
    1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1);
  SC5: TSData =
  (1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1,
    0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1);
  SC6: TSData =
  (0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0,
    0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0);
  SC7: TSData =
  (0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1,
    0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0);
  SC8: TSData =
  (0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1,
    1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1);
  SD1: TSData =
  (0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0,
    0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1);
  SD2: TSData =
  (1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1,
    0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1);
  SD3: TSData =
  (0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1,
    1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0);
  SD4: TSData =
  (1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1,
    0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0);
  SD5: TSData =
  (0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0,
    0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 1);
  SD6: TSData =
  (0, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0,
    1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1);
  SD7: TSData =
  (0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0,
    1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0);
  SD8: TSData =
  (1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0,
    1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1);

  Sc: array[1..16, 1..48] of byte =
  ((15, 18, 12, 25, 2, 6, 4, 1, 16, 7, 22, 11, 24, 20, 13, 5, 27, 9, 17, 8, 28, 21, 14, 3,
    42, 53, 32, 38, 48, 56, 31, 41, 52, 46, 34, 49, 45, 50, 40, 29, 35, 54, 47, 43, 51, 37, 30, 33),
    (16, 19, 13, 26, 3, 7, 5, 2, 17, 8, 23, 12, 25, 21, 14, 6, 28, 10, 18, 9, 1, 22, 15, 4,
    43, 54, 33, 39, 49, 29, 32, 42, 53, 47, 35, 50, 46, 51, 41, 30, 36, 55, 48, 44, 52, 38, 31, 34),
    (18, 21, 15, 28, 5, 9, 7, 4, 19, 10, 25, 14, 27, 23, 16, 8, 2, 12, 20, 11, 3, 24, 17, 6,
    45, 56, 35, 41, 51, 31, 34, 44, 55, 49, 37, 52, 48, 53, 43, 32, 38, 29, 50, 46, 54, 40, 33, 36),
    (20, 23, 17, 2, 7, 11, 9, 6, 21, 12, 27, 16, 1, 25, 18, 10, 4, 14, 22, 13, 5, 26, 19, 8,
    47, 30, 37, 43, 53, 33, 36, 46, 29, 51, 39, 54, 50, 55, 45, 34, 40, 31, 52, 48, 56, 42, 35, 38),
    (22, 25, 19, 4, 9, 13, 11, 8, 23, 14, 1, 18, 3, 27, 20, 12, 6, 16, 24, 15, 7, 28, 21, 10,
    49, 32, 39, 45, 55, 35, 38, 48, 31, 53, 41, 56, 52, 29, 47, 36, 42, 33, 54, 50, 30, 44, 37, 40),
    (24, 27, 21, 6, 11, 15, 13, 10, 25, 16, 3, 20, 5, 1, 22, 14, 8, 18, 26, 17, 9, 2, 23, 12,
    51, 34, 41, 47, 29, 37, 40, 50, 33, 55, 43, 30, 54, 31, 49, 38, 44, 35, 56, 52, 32, 46, 39, 42),
    (26, 1, 23, 8, 13, 17, 15, 12, 27, 18, 5, 22, 7, 3, 24, 16, 10, 20, 28, 19, 11, 4, 25, 14,
    53, 36, 43, 49, 31, 39, 42, 52, 35, 29, 45, 32, 56, 33, 51, 40, 46, 37, 30, 54, 34, 48, 41, 44),
    (28, 3, 25, 10, 15, 19, 17, 14, 1, 20, 7, 24, 9, 5, 26, 18, 12, 22, 2, 21, 13, 6, 27, 16,
    55, 38, 45, 51, 33, 41, 44, 54, 37, 31, 47, 34, 30, 35, 53, 42, 48, 39, 32, 56, 36, 50, 43, 46),
    (1, 4, 26, 11, 16, 20, 18, 15, 2, 21, 8, 25, 10, 6, 27, 19, 13, 23, 3, 22, 14, 7, 28, 17,
    56, 39, 46, 52, 34, 42, 45, 55, 38, 32, 48, 35, 31, 36, 54, 43, 49, 40, 33, 29, 37, 51, 44, 47),
    (3, 6, 28, 13, 18, 22, 20, 17, 4, 23, 10, 27, 12, 8, 1, 21, 15, 25, 5, 24, 16, 9, 2, 19,
    30, 41, 48, 54, 36, 44, 47, 29, 40, 34, 50, 37, 33, 38, 56, 45, 51, 42, 35, 31, 39, 53, 46, 49),
    (5, 8, 2, 15, 20, 24, 22, 19, 6, 25, 12, 1, 14, 10, 3, 23, 17, 27, 7, 26, 18, 11, 4, 21,
    32, 43, 50, 56, 38, 46, 49, 31, 42, 36, 52, 39, 35, 40, 30, 47, 53, 44, 37, 33, 41, 55, 48, 51),
    (7, 10, 4, 17, 22, 26, 24, 21, 8, 27, 14, 3, 16, 12, 5, 25, 19, 1, 9, 28, 20, 13, 6, 23,
    34, 45, 52, 30, 40, 48, 51, 33, 44, 38, 54, 41, 37, 42, 32, 49, 55, 46, 39, 35, 43, 29, 50, 53),
    (9, 12, 6, 19, 24, 28, 26, 23, 10, 1, 16, 5, 18, 14, 7, 27, 21, 3, 11, 2, 22, 15, 8, 25,
    36, 47, 54, 32, 42, 50, 53, 35, 46, 40, 56, 43, 39, 44, 34, 51, 29, 48, 41, 37, 45, 31, 52, 55),
    (11, 14, 8, 21, 26, 2, 28, 25, 12, 3, 18, 7, 20, 16, 9, 1, 23, 5, 13, 4, 24, 17, 10, 27,
    38, 49, 56, 34, 44, 52, 55, 37, 48, 42, 30, 45, 41, 46, 36, 53, 31, 50, 43, 39, 47, 33, 54, 29),
    (13, 16, 10, 23, 28, 4, 2, 27, 14, 5, 20, 9, 22, 18, 11, 3, 25, 7, 15, 6, 26, 19, 12, 1,
    40, 51, 30, 36, 46, 54, 29, 39, 50, 44, 32, 47, 43, 48, 38, 55, 33, 52, 45, 41, 49, 35, 56, 31),
    (14, 17, 11, 24, 1, 5, 3, 28, 15, 6, 21, 10, 23, 19, 12, 4, 26, 8, 16, 7, 27, 20, 13, 2,
    41, 52, 31, 37, 47, 55, 30, 40, 51, 45, 33, 48, 44, 49, 39, 56, 34, 53, 46, 42, 50, 36, 29, 32));

var
  G: array[1..16, 1..48] of byte;
  L, R, F: TByte32;
  c: array[1..56] of byte;


function ReverseStr(SourceStr: string): string;
var
  Counter: Integer;
begin
  Result := '';
  for Counter := 1 to Length(SourceStr) do
    Result := SourceStr[Counter] + Result;
end;

//---------------------------------------------------------------------------
procedure DES_Init(Key: TBlock; FCode: Boolean);
var
  n, h: byte;
begin
  c[1] := Ord(Key[7] and 128 > 0); c[29] := Ord(Key[7] and 2 > 0);
  c[2] := Ord(Key[6] and 128 > 0); c[30] := Ord(Key[6] and 2 > 0);
  c[3] := Ord(Key[5] and 128 > 0); c[31] := Ord(Key[5] and 2 > 0);
  c[4] := Ord(Key[4] and 128 > 0); c[32] := Ord(Key[4] and 2 > 0);
  c[5] := Ord(Key[3] and 128 > 0); c[33] := Ord(Key[3] and 2 > 0);
  c[6] := Ord(Key[2] and 128 > 0); c[34] := Ord(Key[2] and 2 > 0);
  c[7] := Ord(Key[1] and 128 > 0); c[35] := Ord(Key[1] and 2 > 0);
  c[8] := Ord(Key[0] and 128 > 0); c[36] := Ord(Key[0] and 2 > 0);

  c[9] := Ord(Key[7] and 64 > 0); c[37] := Ord(Key[7] and 4 > 0);
  c[10] := Ord(Key[6] and 64 > 0); c[38] := Ord(Key[6] and 4 > 0);
  c[11] := Ord(Key[5] and 64 > 0); c[39] := Ord(Key[5] and 4 > 0);
  c[12] := Ord(Key[4] and 64 > 0); c[40] := Ord(Key[4] and 4 > 0);
  c[13] := Ord(Key[3] and 64 > 0); c[41] := Ord(Key[3] and 4 > 0);
  c[14] := Ord(Key[2] and 64 > 0); c[42] := Ord(Key[2] and 4 > 0);
  c[15] := Ord(Key[1] and 64 > 0); c[43] := Ord(Key[1] and 4 > 0);
  c[16] := Ord(Key[0] and 64 > 0); c[44] := Ord(Key[0] and 4 > 0);

  c[17] := Ord(Key[7] and 32 > 0); c[45] := Ord(Key[7] and 8 > 0);
  c[18] := Ord(Key[6] and 32 > 0); c[46] := Ord(Key[6] and 8 > 0);
  c[19] := Ord(Key[5] and 32 > 0); c[47] := Ord(Key[5] and 8 > 0);
  c[20] := Ord(Key[4] and 32 > 0); c[48] := Ord(Key[4] and 8 > 0);
  c[21] := Ord(Key[3] and 32 > 0); c[49] := Ord(Key[3] and 8 > 0);
  c[22] := Ord(Key[2] and 32 > 0); c[50] := Ord(Key[2] and 8 > 0);
  c[23] := Ord(Key[1] and 32 > 0); c[51] := Ord(Key[1] and 8 > 0);
  c[24] := Ord(Key[0] and 32 > 0); c[52] := Ord(Key[0] and 8 > 0);

  c[25] := Ord(Key[7] and 16 > 0); c[53] := Ord(Key[3] and 16 > 0);
  c[26] := Ord(Key[6] and 16 > 0); c[54] := Ord(Key[2] and 16 > 0);
  c[27] := Ord(Key[5] and 16 > 0); c[55] := Ord(Key[1] and 16 > 0);
  c[28] := Ord(Key[4] and 16 > 0); c[56] := Ord(Key[0] and 16 > 0);

  if FCode then
  begin
    for n := 1 to 16 do
    begin
      for h := 1 to 48 do
      begin
        G[n, h] := c[Sc[n, h]];
      end;
    end;
  end
  else
  begin
    for n := 1 to 16 do
    begin
      for h := 1 to 48 do
      begin
        G[17 - n, h] := c[Sc[n, h]];
      end;
    end;
  end;
end;

procedure DES_Code(Input: TBlock; var Output: TBlock);
var
  n: byte;
  z: Word;
begin
  L[1] := Ord(Input[7] and 64 > 0); R[1] := Ord(Input[7] and 128 > 0);
  L[2] := Ord(Input[6] and 64 > 0); R[2] := Ord(Input[6] and 128 > 0);
  L[3] := Ord(Input[5] and 64 > 0); R[3] := Ord(Input[5] and 128 > 0);
  L[4] := Ord(Input[4] and 64 > 0); R[4] := Ord(Input[4] and 128 > 0);
  L[5] := Ord(Input[3] and 64 > 0); R[5] := Ord(Input[3] and 128 > 0);
  L[6] := Ord(Input[2] and 64 > 0); R[6] := Ord(Input[2] and 128 > 0);
  L[7] := Ord(Input[1] and 64 > 0); R[7] := Ord(Input[1] and 128 > 0);
  L[8] := Ord(Input[0] and 64 > 0); R[8] := Ord(Input[0] and 128 > 0);
  L[9] := Ord(Input[7] and 16 > 0); R[9] := Ord(Input[7] and 32 > 0);
  L[10] := Ord(Input[6] and 16 > 0); R[10] := Ord(Input[6] and 32 > 0);
  L[11] := Ord(Input[5] and 16 > 0); R[11] := Ord(Input[5] and 32 > 0);
  L[12] := Ord(Input[4] and 16 > 0); R[12] := Ord(Input[4] and 32 > 0);
  L[13] := Ord(Input[3] and 16 > 0); R[13] := Ord(Input[3] and 32 > 0);
  L[14] := Ord(Input[2] and 16 > 0); R[14] := Ord(Input[2] and 32 > 0);
  L[15] := Ord(Input[1] and 16 > 0); R[15] := Ord(Input[1] and 32 > 0);
  L[16] := Ord(Input[0] and 16 > 0); R[16] := Ord(Input[0] and 32 > 0);
  L[17] := Ord(Input[7] and 4 > 0); R[17] := Ord(Input[7] and 8 > 0);
  L[18] := Ord(Input[6] and 4 > 0); R[18] := Ord(Input[6] and 8 > 0);
  L[19] := Ord(Input[5] and 4 > 0); R[19] := Ord(Input[5] and 8 > 0);
  L[20] := Ord(Input[4] and 4 > 0); R[20] := Ord(Input[4] and 8 > 0);
  L[21] := Ord(Input[3] and 4 > 0); R[21] := Ord(Input[3] and 8 > 0);
  L[22] := Ord(Input[2] and 4 > 0); R[22] := Ord(Input[2] and 8 > 0);
  L[23] := Ord(Input[1] and 4 > 0); R[23] := Ord(Input[1] and 8 > 0);
  L[24] := Ord(Input[0] and 4 > 0); R[24] := Ord(Input[0] and 8 > 0);
  L[25] := Input[7] and 1; R[25] := Ord(Input[7] and 2 > 0);
  L[26] := Input[6] and 1; R[26] := Ord(Input[6] and 2 > 0);
  L[27] := Input[5] and 1; R[27] := Ord(Input[5] and 2 > 0);
  L[28] := Input[4] and 1; R[28] := Ord(Input[4] and 2 > 0);
  L[29] := Input[3] and 1; R[29] := Ord(Input[3] and 2 > 0);
  L[30] := Input[2] and 1; R[30] := Ord(Input[2] and 2 > 0);
  L[31] := Input[1] and 1; R[31] := Ord(Input[1] and 2 > 0);
  L[32] := Input[0] and 1; R[32] := Ord(Input[0] and 2 > 0);

  for n := 1 to 16 do
  begin
    z := ((R[32] xor G[n, 1]) shl 5) or ((R[5] xor G[n, 6]) shl 4)
      or ((R[1] xor G[n, 2]) shl 3) or ((R[2] xor G[n, 3]) shl 2)
      or ((R[3] xor G[n, 4]) shl 1) or (R[4] xor G[n, 5]);
    F[9] := L[9] xor SA1[z];
    F[17] := L[17] xor SB1[z];
    F[23] := L[23] xor SC1[z];
    F[31] := L[31] xor SD1[z];

    z := ((R[4] xor G[n, 7]) shl 5) or ((R[9] xor G[n, 12]) shl 4)
      or ((R[5] xor G[n, 8]) shl 3) or ((R[6] xor G[n, 9]) shl 2)
      or ((R[7] xor G[n, 10]) shl 1) or (R[8] xor G[n, 11]);
    F[13] := L[13] xor SA2[z];
    F[28] := L[28] xor SB2[z];
    F[2] := L[2] xor SC2[z];
    F[18] := L[18] xor SD2[z];

    z := ((R[8] xor G[n, 13]) shl 5) or ((R[13] xor G[n, 18]) shl 4)
      or ((R[9] xor G[n, 14]) shl 3) or ((R[10] xor G[n, 15]) shl 2)
      or ((R[11] xor G[n, 16]) shl 1) or (R[12] xor G[n, 17]);
    F[24] := L[24] xor SA3[z];
    F[16] := L[16] xor SB3[z];
    F[30] := L[30] xor SC3[z];
    F[6] := L[6] xor SD3[z];

    z := ((R[12] xor G[n, 19]) shl 5) or ((R[17] xor G[n, 24]) shl 4)
      or ((R[13] xor G[n, 20]) shl 3) or ((R[14] xor G[n, 21]) shl 2)
      or ((R[15] xor G[n, 22]) shl 1) or (R[16] xor G[n, 23]);
    F[26] := L[26] xor SA4[z];
    F[20] := L[20] xor SB4[z];
    F[10] := L[10] xor SC4[z];
    F[1] := L[1] xor SD4[z];

    z := ((R[16] xor G[n, 25]) shl 5) or ((R[21] xor G[n, 30]) shl 4)
      or ((R[17] xor G[n, 26]) shl 3) or ((R[18] xor G[n, 27]) shl 2)
      or ((R[19] xor G[n, 28]) shl 1) or (R[20] xor G[n, 29]);
    F[8] := L[8] xor SA5[z];
    F[14] := L[14] xor SB5[z];
    F[25] := L[25] xor SC5[z];
    F[3] := L[3] xor SD5[z];

    z := ((R[20] xor G[n, 31]) shl 5) or ((R[25] xor G[n, 36]) shl 4)
      or ((R[21] xor G[n, 32]) shl 3) or ((R[22] xor G[n, 33]) shl 2)
      or ((R[23] xor G[n, 34]) shl 1) or (R[24] xor G[n, 35]);
    F[4] := L[4] xor SA6[z];
    F[29] := L[29] xor SB6[z];
    F[11] := L[11] xor SC6[z];
    F[19] := L[19] xor SD6[z];

    z := ((R[24] xor G[n, 37]) shl 5) or ((R[29] xor G[n, 42]) shl 4)
      or ((R[25] xor G[n, 38]) shl 3) or ((R[26] xor G[n, 39]) shl 2)
      or ((R[27] xor G[n, 40]) shl 1) or (R[28] xor G[n, 41]);
    F[32] := L[32] xor SA7[z];
    F[12] := L[12] xor SB7[z];
    F[22] := L[22] xor SC7[z];
    F[7] := L[7] xor SD7[z];

    z := ((R[28] xor G[n, 43]) shl 5) or ((R[1] xor G[n, 48]) shl 4)
      or ((R[29] xor G[n, 44]) shl 3) or ((R[30] xor G[n, 45]) shl 2)
      or ((R[31] xor G[n, 46]) shl 1) or (R[32] xor G[n, 47]);
    F[5] := L[5] xor SA8[z];
    F[27] := L[27] xor SB8[z];
    F[15] := L[15] xor SC8[z];
    F[21] := L[21] xor SD8[z];

    L := R;
    R := F;
  end;

  Output[0] := (L[8] shl 7) or (R[8] shl 6) or (L[16] shl 5) or (R[16] shl 4)
    or (L[24] shl 3) or (R[24] shl 2) or (L[32] shl 1) or R[32];
  Output[1] := (L[7] shl 7) or (R[7] shl 6) or (L[15] shl 5) or (R[15] shl 4)
    or (L[23] shl 3) or (R[23] shl 2) or (L[31] shl 1) or R[31];
  Output[2] := (L[6] shl 7) or (R[6] shl 6) or (L[14] shl 5) or (R[14] shl 4)
    or (L[22] shl 3) or (R[22] shl 2) or (L[30] shl 1) or R[30];
  Output[3] := (L[5] shl 7) or (R[5] shl 6) or (L[13] shl 5) or (R[13] shl 4)
    or (L[21] shl 3) or (R[21] shl 2) or (L[29] shl 1) or R[29];
  Output[4] := (L[4] shl 7) or (R[4] shl 6) or (L[12] shl 5) or (R[12] shl 4)
    or (L[20] shl 3) or (R[20] shl 2) or (L[28] shl 1) or R[28];
  Output[5] := (L[3] shl 7) or (R[3] shl 6) or (L[11] shl 5) or (R[11] shl 4)
    or (L[19] shl 3) or (R[19] shl 2) or (L[27] shl 1) or R[27];
  Output[6] := (L[2] shl 7) or (R[2] shl 6) or (L[10] shl 5) or (R[10] shl 4)
    or (L[18] shl 3) or (R[18] shl 2) or (L[26] shl 1) or R[26];
  Output[7] := (L[1] shl 7) or (R[1] shl 6) or (L[9] shl 5) or (R[9] shl 4)
    or (L[17] shl 3) or (R[17] shl 2) or (L[25] shl 1) or R[25];
end;

function StrToKey(aKey: string): TBlock;
var
  Key: TBlock;
  i: Integer;
begin
  FillChar(Key, sizeof(TBlock), 0);
  for i := 1 to Length(aKey) do
  begin
    Key[i mod sizeof(TBlock)] := Key[i mod sizeof(TBlock)] + Ord(aKey[i]);
  end;

  Result := Key;
end;
//加密2
{function LoginMainImagesA(aStr: string; acKey: string): string;
var
  ReadBuf: TBlock;
  WriteBuf: TBlock;
  Key: TBlock;
  Count: Integer;
  Offset: Integer;

  i: Integer;
  S: string;
begin
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  Result := '';

  Key := StrToKey(acKey);
  DES_Init(Key, true);

  Offset := 1;
  Count := Length(aStr);
  repeat
    S := Copy(aStr, Offset, 8);
    FillChar(ReadBuf, 8, 0);
    Move(S[1], ReadBuf, Length(S));
    DES_Code(ReadBuf, WriteBuf);

    for i := 0 to 7 do
    begin
      Result := Result + IntToHex(WriteBuf[i], 2);
    end;

    Offset := Offset + 8;
  until Offset > ((Count + 7) div 8) * 8;
  asm
    db $EB,$0E,'VMProtect end',0
  end;
end;      }
//解密2
function LoginMainImagesB(aStr: string; acKey: string): string;
var
  ReadBuf,
    WriteBuf: TBlock;
  Key: TBlock;
  Offset: Integer;
  Count: Integer;
  i: Integer;
  S: string;
begin
  try
    Key := StrToKey(acKey);
    DES_Init(Key, false);

    S := '';
    i := 1;
    repeat
      S := S + Chr(STRTOINT('$' + Copy(aStr, i, 2)));
      Inc(i, 2);
    until i > Length(aStr);

    Offset := 1;
    Count := Length(S);
    while Offset < ((Count + 7) div 8 * 8) do
    begin
      FillChar(ReadBuf, 8, 0);
      Move(S[Offset], ReadBuf, 8);
      DES_Code(ReadBuf, WriteBuf);

      for i := 0 to 7 do
      begin
        Result := Result + Chr(WriteBuf[i]);
      end;

      Offset := Offset + 8;
    end;

    Result := StrPas(PChar(Result));
  except
    Result := '';
  end;
end;
//--------------------------------------------------------------------------
function LoginMainImagesD(Source, Key: string): string;//解密3(RC5)
var
  //DesDecode: TDCP_rc5;
  DesDecode: TDCP_gost;
  Str: string;
begin
  try
    Result := '';
    DesDecode := TDCP_gost.Create(nil);
    DesDecode.InitStr(Key);
    DesDecode.Reset;
    Str := DesDecode.DecryptString(Source);
    DesDecode.Reset;
    Result := Str;
    DesDecode.Free;
  except
    Result := '';
  end;
end;

{function LoginMainImagesC(Source, Key: string): string;//加密3(RC5)
var
  //DesEncode: TDCP_rc5;
  //DesEncode: TDCP_ice;
  DesEncode: TDCP_gost;
  Str: string;
begin
  asm
    db $EB,$10,'VMProtect begin',0
  end;
  try
    Result := '';
    DesEncode := TDCP_gost.Create(nil);//TDCP_rc5.Create(nil);
    DesEncode.InitStr(Key);
    DesEncode.Reset;
    Str := DesEncode.EncryptString(Source);
    DesEncode.Reset;
    Result := Str;
    DesEncode.Free;
  except
    Result := '';
  end;
  asm
    db $EB,$0E,'VMProtect end',0
  end;
end;      }


//将输入的信息写入登陆器
function WriteInfo(const FilePath: string; MyRecInfo: TRecInfo): Boolean;
var
  TargetFile: file;
begin
  try
    Result := True;
    AssignFile(TargetFile, FilePath);
    FileMode := 2;
    Reset(TargetFile, 1);
    Seek(TargetFile, FileSize(TargetFile));
    BlockWrite(TargetFile, MyRecInfo, RecInfoSize);
    CloseFile(TargetFile);
  except
    Result := False;
  end;
end;

//将输入的信息写入网关
function WriteGateInfo(const FilePath: string; MyRecInfo: TRecGateInfo): Boolean;
var
  TargetFile: file;
begin
  try
    Result := True;
    AssignFile(TargetFile, FilePath);
    FileMode := 2;
    Reset(TargetFile, 1);
    Seek(TargetFile, FileSize(TargetFile));
    BlockWrite(TargetFile, MyRecInfo, RecGateInfoSize);
    CloseFile(TargetFile);
  except
    Result := False;
  end;
end;

procedure MainOutMessage(sMsg: string);
begin
  EnterCriticalSection(g_OutMessageCS);
  try
    g_MainMsgList.Add(sMsg);
  finally
    LeaveCriticalSection(g_OutMessageCS);
  end;
end;

function myStrtoHex(s: string): string;
var tmpstr:string;
    i:integer;
begin
    tmpstr := '';
    for i:=1 to length(s) do
    begin
        tmpstr := tmpstr + inttoHex(ord(s[i]),2);
    end;
    result := tmpstr;
end;

//加密
function Encrypt(const s:string; skey:string):string;
var
    i,j: integer;
    hexS,hexskey,midS,tmpstr:string;
    a,b,c:byte;
begin
    hexS   :=myStrtoHex(s);
    hexskey:=myStrtoHex(skey);
    midS   :=hexS;
    for i:=1 to (length(hexskey) div 2)   do
    begin
        if i<>1 then midS:= tmpstr;
        tmpstr:='';
        for j:=1 to (length(midS) div 2) do
        begin
            a:=strtoint('$'+midS[2*j-1]+midS[2*j]);
            b:=strtoint('$'+hexskey[2*i-1]+hexskey[2*i]);
            c:=a xor b;
            tmpstr := tmpstr+myStrtoHex(chr(c));
        end;
    end;
    result := tmpstr;
end;

//解密密钥
function CertKey(key: string): string;
var i: Integer;
begin
  for i:=1 to length(key) do
    result := result + chr(ord(key[i]) xor length(key)*i*i)
end;

procedure SendGameCenterMsg(wIdent:Word;sSendMsg:String);
var
  SendData:TCopyDataStruct;
  nParam:Integer;
begin
  nParam:=MakeLong(Word(tMakeServer),wIdent);
  SendData.cbData:=Length (sSendMsg) + 1;
  GetMem(SendData.lpData,SendData.cbData);
  StrCopy (SendData.lpData, PChar(sSendMsg));
  SendMessage(g_dwGameCenterHandle,WM_COPYDATA,nParam,Cardinal(@SendData));
  FreeMem(SendData.lpData);
end;
//---------------------------------PE加密-----------------------------------------
//检查PE文件有效性
function CheckValidPE(F: string): Byte;
var
  FS: TFileStream;
  doshead: IMAGE_DOS_HEADER;
  pehead: IMAGE_NT_HEADERS;
begin
  if not (FileExists(F)) then begin //判断文件是否存在
    result := 0;
    exit;
  end;
  try
    try
      FS := TFileStream.Create(F, fmOpenRead);
      if FS.Size < $1000 then begin //判断文件大小，小于0x1000的判定为非有效PE
        result := 0;
        exit;
      end;

      FS.ReadBuffer(doshead, sizeof(IMAGE_DOS_HEADER));
      if doshead.e_magic <> IMAGE_DOS_SIGNATURE then begin //判断Dos头
        result := 0;
        exit;
      end;
      FS.Seek(doshead._lfanew, SoFromBeginning);
      FS.ReadBuffer(pehead, sizeof(IMAGE_NT_HEADERS));
      if pehead.Signature <> IMAGE_NT_SIGNATURE then begin //判断PE头
        result := 0;
        exit;
      end;
      if pehead.FileHeader.Characteristics and IMAGE_FILE_DLL = IMAGE_FILE_DLL then//判断是EXE还是DLL
        result := 2
      else result := 1;
    except
      result := 0;
    end
  finally
    FS.Free;
  end;
end;

//随机字符串
function GetRandomSectionName: string;
var
  I: Integer;
  B: Byte;
begin
  Result := '';
  randomize;
  for I := 1 to 8 do begin
    B := 32 + Random(Ord('z') - 32);
    Result := Result + Chr(B);
  end;
end;
//处理随机区段名
function ProcessRandomSectionNames(F: string{; Memo:TMemo}): Boolean;
var
  FS: TFileStream;
  doshead: IMAGE_DOS_HEADER;
  pehead: IMAGE_NT_HEADERS;
  sectionhead: IMAGE_SECTION_HEADER;
  i: Cardinal;
  sectionname: array[0..8] of char;
  randomname: string;
begin
  try
    try
      FS := TFileStream.Create(F, fmOpenReadWrite);
      FS.Read(doshead, sizeof(IMAGE_DOS_HEADER));//读取DOS头
      FS.Seek(doshead._lfanew, SoFromBeginning);
      FS.Read(pehead, sizeof(IMAGE_NT_HEADERS));//读取PE头
      //Memo.Lines.Add(format('发现%d个区段.', [pehead.FileHeader.NumberOfSections]));
      for i := 1 to pehead.FileHeader.NumberOfSections do begin
        FS.Read(sectionhead, sizeof(IMAGE_SECTION_HEADER));
        copymemory(@sectionname, @sectionhead.Name, 8);
        //Memo.Lines.Add(format('正在处理第%d个区段，原区段名为[%s]', [i, sectionname]));
        randomname := GetRandomSectionName; //随机区段名
        copymemory(@sectionname, @randomname[1], 8);
        copymemory(@sectionhead.Name, @randomname[1], 8);
        FS.Seek(-sizeof(IMAGE_SECTION_HEADER), soFromCurrent);
        FS.Write(sectionhead, sizeof(IMAGE_SECTION_HEADER));
        //Memo.Lines.Add(format('第%d个区段名已被处理为[%s]', [i, sectionname]));
      end;
      result := true;
    except
      result := false;
    end
  finally
    FS.Free;
  end;
end;

procedure EnCompressStream(CompressedStream: TMemoryStream);
var
  SM: TCompressionStream;
  DM: TMemoryStream;
  Count: int64; //注意，此处修改了,原来是int
begin
  if CompressedStream.Size <= 0 then exit;
  CompressedStream.Position := 0;
  Count := CompressedStream.Size; //获得流的原始尺寸
  DM := TMemoryStream.Create;
  SM := TCompressionStream.Create(clMax, DM);//其中的clMax表示压缩级别,可以更改,值是下列参数之一:clNone, clFastest, clDefault, clMax
  try
    CompressedStream.SaveToStream(SM); //SourceStream中保存着原始的流
    SM.Free; //将原始流进行压缩，DestStream中保存着压缩后的流
    CompressedStream.Clear;
    CompressedStream.WriteBuffer(Count, SizeOf(Count)); //写入原始文件的尺寸
    CompressedStream.CopyFrom(DM, 0); //写入经过压缩的流
    CompressedStream.Position := 0;
  finally
    DM.Free;
  end;
end;

//内存运行EXE文件
function RunApp(AppName, g_MakeDir, sData, sType : string): Integer;
var
  ABuffer: array of byte;
  ProcessId: Cardinal;
  Res: TResourceStream;
begin
  Result := 0;
  Res := TResourceStream.Create(HInstance,'qke', RT_RCDATA);
  try
    SetLength(ABuffer, Res.Size);
    Res.ReadBuffer(ABuffer[0], Res.Size);
    Result := MemExecute(ABuffer[0], Res.Size, PChar(AppName + ' '+g_MakeDir + ' '+sData+ ' '+sType), ProcessId);
  finally
    Res.Free;
  end;
end;

initialization
begin
  InitializeCriticalSection(g_OutMessageCS);
  g_MainMsgList := TStringList.Create;
  MakeMsgList := TStringList.Create;
end;
finalization
begin
  DeleteCriticalSection(g_OutMessageCS);
  g_MainMsgList.Free;
  MakeMsgList.Free;
end;
end.
