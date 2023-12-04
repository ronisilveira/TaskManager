unit TaskManager.Task.UseCase.Insert;

interface

type
  InsertTaskRequest = class
  public
    Description: String;
    constructor Create(Description: String);
  end;

  InsertTaskResponse = class

  end;

  InsertTaskOutputPort = interface

  end;

  InsertTaskInputPort = interface
    procedure Call(Request: InsertTaskRequest; Output: InsertTaskOutputPort);
  end;

  InsertTaskInteractor = class(TInterfacedObject, InsertTaskInputPort)
  public
    procedure Call(Request: InsertTaskRequest; Output: InsertTaskOutputPort);
  end;

implementation

{ InsertTaskRequest }

constructor InsertTaskRequest.Create(Description: String);
begin
  Self.Description := Description;
end;

{ InsertTaskInteractor }

procedure InsertTaskInteractor.Call(Request: InsertTaskRequest;
  Output: InsertTaskOutputPort);
begin
  inherited;

end;

end.
