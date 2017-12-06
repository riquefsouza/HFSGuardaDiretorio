using System;
using System.IO;
using System.Drawing;
using System.Collections.Generic;
using Gtk;
using HFSGuardaDiretorio.catalogador;
using HFSGuardaDiretorio.objetos;
using HFSGuardaDiretorio.objetosgui;
using HFSGuardaDiretorio.objetosbo;
using HFSGuardaDiretorio.comum;

namespace HFSGuardaDiretorio.gui
{
	public partial class FrmCadExtensao : Gtk.Dialog
	{

		private readonly Catalogador catalogador;

		public FrmCadExtensao(FrmPrincipal frmPrincipal)
		{
			this.Build ();
			
			catalogador = frmPrincipal.Catalogador;
			ConstruirGrid();
	        CarregarExtensoesNaGrid();
		}

		private void ConstruirGrid() {
			ListStore lstore;

			tabelaExtensao.AppendColumn("Extensão", new CellRendererText (), "text", 0);
			tabelaExtensao.AppendColumn("Ícone", new CellRendererPixbuf(), "pixbuf", 1);

			tabelaExtensao.Columns [0].MinWidth = 150;
			tabelaExtensao.Columns [1].MinWidth = 100;

			lstore = new ListStore (typeof(string), typeof(Gdk.Pixbuf));

			tabelaExtensao.Model = lstore;
		}

		private void CarregarExtensoesNaGrid() {
			ListStore lstore = (ListStore)tabelaExtensao.Model;

			lstore.Clear ();

			foreach (Extensao extensao in catalogador.listaExtensoes) {
				lstore.AppendValues(extensao.Nome,
					Rotinas.byteArrayToPixbuf(extensao.Bmp16));
			}

		}

		protected void OnIncluirExtensaoActionActivated(object sender, EventArgs e)
		{
			StringList log;
			if (EscolhaArquivo.abrirArquivo(EscolhaArquivo.FILTRO_IMAGEM)) {
				FileInfo arquivo = new FileInfo(EscolhaArquivo.NomeArquivo);
				if (arquivo.Exists) {
					log = new StringList();
					
                    if (ExtensaoBO.Instancia.SalvarExtensao(
                            catalogador.listaExtensoes, arquivo.Name,
                            arquivo.FullName, log)) {

                        CarregarExtensoesNaGrid();

                        Dialogo.mensagemInfo("Extensão salva com sucesso!");
                    } else {
                        Dialogo.mensagemInfo("Extensão já existe cadastrada!");
                    }					
				}
			}
		}

		protected void OnExcluirExtensaoActionActivated (object sender, EventArgs e)
		{
	        Extensao extensao;
	        
	        if (catalogador.listaExtensoes.Count > 0) {
				bool res = Dialogo.confirma("Tem Certeza, que você deseja excluir esta extensão?");
				if (res) {
					TreePath path = tabelaExtensao.Selection.GetSelectedRows () [0];
	                extensao = ExtensaoBO.Instancia.pegaExtensaoPorOrdem(
						catalogador.listaExtensoes, path.Indices[0]+1);
	
	                    if (ExtensaoBO.Instancia.excluirExtensao(
	                            catalogador.listaExtensoes, extensao.Codigo)) {
	                        CarregarExtensoesNaGrid();
	                        Dialogo.mensagemInfo("Extensão excluída com sucesso!");
	                    }
	            }
	        }
		}

		protected void OnExcluirTodasExtensoesActionActivated (object sender, EventArgs e)
		{
			bool res = Dialogo.confirma("Tem Certeza, que você deseja excluir todas as extensões?");
            if (res) {
                if (ExtensaoBO.Instancia.excluirTodasExtensoes(
                        catalogador.listaExtensoes)) {
                    CarregarExtensoesNaGrid();
                    Dialogo.mensagemInfo("Extensões excluídas com sucesso!");
                }
			}
		}	

		protected void OnExportarParaTIFFActionActivated (object sender, EventArgs e)
		{
			ExtensaoBO.Instancia.ExportarExtensao(
				TipoExportarExtensao.teTIF, catalogador.listaExtensoes);
		}

		protected void OnExportarParaPNGActionActivated (object sender, EventArgs e)
		{
			ExtensaoBO.Instancia.ExportarExtensao(
				TipoExportarExtensao.tePNG, catalogador.listaExtensoes);
		}

		protected void OnExportarParaJPEGActionActivated (object sender, EventArgs e)
		{
			ExtensaoBO.Instancia.ExportarExtensao(
				TipoExportarExtensao.teJPG, catalogador.listaExtensoes);
		}

		protected void OnExportarParaGIFActionActivated (object sender, EventArgs e)
		{
			ExtensaoBO.Instancia.ExportarExtensao(
				TipoExportarExtensao.teGIF, catalogador.listaExtensoes);			
		}

		protected void OnExportarParaIConeActionActivated (object sender, EventArgs e)
		{
			ExtensaoBO.Instancia.ExportarExtensao(
				TipoExportarExtensao.teICO, catalogador.listaExtensoes);
		}

		protected void OnExportarParaBitmapActionActivated (object sender, EventArgs e)
		{
			ExtensaoBO.Instancia.ExportarExtensao(
				TipoExportarExtensao.teBMP, catalogador.listaExtensoes);
		}

		protected void OnImportarIconesDosArquivosActionActivated (object sender, EventArgs e)
		{
			if (EscolhaArquivo.abrirArquivo(EscolhaArquivo.FILTRO_IMAGEM)) {
				FileInfo arquivo = new FileInfo(EscolhaArquivo.NomeArquivo);
				if (arquivo.Exists) {
                    ExtensaoBO.Instancia.ImportarExtensao(arquivo.FullName,
                            catalogador.listaExtensoes);
                    CarregarExtensoesNaGrid();					
				}
			}
		}
		
		protected void OnExtrairIconesDosArquivosActionActivated (object sender, EventArgs e)
		{
			if (EscolhaArquivo.abrirArquivo(EscolhaArquivo.FILTRO_IMAGEM)) {
				FileInfo arquivo = new FileInfo(EscolhaArquivo.NomeArquivo);
				if (arquivo.Exists) {
                    ExtensaoBO.Instancia.ExtrairExtensao(arquivo.FullName,
                            catalogador.listaExtensoes);
                    CarregarExtensoesNaGrid();					
				}
			}
		}

		protected void OnBtnIncluirClicked (object sender, EventArgs e)
		{
			OnIncluirExtensaoActionActivated (sender, e);
		}

		protected void OnBtnExcluirClicked (object sender, EventArgs e)
		{
			OnExcluirExtensaoActionActivated (sender, e);
		}
	}
}

