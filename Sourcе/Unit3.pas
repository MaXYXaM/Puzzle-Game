unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus,JPEG, ExtCtrls, StdCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    Button3: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation
uses unit1,unit2,unit4;

{$R *.dfm}
//�� ������� ������ "��������� ���� ��������" ��������� ��������� ���������� ���� ������ ��������
procedure TForm3.Button1Click(Sender: TObject);
begin
opendialog1.InitialDir:=Path+'\Image';
   opendialog1.Execute;
   if OpenDialog1.FileName<> '' then
   begin
   Kart.LoadFromFile(OpenDialog1.FileName);
   Orig.Canvas.StretchDraw(Rect(0,0,480,320),Kart);//� ����������� �������� �� �������� 480�320
   Puzzle;
   form1.show;
   form3.visible:=false;
   end;

end;
//������ "���������" ��������� form 4(����� � ������� ������� ���������) � �������� form3
procedure TForm3.Button2Click(Sender: TObject);
begin
form4.show;
form3.visible:=false;
end;
//������ "���������" ��������� form 2(����� � ������� ������� ���������) � �������� form3
procedure TForm3.Button3Click(Sender: TObject);
begin
form2.show;
form3.visible:=false;
end;

end.
