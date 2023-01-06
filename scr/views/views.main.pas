unit views.main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids,
  Vcl.DBGrids, controllers.usuario, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Stan.Async,
  FireDAC.DApt, dao.dmconnection, Vcl.ExtCtrls, dxGDIPlusClasses, views.todo,
  Vcl.Menus;

type
  TfrmMain = class(TForm)
    pnBase: TPanel;
    LblTodoTitle: TLabel;
    LblMDev: TLabel;
    ImgLogo: TImage;
    EditConsTodo: TEdit;
    pnClose: TPanel;
    btnClose: TImage;
    pnDashboard: TPanel;
    pnTodos: TPanel;
    pnSelected: TPanel;
    pnImgPerfil: TPanel;
    ImgPerfil: TImage;
    LblNomePerfil: TLabel;
    pnConfig: TPanel;
    btnConfigs: TImage;
    pnConfigs: TPanel;
    btnConfigsUsers: TPanel;
    procedure FormShow(Sender: TObject);
    procedure BtnTodoClick(Sender: TObject);
    procedure BtnConfigClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure pnTodosClick(Sender: TObject);
    procedure pnDashboardClick(Sender: TObject);
    procedure btnConfigsMouseEnter(Sender: TObject);
    procedure btnConfigsUsersMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnConfigsUsersClick(Sender: TObject);
    procedure btnConfigsUsersMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses views.login, Utils, views.config;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  ArredondarCantos(EditConsTodo);
  ArredondarCantos(frmMain);
  ArredondarCantos5(pnSelected);
  ArredondarCantosCircular(pnImgPerfil);

end;

procedure TfrmMain.pnDashboardClick(Sender: TObject);
begin
  pnSelected.Width := pnDashboard.Width;
  pnSelected.Left := pnDashboard.Left;
  pnDashboard.Font.Color := $FFFFFF;
  pnTodos.Font.Color := $3F2D15;
  ArredondarCantos5(pnSelected);
end;

procedure TfrmMain.pnTodosClick(Sender: TObject);
begin
  pnSelected.Width := pnTodos.Width;
  pnSelected.Left := pnTodos.Left;
  pnTodos.Font.Color := $FFFFFF;
  pnDashboard.Font.Color := $3F2D15;
  ArredondarCantos5(pnSelected);


  CriarFormularioShowModal(TFrmTodo, FrmTodo, 0);

end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.BtnConfigClick(Sender: TObject);
begin


  CriarFormularioShowModal(TFrmConfig, FrmConfig, 0);
end;

procedure TfrmMain.btnConfigsMouseEnter(Sender: TObject);
begin
  pnConfigs.Visible := true;
end;

procedure TfrmMain.btnConfigsUsersClick(Sender: TObject);
begin
  CriarFormularioShowModal(TFrmConfig, FrmConfig, 0);
end;

procedure TfrmMain.btnConfigsUsersMouseLeave(Sender: TObject);
begin
    pnConfigs.Visible := false;
end;

procedure TfrmMain.btnConfigsUsersMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  pnConfigs.Visible := false;
end;

procedure TfrmMain.BtnTodoClick(Sender: TObject);
begin

  CriarFormularioShowModal(TFrmTodo, FrmTodo, 0);
end;

end.
