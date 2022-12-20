unit views.todo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmTodo = class(TForm)
    DBGridAFazer: TDBGrid;
    DBGridFazendo: TDBGrid;
    DBGridFeito: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTodo: TfrmTodo;

implementation

{$R *.dfm}

end.
