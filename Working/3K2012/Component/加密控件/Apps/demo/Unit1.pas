unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DCPcrypt, Blowfish, Haval, Md4, Md5, Rmd160, Sha1,
  Twofish, Rijndael, RC5, RC6, RC4, RC2, Misty1, Mars, IDEA, Ice, Gost,
  DES, Cast256, Cast128;

type
  TForm1 = class(TForm)
    DCP_blowfish1: TDCP_blowfish;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    DCP_cast1281: TDCP_cast128;
    DCP_cast2561: TDCP_cast256;
    DCP_des1: TDCP_des;
    DCP_3des1: TDCP_3des;
    DCP_gost1: TDCP_gost;
    DCP_ice1: TDCP_ice;
    DCP_ice21: TDCP_ice2;
    DCP_thinice1: TDCP_thinice;
    DCP_idea1: TDCP_idea;
    DCP_mars1: TDCP_mars;
    DCP_misty11: TDCP_misty1;
    DCP_rc21: TDCP_rc2;
    DCP_rc41: TDCP_rc4;
    DCP_rc61: TDCP_rc6;
    DCP_rc51: TDCP_rc5;
    DCP_rijndael1: TDCP_rijndael;
    DCP_twofish1: TDCP_twofish;
    DCP_sha11: TDCP_sha1;
    DCP_ripemd1601: TDCP_ripemd160;
    DCP_md51: TDCP_md5;
    DCP_md41: TDCP_md4;
    DCP_haval1: TDCP_haval;
    GroupBox1: TGroupBox;
    ComboBox1: TComboBox;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button2: TButton;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Edit4: TEdit;
    ComboBox2: TComboBox;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
// var
//    Source, Dest: string;
//    Cipher: TDCP_blowfish;
  begin
//    Cipher:= TDCP_blowfish.Create(nil);
    case ComboBox1.ItemIndex of
      0:
        begin
          DCP_blowfish1.InitStr(edit3.text);
          DCP_blowfish1.Reset;
          edit1.text:= DCP_blowfish1.EncryptString(edit4.text);
          DCP_blowfish1.Reset;
          edit2.text:= DCP_blowfish1.DecryptString(edit1.text);
        end;
      1:
        begin
          DCP_cast1281.InitStr(edit3.text);
          DCP_cast1281.Reset;
          edit1.text:= DCP_cast1281.EncryptString(edit4.text);
          DCP_cast1281.Reset;
          edit2.text:= DCP_cast1281.DecryptString(edit1.text);
        end;
      2:
        begin
          DCP_cast2561.InitStr(edit3.text);
          DCP_cast2561.Reset;
          edit1.text:= DCP_cast2561.EncryptString(edit4.text);
          DCP_cast2561.Reset;
          edit2.text:= DCP_cast2561.DecryptString(edit1.text);
        end;
      3:
        begin
          DCP_des1.InitStr(edit3.text);
          DCP_des1.Reset;
          edit1.text:= DCP_des1.EncryptString(edit4.text);
          DCP_des1.Reset;
          edit2.text:= DCP_des1.DecryptString(edit1.text);
        end;
      4:
        begin
          DCP_3des1.InitStr(edit3.text);
          DCP_3des1.Reset;
          edit1.text:= DCP_3des1.EncryptString(edit4.text);
          DCP_3des1.Reset;
          edit2.text:= DCP_3des1.DecryptString(edit1.text);
        end;
      5:
        begin
          DCP_gost1.InitStr(edit3.text);
          DCP_gost1.Reset;
          edit1.text:= DCP_gost1.EncryptString(edit4.text);
          DCP_gost1.Reset;
          edit2.text:= DCP_gost1.DecryptString(edit1.text);
        end;
      6:
        begin
          DCP_ice1.InitStr(edit3.text);
          DCP_ice1.Reset;
          edit1.text:= DCP_ice1.EncryptString(edit4.text);
          DCP_ice1.Reset;
          edit2.text:= DCP_ice1.DecryptString(edit1.text);
        end;
      7:
        begin
          DCP_ice21.InitStr(edit3.text);
          DCP_ice21.Reset;
          edit1.text:= DCP_ice21.EncryptString(edit4.text);
          DCP_ice21.Reset;
          edit2.text:= DCP_ice21.DecryptString(edit1.text);
        end;
      8:
        begin
          DCP_idea1.InitStr(edit3.text);
          DCP_idea1.Reset;
          edit1.text:= DCP_idea1.EncryptString(edit4.text);
          DCP_idea1.Reset;
          edit2.text:= DCP_idea1.DecryptString(edit1.text);
        end;
      9:
        begin
          DCP_mars1.InitStr(edit3.text);
          DCP_mars1.Reset;
          edit1.text:= DCP_mars1.EncryptString(edit4.text);
          DCP_mars1.Reset;
          edit2.text:= DCP_mars1.DecryptString(edit1.text);
        end;
      10:
        begin
          DCP_misty11.InitStr(edit3.text);
          DCP_misty11.Reset;
          edit1.text:= DCP_misty11.EncryptString(edit4.text);
          DCP_misty11.Reset;
          edit2.text:= DCP_misty11.DecryptString(edit1.text);
        end;
      11:
        begin
          DCP_rc21.InitStr(edit3.text);
          DCP_rc21.Reset;
          edit1.text:= DCP_rc21.EncryptString(edit4.text);
          DCP_rc21.Reset;
          edit2.text:= DCP_rc21.DecryptString(edit1.text);
        end;
      12:
        begin
          DCP_rc41.InitStr(edit3.text);
          DCP_rc41.Reset;
          edit1.text:= DCP_rc41.EncryptString(edit4.text);
          DCP_rc41.Reset;
          edit2.text:= DCP_rc41.DecryptString(edit1.text);
        end;
      13:
        begin
          DCP_rc51.InitStr(edit3.text);
          DCP_rc51.Reset;
          edit1.text:= DCP_rc51.EncryptString(edit4.text);
          DCP_rc51.Reset;
          edit2.text:= DCP_rc51.DecryptString(edit1.text);
        end;
      14:
        begin
          DCP_rc61.InitStr(edit3.text);
          DCP_rc61.Reset;
          edit1.text:= DCP_rc61.EncryptString(edit4.text);
          DCP_rc61.Reset;
          edit2.text:= DCP_rc61.DecryptString(edit1.text);
        end;
      15:
        begin
          DCP_rijndael1.InitStr(edit3.text);
          DCP_rijndael1.Reset;
          edit1.text:= DCP_rijndael1.EncryptString(edit4.text);
          DCP_rijndael1.Reset;
          edit2.text:= DCP_rijndael1.DecryptString(edit1.text);
        end;
      16:
        begin
          DCP_thinice1.InitStr(edit3.text);
          DCP_thinice1.Reset;
          edit1.text:= DCP_thinice1.EncryptString(edit4.text);
          DCP_thinice1.Reset;
          edit2.text:= DCP_thinice1.DecryptString(edit1.text);
        end;
      17:
        begin
          DCP_twofish1.InitStr(edit3.text);
          DCP_twofish1.Reset;
          edit1.text:= DCP_twofish1.EncryptString(edit4.text);
          DCP_twofish1.Reset;
          edit2.text:= DCP_twofish1.DecryptString(edit1.text);
        end;

     end;
