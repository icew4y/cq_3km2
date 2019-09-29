program Project2;

uses
  windows, Controls, EDcodeUnit, HUtil32, DateUtils, WinlicenseSDK, SysUtils;

const
(*//1.76M2的哈希值 20110716
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

   CodeString ='LQIUHaAeVralIOAAUC\qPpmMJ@TnH@qKIBE]MaAATr]NWqXtMCEPI@ptU_IeWBm^N?<pI@Q@HceJWQPnJ?UCIPTpXO]fO?]'+
               'cHQeEHq<sW?M^VcaNVpqFIcUEI`MhJ?=?ZbMKVS<rZOAaHs@tU?]qPqajI_AEWbqVVC`nZ@tpYa`nIbAdNCUtROMmO?'+
               'QAORdoLpafW?<fURI_XpY=H`ACLQADLPA>LPIBLPI?'+
               'QPALLphnI@UOHoEAMpqKIQeVOAeLLq=DM_UKIa@nQAYNP@AAM`EAPaESNQQCQa]'+
               'QMpYOQOITIQaIIAABP@DpP@qGMoM>LNeaTrIlMpEBPPY=PP]MLPE=LpU=LpIQLQ=?NoDpMaHoH`QCOPxqRaeHRa=?P@]'+
               'BI`xrPOEPQqELLPQBL`QNPaYEQPYRRAQCMqIQHq\qRPppPPULL_MLOPiCI@E=LpIQLPuIR@PqLPMQM@\rIQTnMpIIR_DrN`qCMpQSH'+
               'qaPMAMQLNeaTrIaUbUbTbUbUbDlH_<mH?<lH_\mJ?=^H_IaTrUaTrE`IBQ^HoA`TO\lUO\uH?LrH_TlJO@mJ?'+
               'PsIo<rTRAbHbDqU_XnI_YbJRM_ToHpI?HpH_MaTo\qJO@pHO=aU?`oHBHrTbU`IO<uH?TrH?<sIOPtTOHmUBU_JRPrI_]'+
               'bUBLpUOPoTrHqUR@qJOYbJ?=_HOHuIO\tIrE]T_XoHbHoIrHsIO@tU?DtTRAaTo<rIoDpU?LlIRM^J?XqJ?I_Tr@mHRA^JOUbTRM]'+
               'JODpH?DsIRDpJ?U`H_\rTo@lTo<sJ?PmIO<lHbUbI_=aI_\nIbM`HBTqHrQ]H_`pH?]`H_`lJOY^I?PuHBLsTrA]U?TmI_XrH_I]'+
               'To\qH?DlHo<mH?<lHO<nJ?@tH?<rU_`oI_DmI?]bIbEbI?HoIRHoUbE`H?PpHO]bT_@pHrI^Io\qHoMbU?HuIbA^ToUaTOTmJ?'+
               'U`JRQ]Tr@oH_LpI_aaJ?]bTOEaIODqJ?LrU_`rIoU]IoDqU_<nIRLmJODtI?]bU_U]JBQ`UBDuHOUbIODtHoHoJBLnIOTsH?'+
               '<pHbQ]IO`mIo@oUO<qIbM`HBLuUBI_IOMbIBDmIBDqHOPrTrLtTRE_IBPoJ?UaU?@oU?<pIrE^UbLuIOU`J?HsI?LqIO=]I?'+
               'XnUR@mJ?Q^IBDmH?PuU?Y^URLlTRDuUbAbH_LtIOXnJRPmHbDnUbA]U?a`TRMaH_Q^HBPpU_TlJ?@lH_LlToYaU_HpHoE]'+
               'UbDqTRLoU?PrH?@pU_<mH?HrH_E^IO<sTO\oHO@uIoQbH_DqUOLuTOLnHB@nJ?`mI?a]IRI]HbHlJ?'+
               'Y_UO@tHrTnHRA_UbTlI_PtH_XoT_`oTRLuHb@pHrHrTRE`IoHqHR@mTbTmU_TnURPlUbTuU_DrJBM`IO`lH_LlUOLoTOa^HrLrH_Ib'+
               'HrI]HBLmUBQ]I_A_HoPlHoa_H?XmH?HsTo=_URQ_IoU_TOHlUO<uU_\pIOHsHo\lHBHqJR@uIoDrIrLrH?\pIBTrHoPtHOa]'+
               'Tb@nUOa]IrLtU?Q`IRTtTbI_HOHtUR@sIbPqIbDoJBHlTbPtJ?'+
               'XsT_<sHBLlH_LlJOE`I_HsHrE`H_`tIOXsIoTtTOUaIOToHOPmU?@lHrA^IbUbIoIbIrU_I?E^U?\pU?<nJRDsT_PsU?'+
               '`lHo=aHBHsHBMbI_U^HO<qHb@sHrTqIOTqJ?'+
               '=_TRM_JOUaJRIbUbLmU_PsTRHpUO@oTo=_UOLtIOTmIoA`T_U_U_@qI_@lH_LlUOI]UBEbJRPrUBU^JBM`U?'+
               '@qI_=`T_EbIr@tIoaaI?]_HOa]HBLlHr@lJBHnIBI]TbE`T_<rTOLpIRA`U_@nI?DqIO@qIoQ^H?E]IbPmI?I]'+
               'HO\rJRI_HrIbH_MbU_HtTRPlU_\qI?YaHOTmHO<pIbTtHO]bIbQ_I?'+
               'EbHrA`TOPlH_LlH_HnIRHtHRHlIBQ`TOM`JRDsUBU^IrDuTODrTbQ^JBPmIOPnUO`oTOAaH?PuT_U]HO\lIOa^J?'+
               'U_UBTsJBAaUbDsIRPnHBHoHOU]IoLmTbPlI_PlIBEaH_DsUOTtH?HpTRLoH?'+
               'DpURHsTRLuTOE`HbLnTrLpI_\tIBM^UOLuIO=bUbUaUbUbUO<nH?@lH?<nJ?DlHO<mH?<rJOLsJBHpIODlI?@oU?I]U_=`T_<tHO]'+
               '_T_PuJ?I^JO\sJRTsH?@uI_<nUREbHoDrTO<pToI^TO<sI_\pJ?\lH?XsHo@nI?@rHbE]IbDpJRLtTOabHoDsJ?'+
               'LmJR@sT_=_T_a_HbTpIbUbUO\qTr@mHOTtJB@nI?PpHoPrHbDqToXuHrTlTbLoIBQ`UOE]'+
               'JO`sTRMaTbU^IBPsToY_IO\pIoa_Io=bU?DmIbU`TrTrUOXnTbAaT_HsHoUbUOQbH?AaHO=bI?XqI?XlH?PnIODuIb@tUBDnJ?'+
               'DtIbTrHRPuIoY]To]]I_M`UbIbU?TsT_A`IOLqIRHqTbEbT_LqH?'+
               'LqTOA^IoPpTRPtIbPnIbHtUOE_H_DrT_LqUBI^I_TpUbE_UOUbTrTnT_a^JBE^I?=aI?'+
               'DpIrLrHrI^HoXlIr@nIrU`HrLqHrDoTRU_ToUaIBA^HO]bJO@qIbPnHo`tHOI]ToY]U_HoI_TrI_EbJBLrTOa`Io<qT_HmU_@rI?'+
               '<rT_=]T_MaJ?TrIrM_Io\qU_@nU?M^IOXmHo\rIoHpTbHoIoDlIoHlIOM`IBPrHO`sUBPnJBA^T_\uH?DtURLpIBQ`H_]'+
               'aIoHlH_LqToE`HoLlIOPnI_Q`I?\uTbPlTOa^IBLqIBQbTbLpHo@lToXqJODtTo]^U?Q_U?]_JBA`T_XmHo<nH?HlHO<lH?'+
               '@lH_\nH?@lH?=bJBA_HoXsIoPlH_]_JODtIRU]HRUaHBPmHbHpURLtU_Q`Ub@lToAaUOLpHO\rUbI`UBIbI?'+
               'HpH_HrHRIaTr@nUbIbIR@mHo`oHBA]J?M]HOXuIOLsIOHoU_A]HoTsTOPlH_M^Io]]H?]'+
               '^U_XuUOPpH_@uIRE^HoPoU_LtIR@pHr@oI_<sIrMaHoXsToE`ToHoJR@rTrE_TbLoIbQ`TbQ`IrPsIrPoT_U]TRTsU_]aU_HuT_=]'+
               'JRHsIOAaUR@qHRDmT_EbTRDuTo`rTbHuH?Y]T_HrIBMbHoA`HBTsTO\rTRHqIbDlTrPsI?`uTo\qI?DqJ?EbURLrJ?'+
               '<uU_`nU_QbHrLuJ?<uUOE^Ho<mHOE]I?XtIoTsUOPmIbQbI_=^H_aaIrLuUO<rTbPtHrLsI_PoHBM`JRQ_I_IaUBQaH?DqI?'+
               'LoIOXsJ?TpUO@sTOHrHBHpJB@rI?`mH?I_UBHnH?@tU?'+
               '`nJOE^UbEbTR@lH_@rTRE_TOYbH_HlIoTsHbHuTrQ_HrE^IoM`JBHnJOE_T_PoHo\qHBA^JBTrI_Q]UbDsT_PuTOTrH?abI?'+
               'DpH_E`Ho\pJ?=`H_@pTrM_IoYaTr@pU_U^U_QaH_HoIRI^JOLuUO@sI?U_To@nTOA^JRQ`J?U_UODrIbDpTOI`TbA^H?LnJBTpH?'+
               '=^IR@tI?YaURTmH?DtHO\lT_Y^H?M^I?`lHBU]TrHrI?abUBM^TrUaI?A]T_XpToHpTR@pTrQ]I_@pH?'+
               'Q`IbAbIoPtT_HlHRTrI_PpTbM`JOM^HbQ_H_<oToTtI?a^UOLnTrE^TbUaHRDuTrTmHOU_Io\nIRQbJ?'+
               '`uT_LpHB@qJOE`HR@uHBAaTO\sJRU`JBPmIbLuI?Q`T_ToIbHsIOHoT_PuToLrI_Y_IbPqIoTpIo=bIo`sIRTqTrU^TRMaJ?'+
               'AbTR@oH_LsT_TqHBMaI_AbU_\nTbU^Tr@uTO@pIoPtIo`rIRHnH_@rIRTmU_DqUBQ^U?HuU?PqTO`pI_U]'+
               'JRDuHbTmIoXmUO\qIoPpHBM^T_<nJ?@tH?`nT_`qU?LtJ?XoHRTmHoabI_@lI?<uUBLsU?Q`IrI_IRPoIbAaHbDnUOLtU?'+
               'EbHRDuJOQ^ToQaURPrIrA_U?a`U?`lIb@pI?`nTo]`I?<lU_Y^U?A_UBDuHo@pU_HmUOMbIbLqH?a^JBQ`IRU]UOaaJOE_IRDqH?'+
               'XlUOI_TOU_H_LtHrTuUOM_JBA^UbUaUBPmIBQ`H_PqHbUbJ?PnTO=_JB@tHbM^JBHmT_`uH?Y`HOTqIrHtT_\pTO`nIrLoIO]]'+
               'U_I`JBMbU?HlHRAaH_ToTrUaUBPuHRU`HOHuJO\qTRHoU_\nHbDnI_TrT_AaU?YbIOY^I_<sI?<rH_I]J?`lH_\mJ?'+
               '<oIo@pHB@tURU]IOXoJOTlIOU^T_LoI?XnUBPoTbPrH?E_JB@uToPtHR@mTRPnHOI^ToXtHRQ`IbM^IoPoU_XoUBTrH_LrU?M]'+
               'HBU]U_LpU_\sToTpJ?HoUOIaI_AaH?<qT_M]IbI^IrPoHo@uIBDpToTuToXsJOHuIoY]U_M^IoQ`IBHtTRTlTrI^H?'+
               'DmT_\sUO`qHrHqT_HoTbLrToDtToLuH?'+
               '@oU_a^UbQaU_PsIoA`U_HoT_DrHo=`IrPuHBU`URTsHo`pJRDsToY^JBDnHBPoJBLpHOI_IoHoURI_I?=_HOHpH_PmH_Q^ToQaU?'+
               'aaHoEbU_@sTrI_IbA]TrAbH?DtHO\lHoDmIO]]IBLnURDmHODuJRPuIbU_IBIaUBHuIOLsIoI]H?'+
               '`uI_I^Tr@oT_@lH_DtT_XrHrTlJ?\nT_HoI?E]H_abUR@nHo=_I?HqTRHlIRDuH?HqJ?E^T_LqHbA^TO]aJOXnJ?LrJ?'+
               'E_HoHlHoA`IOPpUBMaTOPmTbHnIoPqTbA^H_\lI?TsI_A`HoQbHOLsUBTpJ?=^TRPoUO`lT_DtTbPqU?E`TRHlJRLtJ?'+
               'Q`IOPlIR@nIoHtIbI`HOQ`H_A`TrE_UbIbHo@nH?@oHBE_H_M^ToAaJ?XmToXlIBHlTbHlT_YbH_TpTrM]IbUaIREaJRTrH?'+
               'UaI_XrU?LsUB@uJO<nJ?@tH?`uIbHoIBM`TOU]U?@pH?XoIRQ]HOY`T_XoTOQaTrPlU_a`H_U`TO=aTb@pJ?DuJ?<nHODuJBLlH?'+
               '\rIbLtIrU]TRDtI?]^U_PuTrU`I?YbTrQbIOQ_HRM]IOI]IO`uU_]]IbHsIo`tURA^JOXpT_]`I?<tHOUaTrDqU?\mToa_U?HsH?'+
               'TtI?`sJO\mI_`sU_U^IO]bIb@oU?I_TRPnJ?'+
               '\uT_@rH_XpIrDtURTpIbE^I_Q_UBPlU_TlJBTmIOTnIBQ`JO<rJO@sHoLmI_UbHb@mHo<lUbDqJRHqH_`pHOXsHOQaU_HoHrM]'+
               'TO@qU_XoU?`nIOMbJO@nUbTtIRHlUbT';   *)

