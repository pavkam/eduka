(*

The Original Code is: Main.pas, released 2005-02-02.
Authors of this file are Popov John and Ciobanu Alexander. All Rights Reserved.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit Main;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, ComCtrls, Buttons, ImgList,
  Clipbrd, CheckLst, ProTypes, Version, Utils, Printers, ShlObj, ActiveX,
  SynCompletionProposal, SynEditPrint, SynEdit, SynEditHighlighter, SynHighlighterGeneral, SynProSyn,
  PrnExpt, SynEditExport, SynExportRTF, DateUtils,
  SynExportHTML, ToolWin, jpeg, SynEdukaExportHTML, SynEditTextBuffer, SynEditTypes, JvMenus,
  JvXPCore, JvXPCheckCtrls, JvImageList, JvDotNetControls, JvExControls,
  JvComponent, JvStaticText, JvExExtCtrls, JvImage, SerialUtils;
type

  TMainEdukaForm = class(TForm)
    MainMenu: TJvMainMenu;
    _File: TMenuItem;
    _Edit: TMenuItem;
    _Commands: TMenuItem;
    _Program: TMenuItem;
    File_New: TMenuItem;
    File_Open: TMenuItem;
    File_Close: TMenuItem;
    File_Save: TMenuItem;
    File_SaveAs: TMenuItem;
    File_Print: TMenuItem;
    File_Exit: TMenuItem;
    Edit_Undo: TMenuItem;
    Edit_Cut: TMenuItem;
    Edit_Copy: TMenuItem;
    Edit_Paste: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Main_ToolBar: TToolBar;
    Tool_File_New: TToolButton;
    Tool_File_Open: TToolButton;
    Tool_File_Save: TToolButton;
    ToolButton4: TToolButton;
    Tool_Edit_Undo: TToolButton;
    StatusBar: TStatusBar;
    Tool_Edit_Cut: TToolButton;
    Tool_Edit_Copy: TToolButton;
    Tool_Edit_Paste: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    Tool_Program_Check: TToolButton;
    Tool_Program_Run: TToolButton;
    Tool_Program_Stop: TToolButton;
    Edit_SelectAll: TMenuItem;
    N1: TMenuItem;
    Edit_Clear: TMenuItem;
    Program_CheckSyntax: TMenuItem;
    Program_Run: TMenuItem;
    Program_Stop: TMenuItem;
    _Options: TMenuItem;
    Options_SelectLanguage: TMenuItem;
    Options_SelectInterpreter: TMenuItem;
    Kng_Basic: TMenuItem;
    Kng_Advanced: TMenuItem;
    Kng_Step: TMenuItem;
    Kng_Jump: TMenuItem;
    Kng_Rotate: TMenuItem;
    Kng_While: TMenuItem;
    Kng_Repeat: TMenuItem;
    Kng_Procedure: TMenuItem;
    Kng_Call: TMenuItem;
    Kng_If: TMenuItem;
    Kng_Is_Line: TMenuItem;
    Kng_Is_Border: TMenuItem;
    N5: TMenuItem;
    _Help: TMenuItem;
    _Window: TMenuItem;
    Window_ResetGrid: TMenuItem;
    Help_Topics: TMenuItem;
    Help_About: TMenuItem;
    tux_Basic: TMenuItem;
    tux_Advanced: TMenuItem;
    ac_Panel_ant: TPanel;
    ac_ant_Start: TJvStaticText;
    ac_ant_End: TJvStaticText;
    ac_ant_Right: TJvStaticText;
    ac_ant_Left: TJvStaticText;
    ac_ant_Up: TJvStaticText;
    ac_ant_Down: TJvStaticText;
    ac_ant_Repeat: TJvStaticText;
    ac_ant_Procedure: TJvStaticText;
    ac_ant_While: TJvStaticText;
    ac_ant_If: TJvStaticText;
    ac_ant_Else: TJvStaticText;
    ac_ant_Is_Border: TJvStaticText;
    ac_ant_Is_Not_Border: TJvStaticText;
    ant_Basic: TMenuItem;
    ant_Up: TMenuItem;
    ant_Left: TMenuItem;
    ant_Right: TMenuItem;
    ant_Advanced: TMenuItem;
    ant_Is_Not_Border: TMenuItem;
    ant_Is_Border: TMenuItem;
    ant_If: TMenuItem;
    N10: TMenuItem;
    ant_Procedure: TMenuItem;
    ant_Repeat: TMenuItem;
    ant_While: TMenuItem;
    ant_Down: TMenuItem;
    ac_Panel_Kng: TPanel;
    ac_Kng_Start: TJvStaticText;
    ac_Kng_End: TJvStaticText;
    ac_Kng_Step: TJvStaticText;
    ac_Kng_Jump: TJvStaticText;
    ac_Kng_Rotate: TJvStaticText;
    ac_Kng_While: TJvStaticText;
    ac_Kng_Repeat: TJvStaticText;
    ac_Kng_Procedure: TJvStaticText;
    ac_Kng_Call: TJvStaticText;
    ac_Kng_If: TJvStaticText;
    ac_Kng_Else: TJvStaticText;
    ac_Kng_Is_Line: TJvStaticText;
    ac_Kng_Is_Border: TJvStaticText;
    N4: TMenuItem;
    N11: TMenuItem;
    SaveTimer: TTimer;
    ac_Move_ant_Right: TJvStaticText;
    ac_Move_ant_Left: TJvStaticText;
    ac_Move_ant_Up: TJvStaticText;
    ac_Move_ant_Down: TJvStaticText;
    ac_Move_ant_Rotate: TJvStaticText;
    ac_Move_Kng_Rotate: TJvStaticText;
    ac_Move_Kng_Jump: TJvStaticText;
    ac_Move_Kng_Step: TJvStaticText;
    Kng_Is_Not_Line: TMenuItem;
    Kng_Is_Not_Border: TMenuItem;
    ac_Kng_Is_Not_Line: TJvStaticText;
    ac_Kng_Is_Not_Border: TJvStaticText;
    ToolButton1: TToolButton;
    Tool_Window_Reset: TToolButton;
    Panel_Bottom: TPanel;
    set_Grid_45: TJvStaticText;
    set_Grid_36: TJvStaticText;
    set_Grid_24: TJvStaticText;
    set_Grid_20: TJvStaticText;
    DbgScreen: TMenuItem;
    ErrorEdit: TRichEdit;
    Edit_char: TJvDotNetEdit;
    ContextMenu: TJvPopupMenu;
    Popup_Undo: TMenuItem;
    N12: TMenuItem;
    Popup_Cut: TMenuItem;
    Popup_Copy: TMenuItem;
    Popup_Paste: TMenuItem;
    N13: TMenuItem;
    Popup_SelectAll: TMenuItem;
    Popup_Clear: TMenuItem;
    Track_Speed: TTrackBar;
    Static_Speed_Value: TJvStaticText;
    Static_Speed: TJvStaticText;
    set_Grid_15: TJvStaticText;
    Context_Help: TJvPopupMenu;
    Help_Q: TMenuItem;
    PrintDialog: TPrintDialog;
    Extend_Edit: TMenuItem;
    N14: TMenuItem;
    ToolButton3: TToolButton;
    Tool_Extend_Edit: TToolButton;
    ac_Kng_Until: TJvStaticText;
    ac_Ant_Until: TJvStaticText;
    Kng_Until: TMenuItem;
    ant_Until: TMenuItem;
    N15: TMenuItem;
    File_R1: TMenuItem;
    File_R2: TMenuItem;
    File_R3: TMenuItem;
    File_R4: TMenuItem;
    ToolBar1: TToolBar;
    Tool_File_Close: TToolButton;
    PaintBox: TPaintBox;
    Kng_im_Up: TImage;
    Kng_im_Right: TImage;
    ant_im_Up: TImage;
    Kng_im_Left: TImage;
    Kng_im_Down: TImage;
    ant_im_Left: TImage;
    ant_im_Right: TImage;
    ant_im_Down: TImage;
    Bevel: TBevel;
    ac_Ant_Call: TJvStaticText;
    ant_Call: TMenuItem;
    Kng_Condition: TMenuItem;
    ant_Condition: TMenuItem;
    N6: TMenuItem;
    N9: TMenuItem;
    MouseTimer: TTimer;
    N7: TMenuItem;
    N8: TMenuItem;
    DskShortcuts: TMenuItem;
    Editor: TSynEdit;
    SynEditPrint: TSynEditPrint;
    ProProp: TSynCompletionProposal;
    ac_Panel_Tux: TPanel;
    ac_Move_Tux_Step: TJvStaticText;
    ac_Move_Tux_Rotate: TJvStaticText;
    ac_Tux_Start: TJvStaticText;
    ac_Tux_End: TJvStaticText;
    ac_Tux_Step: TJvStaticText;
    ac_Tux_Rotate: TJvStaticText;
    ac_Tux_Until: TJvStaticText;
    ac_Tux_While: TJvStaticText;
    ac_Tux_If: TJvStaticText;
    ac_Tux_Else: TJvStaticText;
    ac_Tux_Procedure: TJvStaticText;
    ac_Tux_Call: TJvStaticText;
    ac_Tux_Remember: TJvStaticText;
    ac_Tux_Forget: TJvStaticText;
    ac_Tux_GoBack: TJvStaticText;
    ac_Tux_Pick: TJvStaticText;
    ac_Tux_Drop: TJvStaticText;
    ac_Tux_Swap: TJvStaticText;
    tux_Step: TMenuItem;
    tux_Rotate: TMenuItem;
    N16: TMenuItem;
    tux_Call: TMenuItem;
    tux_Remember: TMenuItem;
    tux_Forget: TMenuItem;
    tux_GoBack: TMenuItem;
    N17: TMenuItem;
    tux_PickLetter: TMenuItem;
    tux_DropLetter: TMenuItem;
    tux_SwapLetters: TMenuItem;
    tux_While: TMenuItem;
    tux_Until: TMenuItem;
    N18: TMenuItem;
    tux_If: TMenuItem;
    N19: TMenuItem;
    tux_Procedure: TMenuItem;
    tux_im_Up: TImage;
    tux_im_Left: TImage;
    tux_im_Down: TImage;
    tux_im_Right: TImage;
    Pocket_Text: TLabel;
    Pocket_Letter: TJvStaticText;
    Msg_Label: TJvStaticText;
    ImageList: TJvImageList;
    _Utils: TMenuItem;
    _EditExercise: TMenuItem;
    _EditTest: TMenuItem;
    N20: TMenuItem;
    Panel_Editor: TPanel;
    Panel_Test: TPanel;
    __Info_I: TGroupBox;
    Splitter1: TSplitter;
    _d_Description: TMemo;
    _d_Restrictions: TMemo;
    Panel3: TPanel;
    __i0: TImage;
    __i4: TImage;
    __i5: TImage;
    __i3: TImage;
    __i2: TImage;
    __i1: TImage;
    _d_Language: TComboBoxEx;
    _d_Title: TJvDotNetEdit;
    _d_Interpreter: TJvDotNetEdit;
    _d_Duration: TJvDotNetEdit;
    _d_Skill: TJvDotNetEdit;
    _d_Author: TJvDotNetEdit;
    __i6: TImage;
    __i7: TImage;
    __i8: TImage;
    __Filter_I: TLabel;
    _c_Duration_I: TComboBoxEx;
    _c_Skill_I: TComboBoxEx;
    _c_Interpreter_I: TComboBoxEx;
    Panel4: TPanel;
    Panel5: TPanel;
    _c_AvailableFiles: TListBox;
    Panel6: TPanel;
    __Available_I: TLabel;
    Panel7: TPanel;
    Panel8: TPanel;
    __Selected_I: TLabel;
    Exercise_itemUpOver: TImage;
    Exercise_itemDownOver: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    gb_Language: TGroupBox;
    gb_DurationSkill: TGroupBox;
    _c_Duration: TComboBoxEx;
    _c_Skill: TComboBoxEx;
    gb_Grids: TGroupBox;
    _c_Grid_2: TRadioButton;
    _c_Grid_1: TRadioButton;
    Panel10: TPanel;
    gb_Description: TGroupBox;
    _c_Description: TMemo;
    gb_Restrictions: TGroupBox;
    _c_Restrictions: TMemo;
    Splitter2: TSplitter;
    __i10: TImage;
    __i11: TImage;
    Tool_Separator_Copy_Grid: TToolButton;
    Tool_Exercise_Cond2: TToolButton;
    gb_Title: TGroupBox;
    _c_Language: TComboBoxEx;
    _c_Title: TJvDotNetEdit;
    gb_Author: TGroupBox;
    _c_Author: TJvDotNetEdit;
    File_ExportHTML: TMenuItem;
    Tool_Exercise_Cond1: TToolButton;
    Tool_Exercise_Show: TToolButton;
    Tool_Exercise_Next: TToolButton;
    Tool_Exercise_Prev: TToolButton;
    Exercise_itemUpNormal: TImage;
    Exercise_itemDownNormal: TImage;
    Exercise_itemFolderNormal: TImage;
    Exercise_itemFolderOver: TImage;
    Tool_Sep1: TToolButton;
    ExportSaveDialog: TSaveDialog;
    __i9: TImage;
    _d_Grid_Size: TJvDotNetEdit;
    Splitter3: TSplitter;
    Panel11: TPanel;
    Panel9: TPanel;
    Exercise_itemAddNormal: TImage;
    Exercise_itemRemoveNormal: TImage;
    Exercise_itemRemoveOver: TImage;
    Exercise_itemAddOver: TImage;
    _c_SelectedFiles: TListBox;
    Error_Panel: TPanel;
    Error_Panel_Image: TImage;
    Exercise_Exercise: TRichEdit;
    Edit_ShowLines: TMenuItem;
    Tool_Sep0: TToolButton;
    N21: TMenuItem;
    Options_Highlight: TMenuItem;
    MemoryTimer: TTimer;
    Window_SaveGrid: TMenuItem;
    Window_ClearGrid: TMenuItem;
    Tool_Window_Save: TToolButton;
    Tool_Window_Clear: TToolButton;
    Tool_Program_Step: TToolButton;
    Program_Step: TMenuItem;
    Image_Steps: TJvImageList;
    Program_Stop_Point: TMenuItem;
    N22: TMenuItem;
    _PackageManager: TMenuItem;
    AdminPanel: TPanel;
    cbEnableDyno: TJvXPCheckbox;
    cbEnableTST: TJvXPCheckbox;
    cbEnableDebug: TJvXPCheckbox;
    cbEnableAdmOpts: TJvXPCheckbox;
    Kng_Start: TMenuItem;
    Kng_End: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    ant_Start: TMenuItem;
    ant_End: TMenuItem;
    N25: TMenuItem;
    tux_Start: TMenuItem;
    tux_End: TMenuItem;
    mEnableDyno: TMemo;
    mEnableTST: TMemo;
    mEnableDebug: TMemo;
    mEnableAdmOpts: TMemo;
    btSetPass: TJvStaticText;
    btQuitAdm: TJvStaticText;
    _c_StartTest: TJvStaticText;
    Options_Sound: TMenuItem;
    __TestEditor_I: TGroupBox;
    procedure File_ExitClick(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure File_OpenClick(Sender: TObject);
    procedure File_SaveClick(Sender: TObject);
    procedure File_SaveAsClick(Sender: TObject);
    procedure File_NewClick(Sender: TObject);
    procedure File_CloseClick(Sender: TObject);
    procedure Options_SelectInterpreterClick(Sender: TObject);
    procedure CheckFileSave;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Options_SelectLanguageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure button_MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
    procedure button_MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure button_MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DefaultPanelButtons(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Help_AboutClick(Sender: TObject);
    procedure Edit_CutClick(Sender: TObject);
    procedure Edit_CopyClick(Sender: TObject);
    procedure Edit_PasteClick(Sender: TObject);
    procedure Edit_SelectAllClick(Sender: TObject);
    procedure Edit_ClearClick(Sender: TObject);
    procedure Editor1SelectionChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure set_Grid_20Click(Sender: TObject);
    procedure set_Grid_24Click(Sender: TObject);
    procedure set_Grid_36Click(Sender: TObject);
    procedure set_Grid_45Click(Sender: TObject);

    procedure FormDestroy(Sender: TObject);
    procedure Window_ResetGridClick(Sender: TObject);
    procedure DbgScreenClick(Sender: TObject);
    procedure ac_Move_ant_UpClick(Sender: TObject);
    procedure ac_Move_ant_RightClick(Sender: TObject);
    procedure ac_Move_ant_DownClick(Sender: TObject);
    procedure ac_Move_ant_LeftClick(Sender: TObject);
    procedure ac_Move_ant_RotateClick(Sender: TObject);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    { Local DEED}
     procedure ifaceSetupPanelButtons(NoSet : TJvStaticText);

     procedure ifaceActivateControls(tHow : Boolean);
     procedure ifaceActivateFileControls(tHow : Boolean);
     procedure ifaceActivateEditControls(tHow : Boolean);

     procedure ifaceErrorAdjust(tHow : Boolean);
     procedure ifaceGridSizes(ActiveBtn : TJvStaticText);
     procedure ifaceExerciseEditorControls(tHow : Boolean);
     procedure ifaceActivateExerciseMemoEditControls(tHow : Boolean; iEditor : TCustomEdit);
     procedure ifaceExerciseCondAdjust(tHow : Boolean);
     procedure ifaceDisableGridByMove();
     procedure ifaceAdjustTestListControls();
     procedure ifaceSetupExternalImages();
     procedure ifaceLoadDirectoryFiles(sDirName : String);
     procedure ifaceBookMark(Line : Integer);
     procedure ifaceExerciseControls(tHow : Boolean);
     procedure ifaceTestControls(tHow : Boolean);
     procedure ifaceTestEditorControls(tHow, tWhy : Boolean);
     procedure ifaceLaunchedTestControls(tHow, tWhy : Boolean);

     procedure ifaceMoveExerciseToEditor(PrevExercise : Integer);
     procedure ifaceSetFormCaption(Name,FName : String);
     procedure ifaceSetFormIcon(ID : TProInterpreter);

     procedure SendToCharEdit(ch : Char);
     procedure SetupXSyntax;

    {Recent files}
     procedure LoadRecentFiles(CI : TProInterpreter);
     procedure SaveRecentFiles(CI : TProInterpreter);
     procedure AddRecentFile(FName : String);

    {Messages}
     procedure SelectConditionClose(var Msg: TWMChar) ; message  WM_SelectConditionClose;
     procedure SelectTimesClose(var Msg: TWMChar) ; message  WM_SelectTimesClose;
     procedure SelectNameClose(var Msg: TWMChar) ; message  WM_SelectNameClose;
     procedure SelectInterpreterClose(var Msg: TWMChar) ; message  WM_SelectInterpreterClose;
     procedure SelectLanguageClose(var Msg: TWMChar) ; message WM_SelectLanguageClose;
     procedure SelectStudentClose(var Msg: TWMChar) ; message WM_SelectStudentClose;
     procedure ExecutionThreadDied(var Msg: TWMChar) ; message WM_EnableAllControls;
     procedure GridSizeChange(var Msg: TWMChar) ; message WM_SetGridSize;
     procedure OpenMyDDEFiles(var Msg: TMessage) ; message WM_GetThoseFiles;
     procedure CalculateAInstruction(var Msg: TMessage) ; message WM_InstructionCalculate;
     procedure ShowErrorWindow(var Msg: TMessage) ; message WM_ShowError;

    procedure PopUpConditionDialog(Sender: TObject);
    procedure PopupTimesDialog(Sender: TObject);
    procedure PopUpNameDialog(Sender: TObject);
    procedure ac_Move_Kng_RotateClick(Sender: TObject);
    procedure SimpleButtonClick(Sender: TObject);
    procedure Program_StopClick(Sender: TObject);
    procedure Program_RunClick(Sender: TObject);
    procedure Program_CheckSyntaxClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Edit_UndoClick(Sender: TObject);
    procedure ErrorEditEnter(Sender: TObject);
    procedure Editor1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ErrorEditMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit_charKeyPress(Sender: TObject; var Key: Char);
    procedure Editor1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Track_SpeedChange(Sender: TObject);
    procedure set_Grid_15Click(Sender: TObject);
    procedure ControlHelpPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Help_QClick(Sender: TObject);
    procedure SaveTimerTimer(Sender: TObject);
    procedure Track_SpeedEnter(Sender: TObject);
    procedure Help_TopicsClick(Sender: TObject);
    procedure File_PrintClick(Sender: TObject);
    procedure Extend_EditClick(Sender: TObject);
    procedure File_RClick(Sender: TObject);
    procedure MouseTimerTimer(Sender: TObject);
    procedure ac_Move_Kng_StepClick(Sender: TObject);
    procedure ac_Move_Kng_JumpClick(Sender: TObject);
    procedure DskShortcutsClick(Sender: TObject);
    procedure EditorChange(Sender: TObject);
    procedure EditorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditorStatusChange(Sender: TObject;
      Changes: TSynStatusChanges);
    procedure EditChange(Sender: TObject);
    procedure ProPropExecute(Kind: SynCompletionType; Sender: TObject;
      var AString: String; var x, y: Integer; var CanExecute: Boolean);
    procedure ac_Move_Tux_StepClick(Sender: TObject);
    procedure ac_Move_Tux_RotateClick(Sender: TObject);
    procedure PopUpMemoryDialog(Sender: TObject);
    procedure EditorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure _EditExerciseClick(Sender: TObject);
    procedure _c_LanguageChange(Sender: TObject);
    procedure _c_Grid_1Click(Sender: TObject);
    procedure _c_Grid_2Click(Sender: TObject);
    procedure _c_DescriptionChange(Sender: TObject);
    procedure _c_RestrictionsChange(Sender: TObject);
    procedure _c_ExerciseEditChange(Sender: TObject);
    procedure _c_SkillChange(Sender: TObject);
    procedure _c_DurationChange(Sender: TObject);
    procedure _EditTestClick(Sender: TObject);
    procedure Exercise_itemRemoveNormalMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure AllMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Exercise_itemFolderNormalMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure Exercise_itemAddNormalMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure Exercise_itemUpNormalMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure Exercise_itemDownNormalMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure Tool_Copy_GridClick(Sender: TObject);
    procedure File_ExportHTMLClick(Sender: TObject);
    procedure Exercise_itemFolderOverClick(Sender: TObject);
    procedure _c_AvailableFilesClick(Sender: TObject);
    procedure _d_LanguageChange(Sender: TObject);
    procedure _c_AvailableFilesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure _c_Sorters_Change(Sender: TObject);
    procedure _c_ExerciseEditMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure _c_ExerciseEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure _c_ExerciseEditMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure _c_ExerciseEditContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure _c_ExerciseEditEnter(Sender: TObject);
    procedure _c_ExerciseEditExit(Sender: TObject);
    procedure Exercise_itemAddOverClick(Sender: TObject);
    procedure Exercise_itemRemoveOverClick(Sender: TObject);
    procedure _c_SelectedFilesClick(Sender: TObject);
    procedure _c_SelectedFilesKeyPress(Sender: TObject; var Key: Char);
    procedure Exercise_itemUpOverClick(Sender: TObject);
    procedure Exercise_itemDownOverClick(Sender: TObject);
    procedure Error_Panel_ImageClick(Sender: TObject);
    procedure _c_StartTestClick(Sender: TObject);
    procedure Exercise_ExerciseEnter(Sender: TObject);
    procedure Tool_Exercise_ShowClick(Sender: TObject);
    procedure Tool_Exercise_Cond2Click(Sender: TObject);
    procedure Tool_Exercise_Cond1Click(Sender: TObject);
    procedure Tool_Exercise_PrevClick(Sender: TObject);
    procedure Tool_Exercise_NextClick(Sender: TObject);
    procedure Edit_ShowLinesClick(Sender: TObject);
    procedure Options_HighlightClick(Sender: TObject);
    procedure MemoryTimerTimer(Sender: TObject);
    procedure Window_SaveGridClick(Sender: TObject);
    procedure Window_ClearGridClick(Sender: TObject);
    procedure Edit_charContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure aa_imageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure _c_LanguageDropDown(Sender: TObject);
    procedure _c_SkillDropDown(Sender: TObject);
    procedure _c_DurationDropDown(Sender: TObject);
    procedure _d_LanguageDropDown(Sender: TObject);
    procedure _c_Duration_IDropDown(Sender: TObject);
    procedure _c_Skill_IDropDown(Sender: TObject);
    procedure _c_Interpreter_IDropDown(Sender: TObject);
    procedure Program_StepClick(Sender: TObject);
    procedure EditorGutterClick(Sender: TObject; X, Y, Line: Integer;
      mark: TSynEditMark);
    procedure Program_Stop_PointClick(Sender: TObject);

    procedure _PackageManagerClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btSetPassClick(Sender: TObject);
    procedure mEnableAdmOptsMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btSetPassMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AdminPanelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btQuitAdmClick(Sender: TObject);
    procedure _c_StartTestMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Options_SoundClick(Sender: TObject);

    procedure RegSaveExtendedOpts;

    procedure ExceptionHandler(Sender: TObject; E: Exception);
  private
    { Private declarations }
    ImgPrevPos,
       PrevSize,
          PrevHeight
                : Integer;

    _Exercise_Prev_Ext    : Boolean;
    _Exercise_Prev_Ext_En : Boolean;
    TpModified        : Boolean;
    WasExerciseShow       : Boolean;
     iEditor          : TCustomEdit;

    PleaseKeepGrid    : Boolean;

    pFileName         : String;
    pInterpreter      : Integer;
    iCounter          : Integer;
    GridWasSaved      : Boolean;
    Pre1, Pre2        : Boolean;
    TstSelectedGrid1  : Boolean;
    ConsiderNextClick : Boolean;

  public
    { Public declarations }
            ProSyn : TSynProSyn;
            SynExportHTML : TSynEdukaExporterHTML;
  end;


var
   MainEdukaForm  : TMainEdukaForm;

implementation

uses Select_Interpreter, Select_Language,
     Select_Times, Select_Condition, Select_Name,
     Translate,  About, DesignInside, Movement,_Logics_,Lists,Select_Student,
     ProSyntax, EditorFuncs, Files, Errors, ContextHelp, Check_Save
{$IFDEF _DEBUG_}
    ,Debug, DebugMain
{$ENDIF}
, PackageManager, Login, Register;
Var
     SenderOfDialog : String;
       MainFormName : String;
     InternalStop   : Boolean;
    WasProc, WasEnd : Boolean;
    WasProc_N       : Integer;
    LUsedF          : Array[1..4] of String;
    BtnHasDown      : TJvStaticText;
    BtnHasUsed      : Boolean;



{$R *.dfm}


procedure TMainEdukaForm.SetupXSyntax;
var
 StX    : String;
 I, II  : integer;
begin
  ResetHighlighterValues( ProSyn, Editor );
  kBegin  := SY_START;
  kCall   := SY_CALL;
  kDo     := SY_DO;
  kDown   := SY_DOWN;
  kElse   := SY_ELSE;
  kEnd    := SY_END;
  kIf     := SY_IF;
  kIsBorder  := SY_IS_BORDER;
  kIsLine    := SY_IS_LINE;
  kJump      := SY_JUMP;
  kLeft      := SY_LEFT;
  kNot       := SY_NOT;
  kRepeat    := SY_REPEAT;
  kRight     := SY_RIGHT;
  kRotate    := SY_ROTATE;
  kProcedure := SY_PROCEDURE;
  kStep      := SY_STEP;
  kThen      := SY_THEN;
  kTimes     := SY_TIMES;
  kUntil     := SY_UNTIL;
  kUp        := SY_UP;
  kWhile     := SY_WHILE;

  if CurrentInterpreter=piAnt then
   begin
    ProProp.Editor:=Editor;

    Editor.Highlighter:=ProSyn;
    ProSyn.Ant_InstructionsAttri.Foreground:=AntKeyWordsColor;
    ProSyn.Ant_InstructionsAttri.Background:=clNone;
    ProSyn.Ant_InstructionsAttri.Style:=AntKeyWordsStyle;

    ProSyn.Kng_InstructionsAttri.Foreground:=IdentifierColor;
    ProSyn.Kng_InstructionsAttri.Background:=clNone;
    ProSyn.Kng_InstructionsAttri.Style:=IdentifierStyle;

    ikTuxInitKwrd  := 0;
    ikTuxInitConds := 0;

  end else
 if Currentinterpreter=piKng then
  begin
    Editor.Highlighter:=ProSyn;
    ProProp.Editor:=Editor;

    ProSyn.Kng_InstructionsAttri.Foreground:=KngKeyWordsColor;
    ProSyn.Kng_InstructionsAttri.Background:=clNone;
    ProSyn.Kng_InstructionsAttri.Style:=KngKeyWordsStyle;

    ProSyn.Ant_InstructionsAttri.Foreground:=IdentifierColor;
    ProSyn.Ant_InstructionsAttri.Background:=clNone;
    ProSyn.Ant_InstructionsAttri.Style:=IdentifierStyle;

    ikTuxInitKwrd  := 0;
    ikTuxInitConds := 0;

  end else
  begin
    Editor.Highlighter:=ProSyn;
    ProProp.Editor:=Editor;

    ProSyn.Kng_InstructionsAttri.Foreground:=TuxKeyWordsColor;
    ProSyn.Kng_InstructionsAttri.Background:=clNone;
    ProSyn.Kng_InstructionsAttri.Style     :=TuxKeyWordsStyle;

    ProSyn.Ant_InstructionsAttri.Foreground:=TuxKeyWordsColor;
    ProSyn.Ant_InstructionsAttri.Background:=clNone;
    ProSyn.Ant_InstructionsAttri.Style:=TuxKeyWordsStyle;

    kBegin     := ''; kCall      := ''; kDo        := ''; kDown      := SY_Pick; kElse      := '';
    kIf        := ''; kIsBorder  := ''; kIsLine    := ''; kJump      := SY_Swap; kLeft      := '';
    kNot       := ''; kRepeat    := ''; kRight     := SY_Drop; kProcedure := '';
    kThen      := ''; kTimes     := ''; kUntil     := ''; kUp        := '';
    kWhile     := ''; kEnd       := '';

    kTuxKeyWords[1] := SY_START;  kTuxKeyWords[7] := SY_END;       kTuxKeyWords[12] := '';
    kTuxKeyWords[2] := SY_REPEAT; kTuxKeyWords[8] := SY_WHILE;     kTuxKeyWords[13] := SY_UNTIL;
    kTuxKeyWords[3] := SY_IF;     kTuxKeyWords[9] := SY_ELSE;      kTuxKeyWords[14] := SY_PROCEDURE;
    kTuxKeyWords[4] := SY_DO;     kTuxKeyWords[10] := SY_THEN;     kTuxKeyWords[15] := SY_CALL;
    kTuxKeyWords[5] := SY_NOT;    kTuxKeyWords[11] := SY_Remember; kTuxKeyWords[16] := SY_Restore;
    kTuxKeyWords[6] := SY_Forget;

   ikTuxInitKwrd  := 16;
   ikTuxInitConds := 0;
   for i:=1 to 18 do
   begin
    ii := 1;
    StX := lngExtractSpeX(i, ii);

    While StX <> '' do
     begin
      Inc(ikTuxInitConds);
      kTuxConditions[ikTuxInitConds] := StX;
      Inc(ii);
      StX := lngExtractSpeX(i, ii);
     end;
   end;

  end;


end;

procedure TMainEdukaForm.ifaceDisableGridByMove();
var
 tMax : Integer;

procedure ifaceInternalDisable(u , v : Integer; ChangeIt : Boolean);
begin
 if GridPixelSize = grid_15 then Set_Grid_15.Enabled := False else
 begin
  tMax := pntGridPixelate(grid_15) + Integer(CurrentInterpreter = piKng);
  if (U > tMax) or (v > tMax) then
      Set_Grid_15.Enabled := False else
       if ChangeIt then Set_Grid_15.Enabled := True;
 end;

 if GridPixelSize = grid_20 then Set_Grid_20.Enabled := False else
 begin
  tMax := pntGridPixelate(grid_20) + Integer(CurrentInterpreter = piKng);
  if (U > tMax) or (v > tMax) then
      Set_Grid_20.Enabled := False else
      if ChangeIt then Set_Grid_20.Enabled := True;
 end;

 if GridPixelSize = grid_24 then Set_Grid_24.Enabled := False else
 begin
  tMax := pntGridPixelate(grid_24) + Integer(CurrentInterpreter = piKng);
  if (U > tMax) or (v > tMax) then
     Set_Grid_24.Enabled := False else
     if ChangeIt then Set_Grid_24.Enabled := True;
 end;

 if GridPixelSize = grid_36 then Set_Grid_36.Enabled := False else
 begin
  tMax := pntGridPixelate(grid_36) + Integer(CurrentInterpreter = piKng);
  if (U > tMax) or (v > tMax) then
     Set_Grid_36.Enabled := False else
     if ChangeIt then Set_Grid_36.Enabled := True;
 end;

 if GridPixelSize = grid_45 then Set_Grid_45.Enabled := False else
 begin
  tMax := pntGridPixelate(grid_45) + Integer(CurrentInterpreter = piKng);
  if (U > tMax) or (v > tMax) then
     Set_Grid_45.Enabled := False else
     if ChangeIt then Set_Grid_45.Enabled := True;
 end;

end;


begin

 tMax := pntGridPixelate(GridPixelSize) + Integer(CurrentInterpreter = piKng);
  if (U1 > tMax) or (v1 > tMax) then
      Tool_Window_Reset.Enabled := False else Tool_Window_Reset.Enabled := True;

  Tool_Window_Reset.Enabled := (InLaunchedTestMode) or (Tool_Window_Reset.Enabled and GridWasSaved and
                                                       (Editor.Enabled or ExerciseEditorFile));
                                                       
  Window_ResetGrid.Enabled  :=  Tool_Window_Reset.Enabled;

  ifaceInternalDisable(u , v, True);

  if ExerciseEditorFile then
    if _c_Grid_1.Checked then
              ifaceInternalDisable(u2 , v2, False) else
              ifaceInternalDisable(u1 , v1, False);
end;

procedure TMainEdukaForm.ifaceExerciseEditorControls(tHow : Boolean);
begin
 _c_Duration.Enabled := tHow;
 _c_Author.Enabled := tHow;
 _c_Skill.Enabled := tHow;
 _c_Language.Enabled := tHow and (not TestEditorMode);
 _c_Title.Enabled := tHow;
 _c_Description.Enabled := tHow;
 _c_Restrictions.Enabled := tHow;
 _c_Grid_1.Enabled := tHow and (not TestEditorMode);
 _c_Grid_2.Enabled := tHow and (not TestEditorMode);

 _Edit.Enabled := tHow;

 File_ExportHTML.Enabled    := tHow;
 File_Print.Enabled        := tHow;

   _Window.Enabled                  := tHow;
  Tool_Window_Reset.Enabled         := tHow;
  Tool_Window_Save.Enabled          := tHow;
  Tool_Window_Clear.Enabled         := tHow;

 Set_Grid_15.Enabled:= tHow;
 Set_Grid_20.Enabled:= tHow;
 Set_Grid_24.Enabled:= tHow;
 Set_Grid_36.Enabled:= tHow;
 Set_Grid_45.Enabled:= tHow;

 ExerciseEditorFile := tHow;
end;

procedure TMainEdukaForm.ifaceAdjustTestListControls();
begin

 if iSelectedFileList >= nExercises then
   begin
    Exercise_itemAddOver.Enabled   := False;
    Exercise_itemAddNormal.Enabled := False;
   end else
   begin
    Exercise_itemAddOver.Enabled   := True;
    Exercise_itemAddNormal.Enabled := True;
   end;

 if iSelectedFileList < 1 then
   begin
    File_Print.Enabled  := False;
    File_ExportHTML.Enabled  := False;
    Tool_File_Save.Enabled  := False;
    File_Save.Enabled       := False;
    File_SaveAs.Enabled     := False;

    _c_StartTest.Enabled          := False;
    Exercise_itemRemoveOver.Enabled   := False;
    Exercise_itemRemoveNormal.Enabled := False;
   end else
   begin
    File_Print.Enabled      := True;
    File_ExportHTML.Enabled := True;
    Tool_File_Save.Enabled  := True;
    File_Save.Enabled       := True;
    File_SaveAs.Enabled     := True;

    _c_StartTest.Enabled          := True;
    if _c_SelectedFiles.ItemIndex <> -1 then
     begin
      Exercise_itemRemoveOver.Enabled   := True;
      Exercise_itemRemoveNormal.Enabled := True;
     end else
     begin
      Exercise_itemRemoveOver.Enabled   := False;
      Exercise_itemRemoveNormal.Enabled := False;
     end;
   end;

 if (iSelectedFileList < 2) or (_c_SelectedFiles.ItemIndex = -1) then
   begin
    Exercise_itemUpOver      .Enabled := False;
    Exercise_itemUpNormal    .Enabled := False;
    Exercise_itemDownOver    .Enabled := False;
    Exercise_itemDownNormal  .Enabled := False;
   end else
   begin
    if _c_SelectedFiles.ItemIndex =0 then
     begin
      Exercise_itemUpOver      .Enabled := False;
      Exercise_itemUpNormal    .Enabled := False;
      Exercise_itemDownOver    .Enabled := True;
      Exercise_itemDownNormal  .Enabled := True;
     end else
    if _c_SelectedFiles.ItemIndex = iSelectedFileList - 1 then
     begin
      Exercise_itemUpOver      .Enabled := True;
      Exercise_itemUpNormal    .Enabled := True;
      Exercise_itemDownOver    .Enabled := False;
      Exercise_itemDownNormal  .Enabled := False;
     end else
     begin
      Exercise_itemUpOver      .Enabled := True;
      Exercise_itemUpNormal    .Enabled := True;
      Exercise_itemDownOver    .Enabled := True;
      Exercise_itemDownNormal  .Enabled := True;
     end;
   end;

 if (iSortedAvailableFileList > 0) and (_c_AvailableFiles.ItemIndex<>-1) then
  begin
   Exercise_itemAddOver   . Enabled := True;
   Exercise_itemAddNormal . Enabled := True;
  end else
  begin
   Exercise_itemAddOver   . Enabled := False;
   Exercise_itemAddNormal . Enabled := False;
  end;   
end;

procedure TMainEdukaForm.ifaceTestEditorControls(tHow, tWhy : Boolean);
var
 i : Integer;
begin
 _d_Language.Enabled := tHow;
 _c_Duration_I.Enabled := tHow;
 _c_Skill_I.Enabled := tHow;
 _c_Interpreter_I.Enabled := tHow;
 _c_AvailableFiles.Enabled := tHow;
 _c_SelectedFiles.Enabled := tHow;
 _c_StartTest.Enabled := tHow;

 File_ExportHTML.Enabled    := tHow;
 File_Print.Enabled        := tHow;

 Exercise_itemAddNormal.Enabled    := tHow;
 Exercise_itemRemoveNormal.Enabled := tHow;
 Exercise_itemUpNormal.Enabled   := tHow;
 Exercise_itemDownNormal.Enabled := tHow;
 Exercise_itemFolderNormal.Enabled := tHow;

    SetLength(AvailableFileList, 0);

     _c_AvailableFiles.Clear;
     _c_SelectedFiles.Clear;

     iAvailableFileList := 0;
     if tWhy then iSelectedFileList  := 0;

      for i := 0 to _d_Language.ItemsEx.Count-1 do
      begin
       _d_Language.ItemsEx.ComboItems[i].SelectedImageIndex := -1;
       _d_Language.ItemsEx.ComboItems[i].ImageIndex := -1;
      end;

        i := _d_Language.ItemIndex;
        _d_Language.ItemIndex := -1;
        _d_Language.ItemIndex := i;

 TestEditorFile := tHow;
end;

procedure TMainEdukaForm.ifaceExerciseControls(tHow : Boolean);
var
 TSrcFile     : TSearchRec;
 StName,LNm   : ShortString;
 Count, i     : integer;

 Cdd          : ShortString;
 pCdd         : PShortString;

begin
 if not tHow then
  begin
    if Tool_Extend_Edit.Down then
               begin
                  Extend_Edit.OnClick(Extend_Edit);

                  ac_Panel_Tux.BringToFront;
                  ac_Panel_Ant.BringToFront;
                  ac_Panel_Kng.BringToFront;

                  _Exercise_Prev_Ext_En := Extend_Edit.Enabled;

                  _Exercise_Prev_Ext := True;
               end else _Exercise_Prev_Ext := False;
  end
    else if (_Exercise_Prev_Ext) then Extend_Edit.OnClick(Extend_Edit);

 Options_SelectLanguage.Enabled := tHow;

 _Program.Enabled           := tHow;
 Extend_Edit.Enabled        := tHow;
 _PackageManager.Enabled    := tHow;

 _EditTest.Enabled          := tHow;

   ifaceActivateExerciseMemoEditControls(False, nil);

 File_Print.Enabled         := not tHow;
 File_ExportHTML.Enabled     := not tHow;

 Edit_ShowLines.Enabled     := tHow;
 Tool_Program_Check.Enabled := False;
 Tool_Program_Run.Enabled   := False;
 Tool_Program_Stop.Enabled  := False;

 Tool_Separator_Copy_Grid.Visible     := not tHow;

 if tHow then
     Tool_Extend_Edit.Enabled   := _Exercise_Prev_Ext_En;

 Panel_Editor.Visible       := not tHow;
 ExerciseEditorMode             := not tHow;

 if not tHow then Panel_Editor.BringToFront;

 if not tHow then
  begin
   // Include Languages into ComboBox;

   _c_Duration.ItemIndex := 0;
   _c_Skill.ItemIndex    := 0;
   _c_Title.Text := '';
   _c_Description.Lines.Clear;
   _c_Restrictions.Lines.Clear;

   _c_Grid_1.Checked:=true;
   _c_Grid_2.Checked:=false;

   // --
   if _c_Language.ItemsEx.Count > 0 then
    for i := 0 to _c_Language.ItemsEx.Count - 1 do
    begin
     pCdd := _c_Language.ItemsEx.Items[i].Data;
     FreeMem( pCdd );
    end;

   _c_Language.ItemsEx.Clear;
   // --

 count:=FindFirst(ExtractFilePath(ParamStr(0))+'Languages\*.lng',255,TSrcFile);

 _c_Language.ItemsEx.AddItem(engName, idxLanguageIcon, idxLanguageIcon, -1, -1, DynShortString(engCode));

 if CurrentLanguageCode = engCode then
      _c_Language.ItemIndex := 0;

 PLangs[0].Lng   := PShortString(_c_Language.ItemsEx.Items[0].Data)^;

 while (Count=0) do
   begin
   StName:= ExtractFilePath(ParamStr(0))+'Languages\' + TSrcFile.Name;

   Lnm := lngGetLanguageFileNameID(StName);
   Cdd := lngGetLanguageFileNameCode(StName);

   _c_Language.ItemsEx.AddItem(LNm,idxLanguageIcon,idxLanguageIcon,-1,-1,DynShortString(Cdd));

   if Cdd=CurrentLanguageCode then
        _c_Language.ItemIndex := _c_Language.ItemsEx.Count-1;

   PLangs[_c_Language.ItemsEx.Count-1].Lng   := Cdd;

   Count:=FindNext(TSrcFile);
  end;

    PrevLang := _c_Language.ItemIndex;

    PLangs[PrevLang].Lng   := PShortString(_c_Language.ItemsEx.Items[PrevLang].Data)^;

    _c_Duration.ItemsEx.ComboItems[0].Caption := '5 '+CBMINUTES;
    _c_Duration.ItemsEx.ComboItems[1].Caption := '10 '+CBMINUTES;
    _c_Duration.ItemsEx.ComboItems[2].Caption := '15 '+CBMINUTES;
    _c_Duration.ItemsEx.ComboItems[3].Caption := '20 '+CBMINUTES;
    _c_Duration.ItemsEx.ComboItems[4].Caption := '25 '+CBMINUTES;
    _c_Duration.ItemsEx.ComboItems[5].Caption := '30 '+CBMINUTES;
    _c_Duration.ItemsEx.ComboItems[6].Caption := '35 '+CBMINUTES;
    _c_Duration.ItemsEx.ComboItems[7].Caption := '40 '+CBMINUTES;
    _c_Duration.ItemsEx.ComboItems[8].Caption := '45 '+CBMINUTES;


    pntSwapPrimaryGrid( False, otExerciseG1);
    pntSwapPrimaryGrid( False, otExerciseG2);

    ifaceExerciseEditorControls(false);
  end;

end;

procedure TMainEdukaForm.ifaceSetupExternalImages();
begin

 ImageList.GetBitmap(idxLanguageIcon    , __i0.Picture.Bitmap);
 ImageList.GetBitmap(idxTitleIcon       , __i1.Picture.Bitmap);
 ImageList.GetBitmap(idxInterpreterIcon , __i2.Picture.Bitmap);
 ImageList.GetBitmap(idxDurationIcon    , __i3.Picture.Bitmap);
 ImageList.GetBitmap(idxSkillIcon       , __i4.Picture.Bitmap);
 ImageList.GetBitmap(idxAuthorIcon      , __i5.Picture.Bitmap);
 ImageList.GetBitmap(idxDurationIcon    , __i6.Picture.Bitmap);
 ImageList.GetBitmap(idxSkillIcon       , __i7.Picture.Bitmap);
 ImageList.GetBitmap(idxInterpreterIcon , __i8.Picture.Bitmap);
 ImageList.GetBitmap(idxGridIcon        , __i9.Picture.Bitmap);

 ImageList.GetBitmap(Tool_Exercise_Cond1.ImageIndex        , __i10.Picture.Bitmap);
 ImageList.GetBitmap(Tool_Exercise_Cond2.ImageIndex        , __i11.Picture.Bitmap);

 ImageList.GetBitmap(idxItemAddOverIcon       , Exercise_itemAddOver.Picture.Bitmap);
 ImageList.GetBitmap(idxItemAddNormalIcon     , Exercise_itemAddNormal.Picture.Bitmap);
 ImageList.GetBitmap(idxItemRemoveOverIcon    , Exercise_itemRemoveOver.Picture.Bitmap);
 ImageList.GetBitmap(idxItemRemoveNormalIcon  , Exercise_itemRemoveNormal.Picture.Bitmap);
 ImageList.GetBitmap(idxItemFolderOverIcon    , Exercise_itemFolderOver.Picture.Bitmap);
 ImageList.GetBitmap(idxItemFolderNormalIcon  , Exercise_itemFolderNormal.Picture.Bitmap);
 ImageList.GetBitmap(idxItemUpOverIcon        , Exercise_itemUpOver.Picture.Bitmap);
 ImageList.GetBitmap(idxItemUpNormalIcon      , Exercise_itemUpNormal.Picture.Bitmap);
 ImageList.GetBitmap(idxItemDownOverIcon      , Exercise_itemDownOver.Picture.Bitmap);
 ImageList.GetBitmap(idxItemDownNormalIcon    , Exercise_itemDownNormal.Picture.Bitmap);


 Extend_Edit      .ImageIndex := idxExtendEditNormalIcon;
 Tool_Extend_Edit .ImageIndex := idxExtendEditNormalIcon;
 Edit_ShowLines   .ImageIndex := idxShowLinesNormalIcon;
 Tool_Exercise_Show   .ImageIndex := idxExerciseConditionIcon;


 _c_Duration.ItemsEx.ComboItems[0].SelectedImageIndex := idxTimer05Minutes;
 _c_Duration.ItemsEx.ComboItems[0].ImageIndex         := idxTimer05Minutes;
 _c_Duration.ItemsEx.ComboItems[1].SelectedImageIndex := idxTimer10Minutes;
 _c_Duration.ItemsEx.ComboItems[1].ImageIndex         := idxTimer10Minutes;
 _c_Duration.ItemsEx.ComboItems[2].SelectedImageIndex := idxTimer15Minutes;
 _c_Duration.ItemsEx.ComboItems[2].ImageIndex         := idxTimer15Minutes;
 _c_Duration.ItemsEx.ComboItems[3].SelectedImageIndex := idxTimer20Minutes;
 _c_Duration.ItemsEx.ComboItems[3].ImageIndex         := idxTimer20Minutes;
 _c_Duration.ItemsEx.ComboItems[4].SelectedImageIndex := idxTimer25Minutes;
 _c_Duration.ItemsEx.ComboItems[4].ImageIndex         := idxTimer25Minutes;
 _c_Duration.ItemsEx.ComboItems[5].SelectedImageIndex := idxTimer30Minutes;
 _c_Duration.ItemsEx.ComboItems[5].ImageIndex         := idxTimer30Minutes;
 _c_Duration.ItemsEx.ComboItems[6].SelectedImageIndex := idxTimer35Minutes;
 _c_Duration.ItemsEx.ComboItems[6].ImageIndex         := idxTimer35Minutes;
 _c_Duration.ItemsEx.ComboItems[7].SelectedImageIndex := idxTimer40Minutes;
 _c_Duration.ItemsEx.ComboItems[7].ImageIndex         := idxTimer40Minutes;
 _c_Duration.ItemsEx.ComboItems[8].SelectedImageIndex := idxTimer45Minutes;
 _c_Duration.ItemsEx.ComboItems[8].ImageIndex         := idxTimer45Minutes;

 _c_Duration_I.ItemsEx.ComboItems[0].SelectedImageIndex := idxTimerAllMinutes;
 _c_Duration_I.ItemsEx.ComboItems[0].ImageIndex         := idxTimerAllMinutes;
 _c_Duration_I.ItemsEx.ComboItems[1].SelectedImageIndex := idxTimer05Minutes;
 _c_Duration_I.ItemsEx.ComboItems[1].ImageIndex         := idxTimer05Minutes;
 _c_Duration_I.ItemsEx.ComboItems[2].SelectedImageIndex := idxTimer10Minutes;
 _c_Duration_I.ItemsEx.ComboItems[2].ImageIndex         := idxTimer10Minutes;
 _c_Duration_I.ItemsEx.ComboItems[3].SelectedImageIndex := idxTimer15Minutes;
 _c_Duration_I.ItemsEx.ComboItems[3].ImageIndex         := idxTimer15Minutes;
 _c_Duration_I.ItemsEx.ComboItems[4].SelectedImageIndex := idxTimer20Minutes;
 _c_Duration_I.ItemsEx.ComboItems[4].ImageIndex         := idxTimer20Minutes;
 _c_Duration_I.ItemsEx.ComboItems[5].SelectedImageIndex := idxTimer25Minutes;
 _c_Duration_I.ItemsEx.ComboItems[5].ImageIndex         := idxTimer25Minutes;
 _c_Duration_I.ItemsEx.ComboItems[6].SelectedImageIndex := idxTimer30Minutes;
 _c_Duration_I.ItemsEx.ComboItems[6].ImageIndex         := idxTimer30Minutes;
 _c_Duration_I.ItemsEx.ComboItems[7].SelectedImageIndex := idxTimer35Minutes;
 _c_Duration_I.ItemsEx.ComboItems[7].ImageIndex         := idxTimer35Minutes;
 _c_Duration_I.ItemsEx.ComboItems[8].SelectedImageIndex := idxTimer40Minutes;
 _c_Duration_I.ItemsEx.ComboItems[8].ImageIndex         := idxTimer40Minutes;
 _c_Duration_I.ItemsEx.ComboItems[9].SelectedImageIndex := idxTimer45Minutes;
 _c_Duration_I.ItemsEx.ComboItems[9].ImageIndex         := idxTimer45Minutes;


 _c_Skill.ItemsEx.ComboItems[0].SelectedImageIndex := idxSkillNoviceSkill;
 _c_Skill.ItemsEx.ComboItems[0].ImageIndex         := idxSkillNoviceSkill;
 _c_Skill.ItemsEx.ComboItems[1].SelectedImageIndex := idxSkillAdvancedSkill;
 _c_Skill.ItemsEx.ComboItems[1].ImageIndex         := idxSkillAdvancedSkill;
 _c_Skill.ItemsEx.ComboItems[2].SelectedImageIndex := idxSkillExpertSkill;
 _c_Skill.ItemsEx.ComboItems[2].ImageIndex         := idxSkillExpertSkill;

 _c_Skill_I.ItemsEx.ComboItems[0].SelectedImageIndex := idxSkillAllSkills;
 _c_Skill_I.ItemsEx.ComboItems[0].ImageIndex         := idxSkillAllSkills;
 _c_Skill_I.ItemsEx.ComboItems[1].SelectedImageIndex := idxSkillNoviceSkill;
 _c_Skill_I.ItemsEx.ComboItems[1].ImageIndex         := idxSkillNoviceSkill;
 _c_Skill_I.ItemsEx.ComboItems[2].SelectedImageIndex := idxSkillAdvancedSkill;
 _c_Skill_I.ItemsEx.ComboItems[2].ImageIndex         := idxSkillAdvancedSkill;
 _c_Skill_I.ItemsEx.ComboItems[3].SelectedImageIndex := idxSkillExpertSkill;
 _c_Skill_I.ItemsEx.ComboItems[3].ImageIndex         := idxSkillExpertSkill;

 _c_Interpreter_I.ItemsEx.ComboItems[0].SelectedImageIndex := idxInterpreterAll;
 _c_Interpreter_I.ItemsEx.ComboItems[0].ImageIndex         := idxInterpreterAll;
 _c_Interpreter_I.ItemsEx.ComboItems[1].SelectedImageIndex := idxInterpreterAnt;
 _c_Interpreter_I.ItemsEx.ComboItems[1].ImageIndex         := idxInterpreterAnt;
 _c_Interpreter_I.ItemsEx.ComboItems[2].SelectedImageIndex := idxInterpreterKng;
 _c_Interpreter_I.ItemsEx.ComboItems[2].ImageIndex         := idxInterpreterKng;
 _c_Interpreter_I.ItemsEx.ComboItems[3].SelectedImageIndex := idxInterpreterTux;
 _c_Interpreter_I.ItemsEx.ComboItems[3].ImageIndex         := idxInterpreterTux;

end;


procedure TMainEdukaForm.ifaceTestControls(tHow : Boolean);
var
 TSrcFile     : TSearchRec;
 StName,LNm,Cdd   : ShortString;
 Count,i        : integer;
 pCdd    : PShortString;
begin
  Edit_ShowLines.Enabled     := tHow;
 _Options.Enabled := tHow;
 _Program.Enabled           := tHow;
 _Edit.Enabled              := tHow;

 _EditExercise.Enabled          := tHow;
 _PackageManager.Enabled    := tHow;
 
 Tool_Edit_Undo.Enabled     := False;
 Tool_Edit_Cut.Enabled      := False;
 Tool_Edit_Copy.Enabled     := False;
 Tool_Edit_Paste.Enabled    := False;

 _Window.Enabled                   := false;
 Tool_Window_Reset.Enabled         := false;
 Tool_Window_Save.Enabled          := false;
 Tool_Window_Clear.Enabled         := false;

 File_ExportHTML.Enabled    := not tHow;
 File_Print.Enabled        := not tHow;

 Tool_Program_Check.Enabled := False;
 Tool_Program_Run.Enabled   := False;
 Tool_Program_Stop.Enabled  := False;
 PaintBox.Visible           := tHow;


 Panel_Test.Visible       := not tHow;

    TestEditorMode := not tHow;

    if not tHow then
    begin
       // Include Languages into ComboBox;

   // --
   if _d_Language.ItemsEx.Count > 0 then
    for i := 0 to _d_Language.ItemsEx.Count - 1 do
    begin
     pCdd := _d_Language.ItemsEx.Items[i].Data;
     FreeMem( pCdd );
    end;

   _d_Language.ItemsEx.Clear;
   // --

      count:=FindFirst(ExtractFilePath(ParamStr(0))+'Languages\*.lng',255,TSrcFile);

      _d_Language.ItemsEx.AddItem(engName,-1,-1,-1,-1,DynShortString(engCode));

 if CurrentLanguageCode=engCode then
      _d_Language.ItemIndex := 0;

    PLangs[0].Lng   := PShortString(_d_Language.ItemsEx.Items[0].Data)^;

 while (Count=0) do
   begin
   StName:= ExtractFilePath(ParamStr(0))+'Languages\' + TSrcFile.Name;

   Lnm:=lngGetLanguageFileNameID(StName);
   Cdd := lngGetLanguageFileNameCode(StName);

   _d_Language.ItemsEx.AddItem(LNm,-1,-1,-1,-1,DynShortString(Cdd));

   if Cdd=CurrentLanguageCode then
        _d_Language.ItemIndex := _d_Language.ItemsEx.Count-1;

   PLangs[_d_Language.ItemsEx.Count-1].Lng   := Cdd;

   Count:=FindNext(TSrcFile);
  end;


    _c_Duration_I.ItemsEx.ComboItems[1].Caption := '5 '+CBMINUTES;
    _c_Duration_I.ItemsEx.ComboItems[2].Caption := '10 '+CBMINUTES;
    _c_Duration_I.ItemsEx.ComboItems[3].Caption := '15 '+CBMINUTES;
    _c_Duration_I.ItemsEx.ComboItems[4].Caption := '20 '+CBMINUTES;
    _c_Duration_I.ItemsEx.ComboItems[5].Caption := '25 '+CBMINUTES;
    _c_Duration_I.ItemsEx.ComboItems[6].Caption := '30 '+CBMINUTES;
    _c_Duration_I.ItemsEx.ComboItems[7].Caption := '35 '+CBMINUTES;
    _c_Duration_I.ItemsEx.ComboItems[8].Caption := '40 '+CBMINUTES;
    _c_Duration_I.ItemsEx.ComboItems[9].Caption := '45 '+CBMINUTES;

    _c_Duration_I.ItemIndex := 0;
    _c_Skill_I.ItemIndex    := 0;
    _c_Interpreter_I.ItemIndex    := 0;

    Panel_Test.BringToFront;

      ifaceTestEditorControls(tHow, True);
    end;
end;


procedure TMainEdukaForm.ifaceSetFormIcon;
Var
 IcH : HICON;
begin
 icH:=0;

 if (TestEditorMode) or (ExerciseEditorMode) or (AdministrativeStart) then
    IcH:=LoadIcon(GetWindowLong(Handle,GWL_HINSTANCE),'IDI_ICON10') else
 case ID of
  piAnt :  IcH:=LoadIcon(GetWindowLong(Handle,GWL_HINSTANCE),'IDI_ICON11');
  piKng :  IcH:=LoadIcon(GetWindowLong(Handle,GWL_HINSTANCE),'IDI_ICON12');
  piTux :  IcH:=LoadIcon(GetWindowLong(Handle,GWL_HINSTANCE),'IDI_ICON13');
 end;

  if IcH<>0 then
     begin
      Icon.Handle:=IcH;
      Application.Icon.Handle:=IcH;
     end;
end;

procedure TMainEdukaForm.ifaceSetFormCaption;
begin
 if AdministrativeStart then
        Name:= DIALOG_FC_ADMIN;

 if ExerciseEditorMode then
        Name := DIALOG_I_ETK;

 if TestEditorMode then
        Name := DIALOG_I_ETT;

 MainFormName := Name + ' ('+VersionID+')';
{$IFDEF _DEBUG_}
 MainFormName := Name + ' ('+VersionID+' | Debug Version)';
{$ENDIF}

 Application.Title:=ProgramID+' '+Name;

 if FName<>'' then
    Caption:=ProgramID+' '+MainFormName + ' - ' + FName else
    Caption:=ProgramID+' '+MainFormName;
end;


procedure TMainEdukaForm.ifaceMoveExerciseToEditor(PrevExercise : Integer);
var
 II    : Integer;
 Id    : Integer;

 SrcEnglish,
   SrcCurrent  : Boolean;
begin
 SrcEnglish   := false;
 SrcCurrent   := false;
 Id           := 0;

 Exercise_Exercise.Clear;
  for II := 0 to nLangs do
   if (SelectedFileList [ CurrentExerciseNr ]. Info2 [ II ].Lng = CurrentLanguageCode)
       and (SelectedFileList [ CurrentExerciseNr ]. Info2 [ II ].Title <> '')
       and (SelectedFileList [ CurrentExerciseNr ]. Info2 [ II ].Descr <> '') then
    begin
      SrcEnglish := True;
      SrcCurrent := True;
      Id         := II;
    end else

   if (SelectedFileList [ CurrentExerciseNr ]. Info2 [ II ].Lng = engCode)
       and (SelectedFileList [ CurrentExerciseNr ]. Info2 [ II ].Title <> '')
       and (SelectedFileList [ CurrentExerciseNr ]. Info2 [ II ].Descr <> '')
       and (not SrcCurrent) then
    begin
      SrcEnglish := True;
      Id         := II;
    end else

   if (SelectedFileList [ CurrentExerciseNr ]. Info2 [ II ].Lng <> '' )
       and (SelectedFileList [ CurrentExerciseNr ]. Info2 [ II ].Title <> '')
       and (SelectedFileList [ CurrentExerciseNr ]. Info2 [ II ].Descr <> '')
       and (not SrcEnglish) then
                                  Id         := II;

     if SelectedFileList [ CurrentExerciseNr ].NowSuccess then
          begin
            edtPrintToEditor(Exercise_Exercise, ExerciseIsOKColor, ExerciseIsOKStyle,ExerciseISOK + Enter);
            Tool_Exercise_Show.ImageIndex := idxExerciseNowResolvedIcon;
          end else
     if SelectedFileList [ CurrentExerciseNr ].WasSuccess then
           begin
            edtPrintToEditor(Exercise_Exercise, ExerciseWasOKColor, ExerciseWasOKStyle,ExerciseWASOK + Enter);
            Tool_Exercise_Show.ImageIndex := idxExerciseWasResolvedIcon;
           end else
           begin
            edtPrintToEditor(Exercise_Exercise, ExerciseNotOKColor, ExerciseNotOKStyle,ExerciseNOTOK + Enter);
            Tool_Exercise_Show.ImageIndex := idxExerciseConditionIcon;
           end; 

     edtPrintToEditor(Exercise_Exercise, clWhite, [],'' + Enter);
     
     edtPrintToEditor(Exercise_Exercise, ExerciseIndexTitleColor, ExerciseIndexTitleStyle, Gb_Title.Caption+' :' + Enter);

     edtPrintToEditor(Exercise_Exercise, ExerciseTextTitleColor, ExerciseTextTitleStyle,
                     '   '+SelectedFileList [ CurrentExerciseNr ]. Info2 [ Id ].Title + Enter);

     edtPrintToEditor(Exercise_Exercise, clWhite, [],'' + Enter);
     edtPrintToEditor(Exercise_Exercise, ExerciseIndexTitleColor, ExerciseIndexTitleStyle,Gb_Description.Caption+' :' + Enter);

     edtPrintToEditor(Exercise_Exercise, ExerciseTextDescrColor, ExerciseTextDescrStyle,
                     '   '+SelectedFileList [ CurrentExerciseNr ]. Info2 [ Id ].Descr + Enter);

     edtPrintToEditor(Exercise_Exercise, clWhite, [],'' + Enter);
     edtPrintToEditor(Exercise_Exercise, ExerciseIndexTitleColor, ExerciseIndexTitleStyle, Gb_Restrictions.Caption+' :' + Enter);

     edtPrintToEditor(Exercise_Exercise, ExerciseTextRestsColor, ExerciseTextRestsStyle,
                     '   '+SelectedFileList [ CurrentExerciseNr ]. Info2 [ Id ].Rests + Enter);


     if PrevExercise > -1 then
     SelectedFileList [ PrevExercise ].SelExercise := Editor.Text;

     if PrevExercise > -2 then
     begin
       Editor.Text := SelectedFileList [ CurrentExerciseNr ].SelExercise;

       if TstSelectedGrid1 then
          pntSwapPrimaryGrid( True, otTestG1, CurrentExerciseNr) else
          pntSwapPrimaryGrid( True, otTestG2, CurrentExerciseNr);
     end;
end;

procedure TMainEdukaForm.LoadRecentFiles;
Var
 Pb : String;
begin
 if CI = piKng then Pb:='Kng' else
   if CI = piAnt then Pb:='Ant' else Pb:='Tux';

  if ExerciseEditorMode then Pb:='Exercise';
  if TestEditorMode then Pb:='Test';

  LUsedF[1] := LoadOption(Pb+'RecentFile1',VKey,'',RKEY);
  LUsedF[2] := LoadOption(Pb+'RecentFile2',VKey,'',RKEY);
  LUsedF[3] := LoadOption(Pb+'RecentFile3',VKey,'',RKEY);
  LUsedF[4] := LoadOption(Pb+'RecentFile4',VKey,'',RKEY);

  File_R1.Caption := MinimizeName(LUsedF[1],Canvas,180);
  File_R2.Caption := MinimizeName(LUsedF[2],Canvas,180);
  File_R3.Caption := MinimizeName(LUsedF[3],Canvas,180);
  File_R4.Caption := MinimizeName(LUsedF[4],Canvas,180);

  File_R1.Visible := File_R1.Caption<>'';
  File_R2.Visible := File_R2.Caption<>'';
  File_R3.Visible := File_R3.Caption<>'';
  File_R4.Visible := File_R4.Caption<>'';
end;

procedure TMainEdukaForm.SaveRecentFiles;
Var
 Pb : String;
begin
 if CI = piKng then Pb:='Kng' else
   if CI = piAnt then Pb:='Ant' else Pb:='Tux';

  if ExerciseEditorMode then Pb:='Exercise';
  if TestEditorMode then Pb:='Test';
  
  SaveOption(Pb+'RecentFile1',VKey,LUsedF[1],RKEY);
  SaveOption(Pb+'RecentFile2',VKey,LUsedF[2],RKEY);
  SaveOption(Pb+'RecentFile3',VKey,LUsedF[3],RKEY);
  SaveOption(Pb+'RecentFile4',VKey,LUsedF[4],RKEY);
end;

procedure TMainEdukaForm.AddRecentFile(FName : String);
begin
  If AnsiUpperCase(LUsedF[1])=AnsiUpperCase(FName) then Exit;

  If AnsiUpperCase(LUsedF[2])=AnsiUpperCase(FName) then
   begin
     File_R2.Caption:=File_R1.Caption;
     File_R1.Caption:=MinimizeName(FName,Canvas,180);

     LUsedF[2]:=LUsedF[1];
     LUsedF[1]:=FName;

     Exit;
   end;
  If AnsiUpperCase(LUsedF[3])=AnsiUpperCase(FName) then
   begin
     File_R3.Caption:=File_R2.Caption;
     File_R2.Caption:=File_R1.Caption;
     File_R1.Caption:=MinimizeName(FName,Canvas,180);

     LUsedF[3]:=LUsedF[2];
     LUsedF[2]:=LUsedF[1];
     LUsedF[1]:=FName;

     Exit;
   end;

     LUsedF[4]:=LUsedF[3];
     LUsedF[3]:=LUsedF[2];
     LUsedF[2]:=LUsedF[1];
     LUsedF[1]:=FName;

  File_R4.Caption:=File_R3.Caption;
  File_R3.Caption:=File_R2.Caption;
  File_R2.Caption:=File_R1.Caption;
  File_R1.Caption:=MinimizeName(FName,Canvas,180);

  File_R1.Visible := File_R1.Caption<>'';
  File_R2.Visible := File_R2.Caption<>'';
  File_R3.Visible := File_R3.Caption<>'';
  File_R4.Visible := File_R4.Caption<>'';
end;

procedure TMainEdukaForm.ifaceErrorAdjust(tHow : Boolean);
begin
 if tHow then
  begin
    Error_Panel.Hide;
    Editor.SelectedColor.Background := EditorSelNormColor;
    ErrorShown:=false;

    if not Exercise_Exercise.Visible then Editor.Height:=PrevHeight;
    if WasExerciseShow then
     begin
      Tool_Exercise_Show.OnClick(Tool_Exercise_Show);
     end;

    WasExerciseShow := False;
    Editor.BringToFront;
  end;
end;

procedure TMainEdukaForm.ifaceBookMark(Line : Integer);
var
 I, BkNumber : Integer;
begin
 if not Editor.Gutter.Visible then
    Edit_ShowLines.Click();

 if Editor.Marks.Count > 0 then
  begin
   for I := 0  to Editor.Marks.Count - 1 do
    if Editor.Marks.Items[I].Line = Line then
     begin
       BkList[Editor.Marks.Items[I].BookmarkNumber] := -1;
       Editor.Marks.Delete(I);
       Exit;
     end;
  end;

 BkNumber := -1;
 for I := 0 to MaxStopPoints do
  if (BkList[I]=-1) and (BkNumber=-1) then
   begin
    BkList[I] := Line;
    BkNumber  := I;
   end;

 if (BkNumber>-1) then
     Editor.SetBookMark(BkNumber, 0, Line);
end;

procedure TMainEdukaForm.ifaceExerciseCondAdjust(tHow : Boolean);
begin
 Exercise_Exercise.Visible := tHow;
 Exercise_Exercise.BringToFront;
 WasExerciseShow := tHow;

 if Exercise_Exercise.Visible then
    Editor.Height := Editor.Height - Exercise_Exercise.Height else
    Editor.Height := PrevHeight;

end;

procedure TMainEdukaForm.SendToCharEdit(ch : Char);
var
 cht : Char;
begin
 Cht:=Ch;
 Edit_Char.OnKeyPress(Edit_Char,Cht);
end;

procedure TMainEdukaForm.ifaceGridSizes(ActiveBtn : TJvStaticText);
begin
  diMakeStaticTextDefault(set_grid_15);
  diMakeStaticTextDefault(set_grid_20);
  diMakeStaticTextDefault(set_grid_24);
  diMakeStaticTextDefault(set_grid_36);
  diMakeStaticTextDefault(set_grid_45);

  diMakeStaticTextActive(ActiveBtn);
end;

procedure TMainEdukaForm.GridSizeChange;
begin

 case Msg.CharCode of
   45 : begin GRidPixelSize:=grid_45; ifaceGridSizes(set_Grid_45);end;
   36 : begin GRidPixelSize:=grid_36; ifaceGridSizes(set_Grid_36);end;
   24 : begin GRidPixelSize:=grid_24; ifaceGridSizes(set_Grid_24);end;
   20 : begin GRidPixelSize:=grid_20; ifaceGridSizes(set_Grid_20);end;
   15 : begin GRidPixelSize:=grid_15; ifaceGridSizes(set_Grid_15);end;
 end;

  TabMax:=pntGridPixelate(GridPixelSize);

  pntInitializeValues( not PleaseKeepGrid, AnimalReset );

  CurrentX :=   + GridPixelSize *(u-1);
  CurrentY :=   + GridPixelSize *(v-1);

  pntRedrawWholeTable();
end;

procedure TMainEdukaForm.SelectConditionClose;
begin
 Condition:=Dialog_Select_Condition.SelectedCondition;
 edtInsertToEditor(Editor,ipCursor,SenderOfDialog);
end;

procedure TMainEdukaForm.CalculateAInstruction;
begin
 if Msg.WParam = 1 then ifaceActivateControls(false) else
 begin
  Inc(iCounter);

  {$IFDEF _TRIAL_}

  if iCounter >= 30 then
     KillThreadFlag:=True;
     
  {$ENDIF}
  if ExtendedAcademic then
     StatusBar.Panels[4].Text := DLGINSTRUCTIONS + ' '+IntToStr(iCounter);
 end; 

end;

procedure TMainEdukaForm.OpenMyDDEFiles;
begin
  if AdministrativeStart then Exit;
  
  if Msg.WParam = 0 then
    begin
     case pInterpreter of
      Ord(piAnt) :
                   begin
                     Dialog_Select_Interpreter.Speed_Tux.Down:=False;
                     Dialog_Select_Interpreter.Speed_Ant.Down:=True;
                     Dialog_Select_Interpreter.Speed_Kng.Down:=False;
                     SendMessage(MainEdukaForm.Handle,WM_SelectInterpreterClose,0,0);

                   end;
      Ord(piKng) :
                   begin
                     Dialog_Select_Interpreter.Speed_Tux.Down:=False;
                     Dialog_Select_Interpreter.Speed_Ant.Down:=False;
                     Dialog_Select_Interpreter.Speed_Kng.Down:=True;
                     SendMessage(MainEdukaForm.Handle,WM_SelectInterpreterClose,0,0);

                   end;
      Ord(piTux) :
                   begin
                     Dialog_Select_Interpreter.Speed_Tux.Down:=True;
                     Dialog_Select_Interpreter.Speed_Ant.Down:=False;
                     Dialog_Select_Interpreter.Speed_Kng.Down:=False;
                     SendMessage(MainEdukaForm.Handle,WM_SelectInterpreterClose,0,0);

                   end;
      1000       :
                   begin
                     if (ExtendedAcademic) and (not ExerciseEditorMode) then
                        MainEdukaForm._EditExercise.Click();
                   end;
      1001       :
                   begin
                     if (ExtendedAcademic) and (not TestEditorMode) then
                        MainEdukaForm._EditTest.Click();
                   end;
      1002       :
                   begin
                     if InCriticalStage then exit;
                     if (not ExtendedPackage) then exit;

                     PackageForm.NoShow := True;
                     PackageForm.OpenDialog.FileName := pFileName;
                     PackageForm.Pack_Install.OnClick(PackageForm.Pack_Install);
                   end;
     end;
     if InCriticalStage then exit;

     if ((pInterpreter = 1000) or (pInterpreter = 1001)) and
        (not ExtendedAcademic) then
         begin
           pFileName    := '';
           pInterpreter := 0;
           exit;
         end;

     if (pInterpreter <> 1002) then
     begin

     if pFileName <> '' then
      begin
       OpenDialog.FileName:=pFileName;
       File_OpenClick(nil);
      end else File_CloseClick(File_Close);
     end;

     Application.BringToFront;
     BringToFront;

     pFileName := '';
     pInterpreter := 0;

    end else
    begin
     if Msg.WParam = 1 then pInterpreter := Msg.LParam else
                            pFileName    := pFileName + Char(Msg.WParam);
    end;
end;

procedure TMainEdukaForm.SelectStudentClose;
var
 VrLocal : Integer;
begin
  for VrLocal := 0 to iSelectedFileList - 1 do
    begin
     SelectedFileList [ VrLocal ].SelExercise := '{ '+ExerciseID+' '+IntToStr(VrLocal+1)+' }';
     SelectedFileList [ VrLocal ].WasSuccess := False;
     SelectedFileList [ VrLocal ].NowSuccess := False;
    end;

 VrLocal := iSelectedFileList;

  Student_Name := Dialog_Select_Student.edt_StudInfo.Text;
  if Student_Name = '' then Student_Name := HTML_Unknown_Name;

 _EditTest.Click;

 File_New.Click;
 ifaceLaunchedTestControls(True, True);

 WasExerciseShow := false;
 Tool_Exercise_Show.OnClick(Tool_Exercise_Show);

 InLaunchedTestMode := True;
 CurrentExerciseNr      := -1;
 iSelectedFileList  := VrLocal;

 sFileName:=Dialog_Select_Student.edt_ExportFile.Text;
 ifaceSetFormCaption(CurrentInterpreterName, ExtractFileName(sFileName));

 Editor.Modified := True;
 StatusBar.Panels.Items[1].Text:=MDFED;

 TstSelectedGrid1 := True;
 Tool_Exercise_Cond1.Down := True;

 Tool_Exercise_Next.OnClick(Tool_Exercise_Next);

end;

procedure TMainEdukaForm.SelectTimesClose;
begin
 RepeatTimes:=Dialog_Select_Times.RepeatTimes;
 edtInsertToEditor(Editor,ipCursor,SenderOfDialog);
end;

procedure TMainEdukaForm.SelectNameClose;
begin
 ProcName:=Dialog_Select_Name.ProcName;
 edtInsertToEditor(Editor,ipCursor,SenderOfDialog);
end;

procedure TMainEdukaForm.SelectLanguageClose;
var
 LastPos : Integer;
 LastMod : Boolean;
begin
 lngLoadSelectedLanguage(Dialog_Select_Language.LangFileName, MainEdukaForm);

 flsSetDialogsFilter(SaveDialog,OpenDialog,CurrentInterpreter);

 if Editor.Enabled then
  begin
   Editor.Visible:=false;
   ErrorEdit.Visible:=false;
   LastPos:=Editor.SelStart;
   LastMod:=Editor.Modified;

   Editor.ClearAll;
   PleaseKeepGrid := True;
   flsEditorOpenFromFile(True, _c_Duration, _c_Skill, _c_Author, Editor, ExtractFilePath(ParamStr(0))+TmpFileName);
   PleaseKeepGrid := False;
   Editor.Visible:=True;
   ErrorEdit.Visible:=True;

   Editor.Modified:=LastMod;
   Editor.OnChange(Editor);

   Editor.SelStart:=LastPos;
  end;

  StatusBar.Panels.Items[3].Text := CurrentLanguage + ' ('+CurrentLanguageCode+')';

  if CurrentHelpFile<>'' then
     StatusBar.Panels.Items[3].Text:=StatusBar.Panels.Items[3].Text+' ['+CurrentHelpFile+']';

  Help_Topics.Enabled:=CurrentHelpFile<>'';

  case CurrentInterpreter of
   piKng : begin StatusBar.Panels.Items[2].Text:=Dialog_I_Kng; CurrentInterpreterName:=Dialog_I_Kng;end;
   piAnt : begin StatusBar.Panels.Items[2].Text:=Dialog_I_Ant; CurrentInterpreterName:=Dialog_I_Ant;end;
   piTux : begin StatusBar.Panels.Items[2].Text:=Dialog_I_Tux; CurrentInterpreterName:=Dialog_I_Tux;end;
  end;

  if StatusBar.Panels[4].Text <> '' then
        StatusBar.Panels[4].Text :=  DLGINSTRUCTIONS+' '+IntToStr(iCounter);
        
  ifaceSetFormCaption(CurrentInterpreterName,ExtractFileName(sFileName));
  SetupXSyntax;
end;

procedure TMainEdukaForm.ifaceLaunchedTestControls(tHow, tWhy : Boolean);
begin
 Tool_Exercise_Show  . Visible := tHow;
 Tool_Exercise_Cond1 . Visible := tHow;
 Tool_Exercise_Cond2 . Visible := tHow;
 Tool_Exercise_Prev  . Visible := tHow;
 Tool_Exercise_Next  . Visible := tHow;

 Tool_Sep0       . Visible := tHow;
 Tool_Sep1       . Visible := tHow;

 Tool_Exercise_Show  . Enabled := tWhy;
 Tool_Exercise_Cond1 . Enabled := tWhy;
 Tool_Exercise_Cond2 . Enabled := tWhy;
 Tool_Exercise_Prev  . Enabled := tWhy;
 Tool_Exercise_Next  . Enabled := tWhy;


 Tool_File_New        . Enabled := not tHow;
 Tool_File_Open       . Enabled := not tHow;
 Tool_File_Save       . Enabled := not tHow;

 File_New        . Enabled := not tHow;
 File_Open       . Enabled := not tHow;
 File_Save       . Enabled := not tHow;
 File_SaveAs     . Enabled := not tHow;
 File_ExportHTML . Enabled := not tHow;
 File_Print      . Enabled := not tHow;
 File_R1         . Enabled := not tHow;
 File_R2         . Enabled := not tHow;
 File_R3         . Enabled := not tHow;
 File_R4         . Enabled := not tHow;
 _Options        . Enabled := not tHow;
 _Utils          . Enabled := not tHow;

 Tool_Window_Save.Enabled          := not tHow;
 Tool_Window_Clear.Enabled         := not tHow;

 Window_SaveGrid.Enabled           := not tHow;
 Window_ClearGrid.Enabled          := not tHow;

 Window_ResetGrid.Enabled          := tHow;
 Tool_Window_Reset.Enabled         := tHow;
//
end;

procedure TMainEdukaForm.SelectInterpreterClose;
begin
  SaveRecentFiles(CurrentInterpreter);

  if Dialog_Select_Interpreter.Speed_Kng.Down then
  begin
    CurrentInterpreter := piKng;
    ac_Panel_Kng.Visible:=True;
    ac_Panel_ant.Visible:=False;
    ac_Panel_tux.Visible:=False;
    Kng_Basic.Visible:=True;
    Kng_Advanced.Visible:=True;
    ant_Basic.Visible:=False;
    ant_Advanced.Visible:=False;
    tux_Basic.Visible:=False;
    tux_Advanced.Visible:=False;
    ant_Condition.Visible:=False;
    Kng_Condition.Visible:=True;

    Pocket_Text.Visible := False;
    Pocket_Letter.Visible := False;
  end;
 if Dialog_Select_Interpreter.Speed_ant.Down then
  begin
    CurrentInterpreter := piAnt;
    ac_Panel_Kng.Visible:=False;
    ac_Panel_ant.Visible:=True;
    ac_Panel_tux.Visible:=False;
    Kng_Basic.Visible:=False;
    Kng_Advanced.Visible:=False;
    ant_Basic.Visible:=True;
    ant_Advanced.Visible:=True;
    tux_Basic.Visible:=False;
    tux_Advanced.Visible:=False;
    ant_Condition.Visible:=True;
    Kng_Condition.Visible:=False;

    Pocket_Text.Visible := False;
    Pocket_Letter.Visible := False;
  end;
 if Dialog_Select_Interpreter.Speed_tux.Down then
  begin
    CurrentInterpreter := piTux;
    ac_Panel_Kng.Visible:=False;
    ac_Panel_ant.Visible:=False;
    ac_Panel_tux.Visible:=True;
    Kng_Basic.Visible:=False;
    Kng_Advanced.Visible:=False;
    ant_Basic.Visible:=False;
    ant_Advanced.Visible:=False;
    tux_Basic.Visible:=True;
    tux_Advanced.Visible:=True;
    ant_Condition.Visible:=False;
    Kng_Condition.Visible:=False;
    Pocket_Text.Visible := True;
    Pocket_Letter.Visible := True;
  end;

  case CurrentInterpreter of
   piKng : begin StatusBar.Panels.Items[2].Text:=Dialog_I_Kng; CurrentInterpreterName:=Dialog_I_Kng;end;
   piAnt : begin StatusBar.Panels.Items[2].Text:=Dialog_I_Ant; CurrentInterpreterName:=Dialog_I_Ant;end;
   piTux : begin StatusBar.Panels.Items[2].Text:=Dialog_I_Tux; CurrentInterpreterName:=Dialog_I_Tux;end;
  end;

  ifaceSetFormCaption(CurrentInterpreterName,ExtractFileName(sFileName));
  ifaceSetFormIcon(CurrentInterpreter);
  SetupXSyntax;

  flsSetDialogsFilter(SaveDialog,OpenDialog,CurrentInterpreter);
  SaveDialog.FileName:='';
  OpenDialog.FileName:='';

  LoadRecentFiles(CurrentInterpreter);

  pntHideInterpreterImages(piKng);
  pntHideInterpreterImages(piAnt);
  pntHideInterpreterImages(piTux);

  pntInitializeValues(True, AnimalReset);
  pntRedrawWholeTable();
end;


procedure TMainEdukaForm.ifaceActivateEditControls(tHow : Boolean);
begin
 Extend_Edit.Enabled:=tHow;
 Tool_Extend_Edit.Enabled:=tHow;
if tHow then
 begin
 with Editor do
  If Length(SelText)>0 then
  begin
        Edit_Cut.Enabled:=true;
        Popup_Cut.Enabled:=true;
        Popup_Copy.Enabled:=true;
   Tool_Edit_Cut.Enabled:=true;
        Edit_Copy.Enabled:=true;
   Tool_Edit_Copy.Enabled:=true;
  end
   else
   begin
        Popup_Cut.Enabled:=false;
        Popup_Copy.Enabled:=false;
        Edit_Cut.Enabled:=False;
   Tool_Edit_Cut.Enabled:=False;
        Edit_Copy.Enabled:=False;
   Tool_Edit_Copy.Enabled:=False;
  end;

  Tool_Edit_Undo.Enabled    := (Editor.CanUndo);
  Edit_Undo     .Enabled    := (Editor.CanUndo);
  Popup_Undo.Enabled        := (Editor.CanUndo);


  Edit_SelectAll.Enabled  := (Editor.Text <> '');
  Edit_Clear.Enabled      := (Edit_SelectAll.Enabled);
  Popup_SelectAll.Enabled := (Edit_SelectAll.Enabled);
  Popup_Clear.Enabled     := (Edit_Clear.Enabled);

  if  Clipboard.HasFormat(CF_TEXT) then
  begin
   Edit_Paste.Enabled      := True;
   Tool_Edit_Paste.Enabled := True;
   Popup_Paste.Enabled     := True;
  end;
 end else
  begin

         Edit_SelectAll.Enabled :=False;
         Edit_Clear.Enabled :=False;

         Popup_SelectAll.Enabled :=False;
         Popup_Clear.Enabled :=False;

         Edit_Cut.Enabled :=False;
    Tool_Edit_Cut.Enabled :=False;
        Edit_Copy.Enabled :=False;
   Tool_Edit_Copy.Enabled :=False;
   Tool_Edit_Undo.Enabled :=False;
        Edit_Undo.Enabled :=False;
       Edit_Paste.Enabled :=False;
  Tool_Edit_Paste.Enabled :=False;

       Popup_Cut.Enabled:= false;
       Popup_Copy.Enabled:=false;
       Popup_Paste.Enabled:=false;
       Popup_Undo.Enabled:=false;
  end;
end;

procedure TMainEdukaForm.ifaceActivateExerciseMemoEditControls(tHow : Boolean; iEditor : TCustomEdit);
begin
if tHow then
 begin
 with iEditor do
  If Length(SelText)>0 then
  begin
        Edit_Cut.Enabled:=true;
        Popup_Cut.Enabled:=true;
        Popup_Copy.Enabled:=true;
   Tool_Edit_Cut.Enabled:=true;
        Edit_Copy.Enabled:=true;
   Tool_Edit_Copy.Enabled:=true;
  end
   else
   begin
        Popup_Cut.Enabled:=false;
        Popup_Copy.Enabled:=false;
        Edit_Cut.Enabled:=False;
   Tool_Edit_Cut.Enabled:=False;
        Edit_Copy.Enabled:=False;
   Tool_Edit_Copy.Enabled:=False;
  end;

  Tool_Edit_Undo.Enabled    := iEditor.CanUndo;
  Edit_Undo     .Enabled    := iEditor.CanUndo;
  Popup_Undo.Enabled        := iEditor.CanUndo;

  Edit_SelectAll.Enabled  := iEditor.Text <> '';
  Edit_Clear.Enabled      := Edit_SelectAll.Enabled;
  Popup_SelectAll.Enabled := Edit_SelectAll.Enabled;
  Popup_Clear.Enabled     := Edit_Clear.Enabled;

  if  Clipboard.HasFormat(CF_TEXT) and (iEditor.Enabled) then
  begin
   Edit_Paste.Enabled:=true;
   Tool_Edit_Paste.Enabled:=true;
   Popup_Paste.Enabled:=true;
  end;
 end else
  begin

         Edit_SelectAll.Enabled :=False;
         Edit_Clear.Enabled :=False;

         Popup_SelectAll.Enabled :=False;
         Popup_Clear.Enabled :=False;

         Edit_Cut.Enabled :=False;
    Tool_Edit_Cut.Enabled :=False;
        Edit_Copy.Enabled :=False;
   Tool_Edit_Copy.Enabled :=False;
   Tool_Edit_Undo.Enabled :=False;
        Edit_Undo.Enabled :=False;
       Edit_Paste.Enabled :=False;
  Tool_Edit_Paste.Enabled :=False;

       Popup_Cut.Enabled:= false;
       Popup_Copy.Enabled:=false;
       Popup_Paste.Enabled:=false;
       Popup_Undo.Enabled:=false;
  end;
end;


procedure TMainEdukaForm.ifaceActivateFileControls(tHow : Boolean);
begin
 Tool_Program_Check.Enabled  := (tHow);
 Program_CheckSyntax.Enabled := (tHow);

 Tool_Program_Run.Enabled   := tHow;
 Tool_Program_Step.Enabled   := tHow;

 if ExecutionStarted then Tool_Program_Stop.Enabled:= tHow else
      Tool_Program_Stop.Enabled  := False;

 Tool_File_Save.Enabled     := tHow;
 File_SaveAs.Enabled        := tHow;
 File_Save.Enabled          := tHow;

 begin
  _Edit.Enabled             := tHow;
  _Utils.Enabled            := True;
 end;

  _Commands.Enabled         := tHow;
  _Program.Enabled          := tHow;
  _Window.Enabled           := tHow;
  Tool_Window_Reset.Enabled         := (tHow);
  Tool_Window_Save.Enabled          := (tHow);
  Tool_Window_Clear.Enabled         := (tHow);

  Editor.Enabled            := tHow;
  Tool_File_Close.Enabled      := tHow;
  File_Close.Enabled        := tHow;

  File_Print.Enabled        := tHow;
  File_ExportHTML.Enabled    := tHow;

  if tHow then ifaceDisableGridByMove()
   else
   begin
    Set_Grid_15.Enabled:= tHow;
    Set_Grid_20.Enabled:= tHow;
    Set_Grid_24.Enabled:= tHow;
    Set_Grid_36.Enabled:= tHow;
    Set_Grid_45.Enabled:= tHow;
   end;

  if tHow then Editor.Color:=EditorActiveColor
    else Editor.Color:=EditorDisabledColor;

  ifaceActivateEditControls(tHow);
end;

procedure TMainEdukaForm.ifaceActivateControls(tHow : Boolean);
begin

 if tHow then
    Editor.Color := EditorActiveColor else
    Editor.Color := EditorDisabledColor;

 Editor.Enabled  := tHow;
 Tool_Window_Reset.Enabled := tHow;

 if not tHow then
    begin
     Pre1 := Tool_Exercise_Next.Enabled;
     Pre2 := Tool_Exercise_Prev.Enabled;

     Tool_Exercise_Next.Enabled := false;
     Tool_Exercise_Prev.Enabled := false;

    end else
    begin
     Tool_Exercise_Next.Enabled := Pre1;
     Tool_Exercise_Prev.Enabled := Pre2;
    end;


 _Edit.Enabled     := tHow;
 _Window.Enabled   := tHow;
 _Help.Enabled     := tHow;
 _Commands.Enabled := tHow;

 if not InLaunchedTestMode then
  begin
   Options_SelectLanguage.Enabled    := tHow;
   Options_SelectInterpreter.Enabled := tHow;

   File_New.Enabled        := tHow;
   File_Open.Enabled       := tHow;
   File_SaveAs.Enabled     := tHow;
   File_Save.Enabled       := tHow;
   File_ExportHTML.Enabled := tHow;
   File_Print.Enabled      := tHow;
   File_R1.Enabled         := tHow;
   File_R2.Enabled         := tHow;
   File_R3.Enabled         := tHow;
   File_R4.Enabled         := tHow;

   Tool_File_New.Enabled   := tHow;
   Tool_File_Open.Enabled  := tHow;
   Tool_File_Save.Enabled  := tHow;

 end;
   File_Close.Enabled:= tHow;

 Program_CheckSyntax.Enabled := tHow;

 if StartedInStepMode then
  begin
   Program_Run.Enabled         := StartedInStepMode;
   Program_Step.Enabled        := StartedInStepMode;
   Tool_Program_Run.Enabled    := StartedInStepMode;
   Tool_Program_Step.Enabled   := StartedInStepMode;
   Options_Highlight.Enabled   := False;
  end else
  begin
   Program_Run.Enabled         := tHow;
   Program_Step.Enabled        := tHow;
   Tool_Program_Run.Enabled    := tHow;
   Tool_Program_Step.Enabled   := tHow;
   Options_Highlight.Enabled   := True;   
  end;

 Tool_Edit_Undo.Enabled:= tHow;
 Tool_Edit_Cut.Enabled:= tHow;
 Tool_Edit_Copy.Enabled:= tHow;
 Tool_Edit_Paste.Enabled:= tHow;

 Tool_Program_Check.Enabled:= tHow;

 Tool_Extend_Edit.Enabled:= tHow;

 if not InLaunchedTestMode then
  begin
   Tool_Window_Save.Enabled          := tHow;
   Tool_Window_Clear.Enabled         := tHow;
   Set_Grid_15.Enabled:= tHow;
   Set_Grid_20.Enabled:= tHow;
   Set_Grid_24.Enabled:= tHow;
   Set_Grid_36.Enabled:= tHow;
   Set_Grid_45.Enabled:= tHow;
   _Utils.Enabled     := tHow;
  end;

 ac_Panel_Kng.Enabled:= tHow;
 ac_Panel_Ant.Enabled:= tHow;
 ac_Panel_Tux.Enabled:= tHow;

 Tool_File_Close.Enabled:= tHow;

 Tool_Exercise_Show .Enabled := tHow;
 Tool_Exercise_Cond1.Enabled := tHow;
 Tool_Exercise_Cond2.Enabled := tHow;

 Program_Stop_Point.Enabled  := tHow;

end;

procedure TMainEdukaForm.ExecutionThreadDied;
var
 NoDiff     : Boolean;
begin
 Program_Stop.Enabled:=false;
 StartedInStepMode := False;
 Tool_Program_Stop.Enabled:=false;

 ifaceActivateControls(True);
 ifaceActivateEditControls(True);
 ifaceDisableGridByMove();
 Editor.SelStart := Editor.SelEnd;
 pntRedrawWholeTable();

 if InternalStop then File_ExitClick(nil);

 if (SelLine<>-1) and (not RuntimeCycle) then
  begin
   edtPositionateCursor(Editor,SelStart,SelLine);
     Editor.SelEnd:=Editor.SelStart+SelLen;
   SelLen:=0;
   ActiveControl:=Editor;
  end else
     if (SelStart=0) or (RuntimeCycle) then
      begin
       ActiveControl:=Editor;
        ifaceErrorAdjust(True);

       if InLaunchedTestMode then
       begin
        NoDiff := pntCompareGrids( t, SelectedFileList [ CurrentExerciseNr ].Info1.OutGrid);
        if (u <> SelectedFileList [ CurrentExerciseNr ].Info1.OutPositionalX) or
           (v <> SelectedFileList [ CurrentExerciseNr ].Info1.OutPositionalY) then NoDiff := False;

         if NoDiff then PlaySoundEvent ( sndSuccess );
         SelectedFileList [ CurrentExerciseNr ].WasSuccess := SelectedFileList [ CurrentExerciseNr ].WasSuccess or NoDiff;
         SelectedFileList [ CurrentExerciseNr ].NowSuccess := NoDiff;
         ifaceMoveExerciseToEditor(-2);
       end;

      end;
     
end;


procedure TMainEdukaForm.CheckFileSave;
 var
    SaveResp: Integer;
begin

 if (Editor.Modified) or (((ExerciseEditorFile) or ((TestEditorFile) and (iSelectedFileList > 0))) and (TpModified)) then
 begin
  Dialog_Check_Save.SetMessageIcon( 1 );
  Dialog_Check_Save.Text_Q.Clear;
    if (InLaunchedTestMode) then
      Dialog_Check_Save.Text_Q.Lines.Add(DLG_ETQ) else
      Dialog_Check_Save.Text_Q.Lines.Add(DLG_SVQ+' '+MinimizeName(sFileName, Canvas,  Dialog_Check_Save.Text_Q.Width*2-20)+'?');

  ImageList.GetBitmap( Help_Q.ImageIndex       , Dialog_Check_Save.Help_Q.Bitmap);

  SaveResp:=Dialog_Check_Save.ShowModal;
  case SaveResp of
    mrYes    : File_SaveClick(Self);
    mrNo     : {Nothing};
    mrCancel : Abort;
  end;
 end;
end;


procedure TMainEdukaForm.File_ExitClick(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );

 try
  CheckFileSave;
 except
  on EAbort do Exit;
 end;
 
 Application.Terminate;
end;


procedure TMainEdukaForm.PaintBoxPaint(Sender: TObject);
begin
 pntRedrawTable;
end;


procedure TMainEdukaForm.File_OpenClick(Sender: TObject);
Var
 Bll      : Boolean;
 cXP, dXP : Integer;
begin
 InCriticalStage := True;
 if Sender <> nil then PlaySoundEvent( sndJustTick );
 SoundStatus(False);

 try
  CheckFileSave;
 except
  on EAbort do Exit;
 end;

   OpenDialog.Title := Open_Title;

{$WARNINGS OFF}
  if (ExerciseEditorMode) and (DirectoryExists(PChar(MyDocuments)+'\'+MyExercises))
    then OpenDialog.InitialDir:= PChar(MyDocuments)+'\'+MyExercises else

  if (TestEditorMode) and (DirectoryExists(PChar(MyDocuments)+'\'+MyTests))
    then OpenDialog.InitialDir:= PChar(MyDocuments)+'\'+MyTests else

  if DirectoryExists(PChar(MyDocuments)+'\'+MySources)
    then OpenDialog.InitialDir:= PChar(MyDocuments)+'\'+MySources else
      begin
       OpenDialog.InitialDir:= PChar(MyDocuments);
      end;
{$WARNINGS ON}

if Sender<>nil then
 begin
  OpenDialog.FileName := '';
  Bll:=OpenDialog.Execute;
 end else Bll:=true;

if (ExerciseEditorMode) and (Bll) then
 begin
   _Handle:=Handle;

   pntInitializeValues(True, True);
   ifaceSetFormCaption(CurrentInterpreterName,ExtractFileName(OpenDialog.FileName));
   sFileName := OpenDialog.FileName;

   ReadInterpreter := CurrentInterpreter;
  
   if not flsEditorOpenFromFile(True, _c_Duration, _c_Skill, _c_Author,  Editor,sFileName) then

   ifaceExerciseEditorControls(True);

   if ReadInterpreter <> CurrentInterpreter then
       begin
         Dialog_Select_Interpreter.Speed_Kng.Down := False;
         Dialog_Select_Interpreter.Speed_ant.Down := False;
         Dialog_Select_Interpreter.Speed_tux.Down := False;

        case ReadInterpreter of
         piAnt : Dialog_Select_Interpreter.Speed_ant.Down := True;
         piKng : Dialog_Select_Interpreter.Speed_Kng.Down := True;
         piTux : Dialog_Select_Interpreter.Speed_tux.Down := True;
        end;
         SendMessage(Handle, WM_SelectInterpreterClose, 0, 0);
       end;


   AddRecentFile(sFileName);

   _c_Grid_1.OnClick(Nil);

   ifaceExerciseEditorControls(True);

   _c_Language.OnChange(nil);

   TpModified := False;
   StatusBar.Panels.Items[1].Text:='';

   Tool_File_Close.Enabled := True;
   Tool_File_Save.Enabled  := True;
   File_Close.Enabled      := True;
   File_Save.Enabled       := True;
   File_SaveAs.Enabled     := True;
   ifaceDisableGridByMove();
   GridWasSaved := True;

   SoundStatus(True);

   InCriticalStage := False;
   Exit;
 end;

if (TestEditorMode) and (Bll) then
 begin
   for cXP := 0 to nExercises do
    for dXP := 0 to nLangs do
     begin
       SelectedFileList[cXP].Info2[dXP].Title := '';
       SelectedFileList[cXP].Info2[dXP].Descr := '';
       SelectedFileList[cXP].Info2[dXP].Rests := '';

       if dXP <= _d_Language.Items.Count - 1 then
           SelectedFileList[cXP].Info2[dXP].Lng := PShortString(_d_Language.ItemsEx.Items[dXP].Data)^;

     end;

   _Handle:=Handle;

   pntInitializeValues(True, True);

   ifaceSetFormCaption(CurrentInterpreterName,ExtractFileName(OpenDialog.FileName));
   sFileName := OpenDialog.FileName;

    pntClearGrid( otExerciseG1 );
    pntClearGrid( otTemp );

   flsEditorOpenFromFile(True, _c_Duration, _c_Skill, _c_Author,  Editor,sFileName);
   ifaceTestEditorControls(True, False);


   AddRecentFile(sFileName);
   _d_Language.OnChange(nil);

   TpModified := False;
   StatusBar.Panels.Items[1].Text:='';

   Tool_File_Close.Enabled := True;
   Tool_File_Save.Enabled  := True;
   File_Close.Enabled      := True;
   File_Save.Enabled       := True;
   File_SaveAs.Enabled     := True;


   _c_SelectedFiles.Clear;

   for cXP := 0 to iSelectedFileList - 1  do
       _c_SelectedFiles.Items.Add(ExtractFileName(SelectedFileList[ cXP ].FileName));// +

   ifaceAdjustTestListControls();
   GridWasSaved := True;

   SoundStatus(True);
   InCriticalStage := False;
   Exit;
 end;


if Bll then
  begin
   _Handle:=Handle;

  // pntInitializeValues(True);

   pntHideInterpreterImages(piAnt);
   t[1,1].Pres:=false;

  ifaceSetFormCaption(CurrentInterpreterName,ExtractFileName(OpenDialog.FileName));

   sFileName := OpenDialog.FileName;
   Editor.Visible:=False;
   ErrorEdit.Visible:=false;

   pntClearGrid( otExerciseG1 );

   flsEditorOpenFromFile(True, _c_Duration, _c_Skill, _c_Author,  Editor,sFileName);

   ErrorEdit.Visible:=True;
   Editor.Visible:=true;
   Editor.Modified:=false;
   Editor.OnChange(Editor);
   AddRecentFile(sFileName);

   pntSwapPrimaryGrid ( True, otExerciseG1 );
   GridWasSaved := True;
   ifaceActivateFileControls(True);

   SoundStatus(True);
  end;
end;

procedure TMainEdukaForm.File_SaveClick(Sender: TObject);
begin
 InCriticalStage := True;

 PlaySoundEvent( sndJustTick );
 SoundStatus(False);

  if ExerciseEditorMode then
  begin
   _c_LanguageChange(_c_Language);
   if _c_Grid_1.Checked then pntSwapPrimaryGrid ( False, otExerciseG1 ) else
                             pntSwapPrimaryGrid ( False, otExerciseG2 );
  end;

  if (sFileName = 'Untitled') then File_SaveAsClick(Sender)
   else
     begin
      if InLaunchedTestMode then pxtExportTestPage(sFileName) else
          flsEditorSaveToFile(_c_Duration, _c_Skill, _c_Author,  Editor,sFileName);

      if (not ExerciseEditorFile) and (not TestEditorFile) then
       begin
        Editor.Modified:=False;
        Editor.OnChange(Editor);
       end else
       begin
        TpModified := False;
        StatusBar.Panels.Items[1].Text:='';
       end;
      if not InLaunchedTestMode then AddRecentFile(sFileName);
     end;

  SoundStatus(True);
end;

procedure TMainEdukaForm.File_SaveAsClick(Sender: TObject);
var
 pEXT : String;
begin
 PlaySoundEvent( sndJustTick );
 SoundStatus(False);

  SaveDialog.Title := Save_Title;

{$WARNINGS OFF}
  if (ExerciseEditorMode) and (DirectoryExists(PChar(MyDocuments)+'\'+MyExercises))
    then SaveDialog.InitialDir:= PChar(MyDocuments)+'\'+MyExercises else
  if (TestEditorMode) and (DirectoryExists(PChar(MyDocuments)+'\'+MyTests))
    then SaveDialog.InitialDir:= PChar(MyDocuments)+'\'+MyTests else
  if DirectoryExists(PChar(MyDocuments)+'\'+MySources)
    then SaveDialog.InitialDir:= PChar(MyDocuments)+'\'+MySources else
      begin
       SaveDialog.InitialDir:= PChar(MyDocuments);
      end;
{$WARNINGS ON}

  if ExerciseEditorMode then
  begin
   _c_LanguageChange(_c_Language);
   if _c_Grid_1.Checked then pntSwapPrimaryGrid ( False, otExerciseG1 ) else
                             pntSwapPrimaryGrid ( False, otExerciseG2 );
  end else
  begin
   if not GridWasSaved then pntSwapPrimaryGrid( False, otExerciseG1 );
   GridWasSaved := True;
  end;
  
    SaveDialog.FileName := '';
 if SaveDialog.Execute then
  begin
      sFileName:=SaveDialog.FileName;

      if ExerciseEditorMode then pEXT := extFileExercise else
      if TestEditorMode then pEXT := extFileTest else
      case CurrentInterpreter of
         piAnt : pEXT := extFileAnt;
         piTux : pEXT := extFileTux;
         piKng : pEXT := extFileKng;
      end;

      if (ExtractFileExt( sFileName ) = '') then
           sFileName := sFileName + pEXT;

      ifaceSetFormCaption(CurrentInterpreterName,ExtractFileName(sFileName));

      flsEditorSaveToFile(_c_Duration, _c_Skill, _c_Author,  Editor, sFileName);

      if (not ExerciseEditorFile) and (not TestEditorFile) then
       begin
        Editor.Modified:=False;
        Editor.OnChange(Editor);
       end else
       begin
        TpModified := False;
        StatusBar.Panels.Items[1].Text:='';
       end;

      AddRecentFile(sFileName);
  end;
  SoundStatus(True);
end;

procedure TMainEdukaForm.File_NewClick(Sender: TObject);
var
 i : Integer;
begin
 PlaySoundEvent( sndJustTick );
 SoundStatus(False);

 if ExerciseEditorMode then
  begin

   ifaceExerciseEditorControls(True);

 try
  CheckFileSave;
 except
  on EAbort do Exit;
 end;

   pntInitializeValues(True, True);

  if ExerciseEditorMode then
  begin
  PrevLang := 0;
  _c_Language.ItemIndex := 0;
   _c_LanguageChange(_c_Language);
   if _c_Grid_1.Checked then pntSwapPrimaryGrid ( False, otExerciseG1 ) else
                             pntSwapPrimaryGrid ( False, otExerciseG2 );
  end;

   pntSwapPrimaryGrid ( False, otExerciseG1 );
   pntSwapPrimaryGrid ( False, otExerciseG2 );

    TpModified:=False;
    StatusBar.Panels.Items[1].Text:='';

    for i:=0 to nLangs do begin PLangs[i].Title:='';PLangs[i].Descr:='';PLangs[i].Rests:='';end;

   _c_Duration.ItemIndex := 0;
   _c_Skill.ItemIndex    := 0;
   _c_Title.Text := '';
   _c_Description.Lines.Clear;
   _c_Restrictions.Lines.Clear;

   _c_Grid_1.Checked:=true;
   _c_Grid_2.Checked:=false;

   // --
   _c_Language.ItemIndex := 0;
   
   for i := 0 to _c_Language.ItemsEx.Count - 1 do
    if PShortString(_c_Language.ItemsEx.Items[i].Data)^ = CurrentLanguageCode then
       _c_Language.ItemIndex := i;


   Tool_File_Close.Enabled := True;
   Tool_File_Save.Enabled  := True;
   File_Close.Enabled      := True;
   File_Save.Enabled       := True;
   File_SaveAs.Enabled     := True;

   sFileName:='Untitled';
   ifaceSetFormCaption(CurrentInterpreterName,sFileName);

   ActiveControl := _c_Author;
   ifaceActivateExerciseMemoEditControls(True, _c_Author);
   ifaceDisableGridByMove();

   SoundStatus(True);
   InCriticalStage := False;
   Exit;
  end;

 if TestEditorMode then
  begin

   ifaceTestEditorControls(True, true);
   
 try
  CheckFileSave;
 except
  on EAbort do Exit;
 end;

   pntInitializeValues(True, True);
   GridWasSaved := False;
    TpModified:=False;
    StatusBar.Panels.Items[1].Text:='';

    for i:=0 to nLangs do begin PLangs[i].Title:='';PLangs[i].Descr:='';PLangs[i].Rests:='';end;

   _c_Duration_I.ItemIndex    := 0;
   _c_Skill_I.ItemIndex       := 0;
   _c_Interpreter_I.ItemIndex := 0;
   _d_Language.ItemIndex      := 0;

   for i := 0 to _d_Language.ItemsEx.Count - 1 do
    if PShortString(_d_Language.ItemsEx.Items[i].Data)^ = CurrentLanguageCode then
       _d_Language.ItemIndex := i;

   _d_Title.Text := '';
   _d_Description.Lines.Clear;
   _d_Restrictions.Lines.Clear;
   _d_Duration.Text:='';
   _d_Skill.Text:='';
   _d_Interpreter.Text:='';
   _d_Author.Text:='';


   Tool_File_Close.Enabled := True;
   Tool_File_Save.Enabled  := True;
   File_Close.Enabled      := True;
   File_Save.Enabled       := True;
   File_SaveAs.Enabled     := True;

   sFileName:='Untitled';
   ifaceSetFormCaption(CurrentInterpreterName,sFileName);

   ifaceAdjustTestListControls();

   SoundStatus(True);
   InCriticalStage := False;   
   Exit;
  end;

 try
  CheckFileSave;
 except
  on EAbort do Exit;
 end;
 
 GridWasSaved := False;

 pntInitializeValues(True, true);
 pntClearGrid( otExerciseG1 );
 pntClearGrid( otTemp );

 ifaceActivateFileControls(True);

 sFileName:='Untitled';
 ifaceSetFormCaption(CurrentInterpreterName,sFileName);

    Editor.Modified:=False;
    Editor.OnChange(Editor);
    Editor.ClearAll;
    Editor.SetFocus;

 Editor.Modified:=False;
 ifaceDisableGridByMove();
 pntInitializeValues(True, true);
 pntRedrawWholeTable();

 SoundStatus(True);
end;

procedure TMainEdukaForm.File_CloseClick(Sender: TObject);
var
 i : integer;

begin
 InCriticalStage := True;
 PlaySoundEvent( sndJustTick );

 if (InLaunchedTestMode) then
  begin
   ifaceMoveExerciseToEditor(CurrentExerciseNr);

 try
  CheckFileSave;
 except
  on EAbort do Exit;
 end;

   GridWasSaved := False;

   Editor.Lines.Clear;
   Editor.Modified:=False;
   Editor.OnChange(Editor);

   pntInitializeValues(True, true);
   pntRedrawWholeTable();

   if Exercise_Exercise.Visible then Tool_Exercise_Show.OnClick(Tool_Exercise_Show);

   ifaceLaunchedTestControls(False, True);
   ifaceActivateFileControls(False);
   ifaceErrorAdjust(True);

   SendToCharEdit(#27);
   ifaceSetFormCaption(CurrentInterpreterName,'');
   sFileName:='';
   InLaunchedTestMode := False;
  end;

 if TestEditorMode then
  begin
   if Sender <> nil then
               begin

                 try
                  CheckFileSave;
                 except
                  on EAbort do Exit;
                 end;

               end;

    GridWasSaved := False;

    for i:=0 to nLangs do begin PLangs[i].Title:='';PLangs[i].Descr:='';PLangs[i].Rests:='';end;


   _c_Duration_I.ItemIndex    := 0;
   _c_Skill_I.ItemIndex       := 0;
   _c_Interpreter_I.ItemIndex := 0;
   _d_Language.ItemIndex      := 0;

   for i := 0 to _d_Language.ItemsEx.Count - 1 do
    if PShortString(_d_Language.ItemsEx.Items[i].Data)^ = CurrentLanguageCode then
       _d_Language.ItemIndex := i;

   _d_Title.Text := '';
   _d_Description.Lines.Clear;
   _d_Restrictions.Lines.Clear;
   _d_Duration.Text:='';
   _d_Skill.Text:='';
   _d_Interpreter.Text:='';
   _d_Author.Text:='';


   Tool_File_Close.Enabled := False;
   Tool_File_Save.Enabled  := False;
   File_Close.Enabled      := False;
   File_Save.Enabled       := False;
   File_SaveAs.Enabled     := False;


    ifaceSetFormCaption(CurrentInterpreterName,'');
    sFileName:='';

   ifaceActivateExerciseMemoEditControls(False, nil);
   ifaceTestEditorControls(False, True);

   TpModified := False;
   StatusBar.Panels.Items[1].Text:='';
   
   InCriticalStage := False;
   Exit;
  end;

 if ExerciseEditorMode then
  begin

   try
    CheckFileSave;
   except
    on EAbort do Exit;
   end;

   GridWasSaved := False;

    for i:=0 to nLangs do begin PLangs[i].Title:='';PLangs[i].Descr:='';PLangs[i].Rests:='';end;

   _c_Duration.ItemIndex := 0;
   _c_Skill.ItemIndex    := 0;
   _c_Title.Text := '';
   _c_Description.Lines.Clear;
   _c_Restrictions.Lines.Clear;
   _c_Author.Text := '';
   _c_Grid_1.Checked:=true;
   _c_Grid_2.Checked:=false;

   pntInitializeValues(True, true);
   pntRedrawWholeTable();

   pntSwapPrimaryGrid ( False, otExerciseG1 );
   pntSwapPrimaryGrid ( False, otExerciseG2 );

    SendToCharEdit(#27);
    ifaceSetFormCaption(CurrentInterpreterName,'');
    sFileName:='';

   Tool_File_Close.Enabled := False;
   Tool_File_Save.Enabled  := False;
   File_Close.Enabled      := False;
   File_Save.Enabled       := False;
   File_SaveAs.Enabled     := False;
   
   ifaceExerciseEditorControls(False);

   TpModified := False;
   StatusBar.Panels.Items[1].Text:='';
   
   InCriticalStage := False;
   Exit;
  end;

 try
  CheckFileSave;
 except
  on EAbort do Exit;
 end;

 StatusBar.Panels[4].Text := '';

 Editor.Lines.Clear;
 Editor.Modified:=False;


   pntInitializeValues(True, true);
 pntRedrawWholeTable();

   ifaceActivateFileControls(False);
  ifaceErrorAdjust(True);

 SendToCharEdit(#27);
 ifaceSetFormCaption(CurrentInterpreterName,'');
 sFileName:='';
 Editor.OnChange(Editor);
 
 InCriticalStage := False;
end;

procedure TMainEdukaForm.Options_SelectInterpreterClick(Sender: TObject);
begin
 File_Close.Click;

  ImageList.GetBitmap( Help_Q.ImageIndex       , Dialog_Select_Interpreter.Help_Q.Bitmap);

 Dialog_Select_Interpreter.PHandle:=Handle;
 Dialog_Select_Interpreter.Show;
end;

procedure TMainEdukaForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

 try
  CheckFileSave;
 except
  on EAbort do Exit;
 end;

end;

procedure TMainEdukaForm.Options_SelectLanguageClick(Sender: TObject);
begin
 ImageList.GetBitmap( Help_Q.ImageIndex       , Dialog_Select_Language.Help_Q.Bitmap);

 if Editor.Enabled then
     flsEditorSaveToFile(_c_Duration, _c_Skill, _c_Author, Editor,ExtractFilePath(ParamStr(0))+TmpFileName);

 Dialog_Select_Language.PHandle:=Handle;
 Dialog_Select_Language.Show;

end;

procedure TMainEdukaForm.FormCreate(Sender: TObject);
var
 TempStr : String;
 p       : PItemIDList;
 Fck, Ix : Integer;
begin


//------------------------------------------------------
 SaveTimer.Interval := 60000;
 
 Error_Panel_Image.HelpKeyword := hlp_Errors;
 Error_Panel.HelpKeyword       := hlp_Errors;

 pFileName         := '';
 pInterpreter      := 0;
{$WARNINGS OFF}
 MyDocuments := StrAlloc(128);
 p:=nil;
   SHGetSpecialFolderLocation(GW_OWNER, PersonalFolder, p);

   SHGetPathFromIDList(p, MyDocuments);
{$WARNINGS ON}
   InCriticalStage := False;
//------------------------------------------------------
 Editor.BookMarkOptions.BookmarkImages := Image_Steps;
 GridPixelSize := atoi(LoadOption('GridSize',VKey,IntToStr(Grid_24),RKEY));

 if (GridPixelSize <> grid_15) and
    (GridPixelSize <> grid_20) and
    (GridPixelSize <> grid_24) and
    (GridPixelSize <> grid_36) and
    (GridPixelSize <> grid_45) then GridPixelSize := Grid_24;

   AnimalReset := True;
  // Initialize all units that need this kind of stuff
  ifaceSetupExternalImages();
  pntInitializeGraphics( Kng_im_Left, Kng_im_Right, Kng_im_Up, Kng_im_Down,
   ant_im_Left, ant_im_Right, ant_im_Up, ant_im_Down,
   tux_im_Left, tux_im_Right, tux_im_Up, tux_im_Down,
    PaintBox, MainEdukaForm);

   pntClearGrid( otExerciseG1 );
   pntClearGrid( otTemp );

 ExerciseEditorMode := False;
 TestEditorMode := False;
 PleaseKeepGrid  := False;
 
 stxInitializeErrorsUnit(ImageList, Error_Panel, Error_Panel_Image, ErrorEdit,Editor, Msg_Label, Handle);

 Track_Speed.Position := atoi(LoadOption('SpeedValue',VKey,'5',RKEY));
 MainDisableSound     := (LoadOption('SoundStatus',VKey,'1',RKEY) = '1');

 if MainDisableSound then
    Options_Sound.Checked := False;


 MySources    :=  LoadOption('DocPathMySources'   ,VKEY,'My ' + ProgramID + ' Files\Sources' ,RKEY);
 MyExercises      :=  LoadOption('DocPathMyExercises'     ,VKEY,'My ' + ProgramID + ' Files\Exercises' ,RKEY);
 MyExercisesHtml  :=  LoadOption('DocPathMyExercisesHtml' ,VKEY,'My ' + ProgramID + ' Files\Exercises\Html' ,RKEY);
 MyTests      :=  LoadOption('DocPathMyTests'     ,VKEY,'My ' + ProgramID + ' Files\Tests' ,RKEY);
 MyTestsHtml  :=  LoadOption('DocPathMyTestsHtml' ,VKEY,'My ' + ProgramID + ' Files\Tests\Hrml' ,RKEY);

 if not AdministrativeStart then
  begin

 if not ExtendedPackage then
    begin
     _PackageManager.Visible := false;
     DskShortcuts.Visible    := false;
     N20.Visible             := false;
    end;

 if not ExtendedDynamic then
    begin
      Options_SelectLanguage.Visible := false;
      Options_SelectInterpreter.Visible := false;
      N22.Visible := false;
    end;

 if not ExtendedDebug then
    begin
      Options_Highlight.Visible := false;
      Program_Step.Visible      := false;
      Program_Stop_Point.Visible:= false;
      Editor.OnGutterClick      := nil;
      if not N22.Visible then _Options.Visible := false;
      Tool_Program_Step.Visible := false;
      N22.Visible := false;
    end;

 if not ExtendedAcademic then
    begin
      _EditExercise.Visible := false;
      _EditTest.Visible      := false;

      if not N20.Visible then _Utils.Visible := false;

      N20.Visible := false;
    end;
   end;


 ConsiderNextClick := false;
 PrevHeight:=Editor.Height;
 ImgPrevPos := Editor.Left +  Editor.Width - ( Error_Panel.Left + Error_Panel.Width );

 wait:=(Track_Speed.Max-Track_Speed.Position)*20;
 Static_Speed_Value.Caption:=intToStr(abs(wait-Track_Speed.Max*20)+20);

 Static_Speed_Value.Font.Color:=RGB(Track_Speed.Max*10 - (wait div 2),0,0);

 CurrentInterpreter := TProInterpreter(atoi(LoadOption('CurrentInterpreter',VKey,IntToStr(Ord(piAnt)),RKEY)));

 if (CurrentInterpreter<>piAnt) and (CurrentInterpreter<>piKng)
                                and (CurrentInterpreter<>piTux) then
     CurrentInterpreter:=piAnt;

{$IFNDEF _TRIAL_}
 StepByStepHighlighting    := Options_Highlight.Checked;
 CurrentLanguageFileName   := LoadOption('CurrentLanguage',VKey,'',RKEY);
 if not FileExists(CurrentLanguageFileName) then CurrentLanguageFileName:='';
{$ELSE}
 CurrentLanguageFileName :='';
{$ENDIF}


  // Load default language first (english)
 TempStr:=CurrentLanguageFileName;
 lngLoadSelectedLanguage('',Self);
 lngLoadSelectedLanguage(TempStr,Self);

 ifaceSetupPanelButtons(nil);
 ifaceActivateFileControls(false);
 PrevSize:=Editor.Width+ac_Panel_Kng.Width;

  StatusBar.Panels.Items[3].Text := CurrentLanguage + ' (' + CurrentLanguageCode + ')';
  if CurrentHelpFile<>'' then  StatusBar.Panels.Items[3].Text:=StatusBar.Panels.Items[3].Text+' ['+CurrentHelpFile+']';
  if CurrentHelpFile = '' then  Help_Topics.Enabled := False;
  LoadRecentFiles(CurrentInterpreter);

  SynExportHTML := TSynEdukaExporterHTML.Create(Self);
  
  _Commands.Visible := Extend_Edit.Checked;
  
 flsSetDialogsFilter(SaveDialog,OpenDialog,CurrentInterpreter);

 case pntGridPixelate(GridPixelSize) of
  24 : begin ifaceGridSizes(set_Grid_15); GridPixelSize:=15;end;
  18 : begin ifaceGridSizes(set_Grid_20); GridPixelSize:=20;end;
  15 : begin ifaceGridSizes(set_Grid_24); GridPixelSize:=24;end;
  10 : begin ifaceGridSizes(set_Grid_36); GridPixelSize:=36;end;
   8 : begin ifaceGridSizes(set_Grid_45); GridPixelSize:=45;end;
 end;

   pntInitializeValues(True, true);

 Pocket_Letter.Color      :=  ptPocketColor;
 Pocket_Letter.Font.Color :=  ptPocketFontColor;
 Pocket_Letter.Font.Size  :=  ptPocketFontSize;
 Pocket_Letter.Font.Style :=  ptPocketFontStyles;
 Pocket_Text.Font.Color   :=  ptTextFontColor;

 Msg_Label.Color          :=  ptMsgSgColor;
 Msg_Label.Font.Size      :=  ptMsgSgFontSize;
 Msg_Label.Font.Style     :=  ptMsgSgFontStyles;
 Msg_Label.Font.Color     :=  ptMsgSgFontColor;


 // ----
  Color:=FormColor;
  Font.Charset:=FormCharset;
  Font.Color:=FormFontColor;
  Font.Size:=FormFontSize;
  Font.Name:=MainUsedFont;
  Font.Style:=FormFontStyles;


    ac_Panel_Kng.Color:=PanelColor;
    ac_Panel_Ant.Color:=PanelColor;
    ac_Panel_Tux.Color:=PanelColor;

    PaintBox.Color:=PaintBoxColor;
    StatusBar.Color:=StatusBarColor;
    Panel_Bottom.Color:=PanelColor;
    Main_ToolBar.Color:=ToolBarColor;
    Edit_Char.Color:=EditCharColor;

    Static_Speed.Color:=StaticSpeedColor;
    Static_Speed.Font.Name:=MainUsedFont;
    Static_Speed_Value.Color:=StaticSpeedColor;
    Static_Speed_Value.Font.Name:=MainUsedFont;
    StatusBar.Font.Name:=MainUsedFont;

    SetupXSyntax;

  case CurrentInterpreter of
   piKng : begin StatusBar.Panels.Items[2].Text:=Dialog_I_Kng; CurrentInterpreterName:=Dialog_I_Kng;end;
   piAnt : begin StatusBar.Panels.Items[2].Text:=Dialog_I_Ant; CurrentInterpreterName:=Dialog_I_Ant;end;
   piTux : begin StatusBar.Panels.Items[2].Text:=Dialog_I_Tux; CurrentInterpreterName:=Dialog_I_Tux;end;
  end;

  ifaceSetFormCaption(CurrentInterpreterName,'');

 case CurrentInterpreter of
  piKng:
  begin
    ac_Panel_Kng.Visible:=True;
    ac_Panel_ant.Visible:=False;
    ac_Panel_tux.Visible:=False;
    Kng_Basic.Visible:=True;
    Kng_Advanced.Visible:=True;
    ant_Basic.Visible:=False;
    ant_Advanced.Visible:=False;
    tux_Basic.Visible:=False;
    tux_Advanced.Visible:=False;
    Kng_Condition.Visible:=True;
    Pocket_Text.Visible := False;
    Pocket_Letter.Visible := False;
  end;
  piAnt:
  begin
    CurrentInterpreter := piAnt;
    ac_Panel_Kng.Visible:=False;
    ac_Panel_ant.Visible:=True;
    ac_Panel_tux.Visible:=False;
    Kng_Basic.Visible:=False;
    Kng_Advanced.Visible:=False;
    ant_Basic.Visible:=True;
    ant_Advanced.Visible:=True;
    tux_Basic.Visible:=False;
    tux_Advanced.Visible:=False;
    ant_Condition.Visible:=True;
    Pocket_Text.Visible := False;
    Pocket_Letter.Visible := False;
  end;
 piTux:
  begin
    CurrentInterpreter := piTux;
    ac_Panel_Kng.Visible:=False;
    ac_Panel_ant.Visible:=False;
    ac_Panel_tux.Visible:=True;
    Kng_Basic.Visible:=False;
    Kng_Advanced.Visible:=False;
    ant_Basic.Visible:=False;
    ant_Advanced.Visible:=False;
    tux_Basic.Visible:=True;
    tux_Advanced.Visible:=True;
    Pocket_Text.Visible := True;
    Pocket_Letter.Visible := True;
  end;
 end;
    ifaceSetFormIcon(CurrentInterpreter);

 if LoadOption('ShowLineNr',VKey,'0',RKEY) = '1' then
     Edit_ShowLines.Click;

 for Fck := 0 to MaxStopPoints do
   BkList[Fck] := -1;

  if AdministrativeStart then
  begin
    AdminPanel.Visible  := true;
    AdminPanel.Align    := alClient;
    AdminPanel.BringToFront;

    for Ix := 0 to 10 do
     if Assigned(_File.Items[Ix]) then
       _File.Items[Ix].Visible := False;

    File_Exit      .Visible := True;
    Extend_Edit    .Visible := False;
    Edit_ShowLines .Visible := False;
    _Program       .Visible := False;
    _EditExercise  .Visible := False;
    _EditTest      .Visible := False;
    N20            .Visible := False;
    _Window        .Visible := False;
    _Edit          .Visible := False;
    Options_SelectInterpreter .Visible := False;
    Options_Sound             .Visible := False;
    N21.Visible := False;
    Options_Highlight.Visible := False;
    Self.Width              := AdmModeWidth;
    Self.Height             := AdmModeHeight;
    StatusBar.Visible       := False;

    mEnableDyno.Color        := MemoColor;
    mEnableDyno.Font.Charset := MemoCharset;
    mEnableDyno.Font.Color   := MemoFontColor;
    mEnableDyno.Font.Size    := MemoFontSize;
    mEnableDyno.Font.Name    := MainUsedFont;
    mEnableDyno.Font.Style   := MemoFontStyles;

    mEnableDebug.Color        := MemoColor;
    mEnableDebug.Font.Charset := MemoCharset;
    mEnableDebug.Font.Color   := MemoFontColor;
    mEnableDebug.Font.Size    := MemoFontSize;
    mEnableDebug.Font.Name    := MainUsedFont;
    mEnableDebug.Font.Style   := MemoFontStyles;

    mEnableTST.Color        := MemoColor;
    mEnableTST.Font.Charset := MemoCharset;
    mEnableTST.Font.Color   := MemoFontColor;
    mEnableTST.Font.Size    := MemoFontSize;
    mEnableTST.Font.Name    := MainUsedFont;
    mEnableTST.Font.Style   := MemoFontStyles;

    mEnableAdmOpts.Color        := MemoColor;
    mEnableAdmOpts.Font.Charset := MemoCharset;
    mEnableAdmOpts.Font.Color   := MemoFontColor;
    mEnableAdmOpts.Font.Size    := MemoFontSize;
    mEnableAdmOpts.Font.Name    := MainUsedFont;
    mEnableAdmOpts.Font.Style   := MemoFontStyles;

    ifaceSetFormIcon(CurrentInterpreter);

    cbEnableDyno.Checked    := ExtendedDynamic;
    cbEnableTst.Checked     := ExtendedAcademic;
    cbEnableDebug.Checked   := ExtendedDebug;
    cbEnableAdmOpts.Checked := ExtendedPackage;

  end else AdminPanel.Visible := False;


{$IFDEF _TRIAL_}
 File_ExportHTML    .Visible := False;
 File_Print         .Visible := False;
 Edit_ShowLines     .Visible := False;
 Program_Step       .Visible := False;
 Program_Stop_Point .Visible := False;
 N20                .Visible := False;

 Tool_Program_Step  .Visible := False;

{$ENDIF}

{$IFDEF _DEBUG_}
 DbgScreen.Visible:=true;
{$ENDIF}

 Top  := (Screen.WorkAreaHeight - Height) div 2;
 Left := (Screen.WorkAreaWidth - Width) div 2;
 
 OSExceptionHandler( Sender );
end;

procedure TMainEdukaForm.button_MouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
begin
   if not Editor.Enabled then Exit;
   ifaceSetupPanelButtons(Sender as TJvStaticText);
   diMakeStaticTextActive(sender as TJvStaticText);
end;

procedure TMainEdukaForm.button_MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if (InLaunchedTestMode) then Exit;
 if (not Editor.Enabled) and (not ExerciseEditorFile) then Exit;

 if Button=mbLeft then
 begin
  diMakeStaticTextPressed((Sender as TJvStaticText));
  BtnHasDown := Sender as TJvStaticText;
  BtnHasUsed :=False;
 end;
end;

procedure TMainEdukaForm.button_MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if (not Editor.Enabled) and (not ExerciseEditorFile) then Exit;

 diMakeStaticTextReleased((Sender as TJvStaticText));
 BtnHasDown:=nil;
end;

procedure TMainEdukaForm.DefaultPanelButtons(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
  var
   pnt : TPoint;
begin
  ifaceSetupPanelButtons(nil);

   pnt := PaintBox.ScreenToClient(Mouse.CursorPos);

   if (pnt.X<0) or (pnt.Y<0) or (pnt.X>PaintBox.Width)
       or (pnt.Y>PaintBox.Height) then   SendToCharEdit(#13);
end;

procedure TMainEdukaForm.Help_AboutClick(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
 AboutForm.Show;
end;

procedure TMainEdukaForm.Edit_CutClick(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
 if (ExerciseEditorMode) or (TestEditorMode)  then iEditor.CutToClipboard else
                                                Editor.CutToClipboard;
                                                
 ifaceActivateEditControls(True);
end;

procedure TMainEdukaForm.Edit_CopyClick(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
 if (ExerciseEditorMode) or (TestEditorMode)  then iEditor.CopyToClipboard else
                                                Editor.CopyToClipboard;
 ifaceActivateEditControls(True);
end;

procedure TMainEdukaForm.Edit_PasteClick(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
 if (ExerciseEditorMode) or (TestEditorMode)  then iEditor.PasteFromClipboard else
                                                Editor.PasteFromClipboard;
 ifaceActivateEditControls(True);
end;

procedure TMainEdukaForm.Edit_SelectAllClick(Sender: TObject);
begin
 if (ExerciseEditorMode) or (TestEditorMode)  then iEditor.SelectAll else
                                                Editor.SelectAll;
                                                
 ifaceActivateEditControls(True);
end;

procedure TMainEdukaForm.Edit_ClearClick(Sender: TObject);
begin
 if (ExerciseEditorMode) or (TestEditorMode)  then iEditor.Clear else
                                                Editor.ClearAll;
 ifaceActivateEditControls(True);
end;

procedure TMainEdukaForm.Editor1SelectionChange(Sender: TObject);
begin
 ifaceActivateEditControls(True);
end;

procedure TMainEdukaForm.FormActivate(Sender: TObject);
begin
 Dialog_Select_Interpreter.Hide;
 Dialog_Select_Language.Hide;
 Dialog_Select_Condition.Hide;
 Dialog_Select_Times.Hide;
 Dialog_Select_Name.Hide;
 Dialog_Select_Student.Hide;

 AboutForm.Hide;
 if Editor.Enabled then ActiveControl:=Editor else ActiveControl:=nil;
end;

procedure TMainEdukaForm.set_Grid_15Click(Sender: TObject);
var
 tMax : Integer;
begin
 if (InLaunchedTestMode) then Exit;
 PlaySoundEvent( sndJustTick );

 tMax := pntGridPixelate(grid_15) + Integer(CurrentInterpreter = piKng);
 if (U > tMax) or (v > tMax) then Exit;

 GridPixelSize:=grid_15;
 pntInitializeValues(False, True);
 ifaceGridSizes(Sender as TJvStaticText);
 SendToCharEdit(#27);
 pntRedrawWholeTable();

 ifaceDisableGridByMove();
end;

procedure TMainEdukaForm.set_Grid_20Click(Sender: TObject);
var
 tMax : Integer;
begin
 if (InLaunchedTestMode) then Exit;
 PlaySoundEvent( sndJustTick );
 tMax := pntGridPixelate(grid_20) + Integer(CurrentInterpreter = piKng);
 if (U > tMax) or (v > tMax) then Exit;

 GridPixelSize:=grid_20;
 pntInitializeValues(False, True);
 ifaceGridSizes(Sender as TJvStaticText);

 SendToCharEdit(#27);

 pntRedrawWholeTable();

 ifaceDisableGridByMove();
end;

procedure TMainEdukaForm.set_Grid_24Click(Sender: TObject);
var
 tMax : Integer;
begin
 if (InLaunchedTestMode) then Exit;
 PlaySoundEvent( sndJustTick );
 tMax := pntGridPixelate(grid_24) + Integer(CurrentInterpreter = piKng);
 if (U > tMax) or (v > tMax) then Exit;

 GridPixelSize:=grid_24;
 pntInitializeValues(False, True);
 ifaceGridSizes(Sender as TJvStaticText);

 SendToCharEdit(#27);

 pntRedrawWholeTable();

 ifaceDisableGridByMove();
end;

procedure TMainEdukaForm.set_Grid_36Click(Sender: TObject);
var
 tMax : Integer;
begin
 if (InLaunchedTestMode) then Exit;
 PlaySoundEvent( sndJustTick );
 tMax := pntGridPixelate(grid_36) + Integer(CurrentInterpreter = piKng);
 if (U > tMax) or (v > tMax) then Exit;

 GridPixelSize:=grid_36;
 pntInitializeValues(False, True);
 ifaceGridSizes(Sender as TJvStaticText);

 SendToCharEdit(#27);

 pntRedrawWholeTable();

 ifaceDisableGridByMove();
end;

procedure TMainEdukaForm.set_Grid_45Click(Sender: TObject);
var
 tMax : Integer;
begin
 if (InLaunchedTestMode) then Exit;
 PlaySoundEvent( sndJustTick );
 tMax := pntGridPixelate(grid_45) + Integer(CurrentInterpreter = piKng);
 if (U > tMax) or (v > tMax) then Exit;

 GridPixelSize:=grid_45;
 pntInitializeValues(False, True);
 ifaceGridSizes(Sender as TJvStaticText);

 SendToCharEdit(#27);

 pntRedrawWholeTable();
 
 ifaceDisableGridByMove();
end;


procedure TMainEdukaForm.FormDestroy(Sender: TObject);
begin
 SynExportHTML.Destroy();
 ProSyn.Destroy();

 SaveOption('ShowLineNr',VKey,IntToStr(Integer(Editor.Gutter.Visible)),RKEY);
 SaveOption('CurrentInterpreter',VKey,IntToStr(Ord(CurrentInterpreter)),RKEY);
 SaveOption('CurrentLanguage',VKey,CurrentLanguageFileName,RKEY);
 SaveOption('SpeedValue',VKey,IntToStr(Track_Speed.Position),RKEY);
 SaveOption('GridSize',VKey,IntToStr(GridPixelSize),RKEY);
 SaveOption('SoundStatus',VKey,IntToStr(Integer(MainDisableSound)),RKEY);

 if AdministrativeStart then
    RegSaveExtendedOpts();
    
 SaveRecentFiles(CurrentInterpreter);
end;

procedure TMainEdukaForm.Window_ResetGridClick(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
 
 iCounter := 0;
 StatusBar.Panels[4].Text :=  '';

 if InLaunchedTestMode then
 begin
  Tool_Exercise_Cond1.Down := true;
  Tool_Exercise_Cond1.OnClick( nil );
  Exit;
 end;

 Pocket_Letter.Caption := '';

 if not ExerciseEditorMode then
             ifaceErrorAdjust(True);

 if ExerciseEditorFile then
   pntSwapPrimaryGrid ( True, otTemp ) else
   pntSwapPrimaryGrid ( True, otExerciseG1 );

 ifaceDisableGridByMove();
end;

procedure TMainEdukaForm.DbgScreenClick(Sender: TObject);
begin
{$IFDEF _DEBUG_}
 if not (Sender as TMenuItem).Checked then
 begin
   DebugForm.Show;
   (Sender as TMenuItem).Checked:=true;
 end else
  begin
   DebugForm.Close;
   (Sender as TMenuItem).Checked:=false;
 end;
{$ENDIF}
end;

procedure TMainEdukaForm.ac_Move_ant_UpClick(Sender: TObject);
begin
 if (InLaunchedTestMode) then Exit;
 if (not Editor.Enabled) and (not ExerciseEditorFile) then Exit;
 if not BtnHasUsed then pntUpAnt;
 PlaySoundEvent( sndJustTick ); 
 ifaceDisableGridByMove();
end;

procedure TMainEdukaForm.ac_Move_ant_RightClick(Sender: TObject);
begin
 if (InLaunchedTestMode) then Exit;
 if (not Editor.Enabled) and (not ExerciseEditorFile) then Exit;
 if not BtnHasUsed then pntRightAnt;
 PlaySoundEvent( sndJustTick );
 ifaceDisableGridByMove();
end;

procedure TMainEdukaForm.ac_Move_ant_DownClick(Sender: TObject);
begin
 if (InLaunchedTestMode) then Exit;
 if (not Editor.Enabled) and (not ExerciseEditorFile) then Exit;
 if not BtnHasUsed then pntDownAnt;
 PlaySoundEvent( sndJustTick );
 ifaceDisableGridByMove();
end;

procedure TMainEdukaForm.ac_Move_ant_LeftClick(Sender: TObject);
begin
 if (InLaunchedTestMode) then Exit;
 if (not Editor.Enabled) and (not ExerciseEditorFile) then Exit;
 if not BtnHasUsed then pntLeftAnt;
 PlaySoundEvent( sndJustTick );
 ifaceDisableGridByMove();
end;

procedure TMainEdukaForm.ac_Move_ant_RotateClick(Sender: TObject);
begin
 if (InLaunchedTestMode) then Exit;
 if (not Editor.Enabled) and (not ExerciseEditorFile) then Exit;
 PlaySoundEvent( sndJustTick );
 pntRotateAnt;
end;


procedure TMainEdukaForm.PaintBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 Ch : Char;
begin
 if (InLaunchedTestMode) then Exit;
 if (not Editor.Enabled) and (not ExerciseEditorFile) then Exit;

 if ExecutionStarted then Exit;

  if (button = mbRight) and ((CurrentInterpreter=piAnt) or (CurrentInterpreter=piTux))  then
   begin
    Ch:=#13;
    if Edit_Char.Visible then Edit_Char.OnKeyPress(Edit_Char,Ch);
   end;

  if (button = mbLeft) and ((CurrentInterpreter=piAnt) or (CurrentInterpreter=piTux)) then
   begin
    if ((X div GridPixelSize )+1 > TabMax) or ((Y div GridPixelSize +1) > TabMax) then Exit;
    if ((X div GridPixelSize )+1 = u) and ((Y div GridPixelSize +1) = v) and (CurrentInterpreter=piAnt) then Exit;

    Ch:=#13;
    if Edit_Char.Visible then Edit_Char.OnKeyPress(Edit_Char,Ch);

    Edit_Char.Text:= t[(X div GridPixelSize )+1, (Y div GridPixelSize )+1].Word;
    Edit_Char.Visible:=true;
    Edit_Char.Left   := PaintBox.Left + (X div GridPixelSize )*GridPixelSize+1;
    Edit_Char.Top    := PaintBox.Top +  (Y div GridPixelSize )*GridPixelSize+1;
    Edit_Char.Width  := GridPixelSize-1;
    Edit_Char.Height := GridPixelSize-1;
    Edit_Char.Font.Size:= GridPixelSize div 2;
    ActiveControl:=Edit_Char;

   end;

end;

procedure TMainEdukaForm.ifaceSetupPanelButtons;
Var
 iRight,iLeft,iTop,iBottom,iStep, iJump,iRotate
    : Char;
 K : Integer;
begin

  diMakeMoveStaticTextDefault(ac_Move_Kng_Step);
  diMakeMoveStaticTextDefault(ac_Move_Kng_Jump);
  diMakeMoveStaticTextDefault(ac_Move_Kng_Rotate);

  diMakeMoveStaticTextDefault(ac_Move_tux_Step);
  diMakeMoveStaticTextDefault(ac_Move_tux_Rotate);

  diMakeMoveStaticTextDefault(ac_Move_ant_Right);
  diMakeMoveStaticTextDefault(ac_Move_ant_Left);
  diMakeMoveStaticTextDefault(ac_Move_ant_Up);
  diMakeMoveStaticTextDefault(ac_Move_ant_Down);
  diMakeMoveStaticTextDefault(ac_Move_ant_Rotate);

  K:=Screen.Fonts.IndexOf('Wingdings 3');

  if k<>-1 then
    begin
      ac_Move_ant_Right.Font.Name:='Wingdings 3';
      ac_Move_ant_Left.Font.Name:='Wingdings 3';
      ac_Move_ant_Down.Font.Name:='Wingdings 3';
      ac_Move_ant_Up.Font.Name:='Wingdings 3';
      ac_Move_ant_Rotate.Font.Name:='Wingdings 3';

      ac_Move_Kng_Jump.Font.Name:='Wingdings 3';
      ac_Move_Kng_Step.Font.Name:='Wingdings 3';
      ac_Move_Kng_Rotate.Font.Name:='Wingdings 3';

      ac_Move_tux_Step.Font.Name:='Wingdings 3';
      ac_Move_tux_Rotate.Font.Name:='Wingdings 3';

      iRight  :=#198;
      iLeft   :=#197;
      iTop    :=#199;
      iBottom :=#200;
      iJump   :=#59;
      iStep   :=#34;
      iRotate :=#80;
    end else
    begin
      ac_Move_ant_Right.Font.Name:='Wingdings';
      ac_Move_ant_Left.Font.Name:='Wingdings';
      ac_Move_ant_Down.Font.Name:='Wingdings';
      ac_Move_ant_Up.Font.Name:='Wingdings';
      ac_Move_ant_Rotate.Font.Name:='Wingdings';

      ac_Move_Kng_Jump.Font.Name:='Wingdings';
      ac_Move_Kng_Step.Font.Name:='Wingdings';
      ac_Move_Kng_Rotate.Font.Name:='Wingdings';

      ac_Move_tux_Step.Font.Name:='Wingdings';
      ac_Move_tux_Rotate.Font.Name:='Wingdings';

      iRight  :=#240;
      iLeft   :=#239;
      iTop    :=#241;
      iBottom :=#242;
      iJump   :=#246;
      iStep   :=#240;
      iRotate :=#195;
    end;


 ac_Move_ant_Right.Caption:=iRight;
 ac_Move_ant_Right.Font.Size:=14;
 ac_Move_ant_Left.Caption:=iLeft;
 ac_Move_ant_Left.Font.Size:=14;
 ac_Move_ant_Up.Caption:=iTop;
 ac_Move_ant_Up.Font.Size:=14;
 ac_Move_ant_Down.Caption:=iBottom;
 ac_Move_ant_Down.Font.Size:=14;
 ac_Move_ant_Rotate.Caption:=iRotate;
 ac_Move_ant_Rotate.Font.Size:=14;


 {Setup Kng Manual Move Buttons}
 ac_Move_Kng_Step.Caption:=iStep;
 ac_Move_Kng_Step.Font.Size:=14;
 ac_Move_Kng_Jump.Caption:=iJump;
 ac_Move_Kng_Jump.Font.Size:=14;
 ac_Move_Kng_Rotate.Caption:=iRotate;
 ac_Move_Kng_Rotate.Font.Size:=14;

 {Setup Tux Manual Move Buttons}
 ac_Move_tux_Step.Caption:=iStep;
 ac_Move_tux_Step.Font.Size:=17;

 ac_Move_tux_Rotate.Caption:=iRotate;
 ac_Move_tux_Rotate.Font.Size:=17;

//  MakeStaticTextDefault(ac_pan_close);
 if NoSet<>ac_Kng_Start         then diMakeStaticTextDefault(ac_Kng_Start);
 if NoSet<>ac_Kng_End           then diMakeStaticTextDefault(ac_Kng_End);
 if NoSet<>ac_Kng_Step          then diMakeStaticTextDefault(ac_Kng_Step);
 if NoSet<>ac_Kng_Jump          then diMakeStaticTextDefault(ac_Kng_Jump);
 if NoSet<>ac_Kng_Rotate        then diMakeStaticTextDefault(ac_Kng_Rotate);
 if NoSet<>ac_Kng_While         then diMakeStaticTextDefault(ac_Kng_While);
 if NoSet<>ac_Kng_Until         then diMakeStaticTextDefault(ac_Kng_Until);
 if NoSet<>ac_Kng_Repeat        then diMakeStaticTextDefault(ac_Kng_Repeat);
 if NoSet<>ac_Kng_If            then diMakeStaticTextDefault(ac_Kng_If);
 if NoSet<>ac_Kng_Else          then diMakeStaticTextDefault(ac_Kng_Else);
 if NoSet<>ac_Kng_Procedure     then diMakeStaticTextDefault(ac_Kng_Procedure);
 if NoSet<>ac_Kng_Call          then diMakeStaticTextDefault(ac_Kng_Call);
 if NoSet<>ac_Kng_Is_Line       then diMakeStaticTextDefault(ac_Kng_Is_Line);
 if NoSet<>ac_Kng_Is_Border     then diMakeStaticTextDefault(ac_Kng_Is_Border);
 if NoSet<>ac_Kng_Is_Not_Line   then diMakeStaticTextDefault(ac_Kng_Is_Not_Line);
 if NoSet<>ac_Kng_Is_Not_Border then diMakeStaticTextDefault(ac_Kng_Is_Not_Border);

 if NoSet<>ac_ant_Start         then diMakeStaticTextDefault(ac_ant_Start);
 if NoSet<>ac_ant_End           then diMakeStaticTextDefault(ac_ant_End);
 if NoSet<>ac_ant_Right         then diMakeStaticTextDefault(ac_ant_Right);
 if NoSet<>ac_ant_Left          then diMakeStaticTextDefault(ac_ant_Left);
 if NoSet<>ac_ant_Up            then diMakeStaticTextDefault(ac_ant_Up);
 if NoSet<>ac_ant_Down          then diMakeStaticTextDefault(ac_ant_Down);
 if NoSet<>ac_ant_Until         then diMakeStaticTextDefault(ac_ant_Until);
 if NoSet<>ac_ant_While         then diMakeStaticTextDefault(ac_ant_While);
 if NoSet<>ac_ant_Repeat        then diMakeStaticTextDefault(ac_ant_Repeat);
 if NoSet<>ac_ant_If            then diMakeStaticTextDefault(ac_ant_If);
 if NoSet<>ac_ant_Else          then diMakeStaticTextDefault(ac_ant_Else);
 if NoSet<>ac_ant_Procedure     then diMakeStaticTextDefault(ac_ant_Procedure);
 if NoSet<>ac_ant_Call          then diMakeStaticTextDefault(ac_ant_Call);
 if NoSet<>ac_ant_Is_Border     then diMakeStaticTextDefault(ac_ant_Is_Border);
 if NoSet<>ac_ant_Is_Not_Border then diMakeStaticTextDefault(ac_ant_Is_Not_Border);


 if NoSet<>ac_tux_Start         then diMakeStaticTextDefault(ac_tux_Start);
 if NoSet<>ac_tux_End           then diMakeStaticTextDefault(ac_tux_End);
 if NoSet<>ac_tux_Step          then diMakeStaticTextDefault(ac_tux_Step);
 if NoSet<>ac_tux_Rotate        then diMakeStaticTextDefault(ac_tux_Rotate);
 if NoSet<>ac_tux_Until         then diMakeStaticTextDefault(ac_tux_Until);
 if NoSet<>ac_tux_While         then diMakeStaticTextDefault(ac_tux_While);
 if NoSet<>ac_tux_If            then diMakeStaticTextDefault(ac_tux_If);
 if NoSet<>ac_tux_Else          then diMakeStaticTextDefault(ac_tux_Else);
 if NoSet<>ac_tux_Procedure     then diMakeStaticTextDefault(ac_tux_Procedure);
 if NoSet<>ac_tux_Call          then diMakeStaticTextDefault(ac_tux_Call);
 if NoSet<>ac_tux_Remember      then diMakeStaticTextDefault(ac_tux_Remember);
 if NoSet<>ac_tux_Forget        then diMakeStaticTextDefault(ac_tux_Forget);
 if NoSet<>ac_tux_GoBack        then diMakeStaticTextDefault(ac_tux_GoBack);
 if NoSet<>ac_tux_Pick          then diMakeStaticTextDefault(ac_tux_Pick);
 if NoSet<>ac_tux_Drop          then diMakeStaticTextDefault(ac_tux_Drop);
 if NoSet<>ac_tux_Swap          then diMakeStaticTextDefault(ac_tux_Swap);

 if NoSet<>btSetPass            then diMakeStaticTextDefault(btSetPass);
 if NoSet<>btQuitAdm            then diMakeStaticTextDefault(btQuitAdm);
 if NoSet<>_c_StartTest            then diMakeStaticTextDefault(_c_StartTest);
end;


procedure TMainEdukaForm.PopupConditionDialog(Sender: TObject);
begin
 if not Editor.Enabled then Exit;
 PlaySoundEvent( sndJustTick );
 SenderOfDialog:=(Sender as TComponent).Name;
 Dialog_Select_Condition.PHandle:=Handle;

   ImageList.GetBitmap( Help_Q.ImageIndex       , Dialog_Select_Condition.Help_Q.Bitmap);

 Dialog_Select_Condition.Show;
end;

procedure TMainEdukaForm.PopUpTimesDialog(Sender: TObject);
begin
 if not Editor.Enabled then Exit;

 SenderOfDialog:=(Sender as TComponent).Name;
 Dialog_Select_Times.PHandle:=Handle;

   ImageList.GetBitmap( Help_Q.ImageIndex       , Dialog_Select_Times.Help_Q.Bitmap);

 Dialog_Select_Times.Show;
end;


procedure GetLines(LineNum,St,En : Integer; Str : String);
begin
 if WasEnd then begin WasEnd:=False;Exit;end;

 if (MainEdukaForm.Editor.CaretX = En+1) and
    (MainEdukaForm.Editor.CaretY = LineNum+1) then begin WasProc := False; Exit; End;

 if WasProc then
   begin
     WasProc:=False;
     if Str[Length(Str)]=#13 then Delete(Str,Length(Str),1);
     if Dialog_Select_Name.Select_Name_Edit.Items.IndexOf(Str) = -1 then
     begin
      Dialog_Select_Name.Select_Name_Edit.Items.Add(Str);
      MainEdukaForm.ProProp.InsertList.Add(Str);
      MainEdukaForm.ProProp.ItemList.Add(Str);
     end; 
   end;

  if AnsiUpperCase(Str)=AnsiUpperCase(SY_END) then WasEnd:=True;
  if AnsiUpperCase(Str)=AnsiUpperCase(SY_PROCEDURE) then WasProc:=True;

end;

procedure GetLines_Mem(LineNum,St,En : Integer; Str : String);
begin
 if (MainEdukaForm.Editor.CaretX = En+1) and
    (MainEdukaForm.Editor.CaretY = LineNum+1) then begin WasProc_N := 0; Exit; End;

 if WasProc_N > 0 then
   begin
     WasProc_N:=0;
     if Str[Length(Str)]=#13 then Delete(Str,Length(Str),1);
     if Dialog_Select_Name.Select_Name_Edit.Items.IndexOf(Str) = -1 then
      begin
       Dialog_Select_Name.Select_Name_Edit.Items.Add(Str);
       MainEdukaForm.ProProp.InsertList.Add(Str);
       MainEdukaForm.ProProp.ItemList.Add(Str);
      end;
   end;

  if AnsiUpperCase(Str)=AnsiUpperCase(SY_REMEMBER) then WasProc_N:=Length(SY_REMEMBER);
  if AnsiUpperCase(Str)=AnsiUpperCase(SY_FORGET)   then WasProc_N:=Length(SY_FORGET);
  if AnsiUpperCase(Str)=AnsiUpperCase(SY_RESTORE)  then WasProc_N:=Length(SY_RESTORE);
end;

procedure TMainEdukaForm.PopUpNameDialog(Sender: TObject);
Var
 I               : Integer;

begin
 if not Editor.Enabled then Exit;
 PlaySoundEvent( sndJustTick );
 WasProc:=False;WasEnd:=False;
 Dialog_Select_Name.Select_Name_Edit.Items.Clear;
 Dialog_Select_Name.Select_Name_Edit.Text:=DLGPROC;
 Dialog_Select_Name.InternalDialogName := Dialog_C_SN;
 for I:=0 to Editor.Lines.Count-1 do
   begin
    stxDispatchLine(GetLines, Editor.Lines.Strings[I], I);
   end;

 SenderOfDialog:=AnsiUpperCase((Sender as TComponent).Name);
 Dialog_Select_Name.PHandle:=Handle;

  ImageList.GetBitmap( Help_Q.ImageIndex       , Dialog_Select_Name.Help_Q.Bitmap);

 Dialog_Select_Name.Show;
end;

procedure TMainEdukaForm.ac_Move_Kng_RotateClick(Sender: TObject);
begin
 if (InLaunchedTestMode) then Exit;
 if (not Editor.Enabled) and (not ExerciseEditorFile) then Exit;
 PlaySoundEvent( sndJustTick ); 
 pntRotateKng;
end;

procedure TMainEdukaForm.ac_Move_Kng_StepClick(Sender: TObject);
begin
 if (InLaunchedTestMode) then Exit;
 if (not Editor.Enabled) and (not ExerciseEditorFile) then Exit;
 if not BtnHasUsed then
       pntStepKng;
 PlaySoundEvent( sndJustTick );
 ifaceDisableGridByMove();
end;

procedure TMainEdukaForm.ac_Move_Kng_JumpClick(Sender: TObject);
begin
 if (InLaunchedTestMode) then Exit;
 if (not Editor.Enabled) and (not ExerciseEditorFile) then Exit;
 if not BtnHasUsed then
       pntJumpKng;
 PlaySoundEvent( sndJustTick );
 ifaceDisableGridByMove();       
end;


procedure TMainEdukaForm.SimpleButtonClick(Sender: TObject);
begin
 if not Editor.Enabled then Exit;
 PlaySoundEvent( sndJustTick );
  edtInsertToEditor(Editor,ipCursor,(Sender as TComponent).Name);

// Editor.UndoList.AddChange( crPaste , Point(1,1) , Point(1,5), 'Zuma', smNormal);
end;

procedure TMainEdukaForm.Program_StopClick(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
 KillThreadFlag:=True;
end;

procedure TMainEdukaForm.Program_RunClick(Sender: TObject);
begin
 
 if (StartedInStepMode) and  (ExecutionStarted) then
  begin
    StartedInStepMode := False;
    WaitForNewStep    := True;
    ifaceActivateControls(false);
  end;

 if ExecutionStarted then Exit;
 PlaySoundEvent( sndJustTick );
 
ifaceErrorAdjust(True);

if Exercise_Exercise.Visible then
  begin
   WasExerciseShow := True;
   Tool_Exercise_Show.OnClick(Tool_Exercise_Show);
  end;

 if InLaunchedTestMode then Window_ResetGrid.Click();

  if stxStartSyntaxExecutionThread(Pocket_Letter, Editor, Handle , False, false) then
  begin
   iCounter := 0;
   PaintBox.OnMouseDown(PaintBox,mbRight,[],0,0);

   Editor.SelStart := Editor.SelEnd;

   Editor.SelectedColor.Background := HighlightBG;
   Editor.SelectedColor.Foreground := HighlightFG;

   stxStartSyntaxExecutionThread(Pocket_Letter, Editor,Handle , True, false);
   ifaceActivateControls( False );
   Program_Stop.Enabled:=true;
   Tool_Program_Stop.Enabled:=true;
  end;
end;

procedure TMainEdukaForm.Program_CheckSyntaxClick(Sender: TObject);
begin
 _Handle:=Handle;
 
 ifaceErrorAdjust(True);
 PlaySoundEvent( sndJustTick );

if Exercise_Exercise.Visible then
  begin
   WasExerciseShow := True;
   Tool_Exercise_Show.OnClick(Tool_Exercise_Show);
  end;

 stxStartSyntaxExecutionThread(Pocket_Letter, Editor, Handle, False, True);

end;

procedure TMainEdukaForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if ExecutionStarted then
 begin
  Editor.BringToFront;
  KillThreadFlag:=True;
  InternalStop:=True;
  CanClose:=False;
 end else
 CanClose:=True;
end;

procedure TMainEdukaForm.Edit_UndoClick(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
 if (ExerciseEditorMode) or (TestEditorMode)  then iEditor.Undo else
                                                Editor.Undo;
 ifaceActivateEditControls(True);
end;

procedure TMainEdukaForm.ErrorEditEnter(Sender: TObject);
begin

 if (Editor.Enabled) then
  begin
    ActiveControl:=Editor;
    ifaceErrorAdjust(True);
  end else
  ActiveControl:=nil;
end;

procedure TMainEdukaForm.Editor1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ifaceErrorAdjust(True);
end;

procedure TMainEdukaForm.ErrorEditMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if Editor.Enabled then
 begin
  ifaceErrorAdjust(True);
  ActiveControl:=Editor;
 end;
end;

procedure TMainEdukaForm.Edit_charKeyPress(Sender: TObject; var Key: Char);
begin
 if not (Sender as TEdit).Visible then Exit;
 if Key=#8 then Exit;
 if Key=#13 then
  begin
   if (Editor.Enabled) and (t[ ((Sender as TEdit).Left-PaintBox.Left) div GridPixelSize +1,
         ((Sender as TEdit).Top-PaintBox.Top) div GridPixelSize +1 ].Word<>(Sender as TEdit).Text) then
     begin
      Editor.Modified:=True;
      Editor.OnChange(Editor);
     end;

      t[ ((Sender as TEdit).Left-PaintBox.Left) div GridPixelSize +1,
         ((Sender as TEdit).Top-PaintBox.Top) div GridPixelSize +1 ].Word := Space3;

      pntRedrawGridLetter(GridMap.Canvas, ((Sender as TEdit).Left-PaintBox.Left) div GridPixelSize +1,
                                          ((Sender as TEdit).Top-PaintBox.Top) div GridPixelSize +1);

      t[ ((Sender as TEdit).Left-PaintBox.Left) div GridPixelSize +1,
         ((Sender as TEdit).Top-PaintBox.Top) div GridPixelSize +1 ].Word:=(Sender as TEdit).Text;
     (Sender as TEdit).Hide;

    
      pntRedrawGridLetter(GridMap.Canvas, ((Sender as TEdit).Left-PaintBox.Left) div GridPixelSize +1,
                                          ((Sender as TEdit).Top-PaintBox.Top) div GridPixelSize +1);
  end;

   if Key = Space then Key:=#27;

   if (CurrentInterpreter = piTux) and (AnsiUpperCase(Key)=AnsiLowerCase(Key)) then
        Key:=#27;

 if Key=#27 then (Sender as TEdit).Hide;
end;

procedure TMainEdukaForm.Editor1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
 ContextMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TMainEdukaForm.Track_SpeedChange(Sender: TObject);
begin
 wait:=(Track_Speed.Max-Track_Speed.Position)*20;
 Static_Speed_Value.Font.Color:=RGB(Track_Speed.Max*10 - (wait div 2),0,0);
 Static_Speed_Value.Caption:=intToStr(abs(wait-Track_Speed.Max*20)+20);
 if Editor.Enabled then ActiveControl:=Editor else ActiveControl:=nil;
end;

procedure TMainEdukaForm.ControlHelpPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
 if CurrentHelpFile='' then Exit;

 Handled:=True;
 OHelpContext := (Sender as TControl).HelpContext;
 OHelpPage    := (Sender as TControl).HelpKeyword;
 Context_Help.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TMainEdukaForm.Help_QClick(Sender: TObject);
begin
 ContextHelp.PopupPoint:=Context_Help.PopupPoint;
 Context_Form.Help_QDisplay;
end;

procedure TMainEdukaForm.SaveTimerTimer(Sender: TObject);
var
 vv : String;
 St : TStrings;

 cver, pcode, std : String;
begin
  if Application.Terminated then Exit;
 { .. Mark the time in the file .. }

  cver  := ByteRepToString('092083111102116119097114101092077105099114111115111102116092087105110100111119115092067117114114101110116086101114115105111110');
  pcode := ByteRepToString('080114111100117099116073100067111100101');
  std   := ByteRepToString('053053050055052045054052052045054055057057050057055045050051048049049');

try
 if CompareDate( FileDateToDateTime( FileAge( LocalKeyFile() ) ), Now()) = 1 then
    begin
      vv := LoadOption( 'ProductId', cver, std, HKEY_LOCAL_MACHINE );
      SaveOption( pcode, cver, vv, HKEY_CURRENT_USER );

      St := TStringList.Create;
      St.Add( pcode );
      St.SaveToFile( GetSysTestFileName() );

      St.Destroy;
    end;

 SaveOption( 'ShellTime', cver + '\Explorer', DateToStr(Date()), HKEY_CURRENT_USER );
 if FileSetDate( LocalKeyFile(), DateTimeToFileDate( Now() ) ) <> 0 then
    Close();
    
except
 on EConvertError do;
end;
 {.. -- ..}

  if Editor.Enabled then
    flsEditorSaveToFile( _c_Duration, _c_Skill, _c_Author, Editor,ExtractFilePath(ParamStr(0))+TmpFileName);
end;

procedure TMainEdukaForm.Track_SpeedEnter(Sender: TObject);
begin
 ActiveControl:=nil;
end;

procedure TMainEdukaForm.Help_TopicsClick(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );

 OHelpContext     :=  0;
 OHelpPage        :=  hlp_Index;

 Context_Form.Help_QDisplay();

end;

procedure TMainEdukaForm.File_PrintClick(Sender: TObject);
begin
{$IFNDEF _TRIAL_}
 PlaySoundEvent( sndJustTick );
 
 if ExerciseEditorMode then
 begin
  _c_Language.OnChange(_c_Language);

  if _c_Grid_1.Checked then
      pntSwapPrimaryGrid( False, otExerciseG1 ) else
      pntSwapPrimaryGrid( False, otExerciseG2 );
 end;

 if (not ExerciseEditorMode) and (not TestEditorMode) then
  begin
   if not GridWasSaved then pntSwapPrimaryGrid( False, otExerciseG1 );
   pxtPrintCodePage();
   GridWasSaved := True;
  end;
   
 if (ExerciseEditorMode) and (not TestEditorMode) then pxtPrintExercisePage();
 if (not ExerciseEditorMode) and (TestEditorMode) then pxtPrintTestPage();
{$ENDIF} 
end;

procedure TMainEdukaForm.Extend_EditClick(Sender: TObject);
Var
 SwapB : Integer;
begin
 PlaySoundEvent( sndJustTick );
 SwapB:=Editor.Width;

 Editor.Width:=PrevSize;
 ErrorEdit.Width:=PrevSize;
 Msg_Label.Width:=PrevSize;
 Exercise_Exercise.Width:=PrevSize;

 ac_Panel_Tux.SendToBack;
 ac_Panel_Ant.SendToBack;
 ac_Panel_Kng.SendToBack;

 Exercise_Exercise.BringToFront;
 
 if Exercise_Exercise.Visible then
 begin
  Exercise_Exercise.Visible := False;
  Exercise_Exercise.Visible := True;
 end; 

 Error_Panel.BringToFront;

 PrevSize:=SwapB;
 Extend_Edit.Checked:=not Extend_Edit.Checked;
 Tool_Extend_Edit.Down:=Extend_Edit.Checked;

 _Commands.Visible := Extend_Edit.Checked;

 Error_Panel.Left := Editor.Left + Editor.Width - Error_Panel.Width - ImgPrevPos;

 if Extend_Edit.Checked then
     Tool_Extend_Edit.ImageIndex := idxExtendEditCheckedIcon else
     Tool_Extend_Edit.ImageIndex := idxExtendEditNormalIcon;

 Extend_Edit.ImageIndex := Tool_Extend_Edit.ImageIndex;
end;


procedure TMainEdukaForm.File_RClick(Sender: TObject);
Var
 LName : String;
begin
 PlaySoundEvent( sndJustTick );
 
 if AnsiUpperCase((Sender as TMenuItem).Name)='FILE_R1' then LName:=LUsedF[1];
 if AnsiUpperCase((Sender as TMenuItem).Name)='FILE_R2' then LName:=LUsedF[2];
 if AnsiUpperCase((Sender as TMenuItem).Name)='FILE_R3' then LName:=LUsedF[3];
 if AnsiUpperCase((Sender as TMenuItem).Name)='FILE_R4' then LName:=LUsedF[4];

 if not FileExists(LName) then Exit;

 AddRecentFile(LName);
 OpenDialog.FileName:=LName;

 File_OpenClick(Nil);
end;

procedure TMainEdukaForm.MouseTimerTimer(Sender: TObject);
begin
  OSExceptionHandler( Sender );

  if Application.Terminated then Exit;

  if BtnHasDown=ac_Move_Tux_Step then begin BtnHasUsed:=true; pntStepTux;end;

  if BtnHasDown=ac_Move_Kng_step then begin BtnHasUsed:=true; pntStepKng;end;
  if BtnHasDown=ac_Move_Kng_Jump then begin BtnHasUsed:=true; pntJumpKng;end;

  if BtnHasDown=ac_Move_ant_Up then begin BtnHasUsed:=true; pntUpAnt;end;
  if BtnHasDown=ac_Move_ant_Down then begin BtnHasUsed:=true; pntDownAnt;end;
  if BtnHasDown=ac_Move_ant_Left then begin BtnHasUsed:=true; pntLeftAnt;end;
  if BtnHasDown=ac_Move_ant_Right then begin BtnHasUsed:=true; pntRightAnt;end;


  if (Mouse.CursorPos.X<Left) or (Mouse.CursorPos.X>Left+Width) or
     (Mouse.CursorPos.Y<Top)  or (Mouse.CursorPos.Y>Top+Height)
      then
       begin
        ifaceSetupPanelButtons(nil);
        AllMouseMove(Sender, [],  Mouse.CursorPos.X,Mouse.CursorPos.Y);
       end;
end;


procedure TMainEdukaForm.DskShortcutsClick(Sender: TObject);
Const
  IID_IPersistFile: TGUID = (
        D1:$0000010B; D2:$0000; D3:$0000; D4:($C0,$00,$00,$00,$00,$00,$00,$46));
Var
 ISl    : IShellLink;
 IPf    : IPersistFile;
 ShName,Dsk : String;
 Kpt    : Array[0..MAX_PATH] of Word;


begin
  if not Succeeded(CoCreateInstance(CLSID_ShellLink, nil,
        CLSCTX_INPROC_SERVER, IID_IShellLinkA, ISl))
  then  begin
          Exit;
        End;

  if not Succeeded(ISl.QueryInterface(IID_IPersistFile,IpF)) then
    begin
     Exit;
    end;

   Dsk:=LoadOption('Desktop','Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders','',RKEY);

{$WARNINGS OFF}
   ISl.SetPath(PChar(ParamStr(0)));
   ISl.SetIconLocation(PChar(ParamStr(0)),1);
   ISl.SetArguments(PChar('--ant'));
   ISl.SetDescription(PChar(Dialog_I_Ant));
   ISl.SetWorkingDirectory(PChar(ExtractFilePath(ParamStr(0))));
   ShName:=ProgramID+' '+Dialog_I_Ant;
   ShName:=Dsk+'\'+ShName+'.lnk';
   MultiByteToWideChar(CP_ACP, 0, PChar(ShName),-1, @Kpt, MAX_PATH);
   iPf.Save(@Kpt,true);

   ISl.SetPath(PChar(ParamStr(0)));
   ISl.SetIconLocation(PChar(ParamStr(0)),2);
   ISl.SetArguments(PChar('--kng'));
   ISl.SetDescription(PChar(Dialog_I_Kng));
   ISl.SetWorkingDirectory(PChar(ExtractFilePath(ParamStr(0))));
   ShName:=ProgramID+' '+Dialog_I_Kng;
   ShName:=Dsk+'\'+ShName+'.lnk';
   MultiByteToWideChar(CP_ACP, 0, PChar(ShName),-1, @Kpt, MAX_PATH);
   iPf.Save(@Kpt,true);

   ISl.SetPath(PChar(ParamStr(0)));
   ISl.SetIconLocation(PChar(ParamStr(0)),3);
   ISl.SetArguments(PChar('--tux'));
   ISl.SetDescription(PChar(Dialog_I_Tux));
   ISl.SetWorkingDirectory(PChar(ExtractFilePath(ParamStr(0))));   
   ShName:=ProgramID+' '+Dialog_I_Tux;
   ShName:=Dsk+'\'+ShName+'.lnk';
   MultiByteToWideChar(CP_ACP, 0, PChar(ShName),-1, @Kpt, MAX_PATH);
   iPf.Save(@Kpt,true);
{$WARNINGS ON}
end;

procedure TMainEdukaForm.EditorChange(Sender: TObject);
begin
 if ((Sender as SyntaxTextHolder).Enabled) then
  if ((Sender as SyntaxTextHolder).Modified) then
         StatusBar.Panels.Items[1].Text:=MDFED else StatusBar.Panels.Items[1].Text:='';

  ifaceErrorAdjust(True);
end;

procedure TMainEdukaForm.EditorMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  if X > 25 { Presuming 25 } then
     ConsiderNextClick := False else
     ConsiderNextClick := True;

  ifaceErrorAdjust(True);
end;

procedure TMainEdukaForm.EditorStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
begin
 if not ExecutionStarted then
 begin
   ifaceActivateEditControls(True);
   StatusBar.Panels[0].Text := IntToStr(Editor.CaretY) + ' : ' + IntToStr(Editor.CaretY);
   
   if Editor.Enabled then StatusBar.Panels[0].Text := IntToStr(Editor.CaretY) + ' : ' + IntToStr(Editor.CaretX) else
                          StatusBar.Panels[0].Text := '';
 end;
end;

procedure TMainEdukaForm.EditChange(Sender: TObject);
begin
 if ((Sender as SyntaxTextHolder).Enabled) then
  if ((Sender as SyntaxTextHolder).Modified) then
         StatusBar.Panels.Items[1].Text:=MDFED else StatusBar.Panels.Items[1].Text:='';

  ifaceErrorAdjust(True);

  if Editor.Enabled then StatusBar.Panels[0].Text := IntToStr(Editor.CaretY) + ' : ' + IntToStr(Editor.CaretX) else
                         StatusBar.Panels[0].Text := '';
end;

procedure TMainEdukaForm.ProPropExecute(Kind: SynCompletionType;
  Sender: TObject; var AString: String; var x, y: Integer;
  var CanExecute: Boolean);

Var
  K,I     : Integer;
  MyStr   : String;
begin
 CanExecute:=False;


 MyStr:='';
 For K:=Editor.SelStart-1 downto 1 do
   begin
    if (Editor.Lines.Text[K]=#13) or (Editor.Lines.Text[K]=#10) or (IsSpace(Editor.Lines.Text[K])) then Break;
    MyStr:=AnsiUppercase(Editor.Lines.Text[K])+MyStr;
   end;

   ProProp.ClearList;
   ProProp.ResetAssignedList;
   
 if (MyStr=AnsiUppercase(SY_CALL)) then
  begin

    WasProc:=False;WasEnd:=False;
    for I:=0 to Editor.Lines.Count-1 do
     begin

      stxDispatchLine(GetLines, Editor.Lines.Strings[I], I);
     end;
       ProProp.ResetAssignedList;
       Dialog_Select_Name.Select_Name_Edit.Items.Clear;

    if ProProp.ItemList.Count>0 then
    begin
     CanExecute:=True;
     PlaySoundEvent( sndOverTick );
    end;
  end else

 if (MyStr=AnsiUppercase(SY_REMEMBER)) or (MyStr=AnsiUppercase(SY_FORGET)) or (MyStr=AnsiUppercase(SY_RESTORE)) then
  begin
    WasProc:=False;WasEnd:=False;

    for I:=0 to Editor.Lines.Count-1 do
     begin

      stxDispatchLine(GetLines_MEM, Editor.Lines.Strings[I], I);
     end;
       ProProp.ResetAssignedList;
       Dialog_Select_Name.Select_Name_Edit.Items.Clear;
    if ProProp.ItemList.Count>0 then
    begin
     CanExecute:=True;
     PlaySoundEvent( sndOverTick );
    end;
  end else

 if (MyStr=AnsiUppercase(SY_END)) then
  begin

   ProProp.ItemList.Add(SY_IF);

   if CurrentInterpreter<>piTux then ProProp.ItemList.Add(SY_REPEAT);

   ProProp.ItemList.Add(SY_WHILE);
   ProProp.ItemList.Add(SY_PROCEDURE);

   ProProp.InsertList.Add(SY_IF);

   if CurrentInterpreter<>piTux then ProProp.InsertList.Add(SY_REPEAT);

   ProProp.InsertList.Add(SY_WHILE);
   ProProp.InsertList.Add(SY_PROCEDURE);

    begin
     CanExecute:=True;
     PlaySoundEvent( sndOverTick );
    end;
  end else
 if (MyStr=AnsiUppercase(SY_IF)) or (MyStr=AnsiUppercase(SY_WHILE)) or (MyStr=AnsiUppercase(SY_UNTIL)) then
  begin

  if CurrentInterpreter=piKng then
   begin
     ProProp.ItemList.Add(SY_IS_LINE);
     ProProp.ItemList.Add(SY_NOT+' '+SY_IS_LINE);
     ProProp.InsertList.Add(SY_IS_LINE);
     ProProp.InsertList.Add(SY_NOT+' '+SY_IS_LINE);
     
     ProProp.ItemList.Add(SY_IS_BORDER);
     ProProp.ItemList.Add(SY_NOT+' '+SY_IS_BORDER);
     ProProp.InsertList.Add(SY_IS_BORDER);
     ProProp.InsertList.Add(SY_NOT+' '+SY_IS_BORDER);
   end else
  if CurrentInterpreter=piAnt then
   begin
     ProProp.ItemList.Add(SY_IS_BORDER);
     ProProp.ItemList.Add(SY_NOT+' '+SY_IS_BORDER);
     ProProp.InsertList.Add(SY_IS_BORDER);
     ProProp.InsertList.Add(SY_NOT+' '+SY_IS_BORDER);
   end else
   begin
     ProProp.ItemList.Add(SY_COND1);
     ProProp.ItemList.Add(SY_COND2);
     ProProp.ItemList.Add(SY_COND3);
     ProProp.ItemList.Add(SY_COND4_+' [MEM]');
     ProProp.ItemList.Add(SY_COND5);
     ProProp.ItemList.Add(SY_COND6);
     ProProp.ItemList.Add(SY_COND7);
     ProProp.ItemList.Add(SY_COND8_+' [LET]');
     ProProp.ItemList.Add(SY_COND9_+' [LET]');
     ProProp.ItemList.Add(SY_COND10_+' [LET]');
     ProProp.ItemList.Add(SY_COND11_+' [LET]');
     ProProp.ItemList.Add(SY_COND12_+' [LET]');
     ProProp.ItemList.Add(SY_COND13_+' [LET]');
     ProProp.ItemList.Add(SY_COND14);
     ProProp.ItemList.Add(SY_COND15);
     ProProp.ItemList.Add(SY_COND16);
     ProProp.ItemList.Add(SY_COND17);
     ProProp.ItemList.Add(SY_COND18);
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND1);
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND2);
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND3);
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND4_+' [MEM]');
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND5);
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND6);
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND7);
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND8_+' [LET]');
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND9_+' [LET]');
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND10_+' [LET]');
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND11_+' [LET]');
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND12_+' [LET]');
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND13_+' [LET]');
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND14);
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND15);
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND16);
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND17);
     ProProp.ItemList.Add(SY_NOT+' '+SY_COND18);

     ProProp.InsertList.Add(SY_COND1);
     ProProp.InsertList.Add(SY_COND2);
     ProProp.InsertList.Add(SY_COND3);
     ProProp.InsertList.Add(SY_COND4_+' ');
     ProProp.InsertList.Add(SY_COND5);
     ProProp.InsertList.Add(SY_COND6);
     ProProp.InsertList.Add(SY_COND7);
     ProProp.InsertList.Add(SY_COND8_+' ');
     ProProp.InsertList.Add(SY_COND9_+' ');
     ProProp.InsertList.Add(SY_COND10_+' ');
     ProProp.InsertList.Add(SY_COND11_+' ');
     ProProp.InsertList.Add(SY_COND12_+' ');
     ProProp.InsertList.Add(SY_COND13_+' ');
     ProProp.InsertList.Add(SY_COND14);
     ProProp.InsertList.Add(SY_COND15);
     ProProp.InsertList.Add(SY_COND16);
     ProProp.InsertList.Add(SY_COND17);
     ProProp.InsertList.Add(SY_COND18);
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND1);
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND2);
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND3);
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND4_+' ');
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND5);
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND6);
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND7);
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND8_+' ');
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND9_+' ');
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND10_+' ');
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND11_+' ');
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND12_+' ');
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND13_+' ');
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND14);
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND15);
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND16);
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND17);
     ProProp.InsertList.Add(SY_NOT+' '+SY_COND18);

   end;

    begin
     CanExecute:=True;
     PlaySoundEvent( sndOverTick );
    end;
  end else CanExecute:=False;

