unit controllers.usuario;

interface

uses
  models.usuario,
  System.SysUtils,
  dao.dmconnection,
  FireDAC.DApt,
  FireDAC.Stan.Param,
  FireDAC.Comp.Client,
  Data.DB, Vcl.DBGrids, Vcl.DBCGrids;

type

  TRetornosLogin = record
    bLogado: Boolean;
  end;

  TResultConsultaByID = record
    ID: Integer;
    Nome: String;
    Senha: String;
    Ativo: String;

  end;

  TUsuariosController = class
  private
  public
    function Inserir(oUsuario: TUsuarioModels; out sError: String): Boolean;
    function Update(oUsuario: TUsuarioModels; out sError: String): Boolean;
    function Delete(oUsuario: TUsuarioModels; out sError: String): Boolean;
    function ValidaLoginUsuario(oUsuario: TUsuarioModels; out sError: String)
      : TRetornosLogin;
    procedure CarregarTodosUsuariosGrid(oQuery: TFDQuery; DBGrid: TDBGrid;
      DataSource: TDataSource; out sError: String);
    function ConsultarPorID(ID: Integer; out sError: String)
      : TResultConsultaByID;
    function VerificaUsuarioExistente(oUsuario: TUsuarioModels;
      out sError: String): Boolean;

  end;

implementation

{ TUsuariosController }

function TUsuariosController.Update(oUsuario: TUsuarioModels;
  out sError: String): Boolean;
var
  oQuery: TFDQuery;
  oTransaction: TFDTransaction;
begin

  { Criando instâncias da minha query e transaction }
  oQuery := TFDQuery.Create(nil);
  oTransaction := TFDTransaction.Create(nil);

  { Configurando meu transaction }
  oTransaction.Connection := dmconnection.FDConnection;

  { Configurando minha query }
  oQuery.Connection := dmconnection.FDConnection;
  oQuery.Transaction := oTransaction;

  { Iniciando a transação no banco de dados }
  oTransaction.StartTransaction;
  try
    try
      with oQuery do
      begin
        Close;
        Sql.Clear;
        Sql.Text :=
          'UPDATE usuario SET  NOME = :NOME,  SENHA = :SENHA, ATIVO = :ATIVO WHERE ID = :ID';
        ParamByName('ID').AsInteger := oUsuario.ID;
        ParamByName('NOME').AsString := oUsuario.UsuarioLogin;
        ParamByName('SENHA').AsString := oUsuario.Senha;
        ParamByName('ATIVO').AsString := oUsuario.Ativo;

        ExecSQl;
        Result := True;
        { Commit caso sucesso no ExecSQL }
        oTransaction.Commit;
      end;
    except
      on E: Exception do
      begin
        { Reverto a operação caso dê algum erro }
        oTransaction.Rollback;
        Result := False;
        sError := E.Message;
        raise Exception.Create('Erro ao atualizar usuario no banco de dados');
      end;
    end;
  finally
    { Liberando a query e o transaction da memória }
    FreeAndNil(oQuery);
    FreeAndNil(oTransaction);
  end;
end;

function TUsuariosController.ValidaLoginUsuario(oUsuario: TUsuarioModels;
  out sError: String): TRetornosLogin;
var
  oQuery: TFDQuery;
begin

  { Criando instâncias da minha query e configurando com conexão }
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := dmconnection.FDConnection;

  try
    try
      with oQuery do
      begin
        Close;
        Sql.Clear;
        Sql.Text := 'SELECT * FROM USUARIO ' +
          ' where NOME = :NOME and SENHA = :SENHA ';
        ParamByName('NOME').AsString := oUsuario.UsuarioLogin;
        ParamByName('SENHA').AsString := oUsuario.Senha;
        Open;
      end;

      { Retornando uma class com herança de record,
        posso fazer quantos retornos necessários e de qualquer tipo de classe. }
      if oQuery.RecordCount > 0 then
      begin
        Result.bLogado := True;

        iIDUsuario := oQuery.FieldByName('ID').AsInteger;
        sNomeUsuario := oQuery.FieldByName('NOME').AsString;
      end;
    except
      on E: Exception do
      begin
        Result.bLogado := False;
        sError := E.Message;
        raise Exception.Create('Erro ao consultar usuario no banco de dados');
      end;
    end;
  finally
    { Liberando a query da memória }
    FreeAndNil(oQuery);
  end;

end;

function TUsuariosController.VerificaUsuarioExistente(oUsuario: TUsuarioModels;
  out sError: String): Boolean;
var
  oQuery: TFDQuery;
begin
  { Criando instâncias da minha query e configurando com conexão }
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := dmconnection.FDConnection;

  try
    try
      with oQuery do
      begin
        Close;
        Sql.Clear;
        Sql.Text := 'SELECT * FROM USUARIO WHERE NOME = :NOME ';
        ParamByName('NOME').AsString := UpperCase(oUsuario.UsuarioLogin);
        Open;
      end;

      { Verifica se existe registro com o nome informado }
      if oQuery.RecordCount > 0 then
        Result := True
      else
        Result := False;

    except
      on E: Exception do
      begin
        Result := False;
        sError := E.Message;
        raise Exception.Create('Erro ao consultar usuário');
      end;
    end;
  finally
    { Liberando a query da memória }
    FreeAndNil(oQuery);
  end;

