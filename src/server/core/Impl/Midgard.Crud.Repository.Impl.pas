unit Midgard.Crud.Repository.Impl;

interface

uses
  Spring.Persistence.Core.Repository.Simple,
  Midgard.Crud.Repository;

type

  TCrudRepository<TEntity: class, constructor; TKey> = class(TSimpleRepository<TEntity, TKey>, ICrudRepository<TEntity, TKey>)
  end;

implementation

end.
