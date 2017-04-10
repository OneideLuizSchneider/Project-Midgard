unit Persistence.Context;

interface

uses
  Spring.Container;

type
  PersistenceContext = class sealed
    class procedure RegisterTypes(const container: TContainer); static;
  end;
implementation

uses
  Spring.Services,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Core.Session,
  Spring.Persistence.Core.Repository.Proxy,
  FD.Connection,
  Midgard.Crud.Repository, Midgard.Crud.Repository.Impl,
  Pessoa;

class procedure PersistenceContext.RegisterTypes(const container: TContainer);
begin
  container.RegisterType<TFDConnectionDataModule>.Implements<IDBConnection>.AsSingleton;
  container.RegisterType<TSession>.AsSingleton;

  container.RegisterType<ICrudRepository<TPessoa, Int64>, TCrudRepository<TPessoa, Int64>>;

  container.Build;
end;

end.
