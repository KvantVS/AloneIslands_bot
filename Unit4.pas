unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils;

type
  Tfrm_calc = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_calc: Tfrm_calc;

implementation

{$R *.dfm}

procedure Tfrm_calc.Button1Click(Sender: TObject);
var
  iPergs, iumenie: integer;
  money, moneyCount:  integer;
  i: Integer;
  sIntPerg, sPerg:  string;
  chLastChar: char;
  l:  byte;
begin
  money:=0;
  moneyCount:=0;
  iUmenie:=strtoint(Edit1.Text);
  iPergs:=iumenie div 20; //140/20=7, 7*2=14, 14+1=15
  for i := 1 to iPergs do begin
    money:=money + moneyCount;
    moneyCount:=moneyCount+20;
  end;

  iPergs:=sqr(iPergs);
  sIntPerg:=inttostr(iPergs);
  l:=length(sIntPerg);
  chLastChar:=sIntPerg[l];

  if chLastChar='1' then sPerg:=' пергамент';
  if chLastChar in ['2'..'4'] then sPerg:=' пергамента';
  if (chLastChar in ['5'..'9']) or (chLastChar='0')  then sPerg:=' пергаментов';

  if l>=2 then
    if (sIntPerg[l-1]='1') and (chLastChar<>'0') then sPerg:=' пергаментов';

  Label2.Caption:='Потребуется: ' + inttostr(iPergs) + sPerg + #$D#$A + inttostr(money) + ' ЛН';
end;

procedure Tfrm_calc.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9']) and (key<>#08) then key:=#0;
end;

end.
