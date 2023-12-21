unit TaskManager.Task.UseCase.Shared;

interface

uses
  TaskManager.Task.Entity, System.Generics.Collections;

type

  {$M+}
  ITaskRepository = interface
    procedure Insert(Task: TTask);
    function ListAll(): TObjectList<TTask>;
  end;
  {$M-}

implementation

end.
