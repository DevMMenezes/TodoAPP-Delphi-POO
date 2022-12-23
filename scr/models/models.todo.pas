unit models.todo;

interface

uses
  System.SysUtils;

type
  TTodo = class
  private
    FID: Integer;
    FTitulo: String;
    FDescricao: String;
    FStatus: String;
    procedure SetID(const Value: Integer);
    procedure SetTitulo(const Value: String);
    procedure SetDescricao(const Value: String);
    procedure SetStatus(const Value: String);
  public
    property ID: Integer read FID write SetID;
    property Titulo: String read FTitulo write SetTitulo;
    property Descricao: String read FDescricao write SetDescricao;
    property Status: String read FStatus write SetStatus;
  end;

implementation

{ TTodo }

procedure TTodo.SetDescricao(const Value: String);
begin
  if Value = '' then
    raise exception.Create('Preencha a descrição do todo!');
  FDescricao := Value;
end;

procedure TTodo.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TTodo.SetStatus(const Value: String);
begin
  if Value = '' then
    raise exception.Create('Preencha o status do todo!');
  FStatus := Value;
end;

procedure TTodo.SetTitulo(const Value: String);
begin
  if Value = '' then
    raise exception.Create('Preencha o título do todo!');
  FTitulo := Value;
end;

end.
