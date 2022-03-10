unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Menus, StrUtils;

type
  TForm3 = class(TForm)
    Panel2: TPanel;
    LV_FishLog: TListView;
    btn_Close: TButton;
    lbl_price: TLabel;
    lbl_mass: TLabel;
    PopupMenu1: TPopupMenu;
    popup_selectFishName: TMenuItem;
    popup_selectWeight: TMenuItem;
    btn_stat: TButton;
    Label1: TLabel;
    lbl_selected: TLabel;
    N1: TMenuItem;
    btn_Del: TButton;
    ComboBox1: TComboBox;
    Label3: TLabel;
    procedure btn_CloseClick(Sender: TObject);
    procedure LV_FishLogSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure popup_selectFishNameClick(Sender: TObject);
    procedure popup_selectWeightClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btn_statClick(Sender: TObject);
    procedure LV_FishLogKeyPress(Sender: TObject; var Key: Char);
    procedure LV_FishLogClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure LV_FishLogColumnClick(Sender: TObject; Column: TListColumn);
    procedure LV_FishLogCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  iMass: word = 0;
  rPrice: real = 0;
  ColumnToSort: integer;
  function CustomSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;

implementation

uses Unit2, Unit1;

{$R *.dfm}

procedure TForm3.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm3.LV_FishLogClick(Sender: TObject);
begin
  lbl_selected.Caption:=IntToStr(LV_Fishlog.SelCount);
end;

// --- Сортировка --------------------------------------------------------------
function CustomSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
var
  date1, date2: TDateTime;
  iDate1,iDate2:  integer;
  Hour1, Min1, Sec1, MSec1:  Word;
  Hour2, Min2, Sec2, MSec2:  Word;
begin
  date1:=StrToDateTime(Item1.Caption);
  date2:=StrToDateTime(Item2.Caption);
  DecodeTime(date1,Hour1, Min1, Sec1, MSec1);
  DecodeTime(date2,Hour2, Min2, Sec2, MSec2);

  iDate1:=trunc(Date1);
  iDate2:=trunc(Date2);
  result:=(iDate1-iDate2)*100000; // или на *86400 (23ч 59м 59с = 86399 секунд)
  result:=result + (Hour1-Hour2)*3600 + (Min1-Min2)*60 + (Sec1-Sec2); // переводим сразу в секунды
end;

procedure TForm3.LV_FishLogColumnClick(Sender: TObject; Column: TListColumn);
begin
  ColumnToSort:=Column.Index;
  if ColumnToSort<>0 then
    {(Sender as TCustomListView)}LV_Fishlog.AlphaSort
  else
    {(Sender as TCustomListView)}LV_Fishlog.CustomSort(@CustomSortProc,0);
end;

procedure TForm3.LV_FishLogCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
  ix: integer;
begin
  ix:=ColumnToSort - 1;
  if (ix<=Item1.SubItems.Count-1) and (ix<=Item2.SubItems.Count-1) then
    Compare:=AnsiCompareText(Item1.SubItems[ix],Item2.SubItems[ix])
end;
//------------------------------------------------------------------------------

procedure TForm3.LV_FishLogKeyPress(Sender: TObject; var Key: Char);
begin
  lbl_selected.Caption:=IntToStr(LV_Fishlog.SelCount);
end;

procedure TForm3.LV_FishLogSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
//if item.SubItems.Count>=2 then begin
  If selected then begin
    If Item.SubItems[3]<>'' then iMass:=iMass + StrToInt(Item.SubItems[3]);//масса
    If Item.SubItems[2]<>'' then rPrice:=rPrice + StrToFloat(Item.SubItems[2]); //цена
  end else begin
    If Item.SubItems[3]<>'' then iMass:=iMass - StrToInt(Item.SubItems[3]);
    If Item.SubItems[2]<>'' then rPrice:=rPrice - StrToFloat(Item.SubItems[2]);
  end;
//end;
  lbl_price.Caption:=FormatFloat('0.##', rPrice);
//  lbl_price.Caption:=FloatToStr(rPrice);
  lbl_mass.Caption:=IntToStr(iMass);
