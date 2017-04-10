unit Midgard.Crud.Repository;

interface

uses
  Spring.Persistence.Core.Interfaces;

type

  ICrudRepository<TEntity: class, constructor; TKey> = interface(IPagedRepository<TEntity, TKey>)
    ['{C9B067F1-CD9F-4910-889D-8B485D10302D}']
  end;

implementation

end.
