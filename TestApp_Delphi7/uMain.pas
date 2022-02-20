unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DelphiZXingQRCode, ExtCtrls,
  StdCtrls, rxPlacemnt, ComCtrls, Mask, rxToolEdit, rxCurrEdit;

type
  TfrmMain = class(TForm)
    edtText: TEdit;
    Label1: TLabel;
    cmbEncoding: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    QRPaintBox: TPaintBox;
    frmStorage: TFormStorage;
    cmbErrorCorrection: TComboBox;
    Label5: TLabel;
    dlgSave: TSaveDialog;
    btnSave: TButton;
    Label6: TLabel;
    stat1: TStatusBar;
    edtQuietZone: TCurrencyEdit;
    edtScale: TCurrencyEdit;
    Label7: TLabel;
    edtLength: TCurrencyEdit;
    pnl1: TPanel;
    btnLoad: TButton;
    dlgOpen: TOpenDialog;
    procedure FormDestroy(Sender: TObject);
    procedure QRPaintBoxPaint(Sender: TObject);
    procedure edtTextChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure edtScaleKeyPress(Sender: TObject; var Key: Char);
    procedure btnLoadClick(Sender: TObject);
    procedure frmStorageRestorePlacement(Sender: TObject);
    procedure frmStorageSavePlacement(Sender: TObject);
  protected
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
  private
    QRCodeBitmap: TBitmap;
  public
    procedure Generate(QRBitmap: TBitmap; QRText: WideString; ErrorCorrectionLevel, Encoding, QuietZone: Integer);
    procedure QRUpdate(Sender: TObject);
    procedure QRSaveToFile(FileName: PAnsiChar; QRText: WideString; ErrorCorrectionLevel, Encoding, QuietZone: Integer; Scale: Double = 1.0);
    procedure ResizeBitmap(QRBitmap: TBitmap; Scale: Double = 1.0);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  IniFiles, WcBase64;

const
  Numeric      = 7089;
  Alphanumeric = 4296;

  Data_Text    = 'Text';
  Data_Param   = 'Parameter';
  Section      = 'QRData';
  Ident_1      = 'Text';
  Ident_2      = 'EncodingMode';
  Ident_3      = 'ErrorCorrectionLevel';
  Ident_4      = 'QuietZone';
  Ident_5      = 'ScaleImageFile';


procedure TfrmMain.CMDialogKey(var Message: TCMDialogKey);
begin
  if Message.CharCode=VK_RETURN then
    Message.CharCode := VK_TAB;
  inherited;
end;


procedure TfrmMain.Generate(QRBitmap: TBitmap; QRText: WideString; ErrorCorrectionLevel, Encoding, QuietZone: Integer);
var
  QRCode: TDelphiZXingQRCode;
  Row, Column: Integer;
begin
  if(Assigned(QRBitmap))then
  begin
    QRCode := TDelphiZXingQRCode.Create;
    try
      QRCode.Data := QRText;
      QRCode.ErrorCorrectionLevel := ErrorCorrectionLevel;
      QRCode.Encoding := TQRCodeEncoding(Encoding);
      QRCode.QuietZone := QuietZone;
      QRBitmap.Height := QRCode.Rows;
      QRBitmap.Width := QRCode.Columns;
      for Row := 0 to QRCode.Rows - 1 do
      begin
        for Column := 0 to QRCode.Columns - 1 do
        begin
          if(QRCode.IsBlack[Row, Column])then
            QRBitmap.Canvas.Pixels[Column, Row] := clBlack
          else
            QRBitmap.Canvas.Pixels[Column, Row] := clWhite;
        end;
      end;
    finally
      QRCode.Free;
    end;
  end;
end;


procedure TfrmMain.QRSaveToFile(FileName: PAnsiChar; QRText: WideString; ErrorCorrectionLevel, Encoding, QuietZone: Integer; Scale: Double = 1.0);
var
  QRBitmap: TBitmap;
