object frm_calc: Tfrm_calc
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088' '#1091#1084#1077#1085#1080#1081
  ClientHeight = 137
  ClientWidth = 311
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 32
    Width = 168
    Height = 13
    Caption = #1057#1082#1086#1083#1100#1082#1086' '#1091#1084#1077#1085#1080#1103' '#1085#1091#1078#1085#1086' '#1074#1099#1091#1095#1080#1090#1100':'
  end
  object Label2: TLabel
    Left = 0
    Top = 76
    Width = 309
    Height = 25
    Alignment = taCenter
    AutoSize = False
  end
  object Edit1: TEdit
    Left = 180
    Top = 29
    Width = 38
    Height = 21
    TabOrder = 0
    Text = '0'
    OnKeyPress = Edit1KeyPress
  end
  object Button1: TButton
    Left = 224
    Top = 28
    Width = 82
    Height = 23
    Caption = #1057#1095#1080#1090#1072#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
end
