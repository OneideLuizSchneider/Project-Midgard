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
  private
    FEngine: TMVCEngine;
  public
    { Public declarations }
  end;

var
  RESTFullWebModuleClass: TComponentClass = TRESTFullWebModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}



procedure TRESTFullWebModule.WebModuleCreate(Sender: TObject);
begin
  FEngine := TMVCEngine.Create(Self);
  FEngine.Config[TMVCConfigKey.SessionTimeout] := '30';
  FEngine.Config[TMVCConfigKey.DefaultContentType] := TMVCMediaType.APPLICATION_JSON;
  FEngine.Config[TMVCConfigKey.DefaultContentCharset] := TMVCCharSet.ISO88591;
end;

end.
