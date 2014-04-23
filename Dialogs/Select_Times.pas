(*

The Original Code is: Select_Times.pas, released 2005-02-02.
Authors of this file are Popov John and Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains Select_Times definition. Select a number of iterations
    for Repeat instruction.
*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit Select_Times;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DesignInside, ProTypes, Translate, Utils,
  Menus, Spin, JvMenus, JvExControls, JvComponent, JvStaticText, ImgList, JvImageList
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;

{$IFDEF _DEBUG_}
Const
  DbgUName  =  '/Dialogs/Select_Times.pas';
{$ENDIF}

type
  TDialog_Select_Times = class(TForm)
    Sel_Times_OK: TJvStaticText;
    Select_Dialog_SpinEdit : TSpinEdit;
    Context_Help: TJvPopupMenu;
    Help_Q                 : TMenuItem;
    ImageList: TJvImageList;

    procedure button_MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
    procedure Sel_Times_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DefaultMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure Help_QClick(Sender: TObject);
    procedure HelpContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure Select_Dialog_SpinEditKeyPress(Sender: TObject; var Key: Char);
    procedure Select_Dialog_SpinEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
  public
    { Public declarations }

    PHandle : HWND;
    RepeatTimes : String;
  end;

var
  Dialog_Select_Times: TDialog_Select_Times;

implementation

uses ContextHelp;
{$R *.dfm}


(*
 * TDialog_Select_Times.button_MouseMove
 *)

procedure TDialog_Select_Times.button_MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TDialog_Select_Times.button_MouseMovee (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextActive((Sender as TJvStaticText));

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Times.button_MouseMove = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Times.Sel_Times_OKClick
 *)

procedure TDialog_Select_Times.Sel_Times_OKClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Times.Sel_Times_OKClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}
 PlaySoundEvent( sndJustTick );
 Str(Select_Dialog_SpinEdit.Value,RepeatTimes);
 Dialog_Select_Times.Hide;
 PostMessage(PHandle,WM_SelectTimesClose,0,0);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Times.Sel_Times_OKClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Times.FormCreate
 *)

procedure TDialog_Select_Times.FormCreate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Times.FormCreate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextDefault(Sel_Times_Ok);
  Color:=FormColor;
  Font.Charset:=FormCharset;
  Font.Color:=FormFontColor;
  Font.Size:=FormFontSize;
  Font.Name:=MainUsedFont;
  Font.Style:=FormFontStyles;

  Select_Dialog_SpinEdit.Color:=SpinEditColor;
  Select_Dialog_SpinEdit.Font.Charset:=SpinEditCharset;
  Select_Dialog_SpinEdit.Font.Color:=SpinEditFontColor;
  Select_Dialog_SpinEdit.Font.Size:=SpinEditFontSize;
  Select_Dialog_SpinEdit.Font.Name:=MainUsedFont;
  Select_Dialog_SpinEdit.Font.Style:=SpinEditFontStyles;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Times.FormCreate = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Times.DefaultMouseMove
 *)

procedure TDialog_Select_Times.DefaultMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TDialog_Select_Times.DefaultMouseMove (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextDefault(Sel_Times_Ok);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Times.DefaultMouseMove = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Times.FormActivate
 *)

procedure TDialog_Select_Times.FormActivate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Times.FormActivate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 Select_Dialog_SpinEdit.Value:=0;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Times.FormActivate = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Times.Help_QClick
 *)

procedure TDialog_Select_Times.Help_QClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Times.Help_QClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 ContextHelp.PopupPoint:=Context_Help.PopupPoint;
 Context_Form.Help_QDisplay;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Times.Help_QClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Times.HelpContextPopup
 *)

procedure TDialog_Select_Times.HelpContextPopup(
  Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Times.HelpContextPopup (Sender:'+DbgObject(Sender)+'; MousePos:'+DbgPoint(MousePos)+'; var Handled:'+DbgBool(Handled)+')');
   DbgPlus;
 {$ENDIF}

 if CurrentHelpFile='' then Exit;

 Handled:=True;
 OHelpContext := (Sender as TControl).HelpContext;
 OHelpPage    := (Sender as TControl).HelpKeyword;
 
 Context_Help.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Times.HelpContextPopup ( var Handled:'+DbgBool(Handled)+' ) = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Times.FormShow
 *)

procedure TDialog_Select_Times.FormShow(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Times.FormShow (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 PlaySoundEvent( sndDlgTick );
 Help_Q.Caption:=WHATISTHIS;
 Sel_Times_OK.Caption:=DLGOK;
 Caption:=Dialog_C_ST;

 msSetMenuStyles( Context_Help );

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Times.FormShow = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Times.Select_Dialog_SpinEditKeyPress
 *)

procedure TDialog_Select_Times.Select_Dialog_SpinEditKeyPress(
  Sender: TObject; var Key: Char);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Times.Select_Dialog_SpinEditKeyPress (Sender:'+DbgObject(Sender)+'; var Key:'+DbgChar(Key)+')');
   DbgPlus;
 {$ENDIF}

 if Key=#27 then Close;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Times.Select_Dialog_SpinEditKeyPress ( var Key:'+DbgChar(Key)+' ) = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Times.Select_Dialog_SpinEditKeyUp
 *)

procedure TDialog_Select_Times.Select_Dialog_SpinEditKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Times.Select_Dialog_SpinEditKeyPress (Sender:'+DbgObject(Sender)+'; var Key:'+DbgInt(Key)+'; Shift:'+DbgShift(Shift)+')');
   DbgPlus;
 {$ENDIF}

   if Key=13 then Sel_Times_OK.OnClick(Sel_Times_OK);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Times.Select_Dialog_SpinEditKeyPress ( var Key:'+DbgInt(Key)+' ) = void');
 {$ENDIF}
end;

end.
