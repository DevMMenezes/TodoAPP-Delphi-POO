program TodoAPP;

uses
  Vcl.Forms,
  views.login in 'scr\views\views.login.pas' {frmLogin} ,
  Utils in 'scr\utils\Utils.pas',
  models.usuario in 'scr\models\models.usuario.pas',
  controllers.usuario in 'scr\controllers\controllers.usuario.pas',
  dao.dmconnection
    in 'scr\dao\dao.dmconnection.pas' {dmConnection: TDataModule} ,
  dao.getconnection in 'scr\dao\dao.getconnection.pas',
  views.main in 'scr\views\views.main.pas' {frmMain} ,
  views.todo in 'scr\views\views.todo.pas' {frmTodo} ,
  views.config in 'scr\views\views.config.pas' {frmConfig} ,
  views.criar.usuario in 'scr\views\views.criar.usuario.pas' {frmCriarUsuarios};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdmconnection, dmconnection);
  Application.CreateForm(TfrmConfig, frmConfig);
  Application.CreateForm(TfrmCriarUsuarios, frmCriarUsuarios);
  Application.Run;

end.
