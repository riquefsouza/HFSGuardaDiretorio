using System;
using Gtk;
using System.IO;
using System.Drawing;
using System.Collections.Generic;
using HFSGuardaDiretorio.catalogador;
using HFSGuardaDiretorio.comum;
using HFSGuardaDiretorio.objetos;
using HFSGuardaDiretorio.objetosbo;
using HFSGuardaDiretorio.objetosgui;

namespace HFSGuardaDiretorio.gui
{
	public partial class FrmCompararDiretorio : Gtk.Window
	{
	    private FrmCompararDiretorioProgresso frmCompararDiretorioProgresso;
	    private readonly Catalogador catalogador;    
	    
	    public List<Diretorio> listaCompara;		
	
		public FrmCompararDiretorio (FrmPrincipal frmPrincipal) :
			base (Gtk.WindowType.Toplevel)
		{
			this.Build ();
			
			listaCompara = new List<Diretorio>();
	        frmCompararDiretorioProgresso = new FrmCompararDiretorioProgresso(this);
			catalogador = frmPrincipal.Catalogador;

			Arvore.Instancia.Construir (tvDiretorio1);
			Arvore.Instancia.Construir (tvDiretorio2);
			Tabela.Instancia.Construir (true, tabelaCompara);
			CarregarDados();
			LimparComparacao();
		}

		public ProgressBar PBar {
			get { return this.pb; }
		}

		public Label LabStatus1 {
			get {
				Frame frameStatus1 = (Frame)barraStatus1.Children [0];
				HBox hboxStatus1 = (HBox)frameStatus1.Child;
				return (Label)hboxStatus1.Children [0];
			}
		}

		public Label LabStatus2 {
			get {
				Frame frameStatus2 = (Frame)barraStatus2.Children [0];
				HBox hboxStatus2 = (HBox)frameStatus2.Child;
				return (Label)hboxStatus2.Children [0];
			}
		}
			
		protected void OnBtnCompararDiretoriosClicked (object sender, EventArgs e)
		{
			string sCaminhoDir1 = "", sCaminhoDir2 = "";
			bool bSelecionado;
			TreeIter iter1, iter2;
			TreeModel modelo1, modelo2;
			TreeStore store1, store2;

			bSelecionado = false;
			tvDiretorio1.Selection.GetSelected(out modelo1, out iter1);

			if (tvDiretorio1.Selection.IterIsSelected(iter1)) {
				store1 = (TreeStore)modelo1;

				catalogador.LerArvoreDiretorio(store1, iter1, LabStatus2);
				sCaminhoDir1 = LabStatus2.Text;

				tvDiretorio2.Selection.GetSelected(out modelo2, out iter2);

				if (tvDiretorio2.Selection.IterIsSelected(iter2)) {
					store2 = (TreeStore)modelo2;

					catalogador.LerArvoreDiretorio(store2, iter2, LabStatus2);
					sCaminhoDir2 = LabStatus2.Text;
					bSelecionado = true;
				}
			}

			LimparComparacao();

			if (bSelecionado) {
				Comparar(sCaminhoDir1, sCaminhoDir2);
			} else {
				Dialogo.mensagemInfo("Diretórios não selecionados!");
			}	
		}

		protected void OnBtnSalvarLogClicked (object sender, EventArgs e)
		{
			string sLog;
			StringList listaLocal;

			if (listaCompara.Count > 0) {
				listaLocal = new StringList();
				sLog = Rotinas.ExtractFilePath(Rotinas.ExecutablePath())+
						System.IO.Path.DirectorySeparatorChar +
						Rotinas.formataDate(Rotinas.FORMATO_DHARQUIVO, DateTime.Now) +
						"_Comparacao.log";

				foreach (Diretorio diretorio in listaCompara) {
					listaLocal.Add(diretorio.Caminho);
				}

				listaLocal.SaveToFile(sLog);

				Dialogo.mensagemInfo("Log salvo no mesmo diretório do sistema!");
			}
		}

		protected void OnCmbAba1Changed (object sender, EventArgs e)
		{
			Aba aba;
			
			GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Watch);

			TreeStore tvDiretorio1Store = (TreeStore) tvDiretorio1.Model;
			tvDiretorio1Store.Clear();
			aba = AbaBO.Instancia.pegaAbaPorOrdem(catalogador.listaAbas, 
				cmbAba1.Active + 1);
			catalogador.CarregarArvore(tvDiretorio1, aba);
			tvDiretorio1.GrabFocus ();
			LimparComparacao();
			
			GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Arrow);
		}

		protected void OnCmbAba2Changed (object sender, EventArgs e)
		{
			Aba aba;
			
			GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Watch);
			
			TreeStore tvDiretorio2Store = (TreeStore) tvDiretorio2.Model;
			tvDiretorio2Store.Clear();
			aba = AbaBO.Instancia.pegaAbaPorOrdem(catalogador.listaAbas, 
				cmbAba2.Active + 1);
			catalogador.CarregarArvore(tvDiretorio2, aba);
			tvDiretorio2.GrabFocus ();
			LimparComparacao();

			GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Arrow);
		}
		
		private void CarregarDados(){
			TreeIter iter;

			foreach (Aba aba in catalogador.listaAbas) {
				cmbAba1.AppendText(aba.Nome);
				cmbAba2.AppendText(aba.Nome);
			}

			cmbAba1.Model.GetIterFirst (out iter);
			cmbAba1.SetActiveIter (iter);

			cmbAba2.Model.GetIterFirst (out iter);
			cmbAba2.SetActiveIter (iter);
		}
		
		private void LimparComparacao() {
			pb.Fraction = 0;
			ListStore tabelaStore = (ListStore)tabelaCompara.Model;
			tabelaStore.Clear();
			btnSalvarLog.Sensitive = false;
			LabStatus2.Text = "";
		}

		private string SQLCompara(Aba aba1, Aba aba2, string caminho1,
				string caminho2) {
			string sSQL;

			sSQL = DiretorioBO.SQL_CONSULTA_ARQUIVO + " WHERE aba=" + aba1.Codigo
					+ " AND caminho LIKE " + Rotinas.QuotedStr(caminho1 + "%")
					+ " AND nome NOT IN (SELECT nome FROM Diretorios "
					+ " WHERE aba=" + aba2.Codigo + " AND caminho LIKE "
					+ Rotinas.QuotedStr(caminho2 + "%") + ")" + " ORDER BY 1, 2, 3";
			return sSQL;
		}

		private void Comparar(string sCaminhoDir1, string sCaminhoDir2) {
			string sSQL;
			Aba aba1, aba2;
			int tamLista;

			aba1 = AbaBO.Instancia.pegaAbaPorOrdem(catalogador.listaAbas,
				cmbAba1.Active + 1);
			aba2 = AbaBO.Instancia.pegaAbaPorOrdem(catalogador.listaAbas,
				cmbAba2.Active + 1);

			sSQL = SQLCompara(aba1, aba2, sCaminhoDir1, sCaminhoDir2);
			listaCompara = DiretorioBO.Instancia.carregarDiretorio(sSQL, 
					"consultaarquivo", frmCompararDiretorioProgresso);

			if (listaCompara.Count > 0) {
				Tabela.Instancia.Carregar(true, tabelaCompara, listaCompara, catalogador.listaExtensoes, pb);

				tamLista = listaCompara.Count;
				LabStatus2.Text = tamLista.ToString();
				btnSalvarLog.Sensitive = true;
			} else {
				Dialogo.mensagemInfo("Nenhuma diferença encontrada!");
			}
		}
		
	}
}

