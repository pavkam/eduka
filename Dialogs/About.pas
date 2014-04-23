(*

The Original Code is: About.pas, released 2005-02-02.
Authors of this file are Popov John and Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains AboutForm definition that is used to display
    about dialog.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit About;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, jpeg, version, EditorFuncs, ProTypes,
  Buttons,ShellAPI, Translate, Utils, JvImage, JvExExtCtrls, SerialUtils
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;

{$IFDEF _DEBUG_}
Const
  DbgUName  =  '/About/About.pas';
{$ENDIF}

type
  TAboutForm = class(TForm)
    SplashTimer   : TTimer;
    Panel_About   : TPanel;
    SplashImage: TJvImage;
    Memo_About    : TRichEdit;
    
    License_label : TLabel;
    Version_Label : TLabel;
    RegUser_Label: TLabel;
    RegOrg_Label: TLabel;
    RegSer_Label: TLabel;
    lbReg: TLabel;
    spdKeyInfo: TSpeedButton;

    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SplashTimerTimer(Sender: TObject);
    procedure Memo_AboutKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Memo_AboutMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure License_labelClick(Sender: TObject);
    procedure btRegisterClick(Sender: TObject);
    procedure spdKeyInfoClick(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

uses Register, Check_Save, ContextHelp;
{$R *.dfm}


(*
 * TAboutForm.FormClick
 *)

procedure TAboutForm.FormClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TAboutForm.FormClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 Close;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TAboutForm.FormClick = void');
{$ENDIF}
end;


(*
 * TAboutForm.FormCreate
 *)

procedure TAboutForm.FormCreate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TAboutForm.FormCreate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 edtPrintToEditor(Memo_About,clNavy,[fsBold],ProgramID+' ');
 edtPrintToEditor(Memo_About,clGray,[],'Version'+' ');
 edtPrintToEditor(Memo_About,clBackGround,[],VersionID+' ');
 edtPrintToEditor(Memo_About,clGray,[],'was created by'+' ' + Enter + Enter);

 edtPrintToEditor(Memo_About,clNavy,[],'   * '+'Popov John'+' ');
 edtPrintToEditor(Memo_About,clNavy,[fsUnderline],'(pionely@yahoo.com)'+Enter);
 edtPrintToEditor(Memo_About,clTeal,[],'     - '+'Design'+' ' + Enter);
 edtPrintToEditor(Memo_About,clTeal,[],'     - '+'Theory'+' ' + Enter);
 edtPrintToEditor(Memo_About,clTeal,[],'     - '+'Russian and Romanian languages'+' ' + Enter);
 edtPrintToEditor(Memo_About,clNavy,[],'   * '+'Ciobanu Alexander'+ ' ');
 edtPrintToEditor(Memo_About,clNavy,[fsUnderline],'(alex@ciobanu.org)'+Enter);
 edtPrintToEditor(Memo_About,clTeal,[],'     - '+'Programming'+' ' + Enter);
 edtPrintToEditor(Memo_About,clTeal,[],'     - '+'English language'+' ' + Enter);
 edtPrintToEditor(Memo_About,clNavy,[],'   * '+'Sebastian Onofrei' + ' ');
 edtPrintToEditor(Memo_About,clNavy,[fsUnderline],'(suntprof@yahoo.com)'+Enter); 
 edtPrintToEditor(Memo_About,clTeal,[],'     - '+'Project coordination'+' ' + Enter);
 edtPrintToEditor(Memo_About,clRed ,[],'The program includes SynEdit and JEDI packages '+Enter);
 edtPrintToEditor(Memo_About,clRed ,[],'which are released under ');
 edtPrintToEditor(Memo_About,clNavy,[], MPLID + Enter);

 edtPrintToEditor(Memo_About,clRed ,[],'.'+Enter+Enter);

 edtPrintToEditor(Memo_About,clGreen,[],' '+'Eduka+ is available under the'+Enter+ ' ');
 edtPrintToEditor(Memo_About,clNavy,[],LicenseID+' '+ Enter);
 edtPrintToEditor(Memo_About,clGreen,[],' '+'Current version was released on'+Enter+ ' ');
 edtPrintToEditor(Memo_About,clNavy,[],ReleaseDate+' '+ Enter);
 edtPrintToEditor(Memo_About,clGreen,[],' '+'for newer one , see :'+Enter+ ' ');
 edtPrintToEditor(Memo_About,clNavy,[fsUnderline],SiteID+' '+ Enter);




{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TAboutForm.FormCreate = void');
{$ENDIF}
end;


(*
 * TAboutForm.SplashTimerTimer
 *)

procedure TAboutForm.SplashTimerTimer(Sender: TObject);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TAboutForm.Timer1Timer (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}
 
  Memo_About.Top:=Memo_About.Top-1;
  if Memo_About.Top+Memo_About.Height < Panel_About.Height - 130 then Memo_About.Top := ( Panel_About.Top + 50 );

 if (ActiveControl <> nil) then ActiveControl:=nil;

{$IFDEF _DEBUG2_}
  DbgMinus;
  DbgPrint(DbgUName+' : TAboutForm.Timer1Timer = void');
{$ENDIF}
end;


(*
 *  TAboutForm.Memo_AboutKeyDown
 *)

procedure TAboutForm.Memo_AboutKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TAboutForm.Memo_AboutKeyDown (Sender:'+DbgObject(Sender)+'; var Key:'+DbgInt(Key)+'; Shift:'+DbgShift(Shift)+' )');
   DbgPlus;
 {$ENDIF}

 Close;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TAboutForm.Memo_AboutKeyDown ( var Key:'+DbgInt(Key)+' ) = void');
{$ENDIF}
end;


(*
 *  TAboutForm.Memo_AboutMouseDown
 *)

procedure TAboutForm.Memo_AboutMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TAboutForm.Memo_AboutMouseDown (Sender:'+DbgObject(Sender)+'; Button:'+DbgMouseButton(Button)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

 Close;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TAboutForm.Memo_AboutMouseDown = void');
{$ENDIF}
end;


(*
 * TAboutForm.FormShow
 *)

procedure TAboutForm.FormShow(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TAboutForm.FormShow (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 License_label.Caption       := SiteID;
 Version_label.Caption       := 'Version'+' '+VersionID + ' (' + VersionBase + ')';
 RegOrg_Label.Caption        := RegOrg;
 RegUser_Label.Caption       := RegUser;

 lbReg.Caption               := REG_U_ITEM;
{$IFDEF _TRIAL_}
 RegSer_Label.Caption        := REG_U_TRIAL;
 lbReg.Visible               := False;
 RegOrg_Label.Visible        := False;
 RegUser_Label.Visible       := False;
 spdKeyInfo.Enabled          := False;
{$ELSE}
 RegSer_Label.Caption        := StringReplace( REG_U_REGD, '%d', DateToStr(RegDate), [rfReplaceAll] );
 lbReg.Visible               := false;
{$ENDIF}

 PlaySoundEvent( sndDlgTick );
 SplashTimer.Enabled:=True;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TAboutForm.FormShow = void');
{$ENDIF}
end;


(*
 * TAboutForm.FormClose
 *)

procedure TAboutForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TAboutForm.FormClose (Sender:'+DbgObject(Sender)+'; var Action:'+DbgAction(Action)+')');
   DbgPlus;
 {$ENDIF}

 SplashTimer.Enabled:=False;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TAboutForm.FormClose ( var Action:'+DbgAction(Action)+' ) = void');
{$ENDIF}
end;


(*
 * TAboutForm.License_labelClick
 *)

procedure TAboutForm.License_labelClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TAboutForm.License_labelClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

{$WARNINGS OFF}
 ShellExecute(0,'open',PChar((Sender as TLabel).Caption),'','',SW_SHOW);
{$WARNINGS ON}

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TAboutForm.License_labelClick = void');
{$ENDIF}
end;

procedure TAboutForm.btRegisterClick(Sender: TObject);
var
 mdr : Integer;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TAboutForm.btRegisterClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 RegisterForm.lbReg.Caption       :=  REG_U_LTXT;
 RegisterForm.pnlReg.Visible      :=  true;
 RegisterForm.pnlMsg.Visible      :=  false;

 RegisterForm.Reg_OK.Caption      :=  DLGOK;
 RegisterForm.Reg_Cancel.Caption  :=  REG_U_DDCONT;
 RegisterForm.edtKeyFile.Text     :=  '';
 RegisterForm.Caption             :=  REG_U_CAPT;
 RegisterForm.lbBuy.Caption       :=  REG_U_TXT;

 mdr := RegisterForm.ShowModal();
 if mdr = mrOK then
    begin
      Dialog_Check_Save.InformativeMessage( Dialog_C_NOTPK, StringReplace( REG_U_OKRESTART, '%d', DateToStr(RegDate), [rfReplaceAll]), 3 );
      lbReg.Visible := False;
    end else
   if mdr = mrAbort then
    begin
      Dialog_Check_Save.InformativeMessage( Dialog_C_NOTPK, REG_U_ERRRESTART, 2 );
      Application.Terminate;
    end;
    
 ExecutionMode := eemRun;
{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TAboutForm.btRegisterClick = void');
{$ENDIF}

end;

procedure TAboutForm.spdKeyInfoClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TAboutForm.spdKeyInfoClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 Context_Form.reInfo.Show;
 Context_Form.reInfo.Align := alClient;
 Context_Form.reInfo.Text := RegInfo;

 Context_Form.Caption := REG_U_INFO_KEY;
 Context_Form.Help_Exit.Caption := HLPEXIT;

 Context_Form.Width  := 400;
 Context_Form.Height := 350;

 Context_Form.Left := (Screen.WorkAreaWidth - Context_Form.Width) div 2;
 Context_Form.Top  := (Screen.WorkAreaHeight - Context_Form.Height) div 2;

 Context_Form.ShowModal;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TAboutForm.spdKeyInfoClick = void');
{$ENDIF}
end;

end.
