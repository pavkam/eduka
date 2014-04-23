{
 Options and Names (e.g. Version names and etc.)
}

function EdukaAppOpts( Param: String): String;
begin
  if Param = 'ShortCompany' then
     Result := 'IRPG' else
     
  if Param = 'AppSite' then
     Result := 'http://www.ciobanu.org/' + EdukaAppOpts('ShortCompany') else
     
  if Param = 'AppName' then
     Result := 'Eduka+' else
     
  if Param = 'Version' then
    begin
     Result := '1.6.0';

     if IsDemo then Result := Result + ' Demo';
    end;
       
  if Param = 'Company' then
     Result := EdukaAppOpts('ShortCompany') + ' Software' else
     
  if Param = 'RegistryPath' then
     Result := 'Software\'+EdukaAppOpts('Company')+'\'+EdukaAppOpts('AppName')+'\'+EdukaAppOpts('Version') else

end;

{
 ---------------------------------------------------------------------
 I                        TRANSLATION ROUTINES                       I
 ---------------------------------------------------------------------
}
Const
  lngEN = 0;
  lngRO = 1;
  lngRU = 2;

function EdukaTranslator( EncoStr : String; Language : Integer): String;
begin

{
 ********************************************
 *              INSTALLATION PATHS          *
 ********************************************
}

  if EncoStr = 'MyDocuments' then
     case Language of
       lngEN : Result := 'My Eduka+ Files';
       lngRO : Result := 'Fisierele Eduka+';
       lngRU : Result := 'Мои Eduka+ файлы';
     end else
     
  if EncoStr = 'MyDocumentsSources' then
     case Language of
       lngEN : Result := EdukaTranslator('MyDocuments', Language) + '\Sources';
       lngRO : Result := EdukaTranslator('MyDocuments', Language) + '\Exercitii Rezolvate';
       lngRU : Result := EdukaTranslator('MyDocuments', Language) + '\Исходники';
     end else


  if EncoStr = 'MyDocumentsSamples' then
     case Language of
       lngEN : Result := EdukaTranslator('MyDocumentsSources', Language) + '\Samples Suite';
       lngRO : Result := EdukaTranslator('MyDocumentsSources', Language) + '\Suita';
       lngRU : Result := EdukaTranslator('MyDocumentsSources', Language) + '\Сборник';
     end else
     
  if EncoStr = 'MyDocumentsExercises' then
     case Language of
       lngEN : Result := EdukaTranslator('MyDocuments', Language) + '\Exercises';
       lngRO : Result := EdukaTranslator('MyDocuments', Language) + '\Exercitii';
       lngRU : Result := EdukaTranslator('MyDocuments', Language) + '\Задачи';
     end else

  if EncoStr = 'MyDocumentsDemoExercises' then
     case Language of
       lngEN : Result := EdukaTranslator('MyDocumentsExercises', Language) + '\Demo Exercises';
       lngRO : Result := EdukaTranslator('MyDocumentsExercises', Language) + '\Exemple';
       lngRU : Result := EdukaTranslator('MyDocumentsExercises', Language) + '\Примеры';
     end else

  if EncoStr = 'MyDocumentsExercisesHtml' then
     case Language of
       lngEN : Result := EdukaTranslator('MyDocumentsExercises', Language) + '\Html';
       lngRO : Result := EdukaTranslator('MyDocumentsExercises', Language) + '\Html';
       lngRU : Result := EdukaTranslator('MyDocumentsExercises', Language) + '\Html';
     end else

  if EncoStr = 'MyDocumentsTests' then
     case Language of
       lngEN : Result := EdukaTranslator('MyDocuments', Language) + '\Tests';
       lngRO : Result := EdukaTranslator('MyDocuments', Language) + '\Teste';
       lngRU : Result := EdukaTranslator('MyDocuments', Language) + '\Тесты';
     end else
     
  if EncoStr = 'MyDocumentsDemoTests' then
     case Language of
       lngEN : Result := EdukaTranslator('MyDocumentsTests', Language) + '\Demo Tests';
       lngRO : Result := EdukaTranslator('MyDocumentsTests', Language) + '\Exemple';
       lngRU : Result := EdukaTranslator('MyDocumentsTests', Language) + '\Примеры';
     end else

  if EncoStr = 'MyDocumentsTestsHtml' then
     case Language of
       lngEN : Result := EdukaTranslator('MyDocumentsTests', Language) + '\Html';
       lngRO : Result := EdukaTranslator('MyDocumentsTests', Language) + '\Html';
       lngRU : Result := EdukaTranslator('MyDocumentsTests', Language) + '\Html';
     end else

