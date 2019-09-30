unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RSA, StdCtrls, ToolWin, ComCtrls, ranlib, FGInt, FGIntPrimeGeneration;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Memo1: TMemo;
    Memo2: TMemo;
    Button1: TButton;
    Button2: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RSA1: TRSA;
    GroupBox2: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Button3: TButton;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit14: TEdit;
    Button4: TButton;
    Edit6: TEdit;
    Label6: TLabel;
    Edit7: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Edit8: TEdit;
    Button5: TButton;
    Label9: TLabel;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo2.Lines.Clear;
  Memo2.Text := RSA1.EncryptStr(Memo1.Text);
  Label9.Caption := '长度为：'+InttoStr(Length(Memo2.Lines.GetText));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  Memo1.Text := RSA1.DecryptStr(Memo2.Text);
end;

procedure TForm1.Button3Click(Sender: TObject);
var seed, i: integer;
var s,s2: string;
begin
  seed := Round(Time()*3600000.0);

  WRandomInit(seed);

  for i := 1 to 20 do begin
    WRandom();
    WIRandom(0,1000);
  end;
  s:=floattostr(WIRandom(0,1000000000));
  s2:=floattostr(WIRandom(0,1000000000));

  edit4.text:=s;
  edit5.text:=s2;
end;

procedure TForm1.Button4Click(Sender: TObject);
var	
   n, e, d, dp, dq, p, q, phi, one, two, gcd, temp, nilgint,te1,te2,te3 : TFGInt;
   test, signature : String;
   p1,q1,dp1,dq1,e1,d1,n1,nil1,gcdStr:string;
   ok : boolean;
begin
// Enter a random number to generate a prime, i.e.
 // incremental search starting from that number
   Base10StringToFGInt(edit4.text, p);
   PrimeSearch(p);//产生质数
   Base256StringToFGInt(edit5.text, q);//对可视字符解码，使之成为数字
   PrimeSearch(q);//产生质数
 // Compute the modulus
   FGIntMul(p, q, n);//作p*q=n

 // Compute p-1, q-1 by adjusting the last digit of the GInt
   p.Number[1] := p.Number[1] - 1;//把p的最后一位减1
   q.Number[1] := q.Number[1] - 1;
 // Compute phi(n)
   FGIntMul(p, q, phi);//作(p-1)*(q-1)=phi
 // Choose a public exponent e such that GCD(e,phi)=1 //找出与phi（就是(p-1)*(q-1)）互质的数（r）
 // common values are 3, 65537 but if these aren 't coprime
 // to phi, use the following code
   Base10StringToFGInt(Edit14.Text, e); // just an odd starting point
   Base10StringToFGInt('1', one);
   Base10StringToFGInt('2', two);
   FGIntGCD(phi, e, gcd);       //检验是否互质的函数,如果PHI和E互质，GCD等于1
   While FGIntCompareAbs(gcd, one) <> Eq Do     //寻找互质数
   Begin
      FGIntadd(e, two, temp);  //每次循环加2
      FGIntCopy(temp, e);
      FGIntGCD(phi, e, gcd);
   End;
   FGIntToBase10String(e,gcdstr);
   //edit12.text:=gcdstr;     
   FGIntDestroy(two);
   FGIntDestroy(one);
   FGIntDestroy(gcd);
 // Compute the modular (multiplicative) inverse of e, i.e. the secret exponent (key)
   FGIntModInv(e, phi, d);
   FGIntModInv(e, p, dp);
   FGIntModInv(e, q, dq);
   p.Number[1] := p.Number[1] + 1;
   q.Number[1] := q.Number[1] + 1;
   Base10StringToFGInt('100', te1);
   Base10StringToFGInt('25', te2);
   FGIntMul(te1,te2,te3);
   FGIntToBase10String(p,p1);
   //edit3.text:=p1;
   FGIntToBase10String(q,q1);
   //edit4.text:=q1;
   FGIntToBase10String(dp,dp1);
  // edit5.text:=dp1;
   FGIntToBase10String(dq,dq1);
   //edit6.text:=dq1;     }
   FGIntToBase10String(e,e1);
   edit6.text:=e1;
   FGIntToBase10String(n,n1);
   edit7.text:=n1;
   FGIntToBase10String(d,d1);
   edit8.text:=d1;
   {FGIntToBase10String(n,n1);
   edit9.text:=n1;
   FGIntToBase10String(phi,nil1);
   edit10.text:=nil1;  }
   FGIntDestroy(phi);

   FGIntDestroy(nilgint);

 // Now everything is set up to start Encrypting/Decrypting, Signing/Verifying
{   test := 'eagles may soar high, but weasles do not get sucked into jet engines';

   RSAEncrypt(test, e, n, test);
   RSADecrypt(test, d, n, Nilgint, Nilgint, Nilgint, Nilgint, test);
 // this Is faster : RSADecrypt(test, nilGInt, n, dp, dq, p, q, test);
   RSASign(test, d, n, Nilgint, Nilgint, Nilgint, Nilgint, signature);
 // this Is faster : RSASign(test, nilgint, n, dp, dq, p, q, signature);
   RSAVerify(test, signature, e, n, ok);    }

   FGIntDestroy(p);
   FGIntDestroy(q);
   FGIntDestroy(dp);
   FGIntDestroy(dq);
   FGIntDestroy(e);
   FGIntDestroy(d);
   FGIntDestroy(n);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Edit1.Text := Edit6.Text;
  Edit2.Text := Edit7.Text;
  Edit3.Text := Edit8.Text;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  RSA1.CommonalityKey:=Edit1.Text;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
  RSA1.CommonalityMode:=Edit2.Text;
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
  RSA1.PrivateKey:=Edit3.Text;
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  RSA1.Server:=RadioButton1.Checked;
end;

end.
