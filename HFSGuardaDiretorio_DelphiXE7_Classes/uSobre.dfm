object FrmSobre: TFrmSobre
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Sobre o Catalogador'
  ClientHeight = 121
  ClientWidth = 318
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
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 292
    Height = 16
    Caption = 'HFSGuardaDir 2.0 - Catalogador de Diret'#243'rios'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 56
    Top = 30
    Width = 197
    Height = 13
    Caption = 'Desenvolvido em Delphi XE7, Vers'#227'o: 2.0'
  end
  object Label3: TLabel
    Left = 73
    Top = 49
    Width = 162
    Height = 13
    Caption = 'Por Henrique Figueiredo de Souza'
  end
  object Label4: TLabel
    Left = 70
    Top = 68
    Width = 169
    Height = 13
    Caption = 'Todos os direitos reservados, 2015'
  end
  object btnOk: TButton
    Left = 120
    Top = 89
    Width = 75
    Height = 25
    Caption = '&Ok'
    ModalResult = 1
    TabOrder = 0
  end
end
