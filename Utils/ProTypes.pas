(*


The Original Code is: ProTypes.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

  Description : This unit containt all global used variables/
                constants and types

*)
{ Include Compile Directives ! }
{$IFDEF SER_MAKER}
 {$I ..\Utils\directives.inc}
{$ELSE}
 {$I Utils\directives.inc}
{$ENDIF}

{$WARNINGS OFF}
unit ProTypes;
interface
Uses ComCtrls, Messages, SynEdit, Version, Windows, Graphics, Classes;
Const
  {My Documents}
  TmpFileName = 'edukaplus.~tmp';
  KeyFileName = 'edukaplus.edkl';

  extFileKng  = '.kng';
  extFileTux  = '.tux';
  extFileAnt  = '.ant';
  extFileExercise = '.etk';
  extFilePackage = '.epk';  
  extFileTest = '.ett';
  extFileHtm  = '.htm';
  extFileHtml = '.html';

  EdukaFileHeader       = 'Eduka+ File Format (Created by Program: '+ProgramID+' Version: '+VersionID+')';

  EdukaKNGFileFormatID  = 0;
  EdukaANTFileFormatID  = 1;
  EdukaTUXFileFormatID  = 2;
  EdukaExerciseFileFormatID = 3;
  EdukaTESTFileFormatID = 4;

  EdukaFileGridSection  = '[Grid]';
  EdukaFileInfoSection  = '[File Info]';
  EdukaFileDescrSection = '[Data]';
  EdukaFileCodeSection  = '[Code]';
  EdukaFileExerciseSection  = '[Exercise]';
  EdukaFileLangSection  = '[Language]';

  thSleepTime           = 50;

  EdukaDefaultPassword  = '#1234567890#';

  PersonalFolder = {CSIDL_PERSONAL}  $0005;

 // Help Pages
  hlp_Index      = 'index';
  hlp_Errors     = '041039';
  hlp_Glossary   = '058057';

 WM_SelectConditionClose        = WM_USER+1;
 WM_SelectTimesClose            = WM_USER+2;
 WM_SelectNameClose             = WM_USER+3;
 WM_SelectInterpreterClose      = WM_USER+4;
 WM_SelectLanguageClose         = WM_USER+5;
 WM_SelectStudentClose          = WM_USER+8;
 WM_EnableAllControls           = WM_USER+6;
 WM_SetGridSize                 = WM_USER+7;
 WM_GetThoseFiles               = WM_USER+9;
 WM_InstructionCalculate        = WM_USER+10;
 WM_ShowError                   = WM_USER+11;

 MaxStopPoints   = 9;
 
 grid_12 = 12;
 grid_15 = 15;
 grid_18 = 18;
 grid_20 = 20;
 grid_24 = 24;
 grid_30 = 30;
 grid_36 = 36;
 grid_40 = 40;
 grid_45 = 45;

 MaxTableWidth = 50;
 AdmModeWidth   = 310;
 AdmModeHeight  = 360;

 DiroCharacters               = ['<','>','=','|',']','['];

 Enter                        = #13+#10;
 Space                        = #32;
 Space3                       = Space + Space + Space;


 SwapXCoords                  = 20;

 nExercises = 30;
 nLangs = 30;
 nCondTokens = 5;

 UnregisteredTime             = 5;
 
        _TuxCondition_    =  210;
        _Pick_            =  200;
        _Drop_            =  201;
        _Swap_            =  202;
        _Remember_        =  203;
        _Restore_         =  204;
        _Forget_          =  205;
        _Step_            =  11;
        _Jump_            =  12;
        _Rotate_          =  13;
        _Left_            =  21;
        _Right_           =  22;
        _Up_              =  23;
        _Down_            =  24;
        _Repeat_          =  31;
        _While_           =  32;
        _Until_           =  35;
        _If_              =  33;
        _Procedure_       =  34;
        _Is_Line_         =  41;
        _Is_Border_       =  43;
        _Is_Not_Border_   =  44;
        _Is_Not_Line_     =  45;
        _Start_           =  55;
        _End_             =  56;
        _Times_           =  57;
        _Do_              =  58;
        _Then_            =  60;
        _Else_            =  61;
        _Not_             =  62;
        _Call_            =  90;
        _Call_Procedure_  =  91;
        _Identifier_      =  00;

