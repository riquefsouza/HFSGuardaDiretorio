unit uExtensao;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, System.Generics.Collections,
  Vcl.ComCtrls, Data.DB, uDataModule, Vcl.Graphics, Vcl.Controls, uDiretorio,
  Vcl.Imaging.GIFImg, Vcl.Imaging.Jpeg, Vcl.Imaging.PNGImage,
  Vcl.Dialogs, System.UITypes, uRotinas;

type
  TExtensao = record
    codigo: integer;
    nome: String;
    ordem: integer;
    bmp16: Vcl.Graphics.TBitmap;
    bmp32: Vcl.Graphics.TBitmap;
  end;

procedure carregarExtensao(listaExtensao: TList<TExtensao>; progressoLog: TProgressoLog);
function existeExtensao(sExtensao: String;
  listaLocal: TList<TExtensao>): boolean;
function retMaxCodExtensao(listaLocal: TList<TExtensao>): integer;
function SalvarExtensao(listaExtensao: TList<TExtensao>;
  sNomeDiretorio, sCaminhoOriginal: String; log: TStrings): boolean;
procedure salvarExtensoes(listaDiretorio: TList<TDiretorio>;
  listaExtensao: TList<TExtensao>; log: TStrings; progressoLog: TProgressoLog);
function extensaoToSQL(extensao: TExtensao; bInsert: boolean): string;
function excluirExtensao(listaExtensao: TList<TExtensao>;
  codigo: integer): boolean;
function excluirTodasExtensoes(listaExtensao: TList<TExtensao>): boolean;
function criarTabelaExtensoes: boolean;
procedure incluirExtensao(extensao: TExtensao);
procedure carregarExtensoes(lista: TList<TExtensao>;
  listaImg16, listaImg32: TImageList);
function indiceExtensao(lista: TList<TExtensao>; nomeExtensao: String): integer;
procedure ExportarExtensao(tipo: TTipoExportarExtensao;
  listaExtensao: TList<TExtensao>);
function pegaExtensaoPorOrdem(lista: TList<TExtensao>; ordem: integer)
  : TExtensao;
procedure ImportarExtensao(caminho: String; listaExtensao: TList<TExtensao>);
procedure ExtrairExtensao(caminho: String; listaExtensao: TList<TExtensao>);

implementation

function criarTabelaExtensoes: boolean;
var
  sSQL: string;
begin
  sSQL := 'create table IF NOT EXISTS Extensoes(' + 'cod integer not null,' +
    'nome varchar(20) not null,' + 'bmp16 BLOB COLLATE NOCASE null,' +
    'bmp32 BLOB COLLATE NOCASE null,' + 'primary key (cod))';
  result := execConsulta(sSQL, False);
end;

function extensaoToSQL(extensao: TExtensao; bInsert: boolean): string;
var
  sSQL: string;
begin
  if bInsert then
  begin
    sSQL := 'insert into Extensoes(cod, nome) values(';
  end;

  with extensao do
  begin
    sSQL := sSQL + IntToStr(codigo) + ',';
    sSQL := sSQL + QuotedStr(nome);

    if bInsert then
      sSQL := sSQL + ')';
  end;
  result := sSQL;
end;

{
  procedure incluirExtensao(extensao: TExtensao);
  var sSQL: String;
  ms: TMemoryStream;
  imagem: TJPEGImage;
  begin
  sSQL:=extensaoToSQL(extensao, True);
  execConsulta(sSQL, False);

  ms := TMemoryStream.Create;
  imagem:=BMPParaJPG(extensao.icone32);
  try
  imagem.SaveToStream(ms);
  ms.Position := 0;
  dm.conexao.UpdateBlob('UPDATE Extensoes set icone=? WHERE cod=' +
  IntToStr(extensao.codigo), ms);
  finally
  ms.Free;
  imagem.Free;
  end;

  end;
}

procedure incluirExtensao(extensao: TExtensao);
var
  campoBMP16, campoBMP32: TBlobField;
begin
  if dm.cdsExtensoes.Active then
  begin
    dm.cdsExtensoes.ReadOnly := False;
    dm.cdsExtensoes.Append;
    dm.cdsExtensoes.Fields.FieldByNumber(1).Value := extensao.codigo;
    dm.cdsExtensoes.Fields.FieldByNumber(2).Value := extensao.nome;
    campoBMP16 := TBlobField(dm.cdsExtensoes.Fields.FieldByNumber(3));
    campoBMP32 := TBlobField(dm.cdsExtensoes.Fields.FieldByNumber(4));

    BMPParaBlob(extensao.bmp16, dm.cdsExtensoes, campoBMP16);
    BMPParaBlob(extensao.bmp32, dm.cdsExtensoes, campoBMP32);

    dm.cdsExtensoes.Post;
  end;
