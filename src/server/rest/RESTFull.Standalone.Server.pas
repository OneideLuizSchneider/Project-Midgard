unit RESTFull.Standalone.Server;

interface

uses
  System.SysUtils, System.Classes, Midgard.Base.Data.Module;

type
  TMidgardBaseDataModule1 = class(TMidgardBaseDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
  MVCFramework.Server,
  MVCFramework.Server.Impl,
  RESTFull.Web.Module;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TMidgardBaseDataModule1.DataModuleCreate(Sender: TObject);
var
  vServerListenerCtx: IMVCListenersContext;
begin
  inherited;
  vServerListenerCtx := TMVCListenersContext.Create;
  vServerListenerCtx.Add(TMVCListenerProperties.New
     .SetName('RESTFullStandalone')
     .SetPort(8080)
     .SetMaxConnections(1024)
     .SetWebModuleClass(RESTFullWebModuleClass)
   );

  vServerListenerCtx.StartAll;

end;

end.
