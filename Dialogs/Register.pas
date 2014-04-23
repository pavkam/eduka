(*

The Original Code is: Login.pas, released 2005-02-02.
Authors of this file are Popov John and Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains RegisterForm definition.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}

unit Register;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DesignInside, Translate, ProTypes, Menus, Utils,
  Files, ShellAPI, Version, ExtCtrls, ComCtrls, jpeg, JvExControls, JvComponent, JvStaticText, JvDotNetControls,
  JvExExtCtrls, JvImage, SerialUtils
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;
{$IFDEF _DEBUG_}
Const
        DbgUName          = '/Dialogs/Register.pas';
{$ENDIF}
type
  TRegisterForm = class(TForm)
    Reg_OK: TJvStaticText;
    Reg_Cancel: TJvStaticText;
    lbBuy: TLabel;
    pnlReg: TPanel;
    lbReg: TLabel;
    ipImage: TImage;
    pnlMsg: TPanel;
    imgText: TImage;
    mText: TMemo;
    edtKeyFile: TJvDotNetEdit;
    btBrowse: TJvStaticText;
    OpenDialog: TOpenDialog;
    mKeyData: TMemo;
    spdKeyInfo: TSpeedButton;
    procedure btAcceptClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btBuyClick(Sender: TObject);
    procedure button_MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DefaultMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure mTextMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure ifaceSetAnnoyStateRegistration();
    procedure FormShow(Sender: TObject);
    procedure mTextEnter(Sender: TObject);
    procedure btBrowseClick(Sender: TObject);
    procedure edtKeyFileChange(Sender: TObject);
    procedure spdKeyInfoClick(Sender: TObject);
  private
    { Private declarations }
    iRegInfo : String;
  public
    { Public declarations }
  end;

var
  RegisterForm: TRegisterForm;

implementation
Uses ContextHelp;
{$R *.dfm}


