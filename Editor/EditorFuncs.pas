(*

The Original Code is: EditorFuncs.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
     Unit implements functionality to work with RichEdits plus some
     other functions.
*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit EditorFuncs;
interface
Uses ProTypes, SysUtils, ComCtrls, Graphics, Translate, DesignInside, Utils, Classes,
     SynEditTextBuffer, SynEditTypes
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;
{$IFDEF _DEBUG_}
Const
     DbgUName          = '/Editor/EditorFuncs.pas';
{$ENDIF}

procedure edtInsertToEditor    (var Editor : SyntaxTextHolder; Post : TInsertPosition;SenderItem : String);
procedure edtPrintToEditor     (var Editor : HLPSyntaxTextHolder ;Color : TColor;FStyle : TFontStyles;Str : String);
procedure edtPositionateCursor (var Editor : SyntaxTextHolder;X,Y : Integer);
procedure edtInsertToPosition  (var Editor : SyntaxTextHolder;X,Y : Integer; Txt : String);

implementation
var
 PosX    : Integer;
 iEditor : SyntaxTextHolder;
 PosSel  : String;

function PlaceIndentEnter( pHow : Integer) : String;
begin
 PosX   := iEditor.CaretX + pHow;
 Result := Enter;
end;


function SpacesTillWord( Line : Integer ) : Integer;
begin
 Result := 1;
 if iEditor.Lines.Strings[Line] = '' then exit;

 While iEditor.Lines.Strings[Line][Result] = Space do Result := Result + 1;
end;

function IndentBy1( iText : String ) : String;
var
 i : Integer;
begin
 Result := Space;
 if iText = '' then Exit;
 for i := 1 to Length(iText) do
     if iText[i] = #10 then Result := Result + #10 + Space  else Result := Result + iText[i];
end;

function IndentTo1( iText : String ) : String;
var
 strs : TStrings;
 i    : Integer;
 cntn : Boolean;
 st   : String;
begin
 Result := '';
 if iText = '' then Exit;

 strs := TStringList.Create;

 st:='';
 for i:=1 to Length(iText) do
   if (iText[i] <> #13) and (iText[i]<>#10) then St := St + iText[i] else
    if (iText[i] = #10) then
     begin
      strs.Add(st);
      st := '';
     end;
     
strs.Add(st);
cntn := true;
while cntn do
begin

 for i := 0 to strs.Count - 1 do
  begin
   if strs.Strings[i] <> '' then
     begin
      if strs.Strings[i][1] <> Space then
         begin
          cntn := false;
          break;
         end else strs.Strings[i] := Copy(strs.Strings[i], 2, Length(strs.Strings[i])-1);
     end
  end;

end;

for i := 0 to strs.Count - 1 do
 begin
  if i <>0 then Result := Result + Enter + strs.Strings[i] else
                Result := strs.Strings[i];
 end;

 Result := IndentBy1(Result);

 strs.Destroy;
end;


(*
 *  edtGetCommandStructure
 *)

{$WARNINGS OFF}
function edtGetCommandStructure( SenderItem : String; Ident : Integer ) : String;
var b,e:string;
begin

{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : edtGetCommandStructure(SenderItem:'+DbgStr(SenderItem)+'; Ident:'+DbgInt(Ident)+')');
  DbgPlus;
{$ENDIF}

 b:='';e:='';
 Result := '';
 SenderItem:=AnsiUpperCase(SenderItem);

 if (SenderItem = 'TUX_REMEMBER')or(SenderItem = 'AC_TUX_REMEMBER')
        then Result := b + SY_REMEMBER + Space + ProcName + Space+ PlaceIndentEnter(0) +e;

 if (SenderItem = 'TUX_FORGET')or(SenderItem = 'AC_TUX_FORGET')
        then Result := b + SY_FORGET + Space + ProcName + Space+ PlaceIndentEnter(0) +e;

 if (SenderItem = 'TUX_GOBACK')or(SenderItem = 'AC_TUX_GOBACK')
        then Result := b + SY_RESTORE + Space + ProcName + Space+ PlaceIndentEnter(0) + e;

 if (SenderItem = 'TUX_PICKLETTER')or(SenderItem = 'AC_TUX_PICK')
        then Result := b + SY_PICK + e;

 if (SenderItem = 'TUX_DROPLETTER')or(SenderItem = 'AC_TUX_DROP')
        then Result := b + SY_DROP + e;

 if (SenderItem = 'TUX_SWAPLETTERS')or(SenderItem = 'AC_TUX_SWAP')
        then Result := b + SY_SWAP + e;

 if (SenderItem = 'KNG_START')or(SenderItem = 'AC_KNG_START')or(SenderItem = 'ANT_START')or(SenderItem = 'AC_ANT_START')
     or(SenderItem = 'TUX_START')or(SenderItem = 'AC_TUX_START')
        then Result := b + SY_START + PlaceIndentEnter(1) + e;

 if (SenderItem = 'KNG_END')or(SenderItem = 'AC_KNG_END')or(SenderItem = 'ANT_END')or(SenderItem = 'AC_ANT_END')
     or(SenderItem = 'TUX_END')or(SenderItem = 'AC_TUX_END')
        then Result := b + Enter + SY_END  + e;

 if (SenderItem = 'KNG_STEP')or(SenderItem = 'AC_KNG_STEP')
    or(SenderItem = 'TUX_STEP')or(SenderItem = 'AC_TUX_STEP')
        then Result := b + SY_STEP + e;

 if (SenderItem = 'KNG_JUMP')or(SenderItem = 'AC_KNG_JUMP')
         then Result := b +SY_JUMP + e;

 if (SenderItem = 'KNG_ROTATE')or(SenderItem = 'AC_KNG_ROTATE')
    or(SenderItem = 'TUX_ROTATE')or(SenderItem = 'AC_TUX_ROTATE')
         then Result := b + SY_ROTATE + e;

 if (SenderItem = 'KNG_WHILE')or(SenderItem = 'AC_KNG_WHILE')or(SenderItem = 'ANT_WHILE')or(SenderItem = 'AC_ANT_WHILE')
     or(SenderItem = 'TUX_WHILE')or(SenderItem = 'AC_TUX_WHILE')
        then Result := b + SY_WHILE + Space + Condition + Space + SY_DO + Enter + IndentBy1(iEditor.SelText) + Enter + CharString(Ident, Space) + SY_END + Space + SY_WHILE + e;

 if (SenderItem = 'KNG_UNTIL')or(SenderItem = 'AC_KNG_UNTIL')or(SenderItem = 'ANT_UNTIL')or(SenderItem = 'AC_ANT_UNTIL')
    or(SenderItem = 'TUX_UNTIL')or(SenderItem = 'AC_TUX_UNTIL')
        then Result := b + SY_REPEAT + Enter + IndentBy1(iEditor.SelText) + Enter + CharString(Ident, Space) + SY_UNTIL + Space + Condition + e;

 if (SenderItem = 'KNG_REPEAT')or(SenderItem = 'AC_KNG_REPEAT')or(SenderItem = 'ANT_REPEAT')or(SenderItem = 'AC_ANT_REPEAT')
        then Result := b + SY_REPEAT + Space + RepeatTimes + Space + SY_TIMES + Enter + IndentBy1(iEditor.SelText) + Enter + CharString(Ident, Space) + SY_END + Space + SY_REPEAT  + e;

 if (SenderItem = 'KNG_IF')or(SenderItem = 'AC_KNG_IF')or(SenderItem = 'ANT_IF')or(SenderItem = 'AC_ANT_IF')
    or(SenderItem = 'TUX_IF')or(SenderItem = 'AC_TUX_IF')
        then Result := b + SY_IF + Space + Condition + Space + SY_THEN + Space + Enter + IndentBy1(iEditor.SelText) + Enter
                         + CharString(Ident, Space) + SY_ELSE + Enter + Enter + CharString(Ident, Space) + SY_END + Space + SY_IF + e;

 if (SenderItem = 'KNG_ELSE')or(SenderItem = 'AC_KNG_ELSE')or(SenderItem = 'ANT_ELSE')or(SenderItem = 'AC_ANT_ELSE')
    or(SenderItem = 'TUX_ELSE')or(SenderItem = 'AC_TUX_ELSE')
        then Result := b + SY_ELSE + PlaceIndentEnter(1) + e;

 if (SenderItem = 'KNG_PROCEDURE')or(SenderItem = 'AC_KNG_PROCEDURE')or(SenderItem = 'ANT_PROCEDURE')or(SenderItem = 'AC_ANT_PROCEDURE')
    or(SenderItem = 'TUX_PROCEDURE')or(SenderItem = 'AC_TUX_PROCEDURE')
        then Result := b + SY_PROCEDURE + Space + ProcName + Enter + IndentTo1(PosSel) + Enter + CharString(Ident, Space) + SY_END + Space + SY_PROCEDURE  + Enter + Enter;

 if (SenderItem = 'KNG_CALL')or(SenderItem = 'AC_KNG_CALL')or(SenderItem = 'ANT_CALL')or(SenderItem = 'AC_ANT_CALL')
    or(SenderItem = 'TUX_CALL')or(SenderItem = 'AC_TUX_CALL')
        then Result := b + SY_CALL + Space + ProcName + PlaceIndentEnter(0);

 if (SenderItem = 'KNG_IS_LINE')or(SenderItem = 'AC_KNG_IS_LINE')
        then Result := b + SY_IS_LINE + e;

 if (SenderItem = 'KNG_IS_BORDER')or(SenderItem = 'AC_KNG_IS_BORDER')or(SenderItem = 'ANT_IS_BORDER')or(SenderItem = 'AC_ANT_IS_BORDER')
        then Result := b + SY_IS_BORDER + e;

 if (SenderItem = 'KNG_IS_NOT_LINE')or(SenderItem = 'AC_KNG_IS_NOT_LINE')
        then Result := b + SY_NOT + Space + SY_IS_LINE + e;

 if (SenderItem = 'KNG_IS_NOT_BORDER')or(SenderItem = 'AC_KNG_IS_NOT_BORDER')or(SenderItem = 'ANT_IS_NOT_BORDER')or(SenderItem = 'AC_ANT_IS_NOT_BORDER')
        then Result := b + SY_NOT + Space + SY_IS_BORDER + e;

 if (SenderItem = 'ANT_LEFT')or(SenderItem = 'AC_ANT_LEFT')
        then Result := b + SY_LEFT + e;
 if (SenderItem = 'ANT_RIGHT')or(SenderItem = 'AC_ANT_RIGHT')
        then Result := b + SY_RIGHT + e;
 if (SenderItem = 'ANT_UP')or(SenderItem = 'AC_ANT_UP')
        then Result := b + SY_UP + e;
 if (SenderItem = 'ANT_DOWN')or(SenderItem = 'AC_ANT_DOWN')
        then Result := b + SY_DOWN + e;

{$IFDEF _DEBUG_}
 DbgMinus;
 DbgPrint(DbgUName+' : edtGetCommandStructure = '+DbgStr(Result));
{$ENDIF}
end;
{$WARNINGS ON}

(*
 *  edtPositionateCursor
 *)

procedure edtPositionateCursor(var Editor : SyntaxTextHolder;X,Y : Integer);
var
 I,TLen : Integer;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : edtPositionateCursor(Editor:'+DbgObject(Editor)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+')');
  DbgPlus;
{$ENDIF}

 TLen:=0;

 if Y=1 then Editor.SelStart:=X+1
 else
  begin
   For I:=0 To Y-2 do
        TLen:=TLen+Length(Editor.Lines.Strings[I])+2;
    Editor.SelStart:=TLen+X+1;
  end;

{$IFDEF _DEBUG_}
 DbgMinus;
 DbgPrint(DbgUName+' : edtPositionateCursor = void');
{$ENDIF}
end;

procedure ExtractXYFromSel(var Editor : SyntaxTextHolder;Sel : Integer;var X, Y : Integer);
var
 i : Integer;
begin
 X := 1;
 Y := 1;



 for i := 1 to Sel - 1 do
    begin
     if Editor.Lines.Text = '' then Continue;

     if (Editor.Lines.Text[i] = #13) then begin Inc(Y); X := 1;end;
     if (Editor.Lines.Text[i] <> #13) and (Editor.Lines.Text[i] <> #10) then
        Inc(X);
    end;
end;


(*
 *  MakeStaticTextActive
 *)

procedure edtInsertToPosition(var Editor : SyntaxTextHolder; X,Y : Integer; Txt : String);
var
 S      : String;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : edInsertToPosition(Editor:'+DbgObject(Editor)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+'; Txt:'+DbgStr(Txt)+')');
  DbgPlus;
{$ENDIF}



 S:=Editor.Lines.Strings[Y-1];

  if (X-1) > Length(S) then S := S + CharString(X - Length(S), Space) + Txt else
                        Insert(Txt,S,X);
                        
 Editor.Lines.Strings[Y-1] := S;

{$IFDEF _DEBUG_}
 DbgMinus;
 DbgPrint(DbgUName+' : edtInsertToPosition = void');
{$ENDIF}
end;


(*
 *  MakeStaticTextActive
 *)

procedure edtPrintToEditor(var Editor : HLPSyntaxTextHolder ;Color : TColor;FStyle : TFontStyles;Str : String);
var
 sel : Integer;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : edtPrintToEditor(Editor:'+DbgAddr(Addr(Editor))+'; Color:'+DbgInt(LongInt(Color))+'; FStyle:xxxx; Str:'+DbgStr(Str)+')');
  DbgPlus;
{$ENDIF}

  if Str='' then
   begin
    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : edtPrintToEditor = void');
    {$ENDIF}
     Exit;
   end;

  Sel:=Editor.SelStart;
  Editor.SelText:=Str;

  Editor.SelStart:=Sel;
  Editor.SelLength:=Length(Str);

  Editor.SelAttributes.Color:=Color;
  Editor.SelAttributes.Style:=FStyle;
  Editor.SelAttributes.Name:=MainUsedFont;
  Editor.SelStart:=Sel+Length(Str);

{$IFDEF _DEBUG_}
 DbgMinus;
 DbgPrint(DbgUName+' : edtPrintToEditor = void');
{$ENDIF}
end;


(*
 *  MakeStaticTextActive
 *)

procedure edtInsertToEditor(var Editor : SyntaxTextHolder; Post : TInsertPosition;SenderItem : String);
var
 LastX,
  LastY  : Integer;
 LastX1,
  LastY1  : Integer;

 LastText : String;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : edPrintToEditor(Editor:'+DbgAddr(Addr(Editor))+'; Post:'+DbgInt(Ord(Post))+'; SenderItem:'+DbgStr(SenderItem)+')');
  DbgPlus;
{$ENDIF}
  if  (SenderItem='AC_KNG_PROCEDURE') or (SenderItem='AC_ANT_PROCEDURE') or
      (SenderItem='KNG_PROCEDURE')    or (SenderItem='ANT_PROCEDURE') or
      (SenderItem='AC_TUX_PROCEDURE') or (SenderItem='TUX_PROCEDURE') then Post:=ipBegin;



   case Post of
    ipBegin  : begin
                LastY    := Editor.Lines.Count;
                LastX    := Length ( Editor.Lines.Strings[ LastY - 1 ] );
                LastText := Editor.Lines.Text;

                Editor.UndoList.AddChange( crPaste , Point(1, 1) , Point(LastX, LastY), LastText, smNormal);

                PosSel := '';

                if Editor.SelText <> '' then
                 begin
                  PosSel         := Editor.SelText;
                  Editor.SelText := SY_CALL + Space + ProcName;
                 end;

                Editor.Lines.Text :=  edtGetCommandStructure(SenderItem, 0) + Editor.Lines.Text;
               end;
    ipCursor : begin
                PosX           := -1;
                iEditor        := Editor;
                ExtractXYFromSel(Editor, Editor.SelStart, LastX, LastY);
                ExtractXYFromSel(Editor, Editor.SelEnd, LastX1, LastY1);

                if Editor.SelText = '' then
                   Editor.UndoList.AddChange( crPaste , Editor.CaretXY ,
                                           Editor.CaretXY , '', smNormal) else

                Editor.UndoList.AddChange( crPaste , Point(LastX, LastY) ,
                                           Point(LastX1, LastY1), Editor.SelText, smNormal);

                if Editor.CaretX > SwapXCoords then
                Editor.SelText := Enter + CharString(SpacesTillWord(iEditor.CaretY - 1) - 1, Space) +
                                  edtGetCommandStructure(SenderItem, SpacesTillWord(iEditor.CaretY - 1) - 1) else
                Editor.SelText := edtGetCommandStructure(SenderItem, Editor.CaretX-1);

                if PosX <> -1 then Editor.CaretX := PosX;
               end;
    ipEnd    : Editor.Lines.Add(edtGetCommandStructure(SenderItem, 0));
   end;
   

 if PosX = -1 then Editor.SelStart:=Editor.SelStart+1;
 
{$IFDEF _DEBUG_}
 DbgMinus;
 DbgPrint(DbgUName+' : edtInsertToEditor = void');
{$ENDIF}

end;

end.
