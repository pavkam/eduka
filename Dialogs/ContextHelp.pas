(*


The Original Code is: ContextHelp.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains Context_Form definition that is used to display
    our custom Hint Form.
*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit ContextHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DesignInside, Menus, JvMenus, OleCtrls, SHDocVw,
  ProTypes, JvExControls, JvComponent, JvSpecialProgress, JvExComCtrls,
  JvStatusBar
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;

{$IFDEF _DEBUG_}
Const
  DbgUName  =  '/Dialogs/ContextHelp.pas';
{$ENDIF}

type
  TContext_Form = class(TForm)
    WebHelp: TWebBrowser;
    HelpMenu: TJvMainMenu;
    Help_Exit: TMenuItem;
    PgBar: TJvStatusBar;
    Progress: TJvSpecialProgress;
    reInfo: TRichEdit;


    procedure Help_QDisplay;

    procedure HelpEditMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure HelpEditEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Help_ExitClick(Sender: TObject);
    procedure WebHelpProgressChange(Sender: TObject; Progress,
      ProgressMax: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Context_Form  : TContext_Form;
  PopupPoint    : TPoint;

   OHelpContext : Integer;
   OHelpPage    : String;

implementation
Uses Translate;
{$R *.dfm}


(*
 * TContext_Form.Help_QDisplay
 *)

procedure TContext_Form.Help_QDisplay;
var
 hfname : string;

begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TContext_Form.Help_QDisplay() ');
   DbgPlus;
 {$ENDIF}
   reInfo.Visible := False;

   hfname := ExtractFilePath(ParamStr(0)) + 'Helps\' + CurrentHelpFile + '\' + OHelpPage + '.htm';

   if not FileExists( hfname ) then
      hfname := ExtractFilePath(ParamStr(0)) + 'Helps\' + CurrentHelpFile + '\' + hlp_Glossary + '.htm';

   if not FileExists( hfname ) then Exit;

   if OHelpContext > 0 then hfname := hfname + '#' + IntToStr(OHelpContext);
     WebHelp.Navigate( hfname );

   Caption           := Dialog_C_HP;
   Help_Exit.Caption := HLPEXIT;

   if not Visible then
   begin
    Width  := Screen.WorkAreaWidth - 100;
    Height := Screen.WorkAreaHeight - 100;

    Left := (Screen.WorkAreaWidth - Width) div 2;
    Top  := (Screen.WorkAreaHeight - Height) div 2;
    ShowModal;    
   end else BringToFront;

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TContext_Form.Help_QDisplay = void');
 {$ENDIF}
end;


(*
 * TContext_Form.HelpEditMouseDown
 *)

procedure TContext_Form.HelpEditMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TContext_Form.HelpEditMouseDown (Sender:'+DbgObject(Sender)+'; Button:'+DbgMouseButton(Button)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

 Close;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TContext_Form.HelpEditMouseDown = void');
{$ENDIF}
end;


(*
 * TContext_Form.HelpEditEnter
 *)

procedure TContext_Form.HelpEditEnter(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TContext_Form.HelpEditEnter (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 ActiveControl := nil;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TContext_Form.HelpEditEnter = void');
{$ENDIF}
end;


(*
 * TContext_Form.FormCreate
 *)

procedure TContext_Form.FormCreate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TContext_Form.FormCreate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}


{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TContext_Form.FormCreate = void');
{$ENDIF}
end;

procedure TContext_Form.Help_ExitClick(Sender: TObject);
begin
 Close;
end;

procedure TContext_Form.WebHelpProgressChange(Sender: TObject; Progress,
  ProgressMax: Integer);
begin
 self.Progress.Position := Progress;
 self.Progress.Maximum  := ProgressMax;

 Application.ProcessMessages();
end;

end.
