(*

The Original Code is: Login.pas, released 2005-02-02.
Authors of this file are Popov John and Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains LoginForm definition.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}

unit Login;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DesignInside, Translate, ProTypes, Menus, Utils,
  Files, ExtCtrls, JvExControls, JvComponent, JvStaticText, JvDotNetControls
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;
{$IFDEF _DEBUG_}
Const
        DbgUName          = '/Dialogs/Login.pas';
{$ENDIF}
type
  TLoginForm = class(TForm)
    lbLoginCapt : TLabel;
    btLogin: TJvStaticText;
    edtLogin: TJvDotNetEdit;

    procedure btLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtLoginKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtLoginMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btLoginMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginForm: TLoginForm;

implementation

{$R *.dfm}

procedure TLoginForm.btLoginClick(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TLoginForm.btLoginClick (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  PlaySoundEvent( sndJustTick );
  ModalResult := mrOK;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TLoginForm.btLoginClick = void');
 {$ENDIF}
end;

procedure TLoginForm.FormShow(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TLoginForm.FormShow (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  edtLogin.Text := '';
  ActiveControl := edtLogin;
  diMakeStaticTextDefault( btLogin );

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TLoginForm.FormShow = void');
 {$ENDIF}
end;

procedure TLoginForm.edtLoginKeyPress(Sender: TObject; var Key: Char);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TLoginForm.edtLoginKeyPress (Sender:'+DbgObject(Sender)+'; Key:"'+Key+'")');
   DbgPlus;
 {$ENDIF}

 if Key = #13 then
    btLogin.OnClick( btLogin );

 if Key = #27 then Close();

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TLoginForm.edtLoginKeyPress = void');
  {$ENDIF}
end;

procedure TLoginForm.FormCreate(Sender: TObject);
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : TLoginForm.FormCreate (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  Color        := FormColor;
  Font.Charset := FormCharset;
  Font.Color   := FormFontColor;
  Font.Size    := FormFontSize;
  Font.Name    := MainUsedFont;
  Font.Style   := FormFontStyles;

   edtLogin.Color      := _eEditColor;
   edtLogin.Font.Color := _fEditColor;

  {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : TLoginForm.FormCreate = void');
  {$ENDIF}
end;

procedure TLoginForm.edtLoginMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TLoginForm.edtLoginMouseMove (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

 diMakeStaticTextDefault( btLogin );

  {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TLoginForm.edtLoginMouseMove = void');
  {$ENDIF}
end;

procedure TLoginForm.btLoginMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TLoginForm.btLoginMouseMove (Sender:'+DbgObject(Sender)+')');
   DbgPlus;
 {$ENDIF}

  diMakeStaticTextActive( btLogin );

  {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : TLoginForm.btLoginMouseMove = void');
  {$ENDIF}
end;

end.
