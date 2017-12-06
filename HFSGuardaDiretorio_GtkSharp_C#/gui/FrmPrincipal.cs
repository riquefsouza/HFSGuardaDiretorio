using System;
using Gtk;
using HFSGuardaDiretorio.catalogador;
using HFSGuardaDiretorio.comum;
using HFSGuardaDiretorio.objetosgui;
using HFSGuardaDiretorio.objetosbo;

namespace HFSGuardaDiretorio.gui
{
	public partial class FrmPrincipal: Gtk.Window
	{
		private FrmPrincipalProgresso frmPrincipalProgresso;
    	private readonly Catalogador catalogador;
		private Menu popupMenu;
		private int nLargura, nAltura;

		public FrmPrincipal () : base (Gtk.WindowType.Toplevel)
		{
			Build ();
			ConstruirPopupMenu ();

			notebook1.RemovePage (0);
			adicionaTabPage(notebook1, sp, "DISCO1");

			spPesquisa.Position = 250;
			sp.Position = 250;

			barraStatus1.GetSizeRequest (out nLargura, out nAltura);
			barraStatus1.SetSizeRequest (300, nAltura);

			Arvore.Instancia.Construir (arvoreFixa);
			arvoreFixa.Selection.Changed += OnArvoreFixaSelectionChanged;

			Tabela.Instancia.Construir (true, tabelaFixa);
			Tabela.Instancia.Construir (false, tabelaPesquisa);

			frmPrincipalProgresso = new FrmPrincipalProgresso (this);
	        catalogador = new Catalogador(this);

			Arvore.Instancia.selecionarPrimeiroItem(arvoreFixa);
		}

		public Catalogador Catalogador {
			get { return catalogador; }
		}

		public VPaned SPPesquisa {
			get { return this.spPesquisa; }
		}

