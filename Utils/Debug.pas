(*

The Original Code is: Debug.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains custom Debugging routines used entirely in our
    project.
    
*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}

unit Debug;
interface
Uses SysUtils, DebugMain, Windows, Classes, Controls, Forms, Graphics, ProTypes;

function DbgInt(Int : Integer) : String;
function DbgBool(Bool : Boolean) : String;
function DbgShift(Shft : TShiftState) : String;
function DbgMouseButton(Mbt : TMouseButton) : String;
function DbgAction(Act : TCloseAction) : String;
function DbgObject(Obj : TObject) : String;
function DbgPoint(Pnt : TPoint) : String;
function DbgFinger(Pnt : TFingerPrint) : String;
function DbgAddr(Adr : Pointer) : String;
function DbgStr(Stri : String) : String;
function DbgChar(Chr : Char) : String;
function DbgFontStyles(fs : TFontStyles) : String;

procedure DbgPrint(Str : String);
 {
  Prints the debugging messages to (Screen/File)
 }

procedure DbgPlus;
 {
  Inceases Reference of an function
 }

procedure DbgMinus;
 {
  Decreases reference of an function
 }


implementation
var
 DbgRef    : Integer;
 DbgToFile : Boolean;
 DbgFile   : TextFile;
 DbgUsed   : Boolean;
 DbgLtStr  : String;
 DbgLtCnt  : Integer;


function DbgFinger(Pnt : TFingerPrint) : String;
begin
 Result := '[ '+DbgInt(Pnt[1])+', '+DbgInt(Pnt[2])+', '+DbgInt(Pnt[3])+', '+DbgInt(Pnt[4])+' ]';
end;

procedure DbgPlus;
begin
 Inc(DbgRef);
end;

procedure DbgMinus;
begin
 Dec(DbgRef);
end;

function DbgPoint(Pnt : TPoint) : String;
begin
 Result := '('+DbgInt(Pnt.X)+':'+DbgInt(Pnt.Y)+')';
end;

function DbgObject(Obj : TObject) : String;
begin
 if Assigned(Obj) then
     Result := '<'+Obj.ClassName+'>' else Result:='nil';
end;

function DbgChar(Chr : Char) : String;
begin
 Result := ''''+Chr+'''';
end;

function DbgFontStyles(fs : TFontStyles) : String;
begin
 result := '[';
 if fsBold      in fs then Result := Result + ', fsBold';
 if fsItalic    in fs then Result := Result + ', fsItalic';
 if fsUnderline in fs then Result := Result + ', fsUnderline';
 if fsStrikeOut in fs then Result := Result + ', fsStrikeOut';
 result := result + ']';
end;

function DbgStr(Stri : String) : String;
begin
 Result := '"'+Stri+'"';
end;

function DbgMouseButton(Mbt : TMouseButton) : String;
begin
 case Mbt of
   mbLeft  : Result := 'mbLeft';
   mbRight : Result := 'mbRight';
   mbMiddle: Result := 'mbMiddle';
 end;
end;

function DbgAction(Act : TCloseAction) : String;
begin
 case Act of
   caNone     : Result := 'caNone';
   caHide     : Result := 'caHide';
   caFree     : Result := 'caFree';
   caMinimize : Result := 'caMinimize';
 end;
end;

function DbgShift(Shft : TShiftState) : String;
begin
 Result := '[ ';


 if ssShift in Shft then Result := Result + ', ssShift';
 if ssAlt in Shft then Result := Result + ', ssAlt';
 if ssCtrl in Shft then Result := Result + ', ssCtrl';
 if ssLeft in Shft then Result := Result + ', ssLeft';
 if ssRight in Shft then Result := Result + ', ssRight';
 if ssMiddle in Shft then Result := Result + ', ssMiddle';
 if ssDouble in Shft then Result := Result + ', ssDouble';

 Result := Result + ' ]';
end;

function DbgInt(Int : Integer) : String;
begin
 Result:= IntToStr(Int);
end;

function DbgBool(Bool : Boolean) : String;
begin
 if Bool then Result:='True' else Result:='False';
end;

function DbgAddr(Adr : Pointer) : String;
begin
 if Adr<>nil then Result:='xxxx:xxxx' else Result:='nil';
end;

procedure DbgPrint(Str : String);
begin

 if DbgLtStr = Str then
   begin
    Inc(DbgLtCnt);
    Exit;
   end;

While (DbgUsed) do Sleep(10);
DbgUsed:=True;
 if DbgLtCnt > 0 then Str := 'The last message repeated '+IntToStr(DbgLtCnt)+' times !';

 if (Assigned(DebugForm) and (DebugForm.Visible)) then
  begin
     DebugForm.MemoDeb.Lines.Add('('+IntToStr(DbgRef)+') >> '+Str);
  end;

   if DbgToFile then Writeln(DbgFile,'[', GetCurrentThreadId:4,'] ('+IntToStr(DbgRef)+') >> '+Str);

DbgUsed:=False;
DbgLtCnt := 0;
DbgLtStr := Str;
end;

procedure DbgCreateFile(Fname : String);
begin
 Assign(DbgFile,Fname);
{$I-}
 Rewrite(DbgFile);
{$I+}
 if IOResult <> 0 then DbgToFile:= False else DbgToFile:= True;
 DbgPrint('Logging started !');
end;

procedure DbgCloseFile;
begin
 if not DbgToFile then exit;
{$I-}
 CloseFile(DbgFile);
{$I+}
end;

{$IFDEF _DEBUG_}
initialization
 DbgCreateFile('debugging.txt');
 DbgUsed:=False;
 DbgLtStr:='';
 DbgLtCnt:=0;

finalization
 DbgCloseFile;
{$ENDIF}

end.


