unit RESTFullClient.Context;

interface

uses
  Spring.Container;

type
  TRESTFullClientContext = class sealed
  public
    class procedure RegisterTypes(const container: TContainer); static;
  end;
implementation

uses
  MVCFramework.RESTClient,
  MVCFramework.Commons;

class procedure TRESTFullClientContext.RegisterTypes(const container: TContainer);
begin
  container.RegisterType<TRESTClient>.DelegateTo(
    function: TRESTClient
    begin
      Result := TRESTClient.Create('localhost', 5000);
      Result.Accept(TMVCMediaType.APPLICATION_JSON);
      Result.ContentType(TMVCMediaType.APPLICATION_JSON);
      Result.AcceptCharSet(TMVCCharSet.ISO88591);
      Result.ContentCharSet(TMVCCharSet.ISO88591);
    end);

  container.Build;
end;

end.
