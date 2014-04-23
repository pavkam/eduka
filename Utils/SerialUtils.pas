(*

The Original Code is: SerialUtils.pas, released 2005-08-22.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
    Serial Numbering.

*)

{ Include Compile Directives ! }
{$IFDEF SER_MAKER}
 {$I ..\Utils\directives.inc}
{$ELSE}
 {$I Utils\directives.inc}
{$ENDIF}

unit SerialUtils;
interface
Uses SysUtils, Registry, Windows, Classes, Utils;
Const
 VersionBase = 'bt17.0144';

Type
 ABCString = String[2];
 TBaseInts = array[1..3] of Integer;

function GenerateSerialNumber( Base1, Base2, User, Org : String ) : String;
function IntToBase(Int : Integer) : String;
function ValidateSNIntegrity( SN, User, Org : String ) : boolean;
function ValidateBase( St : String ) : boolean;
function ValidateSNBases( SN : String ) : boolean;


function StringToBinaryCode( St1 : String ) : String;
function BinaryCodeToString( St1 : String ) : String;

function ValidateSerialNumber( SN, User, Org : string; nFrom, nDate : TDateTime ) : boolean;

function ValidateKeyInfo( KeyFile : String; var sUser, sOrg, sInfo : String; var sDate : TDateTime  ) : boolean; overload;
function ValidateKeyInfo( Key : TStrings; var sUser, sOrg, sInfo : String; var sDate : TDateTime  ) : boolean; overload;

function LocalKeyFile() : string;

function CharTo8ByteRep( Ch : Char; Bt : Byte ) : String;
function StringTo8ByteRep( St, Rep : String ) : String;

function _8ByteRepToChar( Ch8 : String; bt : Byte ) : Char;
function _8ByteRepToString( St, Rep : String ) : String;

function StickStrings( St : String ) : String;

function StringToByteRep( St : String ) : String;
function ByteRepToString( St : String ) : String;

implementation
Const
 Els  = 7;

 Conv : array[1..Els, 0..1] of Integer = ( (1, Ord('0')), (2, Ord('1')), (5, Ord('2')),
                                           (15, Ord('/')), (35, Ord('X')),
                                           (75, Ord('Y')), (150, Ord('Z'))
                                         );
                                         
function ConvertABCtoInteger( St : ABCString ) : Integer;
var
 i1, i2 : Integer;
begin
 ASSERT( Length(St) = 2, 'Invalid string length passed to this func !');

 if ( St[1] in ['0'..'9'] ) then i1 := Ord(St[1]) - Ord('0') else
                                 i1 := Ord(St[1]) - Ord('A') + 10;

 if ( St[2] in ['0'..'9'] ) then i2 := Ord(St[2]) - Ord('0') else
                                 i2 := Ord(St[2]) - Ord('A') + 10;

 Result := 36 * i1 + i2;

end;

function ConvertBaseToInteger( St : String ) : TBaseInts;
begin
 ASSERT( Length(St) = 6, 'Invalid string length passed to this func !');

 Result[1] := ConvertABCtoInteger(St[1]+St[2]);
 Result[2] := ConvertABCtoInteger(St[3]+St[4]);
 Result[3] := ConvertABCtoInteger(St[5]+St[6]);
end;

function ValidateBase( St : String ) : boolean;
var
 i : integer;
begin
 St := UpperCase(St);
 Result := False;
 if Length( St ) <> 6 then St := '';

 for i:= 1 to Length(St) do
   if not (St[i] in ['0'..'9', 'A'..'Z']) then Exit;

 if (St[1] = '0') and (St[2] = '0' ) then exit;
 if (St[3] = '0') and (St[4] = '0' ) then exit;
 if (St[5] = '0') and (St[6] = '0' ) then exit;

 Result := True;
end;

function IntToBase(Int : Integer) : String;
var
 i1, i2 : integer;
 s1, s2 : string;
begin
 i2     := (Int mod 36);
 i1     := (Int div 36);

 if i1 < 10 then s1 := Char(Ord('0') + i1) else
                 s1 := Char(Ord('A') + i1 - 10);

 if i2 < 10 then s2 := Char(Ord('0') + i2) else
                 s2 := Char(Ord('A') + i2 - 10);

 Result := s1 + s2;

end;

function BaseIntsToString( bi : TBaseInts ) : String;
begin
 Result := IntToBase(bi[1])+IntToBase(bi[2])+IntToBase(bi[3])
