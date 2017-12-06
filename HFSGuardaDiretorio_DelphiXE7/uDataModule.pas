unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, Data.DbxSqlite,
  Data.FMTBcd, Datasnap.Provider, Datasnap.DBClient; { SQLiteTable3 }

type
  Tdm = class(TDataModule)
    conexao: TSQLConnection;
    consultaDirFilho: TSQLQuery;
    consultaDirPai: TSQLQuery;
    consultaArquivo: TSQLQuery;
    tabelaAbas: TSQLTable;
    tabelaAbascod: TLargeintField;
    tabelaAbasnome: TWideStringField;
    consultaAuxiliar: TSQLQuery;
    tabelaExtensoes: TSQLTable;
    tabelaDiretorios: TSQLTable;
    cdsDiretorios: TClientDataSet;
    cdsExtensoes: TClientDataSet;
    dspExtensoes: TDataSetProvider;
    dspDiretorios: TDataSetProvider;
    procedure cdsExtensoesBeforeRefresh(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    {
      conexao: TSQLiteDatabase;
      tabelaExtensoes, tabelaAbas: TSQLiteTable;
      SQLDiretorios, SQLExtensoes, SQLAbas: String;
      consultaDirPai, consultaDirFilho, consultaArquivo: String;
    }
  end;

var
  dm: Tdm;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure Tdm.cdsExtensoesBeforeRefresh(DataSet: TDataSet);
begin
  cdsExtensoes.ApplyUpdates(-1);
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  {
    SQLAbas:='select cod, nome from Abas';

    SQLDiretorios:='select aba, cod, ordem, nome, tam, tipo, '+
    'modificado, atributos, coddirpai, caminho from Diretorios';

    SQLExtensoes:='select cod, nome, bmp16, bmp32 from Extensoes';

    consultaDirPai:='select aba, cod, ordem, coddirpai, nome, tam, '+
    'tipo, modificado, atributos, caminho, nomeaba, nomepai, caminhopai '+
    'from consultadirpai '+
    'order by 1,2,3,4';
    consultaDirFilho:='select aba, cod, ordem, coddirpai, nome, tam, '+
    'tipo, modificado, atributos, caminho, nomeaba, nomepai, caminhopai '+
    'from consultadirfilho '+
    'order by 1,2,3,4';
    consultaArquivo:='select aba, cod, ordem, coddirpai, nome, tam, '+
    'tipo, modificado, atributos, caminho, nomeaba, nomepai, caminhopai '+
    'from consultaarquivo '+
    'order by tipo desc, ordem';
  }
end;

end.
