unit uExtensao;

interface

uses
  Classes, SysUtils, StrUtils, uListaExtensao, uListaDiretorio,
  ComCtrls, DB, uDataModule, Graphics, Controls, uDiretorio,
  GIFImage, Jpeg, Dialogs, SQLiteTable3, uRotinas;

{
type
  TExtensao = record
    codigo: integer;
    nome: String;
    ordem: integer;
    bmp16: Vcl.Graphics.TBitmap;
    bmp32: Vcl.Graphics.TBitmap;
  end;
}
procedure carregarExtensao(listaExtensao: TListaExtensao; progressoLog: TProgressoLog);
function existeExtensao(sExtensao: String;
   listaLocal: TListaExtensao): boolean;
function retMaxCodExtensao(listaLocal: TListaExtensao): integer;
function SalvarExtensao(listaExtensao: TListaExtensao;
  sNomeDiretorio, sCaminhoOriginal: String; log: TStrings): boolean;
procedure salvarExtensoes(listaDiretorio: TListaDiretorio;
  listaExtensao: TListaExtensao; log: TStrings; progressoLog: TProgressoLog);
function extensaoToSQL(extensao: TExtensao; bInsert: boolean): string;
function excluirExtensao(listaExtensao: TListaExtensao;
  codigo: integer): boolean;
function excluirTodasExtensoes(listaExtensao: TListaExtensao): boolean;
function criarTabelaExtensoes:boolean;
procedure incluirExtensao(extensao: TExtensao);
procedure carregarExtensoes(lista: TListaExtensao;
  listaImg16, listaImg32: TImageList);
function indiceExtensao(lista: TListaExtensao; nomeExtensao: String): integer;
procedure ExportarExtensao(tipo: TTipoExportarExtensao;
  listaExtensao: TListaExtensao);
function pegaExtensaoPorOrdem(lista: TListaExtensao; ordem: Integer):
  TExtensao;
procedure ImportarExtensao(caminho: String; listaExtensao: TListaExtensao);
procedure ExtrairExtensao(caminho: String; listaExtensao: TListaExtensao);

implementation

uses pngimage;

function criarTabelaExtensoes:boolean;
var sSQL: string;
begin
  sSQL:='create table IF NOT EXISTS Extensoes('+
  'cod integer not null,'+
  'nome varchar(20) not null,'+
  'bmp16 BLOB COLLATE NOCASE null,'+
  'bmp32 BLOB COLLATE NOCASE null,'+
  'primary key (cod))';
  result:=execConsulta(sSQL, False);
end;

function extensaoToSQL(extensao: TExtensao; bInsert: boolean): string;
var sSQL: string;
begin
  if bInsert then begin
    sSQL:='insert into Extensoes(cod, nome) values(';
  end;

  with extensao do
  begin
    sSQL := sSQL + IntToStr(codigo) + ',';
    sSQL := sSQL + QuotedStr(nome);

    if bInsert then
      sSQL := sSQL + ')';
  end;
  result:=sSQL;
end;

procedure incluirExtensao(extensao: TExtensao);
var sSQL: String;
  ms: TMemoryStream;
begin
  sSQL:=extensaoToSQL(extensao, True);
  execConsulta(sSQL, False);

  ms := TMemoryStream.Create;
	try
    extensao.bmp16.SaveToStream(ms);
    ms.Position := 0;
   	dm.conexao.UpdateBlob('UPDATE Extensoes set bmp16=? WHERE cod=' +
      IntToStr(extensao.codigo), ms);
	finally
    ms.Free;
	end;

  ms := TMemoryStream.Create;
	try
    extensao.bmp32.SaveToStream(ms);
    ms.Position := 0;
   	dm.conexao.UpdateBlob('UPDATE Extensoes set bmp32=? WHERE cod=' +
      IntToStr(extensao.codigo), ms);
	finally
    ms.Free;
	end;

end;

{
procedure incluirExtensao(extensao: TExtensao);
var
  campoBMP16, campoBMP32: TBlobField;
begin
  if dm.cdsExtensoes.Active then begin
    dm.cdsExtensoes.ReadOnly:=false;
    dm.cdsExtensoes.Append;
    dm.cdsExtensoes.Fields.FieldByNumber(1).Value:=extensao.codigo;
    dm.cdsExtensoes.Fields.FieldByNumber(2).Value:=extensao.nome;
    campoBMP16 := TBlobField(dm.cdsExtensoes.Fields.FieldByNumber(3));
    campoBMP32 := TBlobField(dm.cdsExtensoes.Fields.FieldByNumber(4));

    BMPParaBlob(extensao.bmp16, dm.cdsExtensoes, campoBMP16);
    BMPParaBlob(extensao.bmp32, dm.cdsExtensoes, campoBMP32);

    dm.cdsExtensoes.Post;
  end;
end;
}