end;

procedure TForm3.N1Click(Sender: TObject);
begin
  LV_Fishlog.SelectAll;
  lbl_selected.Caption:=IntToStr(LV_Fishlog.SelCount);
end;

procedure TForm3.PopupMenu1Popup(Sender: TObject);
begin
  with LV_Fishlog do begin
    If (ItemIndex<>-1) and (Items[ItemIndex].SubItems.count>1)  then begin
      popup_selectFishName.Enabled:=True;
      popup_SelectWeight.Enabled:=True;
      popup_selectFishname.Caption:='Выбрать всю рыбу "' + Items[ItemIndex].SubItems[0] + '"';
      popup_SelectWeight.caption:='Выбрать всю рыбу типа "' + Items[ItemIndex].SubItems[1] + '"';
    end else begin
      popup_selectFishName.Enabled:=False;
      popup_SelectWeight.Enabled:=False;
      popup_selectFishname.Caption:='Выбрать по наименованию';
      popup_SelectWeight.caption:='Выбрать по размерности';
    end;
  end;

end;

procedure TForm3.popup_selectFishNameClick(Sender: TObject);
var
  i: integer;
  s: string;
begin
  with LV_Fishlog do begin
    s:=Items[itemindex].SubItems[0];
    For i:=0 to Items.Count-1 do Items[i].Selected:=False;
    For i:=0 to Items.Count-1 do
      if Items[i].SubItems[0]=s then Items[i].Selected:=True;
    Lbl_Selected.Caption:=inttostr(SelCount);
  end;
end;

procedure TForm3.popup_selectWeightClick(Sender: TObject);
var
  i: integer;
  s: string;
begin
  with LV_Fishlog do begin
    s:=Items[itemindex].SubItems[1];
    For i:=0 to Items.Count-1 do Items[i].Selected:=False;
    For i:=0 to Items.Count-1 do
      If Items[i].SubItems.Count>1 then
        if Items[i].SubItems[1]=s then Items[i].Selected:=True;
    Lbl_Selected.Caption:=inttostr(SelCount);
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
var
  li: TListItem;
  F:  textfile;
  s:  string;
  k,i: integer;
