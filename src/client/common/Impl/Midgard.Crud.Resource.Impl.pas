unit Midgard.Crud.Resource.Impl;

interface

uses
  System.SysUtils,
  System.Rtti,
  System.Generics.Collections,
  Spring.Collections,
  Midgard.Crud.Resource,
  MVCFramework.Commons,
  MVCFramework.RESTClient,
  Midgard.Exceptions;

type

  ECrudResourceException = class(EBaseAppException);

  TMidgardCrudResource<TDTO: class, constructor; TKey> = class(TInterfacedObject, IMidgardCrudResource<TDTO, TKey>)
  strict private
    FRESTFullClient: TRESTClient;
    FPath: string;
  strict private
    function GetPath: string;
    function GetAnnotedPath: string;
    procedure SetPath(const value: string);
  strict protected
    function FindOne(const id: TKey): TDTO; virtual;
    function FindOneAsList(const id: TKey): IList<TDTO>; virtual;
    function FindAll: IList<TDTO>; virtual;

    function Insert(const dto: TDTO): TKey; virtual;
    procedure Update(const id: TKey; const dto: TDTO); virtual;
    procedure Delete(const id: TKey); virtual;

    property Path: string read GetPath write SetPath;
  public
    constructor Create(const restClient: TRESTClient); virtual;
    destructor Destroy; override;
  end;

  ResourcePathAttribute = class(TCustomAttribute)
  strict private
    FValue: string;
  public
    constructor Create(const value: string);

    property Value: string read FValue;
  end;

implementation

uses
  Spring.Reflection;

{ ResourcePathAttribute }

constructor ResourcePathAttribute.Create(const value: string);
begin
  FValue := value;
end;

{ TCrudResource<TDTO, TKey> }

constructor TMidgardCrudResource<TDTO, TKey>.Create(const restClient: TRESTClient);
begin
  inherited Create;
  FRESTFullClient := restClient;
  FPath := EmptyStr;
end;

procedure TMidgardCrudResource<TDTO, TKey>.Delete(const id: TKey);
var
  response: IRESTResponse;
begin
  response := FRESTFullClient.Resource(Path).Params([TValue.From<TKey>(id).ToString]).doDELETE;
  case response.ResponseCode of
    HTTP_STATUS.OK, HTTP_STATUS.NoContent:
      Exit;
    HTTP_STATUS.NotFound:
      raise ENotFoundException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  else
    raise EInternalErrorException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  end;
end;

destructor TMidgardCrudResource<TDTO, TKey>.Destroy;
begin
  FRESTFullClient.Free;
  inherited;
end;

function TMidgardCrudResource<TDTO, TKey>.FindAll: IList<TDTO>;
var
  response: IRESTResponse;
  dtoList: TObjectList<TDTO>;
  dto: TDTO;
begin
  Result := nil;
  response := FRESTFullClient.Resource(Path).doGET;
  case response.ResponseCode of
    HTTP_STATUS.OK:
      begin
        dtoList := response.BodyAsJSONArray.AsObjectList<TDTO>;
        try
          dtoList.OwnsObjects := False;
          Result := TCollections.CreateObjectList<TDTO>;
          for dto in dtoList do
            Result.Add(dto);
        finally
          dtoList.Free;
        end;
      end;
    HTTP_STATUS.NoContent:
      raise ENoContentException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
    HTTP_STATUS.NotFound:
      raise ENotFoundException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  else
    raise EInternalErrorException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  end;
end;

function TMidgardCrudResource<TDTO, TKey>.GetAnnotedPath: string;
var
  rttiType: TRttiType;
  attr: TCustomAttribute;
begin
  Result := EmptyStr;
  rttiType := TType.GetType(Self.ClassType);
  for attr in rttiType.GetAttributes do
    if (attr is ResourcePathAttribute) then
      Exit(ResourcePathAttribute(attr).Value);
end;

function TMidgardCrudResource<TDTO, TKey>.FindOne(const id: TKey): TDTO;
var
  response: IRESTResponse;
begin
  Result := nil;
  response := FRESTFullClient.Resource(Path).Params([TValue.From<TKey>(id).ToString]).doGET;
  case response.ResponseCode of
    HTTP_STATUS.OK:
      Result := response.BodyAsJSONObject.AsObject<TDTO>;
    HTTP_STATUS.NotFound:
      raise ENotFoundException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  else
    raise EInternalErrorException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  end;
end;

function TMidgardCrudResource<TDTO, TKey>.FindOneAsList(const id: TKey): IList<TDTO>;
var
  dto: TDTO;
begin
  Result := nil;
  dto := FindOne(id);
  if (dto <> nil) then
  begin
    Result := TCollections.CreateObjectList<TDTO>;
    Result.Add(dto);
  end;
end;

function TMidgardCrudResource<TDTO, TKey>.GetPath: string;
begin
  if FPath.IsEmpty then
    FPath := GetAnnotedPath;

  if FPath.IsEmpty then
    raise ECrudResourceException.Create('Resource Path undefined');

  Result := FPath;
end;

function TMidgardCrudResource<TDTO, TKey>.Insert(const dto: TDTO): TKey;
var
  response: IRESTResponse;
begin
  response := FRESTFullClient.Resource(Path).doPOST<TDTO>(dto, False);
  case response.ResponseCode of
    HTTP_STATUS.OK, HTTP_STATUS.Created:
      Exit(TValue.From<Int64>(response.BodyAsString.ToInt64).AsType<TKey>);
    HTTP_STATUS.NotFound:
      raise ENotFoundException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
    HTTP_STATUS.BadRequest:
      raise EBadRequestException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  else
    raise EInternalErrorException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  end;
end;

procedure TMidgardCrudResource<TDTO, TKey>.SetPath(const value: string);
begin
  FPath := value;
end;

procedure TMidgardCrudResource<TDTO, TKey>.Update(const id: TKey; const dto: TDTO);
var
  response: IRESTResponse;
begin
  response := FRESTFullClient.Resource(Path).Params([TValue.From<TKey>(id).ToString]).doPUT<TDTO>(dto, False);
  case response.ResponseCode of
    HTTP_STATUS.OK, HTTP_STATUS.NoContent:
      Exit;
    HTTP_STATUS.NotFound:
      raise ENotFoundException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
    HTTP_STATUS.BadRequest:
      raise EBadRequestException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  else
    raise EInternalErrorException.Create(response.ResponseCode.ToString + ' - ' + response.ResponseText);
  end;
end;

end.
