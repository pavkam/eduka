(*

The Original Code is: Select_Name.pas, released 2005-02-02.
Authors of this file are Popov John and Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains Select_Interpreter definition. Select a name from a ComboBox
    or enter a new one. Used for Memories/Procedures
*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit Select_Name;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DesignInside, ProTypes, Menus, Translate, Utils,
  JvMenus, JvExControls, JvComponent, JvStaticText
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;

{$IFDEF _DEBUG_}
Const
  DbgUName  =  '/Dialogs/Select_Name.pas';
{$ENDIF}

type
  TDialog_Select_Name = class(TForm)
    Sel_Name_OK: TJvStaticText;
    Select_Name_Edit : TComboBox;
    Context_Help: TJvPopupMenu;
    Help_Q           : TMenuItem;

    procedure button_MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
    procedure Sel_Name_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DefaultMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Help_QClick(Sender: TObject);
    procedure HelpContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Select_Name_EditKeyPress(Sender: TObject; var Key: Char);
    procedure Select_Name_EditDropDown(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    ProcName           : String;
    InternalDialogName : String;
    PHandle  : HWND;
  end;

var
  Dialog_Select_Name: TDialog_Select_Name;

implementation

uses ContextHelp;
{$R *.dfm}


(*
 * TDialog_Select_Name.FormKeyDown
 *)

procedure TDialog_Select_Name.button_MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TDialog_Select_Name.button_MouseMove (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

   diMakeStaticTextActive((Sender as TJvStaticText));

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Name.button_MouseMove = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Name.Sel_Name_OKClick
 *)

procedure TDialog_Select_Name.Sel_Name_OKClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Name.Sel_Name_OKClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}
 
 PlaySoundEvent( sndJustTick );
 ProcName:=Select_Name_Edit.Text;
 Dialog_Select_Name.Hide;

 PostMessage(PHandle,WM_SelectNameClose,0,0);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Name.Sel_Name_OKClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Name.FormCreate
 *)

procedure TDialog_Select_Name.FormCreate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Name.FormCreate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 diMakeStaticTextDefault(Sel_Name_OK);

  Color:=FormColor;
  Font.Charset:=FormCharset;
  Font.Color:=FormFontColor;
  Font.Size:=FormFontSize;
  Font.Name:=MainUsedFont;
  Font.Style:=FormFontStyles;

  Select_Name_Edit.Color:=ComboEditColor;
  Select_Name_Edit.Font.Charset:=ComboEditCharset;
  Select_Name_Edit.Font.Color:=ComboEditFontColor;
  Select_Name_Edit.Font.Size:=ComboEditFontSize;
  Select_Name_Edit.Font.Name:=MainUsedFont;
  Select_Name_Edit.Font.Style:=ComboEditFontStyles;

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Name.FormCreate = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Name.DefaultMouseMove
 *)

procedure TDialog_Select_Name.DefaultMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TDialog_Select_Name.DefaultMouseMove (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

 diMakeStaticTextDefault(Sel_Name_OK);

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Name.DefaultMouseMove = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Name.Help_QClick
 *)

procedure TDialog_Select_Name.Help_QClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Name.Help_QClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 ContextHelp.PopupPoint:=Context_Help.PopupPoint;
 Context_Form.Help_QDisplay;

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Name.Help_QClick = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Name.HelpContextPopup
 *)

procedure TDialog_Select_Name.HelpContextPopup(
  Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Name.HelpContextPopup (Sender:'+DbgObject(Sender)+'; MousePos:'+DbgPoint(MousePos)+'; var Handled:'+DbgBool(Handled)+')');
   DbgPlus;
 {$ENDIF}

 if CurrentHelpFile='' then Exit;

 Handled:=True;
 OHelpContext := (Sender as TControl).HelpContext;
 Context_Help.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Name.HelpContextPopup ( var Handled:'+DbgBool(Handled)+' ) = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Name.FormActivate
 *)

procedure TDialog_Select_Name.FormActivate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Name.FormActivate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 Context_Form.Close;

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Name.FormActivate = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Name.FormShow
 *)

procedure TDialog_Select_Name.FormShow(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Name.FormShow (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 PlaySoundEvent( sndDlgTick );
 Help_Q.Caption:=WHATISTHIS;
 Sel_Name_OK.Caption:=DLGOK;

 Caption:=InternalDialogName;

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Name.FormShow = void');
 {$ENDIF}
end;


(*
 * TDialog_Select_Name.Select_Name_EditKeyPress
 *)

procedure TDialog_Select_Name.Select_Name_EditKeyPress(Sender: TObject;
  var Key: Char);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TDialog_Select_Name.Select_Name_EditKeyPress (Sender:'+DbgObject(Sender)+'; var Key:'+DbgChar(Key)+')');
   DbgPlus;
 {$ENDIF}

 if Key=#27 then Close;
 if Key=#13 then Sel_Name_Ok.OnClick(Sel_Name_Ok);

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TDialog_Select_Name.Select_Name_EditKeyPress ( var Key:'+DbgChar(Key)+' ) = void');
 {$ENDIF}
end;

procedure TDialog_Select_Name.Select_Name_EditDropDown(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
end;

end.
