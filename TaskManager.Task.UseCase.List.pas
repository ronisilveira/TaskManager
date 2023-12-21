unit TaskManager.Task.UseCase.List;

interface

uses
  TaskManager.Task.Entity, TaskManager.Task.UseCase.Shared;

type
  TListTaskRequest = class
  end;

  TListTaskResponse = class
  public
    Message: String;
    constructor Create(Message: String);
  end;

  {$M+}
  IListTaskOutputPort = interface
    procedure ShowResult(response: TListTaskResponse);
  end;
  {$M-}

  IListTaskInputPort = interface
    procedure Execute(Request: TListTaskRequest; Output: IListTaskOutputPort);
  end;

  TListTaskInteractor = class(TInterfacedObject, IListTaskInputPort)
  private
    FTaskRepository: ITaskRepository;
  public
    constructor Create(TaskRepository: ITaskRepository);
    procedure Execute(Request: TListTaskRequest; Output: IListTaskOutputPort);
  end;

implementation

{ TListTaskResponse }

constructor TListTaskResponse.Create(Message: String);
begin
  Self.Message := Message;
end;

{ TListTaskInteractor }

constructor TListTaskInteractor.Create(TaskRepository: ITaskRepository);
begin
  FTaskRepository := TaskRepository;
end;

procedure TListTaskInteractor.Execute(Request: TListTaskRequest;
  Output: IListTaskOutputPort);
begin

end;

end.
