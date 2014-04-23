(*

The Original Code is: Select_Condition.pas, released 2005-02-02.
Authors of this file are Popov John and Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains Select_Condition definition.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}

unit Select_Condition;
interface
Uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls , DesignInside, Translate, ProTypes, Menus, ContextHelp,
   Utils, JvMenus, JvDotNetControls, JvExControls, JvComponent, JvStaticText,
  ImgList, JvImageList
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;

{$IFDEF _DEBUG_}
Const
  DbgUName  =  '/Dialogs/Select_Condition.pas';
{$ENDIF}


type
  TDialog_Select_Condition = class(TForm)
    Condition_Box: TJvDotNetListBox;
    Sel_Cond_OK: TJvStaticText;
    Context_Help: TJvPopupMenu;
    Help_Q             : TMenuItem;
    ImageList: TJvImageList;

    procedure StaticButtonsDefault   (Sender: TObject);
    procedure FormActivate           (Sender: TObject);
    procedure Sel_Cond_OKClick       (Sender: TObject);
    procedure Button_MouseMove       (Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure StaticButtonsDefaultMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Help_QClick(Sender: TObject);
    procedure HelpContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure condition_BoxKeyPress(Sender: TObject; var Key: Char);
    procedure condition_BoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    PHandle             : HWND;
    SelectedCondition   : String;
  end;

Var
  Dialog_Select_Condition: TDialog_Select_Condition;

implementation
{$R *.dfm}


(*
 * TDialog_Select_Condition.button_MouseMove
 *)

procedure TDialog_Select_Condition.button_MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TDialog_Select_Condition.button_MouseMove (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;                             
 {$ENDIF}

  diMakeStaticTextActive(Sel_Cond_Ok);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Condition.button_MouseMove = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Condition.StaticButtonsDefault
 *)

procedure TDialog_Select_Condition.StaticButtonsDefault(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Condition.StaticButtonsDefault (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextDefault(Sel_Cond_OK);

  Color:=FormColor;
  Font.Charset:=FormCharset;
  Font.Color:=FormFontColor;
  Font.Size:=FormFontSize;
  Font.Name:=MainUsedFont;
  Font.Style:=FormFontStyles;

  Condition_Box.Color:=ListBoxColor;
  Condition_Box.Font.Charset:=ListBoxCharset;
  Condition_Box.Font.Color:=ListBoxFontColor;
  Condition_Box.Font.Size:=ListBoxFontSize;
  Condition_Box.Font.Name:=MainUsedFont;
  Condition_Box.Font.Style:=ListBoxFontStyles;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Condition.StaticButtonsDefault = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Condition.FormActivate
 *)

procedure TDialog_Select_Condition.FormActivate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Condition.FormActivate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  SelectedCondition:='';

 if CurrentInterpreter = piKng then
  begin
   Condition_Box.Clear;
   Condition_Box.Items.Add(SY_IS_LINE);
   Condition_Box.ItemIndex :=1;
   Condition_Box.Items.Add(SY_IS_BORDER);
   Condition_Box.ItemIndex :=2;
   Condition_Box.Items.Add(SY_NOT+' '+SY_IS_LINE);
   Condition_Box.ItemIndex :=3;
   Condition_Box.Items.Add(SY_NOT+' '+SY_IS_BORDER);
   Condition_Box.ItemIndex :=4;
  end;
  if CurrentInterpreter = piAnt then
  begin
   Condition_Box.Clear;
   Condition_Box.Items.Add(SY_IS_BORDER);
   Condition_Box.ItemIndex :=1;
   Condition_Box.Items.Add(SY_NOT+' '+SY_IS_BORDER);
   Condition_Box.ItemIndex :=2;
  end;
  if CurrentInterpreter = piTux then
  begin
   Condition_Box.Clear;

   Condition_Box.Items.Add(SY_COND1);
   Condition_Box.Items.Add(SY_COND2);
   Condition_Box.Items.Add(SY_COND3);
   Condition_Box.Items.Add(SY_COND4_+' [MEM]');
   Condition_Box.Items.Add(SY_COND5);
   Condition_Box.Items.Add(SY_COND6);
   Condition_Box.Items.Add(SY_COND7);
   Condition_Box.Items.Add(SY_COND8_+' [LET]');
   Condition_Box.Items.Add(SY_COND9_+' [LET]');
   Condition_Box.Items.Add(SY_COND10_+' [LET]');
   Condition_Box.Items.Add(SY_COND11_+' [LET]');
   Condition_Box.Items.Add(SY_COND12_+' [LET]');
   Condition_Box.Items.Add(SY_COND13_+' [LET]');
   Condition_Box.Items.Add(SY_COND14);
   Condition_Box.Items.Add(SY_COND15);
   Condition_Box.Items.Add(SY_COND16);
   Condition_Box.Items.Add(SY_COND17);
   Condition_Box.Items.Add(SY_COND18);
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND1);
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND2);
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND3);
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND4_+' [MEM]');
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND5);
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND6);
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND7);
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND8_+' [LET]');
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND9_+' [LET]');
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND10_+' [LET]');
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND11_+' [LET]');
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND12_+' [LET]');
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND13_+' [LET]');
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND14);
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND15);
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND16);
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND17);
   Condition_Box.Items.Add(SY_NOT+' '+SY_COND18);

   Condition_Box.ItemIndex :=36;

  end;
  Condition_Box.Selected[0]:=true;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Condition.FormActivate = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Condition.Sel_Cond_OKClick
 *)


