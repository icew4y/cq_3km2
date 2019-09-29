{*******************************************************************}
{                                                                   }
{       Almediadev Visual Component Library                         }
{       BusinessSkinForm                                            }
{       Version 4.40                                                }
{                                                                   }
{       Copyright (c) 2000-2004 Almediadev                          }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{       Home:  http://www.almdev.com                                }
{       Support: support@almdev.com                                 }
{                                                                   }
{*******************************************************************}

unit bsconst;

interface

resourcestring

  BS_MI_MINCAPTION = '最小化(&N)';
  BS_MI_MAXCAPTION = '最大化(&X)';
  BS_MI_CLOSECAPTION = '关闭(&C)';
  BS_MI_RESTORECAPTION = '恢复(&R)';
  BS_MI_MINTOTRAYCAPTION = '最小化到系统托盘区(&T)';
  BS_MI_ROLLUPCAPTION = '卷起(&L)';

  BS_MINBUTTON_HINT = '最小化';
  BS_MAXBUTTON_HINT = '最大化';
  BS_CLOSEBUTTON_HINT = '关闭';
  BS_TRAYBUTTON_HINT = '最小化到系统托盘区';
  BS_ROLLUPBUTTON_HINT = '卷起';
  BS_MENUBUTTON_HINT = '系统菜单';

  BS_EDIT_UNDO = '撤销';
  BS_EDIT_COPY = '复制';
  BS_EDIT_CUT = '剪切';
  BS_EDIT_PASTE = '粘贴';
  BS_EDIT_DELETE = '删除';
  BS_EDIT_SELECTALL = '全部选择';

  BS_MSG_BTN_YES = '是(&Y)';
  BS_MSG_BTN_NO = '否(&N)';
  BS_MSG_BTN_OK = '确定';
  BS_MSG_BTN_CLOSE = '关闭';
  BS_MSG_BTN_CANCEL = '取消';
  BS_MSG_BTN_ABORT = '终止(&A)';
  BS_MSG_BTN_RETRY = '重试(&R)';
  BS_MSG_BTN_IGNORE = '忽略(&I)';
  BS_MSG_BTN_ALL = '全部(&A)';
  BS_MSG_BTN_NOTOALL = '全部否(&O)';
  BS_MSG_BTN_YESTOALL = '全部是(&Y)';
  BS_MSG_BTN_HELP = '帮助(&H)';
  BS_MSG_BTN_OPEN = '打开(&O)';
  BS_MSG_BTN_SAVE = '保存(&S)';

  BS_MSG_BTN_BACK_HINT = '转到最后访问的文件夹';
  BS_MSG_BTN_UP_HINT = '转到上一级';
  BS_MSG_BTN_NEWFOLDER_HINT = '新建文件夹';
  BS_MSG_BTN_VIEWMENU_HINT = '查看菜单';
  BS_MSG_BTN_STRETCH_HINT = '拉伸图像';


  BS_MSG_FILENAME = '文件名:';
  BS_MSG_FILETYPE = '文件类型:';
  BS_MSG_NEWFOLDER = '新建文件夹';
  BS_MSG_LV_DETAILS = '详细信息';
  BS_MSG_LV_ICON = '大图标';
  BS_MSG_LV_SMALLICON = '小图标';
  BS_MSG_LV_LIST = '列表';
  BS_MSG_PREVIEWSKIN = '预览';
  BS_MSG_PREVIEWBUTTON = '按钮';
  BS_MSG_OVERWRITE = '您想覆盖原先的文件吗?';

  BS_MSG_CAP_WARNING = '警告';
  BS_MSG_CAP_ERROR = '错误';
  BS_MSG_CAP_INFORMATION = '信息';
  BS_MSG_CAP_CONFIRM = '确认';
  BS_MSG_CAP_SHOWFLAG = '不再显示该信息';

  BS_CALC_CAP = '计算器';
  BS_ERROR = '错误';

  BS_COLORGRID_CAP = '基本颜色';
  BS_CUSTOMCOLORGRID_CAP = '定制颜色';
  BS_ADDCUSTOMCOLORBUTTON_CAP = '添加到定制颜色';

  BS_FONTDLG_COLOR = '颜色:';
  BS_FONTDLG_NAME = '名称:';
  BS_FONTDLG_SIZE = '字号:';
  BS_FONTDLG_HEIGHT = '高度:';
  BS_FONTDLG_EXAMPLE = '示例:';
  BS_FONTDLG_STYLE = '字型:';
  BS_FONTDLG_SCRIPT = '字符集:';

  BS_DBNAV_FIRST = '首记录';
  BS_DBNAV_PRIOR = '前一记录';
  BS_DBNAV_NEXT = '下一记录';
  BS_DBNAV_LAST = '末记录';
  BS_DBNAV_INSERT = '插入记录';
  BS_DBNAV_DELETE = '删除记录';
  BS_DBNAV_EDIT = '编辑记录';
  BS_DBNAV_POST = '保存修改';
  BS_DBNAV_CANCEL = '取消修改';
  BS_DBNAV_REFRESH = '刷新记录';
  BS_DB_DELETE_QUESTION = '删除此记录吗?';
  BS_DB_MULTIPLEDELETE_QUESTION = '删除所有选择的记录吗?';

  BS_NODISKINDRIVE = '驱动器没有磁盘或者驱动器没有准备好';
  BS_NOVALIDDRIVEID = '非法的驱动器符号';

  BS_FLV_NAME = '名称';
  BS_FLV_SIZE = '大小';
  BS_FLV_TYPE = '类型';
  BS_FLV_LOOKIN = '查找: ';
  BS_FLV_MODIFIED = '修改时间';
  BS_FLV_ATTRIBUTES = '属性';
  BS_FLV_DISKSIZE = '磁盘空间';
  BS_FLV_FREESPACE = '可用空间';

  BS_PRNSTATUS_Paused = '暂停';
  BS_PRNSTATUS_PendingDeletion = '正在删除';
  BS_PRNSTATUS_Busy = '忙';
  BS_PRNSTATUS_DoorOpen = '仓门敞开';
  BS_PRNSTATUS_Error = '错误';
  BS_PRNSTATUS_Initializing = '正在初始化';
  BS_PRNSTATUS_IOActive = 'IO Active';
  BS_PRNSTATUS_ManualFeed = '手动送纸';
  BS_PRNSTATUS_NoToner = '没有墨粉';
  BS_PRNSTATUS_NotAvailable = '不可用';
  BS_PRNSTATUS_OFFLine = '脱机';
  BS_PRNSTATUS_OutOfMemory = '内存溢出';
  BS_PRNSTATUS_OutBinFull = '出柜满了';
  BS_PRNSTATUS_PagePunt = '跳纸';
  BS_PRNSTATUS_PaperJam = '卡纸';
  BS_PRNSTATUS_PaperOut = '缺纸';
  BS_PRNSTATUS_PaperProblem = '纸张问题';
  BS_PRNSTATUS_Printing = '打印';
  BS_PRNSTATUS_Processing = '处理';
  BS_PRNSTATUS_TonerLow = '墨粉不足';
  BS_PRNSTATUS_UserIntervention = '用户取消';
  BS_PRNSTATUS_Waiting = '等待';
  BS_PRNSTATUS_WarningUp = '预热';
  BS_PRNSTATUS_Ready = '就绪';
  BS_PRNSTATUS_PrintingAndWaiting = '正在打印: %d 文档,请等待';
  BS_PRNDLG_PRINTER = '打印机';
  BS_PRNDLG_NAME = '名称:';
  BS_PRNDLG_PROPERTIES = '属性...';
  BS_PRNDLG_STATUS = '状态:';
  BS_PRNDLG_TYPE = '类型:';
  BS_PRNDLG_WHERE = '位置:';
  BS_PRNDLG_COMMENT = '备注:';
  BS_PRNDLG_PRINTRANGE = '页面范围';
  BS_PRNDLG_COPIES = '副本';
  BS_PRNDLG_NUMCOPIES = '份数:';
  BS_PRNDLG_COLLATE = '逐份打印';
  BS_PRNDLG_ALL = '全部';
  BS_PRNDLG_PAGES = '页面范围';
  BS_PRNDLG_SELECTION = '当前内容';
  BS_PRNDLG_FROM = '从:';
  BS_PRNDLG_TO = '到:';
  BS_PRNDLG_PRINTTOFILE = '打印到文件';
  BS_PRNDLG_ORIENTATION = '方向';
  BS_PRNDLG_PAPER = '纸张';
  BS_PRNDLG_PORTRAIT = '横向';
  BS_PRNDLG_LANDSCAPE = '纵向';
  BS_PRNDLG_SOURCE = '纸张来源:';
  BS_PRNDLG_SIZE = '纸型:';
  BS_PRNDLG_MARGINS = '页边距 (毫米)';
  BS_PRNDLG_MARGINS_INCHES = '页边距 (英寸)';
  BS_PRNDLG_LEFT = '左:';
  BS_PRNDLG_RIGHT = '右:';
  BS_PRNDLG_TOP = '上:';
  BS_PRNDLG_BOTTOM = '下:';
  BS_PRNDLG_WARNING = '系统中没有安装打印机!';
  BS_FIND_NEXT = '查找下一处';
  BS_FIND_WHAT = '查找内容:';
  BS_FIND_DIRECTION = '方向';
  BS_FIND_DIRECTIONUP = '向上';
  BS_FIND_DIRECTIONDOWN = '向下';
  BS_FIND_MATCH_CASE = '区分大小写';
  BS_FIND_MATCH_WHOLE_WORD_ONLY = '全字匹配';
  BS_FIND_REPLACE_WITH = '替换为:';
  BS_FIND_REPLACE = '替换';
  BS_FIND_REPLACE_All = '全部替换';
  
  BS_MORECOLORS = '更多颜色...';
  BS_AUTOCOLOR = '自动的颜色';

implementation

end.