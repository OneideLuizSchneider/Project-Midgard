program StandaloneServerApp;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Main.View in 'view\Main.View.pas' {Form1},
  RESTFull.Web.Module in 'rest\RESTFull.Web.Module.pas' {RESTFullWebModule: TWebModule},
  Midgard.Base.Data.Module in '..\common\Midgard.Base.Data.Module.pas' {MidgardBaseDataModule: TDataModule},
  RESTFull.Standalone.Server in 'rest\RESTFull.Standalone.Server.pas' {MidgardBaseDataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