end;

function BigIntToBase( bi : Integer ) : String;
var
 vu : TBaseInts;
begin
 vu[1] := (bi mod 36*36);
  bi := bi div 36*36;

 vu[2] := (bi mod 36*36);
  bi := bi div 36*36;

 if bi > 36*36 then bi := 36*36;
 vu[3] := bi;

 Result := BaseIntsToString( vu );
end;

function InterlaceBases( b1, b2 : string; IdSig : Integer ) : string;
var
 s1, s2, s3 : TBaseInts;
 i1, i2, i3 : Integer;
begin
 s1 := ConvertBaseToInteger(b1);
 s2 := ConvertBaseToInteger(b2);


 i1 := (s1[1] mod s2[1]);
 i2 := (s1[2] mod s2[2]);
 i3 := (s1[3] mod s2[3]);

 i1 := i1 * (IdSig mod s2[1]);
 i2 := i2 * (IdSig mod s2[2]);
 i3 := i3 * (IdSig mod s2[3]);

 s3[1] := (i1) mod (36 * 36);
 s3[2] := (i2) mod (36 * 36);
 s3[3] := (i3) mod (36 * 36);

 Result := BaseIntsToString(s3);
end;


procedure SwapBase2(var Base1, Base2 : String);
var
 s1,s2,s3 : Char;
begin
 s1 := Base1[1];
 s2 := Base1[3];
 s3 := Base1[6];

 Base1[1] := Base2[1];
 Base1[3] := Base2[3];
 Base1[6] := Base2[6];

 Base2[1] := s1;
 Base2[3] := s2;
 Base2[6] := s3;

end;

function BCodeFromStr(St : String) : Integer;
var
 i,x : Integer;
begin
 x      := 0;
 result := 0;

 if St = '' then exit;

 for i := 1 to Length(St) do
  begin
     x := x + Ord(St[i]) * i * sqr(Ord(St[i]) + i*3);
  end;

  result := x;
end;

function CCodeFromStr(St : String) : Integer;
var
 i,x : Integer;
begin
 x      := 0;
 result := 0;

 if St = '' then exit;

 for i := 1 to Length(St) do
  begin
     x := x + Ord(St[i]) * sqr(Ord(St[i]) + i*4);
  end;

  result := x;
end;

function GenerateSerialNumber( Base1, Base2, User, Org : String ) : String;
var
 r     : string;
 BBase : Integer;
begin
 Base1 := UpperCase(Base1);
 Base2 := UpperCase(Base2);

 Result := 'Error. Invalid bases supplied';
 if not ValidateBase( Base1 ) then exit;
 if not ValidateBase( Base2 ) then exit;

 BBase := (BCodeFromStr( AnsiUpperCase(User) ) + CCodeFromStr( AnsiUpperCase(Org) ));

 r := InterlaceBases( Base1, Base2, BBase);

 if not ValidateBase(r) then
    begin
      Result := 'Invalid combination of in data !';
      exit;
    end;

 SwapBase2(Base1, Base2);



 Result := Base1+'-'+r+'-'+Base2;

end;

function ValidateSNBases( SN : String ) : boolean;
var
 b1, b2, b3 : String;
begin
 Result := False;

 b1 := Copy(SN, 1, 6);
 b2 := Copy(SN, 8, 6);
 b3 := Copy(SN, 15, 6);

 if not ValidateBase(b1) then exit;
 if not ValidateBase(b2) then exit;
 if not ValidateBase(b3) then exit;

 result := true;
end;

function ValidateSNIntegrity( SN, User, Org : String ) : boolean;
var
 b1, b2, b3 : String;
 BBase     : Integer;
begin
 Result := False;

 b1 := Copy(SN, 1, 6);
 b2 := Copy(SN, 8, 6);
 b3 := Copy(SN, 15, 6);

 if not ValidateBase(b1) then exit;
 if not ValidateBase(b2) then exit;
 if not ValidateBase(b3) then exit;

 SwapBase2(b1, b3);
 BBase  := (BCodeFromStr( AnsiUpperCase(User) ) + CCodeFromStr( AnsiUpperCase(Org) ));
 result := (b2 = InterlaceBases( b1, b3, BBase ));

end;

function CharToBCode( Ch : Char ) : String;
var
 i, k  : Integer;

