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
    // Sample Methods
    // Simple single Test
    [Test]
    procedure Test1;
    // Test with TestCase Atribute to supply parameters.
    [Test]
    [TestCase('TestA','1,2')]
    [TestCase('TestB','3,4')]
    procedure Test2(const AValue1 : Integer;const AValue2 : Integer);
  end;

implementation

procedure InsertTaskTest.Setup;
begin
end;

procedure InsertTaskTest.TearDown;
begin
end;

procedure InsertTaskTest.Test1;
begin
end;

procedure InsertTaskTest.Test2(const AValue1 : Integer;const AValue2 : Integer);
begin
end;

initialization
  TDUnitX.RegisterTestFixture(InsertTaskTest);
end.
