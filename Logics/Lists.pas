(*

The Original Code is: Lists.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
    Unit implements Chained Lists that we use to store execution nodes.
    It is the heart of our execution model.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit Lists;
interface
Uses ProTypes
{$IFDEF _DEBUG_}
 , Debug;
Const
 DbgUName = 'Logic/List.pas'
{$ENDIF}
  ;
Var
 StopDispatchingFlag : Boolean;
  ILastK             : PNode;

{$IFDEF _DEBUG_}
  NodeDeep : Integer;
{$ENDIF}


function nlCreateNode(Parent : PNode; PId,ConId,AdvP : Integer; Stp : String; pSt, pEn, pLn : Integer) : PNode;
 {
   Creates a new Node with Parent specified.
   if Parent is nil, this node is considered Root.
   PId - specifies Instruction's ID. ConId - Condition ID
   AdvP - Advanced Condition. Theese parameters depend on interpreter
 }

function nlRegisterDispatchCallback(Func : DispatchCallbackFunc) : Boolean;
 {
   Registers a callback bunction to receive and execute a Node.
   See DispatchCallbackFunc for details how to create such a callback.
 }

function nlDispatchNode(StartNode : PNode; DeletePrevFinger : Boolean) : Integer;
 {
   Dispatch Node, starts with the specified StartNode and recursively
   executes all of them by using callback.
 }

function nlReferenceNode(LinkType : TLinkType ;PId,ConId,AdvP : Integer; Stp : String;pSt, pEn, pLn : Integer) : PNode;
 {
   Creates the List itself. You must use the return of the function for
   the first time only, so this value could be used in DispatchNode as start
   LinkType specifies how the new node is linked to the previuos (Child, Node, Back)
 }

function nlGetNodeByAdvP(Parent : PNode;AdvP : Integer) : PNode;
 {
   Find the child node of an Parent that has AdvP member equal
   to given value.
 }

procedure nlHardLinkNodes(Parent,Child : PNode);
 {
   Links the Child Node to the Children member of Parent Node
   Thi Function is useful for Call instructions !
 }

function nlDestroyTreeStructure(StartNode : PNode) : Integer;
 {
  Use This function to destroy the whole Tree structure
 }

{$IFDEF _DEBUG_}
function nlDbgDispatchNode(StartNode : PNode) : Integer;
 {
   Use this only in debugging --- !
 }
{$ENDIF}

implementation
Var
 InternalCallBack : DispatchCallbackFunc;


(*
 *  CreateNode
 *)

function nlCreateNode(Parent : PNode; PId,ConId,AdvP : Integer; Stp : String;pSt, pEn, pLn : Integer) : PNode;
Var
  NNode : PNode;
begin
 {$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : nlCreateNode(Parent:'+DbgAddr(Parent)+'; PId:'+DbgInt(PId)+'; ConId:'+DbgInt(ConId)
           +'; AdvP:'+DbgInt(AdvP)+'; Stp:'+DbgStr(Stp)+'; pSt:'+DbgInt(pSt)+')''; pEn:'+DbgInt(pEn)+'; pLn:'+DbgInt(pLn)+')');
   DbgPlus;
  {$ENDIF}

  // Create the new Execution Node
  New(NNode);
  if Parent<>nil then
   begin
     Inc(Parent^.ChLen);
     SetLength(Parent^.Children,Parent^.ChLen);
     Parent^.Children[Parent^.ChLen-1]:=NNode;
   end;
  NNode^.Parent:=Parent;
  NNode^.PId:=PId;
  NNode^.ConId:=ConId;
  NNode^.AdvP:=AdvP;
  NNode^.ChLen:=0;
  NNode^.StPar:=Stp;
  NNode^.pSt := pSt;
  NNode^.pEn := pEn;
  NNode^.pLn := pLn;
  NNode^.Finger[1] := 0;
  NNode^.Finger[2] := 0;
  NNode^.Finger[3] := 0;
  NNode^.Finger[4] := 0;
  Result:=NNode;


 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : nlCreateNode = '+DbgAddr(Result));
 {$ENDIF}
end;

(*
 * RegisterDispatchCallback
 *)
function nlRegisterDispatchCallback(Func : DispatchCallbackFunc) : Boolean;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : nlRegisterDispatchCallback(Func:'+DbgAddr(Addr(Func))+')');
  DbgPlus;
{$ENDIF}

 InternalCallBack:=Func;
 Result := True;

{$IFDEF _DEBUG_}
 DbgMinus;
 DbgPrint(DbgUName+' : nlRegisterDispatchCallback = '+DbgBool(Result));
{$ENDIF}
end;

(*
 * DispatchNode
 *)
function nlDispatchNode(StartNode : PNode; DeletePrevFinger : Boolean) : Integer;
var
 I    : Integer;
 AdvP : Integer;
 AxC  : TFingerPrint;
begin
 Result := 0;
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : nlDispatchNode(StartNode:'+DbgAddr(StartNode)+'; DeletePrevFinger:'+DbgBool(DeletePrevFinger)+')');
  DbgPlus;
{$ENDIF}

  if StopDispatchingFlag then
  begin
{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : nlDispatchNode | StopDispatchingFlag = TRUE , Stopping');
{$ENDIF}
  exit;
  end;

  // Execute Callback
 AdvP:=StartNode^.AdvP;
  if Assigned(InternalCallback) then
   begin
     if DeletePrevFinger then
      begin
        AxC[1] := 0; AxC[2] := 0; AxC[3] := 0; AxC[4] := 0;
      end else AxC := StartNode^.Finger;
    while (InternalCallback(Addr(StartNode), AxC, StartNode^.PId, StartNode^.ConId,StartNode^.AdvP,StartNode^.StPar, StartNode^.pSt, StartNode^.pEn, StartNode^.pLn)) do
     begin
       if StartNode^.ChLen > 0 then
          for i:=0 to StartNode^.ChLen - 1 do
           begin
              if StopDispatchingFlag then
              begin
               {$IFDEF _DEBUG_}
                 DbgMinus;
                 DbgPrint(DbgUName+' : nlDispatchNode | StopDispatchingFlag = TRUE , Stopping');
               {$ENDIF}
                 exit;
              end;
             Result:=1+nlDispatchNode(StartNode^.Children[i], DeletePrevFinger);
           end;
           
       if StartNode^.PId <> _Repeat_ then
                      DeletePrevFinger := False;
                      
     end;
     
     StartNode^.Finger := AxC;
   end;

 StartNode^.AdvP:=AdvP;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : nlDispatchNode = '+DbgInt(Result));
{$ENDIF}

end;

{$IFDEF _DEBUG_}
(*
 * DbgDispatchNode
 *)
function nlDbgDispatchNode(StartNode : PNode) : Integer;
var
 I : Integer;
begin
 DbgPrint(DbgUName+' : nlDbgDispatchNode(StartNode:'+DbgAddr(StartNode)+')');
 DbgPlus;

  Result := 0;

  Inc(NodeDeep);
  // Execute Callback
  if Assigned(InternalCallback) then

    InternalCallback(Addr(StartNode),StartNode^.Finger, StartNode^.PId,StartNode^.ConId,StartNode^.AdvP,StartNode^.StPar, StartNode^.pSt, StartNode^.pEn, StartNode^.pLn);

       if StartNode^.ChLen > 0 then
          for i:=0 to StartNode^.ChLen - 1 do nlDbgDispatchNode(StartNode^.Children[i]);
  Dec(NodeDeep);

 DbgMinus;
 DbgPrint(DbgUName+' : nlDbgDispatchNode = '+DbgInt(Result));
end;
{$ENDIF}


(*
 *  DestroyTreeStructure
 *)

function RecursDestroyTreeStructure(StartNode : PNode) : Integer;
var
 I : Integer;
begin
{$IFDEF _DEBUG2_}
    DbgPrint(DbgUName+' : RecursDestroyTreeStructure(StartNode:'+DbgAddr(StartNode)+')');
    DbgPlus;
{$ENDIF}

    Result:=1;
     if StartNode^.ChLen>0 then
        for i:=0 to StartNode^.ChLen - 1 do Result:=Result+RecursDestroyTreeStructure(StartNode^.Children[i]);

     Dispose(StartNode);

{$IFDEF _DEBUG2_}
   DbgMinus;
   DbgPrint(DbgUName+' : RecursDestroyTreeStructure = '+DbgInt(Result));
{$ENDIF}
end;


function nlDestroyTreeStructure(StartNode : PNode) : Integer;
begin
{$IFDEF _DEBUG_}
    DbgPrint(DbgUName+' : nlDestroyTreeStructure(StartNode:'+DbgAddr(StartNode)+')');
    DbgPlus;
{$ENDIF}

 Result := RecursDestroyTreeStructure(StartNode);
 ILastK:=nil;
{$IFDEF _DEBUG_}
  NodeDeep:=0;
{$ENDIF}

{$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : nlDestroyTreeStructure = '+DbgInt(Result));
{$ENDIF}
end;

(*
 * ReferenceNode
 *)
function nlReferenceNode(LinkType : TLinkType ;PId,ConId,AdvP : Integer;Stp : String; pSt, pEn, pLn : Integer) : PNode;
begin
{$IFDEF _DEBUG_}
    DbgPrint(DbgUName+' : nlReferenceNode(LinkType:'+DbgInt(Ord(LinkType))+'; PId:'+DbgInt(PId)+'; ConId:'+DbgInt(ConId)
           +'; AdvP:'+DbgInt(AdvP)+'; pSt:'+DbgInt(pSt)+'; pEn:'+DbgInt(pEn)+'; pLn:'+DbgInt(pLn)+')');
    DbgPlus;
{$ENDIF}

 if LinkType=ltNewNode then
      ILastK:=nlCreateNode(ILastK, PId, ConId, AdvP, Stp, pSt, pEn, pLn) else
 if LinkType=ltNewChild then
  begin
    ILastK:=nlCreateNode(ILastK, PId, ConId, AdvP, Stp, pSt, pEn, pLn);
    ILastK:=ILastK^.Parent;
  end else
 ILastK:=ILastK^.Parent;

 Result:=ILastK;

 {$IFDEF _DEBUG_}
   DbgMinus;
   DbgPrint(DbgUName+' : nlReferenceNode = '+DbgAddr(Result));
 {$ENDIF}

end;

(*
 * HardLinkNodes
 *)
procedure nlHardLinkNodes(Parent,Child : PNode);
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : nlHardLinkNodes(Parent:'+DbgAddr(Parent)+'; Child:'+DbgAddr(Child)+')');
  DbgPlus;
{$ENDIF}

 Inc(Parent^.ChLen);


 SetLength(Parent^.Children,(Parent^.ChLen)*SizeOf(PNode));

 Parent^.Children[Parent^.ChLen]:=Child;

{$IFDEF _DEBUG_}
  DbgMinus;
   DbgPrint(DbgUName+' : nlHardLinkNodes = void');
{$ENDIF}
end;


(*
 *  GeNodeByAdvP
 *)
function nlGetNodeByAdvP(Parent : PNode;AdvP : Integer) : PNode;
var
 i : integer;
begin
{$IFDEF _DEBUG_}
  DbgPrint(DbgUName+' : nlGetNodeByAdvP(Parent:'+DbgAddr(Parent)+'; AdvP:'+DbgInt(AdvP)+')');
  DbgPlus;
{$ENDIF}

 if Parent^.ChLen>0 then
   for i:=1 to Parent^.ChLen do
     if Parent^.AdvP=AdvP then
       begin
         Result:=Parent^.Children[i];
         Exit;
       end;
 Result:=nil;

{$IFDEF _DEBUG_}
  DbgMinus;
  DbgPrint(DbgUName+' : nlGetNodeByAdvP = '+DbgAddr(Result));
{$ENDIF}
end;

initialization
 ILastK:=nil;
{$IFDEF _DEBUG_}
  NodeDeep:=0;
{$ENDIF}

end.
