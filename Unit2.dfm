object Form2: TForm2
  Left = 453
  Top = 324
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1088#1099#1073#1086#1083#1086#1074#1089#1090#1074#1072
  ClientHeight = 201
  ClientWidth = 254
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 68
    Top = 21
    Width = 100
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1055#1086#1081#1084#1072#1085#1086' '#1088#1099#1073#1099':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Trebuchet MS'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 68
    Top = 41
    Width = 100
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1041#1072#1085#1086#1082'/'#1089#1072#1087#1086#1075#1086#1074':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Trebuchet MS'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 68
    Top = 69
    Width = 100
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1053#1077#1090' '#1082#1083#1077#1074#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Trebuchet MS'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 68
    Top = 89
    Width = 100
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1056#1099#1073#1072' '#1089#1086#1088#1074#1072#1083#1072#1089#1100':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Trebuchet MS'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_fish: TLabel
    Left = 172
    Top = 21
    Width = 7
    Height = 14
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl_banki: TLabel
    Left = 172
    Top = 41
    Width = 7
    Height = 14
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl_noklev: TLabel
    Left = 172
    Top = 69
    Width = 7
    Height = 14
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl_nofish: TLabel
    Left = 172
    Top = 89
    Width = 7
    Height = 14
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 168
    Top = 138
    Width = 50
    Height = 4
    Shape = bsBottomLine
  end
  object lbl_Money: TLabel
    Left = 172
    Top = 142
    Width = 25
    Height = 14
    Caption = '0 LN'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 68
    Top = 117
    Width = 100
    Height = 20
    Alignment = taRightJustify
    AutoSize = False
    Caption = #1042#1099#1087#1080#1090#1086' '#1079#1077#1083#1080#1081':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Trebuchet MS'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_potion: TLabel
    Left = 172
    Top = 117
    Width = 7
    Height = 14
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 172
    Top = 168
    Width = 69
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 168
    Width = 73
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 1
    OnClick = Button2Click
  end
end
