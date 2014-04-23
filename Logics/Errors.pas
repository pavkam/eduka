(*

The Original Code is: Errors.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains implementation of Error Handling routines.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit Errors;
interface
uses Windows, ProTypes, EditorFuncs, DesignInside, Translate, SysUtils, StdCtrls, ExtCtrls,
     Controls, Graphics, Utils, JvStaticText
{$IFDEF _DEBUG_}
 ,Debug
{$ENDIF}
;
{$IFDEF _DEBUG_}
Const
        DbgUName          = '/Logic/Errors.pas';
{$ENDIF}

var
 SelLine, SelStart,
   SelLen          : Integer;
 ErrorShown, RuntimeCycle
                   : Boolean;

procedure stxInitializeErrorsUnit ( iImageList_ : TImageList; iPanel_ : TPanel;
                                    iImage_ : TImage; ErrorHolder : HLPSyntaxTextHolder;
                                    Holder_ : SyntaxTextHolder; Msg_Label_ : TJvStaticText; _WHandle : HWND);

procedure stxError                ( Message_0, Subst_1 , Subst_2 : String;
                                    Line, St, En : Integer; eStyle : TErrorStyle; ErrId : Integer);

procedure stxErrorIntern;

procedure stxHighlightWord        (pSt, pEn, pLn : Integer; Needed : Boolean);

implementation


var
 Holder  : SyntaxTextHolder;
 EHolder : HLPSyntaxTextHolder;
 iPanel  : TPanel;
 iImage  : TImage;
 iImageList: TImageList;
 Msg_Label : TJvStaticText;

 _Message_0, _Subst_1, _Subst_2  : String;
 _Line, _St, _En, _ErrId         : Integer;
 _eStyle                         : TErrorStyle;
 m_WHandle                       : HWND;
(*
 * stxInitializeErrorsUnit
 *)

procedure stxInitializeErrorsUnit;
begin


 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : InitializeErrorsUnit (iImageList_:'+DbgObject(iImageList_)+'; iPanel_:'+DbgObject(iPanel_)+'; iImage_:'+
                                    DbgObject(iImage_)+'; ErrorHolder:'+DbgObject(ErrorHolder)+'; Holder_:'+
                                    DbgObject(Holder_)+'; Msg_Label_:'+DbgObject(Msg_Label_)+'; _WHandle_:'+DbgInt(_WHandle)+')');

   DbgPlus;
 {$ENDIF}

 ErrorShown :=false;
 EHolder:=ErrorHolder;
 Holder:=Holder_;
 Msg_Label := Msg_Label_;
 iPanel := iPanel_;
 iImage := iImage_;
 iImageList :=  iImageList_;
 m_WHandle := _WHandle;
 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : InitializeErrorsUnit = void');
 {$ENDIF}
end;

(*
 * stxErrorIntern
 *)

procedure stxErrorIntern;
var
 Pst   : Integer;
 UT,PT : String;
 tBmp  : TBitmap;

begin

 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : stxErrorIntern (Message_0:'+DbgStr(_Message_0)+'; Subst_1:'+DbgStr(_Subst_1)+'; Subst_2:'+DbgStr(_Subst_2)+'; Line:'+DbgInt(_Line)+'; St:'+DbgInt(_St)+'; En:'+DbgInt(_En)+'; eStyle:'+DbgInt(Ord(_eStyle))+'; ErrId:'+DbgInt(_ErrId)+')');
   DbgPlus;
 {$ENDIF}

 Pst:=Pos('%d',_Message_0);
 if Pst<>0 then
  begin
   Delete(_Message_0,pst,2);
   Insert(_Subst_2,_Message_0,Pst);
  end;

 Pst:=Pos('%s',_Message_0);
 if Pst<>0 then
  begin
   UT:=Copy(_Message_0,1,Pst-1);
   PT:=Copy(_Message_0,Pst+2,Length(_Message_0));

   Delete(_Message_0,pst,2);
   Insert(_Subst_1,_Message_0,Pst);
  end else begin UT:=_Message_0;PT:='';end;

  EHolder.Lines.Clear;

  if _Line<>0 then edtPrintToEditor(EHolder,ErrorLineColor,[],ERR_Line+' '+IntToStr(_Line)+' : ');
  edtPrintToEditor(EHolder,ErrorMessageColor,[],UT);
  edtPrintToEditor(EHolder,ErrorInsertColor,[],_Subst_1);
  edtPrintToEditor(EHolder,ErrorMessageColor,[],PT);

  if (_St=0) and (_En=0) then SelLen:=0
  else
    begin
     SelLine:=_Line;
     SelStart:=_St-1;
     SelLen:=_En-_St;
     Holder.SelectedColor.Background := EditorSelErrorColor;
    end;

 EHolder.BringToFront;
 if not ErrorShown then Holder.Height:= Holder.Height-EHolder.Height - Msg_Label.Height;
 ErrorShown:=true;


 tBmp := TBitmap.Create;
 case _eStyle of
  esNormal  :
    begin
      iImageList.GetBitmap(idxErrorNormalIcon, tBmp);
    end;
  esFatal   :
    begin
      iImageList.GetBitmap(idxErrorFatalIcon, tBmp);
      PlaySoundEvent ( sndError );
    end;
  esMedium  :
    begin
      iImageList.GetBitmap(idxErrorMediumIcon, tBmp);
      PlaySoundEvent ( sndError );
    end;
  esRuntime :
    begin
      iImageList.GetBitmap(idxErrorRuntimeIcon, tBmp);
      PlaySoundEvent ( sndRuntimeError );
    end;
 end;

 iImage.Canvas.Draw(0,0, tBmp);
 tBmp.Free;
 iPanel.Show;
 iPanel.BringToFront;
 iImage.HelpContext := iPanel.HelpContext + _ErrId;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : stxErrorIntern = void');
 {$ENDIF}
end;

(*
 * stxError
 *)

procedure stxError;
begin
 {$IFDEF _DEBUG2_}
   DbgPrint(DbgUName+' : stxError (Message_0:'+DbgStr(Message_0)+'; Subst_1:'+DbgStr(Subst_1)+'; Subst_2:'+DbgStr(Subst_2)+'; Line:'+DbgInt(Line)+'; St:'+DbgInt(St)+'; En:'+DbgInt(En)+'; eStyle:'+DbgInt(Ord(eStyle))+'; ErrId:'+DbgInt(ErrId)+')');
   DbgPlus;
 {$ENDIF}

 _Message_0 := Message_0;
 _Subst_1   := Subst_1;
 _Subst_2   := Subst_2;
 _Line      := Line;
 _St        := St;
 _En        := En;
 _ErrId     := ErrId;
 _eStyle    := eStyle;

 SendMessage( m_WHandle, WM_ShowError, 0, 1 );

 {$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : stxError = void');
 {$ENDIF}
end;


(*
 * stxHighlightWord
 *)

procedure stxHighlightWord;
begin
 {$IFDEF _DEBUG_}
   DbgPrint(DbgUName+' : stxHighlightWord ( pLn:'+DbgInt(pLn)+'; pSt:'+DbgInt(pSt)+'; pEn:'+DbgInt(pEn)+')');
   DbgPlus;
 {$ENDIF}

  { if not RuntimeCycle then
   begin   }
     CurrentLine  := pLn;
     CurrentStart := pSt;
     CurrentEnd   := pEn;


   if (StepByStepHighlighting) or (Needed) then
   begin
    edtPositionateCursor(Holder,CurrentStart-1,CurrentLine);
    Holder.SelEnd := Holder.SelStart + CurrentEnd - CurrentStart;
   end else Holder.SelEnd := Holder.SelStart;

 {  end; } 

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : stxHighlightWord = void');
 {$ENDIF}
end;

end.