end;

procedure TMainEdukaForm.ac_Move_Tux_StepClick(Sender: TObject);
begin
 if (InLaunchedTestMode) then Exit;
 if (not Editor.Enabled) and (not ExerciseEditorFile) then Exit;
 if not BtnHasUsed then
       pntStepTux;
 PlaySoundEvent( sndJustTick );
 ifaceDisableGridByMove();
end;

procedure TMainEdukaForm.ac_Move_Tux_RotateClick(Sender: TObject);
begin
 if (InLaunchedTestMode) then Exit;
 if (not Editor.Enabled) and (not ExerciseEditorFile) then Exit;
 PlaySoundEvent( sndJustTick );
 pntRotateTux;
end;

procedure TMainEdukaForm.PopUpMemoryDialog(Sender: TObject);
Var
 I               : Integer;

begin
 if not Editor.Enabled then Exit;
 PlaySoundEvent( sndJustTick );
 WasProc_N:=0;

 Dialog_Select_Name.Select_Name_Edit.Items.Clear;
 Dialog_Select_Name.Select_Name_Edit.Text:=DLGMEM;
 Dialog_Select_Name.InternalDialogName := Dialog_C_SM;
 for I:=0 to Editor.Lines.Count-1 do
   begin
    stxDispatchLine(GetLines_Mem, Editor.Lines.Strings[I], I);
   end;

 SenderOfDialog:=AnsiUpperCase((Sender as TComponent).Name);
 Dialog_Select_Name.PHandle:=Handle;

    ImageList.GetBitmap( Help_Q.ImageIndex       , Dialog_Select_Name.Help_Q.Bitmap);

 Dialog_Select_Name.Show;
