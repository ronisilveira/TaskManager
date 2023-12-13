unit TaskManager.Task.Entity;

interface

type
  TTask = class
  private
    FDescription: String;
  public
    property Description: String read FDescription write FDescription;
  end;

implementation

end.