end;

procedure carregarExtensao(listaExtensao: TList<TExtensao>; progressoLog: TProgressoLog);
var
  extensao: TExtensao;
  i, total: integer;
  campoBMP16, campoBMP32: TBlobField;
  pb: TProgresso;
begin
  listaExtensao.Clear;

  dm.tabelaExtensoes.Open;
  total := dm.tabelaExtensoes.RecordCount;
  dm.tabelaExtensoes.First;
  {
    dm.tabelaExtensoes:=dm.conexao.GetTable(dm.SQLExtensoes);
    total := dm.tabelaExtensoes.Count;
    dm.tabelaExtensoes.MoveFirst;
  }
  if total > 0 then
  begin
    pb.minimo := 0;
    pb.maximo := total - 1;
    pb.posicao := 0;
    pb.passo := 1;

    for i := 0 to total - 1 do
    begin
      with extensao do
      begin
        codigo := dm.tabelaExtensoes.Fields.FieldByNumber(1).AsInteger;
        nome := dm.tabelaExtensoes.Fields.FieldByNumber(2).AsString;
        campoBMP16 := TBlobField(dm.tabelaExtensoes.Fields.FieldByNumber(3));
        campoBMP32 := TBlobField(dm.tabelaExtensoes.Fields.FieldByNumber(4));
        bmp32 := blobParaBMP(dm.tabelaExtensoes, campoBMP32);
        bmp16 := blobParaBMP(dm.tabelaExtensoes, campoBMP16);
        {
          codigo := StrToInt(dm.tabelaExtensoes.FieldAsString(dm.tabelaExtensoes.FieldIndex['cod']));
          nome := dm.tabelaExtensoes.FieldAsString(dm.tabelaExtensoes.FieldIndex['nome']);
          ms := dm.tabelaExtensoes.FieldAsBlob(dm.tabelaExtensoes.FieldIndex['icone']);
          icone32 := IconeParaBMP(StreamParaIcone(ms), 32);
          icone16:=RedimensionarBMP(icone32, 16);
          ms := dm.tabelaExtensoes.FieldAsBlob(dm.tabelaExtensoes.FieldIndex['gif']);
          gif:=StreamParaGIF(ms); //32
        }

        ordem := (i+1);
      end;

      listaExtensao.Add(extensao);

      dm.tabelaExtensoes.Next;

      pb.posicao := i;

      if Assigned(progressoLog) then begin
        progressoLog(pb);
      end;

    end;
  end;

  dm.tabelaExtensoes.Close;
end;

function existeExtensao(sExtensao: String;
  listaLocal: TList<TExtensao>): boolean;
var
  i: integer;
  extensao: TExtensao;
begin
  result := False;

  if Length(Trim(sExtensao)) > 0 then
  begin
    for i := 0 to listaLocal.Count - 1 do
    begin
      extensao := listaLocal.Items[i];
      if LowerCase(Trim(extensao.nome)) = LowerCase(Trim(sExtensao)) then
      begin
        result := true;
        break;
      end;
    end;
  end;

end;

function retMaxCodExtensao(listaLocal: TList<TExtensao>): integer;
var
  i, nMaior: integer;
  extensao: TExtensao;
begin
  nMaior := 0;

  for i := 0 to listaLocal.Count - 1 do
  begin
    extensao := listaLocal.Items[i];
    if (extensao.codigo > nMaior) then
    begin
      nMaior := extensao.codigo;
    end;
  end;

  result := nMaior + 1;
end;

function SalvarExtensao(listaExtensao: TList<TExtensao>;
  sNomeDiretorio, sCaminhoOriginal: string; log: TStrings): boolean;
var
  sExtensao: string;
  extensao: TExtensao;
  icone: TIcon;
begin
  result := False;

  if LastDelimiter('.', sNomeDiretorio) > 0 then
  begin
    sExtensao := Copy(sNomeDiretorio, LastDelimiter('.', sNomeDiretorio) + 1,
      Length(sNomeDiretorio));
    if not existeExtensao(sExtensao, listaExtensao) then
    begin
      extensao.codigo := retMaxCodExtensao(listaExtensao);
      extensao.nome := LowerCase(sExtensao);
      icone := extrairIconeArquivo(sCaminhoOriginal);
      extensao.bmp32 := IconeParaBmp(icone, 32);
      extensao.bmp16 := RedimensionarBMP(extensao.bmp32, 16);
      incluirExtensao(extensao);
      listaExtensao.Add(extensao);
      log.Append('Salvando Extensão: ' + extensao.nome);
      result := true;
    end;
  end;
