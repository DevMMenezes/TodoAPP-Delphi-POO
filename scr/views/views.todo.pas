unit views.todo;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.DBCGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.DBCtrls,
  Vcl.Buttons,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Vcl.AppEvnts,
  models.todo,
  controllers.todo;

type
  TfrmTodo = class(TForm)
    DBGridFazendo: TDBCtrlGrid;
    DBGridPronto: TDBCtrlGrid;
    DSAFazer: TDataSource;
    DSRealizando: TDataSource;
    DSPronto: TDataSource;
    FDQueryAFazer: TFDQuery;
    FDQueryRealizando: TFDQuery;
    FDQueryPronto: TFDQuery;
    Label1: TLabel;
    DBTextCodR: TDBText;
    DBTextDescR: TDBText;
    LblRealizando: TLabel;
    DBTextDescP: TDBText;
    Label2: TLabel;
    Label3: TLabel;
    DBTextCodP: TDBText;
    DBGridAFazer: TDBCtrlGrid;
    DBTextCodA: TDBText;
    DBTextDescA: TDBText;
    LblCod: TLabel;
    LblStatus: TLabel;
    ApplicationEvents: TApplicationEvents;
    pnStatusR: TPanel;
    pnStatusP: TPanel;
    pnStatusA: TPanel;
    pnAguardando: TPanel;
    pnRealizando: TPanel;
    pnPronto: TPanel;
    pnAdicionar: TPanel;
    procedure FormShow(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure DBGridProntoDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DBGridAFazerDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure AtualizarDadosTDBCtrlGrid;
    procedure DBGridFazendoDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DBGridProntoDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure pnAdicionarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTodo: TfrmTodo;

implementation

{$R *.dfm}

uses controllers.usuario, Utils, dao.dmconnection, views.criar.todo;

procedure TfrmTodo.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
var
  i: smallint;
begin
  if (Msg.message = WM_MOUSEWHEEL) then
  begin
    Msg.message := WM_KEYDOWN;
    Msg.lParam := 0;
    i := HiWord(Msg.wParam);
    if i > 0 then
      Msg.wParam := VK_UP
    else
      Msg.wParam := VK_DOWN;
    Handled := False;
  end;
end;

procedure TfrmTodo.AtualizarDadosTDBCtrlGrid;
var
  cTodo: TTodosController;
  sError: String;
begin
  cTodo := TTodosController.Create;
  try
    { Carrega todos os DBGrids Atualizados }
    cTodo.CarregaTodosPorStatus('A', FDQueryAFazer, DBGridAFazer,
      DSAFazer, sError);
    cTodo.CarregaTodosPorStatus('R', FDQueryRealizando, DBGridFazendo,
      DSRealizando, sError);
    cTodo.CarregaTodosPorStatus('P', FDQueryPronto, DBGridPronto,
      DSPronto, sError);
  finally
    cTodo.Free;
  end;
end;


procedure TfrmTodo.DBGridAFazerDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  oTodo: TTodo;
  cTodo: TTodosController;
  sError: String;
begin
  { Criamos instância de model e controller }
  oTodo := TTodo.Create;
  cTodo := TTodosController.Create;

  { Validação de qual DBGrid está vindo o Drag }
  try
    try
      case TDBCtrlGrid(Source).Tag of
        1:
          begin
            { A fazer }
            oTodo.ID := StrToInt(DBTextCodA.Caption);
            oTodo.Status := 'A';
            cTodo.UpdateStatusDragDrop(oTodo, sError);
          end;
        2:
          begin
            { Realizando }
            oTodo.ID := StrToInt(DBTextCodR.Caption);
            oTodo.Status := 'A';
            cTodo.UpdateStatusDragDrop(oTodo, sError);
          end;
        3:
          begin
            { Pronto }
            oTodo.ID := StrToInt(DBTextCodP.Caption);
            oTodo.Status := 'A';
            cTodo.UpdateStatusDragDrop(oTodo, sError);
          end;
      end;
    except
      on E: Exception do
      begin
        ShowMessage(E.message + sError);
      end;
    end;
  finally
    { Liberando as instâncias da memória e atualizando os DBgrids }
    oTodo.Free;
    cTodo.Free;
    AtualizarDadosTDBCtrlGrid;
  end;
end;

procedure TfrmTodo.DBGridFazendoDragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
  oTodo: TTodo;
  cTodo: TTodosController;
  sError: String;
begin
  { Criamos instância de model e controller }
  oTodo := TTodo.Create;
  cTodo := TTodosController.Create;

  { Validação de qual DBGrid está vindo o Drag }
  try
    try
      case TDBCtrlGrid(Source).Tag of
        1:
          begin
            { A fazer }
            oTodo.ID := StrToInt(DBTextCodA.Caption);
            oTodo.Status := 'R';
            cTodo.UpdateStatusDragDrop(oTodo, sError);
          end;
        2:
          begin
            { Realizando }
            oTodo.ID := StrToInt(DBTextCodR.Caption);
            oTodo.Status := 'R';
            cTodo.UpdateStatusDragDrop(oTodo, sError);
          end;
        3:
          begin
            { Pronto }
            oTodo.ID := StrToInt(DBTextCodP.Caption);
            oTodo.Status := 'R';
            cTodo.UpdateStatusDragDrop(oTodo, sError);
          end;
      end;
    except
      on E: Exception do
      begin
        ShowMessage(E.message + sError);
      end;
    end;
  finally
    { Liberando as instâncias da memória e atualizando os DBgrids }
    oTodo.Free;
    cTodo.Free;
    AtualizarDadosTDBCtrlGrid;
  end;
end;

procedure TfrmTodo.DBGridProntoDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  oTodo: TTodo;
  cTodo: TTodosController;
  sError: String;
begin
  { Criamos instância de model e controller }
  oTodo := TTodo.Create;
  cTodo := TTodosController.Create;

  { Validação de qual DBGrid está vindo o Drag }
  try
    try
      case TDBCtrlGrid(Source).Tag of
        1:
          begin
            { A fazer }
            oTodo.ID := StrToInt(DBTextCodA.Caption);
            oTodo.Status := 'P';
            cTodo.UpdateStatusDragDrop(oTodo, sError);
          end;
        2:
          begin
            { Realizando }
            oTodo.ID := StrToInt(DBTextCodR.Caption);
            oTodo.Status := 'P';
            cTodo.UpdateStatusDragDrop(oTodo, sError);
          end;
        3:
          begin
            { Pronto }
            oTodo.ID := StrToInt(DBTextCodP.Caption);
            oTodo.Status := 'P';
            cTodo.UpdateStatusDragDrop(oTodo, sError);
          end;
      end;
    except
      on E: Exception do
      begin
        ShowMessage(E.message + sError);
      end;
    end;
  finally
    { Liberando as instâncias da memória e atualizando os DBgrids }
    oTodo.Free;
    cTodo.Free;
    AtualizarDadosTDBCtrlGrid;
  end;
end;

procedure TfrmTodo.DBGridProntoDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := Sender is (TDBCtrlGrid);
end;

procedure TfrmTodo.FormShow(Sender: TObject);
begin
  { Carrega os PNs de Legendas Arredondados }
  ArredondarCantos(pnAguardando);
  ArredondarCantos(pnRealizando);
  ArredondarCantos(pnPronto);
  ArredondarCantos(pnAdicionar);

  { Atualiza os DBGrids }
  AtualizarDadosTDBCtrlGrid;
end;

procedure TfrmTodo.pnAdicionarClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCriarTodo, FrmCriarTodo);
  FrmCriarTodo.Tag := 0;
  FrmCriarTodo.ShowModal;
end;

end.