end;

procedure InsertLine(var Editor : SyntaxTextHolder; ll : integer);
var
 i : integer;
begin
 Editor.Lines.Add('');

for i := Editor.Lines.Count - 1 downto ll do
  Editor.Lines.Strings[i] := Editor.Lines.Strings[ i - 1 ];
Editor.Lines.Strings[ ll - 1 ] := '';
end;



procedure One_Ics_Block( var Editor : SyntaxTextHolder; var Key : Word; Kappa : String);

begin
 if AnsiUpperCase(Editor.WordAtCursor) = AnsiUpperCase(Kappa) then
   begin
    if Editor.Lines.Count = Editor.CaretY then
               Editor.Lines.Add('') else
               InsertLine( Editor, Editor.CaretY + 1);

    Editor.CaretY := Editor.CaretY + 1;
    Editor.CaretX := Editor.CaretX - Length(Kappa) + 1;
    Key := 0;
   end;
end;

procedure Bi_Ics_Block( var Editor : SyntaxTextHolder; var Key : Word; Kappa1, Kappa2 : String);
var
 i, sv : integer;

begin

 if AnsiUpperCase(Editor.WordAtCursor) = AnsiUpperCase(Kappa1) then
   begin
     sv := Editor.CaretX;
     for i:= Editor.CaretX downto 1 do
       begin
        Editor.CaretX := i;
        if AnsiUpperCase(Editor.WordAtCursor) = AnsiUpperCase(Kappa2) then
           begin
            if Editor.Lines.Count = Editor.CaretY then
               Editor.Lines.Add('') else
               InsertLine( Editor, Editor.CaretY + 1);

            Editor.CaretY := Editor.CaretY + 1;
            Editor.CaretX := Editor.CaretX - Length(Kappa2) + 1;
            Key := 0;
            break;
           end;
       end;
       if Key <> 0 then Editor.CaretX := sv;
   end;

