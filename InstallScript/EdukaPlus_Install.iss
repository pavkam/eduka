; *****************************************************
; * Eduka+ Install Script. Created for InnoSetup v5+  *
; *                                                   *
; *                                                   *
; *****************************************************
[code]
function IsDemo : Boolean;
begin
 Result := False;
 #include "EdukaPlus_Mode.inc"
end;

#include "EdukaPlus_Code.pas"

[Setup]
; This directive is used to prevent the user from installing new versions of an application
; while the application is still running, and to prevent the user from uninstalling a running application.
             AppMutex = EdukaMutexInstallation
;
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   ShowLanguageDialog = Yes
              AppName = {code:EdukaAppOpts|AppName}
           AppVersion = {code:EdukaAppOpts|Version}
           AppVerName = {code:EdukaAppOpts|AppName} {code:EdukaAppOpts|Version}
         AppPublisher = {code:EdukaAppOpts|Company}
      AppPublisherURL = {code:EdukaAppOpts|AppSite}
           AppContact = {code:EdukaAppOpts|AppSite}
        AppSupportURL = {code:EdukaAppOpts|AppSite}
        AppUpdatesURL = {code:EdukaAppOpts|AppSite}
         AppCopyright = Copyright © 2005 {code:EdukaAppOpts|Company}
          AppComments = {code:EdukaAppOpts|AppName}
VersionInfoDescription= Eduka+ Setup
   VersionInfoCompany = IRPG Software

       DefaultDirName = {pf}\{code:EdukaAppOpts|Company}\Eduka+
     DefaultGroupName = {code:EdukaAppOpts|AppName}
          LicenseFile = ..\License\License_English.rtf
  ChangesAssociations = Yes
  
          Compression = lzma
          ; *TODO*
     SolidCompression = yes
     
   OutputBaseFilename = Setup_beta-1.6.0
; - - - - - - - - - -
        SetupIconFile = style-app-setup-install.ico

; - - - - - - - - - -
 UninstallDisplayIcon = {app}\EdukaPlus.exe,0
 UninstallDisplayName = {code:EdukaAppOpts|AppName} {code:EdukaAppOpts|Version}
 
      WizardImageFile = SetupImages\WizModernImage.bmp
 WizardSmallImageFile = SetupImages\WizModernSmallImage.bmp
 WizardImageBackColor = clWhite

            BackColor = $421F12
           BackColor2 = $421F12
           
; --- This one is not good for 16bpp --
;
;
;           BackColor2 = $7C4229
;  BackColorDirection = lefttoright
;
;
; -------------------------------------

        WindowVisible = Yes
 WindowStartMaximized = Yes
    WindowShowCaption = Yes

   ShowComponentSizes = Yes
   

[Languages]
Name: en; MessagesFile: "compiler:Default.isl"
Name: ro; MessagesFile: "Languages\Romanian-3-4.2.1.isl";
Name: ru; MessagesFile: "Languages\Russian-19-4.1.8.isl";

[Types]

Name: "full";       Description: {code:EdukaMultiLang|InstallTypeFull}
Name: "compact";    Description: {code:EdukaMultiLang|InstallTypeCompact}
Name: "custom";     Description: {code:EdukaMultiLang|InstallTypeCustom};   Flags: iscustom

[Components]
Name: "Main";              Description: {code:EdukaMultiLang|MainComponent};              Types: full compact custom; Flags: fixed
Name: "ExamplesSamples";   Description: {code:EdukaMultiLang|ExamplesSamplesComponent};   Types: full compact
Name: "ExamplesExercises"; Description: {code:EdukaMultiLang|ExamplesExercisesComponent}; Types: full
Name: "ExamplesTests";     Description: {code:EdukaMultiLang|ExamplesTestsComponent};     Types: full
Name: "UKL";               Description: {code:EdukaMultiLang|UKLComponent};               Types: full compact custom; Flags: fixed

Name: "ROL";               Description: {code:EdukaMultiLang|ROLComponent};               Types: full compact custom; Flags: fixed; Languages: ro; Check: not IsDemo
Name: "ROL";               Description: {code:EdukaMultiLang|ROLComponent};               Types: full; Languages: ru en; Check: not IsDemo

