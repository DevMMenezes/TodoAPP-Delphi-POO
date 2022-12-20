unit dao.dmconnection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, dao.getconnection;

type
  TdmConnection = class(TDataModule)
    FDConnection: TFDConnection;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure FDConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
    TGetCon: TGetConnection;

  public

  end;

var
  dmconnection: TdmConnection;

implementation

{$R *.dfm}

uses views.login, Vcl.Forms;

procedure TdmConnection.DataModuleCreate(Sender: TObject);
begin
  TGetCon := TGetConnection.Create(FDConnection);
  Application.CreateForm(TFrmLogin, FrmLogin);
  FrmLogin.showModal;

end;

procedure TdmConnection.DataModuleDestroy(Sender: TObject);
begin
  TGetCon.Destroy;
end;

procedure TdmConnection.FDConnectionBeforeConnect(Sender: TObject);
begin

  if not TGetCon.fGetConnectionData then
    raise Exception.Create('Erro ao Conectar ao Banco de Dados');
end;

end.
