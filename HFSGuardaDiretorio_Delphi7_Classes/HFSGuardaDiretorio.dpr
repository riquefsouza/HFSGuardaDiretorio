program HFSGuardaDiretorio;

uses
  Forms,
  uSplash in 'uSplash.pas' {FrmSplash},
  Bmp2Tiff in 'Bmp2tiff.pas',
  uEscolherDir in 'uEscolherDir.pas' {FrmEscolherDir},
  uAba in 'uAba.pas',
  uArquivo in 'uArquivo.pas',
  uCadExtensao in 'uCadExtensao.pas' {FrmCadExtensao},
  uCompararDiretorio in 'uCompararDiretorio.pas' {FrmCompararDiretorio},
  uDataModule in 'uDataModule.pas' {dm: TDataModule},
  uDiretorio in 'uDiretorio.pas',
  uExtensao in 'uExtensao.pas',
  uImportar in 'uImportar.pas',
  uImportarDiretorio in 'uImportarDiretorio.pas' {FrmImportarDiretorio},
  uPrincipal in 'uPrincipal.pas' {FrmPrincipal},
  uRotinas in 'uRotinas.pas',
  uSobre in 'uSobre.pas' {FrmSobre},
  GIFImage in 'especifico\GIFImage.pas',
  uListaDiretorio in 'especifico\uListaDiretorio.pas',
  uListaExtensao in 'especifico\uListaExtensao.pas',
  uListaImportar in 'especifico\uListaImportar.pas',
  SQLiteTable3 in 'especifico\SQLiteTable3.pas',
  SQLite3 in 'especifico\SQLite3.pas',
  sqlite3udf in 'especifico\sqlite3udf.pas',
  pnglang in 'especifico\pnglang.pas',
  pngextra in 'especifico\pngextra.pas',
  pngimage in 'especifico\pngimage.pas',
  zlibpas in 'especifico\zlibpas.pas',
  uListaAba in 'especifico\uListaAba.pas',
  uAbaObjeto in 'especifico\uAbaObjeto.pas',
  uDiretorioObjeto in 'especifico\uDiretorioObjeto.pas',
  uExtensaoObjeto in 'especifico\uExtensaoObjeto.pas',
  uImportarObjeto in 'especifico\uImportarObjeto.pas',
  uInfoDiretorio in 'uInfoDiretorio.pas' {FrmInfoDiretorio};

{$R *.res}

begin
  Application.Initialize;

  FrmSplash := TFrmSplash.Create(Application);
  FrmSplash.Show;
  FrmSplash.Update;

  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
