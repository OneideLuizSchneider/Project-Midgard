unit RESTFull.Web.Module;

interface

uses
  System.Classes,
  System.Generics.Collections,
  Web.HTTPApp,
  MVCFramework,
  MVCFramework.Commons,
  Spring.Services;

type
  TRESTFullWebModule = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);
  private
    FEngine: TMVCEngine;
    procedure RegisterControllers;
  public
  end;

var
  RESTFullWebModuleClass: TComponentClass = TRESTFullWebModule;

implementation

uses
  RESTFull.Controller,
  RESTFull.Container;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TRESTFullWebModule.RegisterControllers;
var
  container: IRESTFullContainer;
begin
  container := ServiceLocator.GetService<IRESTFullContainer>;
  container.Controllers.ForEach(
    procedure(const controllerItem: TPair<string, IRESTFullControllerItem>)
    begin
      FEngine.AddController(controllerItem.Value.ControllerClass, controllerItem.Value.Delegate);
    end
    );
end;

procedure TRESTFullWebModule.WebModuleCreate(Sender: TObject);
begin
  FEngine := TMVCEngine.Create(Self);
  FEngine.Config[TMVCConfigKey.SessionTimeout] := '30';
  FEngine.Config[TMVCConfigKey.DefaultContentType] := TMVCMediaType.APPLICATION_JSON;
  FEngine.Config[TMVCConfigKey.DefaultContentCharset] := TMVCCharSet.ISO88591;
  RegisterControllers();
end;

procedure TRESTFullWebModule.WebModuleDestroy(Sender: TObject);
begin
  FEngine.Free;
end;

end.
