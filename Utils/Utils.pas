(*

The Original Code is: Utils.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
    Helper functions / procedures.

*)

{ Include Compile Directives ! }
{$IFDEF SER_MAKER}
 {$I ..\Utils\directives.inc}
{$ELSE}
 {$I Utils\directives.inc}
{$ENDIF}

Unit Utils;
interface
{$WARNINGS OFF}
Uses SysUtils, Registry, Windows, ProTypes, Graphics, FileCtrl, Classes, Forms, MMSystem
{$IFNDEF SER_MAKER}
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
{$ENDIF}
;
{$WARNINGS ON}
Function ExtractKw(Str : String; nm : Integer) : String;
function atoi( Ascii : String) : Integer;
function atof( Ascii : String) : Double;
function KillSpaces(Str : String) : String;
function Gol(St : String) : Boolean;
function IsSpace(Ch : Char) : Boolean;
function CharString(C : Integer; Ch : Char) : String;
function ValueInArray(Ax : Array of Integer; Val : Integer) : Boolean;
function MinimizeName(Str : String; Canvas : TCanvas; Len : Integer) : String;
function SelectDirectory(const Caption: WideString; const Root: string; var Directory: string): Boolean;
function LoadFileIntoStream(iFile : String) : TMemoryStream;
function LoadFileIntoArray(iFile : String) : Pointer;

function LoadFileIntoStringList(iFile : String) : TStrings;

procedure PlaySoundEvent(Evnt : TSoundEventType);
procedure SoundStatus(stHow : Boolean);

procedure SaveOption(Name, Key, Value : String;Root : HKey);
 function LoadOption(Name, Key, Default : String;Root : HKey) : String;
procedure DelOption (Name, Key : String;Root : HKey);

function Replace(St, StWhat, StWith : String) : String;
function EncryptPass(St : String) : String;


 function DynShortString(St : ShortString) : PShortString;
 function FileTypeDate( Date : TDateTime ) : String;
 function GetSysTestFileName() : String;

 function BoolRect( VName : String; VVal : Boolean ) : String;

 function WordToStrDirect( Wd : Word ) : String;
 function StrDirectToWord( St : String ) : Word;

{$IFNDEF SER_MAKER}
procedure ExceptionHandler(Sender: TObject; E: Exception);
procedure OSExceptionHandler(Sender: TObject);

{$ENDIF}

implementation
var
 SStatus : Boolean;

{$IFNDEF SER_MAKER}
procedure OSExceptionHandler(Sender: TObject);
begin
  try
    RaiseLastOSError();
  except
   on E: EOSError do
    begin
      if (E.ErrorCode <> 0) and (E.ErrorCode <> 183) then
         ExceptionHandler( Sender, E );
    end;
  end;

  SetLastError(0);
end;

procedure ExceptionHandler(Sender: TObject; E: Exception);
{$IFNDEF _DEBUG_}
var
  ExF : TStrings;
  Zef : String;
{$ENDIF}  
begin
   {$IFNDEF _DEBUG_}
   ExF := TStringList.Create();
   Zef := ExtractFilePath(ParamStr(0)) + '\' + FileTypeDate( Date() ) + '.log';

   if FileExists(Zef) then Exf.LoadFromFile(Zef);
   ExF.Add('# Eduka Exception Log. Please report it to IRPG as soon as possible');
   ExF.Add('# along with some information on how this error was generated !');
   ExF.Add('');
   ExF.Add('Exception: "' + E.ClassName+'"');
   Exf.Add('Message: "'+E.Message+'"');
   Exf.Add('Who: "'+(Sender.ClassName)+'"');

   if (Sender is TComponent) then
     Exf.Add('Name: "'+((Sender as TComponent).Name)+'"');

   if Application.Terminated then ExecutionMode := eemTerminate;

   case ExecutionMode of
    eemPreRun    : Exf.Add('Mode: Initialize');
    eemRun       : Exf.Add('Mode: Run');
    eemTerminate : Exf.Add('Mode: Terminate');
    eemReg       : Exf.Add('Mode: Reg');
   end;

   Exf.Add( BoolRect('InLaunchedTestMode', InLaunchedTestMode) );
   Exf.Add( BoolRect('ExerciseEditorMode', ExerciseEditorMode) );
   Exf.Add( BoolRect('ExerciseEditorFile', ExerciseEditorFile) );
   Exf.Add( BoolRect('TestEditorMode', TestEditorMode) );
   Exf.Add( BoolRect('TestEditorFile', TestEditorFile) );
   Exf.Add( BoolRect('KillThreadFlag', KillThreadFlag) );
   Exf.Add( BoolRect('ExecutionStarted', ExecutionStarted) );
   Exf.Add( BoolRect('StartedInStepMode', StartedInStepMode) );

   Exf.Add( BoolRect('InCriticalStage', InCriticalStage) );
   Exf.Add( BoolRect('ExtendedPackage', ExtendedPackage) );
   Exf.Add( BoolRect('ExtendedDynamic', ExtendedDynamic) );
   Exf.Add( BoolRect('ExtendedDebug', ExtendedDebug) );

   Exf.Add( BoolRect('ExtendedAcademic', ExtendedAcademic) );
   Exf.Add( BoolRect('AdministrativeStart', AdministrativeStart) );
   Exf.Add( BoolRect('AnimalReset', AnimalReset) );
   Exf.Add( BoolRect('MainDisableSound', MainDisableSound) );

   ExF.Add('');
   ExF.Add('');      
   Exf.SaveToFile( Zef );
   Exf.Destroy();
{$ELSE}
   if (Sender is TComponent) then
     DbgPrint(' <Exception Raised> : ' + DbgStr( E.ClassName ) + ' at ' + DbgStr( Sender.ClassName ) + ' with code ' + DbgStr( E.Message )) else
     DbgPrint(' <Exception Raised> : ' + DbgStr( E.ClassName ) + ' at ' + DbgStr( (Sender as TComponent).Name ) + ' with code ' + DbgStr( E.Message ));
{$ENDIF}

   SetLastError(0);