Name: "RUL";               Description: {code:EdukaMultiLang|RULComponent};               Types: full compact custom; Flags: fixed; Languages: ru; Check: not IsDemo
Name: "RUL";               Description: {code:EdukaMultiLang|RULComponent};               Types: full; Languages: ro en; Check: not IsDemo

Name: "SNDS";              Description: {code:EdukaMultiLang|SNDSComponent};              Types: full


[Tasks]
Name: desktopicon; Description: {code:EdukaMultiLang|CreateDesktopShortcut};  GroupDescription: {code:EdukaMultiLang|CreateDesktopShotcutGroup};  Components: Main
Name: lromdiacr;   Description: "Utilizare limba romana cu diacritice";       GroupDescription: "Setari specifice limbei romane:"; Components: Main; Flags: unchecked; Languages: ro; Check: not IsDemo
Name: lromidini;   Description: "Gramatica Republica Moldova";                GroupDescription: "Setari specifice limbei romane:"; Components: Main; Flags: unchecked; Languages: ro; Check: not IsDemo
Name: security;    Description: {code:EdukaMultiLang|AdministrationShortcut}; GroupDescription: {code:EdukaMultiLang|AdministrationShortcutGroup}; Components: Main; Flags: unchecked; Check: not IsDemo

  
[Dirs]
Name: "{userdocs}\{code:EdukaMultiLang|MyDocuments}";
Name: "{userdocs}\{code:EdukaMultiLang|MyDocumentsSources}";
Name: "{userdocs}\{code:EdukaMultiLang|MyDocumentsSamples}";
Name: "{userdocs}\{code:EdukaMultiLang|MyDocumentsExercises}";
Name: "{userdocs}\{code:EdukaMultiLang|MyDocumentsDemoExercises}";
Name: "{userdocs}\{code:EdukaMultiLang|MyDocumentsExercisesHtml}";
Name: "{userdocs}\{code:EdukaMultiLang|MyDocumentsTests}";
Name: "{userdocs}\{code:EdukaMultiLang|MyDocumentsDemoTests}";
Name: "{userdocs}\{code:EdukaMultiLang|MyDocumentsTestsHtml}";

Name: "{app}\Languages"
Name: "{app}\Helps"
Name: "{app}\Sounds"

[Files]

Source: "..\Sounds\*.wav";                       DestDir: "{app}\Sounds";  Flags: ignoreversion; Components: SNDS

Source: "..\Packages\English\Standard Eduka+ Samples.epk.installed";            DestDir: "{app}\Packages";  Flags: ignoreversion; Components: ExamplesSamples; Languages: en
Source: "..\Packages\Russian\Standard Eduka+ Samples.epk.installed";            DestDir: "{app}\Packages";  Flags: ignoreversion; Components: ExamplesSamples; Languages: ru
Source: "..\Packages\Romanian\Standard Eduka+ Samples.epk.installed";           DestDir: "{app}\Packages";  Flags: ignoreversion; Components: ExamplesSamples; Languages: ro

Source: "..\Packages\English\Standard Eduka+ Exercise Samples.epk.installed";   DestDir: "{app}\Packages";  Flags: ignoreversion; Components: ExamplesExercises; Languages: en
Source: "..\Packages\Russian\Standard Eduka+ Exercise Samples.epk.installed";   DestDir: "{app}\Packages";  Flags: ignoreversion; Components: ExamplesExercises; Languages: ru
Source: "..\Packages\Romanian\Standard Eduka+ Exercise Samples.epk.installed";  DestDir: "{app}\Packages";  Flags: ignoreversion; Components: ExamplesExercises; Languages: ro

Source: "..\Packages\English\Standard Eduka+ Test Samples.epk.installed";       DestDir: "{app}\Packages";  Flags: ignoreversion; Components: ExamplesExercises; Languages: en
Source: "..\Packages\Russian\Standard Eduka+ Test Samples.epk.installed";       DestDir: "{app}\Packages";  Flags: ignoreversion; Components: ExamplesExercises; Languages: ru
Source: "..\Packages\Romanian\Standard Eduka+ Test Samples.epk.installed";      DestDir: "{app}\Packages";  Flags: ignoreversion; Components: ExamplesExercises; Languages: ro

