unit RESTFull.Converter.Impl;

interface

uses
  System.Rtti,
  System.SysUtils,
  System.Generics.Collections,
  Spring.Collections,
  Spring.Reflection,
  RESTFull.Converter;

type

  TRESTFullConverter<TEntity, TDTO: class, constructor; TKey> = class(TInterfacedObject, IRESTFullConverter<TEntity, TDTO, TKey>)
  strict private
  strict protected
    function AsEntity(source: TDTO): TEntity; virtual;
    function AsEntities(source: TObjectList<TDTO>): IList<TEntity>; virtual;

    function AsDTO(source: TEntity): TDTO; virtual;
    function AsDTOs(source: IList<TEntity>): TObjectList<TDTO>; virtual;

    function KeyValue(source: TEntity): TKey; overload; virtual;
    function KeyValue(source: TDTO): TKey; overload; virtual;

    procedure Update(source: TDTO; target: TEntity); overload; virtual;
    procedure Update(source: TEntity; target: TDTO); overload; virtual;
  public
  end;

implementation


{ TRESTFullConverter<TEntity, TDTO, TKey> }

function TRESTFullConverter<TEntity, TDTO, TKey>.AsDTO(source: TEntity): TDTO;
begin
  Result := TDTO.Create;
  Update(source, Result);
end;

function TRESTFullConverter<TEntity, TDTO, TKey>.AsDTOs(
  source: IList<TEntity>): TObjectList<TDTO>;
var
  entity: TEntity;
begin
  Result := TObjectList<TDTO>.Create;
  for entity in source do
    Result.Add(AsDTO(entity));
end;

function TRESTFullConverter<TEntity, TDTO, TKey>.AsEntities(
  source: TObjectList<TDTO>): IList<TEntity>;
var
  dto: TDTO;
begin
  Result := TCollections.CreateList<TEntity>;
  for dto in source do
    Result.Add(AsEntity(dto));
end;

function TRESTFullConverter<TEntity, TDTO, TKey>.AsEntity(
  source: TDTO): TEntity;
begin
  Result := TEntity.Create;
  Update(source, Result);
end;

function TRESTFullConverter<TEntity, TDTO, TKey>.KeyValue(
  source: TEntity): TKey;
begin
  Result := TType.GetType(TEntity).GetProperty('Id').GetValue(source).AsType<TKey>;
end;

function TRESTFullConverter<TEntity, TDTO, TKey>.KeyValue(source: TDTO): TKey;
begin
  Result := TType.GetType(TDTO).GetProperty('Id').GetValue(source).AsType<TKey>;
end;

procedure TRESTFullConverter<TEntity, TDTO, TKey>.Update(source: TDTO;
  target: TEntity);
var
  tProp: TRttiProperty;
begin
  TType.GetType(TDTO).Properties.ForEach(
    procedure(const sProp: TRttiProperty)
    begin
      tProp := TType.GetType(TEntity).GetProperty(sProp.Name);
      if (tProp <> nil) and (tProp.IsWritable) then
        tProp.SetValue(target, sProp.GetValue(source));
    end
    );
end;

procedure TRESTFullConverter<TEntity, TDTO, TKey>.Update(source: TEntity;
target: TDTO);
var
  tProp: TRttiProperty;
begin
  TType.GetType(TEntity).Properties.ForEach(
    procedure(const sProp: TRttiProperty)
    begin
      tProp := TType.GetType(TDTO).GetProperty(sProp.Name);
      if (tProp <> nil) and (tProp.IsWritable) then
        tProp.SetValue(target, sProp.GetValue(source));
    end
    );
end;

end.
