program StandaloneServerAppTests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Spring.Container,
  Spring.Services,
  Midgard.Critical.Section.Impl in '..\..\common\Impl\Midgard.Critical.Section.Impl.pas',
  Midgard.Critical.Section in '..\..\common\Midgard.Critical.Section.pas',
  DUnitTestRunner,
  TestRESTFull.Web in 'TestRESTFull.Web.pas',
  Midgard.Crud.Repository in '..\core\Midgard.Crud.Repository.pas',
  Midgard.Crud.Service in '..\core\Midgard.Crud.Service.pas',
  Midgard.Crud.Repository.Impl in '..\core\Impl\Midgard.Crud.Repository.Impl.pas',
  Midgard.Crud.Service.Impl in '..\core\Impl\Midgard.Crud.Service.Impl.pas',
  RESTFull.Converter.Impl in '..\rest\Impl\RESTFull.Converter.Impl.pas',
  RESTFull.Container.Impl in '..\rest\Impl\RESTFull.Container.Impl.pas',
  RESTFull.Container in '..\rest\RESTFull.Container.pas',
  RESTFull.Controller in '..\rest\RESTFull.Controller.pas',
  RESTFull.Converter in '..\rest\RESTFull.Converter.pas',
  RESTFull.Standalone.Server in '..\rest\RESTFull.Standalone.Server.pas' {RESTFullStandaloneServer: TDataModule},
  RESTFull.Web.Module in '..\rest\RESTFull.Web.Module.pas' {RESTFullWebModule: TWebModule},
  Midgard.Base.Data.Module in '..\..\common\Midgard.Base.Data.Module.pas' {MidgardBaseDataModule: TDataModule},
  Pessoa in '..\entities\Pessoa.pas',
  Pessoa.Controller in '..\rest\controllers\Pessoa.Controller.pas',
  Pessoa.DTO in '..\rest\dtos\Pessoa.DTO.pas',
  Business.Context in '..\context\Business.Context.pas',
  Core.Context in '..\context\Core.Context.pas',
  Persistence.Context in '..\context\Persistence.Context.pas',
  RESTFull.Context in '..\context\RESTFull.Context.pas',
  FD.Connection in '..\persistence\FD.Connection.pas' {FDConnectionDataModule: TDataModule};

{R *.RES}

begin
  CoreContext.RegisterTypes(GlobalContainer);
  PersistenceContext.RegisterTypes(GlobalContainer);
  BusinessContext.RegisterTypes(GlobalContainer);
  RESTFullContext.RegisterTypes(GlobalContainer);

  DUnitTestRunner.RunRegisteredTests;
end.

