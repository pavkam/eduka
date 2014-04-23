object Dialog_Select_Language: TDialog_Select_Language
  Left = 285
  Top = 115
  HelpContext = 330
  BorderStyle = bsToolWindow
  Caption = 'Select Language'
  ClientHeight = 296
  ClientWidth = 198
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
  OnMouseMove = ButtonDefaultsMove
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Language_Box: TJvDotNetListBox
    Left = 8
    Top = 24
    Width = 185
    Height = 241
    HelpContext = 330
    Style = lbOwnerDrawFixed
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvRaised
    Color = clMedGray
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ItemHeight = 22
    ParentFont = False
    TabOrder = 0
    OnClick = Language_BoxClick
    OnContextPopup = HelpContextPopup
    OnKeyPress = Language_BoxKeyPress
    OnMouseMove = ButtonDefaultsMove
  end
  object Sel_Lang_OK: TJvStaticText
    Left = 24
    Top = 271
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
    TabOrder = 1
    TextMargins.X = 0
    TextMargins.Y = 0
    WordWrap = False
    OnClick = Sel_Lang_OKClick
    OnContextPopup = HelpContextPopup
    OnMouseMove = button_MouseMove
  end
  object Sel_Lang_Cancel: TJvStaticText
    Left = 104
    Top = 271
    Width = 73
    Height = 22
    HelpContext = 1001
    Alignment = taCenter
    AutoSize = False
    Caption = 'Cancel'
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
    TabOrder = 2
    TextMargins.X = 0
    TextMargins.Y = 0
    WordWrap = False
    OnClick = Sel_Lang_CancelClick
    OnContextPopup = HelpContextPopup
    OnMouseMove = button_MouseMove
  end
  object Language_Available_List: TJvStaticText
    Left = 8
    Top = 3
    Width = 185
    Height = 17
    HelpContext = 330
    Alignment = taCenter
    AutoSize = False
    Caption = 'Available Files:'
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
    Layout = tlTop
    ParentFont = False
    TabOrder = 3
    TextMargins.X = 0
    TextMargins.Y = 0
    WordWrap = False
    OnContextPopup = HelpContextPopup
    OnMouseMove = ButtonDefaultsMove
  end
  object Context_Help: TJvPopupMenu
    Images = ImageList
    ImageMargin.Left = 0
    ImageMargin.Top = 0
    ImageMargin.Right = 0
    ImageMargin.Bottom = 0
    ImageSize.Height = 0
    ImageSize.Width = 0
    Style = msXP
    Left = 8
    Top = 264
    object Help_Q: TMenuItem
      Caption = 'What Is This ?'
      ImageIndex = 0
      OnClick = Help_QClick
    end
  end
  object ImageList: TJvImageList
    Left = 40
    Top = 264
    Bitmap = {
      494C010101000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000095959500D5D5D50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEEFF500ADDA
      E800757575004C4C4C000000000004040400040404001F1F1F0055555500A5A5
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEEFF500DEEF
      F500DEEFF500CFE9F100D2E8EF00D6ECF300D4ECF200CEE7EE00AECFD8005B76
      7E002B2B2B00BABABA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEEFF500DEEF
      F500DAEEF400DCEFF400DCEFF400DCEFF40000000000E6F4F700D6ECF300D1EA
      F100B6D5DE0014151500A5A5A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D9D9D90000000000E0EEF200DEEF
      F500DFF0F600E0F1F600E2F2F6000000000089929500DFEFF500DAEEF400D6EC
      F300D1EAF100C6E1E90000000000D9D9D9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000656565009BBEC800DEEFF500E2F2
      F600E4F3F600E7F4F800E7F4F800CDD9DC00E4EDEF00E6F3F700DEEFF500DAEE
      F400D6ECF300D1EAF10094BAC500656565000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001B1B1B00D9ECF100E2F2F600E5F3
      F700EAF5F800EBF6F900EDF6F9008F969800D3D6D600F9FCFD00E4F2F600DEEF
      F500D7EDF300D2EBF200CDE6ED001B1B1B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DFF0F600E4F3F600EAF5
      F800EDF6F900F0F8FA00F1F9FB003031320031333300EAEBEC00F8FCFC00DFF0
      F600DAEEF400D4ECF200D1EAF100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001B1B1B00DCEDF300E7F4F800EBF6
      F900F0F8FA00F5FAFB00F8FBFD00DEE1E100191A1A003D3E3E00FEFEFE00E0F1
      F600DCEFF400D6ECF300CDE6ED001B1B1B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000065656500A0C1CB00E7F4F800EDF6
      F900F1F9FB00F8FBFD0090909000D7D8D8003F3F3F0008080800F1F8FB00E2F2
      F600DCEFF400D6ECF30095BAC500656565000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D9D9D90000000000D9EAF000EBF6
      F900F0F8FA00F5FAFB0035363600060606001112120082888A00E7F4F800E0F1
      F600DCEFF400CAE3EA0000000000D9D9D9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5A5A50016171700CAE0
      E700EDF6F900F0F8FA00F1F9FB00F0F8FA00EDF6F900EAF5F800E4F3F600DFF0
      F600BDD9E10015161600A5A5A500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BABABA002B2B
      2B00607C8500C1DAE200E6F2F600EAF5F800E8F4F800E0F0F400BAD6DE005E79
      81002B2B2B00BABABA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A5A5A500555555001F1F1F0004040400040404001F1F1F0055555500A5A5
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FFFF000000000000
      03FF000000000000800F00000000000080030000000000008081000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008001000000000000
      C003000000000000F00F00000000000000000000000000000000000000000000
      000000000000}
  end
end