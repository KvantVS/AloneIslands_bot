object Form1: TForm1
  Left = 192
  Top = 113
  Caption = 'AloneIslands'
  ClientHeight = 542
  ClientWidth = 824
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 824
    Height = 29
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 658
      Top = 7
      Width = 35
      Height = 15
      Caption = #1057#1058#1054#1055
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label2: TLabel
      Left = 698
      Top = 8
      Width = 130
      Height = 13
      Caption = #1041#1056#1040#1059#1047#1045#1056' '#1053#1045#1044#1054#1057#1058#1059#1055#1045#1053
      Visible = False
    end
    object Bevel1: TBevel
      Left = 345
      Top = 6
      Width = 50
      Height = 16
      Shape = bsLeftLine
    end
    object ComboBox1: TComboBox
      Left = 454
      Top = 4
      Width = 16
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 11
      OnChange = ComboBox1Change
      OnCloseUp = ComboBox1CloseUp
      OnDropDown = ComboBox1DropDown
      OnMouseEnter = ComboBox1MouseEnter
      OnMouseLeave = ComboBox1MouseLeave
      Items.Strings = (
        #1043#1086#1088#1086#1076#1089#1082#1080#1077' '#1074#1086#1088#1086#1090#1072
        #1051#1072#1074#1082#1072' '#1052#1077#1090#1088#1086#1087#1086#1083#1080#1089#1072
        #1040#1088#1077#1085#1072
        #1061#1088#1072#1084
        #1059#1085#1080#1074#1077#1088#1089#1080#1090#1077#1090
        #1054#1073#1077#1083#1080#1089#1082
        #1052#1072#1089#1090#1077#1088#1089#1082#1072#1103
        '--------'
        #1054#1079#1077#1088#1086' '#1052#1080#1088#1101#1083
        #1058#1105#1084#1085#1099#1081' '#1087#1088#1091#1076)
    end
    object btn_stop: TButton
      Left = 598
      Top = 4
      Width = 57
      Height = 21
      Caption = #1057#1090#1086#1087
      TabOrder = 2
      OnClick = btn_stopClick
    end
    object Edit1: TEdit
      Left = 4
      Top = 4
      Width = 177
      Height = 21
      TabOrder = 0
      Text = 'http://195.242.161.132/'
      OnKeyPress = Edit1KeyPress
    end
    object Button2: TButton
      Left = 184
      Top = 4
      Width = 75
      Height = 21
      Caption = #1055#1077#1088#1077#1081#1090#1080' -->'
      TabOrder = 1
      OnClick = Button2Click
    end
    object btn_Fishing: TButton
      Left = 531
      Top = 4
      Width = 57
      Height = 21
      Caption = #1056#1099#1073#1072#1083#1082#1072
      Enabled = False
      TabOrder = 3
      OnClick = btn_FishingClick
    end
    object chk_Frame: TCheckBox
      Left = 262
      Top = 6
      Width = 77
      Height = 17
      Caption = #1042#1086' '#1092#1088#1101#1081#1084#1077
      TabOrder = 4
      OnClick = chk_FrameClick
    end
    object cmb_Frame: TComboBox
      Left = 277
      Top = 4
      Width = 65
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      Visible = False
    end
    object btn_Automove: TButton
      Left = 472
      Top = 4
      Width = 55
      Height = 21
      Caption = #1040#1074#1090#1086#1093#1086#1076
      Enabled = False
      TabOrder = 6
      OnClick = btn_AutomoveClick
    end
    object LabeledEditX: TLabeledEdit
      Left = 363
      Top = 4
      Width = 25
      Height = 21
      EditLabel.Width = 10
      EditLabel.Height = 13
      EditLabel.Caption = 'X:'
      LabelPosition = lpLeft
      TabOrder = 7
      Text = '0'
    end
    object UpDown1: TUpDown
      Left = 388
      Top = 4
      Width = 12
      Height = 21
      Associate = LabeledEditX
      Min = -200
      Max = 200
      TabOrder = 8
    end
    object LabeledEditY: TLabeledEdit
      Left = 416
      Top = 4
      Width = 25
      Height = 21
      EditLabel.Width = 10
      EditLabel.Height = 13
      EditLabel.Caption = 'Y:'
      LabelPosition = lpLeft
      TabOrder = 9
      Text = '0'
    end
    object UpDown2: TUpDown
      Left = 441
      Top = 4
      Width = 12
      Height = 21
      Associate = LabeledEditY
      Min = -200
      Max = 200
      TabOrder = 10
    end
  end
  object WB1: TWebBrowser
    Left = 0
    Top = 29
    Width = 824
    Height = 494
    Align = alClient
    TabOrder = 0
    OnBeforeNavigate2 = WB1BeforeNavigate2
    OnDocumentComplete = WB1DocumentComplete
    ExplicitLeft = -8
    ExplicitTop = 23
    ControlData = {
      4C0000002A5500000E3300000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620A000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Memo1: TMemo
    Left = 20
    Top = 35
    Width = 685
    Height = 89
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 3
    Visible = False
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 523
    Width = 824
    Height = 19
    Panels = <
      item
        Width = 750
      end
      item
        Style = psOwnerDraw
        Width = 50
      end>
    OnDblClick = StatusBar1DblClick
    OnDrawPanel = StatusBar1DrawPanel
  end
  object Button1: TButton
    Left = 760
    Top = 65
    Width = 54
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    Visible = False
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 747
    Top = 90
    Width = 67
    Height = 25
    Caption = 'Button3'
    TabOrder = 5
    Visible = False
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 743
    Top = 34
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 6
    Visible = False
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 749
    Top = 121
    Width = 75
    Height = 25
    Caption = 'Button5'
    TabOrder = 7
    Visible = False
    OnClick = Button5Click
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 230000
    OnTimer = Timer1Timer
    Left = 96
    Top = 128
  end
  object tmr_potion: TTimer
    Enabled = False
    OnTimer = tmr_potionTimer
    Left = 96
    Top = 172
  end
  object MainMenu1: TMainMenu
    Left = 36
    Top = 128
    object menu_game: TMenuItem
      Caption = #1048#1075#1088#1072
      object menu_actions_fishlog: TMenuItem
        Caption = #1046#1091#1088#1085#1072#1083' '#1088#1099#1073#1072#1083#1082#1080
        ShortCut = 16458
        OnClick = menu_actions_fishlogClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object menu_game_exit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = menu_game_exitClick
      end
    end
    object menu_actions: TMenuItem
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      object menu_actions_fishing: TMenuItem
        Caption = #1056#1099#1073#1072#1083#1082#1072
        Enabled = False
        OnClick = menu_actions_fishingClick
      end
      object menu_avtohod: TMenuItem
        Caption = #1040#1074#1090#1086#1093#1086#1076
        OnClick = menu_avtohodClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object menu_stop: TMenuItem
        Caption = #1057#1090#1086#1087
        Enabled = False
        OnClick = menu_stopClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object menu_actions_giveByOne: TMenuItem
        Caption = #1057#1076#1072#1074#1072#1090#1100' '#1087#1086' 1-'#1081' '#1088#1099#1073#1077
        OnClick = menu_actions_giveByOneClick
      end
    end
    object menu_settings: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      OnClick = menu_settingsClick
    end
    object menu_tools: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      object menu_tools_notepad: TMenuItem
        Caption = #1041#1083#1086#1082#1085#1086#1090
        OnClick = menu_tools_notepadClick
      end
      object N2: TMenuItem
        Caption = #1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088' '#1087#1077#1088#1075#1072#1084#1077#1085#1090#1086#1074
        ShortCut = 16459
        OnClick = N2Click
      end
    end
  end
  object tmr_SchityvanieRyby: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = tmr_SchityvanieRybyTimer
    Left = 96
    Top = 216
  end
  object XPManifest1: TXPManifest
    Left = 36
    Top = 172
  end
  object tmr_waiter: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmr_waiterTimer
    Left = 136
    Top = 128
  end
end
