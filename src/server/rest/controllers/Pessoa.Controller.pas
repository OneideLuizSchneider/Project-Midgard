unit Pessoa.Controller;

interface

uses
  RESTFull.Controller,
  MVCFramework,
  MVCFramework.Commons,
  Pessoa, Pessoa.DTO,
  Midgard.Crud.Repository, Midgard.Crud.Service;

type

  [MVCPath('/pessoa')]
  TPessoaController = class(TCrudController<TPessoa, TPessoaDTO, Int64, ICrudRepository<TPessoa, Int64>, ICrudService<TPessoa, Int64, ICrudRepository<TPessoa, Int64>>>)
  end;

implementation

end.
