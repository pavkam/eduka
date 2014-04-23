(*


The Original Code is: DesignInside.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains mostly constants that identify coloring/styling, etc...
    of controls used in project. There are a set of routines used in
    styling TStaticTexts.

*)

{ Include Compile Directives ! }
{$I Utils\Directives.inc}
unit DesignInside;

interface
uses
  Windows, Graphics, Controls, StdCtrls, Utils, ProTypes, JvStaticText, JvMenus
{$IFDEF _DEBUG2_}
 ,Debug
{$ENDIF}
;

{$IFDEF _DEBUG2_}
Const
  DbgUName  =  '/DesignInside/DesignInside.pas';
{$ENDIF}

Const

 {
  The following constants are indexes in TMainForm.ImageList . They are
  used to identify every image with a Idx (Index), and creates an easy
  way to acces needed images at runtime.
 }

 {
  Test Editor Mode On-Form images and ComboBox images.
 }

 idxLanguageIcon        = 56;
 idxTitleIcon           = 77;
 idxInterpreterIcon     = 57;
 idxDurationIcon        = 73;
 idxSkillIcon           = 76;
 idxAuthorIcon          = 61;
 idxGridIcon            = 87;

 {
  Test Editor Mode : Folder/Add/Remove/Up/Down
  image indexes.
   There are 2 modes : Normal/Over, identfying
  a normal and a highlighted image.
 }
 idxItemAddOverIcon      = 81;
 idxItemAddNormalIcon    = 85;

 idxItemRemoveOverIcon   = 80;
 idxItemRemoveNormalIcon = 84;

 idxItemFolderOverIcon   = 89;
 idxItemFolderNormalIcon = 88;

 idxItemUpOverIcon       = 82;
 idxItemUpNormalIcon     = 86;

 idxItemDownOverIcon     = 79;
 idxItemDownNormalIcon   = 83;

 {
  Editor specific button modes indexes.
 }

 idxExtendEditNormalIcon   =  8;
 idxExtendEditCheckedIcon  =  9;

 idxShowLinesNormalIcon      = 14;
 idxShowLinesCheckedIcon     = 13;

 idxHighlightNormalIcon      = 100;
 idxHighlightCheckedIcon     = 101;

 idxSoundNormalIcon          = 106;
 idxSoundCheckedIcon         = 107;

 {
  ComboBox only items.
 }

 idxTimerAllMinutes          = 29;
 idxTimer05Minutes           = 62;
 idxTimer10Minutes           = 63;
 idxTimer15Minutes           = 64;
 idxTimer20Minutes           = 65;
 idxTimer25Minutes           = 66;
 idxTimer30Minutes           = 67;
 idxTimer35Minutes           = 68;
 idxTimer40Minutes           = 69;
 idxTimer45Minutes           = 70;

 idxSkillAllSkills           = 29;
 idxSkillNoviceSkill         = 76;
 idxSkillAdvancedSkill       = 74;
 idxSkillExpertSkill         = 75;

 idxInterpreterAll           = 29;
 idxInterpreterKng           = 16;
 idxInterpreterAnt           = 15;
 idxInterpreterTux           = 17;

 {
  Error Helper Items. 4 Error modes available :
    - Normal
    - Fatal
    - Medium
    - Runtime
 }

 idxErrorNormalIcon          = 54;
 idxErrorFatalIcon           = 52;
 idxErrorMediumIcon          = 51;
 idxErrorRuntimeIcon         = 53;

 {
  InLaunched mode Exercise modes.
 }

 idxExerciseConditionIcon        = 93;
 idxExerciseNowResolvedIcon      = 92;
 idxExerciseWasResolvedIcon      = 94;


 {
  Constants related to Colouring of TStaticTexts.
  The following items apply mostly to all controls
  in the Project. Most Design-Time properties of
  objects are replaced with this settings.
 }

 ppActiveStaticColor       = clCream;//clBtnFace;
 ppActiveStaticFontColor   = clBlack;//clNavy;
 ppDefaultStaticColor      = $00CBD1CC;//clBtnFace;//clLtGray;
 ppDefaultStaticFontColor  = clNavy;//clBlack;
 ppLettersColor            = clPurple;
 ppDefaultStaticMoveFontColor = clCream;

 pdActiveStaticColor       = clWhite;
 pdActiveStaticFontColor   = clNavy;
 pdDefaultStaticColor      = clCream;
 pdDefaultStaticFontColor  = clNavy;
 pdLettersColor            = clNavy;
 pdDefaultStaticMoveFontColor = clRed;

 ptPocketColor             =  clBtnFace;
 ptPocketFontSize          =  14;
 ptPocketFontStyles        =  [fsBold];
 ptPocketFontColor         =  ppLettersColor;
 ptTextFontColor           =  clNavy;

 ptMsgSgColor              =  clBtnFace;
 ptMsgSgFontSize           =  8;
 ptMsgSgFontStyles         =  [fsBold];
 ptMsgSgFontColor          =  clNavy;

 {
  Editor state constants
 }

 EditorActiveColor       = clWhite;
 EditorDisabledColor     = clMedGray;

 EditorSelErrorColor     = clRed;
 EditorSelNormColor      = clHighlight;

 ErrorLineColor          = clBlue;
 ErrorMessageColor       = clRed;
 ErrorInsertColor        = clBlack;

 {
  Default font is used to identify the standard font
  to be used in the Project. If it is not found on
  a System ( Win95/98 default installation ), the Add
  Font is used.
 }
 DefaultFont             = 'Tahoma';
 AddFont                 = 'Arial';