{
 ********************************************
 *              INSTALL TYPES               *
 ********************************************
}
  if EncoStr = 'InstallTypeFull' then
     case Language of
       lngEN : Result := 'Full installation';
       lngRO : Result := 'Instaleaza totul';
       lngRU : Result := 'Полная установка';
     end else
     
  if EncoStr = 'InstallTypeCompact' then
     case Language of
       lngEN : Result := 'Compact installation';
       lngRO : Result := 'Instalare compacta';
       lngRU : Result := 'Минимальная установка';
     end else
     
  if EncoStr = 'InstallTypeCustom' then
     case Language of
       lngEN : Result := 'Custom installation';
       lngRO : Result := 'Instalare selectiva';
       lngRU : Result := 'Выборочная установка';
     end else
     
{
 ********************************************
 *                 COMPONENTS               *
 ********************************************
}

  if EncoStr = 'MainComponent' then
     case Language of
       lngEN : Result := 'Core Eduka+ Files';
       lngRO : Result := 'Nucleul programului';
       lngRU : Result := 'Ядро программы';
     end else
     
  if EncoStr = 'ExamplesSamplesComponent' then
     case Language of
       lngEN : Result := 'Samples';
       lngRO : Result := 'Exemple';
       lngRU : Result := 'Примеры';
     end else

  if EncoStr = 'ExamplesExercisesComponent' then
     case Language of
       lngEN : Result := 'Exercises examples';
       lngRO : Result := 'Exemple de exercitii';
       lngRU : Result := 'Примеры задач';
     end else
     
  if EncoStr = 'ExamplesTestsComponent' then
     case Language of
       lngEN : Result := 'Tests examples';
       lngRO : Result := 'Exemple de teste';
       lngRU : Result := 'Примеры тестов';
     end else
     
  if EncoStr = 'UKLComponent' then
     case Language of
       lngEN : Result := 'English Support';
       lngRO : Result := 'Limba Engleza';
       lngRU : Result := 'Английский Язык';
     end else
     
  if EncoStr = 'ROLComponent' then
     case Language of
       lngEN : Result := 'Romanian Support';
       lngRO : Result := 'Limba Romana';
       lngRU : Result := 'Румынский Язык';
     end else
     
  if EncoStr = 'RULComponent' then
     case Language of
       lngEN : Result := 'Russian Support';
       lngRO : Result := 'Limba Rusa';
       lngRU : Result := 'Русский Язык';
     end else
     
  if EncoStr = 'SNDSComponent' then
     case Language of
       lngEN : Result := 'Sounds';
       lngRO : Result := 'Sunete';
       lngRU : Result := 'Звуки';
     end else
     
{
 ********************************************
 *                OTHER TASKS               *
 ********************************************
}
  if EncoStr = 'CreateDesktopShortcut' then
     case Language of
       lngEN : Result := 'Create &Desktop icons';
       lngRO : Result := 'Creare iconite pe &Masa de lucru';
       lngRU : Result := 'Создать ярлыки на &Рабочем столе';
     end else
     
  if EncoStr = 'CreateDesktopShotcutGroup' then
     case Language of
       lngEN : Result := 'Additional icons:';
       lngRO : Result := 'Iconite aditionale:';
       lngRU : Result := 'Дополнительные иконки:';
     end else
     
  if EncoStr = 'AdministrationShortcut' then
     case Language of
       lngEN : Result := 'Protected administration';
       lngRO : Result := 'Administrare protejata';
       lngRU : Result := 'Защита администрации';
     end else

  if EncoStr = 'AdministrationShortcutGroup' then
     case Language of
       lngEN : Result := EdukaAppOpts('AppName') + ' in schools:';
       lngRO : Result := EdukaAppOpts('AppName') + ' in scoli:';
       lngRU : Result := EdukaAppOpts('AppName') + ' в школах:';
     end else
     
