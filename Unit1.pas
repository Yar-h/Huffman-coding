unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,math, Grids,unitdop, ComCtrls;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    TreeView1: TTreeView;
    Label1: TLabel;
    Button2: TButton;
    Button3: TButton;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Memo1: TMemo;
    Button4: TButton;
    GroupBox1: TGroupBox;
    Button5: TButton;
    Edit2: TEdit;
    Label2: TLabel;
    Memo2: TMemo;
    Button6: TButton;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;MainArr,eArr:TPArr; Root: TPNode;
  cnt,ecnt:integer; cntChar:integer;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var pnew:TPNode;ok:boolean;i:integer;
begin
root:=nil;
if (cntChar=1) and (stringgrid1.Cells[1,1]='1') and (length(stringgrid1.Cells[0,1])=1) then begin stringgrid1.Cells[2,1]:='1';exit;end;
TreeView1.Items.Clear;
datacheck(StringGrid1,ok);
if (ok=false)then exit;
try
GetArr(stringgrid1,MainArr,cnt,cntChar);
except
showmessage('Ошибка входных данных');
exit;
end;
SortArr(MainArr,cnt);
FillGrid(stringgrid1,MainArr,cnt);
i:=cntChar;
while (i<>0) do begin
  if (stringgrid1.Cells[1,i]='0') then begin
    cntChar:=cntChar-1;
    stringgrid1.RowCount:=cntChar+1;
  end;
i:=i-1;
end;
edit2.Text:=inttostr(cntChar);
GetArr(stringgrid1,eArr,ecnt,cntChar);
while (ecnt<>1)do begin
  new(pnew);
  pnew^.value:='';
  pnew^.chance:=eArr[ecnt-1]^.chance+eArr[ecnt-2]^.chance;
  pnew^.Left:=eArr[ecnt-2];
  pnew^.Right:=eArr[ecnt-1];
  eArr[ecnt-2]:=pnew;
  eArr[ecnt-1]:=nil;
  ecnt:=ecnt-1;
  SortArr(eArr,ecnt);
FillGrid(stringgrid1,eArr,ecnt);
showmessage('Next');
end;
if (stringgrid1.Cells[1,1]<>'1') then begin
  showmessage('Ошибка вероятностей');
  FillGrid(stringgrid1,MainArr,cnt);
  exit;
  end;
FillGrid(stringgrid1,MainArr,cnt);
root:=eArr[0];
ShowTree(root,nil,TreeView1);
treeview1.FullExpand;
traverse('',root,stringgrid1);
treeview1.SetFocus;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
memo1.clear;
edit1.Clear;
  treeview1.Items.Clear;
cntChar:=8;
stringgrid1.RowCount:=cntChar+1;
edit2.Text:=inttostr(cntChar);
InitGrid(StringGrid1);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
memo1.Clear;
memo2.Clear;
memo2.ReadOnly:=true;
with Stringgrid1 do begin
    Cells[0, 0] := 'Символ';
    Cells[1, 0] := 'Вероятность появления';
    Cells[2, 0] := 'Код символа';
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var i:integer;
begin
memo1.clear;
edit1.clear;
for i:=1 to stringgrid1.RowCount-1 do
  stringgrid1.Rows[i].Clear;
  treeview1.Items.Clear;
with Stringgrid1 do begin
    Cells[0, 0] := 'Символ';
    Cells[1, 0] := 'Вероятность появления';
    Cells[2, 0] := 'Код символа';
    end;
end;

procedure TForm1.StringGrid1KeyPress(Sender: TObject; var Key: Char);
var i:integer;
begin
for i:=1 to stringgrid1.RowCount-1 do
  stringgrid1.Cells[2,i]:='';
memo1.clear;
edit1.clear;
end;

procedure TForm1.Button4Click(Sender: TObject);
var text,result:string;i,j:integer;ok:boolean;
begin
memo1.clear;
for i:=1 to stringgrid1.RowCount-1 do
  if (length(stringgrid1.cells[0,i])<>1) or (stringgrid1.cells[1,i]='') or (stringgrid1.cells[2,i]='') then
    begin
      showmessage('Ошибка в таблице');
      exit;
    end;
text:=edit1.Text;
for i:=1 to length(text) do begin
  ok:=false;
  for j:=1 to stringgrid1.RowCount-1 do
    if (text[i]=stringgrid1.Cells[0,j]) and (stringgrid1.cells[1,j]<>'0') then begin ok:=true;break;end;
  if (ok=false) then begin
      showmessage('Буква "'+text[i]+'" не закодирована');
      exit;
  end;
end;
result:='';
for i:=1 to length(text) do
  result:=result+code(text[i],stringgrid1);
memo1.Lines.Append(result);
treeview1.SetFocus;
end;


procedure TForm1.Button5Click(Sender: TObject);
begin
try
cntChar:=strtoint(edit2.Text);
except
exit;
end;
if (cntChar>100) then cntChar:=100;
if (cntChar<0) then cntChar:=0;
edit2.Text:=inttostr(cntChar);
stringgrid1.RowCount:=cntChar+1;

end;

procedure TForm1.Button6Click(Sender: TObject);
var code,str1,str2,result:string;cnt:integer;
begin
  result:='';
  memo2.Clear;
  if (memo1.Text='') then exit;
  code:=memo1.Text;
  code:=copy(code,1,length(code)-2);
  cnt:=1;
  if (str2<>'') then showmessage(str2);
while (length(code)<>0) do
  begin
    str1:=copy(code,1,cnt);
    Showmessage('Поиск буквы для кодовой последовательности '+str1);
    checkChar(str1,StringGrid1,str2);
    if (str2<>'') then begin
        result:=result+str2;
        code:=copy(code,cnt+1,length(code)-cnt);
        cnt:=1;
    end else
    if (cnt=length(code)) then begin
    showmessage('Не найдена буква в таблице');
    break;
    end
    else cnt:=cnt+1;
 end;
memo2.text:=result;
treeview1.SetFocus;

end;

end.
