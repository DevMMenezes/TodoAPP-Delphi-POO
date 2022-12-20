unit models.usuario;

interface

uses
  System.SysUtils;

type
  TUsuarioModels = class

  private
    FSenha: String;
    FUsuarioLogin: String;
    FAtivo: String;
    FID: Integer;
    procedure setUsuario(FValue: String);
    procedure SetSenha(FValue: String);
    procedure SetAtivo(const Value: String);
    procedure SetID(const Value: Integer);
  public

    property UsuarioLogin: String read FUsuarioLogin write setUsuario;
    property Senha: String read FSenha write SetSenha;
    property Ativo: String read FAtivo write SetAtivo;
    property ID: Integer read FID write SetID;

  end;

var
  sNomeUsuario: String;
  iIDUsuario: Integer;

implementation

{ TUsuarioModels }

procedure TUsuarioModels.SetAtivo(const Value: String);
begin
  if Value = '' then
    raise exception.Create('Erro ao Ativar ou Desativar o Usuário!');
  FAtivo := Value;
end;

procedure TUsuarioModels.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TUsuarioModels.SetSenha(FValue: String);
begin
  if FValue = '' then
    raise exception.Create('Preencha o campo de senha!');
  FSenha := UpperCase(FValue);
end;

procedure TUsuarioModels.setUsuario(FValue: String);
begin
  if FValue = '' then
    raise exception.Create('Preencha o campo de usuário!');
  FUsuarioLogin := UpperCase(FValue);
end;

end.
