(*

The Original Code is: ProSyntax.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
    Unit implements all Syntax stuff needed in project.
*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit ProSyntax;
interface
Uses SysUtils, Windows, _Logics_, Lists, ComCtrls, Forms, ProTypes, Translate,
     Utils, Movement, EditorFuncs,DesignInside, Errors, ExtCtrls, StdCtrls, Graphics,
     JvStaticText
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;
{$IFDEF _DEBUG_}
Const
        DbgUName          = '/Logics/ProSyntax.pas';
{$ENDIF}


function stxStartSyntaxExecutionThread(Msg_Text_ : TJvStaticText; Holder_ : SyntaxTextHolder;PHandle_ : HWND; Execute, ShowOK : Boolean) : Boolean;
procedure stxDispatchLine(func : DispatchSyntaxCallback; Line : String; LineNum : Integer);


implementation
var
   Holder       : SyntaxTextHolder;
   PHandle      : HWND;
   CheckExecute : Boolean;
   ShowOKBox    : Boolean;
   InternalCondition
                : String;
   TotalError   : Boolean;

   stxArray     : Array of TSyntaxChain;
   stxArrayLen  : Integer;

   IfStackPos   : Integer;
   IfStack      : Array of Boolean;

   IDStackPos   : Integer;
   IDStack      : Array of Integer;

   WasMovement  : Boolean;
   CycleObserved: Boolean;

   CommentOn    : Boolean;
   ZZPop1, ZzPop2 : Integer;

   PrevoId      : Integer;
   Msg_Text     : TJvStaticText;

   mMemorys     : Integer;
   Memorys      : array of TMemoryType;


(*
 * mmForgetPosition
 *)

procedure mmForgetPosition(pName : String);
var
 X : Integer;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmForgetPosition (pName:'+DbgStr(pName)+')');
   DbgPlus;
 {$ENDIF}

 if mMemorys > 0 then
 for x:=0 to mMemorys-1 do
   if (Memorys[x].mName = AnsiUpperCase(pName)) and  (Memorys[x].mFunc = True) then
    begin

     Dec(Memorys[x].mStack);
     SetLength(Memorys[x].mPos, Memorys[x].mStack);
     if Memorys[x].mStack = 0 then Memorys[x].mFunc := False;
     {$IFDEF _DEBUG2_}
       DbgMinus;
       DbgPrint(DbgUName+' : mmForgetPosition = void');
     {$ENDIF}
     Exit;
    end;

 KillThreadFlag:=True;
 selstart:=1;
 stxError(ERR_0x1E,'',pName, CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1E);

  {$IFDEF _DEBUG2_}
    DbgMinus;
    DbgPrint(DbgUName+' : mmForgetPosition = void');
  {$ENDIF}
end;


(*
 * mmMemorizePosition
 *)

procedure mmMemorizePosition(pName : String);
var
 X : Integer;
 AcX, AcY
   : Integer;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmMemorizePosition (pName:'+DbgStr(pName)+')');
   DbgPlus;
 {$ENDIF}

     AcX := U;
     AcY := V;

 if mMemorys = 0 then
  begin
     Inc(mMemorys);
     x:=mMemorys - 1 ;

     SetLength(Memorys, mMemorys);

     Memorys[x].mStack := 1;
     SetLength(Memorys[x].mPos, Memorys[x].mStack);

     Memorys[x].mPos[Memorys[x].mStack-1].X := AcX;
     Memorys[x].mPos[Memorys[x].mStack-1].Y := AcY;
     Memorys[x].mPos[Memorys[x].mStack-1].DirX := pntGetAnimalOrientation(otPrimary);
     Memorys[x].mName := AnsiUpperCase(pName);
     Memorys[x].mFunc := True;


     {$IFDEF _DEBUG2_}
       DbgMinus;
       DbgPrint(DbgUName+' : mmMemorizePosition = void');
     {$ENDIF}
     Exit;
  end;

 for x:=0 to mMemorys-1 do
   if Memorys[x].mName = AnsiUpperCase(pName) then
    begin
     Inc(Memorys[x].mStack);
     SetLength(Memorys[x].mPos, Memorys[x].mStack);

     Memorys[x].mPos[Memorys[x].mStack-1].X := AcX;
     Memorys[x].mPos[Memorys[x].mStack-1].Y := AcY;
     Memorys[x].mPos[Memorys[x].mStack-1].DirX := pntGetAnimalOrientation(otPrimary);
     Memorys[x].mFunc := True;

     {$IFDEF _DEBUG2_}
       DbgMinus;
       DbgPrint(DbgUName+' : mmMemorizePosition = void');
     {$ENDIF}

     Exit;
    end;

     Inc(mMemorys);
     x:=mMemorys - 1;

     SetLength(Memorys, mMemorys * SizeOf(TMemoryType));

     Memorys[x].mStack := 1;
     SetLength(Memorys[x].mPos, Memorys[x].mStack);

     Memorys[x].mPos[Memorys[x].mStack-1].X := AcX;
     Memorys[x].mPos[Memorys[x].mStack-1].Y := AcY;
     Memorys[x].mPos[Memorys[x].mStack-1].DirX := pntGetAnimalOrientation(otPrimary);

     Memorys[x].mName := AnsiUpperCase(pName);
     Memorys[x].mFunc := True;
   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmMemorizePosition = void');
   {$ENDIF}
end;


(*
 * mmRestorePosition
 *)


procedure mmRestorePosition(pName : String);
var
 X, I : Integer;

begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmRestorePosition (pName:'+DbgStr(pName)+')');
   DbgPlus;
 {$ENDIF}

 if mMemorys > 0 then
 for x:=0 to mMemorys-1 do
   if (Memorys[x].mName = AnsiUpperCase(pName)) and  (Memorys[x].mFunc = True) then
    begin

      if U > Memorys[x].mPos[Memorys[x].mStack-1].X then
      begin
        case pntGetAnimalOrientation(otPrimary) of
         4: begin pntRotateTux; pntRotateTux; end;
         3: begin pntRotateTux; pntRotateTux; pntRotateTux; end;
         1: begin pntRotateTux; end;
        end;

        for I := 1 to U - Memorys[x].mPos[Memorys[x].mStack-1].X do
            pntStepTux;

      end else
      if U < Memorys[x].mPos[Memorys[x].mStack-1].X then
      begin
        case pntGetAnimalOrientation(otPrimary) of
          2:  begin pntRotateTux; pntRotateTux; end;
          3:  begin pntRotateTux; end;
          1:  begin pntRotateTux; pntRotateTux;pntRotateTux; end;
        end;

        for I := 1 to Memorys[x].mPos[Memorys[x].mStack-1].X - U do
            pntStepTux;

      end;

      if V > Memorys[x].mPos[Memorys[x].mStack-1].Y then
      begin
        case pntGetAnimalOrientation(otPrimary) of
          4: begin pntRotateTux; pntRotateTux; pntRotateTux; end;
          2: begin pntRotateTux; end;
          1: begin pntRotateTux; pntRotateTux; end;
        end;
        
        for I := 1 to V - Memorys[x].mPos[Memorys[x].mStack-1].Y do
            pntStepTux;

      end else
      if V < Memorys[x].mPos[Memorys[x].mStack-1].Y then
      begin
        case pntGetAnimalOrientation(otPrimary) of
         4: begin pntRotateTux; end;
         2: begin pntRotateTux; pntRotateTux; pntRotateTux; end;
         3: begin pntRotateTux; pntRotateTux; end;
        end;

        for I := 1 to Memorys[x].mPos[Memorys[x].mStack-1].Y - V do
            pntStepTux;

      end;

        while pntGetAnimalOrientation(otPrimary) <> Memorys[x].mPos[Memorys[x].mStack-1].DirX do
                pntRotateTux;

     {$IFDEF _DEBUG2_}
       DbgMinus;
       DbgPrint(DbgUName+' : mmRestorePosition = void');
     {$ENDIF}
     Exit;
    end;

 KillThreadFlag:=True;
 selstart:=1;
 stxError(ERR_0x1E,'',pName, CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1E);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmRestorePosition = void');
 {$ENDIF}
end;


(*
 * mmPickLetter
 *)

procedure mmPickLetter();
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmPickLetter ()');
   DbgPlus;
 {$ENDIF}

 if Msg_Text.Caption <> '' then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1B,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1B);

   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmPickLetter = void');
   {$ENDIF}

   Exit;
  end;

 if Gol(t[u,v].Word) then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1C,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1C);

   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmPickLetter = void');
   {$ENDIF}

   Exit;
  end;

 Msg_Text.Caption := t[u,v].Word;
 t[u,v].Word := Space3;
 pntRedrawGridLetter( GridMap.Canvas, u,v);
 pntHideInterpreterImages(piTux);
// pntShowAnimal();


 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmPickLetter = void');
 {$ENDIF}
end;


(*
 * mmDropLetter
 *)

procedure mmDropLetter();
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmDropLetter ()');
   DbgPlus;
 {$ENDIF}

 if Msg_Text.Caption = '' then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1A,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1A);
   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmDropLetter = void');
   {$ENDIF}
   Exit;
  end;

 if not Gol(t[u,v].Word) then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1D,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1D);
   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmDropLetter = void');
   {$ENDIF}
   Exit;
  end;

  t[u,v].Word :=  Msg_Text.Caption;
  Msg_Text.Caption := '';
  pntRedrawGridLetter( GridMap.Canvas, u,v);
  pntHideInterpreterImages(piTux);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmDropLetter = void');
 {$ENDIF}
end;


(*
 * mmSwapLetters
 *)

procedure mmSwapLetters();
var
 St : String;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmSwapLetters ()');
   DbgPlus;
 {$ENDIF}

 if Msg_Text.Caption = '' then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1A,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1A);
   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmSwapLetters = void');
   {$ENDIF}
   Exit;
  end;

 if Gol(t[u,v].Word) then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1D,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1D);
   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmSwapLetters = void');
   {$ENDIF}
   Exit;
  end;

  St := Msg_Text.Caption;
  Msg_Text.Caption := t[u,v].Word;
  t[u,v].Word :=  St;
  pntRedrawGridLetter( GridMap.Canvas, u,v);
  pntHideInterpreterImages(piTux);
  
 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmSwapLetters = void');
 {$ENDIF}
