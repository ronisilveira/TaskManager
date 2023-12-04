unit TaskManager.Task.UseCase.Insert.UnitTest;

interface
uses
  DUnitX.TestFramework;

type

  [TestFixture]
  InsertTaskTest = class(TObject)
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure InsertTaskSuccessfully;
    [Test]
    procedure ErrorOnInsertTask;
  end;

implementation

procedure InsertTaskTest.Setup;
begin
end;

procedure InsertTaskTest.TearDown;
begin
end;

procedure InsertTaskTest.InsertTaskSuccessfully;
begin
end;

procedure InsertTaskTest.ErrorOnInsertTask;
begin
end;

initialization
  TDUnitX.RegisterTestFixture(InsertTaskTest);
end.
