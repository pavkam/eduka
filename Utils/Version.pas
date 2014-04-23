(*

The Original Code is: Version.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
    Versioning info.

*)

{ Include Compile Directives ! }
{$IFDEF SER_MAKER}
 {$I ..\Utils\directives.inc}
{$ELSE}
 {$I Utils\directives.inc}
{$ENDIF}

unit Version;
interface
Uses Windows;
Const
  OrganizationID =  'IRPG Software';
  ProgramID      =  'Eduka+';
  VVersion       =  '1.6.0';

{$IFDEF _TRIAL_}
  VersionID      =  VVersion + ' Demo';
{$ELSE}
  VersionID      =  VVersion;
{$ENDIF}

  FileVersionID  =  2;
  LicenseID      =  'Eduka+ EULA License';
  MPLID          =  'MPL License';
  ReleaseDate    =  '10.08.2005';
  SiteID         =  'http://www.ciobanu.org/EdukaPlus';
  BuySiteID      =  'http://www.ciobanu.org/EdukaPlus';

  RKEY            = HKEY_CURRENT_USER;

  VKey           = 'Software\'+OrganizationID+'\'+ProgramID+'\'+VersionID;


implementation

end.
