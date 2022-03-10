unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, StrUtils, CheckLst;

type
  Tfrm_settings = class(TForm)
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    CheckListBox1: TCheckListBox;
    Label2: TLabel;
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_settings: Tfrm_settings;

implementation

uses Unit1, Unit3;

{$R *.dfm}

procedure Tfrm_settings.Button1Click(Sender: TObject);
var
  i:  integer;
begin
  setCurrentDir(ExtractFilePath(Application.ExeName));
  if messageDlg('¬ы уверены, что хотите удалить весь журнал рыбалки?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
    with Form3.LV_Fishlog do begin
      i:=Items.Count-1;
      repeat
        Items[i].Delete;
        dec(i);
      until i=0;
    end;
    if FileExists('fishlog.txt') then begin
      IF FileExists('fishlog.bak') then DeleteFile('fishlog.bak');
      RenameFile('fishlog.txt','fishlog.bak');
    end;
  end;
end;

procedure Tfrm_settings.CheckBox1Click(Sender: TObject);
begin
  bSovmStarVer:=CheckBox1.Checked;
end;

procedure Tfrm_settings.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ini:  TIniFile;
  I: Integer;
//  s:  string;
begin
  if leftstr(Edit1.Text,7)<>'http://' then
    Edit1.Text:='http://' + Edit1.Text;
  if Edit1.Text[length(edit1.Text)]<>'/' then
    edit1.Text:=Edit1.Text+'/';
  sDomen:=Edit1.text;

  ini:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'settings.ini');
  ini.WriteBool('settings','SovmStarVer',bSovmStarVer);
  ini.WriteString('settings','Domen',Edit1.Text);
  ini.Free;
end;

procedure Tfrm_settings.FormCreate(Sender: TObject);
var
  ini:  TIniFile;
begin
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  if FileExists('settings.ini') then begin
    ini:=TIniFile.Create('settings.ini');
    bSovmStarVer:=ini.ReadBool('settings','SovmStarVer',true);
    sDomen:=ini.ReadString('settings','Domen','http://www.aloneislands.ru/');
    ini.Free;
  end else begin
    bSovmStarVer:=true;
    sDomen:='http://www.aloneislands.ru/';
  end;
  CheckBox1.Checked:=bSovmStarVer;
  Edit1.Text:=sDomen;
  Form1.Edit1.Text:=sDomen;
end;

procedure Tfrm_settings.FormShow(Sender: TObject);
begin
  CheckListBox1.Items:=Form1.ComboBox1.Items;
end;

end.