procedure TRegisterForm.ifaceSetAnnoyStateRegistration();
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TRegisterForm.ifaceSetAnnoyStateRegistration ()');
   DbgPlus;
 {$ENDIF}
    ExecutionMode := eemReg;

    Reg_OK.Caption     := REG_U_DDREG;
    Reg_CANCEL.Caption := REG_U_DDCONT;

    pnlReg.Visible     := False;
    pnlMsg.Visible     := True;
    mText.Text         := REG_U_ANNOY;
    Caption            := REG_U_CAPT;
    Reg_Cancel.Enabled := True;

    lbBuy.Caption      :=  REG_U_TXT;
{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TRegisterForm.ifaceSetAnnoyStateRegistration = void');
{$ENDIF}
end;

procedure TRegisterForm.btAcceptClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TRegisterForm.btAcceptClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  PlaySoundEvent( sndJustTick );

  if pnlReg.Visible then // Registration thingies !
  begin
   try
    if SerialUtils.ValidateKeyInfo( edtKeyFile.Text, RegUser, RegOrg, RegInfo, RegDate ) then
       begin
         CopyFile( PChar( edtKeyFile.Text ), PChar( LocalKeyFile() ), false );
         RegLKey := Utils.LoadFileIntoStringList( LocalKeyFile() );

         ModalResult := mrOK;
       end
         else ModalResult := mrCancel;
    except
     on Exception do ModalResult := mrAbort;
    end;

  end else
  begin

    ModalResult        := mrOK;
    Reg_Cancel.Enabled := True;
  end;


{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TRegisterForm.btAcceptClick = void');
{$ENDIF}
end;

procedure TRegisterForm.btCancelClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TRegisterForm.btCancelClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  PlaySoundEvent( sndJustTick );
  Application.Terminate;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TRegisterForm.btCancelClick = void');
{$ENDIF}
end;

procedure TRegisterForm.btBuyClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TRegisterForm.btBuyClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 ShellExecute(0,'open',PChar(BuySiteID),'','',SW_SHOW);

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TRegisterForm.btBuyClick = void');
{$ENDIF}
end;

procedure TRegisterForm.button_MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TRegisterForm.button_MouseMove (Sender:'+DbgObject(Sender)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextActive( Sender as TJvStaticText );

  if ( Sender as TJvStaticText).Name = Reg_Cancel.Name then diMakeStaticTextDefault( Reg_OK ) else
                                                            diMakeStaticTextDefault( Reg_Cancel );


 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TRegisterForm.button_MouseMove = void');
 {$ENDIF}
end;

procedure TRegisterForm.DefaultMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TRegisterForm.ButtonDefaults (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextDefault( Reg_OK );
  diMakeStaticTextDefault( Reg_Cancel );
  diMakeStaticTextDefault( btBrowse );

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TRegisterForm.ButtonDefaults = void');
 {$ENDIF}
end;

procedure TRegisterForm.FormCreate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TRegisterForm.FormCreate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextDefault( Reg_OK );
  diMakeStaticTextDefault( Reg_Cancel );
  diMakeStaticTextDefault( btBrowse );
  imgText.Picture.Assign(ipImage.Picture);

  mKeyData.Color        := MemoColor;
  mKeyData.Font.Charset := MemoCharset;
  mKeyData.Font.Color   := MemoFontColor;
  mKeyData.Font.Size    := MemoFontSize;
  mKeyData.Font.Name    := MainUsedFont;
  mKeyData.Font.Style   := MemoFontStyles;

  mKeyData.Text         := REG_U_NOKEY;
  spdKeyInfo.Enabled    := False;

  mText.Color        := MemoColor;
  mText.Font.Charset := MemoCharset;
  mText.Font.Color   := MemoFontColor;
  mText.Font.Size    := MemoFontSize;
  mText.Font.Name    := MainUsedFont;
  mText.Font.Style   := MemoFontStyles;

  Color        := FormColor;
  Font.Charset := FormCharset;
  Font.Color   := FormFontColor;
  Font.Size    := FormFontSize;
  Font.Name    := MainUsedFont;
  Font.Style   := FormFontStyles;

  pnlReg.Color := FormColor;
  pnlMsg.Color := FormColor;

  edtKeyFile.Font.Color := _fEditColor;
  edtKeyFile.Color := _eEditColor;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TRegisterForm.FormCreate = void');
 {$ENDIF}
end;

procedure TRegisterForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TRegisterForm.FormCloseQuery (Sender:'+DbgObject(Sender)+'; CanClose:'+DbgBool(CanClose)+')');
   DbgPlus;
 {$ENDIF}

 if (ModalResult <> mrOK) and (ModalResult <> mrAbort) then
    CanClose := False;

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TRegisterForm.FormCloseQuery(CanClose:'+DbgBool(CanClose)+') = void');
 {$ENDIF}
end;


procedure TRegisterForm.mTextMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TRegisterForm.mTextMouseDown (Sender:'+DbgObject(Sender)+'; Button:'+DbgMouseButton(Button)+'; Shift:'+DbgShift(Shift)+'; X:'+DbgInt(X)+'; Y:'+DbgInt(Y)+' )');
   DbgPlus;
 {$ENDIF}

 ActiveControl := nil;

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TRegisterForm.mTextKeyDown = void');
 {$ENDIF}
end;

procedure TRegisterForm.FormShow(Sender: TObject);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TRegisterForm.FormShow (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextDefault( Reg_OK );
  diMakeStaticTextDefault( Reg_Cancel );
  diMakeStaticTextDefault( btBrowse );

  PlaySoundEvent( sndDlgTick );
  if pnlReg.Visible then ActiveControl := edtKeyFile else ActiveControl := nil;

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TRegisterForm.mTextKeyDown = void');
 {$ENDIF}
end;

procedure TRegisterForm.mTextEnter(Sender: TObject);
begin
 ActiveControl := nil;
end;

procedure TRegisterForm.btBrowseClick(Sender: TObject);
begin
  if OpenDialog.Execute() then
    edtKeyFile.Text := OpenDialog.FileName;    
end;

procedure TRegisterForm.edtKeyFileChange(Sender: TObject);
var
 iRegUser, iRegOrg : String;
 iRegDate : TDateTime;

 ss                : String;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TRegisterForm.edtKeyFileChange (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

try
 if SerialUtils.ValidateKeyInfo( edtKeyFile.Text, iRegUser, iRegOrg, iRegInfo, iRegDate ) then
   begin
     ss :=  StringReplace( REG_U_KEYINFO, '%u', iRegUser, [rfReplaceAll] );
     ss :=  StringReplace( ss, '%o', iRegOrg, [rfReplaceAll] );
     ss :=  StringReplace( ss, '%d', DateToStr( iRegDate ), [rfReplaceAll] );

     spdKeyInfo.Enabled := True;
     mKeyData.Text := ss;
   end else mKeyData.Text := REG_U_NOKEY;
except
 on Exception do begin mKeyData.Text := REG_U_NOKEY; spdKeyInfo.Enabled := False; end;
end;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TRegisterForm.edtKeyFileChange = void');
{$ENDIF}

end;

procedure TRegisterForm.spdKeyInfoClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TRegisterForm.spdKeyInfoClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 Context_Form.reInfo.Show;
 Context_Form.reInfo.Align := alClient;
 Context_Form.reInfo.Text := iRegInfo;

 Context_Form.Caption := REG_U_INFO_KEY;
 Context_Form.Help_Exit.Caption := HLPEXIT;
 
 Context_Form.Width  := 400;
 Context_Form.Height := 350;

 Context_Form.Left := (Screen.WorkAreaWidth - Context_Form.Width) div 2;
 Context_Form.Top  := (Screen.WorkAreaHeight - Context_Form.Height) div 2;

 Context_Form.ShowModal;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : TRegisterForm.spdKeyInfoClick = void');
{$ENDIF}
end;

end.