end;

procedure End_Ics_Block( var Editor : SyntaxTextHolder; var Key : Word; Kappa : String);
var
 i, sv, Delta : integer;
 xx    : string;
begin
 Delta := 1;
 if AnsiUpperCase(Editor.WordAtCursor) = AnsiUpperCase(Kappa) then
   begin
     sv := Editor.CaretX;
     for i:= Editor.CaretX downto 1 do
       begin
        Editor.CaretX := i;
        if AnsiUpperCase(Editor.WordAtCursor) = AnsiUpperCase(SY_END) then
           begin
            if Editor.WordStart.X = 2 then
             begin
               if (Editor.LineText[Editor.WordStart.X - 1] = Space) then
                begin
                 xx := Editor.LineText;
                 Delete(xx, Editor.WordStart.X - 1 ,1);
                 Editor.LineText := xx;
                 Delta := 2;
                end;
             end else
                begin
                if Editor.WordStart.X > 1 then
                   if (Editor.LineText[Editor.WordStart.X - 1] = Space) and
                      (Editor.LineText[Editor.WordStart.X - 2] = Space)
                    then
                    begin
                     xx := Editor.LineText;
                     Delete(xx, Editor.WordStart.X - 1 ,1);
                     Editor.LineText := xx;
                     Delta := 2;
                    end;
                end;
            if Editor.Lines.Count = Editor.CaretY then
               Editor.Lines.Add('') else
               InsertLine( Editor, Editor.CaretY + 1);

            Editor.CaretY := Editor.CaretY + 1;
            Editor.CaretX := Editor.CaretX - Length(SY_END) - Delta;
            Key := 0;
            break;
           end else
            if AnsiUpperCase(Editor.WordAtCursor) <> AnsiUpperCase(Kappa) then break;
       end;
       if Key <> 0 then Editor.CaretX := sv;
   end;

