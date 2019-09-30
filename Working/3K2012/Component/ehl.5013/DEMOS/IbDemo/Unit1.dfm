object Form1: TForm1
  Left = 234
  Top = 103
  Width = 647
  Height = 387
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 24
    Top = 64
    Width = 592
    Height = 276
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    HorzScrollBar.Tracking = True
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    VertScrollBar.Tracking = True
    OnGetCellParams = DBGridEh1GetCellParams
  end
  object Button1: TButton
    Left = 160
    Top = 8
    Width = 98
    Height = 25
    Caption = 'Apply Updates'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 268
    Top = 8
    Width = 98
    Height = 25
    Caption = 'Cancel Updates'
    TabOrder = 2
    OnClick = Button2Click
  end
  object DataSource1: TDataSource
    DataSet = mtPhoneList
    Left = 24
    Top = 32
  end
  object mtPhoneList: TMemTableEh
    Active = True
    CachedUpdates = True
    FieldDefs = <
      item
        Name = 'EMP_NO'
        DataType = ftAutoInc
      end
      item
        Name = 'FIRST_NAME'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'LAST_NAME'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PHONE_EXT'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'SALARY'
        DataType = ftFloat
      end
      item
        Name = 'JOB_CODE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'JOB_GRADE'
        DataType = ftSmallint
      end
      item
        Name = 'JOB_COUNTRY'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'DEPT_NO'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'LOCATION'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'PHONE_NO'
        DataType = ftString
        Size = 20
      end>
    Params = <>
    DataDriver = BDEDataDriverIB
    Left = 58
    Top = 26
  end
  object BDEDataDriverIB: TBDEDataDriverEh
    DatabaseName = 'DBIB'
    SelectCommand.CommandText.Strings = (
      'SELECT'
      '    emp_no,'
      '    first_name,'
      '    last_name,'
      '    phone_ext,'
      '    SALARY,'
      '    JOB_CODE,'
      '    JOB_GRADE,'
      '    JOB_COUNTRY,'
      '    e.dept_no,'
      '    location,'
      '    phone_no'
      '    FROM employee e, department'
      '    WHERE employee.dept_no = department.dept_no')
    SelectCommand.Params = <>
    UpdateCommand.CommandText.Strings = (
      'update employee'
      'set'
      '  FIRST_NAME = :FIRST_NAME,'
      '  LAST_NAME = :LAST_NAME,'
      '  PHONE_EXT = :PHONE_EXT,'
      '  PHONE_EXT = :PHONE_EXT,'
      ' dept_no = :dept_no,'
      ' SALARY = :SALARY,'
      ' JOB_CODE = :JOB_CODE,'
      ' JOB_GRADE =  :JOB_GRADE,'
      ' JOB_COUNTRY = JOB_COUNTRY'
      'where'
      '  EMP_NO = :OLD_EMP_NO')
    UpdateCommand.Params = <
      item
        DataType = ftUnknown
        Name = 'FIRST_NAME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'LAST_NAME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PHONE_EXT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PHONE_EXT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'dept_no'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SALARY'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'JOB_CODE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'JOB_GRADE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_EMP_NO'
        ParamType = ptUnknown
      end>
    InsertCommand.CommandText.Strings = (
      'insert into employee'
      '  (EMP_NO, FIRST_NAME, LAST_NAME, PHONE_EXT, SALARY,'
      '  dept_no, JOB_CODE, JOB_GRADE, JOB_COUNTRY)'
      'values'
      
        '  (GEN_ID(EMP_NO_GEN, 0) , :FIRST_NAME, :LAST_NAME, :PHONE_EXT, ' +
        ':SALARY,'
      '  :dept_no, :JOB_CODE, :JOB_GRADE, :JOB_COUNTRY)')
    InsertCommand.Params = <
      item
        DataType = ftUnknown
        Name = 'FIRST_NAME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'LAST_NAME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'PHONE_EXT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SALARY'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'dept_no'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'JOB_CODE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'JOB_GRADE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'JOB_COUNTRY'
        ParamType = ptUnknown
      end>
    DeleteCommand.CommandText.Strings = (
      'delete from employee'
      'where'
      '  EMP_NO = :EMP_NO')
    DeleteCommand.Params = <
      item
        DataType = ftUnknown
        Name = 'EMP_NO'
        ParamType = ptUnknown
      end>
    GetrecCommand.CommandText.Strings = (
      'SELECT'
      
        '    emp_no, first_name, last_name, phone_ext, e.dept_no, locatio' +
        'n, phone_no,'
      '    SALARY,'
      '    JOB_CODE,'
      '    JOB_GRADE,'
      '    JOB_COUNTRY'
      '    FROM employee e, department'
      '    WHERE employee.dept_no = department.dept_no'
      '       and emp_no = :emp_no')
    GetrecCommand.Params = <
      item
        DataType = ftUnknown
        Name = 'emp_no'
        ParamType = ptUnknown
      end>
    SpecParams.Strings = (
      'GENERATOR=EMP_NO_GEN'
      'GENERATOR_FIELD=emp_no'
      'AUTO_INCREMENT_FIELD=emp_no')
    OnBuildDataStruct = BDEDataDriverIBBuildDataStruct
    OnUpdateRecord = BDEDataDriverIBUpdateRecord
    OnUpdateError = BDEDataDriverIBUpdateError
    Left = 90
    Top = 18
  end
  object Database1: TDatabase
    Connected = True
    DatabaseName = 'DBIB'
    DriverName = 'INTRBASE'
    LoginPrompt = False
    Params.Strings = (
      
        'SERVER NAME=C:\Program Files\Common Files\Borland Shared\Data\em' +
        'ployee.gdb'
      'USER NAME=SYSDBA'
      'OPEN MODE=READ/WRITE'
      'SCHEMA CACHE SIZE=8'
      'LANGDRIVER='
      'SQLQRYMODE='
      'SQLPASSTHRU MODE=SHARED AUTOCOMMIT'
      'SCHEMA CACHE TIME=-1'
      'MAX ROWS=-1'
      'BATCH COUNT=200'
      'ENABLE SCHEMA CACHE=FALSE'
      'SCHEMA CACHE DIR='
      'ENABLE BCD=FALSE'
      'BLOBS TO CACHE=64'
      'BLOB SIZE=32'
      'WAIT ON LOCKS=FALSE'
      'COMMIT RETAIN=FALSE'
      'ROLE NAME='
      'PASSWORD=masterkey')
    SessionName = 'Default'
    Left = 120
    Top = 10
  end
end
