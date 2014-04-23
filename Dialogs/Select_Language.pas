(*

The Original Code is: Select_Language.pas, released 2005-02-02.
Authors of this file are Popov John and Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains Select_Language definition. This Dialog is responsable for
    listing all Language files.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}

unit Select_Language;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DesignInside, Translate, ProTypes, Menus, Utils,
  JvMenus, JvExControls, JvComponent, JvStaticText, JvDotNetControls,
  ImgList, JvImageList
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;
{$IFDEF _DEBUG_}
Const
        DbgUName          = '/Dialogs/Select_Language.pas';
{$ENDIF}

type
  TDialog_Select_Language = class(TForm)
    Language_Box: TJvDotNetListBox;
    Sel_Lang_OK: TJvStaticText;
    Sel_Lang_Cancel: TJvStaticText;
    Language_Available_List: TJvStaticText;
    Context_Help: TJvPopupMenu;
    Help_Q                  : TMenuItem;
    ImageList: TJvImageList;

    procedure Sel_Lang_OKClick               (Sender: TObject);
    procedure Sel_Lang_CancelClick           (Sender: TObject);
    procedure ButtonDefaults                 (Sender: TObject);
    procedure Button_MouseMove               (Sender: TObject;  Shift: TShiftState; X, Y: Integer);
    procedure ButtonDefaultsMove             (Sender: TObject;  Shift: TShiftState; X, Y: Integer);
    procedure FormShow                       (Sender: TObject);
    procedure Help_QClick                    (Sender: TObject);
    procedure HelpContextPopup               (Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormActivate                   (Sender: TObject);
    procedure FormCreate                     (Sender: TObject);
    procedure Language_BoxKeyPress           (Sender: TObject; var Key: Char);
    procedure Language_BoxClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
     LangFileName    : string;
     PHandle         : HWND;
     Langs           : Array of String;
  end;

var
  Dialog_Select_Language: TDialog_Select_Language;

implementation

uses ContextHelp;
{$R *.dfm}


(*
 * TDialog_Select_Language.Sel_Lang_OKClick
 *)

procedure TDialog_Select_Language.Sel_Lang_OKClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Language.Sel_Lang_OKClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}


  Hide;
  PlaySoundEvent( sndJustTick );
  LangFileName:=Langs[Language_Box.ItemIndex];
  PostMessage(PHandle,WM_SelectLanguageClose,0,0);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Language.Sel_Lang_OKClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Language.button_MouseMove
 *)

procedure TDialog_Select_Language.button_MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TDialog_Select_Language.button_MouseMove (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextActive(Sender as TJvStaticText);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Language.button_MouseMove = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Language.Sel_Lang_CancelClick
 *)

procedure TDialog_Select_Language.Sel_Lang_CancelClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Language.Sel_Lang_CancelClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  PlaySoundEvent( sndJustTick );
  Close;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Language.Sel_Lang_CancelClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Language.ButtonDefaults
 *)