end;


(*
 * mmLetterInCell
 *)

function mmLetterInCell() : boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmLetterInCell ()');
   DbgPlus;
 {$ENDIF}

  Result := not Gol(t[u,v].Word);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmLetterInCell = '+DbgBool(Result));
 {$ENDIF}
end;


(*
 * mmCellEqPocket
 *)

function mmCellEqPocket() : boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmCellEqPocket ()');
   DbgPlus;
 {$ENDIF}

  Result := false;

  if Msg_Text.Caption = '' then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1A,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1A);

   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmCellEqPocket = '+DbgBool(Result));
   {$ENDIF}

   Exit;
  end;

 if Gol(t[u,v].Word) then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1D,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1D);

   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmCellEqPocket = '+DbgBool(Result));
   {$ENDIF}

   Exit;
  end;

  Result := AnsiUpperCase( t[u,v].Word ) = AnsiUpperCase( Msg_Text.Caption );

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmCellEqPocket = '+DbgBool(Result));
 {$ENDIF}
end;


(*
 * mmCellLsPocket
 *)

function mmCellLsPocket() : boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmCellLsPocket ()');
   DbgPlus;
 {$ENDIF}

  Result := false;

  if Msg_Text.Caption = '' then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1A,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1A);

   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmCellLsPocket = '+DbgBool(Result));
   {$ENDIF}

   Exit;
  end;

 if Gol(t[u,v].Word) then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1D,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1D);

   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmCellLsPocket = '+DbgBool(Result));
   {$ENDIF}

   Exit;
  end;

  Result := AnsiUpperCase( t[u,v].Word ) < AnsiUpperCase( Msg_Text.Caption );
 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmCellLsPocket = '+DbgBool(Result));
 {$ENDIF}
end;


(*
 * mmCellBgPocket
 *)

function mmCellBgPocket() : boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmCellBgPocket ()');
   DbgPlus;
 {$ENDIF}

  Result := false;

  if Msg_Text.Caption = '' then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1A,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1A);
   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmCellBgPocket = '+DbgBool(Result));
   {$ENDIF}

   Exit;
  end;

 if Gol(t[u,v].Word) then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1D,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1D);
   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmCellBgPocket = '+DbgBool(Result));
   {$ENDIF}
   Exit;
  end;

  Result := AnsiUpperCase( t[u,v].Word ) > AnsiUpperCase( Msg_Text.Caption );
 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmCellBgPocket = '+DbgBool(Result));
 {$ENDIF}
end;


(*
 * mmCellEqLetter
 *)

function mmCellEqLetter(pLetter : String) : boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmCellBgPocket ( pLetter:'+DbgStr(pLetter)+')');
   DbgPlus;
 {$ENDIF}

 Result := false;
 if Gol(t[u,v].Word) then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1D,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1D);
   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmCellEqLetter = '+DbgBool(Result));
   {$ENDIF}
   Exit;
  end;

  Result := AnsiUpperCase( t[u,v].Word ) = AnsiUpperCase( pLetter );
 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmCellEqLetter = '+DbgBool(Result));
 {$ENDIF}
end;


(*
 * mmCellLsLetter
 *)

function mmCellLsLetter(pLetter : String) : boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmCellLsLetter ( pLetter:'+DbgStr(pLetter)+')');
   DbgPlus;
 {$ENDIF}

  Result := false;
  if Gol(t[u,v].Word) then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1D,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1D);
   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmCellLsLetter = '+DbgBool(Result));
   {$ENDIF}
   Exit;
  end;

  Result := AnsiUpperCase( t[u,v].Word ) < AnsiUpperCase( pLetter );
 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmCellLsLetter = '+DbgBool(Result));
 {$ENDIF}
end;


(*
 * mmCellBgLetter
 *)

function mmCellBgLetter(pLetter : String) : boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmCellBgLetter ( pLetter:'+DbgStr(pLetter)+')');
   DbgPlus;
 {$ENDIF}

  Result := false;
  if Gol(t[u,v].Word) then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1D,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1D);
   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmCellBgLetter = '+DbgBool(Result));
   {$ENDIF}
   Exit;
  end;

  Result := AnsiUpperCase( t[u,v].Word ) > AnsiUpperCase( pLetter );
 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmCellBgLetter = '+DbgBool(Result));
 {$ENDIF}
end;


(*
 * mmCellUppercase
 *)


function mmCellUppercase() : boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmCellUppercase ()');
   DbgPlus;
 {$ENDIF}

 Result := false;

 if Gol(t[u,v].Word) then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1D,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1D);
   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmCellUppercase = '+DbgBool(Result));
   {$ENDIF}

   Exit;
  end;

   Result := AnsiUpperCase(t[u,v].Word) = t[u,v].Word;
 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmCellUppercase = '+DbgBool(Result));
 {$ENDIF}
end;


(*
 * mmEraseMemory
 *)

procedure mmEraseMemory();
var
 x : integer;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmEraseMemory ()');
   DbgPlus;
 {$ENDIF}

 if mMemorys = 0 then
  begin
   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmEraseMemory = void');
   {$ENDIF}
   Exit;
  end;

 for x:=0 to mMemorys-1 do
    begin
     SetLength(Memorys[x].mPos, 0);
     SetLength(Memorys[x].mName, 0);
    end;

 SetLength(Memorys,0);
 mMemorys := 0;

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmEraseMemory = void');
 {$ENDIF}
end;


(*
 * mmMemoryAvailable
 *)

function mmMemoryAvailable(pName : String) : boolean;
var
 X : Integer;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmMemoryAvailable ( pName:'+DbgStr(pName)+')');
   DbgPlus;
 {$ENDIF}

 if mMemorys > 0 then
 for x:=0 to mMemorys-1 do
   if (Memorys[x].mName = AnsiUpperCase(pName)) and  (Memorys[x].mFunc = True) then
    begin
     Result := True;

     {$IFDEF _DEBUG2_}
       DbgMinus;
       DbgPrint(DbgUName+' : mmMemoryAvailable = '+DbgBool(Result));
     {$ENDIF}

     Exit;
    end;
  Result := False;
  {$IFDEF _DEBUG2_}
    DbgMinus;
    DbgPrint(DbgUName+' : mmMemoryAvailable = '+DbgBool(Result));
  {$ENDIF}
end;


(*
 * mmLetterInPocket
 *)

function mmLetterInPocket() : boolean;
begin
  Result := not (Msg_Text.Caption = '');
 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmLetterInPocket = '+DbgBool(Result));
 {$ENDIF}
end;


(*
 * mmPocketEqLetter
 *)

function mmPocketEqLetter(pLetter : String) : boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmPocketEqLetter ( pLetter:'+DbgStr(pLetter)+')');
   DbgPlus;
 {$ENDIF}

  Result := false;
 if Msg_Text.Caption = '' then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1A,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1A);
   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmPocketEqLetter = '+DbgBool(Result));
   {$ENDIF}
   Exit;
  end;

  Result := AnsiUpperCase(Msg_Text.Caption) = AnsiUpperCase(pLetter);
 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmPocketEqLetter = '+DbgBool(Result));
 {$ENDIF}
end;


(*
 * mmPocketLsLetter
 *)

function mmPocketLsLetter(pLetter : String) : boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmPocketLsLetter ( pLetter:'+DbgStr(pLetter)+')');
   DbgPlus;
 {$ENDIF}

  Result := false;
  if Msg_Text.Caption = '' then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1A,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1A);

   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmPocketLsLetter = '+DbgBool(Result));
   {$ENDIF}

   Exit;
  end;

   Result := AnsiUpperCase(Msg_Text.Caption) < AnsiUpperCase(pLetter);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmPocketLsLetter = '+DbgBool(Result));
 {$ENDIF}
end;


(*
 * mmPocketBgLetter
 *)

function mmPocketBgLetter(pLetter : String) : boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmPocketBgLetter ( pLetter:'+DbgStr(pLetter)+')');
   DbgPlus;
 {$ENDIF}

  Result := false;

  if Msg_Text.Caption = '' then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1A,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1A);

   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmPocketBgLetter = '+DbgBool(Result));
   {$ENDIF}

   Exit;
  end;

  Result := AnsiUpperCase(Msg_Text.Caption) > AnsiUpperCase(pLetter);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmPocketBgLetter = '+DbgBool(Result));
 {$ENDIF}

end;


(*
 * mmPocketUppercase
 *)

function mmPocketUppercase() : boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : mmPocketUppercase ()');
   DbgPlus;
 {$ENDIF}

  Result := false;
  if Msg_Text.Caption = '' then
  begin
   KillThreadFlag:=True;
   selstart:=1;
   stxError(ERR_0x1A,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $1A);

   {$IFDEF _DEBUG2_}
     DbgMinus;
     DbgPrint(DbgUName+' : mmPocketUppercase = '+DbgBool(Result));
   {$ENDIF}

   Exit;
  end;

  Result := AnsiUpperCase(Msg_Text.Caption) = Msg_Text.Caption;
 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : mmPocketUppercase = '+DbgBool(Result));
 {$ENDIF}
end;


(*
 * PushIf
 *)

procedure PushIf(Exec : Boolean);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : PushIf (Exec:'+DbgBool(Exec)+')');
   DbgPlus;
 {$ENDIF}

 Inc(IfStackPos);
 SetLength(IfStack,IfStackPos*SizeOf(Boolean));
 IfStack[(IfStackPos-1)]:=Exec;

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : PushIf = void');
 {$ENDIF}
end;

(*
 * PopIf
 *)

function PopIf : Boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : PopIf ()');
   DbgPlus;
 {$ENDIF}

 Result:=IfStack[(IfStackPos-1)];
 Dec(IfStackPos);
 SetLength(IfStack,IfStackPos*SizeOf(Boolean));

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : PopIf = '+DbgBool(Result));
 {$ENDIF}
end;


(*
 * stxDispatchLine
 *)