Source: "..\Packages\English\Additional Eduka+ Romanian Language.epk.installed";            DestDir: "{app}\Packages";  Flags: ignoreversion; Components: ROL; Languages: en
Source: "..\Packages\Russian\Additional Eduka+ Romanian Language.epk.installed";            DestDir: "{app}\Packages";  Flags: ignoreversion; Components: ROL; Languages: ru
Source: "..\Packages\Romanian\Additional Eduka+ Romanian Language.epk.installed";           DestDir: "{app}\Packages";  Flags: ignoreversion; Components: ROL; Languages: ro

Source: "..\Packages\English\Additional Eduka+ Russian Language.epk.installed";       DestDir: "{app}\Packages";  Flags: ignoreversion; Components: RUL; Languages: en
Source: "..\Packages\Romanian\Additional Eduka+ Russian Language.epk.installed";      DestDir: "{app}\Packages";  Flags: ignoreversion; Components: RUL; Languages: ro
Source: "..\Packages\Russian\Additional Eduka+ Russian Language.epk.installed";       DestDir: "{app}\Packages";  Flags: ignoreversion; Components: RUL; Languages: ru

Source: "..\Packages\English\Additional Eduka+ Sounds.epk.installed";       DestDir: "{app}\Packages";  Flags: ignoreversion; Components: SNDS; Languages: en
Source: "..\Packages\Russian\Additional Eduka+ Sounds.epk.installed";       DestDir: "{app}\Packages";  Flags: ignoreversion; Components: SNDS; Languages: ru
Source: "..\Packages\Romanian\Additional Eduka+ Sounds.epk.installed";      DestDir: "{app}\Packages";  Flags: ignoreversion; Components: SNDS; Languages: ro

Source: "..\EdukaPlus.exe";                      DestDir: "{app}";       Flags: ignoreversion; Components: main

Source: "..\Helps\css\*";                        DestDir: "{app}\Helps\css"; Flags: ignoreversion; Components: main
Source: "..\Helps\images\*";                     DestDir: "{app}\Helps\images"; Flags: ignoreversion; Components: main
Source: "..\Helps\images\imagelist\*";           DestDir: "{app}\Helps\images\imagelist"; Flags: ignoreversion; Components: main
Source: "..\Helps\js\*";                         DestDir: "{app}\Helps\js"; Flags: ignoreversion; Components: main

Source: "..\Helps\pages-en\*";                   DestDir: "{app}\Helps\pages-en";     Flags: ignoreversion skipifsourcedoesntexist; Components: UKL
Source: "..\Helps\pages-en\images\*";            DestDir: "{app}\Helps\pages-en\images";     Flags: ignoreversion skipifsourcedoesntexist; Components: UKL

Source: "..\Languages\Romanian_RO.lng";          DestDir: "{app}\Languages"; DestName: "Romanian_RO.lng"; Flags: ignoreversion skipifsourcedoesntexist; Components: ROL; Check: not IsDemo
Source: "..\Helps\pages-ro\*";                   DestDir: "{app}\Helps\pages-ro"; Flags: ignoreversion skipifsourcedoesntexist; Components: ROL; Check: not IsDemo
Source: "..\Helps\pages-ro\images\*";            DestDir: "{app}\Helps\pages-ro\images"; Flags: ignoreversion skipifsourcedoesntexist; Components: ROL; Check: not IsDemo

Source: "..\Languages\Russian_RU.lng";           DestDir: "{app}\Languages"; Flags: ignoreversion skipifsourcedoesntexist; Components: RUL; Check: not IsDemo
Source: "..\Helps\pages-ru\*";                   DestDir: "{app}\Helps\pages-ru"; Flags: ignoreversion skipifsourcedoesntexist; Components: RUL; Check: not IsDemo
Source: "..\Helps\pages-ru\images\*";            DestDir: "{app}\Helps\pages-ru\images"; Flags: ignoreversion skipifsourcedoesntexist; Components: RUL; Check: not IsDemo