end;



procedure TMainEdukaForm.EditorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Key = 17) or (Key = 18) or
    (Key = 16) or (Key = 20)
 then Exit;

 ifaceErrorAdjust(True);
 
 if Key <> 13 then exit;

  if Editor.WordEnd.X <> Editor.CaretX then exit;

  Bi_Ics_Block( Editor, Key, SY_DO, SY_WHILE);
  Bi_Ics_Block( Editor, Key, SY_TIMES, SY_REPEAT);
  Bi_Ics_Block( Editor, Key, SY_THEN, SY_IF);
 { End_Ics_Block( Editor, Key, SY_IF);
 End_Ics_Block( Editor, Key, SY_WHILE); }
 End_Ics_Block( Editor, Key, SY_REPEAT);
 One_Ics_Block( Editor, Key, SY_START);
 One_Ics_Block( Editor, Key, SY_REPEAT);
end;

procedure TMainEdukaForm._EditExerciseClick(Sender: TObject);
begin
 PaintBox.Hint        := HTML_Initial;
  StatusBar.Panels[4].Text := '';

 if _EditExercise.Checked then SaveRecentFiles(CurrentInterpreter);

 _EditExercise.Checked := not _EditExercise.Checked;

 File_Close.Click;

 if not _EditExercise.Checked then Window_ResetGrid.Click;

 ifaceExerciseControls(not _EditExercise.Checked);

 LoadRecentFiles(CurrentInterpreter);
 flsSetDialogsFilter(SaveDialog, OpenDialog, CurrentInterpreter);
 TpModified := False;
 StatusBar.Panels.Items[1].Text:='';

 ifaceSetFormCaption(CurrentInterpreterName,ExtractFileName(sFileName));
 ifaceSetFormIcon(CurrentInterpreter);

 ifaceDisableGridByMove();
