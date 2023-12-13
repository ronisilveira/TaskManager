unit TaskManager.Task.UseCase.Insert.UnitTest;

interface
uses
  DUnitX.TestFramework, Delphi.Mocks, TaskManager.Task.UseCase.Insert,
  TaskManager.Task.Entity;

type

  [TestFixture]
  InsertTaskTest = class(TObject)
  private
    TaskRepositoryMock: TMock<ITaskRepository>;
    InsertTaskOutputPortMock: TMock<IInsertTaskOutputPort>;
    InsertTaskUseCase: IInsertTaskInputPort;
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

uses
  System.Rtti;

procedure InsertTaskTest.Setup;
begin
  TaskRepositoryMock := TMock<ITaskRepository>.Create;
  InsertTaskOutputPortMock := TMock<IInsertTaskOutputPort>.Create;
  InsertTaskUseCase := TInsertTaskInteractor.Create(TaskRepositoryMock.Instance);
end;

procedure InsertTaskTest.TearDown;
begin
  TaskRepositoryMock.Free;
  InsertTaskOutputPortMock.Free;
end;

procedure InsertTaskTest.InsertTaskSuccessfully;
var
  ExpectedTask: TTask;
  ExpectedResponse: TInsertTaskResponse;
begin
  ExpectedTask := TTask.Create;
  ExpectedTask.Description := 'Any description';
  TaskRepositoryMock.Setup.Expect.AtLeastOnce.When.insert(It0.AreSamePropertiesThat<TTask>(ExpectedTask));

  ExpectedResponse := TInsertTaskResponse.Create('Tarefa inserida com sucesso!');
  InsertTaskOutputPortMock.Setup.Expect.AtLeastOnce.When.showResult(It0.AreSameFieldsThat<TInsertTaskResponse>(ExpectedResponse));

  InsertTaskUseCase.Execute(TInsertTaskRequest.Create('Any description'), InsertTaskOutputPortMock.Instance);

  TaskRepositoryMock.Verify('Insert use-case should call insert method from repository');
  InsertTaskOutputPortMock.Verify('Insert use-case should call showResult method from output port');
end;

procedure InsertTaskTest.ErrorOnInsertTask;
var
  ExpectedResponse: TInsertTaskResponse;
begin
  TaskRepositoryMock.Setup.Expect.Never.When.insert(It0.IsNotNil<TTask>);

  ExpectedResponse := TInsertTaskResponse.Create('O preenchimento da descrição é obrigatório');
  InsertTaskOutputPortMock.Setup.Expect.AtLeastOnce.When.showResult(It0.AreSameFieldsThat<TInsertTaskResponse>(ExpectedResponse));

  InsertTaskUseCase.Execute(TInsertTaskRequest.Create(''), InsertTaskOutputPortMock.Instance);

  TaskRepositoryMock.Verify('Insert use-case should never call insert method from repository');
  InsertTaskOutputPortMock.Verify('Insert use-case should call showResult method from output port');
end;

initialization
  TDUnitX.RegisterTestFixture(InsertTaskTest);
end.
