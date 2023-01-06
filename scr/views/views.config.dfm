object frmConfig: TfrmConfig
  Left = 0
  Top = 0
  Caption = 'Configs'
  ClientHeight = 464
  ClientWidth = 802
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pgPrincipal: TPageControl
    Left = 8
    Top = 32
    Width = 786
    Height = 433
    ActivePage = pgTabUsuarios
    TabOrder = 0
    object pgTabUsuarios: TTabSheet
      Caption = 'Usu'#225'rios'
      object DBGridUsuarios: TDBGrid
        Left = 0
        Top = 48
        Width = 775
        Height = 354
        PopupMenu = PopupMenuDBUsuarios
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = DBGridUsuariosDblClick
      end
      object BtnCons: TButton
        Left = 659
        Top = 3
        Width = 113
        Height = 39
        Caption = 'Cons'
        TabOrder = 1
        OnClick = BtnConsClick
      end
      object BtnCriar: TButton
        Left = 540
        Top = 3
        Width = 113
        Height = 39
        Caption = 'Criar'
        TabOrder = 2
        OnClick = BtnCriarClick
      end
    end
  end
  object QUsuarios: TFDQuery
    Left = 76
    Top = 216
  end
  object DSUsuario: TDataSource
    DataSet = QUsuarios
    Left = 156
    Top = 264
  end
  object PopupMenuDBUsuarios: TPopupMenu
    Left = 164
    Top = 168
    object A1: TMenuItem
      Caption = 'Alterar'
      OnClick = A1Click
    end
  end
end
