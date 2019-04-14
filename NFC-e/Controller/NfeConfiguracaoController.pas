{*******************************************************************************
Title: T2Ti ERP                                                                 
Description: Controller relacionado � tabela [NFE_CONFIGURACAO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2010 T2Ti.COM                                          
                                                                                
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
t2ti.com@gmail.com</p>

Albert Eije (T2Ti.COM)
@version 2.0
*******************************************************************************}
unit NfeConfiguracaoController;

interface

uses
  Classes, SysUtils, Windows, Forms, Controller, ZDataset,
  VO, NfeConfiguracaoVO;


type
  TNfeConfiguracaoController = class(TController)
  private
  public
    class function Consulta(pFiltro: String; pPagina: String): TZQuery;
    class function ConsultaLista(pFiltro: String): TListaNfeConfiguracaoVO;
    class function ConsultaObjeto(pFiltro: String): TNfeConfiguracaoVO;
  end;

implementation

uses T2TiORM;

var
  ObjetoLocal: TNfeConfiguracaoVO;

class function TNfeConfiguracaoController.Consulta(pFiltro: String; pPagina: String): TZQuery;
begin
  try
    ObjetoLocal := TNfeConfiguracaoVO.Create;
    Result := TT2TiORM.Consultar(ObjetoLocal, pFiltro, pPagina);
  finally
    ObjetoLocal.Free;
  end;
end;

class function TNfeConfiguracaoController.ConsultaLista(pFiltro: String): TListaNfeConfiguracaoVO;
begin
  try
    ObjetoLocal := TNfeConfiguracaoVO.Create;
    Result := TListaNfeConfiguracaoVO(TT2TiORM.Consultar(ObjetoLocal, pFiltro, True));
  finally
    ObjetoLocal.Free;
  end;
end;

class function TNfeConfiguracaoController.ConsultaObjeto(pFiltro: String): TNfeConfiguracaoVO;
begin
  try
    Result := TNfeConfiguracaoVO.Create;
    Result := TNfeConfiguracaoVO(TT2TiORM.ConsultarUmObjeto(Result, pFiltro, True));
  finally
  end;
end;


end.
