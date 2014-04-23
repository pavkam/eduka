(*

The Original Code is: Select_Interpreter.pas, released 2005-02-02.
Authors of this file are Popov John and Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains Select_Interpreter definition. This dialog is used
    to change the current interpreter.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit Select_Interpreter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, DesignInside, ProTypes, Translate, JvStaticText,
  Menus, Jpeg, Utils, JvMenus, JvExExtCtrls, JvImage, JvExControls, JvComponent,
  ImgList, JvImageList
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;

{$IFDEF _DEBUG_}
Const
  DbgUName  =  '/Dialogs/Select_Interpreter.pas';
{$ENDIF}

type
  TDialog_Select_Interpreter = class(TForm)

    SupportPanel     : TPanel;
    ImagingPanel     : TPanel;
    Bevel1           : TBevel;
    Bevel2           : TBevel;
    Speed_Kng: TSpeedButton;
    Speed_ant        : TSpeedButton;
    Speed_tux        : TSpeedButton;
    Sel_Inter_Cancel: TJvStaticText;
    Sel_Inter_OK: TJvStaticText;
    Image_ant: TImage;
    Image_Kng: TImage;
    Image_tux: TImage;
    Context_Help: TJvPopupMenu;
    Help_Q           : TMenuItem;
    ImageList: TJvImageList;

    procedure Button_MouseMove      (Sender: TObject;  Shift: TShiftState; X, Y: Integer);
    procedure FormClose             (Sender: TObject; var Action: TCloseAction);
    procedure FormActivate          (Sender: TObject);
    procedure Sel_Inter_OKClick     (Sender: TObject);
    procedure FormCreate            (Sender: TObject);
    procedure Speed_Click(Sender: TObject);
    procedure Sel_Inter_CancelClick(Sender: TObject);
    procedure Help_QClick(Sender: TObject);
    procedure HelpContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);


  private
    { Private declarations }
  public
    { Public declarations }
    PHandle : HWND;
  end;

var
  Dialog_Select_Interpreter: TDialog_Select_Interpreter;

implementation

uses ContextHelp;
{$R *.dfm}


(*
 * TDialog_Select_Interpreter.button_MouseMove
 *)

procedure TDialog_Select_Interpreter.button_MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.button_MouseMove (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

 diMakeStaticTextActive(Sender as TJvStaticText);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.button_MouseMove = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Interpreter.FormClose
 *)

procedure TDialog_Select_Interpreter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.FormClose (Sender:'+DbgObject(Sender)+'; var Action:'+DbgAction(Action)+')');
   DbgPlus;
 {$ENDIF}

  if CurrentInterpreter = piKng then Speed_Kng.Down:=True;
  if CurrentInterpreter = piAnt then Speed_Ant.Down:=True;
  if CurrentInterpreter = piTux then Speed_Tux.Down:=True;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TDialog_Select_Interpreter.FormClose ( var Action:'+DbgAction(Action)+' ) = void');
{$ENDIF}
end;


(*
 * TDialog_Select_Interpreter.FormActivate
 *)

procedure TDialog_Select_Interpreter.FormActivate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.FormActivate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextDefault(Sel_Inter_OK);
     diMakeStaticTextDefault(Sel_Inter_Cancel);


  if CurrentInterpreter = piKng then Speed_Kng.Down:=True;
  if CurrentInterpreter = piAnt then Speed_Ant.Down:=True;
  if CurrentInterpreter = piTux then Speed_Tux.Down:=True;

  if CurrentInterpreter = piKng then
   begin
    Image_Kng.Visible:=True;
    Image_Ant.Visible:=False;
    Image_Tux.Visible:=False;
   end;
  if CurrentInterpreter = piAnt      then
   begin
    Image_Kng.Visible:=False;
    Image_Ant.Visible:=True;
    Image_Tux.Visible:=False;
   end;
  if CurrentInterpreter = piTux      then
   begin
    Image_Kng.Visible:=False;
    Image_Ant.Visible:=False;
    Image_Tux.Visible:=True;
   end;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.FormActivate = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Interpreter.Sel_Inter_OKClick
 *)

procedure TDialog_Select_Interpreter.Sel_Inter_OKClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.Sel_Inter_OKClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 PlaySoundEvent( sndJustTick );
 PostMessage(PHandle,WM_SelectInterpreterClose,0,0);
 Dialog_Select_Interpreter.Hide;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.Sel_Inter_OKClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Interpreter.FormCreate
 *)

