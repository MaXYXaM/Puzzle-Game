unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus,JPEG, ExtCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    OpenDialog1: TOpenDialog;
    N4: TMenuItem;
    Timer1: TTimer;
    N1: TMenuItem;
    procedure N4Click(Sender: TObject);
    procedure formcreate(Sender: TObject);
    procedure N441Click(Sender: TObject);
    procedure N881Click(Sender: TObject);
    procedure N16161Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Buf,Orig:TBitmap;
  Kart:TJPEGImage;
  Pazl:array[1..1024] of TBitmap;
  Copia,Pole:array[0..15,0..15] of integer;
  Path:string;
  Mer,XX,YY,PuzClick:integer;
  Procedure Puzzle;
   procedure Map(CellX,CellY,MX,MY,MerX,MerY,Tolst:integer; MapColor:TColor; Buf:TBitmap);
implementation
uses unit2,unit3;
{$R *.dfm}
//�������� ����� Form1 � ��������� Form2 ��� ������� ������  "����"
procedure TForm1.N4Click(Sender: TObject);
begin
Form1.close;
Form2.show;
Form2.visible:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
 var i,j:integer;
begin
path:=ExtractFileDir(Application.ExeName);

Buf:=TBitmap.Create;
Buf.Width:=960;
Buf.Height:=640;

//���� �� ��������
Kart:=TJpegImage.Create;
Kart.LoadFromFile(path+'\Image\1.jpg');


Orig:=Tbitmap.Create;
Orig.Width:=480;
Orig.Height:=320;
Orig.Canvas.StretchDraw(Rect(0,0,480,320),Kart);

for i:=0 to 15 do
for j:=0 to 15 do
//��� ������� �� ��� ����, 1-���� ��� ������������ ����,2-���� ��� ����� ����������� �������� ����������� �� �����
begin
Copia[i,j]:=0;
Pole[i,j]:=0;
end;

 Mer:=4;
 PuzClick:=0;
 Puzzle;



end;
//����������� ������ ���������/////////////
//������� ��������� "�����" 4�4 �����
procedure TForm1.N441Click(Sender: TObject);
begin
Mer:=4;
Puzzle;
Timer1.Enabled:=True;

end;
//������� ��������� "����������" 8�8 ������
procedure TForm1.N881Click(Sender: TObject);
begin
Mer:=8;
Puzzle;
Timer1.Enabled:=True;
end;
//������� ��������� "�������" 16�16 ������
procedure TForm1.N16161Click(Sender: TObject);
begin
Mer:=16;
Puzzle;
Timer1.Enabled:=True;
end;
/////////////////////////////////////////////

//������, ������� ����� ��������� ���� ��� ���������� �������� ������
procedure TForm1.Timer1Timer(Sender: TObject);
var i,j,n,Tolst,MX,MY:integer;
MapColor:TColor;
win:boolean;
begin
 //�������� �� ������������ ���������� ����� � ������� ���������
 win:=true;
 n:=1;
 for i:=0 to Mer-1 do
 for j:=0 to Mer-1 do
 begin
 if pole[i,j]<>n then win:=False;
 n:=n+1;
 end;
 if win=true then
 begin
  Timer1.Enabled:=false;
  ShowMessage('���� ������ ���������!');
 end;
Buf.Canvas.Brush.Color:=ClWhite;
Buf.Canvas.Rectangle(0,0,960,320);

 for i:=0 to Mer-1 do
 for j:=0 to Mer-1 do
 begin
 //�������� ����
 if Pole[i,j]>0 then Buf.Canvas.Draw(i*XX,j*YY,Pazl[Pole[i,j] ] );
 //copia
 if Copia[i,j]>0 then Buf.Canvas.Draw(i*XX+480,j*YY,Pazl [Copia[i,j] ] );
 end;

 //�������� �����
 Tolst:=1;
 MapColor:=clBlack;
 MY:=0;
 MX:=0;
 Map(XX,YY,MX,MY,Mer,Mer,Tolst,MapColor,Buf);
  MX:=480;
 Map(XX,YY,MX,MY,Mer,Mer,Tolst,MapColor,Buf);

 //���� �� ����
  if PuzClick>0 then Buf.Canvas.Draw(Mouse.CursorPos.X-Form1.Left-(XX div 2),Mouse.CursorPos.Y-Form1.Top-25-(YY div 2),Pazl[PuzClick]);

 form1.Canvas.Draw(0,0,Buf);
