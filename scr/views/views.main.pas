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
  FireDAC.DApt, dao.dmconnection, Vcl.ExtCtrls, dxGDIPlusClasses, views.todo;

type
  TfrmMain = class(TForm)
    pnFundo: TPanel;
    pnDock: TPanel;
    BtnTodo: TSpeedButton;
    BtnConfig: TSpeedButton;
    BtnHome: TSpeedButton;
    pnSelect: TPanel;
    procedure FormShow(Sender: TObject);
    procedure BtnTodoClick(Sender: TObject);
    procedure BtnHomeClick(Sender: TObject);
    procedure BtnConfigClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
   ArredondarCantos(pnDock);

end;

procedure TfrmMain.BtnConfigClick(Sender: TObject);
begin
  pnSelect.Left := BtnConfig.Left;

  CriarFormularioShowModal(TFrmConfig, FrmConfig,0);
end;

procedure TfrmMain.BtnHomeClick(Sender: TObject);
begin
  pnSelect.Left := BtnHome.Left;
end;

procedure TfrmMain.BtnTodoClick(Sender: TObject);
begin
  pnSelect.Left := BtnTodo.Left;

  CriarFormularioShowmodal(TFrmTodo, FrmTodo,0);
end;

end.
