unit uImportar;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, System.Generics.Collections,
  Vcl.ComCtrls, uArquivo, uDiretorio, uExtensao, uRotinas;

type
  TImportar = record
    aba: integer;
    codDirRaiz: integer;
    rotuloRaiz: String;
    nomeDirRaiz: String;
    caminho: String;
  end;

procedure CarregarListaDiretorios(importar: TImportar; var nOrdem: integer;
  listaDiretorio: TList<TDiretorio>; log: TStrings);
procedure ImportacaoCompleta(importar: TImportar; var nOrdem: integer;
  listaExtensao: TList<TExtensao>; log: TStrings; progressoLog: TProgressoLog);

implementation

procedure CarregarListaDiretorios(importar: TImportar; var nOrdem: integer;
  listaDiretorio: TList<TDiretorio>; log: TStrings);
var
  arquivo: TArquivo;
  diretorio: TDiretorio;
begin
  arquivo.nome := importar.rotuloRaiz;
  arquivo.tamanho := 0;
  arquivo.modificado := Now;
  arquivo.atributos := faDirectory;

  diretorio := atribuiDiretorio(importar.aba, importar.codDirRaiz,
    importar.nomeDirRaiz, '', true, listaDiretorio, arquivo, nOrdem);

  listaDiretorio.Add(diretorio);
  log.Append(importar.caminho);

  ImportarDiretorio(importar.aba, importar.codDirRaiz, importar.nomeDirRaiz,
    importar.caminho, listaDiretorio, nOrdem, log);
end;

procedure ImportacaoCompleta(importar: TImportar; var nOrdem: integer;
  listaExtensao: TList<TExtensao>; log: TStrings; progressoLog: TProgressoLog);
var
  listaDiretorio: TList<TDiretorio>;
begin
  listaDiretorio := TList<TDiretorio>.Create;
  try
    CarregarListaDiretorios(importar, nOrdem, listaDiretorio, log);

    if TOSVersion.Platform = pfWindows then
    begin
      salvarExtensoes(listaDiretorio, listaExtensao, log, progressoLog);
    end;
    salvarDiretorio(listaDiretorio, log, progressoLog);
  finally
    listaDiretorio.Free;
  end;
end;

end.
