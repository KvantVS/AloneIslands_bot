unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls, ComCtrls, ImgList, ToolWin, StrUtils;

type
  TForm5 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    SG1: TStringGrid;
    Memo1: TMemo;
    Panel4: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Bevel1: TBevel;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    btn_Add: TToolButton;
    btn_del: TToolButton;
    ImageList2: TImageList;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_delClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Memo1Exit(Sender: TObject);
    procedure SG1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;
  AddMode:  boolean=false; // предназначение переменной найти по поиску)
  NewRow:   boolean=false; // при RowCount:=RowCount+1 выполняется лишний раз процедура "SG1SelectCell". Переменная NewRow - для того, чтобы не было лишних считываний
  SelectCell: boolean=false;
  sNotepadFile: string = 'notepad.dat';
  iCurrentRow:  integer = 1;
  OnceSelected: boolean = false; // там где оно используется, происходит рекурсивный вызов - переменая для предотвращения его
  ManualDeleting: boolean = false; // если удаляется вручную

implementation

{$R *.dfm}

procedure TForm5.Edit1Change(Sender: TObject);
begin
  if not SelectCell then begin // если изменение Edit`а вызывается не выбором конкретной записи вручную, а удалением текста, или принужденным выбором другой строки
    if edit1.Text<>'' then SG1.Cells[1,sg1.Row]:=edit1.text
    else SG1.Cells[1,sg1.Row]:=AnsiLeftStr(memo1.lines[0],70);
  end;
end;

procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Memo1Exit(Memo1);
end;

procedure TForm5.FormCreate(Sender: TObject);
var
  f:  file;
  iCount,k,i: integer;
  sRead:  ShortString;
begin
  SG1.Cells[0,0]:='Дата и время';
  SG1.Cells[1,0]:='Запись';

  if FileExists(sNotepadFile) then begin
    AssignFile(f,sNotepadFile);
    Reset(f,1);
    iCount:=0;
    k:=0;
    sRead:='';

    BlockRead(f,iCount,1);
    SG1.RowCount:=iCount+1;

    for I := 1 to iCount do begin
      BlockRead(f,k,1);
      Seek(F,FilePos(F)-1);
      BlockRead(f,sRead,k+1); // дату
      sg1.Cells[0,i]:=sRead;

      BlockRead(f,k,1);
      Seek(F,FilePos(F)-1);
      BlockRead(f,sRead,k+1); // тема
      sg1.Cells[1,i]:=sRead;

      BlockRead(f,k,1);
      Seek(F,FilePos(F)-1);
      BlockRead(f,sRead,k+1); // сообщение
      // никуда писать не надо
      if i=1 then begin
        SelectCell:=true;
        memo1.Text:=sRead;
        Edit1.Text:=sg1.Cells[1,i];
      end;
    end;
    SG1.Row:=1;
    CloseFile(F);
  end else begin
    edit1.Enabled:=false;
    memo1.Enabled:=false;
  end;
end;

procedure TForm5.FormResize(Sender: TObject);
begin
  with SG1 do begin
    ColWidths[1]:=Width-ColWidths[0]-5; // 5=3+2, 3=(GridLineWidth*(ColCount+1)), 2 = BevelWidth*2
  end;
end;

procedure TForm5.Memo1Change(Sender: TObject);
begin
  if not SelectCell then begin // если изменение Memo вызывается не выбором конкретной записи вручную
    if edit1.Text<>'' then SG1.Cells[1,sg1.Row]:=edit1.text
    else SG1.Cells[1,sg1.Row]:=AnsiLeftStr(memo1.lines[0],70);
    SG1.Cells[0,sg1.Row]:=DateTimeToStr(Now);
  end;
end;

procedure TForm5.Memo1Exit(Sender: TObject);
var
  f,fTmp: file;
  iWrite:  integer;
  sWrite:  ShortString;
  NumWritten: integer;
  i,k: Integer;
  j: Integer;