procedure stxDispatchLine(Func : DispatchSyntaxCallback; Line : String; LineNum : Integer);
var
 CiC, LastCut, ZaBeg     : Integer;
 LastChar                : Char;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : stxDispatchLine ( Func:'+DbgAddr(@Func)+'; Line:'+DbgStr(Line)+'; LineNum:'+DbgInt(LineNum)+')');
   DbgPlus;
 {$ENDIF}

 ZaBeg    := Length(Line);
 LastCut  := 1;
 LastChar := ' ';
 
 Line  := TrimLeft(Line);
 ZaBeg := Zabeg - Length(Line);
 Line  := Trim(Line);

 if Line='' then
   begin
    {$IFDEF _DEBUG2_}
      DbgMinus;
      DbgPrint(DbgUName+' : stxDispatchLine = void');
    {$ENDIF}

    Exit;
   end;

 for CiC := 1 to Length(Line) do
 begin

  if Line[CiC] = '{' then
           CommentOn := True;
{$WARNINGS OFF}
  if Line[CiC] = '}' then
         begin
           CommentOn := False;
           Line[CiC] := Space;
         end;

  if CommentOn then Line[CiC] := Space;
{$WARNINGS ON}
  if (IsSpace(Line[CiC]))  then
   if (IsSpace(LastChar)) then Inc(LastCut) else
    begin
      Func(LineNum , ZaBeg + LastCut, ZaBeg + CiC , Copy(Line, LastCut, CiC - LastCut ));
      LastCut := CiC + 1;
    end;

  if Line[CiC] in ['>','<','='] then
    begin
      if (not IsSpace(LastChar)) then
             begin
              Func(LineNum , ZaBeg + LastCut, ZaBeg + CiC , Copy(Line, LastCut, CiC - LastCut ));
	     end;

      Func(LineNum , ZaBeg + CiC, ZaBeg + CiC + 1 - 1, Line[CiC]);
      LastCut  := CiC+1;
      LastChar := Space;
    end else
    LastChar := Line[CiC];
  end;

  CiC := Length(Line);

  if LastCut-1 < Length(Line) then
   begin
     Func(LineNum , ZaBeg + LastCut, ZaBeg + CiC +1, Copy(Line, LastCut, CiC - LastCut+1 ));
   end;

  {$IFDEF _DEBUG2_}
    DbgMinus;
    DbgPrint(DbgUName+' : stxDispatchLine = void');
  {$ENDIF}
end;


(*
 * stxIsNumber
 *)


function stxIsNumber(Str : String) : Boolean;
Var
 i : integer;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : stxIsNumber ( Str:'+DbgStr(Str)+')');
   DbgPlus;
 {$ENDIF}

 result:=false;

 if str='' then
  begin
  {$IFDEF _DEBUG2_}
    DbgMinus;
    DbgPrint(DbgUName+' : stxIsNumber = '+ DbgBool(Result));
  {$ENDIF}
  exit;
  end;

 Result:=true;
 for i:=1 to length(str) do
   if not (str[i] in ['0'..'9']) then Result:=False;

{$IFDEF _DEBUG2_}
  DbgMinus;
  DbgPrint(DbgUName+' : stxIsNumber = '+ DbgBool(Result));
{$ENDIF}
end;


(*
 * stxIsIndentifier
 *)


function stxIsIndentifier(Str : String) : Boolean;
Var
 I : integer;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : stxIsIndentifier ( Str:'+DbgStr(Str)+')');
   DbgPlus;
 {$ENDIF}

 Result:=false;
 if Str ='' then
  begin
  {$IFDEF _DEBUG2_}
    DbgMinus;
    DbgPrint(DbgUName+' : stxIsIndentifier = '+ DbgBool(Result));
  {$ENDIF}
   Exit;
  end;

 if Pos(Str[1],SY_SGNS)<>0 then
  begin
   ZzPop1 := 0;
   ZzPop2 := 1;

  {$IFDEF _DEBUG2_}
    DbgMinus;
    DbgPrint(DbgUName+' : stxIsIndentifier = '+ DbgBool(Result));
  {$ENDIF}

   Exit;
  end;

  Str := AnsiUpperCase(Str);

 for I:=1 to Length(Str) do
    if  (Pos(Str[I],SY_SGNS)=0) and (Pos(Str[I],SY_LTTRS)=0) then
       begin
         ZzPop1 := I-1;
         ZzPop2 := I;

        {$IFDEF _DEBUG2_}
          DbgMinus;
          DbgPrint(DbgUName+' : stxIsIndentifier = '+ DbgBool(Result));
        {$ENDIF}

         Exit;
       end;
 Result:=True;

{$IFDEF _DEBUG2_}
  DbgMinus;
  DbgPrint(DbgUName+' : stxIsIndentifier = '+ DbgBool(Result));
{$ENDIF}
end;


(*
 * ProCBFunc
 *)

procedure ProCBFunc(LineNum,St,En : Integer; Str : String);
var
 Sto           : String;

 {$IFDEF _DEBUG2_}
  Ikp, PreAlloc : Integer;
 {$ENDIF}
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : ProCBFunc ( LineNum:'+DbgInt(LineNum)+'; St:'+DbgInt(St)+'; En:'+DbgInt(En)+'; Str:'+DbgStr(Str)+')');
   DbgPlus;
 {$ENDIF}


 Sto := Str;
 Str := AnsiUpperCase(Str);
 
 {$IFDEF _DEBUG2_}
  IKp := SizeOf(TSyntaxChain);
  PreAlloc := AllocMemSize;
 {$ENDIF}

 Inc(stxArrayLen);


 SetLength(stxArray, stxArrayLen);

 stxArray[stxArrayLen-1].Ln:=LineNum+1;
 stxArray[stxArrayLen-1].St:=st;
 stxArray[stxArrayLen-1].En:=En;
 stxArray[stxArrayLen-1].Str:=Sto;



if CurrentInterpreter = piTux then
 begin
  if lngTrulySpeX(Str) > 0 then
      begin
       if InternalCondition <> '' then
        begin
          Dec(stxArrayLen);
          stxArray[stxArrayLen - 1 ].Str := stxArray[stxArrayLen - 1 ].Str + ' ' + Sto;
        end;

       InternalCondition := InternalCondition + ' ' + Str;
       stxArray[stxArrayLen - 1 ].En:=En;

      {$IFDEF _DEBUG2_}
        DbgMinus;
        DbgPrint(DbgUName+' : ProCBFunc = void');
      {$ENDIF}
        Exit;
      end else
     if InternalCondition <> '' then
       begin
        stxArray[ stxArrayLen - 2 ].Id := lngListSpeX(InternalCondition);
        InternalCondition := '';
       end;
 end;

  if Str = '' then
    begin
        Dec(stxArrayLen);

      {$IFDEF _DEBUG2_}
        DbgMinus;
        DbgPrint(DbgUName+' : ProCBFunc = void');
      {$ENDIF}

        Exit;
    end;

 if (CurrentInterpreter=piTux) and (Str=AnsiUpperCase(SY_PICK)) then stxArray[stxArrayLen - 1].Id:=_Pick_ else
 if (CurrentInterpreter=piTux) and (Str=AnsiUpperCase(SY_DROP)) then stxArray[stxArrayLen - 1].Id:=_Drop_ else
 if (CurrentInterpreter=piTux) and (Str=AnsiUpperCase(SY_SWAP)) then stxArray[stxArrayLen - 1].Id:=_Swap_ else
 if (CurrentInterpreter=piTux) and (Str=AnsiUpperCase(SY_REMEMBER)) then stxArray[stxArrayLen - 1].Id:=_Remember_ else
 if (CurrentInterpreter=piTux) and (Str=AnsiUpperCase(SY_RESTORE)) then stxArray[stxArrayLen - 1].Id:=_Restore_ else
 if (CurrentInterpreter=piTux) and (Str=AnsiUpperCase(SY_FORGET)) then stxArray[stxArrayLen - 1].Id:=_Forget_ else

 if (CurrentInterpreter=piKng) and (Str=AnsiUpperCase(SY_JUMP)) then stxArray[stxArrayLen - 1].Id:=_Jump_ else
 if ((CurrentInterpreter=piKng) or (CurrentInterpreter=piTux)) and (Str=AnsiUpperCase(SY_STEP)) then stxArray[stxArrayLen - 1].Id:=_Step_ else
 if ((CurrentInterpreter=piKng) or (CurrentInterpreter=piTux)) and (Str=AnsiUpperCase(SY_ROTATE)) then stxArray[stxArrayLen - 1].Id:=_Rotate_ else
 if (CurrentInterpreter=piAnt) and (Str=AnsiUpperCase(SY_RIGHT)) then stxArray[stxArrayLen - 1].Id:=_Right_ else
 if (CurrentInterpreter=piAnt) and (Str=AnsiUpperCase(SY_LEFT)) then stxArray[stxArrayLen - 1].Id:=_Left_ else
 if (CurrentInterpreter=piAnt) and (Str=AnsiUpperCase(SY_UP)) then stxArray[stxArrayLen - 1].Id:=_Up_ else
 if (CurrentInterpreter=piAnt) and (Str=AnsiUpperCase(SY_DOWN)) then stxArray[stxArrayLen - 1].Id:=_DOWN_ else
 if (CurrentInterpreter=piKng) and (Str=AnsiUpperCase(SY_IS_LINE)) then stxArray[stxArrayLen - 1].Id:=_Is_Line_ else

 //-----

 if Str=AnsiUpperCase(SY_WHILE) then stxArray[stxArrayLen - 1].Id:=_While_ else
 if Str=AnsiUpperCase(SY_UNTIL) then stxArray[stxArrayLen - 1].Id:=_Until_ else
 if Str=AnsiUpperCase(SY_REPEAT) then stxArray[stxArrayLen - 1].Id:=_Repeat_ else
 if Str=AnsiUpperCase(SY_IF) then stxArray[stxArrayLen - 1].Id:=_If_ else
 if Str=AnsiUpperCase(SY_PROCEDURE) then stxArray[stxArrayLen - 1].Id:=_Procedure_ else
 if Str=AnsiUpperCase(SY_END) then stxArray[stxArrayLen - 1].Id:=_End_ else
 if Str=AnsiUpperCase(SY_START) then stxArray[stxArrayLen - 1].Id:=_Start_ else
 if (CurrentInterpreter<>piTux) and (Str=AnsiUpperCase(SY_IS_BORDER)) then stxArray[stxArrayLen - 1].Id:=_Is_Border_ else
 if Str=AnsiUpperCase(SY_NOT) then stxArray[stxArrayLen - 1].Id:=_Not_ else
 if (CurrentInterpreter<>piTux) and (Str=AnsiUpperCase(SY_TIMES)) then stxArray[stxArrayLen - 1].Id:=_Times_ else
 if Str=AnsiUpperCase(SY_DO) then stxArray[stxArrayLen - 1].Id:=_Do_ else
 if Str=AnsiUpperCase(SY_CALL) then stxArray[stxArrayLen - 1].Id:=_Call_ else
 if Str=AnsiUpperCase(SY_THEN) then stxArray[stxArrayLen - 1].Id:=_Then_ else
 if Str=AnsiUpperCase(SY_ELSE) then stxArray[stxArrayLen - 1].Id:=_Else_ else
    begin
     stxArray[stxArrayLen-1].Id:=_Identifier_;
     stxArray[stxArrayLen-1].Str:=Str;
    end;


