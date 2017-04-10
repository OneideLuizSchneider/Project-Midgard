unit Midgard.Crud.Service;

interface

uses
  Spring.Collections,
  Midgard.Crud.Repository;

type

  ICrudService<TEntity: class, constructor; TKey; IRepository: ICrudRepository<TEntity, TKey>> = interface(IInvokable)
    ['{88115C9C-5C17-4E75-97B0-37915C65020E}']
    function Count: Integer;

    function FindOne(const id: TKey): TEntity;
    function FindAll: IList<TEntity>;

    function Exists(const id: TKey): Boolean;

    procedure Insert(const entity: TEntity); overload;
    procedure Insert(const entities: IEnumerable<TEntity>); overload;

    function Save(const entity: TEntity): TEntity; overload;
    function Save(const entities: IEnumerable<TEntity>): IEnumerable<TEntity>; overload;
    procedure SaveCascade(const entity: TEntity);

    procedure Delete(const entity: TEntity); overload;
    procedure Delete(const entities: IEnumerable<TEntity>); overload;
    procedure DeleteAll;
  end;

implementation

end.
