unit Midgard.Critical.Section;

interface

type

  ICriticalSection = interface
    ['{89E8041F-F237-4A5A-B9B6-C6CA974E5EC9}']
    procedure Enter;
    procedure Leave;
  end;

implementation

end.
