unit uCadExtensao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, FMTBcd,
  DB, Grids, DBGrids, ExtCtrls, DBCtrls, GIFImage, ExtDlgs, Menus;
  
type
  TFrmCadExtensao = class(TForm)
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    Extensao1: TMenuItem;
    ExportarTodos1: TMenuItem;
    IncluirExtensao1: TMenuItem;
    ExcluirExtensao1: TMenuItem;
    ExcluirTodasExtensoes1: TMenuItem;
    ExportarBitmap1: TMenuItem;
    ExportarIcone1: TMenuItem;
    ExportarGIF1: TMenuItem;
    ExportarJPEG1: TMenuItem;
    ExportarPNG1: TMenuItem;
    ExportarTIFF1: TMenuItem;
    sgExtensao: TStringGrid;
    ImportarTodos1: TMenuItem;
    ExtrairIconesArquivos1: TMenuItem;
    ImportarIconesArquivos1: TMenuItem;
    Panel1: TPanel;
    btnIncluir: TButton;
    btnExcluir: TButton;
    procedure FormShow(Sender: TObject);
    procedure IncluirExtensao1Click(Sender: TObject);
    procedure ExcluirExtensao1Click(Sender: TObject);
    procedure ExcluirTodasExtensoes1Click(Sender: TObject);
    procedure ExportarBitmap1Click(Sender: TObject);
    procedure ExportarIcone1Click(Sender: TObject);
    procedure ExportarGIF1Click(Sender: TObject);
    procedure ExportarJPEG1Click(Sender: TObject);
    procedure ExportarPNG1Click(Sender: TObject);
    procedure ExportarTIFF1Click(Sender: TObject);
    procedure sgExtensaoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ImportarIconesArquivos1Click(Sender: TObject);
    procedure ExtrairIconesArquivos1Click(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarExtensoesNaGrid;
  public
    { Public declarations }
  end;

var
  FrmCadExtensao: TFrmCadExtensao;

implementation

{$R *.dfm}

uses uDataModule, uRotinas, uPrincipal, uListaExtensao, uExtensao,
  uEscolherDir;

procedure TFrmCadExtensao.ExcluirExtensao1Click(Sender: TObject);
var extensao: TExtensao;
begin
  if FrmPrincipal.listaExtensoes.Count > 0 then begin
    if MessageDlg('Tem Certeza, que você deseja excluir esta extensão?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin

        extensao:=pegaExtensaoPorOrdem(FrmPrincipal.listaExtensoes,
          sgExtensao.Row);

        if excluirExtensao(FrmPrincipal.listaExtensoes,extensao.codigo) then begin
          CarregarExtensoesNaGrid;
          MessageDlg('Extensão excluída com sucesso!', mtInformation, [mbOk], 0);
        end;
    end;
  end;
end;

procedure TFrmCadExtensao.ExcluirTodasExtensoes1Click(Sender: TObject);
begin
  if FrmPrincipal.listaExtensoes.Count > 0 then begin
    if MessageDlg('Tem Certeza, que você deseja excluir todas as extensões?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      if excluirTodasExtensoes(FrmPrincipal.listaExtensoes) then begin
        CarregarExtensoesNaGrid;
        MessageDlg('Extensões excluídas com sucesso!', mtInformation, [mbOk], 0);
      end;
    end;
  end;
end;

procedure TFrmCadExtensao.ExportarBitmap1Click(Sender: TObject);
begin
  ExportarExtensao(teBMP, FrmPrincipal.listaExtensoes);
end;

procedure TFrmCadExtensao.ExportarGIF1Click(Sender: TObject);
begin
  ExportarExtensao(teGIF, FrmPrincipal.listaExtensoes);
end;

procedure TFrmCadExtensao.ExportarIcone1Click(Sender: TObject);
begin
  ExportarExtensao(teICO, FrmPrincipal.listaExtensoes);
end;

procedure TFrmCadExtensao.ExportarJPEG1Click(Sender: TObject);
begin
  ExportarExtensao(teJPG, FrmPrincipal.listaExtensoes);
end;

procedure TFrmCadExtensao.ExportarPNG1Click(Sender: TObject);
begin
  ExportarExtensao(tePNG, FrmPrincipal.listaExtensoes);
end;

procedure TFrmCadExtensao.ExportarTIFF1Click(Sender: TObject);
begin
  ExportarExtensao(teTIF, FrmPrincipal.listaExtensoes);
end;

procedure TFrmCadExtensao.FormShow(Sender: TObject);
begin
CarregarExtensoesNaGrid;
end;

procedure TFrmCadExtensao.IncluirExtensao1Click(Sender: TObject);
var log: TStringList;
extensao: TExtensao;
begin
  if OpenDialog1.Execute then begin
    log:=TStringList.Create;
    //dm.cdsExtensoes.Open;
    try
      if SalvarExtensao(FrmPrincipal.listaExtensoes,
         ExtractFileName(OpenDialog1.FileName),
         OpenDialog1.FileName, log) then begin

        //dm.cdsExtensoes.ApplyUpdates(0);

        sgExtensao.RowCount:=FrmPrincipal.listaExtensoes.Count+1;
        extensao:=FrmPrincipal.listaExtensoes.Items(sgExtensao.RowCount-2);
        sgExtensao.Cells[0,sgExtensao.RowCount-1]:=extensao.nome;
        sgExtensao.Cells[1,sgExtensao.RowCount-1]:='';
        extensao.ordem:=FrmPrincipal.listaExtensoes.Count;
        FrmPrincipal.ImageList1.Add(extensao.bmp16, nil);
        FrmPrincipal.ImageList2.Add(extensao.bmp32, nil);

        MessageDlg('Extensão salva com sucesso!', mtInformation, [mbOk], 0);
      end else
        MessageDlg('Extensão já existe cadastrada!', mtInformation, [mbOk], 0);
    finally
      log.Free;
      //dm.cdsExtensoes.Close;
    end;
  end;
end;

procedure TFrmCadExtensao.sgExtensaoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  extensao: TExtensao;
begin
  if (ACol = 1) and (ARow > 0) then begin
    if FrmPrincipal.listaExtensoes.Count > 0 then begin
      extensao:=FrmPrincipal.listaExtensoes.Items(ARow-1);
      sgExtensao.Canvas.Draw(Rect.Left + 2, Rect.Top + 2, extensao.bmp16);
    end;
  end;
end;

procedure TFrmCadExtensao.CarregarExtensoesNaGrid;
var extensao: TExtensao;
 i: integer;
begin
  sgExtensao.ColCount:=2;
  if FrmPrincipal.listaExtensoes.Count > 0 then
    sgExtensao.RowCount:=FrmPrincipal.listaExtensoes.Count+1
  else
    sgExtensao.RowCount:=2;
  sgExtensao.DefaultColWidth:=100;
  sgExtensao.DefaultRowHeight:=18;
  sgExtensao.FixedCols:=0;
  sgExtensao.FixedRows:=1;

  sgExtensao.Cells[0,0]:='Extensão';
  sgExtensao.Cells[1,0]:='Ícone';

  sgExtensao.Cells[0,1]:='';
  sgExtensao.Cells[1,1]:='';

  for i := 0 to FrmPrincipal.listaExtensoes.Count - 1 do begin
    extensao := FrmPrincipal.listaExtensoes.Items(i);
    sgExtensao.Cells[0,i+1]:=extensao.nome;
  end;

end;

procedure TFrmCadExtensao.ImportarIconesArquivos1Click(Sender: TObject);
var sCaminho: String;
begin
  Application.CreateForm(TFrmEscolherDir, FrmEscolherDir);
  if FrmEscolherDir.ShowModal() = mrOk then begin
    sCaminho := FrmEscolherDir.labDiretorio.Caption;
    ImportarExtensao(sCaminho, FrmPrincipal.listaExtensoes);
    CarregarExtensoesNaGrid;
  end;
  FrmEscolherDir.Free;
end;

procedure TFrmCadExtensao.ExtrairIconesArquivos1Click(Sender: TObject);
var sCaminho: String;
begin
  Application.CreateForm(TFrmEscolherDir, FrmEscolherDir);
  if FrmEscolherDir.ShowModal() = mrOk then begin
    sCaminho := FrmEscolherDir.labDiretorio.Caption;
    ExtrairExtensao(sCaminho, FrmPrincipal.listaExtensoes);
    CarregarExtensoesNaGrid;
  end;
  FrmEscolherDir.Free;
end;

end.
