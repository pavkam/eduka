(*

The Original Code is: Select_Student.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains Select_Student definition. This dialog is responsable
    for requesting data about tested person and export file name.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit Select_Student;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, DesignInside, ProTypes, Translate,
  Menus, Utils, JvMenus, JvExControls, JvComponent, JvStaticText, JvExStdCtrls,
  JvDotNetControls, ImgList, JvImageList
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;

{$IFDEF _DEBUG_}
Const
  DbgUName  =  '/Dialogs/Select_Student.pas';
{$ENDIF}

type
  TDialog_Select_Student = class(TForm)

    Lbl_StudName     : TLabel;
    lbl_ExportFile   : TLabel;
    Sel_Stud_OK: TJvStaticText;
    Sel_Stud_Cancel: TJvStaticText;
    Sel_Stud_Browse: TJvStaticText;
    Context_Help: TJvPopupMenu;
    Help_Q           : TMenuItem;
    ExportSaveDialog : TSaveDialog;
    edt_StudInfo: TJvDotNetEdit;
    edt_ExportFile: TJvDotNetEdit;
    ImageList: TJvImageList;

    procedure StaticButtonsDefault(Sender: TObject);
    procedure StaticButtonsDefaultMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure button_MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
    procedure Help_QClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Sel_Stud_OKClick(Sender: TObject);
    procedure Sel_Stud_CancelClick(Sender: TObject);
    procedure edt_StudInfoKeyPress(Sender: TObject; var Key: Char);
    procedure Sel_Stud_BrowseClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
  public
    PHandle             : HWND;
    { Public declarations }
  end;

var
  Dialog_Select_Student: TDialog_Select_Student;

implementation
uses ContextHelp;
{$R *.dfm}

(*
 * TDialog_Select_Student.StaticButtonsDefault
 *)

procedure TDialog_Select_Student.StaticButtonsDefault(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Student.StaticButtonsDefault (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 diMakeStaticTextDefault(Sel_Stud_OK);
 diMakeStaticTextDefault(Sel_Stud_Cancel);
 diMakeStaticTextDefault(Sel_Stud_Browse);


  Color:=FormColor;
  Font.Charset:=FormCharset;
  Font.Color:=FormFontColor;
  Font.Size:=FormFontSize;
  Font.Name:=MainUsedFont;
  Font.Style:=FormFontStyles;

   edt_StudInfo.Color      := _eEditColor;
   edt_StudInfo.Font.Color := _fEditColor;

   edt_ExportFile.Color      := _eEditColor;
   edt_ExportFile.Font.Color := _fEditColor;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Student.StaticButtonsDefault = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Student.StaticButtonsDefaultMove
 *)

procedure TDialog_Select_Student.StaticButtonsDefaultMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TDialog_Select_Student.StaticButtonsDefaultMove (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

 diMakeStaticTextDefault(Sel_Stud_OK);
 diMakeStaticTextDefault(Sel_Stud_Cancel);
 diMakeStaticTextDefault(Sel_Stud_Browse);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Student.StaticButtonsDefaultMove = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Student.FormContextPopup
 *)

procedure TDialog_Select_Student.FormContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Student.FormContextPopup (Sender:'+DbgObject(Sender)+'; MousePos:'+DbgPoint(MousePos)+'; var Handled:'+DbgBool(Handled)+')');
   DbgPlus;
 {$ENDIF}

 if CurrentHelpFile='' then Exit;

 Handled:=True;
 OHelpContext := (Sender as TControl).HelpContext;
 OHelpPage    := (Sender as TControl).HelpKeyword;
 
 Context_Help.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Student.FormContextPopup ( var Handled:'+DbgBool(Handled)+' ) = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Student.button_MouseMove
 *)

procedure TDialog_Select_Student.button_MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TDialog_Select_Student.button_MouseMove (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextActive(Sender as TJvStaticText);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Student.button_MouseMove = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Student.Help_QClick
 *)

procedure TDialog_Select_Student.Help_QClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Student.Help_QClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 ContextHelp.PopupPoint:=Context_Help.PopupPoint;
 Context_Form.Help_QDisplay;

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Student.Help_QClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Student.FormShow
 *)

