unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, CheckLst;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Bevel1: TBevel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    cb: TCheckBox;
    Label1: TLabel;
    cbLang: TComboBox;
    GroupBox3: TGroupBox;
    cbLetters: TCheckListBox;
    Image1: TImage;
    Label2: TLabel;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    GroupBox5: TGroupBox;
    bar: TProgressBar;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    lWordFound: TLabel;
    Label7: TLabel;
    lProgress: TLabel;
    Panel3: TPanel;
    Label6: TLabel;
    Label8: TLabel;
    lProgress2: TLabel;
    Panel4: TPanel;
    Label11: TLabel;
    lWordCount: TLabel;
    Label13: TLabel;
    lTime: TLabel;
    Memo1: TMemo;
    SaveDialog1: TSaveDialog;
    Label9: TLabel;
    Button1: TButton;
    cbMode: TComboBox;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure cbLangClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    Letters: String;
  end;

var
  MainForm: TMainForm;
  Words, Found: TStringList;

implementation

uses frmFound, frmInfo;

{$R *.DFM}
{$R WinXP.res}

procedure TMainForm.FormCreate(Sender: TObject);
var
        SearchRec: TSearchRec;
        a: Integer;
begin
        cbLang.Clear;
        a:=FindFirst('*.dic',faanyfile,SearchRec);
        while a=0 do
        begin
                if SearchRec.Name[1]<>'.' then cbLang.Items.Add(SearchRec.Name);
                a:=FindNext(SearchRec);
        end;
        cbLang.ItemIndex:=0;
        cbMode.ItemIndex:=0;
        if cbLang.Items.Count<=0 then
        begin
                Application.MessageBox('Nie odnaleziono ¿adnego pliku s³ownika (wymagane s¹ pliki o rozszerzeniu *.dic). '+chr(13)+'Zainstaluj ponownie program lub pobierz jego najnowsz¹ wersjê z serwisu http://www.trejderowski.com/...'+chr(13)+''+chr(13)+'Program nie mo¿e dzia³aæ prawid³owo bez s³owników i zostanie zamkniêty...','B³¹d!',MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                Application.Terminate;
                exit;
        end;
        Words:=TStringList.Create;
        Words.Clear;
        Found:=TStringList.Create;
        Found.Clear;
        Words.LoadFromFile(cbLang.Items.Strings[cbLang.ItemIndex]);
        Letters:='a¹bcædeêfghijkl³mnñoópqrsœtuvwxyzŸ¿';
        for a:=1 to Length(Letters) do cbLetters.Items.Add(Letters[a]);

        Top := (Screen.Height div 2) - 229;
        Left := (Screen.Width div 2) - 272;
end;

procedure TMainForm.cbLangClick(Sender: TObject);
var
        Start: Cardinal;
        fil, msg: String;
begin
Words.Clear;
Screen.Cursor:=crHourglass;
fil:=cbLang.Items.Strings[cbLang.ItemIndex];
Start := GetTickCount;
Words.LoadFromFile(fil);
msg:='Otwarto plik s³ownika: '+fil+#10#13+'Odczytana iloœæ wyrazów: '+IntToStr(Words.Count)+#10#13+'Czas trwania operacji: '+IntToStr(GetTickCount-Start)+ ' ms.';
Application.MessageBox(PChar(msg),'Otwarto s³ownik...',MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
Screen.Cursor:=crDefault;
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
var
        a, b, c, iMax, iMin: Integer;
        sSelected, sUnselected, tWord: String;
        FoundThere: Boolean;
        Start: Cardinal;
begin
sSelected:='';
sUnselected:='';
for a:=0 to cbLetters.Items.Count-1 do if cbLetters.Checked[a] then sSelected:=sSelected+Copy(Letters,a+1,1);
for a:=0 to cbLetters.Items.Count-1 do if not cbLetters.Checked[a] then sUnselected:=sUnselected+Copy(Letters,a+1,1);
if sSelected='' then
begin
        Application.MessageBox('Wybierz przynajmniej jedn¹ literê.','Informacja...',MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
        exit;
end;
if sSelected=Letters then
begin
        Application.MessageBox('Przeszukiwanie s³ownika nie ma sensu, gdy zaznaczysz wszystkie litery, gdy¿ w rezultacie uzyskasz ca³¹ zawartoœæ danego s³ownika.','Informacja...',MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
        exit;
end;

Height := 390;

Screen.Cursor:=crHourglass;
MainForm.Enabled:=False;
Start:=GetTickCount;
GroupBox5.Visible:=True;
Panel3.BringToFront;
iMin:=0;
iMax:=Words.Count-1;
bar.Min:=iMin;
bar.Max:=iMax;
Application.ProcessMessages;
for a:=iMin to iMax do
begin
        Words.Strings[a]:=LowerCase(Words.Strings[a]);
        bar.Position:=a;
        lProgress2.Caption:=FloatToStrF((a / iMax)*100,ffFixed,1,0)+'%';
        Application.ProcessMessages;
end;

Panel2.BringToFront;
bar.Position:=iMin;
Found.Clear;
c:=0;
FoundThere:=True;
for a:=iMin to iMax do
begin
        tWord:=Words.Strings[a];
        if cbMode.ItemIndex=0 then
        begin
                FoundThere:=True;
                for b:=1 to Length(sSelected) do if Pos(sSelected[b],tWord)=0 then FoundThere:=False;
        end;
        if cbMode.ItemIndex=1 then
        begin
                FoundThere:=False;
                for b:=1 to Length(sSelected) do if Pos(sSelected[b],tWord)<>0 then FoundThere:=True;
        end;
        if cbMode.ItemIndex=2 then
        begin
                FoundThere:=True;
                for b:=1 to Length(sUnselected) do if Pos(sUnselected[b],tWord)<>0 then FoundThere:=False;
        end;
        if FoundThere=True then
        begin
                Inc(c);
                if cb.Checked then
                Found.Add(IntToStr(c)+'. '+tWord)
                else Found.Add(tWord);
        end;
        bar.Position:=a;
        lProgress.Caption:=FloatToStrF((a / iMax)*100,ffFixed,1,0)+'%';
        lWordFound.Caption:=IntToStr(Found.Count);
        Application.ProcessMessages;
end;
bar.Position:=iMin;
Panel4.BringToFront;

Height := 458;

lWordCount.Caption:=lWordFound.Caption;
GroupBox4.Visible:=True;
lTime.Caption:=IntToStr(GetTickCount-Start)+ ' ms';
MainForm.Enabled:=True;
Screen.Cursor:=crDefault;
end;

procedure TMainForm.BitBtn5Click(Sender: TObject);
var
        a: Integer;
begin
for a:=0 to cbLetters.Items.Count-1 do cbLetters.Checked[a]:=True;
end;

procedure TMainForm.BitBtn6Click(Sender: TObject);
var
        a: Integer;
begin
for a:=0 to cbLetters.Items.Count-1 do cbLetters.Checked[a]:=False;
end;

procedure TMainForm.BitBtn7Click(Sender: TObject);
var
        a: Integer;
begin
for a:=0 to cbLetters.Items.Count-1 do cbLetters.Checked[a]:= not cbLetters.Checked[a];
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        Found.Free;
        Words.Free;
end;

procedure TMainForm.BitBtn4Click(Sender: TObject);
begin
Found.Clear;
GroupBox4.Visible:=False;
GroupBox5.Visible:=False;
Height := 328;
end;

procedure TMainForm.BitBtn3Click(Sender: TObject);
begin
Screen.Cursor:=crHourglass;
FoundForm.list.Clear;
FoundForm.list.Items:=Found;
FoundForm.Caption:='Znalezione wyrazy';
FoundForm.Label1.Caption:='';
FoundForm.ShowModal;
end;

procedure TMainForm.BitBtn2Click(Sender: TObject);
begin
Screen.Cursor:=crHourglass;
Memo1.Clear;
Memo1.Lines:=Found;
Memo1.SelectAll;
Memo1.CopyToClipboard;
Application.MessageBox(PChar('Liczba linii tekstu skopiowanych do Schowka: '+IntToStr(Memo1.Lines.Count)),'Informacja...',MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
Screen.Cursor:=crDefault;
end;

procedure TMainForm.BitBtn1Click(Sender: TObject);
begin
if SaveDialog1.Execute then
begin
        Screen.Cursor:=crHourglass;
        ListBox1.Clear;
        ListBox1.Items:=Found;
        ListBox1.Items.SaveToFile(SaveDialog1.FileName);
        Application.MessageBox(PChar('Liczba linii tekstu zapisanych do pliku '+SaveDialog1.FileName+': '+IntToStr(Memo1.Lines.Count)),'Informacja...',MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
        Screen.Cursor:=crDefault;
end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
Screen.Cursor:=crHourglass;
FoundForm.list.Clear;
FoundForm.list.Items.LoadFromFile(cbLang.Text);
FoundForm.Caption:='Edycja s³ownika';
FoundForm.Label1.Caption:=cbLang.Text;
FoundForm.ShowModal;
end;

procedure TMainForm.SpeedButton4Click(Sender: TObject);
begin
Close;
end;

procedure TMainForm.SpeedButton3Click(Sender: TObject);
begin
        Info.ShowModal;
end;

end.
