unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, StrUtils;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbl_fish: TLabel;
    lbl_banki: TLabel;
    lbl_noklev: TLabel;
    lbl_nofish: TLabel;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    lbl_Money: TLabel;
    Label5: TLabel;
    lbl_potion: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;
{$R *.dfm}

procedure TForm2.Button2Click(Sender: TObject);
begin
  lbl_fish.caption:='0';
  lbl_banki.caption:='0';
  lbl_noklev.caption:='0';
  lbl_nofish.caption:='0';
  lbl_Money.Caption:='0 LN';
  lbl_potion.caption:='0';
  rMoney:=0;
  iFishCount:=0;
  iBankiCount:=0;
  iNoKlev:=0;
  iNoFish:=0;
  ipotion:=0;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  F:TextFile;
begin
  IF FileExists('last_session.txt') then begin
    assignFile(F,'last_session.txt');
    reset(F);
    ReadLN(F,iFishCount);  //рыба
    ReadLN(F,iBankiCount);  //банок/сапогов
    ReadLN(F,iNoKlev);  //нет клева
    ReadLN(F,iNoFish);  //рыба сорвалась
    ReadLN(F,iPotion);  //выпито зелий
    ReadLN(F,rMoney);  //деньги
    CloseFile(F);
    Form2.lbl_fish.Caption:=IntToStr(iFishCount);
    Form2.lbl_banki.Caption:=IntToStr(iBankiCount);
    Form2.lbl_noklev.Caption:=IntToStr(iNoKlev);
    Form2.lbl_nofish.Caption:=IntToStr(iNoFish);
    Form2.lbl_potion.Caption:=IntToStr(iPotion);
//    s:=AnsiReplaceStr(s,'.',',');
//    rMoney:=strtoFloat(s);
    Form2.lbl_Money.Caption:=FormatFloat('0.##',rMoney) + ' LN';
  end;
end;

end.
