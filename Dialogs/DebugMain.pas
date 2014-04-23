(*

The Original Code is: DebugMain.pas, released 2005-02-02.
Author of this file is Ciobanu Alexander. All Rights Reserved.

Description :
    Unit contains DebugForm definition that is used to display
    a simple memo that shows current debug info.

*)

{ Include Compile Directives ! }
{$I Utils\directives.inc}
unit DebugMain;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TDebugForm = class(TForm)
    MemoDeb        :    TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DebugForm: TDebugForm;

implementation
Uses Main;
{$R *.dfm}

procedure TDebugForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 MainEdukaForm.DbgScreen.Checked := false;
end;

end.
