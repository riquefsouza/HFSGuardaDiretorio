unit uRotinas;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, System.Generics.Collections,
  Vcl.ComCtrls, Vcl.Graphics, Data.DB, uDataModule,
  Vcl.Controls, ShellAPI, Vcl.Imaging.GIFImg, Vcl.Imaging.Jpeg,
  System.Math, System.DateUtils, Vcl.Imaging.PNGImage, Bmp2Tiff, Windows;

const
  BARRA_NORMAL: Char = '\';
  BARRA_INVERTIDA: Char = '/';

type
  TTipoExportarExtensao = (teNUL, teBMP, teICO, teGIF, teJPG, tePNG, teTIF);

  TProgresso = record
    minimo: Integer;
    maximo: Integer;
    posicao: Integer;
    passo : Integer;
  end;

  TProgressoLog = procedure(progresso: TProgresso) of object;

function criarVisao(visao: String): boolean;
function execConsulta(sSQL: string; bComTransacao: boolean): boolean;
function atribuirParamsConexao: boolean;
function NomeVolumeDrive(const Drive: Char; Path: string): string;
function extrairIconeArquivo(sNomeArquivo: String): TIcon;
function blobParaGIF(ds: TDataSet; campo: TBlobField;
  var imagem: TGIFImage): boolean;
function blobParaPNG(ds: TDataSet; campo: TBlobField): TPNGImage;
procedure GIFParaBlob(imagem: TGIFImage; ds: TDataSet; campo: TBlobField);
procedure PNGParaBlob(imagem: TPNGImage; ds: TDataSet; campo: TBlobField);
function blobParaJPG(ds: TDataSet; campo: TBlobField): TJPEGImage;
procedure JPGParaBlob(imagem: TJPEGImage; ds: TDataSet; campo: TBlobField);
function blobParaIcone(ds: TDataSet; campo: TBlobField): TIcon;
function blobParaBMP(ds: TDataSet; campo: TBlobField): Vcl.Graphics.TBitmap;
procedure IconeParaBlob(imagem: TIcon; ds: TDataSet; campo: TBlobField);
procedure BMPParaBlob(imagem: Vcl.Graphics.TBitmap; ds: TDataSet;
  campo: TBlobField);
function IconeParaBmp(Icone: TIcon; nTamanho: integer): Vcl.Graphics.TBitmap;
function BmpParaIcone(Bitmap: Vcl.Graphics.TBitmap): TIcon;
function BMPParaGIF(bmp: Vcl.Graphics.TBitmap): TGIFImage;
function GIFParaBMP(gif: TGIFImage; nTamanho: integer): Vcl.Graphics.TBitmap;
function BMPParaJPG(bmp: Vcl.Graphics.TBitmap): TJPEGImage;
function JPGParaBMP(jpg: TJPEGImage; nTamanho: integer): Vcl.Graphics.TBitmap;
function BMPParaPNG(bmp: Vcl.Graphics.TBitmap): TPNGImage;
function PNGParaBMP(png: TPNGImage; nTamanho: integer): Vcl.Graphics.TBitmap;
procedure BMPParaTIF(bmp: Vcl.Graphics.TBitmap; sArquivo: String);
function DetectImage(const InputFileName: string; BM: Vcl.Graphics.TBitmap)
  : TTipoExportarExtensao;
function StreamParaIcone(ms: TMemoryStream): TIcon;
function StreamParaGIF(ms: TMemoryStream): TGIFImage;
function StreamParaJPG(ms: TMemoryStream): TJPEGImage;
function JPGParaStream(imagem: TJPEGImage): TMemoryStream;
procedure StreamParaBlob(ms: TMemoryStream; ds: TDataSet; campo: TBlobField);
function RedimensionarBMP(imagem: Vcl.Graphics.TBitmap; nTamanho: integer)
  : Vcl.Graphics.TBitmap;
function CompareTextAsInteger(const s1, s2: string): Integer;
function CompareTextAsDateTime(const s1, s2: string): Integer;

implementation

uses uDiretorio, uExtensao, uAba;

function NomeVolumeDrive(const Drive: Char; Path: string): string;
var
  MaxCompLen, FileSysFlag, PrevErrorMode: Cardinal;