Source: "..\Examples\Sources\Samples Suite\*.*";     DestDir: "{userdocs}\{code:EdukaMultiLang|MyDocumentsSamples}";       Flags: ignoreversion skipifsourcedoesntexist; Components: ExamplesSamples
Source: "..\Examples\Exercises\Demo Exercises\*.*";  DestDir: "{userdocs}\{code:EdukaMultiLang|MyDocumentsDemoExercises}"; Flags: ignoreversion skipifsourcedoesntexist; Components: ExamplesExercises
Source: "..\Examples\Tests\Demo Tests\*.*";          DestDir: "{userdocs}\{code:EdukaMultiLang|MyDocumentsDemoTests}";     Flags: ignoreversion skipifsourcedoesntexist; Components: ExamplesExercises

[Icons]

Name: "{group}\{code:EdukaMultiLang|AdministrationIcon}"; Filename: "{app}\EdukaPlus.exe"; Parameters : "--admin"; WorkingDir: "{app}"; IconFilename : "{app}\EdukaPlus.exe"; IconIndex: 12; Tasks: security; Check: not IsDemo
Name: "{group}\{code:EdukaMultiLang|AntIcon}";            Filename: "{app}\EdukaPlus.exe"; Parameters : "--ant"; WorkingDir: "{app}"; IconFilename : "{app}\EdukaPlus.exe"; IconIndex: 1; Comment: "{code:EdukaMultiLang|AntIcon}"
Name: "{group}\{code:EdukaMultiLang|KangarooIcon}";       Filename: "{app}\EdukaPlus.exe"; Parameters : "--kng"; WorkingDir: "{app}"; IconFilename : "{app}\EdukaPlus.exe"; IconIndex: 2; Comment: "{code:EdukaMultiLang|KangarooIcon}"
Name: "{group}\{code:EdukaMultiLang|TuxIcon}";            Filename: "{app}\EdukaPlus.exe"; Parameters : "--tux"; WorkingDir: "{app}"; IconFilename : "{app}\EdukaPlus.exe"; IconIndex: 3; Comment: "{code:EdukaMultiLang|TuxIcon}"
Name: "{group}\{code:EdukaMultiLang|HomePageIcon}";       Filename: "{app}\EdukaPlus.url"; Languages: en
Name: "{group}\{code:EdukaMultiLang|UnInstallIcon}";      Filename: "{uninstallexe}"; IconFilename : "{app}\EdukaPlus.exe"; IconIndex: 9
Name: "{userdesktop}\{code:EdukaMultiLang|AntIcon}";        Filename: "{app}\EdukaPlus.exe"; Parameters: "--ant"; WorkingDir: "{app}"; IconFilename : "{app}\EdukaPlus.exe"; IconIndex: 1; Tasks : "desktopicon"; Comment: "{code:EdukaMultiLang|AntIcon}"
Name: "{userdesktop}\{code:EdukaMultiLang|KangarooIcon}";   Filename: "{app}\EdukaPlus.exe"; Parameters: "--kng"; WorkingDir: "{app}"; IconFilename : "{app}\EdukaPlus.exe"; IconIndex: 2; Tasks : "desktopicon"; Comment: "{code:EdukaMultiLang|KangarooIcon}"
Name: "{userdesktop}\{code:EdukaMultiLang|TuxIcon}";     Filename: "{app}\EdukaPlus.exe"; Parameters: "--tux"; WorkingDir: "{app}"; IconFilename : "{app}\EdukaPlus.exe"; IconIndex: 3; Tasks : "desktopicon"; Comment: "{code:EdukaMultiLang|TuxIcon}"

Name: "{group}\{code:EdukaMultiLang|HelpIcon}";           Filename: "{app}\Helps\pages-ru\index.htm"; IconFilename : "{app}\EdukaPlus.exe"; IconIndex: 11; Languages: ru; Check: not IsDemo
Name: "{group}\{code:EdukaMultiLang|HelpIcon}";           Filename: "{app}\Helps\pages-ro\index.htm"; IconFilename : "{app}\EdukaPlus.exe"; IconIndex: 11; Languages: ro; Check: not IsDemo
Name: "{group}\{code:EdukaMultiLang|HelpIcon}";           Filename: "{app}\Helps\pages-en\index.htm"; IconFilename : "{app}\EdukaPlus.exe"; IconIndex: 11; Languages: en; Check: not IsDemo

