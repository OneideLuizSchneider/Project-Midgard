unit Business.Context;

interface

uses
  Spring.Container;

type
  BusinessContext = class sealed
    class procedure RegisterTypes(const container: TContainer); static;
  end;
implementation

uses
  Midgard.Crud.Service, Midgard.Crud.Service.Impl, Midgard.Crud.Repository,
  Pessoa;

class procedure BusinessContext.RegisterTypes(const container: TContainer);
begin
  container.RegisterType<ICrudService<TPessoa, Int64, ICrudRepository<TPessoa, Int64>>, TCrudService<TPessoa, Int64, ICrudRepository<TPessoa, Int64>>>;

  container.Build;
end;

end.