begin
  if Path = '' then
    Path := string(Drive + ':\');

  SetLength(Result, 255);

  PrevErrorMode := SetErrorMode(Windows.SEM_FAILCRITICALERRORS);
  try
    if GetVolumeInformation(PChar(Path), PChar(Result), 255, nil, MaxCompLen,
      FileSysFlag, nil, 0) then
      Result := string(PChar(Result))
    else
      Result := '';
  finally
    SetErrorMode(PrevErrorMode);
  end;
end;

function execConsulta(sSQL: string; bComTransacao: boolean): boolean;
begin
  dm.consultaAuxiliar.close;
  dm.consultaAuxiliar.SQL.Text := sSQL;
  Result := (dm.consultaAuxiliar.ExecSQL() > 0);
end;

{
  function execConsulta(sSQL: string; bComTransacao: Boolean): boolean;
  begin
  if bComTransacao then begin
  dm.conexao.BeginTransaction;
  end;

  dm.conexao.ExecSQL(sSQL);

  if bComTransacao then begin
  dm.conexao.Commit;
  end;

  result:=True;
  end;
}

function atribuirParamsConexao: boolean;
var
  sDLL, sBanco: String;
  aba: TAba;
begin
  sDLL := ExtractFilePath(ParamStr(0)) + 'sqlite3.dll';

  if FileExists(sDLL) then
  begin
    sBanco := ExtractFilePath(ParamStr(0)) + 'GuardaDir.db';

    // dm.conexao := TSQLiteDatabase.Create(sBanco);

    dm.conexao.DriverName := 'Sqlite';
    with dm.conexao.Params do
    begin
      Clear;
      Append('DriverName=Sqlite');
      Append('DriverUnit=Data.DbxSqlite');
      Append('DriverPackageLoader=TDBXSqliteDriverLoader,DBXSqliteDriver210.bpl');
      Append('MetaDataPackageLoader=TDBXSqliteMetaDataCommandFactory,DbxSqliteDriver210.bpl');
      Append('FailIfMissing=False');
      Append('Database=' + sBanco);
    end;

    if not FileExists(sBanco) then
    begin
      dm.conexao.Open();

      criarTabelaAbas;

      aba.codigo := 1;
      aba.nome := 'DVD';
      incluirAba(aba);

      criarTabelaExtensoes;
      criarTabelaDiretorios;
      criarVisao('consultadirpai');
      criarVisao('consultadirfilho');
      criarVisao('consultaarquivo');
    end
    else
      dm.conexao.Open();

    Result := True;
  end
  else
    Result := False;
end;

function extrairIconeArquivo(sNomeArquivo: String): TIcon;
var
  Icone: TIcon;
  filtro: Word;
begin
  filtro := 0;
  Icone := TIcon.Create;
  Icone.Handle := ExtractAssociatedIcon(hInstance, PChar(sNomeArquivo), filtro);
  Result := Icone;
end;

function blobParaGIF(ds: TDataSet; campo: TBlobField;
  var imagem: TGIFImage): boolean;
var
  Stream: TStream;
begin
  imagem := TGIFImage.Create;
  try
    Stream := ds.CreateBlobStream(campo, bmRead);
    try
      Stream.Position := 0;
      imagem.LoadFromStream(Stream);
      Result := True;
    finally
      Stream.Free;
    end;
  except
    Result := False;
  end;
end;

function blobParaPNG(ds: TDataSet; campo: TBlobField): TPNGImage;
var
  Stream: TStream;
  imagem: TPNGImage;
begin
  imagem := TPNGImage.Create;
  Stream := ds.CreateBlobStream(campo, bmRead);
  try
    Stream.Position := 0;
    imagem.LoadFromStream(Stream);
    Result := imagem;
  finally
    Stream.Free;
  end;
end;

procedure GIFParaBlob(imagem: TGIFImage; ds: TDataSet; campo: TBlobField);
var
  blob: TStream;
  ms: TMemoryStream;
begin
  blob := ds.CreateBlobStream(campo, bmWrite);
  ms := TMemoryStream.Create;
  try
    imagem.SaveToStream(ms);
    ms.Position := 0;
    blob.Seek(0, soFromBeginning);
    blob.CopyFrom(ms, ms.Size);
  finally
    ms.Free;
    blob.Free;
  end;
end;

procedure PNGParaBlob(imagem: TPNGImage; ds: TDataSet; campo: TBlobField);
var
  blob: TStream;
  ms: TMemoryStream;
begin
  blob := ds.CreateBlobStream(campo, bmWrite);
  ms := TMemoryStream.Create;
  try
    imagem.SaveToStream(ms);
    ms.Position := 0;
    blob.Seek(0, soFromBeginning);
    blob.CopyFrom(ms, ms.Size);
  finally
    ms.Free;
    blob.Free;
  end;
end;

function blobParaJPG(ds: TDataSet; campo: TBlobField): TJPEGImage;
var
  blob: TStream;
  ms: TMemoryStream;
  imagem: TJPEGImage;
begin
  imagem := TJPEGImage.Create;
  // imagem.CompressionQuality := 100;
  blob := ds.CreateBlobStream(campo, bmRead);
  ms := TMemoryStream.Create;
  try
    blob.Seek(0, soFromBeginning);
    ms.CopyFrom(blob, blob.Size);
    ms.Position := 0;
    imagem.LoadFromStream(ms);
    Result := imagem;
  finally
    ms.Free;
    blob.Free;
  end;
end;

procedure JPGParaBlob(imagem: TJPEGImage; ds: TDataSet; campo: TBlobField);
var
  blob: TStream;
  ms: TMemoryStream;
begin
  blob := ds.CreateBlobStream(campo, bmWrite);
  ms := TMemoryStream.Create;
  try
    imagem.CompressionQuality := 100;
    imagem.SaveToStream(ms);

    ms.Position := 0;
    blob.Seek(0, soFromBeginning);
    blob.CopyFrom(ms, ms.Size);
  finally
    ms.Free;
    blob.Free;
  end;
end;

procedure StreamParaBlob(ms: TMemoryStream; ds: TDataSet; campo: TBlobField);
var
  blob: TStream;
begin
  blob := ds.CreateBlobStream(campo, bmWrite);
  try
    ms.Position := 0;
    blob.Seek(0, soFromBeginning);
    blob.CopyFrom(ms, ms.Size);
  finally
    ms.Free;
    blob.Free;
  end;
end;

function blobParaIcone(ds: TDataSet; campo: TBlobField): TIcon;
var
  Stream: TStream;
  imagem: TIcon;
begin
  imagem := TIcon.Create;
  Stream := ds.CreateBlobStream(campo, bmReadWrite);
  try
    Stream.Position := 0;
    imagem.LoadFromStream(Stream);
    Result := imagem;
  finally
    Stream.Free;
  end;
end;

function blobParaBMP(ds: TDataSet; campo: TBlobField): Vcl.Graphics.TBitmap;
var
  Stream: TStream;
  imagem: Vcl.Graphics.TBitmap;
begin
  imagem := Vcl.Graphics.TBitmap.Create;
  Stream := ds.CreateBlobStream(campo, bmReadWrite);
  try
    Stream.Position := 0;
    imagem.LoadFromStream(Stream);
    Result := imagem;
  finally
    Stream.Free;
  end;
end;

procedure IconeParaBlob(imagem: TIcon; ds: TDataSet; campo: TBlobField);
var
  blob: TStream;
  ms: TMemoryStream;
begin
  blob := ds.CreateBlobStream(campo, bmWrite);
  ms := TMemoryStream.Create;
  try
    imagem.SaveToStream(ms);
    ms.Position := 0;
    blob.Seek(0, soFromBeginning);
    blob.CopyFrom(ms, ms.Size);
  finally
    ms.Free;
    blob.Free;
  end;
end;

procedure BMPParaBlob(imagem: Vcl.Graphics.TBitmap; ds: TDataSet;
  campo: TBlobField);
var
  blob: TStream;
  ms: TMemoryStream;
begin
  blob := ds.CreateBlobStream(campo, bmWrite);
  ms := TMemoryStream.Create;
  try
    imagem.SaveToStream(ms);
    ms.Position := 0;
    blob.Seek(0, soFromBeginning);
    blob.CopyFrom(ms, ms.Size);
  finally
    ms.Free;
    blob.Free;
  end;
end;

function criarVisao(visao: String): boolean;
var
  sSQL: string;
begin
  sSQL := 'create view ' + visao + ' as ' +
    'SELECT d.aba,d.cod,d.ordem,d.coddirpai,d.nome,d.tam,d.tipo,d.modificado,' +
    'd.atributos,d.caminho' +
    ',(select nome as nomeaba from Abas where cod=d.aba) as nomeaba' +
    ',(select nome as nomepai from Diretorios where cod=d.cod ' +
    '  and ordem=d.coddirpai and aba=d.aba) as nomepai' +
    ',(select caminho as caminhopai from Diretorios where cod=d.cod ' +
    ' and ordem=d.coddirpai and aba=d.aba) as caminhopai ' +
    'FROM Diretorios d ';

  if visao = 'consultadirpai' then
    sSQL := sSQL + 'where d.tipo=''D'' and d.coddirpai = 0'
  else if visao = 'consultadirfilho' then
    sSQL := sSQL + 'where d.tipo=''D'' and d.coddirpai > 0';

  Result := execConsulta(sSQL, False);
end;

function IconeParaBmp(Icone: TIcon; nTamanho: integer): Vcl.Graphics.TBitmap;
var
  // IconInfo: TIconInfo;
  bmp: Vcl.Graphics.TBitmap;
begin
  // GetIconInfo( Icone.Handle, IconInfo );
  bmp := Vcl.Graphics.TBitmap.Create;
  // bmp.Width := ( IconInfo.xHotspot * 2 );
  // bmp.Height := ( IconInfo.yHotspot * 2 );
  bmp.Width := nTamanho;
  bmp.Height := nTamanho;
  // para salvar bmp com formato de 256 cores
  // bmp.PixelFormat := pf8bit;
  // bmp.PixelFormat := pfDevice;
  // bmp.Transparent := True;
  // bmp.TransparentMode := tmAuto;
  bmp.Canvas.StretchDraw(Rect(0, 0, bmp.Width, bmp.Height), Icone);

  Result := bmp;
end;

function RedimensionarBMP(imagem: Vcl.Graphics.TBitmap; nTamanho: integer)
  : Vcl.Graphics.TBitmap;
var
  bmp: Vcl.Graphics.TBitmap;
begin
  bmp := Vcl.Graphics.TBitmap.Create;
  bmp.Width := nTamanho;
  bmp.Height := nTamanho;
  // bmp.PixelFormat := pf8bit;
  // bmp.Transparent := True;
  // bmp.TransparentMode := tmAuto;
  bmp.Canvas.StretchDraw(Rect(0, 0, bmp.Width, bmp.Height), imagem);
  Result := bmp;
end;

function BmpParaIcone(Bitmap: Vcl.Graphics.TBitmap): TIcon;
var
  IconInfo: TIconInfo;
begin
  IconInfo.fIcon := True;
  IconInfo.xHotspot := Bitmap.Width;
  IconInfo.yHotspot := Bitmap.Height;
  IconInfo.hbmColor := Bitmap.Handle;
  IconInfo.hbmMask := Bitmap.MaskHandle;
  Result := TIcon.Create;
  with Result do
    Handle := CreateIconIndirect(IconInfo);
end;

function BMPParaGIF(bmp: Vcl.Graphics.TBitmap): TGIFImage;
var
  gif: TGIFImage;
begin
  gif := TGIFImage.Create;
  gif.Width := bmp.Width;
  gif.Height := bmp.Height;
  gif.Assign(bmp);
  Result := gif;
end;

function GIFParaBMP(gif: TGIFImage; nTamanho: integer): Vcl.Graphics.TBitmap;
var
  bmp: Vcl.Graphics.TBitmap;
begin
  bmp := Vcl.Graphics.TBitmap.Create;
  bmp.Width := nTamanho;
  bmp.Height := nTamanho;
  // para salvar bmp com formato de 256 cores
  bmp.PixelFormat := pf8bit;
  bmp.Canvas.StretchDraw(Rect(0, 0, bmp.Width, bmp.Height), gif);
  // bmp.Assign(gif);
  Result := bmp;
end;

function BMPParaJPG(bmp: Vcl.Graphics.TBitmap): TJPEGImage;
var
  jpg: TJPEGImage;
begin
  jpg := TJPEGImage.Create;
  jpg.CompressionQuality := 100;
  jpg.Assign(bmp);
  Result := jpg;
end;

function JPGParaBMP(jpg: TJPEGImage; nTamanho: integer): Vcl.Graphics.TBitmap;
var
  bmp: Vcl.Graphics.TBitmap;
begin
  bmp := Vcl.Graphics.TBitmap.Create;
  bmp.Width := nTamanho;
  bmp.Height := nTamanho;
  // para salvar bmp com formato de 256 cores
  bmp.PixelFormat := pf8bit;
  bmp.Canvas.StretchDraw(Rect(0, 0, bmp.Width, bmp.Height), jpg);
  // bmp.Assign(jpg);
  Result := bmp;
end;

function BMPParaPNG(bmp: Vcl.Graphics.TBitmap): TPNGImage;
var
  png: TPNGImage;
begin
  png := TPNGImage.Create;
  png.Assign(bmp);
  Result := png;
end;

function PNGParaBMP(png: TPNGImage; nTamanho: integer): Vcl.Graphics.TBitmap;
var
  bmp: Vcl.Graphics.TBitmap;
begin
  bmp := Vcl.Graphics.TBitmap.Create;
  bmp.Width := nTamanho;
  bmp.Height := nTamanho;
  // para salvar bmp com formato de 256 cores
  bmp.PixelFormat := pf8bit;
  bmp.Canvas.StretchDraw(Rect(0, 0, bmp.Width, bmp.Height), png);
  // bmp.Assign(png);
  Result := bmp;
end;

procedure BMPParaTIF(bmp: Vcl.Graphics.TBitmap; sArquivo: String);
begin
  WriteTiffToFile(sArquivo, bmp);
end;

function DetectImage(const InputFileName: string; BM: Vcl.Graphics.TBitmap)
  : TTipoExportarExtensao;
var
  FS: TFileStream;
  FirstBytes: AnsiString;
  Graphic: TGraphic;
begin
  Result := teNUL;

  Graphic := nil;
  FS := TFileStream.Create(InputFileName, fmOpenRead);
  try
    SetLength(FirstBytes, 8);
    FS.Read(FirstBytes[1], 8);
    if Copy(FirstBytes, 1, 2) = 'BM' then
    begin
      Graphic := Vcl.Graphics.TBitmap.Create;
      Result := teBMP;
    end
    else if FirstBytes = #137'PNG'#13#10#26#10 then
    begin
      Graphic := TPNGImage.Create;
      Result := tePNG;
    end
    else if Copy(FirstBytes, 1, 3) = 'GIF' then
    begin
      Graphic := TGIFImage.Create;
      Result := teGIF;
    end
    else if Copy(FirstBytes, 1, 2) = #$FF#$D8 then
    begin
      Graphic := TJPEGImage.Create;
      Result := teJPG;
    end;
    if Assigned(Graphic) then
    begin
      try
        FS.Seek(0, soFromBeginning);
        Graphic.LoadFromStream(FS);
        BM.Assign(Graphic);
      except
      end;
      Graphic.Free;
    end;
  finally
    FS.Free;
  end;
end;

function StreamParaIcone(ms: TMemoryStream): TIcon;
var
  imagem: TIcon;
begin
  imagem := TIcon.Create;
  ms.Position := 0;
  imagem.LoadFromStream(ms);
  Result := imagem;
end;

function StreamParaGIF(ms: TMemoryStream): TGIFImage;
var
  imagem: TGIFImage;
begin
  imagem := TGIFImage.Create;
  ms.Position := 0;
  imagem.LoadFromStream(ms);
  Result := imagem;
end;

function StreamParaJPG(ms: TMemoryStream): TJPEGImage;
var
  imagem: TJPEGImage;
begin
  imagem := TJPEGImage.Create;
  imagem.CompressionQuality := 100;

  ms.Position := 0;
  imagem.LoadFromStream(ms);
  Result := imagem;
end;

function JPGParaStream(imagem: TJPEGImage): TMemoryStream;
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  imagem.SaveToStream(ms);
  ms.Position := 0;
  Result := ms;
end;

function CompareTextAsInteger(const s1, s2: string): Integer;
begin
  Result := CompareValue(StrToInt(s1), StrToInt(s2));
end;

function CompareTextAsDateTime(const s1, s2: string): Integer;
begin
  Result := CompareDateTime(StrToDateTime(s1), StrToDateTime(s2));
end;

end.