end;

procedure TMainEdukaForm._c_LanguageChange(Sender: TObject);
var
 Mdf : Boolean;
begin
 Mdf := TpModified;

 if Sender <> nil then
  begin
   PLangs[PrevLang].Title := _c_Title.Text;
   PLangs[PrevLang].Descr := _c_Description.Text;
   PLangs[PrevLang].Rests := _c_Restrictions.Text;
   PLangs[PrevLang].Lng   := PShortString(_c_Language.ItemsEx.Items[PrevLang].Data)^;
  end;

 _c_Title.Text        := PLangs[_c_Language.ItemIndex].Title;
 _c_Description.Text  := PLangs[_c_Language.ItemIndex].Descr;
 _c_Restrictions.Text := PLangs[_c_Language.ItemIndex].Rests;

 TpModified := Mdf;
 if TpModified then StatusBar.Panels.Items[1].Text:=MDFED else StatusBar.Panels.Items[1].Text:='';
 
 PrevLang := _c_Language.ItemIndex;
end;

procedure TMainEdukaForm._c_Grid_1Click(Sender: TObject);
begin

  PlaySoundEvent( sndJustTick );

  PaintBox.Hint        := HTML_Initial;
  Pocket_Letter.Caption := '';

  pntHideInterpreterImages(piTux);
  pntHideInterpreterImages(piAnt);
  pntHideInterpreterImages(piKng);

  if Sender <> nil then
        pntSwapPrimaryGrid ( False, otExerciseG2 );

  pntSwapPrimaryGrid ( True, otExerciseG1 );
  ifaceDisableGridByMove();

  if Sender = nil then _c_Grid_1.Checked := True;
