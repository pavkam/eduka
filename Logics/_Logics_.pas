(*


The Original Code is: _Logics_.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
    Unit implements continues to implement Lists but at a higher level
    needed by Logics/Syntax.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit _Logics_;
interface
Uses SysUtils, Lists, ProTypes
{$IFDEF _DEBUG_}
,Debug;
Const
 DbgUName = 'Logics/_Logics_.pas'
{$ENDIF}
;


function llGetLabelNodeByName(Name : String) : PNode;
 {
   Finds the label Node by the given name
 }

function llGetLabelIDByName(Name : String) : Integer;
 {
   Gets label ID by name
 }

function llGetLabelNodeByID(ID : Integer) : PNode;
 {
   Gets Label Node by ID
 }

function llGetLabelNameByID(ID : Integer) : String;
 {
   Gets Label Name by ID
 }

function llAddLabelEntry(LType : TLabelEntryType;Name : String;Node : PNode) : TLogicsError;
 {
   Add a new entry to the label list
 }

function llReInitializeAllDataStructures : TLogicsError;
 {
   Reinitializes all internal structures
 }

function llDefineRootNode(PId,ConId,AdvP : Integer) : TLogicsError;
 {
   Creates the Root node , parent for all the rest nodes
 }

function llNewForkNode(PId,ConId,AdvP : Integer; Stp : String;pSt, pEn, pLn : Integer) : TLogicsError;
 {
  Creates a new WHILE/REPEAT/IF node
 }

function llNewFuncNode(PId,ConId,AdvP : Integer;Name : String;pSt, pEn, pLn : Integer) : TLogicsError;
 {
  Creates a new Function node
 }

function llCallLabel(Name : String;PId : Integer) : TLogicsError;
 {
  Calls a Label defined by Name. PId means that the Node's ID will be
  temporarily swaped with this value !
 }

function llNewNode(PId,ConId,AdvP : Integer; Stp : String;pSt, pEn, pLn : Integer) : TLogicsError;
 {
  Create a simple Child Node
 }

function llNodeBack : TLogicsError;
 {
  Gets back to the parent node !
 }

function llExecuteNodes(Func : DispatchCallbackFunc) : TLogicsError;
 {
  Start Dispathcing (Executing) the NODE TREE. Func, is a callback function defined
  by user to accept and execute instructions !
 }

function llGetRootNode : PNode;
 {
  Returns the root node.
 }

implementation
Var
 ILabels : Array of TLabelEntry;
  Labels : Integer;

  PosStack  : Array of Integer;
   StackPos : Integer;

  RootNode  : PNode;


(*
 * llGetLabelNodeByName
 *)

function llGetLabelNodeByName(Name : String) : PNode;
var
 I : Integer;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : llGetLabelNodeByName(Name:'+Name+')');
  DbgPlus;
{$ENDIF}

 Name:=AnsiUpperCase(Name);

 if Labels>0 then
   for I:=0 to Labels-1 do
       if ILabels[I].Name=Name then
         begin
          Result:=ILabels[I].Node;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : llGetLabelNodeByName = '+DbgAddr(Result));
{$ENDIF}

          Exit;
         end;
 Result:=nil;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : llGetLabelNodeByName = '+DbgAddr(Result));
{$ENDIF}
end;


(*
 * llGetLabelIDByName
 *)

function llGetLabelIDByName(Name : String) : Integer;
var
 I : Integer;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : llGetLabelIDByName(Name:'+Name+')');
  DbgPlus;
{$ENDIF}

 Name:=AnsiUpperCase(Name);

 if Labels>0 then
   for I:=0 to Labels-1 do
       if ILabels[I].Name=Name then
         begin
          Result:=I;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : llGetLabelIDByName = '+DbgInt(Result));
{$ENDIF}
          Exit;
         end;
 Result:=0;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : llGetLabelIDByName = '+DbgInt(Result));
{$ENDIF}


end;


(*
 * llGetLabelNodeByID
 *)

function llGetLabelNodeByID(ID : Integer) : PNode;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : llGetLabelNodeByID(ID:'+DbgInt(ID)+')');
  DbgPlus;
{$ENDIF}

 if Labels<ID then
    begin
      Result:=nil;

      {$IFDEF _DEBUG_}
        DbgMinus;
        DbgPrint(DbgUName+' : llGetLabelNodeByID = '+DbgAddr(Result));
      {$ENDIF}

      Exit;
    end;

 Result:=ILabels[ID].Node;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : llGetLabelNodeByID = '+DbgAddr(Result));
{$ENDIF}

end;


(*
 * llGetLabelNameByID
 *)

function llGetLabelNameByID(ID : Integer) : String;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : llGetLabelNameByID(ID:'+DbgInt(ID)+')');
  DbgPlus;
{$ENDIF}

 if Labels<ID then
    begin
      Result:='';

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : llGetLabelNameByID = '+Result);
{$ENDIF}

      Exit;
    end;

 Result:=ILabels[ID].Name;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : llGetLabelNameByID = '+Result);
{$ENDIF}

end;


(*
 * llAddLabelEntry
 *)

function llAddLabelEntry(LType : TLabelEntryType;Name : String;Node : PNode) : TLogicsError;
begin

{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : llAddLabelEntry(LType:'+DbgInt(Ord(LType))+'; Name:'+Name+'; Node:'+DbgAddr(Node)+')');
  DbgPlus;
{$ENDIF}

  If llGetLabelNodeByName(Name)=nil then
   begin
     Inc(Labels);
     SetLength(ILabels,Labels);
     ILabels[Labels-1].LabelType:=LType;
     Name:=AnsiUpperCase(Name);
     ILabels[Labels-1].Name:=Name;
     ILabels[Labels-1].Node:=Node;
     Result:= leNoError;
   end else Result:=leLabelDefined;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : llAddLabelEntry = '+DbgInt(Ord(Result)));
{$ENDIF}
end;


(*
 *  llReInitializeAllDataStructures
 *)

function llReInitializeAllDataStructures : TLogicsError;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : llReInitializeAllDataStructures() ');
  DbgPlus;
{$ENDIF}

 SetLength(ILabels,0);      // Kill All Labels


 Labels := 0;

 SetLength(PosStack,0);     // Set Stack to 0


 StackPos := 0;
 RootNode := nil;

 Result:= leNoError;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : llReInitializeAllDataStructures = '+DbgInt(Ord(Result)));
{$ENDIF}

end;


(*
 *  llDefineRootNode
 *)

function llDefineRootNode(PId,ConId,AdvP : Integer) : TLogicsError;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : llDefineRootNode(PId:'+DbgInt(PId)+'; ConId:'+DbgInt(ConId)+'; AdvP:'+DbgInt(AdvP)+')');
  DbgPlus;
{$ENDIF}

 RootNode:=nlReferenceNode(ltNewNode,PId,ConId,AdvP, '',0,0,0);
  if RootNode=nil then Result:=leCreateRoot else Result:=leNoError;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : llDefineRootNode = '+DbgInt(Ord(Result)));
{$ENDIF}

end;


(*
 *  llNewForkNode
 *)

function llNewForkNode(PId,ConId,AdvP : Integer; Stp : String; pSt, pEn, pLn : Integer) : TLogicsError;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : llNewForkNode(PId:'+DbgInt(PId)+'; ConId:'+DbgInt(ConId)+'; AdvP:'+DbgInt(AdvP)+')');
  DbgPlus;
{$ENDIF}

 if nlReferenceNode(ltNewNode,PId,ConId,AdvP, Stp, pSt, pEn, pLn)=nil then
   Result:=leCreateNode else Result:=leNoError;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : llNewForkNode = '+DbgInt(Ord(Result)));
{$ENDIF}

end;


(*
 *  llNewNode
 *)

function llNewNode(PId,ConId,AdvP : Integer; Stp : String;pSt, pEn, pLn : Integer) : TLogicsError;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : llNewNode(PId:'+DbgInt(PId)+'; ConId:'+DbgInt(ConId)+'; AdvP:'+DbgInt(AdvP)+')');
  DbgPlus;
{$ENDIF}

 if nlReferenceNode(ltNewChild,PId,ConId,AdvP, Stp, pSt, pEn , pLn)=nil then
   Result:=leCreateNode else Result:=leNoError;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : NewNode = '+DbgInt(Ord(Result)));
{$ENDIF}

end;


(*
 *  llNewFuncNode
 *)

function llNewFuncNode(PId,ConId,AdvP : Integer;Name : String;pSt, pEn, pLn : Integer) : TLogicsError;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : NewFuncNode(PId:'+DbgInt(PId)+'; ConId:'+DbgInt(ConId)+'; AdvP:'+DbgInt(AdvP)+'; Name:'+Name+')');
  DbgPlus;
{$ENDIF}

 Result:=llAddLabelEntry(letProcedure,Name,nlReferenceNode(ltNewNode,PId, ConId, AdvP,'', pSt, pEn, pLn));

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : NewFuncNode = '+DbgInt(Ord(Result)));
{$ENDIF}

end;


(*
 *  llNodeBack
 *)

function llNodeBack : TLogicsError;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : llNodeBack()');
  DbgPlus;
{$ENDIF}

 nlReferenceNode(ltBackNode,0,0,0,'',0,0,0);
 Result := leNoError;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : llNodeBack = '+DbgInt(Ord(Result)));
{$ENDIF}

end;

(*
 *  llCallLabel
 *)

function llCallLabel(Name : String;PId : Integer) : TLogicsError;
var
 MyN : PNode;
  LocN : Integer;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : llCallLabel(Name:'+Name+'; PId:'+DbgInt(PId)+')');
  DbgPlus;
{$ENDIF}
 Result := leNoError;
 MyN:=llGetLabelNodeByName(Name);
 if MyN=nil then
   begin
     Result:=leNoLabel;
     Exit;
   end;
 LocN:=MyN^.PId;
 MyN^.PId:=PId;
 nlDispatchNode(MyN, True);

 MyN^.PId:=LocN;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : llCallLabel = '+DbgInt(Ord(Result)));
{$ENDIF}

end;


(*
 *  llExecuteNodes
 *)

function llExecuteNodes(Func : DispatchCallbackFunc) : TLogicsError;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : llExecuteNodes(Func:'+DbgAddr(Addr(Func))+')');
  DbgPlus;
{$ENDIF}

 nlRegisterDispatchCallBack(Func);
 nlDispatchNode(RootNode, True);
 nlRegisterDispatchCallBack(nil);

 Result:=leNoError;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : llExecuteNodes = '+DbgInt(Ord(Result)));
{$ENDIF}

end;


(*
 *  llGetRootNode
 *)

function llGetRootNode : PNode;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : llGetRootNode()');
  DbgPlus;
{$ENDIF}

 Result:= RootNode;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : llGetRootNode = '+DbgAddr(Result));
{$ENDIF}

end;

begin
  llReInitializeAllDataStructures;

end.
