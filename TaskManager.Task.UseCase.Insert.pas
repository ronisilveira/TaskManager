unit TaskManager.Task.UseCase.Insert;

interface

uses
  TaskManager.Task.Entity;

type
  TInsertTaskRequest = class
  public
    Description: String;
    constructor Create(Description: String);
  end;

  TInsertTaskResponse = class
  public
    Message: String;
    constructor Create(Message: String);
  end;

  {$M+}
  IInsertTaskOutputPort = interface
    procedure showResult(response: TInsertTaskResponse);
  end;
  {$M-}

  IInsertTaskInputPort = interface
    procedure Execute(Request: TInsertTaskRequest; Output: IInsertTaskOutputPort);
  end;

  {$M+}
  ITaskRepository = interface
    procedure insert(Task: TTask);
  end;
  {$M-}

  TInsertTaskInteractor = class(TInterfacedObject, IInsertTaskInputPort)
  private
    FTaskRepository: ITaskRepository;
  public
    constructor Create(TaskRepository: ITaskRepository);
    procedure Execute(Request: TInsertTaskRequest; Output: IInsertTaskOutputPort);
  end;

implementation

{ TInsertTaskRequest }

constructor TInsertTaskRequest.Create(Description: String);
begin
  Self.Description := Description;
end;

{ TInsertTaskResponse }

constructor TInsertTaskResponse.Create(Message: String);
begin
  Self.Message := Message;
end;

{ TInsertTaskInteractor }

constructor TInsertTaskInteractor.Create(TaskRepository: ITaskRepository);
begin
  FTaskRepository := TaskRepository;
end;

procedure TInsertTaskInteractor.Execute(Request: TInsertTaskRequest;
  Output: IInsertTaskOutputPort);
var
  Task: TTask;
begin
  inherited;

  if Request.Description = '' then
  begin
    Output.showResult(TInsertTaskResponse.Create('O preenchimento da descrição é obrigatório'));
    Exit;
  end;

  Task := TTask.Create;
  Task.Description := Request.Description;

  FTaskRepository.insert(Task);

  Output.showResult(TInsertTaskResponse.Create('Tarefa inserida com sucesso!'));
end;

end.