begin
  QRBitmap := TBitmap.Create;
  try
    Generate(QRBitmap, QRText, ErrorCorrectionLevel, Encoding, QuietZone);
    ResizeBitmap(QRBitmap, Scale);
    QRBitmap.SaveToFile(FileName);
  finally
    QRBitmap.Free;
  end;
end;

procedure TfrmMain.ResizeBitmap(QRBitmap: TBitmap; Scale: Double = 1);
var
  buffer: TBitmap;
  NewWidth, NewHeight: Integer;
begin
  if(Assigned(QRBitmap))then
  begin
    NewWidth := Trunc(QRBitmap.Width * Scale);
    NewHeight := Trunc(QRBitmap.Height * Scale);
    buffer := TBitmap.Create;
    try
      buffer.Width := NewWidth;
      buffer.Height := NewHeight;
      buffer.Canvas.StretchDraw(Rect(0, 0, NewWidth, NewHeight), QRBitmap);
      QRBitmap.Width := NewWidth;
      QRBitmap.Height := NewHeight;
      QRBitmap.Canvas.Draw(0, 0, buffer);
    finally
      buffer.Free;
    end;
  end;
end;


procedure TfrmMain.edtTextChange(Sender: TObject);
begin
  if((Sender is TComboBox) and ((Sender as TComboBox).Name = 'cmbEncoding'))then
  begin
    if((Sender as TComboBox).ItemIndex = 1)then
      edtText.MaxLength := Numeric
    else
      edtText.MaxLength := Alphanumeric;
  end;
  edtLength.Value := Length(edtText.Text);
  QRUpdate(Sender);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  QRCodeBitmap.Free;
end;

procedure TfrmMain.QRPaintBoxPaint(Sender: TObject);
var
  Scale: Double;
  NewWidth, NewHeight: Integer;
begin
  QRPaintBox.Canvas.Brush.Color := clWhite;
  QRPaintBox.Canvas.FillRect(Rect(0, 0, QRPaintBox.Width, QRPaintBox.Height));
  if((QRCodeBitmap.Width > 0) and (QRCodeBitmap.Height > 0))then
  begin
    if(QRPaintBox.Width < QRPaintBox.Height)then
      Scale := QRPaintBox.Width / QRCodeBitmap.Width
    else
      Scale := QRPaintBox.Height / QRCodeBitmap.Height;
    NewWidth := Trunc(Scale * QRCodeBitmap.Width);
    NewHeight := Trunc(Scale * QRCodeBitmap.Height);
    QRPaintBox.Canvas.StretchDraw(Rect(0, 0, NewWidth, NewHeight), QRCodeBitmap);
  end;
end;

procedure TfrmMain.QRUpdate(Sender: TObject);
begin
  Generate(QRCodeBitmap, edtText.Text, cmbErrorCorrection.ItemIndex, cmbEncoding.ItemIndex, Trunc(edtQuietZone.Value));
  QRPaintBox.Repaint;
end;

procedure TfrmMain.btnSaveClick(Sender: TObject);
var
  fIni: TIniFile;
  FileFormat: string;
begin
  if(dlgSave.Execute)then
  begin
    FileFormat := ExtractFileExt(dlgSave.FileName);
    if(FileFormat = '.bmp')then
    begin
      QRSaveToFile(PChar(dlgSave.FileName), edtText.Text,
                   cmbErrorCorrection.ItemIndex,
                   cmbEncoding.ItemIndex,
                   Trunc(edtQuietZone.Value),
                   edtScale.Value);
      Application.MessageBox('Immagine salvata con successo', 'QRCode', MB_OK or MB_ICONINFORMATION);
    end else
    if(FileFormat = '.qr')then
    begin
      fIni := TIniFile.Create(dlgSave.FileName);
      try
        fIni.WriteString(Section, Ident_1, Base64Encode(edtText.Text));
        fIni.WriteInteger(Section, Ident_2, cmbEncoding.ItemIndex);
        fIni.WriteInteger(Section, Ident_3, cmbErrorCorrection.ItemIndex);
        fIni.WriteFloat(Section, Ident_4, edtQuietZone.Value);
        fIni.WriteFloat(Section, Ident_5, edtScale.Value);
      finally
        fIni.Free;
      end;
      Application.MessageBox('Dati salvati con successo', 'QRCode', MB_OK or MB_ICONINFORMATION);
    end else
      Application.MessageBox('Formato del file non valido', 'QRCode', MB_OK or MB_ICONERROR);
  end;
