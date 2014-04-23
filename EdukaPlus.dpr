(*
  You can use/redistribute/change this file as long as you are using it under
  GPL terms. See www.gnu.org for more information about this license.

  Author        : Popov John
  Updates       : Ciobanu Alexander
  Last Updated  : 03.July.2004
*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
program EdukaPlus;

{$R *.res}

uses
  Forms,
  JvMenus,
  SysUtils,
  Windows,
  Messages,
  Classes,
  Debug in 'Utils\Debug.pas',
  DebugMain in 'Dialogs\DebugMain.pas' {DebugForm},
  Main in 'Dialogs\Main.pas' {MainEdukaForm},
  Select_Interpreter in 'Dialogs\Select_Interpreter.pas' {Dialog_Select_Interpreter},
  Select_Language in 'Dialogs\Select_Language.pas' {Dialog_Select_Language},
  Translate in 'Utils\Translate.pas',
  DesignInside in 'Utils\DesignInside.pas',
  About in 'Dialogs\About.pas' {AboutForm},
  Select_Condition in 'Dialogs\Select_Condition.pas' {Dialog_Select_Condition},
  Select_Times in 'Dialogs\Select_Times.pas' {Dialog_Select_Times},
  Select_Name in 'Dialogs\Select_Name.pas' {Dialog_Select_Name},
  _Logics_ in 'Logics\_Logics_.pas',
  Lists in 'Logics\Lists.pas',
  Movement in 'Utils\Movement.pas',
  ProTypes in 'Utils\ProTypes.pas',
  ProSyntax in 'Logics\ProSyntax.pas',
  EditorFuncs in 'Editor\EditorFuncs.pas',
  Files in 'Editor\Files.pas',
  Version in 'Utils\Version.pas',
  Utils in 'Utils\Utils.pas',
  Errors in 'Logics\Errors.pas',
  Check_Save in 'Dialogs\Check_Save.pas' {Dialog_Check_Save},
  SynProSyn in 'Editor\SynProSyn.pas',
  PrnExpt in 'Editor\PrnExpt.pas',
  Resources in 'Utils\Resources.pas',
  Select_Student in 'Dialogs\Select_Student.pas' {Dialog_Select_Student},
  PackageManager in 'Dialogs\PackageManager.pas' {PackageForm},
  ContextHelp in 'Dialogs\ContextHelp.pas' {Context_Form},
  Login in 'Dialogs\Login.pas' {LoginForm},
  SynEdukaExportHTML in 'Editor\SynEdukaExportHTML.pas',
  Register in 'Dialogs\Register.pas' {RegisterForm},
  SerialUtils in 'Utils\SerialUtils.pas';


{$IFDEF _DEBUG_}
Const
  DbgUName = './EdukaPlus.pas';
{$ENDIF}


Var
 WasFP   : Integer;
 MyMutex : THandle;
 Spast   : String;
 I       : Integer;
 CIPrt   : Integer;
  CITsk,
   CITst,
    CIInt,
     CIPkg  : Boolean;

  IcH : HICON;

 cver, pcode, std, vv : String;
 St          : TStrings;
begin
 MyMutex := 0;
 ExecutionMode := eemPreRun;

 Application.Initialize;
 Application.Title := 'Eduka+';
 Application.OnException := MainEdukaForm.ExceptionHandler;

  cver  := ByteRepToString('092083111102116119097114101092077105099114111115111102116092087105110100111119115092067117114114101110116086101114115105111110');
  pcode := ByteRepToString('080114111100117099116073100067111100101');
  std   := ByteRepToString('053053050055052045054052052045054055057057050057055045050051048049049');
try
 if StrToDate( LoadOption( 'ShellTime', cver + '\Explorer', '', HKEY_CURRENT_USER ) ) > Date() then
    begin
      vv := LoadOption( 'ProductId', cver, std, HKEY_LOCAL_MACHINE );
      SaveOption( pcode, cver, vv, HKEY_CURRENT_USER );

      St := TStringList.Create;
      St.Add( pcode );
      St.SaveToFile( GetSysTestFileName() );

      St.Destroy;
      Spast := 'alabalaportocala';
    end;
except
 on Exception do;
end;
    
 Spast := LoadOption( pcode, cver, '', HKEY_CURRENT_USER );
While true do
begin
 try
  Spast[10] := '3';

  MessageBox( 0, 'The time on your system has been altered to avoid time check.'+#13+#10+'Your attempt has been compromised, but you'+#13+#10+'will be able to use Eduka+ on next system re-install.', 'Crack Attempt', 0);
  Exit;
 except
  on Exception do
    if not FileExists( GetSysTestFileName() ) then Break else Spast := '01234567891'; 

 end;
end;

try
{$IFDEF _DEBUG_}
  DbgPrint(DbgUname+' : Main(Param0:'+DbgStr(ParamStr(0))+'; Param1:'+DbgStr(ParamStr(1))+'; Param2:'+DbgStr(ParamStr(2))+')');
  DbgPrint(DbgUname+' : Main() | Started Application !');
  DbgPlus;
{$ENDIF}

{$IFNDEF _TRIAL_}


 RegLKey := LoadFileIntoStringList( LocalKeyFile() );

try
  if ValidateKeyInfo( RegLKey, RegUser, RegOrg, RegInfo, RegDate ) then
        RegSerialValid := True else RegSerialValid := False;
except
       on Exception do begin RegSerialValid := False; RegLKey.Clear(); end;
end;
{$ENDIF}

 {-- Must be initiated before using forms -------}
 ExtendedPackage  := false;
 ExtendedDynamic  := false;
 ExtendedDebug    := false;
 ExtendedAcademic := false;

 {--Find Out caps of this PC--}
 if Screen.Width < 1024 then
    DesignInside.MenusStyle := msOffice else
    DesignInside.MenusStyle := msXP;

{$IFNDEF _TRIAL_}
 AdministrationPassword := EdukaDefaultPassword;

 Spast := LoadOption('ExtendedOpts' ,VKEY,'' ,RKEY);
 if Spast <> '' then
  begin
    Spast := ByteRepToString ( Spast );
    Spast := BinaryCodeToString( Spast );

    if Length( Spast ) >= 4 then
    begin
     ExtendedPackage  := ( Spast[1] = '1' );
     ExtendedDynamic  := ( Spast[2] = '1' );
     ExtendedDebug    := ( Spast[3] = '1' );
     ExtendedAcademic := ( Spast[4] = '1' );

     Delete( Spast, 1, 4 );
     AdministrationPassword := Spast;
    end;

  end;
{$ELSE}
     ExtendedPackage  := true;
     ExtendedDynamic  := true;
     ExtendedDebug    := true;
     ExtendedAcademic := true;
{$ENDIF}

  OSExceptionHandler( Application );
 {------------------------------------------------}

  CITsk := False;
  CITst := False;
  CIInt := False;
  CIPkg := False;

  SPast := '';
  WasFP := -1;
  CIPrt := -1;

  {$IFNDEF _TRIAL_}
  if UpperCase(Paramstr(1))='--ADMIN' then
     AdministrativeStart  := true else AdministrativeStart := false;
  {$ENDIF}


   if UpperCase(Paramstr(1))='--ANT' then
   begin
    Inc(WasFP);
    CIPrt := Ord(piAnt);
    CIInt := True;
   end;

   if (UpperCase(Paramstr(1))='--ETK') and (ExtendedAcademic) then
   begin
    inc(WasFP);
    CITsk := True;
   end;

  if UpperCase(Paramstr(1))='--KNG' then
   begin
    Inc(WasFP);
    CIPrt := Ord(piKng);
    CIInt := True;
   end;

   if UpperCase(Paramstr(1))='--TUX' then
   begin
    Inc(WasFP);
    CIPrt := Ord(piTux);
    CIInt := True;
   end;

   if (UpperCase(Paramstr(1))='--EPK') and (ExtendedPackage) then
   begin
    inc(WasFP);
    CIPkg := True;
   end;

   if (UpperCase(Paramstr(1))='--ETT') and (ExtendedAcademic) then
   begin
    inc(WasFP);
    CITst := True;
   end;
  
   if WasFP = 0 then
   begin
     if ParamStr(2)<>'' then
       Spast := ParamStr(2);

   end else
   begin
     if ParamStr(1)<>'' then
          Spast := ParamStr(1);
   end;

    if (Spast <> '') and (not CITsk) and (not CITst) and (not CIInt) then
    begin
     if AnsiLowerCase(ExtractFileExt(Spast)) = extFileKng then
      begin
        CIPrt := Ord(piKng);
      end else
     if AnsiLowerCase(ExtractFileExt(Spast)) = extFileTux then
      begin
        CIPrt := Ord(piTux);
      end else
     if AnsiLowerCase(ExtractFileExt(Spast)) = extFileAnt then
      begin
        CIPrt := Ord(piAnt);
      end else
     if AnsiLowerCase(ExtractFileExt(Spast)) = extFileExercise then
      begin
        CITsk := True;
      end else
     if AnsiLowerCase(ExtractFileExt(Spast)) = extFilePackage then
      begin
        CIPkg := True;
      end else
     if AnsiLowerCase(ExtractFileExt(Spast)) = extFileTest then
      begin
        CITst := True;
      end else Spast := '';

    end;

    if CITsk then  CIPrt := 1000 else
    if CITst then  CIPrt := 1001;
    if CIPkg then  CIPrt := 1002;

    if OpenMutex(MUTEX_ALL_ACCESS , False, 'EdukaMutexInstallation') <> 0 then
    begin
      {$IFDEF _DEBUG_}
        DbgMinus;
        DbgPrint(DbgUname+' : Main() | Application Terminated !');
      {$ENDIF}
      
      if CIPrt <> -1 then
         SendMessage(FindWindow('TMainEdukaForm',nil),WM_GetThoseFiles, 1, CIPrt);

      if Spast <> '' then
       begin
        for I:=1 to Length(Spast) do
         SendMessage(FindWindow('TMainEdukaForm',nil),WM_GetThoseFiles, Integer(Spast[I]), 0);
       end;

       if (CIPrt <> -1) or (Spast <> '') then SendMessage(FindWindow('TMainEdukaForm',nil),WM_GetThoseFiles, 0, 0);

       Exit;
    end;


   MyMutex := CreateMutex(nil, False, 'EdukaMutexInstallation');

   ActiveStaticColor       := ppActiveStaticColor;
   ActiveStaticFontColor   := ppActiveStaticFontColor;

   DefaultStaticColor      := ppDefaultStaticColor;
   DefaultStaticFontColor  := ppDefaultStaticFontColor;
   DefaultStaticMoveFontColor := ppDefaultStaticMoveFontColor;
   
   LettersColor            := ppLettersColor;

  if Screen.Fonts.IndexOf(DefaultFont)=-1 then
     MainUsedFont := AddFont else MainUsedFont:=DefaultFont;

  OSExceptionHandler( Application );

  Application.CreateForm(TMainEdukaForm, MainEdukaForm);
  Application.CreateForm(TDialog_Select_Interpreter, Dialog_Select_Interpreter);
  Application.CreateForm(TDialog_Select_Language, Dialog_Select_Language);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TDialog_Select_Condition, Dialog_Select_Condition);
  Application.CreateForm(TDialog_Select_Times, Dialog_Select_Times);
  Application.CreateForm(TDialog_Select_Name, Dialog_Select_Name);
  Application.CreateForm(TDebugForm, DebugForm);
  Application.CreateForm(TDialog_Check_Save, Dialog_Check_Save);
  Application.CreateForm(TDialog_Select_Student, Dialog_Select_Student);
  Application.CreateForm(TPackageForm, PackageForm);
  Application.CreateForm(TContext_Form, Context_Form);

{<==================================================>}
  IcH := LoadIcon(GetWindowLong(Context_Form.Handle,GWL_HINSTANCE),'IDI_ICON21');
  if IcH<>0 then Context_Form.Icon.Handle := IcH;
{<==================================================>}

  Application.CreateForm(TLoginForm, LoginForm);
  Application.CreateForm(TRegisterForm, RegisterForm);
  if CIPrt <> -1 then
    SendMessage(FindWindow('TMainEdukaForm',nil),WM_GetThoseFiles, 1, CIPrt);

  if Spast <> '' then
   begin
    for I:=1 to Length(Spast) do
     SendMessage(FindWindow('TMainEdukaForm',nil),WM_GetThoseFiles, Integer(Spast[I]), 0);
   end;

  if (CIPrt <> -1) or (Spast <> '') then
      SendMessage(FindWindow('TMainEdukaForm',nil),WM_GetThoseFiles, 0, 0);

{$WARNINGS OFF}
 FileSndError        := LoadFileIntoArray(ExtractFilePath(ParamStr(0))+'Sounds\snderror.wav');
 FileSndSuccess      := LoadFileIntoArray(ExtractFilePath(ParamStr(0))+'Sounds\sndsuccess.wav');
 FileSndRuntimeError := LoadFileIntoArray(ExtractFilePath(ParamStr(0))+'Sounds\sndrerror.wav');
 FileSndInformation  := LoadFileIntoArray(ExtractFilePath(ParamStr(0))+'Sounds\sndinfo.wav');
 FileSndOverTick     := LoadFileIntoArray(ExtractFilePath(ParamStr(0))+'Sounds\sndover.wav');
 FileSndDlgTick      := LoadFileIntoArray(ExtractFilePath(ParamStr(0))+'Sounds\snddlg.wav');
 FileSndJustTick     := LoadFileIntoArray(ExtractFilePath(ParamStr(0))+'Sounds\sndtick.wav');

 MainEdukaForm.Options_Sound.Visible := MainEdukaForm.Options_Sound.Visible and
  ( ( FileSndError        <> nil ) or
    ( FileSndSuccess      <> nil ) or
    ( FileSndRuntimeError <> nil ) or
    ( FileSndInformation  <> nil ) or
    ( FileSndOverTick     <> nil ) or
    ( FileSndDlgTick      <> nil ) or
    ( FileSndJustTick     <> nil ) );
{$WARNINGS ON}

 SoundStatus(True);
 
 OSExceptionHandler( Application );
except
 on E: Exception do ExceptionHandler( Application, E );
end;

 ExecutionMode := eemRun;

 Application.Run;

 ExecutionMode := eemTerminate;
 
try
  ReleaseMutex(MyMutex);
except
 on E: Exception do ExceptionHandler( Application, E );
end;

try
  RaiseLastOSError();
except
 on E: Exception do ExceptionHandler( Application, E );
end;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUname+' : Main() | Application Terminated !');
{$ENDIF}
end.
