unit Resource.Context;

interface

uses
  Spring.Services,
  Spring.Container;

type
  TResourceContext = class sealed
  public
    class procedure RegisterTypes(const container: TContainer); static;
  end;

implementation

uses
  Pessoa.DTO,
  Midgard.Crud.Resource, Midgard.Crud.Resource.Impl,
  MVCFramework.RESTClient;

class procedure TResourceContext.RegisterTypes(const container: TContainer);
begin
  container.RegisterType<IMidgardCrudResource<TPessoaDTO, Int64>>.DelegateTo(
    function: IMidgardCrudResource<TPessoaDTO, Int64>
    begin
      Result := TMidgardCrudResource<TPessoaDTO, Int64>.Create(ServiceLocator.GetService<TRESTClient>);
      Result.Path := '/pessoa';
    end
    );

  container.Build;
end;

end.
