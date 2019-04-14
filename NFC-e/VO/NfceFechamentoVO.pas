{*******************************************************************************
Title: T2Ti ERP                                                                 
Description:  VO  relacionado � tabela [NFCE_FECHAMENTO] 
                                                                                
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
unit NfceFechamentoVO;

{$mode objfpc}{$H+}

interface

uses
  VO, Classes, SysUtils, FGL;

type
  TNfceFechamentoVO = class(TVO)
  private
    FID: Integer;
    FID_NFCE_MOVIMENTO: Integer;
    FTIPO_PAGAMENTO: String;
    FVALOR: Extended;

  published 
    property Id: Integer  read FID write FID;
    property IdNfceMovimento: Integer  read FID_NFCE_MOVIMENTO write FID_NFCE_MOVIMENTO;
    property TipoPagamento: String  read FTIPO_PAGAMENTO write FTIPO_PAGAMENTO;
    property Valor: Extended  read FVALOR write FVALOR;

  end;

  TListaNfceFechamentoVO = specialize TFPGObjectList<TNfceFechamentoVO>;

implementation


initialization
  Classes.RegisterClass(TNfceFechamentoVO);

finalization
  Classes.UnRegisterClass(TNfceFechamentoVO);

end.