end;
//��������� ������ ������� ����, ����� ��������� �������� �� �������
//� ����������� �� ������ ���������
 Procedure Puzzle;
 var i,j,n:integer;
 begin

   for i:=0 to 15 do
   for j:=0 to 15 do

  begin
  Copia[i,j]:=0;
  Pole[i,j]:=0;
  end;
  case Mer of
  4:begin XX:=120;YY:=80; end;
  8:begin XX:=60;YY:=40; end;
  16:begin XX:=30;YY:=20; end;
  end;

  n:=1;
  for i:=0 to Mer-1 do
  for j:=0 to Mer-1 do
  begin
  Pazl[n]:=TBitmap.Create;
  Pazl[n].Width:=XX;
  Pazl[n].Height:=YY;
  Pazl[n].Canvas.CopyRect(Rect(0,0,XX,YY),Orig.Canvas, Rect(i*XX,j*YY,i*XX+XX-1,j*YY+YY-1));
  n:=n+1;
  end;

  n:=1;
  Randomize;
  While(n<=Mer*Mer) do
  begin
  i:=Random(Mer);
  j:=Random(Mer);
  if Copia[i,j]=0 then
  begin
  Copia[i,j]:=n;
  n:=n+1;
  end;
 end;
 end;

 procedure Map(CellX,CellY,MX,MY,MerX,MerY,Tolst:integer; MapColor:TColor; Buf:TBitmap);
 var i:integer;
 begin

 Buf.Canvas.Pen.Color:=MapColor;
 Buf.Canvas.Pen.Width:=Tolst;
  for i:=0  to MerY do
 begin
 Buf.Canvas.MoveTo(0+MX,i*CellY+MY);
 Buf.Canvas.LineTo(MerX*CellX+MX,i*CellY+MY);
 end;

  for i:=0  to MerX do
 begin
 Buf.Canvas.MoveTo(i*CellX+MX,0+MY);
 Buf.Canvas.LineTo(i*CellX+MX,MerY*CellY+MY);
 end;

 end;


procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var S:boolean;
  i,j:integer;
begin

if (Button=MBRight) and (PuzClick>0)then
begin
S:=false;
  for i:=0 to  Mer-1 do
  for j:=0 to  Mer-1 do
  begin
  if(s=false) and(Copia[i,j]=0) then
     begin
     S:=True;
     Copia[i,j]:=PuzClick;
     PuzClick:=0;
     end;
   end;
end

 else
 begin
 S:=False;
//����� �� ������ ������
if (X>=480) and (X<=960) and (Y>=0) and (Y<=320) then
begin
//����� ����
if (Copia[(X-480) div XX,Y div YY]>0)and (PuzClick=0) then
begin
 PuzClick:=Copia[(X-480) div XX,Y div YY];
 Copia[(X-480) div XX,Y div YY]:=0;
 S:=True;
end;
//������ ���� �� �������
if (Copia[(X-480) div XX,Y div YY]=0)and (PuzClick>0) and (S=False) then
begin
 Copia[(X-480) div XX,Y div YY]:=PuzClick;
 PuzClick:=0;
 end;
end;

//����� �� ���� �����
if (X>=0) and (X<=480) and (Y>=0) and (Y<=320) then
begin
//����� ����
if (Pole[X div XX,Y div YY]>0)and (PuzClick=0) then
begin
 PuzClick:=Pole[X div XX,Y div YY];
 Pole[X div XX,Y div YY]:=0;
 S:=True;
end;
//������ ���� �� �������
 if (Pole[X div XX,Y div YY]=0)and (PuzClick>0) and (S=False) then
  begin
  Pole[X div XX,Y div YY]:=PuzClick;
  PuzClick:=0;
  end;
 end;

 end;
end;
//������ "�������" ���������� ����� �� ����������� ��������� ����������� �� ����� �����
procedure TForm1.N1Click(Sender: TObject);
begin
Puzzle;
Timer1.Enabled:=True;
end;
end.





