unit UnitDop;

interface
  uses Dialogs,SysUtils, StdCtrls,Grids,Windows, Messages, Variants, Classes,
      Graphics, Controls, Forms,Math,ComCtrls;
  type
    TArr= array[0..100] of string;
    TPNode = ^TNode;
    TNode = record
        chance:real;
        value:string;
        Left, Right: TPNode;
    end;
    TPArr= array[0..100] of TPNode;
  procedure InitGrid(var sg:TStringGrid);
  procedure FillGrid(var sg:TStringGrid;arr:TPArr;cnt:integer);
  procedure GetArr(sg:TStringGrid;var arr:TPArr;var cnt:integer;cntel:integer);
  procedure SortArr(var arr:TPArr;cnt:integer);
  procedure ShowTree(root:TPNode;Item:TTreeNode;tree:TTreeView);
  procedure getStr(arr:TPArr;cnt:integer;var str:string);
  procedure traverse(code: String;root:TPNode;sg:TStringGrid);
  procedure SgAddCode(sg:TStringGrid;symbol,code:string);
  procedure datacheck(sg:TStringGrid;var ok:boolean);
  function code(char:string;sg:TStringgrid):string;
  procedure checkChar(code:string;sg:TStringgrid;var char:string);
  
implementation

procedure InitGrid(var sg:TStringGrid);
var i:integer; //��������� ������� ��� ������������
  begin
for i:=1 to sg.RowCount-1 do
  sg.Rows[i].Clear;
  with sg do begin
    Cells[0, 0] := '������';
    Cells[1, 0] := '����������� ���������';
    Cells[2, 0] := '��� �������';
    Cells[0, 1] := '�';Cells[1, 1] := '0,1';
    Cells[0, 2] := '�';Cells[1, 2] := '0,01';
    Cells[0, 3] := '�';Cells[1, 3] := '0,09';
    Cells[0, 4] := '�';Cells[1, 4] := '0,4';
    Cells[0, 5] := '�';Cells[1, 5] := '0,4';
    Cells[0, 6] := '�';Cells[1, 6] := '0,0';
    Cells[0, 7] := '�';Cells[1, 7] := '0,0';
    Cells[0, 8] := '�';Cells[1, 8] := '0,0';
  end;
  end;

procedure FillGrid(var sg:TStringGrid;arr:TPArr;cnt:integer);
var i:integer; //��������� ������� ���������� �������
  begin
for i:=1 to sg.RowCount-1 do
  sg.Rows[i].Clear;
  with sg do begin
    Cells[0, 0] := '������';
    Cells[1, 0] := '����������� ���������';
    Cells[3, 0] := '������� ������������� �������';
for i:=0 to cnt-1 do begin
    Cells[0, i+1] :=arr[i]^.value;
    Cells[1, i+1] :=FloatToStr(arr[i]^.chance);
end;
  end;
  end;

procedure GetArr(sg:TStringGrid;var arr:TPArr;var cnt:integer;cntel:integer);
  var i:integer;pnew:TPNode; //�������� ������ ��������� �� �������
begin
cnt:=0;
with sg do begin
  for i:=1 to cntel do begin
    New(pnew);
    pnew^.chance:=StrToFloat(cells[1,i]);
    pnew^.value:=Cells[0,i];
    pnew^.Left:=nil;
    pnew^.Right:=nil;
    arr[cnt]:=pnew;
    cnt:=cnt+1;
    end;
end;
end;

procedure SortArr(var arr:TPArr;cnt:integer);
var i,last:integer; ok: boolean;x:TPNode;//���������� �������
  begin
  last := cnt;
  		repeat
			ok := true;
		    for i:= 0 to last - 2 do
	    				if (arr[i]^.chance < arr[i+1]^.chance) then
	    				begin
					        x := arr[i];
					        arr[i] := arr[i+1];
					        arr[i+1] :=  x;
					        ok :=  false;
				    end;
	    		last := last - 1;
	  	until ok;
  end;

