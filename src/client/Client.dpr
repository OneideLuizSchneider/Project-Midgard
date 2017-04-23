program Client;

uses
  Vcl.Forms,
  Spring.Container,
  Spring.Services,
  Main.View in 'view\Main.View.pas' {MainView},
  Pessoa.View in 'view\Pessoa.View.pas' {PessoaView},
  View.Context in 'context\View.Context.pas',
  RESTFullClient.Context in 'context\RESTFullClient.Context.pas',
  Midgard.Base.View in '..\common\Midgard.Base.View.pas' {MidgardBaseView},
  Midgard.Base.Data.Module in '..\common\Midgard.Base.Data.Module.pas' {MidgardBaseDataModule: TDataModule},
  Midgard.Base.Client.View in 'common\Midgard.Base.Client.View.pas' {BaseClientView},
  Pessoa.DTO in '..\server\rest\dtos\Pessoa.DTO.pas',
  Midgard.Base.Persistence in 'common\Midgard.Base.Persistence.pas' {MidgardBasePersistence: TDataModule},
  Midgard.Crud.Persistence in 'common\Midgard.Crud.Persistence.pas' {MidgardCrudPersistence: TDataModule},
  Pessoa.Persistence in 'persistence\Pessoa.Persistence.pas' {PessoaPersistence: TDataModule},
  Persistence.Context in 'context\Persistence.Context.pas',
  Resource.Context in 'context\Resource.Context.pas',
  Midgard.Crud.Resource in 'common\Midgard.Crud.Resource.pas',
  Midgard.Crud.Resource.Impl in 'common\Impl\Midgard.Crud.Resource.Impl.pas',
  Midgard.Exceptions in '..\common\Midgard.Exceptions.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  TViewContext.RegisterTypes(GlobalContainer);
  TRESTFullClientContext.RegisterTypes(GlobalContainer);
  TPersistenceContext.RegisterTypes(GlobalContainer);
  TResourceContext.RegisterTypes(GlobalContainer);

  Application.Initialize;

  ServiceLocator.GetService<TMainView>;

  Application.Run;
end.
