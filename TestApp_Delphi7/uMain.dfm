object frmMain: TfrmMain
  Left = 247
  Top = 144
  Width = 550
  Height = 375
  Caption = 'Delphi port of ZXing QRCode'
  Color = clBtnFace
  Constraints.MinHeight = 375
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
    336)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 5
    Width = 26
    Height = 13
    Caption = 'Text'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 61
    Width = 50
    Height = 13
    Caption = 'Encoding'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 117
    Width = 60
    Height = 13
    Caption = 'Quiet zone'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 296
    Top = 61
    Width = 45
    Height = 13
    Caption = 'Preview'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object QRPaintBox: TPaintBox
    Left = 296
    Top = 80
    Width = 225
    Height = 225
    Anchors = [akLeft, akTop, akRight, akBottom]
    OnPaint = QRPaintBoxPaint
  end
  object Label5: TLabel
    Left = 152
    Top = 61
    Width = 119
    Height = 13
    Caption = 'Error correction level'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 152
    Top = 117
    Width = 88
    Height = 13
    Caption = 'Scale image file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 432
    Top = 5
    Width = 39
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Length'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtText: TEdit
    Left = 8
    Top = 24
    Width = 409
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'Hello world'
    OnChange = edtTextChange
  end
  object cmbEncoding: TComboBox
    Left = 8
    Top = 80
    Width = 129
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
    Text = 'Auto'
    OnChange = edtTextChange
    Items.Strings = (
      'Auto'
      'Numeric'
      'Alphanumeric'
      'ISO-8859-1'
      'UTF-8 without BOM'
      'UTF-8 with BOM')
  end
  object cmbCorrectionError: TComboBox
    Left = 152
    Top = 80
    Width = 129
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    Text = '(L)ow 7%'
    OnChange = edtTextChange
    Items.Strings = (
      '(L)ow 7%'
      '(M)edium 15%'
      '(Q)uartil 25%'
      '(H)igh 30%')
  end
  object btnSave: TButton
    Left = 8
    Top = 270
    Width = 75
    Height = 35
    Anchors = [akLeft, akBottom]
    Caption = 'Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btnSaveClick
  end
  object stat1: TStatusBar
    Left = 0
    Top = 317
    Width = 534
    Height = 19
    Panels = <>
  end
  object edtQuietZone: TCurrencyEdit
    Left = 8
    Top = 136
    Width = 129
    Height = 21
    DecimalPlaces = 0
    DisplayFormat = '0'
    MaxLength = 2
    MaxValue = 99.000000000000000000
    TabOrder = 4
    Value = 4.000000000000000000
    OnChange = edtTextChange
  end
  object edtScale: TCurrencyEdit
    Left = 152
    Top = 136
    Width = 129
    Height = 21
    DisplayFormat = '0.00'
    MaxLength = 5
    MaxValue = 99.000000000000000000
    MinValue = 1.000000000000000000
    TabOrder = 5
    Value = 1.000000000000000000
  end
  object edtLength: TCurrencyEdit
    Left = 432
    Top = 24
    Width = 89
    Height = 21
    TabStop = False
    DecimalPlaces = 0
    DisplayFormat = '0'
    Anchors = [akTop, akRight]
    ReadOnly = True
    TabOrder = 1
    OnChange = edtTextChange
  end
  object frmStorage: TFormStorage
    Options = [fpPosition]
    UseRegistry = False
    StoredProps.Strings = (
      'cmbCorrectionError.ItemIndex'
      'cmbEncoding.ItemIndex'
      'edtText.Text'
      'edtQuietZone.Text'
      'edtScale.Value')
    StoredValues = <>
    Left = 208
    Top = 272
  end
  object dlgSave: TSaveDialog
    DefaultExt = '.bmp'
    Filter = 'Bitmap|*.bmp'
    Left = 256
    Top = 272
  end
end
