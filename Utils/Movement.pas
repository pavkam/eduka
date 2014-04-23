(*


The Original Code is: Movement.pas, released 2005-02-02.
Authors of this file are Popov John and Ciobanu Alexander. All Rights Reserved.

Description :
    Unit implements the Movement/Graphics functions.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit Movement;

interface
 uses  Controls, Classes, ExtCtrls, Forms, ProTypes,  Windows,Graphics, Translate,Errors, Messages ,DesignInside,
       SysUtils, StdCtrls, Utils
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
 ;

{$IFDEF _DEBUG_}
Const
  DbgUName  =  '/Utils/Movement.pas';
{$ENDIF}

 procedure pntStepTux;
 procedure pntRotateTux;
 procedure pntStepKng;
 procedure pntJumpKng;
 procedure pntRotateKng;
 procedure pntLeftAnt;
 procedure pntRightAnt;
 procedure pntUpAnt;
 procedure pntDownAnt;
 procedure pntRotateAnt;
 function  pntConditionIsLine:boolean;
 function  pntConditionIsNotLine:boolean;
 function  pntConditionIsBorder:boolean;
 function  pntConditionIsNotBorder:boolean;
 function  pntGetAnimalOrientation(Grd : TOtherGrid; ExerciseNr : Integer = -1 ) : Integer;
 procedure pntSetAnimalOrientation(OrX : Integer; Grd : TOtherGrid; ExerciseNr : Integer = -1 );

 procedure pntSwapPrimaryGrid(SwapIn : Boolean; gWith : TOtherGrid; ExerciseID : Integer = 0);
  function pntCompareGrids(Table1, Table2 : TProTable) : Boolean;
  function pntCorrectDirectionals(Sx, Sy : Integer) : Boolean;
 procedure pntRedrawWholeTable();
 procedure pntRedrawTable();
 procedure pntShowAnimal;
 procedure pntDrawTableAgain(Canvas : TCanvas);
 procedure pntDrawGrid( Canvas : TCanvas );
  function pntGridPixelate(GridPixelSize : Integer) : Integer;
  function pntGridDePixelate(GridSize : Integer; Intrp : TProInterpreter) : Integer;
procedure pntInitializeValues(ClearGrid, AnimalReset : Boolean);
 procedure pntClearGrid(Grd : TOtherGrid; ExerciseNr : Integer = -1 );
 procedure pntHideInterpreterImages( InterpreterID : TProInterpreter );
 procedure pntInitializeGraphics( Kng_im_Left_, Kng_im_Right_, Kng_im_Up_, Kng_im_Down_, ant_im_Left_, ant_im_Right_, ant_im_Up_,
  ant_im_Down_, tux_im_Left_, tux_im_Right_, tux_im_Up_, tux_im_Down_ : TImage; PaintBox_ : TPaintBox; MainForm_ : TForm);

 procedure pntDrawGridPoint(Canvas : TCanvas; tx, ty, vx, vy : Integer);
 procedure pntRedrawGridLetter(Canvas : TCanvas; x,y : integer);

implementation
 uses ProSyntax;
 var
  tt : integer;
  grid_x,grid_y :integer;
  PenUp, PenDown : Boolean;

 Kng_im_Left,
 Kng_im_Right,
 Kng_im_Up,
 Kng_im_Down,
 tux_im_Left,
 tux_im_Right,
 tux_im_Up,
 tux_im_Down,
 ant_im_Left,
 ant_im_Right,
 ant_im_Up,
 ant_im_Down : TImage;
 PaintBox : TPaintBox;
 MainForm : TForm;

 function posible(x_,y_:integer):boolean;forward;
 procedure mers( x,y:TTableIndex ; k : integer);forward;
 procedure Rotate;forward;
 function watchLeft:boolean;forward;
 function watchRight:boolean;forward;
 function watchUp:boolean;forward;
 function watchDown:boolean;forward;
 procedure RotateLeft;forward;
 procedure RotateRight;forward;
 procedure RotateUp;forward;
 procedure RotateDown;forward;

procedure pntRedrawWholeTable();
begin
 pntDrawGrid       ( GridMap.Canvas );
 pntDrawTableAgain ( GridMap.Canvas );
 PaintBox.Canvas.Draw(0,0,GridMap);

 PaintBox.Repaint;
end;

function pntCompareGrids(Table1, Table2 : TProTable) : Boolean;
var
 CmpX, CmpY : Integer;
 NoDiff     : Boolean;
begin
  NoDiff := True;
  for CmpX := 1 to TabMax do
   for CmpY := 1 to TabMax do
    NoDiff := NoDiff and
    ((table1[CmpX, CmpY].Oriz = table2[CmpX, CmpY].Oriz) and
     (table1[CmpX, CmpY].Vert = table2[CmpX, CmpY].Vert)  and
     (table1[CmpX, CmpY].Word = table2[CmpX, CmpY].Word));

  Result := NoDiff;
end;

procedure pntSwapPrimaryGrid(SwapIn : Boolean; gWith : TOtherGrid; ExerciseID : Integer = 0);
var
 i,j : Integer;
begin

 if SwapIn then
 begin
  pntHideInterpreterImages(piTux);
  pntHideInterpreterImages(piAnt);
  pntHideInterpreterImages(piKng);

 case gWith of
  otTemp   :
        begin
          t  := tempTable;
          u  := current_i;
          v  := current_j;
          Sx := tempsx;
          Sy := tempsy;
        end;
  otExerciseG1 :
        begin
          t  := tb1;
          u  := u1;
          v  := v1;
          Sx := Sx1;
          Sy := Sy1;
        end;
  otExerciseG2 :
        begin
          t  := tb2;
          u  := u2;
          v  := v2;
          Sx := Sx2;
          Sy := Sy2;
        end;
  otTestG1 :
        begin
          t  := SelectedFileList [ ExerciseID ].Info1.InGrid;
          u  := SelectedFileList [ ExerciseID ].Info1.InPositionalX;
          v  := SelectedFileList [ ExerciseID ].Info1.InPositionalY;
          Sx := SelectedFileList [ ExerciseID ].Info1.InDirectionalX;
          Sy := SelectedFileList [ ExerciseID ].Info1.InDirectionalY;
        end;
  otTestG2 :
        begin
          t  := SelectedFileList [ ExerciseID ].Info1.OutGrid;
          u  := SelectedFileList [ ExerciseID ].Info1.OutPositionalX;
          v  := SelectedFileList [ ExerciseID ].Info1.OutPositionalY;
          Sx := SelectedFileList [ ExerciseID ].Info1.OutDirectionalX;
          Sy := SelectedFileList [ ExerciseID ].Info1.OutDirectionalY;
        end;
 end;
   CurrentX :=   + GridPixelSize *(u-1);
   CurrentY :=   + GridPixelSize *(v-1);

   pntShowAnimal();
   pntRedrawWholeTable();
 end else
 case gWith of
  otTemp   :
        begin
         tempTable := t;
         current_i := u;
         current_j := v;
         tempsx    := Sx;
         tempsy    := Sy;

         for j:=1 to tabMax do
             for i:=1 to tabMax do  tempTable[i,j].Pres  := False;

        end;
  otExerciseG1 :
        begin
          tb1 := t;
          u1  := u;
          v1  := v;
          Sx1 := Sx;
          Sy1 := Sy;

         for j:=1 to tabMax do
             for i:=1 to tabMax do  tb1[i,j].Pres  := False;

        end;
  otExerciseG2 :
        begin
          tb2 := t;
          u2  := u;
          v2  := v;
          Sx2 := Sx;
          Sy2 := Sy;

         for j:=1 to tabMax do
             for i:=1 to tabMax do tb2[i,j].Pres  := False;

        end;

  otTestG1 :
        begin
          SelectedFileList [ ExerciseID ].Info1.InGrid         := t;
          SelectedFileList [ ExerciseID ].Info1.InPositionalX  := u;
          SelectedFileList [ ExerciseID ].Info1.InPositionalY  := v;
          SelectedFileList [ ExerciseID ].Info1.InDirectionalX := Sx;
          SelectedFileList [ ExerciseID ].Info1.InDirectionalY := Sy;

         for j:=1 to tabMax do
             for i:=1 to tabMax do SelectedFileList [ ExerciseID ].Info1.InGrid[i,j].Pres  := False;

        end;
  otTestG2 :
        begin
          SelectedFileList [ ExerciseID ].Info1.OutGrid         := t;
          SelectedFileList [ ExerciseID ].Info1.OutPositionalX  := u;
          SelectedFileList [ ExerciseID ].Info1.OutPositionalY  := v;
          SelectedFileList [ ExerciseID ].Info1.OutDirectionalX := Sx;
          SelectedFileList [ ExerciseID ].Info1.OutDirectionalY := Sy;

         for j:=1 to tabMax do
             for i:=1 to tabMax do SelectedFileList [ ExerciseID ].Info1.OutGrid[i,j].Pres  := False;

        end;
 end;

end;

procedure pntInitializePaintBox( PaintBox_ : TPaintBox);
begin
 PaintBox := PaintBox_;
end;

procedure pntInitializeGraphics;
begin
 Kng_im_Left := Kng_im_Left_;
 Kng_im_Right:= Kng_im_Right_;
 Kng_im_Up   := Kng_im_Up_;
 Kng_im_Down := Kng_im_Down_;
 ant_im_Left := ant_im_Left_;
 ant_im_Right:= ant_im_Right_;
 ant_im_Up   := ant_im_Up_;
 ant_im_Down := ant_im_Down_;

 tux_im_Left := tux_im_Left_;
 tux_im_Right:= tux_im_Right_;
 tux_im_Up   := tux_im_Up_;
 tux_im_Down := tux_im_Down_;

 PaintBox    := PaintBox_;
 MainForm    := MainForm_;

 GridMap     := TBitmap.Create;

 GridMap.Height := PaintBox.Height;
 GridMap.Width  := PaintBox.Width;

 pntDrawGrid( GridMap.Canvas );

end;

function pntGridPixelate(GridPixelSize : Integer) : Integer;
begin
   case GridPixelSize of

   15 : Result := 24;
   20 : Result := 18;
   24 : Result := 15;
   36 : Result := 10;
   45 : Result := 8;
   else Result:= 15;

  end;
end;

function pntGridDePixelate(GridSize : Integer; Intrp : TProInterpreter) : Integer;
begin
   if Intrp = piKng then
   case GridSize of
    25 : Result := 15;
    19 : Result := 20;
    16 : Result := 24;
    11 : Result := 36;
     9 : Result := 45;
    else Result:= 24;
   end else
   case GridSize of
    24 : Result := 15;
    18 : Result := 20;
    15 : Result := 24;
    10 : Result := 36;
     8 : Result := 45;
    else Result:= 24;
  end;

end;


procedure pntClearGrid(Grd : TOtherGrid; ExerciseNr : Integer = -1 );
begin
case Grd of
  otTemp   :
        begin
          FillChar(temptable, SizeOf(temptable),0);
          current_i := 1;
          current_j := 1;
          tempsx    := 1;
          tempsy    := 0;
        end;
  otExerciseG1 :
        begin
          FillChar(tb1, SizeOf(tb1),0);
          u1  := 1;
          v1  := 1;
          Sx1 := 1;
          Sy1 := 0;
        end;
  otExerciseG2 :
        begin
          FillChar(tb2, SizeOf(tb2),0);
          u2  := 1;
          v2  := 1;
          Sx2 := 1;
          Sy2 := 0;
        end;
  otTestG1 :
        begin
          FillChar(SelectedFileList [ ExerciseNr ].Info1.InGrid, SizeOf(SelectedFileList [ ExerciseNr ].Info1.InGrid), 0);

          SelectedFileList [ ExerciseNr ].Info1.InPositionalX  := 1;
          SelectedFileList [ ExerciseNr ].Info1.InPositionalY  := 1;
          SelectedFileList [ ExerciseNr ].Info1.InDirectionalX := 1;
          SelectedFileList [ ExerciseNr ].Info1.InDirectionalY := 0;
        end;
  otTestG2 :
        begin
          FillChar(SelectedFileList [ ExerciseNr ].Info1.OutGrid, SizeOf(SelectedFileList [ ExerciseNr ].Info1.OutGrid),0);

          SelectedFileList [ ExerciseNr ].Info1.OutPositionalX  := 1;
          SelectedFileList [ ExerciseNr ].Info1.OutPositionalY  := 1;
          SelectedFileList [ ExerciseNr ].Info1.OutDirectionalX := 1;
          SelectedFileList [ ExerciseNr ].Info1.OutDirectionalY := 0;
        end;
   otPrimary:
        begin
          FillChar(t, SizeOf(t),0);
          u  := 1;
          v  := 1;
          Sx := 1;
          Sy := 0;
        end;
 end;
end;

procedure pntInitializeValues(ClearGrid, AnimalReset : Boolean);
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : pntInitializeValues()');
  DbgPlus;
{$ENDIF}

 if AnimalReset then
  begin
   pntHideInterpreterImages(piKng);
   pntHideInterpreterImages(piAnt);
   pntHideInterpreterImages(piTux);
  end;

 if ClearGrid then
  begin
   pntClearGrid(otPrimary);
  end;

  tt := Integer ( CurrentInterpreter = piKng );

  TabMax:=pntGridPixelate(GridPixelSize);
  TabMax:=TabMax+tt;

   CurrentX :=   + GridPixelSize *(u-1);
   CurrentY :=   + GridPixelSize *(v-1);

 if AnimalReset then
            pntShowAnimal;

{$IFDEF _DEBUG_}
  DbgMinus;
{$ENDIF}
end;


procedure pntShowAnimal;
var left_, right_ : integer;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : pntShowAnimal()');
  DbgPlus;
{$ENDIF}

   case CurrentInterpreter of
    piKng :
     begin
      left_ := PaintBox.Left+CurrentX;
      right_ := PaintBox.Top+CurrentY;
      if watchRight then
       begin
        Kng_im_Right.Left:=left_;
        Kng_im_Right.Top:=right_ - Kng_im_Right.Picture.Height;
        Kng_im_Right.Show;
       end;
      if watchLeft then
       begin
        Kng_im_Left.Left:=left_ - Kng_im_Left.Picture.Width;
        Kng_im_Left.Top:=right_ - Kng_im_Left.Picture.Height;
        Kng_im_Left.Show;
       end;
      if watchUp then
       begin
        Kng_im_Up.Left:=left_ - Kng_im_Up.Picture.Width div 2 + 12;
        Kng_im_Up.Top:=right_ - Kng_im_Up.Picture.Height;
        Kng_im_Up.Show;
       end;
      if watchDown then
       begin
        Kng_im_Down.Left:=left_ - Kng_im_Down.Picture.Width + 2;
        Kng_im_Down.Top:=right_ - Kng_im_Down.Picture.Height;
        Kng_im_Down.Show;
       end;
     end;
    piAnt :
     begin
      left_  := PaintBox.Left+CurrentX;
      right_ := PaintBox.Top+CurrentY;
      if watchRight then
       begin
        Ant_im_Right.Left:=left_ + GridPixelSize div 2 - Ant_im_Right.Picture.Width div 2 + Ant_im_Right.Picture.Width div 4 ;
        Ant_im_Right.Top:=right_ + GridPixelSize div 2 - Ant_im_Right.Picture.Height div 2;
        Ant_im_Right.Show;
       end;
      if watchLeft then
       begin
        Ant_im_Left.Left:=left_ + GridPixelSize div 2 - Ant_im_Left.Picture.Width  div 2 - Ant_im_Left.Picture.Width  div 4;
        Ant_im_Left.Top:=right_ + GridPixelSize div 2 - Ant_im_Left.Picture.Height div 2;
        Ant_im_Left.Show;
       end;
      if watchUp then
       begin
        Ant_im_Up.Left:=left_ + GridPixelSize div 2 - Ant_im_Up.Picture.Width div 2;
        Ant_im_Up.Top:=right_ + GridPixelSize div 2 - Ant_im_Up.Picture.Height div 2 - Ant_im_Up.Picture.Height div 4;
        Ant_im_Up.Show;
       end;
      if watchDown then
       begin
        Ant_im_Down.Left:=left_ + GridPixelSize div 2 - Ant_im_Down.Picture.Width div 2;
        Ant_im_Down.Top:=right_ + GridPixelSize div 2 - Ant_im_Down.Picture.Height div 2 + Ant_im_Down.Picture.Height div 4;
        Ant_im_Down.Show;
       end;
     end;
   piTux :
     begin
      left_  := PaintBox.Left+CurrentX;
      right_ := PaintBox.Top+CurrentY;
      if watchRight then
       begin
        Tux_im_Right.Left:=left_ + GridPixelSize div 2 - Tux_im_Right.Width div 2;
        Tux_im_Right.Top:=right_ + GridPixelSize div 2 - Tux_im_Right.Height div 2;
        Tux_im_Right.Show;
       end;
      if watchLeft then
       begin
        Tux_im_Left.Left:=left_ + GridPixelSize div 2 - Tux_im_Left.Width div 2;
        Tux_im_Left.Top:=right_ + GridPixelSize div 2 - Tux_im_Left.Height div 2;
        Tux_im_Left.Show;
       end;
      if watchUp then
       begin
        Tux_im_Up.Left:=left_ + GridPixelSize div 2 - Tux_im_Up.Width div 2;
        Tux_im_Up.Top:=right_ + GridPixelSize div 2 - Tux_im_Up.Height div 2;
        Tux_im_Up.Show;
       end;
      if watchDown then
       begin
        Tux_im_Down.Left:=left_ + GridPixelSize div 2 - Tux_im_Down.Width div 2;
        Tux_im_Down.Top:=right_ + GridPixelSize div 2 - Tux_im_Down.Height div 2;
        Tux_im_Down.Show;
       end;
     end;
   end;{case}

{$IFDEF _DEBUG_}
  DbgMinus;
{$ENDIF}
end;

procedure DrawUnit;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : DrawUnit()');
  DbgPlus;
{$ENDIF}

   grid_x:=GridPixelSize *(sx);
   grid_y:=GridPixelSize *(sy);

   CurrentX := CurrentX + grid_x;
   CurrentY := CurrentY + grid_y;

{$IFDEF _DEBUG_}
  DbgMinus;
{$ENDIF}
end;


procedure pntDrawGridPoint(Canvas : TCanvas; tx, ty, vx, vy : Integer);
begin
  while Canvas.LockCount>1 do Sleep(thSleepTime);
  Canvas.Lock;

if (CurrentInterpreter = piKng) then
begin
  with Canvas do
   begin
     Pen.Style:=psSolid;
     Pen.Color:=clBlack;

      if t[tx,ty].oriz then
       begin
        MoveTo((tx-1) * GridPixelSize , (ty-1) * GridPixelSize);
        LineTo((tx) * GridPixelSize, (ty-1) * GridPixelSize);
       end;
      if t[tx,ty].vert then
       begin
        MoveTo((tx-1) * GridPixelSize , (ty-1) * GridPixelSize);
        LineTo((tx-1) * GridPixelSize, (ty) * GridPixelSize);
       end;
        MoveTo(0,0);
   end;
end else
if (CurrentInterpreter = piAnt) or (CurrentInterpreter = piTux) then
begin
  with Canvas do
   begin
    Pen.Style:=psDot;
    Pen.Color:=clGray;

       if t[vx, vy].pres then
        begin
          Moveto(GridPixelSize*vx-3,GridPixelSize*vy-3);

          LineTo(GridPixelSize*vx-GridPixelSize+3,GridPixelSize*vy-3);
          LineTo(GridPixelSize*vx-GridPixelSize+3,GridPixelSize*vy-GridPixelSize+3);
          LineTo(GridPixelSize*vx-3,GridPixelSize*vy-GridPixelSize+3);
          LineTo(GridPixelSize*vx-3,GridPixelSize*vy-3);

          Moveto(GridPixelSize*vx-3,GridPixelSize*vy-3);

        end;
     end;   
end;

 Canvas.Unlock;
end;


procedure pntRedrawGridLetter(Canvas : TCanvas; x,y : integer);
begin
  while Canvas.LockCount>1 do Sleep(thSleepTime);
  Canvas.Lock;

 Canvas.Font.Name  := DefaultFont;
 Canvas.Font.Color := LettersColor;
 Canvas.Font.Style := [fsBold];
 Canvas.Font.Size  := GridPixelSize div 2;

 Canvas.TextOut((x-1)*GridPixelSize + GridPixelSize div 2 - Canvas.TextWidth( t[x,y].word) div 2,
                (y-1)*GridPixelSize + GridPixelSize div 2 - Canvas.TextHeight( t[x,y].word) div 2,
                t[x,y].word);

        if t[x,y].Word=Space3 then t[x,y].Word:='';
        
 Canvas.Unlock;
end;



procedure mers( x,y:TTableIndex ; k : integer);

procedure dute;
var
 tx, ty : Integer;
begin
     u:=x+sx; v:=y+sy;
     DrawUnit;
     tx := 0; ty := 0;
     if PenDown then
       case k of
        1,2 :
          if x<u then
           begin
            t[x,y].oriz:=true;
            tx:=x;
            ty:=y;
           end else
           begin
            t[u,v].oriz:=true;
            tx:=u;
            ty:=v;
           end;
        3,4 :
          if y<v then
           begin
            t[x,y].vert:=true;
            tx:=x;
            ty:=y;
           end else
           begin
            t[u,v].vert:=true;
            tx:=u;
            ty:=v;
           end;
       end;

     if ExecutionStarted then t[x,y].pres:=True;
     pntDrawGridPoint(GridMap.Canvas , tx, ty, x, y);
end;

procedure NotError;
begin
 if not ExecutionStarted then exit;
         {$IFDEF _DEBUG_}
          DbgMinus;
           DbgPrint(DbgUname+' : mers() | x:'+DbgInt(x)+'; y:'+DbgInt(y)+'; x+sx:'+DbgInt(x+sx)+' y+sy:'+DbgInt(y+sy)+'; x+sx*2:'+
                    DbgInt(x+sx*2)+' y+sy*2:'+DbgInt(y+sy*2)+'; t[x,y].word:'+t[x,y].Word+'; t[x+sx,y+sy].word:'+t[x+sx,y+sy].Word+
                                            '; t[x+sx*2,y+sy*2].word:'+t[x+sx*2,y+sy*2].Word);
           DbgPlus;
         {$ENDIF}
   KillThreadFlag:=True;
   stxError(ERR_0x0A,'','', CurrentLine, CurrentStart, CurrentEnd, esRuntime, $0A);
end;

begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : mers(x:'+DbgInt(x)+'; y:'+DbgInt(y)+'; k:'+DbgInt(k)+')');
  DbgPlus;
{$ENDIF}

 if posible(x,y) then
  begin
  case CurrentInterpreter of
   piAnt :
    begin
     if Gol(t[x+sx,y+sy].word) or Gol(t[x+sx+sx,y+sy+sy].word) then
      begin
       if Gol(t[x+sx,y+sy].word) or posible(x+sx,y+sy) then
        begin
         if (not Gol(t[x+sx,y+sy].word)) and ((Gol(t[x+sx+sx,y+sy+sy].word))) then
          begin
           t[x+sx+sx,y+sy+sy].word :=t[x+sx,y+sy].word;
           t[x+sx,y+sy].word := Space3;

           pntRedrawGridLetter(GridMap.Canvas, x+sx+sx, y+sy+sy);
           pntRedrawGridLetter(GridMap.Canvas, x+sx, y+sy);
          end;
         dute;
        end else NotError;
      end else
         begin

           NotError;
         end;
    end;
   piKng :
    begin
      dute;
    end;
   piTux :
    begin
     dute;
    end;
  end; {case}
  end else
         begin
           NotError;
         end;
{$IFDEF _DEBUG_}
  DbgMinus;
{$ENDIF}
end;

function posible( x_,y_:integer):boolean;
var lx,ly :integer;
begin
 lx:=x_+sx; ly:=y_+sy;
 if (lx in [1..TabMax]) and (ly in [1..TabMax])
  then result:=true
  else result:=false;
end;

function pntConditionIsLine:boolean;
begin
 Result:=false;
 if watchLeft  then begin result:= t[u+sx,v+sy].vert or t[u+sx+sx,v+sy+sy].oriz or t[u+sx+sy,v+sx+sy].vert; end else
 if watchRight then begin result:= t[u+sx,v+sy].vert or t[u+sx,v+sy].oriz or t[u+sx+sy,v-sx-sy].vert; end else
 if watchUp    then begin result:= t[u+sx,v+sy].oriz or t[u+sx+sx,v+sy+sy].vert or t[u+sx+sy,v+sx+sy].oriz; end else
 if watchDown  then begin result:= t[u+sx,v+sy].oriz or t[u+sx,v+sy].vert or t[u-sx-sy,v+sx+sy].oriz; end
{$IFDEF _DEBUG_}
  else DbgPrint(DbgUName+' : _kng_Is_Line ==> FATAL : This error should never appear !!!!! No watch position is correct !');
 {$ELSE}
  ;
{$ENDIF}
end;

function pntConditionIsNotLine:boolean;
begin
 result:=not( pntConditionIsLine);
end;

function pntConditionIsBorder:boolean;
begin
 result:=not(posible(u,v));
end;

function pntConditionIsNotBorder:boolean;
begin
 result:=posible(u,v);
end;

procedure pntDrawTableAgain(Canvas : TCanvas);
var i,j     : integer;
    ix,iy   : integer;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : pntDrawTableAgain()');
  DbgPlus;
{$ENDIF}

{$IFDEF _DEBUG_}
  DbgMinus;
  if Canvas.LockCount>1 then
       DbgPrint(DbgUName+' : pntDrawTableAgain() | CANVAS COLLISION , WAITING ...');
  DbgPlus;
{$ENDIF}

  While (Canvas.LockCount > 1) do
   begin

{$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : pntDrawTableAgain() | LOCK WAIT');
   DbgPlus;
{$ENDIF}

     Sleep(thSleepTime);
   end;

 Canvas.Lock;

with Canvas do
 begin
 if CurrentInterpreter = piKng then
  begin
   Pen.Style:=psSolid;
   Pen.Color:=clBlack;
   iy:=0;
   for j:=1 to tabMax do
    begin
     ix:=0;  MoveTo(ix,iy);
     for i:=1 to tabMax do
      begin
       if t[i,j].oriz then LineTo(ix+GridPixelSize,iy)
                      else MoveTo(ix+GridPixelSize,iy);
       ix:=ix+GridPixelSize;
      end;
      iy:=iy+GridPixelSize;
    end;
   MoveTo(0,0);

   ix:=0;
   for i:=1 to tabMax do
    begin
     iy:=0; MoveTo(ix,iy);
     for j:=1 to tabMax do
      begin
       if t[i,j].vert then LineTo(ix,iy+GridPixelSize)
                      else MoveTo(ix,iy+GridPixelSize);
       iy:=iy+GridPixelSize;
      end;
      ix:=ix+GridPixelSize;
    end;
   MoveTo(CurrentX,CurrentY);
  end;
  {pentru ant urme:}
  if (CurrentInterpreter = piAnt) or (CurrentInterpreter = piTux) then
   begin
    Pen.Style:=psDot;
    Pen.Color:=clGray;
    for i:=1 to tabMAx do
     for j:=1 to TabMAx do
      begin
       if t[i,j].pres then
        begin
          Moveto(GridPixelSize*i-3,GridPixelSize*j-3);

          LineTo(GridPixelSize*i-GridPixelSize+3,GridPixelSize*j-3);
          LineTo(GridPixelSize*i-GridPixelSize+3,GridPixelSize*j-GridPixelSize+3);
          LineTo(GridPixelSize*i-3,GridPixelSize*j-GridPixelSize+3);
          LineTo(GridPixelSize*i-3,GridPixelSize*j-3);

          Moveto(GridPixelSize*i-3,GridPixelSize*j-3);

        end;

     {Litera}
{$IFDEF _DEBUG_}
   DbgMinus;
    if t[i,j].Word<>'' then
   DbgPrint(DbgUName+' : pntDrawTableAgain | Draw Letter = "'+t[i,j].Word+'" at t['+DbgInt(i)+':'+DbgInt(j)+']');
   DbgPlus;
{$ENDIF}


       Canvas.Font.Name  := DefaultFont;
       Canvas.Font.Color := LettersColor;
       Canvas.Font.Style := [fsBold];
       Canvas.Font.Size  := GridPixelSize div 2;

       Canvas.TextOut((i-1)*GridPixelSize + GridPixelSize div 2 - Canvas.TextWidth( t[i,j].word) div 2,
                      (j-1)*GridPixelSize + GridPixelSize div 2 - Canvas.TextHeight( t[i,j].word) div 2,
                      t[i,j].word);

       if t[i,j].Word=Space3 then t[i,j].Word:='';

      end;
   end;
 end;

 Canvas.UnLock;

{$IFDEF _DEBUG_}
  DbgMinus;
{$ENDIF}
end;

function pntCorrectDirectionals(Sx, Sy : Integer) : Boolean;
begin
   if( ( Sx = 0)  and  (Sy = 1)) or
     ( ( Sx = -1) and  (Sy = 0)) or
     ( ( Sx = 0)  and (Sy = -1)) or
     ( ( Sx = 1)  and (Sy = 0) ) then
      Result := True else Result := False;
end;

function watchLeft:boolean;
begin
 if (sx = -1) and (sy = 0) then result:= true else result:=false;
end;

function watchRight:boolean;
begin
 if (sx = 1) and (sy = 0) then result:= true else result:=false;
end;

function watchUp:boolean;
begin
 if (sx = 0) and (sy = -1) then result:= true else result:=false;
end;

function watchDown:boolean;
begin
 if (sx = 0) and (sy = 1) then result:= true else result:=false;
end;

procedure MoveLeft;
begin
  mers(u,v,1);
  pntShowAnimal;
end;

procedure MoveRight;
begin
  mers(u,v,2);
  pntShowAnimal;
end;

procedure MoveUp;
begin
  mers(u,v,3);
  pntShowAnimal;
end;

procedure MoveDown;
begin
  mers(u,v,4);
  pntShowAnimal;
end;

procedure Pas;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : Pas()');
  DbgPlus;
{$ENDIF}

 if watchLeft then MoveLeft;
 if watchRight then MoveRight;
 if watchUp then MoveUp;
 if watchDown then MoveDown;

 pntShowAnimal;


{$IFDEF _DEBUG_}
  DbgMinus;
{$ENDIF}
end;

procedure pntStepTux;
begin
  PenDown:=True;
  PenUp:=False;
  Pas;
end;

procedure pntRotateTux;
begin
  Rotate;
  pntHideInterpreterImages(piTux);
  pntShowAnimal;
end;

procedure pntLeftAnt;
begin
 RotateLeft;
 pntHideInterpreterImages(piAnt);
 MoveLeft;
end;

procedure pntRightAnt;
begin
 RotateRight;
 pntHideInterpreterImages(piAnt);
 MoveRight;
end;

procedure pntUpAnt;
begin
 RotateUp;
 pntHideInterpreterImages(piAnt);
 MoveUp;
end;

procedure pntDownAnt;
begin
 RotateDown;
 pntHideInterpreterImages(piAnt);
 MoveDown;
end;

procedure pntRotateAnt;
begin
   pntHideInterpreterImages(piAnt);
   Rotate;
end;

procedure pntStepKng;
begin
  PenDown:=True;
  PenUp:=False;
  pas;
end;

procedure pntJumpKng;
begin
  PenDown:=False;
  PenUp:=True;
  Pas;
end;

procedure pntRotateKng;
begin
  Rotate;
  pntHideInterpreterImages(piKng);
  pntShowAnimal;
end;

procedure RotateLeft;
begin sx:=-1; sy:=0; end;

procedure RotateRight;
begin sx:=1; sy:=0; end;

procedure RotateUp;
begin sx:=0; sy:=-1; end;

procedure RotateDown;
begin sx:=0; sy:=1; end;

procedure Rotate;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : Rotate()');
  DbgPlus;
{$ENDIF}

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : Rotate() | WatchLeft:'+DbgBool(watchLeft)+'; WatchRight:'+DbgBool(watchRight)+'; WatchUp:'+DbgBool(watchUp)
                                   +'; WatchDown:'+DbgBool(watchDown));
  DbgPlus;
{$ENDIF}

 if watchLeft  then RotateUp else
 if watchRight then RotateDown else
 if watchUp    then RotateRight else
 if watchDown  then RotateLeft;

{$IFDEF _DEBUG_}
  DbgMinus;
{$ENDIF}
end;

procedure pntDrawGrid( Canvas : TCanvas );
var  px,py:LongInt;

begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : pntDrawDDGrid()');
  DbgPlus;
{$ENDIF}

{$IFDEF _DEBUG_}
  DbgMinus;
  if Canvas.LockCount>1 then
       DbgPrint(DbgUName+' : pntDrawGrid() | CANVAS COLLISION , WAITING ...');
  DbgPlus;
{$ENDIF}

  While (Canvas.LockCount > 1) do
   begin

{$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : pntDrawGrid() | LOCK WAIT');
   DbgPlus;
{$ENDIF}

     Sleep(thSleepTime);
   end;

   Canvas.Lock;

   Canvas.Pen.Style:=psClear;
   Canvas.Brush.Style:=bsSolid;
   Canvas.Brush.Color:=clBtnFace;
   Canvas.Rectangle(0,0,PaintBox.Width,PaintBox.Height);

   Canvas.Pen.Color:=clMedGray;
   Canvas.Pen.Style:=psDot;

   px:=0;

   Canvas.MoveTo(0,0);
   while Px <= PaintBox.Height do
    begin
     Canvas.LineTo(PaintBox.Height,px);
     px:=px+GridPixelSize;
     Canvas.MoveTo(0,px);
    end;

   py:=0;
   Canvas.MoveTo(0,0);
   while py<=PaintBox.Width do
    begin
     Canvas.LineTo(py,PaintBox.Width);
     py:=py+GridPixelSize;
     Canvas.MoveTo(py,0);
    end;
   Canvas.MoveTo(0,0);

  Canvas.UnLock;

{$IFDEF _DEBUG_}
  DbgMinus;
{$ENDIF}
end;


procedure SetImageStatus( InterpreterID : TProInterpreter; Watch : TWachStatus; Visible : Boolean);
begin

 case InterpreterID of
  piKng : begin
          case Watch of
           wtchLeft  : Kng_im_Left.Visible:=Visible;
           wtchRight : Kng_im_Right.Visible:=Visible;
           wtchUp    : Kng_im_Up.Visible:=Visible;
           wtchDown  : Kng_im_Down.Visible:=Visible;
          end;
        end;

  piAnt : begin
          case Watch of
           wtchLeft  : ant_im_Left.Visible:=Visible;
           wtchRight : ant_im_Right.Visible:=Visible;
           wtchUp    : ant_im_Up.Visible:=Visible;
           wtchDown  : ant_im_Down.Visible:=Visible;
          end;
        end;

  piTux : begin
          case Watch of
           wtchLeft  : tux_im_Left.Visible:=Visible;
           wtchRight : tux_im_Right.Visible:=Visible;
           wtchUp    : tux_im_Up.Visible:=Visible;
           wtchDown  : tux_im_Down.Visible:=Visible;
          end;
        end;
 end;
end;

procedure pntHideInterpreterImages( InterpreterID : TProInterpreter );
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : pntHideInterpreterImages(IntrepreterID:'+DbgInt(Ord(InterpreterID))+')');
  DbgPlus;
{$ENDIF}

 SetImageStatus( InterpreterID, wtchUp    , False);
 SetImageStatus( InterpreterID, wtchDown  , False);
 SetImageStatus( InterpreterID, wtchLeft  , False);
 SetImageStatus( InterpreterID, wtchRight , False);

{$IFDEF _DEBUG_}
  DbgMinus;
{$ENDIF}
end;

function pntGetAnimalOrientation(Grd : TOtherGrid; ExerciseNr : Integer = -1 ) : Integer;
var
 iSx, iSy : Integer;

begin
   iSx := 0;
   iSy := 0;
case Grd of
 otTemp   :
        begin
           iSx := tempsx;
           iSy := tempsy;
        end;

  otExerciseG1 :
        begin
          iSx := Sx1;
          iSy := Sy1;
        end;

  otExerciseG2 :
        begin
          iSx := Sx2;
          iSy := Sy2;
        end;

  otTestG1 :
        begin
          iSx := SelectedFileList [ ExerciseNr ].Info1.InDirectionalX;
          iSy := SelectedFileList [ ExerciseNr ].Info1.InDirectionalY;
        end;

  otTestG2 :
        begin
          iSx := SelectedFileList [ ExerciseNr ].Info1.OutDirectionalX;
          iSy := SelectedFileList [ ExerciseNr ].Info1.OutDirectionalY;
        end;

  otPrimary :
        begin
          iSx := Sx;
          iSy := Sy;
        end;
     end;

 Result:=2;
 if (iSx = -1) and (iSy = 0) then Result := 2;
 if (iSx = 1)  and (iSy = 0) then Result := 4;
 if (iSx = 0) and (iSy = -1) then Result := 3;
 if (iSx = 0)  and (iSy = 1) then Result := 1;

 end;

procedure pntSetAnimalOrientation(OrX : Integer; Grd : TOtherGrid; ExerciseNr : Integer = -1 );
var
 iSx, iSy : Integer;
begin

  Case OrX of
  1: begin iSx := 0;  iSy := 1; end;
  2: begin iSx := -1; iSy := 0; end;
  3: begin iSx := 0; iSy := -1; end;
  4: begin iSx := 1;  iSy := 0; end;
  else begin iSx:=0; iSy:=1; end;
 end;


case Grd of
 otTemp   :
        begin
           tempsx  := iSx;
           tempsy  := iSy;
        end;

  otExerciseG1 :
        begin
          Sx1 := iSx;
          Sy1 := iSy;
        end;

  otExerciseG2 :
        begin
          Sx2 := iSx;
          Sy2 := iSy;
        end;

  otTestG1 :
        begin
          SelectedFileList [ ExerciseNr ].Info1.InDirectionalX := iSx;
          SelectedFileList [ ExerciseNr ].Info1.InDirectionalY := iSy;
        end;

  otTestG2 :
        begin
          SelectedFileList [ ExerciseNr ].Info1.OutDirectionalX := iSx;
          SelectedFileList [ ExerciseNr ].Info1.OutDirectionalY := iSy;
        end;

  otPrimary :
        begin
          Sx := iSx;
          Sy := iSy;
        end;
     end;
end;



procedure pntRedrawTable();
begin
  while PaintBox.Canvas.LockCount>1 do Sleep(thSleepTime);
  PaintBox.Canvas.Lock;

  while GridMap.Canvas.LockCount>1 do Sleep(thSleepTime);
  GridMap.Canvas.Lock;


  PaintBox.Canvas.Draw(0,0,GridMap);
  pntShowAnimal;

  GridMap.Canvas.UnLock;
  PaintBox.Canvas.UnLock;
end;

initialization
 current_i:=1;
 current_j:=1;
 tempsx:=1;
 tempsy:=0;
 t[1,1].Pres:=false;

end.
