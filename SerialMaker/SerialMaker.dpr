program SerialMaker;

uses
  Forms,
  Main in 'Main.pas' {SerialForm},
  SerialUtils in '..\Utils\SerialUtils.pas',
  Utils in '..\Utils\Utils.pas',
  ProTypes in '..\Utils\ProTypes.pas',
  Version in '..\Utils\Version.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Eduka+ Serial Builder';
  Application.CreateForm(TSerialForm, SerialForm);
  Application.Run;
end.
