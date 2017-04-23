inherited PessoaPersistence: TPessoaPersistence
  object Pessoa: TObjectDataSet
    Left = 96
    Top = 56
    object PessoaId: TIntegerField
      FieldName = 'Id'
    end
    object PessoaNome: TStringField
      FieldName = 'Nome'
      Size = 200
    end
    object PessoaCpfCnpj: TStringField
      FieldName = 'CpfCnpj'
    end
  end
end
