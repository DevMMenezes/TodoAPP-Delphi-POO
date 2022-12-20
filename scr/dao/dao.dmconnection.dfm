object dmConnection: TdmConnection
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 510
  Width = 844
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=mySQL')
    LoginPrompt = False
    BeforeConnect = FDConnectionBeforeConnect
    Left = 136
    Top = 160
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 128
    Top = 272
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 'D:\Delphi Estudos\TodoAPP\libmysql.dll'
    Left = 128
    Top = 216
  end
end