end;

procedure salvarExtensoes(listaDiretorio: TList<TDiretorio>;
  listaExtensao: TList<TExtensao>; log: TStrings; progressoLog: TProgressoLog);
var
  diretorio: TDiretorio;
  i: integer;
  pb: TProgresso;
begin
  pb.minimo := 0;
  pb.maximo := listaDiretorio.Count - 1;
  pb.posicao := 0;
  pb.passo := 1;

  dm.cdsExtensoes.Open;
  // dm.conexao.BeginTransaction;
  for i := 0 to listaDiretorio.Count - 1 do
  begin
    diretorio := listaDiretorio.Items[i];

    if diretorio.tipo.codigo = 'A' then
    begin
      SalvarExtensao(listaExtensao, diretorio.nome,
        diretorio.caminhoOriginal, log);
    end;

    pb.posicao := i;

    if Assigned(progressoLog) then begin
      progressoLog(pb);
    end;
  end;
  // dm.conexao.Commit;
  dm.cdsExtensoes.ApplyUpdates(0);
  dm.cdsExtensoes.Close;

end;

function excluirExtensao(listaExtensao: TList<TExtensao>;
  codigo: integer): boolean;
var
  sSQL: string;
  extensao: TExtensao;
  i: integer;
begin
  sSQL := 'delete from Extensoes where cod=' + IntToStr(codigo);
  if execConsulta(sSQL, true) then
  begin

    for i := 0 to listaExtensao.Count - 1 do
    begin
      extensao := listaExtensao.Items[i];
      if extensao.codigo = codigo then
      begin
        listaExtensao.Delete(i);
        break;
      end;
    end;
    result := true;
  end
  else
  begin
    result := False;
  end;
end;

function excluirTodasExtensoes(listaExtensao: TList<TExtensao>): boolean;
var
  sSQL: string;
begin
  sSQL := 'delete from Extensoes';
  if execConsulta(sSQL, true) then
  begin
    listaExtensao.Clear;
    result := true;
  end
  else
  begin
    result := False;
  end;
end;

procedure carregarExtensoes(lista: TList<TExtensao>;
  listaImg16, listaImg32: TImageList);
var
  i: integer;
  extensao: TExtensao;
begin
  for i := 0 to lista.Count - 1 do
  begin
    extensao := lista.Items[i];
    listaImg16.Add(extensao.bmp16, nil);
    listaImg32.Add(extensao.bmp32, nil);
  end;
end;

function indiceExtensao(lista: TList<TExtensao>; nomeExtensao: String): integer;
var
  i: integer;
  extensao: TExtensao;
begin
  result := -1;
  nomeExtensao := Copy(nomeExtensao, LastDelimiter('.', nomeExtensao) + 1,
    Length(nomeExtensao));

  for i := 0 to lista.Count - 1 do
  begin
    extensao := lista.Items[i];
    if LowerCase(Trim(extensao.nome)) = LowerCase(Trim(nomeExtensao)) then
    begin
      result := extensao.ordem + 1;
      break;
    end;
  end;
end;

procedure ImportarExtensao(caminho: String; listaExtensao: TList<TExtensao>);
var
  listaArquivos: TStringList;
  i: integer;
  extensao: TExtensao;
  sExtensao, sArquivo: String;
  tipo: TTipoExportarExtensao;
  bmp: Vcl.Graphics.TBitmap;
begin
  listaArquivos := TStringList.Create;
  try
    if carregarArquivos(caminho, listaArquivos) then
    begin

      dm.cdsExtensoes.Open;
      // dm.conexao.BeginTransaction;
      for i := 0 to listaArquivos.Count - 1 do
      begin
        sArquivo := listaArquivos.Strings[i];
        sExtensao := Copy(sArquivo, LastDelimiter(BARRA_NORMAL, sArquivo) + 1,
          Length(sArquivo));
        sExtensao := Copy(sExtensao, 1, Pos('.', sExtensao) - 1);

        if not existeExtensao(sExtensao, listaExtensao) then
        begin
          bmp := Vcl.Graphics.TBitmap.Create;
          tipo := DetectImage(sArquivo, bmp);

          if tipo <> teNUL then
          begin
            extensao.codigo := retMaxCodExtensao(listaExtensao);
            extensao.nome := LowerCase(sExtensao);
            extensao.bmp32 := RedimensionarBMP(bmp, 32);
            extensao.bmp16 := RedimensionarBMP(bmp, 16);

            incluirExtensao(extensao);
            listaExtensao.Add(extensao);
          end;
        end;
      end;
      // dm.conexao.Commit;
      dm.cdsExtensoes.ApplyUpdates(0);
      dm.cdsExtensoes.Close;

    end;
  finally
    listaArquivos.Free;
  end;