procedure carregarExtensao(listaExtensao: TListaExtensao; progressoLog: TProgressoLog);
var
  Extensao: TExtensao;
  i, total: integer;
  msBMP16, msBMP32: TMemoryStream;
  pb: TProgresso;
begin
  listaExtensao.Clear;
{
  dm.tabelaExtensoes.Open;
  total := dm.tabelaExtensoes.RecordCount;
  dm.tabelaExtensoes.First;
}
  dm.tabelaExtensoes:=dm.conexao.GetTable(dm.SQLExtensoes);
  total := dm.tabelaExtensoes.Count;
  dm.tabelaExtensoes.MoveFirst;

  if total > 0 then begin
    pb.minimo := 0;
    pb.maximo := total - 1;
    pb.posicao := 0;
    pb.passo := 1;

    for i := 0 to total - 1 do begin
      with Extensao do begin
      {
        codigo := dm.tabelaExtensoes.Fields.FieldByNumber(1).AsInteger;
        nome := dm.tabelaExtensoes.Fields.FieldByNumber(2).AsString;
        campoBMP16 := TBlobField(dm.tabelaExtensoes.Fields.FieldByNumber(3));
        campoBMP32 := TBlobField(dm.tabelaExtensoes.Fields.FieldByNumber(4));
        bmp32:=blobParaBMP(dm.tabelaExtensoes, campoBMP32);
        bmp16:=blobParaBMP(dm.tabelaExtensoes, campoBMP16);
       }
        codigo := dm.tabelaExtensoes.FieldAsInteger(dm.tabelaExtensoes.FieldIndex['cod']);
        nome := dm.tabelaExtensoes.FieldAsString(dm.tabelaExtensoes.FieldIndex['nome']);

        msBMP16 := dm.tabelaExtensoes.FieldAsBlob(dm.tabelaExtensoes.FieldIndex['bmp16']);
        bmp16 := StreamParaBMP(msBMP16);
        msBMP16.Free;

        msBMP32 := dm.tabelaExtensoes.FieldAsBlob(dm.tabelaExtensoes.FieldIndex['bmp32']);
        bmp32 := StreamParaBMP(msBMP32);
        msBMP32.Free;


        ordem:=(i+1);
      end;

      listaExtensao.Add(Extensao);

      dm.tabelaExtensoes.Next;

      pb.posicao := i;

      if Assigned(progressoLog) then begin
        progressoLog(pb);
      end;
    end;
  end;

  //dm.tabelaExtensoes.Close;
end;



function existeExtensao(sExtensao: String;
  listaLocal: TListaExtensao): boolean;
var i: integer;
  extensao: TExtensao;
begin
  result:=false;

  if Length(Trim(sExtensao)) > 0 then begin
    for i := 0 to listaLocal.Count - 1 do begin
      extensao := listaLocal.Items(i);
      if LowerCase(Trim(extensao.nome)) = LowerCase(Trim(sExtensao)) then begin
         result:=true;
         break;
      end;
    end;
  end;

end;

function retMaxCodExtensao(listaLocal: TListaExtensao): integer;
var i, nMaior: integer;
  extensao: TExtensao;
begin
  nMaior:=0;

  for i := 0 to listaLocal.Count - 1 do begin
    extensao := listaLocal.Items(i);
    if (extensao.codigo > nMaior) then begin
       nMaior:=extensao.codigo;
    end;
  end;

  result:=nMaior+1;
end;

function SalvarExtensao(listaExtensao: TListaExtensao;
  sNomeDiretorio, sCaminhoOriginal: string; log: TStrings): boolean;
var
  sExtensao: string;
  extensao: TExtensao;
  icone: TIcon;
begin
  result:=false;

  if LastDelimiter('.', sNomeDiretorio) > 0 then begin
    sExtensao := Copy(sNomeDiretorio, LastDelimiter('.', sNomeDiretorio) + 1,
      Length(sNomeDiretorio));
    if not existeExtensao(sExtensao, listaExtensao) then begin
      extensao.codigo := retMaxCodExtensao(listaExtensao);
      extensao.nome := LowerCase(sExtensao);
      icone := extrairIconeArquivo(sCaminhoOriginal);
      extensao.bmp32 := IconeParaBmp(icone, 32);
      extensao.bmp16 := RedimensionarBMP(extensao.bmp32, 16);
      incluirExtensao(extensao);
      listaExtensao.Add(extensao);
      log.Append('Salvando Extensão: '+extensao.nome);
      result:=true;
    end;
  end;
