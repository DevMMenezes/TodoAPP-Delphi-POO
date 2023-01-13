unit views.criar.usuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, models.usuario,
  controllers.usuario, Utils, Vcl.ExtCtrls, dxGDIPlusClasses;

type
  TfrmCriarUsuarios = class(TForm)
    pnFundo: TPanel;
    LbID: TLabel;
    LbNome: TLabel;
    LbSenha: TLabel;
    EdtID: TEdit;
    EdtSenha: TEdit;
    EdtNome: TEdit;
    CBAtivo: TCheckBox;
    BtnGravar: TPanel;
    pnTopbar: TPanel;
    pnClose: TPanel;
    btnClose: TImage;
    BtnAlterar: TPanel;
    procedure FormShow(Sender: TObject);
    procedure BtnGravar1Click(Sender: TObject);
    procedure BtnAlterar1Click(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
    procedure BotoesAposGravar;
    procedure BotoesAposAlterar;
  public
    { Public declarations }
  end;

var
  frmCriarUsuarios: TfrmCriarUsuarios;

implementation

{$R *.dfm}

procedure TfrmCriarUsuarios.BotoesAposAlterar;
begin
  CBAtivo.Enabled := true;
  EdtNome.Enabled := true;
  EdtSenha.Enabled := true;
  BtnAlterar.Enabled := false;
  BtnGravar.Enabled := true;

end;

procedure TfrmCriarUsuarios.BotoesAposGravar;
begin
  CBAtivo.Enabled := false;
  EdtNome.Enabled := false;
  EdtSenha.Enabled := false;
  BtnGravar.Enabled := false;
  BtnAlterar.Enabled := true;

end;

procedure TfrmCriarUsuarios.BtnAlterar1Click(Sender: TObject);
begin

  BotoesAposAlterar;
end;

procedure TfrmCriarUsuarios.BtnAlterarClick(Sender: TObject);
begin
 BotoesAposAlterar;
end;

procedure TfrmCriarUsuarios.btnCloseClick(Sender: TObject);
begin
 Close;
end;

procedure TfrmCriarUsuarios.BtnGravar1Click(Sender: TObject);
var
  oUsuarioInsert, oUsuarioUpdate: TUsuarioModels;
  cUsuario: TUsuariosController;
  sError: String;
begin
  { Criando inst�ncia das classes }
  oUsuarioInsert := TUsuarioModels.Create;
  oUsuarioUpdate := TUsuarioModels.Create;
  cUsuario       := TUsuariosController.Create;
  try
    try
      { Verifico se existe c�digo do produto para decidir entre Inserir ou Update }
      if EdtID.Text <> '' then
      begin
        { Adiciono as informa��es no objeto }
        with oUsuarioUpdate do
        begin
          ID := StrToInt(EdtID.Text);
          UsuarioLogin := EdtNome.Text;
          Senha := EdtSenha.Text;

          if CBAtivo.Checked then
            Ativo := 'S'
          else
            Ativo := 'N';
        end;

        { Fa�o o update, passando o objeto preenchido acima }
        if cUsuario.Update(oUsuarioUpdate, sError) then
        begin
          Mensagem('Usu�rio Alterado com sucesso!');
          BotoesAposGravar;
        end;

      end
      else
      begin

        { Adiciono as informa��es no objeto }
        with oUsuarioInsert do
        begin
          UsuarioLogin := EdtNome.Text;
          Senha := EdtSenha.Text;
          Ativo := 'S';
        end;

        { O nome do usu�rio � UniqueKey, ent�o verifico se existe algum usu�rio
          com o nome que o cliente quer cadastrar }
        if cUsuario.VerificaUsuarioExistente(oUsuarioInsert, sError) then
        begin
          Mensagem('Usu�rio j� cadastrado!');
          exit;
        end;
        { Fa�o a inser��o do usu�rio }
        if cUsuario.Inserir(oUsuarioInsert, sError) then
        begin
          Mensagem('Usu�rio cadastrado com sucesso!');
          EdtID.Text := oUsuarioInsert.ID.ToString;
          BotoesAposGravar;
        end;
      end;

    except
      on E: Exception do
      begin
        Mensagem(E.Message + sError);
      end;
    end;
  finally
    { Fa�o a libera��o dos objetos na mem�ria }
    oUsuarioInsert.Free;
    oUsuarioUpdate.Free;
    cUsuario.Free;
  end;

end;

procedure TfrmCriarUsuarios.BtnGravarClick(Sender: TObject);
var
  oUsuarioInsert, oUsuarioUpdate: TUsuarioModels;
  cUsuario: TUsuariosController;
  sError: String;
begin
  { Criando inst�ncia das classes }
  oUsuarioInsert := TUsuarioModels.Create;
  oUsuarioUpdate := TUsuarioModels.Create;
  cUsuario       := TUsuariosController.Create;
  try
    try
      { Verifico se existe c�digo do produto para decidir entre Inserir ou Update }
      if EdtID.Text <> '' then
      begin
        { Adiciono as informa��es no objeto }
        with oUsuarioUpdate do
        begin
          ID := StrToInt(EdtID.Text);
          UsuarioLogin := EdtNome.Text;
          Senha := EdtSenha.Text;

          if CBAtivo.Checked then
            Ativo := 'S'
          else
            Ativo := 'N';
        end;

        { Fa�o o update, passando o objeto preenchido acima }
        if cUsuario.Update(oUsuarioUpdate, sError) then
        begin
          Mensagem('Usu�rio Alterado com sucesso!');
          BotoesAposGravar;
        end;

      end
      else
      begin

        { Adiciono as informa��es no objeto }
        with oUsuarioInsert do
        begin
          UsuarioLogin := EdtNome.Text;
          Senha := EdtSenha.Text;
          Ativo := 'S';
        end;

        { O nome do usu�rio � UniqueKey, ent�o verifico se existe algum usu�rio
          com o nome que o cliente quer cadastrar }
        if cUsuario.VerificaUsuarioExistente(oUsuarioInsert, sError) then
        begin
          Mensagem('Usu�rio j� cadastrado!');
          exit;
        end;
        { Fa�o a inser��o do usu�rio }
        if cUsuario.Inserir(oUsuarioInsert, sError) then
        begin
          Mensagem('Usu�rio cadastrado com sucesso!');
          EdtID.Text := oUsuarioInsert.ID.ToString;
          BotoesAposGravar;
        end;
      end;

    except
      on E: Exception do
      begin
        Mensagem(E.Message + sError);
      end;
    end;
  finally
    { Fa�o a libera��o dos objetos na mem�ria }
    oUsuarioInsert.Free;
    oUsuarioUpdate.Free;
    cUsuario.Free;
  end;

end;

procedure TfrmCriarUsuarios.FormShow(Sender: TObject);
begin

  case Tag of
    0: { Criar }
      begin
        BtnAlterar.Enabled := false;
        CBAtivo.Checked := true;
        CBAtivo.Enabled := false;
        EdtNome.SetFocus;
      end;
    1: { Alterar }
      begin
        CBAtivo.Enabled := false;
        EdtNome.Enabled := false;
        EdtSenha.Enabled := false;
        BtnGravar.Enabled := false;
      end;
  end;

  ArredondarCantos(frmCriarUsuarios);
    ArredondarCantos(BtnGravar);
      ArredondarCantos(BtnAlterar);

end;

end.
