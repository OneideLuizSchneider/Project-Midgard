unit Midgard.Base.Data.Module;

interface

uses
  System.SysUtils, System.Classes;

type
  TMidgardBaseDataModule = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MidgardBaseDataModule: TMidgardBaseDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