procedure TDialog_Select_Student.FormShow(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Student.FormShow (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 PlaySoundEvent( sndDlgTick );
 Help_Q.Caption:=WHATISTHIS;
 Sel_Stud_OK.Caption:=DLGOK;
 Sel_Stud_Cancel.Caption:=DLGCANCEL;

 Caption:=Dialog_C_SS;
 Lbl_StudName.Caption := SS_StudName;
 lbl_ExportFile.Caption := SS_ExportFile;

 diMakeStaticTextDefault(Sel_Stud_OK);
 diMakeStaticTextDefault(Sel_Stud_Cancel);
 diMakeStaticTextDefault(Sel_Stud_Browse);

 msSetMenuStyles( Context_Help );
 
  ExportSaveDialog.Filter := HtmlFilter;

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Student.FormShow = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Student.Sel_Stud_OKClick
 *)

procedure TDialog_Select_Student.Sel_Stud_OKClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Student.Sel_Stud_OKClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}
 PlaySoundEvent( sndJustTick );
 if edt_ExportFile.Text = '' then begin ActiveControl:=edt_ExportFile; Exit;end;
 PostMessage(PHandle,WM_SelectStudentClose,0,0);
 Close;

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Student.Sel_Stud_OKClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Student.Sel_Stud_CancelClick
 *)

procedure TDialog_Select_Student.Sel_Stud_CancelClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Student.Sel_Stud_CancelClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}
  PlaySoundEvent( sndJustTick );
 Close;

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Student.Sel_Stud_CancelClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Student.edt_StudInfoKeyPress
 *)

procedure TDialog_Select_Student.edt_StudInfoKeyPress(Sender: TObject;
  var Key: Char);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Student.edt_StudInfoKeyPress (Sender:'+DbgObject(Sender)+'; var Key:'+DbgChar(Key)+')');
   DbgPlus;
 {$ENDIF}

 if Key = #13 then
  Sel_Stud_OK.OnClick(Sel_Stud_OK);

 if Key = #27 then
  Sel_Stud_OK.OnClick(Sel_Stud_Cancel);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Student.edt_StudInfoKeyPress ( var Key:'+DbgChar(Key)+' ) = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Student.Sel_Stud_BrowseClick
 *)

procedure TDialog_Select_Student.Sel_Stud_BrowseClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Student.Sel_Stud_BrowseClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  ExportSaveDialog.Title := Save_Title;
  
 if (ExerciseEditorMode) and (DirectoryExists(PChar(MyDocuments)+'\'+MyExercisesHtml))
    then ExportSaveDialog.InitialDir:= PChar(MyDocuments)+'\'+MyExercisesHtml else
  if (TestEditorMode) and (DirectoryExists(PChar(MyDocuments)+'\'+MyTestsHtml))
    then ExportSaveDialog.InitialDir:= PChar(MyDocuments)+'\'+MyTestsHtml else
  if DirectoryExists(PChar(MyDocuments)+'\'+MySources)
    then ExportSaveDialog.InitialDir:= PChar(MyDocuments)+'\'+MySources else
      begin
       ExportSaveDialog.InitialDir:= PChar(MyDocuments);
      end;

  ExportSaveDialog.FileName := '';
  
  if ExportSaveDialog.Execute then
   edt_ExportFile.Text := ExportSaveDialog.FileName;

    if (edt_ExportFile.Text <> '') and(ExtractFileExt(edt_ExportFile.Text) = '')
    then edt_ExportFile.Text := edt_ExportFile.Text + extFileHtml;

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Student.Sel_Stud_BrowseClick = void');
 {$ENDIF}
end;

procedure TDialog_Select_Student.FormActivate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Student.FormActivate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Student.FormActivate = void');
 {$ENDIF}
end;

end.