end;

procedure TMainEdukaForm._c_Grid_2Click(Sender: TObject);
var
 Tx, Ty : Integer;
begin

  PlaySoundEvent( sndJustTick );

  PaintBox.Hint        := HTML_Final;

  Pocket_Letter.Caption := '';

  pntHideInterpreterImages(piTux);
  pntHideInterpreterImages(piAnt);
  pntHideInterpreterImages(piKng);

  if Sender <> nil then
        pntSwapPrimaryGrid ( False, otExerciseG1 );

  for Tx := 1 to TabMax do
   for Ty := 1 to TabMax do
    begin
     if tb1[tx,ty].Vert then tb2[tx,ty].Vert := True;
     if tb1[tx,ty].Oriz then tb2[tx,ty].Oriz := True;
    end;
    
  pntSwapPrimaryGrid ( True, otExerciseG2 );
  ifaceDisableGridByMove();  
end;

procedure TMainEdukaForm._c_DescriptionChange(Sender: TObject);
begin
  TpModified := True;
  StatusBar.Panels.Items[1].Text:=MDFED;
  
  ifaceActivateExerciseMemoEditControls(True, Sender as TMemo);
end;

procedure TMainEdukaForm._c_RestrictionsChange(Sender: TObject);
begin
  TpModified := True;
  StatusBar.Panels.Items[1].Text:=MDFED;

  ifaceActivateExerciseMemoEditControls(True, Sender as TMemo);
end;

procedure TMainEdukaForm._c_ExerciseEditChange(Sender: TObject);
begin
  TpModified := True;
  StatusBar.Panels.Items[1].Text:=MDFED;

  ifaceActivateExerciseMemoEditControls(True, Sender as TCustomEdit);
end;

procedure TMainEdukaForm._c_SkillChange(Sender: TObject);
begin
  TpModified := True;
  StatusBar.Panels.Items[1].Text:=MDFED;
end;

procedure TMainEdukaForm._c_DurationChange(Sender: TObject);
begin
  TpModified := True;
  StatusBar.Panels.Items[1].Text:=MDFED;
end;

procedure TMainEdukaForm._EditTestClick(Sender: TObject);
begin
 StatusBar.Panels[4].Text := '';
 if _EditTest.Checked then SaveRecentFiles(CurrentInterpreter);

 _EditTest.Checked := not _EditTest.Checked;

 File_Close.OnClick(Sender);

 if not _EditTest.Checked then Window_ResetGrid.Click;
 ifaceTestControls(not _EditTest.Checked);

 LoadRecentFiles(CurrentInterpreter);
 flsSetDialogsFilter(SaveDialog, OpenDialog, CurrentInterpreter);

 TpModified := False;
 StatusBar.Panels.Items[1].Text:='';

 ifaceSetFormCaption(CurrentInterpreterName,ExtractFileName(sFileName));
 ifaceSetFormIcon(CurrentInterpreter);

 {$IFDEF _TRIAL_}
 _c_StartTest.Enabled := False;
 _c_StartTest.Visible := False; 
 {$ENDIF}
end;

procedure TMainEdukaForm.AllMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Exercise_itemFolderNormal.Show;
 Exercise_itemFolderOver.Hide;

 Exercise_itemRemoveNormal.Show;
 Exercise_itemRemoveOver.Hide;

 Exercise_itemAddNormal.Show;
 Exercise_itemAddOver.Hide;

 Exercise_itemUpNormal.Show;
 Exercise_itemUpOver.Hide;

 Exercise_itemDownNormal.Show;
 Exercise_itemDownOver.Hide;

 diMakeStaticTextDefault( _c_StartTest );
end;

procedure TMainEdukaForm.Exercise_itemFolderNormalMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 AllMouseMove(Sender, Shift, X, Y);

 Exercise_itemFolderNormal.Hide;
 Exercise_itemFolderOver.Show;

end;

procedure TMainEdukaForm.Exercise_itemRemoveNormalMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);

begin
 AllMouseMove(Sender, Shift, X, Y);

 Exercise_itemRemoveNormal.Hide;
 Exercise_itemRemoveOver.Show;
end;

procedure TMainEdukaForm.Exercise_itemAddNormalMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 AllMouseMove(Sender, Shift, X, Y);

 Exercise_itemAddNormal.Hide;
 Exercise_itemAddOver.Show;
end;

procedure TMainEdukaForm.Exercise_itemUpNormalMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 AllMouseMove(Sender, Shift, X, Y);

 Exercise_itemUpNormal.Hide;
 Exercise_itemUpOver.Show;
end;

procedure TMainEdukaForm.Exercise_itemDownNormalMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 AllMouseMove(Sender, Shift, X, Y);

 Exercise_itemDownNormal.Hide;
 Exercise_itemDownOver.Show;
end;

procedure TMainEdukaForm.Tool_Copy_GridClick(Sender: TObject);
begin
   pntSwapPrimaryGrid ( True, otTemp );
end;

procedure TMainEdukaForm.File_ExportHTMLClick(Sender: TObject);
{$IFNDEF _TRIAL_}
var
 pqName : String;
{$ENDIF}

begin
{$IFNDEF _TRIAL_}
 PlaySoundEvent( sndJustTick );
 SoundStatus(False);
 
  ExportSaveDialog.Title := Save_Title;