end;
{$ENDIF}

function WordToStrDirect( Wd : Word ) : String;
var
 v : array[1..2] of Char absolute Wd;
begin
 Result := v[1] + v[2];
end;

function StrDirectToWord( St : String ) : Word;
var
 Wd : Word;
 v : array[1..2] of Char absolute Wd;
begin
 v[1] := St[1];
 v[2] := St[2];

 Result := Wd;
end;

function BoolRect( VName : String; VVal : Boolean ) : String;
begin
 Result := VName + ': ' + BoolToStr( VVal, true );
end;

function GetSysTestFileName() : String;
var
 pn : PChar;

begin
 Result := '';
 GetMem( pn, 4000 );

 if GetSystemDirectory( pn, 4000 ) = 0 then Exit;
 Result := pn + '\' + 'winldr.dll';

 FreeMem( pn );
end;

function FileTypeDate( Date : TDateTime ) : String;
begin
 Result := DateToStr(Date);

 Result := StringReplace( Result, '\', '.', [rfReplaceAll]);
 Result := StringReplace( Result, '/', '.', [rfReplaceAll]);
 Result := StringReplace( Result, ':', '.', [rfReplaceAll]);
 Result := StringReplace( Result, '"', '.', [rfReplaceAll]);
 Result := StringReplace( Result, '*', '.', [rfReplaceAll]);
 Result := StringReplace( Result, '?', '.', [rfReplaceAll]);
 Result := StringReplace( Result, '|', '.', [rfReplaceAll]);   
end;

function DynShortString(St : ShortString) : PShortString;
begin
 new( Result );
 Result^ := St;
end;

function EncryptPass(St : String) : String;
var
 i,x : Integer;
begin
 x      := 0;
 result := '0';

 if St = '' then exit;

 for i := 1 to Length(St) do
  begin
     x := x + Ord(St[i]) * i * sqr(Ord(St[i]) + i*3);
  end;

  result := IntToStr(x);
end;

function Replace(St, StWhat, StWith : String) : String;
var
 ix : Integer;
begin
 Result := St;

 ix := Pos(AnsiUppercase(StWhat), AnsiUpperCase(St));
 if ix =0 then exit;

 Delete(Result, ix, Length(StWhat));

 Insert(StWith, Result, iX);
end;

procedure SoundStatus(stHow : Boolean);
begin
 SStatus := stHow;
end;

(*
 * PlaySoundEvent
 *)

procedure PlaySoundEvent(Evnt : TSoundEventType);
Var
 Flags : DWORD;
begin
 if not SStatus then Exit;
 if MainDisableSound then Exit;
 
 Flags := SND_MEMORY or SND_NODEFAULT{ or SND_NOSTOP or SND_NOWAIT} or SND_ASYNC;
 case Evnt of
  sndError        : PlaySound(FileSndError, HInstance, Flags);
  sndSuccess      : PlaySound(FileSndSuccess, HInstance, Flags);
  sndRuntimeError : PlaySound(FileSndRuntimeError, HInstance, Flags);
  sndInformation  : PlaySound(FileSndInformation, HInstance, Flags);
  sndOverTick     : PlaySound(FileSndOverTick, HInstance, Flags);
  sndDlgTick      : PlaySound(FileSndDlgTick, HInstance, Flags);
  sndJustTick     : PlaySound(FileSndJustTick, HInstance, Flags);
 end;

end;


(*
 * LoadFileIntoArray
 *)

function LoadFileIntoArray(iFile : String) : Pointer;
var
 F   : File;
 Fsz : LongInt;
begin
 Result := Nil;
{$IFDEF _TRIAL_}
 Exit;
{$ENDIF}

 if not FileExists(iFile) then Exit;
try
 AssignFile(F, iFile);
 Reset(F,1);
 FSz := FileSize(F);

 GetMem( Result, FSz);
 BlockRead(F, Result^, Fsz);

 CloseFile(F);
except
 On Exception do;
end;
end;

(*
 * LoadFileIntoStream
 *)

function LoadFileIntoStream(iFile : String) : TMemoryStream;
begin
 Result := TMemoryStream.Create;
 Result.LoadFromFile(iFile);
end;

(*
 * LoadFileIntoStringList
 *)

function LoadFileIntoStringList(iFile : String) : TStrings;
begin
 Result := TStringList.Create();

try
 Result.LoadFromFile( iFile );
except
 on Exception do;
end;

end;


(*
 * ValueInArray
 *)

function ValueInArray(Ax : Array of Integer; Val : Integer) : Boolean;
var
 CiC : Integer;
begin
 Result := False;
 for CiC := 0 to MaxStopPoints do
  if Ax[CiC] = Val then begin Result := True; Exit; End;
end;


(*
 * SelectDirectory
 *)

function SelectDirectory(const Caption: WideString; const Root: string; var Directory: string): Boolean;
begin
 Result := FileCtrl.SelectDirectory(Caption, Root, Directory);
end;


(*
 * PreCut
 *)

function MinimizeName(Str : String; Canvas : TCanvas; Len : Integer) : String;
begin
 if Length(Str)<20 then
   begin
    Result:=Str;
    Exit;
   end;
 Result := FileCtrl.MinimizeName(Str,Canvas,Len);
end;


(*
 * CharString
 *)

function CharString(C : Integer; Ch : Char) : String;
Var
 X : Integer;
begin

 Result := '';
   for X:=1 to C do Result:=Result+Ch;

end;

(*
 * IsSpace
 *)

function IsSpace(Ch : Char) : Boolean;
begin
 Result := (Ch = #32) or (Ch = #9); 
end;


(*
 * Gol
 *)

function Gol(St : String) : Boolean;
begin
 Result:=(St='') or (St=Space3);
end;

(*
 * KillSpaces
 *)

function KillSpaces(Str : String) : String;
var
 I : Integer;
begin
 Result := '';
 
 for I:=1 to Length(Str)
  do if not IsSpace(Str[I]) then Result:=Result+Str[I];
end;


(*
 * ExtractKw
 *)

Function ExtractKw(Str : String; nm : Integer) : String;
var
 i : Integer;
begin

for i:= 1 to Nm do
 begin
  if Pos(' ', Str) = 0 then
   begin
    if i<>Nm then Result := '' else
                  Result := Str;
    Exit;
   end;

  Result := Copy(Str, 1, Pos(' ', Str)-1);
  Delete(Str, 1, Pos(' ', Str) );
 end;

end;


(*
 *  AToI
 *)
function AToI;
Var
 Error : Integer;
begin
  Val(Ascii, Result, Error);
end;

(*
 * AToF
 *)
function AToF;
Var
 Error : Integer;
begin
 Val(Ascii, Result, Error);
end;

(*
 * SaveOption
 *)
procedure SaveOption;
Var
 Reg : TRegistry;
begin
 Reg := TRegistry.Create;

 try
   Reg.RootKey := root;

    if Reg.OpenKey(key, True) then
     begin
      Reg.WriteString(name,value);
      Reg.CloseKey;
     end;

   finally
    Reg.Free;
   end;
end;

(*
 *  LoadOption
 *)
function LoadOption;
Var
 Reg : TRegistry;
begin
  result:=default;
  Reg := TRegistry.Create;
 try
    Reg.RootKey := root;

    if Reg.OpenKey(Key, True) then
     begin
      if Reg.ValueExists(name) then result:=Reg.ReadString(name)
                               else result:=default;
      Reg.CloseKey;
     end;

   finally
    Reg.Free;
  end;
end;

(*
 *  DelOption
 *)
procedure DelOption;
Var
 Reg : TRegistry;
begin
  Reg := TRegistry.Create;
 try
    Reg.RootKey := root;

    if Reg.OpenKey(Key, True) then
     begin
      if Reg.ValueExists(name) then
       Reg.DeleteValue(name);
      Reg.CloseKey;
     end;

   finally
    Reg.Free;
 end;
end;


end.
