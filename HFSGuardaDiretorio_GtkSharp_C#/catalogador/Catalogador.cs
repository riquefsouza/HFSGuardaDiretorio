/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 07/07/2015
 * Time: 11:02
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using System.IO;
using System.Drawing;
using System.Collections.Generic;
using Gtk;
using HFSGuardaDiretorio.comum;
using HFSGuardaDiretorio.objetos;
using HFSGuardaDiretorio.objetosbo;
using HFSGuardaDiretorio.objetosdao;
using HFSGuardaDiretorio.gui;
using HFSGuardaDiretorio.objetosgui;

namespace HFSGuardaDiretorio.catalogador
{
	/// <summary>
	/// Description of Catalogador.
	/// </summary>
	public class Catalogador : ICatalogador
	{	
		private static readonly string CONSULTA_DIR_PAI
				= "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, "
				+ "atributos, caminho, nomeaba, nomepai, caminhopai "
				+ "from consultadirpai "
				+ "order by 1,2,3,4";
		private static readonly string CONSULTA_DIR_FILHO
				= "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, "
				+ "atributos, caminho, nomeaba, nomepai, caminhopai "
				+ "from consultadirfilho "
				+ "order by 1,2,3,4";
		public static readonly string CONSULTA_ARQUIVO
				= "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, "
				+ "atributos, caminho, nomeaba, nomepai, caminhopai "
				+ "from consultaarquivo "
				+ "order by tipo desc, ordem";
	

		private static readonly ArquivoLog log = new ArquivoLog();//Logger.getLogger(Rotinas.HFSGUARDADIR);

		private List<Diretorio> listaDiretorioFilho;
		private List<Diretorio> listaArquivos;

		public DiretorioOrdem diretorioOrdem;

		public List<Aba> listaAbas;
		public List<Diretorio> listaDiretorioPai;
		public List<Extensao> listaExtensoes;

		private readonly FrmPrincipal form;

		public Catalogador(FrmPrincipal form) {
			this.form = form;

			diretorioOrdem = new DiretorioOrdem();
			
			listaAbas = new List<Aba>();
			listaExtensoes = new List<Extensao>();
			listaDiretorioPai = new List<Diretorio>();
			listaDiretorioFilho = new List<Diretorio>();
			listaArquivos = new List<Diretorio>();
			
			form.SPPesquisa.Child2.Visible = false;

			form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Watch);
			FrmSplash frmSplash = new FrmSplash();       
			FrmSplashProgresso frmSplashProgresso = new FrmSplashProgresso(frmSplash);

			frmSplash.Show();

			CarregarDados(frmSplashProgresso, true, true);
			CarregarAbas();
			tabPanelMudou();
			
			frmSplash.Hide();
			frmSplash.Destroy();

