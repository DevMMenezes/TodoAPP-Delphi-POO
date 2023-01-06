unit views.login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, controllers.usuario, dxGDIPlusClasses, ShadowBox;

type
  TfrmLogin = class(TForm)
    pnFundoLogin: TPanel;
    LblTodoTitle: TLabel;
    LblMDev: TLabel;
    LblLogin: TLabel;
    Image1: TImage;
    EditUsuario: TEdit;
    EditSenha: TEdit;
    BtnOK: TPanel;
    LblDesenvolvidopor: TLabel;
    pnClose: TPanel;
    btnClose: TImage;
    procedure FormShow(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnOK1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses views.main, Utils, models.usuario, dao.dmconnection;

procedure TfrmLogin.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.BtnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmLogin.BtnOK1Click(Sender: TObject);
var
  oUsuario: TUsuarioModels;
  cUsuario: TUsuariosController;
  sError: String;
  rRetornosLogin: TRetornosLogin;
begin
  { Criando a inst�ncias da minha model }
  oUsuario := TUsuarioModels.Create;

  try
    try
      { Com a inst�ncia criada, atribuo a classe instanciada }
      with oUsuario do
      begin
        UsuarioLogin := EditUsuario.Text;
        Senha := EditSenha.Text;
      end;

      { Chamo a fun��o para validar o usu�rio do controller e recebo numa classe record
        para capturar os v�rios retornos que podem serem enviados. }
      rRetornosLogin := cUsuario.ValidaLoginUsuario(oUsuario, sError);

      { Valido se o retorno � para liberar o login ou n�o }
      if rRetornosLogin.bLogado then
      begin
        frmLogin.Destroy;
        CriarFormularioShowModal(TfrmMain, frmMain, 0);
      end
      else
      begin
        ShowMessage('Erro ao validar as credenciais!');
        EditSenha.SetFocus;
      end;
    except
      on E: Exception do
      begin
        ShowMessage(E.Message + ' : ' + sError);
      end;
    end;
  finally
    { Liberando as classes da mem�ria }
    oUsuario.Free;
  end;
end;

procedure TfrmLogin.BtnOKClick(Sender: TObject);
var
  oUsuario: TUsuarioModels;
  cUsuario: TUsuariosController;
  sError: String;
  rRetornosLogin: TRetornosLogin;
begin
  { Criando a inst�ncias da minha model }
  oUsuario := TUsuarioModels.Create;

  try
    try
      { Com a inst�ncia criada, atribuo a classe instanciada }
      with oUsuario do
      begin
        UsuarioLogin := UpperCase(EditUsuario.Text);
        Senha := EditSenha.Text;
      end;

      { Chamo a fun��o para validar o usu�rio do controller e recebo numa classe record
        para capturar os v�rios retornos que podem serem enviados. }
      rRetornosLogin := cUsuario.ValidaLoginUsuario(oUsuario, sError);

      { Valido se o retorno � para liberar o login ou n�o }
      if rRetornosLogin.bLogado then
      begin
        frmLogin.Destroy;
        Application.CreateForm(TfrmMain, frmMain);
        frmMain.Showmodal;
      end
      else
      begin
        ShowMessage('Erro ao validar as credenciais!');
        EditSenha.SetFocus;
      end;
    except
      on E: Exception do
      begin
        ShowMessage(E.Message + ' : ' + sError);
      end;
    end;
  finally
    { Liberando as classes da mem�ria }
    oUsuario.Free;
  end;
end;

procedure TfrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    BtnOKClick(Self);
  end
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  ArredondarCantos(frmLogin);
  ArredondarCantos(BtnOK);
end;

end.
