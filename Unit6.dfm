object frm_settings: Tfrm_settings
  Left = 0
  Top = 0
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 297
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 80
    Top = 82
    Width = 36
    Height = 13
    Caption = #1044#1086#1084#1077#1085':'
  end
  object Label2: TLabel
    Left = 80
    Top = 143
    Width = 147
    Height = 13
    Caption = #1057#1087#1080#1089#1086#1082' '#1090#1086#1095#1077#1082' '#1076#1083#1103' '#1072#1074#1090#1086#1093#1086#1076#1072':'
  end
  object CheckBox1: TCheckBox
    Left = 80
    Top = 48
    Width = 209
    Height = 17
    Hint = 
      #1044#1083#1103' '#1092#1072#1081#1083#1072' '#1078#1091#1088#1085#1072#1083#1072' '#1088#1099#1073#1072#1083#1082#1080'. '#1052#1086#1078#1077#1090' '#1079#1072#1084#1077#1076#1083#1103#1090#1100' '#1079#1072#1087#1091#1089#1082' '#1087#1088#1086#1075#1088#1072#1084#1084#1099'. '#1044#1086#1089 +
      #1090#1072#1090#1086#1095#1085#1086' '#1086#1076#1080#1085' '#1088#1072#1079' '#1079#1072#1087#1091#1089#1090#1080#1090#1100' '#1082#1083#1080#1077#1085#1090' '#1089' '#1101#1090#1086#1081' '#1086#1087#1094#1080#1077#1081'.'
    Caption = #1057#1086#1074#1084#1077#1089#1090#1080#1084#1086#1089#1090#1100' '#1089#1086' '#1089#1090#1072#1088#1099#1084#1080' '#1074#1077#1088#1089#1080#1103#1084#1080
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 0
    OnClick = CheckBox1Click
  end
  object Edit1: TEdit
    Left = 122
    Top = 79
    Width = 167
    Height = 21
    Hint = 
      #1040#1076#1088#1077#1089' '#1089#1072#1081#1090#1072', '#1080#1083#1080' IP-'#1072#1076#1088#1077#1089', '#1077#1089#1083#1080' '#1080#1075#1088#1072' '#1076#1086#1089#1090#1091#1087#1085#1072' '#1090#1086#1083#1100#1082#1086' '#1095#1077#1088#1077#1079' IP, '#1085 +
      #1072#1087#1088#1080#1084#1077#1088' http://195.242.161.132/'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Text = 'http://www.aloneislands.ru/'
  end
  object Button1: TButton
    Left = 80
    Top = 112
    Width = 209
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1078#1091#1088#1085#1072#1083' '#1088#1099#1073#1072#1083#1082#1080
    TabOrder = 2
    OnClick = Button1Click
  end
  object CheckListBox1: TCheckListBox
    Left = 80
    Top = 159
    Width = 209
    Height = 97
    ItemHeight = 13
    TabOrder = 3
  end
end
