using System;
using Gtk;
using HFSGuardaDiretorio.objetos;
using HFSGuardaDiretorio.comum;

namespace HFSGuardaDiretorio.gui
{
	public partial class FrmInfoDiretorio : Gtk.Dialog
	{
		public FrmInfoDiretorio ()
		{
			this.Build ();
			ConstruirGrid();
		}

		protected void OnBtnOkClicked (object sender, EventArgs e)
		{
			this.Hide ();
		}

		private void ConstruirGrid() {
			ListStore lstore;
			CellRendererText rtexto = new CellRendererText ();
			rtexto.FontDesc = Pango.FontDescription.FromString("Bold");

			tabelaInfo.AppendColumn("Item", rtexto, "text", 0);
			tabelaInfo.AppendColumn("Descrição", new CellRendererText (), "text", 1);

			//tabelaInfo.Columns [0].MinWidth = 108;
			//tabelaInfo.Columns [1].MinWidth = 214;

			tabelaInfo.Columns[0].SortColumnId = 1;
			tabelaInfo.Columns[0].Resizable = true;
			tabelaInfo.Columns[0].Sizing = TreeViewColumnSizing.Autosize;

			tabelaInfo.Columns[1].SortColumnId = 1;
			tabelaInfo.Columns[1].Resizable = true;
			tabelaInfo.Columns[1].Sizing = TreeViewColumnSizing.Autosize;

			lstore = new ListStore (typeof(string), typeof(string));

			tabelaInfo.Model = lstore;
		}

		public void setDiretorio(Diretorio diretorio) {
	        if (diretorio!=null) {

				ListStore lstore = (ListStore)tabelaInfo.Model;

				lstore.AppendValues("Aba:", diretorio.Aba.Nome);
				lstore.AppendValues("Nome:", diretorio.Nome);
				lstore.AppendValues("Tamanho:", diretorio.TamanhoFormatado);
				lstore.AppendValues("Tipo:", diretorio.Tipo.Nome);
				lstore.AppendValues("Modificado:", diretorio.ModificadoFormatado);
				lstore.AppendValues("Atributos:", diretorio.Atributos);
				lstore.AppendValues("Caminho:", diretorio.Caminho);
			}
		}

	}
}

