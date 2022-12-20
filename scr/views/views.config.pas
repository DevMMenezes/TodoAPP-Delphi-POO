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
  FireDAC.Comp.Client, Vcl.Menus, Utils, models.usuario, views.criar.usuario;

type
  TfrmConfig = class(TForm)
    pgPrincipal: TPageControl;
    pgTabUsuarios: TTabSheet;
    DBGridUsuarios: TDBGrid;
    BtnCons: TButton;
    QUsuarios: TFDQuery;
    DSUsuario: TDataSource;
    PopupMenuDBUsuarios: TPopupMenu;
    A1: TMenuItem;
    BtnCriar: TButton;
    procedure BtnConsClick(Sender: TObject);
    procedure BtnCriarClick(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure DBGridUsuariosDblClick(Sender: TObject);
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
        ShowMessage(E.Message + sError);
      end;
    end;
  finally
  end;

end;

procedure TfrmConfig.BtnConsClick(Sender: TObject);
var
  cUsuario: TUsuariosController;
  sError: String;
begin

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
  end;

end;

procedure TfrmConfig.BtnCriarClick(Sender: TObject);
begin
  CriarFormularioShowModal(TfrmCriarUsuarios, frmCriarUsuarios, 0);
end;

procedure TfrmConfig.DBGridUsuariosDblClick(Sender: TObject);
begin
  A1Click(Sender);
end;

end.