end;

procedure salvarExtensoes(listaDiretorio: TListaDiretorio;
  listaExtensao: TListaExtensao; log: TStrings; progressoLog: TProgressoLog);
var
  diretorio: TDiretorio;
  i: integer;
  pb: TProgresso;
begin
  pb.minimo := 0;
  pb.maximo := listaDiretorio.Count - 1;
  pb.posicao := 0;
  pb.passo := 1;

  //dm.cdsExtensoes.Open;
  dm.conexao.BeginTransaction;
  for i := 0 to listaDiretorio.Count - 1 do begin
    diretorio := listaDiretorio.Items(i);

    if diretorio.tipo.codigo='A' then begin
      SalvarExtensao(listaExtensao, diretorio.nome,
        diretorio.caminhoOriginal, log);
    end;

    pb.posicao := i;

    if Assigned(progressoLog) then begin
      progressoLog(pb);
    end;

  end;
  dm.conexao.Commit;
  //dm.cdsExtensoes.ApplyUpdates(0);
  //dm.cdsExtensoes.Close;

end;

function excluirExtensao(listaExtensao: TListaExtensao;
  codigo: integer): boolean;
var sSQL: string;
 extensao: TExtensao;
 i: integer;
begin
  sSQL:='delete from Extensoes where cod='+inttostr(codigo);
  if execConsulta(sSQL, True) then begin

    for i := 0 to listaExtensao.Count - 1 do begin
      extensao := listaExtensao.Items(i);
      if extensao.codigo = codigo then begin
         listaExtensao.Delete(i);
         break;
      end;
    end;
    result:=true;
  end else begin
    result:=false;
  end;
end;

function excluirTodasExtensoes(listaExtensao: TListaExtensao): boolean;
var sSQL: string;
begin
  sSQL:='delete from Extensoes';
  if execConsulta(sSQL, True) then begin
    listaExtensao.Clear;
    result:=true;
  end else begin
    result:=false;
  end;
end;

procedure carregarExtensoes(lista: TListaExtensao;
  listaImg16, listaImg32: TImageList);
var i: integer;
 extensao: TExtensao;
begin
  for i := 0 to lista.Count - 1 do begin
    extensao := lista.Items(i);
    listaImg16.Add(extensao.bmp16, nil);
    listaImg32.Add(extensao.bmp32, nil);
  end;
end;

function indiceExtensao(lista: TListaExtensao; nomeExtensao: String): integer;
var i: integer;
 extensao: TExtensao;
begin
  result:=-1;
  nomeExtensao := Copy(nomeExtensao,
    LastDelimiter('.', nomeExtensao)+1, Length(nomeExtensao));

  for i := 0 to lista.Count - 1 do begin
    extensao := lista.Items(i);
    if LowerCase(Trim(extensao.nome)) = LowerCase(Trim(nomeExtensao)) then begin
       result:=extensao.ordem+1;
       break;
    end;
  end;
end;

procedure ImportarExtensao(caminho: String; listaExtensao: TListaExtensao);
var listaArquivos: TStringList;
  i: integer;
  extensao: TExtensao;
  sExtensao, sArquivo: String;
  tipo: TTipoExportarExtensao;
  bmp: Graphics.TBitmap;
begin
  listaArquivos:= TStringList.Create;
  try
    if carregarArquivos(caminho, listaArquivos) then begin

       //dm.cdsExtensoes.Open;
       dm.conexao.BeginTransaction;
       for i := 0 to listaArquivos.Count - 1 do begin
          sArquivo:=listaArquivos.Strings[i];
          sExtensao := Copy(sArquivo, LastDelimiter(BARRA_NORMAL, sArquivo)+1,
            Length(sArquivo));
          sExtensao := Copy(sExtensao, 1, Pos('.', sExtensao)-1);

          if not existeExtensao(sExtensao, listaExtensao) then begin
            bmp:=Graphics.TBitmap.Create;
            tipo:=DetectImage(sArquivo, bmp);

            if tipo<>teNUL then begin
              extensao.codigo := retMaxCodExtensao(listaExtensao);
              extensao.nome := LowerCase(sExtensao);
              extensao.bmp32 := RedimensionarBMP(bmp, 32);
              extensao.bmp16 := RedimensionarBMP(bmp, 16);

              incluirExtensao(extensao);
              listaExtensao.Add(extensao);
            end;
          end;
       end;
       dm.conexao.Commit;
       //dm.cdsExtensoes.ApplyUpdates(0);
       //dm.cdsExtensoes.Close;

    end;
  finally
    listaArquivos.Free;
  end;

