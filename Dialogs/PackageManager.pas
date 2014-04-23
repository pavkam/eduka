(*

The Original Code is: PackageManager.pas, released 2005-02-02.
Authors of this file are Popov John and Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains PackageForm definition.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}

unit PackageManager;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DesignInside, Translate, ProTypes, Menus, Utils,
  Files, JvMenus, JvDotNetControls, JvExControls, JvComponent, JvStaticText,
  ImgList, JvImageList
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;
{$IFDEF _DEBUG_}
Const
        DbgUName          = '/Dialogs/PackageManager.pas';
{$ENDIF}
type
  TPackageForm = class(TForm)
    Avail_Packages: TJvStaticText;
    Package_Box: TJvDotNetListBox;
    Pack_OK: TJvStaticText;
    Pack_Install: TJvStaticText;
    Context_Help: TJvPopupMenu;
    Help_Q: TMenuItem;
    Pack_Uninstall: TJvStaticText;
    OpenDialog: TOpenDialog;
    ImageList: TJvImageList;
    
    procedure Pack_OKClick(Sender: TObject);
    procedure button_MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ButtonDefaults(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure Help_QClick(Sender: TObject);
    procedure helpContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Pack_InstallClick(Sender: TObject);
    procedure Pack_UninstallClick(Sender: TObject);
    procedure Package_BoxClick(Sender: TObject);
    procedure Package_BoxKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    Packs  : array of String;
    NoShow : Boolean;
  end;

var
  PackageForm: TPackageForm;

implementation

uses ContextHelp, Check_Save;

{$R *.dfm}

procedure TPackageForm.Pack_OKClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TPackageForm.Pack_OKClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  PlaySoundEvent( sndJustTick );
  Close();

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TPackageForm.Pack_OKClick = void');
 {$ENDIF}
end;

procedure TPackageForm.button_MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TPackageForm.button_MouseMove (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

  if (Sender as TJvStaticText).Name <> Pack_OK.Name then diMakeStaticTextDefault( Pack_OK );
  if (Sender as TJvStaticText).Name <> Pack_Install.Name then diMakeStaticTextDefault( Pack_Install );
  if (Sender as TJvStaticText).Name <> Pack_UnInstall.Name then diMakeStaticTextDefault( Pack_UnInstall );

  diMakeStaticTextActive(Sender as TJvStaticText);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TPackageForm.button_MouseMove = void');
 {$ENDIF}
end;

procedure TPackageForm.ButtonDefaults(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TPackageForm.ButtonDefaults (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextDefault( Pack_OK );
  diMakeStaticTextDefault( Pack_Install );
  diMakeStaticTextDefault( Pack_UnInstall );

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TPackageForm.ButtonDefaults = void');
 {$ENDIF}
end;

procedure TPackageForm.FormShow(Sender: TObject);
var
 TSrcFile     : TSearchRec;
 StName,LNm   : ShortString;
 Index, Count : integer;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TPackageForm.FormShow (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 PlaySoundEvent( sndDlgTick );
 Help_Q.Caption                  := WHATISTHIS;
 Pack_OK.Caption                 := DLGOK;
 Pack_Install.Caption            := DLGInstall;
 Pack_UnInstall.Caption          := DLGUnInstall;

 Avail_Packages.Caption          := DLG_AVPK;
 Caption                         := Dialog_C_SP;
 OpenDialog.FileName             := '';
 OpenDialog.Filter               := PackageFilter;
 
  diMakeStaticTextDefault( Pack_OK );
  diMakeStaticTextDefault( Pack_Install );
  diMakeStaticTextDefault( Pack_UnInstall );

  msSetMenuStyles( Context_Help );

 SetLength(Packs,0);

 Package_Box.Clear;
 count   := FindFirst(ExtractFilePath(ParamStr(0))+'Packages\*.installed',255,TSrcFile);
 Index   := 0;
 while (Count=0) do
   begin
   if Index >= 30 then Break;

   StName:= ExtractFilePath(ParamStr(0))+'Packages\' + TSrcFile.Name;
   if not flsPackageIsActive(StName) then
    begin
     Count  := FindNext(TSrcFile);
     Continue;
    end; 
   Lnm:=flsGetFilePackageTitle(StName);
   Package_Box.Items.Add(LNm);

   Index:=Index + 1;
   SetLength(Packs, Index);
   Packs[(Index-1)] := StName;
   Count            := FindNext(TSrcFile);
  end;

  Pack_UnInstall.Enabled := not (Index = 0);

  if Index > 0 then Package_Box.Selected[0]:=True;

  Package_BoxClick(Package_Box);
 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TPackageForm.FormShow = void');
 {$ENDIF}
end;


procedure TPackageForm.Help_QClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TPackageForm.Help_QClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 ContextHelp.PopupPoint := Context_Help.PopupPoint;
 Context_Form.Help_QDisplay;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TPackageForm.Help_QClick = void');
 {$ENDIF}
end;

procedure TPackageForm.helpContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TPackageForm.helpContextPopup (Sender:'+DbgObject(Sender)+'; MousePos:'+DbgPoint(MousePos)+'; var Handled:'+DbgBool(Handled)+')');
   DbgPlus;
 {$ENDIF}

 if CurrentHelpFile='' then Exit;

 Handled:=True;
 
 OHelpContext := (Sender as TControl).HelpContext;
 OHelpPage    := (Sender as TControl).HelpKeyword;

 Context_Help.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TPackageForm.helpContextPopup ( var Handled:'+DbgBool(Handled)+' ) = void');
 {$ENDIF}
end;

procedure TPackageForm.FormActivate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TPackageForm.FormActivate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}


 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TPackageForm.FormActivate = void');
 {$ENDIF}
end;

procedure TPackageForm.FormCreate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TPackageForm.FormCreate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}


  {$IFDEF _TRIAL_}
    Pack_Install.Enabled := False;
    Pack_Install.Visible := False;
  {$ENDIF}

  diMakeStaticTextDefault( Pack_OK );
  diMakeStaticTextDefault( Pack_Install );
  diMakeStaticTextDefault( Pack_UnInstall );
  diMakeStaticTextDefault( Avail_Packages );
  Avail_Packages.Cursor := crDefault;
  

  Color:=FormColor;
  Font.Charset:=FormCharset;
  Font.Color:=FormFontColor;
  Font.Size:=FormFontSize;
  Font.Name:=MainUsedFont;
  Font.Style:=FormFontStyles;

  Package_Box.Color:=ListBoxColor;
  Package_Box.Font.Charset:=ListBoxCharset;
  Package_Box.Font.Color:=ListBoxFontColor;
  Package_Box.Font.Size:=ListBoxFontSize;
  Package_Box.Font.Name:=MainUsedFont;
  Package_Box.Font.Style:=ListBoxFontStyles;

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TPackageForm.FormCreate = void');
 {$ENDIF}
end;

procedure TPackageForm.Pack_InstallClick(Sender: TObject);
Var
 Vx, iX : Integer;
 sst    : String;
 Pipi   : TextFile;
 WasError : Boolean;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TPackageForm.Pack_InstallClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}
 InCriticalStage := True;

 if not NoShow then OpenDialog.FileName := '';

 if not NoShow then
 if not OpenDialog.Execute() then
  begin
    {$IFDEF _DEBUG_}
     DbgMinus;
     DbgPrint(DbgUName+' : TPackageForm.Pack_InstallClick = void');
    {$ENDIF}
   InCriticalStage := False;
   Exit;
  end;
  
 WasError := False;
 Vx := flsGetPackageFileCount(OpenDialog.FileName);

 if Vx < 1 then
    begin
      Dialog_Check_Save.InformativeMessage( Dialog_C_NOTPK, Dialog_PK_ERRMSG, 2 );
    end else
    begin
      Dialog_Check_Save.SetMessageIcon( 1 );
      Dialog_Check_Save.Text_Q.Text            := Format(Dialog_PK_OKMSG, [flsGetFilePackageTitle(OpenDialog.FileName), IntToStr(Vx)]);
      Dialog_Check_Save.Check_Save_No.Visible  := False;

      if Dialog_Check_Save.ShowModal() = mrYes then
       begin
        AssignFile(Pipi, ExtractFilePath(ParamStr(0))+'\Packages\'+ExtractFileName(OpenDialog.FileName)+'.installed');
        {$I-}
        Rewrite(Pipi);
        {$I+}

        Writeln(PiPi, flsGetFilePackageTitle(OpenDialog.FileName));

         if IOResult<>0 then
           begin
            Dialog_Check_Save.InformativeMessage( Dialog_C_NOTPK, Dialog_PK_ERRLMSG, 2 );

            {$IFDEF _DEBUG_}
             DbgMinus;
             DbgPrint(DbgUName+' : TPackageForm.Pack_InstallClick = void');
            {$ENDIF}
            InCriticalStage := False;
            Exit;
           end;
           
        WasError := False;

        for iX := 1 to Vx do
        begin
         sst := flsGetFileInstallLocation(OpenDialog.FileName, iX);
         if not flsSaveFileToLocation( sst, flsGetFileBody(OpenDialog.FileName, iX)) then WasError := True
          else
             begin
               Writeln(PiPi, sst);
             end;
         end;

         CloseFile(PiPi);
       end;

  if WasError then
              begin
                Dialog_Check_Save.InformativeMessage( Dialog_C_NOTPK, Dialog_PK_ERRLMSG, 2 );
              end else
              begin
                Dialog_Check_Save.InformativeMessage( Dialog_C_NOTPK, Dialog_PK_GOODMSG, 1 );
              end;

      Dialog_Check_Save.Check_Save_No.Visible  := True;
    end;

   OnShow( Self );
   InCriticalStage := False;

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TPackageForm.Pack_InstallClick = void');
  {$ENDIF}
end;

procedure TPackageForm.Pack_UninstallClick(Sender: TObject);
var
 i, MyIndex  : integer;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TPackageForm.Pack_UninstallClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

   MyIndex := -1;
   for i:= 0 to Package_Box.Items.Count - 1 do
     if Package_Box.Selected [i] then MyIndex := i;

   ASSERT( MyIndex > -1, 'This shouldn''t happen !!! Hmmmmm ....');

   flsRemovePackageFiles(Packs[MyIndex]);

   OnShow( Self );

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TPackageForm.Pack_UninstallClick = void');
  {$ENDIF}
end;

procedure TPackageForm.Package_BoxClick(Sender: TObject);
var
 i, MyIndex  : integer;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TPackageForm.Package_BoxClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

   MyIndex := -1;
   for i:= 0 to Package_Box.Items.Count - 1 do
     if Package_Box.Selected [i] then MyIndex := i;

  if MyIndex <> -1 then
   Pack_Uninstall.Enabled := not flsPackageIsUsed(Packs[MyIndex]);

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TPackageForm.Package_BoxClick = void');
  {$ENDIF}
end;

procedure TPackageForm.Package_BoxKeyPress(Sender: TObject; var Key: Char);
var
 i, MyIndex  : integer;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TPackageForm.Package_BoxKeyPress (Sender:'+DbgObject(Sender)+'; Key:"'+Key+'")');
   DbgPlus;
 {$ENDIF}

   MyIndex := -1;
   for i:= 0 to Package_Box.Items.Count - 1 do
     if Package_Box.Selected [i] then MyIndex := i;

 if MyIndex <> -1 then
   Pack_Uninstall.Enabled := not flsPackageIsUsed(Packs[MyIndex]);

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TPackageForm.Package_BoxKeyPress = void');
  {$ENDIF}
end;

end.