{
 ********************************************
 *                  ICONS                   *
 ********************************************
}
  if EncoStr = 'AdministrationIcon' then
     case Language of
       lngEN : Result := EdukaAppOpts('AppName') + ' Administration';
       lngRO : Result := EdukaAppOpts('AppName') + ' Administrare';
       lngRU : Result := EdukaAppOpts('AppName') + ' Администрация';
     end else
     
  if EncoStr = 'AntIcon' then
     case Language of
       lngEN : Result := EdukaAppOpts('AppName') + ' Ant';
       lngRO : Result := EdukaAppOpts('AppName') + ' Furnica';
       lngRU : Result := EdukaAppOpts('AppName') + ' Муравей';
     end else

  if EncoStr = 'KangarooIcon' then
     case Language of
       lngEN : Result := EdukaAppOpts('AppName') + ' Kangaroo';
       lngRO : Result := EdukaAppOpts('AppName') + ' Cangur';
       lngRU : Result := EdukaAppOpts('AppName') + ' Кенгурёнок';
     end else
     
  if EncoStr = 'TuxIcon' then
     case Language of
       lngEN : Result := EdukaAppOpts('AppName') + ' Tux';
       lngRO : Result := EdukaAppOpts('AppName') + ' Pinguin';
       lngRU : Result := EdukaAppOpts('AppName') + ' Пингвин';
     end else
     
  if EncoStr = 'HomePageIcon' then
     case Language of
       lngEN : Result := EdukaAppOpts('ShortCompany') + ' ' + EdukaAppOpts('AppName') + ' Home page';
       lngRO : Result := EdukaAppOpts('ShortCompany') + ' ' + EdukaAppOpts('AppName') + ' Pagina gazda';
       lngRU : Result := EdukaAppOpts('ShortCompany') + ' ' + EdukaAppOpts('AppName') + ' Домашняя страничка';
     end else
     
  if EncoStr = 'UnInstallIcon' then
     case Language of
       lngEN : Result := 'Uninstall '   + EdukaAppOpts('AppName');
       lngRO : Result := 'Deinstalare ' + EdukaAppOpts('AppName');
       lngRU : Result := 'Удалить '     + EdukaAppOpts('AppName');
     end else

{
 ********************************************
 *                  HELP ICON               *
 ********************************************
}

  if EncoStr = 'HelpIcon' then
     case Language of
       lngEN : Result := 'Help '   + EdukaAppOpts('AppName');
       lngRO : Result := 'Ajutor ' + EdukaAppOpts('AppName');
       lngRU : Result := 'Справка ' + EdukaAppOpts('AppName');
     end else
     
{
 ********************************************
 *                  OTHER                   *
 ********************************************
}
  if EncoStr = 'MDSetupPageTitle' then
     case Language of
       lngEN : Result := 'Setup is Finishing'
       lngRO : Result := 'Instalarea se Incheie'
       lngRU : Result := 'Завершается Установка'
     end else

  if EncoStr = 'MDSetupPageContent' then
     case Language of
       lngEN : Result := 'Please wait while Setup finishes to prepare ' + EdukaAppOpts('AppName') + ' for usage ...';
       lngRO : Result := 'Va rugam sa asteptati pana Programul Instalare pregateste ' + EdukaAppOpts('AppName') + ' pentru utilizare ...';
       lngRU : Result := 'Пожалуйста подождите пока Программа Установки подготавливает ' + EdukaAppOpts('AppName') + ' для использования ...';
     end else

  if EncoStr = 'NoIE' then
     case Language of
       lngEN : Result := 'Your Internet Explorer version is too old. At least version 4 is required to properly display some of the programs''s features. Do you really want to continue installation?';
       lngRO : Result := 'Versiunea de Internet Explorer de care dispune sistemul Dvs. este prea veche. Cel putin versiunea 4 e necesara pentru a permite rularea unor optiuni incluse in program. Doriti sa continuati instalarea?';
       lngRU : Result := 'Текущая версия Internet Explorer не соответствует минимальным требованиям устаноки. Минимальная версия 4 требуется для использования специальных возможностей програмы. Продолжить?'
     end else
