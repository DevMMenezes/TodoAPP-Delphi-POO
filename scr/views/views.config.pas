unit views.Config;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls, controllers.usuario, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Menus, Utils, models.usuario, views.criar.usuario,
  Vcl.AppEvnts, Vcl.ExtCtrls, dxGDIPlusClasses;

type
  TfrmConfig = class(TForm)
    pgPrincipal: TPageControl;
    pgTabUsuarios: TTabSheet;
    DBGridUsuarios: TDBGrid;
    QUsuarios: TFDQuery;
    DSUsuario: TDataSource;
    PopupMenuDBUsuarios: TPopupMenu;
    A1: TMenuItem;
    pnConfiguracoes: TPanel;
    pnClose: TPanel;
    btnClose: TImage;
    BtnCons: TPanel;
    BtnCriar: TPanel;
    procedure BtnCons1Click(Sender: TObject);
    procedure BtnCriar1Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure DBGridUsuariosDblClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure BtnConsClick(Sender: TObject);
    procedure BtnCriarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfig: TfrmConfig;

implementation

{$R *.dfm}

procedure TfrmConfig.A1Click(Sender: TObject);
var
  oResultConsultaByID: TResultConsultaByID;
  cUsuario: TUsuariosController;
  sError: String;
begin

  { Criando instância da classe }
  cUsuario := TUsuariosController.Create;

  try
    try
      oResultConsultaByID := cUsuario.ConsultarPorID(QUsuarios.FieldByName('ID')
        .AsInteger, sError);

      Application.CreateForm(TfrmCriarUsuarios, frmCriarUsuarios);
      frmCriarUsuarios.Tag := 1;

      with frmCriarUsuarios do
      begin
        EdtID.Text := oResultConsultaByID.ID.ToString;
        EdtNome.Text := oResultConsultaByID.Nome;
        EdtSenha.Text := oResultConsultaByID.Senha;

        if oResultConsultaByID.Ativo = 'S' then
          CBAtivo.Checked := True
        else
          CBAtivo.Checked := False;
      end;

      frmCriarUsuarios.ShowModal;

    except
      on E: Exception do
      begin
        Mensagem(E.Message + sError);
      end;
    end;
  finally
    { Liberando classes da memória }
    cUsuario.Free;
  end;

end;

procedure TfrmConfig.btnCloseClick(Sender: TObject);
begin
 Close;
end;

procedure TfrmConfig.BtnCons1Click(Sender: TObject);
var
  cUsuario: TUsuariosController;
  sError: String;
begin
  { Criando instância da classe }
  cUsuario := TUsuariosController.Create;

  try
    try
      cUsuario.CarregarTodosUsuariosGrid(QUsuarios, DBGridUsuarios,
        DSUsuario, sError);
    except
      on E: Exception do
      begin
        ShowMessage(E.Message + ' : ' + sError);
      end;
    end;
  finally
    { Liberando da memória }
    cUsuario.Free;
  end;

end;

procedure TfrmConfig.BtnConsClick(Sender: TObject);
var
  cUsuario: TUsuariosController;
  sError: String;
begin
  { Criando instância da classe }
  cUsuario := TUsuariosController.Create;

  try
    try
      cUsuario.CarregarTodosUsuariosGrid(QUsuarios, DBGridUsuarios,
        DSUsuario, sError);
    except
      on E: Exception do
      begin
        ShowMessage(E.Message + ' : ' + sError);
      end;
    end;
  finally
    { Liberando da memória }
    cUsuario.Free;
  end;

end;

procedure TfrmConfig.BtnCriar1Click(Sender: TObject);
begin
  CriarFormularioShowModal(TfrmCriarUsuarios, frmCriarUsuarios, 0);
end;

procedure TfrmConfig.BtnCriarClick(Sender: TObject);
begin
  Application.CreateForm(TfrmCriarUsuarios, frmCriarUsuarios);
  frmCriarUsuarios.Tag := 0;
  frmCriarUsuarios.ShowModal;
end;

procedure TfrmConfig.DBGridUsuariosDblClick(Sender: TObject);
begin
  A1Click(Sender);
end;

procedure TfrmConfig.FormShow(Sender: TObject);
begin
ArredondarCantos(frmConfig);
ArredondarCantos(BtnCriar);
ArredondarCantos(BtnCons);
end;

end.
