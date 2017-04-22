program StandaloneServerApp;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Spring.Container,
  Spring.Services,
  Main.View in 'view\Main.View.pas' {MainView},
  RESTFull.Web.Module in 'rest\RESTFull.Web.Module.pas' {RESTFullWebModule: TWebModule},
  Midgard.Base.Data.Module in '..\common\Midgard.Base.Data.Module.pas' {MidgardBaseDataModule: TDataModule},
  RESTFull.Standalone.Server in 'rest\RESTFull.Standalone.Server.pas' {RESTFullStandaloneServer: TDataModule},
  RESTFull.Context in 'context\RESTFull.Context.pas',
  RESTFull.Container in 'rest\RESTFull.Container.pas',
  RESTFull.Controller in 'rest\RESTFull.Controller.pas',
  Midgard.Critical.Section in '..\common\Midgard.Critical.Section.pas',
  Midgard.Crud.Service in 'core\Midgard.Crud.Service.pas',
  Midgard.Crud.Repository in 'core\Midgard.Crud.Repository.pas',
  RESTFull.Converter in 'rest\RESTFull.Converter.pas',
  RESTFull.Container.Impl in 'rest\Impl\RESTFull.Container.Impl.pas',
  View.Context in 'context\View.Context.pas',
  Pessoa.Controller in 'rest\controllers\Pessoa.Controller.pas',
  Pessoa.DTO in 'rest\dtos\Pessoa.DTO.pas',
  Pessoa in 'entities\Pessoa.pas',
  RESTFull.Converter.Impl in 'rest\Impl\RESTFull.Converter.Impl.pas',
  FD.Connection in 'persistence\FD.Connection.pas' {FDConnectionDataModule: TDataModule},
  Persistence.Context in 'context\Persistence.Context.pas',
  Midgard.Crud.Repository.Impl in 'core\Impl\Midgard.Crud.Repository.Impl.pas',
  Core.Context in 'context\Core.Context.pas',
  Midgard.Critical.Section.Impl in '..\common\Impl\Midgard.Critical.Section.Impl.pas',
  Business.Context in 'context\Business.Context.pas',
  Midgard.Crud.Service.Impl in 'core\Impl\Midgard.Crud.Service.Impl.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  ViewContext.RegisterTypes(GlobalContainer);
  CoreContext.RegisterTypes(GlobalContainer);
  PersistenceContext.RegisterTypes(GlobalContainer);
  BusinessContext.RegisterTypes(GlobalContainer);
  RESTFullContext.RegisterTypes(GlobalContainer);

  Application.Initialize;

  ServiceLocator.GetService<TRESTFullStandaloneServer>;
  ServiceLocator.GetService<TMainView>;

  Application.Run;
end.
