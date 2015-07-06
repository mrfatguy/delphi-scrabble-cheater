object FoundForm: TFoundForm
  Left = 198
  Top = 107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Found words'
  ClientHeight = 285
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 168
    Top = 88
    Width = 3
    Height = 13
    Visible = False
  end
  object list: TListBox
    Left = 4
    Top = 4
    Width = 160
    Height = 277
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 170
    Top = 4
    Width = 140
    Height = 25
    Caption = 'Add new word'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 170
    Top = 32
    Width = 140
    Height = 25
    Caption = 'Delete selected word'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 170
    Top = 60
    Width = 140
    Height = 25
    Caption = 'Edit selected word'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 170
    Top = 256
    Width = 140
    Height = 25
    Caption = 'Close this window'
    TabOrder = 4
    OnClick = Button4Click
  end
end
