unit Tipos;

{$MODE Delphi}

interface

type
  TImagem = (iIncluir, iAlterar, iExcluir, iConsultar, iImprimir, iSalvar,
    iCancelar, iLocalizar, iSair, iExportar, iExcel, iHTML, iCSV, iWord, iXML,
    iAnterior, iPrimeiro, iUltimo, iProximo, iProximaPagina, iPaginaAnterior,
    iAbrir, iVisualizar, iDigitalizar, iCarregarDados);

  TStatusImagem = (siDesabilitada, siHabilitada);

  TTamanhoImagem = (ti16);

  TPanelExibir = (peGrid, peEdits);

  //0-aberto | 1-venda em andamento | 2-fechado | 3-Importando Or�amentos | 4-Recuperando uma Venda
  TStatusCaixa = (scAberto, scVendaEmAndamento, scFechado, scImportandoOrcamento, scRecuperandoVenda);

  // 0-n�o | 1-sim
  TSimNao = (snNao, snSim);

implementation

end.
