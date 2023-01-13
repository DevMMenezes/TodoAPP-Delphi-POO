object frmConfig: TfrmConfig
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Configs'
  ClientHeight = 503
  ClientWidth = 818
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgPrincipal: TPageControl
    Left = 0
    Top = 68
    Width = 818
    Height = 435
    ActivePage = pgTabUsuarios
    Align = alClient
    TabOrder = 0
    object pgTabUsuarios: TTabSheet
      Caption = 'Usu'#225'rios'
      TabVisible = False
      object DBGridUsuarios: TDBGrid
        Left = 0
        Top = 48
        Width = 807
        Height = 374
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
      object BtnCons: TPanel
        Left = 700
        Top = 3
        Width = 103
        Height = 34
        Cursor = crHandPoint
        BevelOuter = bvNone
        Caption = 'Consultar'
        Color = 309758
        DragCursor = crHandPoint
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4140309
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        OnClick = BtnConsClick
      end
      object BtnCriar: TPanel
        Left = 591
        Top = 3
        Width = 103
        Height = 34
        Cursor = crHandPoint
        BevelOuter = bvNone
        Caption = 'Cadastrar'
        Color = 4140309
        DragCursor = crHandPoint
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        OnClick = BtnCriarClick
      end
    end
  end
  object pnConfiguracoes: TPanel
    Left = 0
    Top = 0
    Width = 818
    Height = 68
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Configura'#231#245'es'
    Color = 309758
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    object pnClose: TPanel
      Left = 759
      Top = 1
      Width = 57
      Height = 56
      Cursor = crHandPoint
      BevelOuter = bvNone
      Color = 309758
      DragCursor = crHandPoint
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object btnClose: TImage
        Left = 0
        Top = 0
        Width = 57
        Height = 56
        Cursor = crHandPoint
        Align = alClient
        Center = True
        DragCursor = crHandPoint
        Picture.Data = {
          0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000020
          00000020080300000044A48AC60000000373424954080808DBE14FE000000009
          70485973000000C1000000C101E2303DBA0000001974455874536F6674776172
          65007777772E696E6B73636170652E6F72679BEE3C1A00000069504C5445FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000B676B28A0000002274524E5300070818191B212C364041424C
          6A6E8285909596A1A7BDC1D5DCDEECEEF0F1F7FAFCB8FF2F78000000FD494441
          5438CB8553C7B283400C1321F4A5F76220FAFF8FCC6181C7247963DD76646BE5
          065C704CD50DF33C749571F00DAF5E7861A9BD0FFA910BC9A929D2B468269292
          3FEEFCB327B7323C9F61B991FDF38F0F46B2F5EF197E4B8EC1953F72CF3E3D65
          3BC743E3D17337DFAECDCEDEFAC8C90C3F9091390078C2163FD1523C003537EB
          2F704FC6B5F6FC8D35E02C2C2DFF5A13CB27EBCB46945C1C18D2D6EFAE941800
          62E16AC542D2A0E2740827428980482887142656E8D89C5FC7428922398400A0
          618781C5653B128A95395070C0CC14F7883B8F94B31EA07EA19A54CB541BA5B6
          5A1D963E6E7561F4955397565F7BFD70F4D3837ABCC07FE7FF06AB142529375C
          CE1D0000000049454E44AE426082}
        OnClick = btnCloseClick
        ExplicitLeft = -40
        ExplicitTop = 16
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
