{ *******************************************************************************
Title: T2Ti ERP
Description: Unit de controle Base - Cliente.

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
******************************************************************************* }
unit Controller;

interface

uses
  Classes, FPJson, SessaoUsuario, SysUtils, Forms,
  VO, TypInfo, FGL, Biblioteca, T2TiORM;

type
  TController = class(TPersistent)
  private
  public
    class function ServidorAtivo: Boolean;
  protected
    class function Sessao: TSessaoUsuario;
  end;

  TClassController = class of TController;

implementation

{ TController }

class function TController.Sessao: TSessaoUsuario;
begin
  Result := TSessaoUsuario.Instance;
end;

class function TController.ServidorAtivo: Boolean;
var
  Url: String;
begin
  Result := False;
  try
    //se tiver ativo
    Result := True;
  except
    Result := False;
  end;
end;

end.

