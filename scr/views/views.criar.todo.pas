unit views.criar.todo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  models.todo, controllers.todo, dxGDIPlusClasses, Utils;

type
  TFrmCriarTodo = class(TForm)
    LblTitulo: TLabel;
    LblDescricao: TLabel;
    EdtTitulo: TEdit;
    MMDesc: TMemo;
    pnTopBar: TPanel;
    BtnOK: TPanel;
    pnClose: TPanel;
    btnClose: TImage;
    procedure BtnOKClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCriarTodo: TFrmCriarTodo;

implementation

{$R *.dfm}

uses views.todo;

procedure TFrmCriarTodo.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCriarTodo.BtnOKClick(Sender: TObject);
var
  oTodo: TTodo;
  cTodo: TTodosController;
  sError: String;
begin
  { Criamos instância de model e controller }
  oTodo := TTodo.Create;
  cTodo := TTodosController.Create;

  try
    try
      oTodo.Titulo := EdtTitulo.Text;
      oTodo.Descricao := MMDesc.Lines.Text;
      oTodo.Status := 'A';

      cTodo.Inserir(oTodo, sError);

      Mensagem('Todo Criado com Sucesso!');

      frmTodo.AtualizarDadosTDBCtrlGrid;

      Close;
    except
      on E: Exception do
      begin
        Mensagem(E.message + sError);
      end;
    end;
  finally
    { Liberando as instâncias da memória }
    oTodo.Free;
    cTodo.Free;
  end;
end;

procedure TFrmCriarTodo.FormShow(Sender: TObject);
begin
  ArredondarCantos(FrmCriarTodo);
  ArredondarCantos(BtnOK);
end;

end.
