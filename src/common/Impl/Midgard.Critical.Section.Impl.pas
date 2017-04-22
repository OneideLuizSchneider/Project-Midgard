unit Midgard.Critical.Section.Impl;

interface

uses
  Midgard.Critical.Section,
  System.Classes,
  System.SyncObjs;

type

  TMidgardCriticalSection = class(TInterfacedObject, ICriticalSection)
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

{ TMidgardCriticalSection }

constructor TMidgardCriticalSection.Create;
begin
  FInternal := TCriticalSection.Create;
end;

destructor TMidgardCriticalSection.Destroy;
begin
  FInternal.Free;
  inherited;
end;

procedure TMidgardCriticalSection.Enter;
begin
  FInternal.Enter;
end;

procedure TMidgardCriticalSection.Leave;
begin
  FInternal.Leave;
end;

end.
