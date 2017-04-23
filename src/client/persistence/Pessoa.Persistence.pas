unit Pessoa.Persistence;

interface

uses
  System.SysUtils, System.Classes, Midgard.Crud.Persistence, System.Rtti, Data.DB,
  Spring.Data.ObjectDataset, Pessoa.DTO, Midgard.Crud.Resource,
  Spring.Container.Common, Spring.Collections, Spring.Data.VirtualDataSet;

type

  TPessoaPersistence = class(TMidgardCrudPersistence)
    Pessoa: TObjectDataSet;
    PessoaId: TIntegerField;
    PessoaNome: TStringField;
    PessoaCpfCnpj: TStringField;
  private
    [Inject]
    FResource: IMidgardCrudResource<TPessoaDTO, Int64>;
  public
    procedure ApplyDelete; override;
    procedure ApplyFindAll; override;
    procedure ApplyFindOne(const id: TValue); override;
    procedure ApplyInsert; override;
    procedure ApplyUpdate; override;
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

{ TPessoaPersistence }

procedure TPessoaPersistence.ApplyDelete;
begin
  inherited;
  Delete<TPessoaDTO, Int64>(FResource, Pessoa, PessoaId.AsLargeInt);
end;

procedure TPessoaPersistence.ApplyFindAll;
begin
  inherited;
  FindAll<TPessoaDTO, Int64>(FResource, Pessoa);
end;

procedure TPessoaPersistence.ApplyFindOne(const id: TValue);
begin
  inherited;
  FindOne<TPessoaDTO, Int64>(FResource, Pessoa, id.AsInt64);
end;

procedure TPessoaPersistence.ApplyInsert;
begin
  inherited;
  Insert<TPessoaDTO, Int64>(FResource, Pessoa, PessoaId);
end;

procedure TPessoaPersistence.ApplyUpdate;
begin
  inherited;
  Update<TPessoaDTO, Int64>(FResource, Pessoa, PessoaId.AsLargeInt);
end;

end.