// Forms
 FormColor               = clBtnFace;
 FormCharset             = DEFAULT_CHARSET;
 FormFontColor           = clWindowText;
 FormFontSize            = 8;
 FormFontStyles          = [];

// Panels
 PanelColor              = FormColor;
 PanelCharset            = DEFAULT_CHARSET;
 PanelFontColor          = clWindowText;
 PanelFontSize           = 8;
 PanelFontStyles         = [];

// SpeedButtons;
 SpeedButtonCharset      = DEFAULT_CHARSET;
 SpeedButtonFontColor    = clWindowText;
 SpeedButtonFontSize     = 8;
 SpeedButtonFontStyles   = [];

// Other controla
 PaintBoxColor           = FormColor;
 StatusBarColor          = FormColor;
 ToolBarColor            = FormColor;
 EditCharColor           = clInactiveBorder;
 StaticSpeedColor        = FormColor;

// Spin Edit Options
 SpinEditColor           = clMedGray;
 SpinEditCharset         = DEFAULT_CHARSET;
 SpinEditFontColor       = clWhite;
 SpinEditFontSize        = 8;
 SpinEditFontStyles      = [];

// ComboBox Options !
 ComboEditColor           = clMedGray;
 ComboEditCharset         = DEFAULT_CHARSET;
 ComboEditFontColor       = clWhite;
 ComboEditFontSize        = 8;
 ComboEditFontStyles      = [fsBold];

// ListBox Options !
 ListBoxColor             = clMedGray;
 ListBoxCharset           = DEFAULT_CHARSET;
 ListBoxFontColor         = clWhite;
 ListBoxFontSize          = 8;
 ListBoxFontStyles        = [fsBold];

// Memo !
 MemoColor             = FormColor;
 MemoCharset           = DEFAULT_CHARSET;
 MemoFontColor         = clNavy;
 MemoFontSize          = 9;
 MemoFontStyles        = [];

// HelpEdit !
 HelpEditColor             = clCream;
 HelpEditCharset           = DEFAULT_CHARSET;
 HelpEditFontColor         = clBlack;
 HelpEditFontSize          = 8;
 HelpEditFontStyles        = [];
 HelpEditFontName          = 'Tahoma';

// Edits ---

 _eEditColor               = clWhite;
 _fEditColor               = clBlack;

// Syntax !
  AntKeywordsColor         = clNavy;
  AntKeywordsStyle         = [];

  KngKeywordsColor         = clNavy;
  KngKeywordsStyle         = [];

  TuxKeywordsColor         = clNavy;
  TuxKeywordsStyle         = [];

  IdentifierColor          = clPurple;
  IdentifierStyle          = [fsItalic];

  ConditionColor           = clMaroon;
  ConditionStyle           = [];

  CommentColor             = clGray;
  CommentStyle             = [];

  KeyWordsColor            = clBlack;
  KeyWordsStyle            = [fsBold];

// Other Text Tools !
  HighlightFG              = clWhite;
  HighlightBG              = clGreen;


  ExerciseIsOKColor            = clOlive;
  ExerciseIsOKStyle            = [fsBold];

  ExerciseWasOKColor            = clOlive;
  ExerciseWasOKStyle            = [fsBold];

  ExerciseNotOKColor            = clOlive;
  ExerciseNotOKStyle            = [fsBold];

  ExerciseIndexTitleColor       = clBlue;
  ExerciseIndexTitleStyle       = [fsBold];

  ExerciseTextTitleColor        = clBlack;
  ExerciseTextTitleStyle        = [];

  ExerciseTextDescrColor        = clBlack;
  ExerciseTextDescrStyle        = [];

  ExerciseTextRestsColor        = clBlack;
  ExerciseTextRestsStyle        = [];

  // HTML Coloristic Constants

   AntLandColor_1 = '#E9E9E1';
   AntLandColor_2 = '#BEC1BA';
   AntLandColor_3 = '#E0E2D7';

   KngLandColor_1 = '#DDD7C9';
   KngLandColor_2 = '#BEB598';
   KngLandColor_3 = '#D1CAB7';

   TuxLandColor_1 = '#F3F3FF';
   TuxLandColor_2 = '#E1E1FF';
   TuxLandColor_3 = '#E9E9FF';

