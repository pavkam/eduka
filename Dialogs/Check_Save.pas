(*


The Original Code is: Check_Save.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains Dialog_Check_Save definition that is used to display
    our custom Yes/No/Cancel Dialog.
*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit Check_Save;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,DesignInside,
  Dialogs, StdCtrls, Translate, Menus, jpeg, ExtCtrls, Utils, ProTypes,
  JvMenus, JvExControls, JvComponent, JvStaticText, JvExExtCtrls, JvImage,
  ImgList, JvImageList
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;

{$IFDEF _DEBUG_}
Const
  DbgUName  =  '/Dialogs/Check_Save.pas';
{$ENDIF}

type
  TDialog_Check_Save = class(TForm)
    Check_Save_Yes    : TJvStaticText;
    Check_Save_Cancel : TJvStaticText;
    Check_Save_No     : TJvStaticText;
    Context_Help      : TJvPopupMenu;
    Help_Q            : TMenuItem;

    Text_Q            : TMemo;
    imgInformation: TImage;
    ImageList: TJvImageList;
    imgError: TImage;
    imgKeys: TImage;

    procedure Button_MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure Check_Save_YesClick(Sender: TObject);
    procedure Check_Save_NoClick(Sender: TObject);
    procedure Check_Save_CancelClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure Help_QClick(Sender: TObject);
    procedure HelpContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure Text_QEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure SetMessageIcon( Ico : Integer );
    procedure InformativeMessage( sTitle, sMessage : String; Ico : Integer );
  private
    { Private declarations }
  public
    { Public declarations }
    IsOneKey    : Boolean;
    HasNewTitle : String;
  end;

var
  Dialog_Check_Save: TDialog_Check_Save;

implementation

uses ContextHelp;
{$R *.dfm}


procedure TDialog_Check_Save.InformativeMessage( sTitle, sMessage : String; Ico : Integer );
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TDialog_Check_Save.InformativeMessage (sTitle:'+DbgStr(sTitle)+';sMessage:'+DbgStr(sMessage)+')');
   DbgPlus;
 {$ENDIF}

   Text_Q.Text := sMessage;
   HasNewTitle := sTitle;
   IsOneKey    := True;

   SetMessageIcon( Ico );

   ShowModal();

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Check_Save.InformativeMessage = void');
 {$ENDIF}
end;

(*
 * TDialog_Check_Save.button_MouseMove
 *)

procedure TDialog_Check_Save.button_MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TDialog_Check_Save.button_MouseMove (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextActive(Sender as TJvStaticText);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Check_Save.button_MouseMove = void');
 {$ENDIF}
end;


(*
 * TDialog_Check_Save.FormShow
 *)

procedure TDialog_Check_Save.FormShow(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Check_Save.FormShow (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}
  PlaySoundEvent ( sndInformation );

  diMakeStaticTextDefault(Check_Save_Yes);
  diMakeStaticTextDefault(Check_Save_No);
  diMakeStaticTextDefault(Check_Save_Cancel);
  
  msSetMenuStyles( Context_Help );

  Help_Q.Caption         :=WHATISTHIS;
  Check_Save_Yes.Caption :=DLGYES;
  Check_Save_No.Caption  :=DLGNO;

  if IsOneKey then
    begin
     Check_Save_Yes.Visible    := False;
     Check_Save_No.Visible     := False;
     Check_Save_Cancel.Caption := DLGOK;

    end else
    begin
     Check_Save_Yes.Visible    := True;
     Check_Save_No.Visible     := True;
     Check_Save_Cancel.Caption := DLGCANCEL;

    end;

   if HasNewTitle <> '' then
           Caption := HasNewTitle else
           Caption := Dialog_C_CS;

   IsOneKey    := False;
   HasNewTitle := '';

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Check_Save.FormShow = void');
 {$ENDIF}
end;


(*
 * TDialog_Check_Save.Check_Save_YesClick
 *)

procedure TDialog_Check_Save.Check_Save_YesClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Check_Save.Check_Save_YesClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

   PlaySoundEvent( sndJustTick );
   ModalResult:=mrYes;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Check_Save.Check_Save_YesClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Check_Save.Check_Save_NoClick
 *)

procedure TDialog_Check_Save.Check_Save_NoClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Check_Save.Check_Save_NoClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}


   PlaySoundEvent( sndJustTick );
   ModalResult:=mrNo;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Check_Save.Check_Save_NoClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Check_Save.Check_Save_CancelClick
 *)

