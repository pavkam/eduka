(*


The Original Code is: PrnExpt.pas, released 2005-02-02.
Authors of this file is Ciobanu Alexander and Popov John. All Rights Reserved.

   Description : Printer and Exporting support.
   
*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit PrnExpt;
interface
Uses Windows, Forms, SynCompletionProposal, SynEditPrint, SynEdit, SynEditHighlighter,
     SynHighlighterGeneral, SynProSyn, SynEdukaExportHTML, ProTypes, Dialogs,
     {}
     ComCtrls,Jpeg, Graphics, SysUtils, Types, Printers,
     ExtCtrls, Controls, Classes;

Type 
PPalEntriesArray = ^TPalEntriesArray; {for palette re-construction}
TPalEntriesArray = array[0..0] of TPaletteEntry;

procedure pxtPrintCodePage();
procedure pxtExportCodePage(iFileName : String);

procedure pxtPrintExercisePage();
procedure pxtExportExercisePage(iFileName : String);

procedure pxtPrintTestPage();
procedure pxtExportTestPage(iFileName : String);


var
 LandColor_1 ,
 LandColor_2 ,
 LandColor_3 : string;

    TempRichEdit : TRichEdit;
           ImageDir : string;
       ImageDirName : string;
           FileName : string;
           FileDir  : string;
   imNameB, imNameE : string;
   
         TestDir,  cTestDir : string;

  ////////////////////////////////////////////////
implementation
uses Main,
   EditorFuncs,Translate, Movement, DesignInside, Version;

(*
 Aceasta procedura este strinsa din movement cu unele modificari
 pentru desenarea imaginii din grid
*)
procedure GetGridBitmap(Grid:TProTable;bBmap : TBitMap; MyBitMap : TBitMap;  tu,tv,tsx,tsy:integer; NIP : TProInterpreter);
{$IFNDEF _TRIAL_}
var pBox  : TPaintBox;
   pbRect : TRect;
    px,py : integer;
    i,j   : integer;
    ix,iy : integer;
    left_, right_ : integer;
    anime : TImage;
    ax,ay : integer;
{$ENDIF}    

begin
{$IFNDEF _TRIAL_}
 anime:=TImage.Create(MainEdukaForm);
 
 anime.Hide;
 anime.Transparent:=true;

 MyBitMap.Canvas.FillRect(Rect(0,0,MainEdukaForm.Bevel.Height,MainEdukaForm.Bevel.Width));
 bBmap.Canvas.FillRect(Rect(0,0,MainEdukaForm.PaintBox.Height,MainEdukaForm.PaintBox.Width));

 MyBitMap.Height := MainEdukaForm.Bevel.Height;
 MyBitMap.Width  := MainEdukaForm.Bevel.Width;

 pBox := TPaintBox.Create(MainEdukaForm);
 pBox.Parent := MainEdukaForm;
 pBox.Height := MainEdukaForm.PaintBox.Height;
 pBox.Width  := MainEdukaForm.PaintBox.Width;
 pBox.Left   := 0;
 pBox.Top    := 0;

 pbRect := Rect(pBox.Left, pBox.Top, pBox.Width, pBox.Height);

 bBmap.Width := pBox.Width;
 bBmap.Height := pBox.Height;
 bBmap.Canvas.CopyRect(pbRect, pBox.Canvas, pbRect);


 with bBmap do
  begin
   Canvas.Pen.Style:=psClear;
   Canvas.Brush.Style:=bsSolid;
   Canvas.Brush.Color:=clWhite;
   Canvas.Rectangle(0,0,bBmap.Width,bBmap.Height);

   Canvas.Pen.Color:=clMedGray;
   Canvas.Pen.Style:=psDot;

   px:=0;
   Canvas.MoveTo(0,0);
   while px<=bBmap.Height do
    begin
     bBmap.Canvas.LineTo( bBmap.Height,px);
     px:=px+GridPixelSize;
     bBmap.Canvas.MoveTo(0,px);
    end;

   py:=0;
   Canvas.MoveTo(0,0);
   while py<=bBmap.Width do
    begin
     bBmap.Canvas.LineTo(py,bBmap.Width);
     py:=py+GridPixelSize;
     bBmap.Canvas.MoveTo(py,0);
    end;
   Canvas.MoveTo(0,0);
  end;
  ///////////////////////////////////////////////////////////////////////////////////////

with bBmap.Canvas do
 begin
 if NIP = piKng then
  begin
   Pen.Style:=psSolid;
   Pen.Color:=clBlack;
   iy:=0;
   for j:=1 to tabMax do
    begin
     ix:=0;  MoveTo(ix,iy);
     for i:=1 to tabMax do
      begin
       if Grid[i,j].oriz then LineTo(ix+GridPixelSize,iy)
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
       if Grid[i,j].vert then LineTo(ix,iy+GridPixelSize)
                      else MoveTo(ix,iy+GridPixelSize);
       iy:=iy+GridPixelSize;
      end;
      ix:=ix+GridPixelSize;
    end;
   MoveTo(CurrentX,CurrentY);
  end;
  {pentru ant urme:}
  if (NIP = piAnt) or (NIP = piTux) then
   begin
    Pen.Style:=psDot;
    Pen.Color:=clMedGray;
    for i:=1 to TabMAx do
     for j:=1 to TabMAx do
      begin
       if Grid[i,j].pres then
        begin
          Moveto(GridPixelSize*i-3,GridPixelSize*j-3);

          LineTo(GridPixelSize*i-GridPixelSize+3,GridPixelSize*j-3);
          LineTo(GridPixelSize*i-GridPixelSize+3,GridPixelSize*j-GridPixelSize+3);
          LineTo(GridPixelSize*i-3,GridPixelSize*j-GridPixelSize+3);
          LineTo(GridPixelSize*i-3,GridPixelSize*j-3);

          Moveto(GridPixelSize*i-3,GridPixelSize*j-3);
        end;
   {litere}
        bBmap.Canvas.Font.Color := LettersColor;
        bBmap.Canvas.Font.Name  := DefaultFont;
        bBmap.Canvas.Font.Style := [fsBold];
        bBmap.Canvas.Font.Size  := GridPixelSize div 2;

        bBmap.Canvas.TextOut(i*GridPixelSize - GridPixelSize + GridPixelSize div 2 - bBmap.Canvas.TextWidth( Grid[i,j].word) div 2 + pBox.Left,
        j*GridPixelSize-GridPixelSize + GridPixelSize div 2 - bBmap.Canvas.TextHeight( Grid[i,j].word) div 2 + pBox.Top, Grid[i,j].word);

        if Grid[i,j].Word=Space3 then Grid[i,j].Word:='';
      end;
   end;
 end;
  ///////////////////////////////////////////////////////////////////////////////////////////
  MyBitMap.Canvas.CopyRect(Rect(MainEdukaForm.PaintBox.Left - MainEdukaForm.Bevel.Left,
                             MainEdukaForm.PaintBox.Top - MainEdukaForm.Bevel.Top,
                             MainEdukaForm.PaintBox.Left - MainEdukaForm.Bevel.Left + MainEdukaForm.PaintBox.Width,
                             MainEdukaForm.PaintBox.Top - MainEdukaForm.Bevel.Top + MainEdukaForm.PaintBox.Height),
                        bBmap.Canvas,
                        Rect(0,0,bBmap.Width, bBmap.Height) );
  ////////////////////////////////////////////////////////////////////////////////////////
   anime.Center:=true;
   anime.AutoSize:=false;

     ax:=GridPixelSize *(tu-1);
     ay:=GridPixelSize *(tv-1);

 with MainEdukaForm  do
  case NIP of
    piKng :
     begin
      left_ := pBox.Left + aX;
      right_ := pBox.Top + aY;
      if (tsx = 1) and (tsy = 0) then
       begin
        anime.Left:=left_;
        anime.Top:=right_ - Kng_im_Right.Picture.Height;
        anime.Picture.Graphic :=  Kng_im_Right.Picture.Graphic;
       end;
      if (tsx = -1) and (tsy = 0) then
       begin
        anime.Left:=left_ - Kng_im_Left.Picture.Width;
        anime.Top:=right_ - Kng_im_Left.Picture.Height;
        anime.Picture.Graphic :=  Kng_im_Left.Picture.Graphic;
       end;
      if (tsx = 0) and (tsy = -1) then
       begin
        anime.Left:=left_ - Kng_im_Up.Picture.Width div 2 + 12;
        anime.Top:=right_ - Kng_im_Up.Picture.Height;
        anime.Picture.Graphic :=  Kng_im_Up.Picture.Graphic;
       end;
      if (tsx = 0) and (tsy = 1) then
       begin
        anime.Left:=left_ - Kng_im_Down.Picture.Width + 2;
        anime.Top:=right_ - Kng_im_Down.Picture.Height;
        anime.Picture.Graphic :=  Kng_im_Down.Picture.Graphic;
       end;
     end;
    piAnt :
     begin
      left_  := pBox.Left+aX;
      right_ := pBox.Top+aY;
      if (tsx = 1) and (tsy = 0) then
       begin
        anime.Left:=left_ + GridPixelSize div 2 - Ant_im_Right.Picture.Width div 2 + Ant_im_Right.Picture.Width div 4 ;
        anime.Top:=right_ + GridPixelSize div 2 - Ant_im_Right.Picture.Height div 2;
        anime.Picture.Graphic :=  Ant_im_Right.Picture.Graphic;
       end;
      if (tsx = -1) and (tsy = 0) then
       begin
        anime.Left:=left_ + GridPixelSize div 2 - Ant_im_Left.Picture.Width div 2 - Ant_im_Left.Picture.Width  div 4;
        anime.Top:=right_ + GridPixelSize div 2 - Ant_im_Left.Picture.Height div 2;
        anime.Picture.Graphic :=  Ant_im_Left.Picture.Graphic;
       end;
      if (tsx = 0) and (tsy = -1) then
       begin
        anime.Left:=left_ + GridPixelSize div 2 - Ant_im_Up.Picture.Width div 2;
        anime.Top:=right_ + GridPixelSize div 2 - Ant_im_Up.Picture.Height div 2 - Ant_im_Up.Picture.Height div 4;
        anime.Picture.Graphic :=  Ant_im_Up.Picture.Graphic;
       end;
      if (tsx = 0) and (tsy = 1) then
       begin
        anime.Left:=left_ + GridPixelSize div 2 - Ant_im_Down.Picture.Width div 2;
        anime.Top:=right_ + GridPixelSize div 2 - Ant_im_Down.Picture.Height div 2+ Ant_im_Down.Picture.Height div 4;
        anime.Picture.Graphic :=  Ant_im_Down.Picture.Graphic;
       end;
     end;
   piTux :
     begin
      left_  := pBox.Left+aX;
      right_ := pBox.Top+aY;
      if (tsx = 1) and (tsy = 0) then
       begin
        anime.Left:=left_ + GridPixelSize div 2 - Tux_im_Right.Width div 2 ;
        anime.Top:=right_ + GridPixelSize div 2 - Tux_im_Right.Height div 2;
        anime.Picture.Graphic :=  Tux_im_Right.Picture.Graphic;
       end;
      if (tsx = -1) and (tsy = 0) then
       begin
        anime.Left:=left_ + GridPixelSize div 2 - Tux_im_Left.Width div 2;
        anime.Top:=right_ + GridPixelSize div 2 - Tux_im_Left.Height div 2;
        anime.Picture.Graphic :=  Tux_im_Left.Picture.Graphic;
       end;
      if (tsx = 0) and (tsy = -1) then
       begin
        anime.Left:=left_ + GridPixelSize div 2 - Tux_im_Up.Width div 2;
        anime.Top:=right_ + GridPixelSize div 2 - Tux_im_Up.Height div 2;
        anime.Picture.Graphic :=  Tux_im_Up.Picture.Graphic;
       end;
      if (tsx = 0) and (tsy = 1) then
       begin
        anime.Left:=left_ + GridPixelSize div 2 - Tux_im_Down.Width div 2;
        anime.Top:=right_ + GridPixelSize div 2 - Tux_im_Down.Height div 2;
        anime.Picture.Graphic :=  Tux_im_Down.Picture.Graphic;
       end;
     end;
   end;

  MyBitMap.Canvas.Draw(anime.Left+MainEdukaForm.PaintBox.Left - MainEdukaForm.Bevel.Left,
                    anime.Top+MainEdukaForm.PaintBox.Top - MainEdukaForm.Bevel.Top,
                    anime.Picture.Graphic);
  ////////////////////////////////////////////////////////////////////////////////////////

  pBox.Free;
  anime.Free;
 {$ENDIF} 
end;

procedure BltTBitmapAsDib(DestDc : hdc;      {Handle of where to blt}
                               x : word;     {Bit at x}
                               y : word;     {Blt at y}
                           Width : word;     {Width to stretch}
                          Height : word;     {Height to stretch}
                              bm : TBitmap); {the TBitmap to Blt}
var
        OriginalWidth : LongInt;     {width of BM}
                   dc : hdc;         {screen dc}
      IsPaletteDevice : bool;        {if the device uses palettes}
  IsDestPaletteDevice : bool;        {if the device uses palettes}
       BitmapInfoSize : integer;     {sizeof the bitmapinfoheader}
         lpBitmapInfo : PBitmapInfo; {the bitmap info header}
                  hBm : hBitmap;     {handle to the bitmap}
                 hPal : hPalette;    {handle to the palette}
               OldPal : hPalette;    {temp palette}
                hBits : THandle;     {handle to the DIB bits}
                pBits : pointer;     {pointer to the DIB bits}
    lPPalEntriesArray : PPalEntriesArray; {palette entry array}
        NumPalEntries : integer;     {number of palette entries}
                    i : integer;     {looping variable}
begin
  {If range checking is on - lets turn it off for now}
  {we will remember if range checking was on by defining}
  {a define called CKRANGE if range checking is on.}
  {We do this to access array members past the arrays}
  {defined index range without causing a range check}
  {error at runtime. To satisfy the compiler, we must}
  {also access the indexes with a variable. ie: if we}
  {have an array defined as a: array[0..0] of byte,}
  {and an integer i, we can now access a[3] by setting}
  {i := 3; and then accessing a[i] without error}
  {$IFOPT R+}
  {$DEFINE CKRANGE}
  {$R-}
  {$ENDIF}

  {Save the original width of the bitmap}
  OriginalWidth := bm.Width;

  {Get the screen's dc to use since memory dc's are not reliable}
  dc := GetDc(0);
  {Are we a palette device?}
  IsPaletteDevice :=
  GetDeviceCaps(dc, RASTERCAPS) and RC_PALETTE = RC_PALETTE;
  {Give back the screen dc}
  ReleaseDc(0, dc);

 {Allocate the BitmapInfo structure}
 if IsPaletteDevice then BitmapInfoSize := sizeof(TBitmapInfo) + (sizeof(TRGBQUAD) * 255)
                    else BitmapInfoSize := sizeof(TBitmapInfo);
 GetMem(lpBitmapInfo, BitmapInfoSize);

 {Zero out the BitmapInfo structure}
 FillChar(lpBitmapInfo^, BitmapInfoSize, #0);

 {Fill in the BitmapInfo structure}
  lpBitmapInfo^.bmiHeader.biSize := sizeof(TBitmapInfoHeader);
  lpBitmapInfo^.bmiHeader.biWidth := OriginalWidth;
  lpBitmapInfo^.bmiHeader.biHeight := bm.Height;
  lpBitmapInfo^.bmiHeader.biPlanes := 1;

  if IsPaletteDevice then lpBitmapInfo^.bmiHeader.biBitCount := 8
                     else lpBitmapInfo^.bmiHeader.biBitCount := 24;

  lpBitmapInfo^.bmiHeader.biCompression := BI_RGB;
  lpBitmapInfo^.bmiHeader.biSizeImage :=
  ((lpBitmapInfo^.bmiHeader.biWidth *
  longint(lpBitmapInfo^.bmiHeader.biBitCount)) div 8) *
  lpBitmapInfo^.bmiHeader.biHeight;
  lpBitmapInfo^.bmiHeader.biXPelsPerMeter := 0;
  lpBitmapInfo^.bmiHeader.biYPelsPerMeter := 0;

  if IsPaletteDevice then
   begin
    lpBitmapInfo^.bmiHeader.biClrUsed := 256;
    lpBitmapInfo^.bmiHeader.biClrImportant := 256;
   end else
   begin
    lpBitmapInfo^.bmiHeader.biClrUsed := 0;
    lpBitmapInfo^.bmiHeader.biClrImportant := 0;
   end;

  {Take ownership of the bitmap handle and palette}
  hBm := bm.ReleaseHandle;
  hPal := bm.ReleasePalette;
  OldPal := 0;
  {Get the screen's dc to use since memory dc's are not reliable}
  dc := GetDc(0);

  if IsPaletteDevice then
   begin
    {If we are using a palette, it must be}
    {selected into the dc during the conversion}
    OldPal := SelectPalette(dc, hPal, TRUE);
    {Realize the palette}
    RealizePalette(dc);
   end;

  {Tell GetDiBits to fill in the rest of the bitmap info structure}
  GetDiBits(dc, hBm, 0, lpBitmapInfo^.bmiHeader.biHeight, nil,
            TBitmapInfo(lpBitmapInfo^), DIB_RGB_COLORS);

  {Allocate memory for the Bits}
  hBits := GlobalAlloc(GMEM_MOVEABLE,
  lpBitmapInfo^.bmiHeader.biSizeImage);
  pBits := GlobalLock(hBits);
  {Get the bits}
  GetDiBits(dc, hBm, 0, lpBitmapInfo^.bmiHeader.biHeight, pBits,
            TBitmapInfo(lpBitmapInfo^), DIB_RGB_COLORS);


  if IsPaletteDevice then
    begin
      {Lets fix up the color table for buggy video drivers}
      GetMem(lPPalEntriesArray, sizeof(TPaletteEntry) * 256);
      {$IFDEF VER100}
      NumPalEntries := GetPaletteEntries(hPal, 0, 256, lPPalEntriesArray^);
      {$ELSE}
      NumPalEntries := GetSystemPaletteEntries(dc, 0, 256, lPPalEntriesArray^);
      {$ENDIF}
      for i := 0 to (NumPalEntries - 1) do
        begin
          lpBitmapInfo^.bmiColors[i].rgbRed := lPPalEntriesArray^[i].peRed;
          lpBitmapInfo^.bmiColors[i].rgbGreen := lPPalEntriesArray^[i].peGreen;
          lpBitmapInfo^.bmiColors[i].rgbBlue := lPPalEntriesArray^[i].peBlue;
        end;
      FreeMem(lPPalEntriesArray, sizeof(TPaletteEntry) * 256);
    end;

  if IsPaletteDevice then
    begin
      {Select the old palette back in}
      SelectPalette(dc, OldPal, TRUE);
      {Realize the old palette}
      RealizePalette(dc);
    end;

  {Give back the screen dc}
  ReleaseDc(0, dc);

  {Is the Dest dc a palette device?}
  IsDestPaletteDevice := GetDeviceCaps(DestDc, RASTERCAPS) and RC_PALETTE = RC_PALETTE;


  if IsPaletteDevice then
    begin
      {If we are using a palette, it must be}
      {selected into the dc during the conversion}
      OldPal := SelectPalette(DestDc, hPal, TRUE);
      {Realize the palette}
      RealizePalette(DestDc);
    end;

  {Do the blt}
  StretchDiBits(DestDc, x, y, Width, Height, 0, 0, OriginalWidth,
       lpBitmapInfo^.bmiHeader.biHeight, pBits, lpBitmapInfo^, DIB_RGB_COLORS, SrcCopy);

  if IsDestPaletteDevice then
    begin
      {Select the old palette back in}
      SelectPalette(DestDc, OldPal, TRUE);
      {Realize the old palette}
      RealizePalette(DestDc);
    end;

  {De-Allocate the Dib Bits}
  GlobalUnLock(hBits);
  GlobalFree(hBits);

  {De-Allocate the BitmapInfo}
  FreeMem(lpBitmapInfo, BitmapInfoSize);

  {Set the ownership of the bimap handles back to the bitmap}
  bm.Handle := hBm;
  bm.Palette := hPal;

{Turn range checking back on if it was on when we started}
{$IFDEF CKRANGE}
{$UNDEF CKRANGE}
{$R+}
{$ENDIF}
end;

function iPosition(const i:  integer):  integer;
begin
result := Integer(i * LongInt(Printer.PageWidth)  div 1000)
end; {iPosition}


function jPosition(const j:  integer):  integer;
begin
result := Integer(j * LongInt(Printer.PageHeight) div 1000)
end; {jPosition}

procedure SendToSpecificDestination(ItemNr : Integer; Info : TMajorExerciseFormat; PLang : TLangInfoFormat; TskIf : String);
var
              i,  p : integer;
 ccBitMap, mmBitMap : TBitMap;
       iJpgB, iJpgE : TImage;
                ipt : string;
     ScaleX, ScaleY : Integer;
          StrNrExercise : string;
begin

case Info.Interpreter of
  piAnt : ipt := Dialog_I_Ant;
  piTux : ipt := Dialog_I_Tux;
  piKng : ipt := Dialog_I_Kng;
 end;
       ccBitMap := TBiTMap.Create;
       mmBitMap := TBiTMap.Create;

       iJpgB:=TImage.Create(MainEdukaForm);
       iJpgE:=TImage.Create(MainEdukaForm);

//////////////////////////////
 TempRichEdit := TRichEdit.Create(MainEdukaForm);
 TempRichEdit.Visible:=false;
 TempRichEdit.Parent := TMainEdukaForm(MainEdukaForm);

with MainEdukaForm do
 if (ExerciseEditorMode or TestEditorMode) then
  begin
  {$IFNDEF _TRIAL_}
  edtPrintToEditor(TempRichEdit,clNavy,[],gb_Author.Caption + ': ');
  edtPrintToEditor(TempRichEdit,_c_Author.Font.Color,_c_Author.Font.Style,Info.Author + Enter + Enter);

  edtPrintToEditor(TempRichEdit,clNavy,[],gb_DurationSkill.Caption + ': '+ Enter);
  edtPrintToEditor(TempRichEdit,_c_Duration.Font.Color,_c_Duration.Font.Style, _c_Duration.ItemsEx.ComboItems[Info.Duration].Caption+ ', ');
  edtPrintToEditor(TempRichEdit,_c_Skill.Font.Color,_c_Skill.Font.Style,_c_Skill.ItemsEx.ComboItems[Info.Skill].Caption+ Enter + Enter);

  edtPrintToEditor(TempRichEdit,clNavy,[fsBold],'[ ');
  edtPrintToEditor(TempRichEdit,clMaroon,[],ipt);
  edtPrintToEditor(TempRichEdit,clNavy,[fsBold],' ]'+ Enter + Enter);

  edtPrintToEditor(TempRichEdit,clNavy,[],gb_Title.Caption + ': ');
  edtPrintToEditor(TempRichEdit,_c_Title.Font.Color,_c_Title.Font.Style,PLang.Title + Enter + Enter);

  edtPrintToEditor(TempRichEdit,clNavy,[],gb_Description.Caption + ': '+ Enter);
  edtPrintToEditor(TempRichEdit,_c_Description.Font.Color,_c_Description.Font.Style,PLang.Descr + Enter + Enter);

  edtPrintToEditor(TempRichEdit,clNavy,[],gb_Restrictions.Caption + ': '+ Enter);
  edtPrintToEditor(TempRichEdit,_c_Restrictions.Font.Color,_c_Restrictions.Font.Style,PLang.Rests + Enter);
  {$ENDIF}
  end else
  begin
    edtPrintToEditor(TempRichEdit,clNavy,[],Editor.lines.Text + Enter);
  end;

 with printer do
  begin

    ScaleX := GetDeviceCaps(Handle, logPixelsX) div Screen.PixelsPerInch;
    ScaleY := GetDeviceCaps(Handle, logPixelsY) div Screen.PixelsPerInch;
    Canvas.Pen.Width := 5;
    Canvas.Rectangle(60 * ScaleX ,25 * ScaleY, Printer.PageWidth - 20 * ScaleX, Printer.PageHeight - 25 * ScaleY);

      Canvas.Font.Name := 'Tahoma';
      Canvas.Font.Size := 10;
      Canvas.Font.Style := [];

    GetGridBitmap( Info.InGrid , ccBitMap, mmBitMap, Info.InPositionalX, Info.InPositionalY, Info.InDirectionalX, Info.InDirectionalY, Info.Interpreter);
    iJpgB.Picture.Bitmap.Assign(mmBitMap);

    BltTBitmapAsDib(Printer.Canvas.Handle,
        278 * ScaleX, 100 * ScaleY,
        iJpgB.Picture.Bitmap.Width * ScaleX , iJpgB.Picture.Bitmap.Height * ScaleY,
        iJpgB.Picture.Bitmap);
 if (ExerciseEditorMode or TestEditorMode) then
    Canvas.TextOut(Printer.PageWidth - 150 * ScaleX, 80 * ScaleY, HTML_Initial);

    GetGridBitmap( Info.OutGrid , ccBitMap, mmBitMap, Info.OutPositionalX, Info.OutPositionalY, Info.OutDirectionalX, Info.OutDirectionalY, Info.Interpreter);
    iJpgE.Picture.Bitmap.Assign(mmBitMap);
 if (ExerciseEditorMode or TestEditorMode) then
   begin
    BltTBitmapAsDib(Printer.Canvas.Handle,
        278 * ScaleX, iJpgB.Picture.Bitmap.Height* ScaleX + 150 * ScaleX,
        iJpgE.Picture.Bitmap.Width * ScaleX, iJpgE.Picture.Bitmap.Height * ScaleY,
        iJpgE.Picture.Bitmap);
    Canvas.TextOut(Printer.PageWidth - 150 * ScaleX,  iJpgB.Picture.Bitmap.Height* ScaleX + 130 * ScaleX, HTML_Final);
   end;
    If ExerciseEditorMode then StrNrExercise:= '' else StrNrExercise:= IntToStr(ItemNr);

      Canvas.Font.Name := 'Tahoma';
      Canvas.Font.Size := 10;
      Canvas.Font.Style := [fsBold];
    if (ExerciseEditorMode or TestEditorMode) then
    Canvas.TextOut(75 * ScaleX, 45 * ScaleY, ExerciseID + ' ' + StrNrExercise);

      Canvas.Font.Name := 'Tahoma';
      Canvas.Font.Size := 6;
      Canvas.Font.Style := [];
    Canvas.TextOut(Printer.PageWidth - 200 * ScaleX, Printer.PageHeight - 45 * ScaleY, HTML_Printed_By+' '+ProgramID+'       ' + DateToStr(Date));
    p:=0;
  for i := 0 to TempRichEdit.Lines.Count do
    begin
        Canvas.Font.Name := 'Tahoma';
        Canvas.Font.Size := 8;
        Canvas.Font.Style := [];
     Canvas.TextOut(75 * ScaleX,75 * ScaleY + (p *
        Canvas.TextHeight(TempRichEdit.Lines.Strings[i])),
                          TempRichEdit.Lines.Strings[i]);
     inc(p);
     if ((i+1) mod 76) = 0 then
      begin
       NewPage;
       p:=0;
            Canvas.Font.Name := 'Tahoma';
            Canvas.Font.Size := 6;
            Canvas.Font.Style := [];
       Canvas.Rectangle(60 * ScaleX ,25 * ScaleY, Printer.PageWidth - 20 * ScaleX, Printer.PageHeight - 25 * ScaleY);
       Canvas.TextOut(Printer.PageWidth - 200 * ScaleX, Printer.PageHeight - 45 * ScaleY,  HTML_Printed_By+' '+ProgramID+'       ' + DateToStr(Date));
      end;
    end;
  end;

         iJpgB.Free;
         iJpgE.Free;
      ccBitMap.Free;
      mmBitMap.Free;
  TempRichEdit.Free;
end;

 ///\/\/\/\/\/\/\/\/\/\/\/                         functii html

function getFontPar(c,s,f:string):string;
begin
result:='color="'+c+'" size="'+s+'" face="'+f+'"';
end;

function getCellPar(w,h,a,va,bd,bg:string):string;
begin
result:='width="'+w+'" height="'+h+'" align="'+a+'" valign="'+va+'"'+' bordercolor="'+bd+'"'+' bgcolor="'+bg+'"';
end;

function getTabPar(w,h,b,a,cp,cs,bd,bg:string):string;
begin
result:='width="'+w+'" height="'+h+'" border="'+b+'" align="'
        +a+'" cellpadding="'+cp+'" cellspacing="'+cs+'"'+' bordercolor="'+bd+'"'+' bgcolor="'+bg+'"';
end;

function Image(iName:string):string;
begin
result:='<img src="'+ExtractFileName(ImageDir)+'/'+iName+ '"'+'' {+' width="427" height="396"}+'>';
end;

function GetSource(ExerciseText : String; PLang : TLangInfoFormat; Info : TMajorExerciseFormat; WsEr, NwEr : Boolean; TskIf : String):string;
var
 Ipt       : String;
 MyStream  : TMemoryStream;
 MyStrings : TStrings;
begin

 case Info.Interpreter of
  piAnt : ipt := Dialog_I_Ant;
  piTux : ipt := Dialog_I_Tux;
  piKng : ipt := Dialog_I_Kng;
 end;

result := '<table '+getTabPar('100%','100%','0','left','10','0','#ffffff',LandColor_1)+' >'+Enter ;
if (ExerciseEditorMode or TestEditorMode or InLaunchedTestMode) then
with MainEdukaForm do
result:= result +
        '<table '+getTabPar('100%','100%','0','left','10','0','#ffffff',LandColor_1)+' >'+Enter
        +'  <tr>'+Enter
        +'    <td '+getCellPar('','','left','top',LandColor_1,LandColor_2)+'> '+Enter
        +'      <font '+ getFontPar('#000066','3','Verdana, Arial, Helvetica, sans-serif') +'>'+'<strong>'+ExerciseText+'</strong>'+'</font>'+'<br>'+Enter
        +'      <font '+ getFontPar('#003333','2','Verdana, Arial, Helvetica, sans-serif') +'>'+'<strong>'+''+'</strong>'+'</font>'+Enter
        +'    </td>'+Enter
        +'  <tr>'+Enter
        +'    <td '+getCellPar('','','left','top','','')+'> '+Enter
        +'      <font '+ getFontPar('#000066','1','Verdana, Arial, Helvetica, sans-serif') +'>'+''+gb_Author.Caption+''+'</font>'+'<br>'+Enter
        +'      <font '+ getFontPar('#003333','2','Verdana, Arial, Helvetica, sans-serif') +'>'+'<strong>'+Info.Author+'</strong>'+'</font>'+Enter
        +'    </td>'+Enter
        +'  </tr>'+Enter
        +'  <tr>'+Enter
        +'    <td '+getCellPar('','','left','top','','')+'> '+Enter
        +'      <font '+ getFontPar('#000066','1','Verdana, Arial, Helvetica, sans-serif') +'>'+''+gb_DurationSkill.Caption+''+'</font>'+'<br>'+Enter
        +'      <font '+ getFontPar('#003333','1','Verdana, Arial, Helvetica, sans-serif') +'>'+'<strong>'+_c_Duration.ItemsEx.ComboItems[Info.Duration].Caption+', /'+'</strong>'+'</font>'+Enter
        +'      <font '+ getFontPar('#003333','1','Verdana, Arial, Helvetica, sans-serif') +'> '+'<strong>'+_c_Skill.ItemsEx.ComboItems[Info.Skill].Caption+'</strong>'+'</font>'+Enter
        +'    </td>'+Enter
        +'  </tr>'+Enter
        +'  <tr>'+Enter
        +'    <td '+getCellPar('','','left','top','','')+'> '+Enter
        +'      <font '+ getFontPar('#000066','3','Verdana, Arial, Helvetica, sans-serif') +'>'+'<strong>'+HTML_Interpreter+': '+Ipt+'</strong>'+'</font>'+Enter
        +'    </td>'+Enter
        +'  </tr>'+Enter
        +'  <tr>'+Enter
        +'    <td '+getCellPar('','','left','top','','')+'> '+Enter
        +'      <font '+ getFontPar('#000066','1','Verdana, Arial, Helvetica, sans-serif') +'>'+''+gb_Title.Caption+''+'</font>'+'<br>'+Enter
        +'      <font '+ getFontPar('#003333','2','Verdana, Arial, Helvetica, sans-serif') +'>'+'<strong>'+PLang.Title+'</strong>'+'</font>'+Enter
        +'    </td>'+Enter
        +'  </tr>'+Enter
        +'  <tr>'+Enter
        +'    <td '+getCellPar('','','left','top','','')+'> '+Enter
        +'      <font '+ getFontPar('#000066','2','Verdana, Arial, Helvetica, sans-serif') +'>'+'<strong>'+gb_Description.Caption+'</strong>'+'</font>'+'<br>'+Enter
        +'      <font '+ getFontPar('#003333','1','Verdana, Arial, Helvetica, sans-serif') +'>'+PLang.Descr+'</font>'+Enter
        +'    </td>'+Enter
        +'  </tr>'+Enter
        +'  <tr>'+Enter
        +'    <td '+getCellPar('','','left','top','','')+'> '+Enter
        +'      <font '+ getFontPar('#000066','2','Verdana, Arial, Helvetica, sans-serif') +'>'+'<strong>'+gb_Restrictions.Caption+'</strong>'+'</font>'+'<br>'+Enter
        +'      <font '+ getFontPar('#003333','1','Verdana, Arial, Helvetica, sans-serif') +'>'+PLang.Rests+'</font>'+Enter
        +'    </td>'+Enter
        +'  </tr>'+Enter
        +'  <tr>'+Enter
        +'    <td '+getCellPar('','','left','top','','')+'> '+Enter
        +'      <font '+ getFontPar('#003333','1','Verdana, Arial, Helvetica, sans-serif') +'>'+ '...'+''+'</font>'+Enter
        +'    </td>'+Enter
        +'  </tr>'+Enter;

if (ExerciseEditorMode or TestEditorMode or InLaunchedTestMode) then
 begin
  if TskIf<>#0 then
   begin
    if NwEr then result:=result
        +'  <tr>'+Enter
        +'    <td '+getCellPar('','','left','top','','')+'> '+Enter
        +'      <font '+ getFontPar('#339900','2','Verdana, Arial, Helvetica, sans-serif') +'> '+'<strong>'+ExerciseISOK+'</strong>'+'</font>'+''+Enter
        +'    </td>'+Enter
        +'  </tr>'+Enter
          else
    if WsEr then result:=result
        +'  <tr>'+Enter
        +'    <td '+getCellPar('','','left','top','','')+'> '+Enter
        +'      <font '+ getFontPar('#336666','2','Verdana, Arial, Helvetica, sans-serif') +'> '+'<strong>'+ExerciseWASOK+'</strong>'+'</font>'+''+Enter
        +'    </td>'+Enter
        +'  </tr>'+Enter
           else
                result:=result
        +'  <tr>'+Enter
        +'    <td '+getCellPar('','','left','top','','')+'> '+Enter
        +'      <font '+ getFontPar('#CC3300','2','Verdana, Arial, Helvetica, sans-serif') +'> '+'<strong>'+ExerciseNOTOK+'</strong>'+'</font>'+''+Enter
        +'    </td>'+Enter
        +'  </tr>'+Enter;
   if TskIf<>'' then
    begin
     MyStream  := TMemoryStream.Create();
     MyStrings := TStringList.Create();
     MyStrings.Add(TskIf);

     MainEdukaForm.SynExportHTML.ExportAsText := True;
     MainEdukaForm.SynExportHTML.CreateHTMLFragment := True;
     MainEdukaForm.SynExportHTML.HTMLFontSize := fsDefault;
     MainEdukaForm.SynExportHTML.Highlighter := MainEdukaForm.ProSyn;
     MainEdukaForm.SynExportHTML.ExportAll(MyStrings);
     MainEdukaForm.SynExportHTML.SaveToStream(MyStream);

     MyStream.Position := 0;

     MyStrings.Clear;
     MyStrings.LoadFromStream(MyStream);
     Ipt:= MyStrings.Text;

     MyStream.Free;
     MyStrings.Free;

     result:=result
        +'  <tr>'+Enter
        +'    <td '+getCellPar('','','left','top','','')+'> '+Enter
        + Ipt + Enter
        +'    </td>'+Enter
        +'  </tr>'+Enter;
    end;
  end;
 end else
   begin
     MyStream  := TMemoryStream.Create();
     MyStrings := TStringList.Create();
     MyStrings.Add(MainEdukaForm.Editor.Lines.Text);

     MainEdukaForm.SynExportHTML.ExportAsText := True;
     MainEdukaForm.SynExportHTML.CreateHTMLFragment := True;
     MainEdukaForm.SynExportHTML.HTMLFontSize := fsDefault;
     MainEdukaForm.SynExportHTML.Highlighter := MainEdukaForm.ProSyn;
     MainEdukaForm.SynExportHTML.ExportAll(MyStrings);
     MainEdukaForm.SynExportHTML.SaveToStream(MyStream);

     MyStream.Position := 0;

     MyStrings.Clear;
     MyStrings.LoadFromStream(MyStream);
     Ipt:= MyStrings.Text;

     MyStream.Free;
     MyStrings.Free;

     result:=result
        +'  <tr>'+Enter
        +'    <td '+getCellPar('','','left','top','','')+'> '+Enter
        + Ipt + Enter
        +'    </td>'+Enter
        +'  </tr>'+Enter;
   end;
 result:=result
         +'</table>'+Enter;
end;

function GetImageTable():string;
begin
result:= '<table '+getTabPar('75%','','0','center','5','0','#ffffff',LandColor_1)+' >'+Enter;
if (ExerciseEditorMode or TestEditorMode or InLaunchedTestMode) then
 result:= result
       +'  <tr>'+Enter
       +'    <td ' + getCellPar('','','left','top','','')+'> ' + Enter + '<font '+ getFontPar('#003333','2','Verdana, Arial, Helvetica, sans-serif') +'>'+Enter+HTML_Initial+Enter+'</font>'+Enter + ' </td>'+Enter
       +'  </tr>'+Enter;
  result:= result
       +'  <tr>'+Enter
       +'    <td> ' + Image(imNameB) + ' </td>'+Enter
       +'  </tr>'+Enter;
if (ExerciseEditorMode or TestEditorMode or InLaunchedTestMode) then
 result:= result
       +'  <tr>'+Enter
       +'    <td ' + getCellPar('','','left','top','','')+'> ' + Enter + '<font '+ getFontPar('#003333','2','Verdana, Arial, Helvetica, sans-serif') +'>'+Enter+HTML_Final+Enter+'</font>'+Enter + ' </td>'+Enter
       +'  </tr>'+Enter
       +'  <tr>'+Enter
       +'    <td> ' + Image(imNameE) + ' </td>'+Enter
       +'  </tr>'+Enter;
 result:=result
       +'</table>'+Enter;
end;

function GetTable(ExerciseText : String; PLang : TLangInfoFormat; Info : TMajorExerciseFormat; WsEr, NwEr : Boolean; TskIf : String):string;
begin
result:='<table '+getTabPar('99%','','0','center','1','0','#ffffff',LandColor_2)+' >'+Enter
       +'  <tr>'+Enter
       +'    <td '+getCellPar('70%','','left','top','','')+'> '+ GetSource(ExerciseText, PLang, Info,WsEr, NwEr, TskIf ) + ' </td>'+Enter
       +'    <td '+getCellPar('30%','','left','top','','')+'> '+ GetImageTable() + ' </td>'+Enter
       +'  </tr>'+Enter
       +'</table>'+Enter;
end;

function GetBodyContent(ExerciseText : String; PLang : TLangInfoFormat; Info : TMajorExerciseFormat; WsEr, NwEr : Boolean; TskIf : String):string;
begin
 result:= result
   + '<p>'+'<font '+ getFontPar('#000066','3','Verdana, Arial, Helvetica, sans-serif') +'>'+Enter+'<strong>'+''+'</strong>'+'</font>'+'</p>'
   + GetTable(ExerciseText, PLang, Info, WsEr, NwEr, TskIf) + Enter;
end;

function GetMeta():string;
begin
result:='<meta http-equiv="Content-Type" content="text/html; charset='+HTML_Charset+'">'+Enter;
end;

function GetTitle(iFileName : string):string;
begin
result:='<title>'+' ['+ProgramID+'] '+'  '+' ['+ExtractFileName(iFileName)+'] '+'</title>'+Enter;
end;

function GetBody(ExerciseText : String ; PLang : TLangInfoFormat; Info : TMajorExerciseFormat; WsEr, NwEr : Boolean; TskIf : String):string;
begin
result:='<body bgColor="'+LandColor_3+'">'+Enter+ GetBodyContent(ExerciseText, PLang, Info, WsEr, NwEr, TskIf )+'</body>'+Enter;
end;

function GetHead(iFileName : string):string;
begin
result:='<head>'+Enter+GetTitle(iFileName)+GetMeta+'</head>'+Enter;

end;

function GetHtmlBody(iFileName : string;ExerciseText : String ; PLang : TLangInfoFormat; Info : TMajorExerciseFormat):string;
begin
result:= result
 +'<html>'+Enter+ GetHead(iFileName)

 +GetBody(ExerciseText, PLang, Info, False, False, #0 ) +'</html>'+Enter;
end;

function GetHtmlContent(iFileName : string;ExerciseText : String ; PLang : TLangInfoFormat; Info : TMajorExerciseFormat):string;
begin
result:=GetHtmlBody(iFileName,ExerciseText, PLang, Info );
end;



procedure saveImageFiles(iFileDir, ibg, ien :string; Info : TMajorExerciseFormat);
var JpgB,JpgE: TJpegImage;
     cBitMap,
      mBitMap : TBitMap;
begin

   imNameB := ibg;
   imNameE := ien;

   cBitMap := TBiTMap.Create;
   mBitMap := TBiTMap.Create;
   JpgB:=TJpegImage.Create;
   JpgE:=TJpegImage.Create;

   GetGridBitmap( Info.InGrid , cBitMap, mBitMap, Info.InPositionalX, Info.InPositionalY, Info.InDirectionalX, Info.InDirectionalY, Info.Interpreter);
   JpgB.Assign(mBitMap);
   JpgB.CompressionQuality := 90;
   JpgB.Compress;
   JpgB.SaveToFile(iFileDir + '\' + imNameB);

  if (ExerciseEditorMode or TestEditorMode or InLaunchedTestMode) then
  begin
   GetGridBitmap( Info.OutGrid , cBitMap, mBitMap, Info.OutPositionalX, Info.OutPositionalY, Info.OutDirectionalX, Info.OutDirectionalY, Info.Interpreter);
   JpgE.Assign(mBitMap);
   JpgE.CompressionQuality := 90;
   JpgE.Compress;
   JpgE.SaveToFile(iFileDir + '\' + imNameE);
  end;
  
 JpgB.Free;
 JpgE.Free;
 cBitMap.Free;
 mBitMap.Free;
end;

function GenHtmlExercisePage(ItemNr : Integer ; PLang : TLangInfoFormat;
 Info : TMajorExerciseFormat; WsEr, NwEr : Boolean; TskIf : String) : String;
begin

if Info.Interpreter =piAnt then
  begin
   LandColor_1 := AntLandColor_1;
   LandColor_2 := AntLandColor_2;
   LandColor_3 := AntLandColor_3;
  end else
 if Info.Interpreter =piKng then
  begin
   LandColor_1 := KngLandColor_1;
   LandColor_2 := KngLandColor_2;
   LandColor_3 := KngLandColor_3;
  end else
 if Info.Interpreter =piTux then
  begin
   LandColor_1 := TuxLandColor_1;
   LandColor_2 := TuxLandColor_2;
   LandColor_3 := TuxLandColor_3;
  end;

 Result := GetBody(ExerciseID+' '+IntToStr(ItemNr), PLang, Info, WsEr, NwEr , TskIf);

end;


procedure SaveBodiedHtmlFile(iFileName : string; Body : String);
var
 hFile : TextFile;
begin

 AssignFile(hFile,iFileName);

{$I-}
 Rewrite(hFile);
{$I+}
 if IOResult<>0 then
   begin
     Exit;
   end;

{$I-}
 writeln(hFile,Body);
{$I+}
 if IOResult<>0 then
   begin
     CloseFile(hFile);
     Exit;
   end;

CloseFile(hFile);
end;

procedure saveHtmlFile(iFileName : string; n : integer; PLang : TLangInfoFormat; Info : TMajorExerciseFormat);
var
 hFile : TextFile;
begin

if Info.Interpreter =piAnt then
  begin
   LandColor_1 := AntLandColor_1;
   LandColor_2 := AntLandColor_2;
   LandColor_3 := AntLandColor_3;
  end else
 if Info.Interpreter =piKng then
  begin
   LandColor_1 := KngLandColor_1;
   LandColor_2 := KngLandColor_2;
   LandColor_3 := KngLandColor_3;
  end else
 if Info.Interpreter =piTux then
  begin
   LandColor_1 := TuxLandColor_1;
   LandColor_2 := TuxLandColor_2;
   LandColor_3 := TuxLandColor_3;
  end;

 AssignFile(hFile,iFileName);

{$I-}
 Rewrite(hFile);
{$I+}
 if IOResult<>0 then
   begin
     Exit;
   end;

{$I-}
 writeln(hFile,GetHtmlContent(iFileName,ExerciseID, PLang, Info));
{$I+}
 if IOResult<>0 then
   begin
     CloseFile(hFile);
     Exit;
   end;

CloseFile(hFile);
end;

procedure pxtPrintCodePage();
 var  PLang : TLangInfoFormat;
begin
{
 if MainEdukaForm.PrintDialog.Execute then
 begin
   MainEdukaForm.SynEditPrint.Highlight := True;
   MainEdukaForm.SynEditPrint.Copies := MainEdukaForm.PrintDialog.Copies;

   MainEdukaForm.SynEditPrint.Font.Size:=12;
   MainEdukaForm.SynEditPrint.Title := sFileName;

   MainEdukaForm.SynEditPrint.Highlighter:=MainEdukaForm.ProSyn;
   MainEdukaForm.SynEditPrint.SynEdit:=MainEdukaForm.Editor;
   MainEdukaForm.SynEditPrint.Lines.Assign(MainEdukaForm.Editor.Lines);
   MainEdukaForm.SynEditPrint.Print;
 end;
   }

 with MainEdukaForm do
 begin

  CurrentExerciseInfo.Interpreter := CurrentInterpreter;
  CurrentExerciseInfo.TableMax := TabMax;
  CurrentExerciseInfo.InGrid   := t;

  CurrentExerciseInfo.InDirectionalX := Sx;
  CurrentExerciseInfo.InDirectionalY := Sy;
  CurrentExerciseInfo.InPositionalX  := u;
  CurrentExerciseInfo.InPositionalY  := v;

 end;
 if MainEdukaForm.PrintDialog.Execute then
     with printer do
      begin
       BeginDoc;   // **
         SendToSpecificDestination(0,CurrentExerciseInfo,PLang,'');
       EndDOc;
      end;

end;

procedure pxtExportCodePage(iFileName : String);
var
 PLang : TLangInfoFormat;
 TempS  : String;
 GenDirPath
        : String;
begin

 with MainEdukaForm do
 begin
 {
  CurrentExerciseInfo.Author   := _c_Author.Text;
  CurrentExerciseInfo.Duration := _c_Duration.ItemIndex;
  CurrentExerciseInfo.Skill    := _c_Skill.ItemIndex;
  }
  CurrentExerciseInfo.Interpreter := CurrentInterpreter;
  CurrentExerciseInfo.TableMax := TabMax;
  CurrentExerciseInfo.InGrid   := t;
 // CurrentExerciseInfo.OutGrid   := tb2;
  CurrentExerciseInfo.InDirectionalX := Sx;
  CurrentExerciseInfo.InDirectionalY := Sy;
  CurrentExerciseInfo.InPositionalX  := u;
  CurrentExerciseInfo.InPositionalY  := v;
  {
  CurrentExerciseInfo.OutDirectionalX := Sx2;
  CurrentExerciseInfo.OutDirectionalY := Sy2;
  CurrentExerciseInfo.OutPositionalX  := u2;
  CurrentExerciseInfo.OutPositionalY  := v2;   }
                                      {
  PLang.Title := _c_Title.Text;
  PLang.Descr := _c_Description.Text;
  PLang.Rests := _c_Restrictions.Text;
  PLang.Lng   := CurrentLanguage;
  }
 end;

   TempS      := ExtractFileName(iFileName);
   Delete(TempS, Length(TempS) - Length(ExtractFileExt(iFileName))+1, Length(ExtractFileExt(iFileName)));
   GenDirPath := ExtractFilePath(iFileName) + TempS + '_files';
 try
   if not DirectoryExists(GenDirPath) then CreateDir( GenDirPath );
 except
   Exit;
 end;

 saveImageFiles(GenDirPath,'ImageBegin.jpg', 'ImageEnd.jpg' , CurrentExerciseInfo);
 ImageDir := ExtractFileName(GenDirPath);
 saveHtmlFile(iFileName, 0, PLang, CurrentExerciseInfo);
 {
 MainEdukaForm.SynExportHTML.ExportAsText := True;
 MainEdukaForm.SynExportHTML.Title:=ExtractFileName(sFileName)+' ['+CurrentInterpreterName+']';
 MainEdukaForm.SynExportHTML.HTMLFontSize := fsDefault;
 MainEdukaForm.SynExportHTML.Highlighter := MainEdukaForm.ProSyn;
 MainEdukaForm.SynExportHTML.ExportAll(MainEdukaForm.Editor.Lines);
 MainEdukaForm.SynExportHTML.SaveToFile(iFileName);
 }
end;

procedure pxtPrintExercisePage();
var  PLang : TLangInfoFormat;
begin
 with MainEdukaForm do
 begin
  CurrentExerciseInfo.Author   := _c_Author.Text;
  CurrentExerciseInfo.Duration := _c_Duration.ItemIndex;
  CurrentExerciseInfo.Skill    := _c_Skill.ItemIndex;
  CurrentExerciseInfo.Interpreter := CurrentInterpreter;
  CurrentExerciseInfo.TableMax := TabMax;
  CurrentExerciseInfo.InGrid   := tb1;
  CurrentExerciseInfo.OutGrid   := tb2;
  CurrentExerciseInfo.InDirectionalX := Sx1;
  CurrentExerciseInfo.InDirectionalY := Sy1;
  CurrentExerciseInfo.InPositionalX  := u1;
  CurrentExerciseInfo.InPositionalY  := v1;
  CurrentExerciseInfo.OutDirectionalX := Sx2;
  CurrentExerciseInfo.OutDirectionalY := Sy2;
  CurrentExerciseInfo.OutPositionalX  := u2;
  CurrentExerciseInfo.OutPositionalY  := v2;

  PLang.Title := _c_Title.Text;
  PLang.Descr := _c_Description.Text;
  PLang.Rests := _c_Restrictions.Text;
  PLang.Lng   := CurrentLanguageCode;
 end;
 if MainEdukaForm.PrintDialog.Execute then
     with printer do
      begin
       BeginDoc;   // **
         SendToSpecificDestination(0,CurrentExerciseInfo,PLang,'');
       EndDOc;
      end;
end;

procedure pxtExportExercisePage(iFileName : String);
var
 PLang : TLangInfoFormat;
 TempS  : String;
 GenDirPath
        : String;
begin

 with MainEdukaForm do
 begin
  CurrentExerciseInfo.Author   := _c_Author.Text;
  CurrentExerciseInfo.Duration := _c_Duration.ItemIndex;
  CurrentExerciseInfo.Skill    := _c_Skill.ItemIndex;
  CurrentExerciseInfo.Interpreter := CurrentInterpreter;
  CurrentExerciseInfo.TableMax := TabMax;
  CurrentExerciseInfo.InGrid   := tb1;
  CurrentExerciseInfo.OutGrid   := tb2;
  CurrentExerciseInfo.InDirectionalX := Sx1;
  CurrentExerciseInfo.InDirectionalY := Sy1;
  CurrentExerciseInfo.InPositionalX  := u1;
  CurrentExerciseInfo.InPositionalY  := v1;
  CurrentExerciseInfo.OutDirectionalX := Sx2;
  CurrentExerciseInfo.OutDirectionalY := Sy2;
  CurrentExerciseInfo.OutPositionalX  := u2;
  CurrentExerciseInfo.OutPositionalY  := v2;

  PLang.Title := _c_Title.Text;
  PLang.Descr := _c_Description.Text;
  PLang.Rests := _c_Restrictions.Text;
  PLang.Lng   := CurrentLanguageCode;
 end;

   TempS      := ExtractFileName(iFileName);
   Delete(TempS, Length(TempS) - Length(ExtractFileExt(iFileName))+1, Length(ExtractFileExt(iFileName)));
   GenDirPath := ExtractFilePath(iFileName) + TempS + '_files';
 try
   if not DirectoryExists(GenDirPath) then CreateDir( GenDirPath );
 except
   Exit;
 end;

 saveImageFiles(GenDirPath,'ImageBegin.jpg', 'ImageEnd.jpg' , CurrentExerciseInfo);
 ImageDir := ExtractFileName(GenDirPath);
 saveHtmlFile(iFileName, 0, PLang, CurrentExerciseInfo);
end;

procedure pxtPrintTestPage();
var
       I, U, ZeCode : integer;
begin
 // JOHN TODO
//////////////////////////////////////////////////  begin save TEST
 if MainEdukaForm.PrintDialog.Execute then
     with printer do
      begin
       {$IFNDEF _TRIAL_}
       BeginDoc;
       {$ENDIF}

         for i:=0 to iSelectedFileList - 1 do
          begin
            if TestEditorMode then SelectedFileList[I].SelExercise := #0;

            ZeCode := 0;

            for u := 0 to MainEdukaForm._d_Language.ItemsEx.Count - 1 do
              if PShortString(MainEdukaForm._d_Language.ItemsEx.Items[u].Data)^ = CurrentLanguageCode then
                ZeCode := u;

            SendToSpecificDestination(I + 1,    SelectedFileList[I].Info1,
            SelectedFileList[I].Info2 [ ZeCode ] , SelectedFileList[I].SelExercise);


            if i < iSelectedFileList-1 then newPage;
          end;
       EndDoc;
      end;
//  SendToSpecificDestination('prn','',0,CurrentExerciseInfo,PLang);
//////////////////////////////////////////////////  end save TEST
end;

procedure pxtExportTestPage(iFileName : String);
var
 I, U, ZeCode  : integer;
 TempS  : String;
 GenDirPath
        : String;

 MainTest : String;
begin

   TempS      := ExtractFileName(iFileName);
   Delete(TempS, Length(TempS) - Length(ExtractFileExt(iFileName))+1, Length(ExtractFileExt(iFileName)));
   GenDirPath := ExtractFilePath(iFileName) + TempS + '_files';
 try
   if not DirectoryExists(GenDirPath) then CreateDir( GenDirPath );
 except
   Exit;
 end;

 MainTest := '<html>'+Enter+ GetHead(iFileName);
 MainTest:=MainTest
      +''+'<font '+ getFontPar('#000066','2','Verdana, Arial, Helvetica, sans-serif') +'>'+Enter+''+'<strong>'+HTML_Test+' '+'</strong>'+''+'</font>'+''+Enter;
 if not TestEditorMode then
  begin
   MainTest:=MainTest
      +''+'<font '+ getFontPar('#000066','2','Verdana, Arial, Helvetica, sans-serif') +'>'+Enter+''+'<strong>'+HTML_Resolved_By+' '+'</strong>'+''+'</font>'+''+Enter
      +''+'<font '+ getFontPar('#1B5358','3','Verdana, Arial, Helvetica, sans-serif') +'>'+Enter+''+'<strong>'+Student_Name+'</strong>'+''+'</font>'+'<br>'+Enter
      +''+'<font '+ getFontPar('#1B5358','2','Verdana, Arial, Helvetica, sans-serif') +'>'+Enter+''+'<strong>'+DateToStr(Date)+'</strong>'+''+'</font>'+''+Enter;
  end;

 for i:=0 to iSelectedFileList - 1 do
  begin
    saveImageFiles(GenDirPath,'ImageBegin'+IntToStr(I)+'.jpg', 'ImageEnd'+IntToStr(I)+'.jpg' , SelectedFileList[I].Info1);

    ImageDir := ExtractFileName(GenDirPath);
    if TestEditorMode then SelectedFileList[I].SelExercise := #0;

    ZeCode := 0;

    for u := 0 to MainEdukaForm._d_Language.ItemsEx.Count - 1 do
      if PShortString(MainEdukaForm._d_Language.ItemsEx.Items[u].Data)^ = CurrentLanguageCode then
        ZeCode := u;

    MainTest := MainTest + GenHtmlExercisePage(I + 1,
    SelectedFileList[I].Info2 [ ZeCode ] ,
    SelectedFileList[I].Info1, SelectedFileList[I].WasSuccess, SelectedFileList[I].NowSuccess,
    SelectedFileList[I].SelExercise);

  end;
 MainTest := MainTest +'</html>'+Enter;
 SaveBodiedHtmlFile(iFileName, MainTest);
end;


end.
