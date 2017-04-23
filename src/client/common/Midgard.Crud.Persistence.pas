unit Midgard.Crud.Persistence;

interface

uses
  System.SysUtils, System.Classes, Midgard.Base.Persistence, System.Rtti, Midgard.Crud.Resource,
  Spring.Data.ObjectDataset, Spring.Collections, Data.DB;

type

  TMidgardCrudPersistence = class(TMidgardBasePersistence)
  strict private
    { private declarations }
  strict protected
    procedure FindOne<TDTO: class, constructor; TKey>(const resource: IMidgardCrudResource<TDTO, TKey>; const dataSet: TObjectDataset; const id: TKey);
    procedure FindAll<TDTO: class, constructor; TKey>(const resource: IMidgardCrudResource<TDTO, TKey>; const dataSet: TObjectDataset);
    procedure Insert<TDTO: class, constructor; TKey>(const resource: IMidgardCrudResource<TDTO, TKey>; const dataSet: TObjectDataset; const idField: TField);
    procedure Update<TDTO: class, constructor; TKey>(const resource: IMidgardCrudResource<TDTO, TKey>; const dataSet: TObjectDataset; const id: TKey);
    procedure Delete<TDTO: class, constructor; TKey>(const resource: IMidgardCrudResource<TDTO, TKey>; const dataSet: TObjectDataset; const id: TKey);
  public
    procedure ApplyFindOne(const id: TValue); virtual; abstract;
    procedure ApplyFindAll; virtual; abstract;
    procedure ApplyInsert; virtual; abstract;
    procedure ApplyUpdate; virtual; abstract;
    procedure ApplyDelete; virtual; abstract;
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

{ TMidgardCrudPersistence }

procedure TMidgardCrudPersistence.Delete<TDTO, TKey>(
  const resource: IMidgardCrudResource<TDTO, TKey>; const dataSet: TObjectDataset;
  const id: TKey);
begin
  resource.Delete(id);
  dataSet.Delete;
end;

procedure TMidgardCrudPersistence.FindAll<TDTO, TKey>(
  const resource: IMidgardCrudResource<TDTO, TKey>;
  const dataSet: TObjectDataset);
begin
  dataSet.Close;
  dataSet.DataList := resource.FindAll as IObjectList;
  dataSet.Open;
end;

procedure TMidgardCrudPersistence.FindOne<TDTO, TKey>(
  const resource: IMidgardCrudResource<TDTO, TKey>; const dataSet: TObjectDataset;
  const id: TKey);
begin
  dataSet.Close;
  dataSet.DataList := resource.FindOneAsList(id) as IObjectList;
  dataSet.Open;
end;

procedure TMidgardCrudPersistence.Insert<TDTO, TKey>(
  const resource: IMidgardCrudResource<TDTO, TKey>; const dataSet: TObjectDataset;
  const idField: TField);
var
  idGenerated: TKey;
begin
  idGenerated := resource.Insert(dataSet.GetCurrentModel<TDTO>);
  dataSet.Edit;
  idField.AsVariant := TValue.From<TKey>(idGenerated).AsVariant;
  dataSet.Post;
end;

procedure TMidgardCrudPersistence.Update<TDTO, TKey>(
  const resource: IMidgardCrudResource<TDTO, TKey>; const dataSet: TObjectDataset;
  const id: TKey);
begin
  resource.Update(id, dataSet.GetCurrentModel<TDTO>);
end;

end.
