object Form1: TForm1
  Left = 271
  Top = 300
  Width = 674
  Height = 543
  Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1054#1053#1050' '#1087#1086' '#1072#1083#1075#1086#1088#1080#1090#1084#1091' '#1061#1072#1092#1092#1084#1077#1085#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 238
    Height = 45
    Caption = 
      #1058#1072#1073#1083#1080#1094#1072' '#1089#1080#1084#1074#1086#1083#1086#1074' '#1080' '#1074#1077#1088#1086#1103#1090#1085#1086#1089#1090#1100' '#1080#1093' '#1087#1086#1103#1074#1083#1077#1085#1080#1103' '#1074' '#1089#1090#1088#1086#1082#1077', '#1079#1072#1087#1080#1089#1072#1085#1085#1099#1077 +
      ' '#1087#1086' '#1091#1073#1099#1074#1072#1085#1080#1102'('#1076#1083#1103' 8 '#1089#1080#1084#1074#1086#1083#1086#1074')'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    ParentFont = False
    WordWrap = True
  end
  object Label3: TLabel
    Left = 8
    Top = 352
    Width = 154
    Height = 15
    Caption = #1058#1077#1082#1089#1090' '#1076#1083#1103' '#1082#1086#1076#1080#1088#1086#1074#1072#1085#1080#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 16
    Top = 376
    Width = 147
    Height = 15
    Caption = #1047#1072#1082#1086#1076#1080#1088#1086#1074#1072#1085#1085#1099#1081' '#1090#1077#1082#1089#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 536
    Top = 296
    Width = 105
    Height = 45
    Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077': '#1082#1086#1083'-'#1074#1086'      '#1073#1091#1082#1074' '#1084#1077#1085#1100#1096#1077' 100'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    ParentFont = False
    WordWrap = True
  end
  object Label5: TLabel
    Left = 16
    Top = 440
    Width = 147
    Height = 15
    Caption = #1044#1077#1082#1086#1076#1080#1088#1086#1074#1072#1085#1085#1099#1081' '#1090#1077#1082#1089#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 56
    Width = 369
    Height = 233
    ColCount = 3
    FixedCols = 0
    RowCount = 9
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentFont = False
    TabOrder = 0
    OnKeyPress = StringGrid1KeyPress
    ColWidths = (
      49
      119
      195)
  end
  object Button1: TButton
    Left = 8
    Top = 296
    Width = 105
    Height = 33
    Caption = #1055#1086#1080#1089#1082
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 264
    Top = 16
    Width = 89
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1088
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 120
    Top = 296
    Width = 129
    Height = 33
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 3
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 168
    Top = 344
    Width = 481
    Height = 23
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 4
  end
  object Memo1: TMemo
    Left = 168
    Top = 376
    Width = 481
    Height = 57
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 5
  end
  object Button4: TButton
    Left = 8
    Top = 400
    Width = 153
    Height = 33
    Caption = #1047#1072#1082#1086#1076#1080#1088#1086#1074#1072#1090#1100
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 6
    OnClick = Button4Click
  end
  object GroupBox1: TGroupBox
    Left = 384
    Top = 8
    Width = 265
    Height = 281
    Caption = #1044#1077#1088#1077#1074#1086' '#1101#1083#1077#1084#1077#1085#1090#1086#1074
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 7
    object TreeView1: TTreeView
      Left = 8
      Top = 24
      Width = 249
      Height = 249
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = [fsItalic]
      Indent = 19
      ParentFont = False
      TabOrder = 0
    end
  end
  object Button5: TButton
    Left = 256
    Top = 296
    Width = 153
    Height = 33
    Caption = #1047#1072#1076#1072#1090#1100' '#1082#1086#1083'-'#1074#1086' '#1073#1091#1082#1074
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 8
    OnClick = Button5Click
  end
  object Edit2: TEdit
    Left = 416
    Top = 296
    Width = 113
    Height = 33
    AutoSize = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 9
  end
  object Memo2: TMemo
    Left = 168
    Top = 440
    Width = 481
    Height = 57
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 10
  end
  object Button6: TButton
    Left = 8
    Top = 464
    Width = 153
    Height = 33
    Caption = #1044#1077#1082#1086#1076#1080#1088#1086#1074#1072#1090#1100
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 11
    OnClick = Button6Click
  end
end