begin
  k:=0;
  iWrite:=0;
  sWrite:='';
  SetCurrentDir(ExtractFilePath(Application.exeName));

  if sg1.cells[1,sg1.Row]<>'' then begin // если равно, то эту запись мы собираемся удалять

  // --- если запись ОДНА (т.е. первая, т.е. файла еще нет) --------------------
  if SG1.rowcount=2 then begin
    AssignFile(F,sNotepadFile);
    Rewrite(f,1);
    iWrite:=SG1.RowCount-1;
    BlockWrite(f,iWrite,1);       // количество строк (1 байт)

    sWrite:=SG1.Cells[0,1];
    BlockWrite(f,sWrite,Length(sWrite)+1,NumWritten); // дату
    sWrite:=Edit1.Text;
    BlockWrite(f,sWrite,Length(sWrite)+1,NumWritten); // тему записи
    sWrite:=memo1.Text;
    BlockWrite(f,sWrite,Length(sWrite)+1,NumWritten); // сообщение
    CloseFile(f);

  // --- если записей НЕСКОЛЬКО, то пишем во временный файл: -------------------
  end else begin
    AssignFile(f,sNotepadFile);
    Reset(f,1);
    AssignFile(fTmp,'note.tmp');
    Rewrite(fTmp,1);

    k:=sg1.RowCount-1;
    BlockWrite(fTmp,k,1);  // перезаписываем в 'note.tmp' кол-во записей во временный файл
    BlockRead(f,k,1);      // считываем из 'notepad.dat' количество записей и пропускаем мимо

    iWrite:=sg1.Row;
    // --- c 1-й записи до редактируемой (НЕ включительно) - всё копируем и сохраняем
    // во временный файл
    for i:=1 to iWrite-1 do begin
      for j := 1 to 3 do begin
        BlockRead(f,k,1);
        Seek(F,FilePos(F)-1);
        BlockRead(f,sWrite,k+1); // дату
        BlockWrite(fTmp,sWrite,length(sWrite)+1);
      end;
    end;
    // --- добавляем отредактированную запись в тот же временный файл ----------
    sWrite:=SG1.Cells[0,SG1.Row];
    BlockWrite(fTmp,sWrite,Length(sWrite)+1,NumWritten); // дату
    sWrite:=Edit1.Text;
    BlockWrite(fTmp,sWrite,Length(sWrite)+1,NumWritten); // тему записи
    sWrite:=memo1.Text;
    BlockWrite(fTmp,sWrite,Length(sWrite)+1,NumWritten); // сообщение

    // --- Пропускаем перезаписываемую запись в файле notepad.dat (если не создаем новую)
    // --- если создаем новую, тогда пропускать нечего (записи в файле нет)
    if not AddMode then begin
      for i := 1 to 3 do begin // 1)дата, 2)тема записи, 3)сообщение
        BlockRead(f,k,1);
        Seek(F,FilePos(F)-1);
        BlockRead(f,sWrite,k+1);
      end;
    end;

    // --- берем оставшуюся часть файла notepad.dat и дописываем во временный файл
    for i := sg1.Row+1 to sg1.RowCount-1 do begin
      for j := 1 to 3 do begin  // 1)дата, 2)тема записи, 3)сообщение
        BlockRead(f,k,1);
        Seek(F,FilePos(F)-1);
        BlockRead(f,sWrite,k+1);
        BlockWrite(fTmp,sWrite,length(sWrite)+1);
      end;
    end;
    closefile(f);
    closefile(fTmp);
    DeleteFile(sNotepadFile);
    RenameFile('note.tmp',sNotepadFile);
  end;
  AddMode:=false;
  end;
end;

procedure TForm5.SG1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  i,j:  byte;
  f:  file;
  k:  integer;
  sRead:  shortstring;
begin
  iCurrentRow:=ARow;
  if not (ManualDeleting) and not (OnceSelected) and (sg1.Cells[1,sg1.Row]='') and (Arow<>sg1.Row) then begin
    OnceSelected:=true;
    NewRow:=true;
    SelectCell:=true;
    Memo1.Text:='';
    Edit1.Text:='';
    sg1.Cells[0,sg1.Row]:='';
    sg1.RowCount:=sg1.RowCount-1;
  end;
  OnceSelected:=false;

  if sg1.Cells[0,ARow]<>'' then begin
    if not NewRow then begin
      // --- Считываем записи из файла
      assignFile(f,sNotepadFile);
      Reset(f,1);
      k:=0;
      sRead:='';
      BlockRead(f,k,1);
      for i:=1 to ARow-1 do begin    //
        for j := 1 to 3 do begin     //
          BlockRead(f,k,1);          // пропускаем первые записи до нужной
          Seek(F,FilePos(F)-1);      //
          BlockRead(f,sRead,k+1);    //
        end;                         //
      end;                           //
      SelectCell:=true;

      BlockRead(f,k,1);
      Seek(F,FilePos(F)-1);
      BlockRead(f,sRead,k+1); // дату

      BlockRead(f,k,1);
      Seek(F,FilePos(F)-1);
      BlockRead(f,sRead,k+1); // тему
      Edit1.Text:=sRead;    // вызывается Edit1.OnChange, хотя нам этого не надо. Для этого переменная SelectCell

      BlockRead(f,k,1);
      Seek(F,FilePos(F)-1);
      BlockRead(f,sRead,k+1); // сообщение
      Memo1.Text:=sRead;    // аналогично Memo1.OnChange, как и Edit

      CloseFile(f);
      SelectCell:=false;
    end;
  end;

  NewRow:=false;
