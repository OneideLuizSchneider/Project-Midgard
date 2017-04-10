unit RESTFull.Container;

interface

uses
  Spring.Collections,
  MVCFramework,
  RESTFull.Controller;

type

  IRESTFullControllerItem = interface
    ['{C618EE0B-32DB-4DE0-BB90-99823106DC37}']
    function GetControllerClass: TRESTFullControllerClass;
    function GetDelegate: TMVCControllerDelegate;

    property ControllerClass: TRESTFullControllerClass read GetControllerClass;
    property Delegate: TMVCControllerDelegate read GetDelegate;
  end;

  IRESTFullContainer = interface
    ['{1BA317EE-7184-4802-BDA6-0FE37DF729AC}']
    function Controllers: IDictionary<string, IRESTFullControllerItem>;
  end;


implementation

end.