procedure TDialog_Select_Language.ButtonDefaults(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Language.ButtonDefaults (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextDefault( Sel_Lang_OK );
  diMakeStaticTextDefault( Sel_Lang_Cancel );

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Language.ButtonDefaults = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Language.ButtonDefaultsMove
 *)

procedure TDialog_Select_Language.ButtonDefaultsMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TDialog_Select_Language.ButtonDefaultsMove (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

 ButtonDefaults(nil);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Language.ButtonDefaultsMove = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Language.FormShow
 *)

procedure TDialog_Select_Language.FormShow(Sender: TObject);
var
 TSrcFile     : TSearchRec;
 StName,LNm,Cdd : ShortString;
 Index, Count : integer;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Language.FormShow (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}


{$IFDEF _TRIAL_}
 Sel_Lang_OK.Enabled := False;
 Sel_Lang_OK.Visible := False;
{$ENDIF}

 PlaySoundEvent( sndDlgTick );
 Help_Q.Caption:=WHATISTHIS;
 Sel_Lang_OK.Caption:=DLGOK;
 Language_Available_List.Caption:=DLG_AFL;
 Sel_Lang_Cancel.Caption:=DLGCANCEL;
 Caption:=Dialog_C_SL;

 SetLength(Langs,0);

 Language_Box.Clear;
 count:=FindFirst(ExtractFilePath(ParamStr(0))+'Languages\*.lng',255,TSrcFile);
 Index:=1;
 Language_Box.Items.Add(engNAME);

 if CurrentLanguageCode=engCode then
      Language_Box.Selected[0]:=True;

   SetLength(Langs,Index*SizeOf(StName));
   Langs[(Index-1)]:='';

 while (Count=0) do
   begin
   if Index >= 30 then Break;

   StName:= ExtractFilePath(ParamStr(0))+'Languages\' + TSrcFile.Name;

   Lnm:=lngGetLanguageFileNameID(StName);
   Cdd:=lngGetLanguageFileNameCode(StName);

   Language_Box.Items.Add(LNm);

   if Cdd = CurrentLanguageCode then
        Language_Box.Selected[Index]:=True;

   Index:=Index+1;
   SetLength(Langs,Index*SizeOf(StName));
   Langs[(Index-1)]:=StName;
   Count:=FindNext(TSrcFile);
  end;

  diMakeStaticTextDefault( Sel_Lang_OK );
   diMakeStaticTextDefault( Sel_Lang_Cancel );
   
  msSetMenuStyles( Context_Help );

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Language.FormShow = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Language.Help_QClick
 *)

procedure TDialog_Select_Language.Help_QClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Language.Help_QClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 ContextHelp.PopupPoint:=Context_Help.PopupPoint;
 Context_Form.Help_QDisplay;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Language.Help_QClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Language.HelpContextPopup
 *)

procedure TDialog_Select_Language.HelpContextPopup(
  Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Language.HelpContextPopup (Sender:'+DbgObject(Sender)+'; MousePos:'+DbgPoint(MousePos)+'; var Handled:'+DbgBool(Handled)+')');
   DbgPlus;
 {$ENDIF}

 if CurrentHelpFile='' then Exit;

 Handled:=True;
 OHelpContext := (Sender as TControl).HelpContext;
 OHelpPage    := (Sender as TControl).HelpKeyword; 
 Context_Help.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Language.HelpContextPopup ( var Handled:'+DbgBool(Handled)+' ) = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Language.FormActivate
 *)

procedure TDialog_Select_Language.FormActivate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Language.FormActivate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}


 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Language.FormActivate = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Language.FormCreate
 *)

procedure TDialog_Select_Language.FormCreate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Language.FormCreate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextDefault( Sel_Lang_OK );
  diMakeStaticTextDefault( Sel_Lang_Cancel );
  diMakeStaticTextDefault( Language_Available_List );
  Language_Available_List.Cursor := crDefault;

  Color:=FormColor;
  Font.Charset:=FormCharset;
  Font.Color:=FormFontColor;
  Font.Size:=FormFontSize;
  Font.Name:=MainUsedFont;
  Font.Style:=FormFontStyles;

  Language_Box.Color:=ListBoxColor;
  Language_Box.Font.Charset:=ListBoxCharset;
  Language_Box.Font.Color:=ListBoxFontColor;
  Language_Box.Font.Size:=ListBoxFontSize;
  Language_Box.Font.Name:=MainUsedFont;
  Language_Box.Font.Style:=ListBoxFontStyles;

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Language.FormCreate = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Language.Language_BoxKeyPress
 *)

procedure TDialog_Select_Language.Language_BoxKeyPress(Sender: TObject;
  var Key: Char);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Language.Language_BoxKeyPress (Sender:'+DbgObject(Sender)+'; var Key:'+DbgChar(Key)+')');
   DbgPlus;
 {$ENDIF}

 if Key=#27 then Close;
 if Key=#13 then Sel_Lang_OK.OnClick(Sel_Lang_OK);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Language.Language_BoxKeyPress ( var Key:'+DbgChar(Key)+' ) = void');
 {$ENDIF}
end;

procedure TDialog_Select_Language.Language_BoxClick(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
end;

end.
