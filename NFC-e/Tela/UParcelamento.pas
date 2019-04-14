{ *******************************************************************************
  Title: T2TiPDV
  Description: Gera Parcelas para o Contas a Receber.

  The MIT License

  Copyright: Copyright (C) 2015 T2Ti.COM

  Permission is hereby granted, free of charge, to any person
  obtaining a copy of this software and associated documentation
  files (the "Software"), to deal in the Software without
  restriction, including without limitation the rights to use,
  copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the
  Software is furnished to do so, subject to the following
  conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  OTHER DEALINGS IN THE SOFTWARE.

  The author may be contacted at:
  alberteije@gmail.com

  @author T2Ti.COM
  @version 1.0
  ******************************************************************************* }
unit UParcelamento;

{$mode objfpc}{$H+}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids, DB, BufDataset,
  ACBrBase, ACBrEnterTab, RXSpin, CurrEdit, dbdateedit, tooledit,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, UBase;

type

  { TFParcelamento }

  TFParcelamento = class(TFBase)
    ACBrEnterTab1: TACBrEnterTab;
    botaoConfirma: TBitBtn;
    CDSParcela: TBufDataset;
    Image1: TImage;
    GroupBox1: TGroupBox;
    editNome: TEdit;
    Image2: TImage;
    Label2: TLabel;
    Label3: TLabel;
    editCPF: TEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBGrid1: TDBGrid;
    qtdParcelas: TRxSpinEdit;
    editValorVenda: TCurrencyEdit;
    editValorRecebido: TCurrencyEdit;
    editValorParcelar: TCurrencyEdit;
    Panel1: TPanel;
    DSParcela: TDataSource;
    DBDateEdit1: TDBDateEdit;
    botaoLocalizaCliente: TBitBtn;
    editDesconto: TCurrencyEdit;
    lblDesconto: TLabel;
    botaoCancela: TSpeedButton;
    editVencimento: TRxDateEdit;
    procedure DBGrid1ColExit(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure editVencimentoChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure botaoConfirmaClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure botaoLocalizaClienteClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CalculaParcelas;
    procedure qtdParcelasChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FParcelamento: TFParcelamento;
  confirmou: Boolean;

implementation

uses UCaixa, FinParcelaReceberVO, FinLancamentoReceberVO,
  Biblioteca, UIdentificaCliente, VendaController;
{$R *.lfm}

procedure TFParcelamento.botaoConfirmaClick(Sender: TObject);
var
  Total, ValoraParcelar: Currency;
  ParcelaCabecalho: TFinLancamentoReceberVO;
  ParcelaDetalhe: TFinParcelaReceberVO;
  Identificacao: String;
begin
  (*
    Exercício - Identifique devidamente o cliente para parcelamento

    if Sessao.VendaAtual.IdCliente < 1 then
    begin
    Application.MessageBox('Escolha um cliente para Parcelar!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    Abort;
    end;
  *)

  {
  Identificacao := 'E' + IntToStr(Sessao.Configuracao.IdEmpresa) + 'X' + IntToStr(Sessao.Configuracao.IdNfceCaixa) + 'V' + DevolveInteiro(FCaixa.edtNVenda.Caption) + 'C' + DevolveInteiro(FCaixa.edtNumeroNota.Caption);

  Total := 0;
  ValoraParcelar := StrToFloat(editValorParcelar.Text);

  CDSParcela.DisableControls;
  CDSParcela.First;

  while not CDSParcela.Eof do
  begin
    Total := Total + CDSParcelaValor.AsFloat;
    CDSParcela.Next;
  end;
  CDSParcela.EnableControls;

  if (Total = ValoraParcelar) then
  begin
    try
      ParcelaCabecalho := TFinLancamentoReceberVO.Create;
      ParcelaCabecalho.IdFinDocumentoOrigem := 1;
      ParcelaCabecalho.IdCliente := 1;
      ParcelaCabecalho.QuantidadeParcela := qtdParcelas.AsInteger;
      ParcelaCabecalho.ValorTotal := Total;
      ParcelaCabecalho.ValorAReceber := Total;
      ParcelaCabecalho.DataLancamento := Date;
      ParcelaCabecalho.NumeroDocumento := Identificacao + 'Q' + qtdParcelas.Text;
      ParcelaCabecalho.PrimeiroVencimento := editVencimento.Date;
      ParcelaCabecalho.CodigoModuloLcto := 'NFC';

      CDSParcela.DisableControls;
      CDSParcela.First;
      while not CDSParcela.Eof do
      begin
        ParcelaDetalhe := TFinParcelaReceberVO.Create;
        ParcelaDetalhe.IdContaCaixa := 1;
        ParcelaDetalhe.IdFinStatusParcela := 1;
        ParcelaDetalhe.NumeroParcela := CDSParcelaParcela.AsInteger;
        ParcelaDetalhe.DataEmissao := Date;
        ParcelaDetalhe.DataVencimento := CDSParcelaVencimento.AsDateTime;
        ParcelaDetalhe.Valor := CDSParcelaValor.AsExtended;
        ParcelaCabecalho.ListaParcelaReceberVO.Add(ParcelaDetalhe);
        CDSParcela.Next;
      end;
      CDSParcela.EnableControls;

      TFinLancamentoReceberController.Insere(ParcelaCabecalho);

      confirmou := True;
    finally
      ParcelaCabecalho.Free;
    end;
    Close;
  end
  else
    Application.MessageBox('A soma das Parcelas difere do valor a parcelar!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
  }
  Close;
end;

procedure TFParcelamento.CalculaParcelas;
var
  x, QtdPar: Integer;
  Vencimento: TDateTime;
  ValorTotal, ValorParcela, Resto: Extended;
begin
  while not CDSParcela.eof do
    CDSParcela.Delete;

  QtdPar := qtdParcelas.AsInteger;
  ValorTotal := editValorParcelar.Value;
  ValorParcela := ValorTotal / QtdPar;// Round(ValorTotal / QtdPar);
  Resto := (ValorTotal - (ValorParcela * QtdPar));

  Vencimento := editVencimento.Date;

  for x := 1 To QtdPar do
  begin
    CDSParcela.Append;
    CDSParcela.FieldByName('Parcela').AsInteger := x;
    CDSParcela.FieldByName('Vencimento').AsDateTime := Vencimento;
    if x = 1 then
      CDSParcela.FieldByName('Valor').AsFloat := ValorParcela + Resto
    else
      CDSParcela.FieldByName('Valor').AsFloat := ValorParcela;
    CDSParcela.Post;
    Vencimento := IncMonth(Vencimento);
  end;
  CDSParcela.Edit;
end;

procedure TFParcelamento.editVencimentoChange(Sender: TObject);
begin
  CalculaParcelas;
end;

procedure TFParcelamento.FormActivate(Sender: TObject);
begin
  Color := StringToColor(Sessao.Configuracao.CorJanelasInternas);
  editVencimento.Date := Date + 30;
  qtdParcelas.SetFocus;
end;

procedure TFParcelamento.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if confirmou then
    ModalResult := MROK;
end;

procedure TFParcelamento.FormCreate(Sender: TObject);
begin
  //configura Dataset
  CDSParcela.Close;
  CDSParcela.FieldDefs.Clear;

  CDSParcela.FieldDefs.add('PARCELA', ftString, 20);
  CDSParcela.FieldDefs.add('VENCIMENTO', ftDate);
  CDSParcela.FieldDefs.add('VALOR', ftFloat);
  CDSParcela.CreateDataset;
  CDSParcela.Active := True;

  TFloatField(CDSParcela.FieldByName('VALOR')).displayFormat:='#,###,###,##0.00';

  confirmou := False;
  qtdParcelas.MaxValue := Sessao.Configuracao.QuantidadeMaximaParcela;
end;

procedure TFParcelamento.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 27 then
    botaoCancela.Click;
  if (Key = 112) then
    botaoLocalizaCliente.Click;
end;

procedure TFParcelamento.DBGrid1ColExit(Sender: TObject);
begin
  if DBGrid1.SelectedField.FieldName = 'Vencimento' then
    DBDateEdit1.Visible := False;
end;

procedure TFParcelamento.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (gdFocused in State) then
  begin
    if (Column.Field.FieldName = 'Vencimento') then
    begin
      with DBDateEdit1 do
      begin
        Left := Rect.Left + DBGrid1.Left + 1;
        Top := Rect.Top + DBGrid1.Top + 1;
        Width := Rect.Right - Rect.Left + 2;
        Width := Rect.Right - Rect.Left + 2;
        Height := Rect.Bottom - Rect.Top + 2;
        Visible := True;
      end;
    end;
  end;
end;

procedure TFParcelamento.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  qt, Total, valorant, prest, Resto: Real;
  Bookmark: TBookmark;
begin
  if (Key = vk_return) then
  begin
    Total := 0;
    prest := 0;
    qt := 0;
    valorant := 0;

    CDSParcela.Post;

    CDSParcela.DisableControls;

    // quantas parcelas ainda faltam
    Bookmark := CDSParcela.GetBookmark;
    while not CDSParcela.Eof do
    begin
      qt := qt + 1;
      CDSParcela.Next;
    end;
    qt := qt - 1;
    CDSParcela.GotoBookmark(Bookmark);

    // pega o saldo das parcelas anteriores
    Bookmark := CDSParcela.GetBookmark;
    while not CDSParcela.bof do
    begin
      valorant := valorant + CDSParcela.Fieldbyname('Valor').AsFloat;
      CDSParcela.prior;
    end;

    CDSParcela.GotoBookmark(Bookmark);
    Bookmark := CDSParcela.GetBookmark;
    Total := editValorParcelar.Value - valorant;

    If (Total >= 0) then
    begin
      if (Total > 0) and (qt > 0) then
      begin
        prest := Round(Total / qt);
        Resto := (Total - (prest * qt));
        CDSParcela.Edit;
        CDSParcela.Fieldbyname('VALOR').AsFloat := CDSParcela.Fieldbyname('VALOR').AsFloat + Resto;
        CDSParcela.Post;
      end;

      CDSParcela.Next;

      while not CDSParcela.Eof do
      begin
        CDSParcela.Edit;
        CDSParcela.Fieldbyname('VALOR').AsFloat := prest;
        CDSParcela.Post;
        CDSParcela.Next;
      end;
      CDSParcela.GotoBookmark(Bookmark);
    end
    else
    begin
      Application.MessageBox('O Valor Informado é Inválido!', 'Informação do Sistema', MB_OK + MB_ICONINFORMATION);
    end;
    CDSParcela.EnableControls;
    CDSParcela.Edit;
  end;
end;

procedure TFParcelamento.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(9)) then
    Exit;

  if (DBGrid1.SelectedField.FieldName = 'Vencimento') then
  begin
    DBDateEdit1.SetFocus;
    SendMessage(DBDateEdit1.Handle, WM_Char, Word(Key), 0);
  end
end;


procedure TFParcelamento.qtdParcelasChange(Sender: TObject);
begin
  CalculaParcelas;
end;

procedure TFParcelamento.botaoLocalizaClienteClick(Sender: TObject);
begin
  Application.CreateForm(TFIdentificaCliente, FIdentificaCliente);
  FIdentificaCliente.ShowModal;
end;

end.