			form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Arrow);
		}
		
		public static void iniciarSistema() {
			Aba aba;
			string sBanco = Rotinas.ExtractFilePath(Rotinas.ExecutablePath()) +
				Path.DirectorySeparatorChar + "GuardaDir.db";
			ConexaoParams cp = new ConexaoParams();
			cp.Nome = sBanco; 
			
			if (!Rotinas.FileExists(sBanco)){
				Rotinas.Conectar(cp);
				
				AbaBO.Instancia.criarTabelaAbas();

				aba = new Aba(1,"DISCO1",0);
				AbaBO.Instancia.incluirAba(aba);

				ExtensaoBO.Instancia.criarTabelaExtensoes();
				DiretorioBO.Instancia.criarTabelaDiretorios();
				VisaoDAO.Instancia.criarVisao("consultadirpai");
				VisaoDAO.Instancia.criarVisao("consultadirfilho");
				VisaoDAO.Instancia.criarVisao("consultaarquivo");
			} else 
				Rotinas.Conectar(cp);

		}

		public void CarregarDados(IProgressoLog pLog, bool bExtensao,
				bool bDiretorio) {
			listaAbas = AbaBO.Instancia.carregarAba(pLog);
			if (bExtensao) {
				listaExtensoes = ExtensaoBO.Instancia.carregarExtensao(pLog);
			}
			if (bDiretorio) {
				listaDiretorioPai = DiretorioBO.Instancia.carregarDiretorio(
						CONSULTA_DIR_PAI, "consultadirpai", pLog);
				listaDiretorioFilho = DiretorioBO.Instancia.carregarDiretorio(
						CONSULTA_DIR_FILHO, "consultadirfilho", pLog);
				listaArquivos = DiretorioBO.Instancia.carregarDiretorio(
						CONSULTA_ARQUIVO, "consultaarquivo", pLog);
			}
		}

		public void ExcluirDados(Aba aba, string sCaminho) {
			DiretorioBO.Instancia.excluirListaDiretorio(listaDiretorioPai, aba, sCaminho);
			DiretorioBO.Instancia.excluirListaDiretorio(listaDiretorioFilho, aba, sCaminho);
			DiretorioBO.Instancia.excluirListaDiretorio(listaArquivos, aba, sCaminho);
		}

		private void AddItemArvore(TreeStore storeArvore, Diretorio diretorio, 
			int Nivel, TreeIter node1) {
			List<Diretorio> listaFilhos;
			TreeIter node2;

			if (Nivel == 0) {
				node1 = storeArvore.AppendValues(ExtensaoBO.Instancia.DiretorioGIF, 
					diretorio.Nome);
			}

			listaFilhos = DiretorioBO.Instancia.itensFilhos(listaDiretorioFilho,
					diretorio.Aba.Codigo, diretorio.Ordem,
					diretorio.Codigo);

			foreach (Diretorio filho in listaFilhos) {
				node2 = storeArvore.AppendValues(node1, 
					ExtensaoBO.Instancia.DiretorioGIF, filho.Nome);
				AddItemArvore(storeArvore, filho, ++Nivel, node2);
			}
		}

		public void IncluirNovaAba() {
			Aba aba;
			string sAba = Dialogo.entrada("Digite o Nome da Nova Aba?");
			if ((sAba != null) && (sAba.Trim().Length > 0)) {
				aba = new Aba();
				aba.Codigo = AbaBO.Instancia.retMaxCodAba(listaAbas);
				aba.Nome = Rotinas.SubString(sAba, 1, 10);
				aba.Ordem = listaAbas.Count + 1;
				AbaBO.Instancia.incluirAba(aba);
				IncluirNovaAba(aba.Nome);
				listaAbas.Add(aba);
			}
		}
		
		public void AlterarNomeAbaAtiva(IProgressoLog pLog) {
			Aba aba = getAbaAtual();
			string sAba = Dialogo.entrada("Digite o Novo Nome da Aba Ativa?", 
					aba.Nome);
			if ((sAba != null) && (sAba.Trim().Length > 0)) {
				aba.Nome = Rotinas.SubString(sAba, 1, 10);
				AbaBO.Instancia.alterarAba(aba);
				form.tabControl1.SetTabLabelText (form.tabControl1.GetNthPage (form.tabControl1.Page), sAba);
				CarregarDados(pLog, false, true);
			}        
		}
		
		public void ExcluirAbaAtiva(IProgressoLog pLog) {
			Aba aba;
			int indiceSel = form.tabControl1.Page;
			if (indiceSel > 0) {
				bool res = Dialogo.confirma("Tem Certeza, que você deseja excluir esta aba, \n" +
				                            "isto implicará na destruição de todos os seus itens catalogados?");
				if (res) {
					form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Watch);
					
					aba = getAbaAtual();
					ExcluirDados(aba, "");
					AbaBO.Instancia.excluirAba(aba);                
					form.tabControl1.RemovePage(indiceSel);
					
					CarregarDados(pLog, false, false);

					form.LabStatus2.Text = "";
					
					form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Arrow);
				}
			} else
					Dialogo.mensagemErro("A primeira Aba não pode ser excluída!");        
		}
		
		private void IncluirNovaAba(string nomeAba) {
			HPaned spPanel;
			ScrolledWindow scrollArvore;
			TreeView arvore;
			ScrolledWindow scrollTabela;
			NodeView tabela;

			spPanel = new HPaned ();
			spPanel.CanFocus = true;
			spPanel.Name = "spPanel" + nomeAba;
			spPanel.Position = 250;

			scrollArvore = new ScrolledWindow ();
			scrollArvore.Name = "scrollArvore" + nomeAba;
			scrollArvore.ShadowType = ((ShadowType)(1));

			arvore = new TreeView ();
			arvore.CanFocus = true;
			arvore.Name = "arvore" + nomeAba;
			arvore.Selection.Changed += form.OnArvoreFixaSelectionChanged;
			arvore.RowExpanded += new RowExpandedHandler (form.OnArvoreFixaRowExpanded);
			arvore.RowCollapsed += new RowCollapsedHandler (form.OnArvoreFixaRowCollapsed);
			arvore.ButtonReleaseEvent += new ButtonReleaseEventHandler (form.OnArvoreFixaButtonReleaseEvent);
			Arvore.Instancia.Construir (arvore);

			scrollArvore.Add (arvore);
			spPanel.Add (scrollArvore);
			Paned.PanedChild w9 = ((Paned.PanedChild)(spPanel [scrollArvore]));
			w9.Resize = false;

			scrollTabela = new ScrolledWindow ();
			scrollTabela.Name = "scrollTabela" + nomeAba;
			scrollTabela.ShadowType = ((ShadowType)(1));

			tabela = new NodeView ();
			tabela.CanFocus = true;
			tabela.Name = "tabela" + nomeAba;
			tabela.ButtonReleaseEvent += new ButtonReleaseEventHandler (form.OnTabelaFixaButtonReleaseEvent);
			tabela.RowActivated += new RowActivatedHandler (form.OnTabelaFixaRowActivated);
			Tabela.Instancia.Construir (true, tabela);

			scrollTabela.Add (tabela);
			spPanel.Add (scrollTabela);

			form.adicionaTabPage (form.tabControl1, spPanel, nomeAba);
		}
			
		public TreeView getArvoreAtual() {
			return getArvoreAtual(form.tabControl1.Page);
		}

		public TreeView getArvoreAtual(int nIndicePagina) {
			HPaned tabPage = (HPaned)form.tabControl1.GetNthPage(nIndicePagina);
			ScrolledWindow scrollArvore = (ScrolledWindow)tabPage.Child1;
			TreeView arvore = (TreeView)scrollArvore.Child;
			return arvore;
		}

		public HPaned getSplitAtual() {
			int nIndicePagina = form.tabControl1.Page;
			HPaned tabPage = (HPaned)form.tabControl1.GetNthPage(nIndicePagina);
			return tabPage;
		}

		public NodeView getTabelaAtual() {
			int nIndicePagina = form.tabControl1.Page;
			HPaned tabPage = (HPaned)form.tabControl1.GetNthPage(nIndicePagina);
			ScrolledWindow scrollTabela = (ScrolledWindow)tabPage.Child2;
			NodeView tabela = (NodeView)scrollTabela.Child;
			return tabela;
		}
	
		public void mostrarOcultarArvore(){
			getSplitAtual ().Child1.Visible = !getSplitAtual ().Child1.Visible;
		}
		
		public void CarregarArvore(TreeView tvAba, Aba aba) {
			TreeIter nodeRaiz = new TreeIter();
			TreeStore storeArvore = (TreeStore)tvAba.Model;

			storeArvore.Clear ();

			foreach (Diretorio diretorio in listaDiretorioPai) {
				if (diretorio.Aba.Codigo == aba.Codigo) {
					AddItemArvore(storeArvore, diretorio, 0, nodeRaiz);
				}
			}

		}

		public void CarregarAbas() {
			TreeView tvAba;

			int nMaximum = listaAbas.Count - 1;
			form.PBar.Fraction = 0;

			for (int i = 0; i < listaAbas.Count; i++) {
				if (i > 0){
					IncluirNovaAba(listaAbas[i].Nome);
				}
				tvAba = getArvoreAtual(i);
				CarregarArvore(tvAba, listaAbas[i]);
				form.PBar.Fraction = Rotinas.calculaProgresso(nMaximum, i);
			}
		}

		private Aba getAbaAtual() {
			return AbaBO.Instancia.pegaAbaPorOrdem(
				listaAbas, form.tabControl1.Page + 1);
		}

		public void CarregarArquivosLista(bool bLista1, NodeView lvArquivos, string sCaminho) {
			string sPaiCaminho;
			List<Diretorio> listaLocal;			
			int nAba;

			listaLocal = new List<Diretorio>();
			ListStore storeArquivos = (ListStore)lvArquivos.Model;
			storeArquivos.Clear ();

			if (bLista1) {
				sPaiCaminho = sCaminho;
				if (!Rotinas.SubString(sCaminho, sCaminho.Length, 1).Equals(Rotinas.BARRA_INVERTIDA)) {
					sCaminho = sCaminho + Rotinas.BARRA_INVERTIDA;
				}
				nAba = getAbaAtual().Codigo;
				foreach (Diretorio diretorio in listaArquivos) {
					if (diretorio.Aba.Codigo == nAba) {
						if (diretorio.CaminhoPai.Equals(sPaiCaminho)) {
							if (Rotinas.StartsStr(sCaminho, diretorio.Caminho)) {
								listaLocal.Add(diretorio);
							}
						}
					}
				}
			} else {
				foreach (Diretorio diretorio in listaArquivos) {
					if (Rotinas.ContainsStr(diretorio.Caminho.ToUpper(), 
							sCaminho.ToUpper())) {
						listaLocal.Add(diretorio);
					}
				}
			}
			Tabela.Instancia.Carregar(bLista1, lvArquivos, listaLocal, listaExtensoes, form.PBar);
			
		}

		public void TamTotalDiretorio(string sCaminho) {
			long conta;
			int nAba;
			decimal soma, tam;

			conta = 0;
			soma = 0;

			foreach (Diretorio diretorio in listaArquivos) {
				nAba = getAbaAtual().Codigo;
				if (diretorio.Aba.Codigo == nAba) {
					if (diretorio.Tipo.Codigo != 'D') {
						if (sCaminho.Trim().Length > 0) {
							if (Rotinas.StartsStr(sCaminho, diretorio.Caminho)) {
								conta++;
								tam = diretorio.Tamanho;
								soma = soma + tam;
							}
						} else {
							conta++;
							tam = diretorio.Tamanho;
							soma = soma + tam;
						}
					}
				}
			}

			
			form.LabStatus1.Text =
					"Quantidade Total: " + Rotinas.FormatLong("0000", conta)
					+ ", Tamanho Total: " + DiretorioBO.Instancia.MontaTamanho(soma);
		}

		private bool testaSeparadorArquivo(string sDir) {
			sDir = Rotinas.SubString(sDir, sDir.Length, 1);
			if (sDir.Equals(Rotinas.BARRA_INVERTIDA) 
					|| sDir.Equals(Rotinas.BARRA_NORMAL)
					|| sDir.Equals(Rotinas.BARRA_INVERTIDA)) {
				return true;
			} else {
				return false;
			}
		}

		private StringList montaCaminho(string sCaminho, bool bRemover) {
			//sCaminho = NO_RAIZ + Rotinas.BARRA_INVERTIDA + sCaminho;
			StringList sl = new StringList(sCaminho, Rotinas.BARRA_INVERTIDA[0]);
			if (sl[sl.Count - 1].Trim().Length == 0) {
				sl.RemoveAt(sl.Count - 1);
			}
			if (bRemover) {
				sl.RemoveAt(sl.Count - 1);
			}
			return sl;
		}

		public void Pesquisar() {
			TreeView arvoreLocal = getArvoreAtual();
			TreeStore arvoreStore = (TreeStore) arvoreLocal.Model;
			ListStore tabelaStore = (ListStore)form.TabelaPesquisa.Model;
			TreeIter iter = new TreeIter();

			if (arvoreStore.IterNChildren() > 0) {
				if (form.EdtPesquisa.Text.Length >= 2) {
					form.SPPesquisa.Child2.Visible = true;
					CarregarArquivosLista(false, form.TabelaPesquisa, 
							form.EdtPesquisa.Text);
					if (tabelaStore.GetIterFirst (out iter)) {
						form.TabelaPesquisa.Selection.SelectIter (iter);
					}
				} else {
					form.SPPesquisa.Child2.Visible = false;
					tabelaStore.Clear();
					Dialogo.mensagemInfo("A pesquisa só é feita com pelo menos 2 caracteres!");
				}
			}
		}

		public void PesquisarArvoreDiretorio(string sCaminho, Aba aba) {
			form.tabControl1.Page = aba.Ordem-1;
			TreeView arvore = getArvoreAtual();
			TreeStore arvoreStore = (TreeStore) arvore.Model;

			StringList sl = montaCaminho(sCaminho, false); // Verifica Diretorio
			TreePath path = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray());

	        if (path == null) {
				sl.Insert(1, sl[1] + Rotinas.BARRA_INVERTIDA);
	            path = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray());
	
	            if (path == null) {
	                sl.Clear();
	                sl = montaCaminho(sCaminho, true); // Verifica Arquivo
	                path = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray());
	
	                if (path == null) {
	                    sl.Insert(1, sl[1] + Rotinas.BARRA_INVERTIDA);
	                    path = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray());
	                }
	            }
	        }

			arvore.ExpandToPath(path);
			arvore.Selection.SelectPath(path);
		}

		public void LerArvoreDiretorio(TreeStore arvoreStore, TreeIter iter,
			Label barraStatus) {

			TreeIter iterAnterior;
			string sSep, sCaminho, sValorAnterior;

			sCaminho = (string)arvoreStore.GetValue(iter, 1);
			arvoreStore.IterParent (out iterAnterior, iter);

			if (arvoreStore.IterIsValid(iterAnterior)) {
				do {
					sValorAnterior = (string)arvoreStore.GetValue (iterAnterior, 1);

					if (Rotinas.SubString (sValorAnterior, 
						    sValorAnterior.Length, 1) == Rotinas.BARRA_INVERTIDA)
						sSep = "";
					else
						sSep = Rotinas.BARRA_INVERTIDA;
					
					sCaminho = sValorAnterior + sSep + sCaminho;

				} while (arvoreStore.IterParent (out iterAnterior, iterAnterior));
			}

			form.LabStatus2.Text = sCaminho;
		}

		public void ListarArquivos(NodeView lvTabela, TreeView arvore, TreeIter iter) {
			TreeStore arvoreStore = (TreeStore) arvore.Model;

			if (arvore.Selection.IterIsSelected(iter)) {
				LerArvoreDiretorio(arvoreStore, iter, form.LabStatus2);
				CarregarArquivosLista(true, lvTabela, form.LabStatus2.Text);
				TamTotalDiretorio(form.LabStatus2.Text);
			}
		}
		
		public void tabPanelMudou(){
			TreeView arvore = getArvoreAtual();
			TreeStore arvoreStore = (TreeStore) arvore.Model;
			NodeView lvTabela = getTabelaAtual();
			TreeIter iter;

			if (arvoreStore.IterNChildren() > 0) {
				if (arvoreStore.GetIterFirst(out iter)) {
					ListarArquivos (lvTabela, arvore, iter);
				}
			}
		}
	
		public Aba getAbaSelecionada() {
			return getAbaAtual();
		}
				
		public void DuploCliqueLista(string nome, string tipo) {
			if (tipo.Equals("Diretório")) {
				form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Watch);
				string sCaminho = form.LabStatus2.Text;
				if (testaSeparadorArquivo(sCaminho)) {
					sCaminho += nome;
				} else {
					sCaminho += Rotinas.BARRA_INVERTIDA + nome;
				}
				
				PesquisarArvoreDiretorio(sCaminho, getAbaAtual());
				
				form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Arrow);
			}
		}

		
		public void EncontrarItemLista(string nomeAba, string nome, string caminho) {
			form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Watch);
			Aba aba = AbaBO.Instancia.pegaAbaPorNome(listaAbas, nomeAba);        
			PesquisarArvoreDiretorio(caminho, aba);
			
			NodeView tabela = getTabelaAtual();
			TreePath path = Tabela.Instancia.encontrarCaminhoPorNome (tabela, nome);
			if (path != null) {
				tabela.Selection.SelectPath(path);
			}

			form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Arrow);
		}
	   
		public int verificaNomeDiretorio(string sCaminho, RotuloRaiz sRotuloRaiz) {
			sRotuloRaiz.Rotulo = 
					DiretorioBO.Instancia.removerDrive(sCaminho);
			if (sRotuloRaiz.Rotulo.Length == 0) {

				sRotuloRaiz.Rotulo = Dialogo.entrada("Este diretório não possui um nome.\nDigite o nome do diretório!");

				if ((sRotuloRaiz.Rotulo != null)
						&& (sRotuloRaiz.Rotulo.Trim().Length > 0)) {
					sRotuloRaiz.Rotulo = sRotuloRaiz.Rotulo.Trim();

					if (sRotuloRaiz.Rotulo.Length > 0) {
						return 1;
					} else {
						Dialogo.mensagemInfo("Nenhum nome de diretório informado!");
						return 0;
					}
				} else {
					return 0;
				}
			} else if (Rotinas.Pos(Rotinas.BARRA_INVERTIDA,
					sRotuloRaiz.Rotulo) > 0) {
				sRotuloRaiz.Rotulo = Rotinas.SubString(sRotuloRaiz.Rotulo,
						Rotinas.LastDelimiter(Rotinas.BARRA_INVERTIDA,
								sRotuloRaiz.Rotulo) + 1,
						sRotuloRaiz.Rotulo.Length);
				return 2;
			} else {
				return 3;
			}
		}
		
		public void ExportarArquivo(TipoExportar tipo, IProgressoLog pLog) {
			string sExtensao = "";

			switch (tipo) {
				case TipoExportar.teTXT:
					sExtensao = "txt";
					break;
				case TipoExportar.teCSV:
					sExtensao = "csv";
					break;
				case TipoExportar.teHTML:
					sExtensao = "html";
					break;
				case TipoExportar.teXML:
					sExtensao = "xml";
					break;
				case TipoExportar.teSQL:
					sExtensao = "sql";
					break;
			}

			Aba aba = getAbaAtual();
			string sDiretorio = Rotinas.ExtractFilePath (Rotinas.ExecutablePath ());
			string sArquivo =  aba.Nome+'.'+sExtensao;
			if (EscolhaArquivo.salvarArquivo(EscolhaArquivo.FILTRO_EXPORTAR, sDiretorio, sArquivo)) {
				FileInfo arquivo = new FileInfo(EscolhaArquivo.NomeArquivo);
				if (!arquivo.Exists) {
					form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Watch);
					DiretorioBO.Instancia.exportarDiretorio(tipo, getAbaAtual(),
							arquivo.FullName, pLog);
					form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Arrow);

					Dialogo.mensagemErro("Exportação realizada com sucesso!");
				}
			}
		}

		public void ExcluirDiretorioSelecionado(IProgressoLog pLog) 
		{
			TreeView arvore = getArvoreAtual();
			TreeStore arvoreStore = (TreeStore) arvore.Model;
			TreeIter iter;
			arvore.Selection.GetSelected (out iter);

			if (arvore.Selection.IterIsSelected(iter)) {
				NodeView tabela = getTabelaAtual();
				ListStore tabelaStore = (ListStore)tabela.Model;
				bool res = Dialogo.confirma("Tem Certeza, que você deseja excluir este diretório, isto implicará na destruição de todos os seus items catalogados?");
				if (res) {
					form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Watch);

					string valor = (string)arvoreStore.GetValue (iter, 1);

					DiretorioBO.Instancia.excluirDiretorio(getAbaAtual(), valor);
					ExcluirDados(getAbaAtual(), valor);

					arvoreStore.Remove (ref iter);
					tabelaStore.Clear ();

					CarregarDados(pLog, false, false);

					form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Arrow);
				}
			}
		}
		
		public void ImportarArquivo(StringList log, IProgressoLog pLog) {
			int nResultado;

			if (EscolhaArquivo.abrirArquivo(EscolhaArquivo.FILTRO_XML)) {
				FileInfo arquivo = new FileInfo(EscolhaArquivo.NomeArquivo);
				if (arquivo.Exists) {
					form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Watch);
					nResultado = DiretorioBO.Instancia.importarDiretorioViaXML(
					getAbaAtual(), arquivo.FullName, listaDiretorioPai, pLog);
					if (nResultado == -1) {
						Dialogo.mensagemErro("Importação não realizada!");
					} else if (nResultado == -2) {
						Dialogo.mensagemErro("Este diretório já existe no catálogo!");
					} else {                    
						FinalizaImportacao(pLog);                    
					}
					form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Arrow);
				}
			}
		}
		
		public bool ImportarDiretorios(StringList listaCaminho,
				bool bSubDiretorio, FrmImportarDiretorio frmImportarDiretorio) {
			int nAba, nRotuloRaiz, nCodDirRaiz;
			RotuloRaiz sRotuloRaiz = new RotuloRaiz();
			string sCaminhoSemDrive;
			Importar importar = new Importar();

			nAba = getAbaAtual().Codigo;
			nCodDirRaiz = DiretorioBO.Instancia.retMaxCodDir(nAba, 
					listaDiretorioPai);

			foreach (string sCaminho in listaCaminho) {
				nRotuloRaiz = verificaNomeDiretorio(sCaminho, sRotuloRaiz);
				if (nRotuloRaiz > 0) {
					importar = new Importar();
					importar.Aba = nAba;
					importar.CodDirRaiz = nCodDirRaiz;
					importar.RotuloRaiz = sRotuloRaiz.Rotulo;
					if (nRotuloRaiz == 1) {
						importar.NomeDirRaiz = sRotuloRaiz.Rotulo;
					} else if (nRotuloRaiz == 2) {
						sCaminhoSemDrive = DiretorioBO.Instancia.removerDrive(sCaminho);
						importar.NomeDirRaiz = Rotinas.SubString(
								sCaminhoSemDrive, 1,
								Rotinas.LastDelimiter(Rotinas.BARRA_INVERTIDA,
										sCaminhoSemDrive) - 1);
					} else if (nRotuloRaiz == 3) {
						importar.NomeDirRaiz = "";
					}
					importar.Caminho = sCaminho;

					frmImportarDiretorio.listaImportar.Add(importar);
					nCodDirRaiz++;
				}
			}

			frmImportarDiretorio.bSubDiretorio = bSubDiretorio;

			if (bSubDiretorio) {
				frmImportarDiretorio.Show();
				frmImportarDiretorio.Importar();
				frmImportarDiretorio.Hide();
				frmImportarDiretorio.Destroy();
				return true;
			} else {
				if (!DiretorioBO.Instancia.verificaCodDir(
						importar.Aba, importar.RotuloRaiz,
						listaDiretorioPai)) {
					frmImportarDiretorio.Show();
					frmImportarDiretorio.Importar();
					frmImportarDiretorio.Hide();
					frmImportarDiretorio.Destroy();
					return true;
				} else {
					Dialogo.mensagemErro("Este diretório já existe no catálogo!");

					return false;
				}
			}

		}
		
		public void FinalizaImportacao(IProgressoLog pLog) {
			TreeView tvAba;

			form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Watch);

			CarregarDados(pLog, true, true);
			tvAba = getArvoreAtual();
			CarregarArvore(tvAba, getAbaAtual());
			tabPanelMudou();
			
			form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Arrow);
			Dialogo.mensagemInfo("Importação do(s) diretório(s) realizada com sucesso!");

		}
		
	 
		public void ComecaImportacao(bool bSubDiretorios, IProgressoLog pLog) {
			string sCaminho;
			StringList listaCaminho;
			FrmImportarDiretorio frmImportarDiretorio;

			if (EscolhaArquivo.abrirDiretorio()) {
				FileInfo arquivo = new FileInfo(EscolhaArquivo.NomeArquivo);
				if (arquivo.Directory.Exists) {
					form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Watch);
					sCaminho = arquivo.FullName;

					frmImportarDiretorio = new FrmImportarDiretorio(form);
					listaCaminho = new StringList();

					if (bSubDiretorios) {
						DiretorioBO.Instancia.
								carregarSubDiretorios(sCaminho, listaCaminho);
					} else {
						listaCaminho.Add(sCaminho);
					}

					if (ImportarDiretorios(listaCaminho, bSubDiretorios, 
							frmImportarDiretorio)) {
						FinalizaImportacao(pLog);
					}

					form.GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Arrow);
				}
			}

		}
		
		public void InformacoesDiretorioArquivo()
		{
	        FrmInfoDiretorio frmInfo;
	        NodeView tabela = getTabelaAtual();
			TreeIter iter;

			tabela.Selection.GetSelected (out iter);

			if (tabela.Selection.IterIsSelected (iter)) {
	            frmInfo = new FrmInfoDiretorio();
	            Aba aba = getAbaSelecionada();
	            Diretorio dir = Tabela.Instancia.getLinhaSelecionada(tabela, false);
	            dir.Aba.Nome = aba.Nome;
	            frmInfo.setDiretorio(dir);
	            frmInfo.Show();
	        }				
		}


	}
}
