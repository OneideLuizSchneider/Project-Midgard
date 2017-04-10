unit Midgard.Critical.Section.Impl;

interface

uses
  Midgard.Critical.Section,
  System.Classes,
  System.SyncObjs;

type

  TCriticalSection = class(TInterfacedObject, ICriticalSection)
  strict private
    FInternal: TCriticalSection;
  strict protected
  public
    constructor Create;
    destructor Destroy; override;

    procedure Enter;
    procedure Leave;
  end;

implementation

{ TCriticalSection }

constructor TCriticalSection.Create;
begin
  FInternal := TCriticalSection.Create;
end;

destructor TCriticalSection.Destroy;
begin
  FInternal.Free;
  inherited;
end;

procedure TCriticalSection.Enter;
begin
  FInternal.Enter;
end;

procedure TCriticalSection.Leave;
begin
  FInternal.Leave;
end;

end.
