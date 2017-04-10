unit View.Context;

interface

uses
  Forms,
  Spring.Container;

type
  ViewContext = class sealed
    class procedure RegisterTypes(const container: TContainer); static;
  end;
implementation

uses
  Main.View;

{ ViewContext }

class procedure ViewContext.RegisterTypes(const container: TContainer);
begin
  container.RegisterType<TMainView>.DelegateTo(
    function: TMainView
    begin
      Application.CreateForm(TMainView, Result);
    end
  ).AsSingleton;

  container.Build;
end;

end.
