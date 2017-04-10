unit Pessoa.DTO;

interface

type

  TPessoaDTO = class
  strict private
    FId: Int64;
    FNome: string;
    FCpfCnpj: string;
  public
    property Id: Int64 read FId write FId;
    property Nome: string read FNome write FNome;
    property CpfCnpj: string read FCpfCnpj write FCpfCnpj;
  end;

implementation

end.