begin
  LV_Fishlog.Column[0].Width:=120;
  LV_Fishlog.Column[1].Width:=163;
  LV_Fishlog.Column[2].Width:=120;
  LV_Fishlog.Column[3].Width:=50;
  LV_Fishlog.Column[4].Width:=50;
  LV_Fishlog.Column[5].Width:=163;
  LV_Fishlog.Column[6].Width:=50;

  for i := 0 to high(aFishs) do
    ComboBox1.Items.Add(aFishs[i]);

  If FileExists('fishlog.txt') then begin
    AssignFile(f,'fishlog.txt');
    Reset(f);
    Repeat
      ReadLN(F,s);
      li:=LV_Fishlog.Items.Add;
      k:=pos(#09,s);
      if k<>0 then li.Caption:=LeftStr(s,k-1) else li.Caption:=s;
      Delete(s,1,k);

      if k<>0 then begin // если табуляция есть (значит есть и subitem`ы)
        Repeat
          k:=pos(#09,s);
          If k<>0 then begin
            li.SubItems.add(AnsiLeftStr(s,k-1));
            Delete(s,1,k);
          end else li.SubItems.add(s);
        until k=0;
      end;

    Until Eof(F);
    CloseFile(f);
  end;

  li:=LV_Fishlog.Items.Add;
  li.Caption:=DateTimeToStr(Now);
  li.SubItems.Add('Запуск клиента');
  for I := 2 to form3.LV_FishLog.Columns.Count - 1 do
    li.SubItems.Add('');

  IF bSovmStarVer then begin
    for i := 0 to LV_Fishlog.Items.count-1 do
      while LV_Fishlog.Items[i].SubItems.Count < LV_Fishlog.Columns.count-1 do
        LV_Fishlog.Items[i].SubItems.Add('');

    for i := 0 to LV_Fishlog.Items.count-1 do
    begin
      s:=LV_Fishlog.Items[i].SubItems[0];
      if (s<>'Большеглазая Сельдь') and
      (s<>'Большеротый Окунь') and
      (s<>'Верховодка') and
      (s<>'Плотва') and
      (s<>'Ёрш') and
      (s<>'Запуск клиента') and
      (s<>'Карась') and
      (s<>'Карп') and
      (s<>'Краснопёрка') and
      (s<>'Лещ') and
      (s<>'Лосось') and
      (s<>'Малоротый Окунь') and
      (s<>'Маскинонг') and
      (s<>'Язь') and
      (s<>'Окунь') and
      (s<>'Пермит') and
      (s<>'Пескарь') and
      (s<>'Плотва') and
      (s<>'Рыбалка запущена.') and
      (s<>'Рыбалка остановлена (капча)') and
      (s<>'Рыбалка остановлена (отсутствие приманки)') and
      (s<>'Сёмга') and
      (s<>'Сом') and
      (s<>'Пермит') and
      (s<>'Сом') and
      (s<>'Судак') and
      (s<>'Тарпон') and
      (s<>'Тунец') and
      (s<>'Форель') and
      (s<>'Щука') then LV_Fishlog.Items[i].SubItems[5]:='Вещь'
      else LV_Fishlog.Items[i].SubItems[5]:='Рыба';
  end;
{    if (s='Запуск клиента') or
    (s='Рыбалка остановлена (капча)') or
    (s='Рыбалка остановлена (отсутствие приманки)') then
    LV_Fishlog.Items[i].SubItems[5]:='';  }
  end;
end;

procedure TForm3.FormResize(Sender: TObject);
var
  a:  byte;
  b:  word;
begin
  b:=0;
  btn_Close.Left:=ClientWidth - btn_Close.width - 12;
  btn_stat.Left:=ClientWidth - btn_stat.Width - btn_Close.width - 9-12;
  btn_del.Left:=btn_stat.Left - btn_del.Width-9;
  for a:=0 to 2 do b:=b + lv_fishlog.Columns[a].Width;
  b:=b+4;
  lbl_price.left:=b;
  lbl_mass.left:=b + lv_fishlog.Columns[3].Width;
end;

procedure TForm3.btn_statClick(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm3.btn_DelClick(Sender: TObject);
begin
  LV_Fishlog.DeleteSelected;
end;

procedure TForm3.ComboBox1Change(Sender: TObject);
var
  i,k:  integer;
  bShowed: boolean;  // чтобы фокусировалось один раз
begin
  bShowed:=false;
  k:=ComboBox1.ItemIndex;
  with LV_Fishlog do begin

    if k=0 then begin
      LV_FishLogColumnClick(LV_FIshlog, Column[6]);
      i:=0;
      repeat
        if Items[i].Subitems[5]='Вещь' then begin
          Items[i].Selected:=true;
          if not bShowed then begin
            Items[i].MakeVisible(false);
            bShowed:=true;
          end;
        end else Items[i].Selected:=false;
        inc(i);
      until i=Items.Count-1; //end;
    end;

    if k=1 then begin
      LV_FishLogColumnClick(LV_FIshlog, Column[6]);
      for i := 0 to Items.count - 1 do begin
        if Items[i].Subitems[5]='Рыба' then begin
          Items[i].Selected:=true;
          if not bShowed then begin
            Items[i].MakeVisible(false);
            bShowed:=true;
          end;
        end else Items[i].Selected:=false;
      end;
    end;

    if (k<>0) and (k<>1) then begin
      LV_FishLogColumnClick(LV_FIshlog, Column[1]);
      for i := 0 to Items.count - 1 do begin
        if Items[i].Subitems[0]=ComboBox1.Items[k] then begin
          Items[i].Selected:=true;
          if not bShowed then begin
            Items[i].MakeVisible(false);
            bShowed:=true;
          end;
        end else Items[i].Selected:=false;
      end;
    end;
  end;
  lbl_selected.caption:=IntToStr(LV_Fishlog.SelCount);
end;

end.