begin
 Randomize;

 i := Ord( Ch );
 Result := '';

 if i = 0 then Result := '@';

 while i > 0 do
 begin
  for k := Els downto 1 do
   if i >= Conv[ k, 0 ] then
    begin
     Result := Result + Chr(Conv[ k, 1 ]);
     i := i - Conv[ k, 0 ];
     break;
    end;

 end;

 Assert( Length(Result) <= Els );
 Result := Chr(Conv[ Length(Result), 1 ]) + Result + Chr( 32 + Random(80)) + Chr( 32 + Random(80));

end;

function StringToBinaryCode( St1 : String ) : String;
var
 i : Integer;
begin
 Result := '';

 if St1 <> '' then
 for i := 1 to Length( St1 ) do
  begin
   Result := Result + CharToBCode( St1[i] );
  end;

end;

function _atoi( Ascii : String) : Integer;
Var
 Error : Integer;
begin
  Val(Ascii, Result, Error);
end;

function FindConv( Ch : Char ) : Integer;
var
 i : Integer;
begin
 Result := 0;

 for i := 1 to Els do
   if Conv[ i, 1 ] = Ord( Ch ) then begin Result := i; exit; end;

end;

function FindAdd( Ch : Char ) : Integer;
var
 i : Integer;
begin
 Result := 0;

 if Ch = '@' then Exit;
 
 i := FindConv( Ch );
 if i = 0 then Exit;

 Result := Conv[ i, 0 ];
end;

function BinaryCodeToString( St1 : String ) : String;
var
 i, Ch, l : Integer;
begin
 Result := '';
 Ch     := 0;

 while Length( St1 ) > 0 do
  begin
   l := FindConv( St1[1] );
   if (l = 0) or ( Length(St1) < (l+1) ) then Exit;

   for i := 1 to l do
       Ch := Ch + FindAdd( St1[ i + 1 ] );

   Result := Result + Chr( Ch ); Ch := 0;
   Delete( St1, 1, l + 1 + 2 { 2 bytes random } );    
  end;
  
end;

function ValidateSerialNumber( SN, User, Org : string; nFrom, nDate : TDateTime ) : boolean;
begin
 result := true;
try
 if not ValidateSNIntegrity( SN, User, Org ) or (Date > nDate) or ( nFrom > Date ) then
    raise EInOutError.Create('This shouldn''t have happened !!!!!');
except
    raise EInOutError.Create('This shouldn''t have happened !!!!!');
end;

end;

function LocalKeyFile() : string;
begin
 Result := ExtractFilePath( ParamStr(0) ) + 'edukaplus.edkl';
end;

function ValidateKeyInfo( KeyFile : String; var sUser, sOrg, sInfo : String; var sDate : TDateTime ) : boolean;
var
 St : TStrings;
begin
 St := LoadFileIntoStringList( KeyFile );

 St.Count;
 Result := ValidateKeyInfo( St, sUser, sOrg, sInfo, sDate );

 St.Destroy;
end;

function ExtractUserOrgSerial( ssLine : String; var ssUser, ssOrg, ssSerial, ssInfo : String; var ssFrom, ssDate : TDateTime ) : boolean;
var
 l, i, x : Integer;
 arp     : array[1..6] of string;
begin
 Result := false;
 ssLine := BinaryCodeToString( _8ByteRepToString( ssLine, VersionBase ) );

 if ssLine = '' then Exit;

 x := 1;

 arp[ 1 ] := '';
 arp[ 2 ] := '';
 arp[ 3 ] := '';

 arp[ 4 ] := '';
 arp[ 5 ] := '';
 arp[ 6 ] := '';

 while ssLine <> '' do
  begin
    l := StrDirectToWord( ssLine[1] + ssLine[2] );
    if Length( ssLine ) < l + 2 then Exit;

    for i := 3 to l + 2 do
     arp[x] := arp[x] + ssLine[i];

    Delete(ssLine, 1, l + 2);
    Inc(x);

    if x > 7 then Exit;
  end;

  ssUser   := arp[1];
  ssOrg    := arp[2];
  ssSerial := arp[3];
  ssInfo   := arp[4];

  ssFrom   := StrToFloat( arp[5] );
  ssDate   := StrToFloat( arp[6] );
  Result   := true;
end;

function ValidateKeyInfo( Key : TStrings; var sUser, sOrg, sInfo : String; var sDate : TDateTime ) : boolean; overload;
var
 i : Integer;
 ssUser, ssOrg, ssSerial, ssInfo : String;
 ssDate, ssFrom : TDateTime;