s176CodeString= 'HbPlNB`uXryeQ`M]ISamMCMgW`IfPo`sV_aTXbuQIoE?I?`oI_<oQ@Q=J@yvMREaHRejIo]dVqM?Lq]'+
                'SIREaIQQHJQ<rIo=cLOIkZ`UIXO<qIpuJMbeCLOUTHoLnQOYLQaUdOA@nLO]DTpLpQoLqRO`mIPUTV@IAX@\oY_=pH_PpLoDmIA]'+
                '_IRMVOOEIHBeMWcdtR`pfURI_XpY=RaACLQADLPA>LPIBLPI?PaEHIa@sL`EVLQEQIQ]'+
                '=I`AEQpppQA=NM`@sQqATQplpL`EEM`EPIA]IRP]GIoM>I@dsLP]LIploL_ULLpiUNpmDP@`fURI_X@Y>MQACLQADPPA>LPIBLPI?'+
                'PaEHIa@sL`EVLQEQIQ]=I`AEQpppQA=NM`@sQqATQplpL`EEM`EPIA]IRP]GIoM>I@dsLP]'+
                'LIploL_ULLpiUNpmDP@a=PQQBM@dnL`uTQ@EULPyTRP\qRaAKOaMCRQeKN_QCNpU?N^eaTrIaUbUbTbUbUbDlH_<mH?<lH_\mJ?'+
                '=^I_M_ToM^H?\rJOQ`Io@uI?`tT_U`IRQ`I?`mHrHtTb@mTrHsU?XtTO`oIrPmH_E`Io=`H_<tH?PuTRE]'+
                'UBQbTbQ_IrQaU_DnHRHlToI`IoYaI?I]HbPmH?DtJBPrH?PqH?MaH_LqHOU]TrDqJBEaIoM`IOM]HRHnJOE`H?'+
                '\nIOTtTOLrIBEaJ?LqJRAbTRTlTrLnI_@uTo<oIoDoTO]]HoHrTrTpTrPmTO<rT_HtTrTrTOPrH_XnHOXuU?'+
                'EbUOHtHo\uIbTmIrQ^J?Q_H_Y_I_HoTbPoIOa]UOXmI_I^IoE]HBLoHoLtH_DrHr@lJOM^Ho`oHrLsJ?HnI_a]JO\qH?DlHo<mH?'+
                '<lHO<nJ?@tH?A]HRQ`I_Y^URMbTrI]U_XuHo`tIoDrI_QaI_XsTOPuHBPnJBPnI_\oHRPpHrDsTrU^IrA]'+
                'IO<sUBQbTo<lT_\sUOQbHoPrHRPpURDtJ?HuIo\uU?'+
                '<rIOa`UO`mIo@lHOLsUO\lUbEbIoLlToHoJOHqJOHtHoPmUBPoHbTnIbTqTbTqH_`qTOM^J?PnHbHsHoA_U?'+
                'UbUO<mH_HpU_LnURU_HrA_J?@nH?U`U?Y^IoIbIRU_JRU_TrDsI_abTrIaU?a^TOa^T_YbHo]^HO`pTbE]HRLmUbPtI?HpI?'+
                'LmTRHnUOHmIOToU?LsI?XlHoY`H_M^I_LpIRHqUBM]Toa`HBLlH_LlU?Y]IrE]JRI]HoE`H?@qI_DsUODuUOQ^H?]`UbPrHbTsJO]'+
                '^JBLuH?U^I?LpI?PqIoXuI_`lIRU_UBQ`Io]_TrM_IRLpIRTsT_]aIrLuT_`rT_<sH?PqUbQbIr@sHoY^HoA`U?'+
                '<rI_I_JRA_H_Q^IODuTrU]IBToTOXsT_DlT_HlH_LlU?\rIo`mT_XnHrToJBE_IOTtIRAaJ?E_HOTrIOHmUOa]H?'+
                'PtToPrTo`qIOTuIOM_TO]aIo\sIoI^HOTnIOUaIO`lTRPqToDsHBM^HBTmU?Y`JB@tH?HpU_TpH_HmTOE_HoE^I?'+
                '<rT_TlToPtTRHrUOLrTrLqH?`pHOLoJ?HtUOXlH_LmH?<sH?@tUBM]IR@nH_LoJBDsTODlUbPtH_LtIRMaIbHsI_U`H?'+
                'PuU_PrIRHtTb@qTo@tU_TnHODoIRM]J?EbUbTmURIbH_<rU_TuIo\pUBIaIRHrTbPrIO]]U?DuUR@mUbHsU?`pU?\pIoXnJ?'+
                'HnT_EaJR@pIoHsH?MbJ?AbToTtIO<nI?<oI_HqJOHuHRUaH?TtIoMbU?XoJOPrJ?`uTrEaJOE_IoLpIbHuJ?QbUbUbIBPqJ?'+
                'XtHo`pH_LnHOIaH_@oIOLqI_DsUBM^H?Q_JOUbHoU`IRQ_H_XlH_PqI?IaU_U^H_DlHOI`J?a]IBLrUO]'+
                'aTb@lUO<pJO`pIOE`HrLmU?Q]Io<nI?<lJRHrIoPtUbEaIbLnJOQ`JOLmIrLoHrU_T_DnI?'+
                '@nHrPuH_<sTbHsT_LlU_a`HRTqTO=`I_=aIoQaJ?UbHRDrIREaU?'+
                'LrUOHuToLuI_\tIo\pJRTlJOLpUbUbJOXmJBPqI_HmHBI^ToPsUOE`UOabUBMaI?QaIR@pJRE]HBA`IRUbUbQbUbUaH?DlHO<lH?'+
                'DtH_<mH?<uI_LnH?Y`I?XpToXqHOa^I_<sH?EbHO`mHrPpIoXqU?Y^ToHsUOMaJO<sHO=bIBTnT_E`ToE_IoAaIO]'+
                '^UbHuH_<oJOXrT_PnI_U^U_LuUOXqHO]_T_\uJ?LrHRDsH?TqH?M]J?`nU?@qTo@mH?]aJBTmH?<oHRAaI?'+
                'XnToDsIoQaUO@lIb@nIo]_TrToHo<mIO<rU?PuHrAbTOA^HODnIrMbToQ^HO]aTOY`J?'+
                'DrJBHsHrHoHoLrIOXoIRI`H_PlTRLqIRHsIOLmHbA^U_`qIrPsT_HmIoLuHO`uHOTnIRU]IbToH?'+
                'PsH_XlHRPuH_<sUR@qH_\pH_I]HoIbJ?<nTrQaH?PmJOA_JBQ^JRA]IoDoH?Y`IrU]JOXlH_MbHOY^U_U^TbE]'+
                'I_XpTo@tTOHnHoPuHrA^Io\tHBLuUOa^IbPuH?TqI?TlH?LtIBDpTbMbTRMbIbHnIo\uU?'+
                'a_TO@lIOTsHODpIo\uHbPtTO<rUO<pHo\pIOM`IoHpI_<tJOU]'+
                'TbLpT_`qI_@qUbUaURHsTbTnHOHqHrE_UO@mJBDpIO`tJRPqIBE^IbHpHR@lT_HnIoUaIODpHrA`TO\qU_Y`UbPpUOQ`IbE`HoPuI?'+
                '<lIbEaH_@pT_a]HbM`HBI]HB@sIrHlJRLlToHoU_LlHBHnU?Y^I?TqIrDlH_<uTO\sIO<nH?HlHO<lH?@lH_\nH?@lH?'+
                '<pTRTmToLqI_<oTO`nIbM^H?]_URQ^TRQaI_U`HRM`ToPnTrQ^U_LmHO<rTOPoUO\sJBTlUR@nIRHrTrLmU?Q^J?'+
                'IaIoDqIrPqIOA^TOHsIoDqJO=]J?XpIrQ_HbUaHoUbIrTqHoPqI_XsIoHpI?YaU?TsToXrHO<lHrHmU_`uTrTlJ?'+
                'QaToXuHrLnIoY_I_LtU_@tI?`tURLlHRDnIRQaTbPpJ?@lI_YaU?=`JBIaUO@qU_A_HBPmI_M^UOLmH?'+
                'LnJBLoH_E^TO`uHoTrJOHtIoXpU?a]URLoJOXmU?A_TOIbJBTmIRM`I_DrIoTmJO<lHoa]UbIaJO]^IrPpH?'+
                'LpUODoU_\qHOTmIO\qHOXoIBTmTrA^IBEbT_XmTo@lHRDrJO]bHbPrIOE]'+
                'ToA^TOPqU_a^H_`tIODqTo@oIRQ`JBLtJRPsIrDoHbPnI_PtIOXpU_LnUBTtT_]]IoHoIo<pI_<mTRDtH_<qHBE]'+
                'T_a^TODuIRMbToQ`JBEaTo<mUOTuIoHlHoLrJO\sJ?LtH_@rJO=^I_I]Io<nHOE^IoQ]'+
                'JO<tTRLrToHpTRAaIBPtTOI^H_I^HoHmHbDlU?=^URHtHRE`URUbJO]bJO<nHBDnJB@qIRDlJOE`UOI]'+
                'TRPsTbDpTo=aIo<qJO\sHRLmIo<uH?XqIB@oU?]]UO`tHRPmH?DtHO\lT_\lU_TlHbPrI?'+
                'E^JO`lJRHnHO<sIBMaT_HmU_a`HOXmURIbHb@qJBHsIOPoHrAaH_@tHo=`TrDpI_]`HoPlI_<tIoHmTR@rU?@tIoa`I?'+
                'LpHOMaHRU]H?LtU_`nIbMaHOPqI?E_TrDlIrPrT_aaHrTmHOLnI?AbUO\nT_`oIbHsUbDuH?`rU_XoJ?TnHRDnH?'+
                '`oJRLoTO<sHRTnHbHqToUaIo=^H_\oJ?LpHRTmToE_I_XlHB@lUOUbTOA`T_A^H?XmT_`sIBLoUBLmU?HmIOHsUO\rI?DmIrM]'+
                'IoM^TRDnURM`UODpU_\oToDuTRHoIo\pJ?TuIRLlT_U`TrTuJO<nJ?@tHBLlUbHsUBTlH?XrU_PqTbMaHoLuJ?'+
                '`qURTrHOTtHrTpUOQbHbDsHrI^H?\lIo]aTOE^TrPqH?HnUOPlTbTrI_@tH?<tI?'+
                'DoT_HtJBLtIBHnT_YbTbTmJO@uHoPrTR@lIoPtHBLmU?MaUbPoHrLlU?E^TOQ_IO]`JOLqUBHmH_\sIOLnIoAbU?'+
                '`nH_E`JB@oIRHpIOU`HBTpHrHsI?TrI_M`TRIbHRLrHBDoIBDuIoPlI_XpI?TuIbPoJRM`HBDpIO]bJ?I_HRI^U_=]TOQ]Io<uI?'+
                'a]J?XrTRI`Tr@rToDsIrPsHBE]TRI^IoLtJO\oH_\nTOU]TOXlI?PnT_PuHrLlH_\mJ?<uI?XqTR@sHR@lU?<qU?'+
                'abHoTpUBHuToTsT_A]IbE^UBPoIOU`TbPpI?A`Tb@nIOM^JB@uHO`rUOHqJO]`UO<pUO=^JRMaURHrHODoHBQ]HR@tHrTmJ?'+
                'PuIOI]HbI^IBEaI?MaI?A`IbU`TOXtIo`rTO]^I?LoHoHlU?HpI_=^HrQ]HBLqJBPoU_@sU?'+
                'TrHRPqHOI_T_\pTRDtTbM_TOHpHrU_ToQ_UO=]HRHpH?EbJRHpTrTpIrU`HrQaHo\mIoLoTOXrIoA_H_`rT_HsH?a^T_I^U?'+
                '`uIBPoUODtTbDrTRTrUO@sIo`nH?PpIrPuI?UbHbTqHBLnU_LpIoA]U?HuH?DtHO\mH?<sIoXnIo`pHBHmUBTmURDlTOI_H_A]'+
                'H_LlUOabJRE`J?PoTbM_H?\mJBLuJ?LlJ?LlIoXuTR@qJO=_JOPnHrHoI_DsToPqURQ]IoM]'+
                'HbE_HOTsJBDoIbQ`HbU^T_UaUbToIo`nIoXqIrTtURTlHBHnHO@lI_M^Hr@mI?'+
                'HqTrQ`JOMaIrMbI_HpHOE`IbLtJODmIb@lIO<qJRPtIRE`IoPnIoa_IRE^IOE`HrPsT_TuTOa_HBDsTbUbH_TpU_XnURE`IOHqI?'+
                'XtIOA^HBTnHo@rH?a^JRDmH?<uJ?`nToIbH_TrU?<rHrHmUO\mJ?HoU_PqTRE^JBE`T_@oJBM_U?HuH?DtHO\mH?'+
                '<sTRQ_Io`nURPoJ?@lTrToHBPuHRU^HoXmI?PsTO`nUbPqIbDqU_PsI_@tUR@oI_EaUBDpU?PlTOLnI?a]T_XrHRM^HrDoT_]'+
                '^UB@pIOXuTbLuHo<pIbTpIb@rJOXsURPqHOTsJ?TqJRToH?LqI?PnH_TlIrTmU?TsJO`oUOUaURDrURHuU_Y`HRTnIO\nTO]_I?'+
                'XrI?\tI_@qH_I`JRM^J?a_U_TmIoA_TbLtJO<rHRI_Io`tIo`rIo<tT_\oJOQ`I?A]UBA]IRDuIBPrTO@uH_AaU?QbI?'+
                'A`To`pHBHsH_XlIrHpToToH?U_URA^JOTuIBDnI?=`JOXpHRA^JOU_';

  CodeString  = 'I_Y_OBAUHa@pW?LnZ?UuVo=bJ?LqX?U@WS`sZ_PrO`uiNQPtWoIfNo<uOOPuIcToHAHmH?'+
                'QMJAUSM`IJX@`sPRxlU_E=VsINJBxtNblnIRiCR`icP@tnRRuDVRmsWoAfNbQkIBaLHbISLRI?HbPtH?'+
                '<sH_QdYaa_PppuIAXsTPDoMBLlIp@nHPprI_E]H`]gNpIbQrDfURI_XpY=RaACLQADLPA>LPIBLPI?PQAFNqEGH`eQIPM>HpYGNQ]'+
                '@Ia@sI?QJOpIHRA]?P`e=L`EEIa]QN@QEHqUOPPpqMPiPO``qPpuLOpySOoMLM`]FP`HfURI_X@Y>MQACLQADPPA>LPIBLPI?'+
                'PQAFNqEGH`eQIPM>HpYGNQ]@Ia@sI?QJOpIHRA]?P`e=L`EEIa]QN@QEHqUOPPpqMPiPO``qPpuLOpySOoMLM`]'+
                'FP`I=PQQIIQARI?DqLoPnP`mDHoHrO`QJOOMHLpHsQ`AHLpyRQneaTrIaUbUbTbUbUbDlH_<mH?<lH_\mJ?@lH?'+
                'TpURDmUB@oTREbHRHtIoHuTo<tIrQ^J?E]IOY]IbLoI?<pJRUbTo<nTrE^HoI_IRPrIB@nI?\nHbLmJ?IbIO=]TbA_JBQ^IrPtJ?'+
                'HoJBIaUBE`UOTqURHuIbE]ToDnIBMbHRPrHBM`TrTlHoI^TbHrIoXuI?]^UOQaI?@mJO]`TRHlJRPpURHlIOPpIOUaJOLlJ?'+
                'IbIbDpU_`mT_YaIO<qTOI_UO`tTO]^Io\lIO<pH_ToIrU_HOPoUOa^I_I`ToQ`I?MaHRE^TO=^HrQbIoAaIbPsTbLmHOA^JOaaI?'+
                'DuIOPuJ?U`U_XpU_UbI?<nHoLmH_TpH?Q_Ho<pH?<oIrTlH_<oH?@lH?<mH?DtHO\lH?]^UBPuH_DqU?TuTOHqH?'+
                '\tIb@uUbTsIr@lT_YbT_EbTRTqTRPlIbI]JO`nJBHmU_E`HRPsIOa^HoTtIBTpTbHlTOHpHBTqTOHqJO\nJO`pHB@tJ?DoHRE`IO]'+
                '_UOE]IrLsU?PsHbI^U_a]URDmJBHqUOa`Ib@tIBQaIrM]TbE^I?@sUbPmIoAaHrDrHBMbT_XoJRI]To]]U_Q`H?HlU?'+
                '\oUO<rHBA`HrQ`HoM^JRTnIBQ]HrPpIoXmJRM]U?@mI_E`IO`sHbDoUO@nHbLnUbA`HrDqU?HlJ?HpTbMbHRHrI?XoH?'+
                '`qU_TqHrDlJ?E^HbQ]UBDrHOXmUOHnUBQ]JO<nI?=]IRTnJ?'+
                '<qUOLrTrLnIoaaHOQ`To@oUBU_UOA_UbPuH_AaT_DqIbPlIBTrJO<qUbLrU_Q]IBHqJRA`Io]_URLqT_`pHBLsToPnHoLsIOa]'+
                'JBToJRPlI_DmHo<nHoA_UOYaH_=bTRDqUOE^HbM]T_PpI_\rTOXuT_=`Io<rIoQbHo<nI?<uTbAaToLlURQ_Tb@nUOY]I?`mUBM]'+
                'H_XoH?=aU_<tT_]_ToE_IrI`JO=`T_LlTo=bJOXoUOEbJOMaI?@pHbAaIOa^U_DnJ?'+
                '<rToDnIO`nU_PsHbDsT_\nHbQbU_XlTrHqHBTuH?AbT_HmToIaHbDtJRToUOIaIrPlU_`rH_HpIO<nI?'+
                '<mTODrHbTqH_E^ToYbH_DmHo\lH_`tUOHnH?TlIoHpHBPqHoHrIbU^HbE]J?HuU_\rJ?]aJBDlU_U]J?PrJRM]I?Q^JRLmH?TqH?'+
                'Y^U?E_I_=^T_PrUbToU?M`JO<oJR@lTO\rHrDuHrDtHbHmIoAaIOEaHRI_IO@oH?TlUOPoU_<nI?'+
                '<lI_\nUBU^I_PpHOTqHOQ`IOAbHo]]TRLoTRPtIOPlU?HmHRIbH?TtIRDuIoabU_M^H_I]'+
                'HoHuHo<oTbU`TrUbHOY_IrLoT_LuIOPmHoTsHrDmIbI]HoDpToQ^ToUbI?TpToPtTRM_JO\tToDpU?'+
                '`tHoPnJBLlIB@pT_XnJOXmIO<nI?<lHoHsHO`rIOY`IODrHrPsHoHrT_PrJOPoU?=`T_I]I_TpHB@uIO=`UOAaUO`oT_E`I_U^H?'+
                '@pI_\lU?Y^I_LuIOXoIRTmIoU]H_I`UBHqHoEaIrTsHO\rIRLpU_IbI_`uUO<sI_DnIO\lIRDtIrHuUb@nToDqTOY]HbU^I?'+
                'EaTbUbUbQbUbUaH?DlHO<lH?DtH_<mH?<tIBHtI_]^JOQ_I_A_HoPnI?HqToXoTbTtIrPsUBI^TrDrTR@tH?AaJ?'+
                '`qU_Y_IO<rHrEaTO=]I?A^TbLtJ?`tJOM_JOXsURA_TbLoUbLoJRE_H_Y]IbDpI?'+
                '<sTO\tJOPqH_=bToXnUbPmH_XrIO@uT_a`JO@rTo]_JOQbJRE`IBLsJOXlHbToUbTsU_\oIRUaU?QaIO@lJOXpTo]'+
                '`HoDmUBHpURU`JREbJ?aaI_@nH?HoIbI`UbIbTO\oJBA_IbHtJ?<mT_`rI?DtT_E`H_HrHoI^UO=]IbU^ToDpT_PpUR@tHOHpU?'+
                'LrTOI_I_XlTRDrU_LtH_`lHB@qJOM]H?PrJRI_JOHqUR@tI_LmIbA_I?XlH?PuJBI_TO=]HoLoH_HqU_@tHrLqIO]`H?]]JBI]'+
                'IoPsURA^H_E]IoQ`U_=]HbDlI?ToI_]^H?I]TOHnT_@mI_LuToYaUOU^U_<lHbHqHrDoIO\mJBHoTOHrHoTmU?'+
                '\tU_TlUOTrU_LpT_UbJBTqUR@rIRLmIrQbTrQ]'+
                'TrDuJB@tI_MaHoDoTrEaHBPtIrHmTbDlToPtHOYaHbLnIOLmHbEaUB@mIBIbT_LqTRLsTo`uToMbI?LsH?'+
                'abJOMbIBPsIRU^Io<tU_<pUBTlIOLlUO@sTRE_TrQaI_<pIbLmJBLuTo`lHOXtH?<uTODoT_<nH?HlHO<lH?@lH_\nH?@lH?'+
                '<tU_TmH?@sI?EbJBPqTrHuToLlIr@rJ?E]UOTmJOHrU_EaTOTuJBE`HrHlIB@lIrUaH?DnJBLqHR@sTOXpIOAaHO]_T_]]'+
                'JOXoUBDmJOHmU?EbH?XlT_<oIrA`IrU]HBDlHo@sHrU]H_=aH_@qJ?YbUODrUbHuI?'+
                'XmUbQ^H_Y_I_Q`U_\mI_<uI_PqUODqToTnJRTrUOA]TrDlUOTrIOAaTRPsUBPmT_PoU?'+
                'M`TbQ`JRPoHRDsJRPtHbMbHoY^IOXuU_UaI?TqIOU^HoI`TO`qHB@rHoTqIo@uI_Q]UOI`URDqTRQaHRU`H?TqH?'+
                'TuHOUaTbU^HO<uUBA_IoXrJBHlT_HpIBDuIbHrH_A_I?U^To<oH_a^T_XoT_=aIRQbHO\tTbEaIRE`T_HuHbDsHo`rI?'+
                'M`HO`pIbTtIODrIODnTrDoToDuTrM_I_YaTRM_JBE`IrPoIO@rTrTsIoXuJ?`sHbQbTRQ`To=aUOQ]TrDsH?'+
                '=_UREbUB@tI_AaUOPsIrPnH?MbTbLnI?a^JBQ]U?@rH_HuJ?HuU?'+
                'PoIo<oIBPmT_\rHb@qTRHsURLrHO<tIrQaIRE`HoHmI_aaTO\sU?=_J?M_TrIaHRU]HOLsUBMbTbU^HRDtH_M_URDoH_abHR@rJ?'+
                'DqJRE]UBPuIBM_IoDsU?@sUOPpU?DsIODrU?TqH?DtHO\lTRHpHbI^TOEaUbI]'+
                'TRLoI_\oIbDqIBE`U_LuIOHuJOIaI_LsJRQaTo@nUREbHbHqUOMbHOLlIBHuUR@uJ?LuHODlIrE_T_LnJODoU?TtIBHuTO<lH?'+
                'QaIOA_IoYbURU`U?`rJ?QaJBDrU_EaTrM_HrTtIBTlToPoTbHoTOXtJRQ_UOXsIrEbU_E^HoU`HrHuJRTnT_XqH?TpI_`rHbToH?'+
                '@sIrUbIBDlIrDqTOTpIBTsIRUbU?'+
                '`uURI`URPtIRIbTRLrUb@oHoHmHoTqIRUbIoTsIrDsTRLtHBA_Io`pUbTtJOM_H_LtTRLnJOEaHOQ`I?'+
                '`mUOTtToE`TbDoTo=_IO<nJ?@tHBHqIOM^J?UaHo@tIbLmUBTuJOLrJODrT_Y`U_Y`HRLoTr@lTb@pHr@oI_LtH?TtH?'+
                '`rJBDnIbE`IrE]HOE_UBTtIo=bTo=`H?@oJ?\uIBQ`TOPpH_<sToI^HbAbHBE`IOEaH?LlIBM^TbLoHBE^IOE_H?A^JO\nI?'+
                '\nJO\tIBMaUBTtU?\tU_XsJBI`TbPsHrDpTbAaT_<tIbDtIrPmJRI^UBQbHbQaIrTnUO\pTO]^ToM`JRE_HrPqToXsIBI`I?'+
                'TtIoY`U?MaTrPrH?XlJ?M^Tr@nIo<qIrTuJB@rIoXtJBTrIOHoU_U`HoQ`I?HuUb@qIrDqU?U_U?HmJ?<rUbTlH_\mJ?'+
                '<lHoAbI_E`JOa`I?XnT_LpTOQ^IOHtI_<lJODnUbDqToHrUbHrU?TmHODnIbE_TrEaHO]aJBMbUbLqJO<sIOA]TbHrH?'+
                '<nHRDoURLoI_TnI?a`IOTlTRHqIO<sHbI_I_\tIOa_I_E^TOQ_IOPuJBM`I?\tU_<rI?TnUOMbIO@lJ?UbURM^H_]`T_`uIbLlU?'+
                '\lHbIaTOE`ToUaI?HnHbAbU?\sU?HqIBPpUBAaH_A_T_QaU_LoJ?PuTRHuJRU]IBAbU?XqUBHuT_Y_Ib@tI_<rU?DmIOTrU_=]'+
                'Tb@mIR@tUO@sIBDlUO=aJ?TnTRA^IoHnJOXpH_Y]TO<lJO`tU?`mH?DtHO\mH?<qH?Y`IR@nU?HtIbPsHRDpURQaI?'+
                'TrIRLlTODtToY]HRHsTrHnUbLpTbQ_IoU]HrTuHODtIo`pJBLtUO=_JOPtU_I`H_U`H_XsH_`lI?XtU_@sU?PsHoE`IOIbJOE]'+
                'TRPrUBTnJRM^JBDoU?UaJBLmTbHnH_\qIO<sU_DpJBTnUO<uTOa_IRDlJBE_TO<lI_@qJRM]U?LsTbEaTo=`H_I]H?'+
                '`lU_LnUOU_HR@nHOU]I_DpI?`qTo=^I_I`I?@qT_TuUOPrH_TnHoI]'+
                'U_HlHoXnI_@nU_HlUbEbHO\mJBQaT_@nHoDtJOa^TO\rHoTrIbMbToDqU_A`JRA`U?@nHoDuH?DtHO\mH?<pURPpHo@pIo]'+
                'aHrQ_HO`oHbIbTrLnU?\oIBE^TO<uU_\oH?LlTOHqUODoH_TtU?LrI?@mT_Y^IBLtI_=`IrPrI?]`I?DlI_Q_UBHlToU_JBLnURA]'+
                'JBIaI?LuJ?a]U_XuH?YbTRE^IOQbTr@rIoPuTrToTOM^TR@pJBQaU_LuHo\nUOPuI?\rUO=aU_DsH?A`T_MaH?'+
                'DuJO\sUO=aTR@mIoQ_T_@uTRTnIBE_JBPqUBDsHO@mH?PmH_XuU_TuTrTqTRUbHRE_UBTrUBUaH?@tU_UaU_PqT_PlHo<pI_E]'+
                'U_QbTO=aHo@tI_`sHoQaTOPoJRLlJOa^HBI_U_LpTRLq';


