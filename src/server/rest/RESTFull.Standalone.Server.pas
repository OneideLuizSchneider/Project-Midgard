unit RESTFull.Standalone.Server;

interface

uses
  System.SysUtils, System.Classes, Midgard.Base.Data.Module,
  MVCFramework.Server,
  MVCFramework.Server.Impl;

type
  TRESTFullStandaloneServer = class(TMidgardBaseDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
   FServerListenerCtx: IMVCListenersContext;
  public
  end;

implementation

uses
  RESTFull.Web.Module;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TRESTFullStandaloneServer.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FServerListenerCtx := TMVCListenersContext.Create;
  FServerListenerCtx.Add(TMVCListenerProperties.New
     .SetName('RESTFullStandalone')
     .SetPort(5000)
     .SetMaxConnections(1024)
     .SetWebModuleClass(RESTFullWebModuleClass)
   );

  FServerListenerCtx.StartAll;
end;

end.
