object Form3: TForm3
  Left = 149
  Top = 91
  AlphaBlend = True
  AlphaBlendValue = 220
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1046#1091#1088#1085#1072#1083' '#1088#1099#1073#1072#1083#1082#1080
  ClientHeight = 416
  ClientWidth = 738
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 381
    Width = 738
    Height = 35
    Align = alBottom
    TabOrder = 0
    object lbl_price: TLabel
      Left = 340
      Top = 4
      Width = 3
      Height = 13
    end
    object lbl_mass: TLabel
      Left = 390
      Top = 4
      Width = 3
      Height = 13
    end
    object Label1: TLabel
      Left = 212
      Top = 9
      Width = 48
      Height = 13
      Caption = #1042#1099#1073#1088#1072#1085#1086':'
    end
    object lbl_selected: TLabel
      Left = 265
      Top = 9
      Width = 3
      Height = 13
    end
    object Label3: TLabel
      Left = 10
      Top = 9
      Width = 47
      Height = 13
      Caption = #1042#1099#1073#1088#1072#1090#1100':'
    end
    object btn_Close: TButton
      Left = 658
      Top = 6
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Default = True
      TabOrder = 0
      OnClick = btn_CloseClick
    end
    object btn_stat: TButton
      Left = 574
      Top = 6
      Width = 75
      Height = 25
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
      TabOrder = 1
      OnClick = btn_statClick
    end
    object btn_Del: TButton
      Left = 509
      Top = 6
      Width = 59
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 2
      OnClick = btn_DelClick
    end
    object ComboBox1: TComboBox
      Left = 61
      Top = 6
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnChange = ComboBox1Change
      Items.Strings = (
        #1042#1077#1097#1080
        #1056#1099#1073#1091)
    end
  end
  object LV_FishLog: TListView
    Left = 0
    Top = 0
    Width = 738
    Height = 381
    Align = alClient
    Columns = <
      item
        Caption = #1044#1072#1090#1072', '#1074#1088#1077#1084#1103
        Width = 120
      end
      item
        AutoSize = True
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      end
      item
        Caption = #1056#1072#1079#1084#1077#1088#1085#1086#1089#1090#1100
        Width = 120
      end
      item
        Caption = #1062#1077#1085#1072
      end
      item
        Caption = #1052#1072#1089#1089#1072
      end
      item
        AutoSize = True
        Caption = #1055#1088#1080#1084#1072#1085#1082#1072
      end
      item
        Caption = #1058#1080#1087
      end>
    GridLines = True
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    ParentShowHint = False
    PopupMenu = PopupMenu1
    ShowHint = False
    TabOrder = 1
    ViewStyle = vsReport
    OnClick = LV_FishLogClick
    OnColumnClick = LV_FishLogColumnClick
    OnCompare = LV_FishLogCompare
    OnKeyPress = LV_FishLogKeyPress
    OnSelectItem = LV_FishLogSelectItem
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 4
    Top = 24
    object popup_selectFishName: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102
      Enabled = False
      OnClick = popup_selectFishNameClick
    end
    object popup_selectWeight: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1087#1086' '#1088#1072#1079#1084#1077#1088#1085#1086#1089#1090#1080
      Enabled = False
      OnClick = popup_selectWeightClick
    end
    object N1: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077
      ShortCut = 16449
      OnClick = N1Click
    end
  end
end
