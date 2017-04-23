unit Midgard.Crud.Resource;

interface

uses
  Spring.Collections;

type

  IMidgardCrudResource<TDTO: class, constructor; TKey> = interface(IInvokable)
    ['{C85DF74A-8BE6-4B3A-88DD-5B3575F9CADA}']
    function GetPath: string;
    procedure SetPath(const value: string);

    function FindOne(const id: TKey): TDTO;
    function FindOneAsList(const id: TKey): IList<TDTO>;
    function FindAll: IList<TDTO>;

    function Insert(const dto: TDTO): TKey;
    procedure Update(const id: TKey; const dto: TDTO);
    procedure Delete(const id: TKey);

    property Path: string read GetPath write SetPath;
  end;

implementation

end.