end;

procedure TUsuariosController.CarregarTodosUsuariosGrid(oQuery: TFDQuery;
  DBGrid: TDBGrid; DataSource: TDataSource; out sError: String);
begin
  { Criando instâncias da minha query e configurando com conexão }
  oQuery.Connection := dmconnection.FDConnection;

  { Configurando DS e DBGrid }
  DataSource.DataSet := oQuery;
  DBGrid.DataSource := DataSource;

  try
    try
      with oQuery do
      begin
        Close;
        Sql.Clear;
        Sql.Text := 'SELECT * FROM USUARIO ';
        Open;
      end;
    except
      on E: Exception do
      begin
        sError := E.Message;
        raise Exception.Create('Erro ao consultar usuários no banco de dados');
      end;
    end;
  finally
  end;

end;

function TUsuariosController.ConsultarPorID(ID: Integer; out sError: String)
  : TResultConsultaByID;
var
  oQuery: TFDQuery;
begin
  { Criando instâncias da minha query e configurando com conexão }
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := dmconnection.FDConnection;

  try
    try

      with oQuery do
      begin
        Close;
        Sql.Clear;
        Sql.Text := 'SELECT * FROM USUARIO WHERE ID = :ID';
        ParamByName('ID').AsInteger := ID;
        Open;

        { Ao retornar o TResultConsultaByID, consigo individualizar o
          resultado de cada objeto informado no TResultConsultaByID }
        Result.ID := oQuery.FieldByName('ID').AsInteger;
        Result.Nome := oQuery.FieldByName('NOME').AsString;
        Result.Senha := oQuery.FieldByName('SENHA').AsString;
        Result.Ativo := oQuery.FieldByName('ATIVO').AsString;
      end;

    except
      on E: Exception do
      begin
        sError := E.Message;
        raise Exception.Create('Erro ao consultar o usuario por ID');
      end;
    end;
  finally
    { Liberando a query da memória }
    FreeAndNil(oQuery);
  end;

end;

function TUsuariosController.Delete(oUsuario: TUsuarioModels;
  out sError: String): Boolean;
var
  oQuery: TFDQuery;
  oTransaction: TFDTransaction;
begin

  { Criando instâncias da minha query e transaction }
  oQuery := TFDQuery.Create(nil);
  oTransaction := TFDTransaction.Create(nil);

  { Configurando meu transaction }
  oTransaction.Connection := dmconnection.FDConnection;

  { Configurando minha query }
  oQuery.Connection := dmconnection.FDConnection;
  oQuery.Transaction := oTransaction;

  { Iniciando a transação no banco de dados }
  oTransaction.StartTransaction;
  try
    try
      with oQuery do
      begin
        Close;
        Sql.Clear;
        Sql.Text := 'DELETE FROM usuario WHERE ID = :ID';
        ParamByName('ID').AsInteger := oUsuario.ID;
        ExecSQl;
        Result := True;
        { Commit caso sucesso no ExecSQL }
        oTransaction.Commit;
      end;
    except
      on E: Exception do
      begin
        { Reverto a operação caso dê algum erro }
        oTransaction.Rollback;
        Result := False;
        sError := E.Message;
        raise Exception.Create('Erro ao excluir o usuario no banco de dados');
      end;
    end;
  finally
    { Liberando a query e o transaction da memória }
    FreeAndNil(oQuery);
    FreeAndNil(oTransaction);
  end;
end;

function TUsuariosController.Inserir(oUsuario: TUsuarioModels;
  out sError: String): Boolean;
var
  oQuery: TFDQuery;
  oTransaction: TFDTransaction;
begin

  { Criando instâncias da minha query e transaction }
  oQuery := TFDQuery.Create(nil);
  oTransaction := TFDTransaction.Create(nil);

  { Configurando meu transaction }
  oTransaction.Connection := dmconnection.FDConnection;

  { Configurando minha query }
  oQuery.Connection := dmconnection.FDConnection;
  oQuery.Transaction := oTransaction;

  { Iniciando a transação no banco de dados }
  oTransaction.StartTransaction;
  try
    try
      with oQuery do
      begin
        Close;
        Sql.Clear;
        Sql.Text :=
          'INSERT INTO usuario (ATIVO,NOME,SENHA) VALUES(:ATIVO,:NOME,:SENHA)';
        ParamByName('ATIVO').AsString := oUsuario.Ativo;
        ParamByName('NOME').AsString := oUsuario.UsuarioLogin;
        ParamByName('SENHA').AsString := oUsuario.Senha;
        ExecSQl;

        Close;
        Sql.Clear;
        Sql.Text := 'SELECT LAST_INSERT_ID() as ID';
        Open;

        oUsuario.ID := oQuery.FieldByName('ID').AsInteger;

        { Commit caso sucesso no ExecSQL }
        oTransaction.Commit;
        Result := True;

      end;
    except
      on E: Exception do
      begin
        { Reverto a operação caso dê algum erro }
        oTransaction.Rollback;
        Result := False;
        sError := E.Message;
        raise Exception.Create('Erro ao inserir usuario ao banco de dados');
      end;
    end;
  finally
    { Liberando a query e o transaction da memória }
    FreeAndNil(oQuery);
    FreeAndNil(oTransaction);
  end;
end;

end.