[INI]
Filename: "{app}\EdukaPlus.url"; Section: "InternetShortcut"; Key: "URL"; String: "{code:EdukaAppOpts|AppSite}"

[UninstallDelete]
Type: filesandordirs; Name: "{pf}\{code:EdukaAppOpts|Company}"

[Registry]
Root: HKCU; Subkey: "Software\{code:EdukaAppOpts|Company}";              ValueType: string; ValueName: ""; ValueData: ""; Flags: uninsdeletekey

Root: HKCU; Subkey: "{code:EdukaAppOpts|RegistryPath}"; ValueType: string; ValueName: "DocPathMySources";       ValueData: "{code:EdukaMultiLang|MyDocumentsSources}";       Flags: uninsdeletekey
Root: HKCU; Subkey: "{code:EdukaAppOpts|RegistryPath}"; ValueType: string; ValueName: "DocPathMyExercises";     ValueData: "{code:EdukaMultiLang|MyDocumentsExercises}";     Flags: uninsdeletekey
Root: HKCU; Subkey: "{code:EdukaAppOpts|RegistryPath}"; ValueType: string; ValueName: "DocPathMyExercisesHtml"; ValueData: "{code:EdukaMultiLang|MyDocumentsExercisesHtml}"; Flags: uninsdeletekey
Root: HKCU; Subkey: "{code:EdukaAppOpts|RegistryPath}"; ValueType: string; ValueName: "DocPathMyTests";         ValueData: "{code:EdukaMultiLang|MyDocumentsTests}";         Flags: uninsdeletekey
Root: HKCU; Subkey: "{code:EdukaAppOpts|RegistryPath}"; ValueType: string; ValueName: "DocPathMyTestsHtml";     ValueData: "{code:EdukaMultiLang|MyDocumentsTestsHtml}";     Flags: uninsdeletekey

Root: HKCU; Subkey: "{code:EdukaAppOpts|RegistryPath}"; ValueType: string; ValueName: "CurrentLanguage";    ValueData: "{app}\Languages\English_UK.lng";      Flags: uninsdeletekey; Languages: en
Root: HKCU; Subkey: "{code:EdukaAppOpts|RegistryPath}"; ValueType: string; ValueName: "CurrentLanguage";    ValueData: "{app}\Languages\Romanian_RO.lng";     Flags: uninsdeletekey; Languages: ro
Root: HKCU; Subkey: "{code:EdukaAppOpts|RegistryPath}"; ValueType: string; ValueName: "CurrentLanguage";    ValueData: "{app}\Languages\Russian_RU.lng";      Flags: uninsdeletekey; Languages: ru

Root: HKCU; Subkey: "{code:EdukaAppOpts|RegistryPath}"; ValueType: string; ValueName: "ExtendedOpts";  ValueData: "050088050050055111049088047048080047088047050048083093047089047050049061063"; Flags: uninsdeletekey; Tasks: security; Check: not IsDemo
Root: HKCU; Subkey: "{code:EdukaAppOpts|RegistryPath}"; ValueType: string; ValueName: "ExtendedOpts";  ValueData: "088088050050049049044087088088050050049049105087088088050050049049108082088088050050049049044088"; Flags: uninsdeletekey; Tasks: not security; Check: not IsDemo

Root: HKCR; Subkey: ".ant"; ValueType: string; ValueName: ""; ValueData: "EdukaPlusANT"; Flags: uninsdeletekey
Root: HKCR; Subkey: ".kng"; ValueType: string; ValueName: ""; ValueData: "EdukaPlusKNG"; Flags: uninsdeletekey
Root: HKCR; Subkey: ".tux"; ValueType: string; ValueName: ""; ValueData: "EdukaPlusTUX"; Flags: uninsdeletekey