//由于此过程，需要带WinlicenseSDK.dll文件
procedure MakeM2FileKey(g_MakeDir, sData: string);
var
  ExpDateSysTime: SYSTEMTIME;
  LicenseKeyBuff: array[0..1000] of AnsiChar;
  SizeKey, i: integer;
  pName: PAnsiChar;
  pOrg: PAnsiChar;
  pCustom: PAnsiChar;
  pHardId: PAnsiChar;
  //pExpDateSysTime: ^SYSTEMTIME;
  NumDays, NumExec: integer;
  KeyFile: file of AnsiChar;
  str: PAnsiChar;

  sStr: string;
  sSocketIndex: string;
  sAccount: string;
  sGatePass: string;
  sKeyPass: string;
  sHardId: string;
  sRegDate: String;
  RegExpDate: TDate;
begin
  try
    sStr := DecryptString(sData);
    sStr := GetValidStr3(sStr, sSocketIndex, ['/']);//
    sStr := GetValidStr3(sStr, sAccount, ['/']);
    sStr := GetValidStr3(sStr, sKeyPass, ['/']);
    sStr := GetValidStr3(sStr, sGatePass, ['/']);
    sRegDate := GetValidStr3(sStr, sHardId, ['/']);
    if (sAccount <> '') and (sKeyPass <> '') and (sSocketIndex <> '') and (sGatePass <>'') and (sHardId <> '') and (sRegDate <> '') then begin
      pName := PAnsiChar(sAccount);//用户名
      pOrg := PAnsiChar(sKeyPass);//公司信息
      pCustom := PAnsiChar(sGatePass);//IP信息
      pHardId := PAnsiChar(Trim(sHardId));//硬件ID

      NumExec := 0;//限制运行次数，0值则不控制运行次数
      RegExpDate:= StrToDate(sRegDate) {+ 365};//20110712 修改，到期日期直接按注册类型决定
      DateTimeToSystemTime(RegExpDate, ExpDateSysTime);//到期日期-
      //pExpDateSysTime := addr(ExpDateSysTime){nil};//到期日期-
      if (Date() <= RegExpDate) then begin//到期日期大于或等于当前的日期
        NumDays:= DaysBetween(Date(),RegExpDate);//取两日期的数
      end else NumDays:= 0;

      str:= PAnsiChar(DeCodeString(CodeString));//M2哈希值
      SizeKey := WLGenLicenseFileKey(str, pName, pOrg, pCustom, pHardId, NumDays, NumExec, {pExpDateSysTime}ExpDateSysTime, 0, 0, 0, LicenseKeyBuff) ;
      //保存注册文件
      AssignFile(KeyFile, g_MakeDir + '\' + sAccount +'\IGEM2key.dat');
      Rewrite(KeyFile);
      for i:= 0 to SizeKey-1 do Write(KeyFile, LicenseKeyBuff[i]);
      CloseFile(KeyFile);
    end;
  except
  end;
end;

{procedure Log( s : PChar);stdcall;
var
  F : TextFile;
begin
  assignfile(f,'c:\记事本.txt');
  if fileexists('c:\记事本.txt') then append(f)
  else rewrite(f);
  writeln(f,s);
  closefile(f);
end;  }

procedure MakeM2FileKey_176(g_MakeDir, sData: string);
var
  ExpDateSysTime: SYSTEMTIME;
  LicenseKeyBuff: array[0..1000] of AnsiChar;
  SizeKey, i: integer;
  pName: PAnsiChar;
  pOrg: PAnsiChar;
  pCustom: PAnsiChar;
  pHardId: PAnsiChar;
  //pExpDateSysTime: ^SYSTEMTIME;
  NumDays, NumExec: integer;
  KeyFile: file of AnsiChar;
  str: PAnsiChar;

  sStr: string;
  sSocketIndex: string;
  sAccount: string;
  sGatePass: string;
  sKeyPass: string;
  sHardId: string;
  sRegDate: String;
  RegExpDate: TDate;
begin
  try
    sStr := DecryptString(sData);
    sStr := GetValidStr3(sStr, sSocketIndex, ['/']);//
    sStr := GetValidStr3(sStr, sAccount, ['/']);
    sStr := GetValidStr3(sStr, sKeyPass, ['/']);
    sStr := GetValidStr3(sStr, sGatePass, ['/']);
    sRegDate := GetValidStr3(sStr, sHardId, ['/']);
    if (sAccount <> '') and (sKeyPass <> '') and (sSocketIndex <> '') and (sGatePass <>'') and (sHardId <> '') and (sRegDate <> '') then begin
      pName := PAnsiChar(sAccount);//用户名
      pOrg := PAnsiChar(sKeyPass);//公司信息
      pCustom := PAnsiChar(sGatePass);//IP信息
      pHardId := PAnsiChar(Trim(sHardId));//硬件ID

      NumExec := 0;//限制运行次数，0值则不控制运行次数
      RegExpDate:= StrToDate(sRegDate) {+ 365};//20110712 修改，到期日期直接按注册类型决定
      DateTimeToSystemTime(RegExpDate, ExpDateSysTime);//到期日期-
      //pExpDateSysTime := addr(ExpDateSysTime){nil};//到期日期-
      if (Date() <= RegExpDate) then begin//到期日期大于或等于当前的日期
        NumDays:= DaysBetween(Date(),RegExpDate);//取两日期的数
      end else NumDays:= 0;

      str:= PAnsiChar(DeCodeString(s176CodeString));//1.76 M2哈希值
      SizeKey := WLGenLicenseFileKey(str, pName, pOrg, pCustom, pHardId, NumDays, NumExec, {pExpDateSysTime}ExpDateSysTime, 0, 0, 0, LicenseKeyBuff) ;

      //保存注册文件
      AssignFile(KeyFile, g_MakeDir + '\' + sAccount +'\IGEM2key.dat');
      Rewrite(KeyFile);
      for i:= 0 to SizeKey-1 do Write(KeyFile, LicenseKeyBuff[i]);
      CloseFile(KeyFile);
    end;
  except
  end;
end;

begin
  if (ParamStr(1) <> '') and (ParamStr(2) <> '') and (ParamStr(3) <> '') then begin
    if ParamStr(3) = 'A' then MakeM2FileKey(ParamStr(1), ParamStr(2));
    if ParamStr(3) = 'B' then MakeM2FileKey_176(ParamStr(1), ParamStr(2));
  end;
end.
