unit uImportar;

interface

uses
  Classes, SysUtils, StrUtils, uListaDiretorio, uListaImportar, uListaExtensao,
  ComCtrls, uArquivo, uDiretorio, uExtensao, uRotinas;
{
type
  TImportar = record
    aba: integer;
    codDirRaiz: integer;
    rotuloRaiz: String;
    nomeDirRaiz: String;
    caminho: String;
  end;
}
procedure CarregarListaDiretorios(importar: TImportar; var nOrdem: integer;
   listaDiretorio: TListaDiretorio; log: TStrings);
procedure ImportacaoCompleta(importar: TImportar; var nOrdem: integer;
  listaExtensao: TListaExtensao; log: TStrings; progressoLog: TProgressoLog);

implementation

procedure CarregarListaDiretorios(importar: TImportar; var nOrdem: integer;
   listaDiretorio: TListaDiretorio; log: TStrings);
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
  listaExtensao: TListaExtensao; log: TStrings; progressoLog: TProgressoLog);
var
  listaDiretorio: TListaDiretorio;
begin
  listaDiretorio := TListaDiretorio.Create;
  try
    CarregarListaDiretorios(importar, nOrdem, listaDiretorio, log);
    salvarExtensoes(listaDiretorio, listaExtensao, log, progressoLog);
    salvarDiretorio(listaDiretorio, log, progressoLog);
  finally
    listaDiretorio.Free;
  end;
end;

end.