end;

function EdukaMultiLang( Param: String ): String;
begin
 if ActiveLanguage = 'en' then Result := EdukaTranslator( Param, lngEN );
 if ActiveLanguage = 'ro' then Result := EdukaTranslator( Param, lngRO );
 if ActiveLanguage = 'ru' then Result := EdukaTranslator( Param, lngRU );
end;


{
 Custom Setup Processings. Basically we will generate RO_S from RO by
 replacing all diacritics to simple characters if the files are copied.
}

procedure ReplaceIdinI(var St : String );
begin
 StringChange( St, 'В', 'О');
 StringChange( St, 'в', 'о');

 StringChange( St, 'ROMОN', 'ROMВN');
 StringChange( St, 'Romоn', 'Romвn');
 StringChange( St, 'romоn', 'romвn');
end;

procedure ReplaceIdinI_Ex(var St : String );
begin
 StringChange( St, '.В.', '.О.');
 StringChange( St, '.в.', '.о.');

 StringChange( St, 'ROM.О.N', 'ROM.В.N');
 StringChange( St, 'Rom.о.n', 'Rom.в.n');
 StringChange( St, 'rom.о.n', 'rom.в.n');
end;

procedure ReplaceDiacr(var St : String );
begin
 StringChange( St, 'є', 's');
 StringChange( St, 'О', 'I');
 StringChange( St, 'г', 'a');
 StringChange( St, 'о', 'i');
 StringChange( St, 'Є', 'S');

 StringChange( St, 'В', 'A');
 StringChange( St, 'в', 'a');

 StringChange( St, 'Ю', 'T');
 StringChange( St, 'ю', 't');
end;

procedure ReplaceDiacr_Ex(var St : String );
begin
 StringChange( St, '.є.', 's');
 StringChange( St, '.О.', 'I');
 StringChange( St, '.г.', 'a');
 StringChange( St, '.о.', 'i');
 StringChange( St, '.Є.', 'S');

 StringChange( St, '.В.', 'A');
 StringChange( St, '.в.', 'a');

 StringChange( St, '.Ю.', 'T');
 StringChange( St, '.ю.', 't');
end;

procedure ReplacePseudo(var St : String );
begin
 StringChange( St, '.є.', 'є');
 StringChange( St, '.О.', 'О');
 StringChange( St, '.г.', 'г');
 StringChange( St, '.о.', 'о');
 StringChange( St, '.Є.', 'Є');

 StringChange( St, '.В.', 'В');
 StringChange( St, '.в.', 'в');

 StringChange( St, '.Ю.', 'Ю');
 StringChange( St, '.ю.', 'ю');
end;

procedure GoAndReplace( MyPage : TOutputProgressWizardPage; theFile : String; var TotalPrc, Mprc : Integer; CeDo : Integer );
var
 FindRec               : TFindRec;
 St                    : String;
