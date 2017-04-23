unit View.Context;

interface

uses
  Spring.Container;

type
  TViewContext = class sealed
  public
    class procedure RegisterTypes(const container: TContainer); static;
  end;


implementation

{ TViewContext }

uses
  Vcl.Forms,
  Main.View,
  Pessoa.View;

class procedure TViewContext.RegisterTypes(const container: TContainer);
begin
  container.RegisterType<TMainView>.DelegateTo(
    function: TMainView
    begin
      Application.CreateForm(TMainView, Result);
    end).AsSingleton;

  container.RegisterType<TPessoaView>.DelegateTo(
    function: TPessoaView
    begin
      Application.CreateForm(TPessoaView, Result);
    end);

  container.Build;
end;

end.