{$IFDEF _DEBUG2_}
  PreAlloc := AllocMemSize - PreAlloc;
  DbgPrint(DbgUName+' : ProCBFunc | Allocated '+DbgInt(PreAlloc)+' Bytes of free memory, where structure needs '+DbgInt(IKp)+' Bytes.');
{$ENDIF}

{$IFDEF _DEBUG2_}
  DbgMinus;
  DbgPrint(DbgUName+' : ProCBFunc = void');
{$ENDIF}
end;

(*
 * stxEndOfFile
 *)


function stxEndOfFile( I : Integer): Boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : ProCBFunc ( I:'+DbgInt(I)+')');
   DbgPlus;
 {$ENDIF}

  result:= (i > stxArrayLen-1);

{$IFDEF _DEBUG2_}
  DbgMinus;
  DbgPrint(DbgUName+' : stxEndOfFile = '+DbgBool(Result));
{$ENDIF}
end;

function stxIncreasePos(var I : Integer; Line : Integer) : boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : stxIncreasePos ( var I:'+DbgInt(I)+'; Line:'+DbgInt(Line)+')');
   DbgPlus;
 {$ENDIF}

 Inc(I);
 if stxEndOfFile(i) then
   begin
    stxError(ERR_0x01,'','',Line ,stxArray[I-1].en,stxArray[I-1].en, esFatal, $01);
    TotalError:=True;
    result:=false;
    Exit;
   end;
 result:=true;

{$IFDEF _DEBUG2_}
  DbgMinus;
  DbgPrint(DbgUName+' : stxIncreasePos( var I:'+DbgInt(I)+') = '+DbgBool(Result));
{$ENDIF}
end;


(*
 * stxNextReservedWord
 *)

function stxNextReservedWord(I, RWd : Integer) : Boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : stxNextReservedWord ( I:'+DbgInt(I)+'; RWd:'+DbgInt(Rwd)+')');
   DbgPlus;
 {$ENDIF}

 Result:= (stxArray[I].Id = RWd);

{$IFDEF _DEBUG2_}
  DbgMinus;
  DbgPrint(DbgUName+' : stxNextReservedWord = '+DbgBool(Result));
{$ENDIF}
end;


(*
 * stxGetIndentifier
 *)


function stxGetIndentifier( I : Integer) : String;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : stxGetIndentifier ( I:'+DbgInt(I)+')');
   DbgPlus;
 {$ENDIF}

 Result:=stxArray[I].Str;

{$IFDEF _DEBUG2_}
  DbgMinus;
  DbgPrint(DbgUName+' : stxGetIndentifier = '+DbgStr(Result));
{$ENDIF}
end;


(*
 * EqS
 *)

function EqS(var Id : Integer; var s : String; Line : Integer) : Boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : EqS ( var Id:'+DbgInt(Id)+'; var S:'+DbgStr(S)+'; Line:'+DbgInt(Line)+')');
   DbgPlus;
 {$ENDIF}

 if stxArray[Id].Id < _TuxCondition_ then
   result:=false
  else

 case stxArray[Id].Id - _TuxCondition_ of
  4, 8..13   :
      begin
        result:=true;
        if not stxIncreasePos( Id,Line) then
         begin
          {$IFDEF _DEBUG2_}
            DbgMinus;
            DbgPrint(DbgUName+' : EqS ( var Id:'+DbgInt(Id)+'; var S:'+DbgStr(S)+') = '+DbgBool(Result));
          {$ENDIF}
          Exit;
        end;

                       if (not stxNextReservedWord(Id,_Identifier_)) then
                               begin
                                stxError(ERR_0x18,'',stxArray[Id-1].Str, stxArray[Id-1].Ln, stxArray[Id-1].St, stxArray[Id-1].En, esFatal, $18);
                                TotalError:=True;
                                {$IFDEF _DEBUG2_}
                                  DbgMinus;
                                  DbgPrint(DbgUName+' : EqS ( var Id:'+DbgInt(Id)+'; var S:'+DbgStr(S)+') = '+DbgBool(Result));
                                {$ENDIF}
                                Exit;
                               end;

                       if not stxIsIndentifier(stxArray[Id].Str) then
                               begin
                                stxError(ERR_0x17,stxArray[Id].Str,'', stxArray[Id].Ln, stxArray[Id].St+ZZPop1, stxArray[Id].St+ZZPop2, esMedium, $17);
                                TotalError:=True;
                                {$IFDEF _DEBUG2_}
                                  DbgMinus;
                                  DbgPrint(DbgUName+' : EqS ( var Id:'+DbgInt(Id)+'; var S:'+DbgStr(S)+') = '+DbgBool(Result));
                                {$ENDIF}
                                Exit;
                               end;

        s := stxArray[Id].Str;
        if ( (Length(S) > 1) or (AnsiUpperCase(S) = AnsiLowerCase(S)) ) and (stxArray[Id-1].Id - _TuxCondition_ <> 4) then
                               begin
                                stxError(ERR_0x19,'',stxArray[Id].Str, stxArray[Id].Ln, stxArray[Id].St, stxArray[Id].En, esMedium, $19);
                                TotalError:=True;
                                {$IFDEF _DEBUG2_}
                                  DbgMinus;
                                  DbgPrint(DbgUName+' : EqS ( var Id:'+DbgInt(Id)+'; var S:'+DbgStr(S)+') = '+DbgBool(Result));
                                {$ENDIF}
                                Exit;
                               end;
      end;
  1..3, 5..7, 14..18 :
      begin
        s      := '';
        result := true;
      end;
  else result:=false;
 end;

{$IFDEF _DEBUG2_}
  DbgMinus;
  DbgPrint(DbgUName+' : EqS ( var Id:'+DbgInt(Id)+'; var S:'+DbgStr(S)+') = '+DbgBool(Result));
{$ENDIF}
end;


(*
 * stxTuxGetConditionId
 *)


function stxTuxGetConditionId(var I : Integer; Line : Integer; var _Rename : String ) : Integer;
var
 UID : Integer;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : stxTuxGetConditionId ( var I:'+DbgInt(I)+'; Line:'+DbgInt(Line)+'; var _Rename:'+DbgStr(_Rename)+')');
   DbgPlus;
 {$ENDIF}

 result:=0;
 UID := stxArray[I].Id;
 if EqS(I, _Rename, Line) then result:=UID else
    if (stxArray[I].Id=_Not_) then
     begin
       if not stxIncreasePos( I,Line) then
       begin
        {$IFDEF _DEBUG2_}
          DbgMinus;
          DbgPrint(DbgUName+' : stxTuxGetConditionId ( var I:'+DbgInt(I)+'; var _Rename:'+DbgStr(_Rename)+') = '+DbgInt(Result));
        {$ENDIF}
        Exit;
       end;

        UID := stxArray[I].Id;
     if EqS(I, _Rename, Line) then result:=(-1)*UID else
               begin
                stxError(ERR_0x03,stxArray[I].Str,'', stxArray[I].Ln, stxArray[I].St ,stxArray[I].En, esMedium, $03);
                TotalError:=True;
                result:=0;
               end;
     end else
    begin
     stxError(ERR_0x03,stxArray[I].Str,'', Line, stxArray[I].St, stxArray[I].En, esMedium, $03);
     TotalError:=True;
     result:=0;
    end;

{$IFDEF _DEBUG2_}
  DbgMinus;
  DbgPrint(DbgUName+' : stxTuxGetConditionId ( var I:'+DbgInt(I)+'; var _Rename:'+DbgStr(_Rename)+') = '+DbgInt(Result));
{$ENDIF}
end;


(*
 * stxGetConditionId
 *)

function stxGetConditionId(var I : Integer; Line : Integer ) : Integer;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : stxGetConditionId ( var I:'+DbgInt(I)+'; Line:'+DbgInt(Line)+')');
   DbgPlus;
 {$ENDIF}

 result:=0;
 if (stxArray[I].Id=_Is_Border_) then result:=_Is_Border_ else
  if (stxArray[I].Id=_Is_Line_) then result:=_Is_Line_ else
   if (stxArray[I].Id=_Is_Not_Border_) then result:=_Is_Not_Border_ else
    if (stxArray[I].Id=_Not_) then
     begin
       if not stxIncreasePos( I,Line) then
       begin
        {$IFDEF _DEBUG2_}
          DbgMinus;
          DbgPrint(DbgUName+' : stxGetConditionId ( var I:'+DbgInt(I)+' ) = '+DbgInt(Result));
        {$ENDIF}
        Exit;
       end;
         if stxArray[I].Id=_Is_Border_ then result:=_Is_Not_Border_ else
         if stxArray[I].Id=_Is_Line_ then result:=_Is_Not_Line_ else
               begin
                stxError(ERR_0x03,stxArray[I].Str,'', stxArray[I].Ln, stxArray[I].St ,stxArray[I].En, esMedium, $03);
                TotalError:=True;
                result:=0;
               end;
     end else
    begin
     stxError(ERR_0x03,stxArray[I].Str,'', Line, stxArray[I].St, stxArray[I].En, esMedium, $03);
     TotalError:=True;
     result:=0;
    end;

{$IFDEF _DEBUG2_}
  DbgMinus;
  DbgPrint(DbgUName+' : stxGetConditionId ( var I:'+DbgInt(I)+' ) = '+DbgInt(Result));
{$ENDIF}
end;


(*
 * PushCycleId
 *)