Root: HKCR; Subkey: ".etk"; ValueType: string; ValueName: ""; ValueData: "EdukaPlusETK"; Flags: uninsdeletekey
Root: HKCR; Subkey: ".epk"; ValueType: string; ValueName: ""; ValueData: "EdukaPlusEPK"; Flags: uninsdeletekey
Root: HKCR; Subkey: ".ett"; ValueType: string; ValueName: ""; ValueData: "EdukaPlusETT"; Flags: uninsdeletekey

; Languages ---------- Different

Root: HKCR; Subkey: "EdukaPlusANT"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Ant";      Flags: uninsdeletekey; Languages: en
Root: HKCR; Subkey: "EdukaPlusKNG"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Kangaroo"; Flags: uninsdeletekey; Languages: en
Root: HKCR; Subkey: "EdukaPlusTUX"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Tux";      Flags: uninsdeletekey; Languages: en

Root: HKCR; Subkey: "EdukaPlusETK"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Exercise";          Flags: uninsdeletekey; Languages: en
Root: HKCR; Subkey: "EdukaPlusEPK"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Package";           Flags: uninsdeletekey; Languages: en
Root: HKCR; Subkey: "EdukaPlusETT"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Test";          Flags: uninsdeletekey; Languages: en

; --------------------------------

Root: HKCR; Subkey: "EdukaPlusANT"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Furnica";      Flags: uninsdeletekey; Languages: ro
Root: HKCR; Subkey: "EdukaPlusKNG"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Cangur"; Flags: uninsdeletekey; Languages: ro
Root: HKCR; Subkey: "EdukaPlusTUX"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Pinguin";      Flags: uninsdeletekey; Languages: ro

Root: HKCR; Subkey: "EdukaPlusETK"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Exercitiu";          Flags: uninsdeletekey; Languages: ro
Root: HKCR; Subkey: "EdukaPlusEPK"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Pachet";          Flags: uninsdeletekey; Languages: ro
Root: HKCR; Subkey: "EdukaPlusETT"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Test";          Flags: uninsdeletekey; Languages: ro

; --------------------------------

Root: HKCR; Subkey: "EdukaPlusANT"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Муравей";      Flags: uninsdeletekey; Languages: ru
Root: HKCR; Subkey: "EdukaPlusKNG"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Кенгурёнок"; Flags: uninsdeletekey; Languages: ru
Root: HKCR; Subkey: "EdukaPlusTUX"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Пингвин";      Flags: uninsdeletekey; Languages: ru

Root: HKCR; Subkey: "EdukaPlusETK"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Задача";          Flags: uninsdeletekey; Languages: ru
Root: HKCR; Subkey: "EdukaPlusEPK"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Пакет";          Flags: uninsdeletekey; Languages: ru
Root: HKCR; Subkey: "EdukaPlusETT"; ValueType: string; ValueName: ""; ValueData: "Eduka+ Тест";          Flags: uninsdeletekey; Languages: ru

; ------------------------------- END


Root: HKCR; Subkey: "EdukaPlusANT\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\EdukaPlus.exe,4"
Root: HKCR; Subkey: "EdukaPlusKNG\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\EdukaPlus.exe,5"
Root: HKCR; Subkey: "EdukaPlusTUX\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\EdukaPlus.exe,6"

Root: HKCR; Subkey: "EdukaPlusETK\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\EdukaPlus.exe,7"
Root: HKCR; Subkey: "EdukaPlusEPK\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\EdukaPlus.exe,10"
Root: HKCR; Subkey: "EdukaPlusETT\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\EdukaPlus.exe,8"


Root: HKCR; Subkey: "EdukaPlusANT\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\EdukaPlus.exe"" ""--ant"" ""%1"""
Root: HKCR; Subkey: "EdukaPlusKNG\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\EdukaPlus.exe"" ""--kng"" ""%1"""
Root: HKCR; Subkey: "EdukaPlusTUX\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\EdukaPlus.exe"" ""--tux"" ""%1"""

Root: HKCR; Subkey: "EdukaPlusETK\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\EdukaPlus.exe"" ""--etk"" ""%1"""
Root: HKCR; Subkey: "EdukaPlusEPK\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\EdukaPlus.exe"" ""--epk"" ""%1"""
Root: HKCR; Subkey: "EdukaPlusETT\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\EdukaPlus.exe"" ""--ett"" ""%1"""

