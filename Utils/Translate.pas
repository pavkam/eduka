(*

The Original Code is: Translate.pas, released 2005-02-02.
Authors of this file are Popov John and Ciobanu Alexander. All Rights Reserved.

  Description : This unit controls all translation-related
                routines.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit Translate;
interface
 Uses SysUtils, Main, Forms, Utils, ProTypes, Version
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;
Const
{$IFDEF _DEBUG_}
  DbgUName  =  '/Utils/Translate.pas';
{$ENDIF}

{-TUX-}


engSY_Pick       =  'Pick';
engSY_Drop       =  'Drop';
engSY_Swap       =  'Swap';
engSY_Remember   =  'Memorize';
engSY_Restore    =  'Restore';
engSY_Forget     =  'Forget';
engSY_START      =  'Begin';
engSY_END        =  'End';
engSY_LEFT       =  'Left';
engSY_RIGHT      =  'Right';
engSY_UP         =  'Up';
engSY_DOWN       =  'Down';
engSY_JUMP       =  'Jump';
engSY_STEP       =  'Step';
engSY_ROTATE     =  'Rotate';
engSY_WHILE      =  'While';
engSY_UNTIL      =  'Until';
engSY_REPEAT     =  'Repeat';
engSY_IF         =  'If';
engSY_ELSE       =  'Else';
engSY_PROCEDURE  =  'Procedure';
engSY_IS_BORDER  =  'IsBorder';
engSY_IS_LINE    =  'IsLine';
engSY_TIMES      =  'Times';
engSY_DO         =  'Do';
engSY_THEN       =  'Then';
engSY_CALL       =  'Call';
engSY_NOT        =  'Not';

engSY_Cond1      =  'Border Will Follow';
engSY_Cond2      =  'Cell Contains Letter';
engSY_Cond3      =  'Pocket Contains Letter';
engSY_Cond4_     =  'Can Remember';

engSY_Cond5      =  'Cell = Pocket';
engSY_Cond6      =  'Cell > Pocket';
engSY_Cond7      =  'Cell < Pocket';

engSY_Cond8_     =  'Cell =';
engSY_Cond9_     =  'Cell >';
engSY_Cond10_    =  'Cell <';

engSY_Cond11_    =  'Pocket =';
engSY_Cond12_    =  'Pocket >';
engSY_Cond13_    =  'Pocket <';

engSY_Cond14     =  'Pocket Is Uppercase';
engSY_Cond15     =  'Cell Is Uppercase';

engSY_Cond16      =  'Pocket = Cell';
engSY_Cond17      =  'Pocket > Cell';
engSY_Cond18      =  'Pocket < Cell';

engSY_LTTRS      =  'abcdefghijklmnopqrstuvwxyz_';
engSY_SGNS       =  '0123456789';

engNAME          =  'English';
engCode          =  'US';

 procedure lngLoadSelectedLanguage(LngFile : String; MainEdukaForm : TMainEdukaForm);
   {
     Load an specified language file . if '' specified, default language loads.
   }

 function lngGetLanguageFileNameID(FName : String) : String;
   {
     Gets an ID from an specified language file.
   }
 function lngGetLanguageFileNameCode(FName : String) : String;
   {
    Gets an Code form a language file.
   }

 function lngSpeX(St, From : String) : Integer;
 function lngSpeX2(St, From : String) : String;
 function lngTrulySpeX(St : String) : Integer;
 function lngListSpeX ( Def : String ) : Integer;
 function lngTrulySpeX2(St : String; CondId : Integer) : Integer;
 function lngExtractSpeX ( iId, iNm : Integer) : String;

Var
  CurrentLanguage, CurrentLanguageCode,
    CurrentLanguageFileName,
      CurrentHelpFile : string;




SY_START,
SY_END,
SY_LEFT,
SY_RIGHT,
SY_JUMP,
SY_STEP,
SY_ROTATE,
SY_UP,
SY_DOWN,
SY_WHILE,
SY_UNTIL,
SY_REPEAT,
SY_IF,
SY_ELSE,
SY_PROCEDURE,
SY_IS_BORDER,
SY_IS_LINE,
SY_TIMES,
SY_DO,
SY_THEN,
SY_CALL,
SY_NOT,
SY_SGNS,
SY_LTTRS,

SY_Pick,
SY_Drop,
SY_Swap,
SY_Remember,
SY_Restore,
SY_Forget,

SY_Cond1,
SY_Cond2,
SY_Cond3,
SY_Cond4_,
SY_Cond5,
SY_Cond6,
SY_Cond7,
SY_Cond8_,
SY_Cond9_,
SY_Cond10_,
SY_Cond11_,
SY_Cond12_,
SY_Cond13_,
SY_Cond14,
SY_Cond15,
SY_Cond16,
SY_Cond17,
SY_Cond18,

ERR_0x00,
ERR_0x01,
ERR_0x03,
ERR_0x05,
ERR_0x06,
ERR_0x07,
ERR_0x0A,
ERR_0x0B,
ERR_0x0C,
ERR_0x0D,
ERR_0x0E,
ERR_0x0F,
ERR_0x10,
ERR_0x11,
ERR_0x12,
ERR_0x14,
ERR_0x15,
ERR_0x16,
ERR_0x17,
ERR_0x18,

ERR_0x19,
ERR_0x1A,
ERR_0x1B,
ERR_0x1C,
ERR_0x1D,
ERR_0x1E,
ERR_0x1F,

ERR_Line,


Dialog_C_SC,
Dialog_C_SM,
Dialog_C_ST,
Dialog_C_SN,
Dialog_C_SI,
Dialog_C_SL,
Dialog_C_SP,
Dialog_C_CS,
Dialog_C_HP,
Dialog_I_Ant,
Dialog_I_Kng,
Dialog_I_Tux,
Dialog_I_ETt,
Dialog_I_ETk,
Dialog_C_SS,
Dialog_C_NOTPK,
Dialog_PK_ERRMSG,
Dialog_PK_OKMSG,
Dialog_PK_ERRLMSG,
Dialog_PK_GOODMSG,
DIALOG_FC_ADMIN,

DLG_LOGIN_FC, 
DLG_LOGIN_LC,
DLG_LOGIN_BC,
DLG_LOGIN_FC1,
DLG_LOGIN_LC1,
DLG_LOGIN_BC1,
DLG_LOGIN_FC2,
DLG_LOGIN_LC2,
DLG_LOGIN_BC2,
DLG_MSG_NOPASS,
DLG_MSG_WRONGPASS,
DLG_MSG_NEWPASS,
DLG_MSG_MISSPASS,

REG_U_TRIAL,
REG_U_REGD,
REG_U_LTXT,
REG_U_LHDID,
REG_U_TXT,
REG_U_CAPT,
REG_U_OKRESTART,
REG_U_ERRRESTART,
REG_U_ITEM,
REG_U_ANNOY,
REG_U_DDREG,
REG_U_DDCONT,

REG_U_NOKEY,
REG_U_KEYINFO,
REG_U_INFO_KEY,

SS_StudName,
SS_ExportFile,

DLGINSTRUCTIONS,
DLGOK,
DLGCANCEL,
DLGYES,
DLGNO,
DLG_AFL,
DLG_SVQ,
DLG_ETQ,
DLGPROC,
DLGInstall,
DLGUnInstall,
DLG_AVPK,
DLGMEM,
CBMINUTES,
MDFED,
CBALL_ALL,
HLPEXIT,
WHATISTHIS,
ExerciseID,
DIRSELECT,
ExerciseISOK,
ExerciseWASOK,
ExerciseNOTOK,
TuxFilter,
AntFilter,
KngFilter,
ExerciseFilter,
TestFilter,
HtmlFilter,
PackageFilter,
SAVE_TITLE,
OPEN_TITLE,
HTML_Initial,
HTML_Final,
HTML_Printed_By,
HTML_Interpreter,
HTML_Test,
HTML_Resolved_By,
HTML_Unknown_Name,
HTML_Charset,
 StringUl  : string ;


implementation


procedure LoadIdentifierTable(IdT : String; DelIt : Boolean);
var
 i : Integer;
begin
 if DelIt then IdentCharacters := [];
 for i:= 1 to Length(IdT) do
                IdentCharacters := IdentCharacters + [IdT[i]];
end;

procedure lngSetupDefaultLanguage( MainEdukaForm : TMainEdukaForm );
begin
 {$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : lngSetupDefaultLanguage( MainEdukaForm:'+DbgAddr(Addr(MainEdukaForm))+')');
  DbgPlus;
 {$ENDIF}

 MainEdukaForm._File.Caption := 'File';
 MainEdukaForm.File_New.Caption := 'New';
 MainEdukaForm.File_Open.Caption := 'Open...';
 MainEdukaForm.File_Close.Caption := 'Close';
 MainEdukaForm.File_Save.Caption := 'Save';
 MainEdukaForm.File_SaveAs.Caption := 'Save As...';
 MainEdukaForm.File_ExportHTML.Caption := 'Export as HTML...';
 MainEdukaForm.File_Print.Caption := 'Print...';
 MainEdukaForm.File_Exit.Caption := 'Exit';

 MainEdukaForm._Edit.Caption := 'Edit';
 MainEdukaForm.Edit_Undo.Caption := 'Undo';
 MainEdukaForm.Extend_Edit.Caption := 'Enlarge Editor';
 MainEdukaForm.Edit_Cut.Caption := 'Cut';
 MainEdukaForm.Edit_Copy.Caption := 'Copy';
 MainEdukaForm.Edit_Paste.Caption := 'Paste';
 MainEdukaForm.Edit_SelectAll.Caption := 'Select All';
 MainEdukaForm.Edit_Clear.Caption := 'Clear';
 MainEdukaForm.Edit_ShowLines.Caption := 'Show Line Numbers';

 MainEdukaForm._Program.Caption := 'Program';
 MainEdukaForm.Program_CheckSyntax.Caption := 'Check Syntax';
 MainEdukaForm.Program_Run.Caption := 'Run';
 MainEdukaForm.Program_Stop.Caption := 'Stop';
 MainEdukaForm.Program_Step.Caption := 'Step';
 MainEdukaForm.Program_Stop_Point.Caption := 'Toggle Stop Point';

 MainEdukaForm._Options.Caption := 'Options';

 MainEdukaForm.Options_SelectLanguage.Caption := 'Select Language';
 MainEdukaForm.Options_SelectInterpreter.Caption := 'Select Interpreter';
 MainEdukaForm.Options_Sound.Caption := 'Enable/Disable Sounds';
 MainEdukaForm.Options_Highlight.Caption := 'Step-By-Step Highlight';

 MainEdukaForm.DskShortcuts.Caption := 'Create Desktop Shortcuts';
 MainEdukaForm._PackageManager.Caption := 'Package Manager';

 MainEdukaForm._Window.Caption := 'Grid';
 MainEdukaForm.Window_ResetGrid.Caption := 'Bring Default Grid';
 MainEdukaForm.Window_SaveGrid.Caption := 'Save Grid as Default';
 MainEdukaForm.Window_ClearGrid.Caption := 'Clear Current Grid';

 MainEdukaForm._Help.Caption := 'Help';
 MainEdukaForm.Help_Topics.Caption := 'Help Topics';

 MainEdukaForm.Help_About.Caption := 'About';

 MainEdukaForm._Commands.Caption := 'Instructions';
 MainEdukaForm.Kng_Basic.Caption := 'Basic';
 MainEdukaForm.Kng_Advanced.Caption := 'Advanced';
 MainEdukaForm.Kng_Condition.Caption := 'Conditions';
 MainEdukaForm.ant_Basic.Caption := 'Basic';
 MainEdukaForm.ant_Advanced.Caption := 'Advanced';
 MainEdukaForm.ant_Condition.Caption := 'Conditions';

 MainEdukaForm.tux_Advanced.Caption := 'Advanced';
 MainEdukaForm.tux_Basic.Caption := 'Basic';

 MainEdukaForm.ac_tux_Start.Caption := 'Begin';
 MainEdukaForm.ac_tux_End.Caption := 'End';
 MainEdukaForm.ac_tux_Step.Caption := 'Step';
 MainEdukaForm.ac_tux_Rotate.Caption := 'Rotate';

 MainEdukaForm.ac_tux_Remember.Caption := 'Memorize';
 MainEdukaForm.ac_tux_Forget.Caption := 'Forget';
 MainEdukaForm.ac_tux_GoBack.Caption := 'Restore';
 MainEdukaForm.ac_tux_Call.Caption := 'Call';
 MainEdukaForm.ac_tux_Drop.Caption := 'Drop';
 MainEdukaForm.ac_tux_Pick.Caption := 'Pick';
 MainEdukaForm.ac_tux_Swap.Caption := 'Swap';

 MainEdukaForm.ac_tux_While.Caption := 'While';
 MainEdukaForm.ac_tux_Until.Caption := 'Until';
 MainEdukaForm.ac_tux_If.Caption := 'If';
 MainEdukaForm.ac_tux_Else.Caption := 'Else';
 MainEdukaForm.ac_tux_Procedure.Caption := 'Procedure';

 MainEdukaForm.tux_Start.Caption := 'Begin';
 MainEdukaForm.tux_End.Caption := 'End';

 MainEdukaForm.tux_Step.Caption := 'Step';
 MainEdukaForm.tux_Rotate.Caption := 'Rotate';
 MainEdukaForm.tux_While.Caption := 'While';
 MainEdukaForm.tux_Until.Caption := 'Until';

 MainEdukaForm.tux_Remember.Caption := 'Memorize';
 MainEdukaForm.tux_Forget.Caption := 'Forget';
 MainEdukaForm.tux_GoBack.Caption := 'Restore';
 MainEdukaForm.tux_Call.Caption := 'Call';
 MainEdukaForm.tux_DropLetter.Caption := 'Drop';
 MainEdukaForm.tux_PickLetter.Caption := 'Pick';
 MainEdukaForm.tux_SwapLetters.Caption := 'Swap';

 MainEdukaForm.tux_While.Caption := 'While';
 MainEdukaForm.tux_Until.Caption := 'Until';
 MainEdukaForm.tux_If.Caption := 'If';
 MainEdukaForm.tux_Procedure.Caption := 'Procedure';


 MainEdukaForm.ac_Kng_Start.Caption := 'Begin';
 MainEdukaForm.ac_Kng_End.Caption := 'End';
 MainEdukaForm.ac_Kng_Step.Caption := 'Step';
 MainEdukaForm.ac_Kng_Jump.Caption := 'Jump';
 MainEdukaForm.ac_Kng_Rotate.Caption := 'Rotate';
 MainEdukaForm.ac_Kng_While.Caption := 'While';
 MainEdukaForm.ac_Kng_Until.Caption := 'Until';

 MainEdukaForm.ac_Kng_Repeat.Caption := 'Repeat';
 MainEdukaForm.ac_Kng_If.Caption := 'If';
 MainEdukaForm.ac_Kng_Else.Caption := 'Else';
 MainEdukaForm.ac_Kng_Procedure.Caption := 'Procedure';
 MainEdukaForm.ac_Kng_Call.Caption := 'Call';
 MainEdukaForm.ac_Kng_Is_Line.Caption := 'IsLine';
 MainEdukaForm.ac_Kng_Is_Border.Caption := 'IsBorder';
 MainEdukaForm.ac_Kng_Is_Not_Line.Caption := 'Not IsLine';
 MainEdukaForm.ac_Kng_Is_Not_Border.Caption := 'Not IsBorder';

 MainEdukaForm.ac_ant_Start.Caption := 'Begin';
 MainEdukaForm.ac_ant_End.Caption := 'End';
 MainEdukaForm.ac_ant_Right.Caption := 'Right';
 MainEdukaForm.ac_ant_Left.Caption := 'Left';
 MainEdukaForm.ac_ant_Up.Caption := 'Up';
 MainEdukaForm.ac_ant_Down.Caption := 'Down';
 MainEdukaForm.ac_ant_While.Caption := 'While';
 MainEdukaForm.ac_ant_Until.Caption := 'Until';

 MainEdukaForm.ac_ant_Repeat.Caption := 'Repeat';
 MainEdukaForm.ac_ant_If.Caption := 'If';
 MainEdukaForm.ac_ant_Else.Caption := 'Else';
 MainEdukaForm.ac_ant_Procedure.Caption := 'Procedure';
 MainEdukaForm.ac_ant_Call.Caption := 'Call';
 MainEdukaForm.ac_ant_Is_Border.Caption := 'IsBorder';
 MainEdukaForm.ac_ant_Is_Not_Border.Caption := 'Not IsBorder';

 MainEdukaForm.Kng_Start.Caption := 'Begin';
 MainEdukaForm.Kng_End.Caption := 'End';

 MainEdukaForm.Kng_Step.Caption := 'Step';
 MainEdukaForm.Kng_Jump.Caption := 'Jump';
 MainEdukaForm.Kng_Rotate.Caption := 'Rotate';
 MainEdukaForm.Kng_While.Caption := 'While';
 MainEdukaForm.Kng_Repeat.Caption := 'Repeat';
 MainEdukaForm.Kng_If.Caption := 'If';
 MainEdukaForm.Kng_Procedure.Caption := 'Procedure';
 MainEdukaForm.Kng_Call.Caption := 'Call';
 MainEdukaForm.Kng_Is_Line.Caption := 'IsLine';
 MainEdukaForm.Kng_Is_Border.Caption := 'IsBorder';
 MainEdukaForm.Kng_Is_Not_Line.Caption := 'Not IsLine';
 MainEdukaForm.Kng_Is_Not_Border.Caption := 'Not IsBorder';


 MainEdukaForm.ant_Start.Caption := 'Begin';
 MainEdukaForm.ant_End.Caption := 'End';

 MainEdukaForm.ant_Right.Caption := 'Right';
 MainEdukaForm.ant_Left.Caption := 'Left';
 MainEdukaForm.ant_Up.Caption := 'Up';
 MainEdukaForm.ant_Down.Caption := 'Down';
 MainEdukaForm.ant_While.Caption := 'While';
 MainEdukaForm.ant_Repeat.Caption := 'Repeat';
 MainEdukaForm.ant_If.Caption := 'If';
 MainEdukaForm.ant_Procedure.Caption := 'Procedure';
 MainEdukaForm.ant_Call.Caption := 'Call';
 MainEdukaForm.ant_Is_Border.Caption := 'IsBorder';
 MainEdukaForm.ant_Is_Not_Border.Caption := 'Not IsBorder';

 MainEdukaForm._EditExercise.Caption:='Exercise Editor Mode';
 MainEdukaForm._EditTest.Caption:='Test Editor Mode';

 MainEdukaForm._Utils.Caption:='Tools';

 MainEdukaForm.Popup_Undo.Caption:=MainEdukaForm.Edit_Undo.Caption;
  MainEdukaForm.Popup_Copy.Caption:=MainEdukaForm.Edit_Copy.Caption;
   MainEdukaForm.Popup_Cut.Caption:=MainEdukaForm.Edit_Cut.Caption;
    MainEdukaForm.Popup_Paste.Caption:=MainEdukaForm.Edit_Paste.Caption;
     MainEdukaForm.Popup_SelectAll.Caption:=MainEdukaForm.Edit_SelectAll.Caption;
      MainEdukaForm.Popup_Clear.Caption:=MainEdukaForm.Edit_Clear.Caption;

      MainEdukaForm.Help_Q.Caption:='What Is This?';

 WhatIsThis:='What Is This?';
 MainEdukaForm.Static_Speed.Caption:='Speed :';

 MainEdukaForm.Tool_File_New.Hint   := MainEdukaForm.File_New.Caption;
 MainEdukaForm.Tool_File_Open.Hint  := MainEdukaForm.File_Open.Caption;
 MainEdukaForm.Tool_File_Close.Hint := MainEdukaForm.File_Close.Caption;
 MainEdukaForm.Tool_File_Save.Hint  := MainEdukaForm.File_Save.Caption;

 MainEdukaForm.Tool_Edit_Undo.Hint  := MainEdukaForm.Edit_Undo.Caption;
 MainEdukaForm.Tool_Edit_Cut.Hint   := MainEdukaForm.Edit_Cut.Caption;
 MainEdukaForm.Tool_Edit_Copy.Hint  := MainEdukaForm.Edit_Copy.Caption;
 MainEdukaForm.Tool_Edit_Paste.Hint := MainEdukaForm.Edit_Paste.Caption;

 MainEdukaForm.Tool_Program_Check.Hint := MainEdukaForm.Program_CheckSyntax.Caption;
 MainEdukaForm.Tool_Program_Run.Hint   := MainEdukaForm.Program_Run.Caption;
 MainEdukaForm.Tool_Program_Step.Hint   := MainEdukaForm.Program_Step.Caption;
 MainEdukaForm.Tool_Program_Stop.Hint  := MainEdukaForm.Program_Stop.Caption;

 MainEdukaForm.Tool_Window_Reset.Hint  := MainEdukaForm.Window_ResetGrid.Caption;
 MainEdukaForm.Tool_Window_Save.Hint   := MainEdukaForm.Window_SaveGrid.Caption;
 MainEdukaForm.Tool_Window_Clear.Hint  := MainEdukaForm.Window_ClearGrid.Caption;
 MainEdukaForm.Tool_Extend_Edit.Hint   := MainEdukaForm.Extend_Edit.Caption;


MainEdukaForm.Tool_Exercise_Show.Hint := 'Exercise Description';
MainEdukaForm.Tool_Exercise_Next.Hint := 'Next Exercise';
MainEdukaForm.Tool_Exercise_Prev.Hint := 'Previous Exercise';
MainEdukaForm.Tool_Exercise_Cond1.Hint := 'Initial Grid';
MainEdukaForm.Tool_Exercise_Cond2.Hint := 'Final Grid';



  HTML_Initial      := 'Initial Grid';
  HTML_Final        := 'Final Grid';
  HTML_Printed_By   := 'Printed by';
  HTML_Interpreter  := 'Interpreter';
  HTML_Test         := 'Test';
  HTML_Resolved_By  := 'Solved by';
  HTML_Unknown_Name := 'Unknown';
  HTML_Charset      := 'iso-8859-1';

 MainEdukaForm.PaintBox.Hint        := 'Initial Grid';

 MainEdukaForm.Pocket_Text.Caption   := 'Pocket:';
 MainEdukaForm.Msg_Label.Caption     := 'Messages Window';

 MainEdukaForm.gb_Author.Caption            := 'Author';
 MainEdukaForm.gb_DurationSkill.Caption     := 'Duration / Skill';
 MainEdukaForm.gb_Language.Caption          := 'Language';
 MainEdukaForm.gb_Title.Caption             := 'Title';
 MainEdukaForm.gb_Description.Caption       := 'Description';
 MainEdukaForm.gb_Restrictions.Caption      := 'Restrictions';
 MainEdukaForm.gb_Grids.Caption             := 'Grids (Initial/Final)';

 MainEdukaForm._c_Skill.ItemIndex:=0;
 MainEdukaForm._c_Skill.ItemsEx.ComboItems[0].Caption := 'Easy';
 MainEdukaForm._c_Skill.ItemsEx.ComboItems[1].Caption := 'Advanced';
 MainEdukaForm._c_Skill.ItemsEx.ComboItems[2].Caption := 'Expert';

 MainEdukaForm._c_Skill_I.ItemIndex:=0;
 MainEdukaForm._c_Skill_I.ItemsEx.ComboItems[0].Caption := 'All';
 MainEdukaForm._c_Skill_I.ItemsEx.ComboItems[1].Caption := 'Easy';
 MainEdukaForm._c_Skill_I.ItemsEx.ComboItems[2].Caption := 'Advanced';
 MainEdukaForm._c_Skill_I.ItemsEx.ComboItems[3].Caption := 'Expert';

 MainEdukaForm._c_Interpreter_I.ItemIndex:=0;
 MainEdukaForm._c_Duration_I.ItemIndex:=0;

 MainEdukaForm._c_Duration_I.ItemsEx.ComboItems[0].Caption := 'All';

 MainEdukaForm._c_Interpreter_I.ItemsEx.ComboItems[0].Caption := 'All';
 MainEdukaForm._c_Interpreter_I.ItemsEx.ComboItems[1].Caption := 'Ant';
 MainEdukaForm._c_Interpreter_I.ItemsEx.ComboItems[2].Caption := 'Kangaroo';
 MainEdukaForm._c_Interpreter_I.ItemsEx.ComboItems[3].Caption := 'Tux';

  MainEdukaForm.__Info_I.Caption       := 'Exercise Information';
  MainEdukaForm.__TestEditor_I.Caption := 'Test Editor';
  MainEdukaForm.__Filter_I.Caption     := 'Filter exercise list according to advanced criteria';
  MainEdukaForm.__Available_I.Caption  := 'Available exercises:';
  MainEdukaForm.__Selected_I.Caption   := 'Selected exercises:';
  MainEdukaForm._c_StartTest.Caption   := 'Launch Test';

 CBMINUTES := 'min.';

Dialog_C_SC := 'Select Condition';
Dialog_C_SM := 'Select Memory Group';
Dialog_C_ST := 'Select Cicle Count';
Dialog_C_SN := 'Select Procedure Name';
Dialog_C_SI := 'Select Interpreter';
Dialog_C_SL := 'Select Language';
DIALOG_FC_ADMIN := 'Administration';

DLGInstall       := 'Install New';
DLGUnInstall     := 'Uninstall Selected';
DLG_AVPK         := 'Installed Packages:';
Dialog_C_SP      := 'Package Manager';

DLG_LOGIN_FC      := 'Administration Check';
DLG_LOGIN_LC      := ProgramID+' Administration Password: ';
DLG_LOGIN_BC      := 'Login';

DLG_LOGIN_FC1     := 'Change Password';
DLG_LOGIN_LC1     := 'New '+ProgramID+' Administration Password: ';
DLG_LOGIN_BC1     := 'Change';

DLG_LOGIN_FC2     := 'Change Password';
DLG_LOGIN_LC2     := 'Verify New '+ProgramID+' Administration Password: ';
DLG_LOGIN_BC2     := 'Verify';


DLG_MSG_NOPASS    := 'No '+ProgramID+' Administration password has been supplied. Please create one.';
DLG_MSG_WRONGPASS := 'The password you have entered is wrong!';
DLG_MSG_NEWPASS   := 'New password has been saved. Use it at next login.';
DLG_MSG_MISSPASS  := 'Passwords do not match. New password hasn''t been set!';

       MainEdukaForm.cbEnableDyno.Caption    := 'Enable dynamic switch of languages and interpreters.';
       MainEdukaForm.cbEnableTst.Caption     := 'Enable Exercise and Test support.';
       MainEdukaForm.cbEnableDebug.Caption   := 'Enable Algorithm Debugging options.';
       MainEdukaForm.cbEnableAdmOpts.Caption := 'Enable Administration options (not recommended).';
       MainEdukaForm.btSetPass.Caption       := 'Change Password';

       MainEdukaForm.btQuitAdm.Caption       := 'Quit Administration';

MainEdukaForm.mEnableDyno.Text        := 'Enable this option to allow any user currently using '+
                                         ProgramID+' to switch between all available ' +
                                         'languages and interpreters.';

MainEdukaForm.mEnableTST.Text         := 'This option will activate the possibility of using the ' +
                                         'built-in exercise and test editors.';

MainEdukaForm.mEnableDebug.Text       := 'Debugging is a very useful method of finding bugs. '+
                                         'This option allows the usage of built-in debugging tools.';

                                          
MainEdukaForm.mEnableAdmOpts.Text     := 'It is not recommended to activate this option unless '+
                                         'this is a home computer or you know what you are '+
                                         'doing.';

DLGINSTRUCTIONS := 'Ran instructions:';

Dialog_C_HP := 'Help';
Dialog_C_CS := 'Confirm';

DLG_AFL     := 'Available Languages:';
DLG_SVQ     := 'Save changes to';
DLG_ETQ     := 'Save the results ? Press Yes or No buttons. Use Cancel button to return to the test.';
DLGOK       := 'OK';
DLGCANCEL   := 'Cancel';
DLGYES      := 'Yes';
DLGNO       := 'No';

Dialog_I_Ant:= 'Ant';
Dialog_I_Kng:= 'Kangaroo';
Dialog_I_Tux:= 'Tux';
Dialog_I_ETt:= 'Test Editor';
Dialog_I_ETk:= 'Exercise Editor';

DLGPROC       := '<Procedure Name>';
DLGMEM        := '<Memory Group Name>';
Dialog_C_SS   := 'Select test user''s name';
SS_StudName   := 'Test user''s name:';
SS_ExportFile := 'Export file name:';

MDFED       := 'Modified';
HLPEXIT     := 'Exit';
ExerciseID  := 'Exercise';
DIRSELECT   := 'Select directory to add to the existing list :';

ExerciseISOK    := 'Exercise succesefully solved!';
ExerciseWASOK   := 'Exercise was once a correctly solved!';
ExerciseNOTOK   := 'Exercise not yet solved!';

SAVE_TITLE := 'Save File';
OPEN_TITLE := 'Open File';


Dialog_C_NOTPK    := 'Information';
Dialog_PK_ERRMSG  := 'The file you wish to install doesn''t seem to be a valid '+ProgramID+' package!';
Dialog_PK_OKMSG   := 'The package "%s" contains %s files. Are you sure you want to continue?';
Dialog_PK_ERRLMSG := 'Installation of the selected package has partially failed!';
Dialog_PK_GOODMSG := 'Installation of the selected package succesefully finished.';

 SY_START     := engSY_START;
 SY_END       := engSY_END;
 SY_LEFT      := engSY_LEFT;
 SY_RIGHT     := engSY_RIGHT;

 SY_STEP      := engSY_STEP;
 SY_JUMP      := engSY_JUMP;
 SY_ROTATE    := engSY_ROTATE;

 SY_UP        := engSY_UP;
 SY_DOWN      := engSY_DOWN;
 SY_WHILE     := engSY_WHILE;
 SY_UNTIL     := engSY_UNTIL;
 SY_REPEAT    := engSY_REPEAT;
 SY_IF        := engSY_IF;
 SY_ELSE      := engSY_ELSE;
 SY_PROCEDURE := engSY_PROCEDURE;
 SY_IS_BORDER := engSY_IS_BORDER;
 SY_IS_LINE   := engSY_IS_LINE;
 SY_TIMES     := engSY_TIMES;
 SY_DO        := engSY_DO;
 SY_THEN      := engSY_THEN;
 SY_CALL      := engSY_CALL;
 SY_NOT       := engSY_NOT;
 SY_Pick      := engSY_Pick;
 SY_Drop      := engSY_Drop;
 SY_Swap      := engSY_Swap;
 SY_Remember  := engSY_Remember;
 SY_Restore   := engSY_Restore;
 SY_Forget    := engSY_Forget;

 SY_Cond1     :=  engSY_Cond1;
 SY_Cond2     :=  engSY_Cond2;
 SY_Cond3     :=  engSY_Cond3;
 SY_Cond4_    :=  engSY_Cond4_;
 SY_Cond5     :=  engSY_Cond5;
 SY_Cond6     :=  engSY_Cond6;
 SY_Cond7     :=  engSY_Cond7;
 SY_Cond8_    :=  engSY_Cond8_;
 SY_Cond9_    :=  engSY_Cond9_;
 SY_Cond10_   :=  engSY_Cond10_;
 SY_Cond11_   :=  engSY_Cond11_;
 SY_Cond12_   :=  engSY_Cond12_;
 SY_Cond13_   :=  engSY_Cond13_;
 SY_Cond14    :=  engSY_Cond14;
 SY_Cond15    :=  engSY_Cond15;
 SY_Cond16    :=  engSY_Cond16;
 SY_Cond17    :=  engSY_Cond17;
 SY_Cond18    :=  engSY_Cond18;

 SY_SGNS      := AnsiUpperCase(engSY_SGNS);
 SY_LTTRS     := AnsiUpperCase(engSY_LTTRS);

 // ---------- Registration Things

REG_U_TRIAL	      := 'Demo Version';
REG_U_REGD        := 'Expires on %d';
REG_U_LTXT        := 'Specify Key File:';
REG_U_TXT         := 'Buy a License!';
REG_U_ITEM        := 'Register';
REG_U_CAPT        := 'Register '+ProgramID;
REG_U_OKRESTART   := 'Selected Key File is valid until %d. Thank you for your support !';
REG_U_ERRRESTART  := 'The Key File you have entered is not a valid one! Try again!';
REG_U_ANNOY       := ProgramID+' is not registered. Consider registering '+ProgramID+' to be able to use it!';
REG_U_DDREG       := 'Register now !';
REG_U_DDCONT      := 'Exit ' + ProgramID;

REG_U_NOKEY       := 'No valid Key file selected.';
REG_U_KEYINFO     := 'Key registered for "%u" from "%o" and expires on %d.';

REG_U_INFO_KEY    := 'Key Information';

 // -------------------------------

 ERR_0x00 := 'Program syntax is OK';
 ERR_0x0A := 'Execution cannot continue. Interpreter has faced an obstacle.';
 ERR_0x0D := 'The program has entered an infinite loop. You can stop the execution by using Stop Button.';

 ERR_0x1A := 'Execution error. The pocket is empty.';
 ERR_0x1B := 'Execution error. The pocket is not empty.';
 ERR_0x1C := 'Execution error. The current cell is empty.';
 ERR_0x1D := 'Execution error. The current cell is not empty.';
 ERR_0x1E := 'Execution error. The "%d" memory group not found !';

 ERR_0x01 := '(0x01) Unexpected end of code text.';
 ERR_0x03 := '(0x03) Invalid or incomplete condition "%s" found .';
 ERR_0x05 := '(0x05) Keyword(s) "%s", expected in "%d" structure.';
 ERR_0x06 := '(0x06) Invalid number "%s" found in "%d" structure.';
 ERR_0x07 := '(0x07) The body of structure "%d" must contain at least one instruction.';
 ERR_0x0B := '(0x0B) Keyword(s) "%s" must exist in "%d" statement.';
 ERR_0x0C := '(0x0C) Keyword "%d" specifies the end of a structure which requires a beginning "%s" keyword.';
 ERR_0x1F := '(0x1F) A "%d" keyword that began a structure requires a "%s" keyword.';
 ERR_0x0E := '(0x0E) Procedure name expected.';
 ERR_0x0F := '(0x0F) Procedure "%s" has already been defined.';
 ERR_0x10 := '(0x10) Procedure name expected in "%d" structure.';
 ERR_0x11 := '(0x11) Procedure "%s" has not been defined yet.';
 ERR_0x12 := '(0x12) Unknown identifier, or incorrect instruction "%s".';
 ERR_0x14 := '(0x14) Some structures began without a "%d" termination.';
 ERR_0x15 := '(0x15) Invalid or improperly used keyword follows "%d" .';
 ERR_0x16 := '(0x16) No "%d" keyword found, cannot start program execution.';
 ERR_0x17 := '(0x17) Invalid or misplaced character used in "%s" identifier.';
 ERR_0x18 := '(0x18) Memory group name or a letter expected in "%d" structure.';
 ERR_0x19 := '(0x19) The identifier "%d" is supposed to be 1 character long.';

 ERR_Line := 'Line';


  TuxFilter   := 'Tux Files (*'+extFileTux+')|*'+extFileTux+'|All Files (*.*)|*.*';
  AntFilter   := 'Ant Files (*'+extFileAnt+')|*'+extFileAnt+'|All Files (*.*)|*.*';
  KngFilter   := 'Kangaroo Files (*'+extFileKng+')|*'+extFileKng+'|All Files (*.*)|*.*';
  ExerciseFilter  := ProgramID+' Exercise Files (*'+extFileExercise+')|*'+extFileExercise+'|All Files (*.*)|*.*';
  TestFilter  := ProgramID+' Test Files (*'+extFileTest+')|*'+extFileTest+'|All Files (*.*)|*.*';
  HtmlFilter  := 'HTML Format Files (*'+extFileHtml+';*'+extFileHtm+')|*'+extFileHtml+';*'+extFileHtm+'|All Files (*.*)|*.*';
  PackageFilter := ProgramID+' Package Files (*'+extFilePackage+')|*'+extFilePackage+'|All Files (*.*)|*.*';
 CurrentHelpFile:='pages-en';

 if not FileExists(ExtractFilePath(ParamStr(0))+'Helps\'+CurrentHelpFile+'\index.htm') then CurrentHelpFile:='';

 CurrentLanguageFileName:='';
 CurrentLanguage:=engName;
 CurrentLanguageCode := engCode;
{$IFDEF _DEBUG_}
 DbgMinus;
{$ENDIF}
end;

function lngExtractItemValue(From_a : string):string;
var         i, k : integer;
    default_item : string;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : lngExtractItemValue(From_a:'+From_a+')');
  DbgPlus;
{$ENDIF}

 i:=1;

 if (From_a<>'') and (From_a[1]<>'/') then
  begin
   while From_a[i]<>'"' do inc(i);
   k:=i;
   repeat inc(k); if k > Length(From_a) then break; until From_a[k]='"';
   default_item:=Copy(From_a,i+1,k-i-1);
  end;

 Result := default_item;

{$IFDEF _DEBUG_}
 DbgMinus;
 DbgPrint(DbgUName+' : lngExtractItemValue = '+Result);
{$ENDIF}
end;

function  lngExtractItem(StringLine : Shortstring):string;
var z : integer;
    tempStr : string;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : lngExtractItem(StringLine:'+StringLine+')');
  DbgPlus;
{$ENDIF}

 z:=1;
 if (StringLine<>'') and (StringLine[1]<>'/') then
  begin
   while not (StringLine[z] in [#32,#9]) do  inc(z);
   tempStr:=Copy(StringLine,1,z-1);
  end;
 Result:=tempStr;

{$IFDEF _DEBUG_}
 DbgMinus;
 DbgPrint(DbgUName+' : lngExtractItem = '+Result);
{$ENDIF}
end;

procedure lngTranslateItem(ConstantItem,ValueItem:String);
begin
 // Translate Interface :

 ValueItem := Replace(ValueItem, '${APP}', ProgramID);

 ConstantItem:=AnsiUpperCase(ConstantItem);

 if ConstantItem = 'NAME' then CurrentLanguage     := ValueItem;
 if ConstantItem = 'CODE' then CurrentLanguageCode := AnsiUpperCase(ValueItem);
  
 if ConstantItem = 'HELP_FILE' then
  begin
    CurrentHelpFile := ValueItem;
    if not FileExists(ExtractFilePath(ParamStr(0))+'Helps\'+CurrentHelpFile+'\index.htm') then CurrentHelpFile:='';
  end;


 if ConstantItem = 'FILE' then MainEdukaForm._File.Caption := ValueItem;
 if ConstantItem = 'FILE_NEW' then MainEdukaForm.File_New.Caption := ValueItem;
 if ConstantItem = 'FILE_OPEN' then MainEdukaForm.File_Open.Caption := ValueItem;
 if ConstantItem = 'FILE_CLOSE' then MainEdukaForm.File_Close.Caption := ValueItem;
 if ConstantItem = 'FILE_SAVE' then MainEdukaForm.File_Save.Caption := ValueItem;
 if ConstantItem = 'FILE_SAVEAS' then MainEdukaForm.File_SaveAs.Caption := ValueItem;
 if ConstantItem = 'FILE_PRINT' then MainEdukaForm.File_Print.Caption := ValueItem;
 if ConstantItem = 'FILE_EXPORT' then MainEdukaForm.File_ExportHTML.Caption := ValueItem;
 if ConstantItem = 'FILE_EXIT' then MainEdukaForm.File_Exit.Caption := ValueItem;


 if ConstantItem = 'EDIT' then MainEdukaForm._Edit.Caption := ValueItem;
 if ConstantItem = 'EDIT_EXTEND' then begin MainEdukaForm.Extend_Edit.Caption := ValueItem;end;
 if ConstantItem = 'EDIT_UNDO' then begin MainEdukaForm.Edit_Undo.Caption := ValueItem;MainEdukaForm.Popup_Undo.Caption:=MainEdukaForm.Edit_Undo.Caption;end;
 if ConstantItem = 'EDIT_CUT' then begin MainEdukaForm.Edit_Cut.Caption := ValueItem;MainEdukaForm.Popup_Cut.Caption:=MainEdukaForm.Edit_Cut.Caption;end;
 if ConstantItem = 'EDIT_COPY' then begin MainEdukaForm.Edit_Copy.Caption := ValueItem; MainEdukaForm.Popup_Copy.Caption:=MainEdukaForm.Edit_Copy.Caption;end;
 if ConstantItem = 'EDIT_PASTE' then begin MainEdukaForm.Edit_Paste.Caption := ValueItem;MainEdukaForm.Popup_Paste.Caption:=MainEdukaForm.Edit_Paste.Caption;end;
 if ConstantItem = 'EDIT_SELECTALL' then begin MainEdukaForm.Edit_SelectAll.Caption := ValueItem;MainEdukaForm.Popup_SelectAll.Caption:=MainEdukaForm.Edit_SelectAll.Caption;end;
 if ConstantItem = 'EDIT_CLEAR' then begin MainEdukaForm.Edit_Clear.Caption := ValueItem;MainEdukaForm.Popup_Clear.Caption:=MainEdukaForm.Edit_Clear.Caption;end;
 if ConstantItem = 'EDIT_SHOWLINES' then begin MainEdukaForm.Edit_ShowLines.Caption := ValueItem;MainEdukaForm.Popup_Clear.Caption:=MainEdukaForm.Edit_Clear.Caption;end;

 if ConstantItem = 'PROGRAM' then MainEdukaForm._Program.Caption := ValueItem;
 if ConstantItem = 'PROGRAM_CHECKSYNTAX' then MainEdukaForm.Program_CheckSyntax.Caption := ValueItem;
 if ConstantItem = 'PROGRAM_RUN' then MainEdukaForm.Program_Run.Caption := ValueItem;
 if ConstantItem = 'PROGRAM_STOP' then MainEdukaForm.Program_Stop.Caption := ValueItem;
 if ConstantItem = 'PROGRAM_STEP' then MainEdukaForm.Program_Step.Caption := ValueItem;
 if ConstantItem = 'PROGRAM_STOPPOINT' then MainEdukaForm.Program_Stop_Point.Caption := ValueItem;


 if ConstantItem = 'OPTIONS' then MainEdukaForm._Options.Caption := ValueItem;

 if ConstantItem = 'OPTIONS_SELECTLANGUAGE' then MainEdukaForm.Options_SelectLanguage.Caption := ValueItem;
 if ConstantItem = 'OPTIONS_SELECTINTERPRETER' then MainEdukaForm.Options_SelectInterpreter.Caption := ValueItem;
 if ConstantItem = 'OPTIONS_CREATESHORTCUTS' then MainEdukaForm.DskShortcuts.Caption := ValueItem;
 if ConstantItem = 'OPTIONS_PACKAGEMANAGER' then MainEdukaForm._PackageManager.Caption := ValueItem;
 if ConstantItem = 'OPTIONS_HIGHLIGHT' then MainEdukaForm.Options_Highlight.Caption := ValueItem;

 if ConstantItem = 'OPTIONS_SOUND' then MainEdukaForm.Options_Sound.Caption := ValueItem;

 if ConstantItem = 'WINDOW' then MainEdukaForm._Window.Caption := ValueItem;
 if ConstantItem = 'WINDOW_RESETGRID' then MainEdukaForm.Window_ResetGrid.Caption := ValueItem;

 if ConstantItem = 'WINDOW_SAVEGRID' then MainEdukaForm.Window_SaveGrid.Caption := ValueItem;
 if ConstantItem = 'WINDOW_CLEARGRID' then MainEdukaForm.Window_ClearGrid.Caption := ValueItem;

 if ConstantItem = 'HELP' then MainEdukaForm._Help.Caption := ValueItem;
 if ConstantItem = 'HELP_HELPTOPICS' then MainEdukaForm.Help_Topics.Caption := ValueItem;

 if ConstantItem = 'HELP_ABOUT' then MainEdukaForm.Help_About.Caption := ValueItem;

 if ConstantItem = 'TOOLS' then MainEdukaForm._Utils.Caption := ValueItem;
 if ConstantItem = 'TOOLS_EXERCISE_EDITOR' then  MainEdukaForm._EditExercise.Caption := ValueItem;
 if ConstantItem = 'TOOLS_TEST_EDITOR' then  MainEdukaForm._EditTest.Caption := ValueItem;


 if ConstantItem = 'COMMANDS' then MainEdukaForm._Commands.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_BASIC' then MainEdukaForm.Kng_Basic.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED' then MainEdukaForm.Kng_Advanced.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_BASIC' then MainEdukaForm.tux_Basic.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED' then MainEdukaForm.tux_Advanced.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_CONDITION' then MainEdukaForm.Kng_Condition.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC' then MainEdukaForm.ant_Basic.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED' then MainEdukaForm.ant_Advanced.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_CONDITION' then MainEdukaForm.ant_Condition.Caption := ValueItem;


 if ConstantItem = 'COMMANDS_BASIC_KNG_START' then MainEdukaForm.Kng_Start.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_KNG_END' then MainEdukaForm.Kng_End.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_BASIC_KNG_STEP' then MainEdukaForm.Kng_Step.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_KNG_JUMP' then MainEdukaForm.Kng_Jump.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_KNG_ROTATE' then MainEdukaForm.Kng_Rotate.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_WHILE' then MainEdukaForm.Kng_While.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_UNTIL' then MainEdukaForm.Kng_Until.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_REPEAT' then MainEdukaForm.Kng_Repeat.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_IF' then MainEdukaForm.Kng_If.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_PROCEDURE' then MainEdukaForm.Kng_Procedure.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_CALL' then MainEdukaForm.Kng_Call.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_IS_LINE' then MainEdukaForm.Kng_Is_Line.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_IS_BORDER' then MainEdukaForm.Kng_Is_Border.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_IS_NOT_LINE' then MainEdukaForm.Kng_Is_Not_Line.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_IS_NOT_BORDER' then MainEdukaForm.Kng_Is_Not_Border.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_BASIC_ANT_START' then MainEdukaForm.ant_Start.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_ANT_END' then MainEdukaForm.ant_End.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_BASIC_ANT_RIGHT' then MainEdukaForm.ant_Right.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_ANT_LEFT' then MainEdukaForm.ant_Left.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_ANT_UP' then MainEdukaForm.ant_Up.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_ANT_DOWN' then MainEdukaForm.ant_Down.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_WHILE' then MainEdukaForm.ant_While.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_UNTIL' then MainEdukaForm.ant_Until.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_REPEAT' then MainEdukaForm.ant_Repeat.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_IF' then MainEdukaForm.ant_If.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_PROCEDURE' then MainEdukaForm.ant_Procedure.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_CALL' then MainEdukaForm.ant_Call.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_IS_BORDER' then MainEdukaForm.ant_Is_Border.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_IS_NOT_BORDER' then MainEdukaForm.ant_Is_Not_Border.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_BASIC_TUX_START' then MainEdukaForm.Tux_Start.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_TUX_END' then MainEdukaForm.Tux_End.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_BASIC_TUX_STEP' then MainEdukaForm.tux_Step.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_TUX_ROTATE' then MainEdukaForm.tux_Rotate.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_WHILE' then MainEdukaForm.tux_While.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_UNTIL' then MainEdukaForm.tux_Until.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_IF' then MainEdukaForm.tux_If.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_PROCEDURE' then MainEdukaForm.tux_Procedure.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_CALL' then MainEdukaForm.tux_Call.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_ADVANCED_TUX_REMEMBER' then MainEdukaForm.tux_Remember.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_FORGET' then MainEdukaForm.tux_Forget.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_GOBACK' then MainEdukaForm.tux_GoBack.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_ADVANCED_TUX_PICK' then MainEdukaForm.tux_PickLetter.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_DROP' then MainEdukaForm.tux_DropLetter.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_SWAP' then MainEdukaForm.tux_SwapLetters.Caption := ValueItem;


 {Again for panels}

 if ConstantItem = 'COMMANDS_BASIC_KNG_START' then MainEdukaForm.ac_Kng_Start.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_KNG_END' then MainEdukaForm.ac_Kng_End.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_KNG_STEP' then MainEdukaForm.ac_Kng_Step.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_KNG_JUMP' then MainEdukaForm.ac_Kng_Jump.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_KNG_ROTATE' then MainEdukaForm.ac_Kng_Rotate.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_UNTIL' then MainEdukaForm.ac_Kng_Until.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_WHILE' then MainEdukaForm.ac_Kng_While.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_REPEAT' then MainEdukaForm.ac_Kng_Repeat.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_IF' then MainEdukaForm.ac_Kng_If.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_ELSE' then MainEdukaForm.ac_Kng_Else.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_PROCEDURE' then MainEdukaForm.ac_Kng_Procedure.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_CALL' then MainEdukaForm.ac_Kng_Call.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_IS_LINE' then MainEdukaForm.ac_Kng_Is_Line.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_IS_BORDER' then MainEdukaForm.ac_Kng_Is_Border.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_IS_NOT_LINE' then MainEdukaForm.ac_Kng_Is_Not_Line.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_KNG_IS_NOT_BORDER' then MainEdukaForm.ac_Kng_Is_Not_Border.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_BASIC_ANT_START' then MainEdukaForm.ac_ant_Start.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_ANT_END' then MainEdukaForm.ac_ant_End.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_ANT_RIGHT' then MainEdukaForm.ac_ant_Right.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_ANT_LEFT' then MainEdukaForm.ac_ant_Left.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_ANT_UP' then MainEdukaForm.ac_ant_Up.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_ANT_DOWN' then MainEdukaForm.ac_ant_Down.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_WHILE' then MainEdukaForm.ac_ant_While.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_UNTIL' then MainEdukaForm.ac_ant_Until.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_REPEAT' then MainEdukaForm.ac_ant_Repeat.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_IF' then MainEdukaForm.ac_ant_If.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_ELSE' then MainEdukaForm.ac_ant_Else.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_CALL' then MainEdukaForm.ac_ant_Call.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_PROCEDURE' then MainEdukaForm.ac_ant_Procedure.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_IS_BORDER' then MainEdukaForm.ac_ant_Is_Border.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_ANT_IS_NOT_BORDER' then MainEdukaForm.ac_ant_Is_Not_Border.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_BASIC_TUX_START' then MainEdukaForm.ac_tux_Start.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_BASIC_TUX_END' then MainEdukaForm.ac_tux_End.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_BASIC_TUX_STEP' then MainEdukaForm.ac_tux_Step.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_BASIC_TUX_ELSE' then MainEdukaForm.ac_tux_Else.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_BASIC_TUX_ROTATE' then MainEdukaForm.ac_tux_Rotate.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_WHILE' then MainEdukaForm.ac_tux_While.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_UNTIL' then MainEdukaForm.ac_tux_Until.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_IF' then MainEdukaForm.ac_tux_If.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_PROCEDURE' then MainEdukaForm.ac_tux_Procedure.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_CALL' then MainEdukaForm.ac_tux_Call.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_ADVANCED_TUX_REMEMBER' then MainEdukaForm.ac_tux_Remember.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_FORGET' then MainEdukaForm.ac_tux_Forget.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_GOBACK' then MainEdukaForm.ac_tux_GoBack.Caption := ValueItem;

 if ConstantItem = 'COMMANDS_ADVANCED_TUX_PICK' then MainEdukaForm.ac_tux_Pick.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_DROP' then MainEdukaForm.ac_tux_Drop.Caption := ValueItem;
 if ConstantItem = 'COMMANDS_ADVANCED_TUX_SWAP' then MainEdukaForm.ac_tux_Swap.Caption := ValueItem;


 if ConstantItem = 'HINT_CONDITIONS'  then MainEdukaForm.Tool_Exercise_Show.Hint := ValueItem;
 if ConstantItem = 'HINT_NEXTEXERCISE' then MainEdukaForm.Tool_Exercise_Next.Hint := ValueItem;
 if ConstantItem = 'HINT_PREVEXERCISE' then MainEdukaForm.Tool_Exercise_Prev.Hint := ValueItem;
 if ConstantItem = 'HINT_GRIDINITIAL'  then MainEdukaForm.Tool_Exercise_Cond1.Hint := ValueItem;
 if ConstantItem = 'HINT_GRIDFINAL'    then MainEdukaForm.Tool_Exercise_Cond2.Hint := ValueItem;

 if ConstantItem = 'HINT_GRIDINITIAL'  then MainEdukaForm.PaintBox.Hint := ValueItem;

 if ConstantItem = 'MODIFIED_LABEL' then MDFED:=ValueItem;

 if ConstantItem = 'POCKET_TEXT' then MainEdukaForm.Pocket_Text.Caption:=ValueItem;
 if ConstantItem = 'MSGLABEL_TEXT' then MainEdukaForm.Msg_Label.Caption:=ValueItem;

 if ConstantItem = 'GB_AUTHOR' then MainEdukaForm.gb_Author.Caption:=ValueItem;
 if ConstantItem = 'GB_DURATIONSKILL' then MainEdukaForm.gb_DurationSkill.Caption:=ValueItem;
 if ConstantItem = 'GB_LANGUAGE' then MainEdukaForm.gb_Language.Caption:=ValueItem;
 if ConstantItem = 'GB_TITLE' then MainEdukaForm.gb_Title.Caption:=ValueItem;
 if ConstantItem = 'GB_DESCRIPTION' then MainEdukaForm.gb_Description.Caption:=ValueItem;
 if ConstantItem = 'GB_RESTRICTIONS' then MainEdukaForm.gb_Restrictions.Caption:=ValueItem;
 if ConstantItem = 'GB_GRIDS' then MainEdukaForm.gb_Grids.Caption:=ValueItem;

 if ConstantItem = '__INFO_I' then MainEdukaForm.__Info_I.Caption:=ValueItem;
 if ConstantItem = '__TESTEDITOR_I' then MainEdukaForm.__TestEditor_I.Caption:=ValueItem;
 if ConstantItem = '__FILTER_I' then MainEdukaForm.__Filter_I.Caption:=ValueItem;
 if ConstantItem = '__AVAILABLE_I' then MainEdukaForm.__Available_I.Caption:=ValueItem;
 if ConstantItem = '__SELECTED_I' then MainEdukaForm.__Selected_I.Caption:=ValueItem;
 if ConstantItem = '__STARTTEST' then MainEdukaForm._c_StartTest.Caption:=ValueItem;

 if ConstantItem = 'CB_NOVICE'   then MainEdukaForm._c_Skill.ItemsEx.ComboItems[0].Caption:=ValueItem;
 if ConstantItem = 'CB_ADVANCED' then MainEdukaForm._c_Skill.ItemsEx.ComboItems[1].Caption:=ValueItem;
 if ConstantItem = 'CB_EXPERT'   then MainEdukaForm._c_Skill.ItemsEx.ComboItems[2].Caption:=ValueItem;

 if ConstantItem = 'CB_NOVICE'   then MainEdukaForm._c_Skill_I.ItemsEx.ComboItems[1].Caption:=ValueItem;
 if ConstantItem = 'CB_ADVANCED' then MainEdukaForm._c_Skill_I.ItemsEx.ComboItems[2].Caption:=ValueItem;
 if ConstantItem = 'CB_EXPERT'   then MainEdukaForm._c_Skill_I.ItemsEx.ComboItems[3].Caption:=ValueItem;

 if ConstantItem = 'CBALL_ALL'   then MainEdukaForm._c_Skill_I.ItemsEx.ComboItems[0].Caption:=ValueItem;
 if ConstantItem = 'CBALL_ALL'   then MainEdukaForm._c_Interpreter_I.ItemsEx.ComboItems[0].Caption:=ValueItem;
 if ConstantItem = 'CBALL_ALL'   then MainEdukaForm._c_Duration_I.ItemsEx.ComboItems[0].Caption:=ValueItem;

 if ConstantItem = 'CB_MINUTES'  then CBMINUTES:=ValueItem;

 if ConstantItem = 'HELP_WHAT_IS_THIS' then
   begin
     WhatIsThis:=ValueItem;
     MainEdukaForm.Help_Q.Caption := ValueItem;
   end;

 if ConstantItem = 'DIALOG_OK' then DLGOK:=ValueItem;
 if ConstantItem = 'DIALOG_HELPEXIT' then HLPEXIT:=ValueItem; 
 if ConstantItem = 'DIALOG_YES' then DLGYES:=ValueItem;
 if ConstantItem = 'DIALOG_NO' then DLGNO:=ValueItem;

 if ConstantItem = 'DIALOG_CANCEL' then DLGCANCEL:=ValueItem;
 if ConstantItem = 'DIALOG_AFILES' then DLG_AFL:=ValueItem;
 if ConstantItem = 'DIALOG_SAVEQ' then DLG_SVQ:=ValueItem;
 if ConstantItem = 'DIALOG_ENTEQ' then DLG_ETQ:=ValueItem;
 if ConstantItem = 'DIALOG_DEFPROC' then DLGPROC:=ValueItem;
 if ConstantItem = 'DIALOG_DEFMEM' then DLGMEM:=ValueItem;

 if ConstantItem = 'DIALOG_FC_ADMIN' then DIALOG_FC_ADMIN:=ValueItem;

 if ConstantItem = 'DIALOG_C_SC' then Dialog_C_SC:=ValueItem;
 if ConstantItem = 'DIALOG_C_SS' then Dialog_C_SS:=ValueItem;
 if ConstantItem = 'DIALOG_C_SM' then Dialog_C_SM:=ValueItem;

 if ConstantItem = 'DIALOG_C_ST' then Dialog_C_ST:=ValueItem;
 if ConstantItem = 'DIALOG_C_SN' then Dialog_C_SN:=ValueItem;
 if ConstantItem = 'DIALOG_C_SI' then Dialog_C_SI:=ValueItem;
 if ConstantItem = 'DIALOG_C_SL' then Dialog_C_SL:=ValueItem;
 if ConstantItem = 'DIALOG_C_CS' then Dialog_C_CS:=ValueItem;
 if ConstantItem = 'DIALOG_C_HP' then Dialog_C_HP:=ValueItem;

  if ConstantItem = 'DIALOG_I_TUX' then DIALOG_I_TUX:=ValueItem;
  if ConstantItem = 'DIALOG_I_ANT' then DIALOG_I_ANT:=ValueItem;
  if ConstantItem = 'DIALOG_I_KNG' then DIALOG_I_KNG:=ValueItem;

  if ConstantItem = 'DIALOG_I_ETT' then DIALOG_I_ETT:=ValueItem;
  if ConstantItem = 'DIALOG_I_ETK' then DIALOG_I_ETK:=ValueItem;
  if ConstantItem = 'DLG_INSTRUCTIONS' then DLGINSTRUCTIONS:=ValueItem;


  if ConstantItem = 'DIALOG_I_TUX' then MainEdukaForm._c_Interpreter_I.ItemsEx.ComboItems[3].Caption:=ValueItem;
  if ConstantItem = 'DIALOG_I_ANT' then MainEdukaForm._c_Interpreter_I.ItemsEx.ComboItems[1].Caption:=ValueItem;
  if ConstantItem = 'DIALOG_I_KNG' then MainEdukaForm._c_Interpreter_I.ItemsEx.ComboItems[2].Caption:=ValueItem;

 if ConstantItem = 'SS_STUDNAME' then   SS_StudName:=ValueItem;
 if ConstantItem = 'SS_EXPORTFILE' then SS_ExportFile:=ValueItem;

 if ConstantItem = 'SPEED_LABEL' then  MainEdukaForm.Static_Speed.Caption := ValueItem;
 if ConstantItem = 'EXERCISEID' then ExerciseID := ValueItem;
 if ConstantItem = 'DIRSELECT' then DIRSELECT := ValueItem;

 if ConstantItem = 'EXERCISEISOK' then ExerciseISOK := ValueItem;
 if ConstantItem = 'EXERCISEWASOK' then ExerciseWASOK := ValueItem;
 if ConstantItem = 'EXERCISENOTOK' then ExerciseNOTOK := ValueItem;

 if ConstantItem = 'SAVE_TITLE' then SAVE_TITLE := ValueItem;
 if ConstantItem = 'OPEN_TITLE' then OPEN_TITLE := ValueItem;

 if ConstantItem = 'TUXFILTER' then TuxFilter := ValueItem;
 if ConstantItem = 'ANTFILTER' then AntFilter := ValueItem;
 if ConstantItem = 'KNGFILTER' then KngFilter := ValueItem;
 if ConstantItem = 'TSKFILTER' then ExerciseFilter := ValueItem;
 if ConstantItem = 'TSTFILTER' then TestFilter := ValueItem;
 if ConstantItem = 'HTMFILTER' then HtmlFilter := ValueItem;
 if ConstantItem = 'PKGFILTER' then PackageFilter := ValueItem;

 if ConstantItem = 'DLGINSTALL' then DLGInstall := ValueItem;
 if ConstantItem = 'DLGUNINSTALL' then DLGUnInstall := ValueItem;
 if ConstantItem = 'DLG_AVPK' then DLG_AVPK := ValueItem;
 if ConstantItem = 'DIALOG_C_SP' then Dialog_C_SP := ValueItem;

 if ConstantItem = 'DIALOG_C_NOTPK'   then DIALOG_C_NOTPK       := ValueItem;
 if ConstantItem = 'DIALOG_PK_ERRMSG' then DIALOG_PK_ERRMSG  := ValueItem;
 if ConstantItem = 'DIALOG_PK_OKMSG'  then DIALOG_PK_OKMSG   := ValueItem;
 if ConstantItem = 'DIALOG_PK_ERRLMSG' then DIALOG_PK_ERRLMSG  := ValueItem;

  TuxFilter := Format( TuxFilter, [extFileTux, extFileTux]);
  AntFilter := Format( AntFilter, [extFileAnt, extFileAnt]);
  KngFilter := Format( KngFilter, [extFileKng, extFileKng]);
  ExerciseFilter := Format( ExerciseFilter, [extFileExercise, extFileExercise]);
  TestFilter := Format( TestFilter, [extFileTest, extFileTest]);
  PackageFilter := Format( PackageFilter, [extFilePackage, extFilePackage]);  
  HtmlFilter := Format( HtmlFilter, [extFileHtml, extFileHtm, extFileHtml, extFileHtm]);

 if ConstantItem = 'HTML_INITIAL'      then HTML_Initial := ValueItem;
 if ConstantItem = 'HTML_FINAL'        then HTML_Final := ValueItem;
 if ConstantItem = 'HTML_PRINTED_BY'   then HTML_Printed_By := ValueItem;
 if ConstantItem = 'HTML_INTERPRETER'  then HTML_Interpreter := ValueItem;
 if ConstantItem = 'HTML_TEST'         then HTML_Test := ValueItem;
 if ConstantItem = 'HTML_RESOLVED_BY'  then HTML_Resolved_By := ValueItem;
 if ConstantItem = 'HTML_UNKNOWN_NAME' then HTML_Unknown_Name := ValueItem;
 if ConstantItem = 'HTML_CHARSET'      then HTML_Charset := ValueItem;
 if ConstantItem = 'SY_START'  then SY_START  := ValueItem;
 if ConstantItem = 'SY_END'    then SY_END  := ValueItem;
 if ConstantItem = 'SY_STEP'   then SY_STEP  := ValueItem;
 if ConstantItem = 'SY_JUMP'   then SY_JUMP  := ValueItem;
 if ConstantItem = 'SY_ROTATE' then SY_ROTATE  := ValueItem;
 if ConstantItem = 'SY_WHILE'  then SY_WHILE  := ValueItem;
 if ConstantItem = 'SY_UNTIL'  then SY_UNTIL  := ValueItem;
 if ConstantItem = 'SY_REPEAT' then SY_REPEAT  := ValueItem;
 if ConstantItem = 'SY_IF'     then SY_IF  := ValueItem;
 if ConstantItem = 'SY_ELSE'   then SY_ELSE  := ValueItem;
 if ConstantItem = 'SY_PROCEDURE' then SY_PROCEDURE  := ValueItem;
 if ConstantItem = 'SY_CALL'      then SY_CALL  := ValueItem;
 if ConstantItem = 'SY_IS_LINE'   then SY_IS_LINE  := ValueItem;
 if ConstantItem = 'SY_IS_BORDER' then SY_IS_BORDER  := ValueItem;
 if ConstantItem = 'SY_THEN'   then SY_THEN  := ValueItem;
 if ConstantItem = 'SY_NOT'    then SY_NOT   := ValueItem;
 if ConstantItem = 'SY_TIMES'  then SY_TIMES := ValueItem;
 if ConstantItem = 'SY_DO'     then SY_DO  := ValueItem;
 if ConstantItem = 'SY_LEFT'   then SY_LEFT  := ValueItem;
 if ConstantItem = 'SY_RIGHT'  then SY_RIGHT  := ValueItem;
 if ConstantItem = 'SY_UP'     then SY_UP  := ValueItem;
 if ConstantItem = 'SY_DOWN'   then SY_DOWN  := ValueItem;
 if ConstantItem = 'SY_PICK'   then   SY_Pick := ValueItem;
 if ConstantItem = 'SY_DROP'   then   SY_Drop := ValueItem;
 if ConstantItem = 'SY_SWAP'   then   SY_Swap := ValueItem;
 if ConstantItem = 'SY_REMEMBER' then SY_Remember := ValueItem;
 if ConstantItem = 'SY_RESTORE'  then SY_Restore := ValueItem;
 if ConstantItem = 'SY_FORGET'   then SY_Forget := ValueItem;
 if ConstantItem = 'SY_COND1'    then SY_Cond1 := ValueItem;
 if ConstantItem = 'SY_COND2'    then SY_Cond2 := ValueItem;
 if ConstantItem = 'SY_COND3'    then SY_Cond3 := ValueItem;
 if ConstantItem = 'SY_COND4_'   then SY_Cond4_ := ValueItem;
 if ConstantItem = 'SY_COND5'    then SY_Cond5 := ValueItem;
 if ConstantItem = 'SY_COND6'    then SY_Cond6 := ValueItem;
 if ConstantItem = 'SY_COND7'    then SY_Cond7 := ValueItem;
 if ConstantItem = 'SY_COND8_'   then SY_Cond8_ := ValueItem;
 if ConstantItem = 'SY_COND9_'   then SY_Cond9_ := ValueItem;
 if ConstantItem = 'SY_COND10_'  then SY_Cond10_ := ValueItem;
 if ConstantItem = 'SY_COND11_'  then SY_Cond11_ := ValueItem;
 if ConstantItem = 'SY_COND12_'  then SY_Cond12_ := ValueItem;
 if ConstantItem = 'SY_COND13_'  then SY_Cond13_ := ValueItem;
 if ConstantItem = 'SY_COND14'   then SY_Cond14 := ValueItem;
 if ConstantItem = 'SY_COND15'   then SY_Cond15 := ValueItem;
 if ConstantItem = 'SY_COND16'  then SY_Cond16 := ValueItem;
 if ConstantItem = 'SY_COND17'   then SY_Cond17 := ValueItem;
 if ConstantItem = 'SY_COND18'   then SY_Cond18 := ValueItem;

 if ConstantItem = 'SY_SGNS'   then
  begin
   SY_SGNS  := AnsiUpperCase(ValueItem);
  end;

 if ConstantItem = 'SY_LTTRS' then
  begin
   SY_LTTRS := AnsiUpperCase(ValueItem);
  end;

 if ConstantItem = 'ERR_0X00' then ERR_0x00  := ValueItem;
 if ConstantItem = 'ERR_0X01' then ERR_0x01  := ValueItem;
 if ConstantItem = 'ERR_0X03' then ERR_0x03  := ValueItem;
 if ConstantItem = 'ERR_0X05' then ERR_0x05  := ValueItem;
 if ConstantItem = 'ERR_0X06' then ERR_0x06  := ValueItem;
 if ConstantItem = 'ERR_0X07' then ERR_0x07  := ValueItem;
 if ConstantItem = 'ERR_0X0A' then ERR_0x0A  := ValueItem;
 if ConstantItem = 'ERR_0X0B' then ERR_0x0B  := ValueItem;
 if ConstantItem = 'ERR_0X0C' then ERR_0x0C  := ValueItem;
 if ConstantItem = 'ERR_0X0D' then ERR_0x0D  := ValueItem; 
 if ConstantItem = 'ERR_0X0E' then ERR_0x0E  := ValueItem;
 if ConstantItem = 'ERR_0X0F' then ERR_0x0F  := ValueItem;
 if ConstantItem = 'ERR_0X10' then ERR_0x10  := ValueItem;
 if ConstantItem = 'ERR_0X11' then ERR_0x11  := ValueItem;
 if ConstantItem = 'ERR_0X12' then ERR_0x12  := ValueItem;
 if ConstantItem = 'ERR_0X14' then ERR_0x14  := ValueItem;
 if ConstantItem = 'ERR_0X15' then ERR_0x15  := ValueItem;
 if ConstantItem = 'ERR_0X16' then ERR_0x16  := ValueItem;
 if ConstantItem = 'ERR_0X17' then ERR_0x17  := ValueItem;
 if ConstantItem = 'ERR_0X18' then ERR_0x18  := ValueItem;

 if ConstantItem = 'ERR_0X19' then ERR_0x19  := ValueItem;
 if ConstantItem = 'ERR_0X1A' then ERR_0x1A  := ValueItem;
 if ConstantItem = 'ERR_0X1B' then ERR_0x1B  := ValueItem;
 if ConstantItem = 'ERR_0X1C' then ERR_0x1C  := ValueItem;
 if ConstantItem = 'ERR_0X1D' then ERR_0x1D  := ValueItem;
 if ConstantItem = 'ERR_0X1E' then ERR_0x1E  := ValueItem;
 if ConstantItem = 'ERR_0X1F' then ERR_0x1E  := ValueItem;

 if ConstantItem = 'ERR_LINE' then ERR_Line  := ValueItem;

 MainEdukaForm.Tool_File_New.Hint   := MainEdukaForm.File_New.Caption;
 MainEdukaForm.Tool_File_Open.Hint  := MainEdukaForm.File_Open.Caption;
 MainEdukaForm.Tool_File_Close.Hint := MainEdukaForm.File_Close.Caption;
 MainEdukaForm.Tool_File_Save.Hint  := MainEdukaForm.File_Save.Caption;


 MainEdukaForm.Tool_Edit_Undo.Hint  := MainEdukaForm.Edit_Undo.Caption;
 MainEdukaForm.Tool_Edit_Cut.Hint   := MainEdukaForm.Edit_Cut.Caption;
 MainEdukaForm.Tool_Edit_Copy.Hint  := MainEdukaForm.Edit_Copy.Caption;
 MainEdukaForm.Tool_Edit_Paste.Hint := MainEdukaForm.Edit_Paste.Caption;

 MainEdukaForm.Tool_Program_Check.Hint := MainEdukaForm.Program_CheckSyntax.Caption;
 MainEdukaForm.Tool_Program_Run.Hint   := MainEdukaForm.Program_Run.Caption;
 MainEdukaForm.Tool_Program_Stop.Hint  := MainEdukaForm.Program_Stop.Caption;
 MainEdukaForm.Tool_Extend_Edit.Hint   := MainEdukaForm.Extend_Edit.Caption;

 MainEdukaForm.Tool_Program_Step.Hint   := MainEdukaForm.Program_Step.Caption;

 MainEdukaForm.Tool_Window_Reset.Hint  := MainEdukaForm.Window_ResetGrid.Caption;
 MainEdukaForm.Tool_Window_Save.Hint   := MainEdukaForm.Window_SaveGrid.Caption;
 MainEdukaForm.Tool_Window_Clear.Hint  := MainEdukaForm.Window_ClearGrid.Caption;


 { ------------------------------------------------ }
 if ConstantItem = 'DLG_LOGIN_FC'  then DLG_LOGIN_FC  := ValueItem;
 if ConstantItem = 'DLG_LOGIN_LC'  then DLG_LOGIN_LC  := ValueItem;
 if ConstantItem = 'DLG_LOGIN_BC'  then DLG_LOGIN_BC  := ValueItem;
 if ConstantItem = 'DLG_LOGIN_FC1'  then DLG_LOGIN_FC1  := ValueItem;
 if ConstantItem = 'DLG_LOGIN_LC1'  then DLG_LOGIN_LC1  := ValueItem;
 if ConstantItem = 'DLG_LOGIN_BC1'  then DLG_LOGIN_BC1  := ValueItem;
 if ConstantItem = 'DLG_LOGIN_FC2'  then DLG_LOGIN_FC2  := ValueItem;
 if ConstantItem = 'DLG_LOGIN_LC2'  then DLG_LOGIN_LC2  := ValueItem;
 if ConstantItem = 'DLG_LOGIN_BC2'  then DLG_LOGIN_BC2  := ValueItem;



 if ConstantItem = 'ADM_MM_EL'   then MainEdukaForm.mEnableDyno.Text     := ValueItem;
 if ConstantItem = 'ADM_MM_ET'   then MainEdukaForm.mEnableTST.Text      := ValueItem;
 if ConstantItem = 'ADM_MM_ED'  then MainEdukaForm.mEnableDebug.Text    := ValueItem;
 if ConstantItem = 'ADM_MM_EA'  then MainEdukaForm.mEnableAdmOpts.Text  := ValueItem;
 
 if ConstantItem = 'ADM_BT_QT'       then MainEdukaForm.btQuitAdm.Caption    := ValueItem;

 if ConstantItem = 'ADM_CB_EL'  then MainEdukaForm.cbEnableDyno.Caption  := ValueItem;
 if ConstantItem = 'ADM_CB_ET'  then MainEdukaForm.cbEnableTst.Caption   := ValueItem;
 if ConstantItem = 'ADM_CB_ED'  then MainEdukaForm.cbEnableDebug.Caption  := ValueItem;
 if ConstantItem = 'ADM_CB_EA'  then MainEdukaForm.cbEnableAdmOpts.Caption  := ValueItem;
 if ConstantItem = 'ADM_BT_SP'  then MainEdukaForm.btSetPass.Caption  := ValueItem;

 if ConstantItem = 'DLG_MSG_NOPASS'     then DLG_MSG_NOPASS  := ValueItem;
 if ConstantItem = 'DLG_MSG_WRONGPASS'  then DLG_MSG_WRONGPASS  := ValueItem;
 if ConstantItem = 'DLG_MSG_NEWPASS'    then DLG_MSG_NEWPASS  := ValueItem;
 if ConstantItem = 'DLG_MSG_MISSPASS'   then DLG_MSG_MISSPASS  := ValueItem;

 if ConstantItem = 'REG_U_TRIAL'      then REG_U_TRIAL  := ValueItem;
 if ConstantItem = 'REG_U_REGD'       then REG_U_REGD  := ValueItem;
 if ConstantItem = 'REG_U_LTXT'       then REG_U_LTXT  := ValueItem;
 if ConstantItem = 'REG_U_LHDID'      then REG_U_LHDID  := ValueItem;

 if ConstantItem = 'REG_U_TXT'        then REG_U_TXT  := ValueItem;
 if ConstantItem = 'REG_U_CAPT'       then REG_U_CAPT  := ValueItem;
 if ConstantItem = 'REG_U_OKRESTART'  then REG_U_OKRESTART  := ValueItem;
 if ConstantItem = 'REG_U_ERRRESTART' then REG_U_ERRRESTART  := ValueItem;
 if ConstantItem = 'REG_U_ITEM'       then REG_U_ITEM  := ValueItem;
 if ConstantItem = 'REG_U_ANNOY'       then REG_U_ANNOY  := ValueItem;

 if ConstantItem = 'REG_U_DDREG'       then REG_U_DDREG  := ValueItem;
 if ConstantItem = 'REG_U_DDCONT'      then REG_U_DDCONT  := ValueItem;

 if ConstantItem = 'REG_U_NOKEY'       then REG_U_NOKEY  := ValueItem;
 if ConstantItem = 'REG_U_KEYINFO'      then REG_U_KEYINFO  := ValueItem;

 if ConstantItem = 'REG_U_INFO_KEY'      then REG_U_INFO_KEY  := ValueItem;

end;

procedure lngLoadLanguageFile(FileName:string);
var
 TFile     : TextFile;
 LineStr   : string;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : lngLoadLanguageFile(FileName:'+FileName+')');
  DbgPlus;
{$ENDIF}

   Assign(TFile, FileName);
{$I-}
   Reset(TFile);
{$I+}
   if IOResult<>0 then
    begin
    {$IFDEF _DEBUG_}
     DbgPrint(DbgUName+' : lngLoadLanguageFile | Error : File not Found !');
     DbgMinus;
    {$ENDIF}
      Exit;
    end;

   while not Eof(TFile) do
    begin
      Readln(TFile, LineStr);
      if LineStr<>'' then
         lngTranslateItem(lngExtractItem(LineStr),lngExtractItemValue(LineStr));
    end;
    
   CloseFile(TFile);

 CurrentLanguageFileName := FileName;

{$IFDEF _DEBUG_}
 DbgMinus;
{$ENDIF}
end;

Procedure lngLoadSelectedLanguage(LngFile : String; MainEdukaForm : TMainEdukaForm);
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : lngLoadSelectedLanguage(LngFile:'+LngFile+'; MainEdukaForm:'+DbgAddr(Addr(MainEdukaForm))+')');
  DbgPlus;
{$ENDIF}


  if LngFile='' then lngSetupDefaultLanguage(MainEdukaForm)
    else lngLoadLanguageFile(LngFile);

 LoadIdentifierTable(SY_LTTRS+AnsiLowerCase(SY_LTTRS), true);
 LoadIdentifierTable(SY_SGNS, False);

{$IFDEF _DEBUG_}
  DbgMinus;
{$ENDIF}
end;

function lngGetLanguageFileNameID(FName : String) : String;
var
 TFile     : TextFile;
 LineStr   : string;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : lngLanguageFileNameID(FName:'+FName+')');
  DbgPlus;
{$ENDIF}

   Result:='';

   Assign(TFile, FName);
{$I-}
   Reset(TFile);
{$I+}
   if IOResult<>0 then
    begin
    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : lngLanguageFileNameID | Error : File not found.');
    {$ENDIF}
      exit;
    end;

   while not Eof(TFile) do
    begin
      Readln(TFile, LineStr);
      if AnsiUpperCase(lngExtractItem(LineStr))='NAME' then
       begin
         Result := lngExtractItemValue(LineStr);
        {$IFDEF _DEBUG_}
          DbgMinus;
          DbgPrint(DbgUName+' : lngLanguageFileNameID = '+Result);
        {$ENDIF}
        Exit;
       end;
    end;
   CloseFile(TFile);

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : lngLanguageFileNameID = '+Result);
{$ENDIF}
end;

function lngGetLanguageFileNameCode(FName : String) : String;
var
 TFile     : TextFile;
 LineStr   : string;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : lngGetLanguageFileNameCode(FName:'+FName+')');
  DbgPlus;
{$ENDIF}

   Result:='';

   Assign(TFile, FName);
{$I-}
   Reset(TFile);
{$I+}
   if IOResult<>0 then
    begin
    {$IFDEF _DEBUG_}
      DbgMinus;
      DbgPrint(DbgUName+' : lngGetLanguageFileNameCode | Error : File not found.');
    {$ENDIF}
      exit;
    end;

   while not Eof(TFile) do
    begin
      Readln(TFile, LineStr);
      if AnsiUpperCase(lngExtractItem(LineStr))='CODE' then
       begin
         Result := AnsiUpperCase(lngExtractItemValue(LineStr));
        {$IFDEF _DEBUG_}
          DbgMinus;
          DbgPrint(DbgUName+' : lngGetLanguageFileNameCode = '+Result);
        {$ENDIF}
        Exit;
       end;
    end;
   CloseFile(TFile);

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : lngGetLanguageFileNameCode = '+Result);
{$ENDIF}
end;



(*
 * lngSpeX
 *)

function lngSpeX(St, From : String) : Integer;
var
 i : Integer;
 ax : String;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : SpeX ( St:'+DbgStr(St)+'; From:'+DbgStr(From)+')');
   DbgPlus;
 {$ENDIF}

 for i:=1 to nCondTokens do
 begin
 ax := AnsiUpperCase(ExtractKw(From, i));
 if ax = St then
  begin
   Result := i;

  {$IFDEF _DEBUG2_}
    DbgMinus;
    DbgPrint(DbgUName+' : SpeX = '+ DbgInt(Result));
  {$ENDIF}

   Exit;
  end;
 end;
 Result := 0;

{$IFDEF _DEBUG2_}
  DbgMinus;
  DbgPrint(DbgUName+' : SpeX = '+ DbgInt(Result));
{$ENDIF}
end;


(*
 * lngSpeX2
 *)

function lngSpeX2(St, From : String) : String;
var
 i : Integer;
 ax : String;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : lngSpeX2 ( St:'+DbgStr(St)+'; From:'+DbgStr(From)+')');
   DbgPlus;
 {$ENDIF}

 for i:=1 to nCondTokens do
 begin
 ax := AnsiUpperCase(ExtractKw(From, i));
 if ax = St then
  begin
   Result := ExtractKw(From, i);

  {$IFDEF _DEBUG2_}
    DbgMinus;
    DbgPrint(DbgUName+' : lngSpeX2 = '+ DbgStr(Result));
  {$ENDIF}

   Exit;
  end;
 end;
 Result := '';

{$IFDEF _DEBUG2_}
  DbgMinus;
  DbgPrint(DbgUName+' : lngSpeX2 = '+ DbgStr(Result));
{$ENDIF}
end;



(*
 * lngTrulySpeX
 *)

function lngTrulySpeX(St : String) : Integer;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TrulySpeX ( St:'+DbgStr(St)+')');
   DbgPlus;
 {$ENDIF}
 
  Result := 0;
  if St = '' then Exit;

                     Result := lngSpeX(St, SY_COND1);
  if Result = 0 then Result := lngSpeX(St, SY_COND2);
  if Result = 0 then Result := lngSpeX(St, SY_COND3);
  if Result = 0 then Result := lngSpeX(St, SY_COND4_);
  if Result = 0 then Result := lngSpeX(St, SY_COND5);
  if Result = 0 then Result := lngSpeX(St, SY_COND6);
  if Result = 0 then Result := lngSpeX(St, SY_COND7);
  if Result = 0 then Result := lngSpeX(St, SY_COND8_);
  if Result = 0 then Result := lngSpeX(St, SY_COND9_);
  if Result = 0 then Result := lngSpeX(St, SY_COND10_);
  if Result = 0 then Result := lngSpeX(St, SY_COND11_);
  if Result = 0 then Result := lngSpeX(St, SY_COND12_);
  if Result = 0 then Result := lngSpeX(St, SY_COND13_);
  if Result = 0 then Result := lngSpeX(St, SY_COND14);
  if Result = 0 then Result := lngSpeX(St, SY_COND15);
  if Result = 0 then Result := lngSpeX(St, SY_COND16);
  if Result = 0 then Result := lngSpeX(St, SY_COND17);
  if Result = 0 then Result := lngSpeX(St, SY_COND18);
{$IFDEF _DEBUG2_}
  DbgMinus;
  DbgPrint(DbgUName+' : TrulySpeX = '+ DbgInt(Result));
{$ENDIF}
end;

(*
 * lngTrulySpeX2
 *)

function lngTrulySpeX2(St : String; CondId : Integer) : Integer;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : TrulySpeX ( St:'+DbgStr(St)+'; CondId:'+DbgInt(CondId)+')');
   DbgPlus;
 {$ENDIF}

   case CondId of
   1   : Result := lngSpeX(St, SY_Cond1);
   2   : Result := lngSpeX(St, SY_Cond2);
   3   : Result := lngSpeX(St, SY_Cond3);
   4   : Result := lngSpeX(St, SY_Cond4_);
   5   : Result := lngSpeX(St, SY_Cond5);
   6   : Result := lngSpeX(St, SY_Cond6);
   7   : Result := lngSpeX(St, SY_Cond7);
   8   : Result := lngSpeX(St, SY_Cond8_);
   9   : Result := lngSpeX(St, SY_Cond9_);
   10  : Result := lngSpeX(St, SY_Cond10_);
   11  : Result := lngSpeX(St, SY_Cond11_);
   12  : Result := lngSpeX(St, SY_Cond12_);
   13  : Result := lngSpeX(St, SY_Cond13_);
   14  : Result := lngSpeX(St, SY_Cond14);
   15  : Result := lngSpeX(St, SY_Cond15);
   16  : Result := lngSpeX(St, SY_Cond16);
   17  : Result := lngSpeX(St, SY_Cond17);
   18  : Result := lngSpeX(St, SY_Cond18);
   else Result := 0;
 end;

{$IFDEF _DEBUG2_}
  DbgMinus;
  DbgPrint(DbgUName+' : TrulySpeX = '+DbgInt(Result));
{$ENDIF}
end;


(*
 * lngListSpeX
 *)
function lngListSpeX ( Def : String ) : Integer;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : lngListSpeX ( Def:'+DbgStr(Def)+')');
   DbgPlus;
 {$ENDIF}
  if Def = ' '+AnsiUpperCase(SY_Cond1) then Result := 1 else
  if Def = ' '+AnsiUpperCase(SY_Cond2) then Result := 2 else
  if Def = ' '+AnsiUpperCase(SY_Cond3) then Result := 3 else
  if Def = ' '+AnsiUpperCase(SY_Cond4_) then Result := 4 else
  if Def = ' '+AnsiUpperCase(SY_Cond5) then Result := 5 else
  if Def = ' '+AnsiUpperCase(SY_Cond6) then Result := 6 else
  if Def = ' '+AnsiUpperCase(SY_Cond7) then Result := 7 else
  if Def = ' '+AnsiUpperCase(SY_Cond8_) then Result := 8 else
  if Def = ' '+AnsiUpperCase(SY_Cond9_) then Result := 9 else
  if Def = ' '+AnsiUpperCase(SY_Cond10_) then Result := 10 else
  if Def = ' '+AnsiUpperCase(SY_Cond11_) then Result := 11 else
  if Def = ' '+AnsiUpperCase(SY_Cond12_) then Result := 12 else
  if Def = ' '+AnsiUpperCase(SY_Cond13_) then Result := 13 else
  if Def = ' '+AnsiUpperCase(SY_Cond14) then Result := 14 else
  if Def = ' '+AnsiUpperCase(SY_Cond15) then Result := 15 else
  if Def = ' '+AnsiUpperCase(SY_Cond16) then Result := 16 else
  if Def = ' '+AnsiUpperCase(SY_Cond17) then Result := 17 else
  if Def = ' '+AnsiUpperCase(SY_Cond18) then Result := 18 else Result := 0;
  Result := _TuxCondition_ + Result;

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : lngListSpeX = '+ DbgInt(Result));
 {$ENDIF}
end;


(*
 * lngExtractSpeX
 *)

function lngExtractSpeX ( iId, iNm : Integer) : String;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : lngExtractSpeX ( iId:'+DbgInt(iId)+'; iNm:'+DbgInt(iNm)+')');
   DbgPlus;
 {$ENDIF}
  Result := '';
  
  case iId of
   1  : Result := ExtractKw(SY_Cond1, iNm);
   2  : Result := ExtractKw(SY_Cond2, iNm);
   3  : Result := ExtractKw(SY_Cond3, iNm);
   4  : Result := ExtractKw(SY_Cond4_, iNm);
   5  : Result := ExtractKw(SY_Cond5, iNm);
   6  : Result := ExtractKw(SY_Cond6, iNm);
   7  : Result := ExtractKw(SY_Cond7, iNm);
   8  : Result := ExtractKw(SY_Cond8_, iNm);
   9  : Result := ExtractKw(SY_Cond9_, iNm);
   10 : Result := ExtractKw(SY_Cond10_, iNm);
   11 : Result := ExtractKw(SY_Cond11_, iNm);
   12 : Result := ExtractKw(SY_Cond12_, iNm);
   13 : Result := ExtractKw(SY_Cond13_, iNm);
   14 : Result := ExtractKw(SY_Cond14, iNm);
   15 : Result := ExtractKw(SY_Cond15, iNm);
   16 : Result := ExtractKw(SY_Cond16, iNm);
   17 : Result := ExtractKw(SY_Cond17, iNm);
   18 : Result := ExtractKw(SY_Cond18, iNm);
 end;

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : lngExtractSpeX = '+ DbgStr(Result));
 {$ENDIF}
end;


end.