procedure TDialog_Check_Save.Check_Save_CancelClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Check_Save.Check_Save_CancelClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}


   PlaySoundEvent( sndJustTick );
   ModalResult:=mrCancel;


 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Check_Save.Check_Save_CancelClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Check_Save.FormMouseMove
 *)

procedure TDialog_Check_Save.FormMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TDialog_Check_Save.FormMouseMove (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextDefault(Check_Save_Yes);
  diMakeStaticTextDefault(Check_Save_No);
  diMakeStaticTextDefault(Check_Save_Cancel);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Check_Save.FormMouseMove = void');
 {$ENDIF}
end;


(*
 * TDialog_Check_Save.Help_QClick
 *)

procedure TDialog_Check_Save.Help_QClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Check_Save.Help_QClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 ContextHelp.PopupPoint:=Context_Help.PopupPoint;
 Context_Form.Help_QDisplay;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Check_Save.Help_QClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Check_Save.HelpContextPopup
 *)

procedure TDialog_Check_Save.HelpContextPopup(
  Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Check_Save.HelpContextPopup (Sender:'+DbgObject(Sender)+'; MousePos:'+DbgPoint(MousePos)+'; var Handled:'+DbgBool(Handled)+')');
   DbgPlus;
 {$ENDIF}

 if CurrentHelpFile='' then Exit;

 Handled:=True;
 OHelpContext := (Sender as TControl).HelpContext;
 OHelpPage    := (Sender as TControl).HelpKeyword;

 Context_Help.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Check_Save.HelpContextPopup ( var Handled:'+DbgBool(Handled)+' ) = void');
 {$ENDIF}
end;


(*
 * TDialog_Check_Save.FormActivate
 *)

procedure TDialog_Check_Save.FormActivate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Check_Save.FormActivate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}


 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Check_Save.FormActivate = void');
 {$ENDIF}
end;


(*
 * TDialog_Check_Save.Text_QEnter
 *)

procedure TDialog_Check_Save.Text_QEnter(Sender: TObject);
begin
  {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Check_Save.Text_QEnter (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 ActiveControl:=nil;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Check_Save.Text_QEnter = void');
 {$ENDIF}
end;


(*
 * TDialog_Check_Save.FormCreate
 *)

procedure TDialog_Check_Save.FormCreate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Check_Save.FormCreate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}
  IsOneKey    := false;
  HasNewTitle := '';

  diMakeStaticTextDefault(Check_Save_Yes);
  diMakeStaticTextDefault(Check_Save_No);
  diMakeStaticTextDefault(Check_Save_Cancel);

  Color:=FormColor;
  Font.Charset:=FormCharset;
  Font.Color:=FormFontColor;
  Font.Size:=FormFontSize;
  Font.Name:=MainUsedFont;
  Font.Style:=FormFontStyles;

  Text_Q.Color:=MemoColor;
  Text_Q.Font.Charset:=MemoCharset;
  Text_Q.Font.Color:=MemoFontColor;
  Text_Q.Font.Size:=MemoFontSize;
  Text_Q.Font.Name:=MainUsedFont;
  Text_Q.Font.Style:=MemoFontStyles;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Check_Save.FormCreate = void');
 {$ENDIF}
end;


(*
 * TDialog_Check_Save.FormKeyPress
 *)

procedure TDialog_Check_Save.FormKeyPress(Sender: TObject; var Key: Char);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Check_Save.FormKeyPress (Sender:'+DbgObject(Sender)+'; var Key:'+DbgChar(Key)+')');
   DbgPlus;
 {$ENDIF}

 if Key=#27 then Check_Save_Cancel.OnClick(Check_Save_Cancel);
 if Key=#13 then Check_Save_Yes.OnClick(Check_Save_Yes);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Check_Save.FormKeyPress ( var Key:'+DbgChar(Key)+' ) = void');
 {$ENDIF}
end;

procedure TDialog_Check_Save.SetMessageIcon(Ico: Integer);
begin
   imgInformation.Visible := False;
   imgError.Visible := False;
   imgKeys.Visible := False;

   case Ico of
    1: imgInformation.Visible := True;
    2: imgError.Visible := True;
    3: imgKeys.Visible := True;
   end;
end;

end.
