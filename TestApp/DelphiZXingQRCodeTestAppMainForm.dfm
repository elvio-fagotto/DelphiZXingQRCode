object Form1: TForm1
  Left = 247
  Top = 144
  Width = 550
  Height = 321
  Caption = 'Delphi port of ZXing QRCode'
  Color = clBtnFace
  Constraints.MinHeight = 320
  Constraints.MinWidth = 550
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    534
    282)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 13
    Width = 22
    Height = 13
    Caption = 'Text'
  end
  object Label2: TLabel
    Left = 8
    Top = 69
    Width = 43
    Height = 13
    Caption = 'Encoding'
  end
  object Label3: TLabel
    Left = 184
    Top = 69
    Width = 52
    Height = 13
    Caption = 'Quiet zone'
  end
  object Label4: TLabel
    Left = 296
    Top = 13
    Width = 38
    Height = 13
    Caption = 'Preview'
  end
  object PaintBox1: TPaintBox
    Left = 296
    Top = 32
    Width = 230
    Height = 242
    Anchors = [akLeft, akTop, akRight, akBottom]
    OnPaint = PaintBox1Paint
  end
  object Label5: TLabel
    Left = 8
    Top = 117
    Width = 100
    Height = 13
    Caption = 'Error correction level'
  end
  object edtText: TEdit
    Left = 8
    Top = 32
    Width = 265
    Height = 21
    TabOrder = 0
    Text = 'Hello world'
    OnChange = edtTextChange
  end
  object cmbEncoding: TComboBox
    Left = 8
    Top = 88
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'Auto'
    OnChange = cmbEncodingChange
    Items.Strings = (
      'Auto'
      'Numeric'
      'Alphanumeric'
      'ISO-8859-1'
      'UTF-8 without BOM'
      'UTF-8 with BOM')
  end
  object edtQuietZone: TEdit
    Left = 184
    Top = 88
    Width = 89
    Height = 21
    TabOrder = 2
    Text = '4'
    OnChange = edtQuietZoneChange
  end
  object cmbCorrectionError: TComboBox
    Left = 8
    Top = 136
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    Text = 'Low'
    OnChange = cmbEncodingChange
    Items.Strings = (
      'Low'
      'Medium'
      'Quartil'
      'High')
  end
  object frmStorage: TFormStorage
    Options = [fpPosition]
    UseRegistry = False
    StoredProps.Strings = (
      'cmbCorrectionError.ItemIndex'
      'cmbEncoding.ItemIndex'
      'edtQuietZone.Text'
      'edtText.Text')
    StoredValues = <>
    Left = 16
    Top = 168
  end
end
