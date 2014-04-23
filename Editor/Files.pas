(*

The Original Code is: Files.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
    Unit implements the handling routines for file support.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit Files;
interface
uses StdCtrls, SysUtils, ProTypes, Version, Movement, Dialogs, Translate, Windows, Utils, ComCtrls
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;
{$IFDEF _DEBUG_}
Const
  DbgUName  =  '/Editor/Files.pas';
{$ENDIF}

 function flsEditorSaveToFile  (  _c_Duration,
                                  _c_Skill     : TComboBoxEx;
                                  _c_Author    : TEdit;
                                  Editor       : SyntaxTextHolder;
                                  FileName     : String
                                ) : Boolean;

 function flsEditorOpenFromFile(
                                 RealRead      : Boolean;
                                 _c_Duration,
                                 _c_Skill      : TComboBoxEx;
                                 _c_Author     : TEdit;
                                 Editor        : SyntaxTextHolder;
                                 FileName      : String
                                 ) : Boolean;

 function flsGetPackageFileCount( pk : String ) : Integer;
 function flsGetFileInstallLocation( pk : String; FileID : Integer) : String;
 function flsGetFileBody( pk : String; FileID : Integer ) : String; 
 function flsGetFilePackageTitle( pk : String ) : String;

 function flsGetActivePackageFiles( pk : String ) : Integer;
 function flsGetActivePackageFile( pk : String; Id : Integer ) : String;
 function flsPackageIsActive( pk : String) : boolean;
 procedure flsRemovePackageFiles( pk : String );
 function flsPackageIsUsed( pk : String) : boolean;
 function flsSaveFileToLocation( MetaFileName : String; FileBody : String) : boolean;

procedure flsSetDialogsFilter(SaveDlg : TSaveDialog; OpenDlg : TOpenDialog; InterpreterID : TProInterpreter);

implementation
var
 CommentOn_     : Boolean;
   CndStrings,
   RawStrings   : array[1 .. nCondTokens] of String;
   iIndex       : Integer;
   ReadError    : Boolean;



function CheckForConditional(St : String) : String;
var
 iId, iNm : Integer;
 iSk      : String;
begin
 Result := St;

 if St = '' then Exit;
 if St[1]<>'#' then Exit;

 iId := atoi(Copy(St, 2, Pos('$', St)-2 ));
 iNm := atoi(Copy(St, Pos('$', St)+1, Length(St) ));

 if (iId < 1) or (iId > 18) or (iNm < 1) or (iNm > nCondTokens) then Exit;

 iSk := lngExtractSpeX(iId, iNm);
 if iSk <> '' then Result := iSk else Result:=St;
end;


(*
 * TransX
 *)

{$WARNINGS OFF}
function TransX(Str : String;What : TProInterpreter) : String;
var
 St : String;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TransX (Str:'+DbgStr(Str)+'; What:'+DbgInt(Ord(What))+')');
   DbgPlus;
 {$ENDIF}

 St:=AnsiUpperCase(Str);
 Result:=Str;

 if Str='' then
     begin
    {$IFDEF _DEBUG2_}
      DbgMinus;
      DbgPrint(DbgUName+' : TransX = ' + DbgStr(Result));
    {$ENDIF}

    Exit;
   end;

 if Str[1]='{' then
     begin
    {$IFDEF _DEBUG2_}
      DbgMinus;
      DbgPrint(DbgUName+' : TransX = ' + DbgStr(Result));
    {$ENDIF}
    CommentOn_:=True;
    Exit;
   end;

 if Str[Length(Str)]='}' then
    begin
    {$IFDEF _DEBUG2_}
      DbgMinus;
      DbgPrint(DbgUName+' : TransX = ' + DbgStr(Result));
    {$ENDIF}
    CommentOn_:=False;
    Exit;
   end;

 if Str[1]='`' then
    begin
    {$IFDEF _DEBUG2_}
      DbgMinus;
      DbgPrint(DbgUName+' : TransX = ' + DbgStr(Result));
    {$ENDIF}
    CommentOn_:=True;
    Delete(Result,1,1);
    Exit;
   end;


 if Str[Length(Str)]='''' then
     begin
    {$IFDEF _DEBUG2_}
      DbgMinus;
      DbgPrint(DbgUName+' : TransX = ' + DbgStr(Result));
    {$ENDIF}
    CommentOn_:=False;
    Result:='';Delete(Result,Length(Str),1);
    Exit;
   end;

 if CommentOn_ then
    begin
    {$IFDEF _DEBUG2_}
      DbgMinus;
      DbgPrint(DbgUName+' : TransX = ' + DbgStr(Result));
    {$ENDIF}

    Exit;
   end;

  { eng -> lng }
  Result := CheckForConditional(Result);

  if What <> piAnt then if St=AnsiUpperCase(engSY_STEP)    then Result:=SY_STEP;
  if What = piKng  then if St=AnsiUpperCase(engSY_JUMP)    then Result:=SY_JUMP;
  if What <> piAnt then if St=AnsiUpperCase(engSY_ROTATE)  then Result:=SY_ROTATE;
  if What = piAnt  then if St=AnsiUpperCase(engSY_RIGHT)   then Result:=SY_RIGHT;
  if What = piAnt  then if St=AnsiUpperCase(engSY_LEFT)    then Result:=SY_LEFT;
  if What = piAnt  then if St=AnsiUpperCase(engSY_UP)      then Result:=SY_UP;
  if What = piAnt  then if St=AnsiUpperCase(engSY_DOWN)    then Result:=SY_DOWN;
  if What = piTux  then if St=AnsiUpperCase(engSY_Pick)    then Result:=SY_Pick;
  if What = piTux  then if St=AnsiUpperCase(engSY_Drop)    then Result:=SY_Drop;
  if What = piTux  then if St=AnsiUpperCase(engSY_Swap)    then Result:=SY_Swap;
  if What = piTux  then if St=AnsiUpperCase(engSY_Remember)then Result:=SY_Remember;
  if What = piTux  then if St=AnsiUpperCase(engSY_Restore) then Result:=SY_Restore;
  if What = piTux  then if St=AnsiUpperCase(engSY_Forget)  then Result:=SY_Forget;
  if What = piKng  then if St=AnsiUpperCase(engSY_IS_LINE) then Result:=SY_IS_LINE;
  if What <> piTux then if St=AnsiUpperCase(engSY_IS_BORDER) then Result:=SY_IS_BORDER;
  if What <> piTux then if St=AnsiUpperCase(engSY_TIMES)     then Result:=SY_TIMES;

  if St=AnsiUpperCase(engSY_START)     then Result:=SY_START;
  if St=AnsiUpperCase(engSY_END)       then Result:=SY_END;
  if St=AnsiUpperCase(engSY_DO)        then Result:=SY_DO;
  if St=AnsiUpperCase(engSY_WHILE)     then Result:=SY_WHILE;
  if St=AnsiUpperCase(engSY_UNTIL)     then Result:=SY_UNTIL;
  if St=AnsiUpperCase(engSY_REPEAT)    then Result:=SY_REPEAT;
  if St=AnsiUpperCase(engSY_IF)        then Result:=SY_IF;
  if St=AnsiUpperCase(engSY_ELSE)      then Result:=SY_ELSE;
  if St=AnsiUpperCase(engSY_PROCEDURE) then Result:=SY_PROCEDURE;
  if St=AnsiUpperCase(engSY_CALL)      then Result:=SY_CALL;
  if St=AnsiUpperCase(engSY_NOT)       then Result:=SY_NOT;
  if St=AnsiUpperCase(engSY_THEN)      then Result:=SY_THEN;

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TransX = ' + DbgStr(Result));
 {$ENDIF}
end;

function ConditionTillNow() : integer;
var
 I  : Integer;
 AP : String;
begin
  AP := '';
  for i:=1 to iIndex do AP := AP + ' ' + CndStrings [i];
  Result := lngListSpeX( AnsiUpperCase(AP) ) - _TuxCondition_;
end;

function GenerateCompositeResult(CI : Integer) : string;
var
 I   : Integer;
  CT : Integer;
begin
 Result :='';
 for i:=1 to iIndex do
   begin
    CT := lngTrulySpeX2( AnsiUpperCase(CndStrings [i]), CI);
    Result := Result +'#'+IntToStr(CI)+'$'+IntToStr(CT) + RawStrings [i];
    RawStrings [i] := '';
   end;
end;

function GenerateErrorResult() : string;
var
 I : Integer;
begin
 Result :='{!} ';
 for i:=1 to iIndex do
   begin
    if i = iIndex then
        Result := Result + '`'+CndStrings [i]+'''' +' {!}'+ RawStrings [i] else
        Result := Result + '`'+CndStrings [i]+'''' + RawStrings [i];
    RawStrings [i] := '';
   end;
end;


(*
 * TransLX
 *)

function TransLX(Str : String;What : TProInterpreter) : String;
var
 St : String;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TransLX (Str:'+DbgStr(Str)+'; What:'+DbgInt(Ord(What))+')');
   DbgPlus;
 {$ENDIF}
 St:=AnsiUpperCase(Str);
 Result:=Str;
 if Str='' then
    begin
    {$IFDEF _DEBUG2_}
      DbgMinus;
      DbgPrint(DbgUName+' : TransLX = ' + DbgStr(Result));
    {$ENDIF}

    Exit;
   end;

 if Str[1]='{' then
    begin
    {$IFDEF _DEBUG2_}
      DbgMinus;
      DbgPrint(DbgUName+' : TransLX = ' + DbgStr(Result));
    {$ENDIF}
    CommentOn_:=True;
    Exit;
   end;

 if Str[Length(Str)]='}' then
    begin
    {$IFDEF _DEBUG2_}
      DbgMinus;
      DbgPrint(DbgUName+' : TransLX = ' + DbgStr(Result));
    {$ENDIF}
    CommentOn_:=False;
    Exit;
   end;

 if CommentOn_ then
   begin
    {$IFDEF _DEBUG2_}
      DbgMinus;
      DbgPrint(DbgUName+' : TransLX = ' + DbgStr(Result));
    {$ENDIF}

    Exit;
   end;

 if Result = #0 then Result:= '' else
                     Result:='`'+Result+'''';


  if What <> piAnt then if St=AnsiUpperCase(SY_STEP)     then Result:=engSY_STEP;
  if What = piKng  then if St=AnsiUpperCase(SY_JUMP)     then Result:=engSY_JUMP;
  if What <> piAnt then if St=AnsiUpperCase(SY_ROTATE)   then Result:=engSY_ROTATE;
  if What = piAnt  then if St=AnsiUpperCase(SY_RIGHT)    then Result:=engSY_RIGHT;
  if What = piAnt  then if St=AnsiUpperCase(SY_LEFT)     then Result:=engSY_LEFT;
  if What = piAnt  then if St=AnsiUpperCase(SY_UP)       then Result:=engSY_UP;
  if What = piAnt  then if St=AnsiUpperCase(SY_DOWN)     then Result:=engSY_DOWN;
  if What = piTux  then if St=AnsiUpperCase(SY_Pick)     then Result:=engSY_Pick;
  if What = piTux  then if St=AnsiUpperCase(SY_Drop)     then Result:=engSY_Drop;
  if What = piTux  then if St=AnsiUpperCase(SY_Swap)     then Result:=engSY_Swap;
  if What = piTux  then if St=AnsiUpperCase(SY_Remember) then Result:=engSY_Remember;
  if What = piTux  then if St=AnsiUpperCase(SY_Restore)  then Result:=engSY_Restore;
  if What = piTux  then if St=AnsiUpperCase(SY_Forget)   then Result:=engSY_Forget;
  if What = piKng  then if St=AnsiUpperCase(SY_IS_LINE)  then Result:=engSY_IS_LINE;
  if What <> piTux then if St=AnsiUpperCase(SY_IS_BORDER)then Result:=engSY_IS_BORDER;
  if What <> piTux then if St=AnsiUpperCase(SY_TIMES)    then Result:=engSY_TIMES;

  if St=AnsiUpperCase(SY_START)     then Result:=engSY_START;
  if St=AnsiUpperCase(SY_END)       then Result:=engSY_END;
  if St=AnsiUpperCase(SY_DO)        then Result:=engSY_DO;
  if St=AnsiUpperCase(SY_WHILE)     then Result:=engSY_WHILE;
  if St=AnsiUpperCase(SY_UNTIL)     then Result:=engSY_UNTIL;
  if St=AnsiUpperCase(SY_REPEAT)    then Result:=engSY_REPEAT;
  if St=AnsiUpperCase(SY_IF)        then Result:=engSY_IF;
  if St=AnsiUpperCase(SY_ELSE)      then Result:=engSY_ELSE;
  if St=AnsiUpperCase(SY_PROCEDURE) then Result:=engSY_PROCEDURE;
  if St=AnsiUpperCase(SY_CALL)      then Result:=engSY_CALL;
  if St=AnsiUpperCase(SY_NOT)       then Result:=engSY_NOT;
  if St=AnsiUpperCase(SY_THEN)      then Result:=engSY_THEN;

  if What = piTux then
  begin
  if lngTrulySpeX(St) > 0 then
    begin
       Inc(iIndex);
       CndStrings[iIndex] := Str;
       Result        := '';
    end else
    begin
       if iIndex > 0 then
        begin
         if ConditionTillNow() > 0 then
          begin
            Result := GenerateCompositeResult(ConditionTillNow()) + Result;
            iIndex := 0;
          end else
          begin
            Result := GenerateErrorResult() + Result;
            iIndex := 0;
          end;
        end;
    end;
   end;

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TransLX = ' + DbgStr(Result));
 {$ENDIF}
end;
{$WARNINGS ON}


(*
 * ToEngCompatibility
 *)

function ToEngCompatibility(Str : String;What : TProInterpreter) : String;
var
 I       : Integer;
 Kappa   : Integer;
 NewLine,
   Lpi : String;
 Chg     : Boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : ToEngCompatibility (Str:'+DbgStr(Str)+'; What:'+DbgInt(Ord(What))+')');
   DbgPlus;
 {$ENDIF}
 Result := '';

 if Str = '' then
  begin
 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : ToEngCompatibility = ' + DbgStr(Result));
 {$ENDIF}
  Exit;
  end;
 NewLine:='';

 repeat
  Chg := False;
  I := Pos(#13+#10,Str);
  if I >0 then
   begin
    Delete(Str, I,2);
    Insert(#0, Str, I);
    Chg := True;
   end;
 until not Chg;

Lpi :='';
for Kappa := 1 to Length(Str) do
 begin
  if Str[Kappa] in DiroCharacters then
  begin
   if Kappa > 1 then
      if not IsSpace(Str[Kappa-1]) then Lpi := Lpi + ' ';
   Lpi := Lpi + Str[Kappa];
   if Kappa < Length(Str) then
      if not IsSpace(Str[Kappa+1]) then Lpi := Lpi + ' ';
  end else Lpi := Lpi + Str[Kappa];
 end;
Kappa := 0;
 Str := Lpi;

 if Str[Length(Str)] = #0 then
     Delete(Str,Length(Str), 1);

 for I :=1 to Length(Str) do
 begin
   if (not IsSpace(Str[I])) and (Kappa=0) then Kappa:=I;
   if (Kappa<>0) then
    begin
     Lpi := '';
    if (Str[I]=#0)  then begin Lpi:=TransLX(Copy(Str,Kappa,(I)-Kappa),What)+#0;Kappa:=0;end else
    if (IsSpace(Str[I])) then begin          Lpi:=TransLX(Copy(Str,Kappa,(I)-Kappa),What)+Str[I];Kappa:=0;end else
    if (Str[I]='{') then begin Lpi:=TransLX(Copy(Str,Kappa,(I)-Kappa),What)+TransLX('{',What) ;Kappa:=0;end else
    if (Str[I]='}') then begin Lpi:=TransLX(Copy(Str,Kappa,(I)-Kappa),What)+TransLX('}',What) ;Kappa:=0;end;

    if iIndex > 0 then RawStrings[iIndex] := RawStrings[iIndex] + Lpi else
      if Lpi<>'' then NewLine := NewLine + Lpi;

    end else
     if (Str<>'') and (Kappa=0) then
      begin
       if iIndex > 0 then RawStrings[iIndex] := RawStrings[iIndex] + Str[I] else
             NewLine:=NewLine+Str[I];
      end;       
  end;
  I:=Length(Str);
  if Kappa<>0 then NewLine:=NewLine+TransLX(Copy(Str,Kappa,I),What);

  if iIndex > 0 then NewLine:=NewLine+TransLX(#0,What);

  repeat
  Chg := False;
  I := Pos(#0,NewLine);
  if I >0 then
   begin
    Delete(NewLine, I, 1);
    Insert(#13+#10, NewLine, I);
    Chg := True;
   end;
 until not Chg;

 Result:=NewLine;

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : ToEngCompatibility = ' + DbgStr(Result));
 {$ENDIF}
end;


(*
 * ToLangCompatibility
 *)

function ToLangCompatibility(Str : String;What : TProInterpreter) : String;
var
 I       : Integer;
 Kappa   : Integer;
 NewLine : String;

begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : ToLangCompatibility (Str:'+DbgStr(Str)+'; What:'+DbgInt(Ord(What))+')');
   DbgPlus;
 {$ENDIF}

 Kappa:=0;
 NewLine:='';

 for I :=1 to Length(Str) do
 begin
  if (not IsSpace(Str[I])) and (Kappa=0) then Kappa:=I;
   if (Kappa<>0) then
    begin
     if (IsSpace(Str[I])) then begin NewLine:=NewLine+TransX(Copy(Str,Kappa,(I)-Kappa),What)+Str[I];Kappa:=0;end else
     if (Str[I]='{') then begin NewLine:=NewLine+TransX(Copy(Str,Kappa,(I)-Kappa),What)+TransX('{',What) ;Kappa:=0;end else
     if (Str[I]='}') then begin NewLine:=NewLine+TransX(Copy(Str,Kappa,(I)-Kappa),What)+TransX('}',What) ;Kappa:=0;end else

     if (Str[I]='`') then
       begin
         NewLine:=NewLine+TransX(Copy(Str,Kappa,(I)-Kappa),What)+TransX('`',What);
         Kappa:=0;
       end else
     if (Str[I]='''') then
       begin
         NewLine:=NewLine+TransX(Copy(Str,Kappa,(I)-Kappa),What)+TransX('''',What);
         Kappa:=0;
       end;
    end else
     if (Str<>'') and (Kappa=0) then NewLine:=NewLine+Str[I];
 end;
  I:=Length(Str);
 if Kappa<>0 then NewLine:=NewLine+TransX(Copy(Str,Kappa,I),What);

 Result:=NewLine;

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : ToLangCompatibility = ' + DbgStr(Result));
 {$ENDIF}
end;



(*
 * GenerateSourceFormat
 *)

function GenerateSourceFormat(Editor : SyntaxTextHolder; Ci : TProInterpreter; U,V,Sx,Sy,
                                               GridPixelSize, TabMax : Integer; t : TProTable ) : String;
var
 fId, Cx,Cy, Tk : Integer;
begin

 fId := EdukaAntFileFormatID;
 case Ci of
  piAnt : fId := EdukaAntFileFormatID;
  piTux : fId := EdukaTuxFileFormatID;
  piKng : fId := EdukaKNGFileFormatID;
 end;

Result := EdukaFileHeader + Enter +
          EdukaFileInfoSection + Enter +
          IntToStr(FileVersionID) + Space + IntToStr(fId) + Enter +
          EdukaFileDescrSection + Enter +
          IntToStr(u) + Space + IntToStr(v) + Space + IntToStr(sx) + Space +
          IntToStr(sy) + Space + IntToStr(GridPixelSize) + Enter + EdukaFileGridSection + Enter;

 For Cx:=1 to TabMax do
  For Cy:=1 to TabMax do
   if Ci = piKng then
   begin

     Tk := 0;
     if t[Cx,Cy].Oriz then Tk := 1;
     if t[Cx,Cy].Vert then Tk := Tk + 2;

     if Tk<>0 then Result := Result + IntToStr(Cx) + Space + IntToStr(Cy) + Space + IntToStr(Tk) + Enter;
   end
    else
      if not Gol(t[Cx,Cy].Word) then
          Result := Result + IntToStr(Cx) + Space + IntToStr(Cy) + Space + t[Cx,Cy].Word + Enter;

   Result := Result + IntToStr(0) + Space + IntToStr(0) + Enter +
             EdukaFileCodeSection + Enter + ToEngCompatibility(Editor.Lines.Text,Ci);

end;


(*
 * GenerateExerciseFormat
 *)

function GenerateExerciseFormat( Ci : TProInterpreter; Author : String; U1,V1,Sx1,Sy1,U2,V2,Sx2,Sy2,Skill,Duration,
                                               GridPixelSize, TabMax : Integer; tb1, tb2 : TProTable; PLangs : TLangInfoArrayFormat ) : String;
var
 Cx,Cy : Integer;

begin

Result := EdukaFileDescrSection + Enter +
          IntToStr(GridPixelSize) + Space + IntToStr(Ord(Ci)) + Space +
          IntToStr(Duration) + Space + IntToStr(Skill) + Enter+
          IntToStr(u1) + Space + IntToStr(v1) + Space + IntToStr(sx1) + Space +
          IntToStr(sy1) + Space + Enter +
          IntToStr(u2) + Space + IntToStr(v2) + Space + IntToStr(sx2) + Space +
          IntToStr(sy2) + Space + Enter;


if Author<>'' then Result := Result + Author else Result := Result + '--';

Result := Result + Enter + EdukaFileGridSection + Enter;

 For Cx:=1 to TabMax do
  For Cy:=1 to TabMax do
   begin
    Result := Result + IntToStr(Integer(tb1[Cx,Cy].Vert)) + Space +
                       IntToStr(Integer(tb1[Cx,Cy].Oriz)) + Space;

     if tb1[Cx,Cy].Word<>'' then
       Result := Result + tb1[Cx,Cy].Word + Enter else
       Result := Result + '--' + Enter;
   end;

   Result := Result + EdukaFileGridSection + Enter;

 For Cx:=1 to TabMax do
  For Cy:=1 to TabMax do
   begin
    Result := Result + IntToStr(Integer(tb2[Cx,Cy].Vert)) + Space +
                       IntToStr(Integer(tb2[Cx,Cy].Oriz)) + Space;

     if tb2[Cx,Cy].Word<>'' then
       Result := Result + tb2[Cx,Cy].Word + Enter else
       Result := Result + '--' + Enter;
   end;

 Result := Result + EdukaFileCodeSection + Enter;

 For Cx:=0 to nLangs do
   if (PLangs[Cx].Title <> '') and (PLangs[Cx].Descr <> '') and (PLangs[Cx].Lng <> '')
        then
          begin
           Result := Result + EdukaFileLangSection + Enter +
                     PLangs[Cx].Lng + Enter + IntToStr(Length(PLangs[Cx].Title)) + Space +
                     IntToStr(Length(PLangs[Cx].Descr)) + Space + IntToStr(Length(PLangs[Cx].Rests))
                     + Enter + PLangs[Cx].Title + PLangs[Cx].Descr + PLangs[Cx].Rests + Enter;
          end;
     Result := Result + '<->';
end;


(*
 * GenerateExerciseFileFormat
 *)

function GenerateExerciseFileFormat( Ci : TProInterpreter; Author : String; U1,V1,Sx1,Sy1,U2,V2,Sx2,Sy2,Skill,Duration,
                                               GridPixelSize, TabMax : Integer; tb1, tb2 : TProTable; PLangs : TLangInfoArrayFormat ) : String;

begin
Result := EdukaFileHeader + Enter +
          EdukaFileInfoSection + Enter +
          IntToStr(FileVersionID) + Space + IntToStr(EdukaExerciseFileFormatID) + Enter +
          GenerateExerciseFormat( Ci, Author, U1, V1, Sx1, Sy1,U2, V2, Sx2, Sy2, Skill, Duration,
                              GridPixelSize, TabMax, tb1, tb2, PLangs);
end;


(*
 * GenerateTestFileFormat
 *)


function GenerateTestFileFormat() : String;
var
 CExercise : Integer;

begin

Result := EdukaFileHeader + Enter +
          EdukaFileInfoSection + Enter +
          IntToStr(FileVersionID) + Space + IntToStr(EdukaTESTFileFormatID) + Enter +
          EdukaFileDescrSection + Enter + IntToStr(iSelectedFileList);

 for CExercise := 0 to iSelectedFileList - 1 do
  Result := Result + Enter + EdukaFileExerciseSection + Enter + SelectedFileList [ CExercise ].FileName + Enter +
            GenerateExerciseFormat( SelectedFileList [ CExercise ].Info1.Interpreter ,
                                SelectedFileList [ CExercise ].Info1.Author ,
                                SelectedFileList [ CExercise ].Info1.InPositionalX,
                                SelectedFileList [ CExercise ].Info1.InPositionalY,
                                SelectedFileList [ CExercise ].Info1.InDirectionalX,
                                SelectedFileList [ CExercise ].Info1.InDirectionalY,
                                SelectedFileList [ CExercise ].Info1.OutPositionalX,
                                SelectedFileList [ CExercise ].Info1.OutPositionalY,
                                SelectedFileList [ CExercise ].Info1.OutDirectionalX,
                                SelectedFileList [ CExercise ].Info1.OutDirectionalY,
                                SelectedFileList [ CExercise ].Info1.Skill,
                                SelectedFileList [ CExercise ].Info1.Duration,
                                pntGridDePixelate(
                                                  SelectedFileList [ CExercise ].Info1.TableMax,
                                                  SelectedFileList [ CExercise ].Info1.Interpreter
                                                  ),
                                SelectedFileList [ CExercise ].Info1.TableMax ,
                                SelectedFileList [ CExercise ].Info1.InGrid,
                                SelectedFileList [ CExercise ].Info1.OutGrid,
                                SelectedFileList [ CExercise ].Info2
                                );
end;

(*
 * SaveInterpreterFormat
 *)

function SaveInterpreterFormat(Editor : SyntaxTextHolder; FileName : String; Int : TProInterpreter) : Boolean;
var
 TFile    : TextFile;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : SaveInterpreterFormat (Editor:'+DbgObject(Editor)+'; FileName:'+DbgStr(FileName)+'; Int:'+DbgInt(Ord(Int))+')');
   DbgPlus;
 {$ENDIF}


 AssignFile(TFile,FileName);
{$I-}
 Rewrite(TFile);
{$I+}
 if IOResult<>0 then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : SaveInterpreterFormat = '+DbgBool(Result));
    {$ENDIF}

     Exit;
   end;

{$I-}
 Writeln(TFile,GenerateSourceFormat(Editor, Int, u, v, sx, sy, GridPixelSize, TabMax, t ));
{$I+}
 if IOResult<>0 then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : SaveInterpreterFormat = '+DbgBool(Result));
    {$ENDIF}

     Exit;
   end;

 CloseFile(TFile);
 Result:=true;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : SaveInterpreterFormat = '+DbgBool(Result));
{$ENDIF}
end;



(*
 * SaveToExerciseFormat
 *)

function SaveToExerciseFormat(_c_Duration, _c_Skill : TComboBoxEx;_c_Author : TEdit; FileName : String) : Boolean;
var
 TFile : TextFile;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : SaveToExerciseFormat (_c_Duration:'+DbgObject(_c_Duration)+'; _c_Skill:'+DbgObject(_c_Skill)+'; _c_Author:'+DbgObject(_c_Author)+'; FileName:'+DbgStr(FileName)+')');
   DbgPlus;
 {$ENDIF}

 AssignFile(TFile,FileName);
{$I-}
 Rewrite(TFile);
{$I+}
 if IOResult<>0 then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : SaveToExerciseFormat = '+DbgBool(Result));
    {$ENDIF}

     Exit;
   end;


{$I-}
 Writeln(TFile, GenerateExerciseFileFormat( CurrentInterpreter, _c_Author.Text, U1,V1,Sx1,Sy1,U2,V2,Sx2,Sy2,
                      _c_Skill.ItemIndex,_c_Duration.ItemIndex, GridPixelSize, TabMax,
                      tb1, tb2, PLangs ));
{$I+}
 if IOResult<>0 then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : SaveInterpreterFormat = '+DbgBool(Result));
    {$ENDIF}

     Exit;
   end;

 CloseFile(TFile);
 Result:=true;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : SaveToExerciseFormat = '+DbgBool(Result));
{$ENDIF}
end;


(*
 * SaveToTESTFormat
 *)

function SaveToTESTFormat(FileName : String) : Boolean;
var
 TFile : TextFile;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : SaveToTESTFormat (FileName:'+DbgStr(FileName)+')');
   DbgPlus;
 {$ENDIF}

 Result := False;
 if iSelectedFileList < 1 then Exit;

 AssignFile(TFile,FileName);
{$I-}
 Rewrite(TFile);
{$I+}
 if IOResult<>0 then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : SaveToTESTFormat = '+DbgBool(Result));
    {$ENDIF}

     Exit;
   end;

{$I-}
 Writeln(TFile, GenerateTestFileFormat());
{$I+}
 if IOResult<>0 then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : SaveInterpreterFormat = '+DbgBool(Result));
    {$ENDIF}

     Exit;
   end;

 CloseFile(TFile);
 Result:=true;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : SaveToTESTFormat = '+DbgBool(Result));
{$ENDIF}
end;


(*
 * flsEditorSaveToFile
 *)

function flsEditorSaveToFile(_c_Duration, _c_Skill : TComboBoxEx;_c_Author : TEdit; Editor : SyntaxTextHolder; FileName : String) : Boolean;
begin
{$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : flsEditorSaveToFile (_c_Duration:'+DbgObject(_c_Duration)+'; _c_Skill:'+DbgObject(_c_Skill)+'; _c_Author:'+DbgObject(_c_Author)+'; Editor:+'+DbgObject(Editor)+'+; FileName:'+DbgStr(FileName)+')');
   DbgPlus;
{$ENDIF}

  CommentOn_:=False;
  Result:=false;

  if TestEditorFile then result:=SaveToTESTFormat(FileName) else
  if ExerciseEditorFile then result:=SaveToExerciseFormat(_c_Duration, _c_Skill,_c_Author, FileName) else
 case CurrentInterpreter of
  piKng : result:=SaveInterpreterFormat(Editor, FileName, piKng);
  piAnt : result:=SaveInterpreterFormat(Editor, FileName, piAnt);
  piTux : result:=SaveInterpreterFormat(Editor, FileName, piTux);
 end;

{$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : EditorSaveToFile = '+DbgBool(Result));
   DbgPlus;
{$ENDIF}
end;


function ReadString(var TFile : Text) : String;
var
 Line : String;
begin
 ReadError := True;

 if EOF(TFile) then Exit;

{$I-}
  Readln(TFile, Line);
{$I+}
  if IOResult <> 0 then Exit;

  ReadError := False;
  Result := Line;
end;

function ReadInteger(var TFile : Text) : Integer;
begin
 ReadError := True;
 Result    := 0;
 if EOF(TFile) then Exit;

{$I-}
  Read(TFile, Result);
{$I+}
  if IOResult <> 0 then Exit;

  ReadError := False;
end;

function ReadBlockString(var TFile : Text; Len : Integer) : String;
var
 CiC : Integer;
 Ch  : Char;
begin
 ReadError := True;
 Result    := '';

  if Len = 0 then
   begin
    ReadError := False;
    Exit;
   end;

  for CiC:=1 to Len do
   begin
    if EOF(TFile) then Exit;
   {$I-}
    Read(TFile, Ch);
   {$I+}
    if IOResult <> 0 then Exit;

    Result := Result + Ch;
   end;

  ReadError := False;
end;




function GetSourceHeader(var TFile : Text; Ci : TProInterpreter; IsTest, IsExercise : Boolean) : Boolean;
var
 YCi : Integer;

begin
  ReadError := False;
  Result := False;
  ReadString(TFile);
  YCi := -1;

  case Ci of
   piKng : YCi := EdukaKNGFileFormatID;
   piAnt : YCi := EdukaANTFileFormatID;
   piTux : YCi := EdukaTUXFileFormatID;
  end;

  if IsTest then YCi := EdukaTESTFileFormatID;
  if IsExercise then YCi := EdukaExerciseFileFormatID;

  if ReadString(TFile) <> EdukaFileInfoSection then Exit;
  if ReadInteger(TFile) <> FileVersionID then Exit;
  if ReadInteger(TFile) <> YCi then Exit;

  ReadString(TFile);

  Result := not ReadError;
end;

function GetDataCoords(var TFile : Text; var u,v,sx,sy, GridPixelSize : integer; Ci : TProInterpreter) : Boolean;
var
 TabMax : Integer;
begin
  ReadError := False;
  Result := False;

  U  := ReadInteger(TFile);
  V  := ReadInteger(TFile);
  Sx := ReadInteger(TFile);
  Sy := ReadInteger(TFile);
  GridPixelSize := ReadInteger(TFile);
  TabMax := pntGridPixelate(GridPixelSize) + Integer(Ci = piKng);

  ReadString(TFile);

  if ( (GridPixelSize <> Grid_15) and (GridPixelSize <> Grid_20) and (GridPixelSize <> Grid_36) and
       (GridPixelSize <> Grid_45) and (GridPixelSize <> Grid_24) ) or

     ((U > TabMax) or (U < 1) or
     (V > TabMax) or (V < 1) ) or
      (not pntCorrectDirectionals(Sx, Sy))
        then
          begin
           GridPixelSize := Grid_36;
           U:=1 ; V:=1;
           Sx:=0; Sy:=1;
           Exit;
          end;

  Result := not ReadError;
end;


function GetExerciseDataCoords(var TFile : Text; var u,v,sx,sy : integer; GridPixelSize : integer; Ci : TProInterpreter) : Boolean;
var
 TabMax  : Integer;
begin
  ReadError := False;
  Result := False;

  U   := ReadInteger(TFile);
  V   := ReadInteger(TFile);
  Sx  := ReadInteger(TFile);
  Sy  := ReadInteger(TFile);

  TabMax := pntGridPixelate(GridPixelSize) + Integer(Ci = piKng);

  ReadString(TFile);

     if
     ((U > TabMax) or (U < 1) or
     (V > TabMax) or (V < 1) ) or
        (not pntCorrectDirectionals(Sx, Sy)) then
          begin
           U:=1 ; V:=1;
           Sx:=0; Sy:=1;
           Exit;
          end;

  Result := not ReadError;
end;


function GetExerciseDataOther(var TFile : Text; var GridPixelSize, Duration, Skill : integer; var  Ci : TProInterpreter) : Boolean;
var
  Tk : Integer;

begin
  ReadError := False;
  Result := False;

  GridPixelSize := ReadInteger(TFile);
  Tk            := ReadInteger(TFile);
  Duration      := ReadInteger(TFile);
  Skill         := ReadInteger(TFile);
  ReadString(TFile);

  case Tk of
   Ord(piKng) : Ci := piKng;
   Ord(piAnt) : Ci := piAnt;
   Ord(piTux) : Ci := piTux;
   else Ci := piAnt;
  end;

  if (Tk < Ord(piAnt)) or (Tk > Ord(piTux)) or ( Duration > 8 ) or ( Duration < 0 ) or
     ( Skill > 2 ) or ( Skill < 0 ) then
     begin
      Skill := 0;
      Duration := 0;
      Exit;
     end;

  Result := not ReadError;
end;


function GetSourceData(var TFile : Text; Ci : TProInterpreter) : Boolean;
var
 GridPixelSize : Integer;
begin
  ReadError := False;
  Result := False;

  if ReadString(TFile) <> EdukaFileDescrSection then Exit;
  if not GetDataCoords(TFile, u1, v1, sx1, sy1, GridPixelSize, Ci) then Exit;

  SendMessage(_Handle,WM_SetGridSize, GridPixelSize,0);

  Result := not ReadError;
end;


function GetExerciseData(var TFile : Text; var Ci : TProInterpreter;
                     var U1, V1, Sx1, Sy1, U2, V2, Sx2, Sy2,
                         GridPixelSize, Duration, Skill  : Integer;var Author : String) : Boolean;
begin
  ReadError := False;
  Result := False;

  if ReadString(TFile) <> EdukaFileDescrSection                        then Exit;
  if not GetExerciseDataOther(TFile, GridPixelSize, Duration, Skill, Ci)   then Exit;
  if not GetExerciseDataCoords(TFile, u1, v1, sx1, sy1, GridPixelSize, Ci) then Exit;
  if not GetExerciseDataCoords(TFile, u2, v2, sx2, sy2, GridPixelSize, Ci) then Exit;

  Author := ReadString(TFile);
  if Author = '--' then Author := '';

  Result := not ReadError;
end;

function GetSourceGrid(var TFile : Text; Ci : TProInterpreter) : Boolean;
var
 Cx, Cy, Idx : Integer;
 Ids         : String;

begin
  ReadError := False;
  Result := False;

  if ReadString(TFile) <> EdukaFileGridSection then Exit;

  FillChar( tb1, SizeOf(tb1), 0 );

 repeat
   Cx  := ReadInteger(TFile);
   Cy  := ReadInteger(TFile);
   Ids := KillSpaces(ReadString(TFile));
   
   if Cx + Cy = 0 then Break;

   if Ci <> piKng then
    begin
     if Length(Ids) <> 1 then Exit;

     if (Cx=0) and (Cy=0) then break;
     if (Cx<=MaxTableWidth) and (Cy<=MaxTableWidth) and (Cx>=1) and (Cy>=1)
        then tb1[Cx,Cy].Word := Ids;
    end else
    begin
     Idx := atoi(Ids);
     if Idx = 0 then Exit;

     if (Cx=0) and (Cy=0) then break;
     if (Cx<=MaxTableWidth) and (Cy<=MaxTableWidth) and (Cx>=1) and (Cy>=1)
        then
         begin
          if Odd( Idx ) then tb1[Cx,Cy].Oriz := True;
          if Idx > 1 then tb1[Cx,Cy].Vert := True;
         end;
    end;

 until (Cx=0) and (Cy=0);

  Result := not ReadError;
end;


function GetSourceCode(var TFile : Text; Ci : TProInterpreter; Editor : SyntaxTextHolder) : Boolean;
var
 Line : String;
 Cx   : Integer;
begin
 ReadError := False;
 Result := False;

 if ReadString(TFile) <> EdukaFileCodeSection then Exit;

 Editor.Lines.Clear;

 while not EOF(TFile) do
 begin
  Line := ReadString(TFile);

   if Length(Line)>0 then
    for Cx:=1 to Length(Line) do
     if Line[Cx]=#9 then
      begin
       Delete(Line,Cx,1);
       Insert(Space3+Space3,Line,Cx);
      end;

  Editor.Lines.Add(ToLangCompatibility(Line,Ci));
 end;

  Result := not ReadError;
end;


function GetExerciseGrid(var TFile : Text; Ci : TProInterpreter; GridPixelSize : Integer; var Tb : TProTable) : Boolean;
var
 TabMax, Cx, Cy   : Integer;
 IsVert, IsHoriz  : Integer;
 AWord            : String;
begin
 ReadError := False;
 Result := False;

 if ReadString(TFile) <> EdukaFileGridSection then Exit;

 TabMax := pntGridPixelate(GridPixelSize) + Integer( Ci = piKng );

 FillChar( Tb, SizeOf(Tb), 0 );

 For Cx:=1 to TabMax do
  For Cy:=1 to TabMax do
    begin
      IsVert  := ReadInteger(TFile);
      IsHoriz := ReadInteger(TFile);
      AWord   := KillSpaces(ReadString(TFile));

      if AWord = '--' then AWord := '';
      if AWord <> '' then AWord := AWord[1];

      Tb[Cx,Cy].Word := AWord;
      Tb[Cx,Cy].Vert := Boolean(IsVert);
      Tb[Cx,Cy].Oriz := Boolean(IsHoriz);
      Tb[Cx,Cy].Pres := False;
    end;


 Result := not ReadError;
end;

function GetExerciseLanguages(var TFile : Text; var PLangs : TLangInfoArrayFormat) : Boolean;
var
 Cx  : Integer;
 TitleLen, DescrLen,
  RestsLen   : Integer;

 Lng : String;
 //Boo : Boolean;
begin
 ReadError := False;
 Result := False;

 if ReadString(TFile) <> EdukaFileCodeSection then Exit;

  For Cx:=0 to nLangs do
     begin
      PLangs[Cx].Title := '';
      PLangs[Cx].Descr := '';
      PLangs[Cx].Rests := '';
     end;


 while not EOF(TFile) do
  begin
   Lng := ReadString(TFile);
   if Lng = '<->' then Break;

   if Lng <> EdukaFileLangSection then Exit;

   Lng := ReadString(TFile);

   for Cx:=0 to nLangs do
    if (PLangs[Cx].Lng = Lng) or (Cx = nLangs) then
     begin
       TitleLen := ReadInteger(TFile);
       DescrLen := ReadInteger(TFile);
       RestsLen := ReadInteger(TFile);
       ReadString(TFile);

       if ReadError then Exit;

       PLangs[Cx].Title := ReadBlockString(TFile, TitleLen);
       PLangs[Cx].Descr := ReadBlockString(TFile, DescrLen);
       PLangs[Cx].Rests := ReadBlockString(TFile, RestsLen);
       ReadString(TFile);
       
       Break;
     end;
  end;

 Result := not ReadError;
end;


function GetExerciseAllFileFormat(var TFile : Text;var CTI : TMajorExerciseFormat; var PLangs : TLangInfoArrayFormat) : Boolean;
Var
 GridPixelSize : Integer;
begin
 ReadError := False;
 Result := False;

 if not GetExerciseData(TFile, CTI.Interpreter , CTI.InPositionalX, CTI.InPositionalY,
                    CTI.InDirectionalX, CTI.InDirectionalY, CTI.OutPositionalX, CTI.OutPositionalY,
                    CTI.OutDirectionalX, CTI.OutDirectionalY, GridPixelSize, CTI.Duration,
                    CTI.Skill, CTI.Author) then Exit;
 CTI.TableMax := pntGridPixelate( GridPixelSize ) + Integer( CTI.Interpreter = piKng );

 if not GetExerciseGrid(TFile, CTI.Interpreter, GridPixelSize, CTI.InGrid ) then Exit;
 if not GetExerciseGrid(TFile, CTI.Interpreter, GridPixelSize, CTI.OutGrid ) then Exit;
 if not GetExerciseLanguages(TFile, PLangs) then Exit;

 Result := not ReadError;
end;


function GetTestAllFileFormat(var TFile : Text) : Boolean;
Var
 Cx, Files : Integer;
begin
 ReadError := False;
 Result := False;

 if not GetSourceHeader(TFile, CurrentInterpreter, True, False) then Exit;
 if ReadString(TFile) <> EdukaFileDescrSection then Exit;
 Files := ReadInteger(TFile); if (Files < 1) or (Files > 30) then Exit;
 ReadString(TFile);
 iSelectedFileList := Files;

 for Cx := 0 to Files - 1 do
    begin
     if ReadString(TFile) <> EdukaFileExerciseSection then Exit;
     SelectedFileList [ Cx ].FileName := ReadString(TFile);

     if not GetExerciseAllFileFormat(TFile, SelectedFileList [ Cx ] .Info1, SelectedFileList [ Cx ] .Info2)
        then Exit;
    end;

 Result := not ReadError;
end;


(*
 * ReadInterpreterFormat
 *)

function ReadInterpreterFormat(Editor : SyntaxTextHolder; FileName : String; Ipt : TProInterpreter) : Boolean;
var
 TFile : TextFile;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : ReadInterpreterFormat (Editor:'+DbgObject(Editor)+'; FileName:'+DbgStr(FileName)+'; Ipt:'+DbgInt(Ord(Ipt))+')');
   DbgPlus;
 {$ENDIF}


 AssignFile(TFile,FileName);
{$I-}
 Reset(TFile);
{$I+}
 if IOResult<>0 then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : ReadInterpreterFormat = '+DbgBool(Result));
    {$ENDIF}

     Exit;
   end;

 if not GetSourceHeader(TFile, Ipt, false, false) then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : ReadInterpreterFormat = '+DbgBool(Result));
    {$ENDIF}
     CloseFile(TFile);
     Exit;
   end;

 if not GetSourceData(TFile, Ipt) then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : ReadInterpreterFormat = '+DbgBool(Result));
    {$ENDIF}
     CloseFile(TFile);
     Exit;
   end;

 if not GetSourceGrid(TFile, Ipt) then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : ReadInterpreterFormat = '+DbgBool(Result));
    {$ENDIF}
     CloseFile(TFile);
     Exit;
   end;


 if not GetSourceCode(TFile, Ipt, Editor) then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : ReadInterpreterFormat = '+DbgBool(Result));
    {$ENDIF}
     CloseFile(TFile);
     Exit;
   end;

 CloseFile(TFile);
 Result:=true;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : ReadInterpreterFormat = '+DbgBool(Result));
{$ENDIF}
end;


(*
 * ReadFromExerciseFormat_Fake
 *)


function ReadFromExerciseFormat_Fake( FileName : String;var CTI : TMajorExerciseFormat ) : Boolean;
var
 TFile : TextFile;

begin
{$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : ReadFromExerciseFormat_Fake ( FileName:'+DbgStr(FileName)+'; CTI:'+DbgAddr(Addr(CTI))+')');
   DbgPlus;
{$ENDIF}

 AssignFile(TFile,FileName);
{$I-}
 Reset(TFile);
 if IOResult<>0 then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : ReadFromExerciseFormat_Fake = '+DbgBool(Result));
    {$ENDIF}

     Exit;
   end;

  if not GetSourceHeader(TFile, CTI.Interpreter, False, True) then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : ReadFromExerciseFormat_Real = '+DbgBool(Result));
    {$ENDIF}
     CloseFile(TFile);
     Exit;
   end;

 if not GetExerciseAllFileFormat(TFile, CTI, PLangs) then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : ReadFromExerciseFormat_Real = '+DbgBool(Result));
    {$ENDIF}
     CloseFile(TFile);
     Exit;
   end;

 CloseFile(TFile);
 Result:=true;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : ReadFromExerciseFormat_Fake = '+DbgBool(Result));
{$ENDIF}
end;



(*
 * ReadFromExerciseFormat_Real
 *)

function ReadFromExerciseFormat_Real(_c_Duration, _c_Skill : TComboBoxEx;_c_Author : TEdit; FileName : String) : Boolean;
var
 CTI : TMajorExerciseFormat;
 
begin
{$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : ReadFromExerciseFormat_Real (_c_Duration:'+DbgObject(_c_Duration)+'; _c_Skill:'+DbgObject(_c_Skill)+'; _c_Author:'+DbgObject(_c_Author)+'; FileName:'+DbgStr(FileName)+')');
   DbgPlus;
{$ENDIF}
  Result := False;
  if ReadFromExerciseFormat_Fake(FileName, CTI) then
   begin
     Sx1 := CTI.InDirectionalX;
     Sy1 := CTI.InDirectionalY;

     u1  := CTI.InPositionalX;
     v1  := CTI.InPositionalY;

     Sx2 := CTI.OutDirectionalX;
     Sy2 := CTI.OutDirectionalY;

     u2  := CTI.OutPositionalX;
     v2  := CTI.OutPositionalY;

     _c_Author.Text        := CTI.Author;
     _c_Duration.ItemIndex := CTI.Duration;
     _c_Skill.ItemIndex    := CTI.Skill;

     SendMessage(_Handle,WM_SetGridSize, pntGridDePixelate( CTI.TableMax, CTI.Interpreter) ,0);

     tb1 := CTI.InGrid;
     tb2 := CTI.OutGrid;
     ReadInterpreter := CTI.Interpreter;
     Result := True;
   end;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : ReadFromExerciseFormat_Real = '+DbgBool(Result));
{$ENDIF}
end;



(*
 * ReadFromTESTFormat
 *)

function ReadFromTESTFormat(FileName : String) : Boolean;
var
 TFile  : TextFile;
begin
{$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : ReadFromTESTFormat ( FileName:'+DbgStr(FileName)+')');
   DbgPlus;
{$ENDIF}

 AssignFile(TFile,FileName);
{$I-}
 Reset(TFile);

 if (IOResult<>0) or (EOF(TFile)) then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : ReadFromTESTFormat = '+DbgBool(Result));
    {$ENDIF}

     Exit;
   end;


  if not GetTestAllFileFormat(TFile) then
   begin
     Result:=false;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : ReadFromTESTFormat = '+DbgBool(Result));
    {$ENDIF}
     CloseFile(TFile);
     Exit;
   end;

 CloseFile(TFile);
 Result:=true;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : ReadFromTESTFormat = '+DbgBool(Result));
{$ENDIF}
end;


(*
 * flsEditorOpenFromFile
 *)

function flsEditorOpenFromFile(RealRead : Boolean;_c_Duration, _c_Skill : TComboBoxEx;_c_Author : TEdit; Editor : SyntaxTextHolder; FileName : String) : Boolean;
begin
{$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : flsEditorOpenFromFile ( RealRead:'+DbgBool(RealRead)+'; _c_Duration:'+DbgObject(_c_Duration)+'; _c_Skill:'+DbgObject(_c_Skill)+'; _c_Author:'+DbgObject(_c_Author)+'; Editor:'+DbgObject(Editor)+'; FileName:'+DbgStr(FileName)+')');
   DbgPlus;
{$ENDIF}
  CommentOn_:=False;
  Result:=False;
try
 if ExerciseEditorMode then
  begin
   if RealRead then Result:=ReadFromExerciseFormat_Real( _c_Duration, _c_Skill,_c_Author, FileName) else
                    Result:=ReadFromExerciseFormat_Fake(FileName, CurrentExerciseInfo);
  end else
 if TestEditorMode then Result:=ReadFromTESTFormat(FileName) else
 case CurrentInterpreter of
  piKng : result:=ReadInterpreterFormat(Editor, FileName, piKng);
  piAnt : result:=ReadInterpreterFormat(Editor, FileName, piAnt);
  piTux : result:=ReadInterpreterFormat(Editor, FileName, piTux);
 end;
except
end;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : EditorOpenFromFile = '+DbgBool(Result));
{$ENDIF}
end;


(*
 * flsSetDialogsFilter
 *)

procedure flsSetDialogsFilter(SaveDlg : TSaveDialog; OpenDlg : TOpenDialog; InterpreterID : TProInterpreter);
begin
{$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : flsSetDialogsFilter (SaveDlg:'+DbgObject(SaveDlg)+'; OpenDlg:'+DbgObject(OpenDlg)+'; InterpreterID:'+DbgInt(Ord(InterpreterID))+')');
   DbgPlus;
{$ENDIF}
if TestEditorMode then
begin
    OpenDlg.Filter := TestFilter;
    SaveDlg.Filter := TestFilter;
end else
if ExerciseEditorMode then
begin
    OpenDlg.Filter := ExerciseFilter;
    SaveDlg.Filter := ExerciseFilter;
end else
begin
 case InterpreterID of
   piKng:
    begin
     OpenDlg.Filter := KngFilter;
     SaveDlg.Filter := KngFilter;
    end;
   piAnt:
    begin
     OpenDlg.Filter := AntFilter;
     SaveDlg.Filter := AntFilter;
    end;
   piTux:
    begin
     OpenDlg.Filter := TuxFilter;
     SaveDlg.Filter := TuxFilter;
    end;
  end;
end;
{$IFDEF _DEBUG_}
  DbgMinus;
{$ENDIF}
end;




(*
 * flsGetPackageFileCount
 *)

function flsGetPackageFileCount( pk : String ) : Integer;
var
 TFile : Text;

 iFileSize : Integer;
 sFileName : String;
 i, Files  : Integer;

begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : flsGetPackageFileCount (pk:'+DbgStr(pk)+')');
   DbgPlus;
 {$ENDIF}

 AssignFile(TFile, pk);
{$I-}
 Reset(TFile);
{$I+}
 if IOResult<>0 then
   begin
     Result:=-1;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetPackageFileCount = '+DbgInt(Result));
    {$ENDIF}

     Exit;
   end;

Files := 0;

{$I-}
Readln(TFile, sFileName);
while not(EOF(TFile)) do
begin
 Inc( Files );
 Readln(TFile, iFileSize );

 if IOResult<>0 then
   begin
     Result:=-1;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetPackageFileCount = '+DbgInt(Result));
    {$ENDIF}

     Exit;
   end;

 Readln(TFile, sFileName );

 if IOResult<>0 then
   begin
     Result:=-1;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetPackageFileCount = '+DbgInt(Result));
    {$ENDIF}

     Exit;
   end;

 for i:=1 to iFileSize do
  Read(TFile);

 if IOResult<>0 then
   begin
     Result:=-1;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetPackageFileCount = '+DbgInt(Result));
    {$ENDIF}

     Exit;
   end;

 Readln(TFile);
end;
{$I+}
CloseFile(TFile);
Result := Files;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetPackageFileCount = '+DbgInt(Result));
    {$ENDIF}
end;




(*
 * flsGetFileInstallLocation
 *)

function flsGetFileInstallLocation( pk : String; FileID : Integer ) : String;
var
 TFile : Text;

 iFileSize : Integer;
 sFileName : String;
 i, Files  : Integer;

begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : flsGetFileInstallLocation (pk:'+DbgStr(pk)+'; FileID:'+DbgInt(FileID)+')');
   DbgPlus;
 {$ENDIF}

 AssignFile(TFile, pk);
{$I-}
 Reset(TFile);
{$I+}
 if IOResult<>0 then
   begin
     Result:='';

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetFileInstallLocation = '+DbgStr(Result));
    {$ENDIF}

     Exit;
   end;

Files := 0;

{$I-}

Readln(TFile, sFileName);
while not(EOF(TFile)) do
begin

 Inc( Files );
 Readln(TFile, iFileSize );

 if IOResult<>0 then
   begin
     Result:='';

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetFileInstallLocation = '+DbgStr(Result));
    {$ENDIF}

     Exit;
   end;

 Readln(TFile, sFileName );

 if Files = FileID then break;
 
 if IOResult<>0 then
   begin
     Result:='';

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetFileInstallLocation = '+DbgStr(Result));
    {$ENDIF}

     Exit;
   end;

 for i:=1 to iFileSize do
  Read(TFile);

 if IOResult<>0 then
   begin
     Result:='';

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetFileInstallLocation = '+DbgStr(Result));
    {$ENDIF}

     Exit;
   end;

 Readln(TFile);
end;
{$I+}

CloseFile(TFile);

Result := sFileName;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetFileInstallLocation = '+DbgStr(Result));
    {$ENDIF}
end;





(*
 * flsGetFilePackageTitle
 *)

function flsGetFilePackageTitle( pk : String ) : String;
var
 TFile : Text;

begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : flsGetFilePackageTitle (pk:'+DbgStr(pk)+')');
   DbgPlus;
 {$ENDIF}

 AssignFile(TFile, pk);
{$I-}
 Reset(TFile);
{$I+}
 if IOResult<>0 then
   begin
     Result:='';

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetFilePackageTitle = '+DbgStr(Result));
    {$ENDIF}

     Exit;
   end;

{$I-}
 Readln(TFile, Result);
{$I+}

 if IOResult<>0 then
   begin
     Result:='';

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetFileInstallLocation = '+DbgStr(Result));
    {$ENDIF}

     Exit;
   end;

CloseFile(TFile);

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetFileInstallLocation = '+DbgStr(Result));
    {$ENDIF}
end;





(*
 * flsGetFileBody
 *)


function flsGetFileBody( pk : String; FileID : Integer ) : String;
var
 TFile : Text;

 iFileSize : Integer;
 sFileName, sFileBody : String;
 i, Files  : Integer;
 ChId      : Char;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : flsGetFileBody (pk:'+DbgStr(pk)+'; FileID:'+DbgInt(FileID)+')');
   DbgPlus;
 {$ENDIF}
 sFileBody := '';

 AssignFile(TFile, pk);
{$I-}
 Reset(TFile);
{$I+}
 if IOResult<>0 then
   begin
     Result:= '';

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetFileInstallLocation = '+DbgStr(Result));
    {$ENDIF}

     Exit;
   end;

Files := 0;

{$I-}
Readln(TFile, sFileName);
while not(EOF(TFile)) do
begin

 Inc( Files );
 Readln(TFile, iFileSize );

 if IOResult<>0 then
   begin
     Result:= '';

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetFileInstallLocation = '+DbgStr(Result));
    {$ENDIF}

     Exit;
   end;

 Readln(TFile, sFileName );

 if IOResult<>0 then
   begin
     Result:= '';

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetFileInstallLocation = '+DbgStr(Result));
    {$ENDIF}

     Exit;
   end;

 for i:=1 to iFileSize do
  begin
   Read(TFile, ChId);
    if Files = FileID then sFileBody := sFileBody + ChId;
  end;


 if IOResult<>0 then
   begin
     Result:= '';

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetFileInstallLocation = '+DbgStr(Result));
    {$ENDIF}

     Exit;
   end;

 Readln(TFile);

 if Files = FileID then break;
end;
{$I+}

CloseFile(TFile);

Result := sFileBody;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetFileInstallLocation = '+DbgStr(Result));
    {$ENDIF}
end;




(*
 * ExposeRealNature
 *)

{$WARNINGS OFF}
function ExposeRealNature( MetaFileName : String ) : String;
var
 MMDir, MetaDir : String;
 
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : ExposeRealNature ( MetaFileName:' + DbgStr(MetaFileName) + ')' );
   DbgPlus;
 {$ENDIF}

 Result := '';
 MMDir  := MetaFileName;

 Repeat

   MetaDir := MMDir;
   MMDir   := ExtractFileDir(MetaDir);

 Until (MMDir = '') or (MMDir = MetaDir);

 if AnsiUpperCase(MetaDir) = '${SOUND}' then
    MMDir := (Replace( MetaFileName, '${SOUND}', ExtractFileDir(ParamStr(0)) + '\Sounds')) else

 if AnsiUpperCase(MetaDir) = '${HELPS}' then
    MMDir := (Replace( MetaFileName, '${HELPS}', ExtractFileDir(ParamStr(0)) + '\Helps')) else

 if AnsiUpperCase(MetaDir) = '${LANG}' then
    MMDir := (Replace( MetaFileName, '${LANG}', ExtractFileDir(ParamStr(0)) + '\Languages')) else

 if AnsiUpperCase(MetaDir) = '${EXERCISE}' then
    MMDir := (Replace( MetaFileName, '${EXERCISE}', PChar(MyDocuments)+'\'+MyExercises)) else

 if AnsiUpperCase(MetaDir) = '${SOURCE}' then
    MMDir := (Replace( MetaFileName, '${SOURCE}', PChar(MyDocuments)+'\'+MySources)) else

 if AnsiUpperCase(MetaDir) = '${TEST}' then
    MMDir := (Replace( MetaFileName, '${TEST}', PChar(MyDocuments)+'\'+MyTests)) else
 begin
    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : ExposeRealNature = '+ DbgStr(Result));
    {$ENDIF}

    Exit;
 end;

 Result := MMDir;

  {$IFDEF _DEBUG_}
    DbgMinus;
    DbgPrint(DbgUName+' : ExposeRealNature = '+ DbgStr(Result));
  {$ENDIF}
end;
{$WARNINGS ON}


(*
 * flsSaveFileToLocation
 *)

function flsSaveFileToLocation( MetaFileName : String; FileBody : String) : boolean;
var
  MMDir          : String;
  TFile          : TextFile;
  WasGood        : Boolean;
  MK             : String;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : flsSaveFileToLocation (MetaFileName:'+DbgStr(MetaFileName) + '; FileBody:<not shown> )');
   DbgPlus;
 {$ENDIF}
 
   Result := False;

   MMDir := ExposeRealNature( MetaFileName );
   if MMDir = '' then Exit;


repeat
WasGood := false;
MK      := ExtractFileDir(MMDir);
Repeat

 if not DirectoryExists(MK) then
  begin
   {$I-}
     MkDir(MK);
   {$I+}

    if IOResult = 0 then begin WasGood := True; Break; end;
  end;

 MK := ExtractFileDir(MK);
Until ( ExtractFileName(MK) = '' );


until not WasGood;



 AssignFile(TFile, MMDir);
{$I-}
 Rewrite(TFile);
{$I+}
 if IOResult<>0 then
   begin

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsSaveFileToLocation = '+ DbgBool(Result));
    {$ENDIF}

     Exit;
   end;

{$I-}
 Write(TFile, FileBody);
{$I+}

 if IOResult<>0 then
   begin

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsSaveFileToLocation = '+ DbgBool(Result));
    {$ENDIF}

     Exit;
   end;

 CloseFile(TFile);

   Result := True;

  {$IFDEF _DEBUG_}
    DbgMinus;
    DbgPrint(DbgUName+' : flsSaveFileToLocation = '+DbgBool(Result));
  {$ENDIF}
end;



(*
 * flsGetActivePackageFiles
 *)

function flsGetActivePackageFiles( pk : String ) : Integer;
var
 TFile : Text;

 Files     : Integer;

begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : flsGetActivePackageFiles (pk:'+DbgStr(pk)+')');
   DbgPlus;
 {$ENDIF}

 AssignFile(TFile, pk);
{$I-}
 Reset(TFile);
{$I+}
 if IOResult<>0 then
   begin
     Result:=-1;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetActivePackageFiles = '+DbgInt(Result));
    {$ENDIF}

     Exit;
   end;

{$I-}
 Readln(TFile);
{$I+}

 if IOResult<>0 then
   begin
     Result:=-1;

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetActivePackageFiles = '+DbgInt(Result));
    {$ENDIF}

     Exit;
   end;

   Files := 0;

   while not (EOF(TFile)) do
   begin
    Inc(Files);
    Readln(TFile);
   end;

   Result := Files;
   CloseFile(TFile);

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetActivePackageFiles = '+DbgInt(Result));
    {$ENDIF}
end;



(*
 * flsGetActivePackageFile
 *)

function flsGetActivePackageFile( pk : String; Id : Integer ) : String;
var
 TFile : Text;
 Files     : Integer;

begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : flsGetActivePackageFile (pk:'+DbgStr(pk)+'; id:'+DbgInt(Id)+')');
   DbgPlus;
 {$ENDIF}

 AssignFile(TFile, pk);
{$I-}
 Reset(TFile);
{$I+}
 if IOResult<>0 then
   begin
     Result:='';

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetActivePackageFile = ' + DbgStr(Result) );
    {$ENDIF}

     Exit;
   end;

{$I-}
 Readln(TFile);
{$I+}

 if IOResult<>0 then
   begin
     Result:='';

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetActivePackageFile = ' + DbgStr(Result));
    {$ENDIF}

     Exit;
   end;

   Files := 0;

   while not (EOF(TFile)) do
   begin
    Inc(Files);
    Readln(TFile, Result);

    if Files = Id then break;
   end;

   CloseFile(TFile);

    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsGetActivePackageFile = ' + DbgStr(Result));
    {$ENDIF}
end;



(*
 * flsPackageIsActive
 *)

function flsPackageIsActive( pk : String) : boolean;
var
 ii, i : Integer;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : flsPackageIsActive (pk:'+DbgStr(pk)+')');
   DbgPlus;
 {$ENDIF}

 ii := flsGetActivePackageFiles( pk );
 Result := false;

 if ii < 1 then
  begin
    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : flsPackageIsActive = '+DbgBool(Result));
    {$ENDIF}

   exit;
  end;

 for i := 1 to ii do
  if FileExists(ExposeRealNature(flsGetActivePackageFile( pk, i))) then
     begin
      Result := true;
      {$IFDEF _DEBUG_}
        DbgMinus;
        DbgPrint(DbgUName+' : flsPackageIsActive = '+DbgBool(Result));
      {$ENDIF}
      exit;
     end;

  {$IFDEF _DEBUG_}
    DbgMinus;
    DbgPrint(DbgUName+' : flsPackageIsActive = '+DbgBool(Result));
  {$ENDIF}
end;



(*
 * flsPackageIsUsed
 *)

function flsPackageIsUsed( pk : String) : boolean;
var
 ii, i : Integer;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : flsPackageIsUsed (pk:'+DbgStr(pk)+')');
   DbgPlus;
 {$ENDIF}

 ii := flsGetActivePackageFiles( pk );
 Result := true;

 if ii < 1 then
  begin
  {$IFDEF _DEBUG_}
    DbgMinus;
    DbgPrint(DbgUName+' : flsPackageIsUsed = '+DbgBool(Result));
  {$ENDIF}
   exit;
  end; 

 for i := 1 to ii do
  if FileExists(ExposeRealNature(flsGetActivePackageFile( pk, i))) then
   begin
     if (AnsiUpperCase(CurrentLanguageFileName) = AnsiUpperCase(ExposeRealNature(flsGetActivePackageFile( pk, i)))) or
        (AnsiUpperCase(ExtractFilePath(ParamStr(0))+'\Helps\'+CurrentHelpFile)=
         AnsiUpperCase(ExposeRealNature(flsGetActivePackageFile( pk, i)))) then
         begin
           {$IFDEF _DEBUG_}
            DbgMinus;
            DbgPrint(DbgUName+' : flsPackageIsUsed = '+DbgBool(Result));
           {$ENDIF}
          Exit;
        end;
   end;
   
 Result := false;
 
 {$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : flsPackageIsUsed = '+DbgBool(Result));
 {$ENDIF}
end;



(*
 * flsRemovePackageFiles
 *)

procedure flsRemovePackageFiles( pk : String );
var
 ii, i : Integer;
 vv    : file;
 poponeatza : String;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : flsRemovePackageFiles (pk:'+DbgStr(pk)+')');
   DbgPlus;
 {$ENDIF}

 ii := flsGetActivePackageFiles( pk );
 if ii < 1 then
  begin
   {$IFDEF _DEBUG_}
    DbgMinus;
    DbgPrint(DbgUName+' : flsRemovePackageFiles = void');
   {$ENDIF}
   exit;
  end;


 for i := 1 to ii do
  if FileExists(ExposeRealNature(flsGetActivePackageFile( pk, i))) then
     begin
       {$IFDEF _DEBUG_}
        DbgPrint(DbgUName+' : flsRemovePackageFiles | Removing file ('+DbgStr(ExposeRealNature(flsGetActivePackageFile( pk, i)))+')');
       {$ENDIF}

      {$I-}
        Assign(vv, ExposeRealNature(flsGetActivePackageFile( pk, i)));
        Erase(vv);
      {$I+}
        if IOResult <> 0 then
       {$IFDEF _DEBUG_}
        DbgPrint(DbgUName+' : flsRemovePackageFiles | Removing file failed !');
       {$ENDIF}
        ;
        poponeatza :=  ExtractFileDir(ExposeRealNature(flsGetActivePackageFile( pk, i)));
        repeat
{$WARNINGS OFF}
         if AnsiUpperCase(Poponeatza) = AnsiUpperCase(MyDocuments + '\' + MyTests) then Break;
         if AnsiUpperCase(Poponeatza) = AnsiUpperCase(MyDocuments + '\' + MySources) then Break;
         if AnsiUpperCase(Poponeatza) = AnsiUpperCase(MyDocuments + '\' + MyExercises) then Break;

         RemoveDirectory( PChar(Poponeatza));
{$WARNINGS ON}
         Poponeatza := ExtractFileDir(Poponeatza);
        until (ExtractFileName(Poponeatza) = '');
     end;

  {$I-}
    Assign( vv,  pk);
    Erase( vv );
  {$I+}

   {$IFDEF _DEBUG_}
    DbgMinus;
    DbgPrint(DbgUName+' : flsRemovePackageFiles = void');
   {$ENDIF}
end;

end.
