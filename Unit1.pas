unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, ActnList, ExtActns, ExtCtrls, StrUtils,
  Buttons, ComCtrls, XPMan, HTTPApp, mshtml, activex, Menus, Registry;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    WB1: TWebBrowser;
    Memo1: TMemo;
    Edit1: TEdit;
    Button2: TButton;
    Timer1: TTimer;
    StatusBar1: TStatusBar;
    btn_stop: TButton;
    btn_Fishing: TButton;
    Label1: TLabel;
    chk_Frame: TCheckBox;
    cmb_Frame: TComboBox;
    tmr_potion: TTimer;
    MainMenu1: TMainMenu;
    menu_game: TMenuItem;
    menu_actions_fishing: TMenuItem;
    menu_stop: TMenuItem;
    N4: TMenuItem;
    menu_actions: TMenuItem;
    menu_settings: TMenuItem;
    menu_game_exit: TMenuItem;
    menu_actions_giveByOne: TMenuItem;
    menu_actions_fishlog: TMenuItem;
    menu_avtohod: TMenuItem;
    btn_Automove: TButton;
    Button1: TButton;
    Button3: TButton;
    LabeledEditX: TLabeledEdit;
    UpDown1: TUpDown;
    LabeledEditY: TLabeledEdit;
    UpDown2: TUpDown;
    N2: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    tmr_SchityvanieRyby: TTimer;
    XPManifest1: TXPManifest;
    Label2: TLabel;
    Button4: TButton;
    menu_tools: TMenuItem;
    menu_tools_notepad: TMenuItem;
    Button5: TButton;
    tmr_waiter: TTimer;
    ComboBox1: TComboBox;
    Bevel1: TBevel;
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure WB1DocumentComplete(Sender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure FormCreate(Sender: TObject);
    procedure btn_stopClick(Sender: TObject);
    procedure btn_FishingClick(Sender: TObject);
    procedure chk_FrameClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect1: TRect);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MyMessageHandler(var Msg: TMsg; var Handled: Boolean);
    procedure StatusBar1DblClick(Sender: TObject);
    procedure tmr_potionTimer(Sender: TObject);
    procedure menu_actions_fishingClick(Sender: TObject);
    procedure menu_stopClick(Sender: TObject);
    procedure menu_actions_fishlogClick(Sender: TObject);
    procedure menu_game_exitClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure WB1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
      var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
      var Cancel: WordBool);
    procedure Button3Click(Sender: TObject);
    procedure menu_avtohodClick(Sender: TObject);
    procedure btn_AutomoveClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure tmr_SchityvanieRybyTimer(Sender: TObject);
    procedure menu_tools_notepadClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure menu_actions_giveByOneClick(Sender: TObject);
    procedure tmr_waiterTimer(Sender: TObject);
    procedure menu_settingsClick(Sender: TObject);
    procedure ComboBox1MouseEnter(Sender: TObject);
    procedure ComboBox1MouseLeave(Sender: TObject);
    procedure ComboBox1DropDown(Sender: TObject);
    procedure ComboBox1CloseUp(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure MyExcept(Sender: TObject; E: Exception);
 {   procedure CreateChildForm(const childName: string);       }
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  FOleInPlaceActiveObject: IOleInPlaceActiveObject;
  SaveMessageHandler: TMessageEvent;
  PFind:  PChar;                    // для поиска текста (удочек, приманки, и т.д)
  str1,str2:   string;              // для поиска текста (удочек, приманки, и т.д)
  UDKI:     array [0..2] of string; // массив названий удочек
  stop:     byte=1;                 // остановить браузер или нет.
  wCountFiles:  word=0;
  isFishing:  boolean=false;   // чтобы окно рыбалки открывалось только один раз
  Flags1, TargetFrameName: OleVariant;  // для работы с фрэймами
  iFishCount: Word = 0;             // Вы поймали рыбу
  iBankiCount:Word = 0;             // сапог/ботинок
  iNoKlev:    Word = 0;             // Нет клева
  iNoFish:    Word = 0;             // Рыба сорвалась
  iPotion:    byte = 0;             // Кол-во выпитых зельев
  rectPanel:  TRect;   // для рисования и вывода текста на строке состояния
  rMoney:     Single;
//  bExit:      boolean=False; // При закрытии Алонов
  sPrimName:  string;   // название приманки в отдельную переменную
  sDomen:     string = 'http://195.242.161.132/';
  bAutohod:   boolean = False;
  bNazhaliLovit:  boolean = False;
  bAutomoveOnOff: boolean = False;
  aFishs: array [0..23] of string = ('Верховодка','Краснопёрка','Пескарь','Ёрш',
  'Плотва','Большеглазая Сельдь','Карась','Лещ','Пермит','Малоротый Окунь','Окунь',
  'Большеротый Окунь','Карп','Тунец','Язь','Судак','Щука','Маскинонг','Лосось',
  'Сёмга','Сом','Форель','Радужная Форель','Тарпон');
  bSdachaRyby:  boolean = false;
  PosKletkiX: set of byte; // Посещенные клетки (заполняются в случае если смежные недоступны)
  PosKletkiY: set of byte; // Посещенные клетки (заполняются в случае если смежные недоступны)
  kkkkk:  integer=0; // удалить
//  iDebugAutomove: integer=0;
  //iDebugDocComplete: integer=0;
  x1,y1:  integer;
  bSovmStarVer: boolean;
  bDropDown:  boolean=false;

  procedure Automove(x2,y2: integer);
  function obr(int: shortint): ShortInt;
  function PoiskDeistviya(str: string): boolean;

implementation

uses Unit2, Unit3, Unit4, Unit5, Unit6;

{$R *.dfm}
{$R BITMAPS.RES}
procedure Tform1.MyExcept(Sender: TObject; E: Exception);
var
  f:  textfile;
  fStr: string;
  e2: EAccessViolation;
  i,j:  integer;
  iParamCounts: byte;
begin
  {$WARN SYMBOL_PLATFORM OFF}
  fStr:='Exceptions.txt';
  Application.ShowException(E);
  setcurrentDir(ExtractFilePath(Application.ExeName));
  Assignfile(f, fStr);
  if FileExists(fStr) then Append(f) else Rewrite(f);

  WriteLN(f, DateTimeToStr(Now));
  WriteLN(f, E.Message);
  if E is EAccessViolation then begin
    e2:=E as EAccessViolation;
    WriteLN(f, e2.ExceptionRecord.ExceptionCode, #09 + '- Код исключения (AccessViolation)');
    WriteLN(f, e2.ExceptionRecord.ExceptionFlags, #09 + '- если 0 - дальнейшее выполнение участка кода возможно, не 0 - выполнение невозможно');
//    WriteLN(f, e2.ExceptionRecord.ExceptionAddress);
    iParamCounts:=e2.ExceptionRecord.NumberParameters;
    WriteLN(f, iParamCounts, #09 + '- Число параметров:');
    for i := 0 to iParamCounts-1 do begin
      j:=e2.ExceptionRecord.ExceptionInformation[i];
      Write(f, '   ', j);
      if (i=0) then begin
        if (j=0) then write(f,#09 + '- 0 = Поток пытается прочитать недоступные данные'#$D#$A);
        if (j=1) then write(f,#09 + '- 1 = Поток пытается записать данные в недоступный адрес памяти'#$D#$A);
      end;
      if i=1 then Write(f, #09'- Виртуальный адрес недоступных данных'#$D#$A);
{The first element of the array contains a read-write flag that indicates the type
of operation that caused the access violation. If this value is zero, the thread
attempted to read the inaccessible data. If this value is 1, the thread attempted
to write to an inaccessible address. If this value is 8, the thread causes a user-mode
data execution prevention (DEP) violation.
The second array element specifies the virtual address of the inaccessible data.
}
    end;
  end;
  WriteLN(f);
  closefile(f);
end;

function PoiskDeistviya(str: string): boolean;
var
  a,b,iTime:  integer;
  strstr: string;
begin
  { Действие, ещё <I><B id=waiter_time>196</B> сек }
  strstr:=str;
  a:=pos('Действие, ещё',strstr);
  if a<>0 then begin
    Delete(strstr,1,a);
    a:=pos('waiter_time',strstr);
    b:=posEx('<',strstr,a);
    strstr:=MidStr(strstr,a+12,b-a-12);
    iTime:=strtoint(strstr);
    result:=true;
    form1.tmr_waiter.Interval:=(1+iTime)*1000;
    form1.tmr_waiter.Enabled:=true;
  end else result:=false;
end;

function obr(int: shortint): ShortInt;
begin
  case int of
    1:  result:=-1;
    -1: result:=1;
  end;
end;

procedure AutoMove(x2,y2: integer);
var
  HTMLDoc: IHTMLDocument2;
  s, s2,ss:  string;
  k,k2,k3: integer;
  xMove,yMove:  integer;
  aMap: array [-1..1,-1..1] of shortint;
  i,j:  shortint;
  xTmp, yTmp: integer;
begin
//  inc(iDebugAutomove);
  HTMLDoc:=Form1.WB1.Document as IHTMLDocument2;
  s:=htmldoc.frames.item(TargetFrameName).document.body.InnerHTML;

  IF not PoiskDeistviya(s) then begin
  TargetFrameName:='main_top';
  bAutohod:=false;

  if pos('Нападение',s)=0 then begin

  for j := -1 to 1 do
    for I := -1 to 1 do
      amap[i,j]:=-1;
  aMap[0,0]:=0;

  // --- Поиск текущего местоположения (в x1 и y1) -----------------------------
  ss:=s;
  repeat
    k:=pos('<TD',ss);
    k2:=posEx('</TD>',ss,k);
    s2:=ansimidstr(ss,k,k2-k);
    delete(ss,k,k2-k+5);
    k3:=pos('Ваше местоположение',s2);
    if k3<>0 then begin
      k:=pos('map/',s2);
      k2:=posEx('.jpg',s2,k);
      Delete(s2,k2,length(s2));
      Delete(s2,1,k+3);
      k:=pos('/',s2);
      Delete(s2,1,k);
      ss:=s2;
      k:=pos('_',s2);
      Delete(s2,1,k);          // в s2 координата Y
      Delete(ss,k,length(ss)); // в ss координата X
      x1:=StrToInt(ss)-22;
      y1:=StrToInt(s2)-26;
    end;
  until k3<>0;

  // --- если начальная координата равна конечной, тогда выходим из процедуры и откл. автоход
  if (x1=x2) and (y1=y2) then begin
    bAutohod:=false;
    Form1.btn_Automove.enabled:=true;
    PosKletkiX:=[];
    PosKletkiY:=[];
    exit;
  end;

  // --- Заполняем матрицу карты -------
  for j:=-1 to 1 do begin
    for i:=-1 to 1 do begin
      repeat
        k:=pos('<TD',s);
        k2:=posEx('</TD>',s,k);
        s2:=ansimidstr(s,k,k2-k);
        delete(s,k,k2-k+5);
        xTmp:=x1+22+i;
        yTmp:=y1+26+j;
        k:=pos('map/day/'+inttostr(xTmp)+'_'+inttostr(yTmp),s2);
        if k=0 then   k:=pos('map/night/'+inttostr(xTmp)+'_'+inttostr(yTmp),s2);
        IF k<>0 then begin
          // если клетка находится в посещенных клетках - то она для шага недоступна
          If (pos('Перейти',s2)<>0) and not (xTmp in PosKletkiX) and not (yTmp in PosKletkiY) then aMap[i,j]:=1 else aMap[i,j]:=0;
        end;
      until k<>0;
    end;
  end;

  // --- Вычисление координат для шага -----------------------------------------
  xMove:=0;
  yMove:=0;
  if x1<x2 then inc(xMove);
  if x1>x2 then dec(xMove);
  if y1<y2 then inc(yMove);
  if y1>y2 then dec(yMove);

  repeat
    if aMap[xMove,yMove]=1 then begin
      i:=xMove;
      j:=yMove;
      break;
    end else begin   // ищем смежные клетки ------------------------------------

      i:=xMove;
      j:=yMove;

      if xMove=0 then begin          //0,1 (или 0,0 или 0,-1), Y остается той же, X меняется
        dec(i);
        if aMap[i,j]<>1 then inc(i,2) else break;
      end;
      if aMap[i,j]=1 then break;

      if yMove=0 then begin          //0,1 (или 0,0 или 0,-1), X остается той же, Y меняется
        dec(j);
        if aMap[i,j]<>1 then inc(j,2) else break;
      end;
      if aMap[i,j]=1 then break;

      i:=xMove;
      j:=yMove;

      if xMove=1 then begin ////////////////////////////
                                                      //
        if yMove=1 then begin        // если (1,1)    //
          dec(j);                    // (1,0)         //
          if aMap[i,j]<>1 then begin // --- если =0   // =0 означает, что клетка для шага недоступна
            inc(j);                  // обратно (1,1) //
            dec(i);                  // (0,1)         //
          end;                                        //
        end;                                          //
        if aMap[i,j]=1 then break;                    //
                                                      //
        if yMove=-1 then begin       // если (1,-1)   //
          dec(i);                    // (0,-1)        //
          if aMap[i,j]<>1 then begin // --- если =0   // =0 означает, что клетка для шага недоступна
            inc(i);                  // обратно (1,-1)//
            inc(j);                  // (1,0)         //
          end;                                        //
        end;                                          //
        if aMap[i,j]=1 then break;                    //
      end;   ///////////////////////////////////////////
      ///
      i:=xMove;
      j:=yMove;

      if xMove=-1 then begin ///////////////////////////
                                                      //
        if yMove=1 then begin        // если (-1,1)   //
          inc(i);                    // (0,1)         //
          if aMap[i,j]<>1 then begin // --- если =0   // =0 означает, что клетка для шага недоступна
            dec(i);                  // обратно (-1,1)//
            dec(j);                  // (0,1)         //
          end;                                        //
        end;                                          //
        if aMap[i,j]=1 then break;                    //
                                                      //
        if yMove=-1 then begin       // если (-1,-1)  //
          inc(j);                    // (0,-1)        //
          if aMap[i,j]<>1 then begin // --- если =0   // =0 означает, что клетка для шага недоступна
            dec(j);                  // обратно (1,-1)//
            inc(i);                  // (1,0)         //
          end;                                        //
        end;                                          //
        if aMap[i,j]=1 then break;                    //
      end;   ///////////////////////////////////////////

      // --- если всё же aMap[i,j]<>1 (т.е. смежные клетки тоже недоступны для шага)
      PosKletkiX:=PosKletkiX + [x1+22];
      PosKletkiY:=PosKletkiY + [y1+26];
      if xMove=0 then begin
        i:=-1;
        j:=0;
        if aMap[i,j]<>1 then inc(i,2) else break;
        if aMap[i,j]=1 then break;
      end;
      if yMove=0 then begin
        i:=0;
        j:=-1;
        if aMap[i,j]<>1 then inc(j,2) else break;
        if aMap[i,j]=1 then break;
      end;

      if (xMove<>0) and (yMove<>0) then begin
        if (abs(x2-x1) >= abs(y2-y1)) then begin
          i:=xMove;
          j:=obr(yMove);
        end;
        if (abs(y2-y1) > abs(x2-x1)) then begin
          i:=obr(xMove);
          j:=yMove;
        end;
      end;
      if aMap[i,j]=1 then break else begin
        xMove:=i;
        yMove:=j;
      end;
    end;
  until aMap[i,j]=1;

  bAutohod:=bAutomoveOnOff;
  {else }Form1.WB1.Navigate('javascript:go_nature('+inttostr(x1+i)+','+inttostr(y1+j)+');',Flags1,TargetFrameName)
  end else bAutohod:=false;  // if pos('Нападение',s)=0 then begin
  end;     // IF not PoiskDeistviya(s) then begin
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  HTMLDoc2: IHTMLDocument2;
//  fs: string;
//  text: TStringList;
begin
  HTMLDoc2:=WB1.document as IHTMLDocument2;
//  text:=TStringList.Create;
  SetCurrentDir(ExtractFilePath(Application.ExeName));
//  fs:='debug_innerText.txt';
  TargetFrameName:='main_top';
//  text.Text:=HTMLDoc2.frames.item(TargetFrameName).document.body.InnerText;
//  text.SaveToFile(fs);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
//  stop:=0;
//  Label1.Visible:=False;
  If chk_Frame.Checked then begin
    TargetFrameName:=cmb_Frame.Items[cmb_Frame.ItemIndex];
    WB1.Navigate(Edit1.text, Flags1, TargetFrameName);
  end
  else begin
    TargetFrameName:='main_top';
    wb1.Navigate(Edit1.text);
  end;
  wb1.SetFocus;
  btn_Fishing.Enabled:=True;
  btn_Automove.Enabled:=true;
  menu_actions_fishing.Enabled:=True;
end;

procedure TForm1.Button3Click(Sender: TObject);
{var
  HTMLDoc2: IHTMLDocument2;
  fs: string;
  text: TStringList;}
begin
{  HTMLDoc2:=WB1.document as IHTMLDocument2;
  text:=TStringList.Create;
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  fs:='debug_InnerHTML.txt';
  TargetFrameName:='main_top';
  text.Text:=HTMLDoc2.frames.item(TargetFrameName).document.body.InnerHTML;
  text.SaveToFile(fs); }
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  TargetFrameName:='main_top';
  WB1.Navigate('javascript:location=''main.php?filter_f4=fish''',Flags1,TargetFrameName);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  bAutomoveOnOff:=false;
  Automove(strtoint(LabeledEditX.Text),strtoint(LabeledEditY.Text));
end;

procedure TForm1.btn_AutomoveClick(Sender: TObject);
begin
  bAutomoveOnOff:=True;
  btn_Stop.Enabled:=True;
  btn_Automove.Enabled:=false;
  Automove(strtoint(LabeledEditX.Text),strtoint(LabeledEditY.Text));
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  TargetFrameName:='main_top';
  WB1.Navigate(sDomen + 'main.php?go=back', Flags1, TargetFrameName);
  Timer1.Enabled:=False;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  If (Ord(Key)=13) or (Ord(Key)=10) then begin
    Edit1.SelectAll;
    Button2Click(Form1);
  end;
end;

procedure TForm1.WB1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch;
  var URL, Flags, TargetFrameName, PostData, Headers: OleVariant;
  var Cancel: WordBool);
//var
//  f:  textfile;
//  sf: string;
//  str:  string;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  StatusBar1.Panels[0].Text:=URL;
{  sf:='debug_URLS.txt';                     // debug
  assignfile(f,sf);                         //
  If FileExists(sf) then Append(F)          //
  else Rewrite(f);                          //
  str:=DateTimeToStr(Now) + #09 + URL;      //
  WriteLN(f,str);                           //
  CloseFile(f);                             // }
end;

//======================== --- ОСНОВНАЯ ПРОЦЕДУРА --- ========================//
procedure TForm1.WB1DocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  k,k1,i:  integer; // k2 - временный счетчик, для того, чтобы инфа о пойманом не дублировалась
//  k3_money: real;      // k3_money - тоже самое, но для денег
  sUdka:  string;
  iUdka:  byte;
  HTMLDoc: IHTMLDocument2;
  Element: OleVariant;
  bFishing:  boolean; // используется для включения режима выбора приманки
  ElementHTML: IHTMLElement;
  ListItem: TListItem;
  sUser, sPass: string;
  sTmp: string;  // хранит id рыбы при сдаче её поштучно
begin
  HTMLDoc:=WB1.document as IHTMLDocument2;

  //--- Запуск с командной строкой----------------------------------------------
  IF (URL=sDomen) and (ParamStr(1)<>'') then begin
    sUser:=paramstr(1);
    sPass:=paramstr(2);

  // Третий вариант (рабочий):
    ElementHTML:=HTMLDoc.all.item('user',0) as IHTMLElement;
    ElementHTML.setAttribute('value',sUser,0);
    ElementHTML:=HTMLDoc.all.item('pass',0) as IHTMLElement;
    ElementHTML.setAttribute('value',sPass,0);
    WB1.Navigate('javascript:document.auth.submit();');

{   // Старый вариант:
    For i:=0 to HTMLDoc.all.length-1 do begin
      ElementHTML:=HTMLDoc.all.item(i,0) as IHTMLElement;
      If ElementHTML.GetAttribute('name',0)='user' then ElementHTML.setAttribute('value',sUser, 0);
      If ElementHTML.GetAttribute('name',0)='pass' then ElementHTML.setAttribute('value',sPass, 0);
    end;
    For i:=0 to HTMLDoc.all.length-1 do begin
      ElementHTML:=HTMLDoc.all.item(i,0) as IHTMLElement;
      If ElementHTML.GetAttribute('title',0)='Вход' then ElementHTML.click;
    end;      }
  end;
  //------------------------------------------------------------------------------

  if bAutohod then begin
    if (AnsiLeftStr(URL,length(sDomen)+30)=sDomen+'services/_nature.php?go_nature') then begin
      Automove(strtoint(LabeledEditX.text),strtoint(LabeledEditY.Text));
//      inc(iDebugDocComplete);
    end;
  end;

  IF (bSdachaRyby) then begin
    TargetFrameName:='main_top';
    if (URL=sDomen+'main.php?filter_f4=fish') or (LeftStr(URL,length(sDomen)+19) = sDomen+'main.php?lavkasdat=') then begin
      {Поиск рыбы в HTML}
      str1:=HTMLDoc.frames.item(TargetFrameName).document.body.InnerHTML;
      k:=pos('sellingform',str1);     // sellingform('7964095','Щука')
      IF k<>0 then begin
        Delete(str1,1,k);
        k:=pos('''',str1);
        k1:=PosEx('''',str1,k+1);
        sTmp:=MidStr(str1,k +1,k1-k-1);
        WB1.Navigate(sDomen+'main.php?lavkasdat='+sTmp,Flags1,TargetFrameName);
      end else bSdachaRyby:=false;
    end;
  end;

  If STOP = 0 then  // Если НЕ стоп (т.е. авторыбалка включена)
  begin
    TargetFrameName:='main_top';

    IF (URL=sDomen + 'game.php') then
      WB1.Navigate(sDomen + 'main.php',Flags1, TargetFrameName);
    IF (URL=sDomen + 'main.php') then
      wb1.Navigate(sDomen + 'main.php?go=back',Flags1, TargetFrameName);
    IF (URL=sDomen + 'main.php?go=back') or (URL=sDomen + 'main.php?go=pers') then begin
      wb1.Navigate(sDomen + 'main.php?fishing=on', Flags1, TargetFrameName);
      isFishing:=true;  // чтобы окно рыбалки открывалось только один раз
    end;

    //--- Просьба ввести код (перенести его нафиг за IF STOP = 0) --------------
    IF pos('видите на картинке',HTMLDoc.frames.item(TargetFrameName).document.body.InnerText)<>0 then begin
      stop:=1;
      label1.visible:=true;
      btn_Fishing.Enabled:=True;
      menu_actions_fishing.Enabled:=True;
      ListItem:=Form3.LV_FishLog.Items.Add;
      ListItem.Caption:=DateTimeToStr(Now);
      ListItem.SubItems.Add('Рыбалка остановлена (капча)');
      for I := 2 to form3.LV_FishLog.Columns.Count - 1 do
        ListItem.SubItems.Add('');
      If (not Application.Active) then FlashWindow(Application.Handle,true);
    end;

    //--------- Основной код рыбалки -------------------------------------------
    if (URL=sDomen + 'main.php?fishing=on') then begin
      str1:=HTMLDoc.frames.item(TargetFrameName).document.body.innerHTML;

   {   assignfile(ffishing2,'debug_fishingHTML.txt');
      append(ffishing2);
      writeln(ffishing2,datetimetostr(now));
      writeln(ffishing2,'str1 = ');
      write(ffishing2,str1);
      WriteLN(ffishing2,'--------------------------------------------------');

      closefile(ffishing2);
    }
    if bNazhaliLovit then tmr_SchityvanieRyby.Enabled:=true;

      //--- Если усталость -----------------------------------------------------
      if pos('Вы слишком',str1)<>0 then begin
        // переход к метке 1
        WB1.Navigate(sDomen + 'main.php?go=inv&filter_f4=potion',Flags1,TargetFrameName);
      end;

      if isFishing then begin  // открывается один раз (поиск приманки, нажатие ловить) и потом ставится в false, таким образом не открывая постоянно "выбор приманки"
        Timer1.Enabled:=False;
        isFishing:=false;
        PFind:=nil;
        Memo1.Lines.Clear;
        //---------- Нахождение приманки и нажатие на "ловить" -----------------
        If pos('У вас нет снастей для ловли',HTMLDoc.frames.item(TargetFrameName).document.body.InnerText)<>0 then begin
          // переход к метке 2
          WB1.Navigate(sDomen + 'main.php?go=inv&filter_f4=orujie', Flags1, TargetFrameName);
        end else

        if pos('У вас нет приманок для ловли',HTMLDoc.frames.item(TargetFrameName).document.body.InnerText)<>0 then begin
          stop:=1;
          label1.visible:=true;
          btn_Fishing.Enabled:=True;
          menu_actions_fishing.Enabled:=True;
          ListItem:=Form3.LV_FishLog.Items.Add;
          ListItem.Caption:=DateTimeToStr(Now);
          ListItem.SubItems.Add('Рыбалка остановлена (отсутствие приманки)');
          for I := 2 to form3.LV_FishLog.Columns.Count - 1 do
            ListItem.SubItems.Add('');
          If (not Application.Active) then FlashWindow(Application.Handle,true);
        end else

        // --- если всё нормально, выбираем приманку и нажимаем ловить ---
        begin
          bFishing:=false;
          str1:=HTMLDoc.frames.item(TargetFrameName).document.body.innerHTML;
          k:=pos('<TD class=user>',str1);
          k1:=posEx('</TD>',str1,k+1);
          sPrimName:=AnsiMidStr(str1,k+15,k1-(k+15));

          For i:=0 to HTMLDoc.frames.item(TargetFrameName).document.all.length-1 do begin
            try
              If (HTMLDoc.frames.item(TargetFrameName).document.all.item(i,0).GetAttribute('name',0)='primid') then begin
                HTMLDoc.frames.item(TargetFrameName).document.all.item(i,0).click;
                bFishing:=true;
                break;
              end;
              except
            end;
          end;
          IF bFishing then begin
          //------------- Нажатие на "Ловить" ----------------------------------
            For i:=0 to HTMLDoc.frames.item(TargetFrameName).document.all.length-1 do begin
              try
                Element:=HtmlDoc.frames.item(TargetFrameName).document.all.item(i,0);
                IF Element.GetAttribute('type',0)='submit' then begin
                  IF Element.GetAttribute('value',0)='Ловить' then begin
                    Element.click;
                    Timer1.Enabled:=True;
                    bNazhaliLovit:=true;
                    break;
                  end;
                end;
              except
              end;
            end;
          end;
        end;
      end;
    end;
    //==========================================================================

    //---------------- Если усталость ------------------------------------------
    {метка 1}
    If (URL=sDomen + 'main.php?go=inv&filter_f4=potion') then begin
      PFind:='';
      memo1.Lines.clear;
      {memo1.Text}str1:=WB1.OleObject.document.frames.item(TargetFrameName).document.body.innerHTML;
      PFind:=strpos(PChar(memo1.Text),'show_w (''Зелье восстановления');
      If PFind<>nil then begin
        k:=pos('<SCRIPT>',PFind);
        Str2:=AnsiLeftStr(PFind,k);
        PFind:=strpos(PChar(Str2),'potion(');
        Str2:=PFind;
        Delete(str2,1,8);
        Str2:=LeftStr(Str2,7);
        WB1.Navigate('javascript:potion(''' + str2 + ''',''Зелье восстановления'');', Flags1, TargetFrameName);
        tmr_Potion.Enabled:=True;
      end;
    end;
    //---------------- Если удочек нет в руке ----------------------------------
    {метка 2}
    If (URL=sDomen + 'main.php?go=inv&filter_f4=orujie') then begin
      PFind:='';
      str1:='';
      memo1.Lines.clear;
      Memo1.text:=WB1.OleObject.document.frames.item(TargetFrameName).document.body.innerHTML;
      for iUdka:=0 to 2 do begin
        str1:=udki[iUdka];
        PFind:=strpos(PChar(memo1.text),PChar(str1));  // --- Ищем начало описания удки
        If PFind<>nil then begin
          k:=pos('<SCRIPT>',PFind);                    // --- Ищем конец описания удки
          sUdka:=AnsiLeftStr(Pfind,k);                 // --- заносим найденное между началом и концом в переменную
          PFind:=strpos(PChar(sUdka),'Надеть');        // --- продвигаемся к id-коду удочки
          PFind:=strpos(PFind,'wear=');                // --- -//-
          str1:=PFind;
          delete(str1,1,5);
          k:=pos('''',str1);
          str1:=LeftStr(str1,k-1);
          WB1.Navigate(sDomen + 'main.php?wear=' + str1, Flags1, TargetFrameName);
          stop:=0;
          break;
        end;
      end;
    end;
    If (LeftStr(URL,length(sDomen)+14)=sDomen + 'main.php?wear=') then begin
          WB1.Navigate(sDomen + 'main.php?go=back', Flags1, TargetFrameName);
    end;
  end;
{  New, Dispose, GetMem, ReallocMem, and FreeMem }

end;
//==============================================================================

procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.OnException:=MyExcept;
  UDKI[0]:='show_w (''Телескопическая удочка 6м''';
  UDKI[1]:='show_w (''Телескопическая удочка 4м''';
  UDKI[2]:='show_w (''Бамбуковая удочка новичка''';
  Flags1:=0;
  PosKletkiY:=[];
  PosKletkix:=[];
end;

procedure TForm1.btn_stopClick(Sender: TObject);
begin
  WB1.Stop;
  stop:=1;
  Label1.Visible:=True;
  btn_Fishing.Enabled:=True;
  menu_actions_fishing.enabled:=true;
  Timer1.Enabled:=false;
  bAutohod:=False;
  btn_Automove.Enabled:=true;
  bAutomoveOnOff:=False;
  bSdachaRyby:=false;
end;

procedure TForm1.btn_FishingClick(Sender: TObject);
var
  ListItem: TListItem;
  I: Integer;
begin
  Label1.Visible:=False;
  menu_actions_fishing.enabled:=false;
  Stop:=0;
  TargetFrameName:='main_top';
  WB1.Navigate(sDomen + 'main.php',Flags1, TargetFrameName);
  btn_Fishing.Enabled:=False;
  btn_stop.Enabled:=True;
  menu_stop.Enabled:=True;

  ListItem:=Form3.LV_FishLog.Items.Add;
  ListItem.Caption:=DateTimeToStr(Now);
  ListItem.SubItems.Add('Рыбалка запущена.');
  for I := 2 to form3.LV_FishLog.Columns.Count - 1 do
    ListItem.SubItems.Add('');
end;

procedure TForm1.chk_FrameClick(Sender: TObject);
var
  i:  byte;
begin
  cmb_Frame.Visible:=chk_Frame.Checked;
  If chk_Frame.Checked then begin
    chk_Frame.Width:=17;
    If WB1.OleObject.Document.Frames.length<>0 then
      for i:=0 to WB1.OleObject.Document.Frames.length-1 do
        cmb_Frame.Items.Add(WB1.OleObject.Document.Frames.Item(i).name);
  end else begin
    chk_Frame.Width:=77;
    cmb_Frame.Items.Clear;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  i:  ShortInt;
begin
  i:=ComboBox1.ItemIndex;
//  with ComboBox1 do begin
//  if items[ItemIndex]='' then

  case i of
    0: begin LabeledEditX.Text:='0'; LabeledEditY.Text:='0'; end;
    1: begin LabeledEditX.Text:='1'; LabeledEditY.Text:='-5'; end;
    2: begin LabeledEditX.Text:='-1'; LabeledEditY.Text:='-3'; end;
    3: begin LabeledEditX.Text:='-5'; LabeledEditY.Text:='-6'; end;
    4: begin LabeledEditX.Text:='3'; LabeledEditY.Text:='-2'; end;
    5: begin LabeledEditX.Text:='1'; LabeledEditY.Text:='-3'; end;
    6: begin LabeledEditX.Text:='-2'; LabeledEditY.Text:='-1'; end;
    {--------------------------------------------------------------------------}
    8: begin LabeledEditX.Text:='-6'; LabeledEditY.Text:='5'; end;
    9: begin LabeledEditX.Text:='25'; LabeledEditY.Text:='-3'; end;
  end;

  bDropDown:=false;
  ComboBox1.Width:=16;
  ComboBox1.Left:=454;
end;

procedure TForm1.ComboBox1CloseUp(Sender: TObject);
begin
  bDropDown:=false;
  ComboBox1.Width:=16;
  ComboBox1.Left:=454;
end;

procedure TForm1.ComboBox1DropDown(Sender: TObject);
begin
  bDropDown:=true;
end;

procedure TForm1.ComboBox1MouseEnter(Sender: TObject);
begin
  if not bDropDown then begin
    ComboBox1.Width:=107;
    ComboBox1.Left:=LabeledEditX.left;
  end;
end;

procedure TForm1.ComboBox1MouseLeave(Sender: TObject);
begin
  if not bDropDown then begin
    ComboBox1.Width:=16;
    ComboBox1.Left:=454;
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  StatusBar1.Panels[0].Width:=StatusBar1.Width-60;
end;

procedure TForm1.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect1: TRect);
var
  bm: TBitmap;
begin
  Rectpanel:=Rect1;    // для использования ВНЕ процедуры (т.е. при поимки рыбы)
  bm:=TBitmap.Create;            // загружаем
  bm.LoadFromResourceName(HInstance,'FISH');
//  bm.LoadFromFile('9.bmp');      // картинку
  StatusBar1.canvas.fillrect(Rect1);
  Statusbar1.Canvas.Brush.Style:=bsClear;
  Statusbar1.canvas.Brush.Color:=clBtnFace;
  SetBkMode(StatusBar1.Canvas.Handle,transparent);
  statusbar1.Canvas.BrushCopy(Rect(Rect1.Left,Rect1.Top,Rect1.Left+bm.Width,Rect1.Top+bm.height),bm,Rect(0,0,bm.width,bm.height),clBlack);
  StatusBar1.Canvas.TextOut(Rect1.Left+35,Rect1.top,IntToStr(iFishCount));
  bm.FreeImage;
  bm.Free;
end;

//======== ВКЛЮЧЕНИЕ КОМАНД "КОПИРОВАТЬ, ВЫРЕЗАТЬ, ВСТАВИТЬ" ===================
procedure TForm1.FormActivate(Sender: TObject);
begin
  SaveMessageHandler := Application.OnMessage;
  Application.OnMessage := MyMessageHandler;
end;

procedure TForm1.FormDeactivate(Sender: TObject);
begin
  Application.OnMessage := SaveMessageHandler;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  f:textfile;
  i,j:  integer;
  s: string;
begin
  Application.OnMessage := SaveMessageHandler;
  FOleInPlaceActiveObject := nil;

  // --- Автоматическое нажатие кнопки "Выход" при закрытии клиента ------------
  If (LeftStr(WB1.LocationURL,length(sDomen))=sDomen)
  and (length(WB1.LocationURL)>length(sDomen)) then begin  // ">" означает, что после "http://195.242.161.132/" еще что-то есть, значит юзер в игре
    TargetFrameName:='main_top';
    WB1.Navigate('javascript:top.location=''exit.php?rand=''+Math.random();');{0.185043323355245}
  end;

  // --- Запись статистики в файл ----------------------------------------------
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  assignfile(f,'last_session.txt');
  Rewrite(F);
  WriteLN(F,iFishCount);   //рыба
  WriteLN(F,iBankiCount);  //банок/сапогов
  WriteLN(F,iNoKlev);      //нет клева
  WriteLN(F,iNoFish);      //рыба сорвалась
  WriteLN(F,iPotion);      //выпито зелий
  WriteLN(F,rMoney:1:2);   //деньги
  CloseFile(F);

  //--- Запись журнала в файл --------------------------------------------------
  AssignFile(f,'fishlog.txt');
  rewrite(F);
  With Form3.LV_FishLog do begin
    For i:=0 to Items.Count-1 do begin
      s:='';
      For j:=0 to Items[i].SubItems.Count-1 do s:=s + #09 + Items[i].SubItems[j];
      WriteLN(F,Items[i].Caption + s);
    end;
  end;
  CloseFile(F);
end;

procedure TForm1.MyMessageHandler(var Msg: TMsg; var Handled: Boolean);
var
  iOIPAO: IOleInPlaceActiveObject;
  Dispatch: IDispatch;
begin
  { exit if we don't get back a webbrowser object }
  if WB1 = nil then
  begin
    Handled := False;
    Exit;
  end;

  Handled:=(IsDialogMessage(WB1.Handle, Msg) = True);

  if (Handled) and (not WB1.Busy) then
  begin
    if FOleInPlaceActiveObject = nil then
    begin
      Dispatch := WB1.Application;
      if Dispatch <> nil then
      begin
        Dispatch.QueryInterface(IOleInPlaceActiveObject, iOIPAO);
        if iOIPAO <> nil then
          FOleInPlaceActiveObject := iOIPAO;
      end;
    end;

    if FOleInPlaceActiveObject <> nil then
      if ((Msg.message = WM_KEYDOWN) or (Msg.message = WM_KEYUP)) and
         ((Msg.wParam = VK_BACK) or (Msg.wParam = VK_LEFT) or (Msg.wParam = VK_RIGHT)) then
        //nothing - do not pass on Backspace, Left or Right arrows
      else
        FOleInPlaceActiveObject.TranslateAccelerator(Msg);
  end;
  if WB1.Busy then
    label2.Visible:=true
  else
    label2.Visible:=false;
end;
//==============================================================================

procedure TForm1.menu_avtohodClick(Sender: TObject);
begin
  Automove(strtoint(LabeledEditX.Text),strtoint(LabeledEditY.Text));
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  Frm_calc.showModal;
end;

procedure TForm1.StatusBar1DblClick(Sender: TObject);
begin
  form3.showmodal;
end;

//---------------- Выпивание зелика восстановления усталости -------------------
procedure TForm1.tmr_potionTimer(Sender: TObject);
var
  i:  integer;
  HTMLDoc: IHTMLDocument2;
begin
  HTMLDoc:=WB1.document as IHTMLDocument2;
  For i:=0 to HTMLDoc.frames.item(TargetFrameName).document.all.length-1 do begin
    try {type=submit value=OK}
      If (HTMLDoc.frames.item(TargetFrameName).document.all.item(i,0).GetAttribute('type',0)='submit') and
         (HTMLDoc.frames.item(TargetFrameName).document.all.item(i,0).GetAttribute('value',0)='OK') then begin
           HTMLDoc.frames.item(TargetFrameName).document.all.item(i,0).click;
           inc(iPotion);
           Form2.lbl_potion.caption:=IntToStr(iPotion);
           break;
      end;
      except
    end;
  end;
  tmr_Potion.Enabled:=false;
end;

procedure TForm1.tmr_SchityvanieRybyTimer(Sender: TObject);
var
  page: string;
  HTML: IHTMLDocument2;
  ListItem: TListItem;
  kDeistvie:  integer;
{  ffishing,ffishing2: textfile;}
  k,k1,i:  integer;
  q,w,e,r: integer;
  iRepeatCount:integer;
begin
  bNazhaliLovit:=false;
  tmr_SchityvanieRyby.Enabled:=false;

{  assignfile(ffishing2,'debug_fishingHTML.txt');
  If FileExists('debug_fishingHTML.txt') then Append(ffishing2)          //
  else Rewrite(ffishing2);                          //
  writeln(ffishing2,datetimetostr(now));
  writeln(ffishing2,'page = ');
  write(ffishing2,page);
  WriteLN(ffishing2,'--------------------------------------------------');
  closefile(ffishing2); }

  iRepeatCount:=0;
  repeat
    inc(iRepeatCount);
    HTML:=WB1.Document as IHTMLDocument2;
    page:=HTML.frames.item(TargetFrameName).document.body.innerHTML;
    q:=pos('поймали',page);
    w:=pos('У вас нет',page);
    e:=pos('Нет клёва',page);
    r:=pos('Рыба сорвалась',page);

    if (q<>0) or (w<>0) or (e<>0) or (r<>0) then begin

      // --- После "Действие, еще" идет дублированная информация. Удаляем её
      kDeistvie:=pos('Действие, ещё',page);
      if (kDeistvie<>0) then   Delete(page,kDeistvie,length(page){-kDeistvie+1});

{      assignfile(ffishing,'debug_fishing.txt');            // debug
      If FileExists('debug_fishing.txt') then Append(ffishing)          //
      else Rewrite(ffishing);                          //
      append(ffishing);                                    //
      writeln(ffishing,'kDeistvie='+IntToStr(kDeistvie));    //
      closefile(ffishing);                                     // }

      // --- Обработка пойманной рыбы ------------------------------------------
      repeat
        k:=pos('Вы поймали рыбу',page);
        If k<>0 then begin
          inc(iFishCount);
          Delete(page,k,15);    // Удаляем надпись "Вы поймали рыбу"

          // --- Размерность рыбы -------
          k:=pos('<I class=timef>',page);
          k1:=posEx('</I>',page,k);
          str2:=AnsiMidStr(page,k+15,k1-(k+15));  // в str2 - размерность рыбы
          delete(page,k,15);
          delete(page,k1,4);

          k:=pos('show_w',page);
          delete(page,k,6);
          k:=posEx('''',page,k);
          k1:=posEx('''',page,k+1);
          ListItem:=Form3.LV_FishLog.Items.Add;
          ListItem.Caption:=DateTimeToStr(Now);
          ListItem.SubItems.Add(AnsiMidStr(page,k+1,k1-k-1)); // Заносим в журнал название рыбы
          ListItem.SubItems.Add(str2);                        // Заносим в журнал размерность рыбы

          for i:=1 to 6 do k:=posEx(',',page,k+1);   // ищем 6-ю запятую. После неё идёт цена
          k1:=posEx(',',page,k+1);
          str2:=midstr(page,k+1,k1-k-1);             // в str2 - цена рыбы
          str2:=AnsiReplaceStr(str2, '.', ',');
          Listitem.SubItems.Add(str2);
          rMoney:=rMoney + strtofloat(str2);

          // --- Масса после 14-й запятой (21-й)
          for i:=1 to 14 do k:=posEx(',',page,k+1);
          k1:=posEx(',',page,k+1);
          str2:=AnsiMidStr(page,k+1,k1-k-1);         // в str2 - масса
          Delete(str2,1,1);
          Delete(str2,length(str2),1);
          ListItem.SubItems.Add(str2);

          ListItem.SubItems.Add(sPrimName);
          ListItem.SubItems.Add('Рыба');
        end;
      until k=0;
      Form2.lbl_Money.Caption:=FormatFloat('0.##',rMoney) + ' LN';
      Form2.lbl_fish.Caption:=inttostr(iFishCount);
      StatusBar1DrawPanel(StatusBar1,StatusBar1.Panels[1],RectPanel);
      StatusBar1.Repaint;

      repeat
        k:=pos('Вы поймали консервную банку',page);
        if k<>0 then begin
          inc(iBankiCount);
          Delete(page,k,27);
        end;
      until k=0;

      repeat
        k:=pos('Вы поймали дырявый сапог',page);
        if k<>0 then begin
          inc(iBankiCount);
          Delete(page,k,24);
        end;
      until k=0;
      Form2.lbl_banki.Caption:=IntToStr(iBankiCount);

      repeat
        k:=pos('Нет клёва',page);
        if k<>0 then begin
          inc(iNoKlev);
          Delete(page,k,9);
        end;
      until k=0;
      Form2.lbl_noklev.Caption:=IntToStr(iNoKlev);

      repeat
        k:=pos('Рыба сорвалась',page);
        if k<>0 then begin
          inc(iNoFish);
          Delete(page,k,14);
        end;
      until k=0;
      Form2.lbl_nofish.Caption:=IntToStr(iNoFish);
    end;
  until (q<>0) or (w<>0) or (e<>0) or (r<>0) or (iRepeatCount=80);
end;

procedure TForm1.tmr_waiterTimer(Sender: TObject);
begin
  tmr_waiter.Enabled:=False;
  Automove(strtoint(LabeledEditX.Text),strtoint(LabeledEditY.Text));
end;

//------------------------------------------------------------------------------
procedure TForm1.menu_actions_fishingClick(Sender: TObject);
begin
  btn_Fishing.Click;
end;

procedure TForm1.menu_settingsClick(Sender: TObject);
begin
  frm_settings.showmodal;
end;

procedure TForm1.menu_stopClick(Sender: TObject);
begin
  btn_stop.Click;
end;

procedure TForm1.menu_tools_notepadClick(Sender: TObject);
begin
  Form5.show;
end;

procedure TForm1.menu_actions_giveByOneClick(Sender: TObject);
begin
  bSdachaRyby:=true;
  TargetFrameName:='main_top';
  WB1.Navigate(sDomen+'main.php?go=inv',Flags1,TargetFrameName);
  WB1.Navigate('javascript:location=''main.php?filter_f4=fish'';',Flags1,TargetFrameName);
end;

procedure TForm1.menu_actions_fishlogClick(Sender: TObject);
begin
  Form3.ShowModal;
end;

procedure TForm1.menu_game_exitClick(Sender: TObject);
begin
  Close;
end;

initialization
  OleInitialize(nil);

finalization
  OleUninitialize;

end.