end;

procedure TfrmMain.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  edtText.SelStart := 0;
  edtText.SelectAll;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  QRCodeBitmap := TBitmap.Create;
  QRUpdate(Sender);
end;

procedure TfrmMain.edtScaleKeyPress(Sender: TObject; var Key: Char);
begin
  {
  if(Key = #13)then
  begin
    if(HiWord(GetKeyState(VK_SHIFT)) <> 0)then
      SelectNext(Sender as TWinControl, False, True)
    else
      SelectNext(Sender as TWinControl, True, True);
    Key := #0;
    Exit;
  end;
  }
  if(Sender is TCurrencyEdit)then
  begin
    if(Key in['.', ','])then
    begin
      Key := DecimalSeparator;
    end;
  end;
end;

procedure TfrmMain.btnLoadClick(Sender: TObject);
var
  fIni: TIniFile;
begin
  if(dlgOpen.Execute)then
  begin
    fIni := TIniFile.Create(dlgOpen.FileName);
    try
      cmbEncoding.ItemIndex := fIni.ReadInteger(Section, Ident_2, 0);
      cmbErrorCorrection.ItemIndex := fIni.ReadInteger(Section, Ident_3, 0);
      edtQuietZone.Value := fIni.ReadFloat(Section, Ident_4, 0.0);
      edtScale.Value := fIni.ReadFloat(Section, Ident_5, 0.0);
      edtText.Text := Base64Decode(fIni.ReadString(Section, Ident_1, ''));
    finally
      fIni.Free;
    end;
  end;
end;

procedure TfrmMain.frmStorageRestorePlacement(Sender: TObject);
var
  fIni: TIniFile;
begin
  fIni := TIniFile.Create(frmStorage.IniFileName);
  try
    cmbEncoding.ItemIndex := fIni.ReadInteger(Section, Ident_2, 0);
    cmbErrorCorrection.ItemIndex := fIni.ReadInteger(Section, Ident_3, 0);
    edtQuietZone.Value := fIni.ReadFloat(Section, Ident_4, 0.0);
    edtScale.Value := fIni.ReadFloat(Section, Ident_5, 0.0);
    edtText.Text := Base64Decode(fIni.ReadString(Section, Ident_1, ''));
  finally
    fIni.Free;
  end;
  {
  edtText.Text := 'BEGIN:VCARD' + #13#10 +
                  'VERSION:2.1' + #13#10 +
                  'N:Fagotto;Elvio;;;' + #13#10 +
                  'FN:Elvio Fagotto' + #13#10 +
                  'ORG:EF' + #13#10 +
                  'ADR:;;Via Villa di Summaga\, 25;Portogruaro;Venezia;30026;Italia' + #13#10 +
                  'TEL;CELL:+393475943202' + #13#10 +
                  'EMAIL;INTERNET:elvio.fagotto@gmail.com' + #13#10 +
                  'TEL:+393475943202' + #13#10 +
                  'END:VCARD';
  }
end;

procedure TfrmMain.frmStorageSavePlacement(Sender: TObject);
var
  fIni: TIniFile;
begin
  fIni := TIniFile.Create(frmStorage.IniFileName);
  try
    fIni.WriteString(Section, Ident_1, Base64Encode(edtText.Text));
    fIni.WriteInteger(Section, Ident_2, cmbEncoding.ItemIndex);
    fIni.WriteInteger(Section, Ident_3, cmbErrorCorrection.ItemIndex);
    fIni.WriteFloat(Section, Ident_4, edtQuietZone.Value);
    fIni.WriteFloat(Section, Ident_5, edtScale.Value);
  finally
    fIni.Free;
  end;
end;

end.