		public Notebook tabControl1 {
			get { return this.notebook1; }
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

		public ProgressBar PBar {
			get { return this.pb; }
		}

		public Entry EdtPesquisa {
			get { return this.edtPesquisa; }
		}

		public NodeView TabelaPesquisa {
			get { return this.tabelaPesquisa; }
		}

		public ToggleAction MenuGravarLogImportacao {
			get { return this.GravarLogDaImportacaoAction; }
		}

		public TreeView ArvoreFixa {
			get { return this.arvoreFixa; }
		}

		public void adicionaTabPage(Notebook noteBook, HPaned spPanel, string nomeAba) {
			HBox tabAba;
			Gtk.Image imgAba;
			Label labAba;

			noteBook.Add (spPanel);

			tabAba = new HBox ();
			imgAba = new Gtk.Image (ExtensaoBO.Instancia.CDOuroGIF);

			labAba = new Label();
			labAba.Name = "labAba" + nomeAba;
			labAba.LabelProp = nomeAba;

			tabAba.Add(imgAba);
			tabAba.Add(labAba);

			noteBook.SetTabLabel(spPanel, tabAba);
			tabAba.ShowAll ();
			noteBook.ShowAll();
		}

		private void ConstruirPopupMenu(){
			popupMenu = new Menu();

			MenuItem menuInformacoesDiretorioArquivo = new MenuItem ("Informações do Diretório / Arquivo");
			menuInformacoesDiretorioArquivo.Activated += new EventHandler (OnInformacoesDiretorioArquivoActivated);
			menuInformacoesDiretorioArquivo.Show();
			popupMenu.Append(menuInformacoesDiretorioArquivo);

			MenuItem menuExcluirDiretorioSelecionado = new MenuItem ("Excluir Diretório Selecionado");
			menuExcluirDiretorioSelecionado.Activated += new EventHandler (OnExcluirDiretorioSelecionadoActivated);
			menuExcluirDiretorioSelecionado.Show();
			popupMenu.Append(menuExcluirDiretorioSelecionado);

			MenuItem menuExpandirDiretorios2 = new MenuItem ("Expandir Diretórios");
			menuExpandirDiretorios2.Activated += new EventHandler (OnExpandirDiretorios2Activated);
			menuExpandirDiretorios2.Show();
			popupMenu.Append (menuExpandirDiretorios2);

			MenuItem menuColapsarDiretorios2 = new MenuItem ("Colapsar Diretórios");
			menuColapsarDiretorios2.Activated += new EventHandler (OnColapsarDiretorios2Activated);
			menuColapsarDiretorios2.Show();
			popupMenu.Append(menuColapsarDiretorios2);

			SeparatorMenuItem separador2 = new SeparatorMenuItem ();
			separador2.Show();
			popupMenu.Append (separador2);

			MenuItem menuIncluirNovaAba2 = new MenuItem ("Incluir nova aba");
			menuIncluirNovaAba2.Activated += new EventHandler(OnIncluirNovaAba2Activated);
			menuIncluirNovaAba2.Show();
			popupMenu.Append(menuIncluirNovaAba2);

			MenuItem menuAlterarNomeAbaAtiva2 = new MenuItem ("Alterar nome da aba ativa");
			menuAlterarNomeAbaAtiva2.Activated += new EventHandler (OnAlterarNomeAbaAtiva2Activated);
			menuAlterarNomeAbaAtiva2.Show();
			popupMenu.Append(menuAlterarNomeAbaAtiva2);

			MenuItem menuExcluirAbaAtiva2 = new MenuItem ("Excluir aba ativa");
			menuExcluirAbaAtiva2.Activated += new EventHandler (OnExcluirAbaAtiva2Activated);
			menuExcluirAbaAtiva2.Show();
			popupMenu.Append(menuExcluirAbaAtiva2);
		}

		protected void OnDeleteEvent (object sender, DeleteEventArgs a)
		{
			Rotinas.Desconectar();
			
			Application.Quit ();
			a.RetVal = true;
		}

		protected void OnSobreOCatalogadorActionActivated (object sender, EventArgs e)
		{
			FrmSobre frmSobre = new FrmSobre();
			frmSobre.Show();
		}

		protected void OnCadastrarExtensaoDeArquivoActionActivated (object sender, EventArgs e)
		{
			FrmCadExtensao frmCadExtensao = new FrmCadExtensao(this);
			frmCadExtensao.Show ();
		}

		protected void OnCompararDiretoriosActionActivated (object sender, EventArgs e)
		{
			FrmCompararDiretorio frmCompararDiretorio = new FrmCompararDiretorio (this);
			frmCompararDiretorio.Show ();
		}

		protected void OnMostrarOcultarListaItensPesquisadosActionActivated (object sender, EventArgs e)
		{
			spPesquisa.Child2.Visible = !spPesquisa.Child2.Visible;
		}

		protected void OnMostrarOcultarArvoreDirAbaAtivaActionActivated (object sender, EventArgs e)
		{
			catalogador.mostrarOcultarArvore();
		}

		protected void OnImportarDiretorioActionActivated (object sender, EventArgs e)
		{
			catalogador.ComecaImportacao(false, frmPrincipalProgresso);
		}
			
		protected void OnIncluirNovaAbaActionActivated (object sender, EventArgs e)
		{
			catalogador.IncluirNovaAba();
		}

		protected void OnImportarDiretoriosViaXMLActionActivated (object sender, EventArgs e)
		{
	        StringList log = new StringList();
            catalogador.ImportarArquivo(log, frmPrincipalProgresso);
		}

		protected void OnSQLActionActivated (object sender, EventArgs e)
		{
			catalogador.ExportarArquivo(TipoExportar.teSQL, frmPrincipalProgresso);
		}

		protected void OnXMLActionActivated (object sender, EventArgs e)
		{
			catalogador.ExportarArquivo(TipoExportar.teXML, frmPrincipalProgresso);
		}

		protected void OnHTMLActionActivated (object sender, EventArgs e)
		{
			catalogador.ExportarArquivo(TipoExportar.teHTML, frmPrincipalProgresso);
		}

		protected void OnCSVActionActivated (object sender, EventArgs e)
		{
			catalogador.ExportarArquivo(TipoExportar.teCSV, frmPrincipalProgresso);
		}

		protected void OnTXTAction1Activated (object sender, EventArgs e)
		{
			catalogador.ExportarArquivo(TipoExportar.teTXT, frmPrincipalProgresso);
		}

		protected void OnColapsarDiretoriosActionActivated (object sender, EventArgs e)
		{
			catalogador.getArvoreAtual().CollapseAll();
		}

		protected void OnExpandirDiretoriosActionActivated (object sender, EventArgs e)
		{
			catalogador.getArvoreAtual().ExpandAll();
		}
		
  		protected void OnImportarSubDiretoriosActionActivated (object sender, EventArgs e)
		{
			catalogador.ComecaImportacao(true, frmPrincipalProgresso);
		}

		protected void OnExcluirAbaAtivaActionActivated (object sender, EventArgs e)
		{
			catalogador.ExcluirAbaAtiva(frmPrincipalProgresso);
		}

		protected void OnAlterarNomeDaAbaAtivaActionActivated (object sender, EventArgs e)
		{
			catalogador.AlterarNomeAbaAtiva(frmPrincipalProgresso);
		}

		private void OnInformacoesDiretorioArquivoActivated(object sender, EventArgs e)
		{
			catalogador.InformacoesDiretorioArquivo();
		}

		private void OnExcluirDiretorioSelecionadoActivated(object sender, EventArgs e)
		{
			catalogador.ExcluirDiretorioSelecionado(frmPrincipalProgresso);
		}

		private void OnExpandirDiretorios2Activated(object sender, EventArgs e)
		{
			OnExpandirDiretoriosActionActivated(sender, e);
		}

		private void OnColapsarDiretorios2Activated(object sender, EventArgs e)
		{
			OnColapsarDiretoriosActionActivated(sender, e);
		}

		private void OnIncluirNovaAba2Activated(object sender, EventArgs e)
		{
			OnIncluirNovaAbaActionActivated(sender, e);
		}

		private void OnAlterarNomeAbaAtiva2Activated(object sender, EventArgs e)
		{
			OnAlterarNomeDaAbaAtivaActionActivated(sender, e);
		}

		private void OnExcluirAbaAtiva2Activated(object sender, EventArgs e)
		{
			OnExcluirAbaAtivaActionActivated(sender, e);
		}

		protected void OnBtnImportarDiretorioClicked (object sender, EventArgs e)
		{
			OnImportarDiretorioActionActivated(sender, e);
		}

		protected void OnBtnPesquisaClicked (object sender, EventArgs e)
		{
			catalogador.Pesquisar();
		}

		protected void OnNotebook1SelectPage (object o, SelectPageArgs args)
		{
			catalogador.tabPanelMudou();
		}

		public void OnTabelaFixaButtonReleaseEvent (object o, ButtonReleaseEventArgs args)
		{
			if (args.Event.Button == 3) {
				popupMenu.Popup (null, null, null, args.Event.Button, Global.CurrentEventTime);
			}

			//if (args.Event.Button == 1) {
				//if (((Gdk.EventButton)args.Event).Type == Gdk.EventType.TwoButtonPress) {
			//}

		}

		public void OnArvoreFixaButtonReleaseEvent (object o, ButtonReleaseEventArgs args)
		{
			if (args.Event.Button == 3) {
				popupMenu.Popup (null, null, null, args.Event.Button, Global.CurrentEventTime);
			}
		}

		protected void OnTabelaPesquisaButtonReleaseEvent (object o, ButtonReleaseEventArgs args)
		{
			if (args.Event.Button == 1) {
				NodeView lvPesquisa = (NodeView) o;
				TreeIter iter;

				lvPesquisa.Selection.GetSelected (out iter);

				if (lvPesquisa.Selection.IterIsSelected (iter)) {
					ListStore storePesquisa = (ListStore)lvPesquisa.Model;

					string nome = storePesquisa.GetValue(iter, 1).ToString();
					string caminho = storePesquisa.GetValue(iter, 6).ToString();
					string nomeAba = storePesquisa.GetValue(iter, 7).ToString();

					catalogador.EncontrarItemLista (nomeAba, nome, caminho);
				}				
			}
		}

		public void OnTabelaFixaRowActivated (object o, RowActivatedArgs args)
		{
			NodeView lvTabela = (NodeView)o;
			TreeModel modelo;
			TreeIter iter;

			lvTabela.Selection.GetSelected (out modelo, out iter);

			if (lvTabela.Selection.IterIsSelected (iter)) {
				//ListStore modelo = (ListStore)lvTabela.Model;

				string nome = modelo.GetValue (iter, 1).ToString ();
				string tipo = modelo.GetValue (iter, 3).ToString ();

				catalogador.DuploCliqueLista (nome, tipo);
			}
		}

		public void OnArvoreFixaSelectionChanged (object o, EventArgs args)
		{
			TreeIter iter;
			TreeSelection selecao = (TreeSelection)o;

			if (selecao.GetSelected(out iter))
			{
				NodeView lvTabela = catalogador.getTabelaAtual();
				TreeView arvore = catalogador.getArvoreAtual();
				catalogador.ListarArquivos(lvTabela, arvore, iter);
			}
		}

		public void OnArvoreFixaRowExpanded (object o, RowExpandedArgs args)
		{
			TreeView arvore = (TreeView)o;
			TreeStore store = (TreeStore)arvore.Model;
			store.SetValue (args.Iter, 0, ExtensaoBO.Instancia.DirAbertoGIF);
		}

		public void OnArvoreFixaRowCollapsed (object o, RowCollapsedArgs args)
		{
			TreeView arvore = (TreeView)o;
			TreeStore store = (TreeStore)arvore.Model;
			store.SetValue (args.Iter, 0, ExtensaoBO.Instancia.DiretorioGIF);
		}
						
	}
}
