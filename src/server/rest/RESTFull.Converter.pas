unit RESTFull.Converter;

interface

uses
  System.Generics.Collections,
  Spring.Collections;

type

  IRESTFullConverter<TEntity, TDTO: class, constructor; TKey> = interface
    ['{568C68EE-CB20-431B-AE1D-EFF808BF4D85}']
    function AsEntity(source: TDTO): TEntity;
    function AsEntities(source: TObjectList<TDTO>): IList<TEntity>;

    function AsDTO(source: TEntity): TDTO;
    function AsDTOs(source: IList<TEntity>): TObjectList<TDTO>;

    function KeyValue(source: TEntity): TKey; overload;
    function KeyValue(source: TDTO): TKey; overload;

    procedure Update(source: TDTO; target: TEntity); overload;
    procedure Update(source: TEntity; target: TDTO); overload;
  end;

implementation

end.
