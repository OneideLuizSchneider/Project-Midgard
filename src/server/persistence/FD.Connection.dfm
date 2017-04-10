inherited FDConnectionDataModule: TFDConnectionDataModule
  OnCreate = DataModuleCreate
  Height = 258
  Width = 244
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=midgard'
      'User_Name=postgres'
      'Password=123'
      'Server=127.0.0.1'
      'DriverID=PG')
    ResourceOptions.AssignedValues = [rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    LoginPrompt = False
    Left = 96
    Top = 24
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 104
    Top = 152
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    DriverID = 'PG'
    VendorHome = 'C:\Projetos\Project-Midgard\output\server\DLLs\'
    VendorLib = 'libpq.dll'
    Left = 96
    Top = 80
  end
end