//    DCP_blowfish1.Burn;
//    DCP_blowfish1.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ComboBox1.Items.Add('blowfish');
  ComboBox1.Items.Add('cost128');
  ComboBox1.Items.Add('cost256');
  ComboBox1.Items.Add('des');
  ComboBox1.Items.Add('3des');
  ComboBox1.Items.Add('gost');
  ComboBox1.Items.Add('ice');
  ComboBox1.Items.Add('ice2');
  ComboBox1.Items.Add('idea');
  ComboBox1.Items.Add('mars');
  ComboBox1.Items.Add('misty1');
  ComboBox1.Items.Add('rc2');
  ComboBox1.Items.Add('rc4');
  ComboBox1.Items.Add('rc5');
  ComboBox1.Items.Add('rc6');
  ComboBox1.Items.Add('rijndael');
  ComboBox1.Items.Add('thinice');
  ComboBox1.Items.Add('twofish');
  ComboBox2.Items.Add('HAVAL');
  ComboBox2.Items.Add('MD4');
  ComboBox2.Items.Add('MD5');
  ComboBox2.Items.Add('RMD160');
  ComboBox2.Items.Add('SHA1');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Read,len: integer;
  HashDigest: array[0..31] of byte;
  S: string;
begin
  S:=edit4.Text;
  case ComboBox2.ItemIndex of
    0:
      begin
        DCP_HAVAL1.Init ;
        DCP_HAVAL1.UpdateStr(S);
        DCP_HAVAL1.Final(HashDigest);
        len:=DCP_HAVAL1.HashSize;
      end;
    1:
      begin
        DCP_MD41.Init ;
        DCP_MD41.UpdateStr(S);
        DCP_MD41.Final(HashDigest);
        len:=DCP_MD41.HashSize;
      end;
    2:
      begin
        DCP_MD51.Init ;
        DCP_MD51.UpdateStr(S);
        DCP_MD51.Final(HashDigest);
        len:=DCP_MD51.HashSize;
      end;
    3:
      begin
        DCP_ripemd1601.Init;
        DCP_ripemd1601.UpdateStr(S);
        DCP_ripemd1601.Final(HashDigest);
        len:=DCP_ripemd1601.HashSize;
      end;
    4:
      begin
        DCP_SHA11.Init ;
        DCP_SHA11.UpdateStr(S);
        DCP_SHA11.Final(HashDigest);
        len:=DCP_SHA11.HashSize;
      end;
  end;
  s:='';
  for Read:= 0 to ((len div 8)-1) do
  s:= s + IntToHex(HashDigest[Read],2);
  edit1.Text:= s;
end;

end.
