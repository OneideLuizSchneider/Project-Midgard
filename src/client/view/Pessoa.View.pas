unit Pessoa.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Grids, Vcl.DBGrids, Midgard.Base.Client.View, Pessoa.Persistence,
  Vcl.StdCtrls, Spring.Container.Common;

type
  TPessoaView = class(TBaseClientView)
    dbgrd1: TDBGrid;
    dbnvgr1: TDBNavigator;
    pnl1: TPanel;
    btn1: TButton;
    dsPessoa: TDataSource;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    [Inject]
    FPersistence: TPessoaPersistence;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TPessoaView.btn1Click(Sender: TObject);
var
  id: Int64;
begin
  inherited;
  try
    id := StrToInt64Def(InputBox('Id', 'Id', ''), 0);
    FPersistence.ApplyFindOne(id);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TPessoaView.btn2Click(Sender: TObject);
begin
  inherited;
  try
    FPersistence.ApplyDelete;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TPessoaView.btn3Click(Sender: TObject);
begin
  inherited;
  try
    FPersistence.ApplyUpdate;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TPessoaView.btn4Click(Sender: TObject);
begin
  inherited;
  try
    FPersistence.ApplyInsert;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TPessoaView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FPersistence.Free;
end;

procedure TPessoaView.FormShow(Sender: TObject);
begin
  inherited;
  FPersistence.ApplyFindAll;
  dsPessoa.DataSet := FPersistence.Pessoa;
end;

end.
