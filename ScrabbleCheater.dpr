program ScrabbleCheater;

uses
  Forms,
  frmMain in 'frmMain.pas' {MainForm},
  frmFound in 'frmFound.pas' {FoundForm},
  frmInfo in 'frmInfo.pas' {Info};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'ScrabbleCheater 1.00';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFoundForm, FoundForm);
  Application.CreateForm(TInfo, Info);
  Application.Run;
end.
