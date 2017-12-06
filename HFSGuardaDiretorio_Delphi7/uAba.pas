unit uAba;

interface

uses
  Classes, SysUtils, StrUtils, ComCtrls, DB, uDataModule, uListaAba, uRotinas;
{
type
  TAba = record
    codigo: integer;
    nome: String;
    ordem: integer;
  end;
}
procedure carregarAba(listaAba: TListaAba; progressoLog: TProgressoLog);
function retMaxCodAba(listaLocal: TListaAba): integer;
function abaToSQL(aba: TAba): String;
function incluirAba(aba: TAba): boolean;
function alterarAba(aba: TAba): boolean;
function excluirAba(aba: TAba): boolean;
function criarTabelaAbas:boolean;
function pegaAbaPorOrdem(lista: TListaAba; ordem: Integer): TAba;

implementation

procedure carregarAba(listaAba: TListaAba; progressoLog: TProgressoLog);
var
  aba: TAba;
  i, total: integer;
  pb: TProgresso;
begin
  listaAba.Clear;
{
  dm.tabelaAbas.Open;
  total := dm.tabelaAbas.RecordCount;
  dm.tabelaAbas.First;
}
  dm.tabelaAbas:=dm.conexao.GetTable(dm.SQLAbas);
  total := dm.tabelaAbas.Count;
  dm.tabelaAbas.MoveFirst;

  if total > 0 then begin
    pb.minimo := 0;
    pb.maximo := total - 1;
    pb.posicao := 0;
    pb.passo := 1;

    for i := 0 to total - 1 do begin
      with aba do begin
      {
        codigo := dm.tabelaAbas.Fields.FieldByNumber(1).AsInteger;
        nome := dm.tabelaAbas.Fields.FieldByNumber(2).AsString;
      }
        codigo := dm.tabelaAbas.FieldAsInteger(dm.tabelaAbas.FieldIndex['cod']);  //0
        nome := dm.tabelaAbas.FieldAsString(dm.tabelaAbas.FieldIndex['nome']); //1
       
        ordem:=(i+1);
      end;

      listaAba.Add(aba);

      dm.tabelaAbas.Next;

      pb.posicao := i;

      if Assigned(progressoLog) then begin
        progressoLog(pb);
      end;
    end;
  end;

  //dm.tabelaAbas.Close;
end;

function retMaxCodAba(listaLocal: TListaAba): integer;
var i, nMaior: integer;
  aba: TAba;
begin
  nMaior:=0;

  for i := 0 to listaLocal.Count - 1 do begin
    aba := listaLocal.Items(i);
    if (aba.codigo > nMaior) then begin
       nMaior:=aba.codigo;
    end;
  end;

  result:=nMaior+1;
end;

function abaToSQL(aba: TAba): String;
begin
  result:='insert into Abas(cod, nome) values('+
  inttostr(aba.codigo)+','+QuotedStr(aba.nome)+')';
end;

function incluirAba(aba: TAba): boolean;
var sSQL: string;
begin
  sSQL:=abaToSQL(aba);
  result:=execConsulta(sSQL, True);
end;

function alterarAba(aba: TAba): boolean;
var sSQL: string;
begin
  sSQL:='update Abas set nome='+QuotedStr(aba.nome)+
  ' where cod='+inttostr(aba.codigo);
  result:=execConsulta(sSQL, True);
end;

function excluirAba(aba: TAba): boolean;
var sSQL: string;
begin
  sSQL:='delete from Diretorios where aba='+inttostr(aba.codigo);
  execConsulta(sSQL, True);
  sSQL:='delete from Abas where cod='+inttostr(aba.codigo);
  result:=execConsulta(sSQL, True);
end;

function criarTabelaAbas:boolean;
var sSQL: string;
begin
  sSQL:='create table IF NOT EXISTS Abas('+
  'cod integer not null,'+
  'nome varchar(10) not null,'+
  'primary key (cod))';
  result:=execConsulta(sSQL, False);
end;

function pegaAbaPorOrdem(lista: TListaAba; ordem: Integer): TAba;
var i: integer;
 aba: TAba;
begin
  for i := 0 to lista.Count - 1 do begin
    aba := lista.Items(i);
    if aba.ordem = ordem then begin
       result:=aba;
       break;
    end;
  end;
end;

end.
