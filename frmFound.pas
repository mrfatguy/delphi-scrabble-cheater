unit frmFound;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFoundForm = class(TForm)
    list: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FoundForm: TFoundForm;

implementation

{$R *.DFM}

uses frmMain;

procedure TFoundForm.Button4Click(Sender: TObject);
begin
Close;
end;

procedure TFoundForm.FormShow(Sender: TObject);
begin
Screen.Cursor:=crDefault;
end;

procedure TFoundForm.Button1Click(Sender: TObject);
var
        add: String;
begin
add:=InputBox('Dodaj...','Wpisz wyraz, który chcesz dodaæ:','');
if add<>'' then list.Items.Add(add);
end;

procedure TFoundForm.Button2Click(Sender: TObject);
begin
if list.ItemIndex=-1 then exit;
list.Items.Delete(list.ItemIndex);
end;

procedure TFoundForm.Button3Click(Sender: TObject);
var
        add: String;
begin
if list.ItemIndex=-1 then exit;
add:=InputBox('Zmieñ...','Zmieñ wybrany wyraz:',list.Items.Strings[list.ItemIndex]);
list.Items.Strings[list.ItemIndex]:=add;
end;

procedure TFoundForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Screen.Cursor:=crHourglass;
if Label1.Caption='' then Found.Assign(list.Items) else list.Items.SaveToFile(Label1.Caption);
Screen.Cursor:=crDefault;
end;

end.
