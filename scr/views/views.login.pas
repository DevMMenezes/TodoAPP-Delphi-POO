unit views.login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, controllers.usuario, dxGDIPlusClasses;

type
  TfrmLogin = class(TForm)
    pnBase: TPanel; { rgb(110,49,20) }
    ImageFundo: TImage;
    EditSenha: TEdit;
    EditUsuario: TEdit;
    LbUsuario: TLabel;
    LbSenha: TLabel;
    BtnOK: TButton;
    BtnFechar: TButton;
    LbDev: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmLogin.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLogin.BtnOKClick(Sender: TObject);
var
  oUsuario: TUsuarioModels;
  cUsuario: TUsuariosController;
  sError: String;
  rRetornosLogin: TRetornosLogin;
begin
  { Criando a instâncias da minha model }
  oUsuario := TUsuarioModels.Create;

  try
    try
      { Com a instância criada, atribuo a classe instanciada }
      with oUsuario do
      begin
        UsuarioLogin := EditUsuario.Text;
        Senha := EditSenha.Text;
      end;

      { Chamo a função para validar o usuário do controller e recebo numa classe record
        para capturar os vários retornos que podem serem enviados. }
      rRetornosLogin := cUsuario.ValidaLoginUsuario(oUsuario, sError);

      { Valido se o retorno é para liberar o login ou não }
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
    { Liberando as classes da memória }
    oUsuario.Free;
  end;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmLogin := nil;
  Action := caFree;
end;

procedure TfrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    BtnOK.Click;
  end
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  ArredondarCantos(EditUsuario);
  ArredondarCantos(EditSenha);
end;

end.
