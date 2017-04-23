unit RESTFull.Controller;

interface

uses
  System.Rtti,
  System.SysUtils,
  MVCFramework,
  MVCFramework.Commons,
  Spring.Services,
  Spring.Collections,
  Midgard.Critical.Section,
  Midgard.Crud.Service,
  Midgard.Crud.Repository,
  RESTFull.Converter;

type

  ERESTFullControllerException = class(Exception);

  TRESTFullController = class(TMVCController)
  end;

  TRESTFullControllerClass = class of TRESTFullController;

  TCrudController<TEntity, TDTO: class, constructor; TKey; IRepository: ICrudRepository<TEntity, TKey>; IService: ICrudService < TEntity, TKey, IRepository >> = class(TRESTFullController)
  strict private
    FService: IService;
    FConverter:
    IRESTFullConverter<TEntity, TDTO, TKey>;
    FCriticalSection:
    IMidgardCriticalSection;
  strict protected
    procedure MVCControllerAfterCreate; override;
    procedure MVCControllerBeforeDestroy; override;

    function GetService: IService;
    function GetConverter: IRESTFullConverter<TEntity, TDTO, TKey>;
    function GetCriticalSection: IMidgardCriticalSection;
  public
    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpGET])]
    [MVCProduces(TMVCMediaType.APPLICATION_JSON, TMVCCharSet.ISO88591)]
    procedure FindOne(ctx: TWebContext); virtual;

    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    [MVCProduces(TMVCMediaType.APPLICATION_JSON, TMVCCharSet.ISO88591)]
    procedure FindAll(ctx: TWebContext); virtual;

    [MVCPath]
    [MVCHTTPMethod([httpPOST])]
    [MVCProduces(TMVCMediaType.APPLICATION_JSON, TMVCCharSet.ISO88591)]
    [MVCConsumes(TMVCMediaType.APPLICATION_JSON)]
    procedure Insert(ctx: TWebContext); virtual;

    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpPUT])]
    [MVCProduces(TMVCMediaType.APPLICATION_JSON, TMVCCharSet.ISO88591)]
    [MVCConsumes(TMVCMediaType.APPLICATION_JSON)]
    procedure Update(ctx: TWebContext); virtual;

    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure Delete(ctx: TWebContext); virtual;
  end;

implementation

{ TCrudController<TEntity, TKey, TDTO, IService> }

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.Delete(ctx: TWebContext);
var
  vEntity: TEntity;
begin
  GetCriticalSection.Enter;
  try
    vEntity := GetService.FindOne(TValue.From<Int64>(ctx.Request.Params['id'].ToInt64).AsType<TKey>);
    if (vEntity <> nil) then
    begin
      try
        Self.GetService.Delete(vEntity);

        ctx.Response.RawWebResponse.Content := '';
        ctx.Response.StatusCode := HTTP_STATUS.NoContent;
        ctx.Response.ReasonString := 'No Content';
      finally
        vEntity.Free;
      end;
    end
    else
      Self.Render(HTTP_STATUS.NotFound, 'Not Found');
  finally
    GetCriticalSection.Leave;
  end;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.FindOne(ctx: TWebContext);
var
  vEntity: TEntity;
begin
  GetCriticalSection.Enter;
  try
    vEntity := GetService.FindOne(TValue.From<Int64>(ctx.Request.Params['id'].ToInt64).AsType<TKey>);
    if (vEntity <> nil) then
    begin
      try
        Self.Render(GetConverter.AsDTO(vEntity));
      finally
        vEntity.Free;
      end;
    end
    else
      Self.Render(HTTP_STATUS.NotFound, 'Not Found');
  finally
    GetCriticalSection.Leave;
  end;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.FindAll(ctx: TWebContext);
var
  vEntities: IList<TEntity>;
begin
  GetCriticalSection.Enter;
  try
    vEntities := GetService.FindAll;
    if (vEntities <> nil) and (vEntities.Count > 0) then
      Self.Render<TDTO>(GetConverter.AsDTOs(vEntities))
    else
      Self.Render(HTTP_STATUS.NoContent, 'No Content');
  finally
    GetCriticalSection.Leave;
  end;
end;

function TCrudController<TEntity, TDTO, TKey, IRepository, IService>.GetConverter: IRESTFullConverter<TEntity, TDTO, TKey>;
begin
  Result := FConverter;
end;

function TCrudController<TEntity, TDTO, TKey, IRepository, IService>.GetCriticalSection: IMidgardCriticalSection;
begin
  Result := FCriticalSection;
end;

function TCrudController<TEntity, TDTO, TKey, IRepository, IService>.GetService: IService;
begin
  Result := FService;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.MVCControllerAfterCreate;
begin
  inherited MVCControllerAfterCreate;
  FService := ServiceLocator.GetService<IService>;
  FConverter := ServiceLocator.GetService<IRESTFullConverter<TEntity, TDTO, TKey>>;
  FCriticalSection := ServiceLocator.GetService<IMidgardCriticalSection>;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.MVCControllerBeforeDestroy;
begin
  FService := nil;
  FConverter := nil;
  inherited MVCControllerBeforeDestroy;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.Insert(ctx: TWebContext);
var
  vDto: TDTO;
  vEntity: TEntity;
  vId: string;
begin
  GetCriticalSection.Enter;
  try
    vDto := ctx.Request.BodyAs<TDTO>;
    try
      vEntity := GetConverter.AsEntity(vDto);
      try
        vEntity := Self.GetService.Save(vEntity);

        vId := TValue.From<TKey>(GetConverter.KeyValue(vEntity)).ToString;

        ctx.Response.RawWebResponse.Content := vId;
        ctx.Response.Location := ctx.Request.PathInfo + '/' + vId;

        ctx.Response.StatusCode := HTTP_STATUS.Created;
        ctx.Response.ReasonString := 'Created';
      finally
        vEntity.Free;
      end;
    finally
      vDto.Free;
    end;
  finally
    GetCriticalSection.Leave;
  end;
end;

procedure TCrudController<TEntity, TDTO, TKey, IRepository, IService>.Update(ctx: TWebContext);
var
  vEntity: TEntity;
  vDto: TDTO;
begin
  GetCriticalSection.Enter;
  try
    vEntity := GetService.FindOne(TValue.From<Int64>(ctx.Request.Params['id'].ToInt64).AsType<TKey>);
    if (vEntity <> nil) then
    begin
      try
        vDto := ctx.Request.BodyAs<TDTO>;
        try
          GetConverter.Update(vDto, vEntity);

          Self.GetService.Save(vEntity);

          ctx.Response.RawWebResponse.Content := '';
          ctx.Response.StatusCode := HTTP_STATUS.NoContent;
          ctx.Response.ReasonString := 'No Content';
        finally
          vDto.Free;
        end;
      finally
        vEntity.Free;
      end;
    end
    else
      Self.Render(HTTP_STATUS.NotFound, 'Not Found');
  finally
    GetCriticalSection.Leave;
  end;
end;

end.
