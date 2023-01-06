unit controllers.todo;

interface

uses
  models.todo, FireDAC.Comp.Client, dao.dmconnection, System.SysUtils,
  Vcl.DBCGrids, Data.DB;

type
  TTodosController = class
  private
  public
    function Inserir(oTodo: TTodo; out sError: String): Boolean;
    function Update(oTodo: TTodo; out sError: String): Boolean;
    procedure CarregaTodosPorStatus(Status: String; oQuery: TFDQuery;
      DBGrid: TDBCtrlGrid; DataSource: TDataSource; out sError: String);
    function UpdateStatusDragDrop(oTodo: TTodo; out sError: String): Boolean;
  end;

implementation

{ TTodosController }

function TTodosController.Inserir(oTodo: TTodo; out sError: String): Boolean;
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
          'INSERT INTO todoapp (TITULO,DESCRICAO,STATUS) VALUES(:TITULO,:DESCRICAO,:STATUS)';
        ParamByName('TITULO').AsString := oTodo.Titulo;
        ParamByName('DESCRICAO').AsString := oTodo.Descricao;
        ParamByName('STATUS').AsString := oTodo.Status;
        ExecSQl;

        Close;
        Sql.Clear;
        Sql.Text := 'SELECT LAST_INSERT_ID() as ID';
        Open;

        oTodo.ID := oQuery.FieldByName('ID').AsInteger;

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
        raise Exception.Create('Erro ao inserir todo ao banco de dados');
      end;
    end;
  finally
    { Liberando a query e o transaction da memória }
    FreeAndNil(oQuery);
    FreeAndNil(oTransaction);
  end;
end;

function TTodosController.Update(oTodo: TTodo; out sError: String): Boolean;
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
          'UPDATE TODO SET  TITULO = :TITULO,  DESCRICAO = :DESCRICAO, ' +
          ' STATUS = :STATUS WHERE ID = :ID';
        ParamByName('ID').AsInteger := oTodo.ID;
        ParamByName('TITULO').AsString := oTodo.Titulo;
        ParamByName('DESCRICAO').AsString := oTodo.Descricao;
        ParamByName('STATUS').AsString := oTodo.Status;
        ExecSQl;

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
        raise Exception.Create('Erro ao Atualizar o Todo no Banco de Dados');
      end;
    end;
  finally
    { Liberando a query e o transaction da memória }
    FreeAndNil(oQuery);
    FreeAndNil(oTransaction);
  end;
end;

function TTodosController.UpdateStatusDragDrop(oTodo: TTodo;
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
          'UPDATE TODO SET STATUS = :STATUS WHERE ID = :ID';
        ParamByName('ID').AsInteger := oTodo.ID;
        ParamByName('STATUS').AsString := oTodo.Status;
        ExecSQl;

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
        raise Exception.Create('Erro ao Atualizar Status do DragDrop no Banco de Dados');
      end;
    end;
  finally
    { Liberando a query e o transaction da memória }
    FreeAndNil(oQuery);
    FreeAndNil(oTransaction);
  end;
end;

procedure TTodosController.CarregaTodosPorStatus(Status: String;
  oQuery: TFDQuery; DBGrid: TDBCtrlGrid; DataSource: TDataSource;
  out sError: String);
begin
  { Criando instâncias da minha query e configurando com conexão }
  oQuery.Connection := dmconnection.FDConnection;

  { Configurando DS e DBGrid }
  DataSource.DataSet := oQuery;
  DBGrid.DataSource := DataSource;

  { STATUS : A - REALIZAR, R- REALIZANDO , P - PRONTO }
  try
    try
      with oQuery do
      begin
        Close;
        Sql.Clear;
        Sql.Text := 'SELECT * FROM TODO WHERE STATUS = :STATUS';
        ParamByName('STATUS').AsString := Trim(UpperCase(Status));
        Open;
      end;

      DBGrid.BringToFront;

    except
      on E: Exception do
      begin
        sError := E.Message;
        raise Exception.Create('Erro ao consultar todos no banco de dados');
      end;
    end;
  finally
  end;

end;

end.
