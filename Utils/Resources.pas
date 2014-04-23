(*

The Original Code is: Resources.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
     Unit is intended just to import two resourse files
     into application : icons.res and WindowsXP.res.
     And, then,  initialize the common controls.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit Resources;
interface
 Uses ComCtrls;

implementation
{$R icons.res}

{$IFDEF _FORXP_}
{$R WindowsXP.res}

initialization
 InitCommonControl(0);
{$ENDIF}

end.