begin
 Result := False;

 if Key = nil then
    Key := TStringList.Create();

 for i := 1 to Key.Count - 1 do
  begin
   if not ExtractUserOrgSerial( Key.Strings[ i ], ssUser, ssOrg, ssSerial, ssInfo, ssFrom, ssDate ) then Continue;

  try
   if ValidateSerialNumber( ssSerial, ssUser, ssOrg, ssFrom, ssDate ) then
    begin
     Result := True;
     sUser := ssUser;
     sOrg  := ssOrg;
     sInfo := ssInfo;
     
     sDate := ssDate;
     Exit;
    end;
  except
   on Exception do continue;
  end;

  end;

  raise EInOutError.Create('This should not happen !');
end;

function ChOp( Bt, Wt : Byte; Nr : Integer ) : Integer;
begin
 if ((Bt shr Nr) and 1) = 1 then
    Result := Wt * 1 else
    Result := Wt * (-1);
end;

function CharTo8ByteRep( Ch : Char; Bt : Byte ) : String;
var
 I : Integer;
 a : array[1..8] of byte;
 st: String;
begin
 randomize;

 repeat
 for i := 1 to 8 do a[i] := Random(255);
 until ( ChOp( Bt, a[1], 0) +
         ChOp( Bt, a[2], 1) +
         ChOp( Bt, a[3], 2) +
         ChOp( Bt, a[4], 3) +
         ChOp( Bt, a[5], 4) +
         ChOp( Bt, a[6], 5) +
         ChOp( Bt, a[7], 6) +
         ChOp( Bt, a[8], 7) ) = Ord( Ch );

 Result := '';
 for i := 1 to 8 do
 begin
   st := inttostr( a[i] );

   if Length(st) < 3 then st := '0' + st;
   if Length(st) < 3 then st := '0' + st;

   Result := Result + St;
 end;

end;


function _8ByteRepToChar( Ch8 : String; Bt : Byte ) : Char;
var
 i, smm  : Integer;
 kk      : String;
begin
 kk := '';
 smm := 0;
 for i := 1 to Length( Ch8 ) do
   begin
     kk := kk + Ch8[ i ];
     if Length(kk) = 3 then
       begin
        smm := smm + ChOp( bt, atoi( kk ), ((i div 3) - 1) );
        kk := '';
       end;
   end;

 Result := Chr(smm);
end;

function StringTo8ByteRep( St, Rep : String ) : String;
var
 i, u : Integer;
 smm  : string;
begin
 smm := '';
 if St = '' then Exit;

 u := 0;
 for i := 1 to Length( St ) do
   begin
     Inc(u);
     if u > Length(Rep) then u := 1;

     smm := smm + CharTo8ByteRep( St[i], Ord(Rep[u]) );

   end;
   
 Result := smm;
end;

function _8ByteRepToString( St, Rep : String ) : String;
var
 i, k : Integer;
 sy   : String;
begin
 Result := '';
 if (St = '') or ((Length( St ) mod 24) <> 0) then Exit;

 sy := '';
 k  := 0;
 for i := 1 to Length( St ) do
  begin
   sy := sy + St[i];
   if length(Sy) = 24 then
    begin
     Inc(k);

     if k > Length(Rep) then k := 1;
     Result := Result + _8ByteRepToChar( sy, Ord(Rep[k]) );
     
     sy := '';
    end;

  end;

end;

function StickStrings( St : String ) : String;
begin
 Result := StringReplace( St, #13 + #10, '', [rfReplaceAll] );
end;

function StringToByteRep( St : String ) : String;
var
 stu : string;
 i  : integer;

begin
 Result := '';
 if St = '' then exit;

 for i := 1 to length(St) do
  begin
   stu     := inttostr( ord(st[i]) );

   if length(stu) < 3 then stu := '0' + stu;
   if length(stu) < 3 then stu := '0' + stu;

   Result := Result + stu;
  end;
end;

function ByteRepToString( St : String ) : String;
var
 stu : string;
 i  : integer;

begin
 Result := '';
 if St = '' then exit;

 for i := 1 to length(St) do
  begin
    stu := stu + st[i];

    if length(stu) = 3 then
       begin Result := Result + chr( atoi(stu) ); stu := ''; end;

  end;
end;

end.