end;

procedure ExtrairExtensao(caminho: String; listaExtensao: TListaExtensao);
var listaArquivos: TStringList;
  i: integer;
  sArquivo: String;
  log: TStringList;
begin
  listaArquivos:= TStringList.Create;
  log:=TStringList.Create;
  try
    if carregarTodosArquivos(caminho, listaArquivos) then begin

       //dm.cdsExtensoes.Open;
       dm.conexao.BeginTransaction;
       for i := 0 to listaArquivos.Count - 1 do begin
          sArquivo:=listaArquivos.Strings[i];
          SalvarExtensao(listaExtensao, ExtractFileName(sArquivo),
            sArquivo, log);
       end;
       dm.conexao.Commit;
       //dm.cdsExtensoes.ApplyUpdates(0);
       //dm.cdsExtensoes.Close;

    end;
  finally
    listaArquivos.Free;
    log.Free;
  end;

end;

procedure ExportarExtensao(tipo: TTipoExportarExtensao;
  listaExtensao: TListaExtensao);
var sCaminho, sImg16, sImg32, sExtensao: String;
  i: integer;
  extensao: TExtensao;
  icone: TIcon;
  gifImagem: TGIFImage;
  jpgImagem: TJPEGImage;
  pngImagem: TPngObject;
begin
  if listaExtensao.Count > 0 then begin
    sCaminho:=ExtractFilePath(ParamStr(0));

      case tipo of
        teBMP: sExtensao:='.bmp';
        teICO: sExtensao:='.ico';
        teGIF: sExtensao:='.gif';
        teJPG: sExtensao:='.jpg';
        tePNG: sExtensao:='.png';
        teTIF: sExtensao:='.tif';
      end;

    for i := 0 to listaExtensao.Count - 1 do begin
      extensao := listaExtensao.Items(i);

      sImg16:=sCaminho+extensao.nome+'16'+sExtensao;
      if FileExists(sImg16) then
        DeleteFile(sImg16);

      sImg32:=sCaminho+extensao.nome+'32'+sExtensao;;
      if FileExists(sImg32) then
        DeleteFile(sImg32);

      case tipo of
        teBMP: begin
          extensao.bmp16.SaveToFile(sImg16);
          extensao.bmp32.SaveToFile(sImg32);
        end;
        teICO: begin
          icone:=BmpParaIcone(extensao.bmp16);
          icone.SaveToFile(sImg16);
          icone.Free;

          icone:=BmpParaIcone(extensao.bmp32);
          icone.SaveToFile(sImg32);
          icone.Free;
        end;
        teGIF: begin
          gifImagem:=BmpParaGIF(extensao.bmp16);
          gifImagem.SaveToFile(sImg16);
          gifImagem.Free;

          gifImagem:=BmpParaGIF(extensao.bmp32);
          gifImagem.SaveToFile(sImg32);
          gifImagem.Free;
        end;
        teJPG: begin
          jpgImagem:=BmpParaJPG(extensao.bmp16);
          jpgImagem.SaveToFile(sImg16);
          jpgImagem.Free;

          jpgImagem:=BmpParaJPG(extensao.bmp32);
          jpgImagem.SaveToFile(sImg32);
          jpgImagem.Free;
        end;
        tePNG: begin
          pngImagem:=BmpParaPNG(extensao.bmp16);
          pngImagem.SaveToFile(sImg16);
          pngImagem.Free;

          pngImagem:=BmpParaPNG(extensao.bmp32);
          pngImagem.SaveToFile(sImg32);
          pngImagem.Free;
        end;
        teTIF: begin
          BMPParaTIF(extensao.bmp16, sImg16);
          BMPParaTIF(extensao.bmp32, sImg32);
        end;
      end;

    end;
    MessageDlg('Ícones salvos no mesmo diretório do sistema!',
      mtInformation, [mbOk], 0);
  end;
end;

function pegaExtensaoPorOrdem(lista: TListaExtensao; ordem: Integer):
  TExtensao;
var i: integer;
 extensao: TExtensao;
begin
  for i := 0 to lista.Count - 1 do begin
    extensao := lista.Items(i);
    if extensao.ordem = ordem then begin
       result:=extensao;
       break;
    end;
  end;
end;

end.
