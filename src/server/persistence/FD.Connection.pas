unit FD.Connection;

interface

uses
  System.SysUtils, System.Classes, Midgard.Base.Data.Module, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Phys.PGDef, FireDAC.Phys.PG, FireDAC.Comp.UI,
  Data.DB, FireDAC.Comp.Client,
  // Spring
  Spring.Collections,
  Spring.Persistence.Core.Interfaces,
  Spring.Persistence.Adapters.FireDAC,
  Spring.Persistence.SQL.Interfaces;

type
  TFDConnectionDataModule = class(TMidgardBaseDataModule, IDBConnection)
    FDConnection: TFDConnection;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  strict private
    FAdapter: IDBConnection;
    function GetAutoFreeConnection: Boolean;
    function GetExecutionListeners: IList<TExecutionListenerProc>;
    function GetQueryLanguage: TQueryLanguage;
    procedure SetAutoFreeConnection(value: Boolean);
    procedure SetQueryLanguage(const value: TQueryLanguage);
  public
    procedure Connect;
    procedure Disconnect;

    function IsConnected: Boolean;
    function CreateStatement: IDBStatement;
    function BeginTransaction: IDBTransaction;

    procedure AddExecutionListener(const listenerProc: TExecutionListenerProc);
    procedure ClearExecutionListeners;

    property AutoFreeConnection: Boolean read GetAutoFreeConnection write SetAutoFreeConnection;
    property ExecutionListeners: IList<TExecutionListenerProc> read GetExecutionListeners;
    property QueryLanguage: TQueryLanguage read GetQueryLanguage write SetQueryLanguage;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TFDConnectionDataModule.AddExecutionListener(
  const listenerProc: TExecutionListenerProc);
begin
  FAdapter.AddExecutionListener(listenerProc);
end;

function TFDConnectionDataModule.BeginTransaction: IDBTransaction;
begin
  Result := FAdapter.BeginTransaction;
end;

procedure TFDConnectionDataModule.ClearExecutionListeners;
begin
  FAdapter.ClearExecutionListeners;
end;

procedure TFDConnectionDataModule.Connect;
begin
  FAdapter.Connect;
end;

function TFDConnectionDataModule.CreateStatement: IDBStatement;
begin
  Result := FAdapter.CreateStatement;
end;

procedure TFDConnectionDataModule.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FDPhysPgDriverLink.VendorHome := ParamStr(0) + 'DLLs\';
  FAdapter := TFireDACConnectionAdapter.Create(FDConnection);
  FAdapter.AutoFreeConnection := False;
  FAdapter.Connect;
end;

procedure TFDConnectionDataModule.Disconnect;
begin
  FAdapter.Disconnect;
end;

function TFDConnectionDataModule.GetAutoFreeConnection: Boolean;
begin
  Result := FAdapter.AutoFreeConnection;
end;

function TFDConnectionDataModule.GetExecutionListeners: IList<TExecutionListenerProc>;
begin
  Result := FAdapter.ExecutionListeners;
end;

function TFDConnectionDataModule.GetQueryLanguage: TQueryLanguage;
begin
  Result := FAdapter.QueryLanguage;
end;

function TFDConnectionDataModule.IsConnected: Boolean;
begin
  Result := FAdapter.IsConnected;
end;

procedure TFDConnectionDataModule.SetAutoFreeConnection(value: Boolean);
begin
  FAdapter.AutoFreeConnection := value;
end;

procedure TFDConnectionDataModule.SetQueryLanguage(const value: TQueryLanguage);
begin
  FAdapter.QueryLanguage := value;
end;

end.