Type
  TFingerPrint = array [1..4] of LongInt;

  {
   The Main Node Structure. The heart of our Logics implementation
   It contains lots of info. Ex. you can obtain the line, start and end
   of a token, even when running this nodes.
  }

  PNode = ^TNode;
  TNode = record
            PId   : Byte;
            ConId : SmallInt;
            AdvP  : Word;
            ChLen : Word;
            StPar : String;
            Finger: TFingerPrint;
            Children : array of PNode;
              Parent : PNode;

            pSt, pEn : Byte;
            pLn      : Word;
           end;



  // Type used in ReferenceNode , to identify the action to perform
 TLinkType = (ltNewNode ,ltNewChild, ltBackNode);

 DispatchCallbackFunc = function(NodePtr : Pointer;var Finger : TFingerPrint; var PId : Byte; var ConId : SmallInt; var AdvP : Word; StPar : String; pSt, pEn : Byte; pLn : Word) : Boolean;

 TLabelEntryType = (letProcedure);
 TLogicsError = (leNoError, leLabelDefined, leStackEmpty, leCreateRoot, leCreateNode, leNoLabel);
 TLabelEntry = record
                  LabelType : TLabelEntryType;
                  Name      : String;
                  Node      : PNode;
                end;

 TErrorStyle         = (esNormal, esFatal, esMedium, esRuntime);

 TOtherGrid          = (otPrimary, otTemp, otExerciseG1, otExerciseG2, otTestG1, otTestG2);

 TWachStatus         = (wtchLeft, wtchRight, wtchUp, wtchDown);
 TProInterpreter     = (piAnt, piKng, piTux);
 SyntaxTextHolder    =  TSynEdit;
 HLPSyntaxTextHolder =  TRichEdit;
 TInsertPosition     = (ipBegin, ipCursor, ipEnd);
 TSoundEventType     = ( sndError, sndSuccess, sndRuntimeError,
                         sndInformation, sndOverTick, sndDlgTick,
                         sndJustTick);
 TTableIndex         =  1..MaxTableWidth;
 TInTableCells       = record
                          Pres : Boolean;
                          Oriz : Boolean;
                          Vert : Boolean;
                          Word : String;
                       end;

 TSyntaxChain           = record
                             Str          : String;
                             Id,Ln,St,En  : Integer;
                           end;

 DispatchSyntaxCallback = procedure(LineNum,St,En : Integer; Str : String);


 TMemoryType     =  record
                      mName  : String;
                      mPos   : array of Record
                                          X, Y, DirX : Integer;
                                        end;
                      mStack : Integer;
                      mFunc  : Boolean;
                     end;

 TProTable        = array[TTableIndex, TTableIndex] of TInTableCells;

 TLangInfoFormat     = record
                         Title,
                          Descr,
                           Rests,
                             Lng : String;
                        end;

 TLangInfoArrayFormat = array[0..nLangs] of TLangInfoFormat;

 TMajorExerciseFormat    = record
                         Author          : String;

                         Duration        : Integer;
                         Skill           : Integer;
                         Interpreter     : TProInterpreter;

                           TableMax      : Integer;

                         InGrid, OutGrid : TProTable;

                         InDirectionalX,
                           InDirectionalY  : Integer;

                         OutDirectionalX,
                           OutDirectionalY  : Integer;

                         InPositionalX,
                           InPositionalY    : Integer;

                         OutPositionalX,
                           OutPositionalY    : Integer;
                        end;

 TAvailExerciseFileInfo      = record
                            Interpreter : TProInterpreter;
                            Skill    : Integer;
                            Duration : Integer;
                            Title    : String;
                            FileName : String;
                           end;

 TSelExerciseFileInfo        = record
                            FileName : String;
                            Info1    : TMajorExerciseFormat;
                            Info2    : TLangInfoArrayFormat;

                            SelExercise   : String;
                            WasSuccess,
                              NowSuccess : Boolean;

                           end;

  TEdukaExecutionMode  = ( eemPreRun, eemRun, eemTerminate, eemReg );

Var
 FileSndError,
 FileSndSuccess,
 FileSndRuntimeError,
 FileSndInformation,
 FileSndOverTick,
 FileSndDlgTick,
 FileSndJustTick    : Pointer;

  MySources,
   MyExercises,
    MyExercisesHtml,
     MyTests,
      MyTestsHtml     :  String;

 CurrentInterpreter     : TProInterpreter;
 CurrentInterpreterName : String;

 IdentCharacters    : Set of Char;//= [ 'A'..'Z'];//#33..#$7a, #$7c..#255 ];

 RegUser, RegOrg    : String;
 RegInfo            : String;
 RegDate            : TDateTime;
 RegLKey            : TStrings;

 RegSerialValid     : Boolean;

 CurrentLine        : Integer;
 CurrentStart       : Integer;
 CurrentEnd         : Integer;
 ReadInterpreter    : TProInterpreter;
      sFileName     : String;

   InLaunchedTestMode,
 ExerciseEditorMode,
     ExerciseEditorFile : Boolean;

 TestEditorMode,
     TestEditorFile : Boolean;

    PLangs         : TLangInfoArrayFormat;
    {descriierile restrictiile titlurile (numai Exercise editor)}

    PrevLang       : Integer;

  MyDocuments      : PChar;

  CurrentExerciseInfo  : TMajorExerciseFormat;
  CurrentExerciseNr    : Integer;
  {}

   iSortedAvailableFileList,
    iAvailableFileList,
      iSelectedFileList  : Integer;
           {iSelectedFileList 0..6=7 Cite probleme sunt in test}
   SortedAvailableFileList,
      AvailableFileList  : Array of TAvailExerciseFileInfo;

          {problemele din test}
        SelectedFileList : Array[0..nExercises] of TSelExerciseFileInfo;


 Condition,
    ProcName,
       RepeatTimes,
         Student_Name : String;

 StepByStepHighlighting : Boolean;

 _Handle : HWND;

 KillThreadFlag    : Boolean;
 ExecutionStarted  : Boolean;
  GridPixelSize : Integer;
       Wait        : Word;
      u,v          : integer;
   tempTable, t, tb1, tb2, tb_    : TProTable;
          tabMax   : integer;
          CurrentX, CurrentY : Integer;

      tempsx, tempsy : integer;
               sx,sy : integer;
       current_i, current_j : Integer;

      u1,v1,u2,v2,u_,v_   : Integer;
      sx1,sy1, sx2,sy2,sx_,sy_ : Integer;
    GridMap  : TBitmap;

    StartedInStepMode : Boolean;
    WaitForNewStep    : Boolean;
    BkList            : array[0..MaxStopPoints] of Integer;

    InCriticalStage   : Boolean;

    ExtendedPackage,
     ExtendedDynamic,
      ExtendedDebug,
       ExtendedAcademic,
        AdministrativeStart : Boolean;

        AdministrationPassword : String;

   AnimalReset : Boolean;
   MainDisableSound : Boolean;

   ExecutionMode    : TEdukaExecutionMode;
{$WARNINGS ON}    
implementation

end.
