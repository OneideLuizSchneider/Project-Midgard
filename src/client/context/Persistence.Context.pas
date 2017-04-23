unit Persistence.Context;

interface

uses
  Spring.Container;

type
  TPersistenceContext = class sealed
  public
    class procedure RegisterTypes(const container: TContainer); static;
  end;

implementation

uses  
  Pessoa.Persistence;

class procedure TPersistenceContext.RegisterTypes(const container: TContainer);
begin 
  container.RegisterType<TPessoaPersistence>;

  container.Build;
end;

end.