procedure TDialog_Select_Condition.Sel_Cond_OKClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Condition.Sel_Cond_OKClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 // Save The returned condition
  PlaySoundEvent( sndJustTick );
 SelectedCondition:=(Dialog_Select_Condition.Condition_Box.Items.Strings
                                   [Dialog_Select_Condition.Condition_Box.ItemIndex]);

 // Deactivate this form
 PostMessage(PHandle,WM_SelectConditionClose,0,0);
 Dialog_Select_Condition.Close;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Condition.Sel_Cond_OKClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Condition.StaticButtonsDefaultMove
 *)

procedure TDialog_Select_Condition.StaticButtonsDefaultMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TDialog_Check_Save.StaticButtonsDefaultMove (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

 diMakeStaticTextDefault(Sel_Cond_OK);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Condition.StaticButtonsDefaultMove = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Condition.Help_QClick
 *)

procedure TDialog_Select_Condition.Help_QClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Condition.Help_QClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 ContextHelp.PopupPoint:=Context_Help.PopupPoint;
 Context_Form.Help_QDisplay;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Condition.Help_QClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Condition.HelpContextPopup
 *)

procedure TDialog_Select_Condition.HelpContextPopup(
  Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Condition.HelpContextPopup (Sender:'+DbgObject(Sender)+'; MousePos:'+DbgPoint(MousePos)+'; var Handled:'+DbgBool(Handled)+')');
   DbgPlus;
 {$ENDIF}

 if CurrentHelpFile='' then Exit;

 Handled:=True;
 OHelpContext := (Sender as TControl).HelpContext;
 OHelpPage    := (Sender as TControl).HelpKeyword;
 
 Context_Help.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Condition.HelpContextPopup ( var Handled:'+DbgBool(Handled)+' ) = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Condition.FormShow
 *)

procedure TDialog_Select_Condition.FormShow(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Condition.FormShow (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 PlaySoundEvent( sndDlgTick );

 Help_Q.Caption:=WHATISTHIS;
 Sel_Cond_OK.Caption:=DLGOK;
 Caption:=Dialog_C_SC;

 msSetMenuStyles( Context_Help );

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Condition.FormShow = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Condition.condition_BoxKeyPress
 *)

procedure TDialog_Select_Condition.condition_BoxKeyPress(Sender: TObject;
  var Key: Char);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Condition.condition_BoxKeyPress (Sender:'+DbgObject(Sender)+'; var Key:'''+Key+''')');
   DbgPlus;
 {$ENDIF}

 if Key=#27 then Close;
 if Key=#13 then Sel_Cond_Ok.OnClick(Sel_Cond_Ok);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Condition.condition_BoxKeyPress ( var Key:'+DbgChar(Key)+' ) = void');
 {$ENDIF}
end;

procedure TDialog_Select_Condition.condition_BoxClick(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
end;

end.
