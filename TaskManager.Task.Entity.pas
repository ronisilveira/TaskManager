unit TaskManager.Task.Entity;

interface

type

  TTaskStatus = (Pending, Completed, Canceled);

  TTask = class
  private
    FDescription: String;
    FStatus: TTaskStatus;
  public
    property Description: String read FDescription write FDescription;
    property Status: TTaskStatus read FStatus write FStatus;
  end;

implementation

end.
