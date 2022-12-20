unit dao.getconnection;

interface

uses
   FireDAC.Comp.Client,
   FireDAC.Stan.Intf;

type
   TGetConnection = class
   private
      FConnection: TFDConnection;
      FServidor: String;
      FLogin: String;
      FSenha: String;
      FPorta: String;
      FBase: String;
      FMsgError: String;

   public
      constructor Create(NameConnection: TFDConnection);
      destructor Destroy; override;

      function fGetConnectionData: boolean;

      property Connection: TFDConnection read FConnection write FConnection;
      property Servidor: String read FServidor write FServidor;
      property Login: String read FLogin write FLogin;
      property Senha: String read FSenha write FSenha;
      property Porta: String read FPorta write FPorta;
      property Base: String read FBase write FBase;
      property MsgError: String read FMsgError write FMsgError;

   end;

implementation

uses
   System.SysUtils;

{ TGetConnection }

constructor TGetConnection.Create(NameConnection: TFDConnection);
begin
   FConnection := NameConnection;

   FServidor := 'localhost';
   FLogin := 'root';
   FSenha := 'masterkey';
   FPorta := '3306';
   FBase := 'todoapp';
end;

destructor TGetConnection.Destroy;
begin
   FConnection.Connected := False;
   inherited;
end;

function TGetConnection.fGetConnectionData: boolean;
begin
   Result := True;

   try
      with FConnection do
      begin
         Params.Clear;
         Params.Values['server'] := FServidor; // localhost
         Params.Values['user_name'] := FLogin; // root
         Params.Values['password'] := FSenha; // masterkey
         Params.Values['port'] := FPorta; // 3306
         Params.Values['database'] := FBase; // SUPORTE
         Params.Values['DriverID'] := 'mySQL';
      end;

   except
      on e: Exception do
      begin
         FMsgError := e.Message;
         Result := False;
      end;
   end;

end;

end.
