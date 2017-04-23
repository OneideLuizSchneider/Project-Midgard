unit Main.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Spring.Services;

type
  TMainView = class(TForm)
    mmMainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    Cliente1: TMenuItem;
    procedure Cliente1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation

uses
  Pessoa.View;

{$R *.dfm}

procedure TMainView.Cliente1Click(Sender: TObject);
var
  vPessoaView: TPessoaView;
begin
  vPessoaView := ServiceLocator.GetService<TPessoaView>;
  try
    vPessoaView.ShowModal;
  finally
    vPessoaView.Free;
  end;
end;

end.
