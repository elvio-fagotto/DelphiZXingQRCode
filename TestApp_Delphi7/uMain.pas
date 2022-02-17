unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DelphiZXingQRCode, ExtCtrls,
  StdCtrls, rxPlacemnt, AlignEdit, ComCtrls, Mask, rxToolEdit,
  rxCurrEdit;

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
    cmbCorrectionError: TComboBox;
    Label5: TLabel;
    dlgSave: TSaveDialog;
    btnSave: TButton;
    Label6: TLabel;
    stat1: TStatusBar;
    edtQuietZone: TCurrencyEdit;
    edtScale: TCurrencyEdit;
    Label7: TLabel;
    edtLength: TCurrencyEdit;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QRPaintBoxPaint(Sender: TObject);
    procedure edtTextChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
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

const
  Numeric: Integer      = 7089;
  Alphanumeric: Integer = 4296;

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

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  QRCodeBitmap := TBitmap.Create;
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
  Generate(QRCodeBitmap, edtText.Text, cmbCorrectionError.ItemIndex, cmbEncoding.ItemIndex, StrToIntDef(edtQuietZone.Text, 0));
  QRPaintBox.Repaint;
end;

procedure TfrmMain.btnSaveClick(Sender: TObject);
begin
  if(dlgSave.Execute)then
  begin
    QRSaveToFile(PChar(dlgSave.FileName), edtText.Text,
                 cmbCorrectionError.ItemIndex,
                 cmbEncoding.ItemIndex,
                 StrToIntDef(edtQuietZone.Text, 0),
                 edtScale.Value);
  end;
end;

procedure TfrmMain.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  edtText.SelStart := 0;
  edtText.SelectAll;
end;

end.
