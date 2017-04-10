unit Main.View;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.StdCtrls, IdHTTPWebBrokerBridge, Web.HTTPApp,
  RESTFull.Standalone.Server,
  Spring.Container.Common;

type
  TMainView = class(TForm)
  private
    { Private declarations }
  public

  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}


end.
