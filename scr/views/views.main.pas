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
  Vcl.Menus, Vcl.ComCtrls, VclTee.TeeGDIPlus, VclTee.TeEngine, VclTee.Series,
  VclTee.TeeProcs, VclTee.Chart, VclTee.DBChart, VclTee.TeeDBCrossTab,
  Vcl.Imaging.GIFImg,
  controllers.todo;

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
    PG: TPageControl;
    TabSDashboard: TTabSheet;
    TabSTodos: TTabSheet;
    GraficoProgresso: TChart;
    Series1: TPieSeries;
    TeeGDIPlus: TTeeGDIPlus;
    ImgLoading: TImage;
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
    procedure btnConfigsMouseLeave(Sender: TObject);
    procedure btnCloseMouseEnter(Sender: TObject);
    procedure btnCloseMouseLeave(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarGraficoProgresso;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  LoadingControll: Boolean;

implementation

{$R *.dfm}

uses views.login, Utils, views.config;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  { Arredondando os Componentes da Tela }
  ArredondarCantos(EditConsTodo);
  ArredondarCantos(frmMain);
  ArredondarCantos5(pnSelected);
  ArredondarCantosCircular(pnImgPerfil);
  ArredondarCantos(pnConfigs);
  ArredondarCantos(pnConfig);
  ArredondarCantos(pnClose);

  { Carregando os dados }
  pnDashboardClick(Self);
end;

procedure TfrmMain.pnDashboardClick(Sender: TObject);
begin
  { Comportamento de cores e btn selecionado }
  pnSelected.Width := pnDashboard.Width;
  pnSelected.Left := pnDashboard.Left;
  pnDashboard.Font.Color := $FFFFFF;
  pnTodos.Font.Color := $3F2D15;
  ArredondarCantos5(pnSelected);

  { Abrindo a tab do pg }
  PG.ActivePage := TabSDashboard;

  { Controllando Loading }
  GraficoProgresso.Visible := False;

  { Carregando e executando a animação de loading }
  ImgLoading.Visible := True;
  ImgLoading.Picture.LoadFromFile(ExtractFileDir(Application.ExeName) +
    '\Imagens\LoadingGif.gif');
  (ImgLoading.Picture.Graphic as TGIFImage).Animate := True;

  { Carregando Gráfico }
  CarregarGraficoProgresso;

  { Verifico se carregou e troco o loading pelo o gráfico }
  if LoadingControll then
  begin
    ImgLoading.Visible := False;
    (ImgLoading.Picture.Graphic as TGIFImage).Animate := False;
    GraficoProgresso.Visible := True;
  end;

end;

procedure TfrmMain.pnTodosClick(Sender: TObject);
begin
  { Comportamento de cores e btn selecionado }
  pnSelected.Width := pnTodos.Width;
  pnSelected.Left := pnTodos.Left;
  pnTodos.Font.Color := $FFFFFF;
  pnDashboard.Font.Color := $3F2D15;
  ArredondarCantos5(pnSelected);

  { Abrindo a tab do pg }
  PG.ActivePage := TabSTodos;

  { Abrindo o frm dentro do pagecontrol }
  Application.CreateForm(TFrmTodo, frmTodo);
  frmTodo.Parent := TabSTodos;
  frmTodo.Align := alClient;
  frmTodo.BorderStyle := bsNone;
  frmTodo.Show;

end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.btnCloseMouseEnter(Sender: TObject);
begin
  { Efeito Hover }
  pnClose.Color := $0000A0E4;
end;

procedure TfrmMain.btnCloseMouseLeave(Sender: TObject);
begin
  { Efeito Hover }
  pnClose.Color := $0004B9FE;
end;

procedure TfrmMain.BtnConfigClick(Sender: TObject);
begin
  CriarFormularioShowModal(TFrmConfig, FrmConfig, 0);
end;

procedure TfrmMain.btnConfigsMouseEnter(Sender: TObject);
begin
  pnConfigs.Visible := True;
  { Efeito Hover }
  pnConfig.Color := $0000A0E4;
end;

procedure TfrmMain.btnConfigsMouseLeave(Sender: TObject);
begin
  { Efeito Hover }
  pnConfig.Color := $0004B9FE;
end;

procedure TfrmMain.btnConfigsUsersClick(Sender: TObject);
begin
  Application.CreateForm(TFrmConfig, FrmConfig);
  FrmConfig.ShowModal;
end;

procedure TfrmMain.btnConfigsUsersMouseLeave(Sender: TObject);
begin
  pnConfigs.Visible := False;
end;

procedure TfrmMain.btnConfigsUsersMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  pnConfigs.Visible := False;
end;

procedure TfrmMain.BtnTodoClick(Sender: TObject);
begin
  CriarFormularioShowModal(TFrmTodo, frmTodo, 0);
end;

procedure TfrmMain.CarregarGraficoProgresso;
var
  sError: String;
  cTodo: TTodosController;
  ResultPorStatus: TResultPorStatus;
begin
  { Criando instância da classe }
  cTodo := TTodosController.Create;

  try
    try
      { Executa a chamada e faz o calculo dos Todos mensais }
      ResultPorStatus := cTodo.ConsultaPorStatus(sError);

      { Como o gráfico é montado em tempo de execução e não com query, faço a limpeza
        com o clear e depois adiciono as informações }
      GraficoProgresso.Series[0].Clear;

      { Adiciono cada informação do Gráfico }
      GraficoProgresso.Series[0].Add(ResultPorStatus.Aguardando,
        'Aguardando ' + CalculaPorcentagem(ResultPorStatus.Total,
        ResultPorStatus.Aguardando), clRed);

      GraficoProgresso.Series[0].Add(ResultPorStatus.Realizando,
        'Realizando ' + CalculaPorcentagem(ResultPorStatus.Total,
        ResultPorStatus.Realizando), $004080FF);

      GraficoProgresso.Series[0].Add(ResultPorStatus.Pronto,
        'Pronto ' + CalculaPorcentagem(ResultPorStatus.Total,
        ResultPorStatus.Pronto), $0053A600);

      LoadingControll := ResultPorStatus.Loading;

    except
      on E: Exception do
        Mensagem(E.Message + #13 + sError);
    end;
  finally
    { Liberando da Memória }
    cTodo.Free;
  end;
end;

end.
