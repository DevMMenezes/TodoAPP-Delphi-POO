unit views.todo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Buttons, models.todo, controllers.todo, FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmTodo = class(TForm)
    DBGridAFazer: TDBCtrlGrid;
    DBGridFazendo: TDBCtrlGrid;
    DBGridPronto: TDBCtrlGrid;
    DSAFazer: TDataSource;
    DSRealizando: TDataSource;
    DSPronto: TDataSource;
    FDQueryAFazer: TFDQuery;
    FDQueryRealizando: TFDQuery;
    FDQueryPronto: TFDQuery;
    LblCod: TLabel;
    LblStatus: TLabel;
    DBTextCod: TDBText;
    FDQueryAFazerID: TIntegerField;
    DBTextNome: TDBText;
    Shape3: TShape;
    BtnAdd: TBitBtn;
    FDQueryAFazerTITULO: TStringField;
    FDQueryAFazerDESCRICAO: TStringField;
    FDQueryAFazerSTATUS: TStringField;
    Shape1: TShape;
    Label1: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    LblRealizando: TLabel;
    DBText3: TDBText;
    Label2: TLabel;
    Label3: TLabel;
    DBText4: TDBText;
    Shape2: TShape;
    procedure BtnAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTodo: TfrmTodo;

implementation

{$R *.dfm}

uses controllers.usuario;

procedure TfrmTodo.BtnAddClick(Sender: TObject);
var
  oTodo: TTodo;
  cTodo: TTodosController;
  sError: String;
begin
  oTodo := TTodo.Create;

  try
    try

    except
      on E: Exception do
      begin
        ShowMessage(E.Message + ' ' + sError);
      end;
    end;
  finally
  end;

end;

procedure TfrmTodo.FormShow(Sender: TObject);
var
  cTodo: TTodosController;
  sError: String;
begin
  cTodo.CarregaTodosPorStatus('A', FDQueryAFazer, DBGridAFazer,
    DSAFazer, sError);
  cTodo.CarregaTodosPorStatus('R', FDQueryRealizando, DBGridFazendo,
    DSRealizando, sError);
  cTodo.CarregaTodosPorStatus('P', FDQueryPronto, DBGridPronto,
    DSPronto, sError);
end;

end.