begin
  if FileExists( theFile ) then
    if LoadStringFromFile( theFile, St ) then
     begin
       case Cedo of
        0: ReplaceIdinI( St );
        1: ReplaceDiacr( St );
        2: ReplaceIdinI_Ex( St );
        3: ReplaceDiacr_Ex( St );
        4: ReplacePseudo( St );
       end;

       SaveStringToFile( theFile, St, false);

       TotalPrc := TotalPrc + 2;
       MyPage.SetProgress( TotalPrc, MPrc);

       Exit;
     end;

    if DirExists( theFile ) then
    if FindFirst( theFile + '\*', FindRec) then
    begin

      try

        repeat
          // Don't count directories
          if FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY = 0 then
               if LoadStringFromFile( theFile + '\' + FindRec.Name, St ) then
             begin
               case Cedo of
                0: ReplaceIdinI( St );
                1: ReplaceDiacr( St );
                2: ReplaceIdinI_Ex( St );
                3: ReplaceDiacr_Ex( St );
                4: ReplacePseudo( St );                
               end;
                  
               SaveStringToFile( theFile + '\' + FindRec.Name, St, false);

               TotalPrc := TotalPrc + 4;
               MyPage.SetProgress( TotalPrc, MPrc);
             end;

        until not FindNext( FindRec );

      finally
        FindClose(FindRec);
      end;
     end;

end;


procedure CurStepChanged(CurStep: TSetupStep);
var
 LangFile, HelpDir, St : String;
 ExeDir, TstDir        : String;
 FindRec               : TFindRec;
 MyPage                : TOutputProgressWizardPage;
 TotalPrc, MPrc        : Integer;

begin
 if ( CurStep <> ssPostInstall ) then Exit;

 TotalPrc := 0;
 MPrc     := 40;
 if IsTaskSelected('lromidini')     then MPrc := MPrc + 120;
 if not IsTaskSelected('lromdiacr') then Mprc := Mprc + 120;

 MyPage := CreateOutputProgressPage( EdukaMultiLang('MDSetupPageTitle') ,
                                     EdukaMultiLang('MDSetupPageContent') );

 MyPage.SetProgress( TotalPrc, MPrc );
 MyPage.Show;

 LangFile := ExpandConstant('{app}') + '\Languages\Romanian_RO.lng';
 HelpDir  := ExpandConstant('{app}') + '\Helps\pages-ro';

 ExeDir  := ExpandConstant('{userdocs}') + '\' + EdukaMultiLang('MyDocumentsDemoExercises');
 TstDir  := ExpandConstant('{userdocs}') + '\' + EdukaMultiLang('MyDocumentsDemoTests');

 if ( IsTaskSelected('lromidini') ) then
 begin
   GoAndReplace(MyPage, LangFile, TotalPrc, MPrc, 0);
   GoAndReplace(MyPage, HelpDir, TotalPrc, MPrc, 0);

   GoAndReplace(MyPage, ExeDir, TotalPrc, MPrc, 2);
   GoAndReplace(MyPage, TstDir, TotalPrc, MPrc, 2);
 end;

 if ( not IsTaskSelected('lromdiacr') ) then
 begin
   GoAndReplace(MyPage, LangFile, TotalPrc, MPrc, 1);
   GoAndReplace(MyPage, HelpDir, TotalPrc, MPrc, 1);

   GoAndReplace(MyPage, ExeDir, TotalPrc, MPrc, 3);
   GoAndReplace(MyPage, TstDir, TotalPrc, MPrc, 3);

 end;

   GoAndReplace(MyPage, ExeDir, TotalPrc, MPrc, 4);
   GoAndReplace(MyPage, TstDir, TotalPrc, MPrc, 4);

 MyPage.SetProgress(MPrc, MPrc);
 MyPage.Hide;
end;


{
 Checking for IE Version minimum 4 !
}

function InitializeSetup() : Boolean;
var
 IEVer       : String;
 pPos, pVer  : Integer;
begin
  if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'Software\Microsoft\Internet Explorer',     'Version', IEVer) then  begin    pPos := Pos( '.', IEVer );    pVer := StrToIntDef( Copy( IEVer, 1, pPos - 1 ), 0 );    if pVer >= 4 then    begin     Result := True;     Exit;    end;  end;  if MsgBox( EdukaMultiLang( 'NoIE' ) , mbConfirmation, MB_YESNO) = IDYES then     Result := True else     Result := False; end;