Var
 MainUsedFont              : String;
 ActiveStaticColor         : Integer;
 ActiveStaticFontColor     : Integer;

 DefaultStaticColor        : Integer;
 DefaultStaticFontColor    : Integer;
 DefaultStaticMoveFontColor    : Integer;
 LettersColor              : Integer;

 MenusStyle                : TJvMenuStyle;


procedure diMakeStaticTextActive      (StaticObject : TJvStaticText);
procedure diMakeMoveStaticTextDefault (StaticObject : TJvStaticText);
procedure diMakeStaticTextDefault     (StaticObject : TJvStaticText);
Procedure diMakeStaticTextPressed     (StaticObject : TJvStaticText);
Procedure diMakeStaticTextReleased    (StaticObject : TJvStaticText);

Procedure msSetMenuStyles             (MenuObject   : TJvMainMenu); overload;
Procedure msSetMenuStyles             (MenuObject   : TJvPopupMenu); overload;

implementation

(*
 *  msSetMenuStyles
 *)
Procedure msSetMenuStyles(MenuObject   : TJvMainMenu); overload;
begin
 MenuObject.Style := MenusStyle;
end;

Procedure msSetMenuStyles(MenuObject   : TJvPopupMenu); overload;
begin
 MenuObject.Style := MenusStyle;
end;


(*
 *  MakeStaticTextActive
 *)
Procedure diMakeStaticTextActive(StaticObject : TJvStaticText);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : MakeStaticTextActive (StaticObject:'+DbgObject(StaticObject)+')');
 {$ENDIF}

  StaticObject.Color      := ActiveStaticColor;
{$IFDEF _FONTSTYLE_}
  StaticObject.Font.Color := ActiveStaticFontColor;
  //StaticObject.Font.Style := {[fsItalic];//}[fsBold];
  { TODO : Ion sa se uite la designnul la butoane }
{$ENDIF}
end;

(*
 *  MakeStaticTextDefault
 *)
procedure diMakeStaticTextDefault(StaticObject : TJvStaticText);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : MakeStaticTextDefault (StaticObject:'+DbgObject(StaticObject)+')');
 {$ENDIF}

 StaticObject.BevelInner := bvLowered;
 StaticObject.BevelKind  := bkFlat;
 StaticObject.BevelOuter := bvRaised;
 StaticObject.Color      := DefaultStaticColor;
 StaticObject.Cursor     := crHandPoint;

{$IFDEF _FONTSTYLE_}
 StaticObject.Font.Color := DefaultStaticFontColor;
 StaticObject.Font.Name  := MainUsedFont;
 StaticObject.Font.Style := [];
{$ENDIF}

end;

(*
 *  MakeMoveStaticTextDefault
 *)
procedure diMakeMoveStaticTextDefault(StaticObject : TJvStaticText);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : MakeMoveStaticTextDefault (StaticObject:'+DbgObject(StaticObject)+')');
 {$ENDIF}

 StaticObject.BevelInner := bvLowered;
 StaticObject.BevelKind  := bkFlat;
 StaticObject.BevelOuter := bvRaised;
 StaticObject.Color      := DefaultStaticColor;
 StaticObject.Cursor     := crHandPoint;

{$IFDEF _FONTSTYLE_}
 StaticObject.Font.Color := DefaultStaticMoveFontColor;
 StaticObject.Font.Style := [fsBold];
{$ENDIF} 
end;

(*
 *  MakeStaticTextPressed
 *)
Procedure diMakeStaticTextPressed(StaticObject : TJvStaticText);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : MakeStaticTextPressed (StaticObject:'+DbgObject(StaticObject)+')');
 {$ENDIF}

 StaticObject.BevelKind  := bkTile;

end;

(*
 *  MakeStaticTextReleased
 *)
Procedure diMakeStaticTextReleased(StaticObject : TJvStaticText);
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : MakeStaticTextReleased (StaticObject:'+DbgObject(StaticObject)+')');
 {$ENDIF}

 StaticObject.BevelKind:=bkFlat;

end;

end.
