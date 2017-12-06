unit uListaExtensao;

interface

uses Classes, SysUtils, Graphics, GIFImage;

Type
  PTExtensao = ^TExtensao;
  TExtensao = record
    codigo: integer;
    nome: String;
    ordem: integer;
    bmp16: TBitmap;
    bmp32: TBitmap;
  end;

  TListaExtensao = class
  private
    { private declarations }
    FListaExtensao : TList;
    RExtensao: PTExtensao;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create;
    procedure Add(pExtensao: TExtensao);
    procedure Delete(Index: Integer);
    function Count: Integer;
    function Items(indice: integer): TExtensao;
    procedure Free;
    procedure Clear;    
  published
    { published declarations }
  end;
implementation

constructor TListaExtensao.Create;
begin
  inherited Create;
  FListaExtensao := TList.Create;
end;

function TListaExtensao.Count: Integer;
begin
  Result := FListaExtensao.Count;
end;

procedure TListaExtensao.Add(pExtensao: TExtensao);
begin
  New(RExtensao);
  RExtensao^.codigo:=pExtensao.codigo;
  RExtensao^.nome:=pExtensao.nome;
  RExtensao^.ordem:=pExtensao.ordem;
  RExtensao^.bmp16:=pExtensao.bmp16;
  RExtensao^.bmp32:=pExtensao.bmp32;  
  FListaExtensao.Add(RExtensao);
end;

procedure TListaExtensao.Delete(Index: Integer);
begin
  FListaExtensao.Delete(Index)
end;

function TListaExtensao.Items(indice: integer): TExtensao;
var extensao: TExtensao;
begin
  RExtensao:=FListaExtensao.Items[indice];
  extensao.codigo:=RExtensao^.codigo;
  extensao.nome:=RExtensao^.nome;
  extensao.ordem:=RExtensao^.ordem;
  extensao.bmp16:=RExtensao^.bmp16;
  extensao.bmp32:=RExtensao^.bmp32;
  result:= extensao;
end;

procedure TListaExtensao.Free;
var i: integer;
begin
  for i := 0 to FListaExtensao.Count - 1 do begin
    RExtensao:=FListaExtensao.Items[i];
    Dispose(RExtensao);
  end;
  FListaExtensao.Free;
end;

procedure TListaExtensao.Clear;
var i: integer;
begin
  for i := 0 to FListaExtensao.Count - 1 do begin
    RExtensao:=FListaExtensao.Items[i];
    Dispose(RExtensao);
  end;
  FListaExtensao.Clear;
end;

end.