procedure PushCycleId(Id : Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : PushCycleId (Id:'+DbgInt(Id)+')');
   DbgPlus;
 {$ENDIF}

 Inc(IDStackPos);
 SetLength(IDStack,IDStackPos*SizeOf(Integer));
 IDStack[(IDStackPos-1)]:=ID;

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : PushCycleId = void');
 {$ENDIF}
end;

(*
 * PopCycleID
 *)


function PopCycleID : Integer;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : PopCycleID ()');
   DbgPlus;
 {$ENDIF}

 if IDStackPos=0 then Result:=0 else
  begin
    Result:=IDStack[(IDStackPos-1)];
    Dec(IDStackPos);
    SetLength(IDStack,IDStackPos*SizeOf(Integer));
  end;

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : PopCycleID = '+DbgInt(Result));
 {$ENDIF}
end;


(*
 * stxCreateTreeNodeRTL
 *)

{$WARNINGS OFF}
procedure stxCreateTreeNodeRTL;
var
 I      : Integer;
 Str    : String;
 ConId  : Integer;
 sIns   : Integer;

 Cycles   : Integer;
 IfCycles : Integer;
 ElseOpened : array of Boolean;
 KCycles  : Integer;
 _Rename  : String;
 LastWhileI,
   LastIType,LastELoc
         : Integer;
 ssEn, ssLn, ssSt : Integer;

begin
 i:=0;
 Cycles:=0;
 IfCycles:=0;
 KCycles:=0;

 LastWhileI := -1;
 LastIType  := 0;
 LastELoc   := 0;
 
 SetLength( ElseOpened, 0);
 
 while i < stxArrayLen do
  begin
    if TotalError then Exit;

     ssEn := stxArray[I].En;
     ssSt := stxArray[I].St;
     ssLn := stxArray[I].Ln;

    case stxArray[I].Id of
     _Pick_    :  llNewNode(_Pick_,0,0,'',ssSt, ssEn, ssLn);
     _Drop_    :  llNewNode(_Drop_,0,0,'',ssSt, ssEn, ssLn);
     _Swap_    :  llNewNode(_Swap_,0,0,'',ssSt, ssEn, ssLn);
     _Step_    :  llNewNode(_Step_,0,0,'',ssSt, ssEn, ssLn);
     _Jump_    :  llNewNode(_Jump_,0,0,'',ssSt, ssEn, ssLn);
     _Rotate_  :  llNewNode(_Rotate_,0,0,'',ssSt, ssEn, ssLn);
     _Right_   :  llNewNode(_Right_,0,0,'',ssSt, ssEn, ssLn);
     _Left_    :  llNewNode(_Left_ ,0,0,'',ssSt, ssEn, ssLn);
     _Up_      :  llNewNode(_Up_   ,0,0,'',ssSt, ssEn, ssLn);
     _Down_    :  llNewNode(_Down_ ,0,0,'',ssSt, ssEn, ssLn);

     _While_   :  begin
                     Inc(Cycles);

                     LastELoc:=I;
                     if not stxIncreasePos( I , stxArray[I].Ln) then exit;

                       if CurrentInterpreter = piTux then
                             ConId:=stxTuxGetConditionId(I, stxArray[I].Ln, _ReName) else
                             ConId:=stxGetConditionId(I, stxArray[I].Ln);

                       if (ConId=0) then Exit;
                  if not TotalError then
                   begin
                     if not stxIncreasePos( I , stxArray[I].Ln) then exit;
                        if not stxNextReservedWord(I,_Do_) then
                          begin
                            if stxArray[I-2].Id=_not_ then
                            stxError(ERR_0x05,SY_DO,SY_WHILE,stxArray[I-3].Ln, stxArray[I-3].St,stxArray[I-3].En, esMedium, $05) else
                            stxError(ERR_0x05,SY_DO,SY_WHILE,stxArray[I-2].Ln, stxArray[I-2].St,stxArray[I-2].En, esMedium, $05);
                            TotalError:=True;
                            Exit;
                          end;
                     end;     
                     LastWhileI:=I+1;
                     LastIType:=_While_;
                     llNewForkNode(_While_,ConId,0,_Rename,ssSt, ssEn, ssLn);
                     PushCycleID(_While_);
                  end;

     _Until_   :  begin
                  if PopCycleId<> _Until_ then
                    begin
                     stxError(ERR_0x0C,SY_REPEAT,SY_UNTIL, stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esMedium, $0C);
                     TotalError:=true;
                     Exit;
                    end;

                  if (LastWhileI = I) and (LastIType=_Until_) then
                   begin
                     stxError(ERR_0x07,'',SY_REPEAT+'...'+SY_UNTIL, stxArray[LastELoc].Ln, stxArray[LastELoc].St, stxArray[LastELoc].En, esMedium, $07);
                     TotalError:=true;
                     Exit;
                   end;
                     Dec(KCycles);

                     if not stxIncreasePos( I , stxArray[I].Ln) then exit;
                      if CurrentInterpreter = piTux then
                             ConId:=stxTuxGetConditionId(I, stxArray[I].Ln, _ReName) else
                             ConId:=stxGetConditionId(I, stxArray[I].Ln);

                       if (ConId=0) then Exit;

                     ILastK^.ConId:=ConId;
                     ILastK^.StPar:=_Rename;
                     llNodeBack;
                  end;

     _Repeat_  :  begin
                      LastELoc:=I;
                      if not stxNextReservedWord(I+2,_Times_) then
                       begin

                       if (stxIsNumber(stxGetIndentifier(I+1))) and (CurrentInterpreter<>piTux) then
                         begin
                            stxError(ERR_0x05, SY_TIMES, SY_REPEAT, stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esMedium, $05);
                            TotalError:=True;
                            Exit;
                         end;

                         llNewForkNode(_Until_,0,1,'',ssSt, ssEn, ssLn);
                         PushCycleID(_Until_);
                         Inc(KCycles);

                         LastELoc:=I;
                         LastWhileI:=I+1;
                         LastIType:=_Until_;

                         Inc(I);
                         Continue;
                       end;
                       Inc(Cycles);
                      if not stxIncreasePos( I , stxArray[I].Ln) then exit;
                       Str:=stxGetIndentifier(I);          // Get the number of iterations !

                       if stxIsNumber(Str) then ConId:=StrToInt(Str) else
                         begin
                            stxError(ERR_0x06, Str,SY_REPEAT, stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esMedium, $06);
                            TotalError:=True;
                            Exit;
                         end;

                     if not stxIncreasePos( I , stxArray[I].Ln) then exit;
                        if not stxNextReservedWord(I,_Times_) then
                          begin
                            stxError(ERR_0x05,SY_TIMES,SY_REPEAT, stxArray[I-2].Ln, stxArray[I-2].St, stxArray[I-2].En, esMedium, $05);
                            TotalError:=True;
                            Exit;
                          end;

                     LastWhileI:=I+1;
                     LastIType:=_Repeat_;

                     llNewForkNode(_Repeat_, 0, ConId, '', ssSt, ssEn, ssLn);
                     PushCycleID(_Repeat_);
                  end;

     _If_    :   begin
                    Inc(IfCycles);

                    SetLength( ElseOpened, IfCycles );
                    ElseOpened[ IfCycles - 1 ] := false;

                     if not stxIncreasePos( I , stxArray[I].Ln) then exit;

                      if CurrentInterpreter = piTux then
                             ConId:=stxTuxGetConditionId(I, stxArray[I].Ln, _ReName) else
                             ConId:=stxGetConditionId(I, stxArray[I].Ln);

                          if (ConId=0) then Exit;

                    if not TotalError then
                    begin
                     if not stxIncreasePos( I , stxArray[I].Ln) then exit;
                        if not stxNextReservedWord(I,_Then_) then
                          begin
                            if stxArray[I-3].Id=_If_ then
                               stxError(ERR_0x05,SY_THEN,SY_IF, stxArray[I-3].Ln, stxArray[I-3].St, stxArray[I-3].En, esMedium, $05)
                                else stxError(ERR_0x05,SY_THEN,SY_IF, stxArray[I-2].Ln, stxArray[I-2].St, stxArray[I-2].En, esMedium, $05);
                            TotalError:=True;
                            Exit;
                          end;
                     end;     

                     llNewForkNode(_If_,ConId,1,_Rename,ssSt, ssEn, ssLn);
                     PushCycleID(_If_);
                  end;

     _Then_  : begin
                 stxError(ERR_0x0B,SY_THEN,SY_IF, stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esFatal, $0B);
                 TotalError:=True;
                 Exit;
                end;
     _Not_  : begin
                 stxError(ERR_0x0B,SY_NOT,SY_IF+'/'+SY_WHILE+'/'+SY_UNTIL, stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esFatal, $0B);
                 TotalError:=True;
                 Exit;
                end;
     _Is_Line_  : begin
                 stxError(ERR_0x0B,SY_IS_LINE,SY_IF+'/'+SY_WHILE+'/'+SY_UNTIL, stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esFatal, $0B);
                 TotalError:=True;
                 Exit;
                end;
     _Is_Border_  : begin
                 stxError(ERR_0x0B,SY_IS_BORDER,SY_IF+'/'+SY_WHILE+'/'+SY_UNTIL, stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esFatal, $0B);
                 TotalError:=True;
                 Exit;
                end;
     _Else_  : begin
                  if IfCycles=0 then
                   begin
                    stxError(ERR_0x0B,SY_ELSE,SY_IF, stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esFatal, $0B);
                    TotalError:=True;
                    Exit;
                   end;

                   if ElseOpened[ IfCycles - 1 ] then
                     begin
                      stxError(ERR_0x14,'',SY_END, stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esFatal, $14);
                      TotalError:=True;
                      Exit;
                     end;

                  ElseOpened[ IfCycles - 1 ] := true;

                   ILastK^.AdvP:=2;
                   llNodeBack;

                   llNewForkNode(_Else_,0,1,'',ssSt, ssEn, ssLn);
                end;
     _Times_ : begin
                 stxError(ERR_0x0B,SY_TIMES,SY_REPEAT, stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esFatal, $0B);
                 TotalError:=True;
                 Exit;
                end;
     _Do_    :  begin
                 stxError(ERR_0x0B,SY_DO,SY_WHILE, stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esFatal, $0B);
                 TotalError:=True;
                 Exit;
                end;
     _TuxCondition_ :  begin
                 stxError(ERR_0x03,stxArray[I].Str,'',stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esFatal, $03);
                 TotalError:=True;
                 Exit;
                end;
     _TuxCondition_+1 .. _TuxCondition_+18 :  begin
                 stxError(ERR_0x0B,stxArray[I].Str,SY_IF+'/'+SY_WHILE+'/'+SY_UNTIL,stxArray[I].Ln, stxArray[I].St, stxArray[I].En,esFatal, $0B);
                 TotalError:=True;
                 Exit;
                end;
     _Procedure_ : begin
                     Inc(Cycles);
                     LastELoc:=I;

                     if not stxIncreasePos( I , stxArray[I].Ln) then exit;

                       if (not stxNextReservedWord(I,_Identifier_)) then
                               begin
                                stxError(ERR_0x0E,'','', stxArray[I-1].Ln, stxArray[I-1].St, stxArray[I-1].En, esFatal, $0E);
                                TotalError:=True;
                                Exit;
                               end;

                       if not stxIsIndentifier(stxArray[I].Str) then
                               begin
                                stxError(ERR_0x17,stxArray[I].Str,'', stxArray[I].Ln, stxArray[I].St+ZZPop1, stxArray[I].St+ZZPop2, esMedium, $17);
                                TotalError:=True;
                                Exit;
                               end;

                       if llGetLabelNodeByName(stxArray[I].Str) <> nil then
                               begin
                                stxError(ERR_0x0F,stxArray[I].Str,'', stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esFatal, $0F);
                                TotalError:=True;
                                Exit;
                               end;
                       LastWhileI:=I+1;
                       LastIType:=_Procedure_;

                       llNewFuncNode(_Procedure_,0,1,stxArray[I].Str,ssSt, ssEn, ssLn);
                       PushCycleID(_Procedure_);
                   end;
     _Call_  : begin
                  if not stxIncreasePos( I , stxArray[I].Ln) then exit;
                  if not stxNextReservedWord(I,_Identifier_) then
                    begin
                      stxError(ERR_0x10,'',SY_CALL, stxArray[I-1].Ln, stxArray[I-1].St, stxArray[I-1].En, esFatal, $10);
                      TotalError:=True;
                      Exit;
                    end;

                 if not stxIsIndentifier(stxArray[I].Str) then
                    begin
                     stxError(ERR_0x17,stxArray[I].Str,'', stxArray[I].Ln, stxArray[I].St+ZZPop1, stxArray[I].St+ZZPop2, esMedium, $17);
                     TotalError:=True;
                     Exit;
                    end;

                  if llGetLabelNodeByName(stxArray[I].Str)= nil then
                    begin
                      stxError(ERR_0x11,stxArray[I].Str,'', stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esFatal, $11);
                      TotalError:=True;
                      Exit;
                    end;

                  llNewNode(_Call_, llGetLabelIDByName(stxArray[ I ].Str), 0,'',ssSt, ssEn, ssLn);
                end;

     _Remember_ : begin
                  if not stxIncreasePos( I , stxArray[I].Ln) then exit;

                  if not stxNextReservedWord(I,_Identifier_) then
                    begin
                      stxError(ERR_0x18,'',SY_REMEMBER, stxArray[I-1].Ln, stxArray[I-1].St, stxArray[I-1].En, esFatal, $18);
                      TotalError:=True;
                      Exit;
                    end;

                 if not stxIsIndentifier(stxArray[I].Str) then
                    begin
                     stxError(ERR_0x17,stxArray[I].Str,'', stxArray[I].Ln, stxArray[I].St+ZZPop1, stxArray[I].St+ZZPop2, esMedium, $17);
                     TotalError:=True;
                     Exit;
                    end;


                  llNewNode( _Remember_, 0, 0, stxArray[ I ].Str,ssSt, ssEn, ssLn);
                end;

     _Forget_ : begin
                  if not stxIncreasePos( I , stxArray[I].Ln) then exit;

                  if not stxNextReservedWord(I,_Identifier_) then
                    begin
                      stxError(ERR_0x18,'',SY_FORGET, stxArray[I-1].Ln, stxArray[I-1].St, stxArray[I-1].En, esFatal, $18);
                      TotalError:=True;
                      Exit;
                    end;

                 if not stxIsIndentifier(stxArray[I].Str) then
                    begin
                     stxError(ERR_0x17,stxArray[I].Str,'', stxArray[I].Ln, stxArray[I].St+ZZPop1, stxArray[I].St+ZZPop2, esMedium, $17);
                     TotalError:=True;
                     Exit;
                    end;


                  llNewNode( _Forget_, 0, 0, stxArray[ I ].Str,ssSt, ssEn, ssLn);
                end;

     _Restore_ : begin
                  if not stxIncreasePos( I , stxArray[I].Ln) then exit;

                  if not stxNextReservedWord(I,_Identifier_) then
                    begin
                      stxError(ERR_0x18,'',SY_RESTORE, stxArray[I-1].Ln, stxArray[I-1].St, stxArray[I-1].En, esFatal, $18);
                      TotalError:=True;
                      Exit;
                    end;

                 if not stxIsIndentifier(stxArray[I].Str) then
                    begin
                     stxError(ERR_0x17,stxArray[I].Str,'', stxArray[I].Ln, stxArray[I].St+ZZPop1, stxArray[I].St+ZZPop2, esMedium, $17);
                     TotalError:=True;
                     Exit;
                    end;


                  llNewNode( _Restore_, 0, 0, stxArray[ I ].Str,ssSt, ssEn, ssLn);
                end;

     _End_   : begin
                ConId:=PopCycleId;

                if (ConId = _Until_) then
                  begin
                     stxError(ERR_0x1F,SY_UNTIL,SY_REPEAT,stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esFatal, $1F);
                     SelStart:=1;
                     SelLine:=-1;
                     TotalError:=true;
                     Exit;
                  end;

                   if (LastWhileI = I) then
                   begin
                    if LastIType=_While_ then
                     stxError(ERR_0x07,'',SY_WHILE, stxArray[LastELoc].Ln, stxArray[LastELoc].St, stxArray[LastELoc].En, esMedium, $07);

                    if LastIType=_Repeat_ then
                     stxError(ERR_0x07,'',SY_REPEAT, stxArray[LastELoc].Ln, stxArray[LastELoc].St, stxArray[LastELoc].En, esMedium, $07);

                    if LastIType=_Procedure_ then
                     stxError(ERR_0x07,'',SY_PROCEDURE, stxArray[LastELoc].Ln, stxArray[LastELoc].St, stxArray[LastELoc].En, esMedium, $07);

                     TotalError:=true;
                     Exit;
                   end;

                 LastWhileI:=-1;
                 Inc(I);
                 if (I>stxArrayLen-1) and (ConId<>_Start_) then               // Start
                       begin
                         stxError(ERR_0x14,'',SY_END, stxArray[I-1].Ln, stxArray[I-1].St, stxArray[I-1].En, esFatal, $14);
                         TotalError:=true;
                         Exit;
                       end else if ConId=_Start_ then Dec(Cycles);

                 if (I<stxArrayLen)  then                                  // All other
                 if (not stxNextReservedWord(I,ConId)) then
                       begin
                         stxError(ERR_0x15,'',SY_END, stxArray[I-1].Ln, stxArray[I-1].St, stxArray[I-1].En, esFatal, $15);
                         TotalError:=true;
                         Exit;
                       end else
                  begin
                   if ConId=_If_ then Dec(IfCycles) else Dec(Cycles);
                   llNodeBack;
                  end;

                end;
     _Start_ : begin
                llNewFuncNode(55,0,1,'_ProStart##6',ssSt, ssEn, ssLn);
                Inc(Cycles);
                PushCycleId(_Start_);
               end;
     else
       begin

         if not stxIsIndentifier(stxArray[I].Str) then
             begin
              stxError(ERR_0x17,stxArray[I].Str,'', stxArray[I].Ln, stxArray[I].St+ZZPop1, stxArray[I].St+ZZPop2, esMedium, $17);
              TotalError:=True;
              Exit;
             end;

          stxError(ERR_0x12,stxArray[I].Str,'', stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esFatal, $12);
          TotalError:=true;
          Exit;
       end;
  end;
      Inc(I);
  end;
   if (Cycles>0) or (IfCycles>0) then
    begin
       stxError(ERR_0x14,'',SY_END, stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esFatal, $14);
       SelStart:=1;
       SelLine:=-1;
       TotalError:=true;
       Exit;
    end;
  if (KCycles>0) then
    begin
       stxError(ERR_0x14,'',SY_UNTIL,stxArray[I].Ln, stxArray[I].St, stxArray[I].En, esFatal, $14);
       SelStart:=1;
       SelLine:=-1;
       TotalError:=true;
       Exit;
    end;
end;
{$WARNINGS ON}

(*
 * _ConCheck
 *)

function _ConCheck(St : Integer; StPar : String) : Boolean;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : _ConCheck ( St:'+DbgInt(St)+'; StPar:'+DbgStr(StPar)+')');
   DbgPlus;
 {$ENDIF}
  Result := false;
 if Abs(St) > _TuxCondition_ then
  case Abs(St) - _TuxCondition_  of
    1            : Result := pntConditionIsBorder;
    2            : Result := mmLetterInCell();
    3            : Result := mmLetterInPocket();
    4            : Result := mmMemoryAvailable(StPar);

    5,16         : Result := mmCellEqPocket();
    6,18         : Result := mmCellBgPocket();
    7,17         : Result := mmCellLsPocket();

    8            : Result := mmCellEqLetter(StPar);
    9            : Result := mmCellBgLetter(StPar);
    10           : Result := mmCellLsLetter(StPar);

    11           : Result := mmPocketEqLetter(StPar);
    12           : Result := mmPocketBgLetter(StPar);
    13           : Result := mmPocketLsLetter(StPar);

    14           : Result := mmPocketUppercase();
    15           : Result := mmCellUppercase();
   end else
  case St of
    _Is_Line_       : Result:=pntConditionIsLine;
    _Is_Border_     : Result:=pntConditionIsBorder;
    _Is_Not_Line_   : Result:=pntConditionIsNotLine;
    _Is_Not_Border_ : Result:=pntConditionIsNotBorder;
   end;
    if St<0 then Result := not Result;

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : _ConCheck = '+DbgBool(Result));
 {$ENDIF}
end;

function CreateStringFingerPrint(St : String) : LongInt;
var
 i : Integer;
begin
 Result := 1;
 if St = '' then Exit;

 for i:=1 to Length(St) do
    Result := Result + Ord(St[i])*i*Result;
end;

function CreateCellFingerPrint(X, Y : Integer) : LongInt;
begin
if not Gol(t[X, Y].Word) then
Result :=
( Integer(t[X,Y].Pres) +
  Integer(t[X,Y].Oriz)*2 +
   Integer(t[X,Y].Vert)*4 +
    CreateStringFingerPrint(t[X, Y].Word)
) else
Result :=
( Integer(t[X,Y].Pres) +
  Integer(t[X,Y].Oriz)*2 +
   Integer(t[X,Y].Vert)*4
)
end;

function CreateTableFingerPrint() : LongInt;
var
 Tx, Ty : Integer;
begin
 Result := 0;
 for Tx:= 1 to TabMax do
  for Ty := 1 to TabMax do
     Result := Result + CreateCellFingerPrint(Tx, Ty) * (Ty * TabMax + Tx);
end;

function CreateStackCellFingerPrint(M,C : Integer) : LongInt;
begin
Result :=
 (Memorys[M].mPos[C].Y * TabMax) +
 (Memorys[M].mPos[C].X) +
 (Memorys[M].mPos[C].DirX * 10000);
end;

function CreateStackFingerPrint(M : Integer) : LongInt;
var
 Tx : Integer;
begin
  Result := 1;
  if Memorys[M].mStack = 0 then Exit;
  for Tx := 0 to Memorys[M].mStack -1 do
   Result := Result + CreateStackCellFingerPrint(M, Tx) * Tx;
end;

function CreateMemoryCellFingerPrint(Cell : Integer) : LongInt;
begin
Result :=
 (CreateStackFingerPrint(Cell)*139513)+
 (CreateStringFingerPrint(Memorys[Cell].mName)) +
 (Integer(Memorys[Cell].mFunc)*1173);
end;

function CreateMemoryFingerPrint() : LongInt;
var
 I : Integer;
begin
 Result := 541219;
 if mMemorys = 0 then Exit;

 for i:=0 to mMemorys - 1 do
    Result := Result + CreateMemoryCellFingerPrint(i) * i;
end;

function CreateDirectionalFingerPrint() : LongInt;
begin
  Result :=
  (Sx * 1034001) +
  (Sx * 4057002) +
  (U  * 1040803) +
  (V  * 1407219) +
  (CreateStringFingerPrint( Msg_Text.Caption ));
end;

function CreateSituationFingerPrint : LongInt;
begin
Result :=
  CreateMemoryFingerPrint() +
  CreateTableFingerPrint() +
  CreateDirectionalFingerPrint();
end;


(*
 * ExecuteAlgorithm
 *)
{$WARNINGS OFF}

function ExecuteAlgorithm(NodePtr : Pointer;var Finger : TFingerPrint; var PId : Byte;var ConId : SmallInt; var AdvP : Word; StPar : String;
                          pSt, pEn : Byte; pLn : Word) : Boolean;
Var
  CSit : LongInt;
{$IFDEF _DEBUG_}

  st   : string;
  I    : Integer;
{$ENDIF}
begin
 {$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : ExecuteAlgorithm(NodePtr:'+DbgAddr(NodePtr)+'; var Finger:'+DbgFinger(Finger)+'; var PId:'+DbgInt(PId)+'; var ConId:'+DbgInt(ConId)
           +'; var AdvP:'+DbgInt(AdvP)+'; StPar:'+DbgStr(StPar)+'; pSt:'+DbgInt(pSt)+'; pEn:'+DbgInt(pEn)+'; pLn:'+DbgInt(pLn)+')');
  DbgPlus;
 {$ENDIF}
  Result := false;

  if ValueInArray(BkList, pLn) then
   begin
    StartedInStepMode := True;
    WaitForNewStep    := False;
    SendMessage(PHandle, WM_InstructionCalculate, 1, 0);
   end;

  if (StartedInStepMode) and (PId <> _Call_Procedure_) then
   if ((PId = _Start_) or (PId = _Else_) or (PId = _If_)) and
      (AdvP = 0 ) then else
  begin
   stxHighlightWord(pSt, pEn , pLn, True);
   While (not WaitForNewStep) and (not KillThreadFlag) do Sleep(20);
   WaitForNewStep := False;
  end;

   if ((PId = _Start_) or (PId = _Else_) or (PId = _If_)) and
      (AdvP = 0 ) then else
      stxHighlightWord(pSt, pEn , pLn, False);

  if KillThreadFlag then
    begin
      StopDispatchingFlag:=True;
      Result:=false;
      {$IFDEF _DEBUG2_}
       DbgMinus;
       DbgPrint(DbgUName+' : ExecuteAlgorithm ( var PId:'+DbgInt(PId)+'; var ConId:'+DbgInt(ConId)+'; var AdvP:'+DbgInt(AdvP)+' ) = '+DbgBool(Result));
     {$ENDIF}
      Exit;
    end;
   

{$IFDEF _DEBUG_}
   st:='';
   for i:=1 to NodeDeep do st:=st + '-';
   St := DbgUName+' : ExecuteAlgorithm | ' + St + '>';
{$ENDIF}

   if (PId <> _Repeat_) and (PId <> _If_) and (PId <> _Else_) and (PId <> _Start_) and (PId <> _Call_Procedure_) then
   begin
   CSit := CreateSituationFingerPrint();
   if (CSit = Finger[pntGetAnimalOrientation(otPrimary)]) and (not RuntimeCycle) then
     begin
      stxError(ERR_0x0D,'',SY_END, CurrentLine, CurrentStart, CurrentEnd, esRuntime, $0D);

      {SelLine:=-1;
      SelStart:=0;}
      
      RuntimeCycle := True;
     end else Finger[pntGetAnimalOrientation(otPrimary)] := CSit;
   end;  
 case PId of
          _Step_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' STEP');
                   {$ENDIF}

                    if RuntimeCycle then WasMovement := True;

                     result:=false;
                     if (not StartedInStepMode) then sleep(wait);

                     if CurrentInterpreter=piTux then pntStepTux else
                                                      pntStepKng;
                     SendMessage(PHandle, WM_InstructionCalculate, 0, 0);
                   end;

          _Jump_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' JUMP');
                   {$ENDIF}

                    if RuntimeCycle then WasMovement := True;

                     result:=false;
                     if (not StartedInStepMode) then sleep(wait);
                      pntJumpKng;

                     SendMessage(PHandle, WM_InstructionCalculate, 0, 0);
                   end;

         _Rotate_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' ROTATE');
                   {$ENDIF}

                    if RuntimeCycle then WasMovement := True;

                     result:=false;
                     if (not StartedInStepMode) then sleep(wait);

                     if CurrentInterpreter=piTux then pntRotateTux else
                                                      pntRotateKng;

                     SendMessage(PHandle, WM_InstructionCalculate, 0, 0);
                   end;

           _Left_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' LEFT');
                   {$ENDIF}

                    if RuntimeCycle then WasMovement := True;

                     result:=false;
                     pntLeftAnt;
                     if (not StartedInStepMode) then Sleep(Wait);

                     SendMessage(PHandle, WM_InstructionCalculate, 0, 0);
                   end;

          _Right_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' RIGHT');
                   {$ENDIF}

                    if RuntimeCycle then WasMovement := True;

                     result:=false;
                     pntRightAnt;
                     if (not StartedInStepMode) then Sleep(Wait);

                     SendMessage(PHandle, WM_InstructionCalculate, 0, 0);
                   end;

             _Up_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' UP');
                   {$ENDIF}

                    if RuntimeCycle then WasMovement := True;

                     result:=false;
                     pntUpAnt;
                     if (not StartedInStepMode) then Sleep(Wait);

                     SendMessage(PHandle, WM_InstructionCalculate, 0, 0);
                   end;

           _Down_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' DOWN');
                   {$ENDIF}

                    if RuntimeCycle then WasMovement := True;

                     result:=false;
                     pntDownAnt;
                     if (not StartedInStepMode) then Sleep(Wait);

                     SendMessage(PHandle, WM_InstructionCalculate, 0, 0);
                    end;

         _Repeat_ : begin
                   {$IFDEF _DEBUG_}
                    DbgPrint(st + ' REPEAT '+DbgInt(AdvP)+' TIMES');
                   {$ENDIF}
                    if (StepByStepHighlighting) and (not StartedInStepMode) then Sleep(wait);

                    result:=true;
                    if AdvP=0 then result:=false else
                               Dec(AdvP);
                   end;

          _While_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' WHILE '+DbgInt(ConId)+' DO');
                   {$ENDIF}
                    if (StepByStepHighlighting) and (not StartedInStepMode) then Sleep(wait);

                    if (not WasMovement) and (RuntimeCycle) then
                        Sleep((Wait+1));

                     Result:=_ConCheck(ConId, StPar );

                   end;

           _Until_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' UNTIL '+DbgInt(ConId)+' DO');
                   {$ENDIF}
                  Result:=True;
                  if (StepByStepHighlighting) and (not StartedInStepMode) then Sleep(wait);

                  if (not WasMovement) and (RuntimeCycle) then
                      Sleep((Wait+1));

                  if AdvP=0 then Result:=not _ConCheck(ConId, StPar) else
                               Dec(AdvP);
                   end;

             _If_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' IF '+DbgInt(ConId)+' THEN');
                   {$ENDIF}
                    if (StepByStepHighlighting) and (not StartedInStepMode) then Sleep(wait);

                     if AdvP=0 then result:=false
                       else
                       begin
                       Result:=_ConCheck(ConId, StPar);
                       if AdvP=2 then PushIf(Result);
                       AdvP:=0;
                      end;
                    end;

       _Procedure_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' PROCEDURE (Ignored)');
                   {$ENDIF}
                    result:=false;
                   end;

           _Start_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' START');
                   {$ENDIF}
                    if (StepByStepHighlighting) and (not StartedInStepMode) then Sleep(wait);

                    result:=true;
                    if AdvP=0 then result:=false else
                               Dec(AdvP);
                  end;
          _Else_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' ELSE');
                   {$ENDIF}
                     Result:=false;
                      if AdvP=0 then
                      begin
                        {$IFDEF _DEBUG2_}
                         DbgMinus;
                         DbgPrint(DbgUName+' : ExecuteAlgorithm ( var PId:'+DbgInt(PId)+'; var ConId:'+DbgInt(ConId)+'; var AdvP:'+DbgInt(AdvP)+' ) = '+DbgBool(Result));
                       {$ENDIF}
                       Exit;
                      end;
                       Result:=not PopIf;
                       Dec(AdvP);
                   end;
       _Remember_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' REMEMBER '+DbgStr(StPar));
                   {$ENDIF}
                     if (StepByStepHighlighting) and (not StartedInStepMode) then Sleep(wait);

                     result:=false;
                     mmMemorizePosition(StPar);

                     SendMessage(PHandle, WM_InstructionCalculate, 0, 0);
                   end;
       _Restore_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' RESTORE '+DbgStr(StPar));
                   {$ENDIF}
                    if (StepByStepHighlighting) and (not StartedInStepMode) then Sleep(wait);

                    if RuntimeCycle then WasMovement := True;

                     result:=false;
                     mmRestorePosition(StPar);

                     SendMessage(PHandle, WM_InstructionCalculate, 0, 0);
                   end;
       _Forget_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' FORGET '+DbgStr(StPar));
                   {$ENDIF}
                     if (StepByStepHighlighting) and (not StartedInStepMode) then Sleep(wait);

                     result:=false;
                     mmForgetPosition(StPar);

                     SendMessage(PHandle, WM_InstructionCalculate, 0, 0);
                   end;

       _Pick_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' PICK');
                   {$ENDIF}
                    if (StepByStepHighlighting) and (not StartedInStepMode) then Sleep(wait);

                     result:=false;
                     mmPickLetter();

                     SendMessage(PHandle, WM_InstructionCalculate, 0, 0);
                   end;
       _Drop_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' DROP');
                   {$ENDIF}
                    if (StepByStepHighlighting) and (not StartedInStepMode) then Sleep(wait);

                     result:=false;
                     mmDropLetter();

                     SendMessage(PHandle, WM_InstructionCalculate, 0, 0);
                   end;
       _Swap_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(st + ' SWAP');
                   {$ENDIF}
                    if (StepByStepHighlighting) and (not StartedInStepMode) then Sleep(wait);

                     result:=false;
                     mmSwapLetters();

                     SendMessage(PHandle, WM_InstructionCalculate, 0, 0);
                   end;

          _Call_ : begin
                   {$IFDEF _DEBUG_}
                     DbgPrint(St + ' CALL '+DbgStr(llGetLabelNameByID(ConID)));
                   {$ENDIF}

                    llCallLabel( llGetLabelNameByID(ConID), _Call_Procedure_);
                    result:=false;
                   end;
          _Call_Procedure_ :
                   begin
                   {$IFDEF _DEBUG_}
                    DbgPrint(st + ' PROCEDURE (Entry Point)');
                   {$ENDIF}
                    if (StepByStepHighlighting) and (not StartedInStepMode) then Sleep(wait);

                    result:=true;
                    if AdvP=0 then result:=false else
                               Dec(AdvP);
                   end;
   end;

  {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : ExecuteAlgorithm ( var PId:'+DbgInt(PId)+'; var Finger:'+DbgFinger(Finger)+'; var ConId:'+DbgInt(ConId)+'; var AdvP:'+DbgInt(AdvP)+' ) = '+DbgBool(Result));
  {$ENDIF}

end;


(*
 * stxCreateNodeTree
 *)

procedure stxCreateNodeTree(Holder : SyntaxTextHolder; PHandle : HWND);
var
 I          : Integer;

{$IFDEF _DEBUG_}
  PreAlloc : Integer;
{$ENDIF}

begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : stxCreateNodeTree ( Holder:'+DbgObject(Holder)+'; PHandle:'+DbgInt(PHandle)+')');
   DbgPlus;
 {$ENDIF}

 mmEraseMemory();

 TotalError:=False;
 KillThreadFlag:=False;
 StopDispatchingFlag:=False;
 CycleObserved:=False;
 CommentOn:=false;
 InternalCondition := '';
 SetLength(stxArray,0);
 stxArrayLen:=0;

 SetLength(IDStack,0);
 IdStackPos:=0;

 if llGetRootNode <> nil then nlDestroyTreeStructure(llGetRootNode);
  llReInitializeAllDataStructures;

  {$IFDEF _DEBUG_}
    PreAlloc := AllocMemSize;
  {$ENDIF}

 for i:=0 to Holder.Lines.Count-1 do
   begin
    stxDispatchLine(ProCBFunc, Holder.Lines.Strings[I], I);
    if TotalError then Break;
   end;
    if not TotalError then
       ProCBFunc(Holder.Lines.Count-1,0,0,'');

  {$IFDEF _DEBUG_}
    PreAlloc := AllocMemSize - PreAlloc;
  {$ENDIF}


{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : stxCreateNodeTree | Allocated '+DbgInt(PreAlloc)+' Bytes for Syntax Processing.');
{$ENDIF}

    if TotalError then
      begin
         if llGetRootNode <> nil then nlDestroyTreeStructure(llGetRootNode);
          llReInitializeAllDataStructures;
      
        PostMessage(PHandle,WM_EnableAllControls,0,0);
        KillThreadFlag:=False;
        {$IFDEF _DEBUG2_}
         DbgMinus;
         DbgPrint(DbgUName+' : stxCreateNodeTree = void');
        {$ENDIF}
        Exit;
      end;

  llDefineRootNode(0,0,0);

 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : stxCreateTreeNodeRTL ()');
   DbgPlus;
 {$ENDIF}


  {$IFDEF _DEBUG_}
    PreAlloc := AllocMemSize;
  {$ENDIF}

  stxCreateTreeNodeRTL();

  {$IFDEF _DEBUG_}
    PreAlloc := AllocMemSize - PreAlloc;
  {$ENDIF}

  {$IFDEF _DEBUG_}
    DbgPrint(DbgUName+' : stxCreateTreeNodeRTL | Allocated '+DbgInt(PreAlloc)+' Bytes for all nodes.');
  {$ENDIF}

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : stxCreateTreeNodeRTL = void');
  {$ENDIF}

  SetLength(stxArray,0);
  stxArrayLen:=0;

    if TotalError then
      begin
         if llGetRootNode <> nil then nlDestroyTreeStructure(llGetRootNode);
          llReInitializeAllDataStructures;

          PostMessage(PHandle,WM_EnableAllControls,0,0);
          KillThreadFlag:=False;
          SetLength(stxArray,0);
          stxArrayLen:=0;
         {$IFDEF _DEBUG2_}
           DbgMinus;
           DbgPrint(DbgUName+' : stxCreateNodeTree = void');
         {$ENDIF}
          Exit;
      end;

  if llGetLabelNodeByName('_ProStart##6')=nil then
    begin
     if llGetRootNode <> nil then nlDestroyTreeStructure(llGetRootNode);
       llReInitializeAllDataStructures;

     stxError(ERR_0x16,'',SY_START,1, 0,0, esFatal, $16);
     SelLine:=0;
     PostMessage(PHandle,WM_EnableAllControls,0,0);
     KillThreadFlag:=False;
     TotalError:=True;
      {$IFDEF _DEBUG2_}
       DbgMinus;
       DbgPrint(DbgUName+' : stxCreateNodeTree = void');
      {$ENDIF}
     Exit;
    end;

if CheckExecute then
   begin
     ExecutionStarted:=True;
     nlRegisterDispatchCallback(ExecuteAlgorithm);
     llCallLabel('_ProStart##6',_Start_);
    end else
    begin
     SelLine:=-1;
     SelStart:=0;

     if ShowOKBox then
       stxError('',ERR_0x00,'',0,0,0, esNormal, $00);

    end;

if llGetRootNode <> nil then nlDestroyTreeStructure(llGetRootNode);
  llReInitializeAllDataStructures;

if CheckExecute then
 begin
  ExecutionStarted:=False;
  PostMessage(PHandle,WM_EnableAllControls,0,0);
  KillThreadFlag:=False;
 end;

{$IFDEF _DEBUG2_}
 DbgMinus;
 DbgPrint(DbgUName+' : stxCreateNodeTree = void');
{$ENDIF}
end;


(*
 * SyntaxExecutionThread
 *)

function SyntaxExecutionThread(P : Pointer) : DWORD; stdcall;
begin
{$IFDEF _DEBUG2_}
  DbgPrint(DbgUName+' : SyntaxExecutionThread( P:'+DbgAddr(P)+')');
  DbgPlus;
{$ENDIF}

 stxCreateNodeTree(Holder, PHandle);
 Result:=0;

{$IFDEF _DEBUG2_}
 DbgMinus;
 DbgPrint(DbgUName+' : SyntaxExecutionThread = '+DbgInt(Result));
{$ENDIF}
end;


(*
 * stxStartSyntaxExecutionThread
 *)

function stxStartSyntaxExecutionThread;
var
 ThId : Cardinal;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : StartSyntaxExecutionThread(Msg_Text_:'+DbgObject(Msg_Text_)+'; Holder_:'+DbgObject(Holder_)+'; PHandle_:'+DbgInt(PHandle_)+'; Execute:'+DbgBool(Execute)+')');
  DbgPlus;
{$ENDIF}

 Holder:=Holder_;
 PHandle:=PHandle_;
 Msg_Text := Msg_Text_;
 CheckExecute:=Execute;
 ShowOKBox := ShowOK;
 PrevoId := 0;
 RuntimeCycle := False;
 WasMovement := False;

 if CheckExecute then
 begin
  CreateThread(nil,0,@SyntaxExecutionThread,nil,0,ThId);
  Result:=True;
 end else
 begin
  SyntaxExecutionThread(nil);
  Result:=not TotalError;
 end;

{$IFDEF _DEBUG_}
 DbgMinus;
 DbgPrint(DbgUName+' : stxStartSyntaxExecutionThread = '+DbgBool(Result));
{$ENDIF}
end;
{$WARNINGS ON}

end.

