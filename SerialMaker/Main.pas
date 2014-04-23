unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SerialUtils, Mask, JvExMask, JvToolEdit, Utils,
  JvComponent, JvCABFile, JvZlibMultiple;

type
  TSerialForm = class(TForm)
    edtA: TEdit;
    edtB: TEdit;
    lbA: TLabel;
    lbB: TLabel;
    edtRes: TEdit;
    lbRes: TLabel;
    btGenerate: TButton;
    btQuit: TButton;
    btRand: TButton;
    lbUser: TLabel;
    edtUser: TEdit;
    lbOrg: TLabel;
    edtOrg: TEdit;
    btCheck: TButton;
    btRU: TButton;
    btSave: TButton;
    SaveDialog: TSaveDialog;
    Label1: TLabel;
    deDate: TJvDateEdit;
    edtInfo: TJvFilenameEdit;
    Label2: TLabel;
    aZIP: TJvZlibMultiple;
    procedure btQuitClick(Sender: TObject);
    procedure btGenerateClick(Sender: TObject);
    procedure btRandClick(Sender: TObject);
    procedure btCheckClick(Sender: TObject);
    procedure btRUClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Failures, Tests,
      AFailures : Integer;

    Testing : Boolean;  
  end;

var
  SerialForm: TSerialForm;

implementation

{$R *.dfm}

procedure TSerialForm.btQuitClick(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TSerialForm.btGenerateClick(Sender: TObject);
begin
 //
 // Generate code :

 if ( Length(edtUser.Text) < 4 ) or
    ( Length(edtOrg.Text) < 4 ) then
      begin
        Application.MessageBox('Invalid username/organisation supplied !!', 'Error', 0);
        Exit;
      end;

 edtRes.Color := clSilver;

 edtRes.Text := GenerateSerialNumber( edtA.Text, edtB.Text, edtUser.Text, edtOrg.Text);

try
 if not ValidateSNIntegrity(edtRes.Text, edtUser.Text, edtOrg.Text) then
    edtRes.Color := clRed;
except
 edtRes.Color := clRed;
end;

end;

procedure TSerialForm.btRandClick(Sender: TObject);
begin
 //

 edtRes.Color := clSilver;

repeat
 Randomize;
 edtA.Text :=
              IntToBase(Random(36*36))+IntToBase(Random(36*36))+IntToBase(Random(36*36));

 Randomize;
 edtB.Text := IntToBase(Random(36*36))+IntToBase(Random(36*36))+IntToBase(Random(36*36));

until (ValidateBase(edtA.Text) and ValidateBase(edtB.Text));

end;

procedure TSerialForm.btCheckClick(Sender: TObject);
var
 ix, iy : Integer;
begin
//

Testing  := not Testing;

if Testing then
  begin
   btCheck.Caption := 'Stop Checking';
   Application.MessageBox('This action will check the efficacity of your algorithm !', 'Info', 0);

   Failures := 0;
   AFailures:= 0;
   Tests    := 0;
  end else
  begin
   btCheck.Caption := 'Check Algorithm';
   exit;
  end;

for iy := 1 to 500 do
begin
 Application.ProcessMessages();
 if not Testing then Break;

 btRU.Click();

 for ix := 1 to 500 do
   begin
     if not Testing then Break;

     btRand.Click();
     btGenerate.Click();
     Inc( Tests );
     if (edtRes.Color = clRed) and (ValidateSNBases(edtRes.Text)) then
       begin
         Inc( Failures );
       end else
     if (edtRes.Color = clRed) then
       begin
         Inc( AFailures );
       end;
   end;
end;
 Application.MessageBox(PChar('<Statistics> '+#13+#10+
                        '   - Total       : '+IntToStr(Tests)+#13+#10+
                        '   - Failed      : '+IntToStr(Failures)+#13+#10+
                        '   - G.Failed   : '+IntToStr(AFailures)+#13+#10+
                        '   - G.Rate     : '+FloatToStr(100 - (AFailures/Tests) * 100)+#13+#10+
                        '   - Rate        : '+FloatToStr(100 - (Failures/Tests) * 100)),  'Wrong', 0);
end;

procedure TSerialForm.btRUClick(Sender: TObject);
begin
 Randomize;
 edtUser.Text :=
              IntToBase(Random(36*36))+IntToBase(Random(36*36))+IntToBase(Random(36*36));
 Randomize;
 edtOrg.Text := IntToBase(Random(36*36))+IntToBase(Random(36*36))+IntToBase(Random(36*36));

end;

procedure TSerialForm.btSaveClick(Sender: TObject);
var
 St, Kp, Fns  : TStrings;
 BCode   : String;
 KeyInfo : String;
begin
 SaveDialog.FileName := '';

 if SaveDialog.Execute() then
 begin
   if ExtractFileExt( SaveDialog.FileName ) = '' then
      SaveDialog.FileName := SaveDialog.FileName + '.edkl';

   Kp := TStringList.Create();
   Kp.LoadFromFile( edtInfo.FileName );
   KeyInfo := Kp.Text;
   Kp.Destroy;

   St := TStringList.Create();

    begin
     St.Add(';0.21%f;Eduka+ Key File;');

     BCode := StringToBinaryCode( WordToStrDirect( Length( edtUser.Text ) ) + edtUser.Text +
                                  WordToStrDirect( Length( edtOrg.Text ) ) + edtOrg.Text +
                                  WordToStrDirect( Length( edtRes.Text ) ) + edtRes.Text +
                                  WordToStrDirect( Length( KeyInfo ) ) + KeyInfo +
                                  WordToStrDirect( Length( FloatToStr( Date() ) ) ) +
                                  FloatToStr( Date() ) +
                                  WordToStrDirect( Length( FloatToStr( deDate.Date ) ) ) +
                                  FloatToStr( deDate.Date )
                                 );

     BCode := StringTo8ByteRep( BCode, VersionBase );
     St.Add( BCode );

     St.SaveToFile( SaveDialog.FileName + '.txt' );

     Fns := TStringList.Create();
     Fns.Add( SaveDialog.FileName + '.txt' );
     aZIP.CompressFiles( Fns, SaveDialog.FileName );
    end;

    St.Destroy();
 end;
 
end;

end.