end;

procedure TForm5.btn_AddClick(Sender: TObject);
begin
  AddMode:=true;// чтобы при авто-выборе новой строки (он происходит при ее создании) - ничего из файла по этой строке не считывалось (потому что в файле еще нет записи с этой строкой)
  If (memo1.Focused) then   Edit1.SetFocus   // Memo1Exit(Memo1);
  else if (Edit1.Focused) then Memo1Exit(memo1);

  if (sg1.RowCount=2) and (sg1.Cells[0,1]='') then begin
    sg1.Cells[0,1]:=DateTimeToStr(Now);
    Edit1.Enabled:=true;
    Memo1.Enabled:=true;
  end
  else begin
    if sg1.Cells[1,sg1.Row]<>'' then begin
      NewRow:=True;
      SG1.RowCount:=SG1.RowCount+1;
      SG1.Row:=SG1.RowCount-1;
      SG1.cells[0,sg1.Row]:=DateTimeToStr(Now);
      edit1.Text:='';
      memo1.Text:='';
    end;
  end;

  iCurrentRow:=sg1.Row;
  AddMode:=true;
end;

procedure TForm5.btn_delClick(Sender: TObject);
var
  f,fTmp: file;
  iCount:  integer;
  sWrite:  ShortString;
  i,k: Integer;
  j: Integer;
begin
  if sg1.RowCount>2 then begin
    AssignFile(f,sNotepadFile);
    Reset(f,1);
    AssignFile(fTmp,'note.tmp');
    Rewrite(fTmp,1);
    k:=0;
    sWrite:='';

    BlockRead(f,k,1);      // считываем количество записей
    BlockWrite(fTmp,k,1);  // и сразу пишем во временный файл

    iCount:=sg1.Row;

    // --- c 1-й записи по удаляемую - копируем и сохраняем во временный файл---
    for i:=1 to iCount-1 do begin
      for j := 1 to 3 do begin
        BlockRead(f,k,1);
        Seek(F,FilePos(F)-1);
        BlockRead(f,sWrite,k+1); // дату
        BlockWrite(fTmp,sWrite,length(sWrite)+1);
      end;
    end;

    // --- Пропускаем удаляемую запись в файле notepad.dat
    for i := 1 to 3 do begin // 1)дата, 2)тема записи, 3)сообщение
      BlockRead(f,k,1);
      Seek(F,FilePos(F)-1);
      BlockRead(f,sWrite,k+1);
    end;

    // --- берем оставшуюся часть файла notepad.dat и дописываем во временный файл
    for i := iCount+1 to sg1.RowCount-1 do begin // если удаляется последняя запись - этот участок кода пропустится
      for j := 1 to 3 do begin  // 1)дата, 2)тема записи, 3)сообщение
        BlockRead(f,k,1);
        Seek(F,FilePos(F)-1);
        BlockRead(f,sWrite,k+1);
        BlockWrite(fTmp,sWrite,length(sWrite)+1);
      end;
    end;
    closefile(f);
    closefile(fTmp);
    DeleteFile(sNotepadFile);
    RenameFile('note.tmp',sNotepadFile);
    /////////////////////////////////////////

    with SG1 do begin
      Cells[0,row]:='';
      Cells[1,row]:='';
      for i := row to RowCount - 2 do begin
        Cells[0,i]:=cells[0,i+1];
        Cells[1,i]:=cells[1,i+1];
      end;
//      NewRow:=true;  // чтоб не выполнялась SG1SelectCell // нет) тут SG1SelectCell всё-таки нужна
      ManualDeleting:=true;
      rowcount:=rowcount-1;
    end;
  end else begin  // если удаляем единственную оставшуюся запись
    sg1.cells[0,1]:='';
    sg1.cells[1,1]:='';
    DeleteFile(sNotepadFile);
    SelectCell:=true;  // чтобы следующие 2 строчки нормально очистили поля Edit и Memo
    memo1.text:='';
    edit1.text:='';
    Edit1.Enabled:=false;
    memo1.Enabled:=false;
  end;
end;

end.