procedure TDialog_Select_Interpreter.FormCreate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.Sel_Inter_OKClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextDefault(Sel_Inter_OK);
  diMakeStaticTextDefault(Sel_Inter_Cancel);

  Color:=FormColor;
  Font.Charset:=FormCharset;
  Font.Color:=FormFontColor;
  Font.Size:=FormFontSize;
  Font.Name:=MainUsedFont;
  Font.Style:=FormFontStyles;

  SupportPanel.Color:=PanelColor;
  SupportPanel.Font.Charset:=PanelCharset;
  SupportPanel.Font.Color:=PanelFontColor;
  SupportPanel.Font.Size:=PanelFontSize;
  SupportPanel.Font.Name:=MainUsedFont;
  SupportPanel.Font.Style:=PanelFontStyles;

  Speed_Kng.Font.Charset:=SpeedButtonCharset;
  Speed_Kng.Font.Color:=SpeedButtonFontColor;
  Speed_Kng.Font.Size:=SpeedButtonFontSize;
  Speed_Kng.Font.Name:=MainUsedFont;
  Speed_Kng.Font.Style:=SpeedButtonFontStyles;

  Speed_Ant.Font.Charset:=SpeedButtonCharset;
  Speed_Ant.Font.Color:=SpeedButtonFontColor;
  Speed_Ant.Font.Size:=SpeedButtonFontSize;
  Speed_Ant.Font.Name:=MainUsedFont;
  Speed_Ant.Font.Style:=SpeedButtonFontStyles;

  Speed_Tux.Font.Charset:=SpeedButtonCharset;
  Speed_Tux.Font.Color:=SpeedButtonFontColor;
  Speed_Tux.Font.Size:=SpeedButtonFontSize;
  Speed_Tux.Font.Name:=MainUsedFont;
  Speed_Tux.Font.Style:=SpeedButtonFontStyles;

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.Sel_Inter_OKClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Interpreter.Speed_Click
 *)

procedure TDialog_Select_Interpreter.Speed_Click(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.Speed_Click (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}
 
 PlaySoundEvent( sndJustTick );
 Image_Kng.Visible := (Sender as TComponent).Name = 'Speed_Kng';
 Image_Ant.Visible := (Sender as TComponent).Name = 'Speed_ant';
 Image_Tux.Visible := (Sender as TComponent).Name = 'Speed_tux';

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.Speed_Click = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Interpreter.Sel_Inter_CancelClick
 *)

procedure TDialog_Select_Interpreter.Sel_Inter_CancelClick( Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.Sel_Inter_CancelClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 Hide;
 PlaySoundEvent( sndJustTick );
  if CurrentInterpreter = piKng then Speed_Kng.Down:=True;
  if CurrentInterpreter = piAnt then Speed_ant.Down:=True;
  if CurrentInterpreter = piTux then Speed_tux.Down:=True;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.Sel_Inter_CancelClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Interpreter.Help_QClick
 *)

procedure TDialog_Select_Interpreter.Help_QClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.Help_QClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 ContextHelp.PopupPoint:=Context_Help.PopupPoint;
 Context_Form.Help_QDisplay;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.Help_QClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Interpreter.HelpContextPopup
 *)

procedure TDialog_Select_Interpreter.HelpContextPopup(
  Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.HelpContextPopup (Sender:'+DbgObject(Sender)+'; MousePos:'+DbgPoint(MousePos)+'; var Handled:'+DbgBool(Handled)+')');
   DbgPlus;
 {$ENDIF}

 if CurrentHelpFile='' then Exit;

 Handled:=True;
 OHelpContext := (Sender as TControl).HelpContext;
 OHelpPage    := (Sender as TControl).HelpKeyword; 
 Context_Help.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.HelpContextPopup ( var Handled:'+DbgBool(Handled)+' ) = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Interpreter.FormShow
 *)

procedure TDialog_Select_Interpreter.FormShow(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.FormShow (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}
 PlaySoundEvent( sndDlgTick );

 Help_Q.Caption:=WHATISTHIS;
 Sel_Inter_OK.Caption:=DLGOK;
 Sel_Inter_Cancel.Caption:=DLGCANCEL;
 Speed_Kng.Caption:=Dialog_I_Kng;
 Speed_ant.Caption:=Dialog_I_Ant;
 Speed_tux.Caption:=Dialog_I_Tux;
 Caption:=Dialog_C_SI;
 
 msSetMenuStyles( Context_Help );

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.FormShow = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Interpreter.FormMouseMove
 *)

procedure TDialog_Select_Interpreter.FormMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.FormMouseMove (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextDefault(Sel_Inter_OK);
  diMakeStaticTextDefault(Sel_Inter_Cancel);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Interpreter.FormMouseMove = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Interpreter.FormKeyDown
 *)

procedure TDialog_Select_Interpreter.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Condition.condition_BoxKeyPress (Sender:'+DbgObject(Sender)+'; var Key:'+DbgInt(Key)+')');
   DbgPlus;
 {$ENDIF}

 if Key=27 then Sel_Inter_Cancel.OnClick(Sel_Inter_Cancel);
 if Key=13 then Sel_Inter_OK.OnClick(Sel_Inter_OK);
 
 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Condition.condition_BoxKeyPress ( var Key:'+DbgInt(Key)+' ) = void');
 {$ENDIF}
end;

end.
