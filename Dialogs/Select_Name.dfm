object Dialog_Select_Name: TDialog_Select_Name
  Left = 460
  Top = 264
  HelpContext = 331
  BorderStyle = bsToolWindow
  Caption = 'Type Procedure Name'
  ClientHeight = 64
  ClientWidth = 224
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnContextPopup = HelpContextPopup
  OnCreate = FormCreate
  OnMouseMove = DefaultMouseMove
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Sel_Name_OK: TJvStaticText
    Left = 80
    Top = 40
    Width = 73
    Height = 22
    HelpContext = 1000
    Alignment = taCenter
    AutoSize = False
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Tahoma'
    HotTrackFont.Style = []
    Layout = tlCenter
    ParentFont = False
    TabOrder = 0
    TextMargins.X = 0
    TextMargins.Y = 0
    WordWrap = False
    OnClick = Sel_Name_OKClick
    OnContextPopup = HelpContextPopup
    OnMouseMove = button_MouseMove
  end
  object Select_Name_Edit: TComboBox
    Left = 8
    Top = 16
    Width = 209
    Height = 21
    HelpContext = 331
    Color = clMedGray
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ItemHeight = 13
    ParentFont = False
    PopupMenu = Context_Help
    TabOrder = 1
    Text = '<Name>'
    OnContextPopup = HelpContextPopup
    OnDropDown = Select_Name_EditDropDown
    OnKeyPress = Select_Name_EditKeyPress
  end
  object Context_Help: TJvPopupMenu
    ImageMargin.Left = 0
    ImageMargin.Top = 0
    ImageMargin.Right = 0
    ImageMargin.Bottom = 0
    ImageSize.Height = 0
    ImageSize.Width = 0
    Left = 640
    Top = 168
    object Help_Q: TMenuItem
      Caption = 'What Is This ?'
      OnClick = Help_QClick
    end
  end
end
