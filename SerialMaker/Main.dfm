object SerialForm: TSerialForm
  Left = 263
  Top = 124
  BorderStyle = bsToolWindow
  Caption = 'Create A Serial Number'
  ClientHeight = 309
  ClientWidth = 279
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbA: TLabel
    Left = 8
    Top = 8
    Width = 37
    Height = 13
    Caption = 'Base A:'
  end
  object lbB: TLabel
    Left = 152
    Top = 8
    Width = 37
    Height = 13
    Caption = 'Base B:'
  end
  object lbRes: TLabel
    Left = 8
    Top = 96
    Width = 56
    Height = 13
    Caption = 'Result S/N:'
  end
  object lbUser: TLabel
    Left = 8
    Top = 53
    Width = 51
    Height = 13
    Caption = 'Username:'
  end
  object lbOrg: TLabel
    Left = 152
    Top = 52
    Width = 62
    Height = 13
    Caption = 'Organisation:'
  end
  object Label1: TLabel
    Left = 8
    Top = 136
    Width = 75
    Height = 13
    Caption = 'Expiration Date:'
  end
  object Label2: TLabel
    Left = 8
    Top = 176
    Width = 66
    Height = 13
    Caption = 'Info Filename:'
  end
  object edtA: TEdit
    Left = 16
    Top = 24
    Width = 121
    Height = 21
    MaxLength = 6
    TabOrder = 0
    Text = '000000'
  end
  object edtB: TEdit
    Left = 160
    Top = 24
    Width = 113
    Height = 21
    MaxLength = 6
    TabOrder = 1
    Text = '000000'
  end
  object edtRes: TEdit
    Left = 16
    Top = 112
    Width = 257
    Height = 21
    Color = clSilver
    ReadOnly = True
    TabOrder = 2
  end
  object btGenerate: TButton
    Left = 176
    Top = 247
    Width = 97
    Height = 25
    Caption = 'Generate'
    TabOrder = 3
    OnClick = btGenerateClick
  end
  object btQuit: TButton
    Left = 176
    Top = 280
    Width = 97
    Height = 25
    Caption = 'Quit'
    TabOrder = 4
    OnClick = btQuitClick
  end
  object btRand: TButton
    Left = 88
    Top = 217
    Width = 81
    Height = 25
    Caption = 'Random Bases'
    TabOrder = 5
    OnClick = btRandClick
  end
  object edtUser: TEdit
    Left = 16
    Top = 68
    Width = 121
    Height = 21
    TabOrder = 6
  end
  object edtOrg: TEdit
    Left = 160
    Top = 68
    Width = 113
    Height = 21
    TabOrder = 7
  end
  object btCheck: TButton
    Left = 8
    Top = 280
    Width = 163
    Height = 25
    Caption = 'Check Algorithm'
    TabOrder = 8
    OnClick = btCheckClick
  end
  object btRU: TButton
    Left = 8
    Top = 217
    Width = 73
    Height = 25
    Caption = 'Rnd U/O'
    TabOrder = 9
    OnClick = btRUClick
  end
  object btSave: TButton
    Left = 8
    Top = 247
    Width = 161
    Height = 25
    Caption = 'Save To File ...'
    TabOrder = 10
    OnClick = btSaveClick
  end
  object deDate: TJvDateEdit
    Left = 16
    Top = 152
    Width = 257
    Height = 21
    ButtonFlat = False
    TabOrder = 11
  end
  object edtInfo: TJvFilenameEdit
    Left = 16
    Top = 192
    Width = 257
    Height = 21
    AddQuotes = False
    Filter = 'Rich Text Files (*.rtf)|*.rtf'
    ButtonFlat = False
    TabOrder = 12
  end
  object SaveDialog: TSaveDialog
    Filter = 'Eduka+ Key Files (*.edkl)|*.edkl'
    Left = 248
    Top = 96
  end
  object aZIP: TJvZlibMultiple
    Left = 192
    Top = 104
  end
end
