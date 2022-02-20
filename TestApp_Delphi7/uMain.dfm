object frmMain: TfrmMain
  Left = 422
  Top = 262
  Width = 550
  Height = 355
  Caption = 'Delphi port of ZXing QRCode'
  Color = clBtnFace
  Constraints.MinHeight = 355
  Constraints.MinWidth = 550
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCanResize = FormCanResize
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    534
    316)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 4
    Width = 27
    Height = 14
    Caption = 'Text'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 10
    Top = 52
    Width = 94
    Height = 14
    Caption = 'Encoding mode'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 10
    Top = 100
    Width = 66
    Height = 14
    Caption = 'Quiet zone'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 298
    Top = 52
    Width = 48
    Height = 14
    Caption = 'Preview'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 154
    Top = 52
    Width = 127
    Height = 14
    Caption = 'Error correction level'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 154
    Top = 100
    Width = 93
    Height = 14
    Caption = 'Scale image file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 434
    Top = 4
    Width = 44
    Height = 14
    Anchors = [akTop, akRight]
    Caption = 'Length'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtText: TEdit
    Left = 8
    Top = 19
    Width = 417
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    OEMConvert = True
    ParentFont = False
    TabOrder = 0
    Text = 'Hello world'
    OnChange = edtTextChange
    OnKeyPress = edtScaleKeyPress
  end
  object cmbEncoding: TComboBox
    Left = 8
    Top = 67
    Width = 137
    Height = 24
    AutoDropDown = True
    AutoCloseUp = True
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 16
    ItemIndex = 0
    ParentFont = False
    TabOrder = 2
    Text = 'Auto'
    OnChange = edtTextChange
    OnKeyPress = edtScaleKeyPress
    Items.Strings = (
      'Auto'
      'Numeric'
      'Alphanumeric'
      'ISO-8859-1'
      'UTF-8 without BOM'
      'UTF-8 with BOM')
  end
  object cmbErrorCorrection: TComboBox
    Left = 152
    Top = 67
    Width = 137
    Height = 24
    AutoDropDown = True
    AutoCloseUp = True
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 16
    ItemIndex = 0
    ParentFont = False
    TabOrder = 3
    Text = '(L)ow 7%'
    OnChange = edtTextChange
    OnKeyPress = edtScaleKeyPress
    Items.Strings = (
      '(L)ow 7%'
      '(M)edium 15%'
      '(Q)uartil 25%'
      '(H)igh 30%')
  end
  object btnSave: TButton
    Left = 8
    Top = 255
    Width = 75
    Height = 35
    Anchors = [akLeft, akBottom]
    Caption = 'Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btnSaveClick
  end
  object stat1: TStatusBar
    Left = 0
    Top = 297
    Width = 534
    Height = 19
    Panels = <>
  end
  object edtQuietZone: TCurrencyEdit
    Left = 8
    Top = 115
    Width = 137
    Height = 24
    DecimalPlaces = 0
    DisplayFormat = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 2
    MaxValue = 99.000000000000000000
    ParentFont = False
    TabOrder = 4
    Value = 4.000000000000000000
    OnChange = edtTextChange
    OnKeyPress = edtScaleKeyPress
  end
  object edtScale: TCurrencyEdit
    Left = 152
    Top = 115
    Width = 137
    Height = 24
    DisplayFormat = '0.00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 5
    MaxValue = 99.000000000000000000
    MinValue = 1.000000000000000000
    ParentFont = False
    TabOrder = 5
    Value = 1.000000000000000000
    OnKeyPress = edtScaleKeyPress
  end
  object edtLength: TCurrencyEdit
    Left = 432
    Top = 19
    Width = 89
    Height = 24
    TabStop = False
    DecimalPlaces = 0
    DisplayFormat = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Anchors = [akTop, akRight]
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    OnChange = edtTextChange
    OnKeyPress = edtScaleKeyPress
  end
  object pnl1: TPanel
    Left = 296
    Top = 67
    Width = 225
    Height = 225
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 7
    object QRPaintBox: TPaintBox
      Left = 1
      Top = 1
      Width = 219
      Height = 219
      Align = alClient
      Color = clBtnFace
      ParentColor = False
      OnPaint = QRPaintBoxPaint
    end
  end
  object btnLoad: TButton
    Left = 88
    Top = 255
    Width = 75
    Height = 35
    Anchors = [akLeft, akBottom]
    Caption = 'Load'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = btnLoadClick
  end
  object frmStorage: TFormStorage
    UseRegistry = False
    OnSavePlacement = frmStorageSavePlacement
    OnRestorePlacement = frmStorageRestorePlacement
    StoredValues = <>
    Left = 192
    Top = 256
  end
  object dlgSave: TSaveDialog
    DefaultExt = '.bmp'
    Filter = 'Immagine BMP|*.bmp|Dati QR code|*.qr'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 256
    Top = 256
  end
  object dlgOpen: TOpenDialog
    DefaultExt = '*.qr'
    Filter = 'Dati QR code|*.qr'
    Left = 224
    Top = 256
  end
end
