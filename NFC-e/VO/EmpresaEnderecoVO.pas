{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [EMPRESA_ENDERECO] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2014 T2Ti.COM                                          
                                                                                
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
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (t2ti.com@gmail.com)                    
@version 2.0                                                                    
*******************************************************************************}
unit EmpresaEnderecoVO;

{$mode objfpc}{$H+}

interface

uses
  VO, Classes, SysUtils, FGL;

type
  TEmpresaEnderecoVO = class(TVO)
  private
    FID: Integer;
    FID_EMPRESA: Integer;
    FLOGRADOURO: String;
    FNUMERO: String;
    FCOMPLEMENTO: String;
    FBAIRRO: String;
    FCIDADE: String;
    FCEP: String;
    FFONE: String;
    FMUNICIPIO_IBGE: Integer;
    FUF: String;
    FPRINCIPAL: String;
    FENTREGA: String;
    FCOBRANCA: String;
    FCORRESPONDENCIA: String;

  published 
    property Id: Integer  read FID write FID;
    property IdEmpresa: Integer  read FID_EMPRESA write FID_EMPRESA;
    property Logradouro: String  read FLOGRADOURO write FLOGRADOURO;
    property Numero: String  read FNUMERO write FNUMERO;
    property Complemento: String  read FCOMPLEMENTO write FCOMPLEMENTO;
    property Bairro: String  read FBAIRRO write FBAIRRO;
    property Cidade: String  read FCIDADE write FCIDADE;
    property Cep: String  read FCEP write FCEP;
    property Fone: String  read FFONE write FFONE;
    property MunicipioIbge: Integer  read FMUNICIPIO_IBGE write FMUNICIPIO_IBGE;
    property Uf: String  read FUF write FUF;
    property Principal: String  read FPRINCIPAL write FPRINCIPAL;
    property Entrega: String  read FENTREGA write FENTREGA;
    property Cobranca: String  read FCOBRANCA write FCOBRANCA;
    property Correspondencia: String  read FCORRESPONDENCIA write FCORRESPONDENCIA;

  end;

  TListaEmpresaEnderecoVO = specialize TFPGObjectList<TEmpresaEnderecoVO>;

implementation


initialization
  Classes.RegisterClass(TEmpresaEnderecoVO);

finalization
  Classes.UnRegisterClass(TEmpresaEnderecoVO);

end.
