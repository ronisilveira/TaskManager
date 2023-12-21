program TaskManagerUnitTest;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}
uses
  SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  TaskManager.Task.UseCase.Insert.UnitTest in 'TaskManager.Task.UseCase.Insert.UnitTest.pas',
  TaskManager.Task.Entity in 'TaskManager.Task.Entity.pas',
  TaskManager.Task.UseCase.Insert in 'TaskManager.Task.UseCase.Insert.pas',
  Delphi.Mocks.AutoMock in 'DelphiMocks\Delphi.Mocks.AutoMock.pas',
  Delphi.Mocks.Behavior in 'DelphiMocks\Delphi.Mocks.Behavior.pas',
  Delphi.Mocks.Expectation in 'DelphiMocks\Delphi.Mocks.Expectation.pas',
  Delphi.Mocks.Helpers in 'DelphiMocks\Delphi.Mocks.Helpers.pas',
  Delphi.Mocks.Interfaces in 'DelphiMocks\Delphi.Mocks.Interfaces.pas',
  Delphi.Mocks.MethodData in 'DelphiMocks\Delphi.Mocks.MethodData.pas',
  Delphi.Mocks.ObjectProxy in 'DelphiMocks\Delphi.Mocks.ObjectProxy.pas',
  Delphi.Mocks.ParamMatcher in 'DelphiMocks\Delphi.Mocks.ParamMatcher.pas',
  Delphi.Mocks in 'DelphiMocks\Delphi.Mocks.pas',
  Delphi.Mocks.Proxy in 'DelphiMocks\Delphi.Mocks.Proxy.pas',
  Delphi.Mocks.Proxy.TypeInfo in 'DelphiMocks\Delphi.Mocks.Proxy.TypeInfo.pas',
  Delphi.Mocks.ReturnTypePatch in 'DelphiMocks\Delphi.Mocks.ReturnTypePatch.pas',
  Delphi.Mocks.Utils in 'DelphiMocks\Delphi.Mocks.Utils.pas',
  Delphi.Mocks.Validation in 'DelphiMocks\Delphi.Mocks.Validation.pas',
  Delphi.Mocks.WeakReference in 'DelphiMocks\Delphi.Mocks.WeakReference.pas',
  Delphi.Mocks.When in 'DelphiMocks\Delphi.Mocks.When.pas';

var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  exit;
{$ENDIF}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //tell the runner how we will log things
    //Log to the console window
    logger := TDUnitXConsoleLogger.Create(true);
    runner.AddLogger(logger);
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);
    runner.FailsOnNoAsserts := False; //When true, Assertions must be made during tests;

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end.