{$WARNINGS OFF}
 if (ExerciseEditorMode) and (DirectoryExists(PChar(MyDocuments)+'\'+MyExercisesHtml))
    then ExportSaveDialog.InitialDir:= PChar(MyDocuments)+'\'+MyExercisesHtml else
  if (TestEditorMode) and (DirectoryExists(PChar(MyDocuments)+'\'+MyTestsHtml))
    then ExportSaveDialog.InitialDir:= PChar(MyDocuments)+'\'+MyTestsHtml else
  if DirectoryExists(PChar(MyDocuments)+'\'+MySources)
    then ExportSaveDialog.InitialDir:= PChar(MyDocuments)+'\'+MySources else
      begin
       ExportSaveDialog.InitialDir:= PChar(MyDocuments);
      end;
{$WARNINGS ON}
 ExportSaveDialog.Filter :=  HtmlFilter;
 ExportSaveDialog.FileName := '';
 if ExerciseEditorMode then
 begin
  _c_LanguageChange(_c_Language);
   if _c_Grid_1.Checked then pntSwapPrimaryGrid ( False, otExerciseG1 ) else
                             pntSwapPrimaryGrid ( False, otExerciseG2 );
  end;
 if ExportSaveDialog.Execute then
  begin
   pqName := ExportSaveDialog.FileName;

   if (UpperCase(ExtractFileExt(pqName)) = '')
    then pqName := pqName + extFileHtml;
    
    if (not ExerciseEditorMode) and (not TestEditorMode) then
     begin
      if not GridWasSaved then pntSwapPrimaryGrid( False, otExerciseG1 );
      pxtExportCodePage(pqName);
      GridWasSaved := True;
     end;

    if (ExerciseEditorMode)     and (not TestEditorMode) then pxtExportExercisePage(pqName);
    if (not ExerciseEditorMode) and (TestEditorMode)     then pxtExportTestPage(pqName);
  end;

  SoundStatus(True);
{$ENDIF}  
end;

procedure TMainEdukaForm.ifaceLoadDirectoryFiles(sDirName : String);
var
 TSrcFile     : TSearchRec;
 StName       : ShortString;
 Index, Count : integer;
 ZZAll        : Boolean;
begin

 count:=FindFirst(ExtractFilePath(sDirName)+ExtractFileName(sDirName)+ '\*.*',255,TSrcFile);

 while (Count=0) do
   begin
   StName:= ExtractFilePath(sDirName) + ExtractFileName(sDirName) + '\' + TSrcFile.Name;

   if ((TSrcFile.Attr and faDirectory) = faDirectory) and
      (TSrcFile.Name <> '.') and (TSrcFile.Name <> '..') then
         ifaceLoadDirectoryFiles(StName);

   if AnsiUpperCase(ExtractFileExt(TSrcFile.Name))='.ETK' then
   begin

   ZZAll := True;

    if iAvailableFileList > 0 then
     for Index := 0 to iAvailableFileList - 1 do
         if AvailableFileList[Index].FileName = StName then ZZAll := False;

      ExerciseEditorMode := True;
     if (flsEditorOpenFromFile(false, nil, nil, nil, nil, StName)) and (ZZAll) then
      begin
       iAvailableFileList:=iAvailableFileList+1;
       SetLength(AvailableFileList,iAvailableFileList*SizeOf(TAvailExerciseFileInfo));

       AvailableFileList[(iAvailableFileList-1)].Interpreter := CurrentExerciseInfo.Interpreter;
       AvailableFileList[(iAvailableFileList-1)].Skill := CurrentExerciseInfo.Skill;
       AvailableFileList[(iAvailableFileList-1)].Duration := CurrentExerciseInfo.Duration;

       AvailableFileList[(iAvailableFileList-1)].FileName := StName;
       AvailableFileList[(iAvailableFileList-1)].Title    := '';

       for Count := 0 to nLangs do
        if (PLangs[Count].Title<> '') then
          begin
           if (PLangs[Count].Lng = CurrentLanguageCode) then
            begin
              AvailableFileList[(iAvailableFileList-1)].FileName := StName;
              AvailableFileList[(iAvailableFileList-1)].Title     := PLangs[Count].Title;

            end;
          end;
         end; 
        end;
      ExerciseEditorMode := False;



   Count:=FindNext(TSrcFile);
  end;

  _c_Duration_I.OnChange(_c_Duration_I);

end;

procedure TMainEdukaForm.Exercise_itemFolderOverClick(Sender: TObject);
var
  S: string;
begin
  S := '';
 PlaySoundEvent( sndJustTick );

 if SelectDirectory(DIRSELECT, '', S) then
 if DirectoryExists(s) then
    ifaceLoadDirectoryFiles(S);


 ifaceAdjustTestListControls();    
end;

procedure TMainEdukaForm._c_AvailableFilesClick(Sender: TObject);
var
 Count, i : Integer;
begin

 if _c_AvailableFiles.ItemIndex = -1 then Exit;

 PlaySoundEvent( sndJustTick );
 SoundStatus(False);

 ExerciseEditorMode := True;

if flsEditorOpenFromFile(false, nil, nil, nil, nil, SortedAvailableFileList[ _c_AvailableFiles.ItemIndex ].FileName) then
 begin
   _d_Author.Text      := CurrentExerciseInfo.Author;
   case CurrentExerciseInfo.Interpreter of
    piTux : _d_Interpreter.Text := Dialog_I_Tux;
    piAnt : _d_Interpreter.Text := Dialog_I_Ant;
    piKng : _d_Interpreter.Text := Dialog_I_Kng;
   end;


   _d_Skill.Text := _c_Skill.Items.Strings[CurrentExerciseInfo.Skill];


   _d_Duration.Text  := IntToStr((CurrentExerciseInfo.Duration+1)*5) + ' ' + CBMINUTES;

 if CurrentExerciseInfo.Interpreter = piKng then
   _d_Grid_Size.Text := IntToStr(CurrentExerciseInfo.TableMax-1) + 'x' + IntToStr(CurrentExerciseInfo.TableMax-1) else
   _d_Grid_Size.Text := IntToStr(CurrentExerciseInfo.TableMax) + 'x' + IntToStr(CurrentExerciseInfo.TableMax);

    for Count := 0 to _d_Language.ItemsEx.Count-1 do
      begin
       _d_Language.ItemsEx.ComboItems[Count].SelectedImageIndex := -1;
       _d_Language.ItemsEx.ComboItems[Count].ImageIndex := -1;
      end;

     for Count := 0 to nLangs do
        if (PLangs[Count].Title<> '') and (PLangs[Count].Lng <> '') then
          begin
           if (PLangs[Count].Lng = CurrentLanguageCode) then
              begin
              _d_Language.ItemIndex := 0;

              for i := 0 to _d_Language.ItemsEx.Count - 1 do
                if PShortString(_d_Language.ItemsEx.Items[i].Data)^ = CurrentLanguageCode then
              _d_Language.ItemIndex := i;
              end;

            _d_Language.ItemsEx.ComboItems[Count].SelectedImageIndex := idxLanguageIcon;
            _d_Language.ItemsEx.ComboItems[Count].ImageIndex         := idxLanguageIcon;
          end;

   Count := _d_Language.ItemIndex;
   _d_Language.ItemIndex := -1;
   _d_Language.ItemIndex := Count;
   _d_Language.OnChange(_d_Language);
 end;
 ExerciseEditorMode := False;
 ifaceAdjustTestListControls();

 SoundStatus(True);
end;

procedure TMainEdukaForm._d_LanguageChange(Sender: TObject);
Var
 Cx : Integer;
begin
 if (Sender = nil) and  (_c_SelectedFiles.ItemIndex <> -1 ) then
    for Cx := 0 to nLangs do
        PLangs [ Cx ]  := SelectedFileList [ _c_SelectedFiles.ItemIndex ].Info2[ Cx ];


 _d_Title.Text        := PLangs[_d_Language.ItemIndex].Title;
 _d_Description.Text  := PLangs[_d_Language.ItemIndex].Descr;
 _d_Restrictions.Text := PLangs[_d_Language.ItemIndex].Rests;
end;

procedure TMainEdukaForm._c_AvailableFilesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  _c_AvailableFiles.OnClick(_c_AvailableFiles);
end;

procedure TMainEdukaForm._c_Sorters_Change(Sender: TObject);
var
 I      : Integer;
 WillGo : Boolean;
begin
 _c_AvailableFiles.Clear;
 SetLength(SortedAvailableFileList,0);
 iSortedAvailableFileList       := 0;

 if iAvailableFileList > 0 then
    for i:=0 to iAvailableFileList-1 do
     begin
      WillGo := True;

       if _c_Duration_I.ItemIndex > 0  then
         begin
          if _c_Duration_I.ItemIndex - 1 = AvailableFileList[i].Duration then WillGo := WillGo and True
             else WillGo := WillGo and False;
         end else WillGo := WillGo and True;

       if _c_Skill_I.ItemIndex > 0  then
         begin
          if _c_Skill_I.ItemIndex - 1 = AvailableFileList[i].Skill then WillGo := WillGo and True
             else WillGo := WillGo and False;
         end else WillGo := WillGo and True;

       if _c_Interpreter_I.ItemIndex > 0  then
         begin
          if _c_Interpreter_I.ItemIndex - 1 = Ord(AvailableFileList[i].Interpreter) then WillGo := WillGo and True
             else WillGo := WillGo and False;
         end else WillGo := WillGo and True;

      if WillGo then
       begin
        iSortedAvailableFileList := iSortedAvailableFileList+1;
        SetLength(SortedAvailableFileList,iSortedAvailableFileList*SizeOf(TAvailExerciseFileInfo));
        SortedAvailableFileList[(iSortedAvailableFileList - 1)] := AvailableFileList[i];
        _c_AvailableFiles.Items.Add(ExtractFileName(AvailableFileList[i].FileName));
       end;
     end;
   ifaceAdjustTestListControls();  
end;

procedure TMainEdukaForm._c_ExerciseEditMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 //
  ifaceActivateExerciseMemoEditControls(True, Sender as TCustomEdit);
end;

procedure TMainEdukaForm._c_ExerciseEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   ifaceActivateExerciseMemoEditControls(True, Sender as TCustomEdit);
end;

procedure TMainEdukaForm._c_ExerciseEditMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
   ifaceActivateExerciseMemoEditControls(True, Sender as TCustomEdit);
end;

procedure TMainEdukaForm._c_ExerciseEditContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
   iEditor := Sender as TCustomEdit;
   Handled := False;
end;

procedure TMainEdukaForm._c_ExerciseEditEnter(Sender: TObject);
begin
   iEditor := Sender as TCustomEdit;
   ifaceActivateExerciseMemoEditControls(True, Sender as TCustomEdit);
end;

procedure TMainEdukaForm._c_ExerciseEditExit(Sender: TObject);
begin
  ifaceActivateExerciseMemoEditControls(False, Sender as TCustomEdit);
end;


procedure TMainEdukaForm.Exercise_itemAddOverClick(Sender: TObject);
var
 Count : Integer;

begin
 if _c_AvailableFiles.ItemIndex = -1 then Exit;
 ExerciseEditorMode := True;

 PlaySoundEvent( sndJustTick );

if flsEditorOpenFromFile(false, nil, nil, nil, nil, SortedAvailableFileList[ _c_AvailableFiles.ItemIndex ].FileName) then
 begin

   Inc(iSelectedFileList);

   SelectedFileList[ iSelectedFileList - 1 ].FileName := SortedAvailableFileList[ _c_AvailableFiles.ItemIndex ].FileName;
   SelectedFileList[ iSelectedFileList - 1 ].Info1    := CurrentExerciseInfo;
   for Count := 0 to nLangs do
      SelectedFileList[ iSelectedFileList - 1 ].Info2[Count] := PLangs[Count];

   _c_SelectedFiles.Items.Add(ExtractFileName(SelectedFileList[ iSelectedFileList - 1 ].FileName))

 end;
 ExerciseEditorMode := False;

 ifaceAdjustTestListControls();

 TpModified := True;
 StatusBar.Panels.Items[1].Text:=MDFED;
end;

procedure TMainEdukaForm.Exercise_itemRemoveOverClick(Sender: TObject);
var
 Count : Integer;

begin
 if _c_SelectedFiles.ItemIndex = -1 then Exit;

 PlaySoundEvent( sndJustTick );

 if iSelectedFileList > _c_SelectedFiles.ItemIndex then
 for Count := _c_SelectedFiles.ItemIndex to iSelectedFileList - 2  do
    begin
      SelectedFileList [ Count ] := SelectedFileList [ Count + 1 ];
      _c_SelectedFiles.Items.Strings [ Count ] := _c_SelectedFiles.Items.Strings [ Count + 1 ];
    end;

 _c_SelectedFiles.Items.Delete(iSelectedFileList - 1);
 Dec (iSelectedFileList);

 ifaceAdjustTestListControls();
 
 TpModified := True;
 StatusBar.Panels.Items[1].Text:=MDFED;
end;

procedure TMainEdukaForm._c_SelectedFilesClick(Sender: TObject);
var
 Count, i : Integer;
begin
 Count := _c_SelectedFiles.ItemIndex;

 if Count = -1 then Exit;

 PlaySoundEvent( sndJustTick );
 SoundStatus(False);

   _d_Author.Text      := SelectedFileList [ Count ].Info1.Author;

   case SelectedFileList [ Count ].Info1.Interpreter of
    piTux : _d_Interpreter.Text := Dialog_I_Tux;
    piAnt : _d_Interpreter.Text := Dialog_I_Ant;
    piKng : _d_Interpreter.Text := Dialog_I_Kng;
   end;


   _d_Skill.Text := _c_Skill.Items.Strings[SelectedFileList [ Count ].Info1.Skill];


   _d_Duration.Text  := IntToStr((SelectedFileList [ Count ].Info1.Duration+1)*5) + ' ' + CBMINUTES;

  if SelectedFileList [ Count ].Info1.Interpreter = piKng then
   _d_Grid_Size.Text := IntToStr(SelectedFileList [ Count ].Info1.TableMax-1) + 'x' + IntToStr(SelectedFileList [ Count ].Info1.TableMax-1) else
   _d_Grid_Size.Text := IntToStr(SelectedFileList [ Count ].Info1.TableMax) + 'x' + IntToStr(SelectedFileList [ Count ].Info1.TableMax);
    for Count := 0 to _d_Language.ItemsEx.Count-1 do
      begin
       _d_Language.ItemsEx.ComboItems[Count].SelectedImageIndex := -1;
       _d_Language.ItemsEx.ComboItems[Count].ImageIndex := -1;
      end;

     for Count := 0 to nLangs do
        if ( SelectedFileList [ _c_SelectedFiles.ItemIndex ].Info2[Count].Title<> '') and (( SelectedFileList [ _c_SelectedFiles.ItemIndex ].Info2[Count].Lng<> '')) then
          begin
           if ( SelectedFileList [ _c_SelectedFiles.ItemIndex ].Info2[Count].Lng = CurrentLanguageCode) then
              begin
              _d_Language.ItemIndex := 0;

              for i := 0 to _d_Language.ItemsEx.Count - 1 do
                if PShortString(_d_Language.ItemsEx.Items[i].Data)^ = CurrentLanguageCode then

              _d_Language.ItemIndex := i;
              end;

            _d_Language.ItemsEx.ComboItems[Count].SelectedImageIndex := idxLanguageIcon;
            _d_Language.ItemsEx.ComboItems[Count].ImageIndex         := idxLanguageIcon;
          end;
          
 Count := _d_Language.ItemIndex;
 _d_Language.ItemIndex := -1;
 _d_Language.ItemIndex := Count;

 _d_Language.OnChange(nil);

 ifaceAdjustTestListControls();
  SoundStatus(True);
end;


procedure TMainEdukaForm._c_SelectedFilesKeyPress(Sender: TObject;
  var Key: Char);
begin
  _c_SelectedFiles.OnClick(_c_SelectedFiles);
end;

procedure TMainEdukaForm.Exercise_itemUpOverClick(Sender: TObject);
var
 Temp    : TSelExerciseFileInfo;
begin
 if _c_SelectedFiles.ItemIndex = -1 then Exit;
 if _c_SelectedFiles.ItemIndex = 0 then Exit;

 PlaySoundEvent( sndJustTick );

    Temp :=  SelectedFileList [ _c_SelectedFiles.ItemIndex ];
    SelectedFileList [ _c_SelectedFiles.ItemIndex ] := SelectedFileList [ _c_SelectedFiles.ItemIndex - 1 ];
    SelectedFileList [ _c_SelectedFiles.ItemIndex - 1 ] := Temp;

  _c_SelectedFiles.Items.Exchange(_c_SelectedFiles.ItemIndex, _c_SelectedFiles.ItemIndex - 1 );
  ifaceAdjustTestListControls();
  
 TpModified := True;
 StatusBar.Panels.Items[1].Text:=MDFED;
end;

procedure TMainEdukaForm.Exercise_itemDownOverClick(Sender: TObject);
var
 Temp    : TSelExerciseFileInfo;
begin
 if _c_SelectedFiles.ItemIndex = -1 then Exit;
 if _c_SelectedFiles.ItemIndex = iSelectedFileList - 1 then Exit;

 PlaySoundEvent( sndJustTick );
 
    Temp :=  SelectedFileList [ _c_SelectedFiles.ItemIndex ];
    SelectedFileList [ _c_SelectedFiles.ItemIndex ] := SelectedFileList [ _c_SelectedFiles.ItemIndex + 1 ];
    SelectedFileList [ _c_SelectedFiles.ItemIndex + 1 ] := Temp;

  _c_SelectedFiles.Items.Exchange(_c_SelectedFiles.ItemIndex, _c_SelectedFiles.ItemIndex + 1 );
  ifaceAdjustTestListControls();
  
 TpModified := True;
 StatusBar.Panels.Items[1].Text := MDFED;
end;

procedure TMainEdukaForm.Error_Panel_ImageClick(Sender: TObject);
begin
 if CurrentHelpFile='' then Exit;
 OHelpContext := (Sender as TControl).HelpContext;
 OHelpPage    := (Sender as TControl).HelpKeyword;

 ContextHelp.PopupPoint := Point( Left + Error_Panel.Left, Top + Error_Panel.Top);
 Context_Form.Help_QDisplay;
end;

procedure TMainEdukaForm._c_StartTestClick(Sender: TObject);
begin

 PlaySoundEvent( sndJustTick );

 if iSelectedFileList = 0 then Exit;
 Dialog_Select_Student.edt_StudInfo.Text := '';
 Dialog_Select_Student.edt_ExportFile.Text := '';

 Dialog_Select_Student.PHandle := Handle;

 ImageList.GetBitmap( Help_Q.ImageIndex       , Dialog_Select_Student.Help_Q.Bitmap);

 Dialog_Select_Student.Show;
end;

procedure TMainEdukaForm.Exercise_ExerciseEnter(Sender: TObject);
begin
 if (Editor.Enabled) then
  begin
    ActiveControl:=Editor;
    ifaceErrorAdjust(True);
  end else
  ActiveControl:=nil;
end;

procedure TMainEdukaForm.Tool_Exercise_ShowClick(Sender: TObject);
begin
 if ErrorShown then Exit;
 PlaySoundEvent( sndJustTick );
 WasExerciseShow := not WasExerciseShow;

 Tool_Exercise_Show.Down := WasExerciseShow;

 ifaceExerciseCondAdjust( WasExerciseShow );
end;

procedure TMainEdukaForm.Tool_Exercise_Cond2Click(Sender: TObject);
begin
 if (Tool_Exercise_Cond2.Down) and (Sender <> nil) then Exit;


 if (not TstSelectedGrid1) and (Sender <> nil) then
  begin
    Tool_Exercise_Cond2.Down := True;
    Exit;
  end;

 TstSelectedGrid1 := False;

 PlaySoundEvent( sndJustTick );

  PaintBox.Hint        := HTML_Final;
  Pocket_Letter.Caption := '';

  pntSwapPrimaryGrid ( True, otTestG2,  CurrentExerciseNr);

 if Sender <> nil then Tool_Exercise_Cond2.Down := not Tool_Exercise_Cond2.Down;

 Tool_Exercise_Cond1.Down := not Tool_Exercise_Cond2.Down;
end;

procedure TMainEdukaForm.Tool_Exercise_Cond1Click(Sender: TObject);
begin

 if (Tool_Exercise_Cond1.Down) and (Sender <> nil) then Exit;

 if (TstSelectedGrid1) and (Sender <> nil) then
  begin
    Tool_Exercise_Cond1.Down := True;
    Exit;
  end;

 TstSelectedGrid1 := True;

 PlaySoundEvent( sndJustTick );
 
  PaintBox.Hint        := HTML_Initial;
  Pocket_Letter.Caption := '';

  pntSwapPrimaryGrid ( True, otTestG1,  CurrentExerciseNr);

 if Sender <> nil then Tool_Exercise_Cond1.Down := not Tool_Exercise_Cond1.Down;

 Tool_Exercise_Cond2.Down := not Tool_Exercise_Cond1.Down;
end;

procedure TMainEdukaForm.Tool_Exercise_PrevClick(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
 SoundStatus(False);

 if CurrentExerciseNr < 1 then
    Tool_Exercise_Prev.Enabled := False else
    Dec(CurrentExerciseNr);

 if CurrentExerciseNr < 1 then
    Tool_Exercise_Prev.Enabled := False;

 if CurrentExerciseNr < iSelectedFileList - 1 then
    Tool_Exercise_Next.Enabled := True else Tool_Exercise_Next.Enabled := False;

  AnimalReset := False;
  
     if SelectedFileList [ CurrentExerciseNr ].Info1.Interpreter <> CurrentInterpreter then
       begin
         Dialog_Select_Interpreter.Speed_Kng.Down := False;
         Dialog_Select_Interpreter.Speed_ant.Down := False;
         Dialog_Select_Interpreter.Speed_tux.Down := False;

        case SelectedFileList [ CurrentExerciseNr ].Info1.Interpreter of
         piAnt : Dialog_Select_Interpreter.Speed_ant.Down := True;
         piKng : Dialog_Select_Interpreter.Speed_Kng.Down := True;
         piTux : Dialog_Select_Interpreter.Speed_tux.Down := True;
        end;
         SendMessage(Handle, WM_SelectInterpreterClose, 0, 0);
       end;

  if TabMax <> SelectedFileList [ CurrentExerciseNr ].Info1.TableMax then
      SendMessage(Handle,WM_SetGridSize,pntGridDePixelate(SelectedFileList [ CurrentExerciseNr ].Info1.TableMax, SelectedFileList [ CurrentExerciseNr ].Info1.Interpreter),0);

  AnimalReset := True;

  ifaceMoveExerciseToEditor(CurrentExerciseNr+1);

    if TstSelectedGrid1 then Tool_Exercise_Cond1.OnClick(nil);
    if not TstSelectedGrid1 then Tool_Exercise_Cond2.OnClick(nil);

   SoundStatus(True);
end;

procedure TMainEdukaForm.Tool_Exercise_NextClick(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );

 SoundStatus(False);

 if CurrentExerciseNr >= iSelectedFileList - 1 then
    Tool_Exercise_Next.Enabled := False else
    Inc(CurrentExerciseNr);

 if CurrentExerciseNr >= iSelectedFileList - 1 then
    Tool_Exercise_Next.Enabled := False;

 if CurrentExerciseNr > 0 then
    Tool_Exercise_Prev.Enabled := True else Tool_Exercise_Prev.Enabled := False;

  AnimalReset := False;

     if SelectedFileList [ CurrentExerciseNr ].Info1.Interpreter <> CurrentInterpreter then
       begin
         Dialog_Select_Interpreter.Speed_Kng.Down := False;
         Dialog_Select_Interpreter.Speed_ant.Down := False;
         Dialog_Select_Interpreter.Speed_tux.Down := False;

        case SelectedFileList [ CurrentExerciseNr ].Info1.Interpreter of
         piAnt : Dialog_Select_Interpreter.Speed_ant.Down := True;
         piKng : Dialog_Select_Interpreter.Speed_Kng.Down := True;
         piTux : Dialog_Select_Interpreter.Speed_tux.Down := True;
        end;
         SendMessage(Handle, WM_SelectInterpreterClose, 0, 0);
       end;


  if TabMax <> SelectedFileList [ CurrentExerciseNr ].Info1.TableMax then
      SendMessage(Handle,WM_SetGridSize,pntGridDePixelate(SelectedFileList [ CurrentExerciseNr ].Info1.TableMax,SelectedFileList [ CurrentExerciseNr ].Info1.Interpreter),0);

  AnimalReset := True;

  ifaceMoveExerciseToEditor(CurrentExerciseNr-1);

    if TstSelectedGrid1 then Tool_Exercise_Cond1.OnClick( nil );
    if not TstSelectedGrid1 then Tool_Exercise_Cond2.OnClick( nil );
  
   SoundStatus(True);
end;

procedure TMainEdukaForm.Edit_ShowLinesClick(Sender: TObject);
begin
 if Editor.Marks.Count > 0 then Exit;

 Edit_ShowLines.Checked:=not Edit_ShowLines.Checked;

 if Edit_ShowLines.Checked then
   begin
     Edit_ShowLines.ImageIndex := idxShowLinesCheckedIcon;
     Editor.Gutter.Visible := True;
   end else
   begin
     Edit_ShowLines.ImageIndex := idxShowLinesNormalIcon;
     Editor.Gutter.Visible := False;
   end;
end;

procedure TMainEdukaForm.Options_HighlightClick(Sender: TObject);
begin
  Options_Highlight.Checked := not Options_Highlight.Checked;
  StepByStepHighlighting    := Options_Highlight.Checked;

  if StepByStepHighlighting then Options_Highlight.ImageIndex := idxHighlightNormalIcon else
                                 Options_Highlight.ImageIndex := idxHighlightCheckedIcon;

  if (not StepByStepHighlighting) and (ExecutionStarted) then
  begin
   Editor.SelStart:=0;
   Editor.SelEnd:=0;
  end;

  if (StepByStepHighlighting) and (ExecutionStarted) then
  begin
    edtPositionateCursor(Editor,CurrentStart-1,CurrentLine);
    Editor.SelEnd := Editor.SelStart + CurrentEnd - CurrentStart;
  end;

end;


procedure TMainEdukaForm.MemoryTimerTimer(Sender: TObject);
begin
 if Application.Terminated then Exit;
 
 StatusBar.Panels[5].Text := IntToStr(AllocMemSize div 1024) +' Kb';
end;

procedure TMainEdukaForm.Window_SaveGridClick(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
 
 if not ExerciseEditorFile then
  pntSwapPrimaryGrid( False, otExerciseG1 );
  
  pntSwapPrimaryGrid( False, otTemp );
  GridWasSaved := True;

 ifaceDisableGridByMove();
end;

procedure TMainEdukaForm.Window_ClearGridClick(Sender: TObject);
begin
  PlaySoundEvent( sndJustTick );

  pntHideInterpreterImages(piAnt);
  pntHideInterpreterImages(piKng);
  pntHideInterpreterImages(piTux);

  pntInitializeValues(True, True);
  Pocket_Letter.Caption := '';
  pntRedrawWholeTable();

  ifaceDisableGridByMove();
end;

procedure TMainEdukaForm.Edit_charContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
 Handled := True;
end;

procedure TMainEdukaForm.aa_imageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 ReX, ReY : Integer;
begin
 ReX := (Sender as TImage).ClientToParent(Point(X,Y)).X;
 ReY := (Sender as TImage).ClientToParent(Point(X,Y)).Y;

 ReX := ReX - PaintBox.Left;
 ReY := ReY - PaintBox.Top;

 PaintBoxMouseDown(Sender, Button, Shift, ReX, ReY);
end;

procedure TMainEdukaForm._c_LanguageDropDown(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
end;

procedure TMainEdukaForm._c_SkillDropDown(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
end;

procedure TMainEdukaForm._c_DurationDropDown(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
end;

procedure TMainEdukaForm._d_LanguageDropDown(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
end;

procedure TMainEdukaForm._c_Duration_IDropDown(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
end;

procedure TMainEdukaForm._c_Skill_IDropDown(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
end;

procedure TMainEdukaForm._c_Interpreter_IDropDown(Sender: TObject);
begin
 PlaySoundEvent( sndJustTick );
end;

procedure TMainEdukaForm.Program_StepClick(Sender: TObject);
begin
{$IFNDEF _TRIAL_}
  if StartedInStepMode then WaitForNewStep := True else
  begin
   WaitForNewStep    := True;
   StartedInStepMode := True;
   Program_Run.Click();
  end;
{$ENDIF}  
end;

procedure TMainEdukaForm.EditorGutterClick(Sender: TObject; X, Y,
  Line: Integer; mark: TSynEditMark);
begin
  if not ConsiderNextClick then Exit;
  
{$IFNDEF _TRIAL_}
  ifaceBookMark(Line);
{$ENDIF}  
end;

procedure TMainEdukaForm.Program_Stop_PointClick(Sender: TObject);
begin

{$IFNDEF _TRIAL_}
  ifaceBookMark(Editor.CaretY);
{$ENDIF}
end;

procedure TMainEdukaForm._PackageManagerClick(Sender: TObject);
begin

 PackageForm.NoShow := False;
 PackageForm.ShowModal();

end;

procedure TMainEdukaForm.FormShow(Sender: TObject);
begin
{------------------- REG -----------------------}

  msSetMenuStyles( MainMenu );
  msSetMenuStyles( ContextMenu );
  msSetMenuStyles( Context_Help );

{$IFNDEF _TRIAL_}
try
  if ValidateKeyInfo( RegLKey, RegUser, RegOrg, RegInfo, RegDate ) then;
except
       on Exception do
          begin
            RegisterForm.ifaceSetAnnoyStateRegistration();

            if RegisterForm.ShowModal() = mrOK then
               AboutForm.lbReg.OnClick(AboutForm.lbReg);
          end;
end;


{-----------------------------------------------}

 if AdministrativeStart then
 begin                 

  if AdministrationPassword = '' then
     begin
      Dialog_Check_Save.InformativeMessage( Dialog_C_NOTPK, DLG_MSG_NOPASS, 1 );
      Exit;
     end;

  LoginForm.Caption             := DLG_LOGIN_FC;
  LoginForm.lbLoginCapt.Caption := DLG_LOGIN_LC;
  LoginForm.btLogin.Caption     := DLG_LOGIN_BC;

  if LoginForm.ShowModal() = mrOK then
   begin
    if LoginForm.edtLogin.Text <> AdministrationPassword then
      begin
        Dialog_Check_Save.InformativeMessage( Dialog_C_NOTPK, DLG_MSG_WRONGPASS, 2 );
        Self.File_Exit.Click();
      end;

   end else
   begin
        Self.File_Exit.Click();
   end;
 end;
{$ENDIF}
end;

procedure TMainEdukaForm.btSetPassClick(Sender: TObject);
var
 NewPass : string;
begin
  diMakeStaticTextDefault( btSetPass );

  PlaySoundEvent( sndJustTick );
  
  LoginForm.edtLogin.Text       := '';
  LoginForm.Caption             := DLG_LOGIN_FC1;
  LoginForm.lbLoginCapt.Caption := DLG_LOGIN_LC1;
  LoginForm.btLogin.Caption     := DLG_LOGIN_BC1;

  if LoginForm.ShowModal() = mrOK then
   begin
    NewPass := LoginForm.edtLogin.Text;
    LoginForm.edtLogin.Text := '';

    LoginForm.Caption             := DLG_LOGIN_FC2;
    LoginForm.lbLoginCapt.Caption := DLG_LOGIN_LC2;
    LoginForm.btLogin.Caption     := DLG_LOGIN_BC2;

    LoginForm.ShowModal();

    if LoginForm.edtLogin.Text <> NewPass then
           Dialog_Check_Save.InformativeMessage( Dialog_C_NOTPK, DLG_MSG_MISSPASS, 2 )
          else
          begin
           AdministrationPassword := NewPass;
           RegSaveExtendedOpts();

//           SaveOption('AdministrationPassword' ,VKey, EncryptPass( NewPass ) ,RKEY);
           Dialog_Check_Save.InformativeMessage( Dialog_C_NOTPK, DLG_MSG_NEWPASS, 1 );
          end;
   end;
end;

procedure TMainEdukaForm.mEnableAdmOptsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 ActiveControl := nil;
end;

procedure TMainEdukaForm.btSetPassMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 if (Sender as TJvStaticText).Name = btQuitAdm.Name then
                      diMakeStaticTextDefault( btSetPass ) else
                      diMakeStaticTextDefault( btQuitAdm );
 
 diMakeStaticTextActive( Sender as TJvStaticText );
end;

procedure TMainEdukaForm.AdminPanelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 diMakeStaticTextDefault( btSetPass );
 diMakeStaticTextDefault( btQuitAdm );
end;

procedure TMainEdukaForm.btQuitAdmClick(Sender: TObject);
begin
 File_Exit.Click();
end;

procedure TMainEdukaForm._c_StartTestMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 AllMouseMove(Sender, Shift, X, Y);
 diMakeStaticTextActive( Sender as TJvStaticText );
end;

procedure TMainEdukaForm.Options_SoundClick(Sender: TObject);
begin
 Options_Sound.Checked:=not Options_Sound.Checked;

 if Options_Sound.Checked then
   begin
     Options_Sound.ImageIndex := idxSoundCheckedIcon;
     MainDisableSound := False;
   end else
   begin
     Options_Sound.ImageIndex := idxSoundNormalIcon;
     MainDisableSound := True;
   end;
end;

procedure TMainEdukaForm.RegSaveExtendedOpts;
var
 Opts, b1, b2, b3, b4 : String;
begin

{   SaveOption('ExtendedDynamic' ,VKey, IntToStr(Integer(cbEnableDyno.Checked)),RKEY);
   SaveOption('ExtendedPackage' ,VKey, IntToStr(Integer(cbEnableAdmOpts.Checked)),RKEY);
   SaveOption('ExtendedDebug'   ,VKey, IntToStr(Integer(cbEnableDebug.Checked)),RKEY);
   SaveOption('ExtendedAcademic',VKey, IntToStr(Integer(cbEnableTst.Checked)),RKEY);
}

 if (cbEnableAdmOpts.Checked) then b1 := '1' else b1 := '-';
 if (cbEnableDyno.Checked)    then b2 := '1' else b2 := '2';
 if (cbEnableDebug.Checked)   then b3 := '1' else b3 := '8';
 if (cbEnableTst.Checked)     then b4 := '1' else b4 := 'a';

 Opts := b1 + b2 + b3 + b4 + AdministrationPassword;

 Opts := StringToBinaryCode( Opts );
 Opts := StringToByteRep( Opts );
 
 SaveOption('ExtendedOpts' ,VKey, Opts,RKEY);
end;

procedure TMainEdukaForm.ExceptionHandler(Sender: TObject; E: Exception);
begin
 ExceptionHandler( Sender, E );
end;

procedure TMainEdukaForm.ShowErrorWindow(var Msg: TMessage);
begin
 stxErrorIntern();
end;

end.