end;

procedure ExtrairExtensao(caminho: String; listaExtensao: TList<TExtensao>);
var
  listaArquivos: TStringList;
  i: integer;
  sArquivo: String;
  log: TStringList;
begin
  listaArquivos := TStringList.Create;
  log := TStringList.Create;
  try
    if carregarTodosArquivos(caminho, listaArquivos) then
    begin

      dm.cdsExtensoes.Open;
      // dm.conexao.BeginTransaction;
      for i := 0 to listaArquivos.Count - 1 do
      begin
        sArquivo := listaArquivos.Strings[i];
        SalvarExtensao(listaExtensao, ExtractFileName(sArquivo), sArquivo, log);
      end;
      // dm.conexao.Commit;
      dm.cdsExtensoes.ApplyUpdates(0);
      dm.cdsExtensoes.Close;

    end;
  finally
    listaArquivos.Free;
    log.Free;
  end;

end;

procedure ExportarExtensao(tipo: TTipoExportarExtensao;
  listaExtensao: TList<TExtensao>);
var
  sCaminho, sImg16, sImg32, sExtensao: String;
  i: integer;
  extensao: TExtensao;
  icone: TIcon;
  gifImagem: TGIFImage;
  jpgImagem: TJPEGImage;
  pngImagem: TPngImage;
begin
  if listaExtensao.Count > 0 then
  begin
    sCaminho := ExtractFilePath(ParamStr(0));

    case tipo of
      teBMP:
        sExtensao := '.bmp';
      teICO:
        sExtensao := '.ico';
      teGIF:
        sExtensao := '.gif';
      teJPG:
        sExtensao := '.jpg';
      tePNG:
        sExtensao := '.png';
      teTIF:
        sExtensao := '.tif';
    end;

    for i := 0 to listaExtensao.Count - 1 do
    begin
      extensao := listaExtensao.Items[i];

      sImg16 := sCaminho + extensao.nome + '16' + sExtensao;
      if FileExists(sImg16) then
        DeleteFile(sImg16);

      sImg32 := sCaminho + extensao.nome + '32' + sExtensao;;
      if FileExists(sImg32) then
        DeleteFile(sImg32);

      case tipo of
        teBMP:
          begin
            extensao.bmp16.SaveToFile(sImg16);
            extensao.bmp32.SaveToFile(sImg32);
          end;
        teICO:
          begin
            icone := BmpParaIcone(extensao.bmp16);
            icone.SaveToFile(sImg16);
            icone.Free;

            icone := BmpParaIcone(extensao.bmp32);
            icone.SaveToFile(sImg32);
            icone.Free;
          end;
        teGIF:
          begin
            gifImagem := BmpParaGIF(extensao.bmp16);
            gifImagem.SaveToFile(sImg16);
            gifImagem.Free;

            gifImagem := BmpParaGIF(extensao.bmp32);
            gifImagem.SaveToFile(sImg32);
            gifImagem.Free;
          end;
        teJPG:
          begin
            jpgImagem := BmpParaJPG(extensao.bmp16);
            jpgImagem.SaveToFile(sImg16);
            jpgImagem.Free;

            jpgImagem := BmpParaJPG(extensao.bmp32);
            jpgImagem.SaveToFile(sImg32);
            jpgImagem.Free;
          end;
        tePNG:
          begin
            pngImagem := BmpParaPNG(extensao.bmp16);
            pngImagem.SaveToFile(sImg16);
            pngImagem.Free;

            pngImagem := BmpParaPNG(extensao.bmp32);
            pngImagem.SaveToFile(sImg32);
            pngImagem.Free;
          end;
        teTIF:
          begin
            BMPParaTIF(extensao.bmp16, sImg16);
            BMPParaTIF(extensao.bmp32, sImg32);
          end;
      end;

    end;
    MessageDlg('Ícones salvos no mesmo diretório do sistema!', mtInformation,
      [mbOk], 0);
  end;
end;

function pegaExtensaoPorOrdem(lista: TList<TExtensao>; ordem: integer)
  : TExtensao;
var
  i: integer;
  extensao: TExtensao;
begin
  for i := 0 to lista.Count - 1 do
  begin
    extensao := lista.Items[i];
    if extensao.ordem = ordem then
    begin
      result := extensao;
      break;
    end;
  end;
end;

end.
