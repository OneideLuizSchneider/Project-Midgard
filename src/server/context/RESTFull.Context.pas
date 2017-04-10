unit RESTFull.Context;

interface

uses
  Spring.Container;

type
  RESTFullContext = class sealed
    class procedure RegisterTypes(const container: TContainer); static;
  end;

implementation

uses
  RESTFull.Standalone.Server,
  RESTFull.Container, RESTFull.Container.Impl, RESTFull.Converter, RESTFull.Converter.Impl,
  RESTFull.Controller,
  Pessoa, Pessoa.DTO, Pessoa.Controller;

{ RESTFullContext }

class procedure RESTFullContext.RegisterTypes(const container: TContainer);
begin
  container.RegisterType<TRESTFullStandaloneServer>.AsSingleton;
  container.RegisterType<IRESTFullContainer, TRESTFullContainer>.AsSingleton;

  container.RegisterType<IRESTFullConverter<TPessoa, TPessoaDTO, Int64>, TRESTFullConverter<TPessoa, TPessoaDTO, Int64>>;
  container.RegisterType<TPessoaController>;

  container.Build;
end;

end.
