program Fishing;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit6 in 'Unit6.pas' {frm_settings},
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {frm_calc},
  Unit5 in 'Unit5.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'AloneIslands';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tfrm_settings, frm_settings);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(Tfrm_calc, frm_calc);
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
