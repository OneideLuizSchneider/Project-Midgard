object PessoaView: TPessoaView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Pessoa'
  ClientHeight = 359
  ClientWidth = 557
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgrd1: TDBGrid
    Left = 0
    Top = 49
    Width = 557
    Height = 252
    Align = alClient
    DataSource = dsPessoa
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dbnvgr1: TDBNavigator
    Left = 0
    Top = 0
    Width = 557
    Height = 49
    DataSource = dsPessoa
    Align = alTop
    TabOrder = 1
  end
  object pnl1: TPanel
    Left = 0
    Top = 301
    Width = 557
    Height = 58
    Align = alBottom
    TabOrder = 2
    object btn1: TButton
      AlignWithMargins = True
      Left = 406
      Top = 4
      Width = 121
      Height = 50
      Align = alLeft
      Caption = 'FindByID Server'
      TabOrder = 0
      OnClick = btn1Click
    end
    object btn2: TButton
      AlignWithMargins = True
      Left = 272
      Top = 4
      Width = 128
      Height = 50
      Align = alLeft
      Caption = 'Delete on Server'
      TabOrder = 1
      OnClick = btn2Click
    end
    object btn3: TButton
      AlignWithMargins = True
      Left = 138
      Top = 4
      Width = 128
      Height = 50
      Align = alLeft
      Caption = 'Update on Server'
      TabOrder = 2
      OnClick = btn3Click
    end
    object btn4: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 128
      Height = 50
      Align = alLeft
      Caption = 'Insert on Server'
      TabOrder = 3
      OnClick = btn4Click
    end
  end
  object dsPessoa: TDataSource
    Left = 392
    Top = 144
  end
end