procedure ShowTree(root:TPNode;Item:TTreeNode;tree:TTreeView);
    var tmpItem:TTreeNode;name:string;//����� ������ �� treeview
begin
if (root<>nil) then
  begin
    if (root^.Left=nil)then
      name:=floattostr(root^.chance)+' ('+root^.value+')' else
            name:=floattostr(root^.chance);
    tmpItem:=tree.Items.AddChild(item,name);
    ShowTree(root^.Left,tmpItem,tree);
    ShowTree(root^.Right,tmpItem,tree);
  end
else
  //tree.Items.AddChild(item,'nil')
end;

procedure getStr(arr:TPArr;cnt:integer;var str:string);
var i:integer; //�������� ������ ��������� �� ��������� �������
begin
str:='';
for i := 0 to cnt-1 do
  str:=str+format('%f ', [arr[i]^.chance]) ;
str:=copy(str,1,(length(str)-1));
end;

procedure SgAddCode(sg:TStringGrid;symbol,code:string);
var i:integer; //�������� ���������� ��� � �������
begin
for i:=1 to sg.RowCount-1 do
  if sg.Cells[0,i]=symbol then
    sg.Cells[2,i]:=code;
end;

procedure traverse(code: String;root:TPNode;sg:TStringGrid);
begin //����������� ���������� ����� ��������
if root<>nil then begin
  if (root^.Left=nil) and (root^.Right=nil) then
  begin
    SgAddCode(sg,root^.value,code);
    ShowMessage('������: ' + root^.value +'  '+'�������� ���: '+ code);
  end;
  if (root^.Left <> nil) then
        traverse(code + '1', root^.Left,sg);
  if (root^.Right <> nil) then
        traverse(code + '0', root^.Right,sg);
end;
end;

procedure datacheck(sg:TStringGrid;var ok:boolean);//�������� ������ � �������
var i,j:integer;message:string;sum:real;
begin
message:='������ ������� ������';
ok:=true;
for i:=1 to sg.RowCount-1 do
  if length(sg.Cells[0,i])<>1 then begin showmessage('� ������� ���������� ������ ������ �������');ok:=false;exit;end;
for i:=1 to sg.RowCount-1 do begin
  try
    sum:=strtofloat(sg.Cells[1,i]);
  except
    showmessage('Number error');ok:=false;exit;
  end;
  if (sum<0) or (sum>1) then begin showmessage('������ ��� ����� ������������');ok:=false;exit;end;
end;
for i:=1 to sg.RowCount-1 do
  if (sg.Cells[0,i]<>'') and (sg.Cells[1,i]='') then
    sg.Cells[1,i]:='0,0';
for i:=1 to sg.RowCount-2 do
  for j:=i+1 to sg.RowCount-1 do
    if (sg.Cells[0,i]=sg.Cells[0,j]) then begin
      showmessage('� ������� ������� ���������� �������(������)');
      ok:=false;exit;end;
sum:=0;
for i:=1 to sg.RowCount-1 do
  sum:=sum+strtofloat(sg.Cells[1,i]);
  sum:=sum-1;
  if (sum<0) then sum:=round(sum);
  if sum<>0 then begin showmessage('����� ���� ������������ ��������� ��������� �� ����� �������');
  ok:=false;exit;end;
end;

function code(char:string;sg:TStringgrid):string;
var i:integer;
  begin
for i:= 1 to sg.RowCount-1 do
  if (sg.Cells[0,i]=char) then begin
      result:=sg.Cells[2,i];
      showmessage('��� ����� "'+char+'" ��� = '+sg.Cells[2,i]);
      exit;
    end;
  end;

procedure checkChar(code:string;sg:TStringgrid;var char:string);
var i:integer;
begin
char:='';
for i:=1 to sg.RowCount-1 do
  if (sg.Cells[2,i]=code) then begin
    char:=sg.Cells[0,i];
    showmessage('��� ���� "'+code+'" ����� = '+char);
    exit;
  end;
end;

end.
