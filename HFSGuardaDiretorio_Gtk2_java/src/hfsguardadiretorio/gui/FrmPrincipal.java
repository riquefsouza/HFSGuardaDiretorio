package hfsguardadiretorio.gui;

import hfsguardadiretorio.comum.Rotinas;

import org.gnome.gdk.Event;
import org.gnome.gdk.EventButton;
import org.gnome.gtk.Button;
import org.gnome.gtk.CellRendererText;
import org.gnome.gtk.CheckMenuItem;
import org.gnome.gtk.Entry;
import org.gnome.gtk.EntryIconPosition;
import org.gnome.gtk.Gtk;
import org.gnome.gtk.HBox;
import org.gnome.gtk.HPaned;
import org.gnome.gtk.Label;
import org.gnome.gtk.Menu;
import org.gnome.gtk.MenuBar;
import org.gnome.gtk.MenuItem;
import org.gnome.gtk.Notebook;
import org.gnome.gtk.PolicyType;
import org.gnome.gtk.ProgressBar;
import org.gnome.gtk.ScrolledWindow;
import org.gnome.gtk.SeparatorMenuItem;
import org.gnome.gtk.ShadowType;
import org.gnome.gtk.Statusbar;
import org.gnome.gtk.ToolItem;
import org.gnome.gtk.Toolbar;
import org.gnome.gtk.TreeIter;
import org.gnome.gtk.TreePath;
import org.gnome.gtk.TreeView;
import org.gnome.gtk.TreeViewColumn;
import org.gnome.gtk.TreeViewColumnSizing;
import org.gnome.gtk.VBox;
import org.gnome.gtk.VPaned;
import org.gnome.gtk.Widget;
import org.gnome.gtk.Window;
import org.gnome.gtk.WindowPosition;
import org.gnome.gtk.WindowType;

public class FrmPrincipal extends Window
{
	private VBox vbox1;
	private MenuBar barraMenu1;
	private MenuItem menuAba;
	private Menu submenuAba;
	private MenuItem menuIncluirNovaAba;
	private MenuItem menuAlterarNomeAbaAtiva;
	private MenuItem menuExcluirAbaAtiva;
	private MenuItem menuDiretorio;
	private Menu submenuDiretorio;
	private MenuItem menuImportarDiretorio;
	private MenuItem menuImportarSubDiretorios;
	private MenuItem menuCompararDiretorios;
	private MenuItem menuCadastrarExtensaoArquivo;
	private SeparatorMenuItem menuseparador1;
	private MenuItem menuExpandirDiretorios;
	private MenuItem menuColapsarDiretorios;
	private MenuItem menuExportarDiretoriosAbaAtiva;
	private Menu menu2;
	private MenuItem menuTXT;
	private MenuItem menuCSV;
	private MenuItem menuHTML;
	private MenuItem menuXML;
	private MenuItem menuSQL;
	private MenuItem menuImportarDiretoriosViaXML;
	private CheckMenuItem menuGravarLogImportacao;
	private MenuItem menuVisao;
	private Menu submenuVisao;
	private MenuItem menuMostrarOcultarArvoreDirAbaAtiva;
	private MenuItem menuMostrarOcultarListaItensPesquisados;
	private MenuItem menuSobre;
	private Menu submenuSobre;
	private MenuItem menuSobreCatalogador;
	private Toolbar toolbar1;
	private ToolItem toolbutton1;
	private Button btnImportarDiretorio;
	private ToolItem toolbutton2;
	private ProgressBar pb;
	private ToolItem toolbutton3;
	private Entry edtPesquisa;
	private ToolItem toolbutton4;
	private Button btnPesquisa;
	private VPaned spPesquisa;
	private Notebook notebook1;
	private HPaned sp;
	private ScrolledWindow scrollArvore;
	private TreeView arvoreFixa;
	private TreeViewColumn colunaArvoreFixa;
	private ScrolledWindow scrollTabelaFixa;
	private TreeView tabelaFixa;
	private TreeViewColumn colunaTabelaFixaNome;
	private TreeViewColumn colunaTabelaFixaTamanho;
	private TreeViewColumn colunaTabelaFixaTipo;
	private TreeViewColumn colunaTabelaFixaModificado;
	private TreeViewColumn colunaTabelaFixaAtributos;
	private TreeViewColumn colunaTabelaFixaCaminho;
	private Label labAbaFixa;
	private Label label2;
	private Label label3;
	private ScrolledWindow scrollPesquisa;
	private TreeView tabelaPesquisa;
	private TreeViewColumn colunaTabelaPesquisaNome;
	private TreeViewColumn colunaTabelaPesquisaTamanho;
	private TreeViewColumn colunaTabelaPesquisaTipo;
	private TreeViewColumn colunaTabelaPesquisaModificado;
	private TreeViewColumn colunaTabelaPesquisaAtributos;
	private TreeViewColumn colunaTabelaPesquisaCaminho;
	private TreeViewColumn colunaTabelaPesquisaAba;
	private HBox hbox6;
	private Statusbar barraStatus111;
	private Statusbar barraStatus211;


	public FrmPrincipal()
	{
		super(WindowType.TOPLEVEL);
		this.barraStatus211 = new Statusbar();
		this.barraStatus211.setName("barraStatus211");
		this.barraStatus211.setCanFocus(false);
		this.barraStatus211.setSpacing(2);
	
		this.barraStatus111 = new Statusbar();
		this.barraStatus111.setName("barraStatus111");
		this.barraStatus111.setSizeRequest(300, -1);
		this.barraStatus111.setCanFocus(false);
		this.barraStatus111.setSpacing(2);
	
		this.hbox6 = new HBox(false, 0);
		this.hbox6.setName("hbox6");
		this.hbox6.setCanFocus(false);
		hbox6.packStart(barraStatus111, false, true, 0);
		hbox6.packStart(barraStatus211, true, true, 0);
	
	
	
	
	
	
	
	
		this.tabelaPesquisa = new TreeView();
		this.tabelaPesquisa.setName("tabelaPesquisa");
		this.tabelaPesquisa.setCanFocus(true);
		this.tabelaPesquisa.setModel(Rotinas.getInstancia().lsTabelaPesquisa());
		this.colunaTabelaPesquisaNome = this.tabelaPesquisa.appendColumn();
		this.colunaTabelaPesquisaNome.setResizable(true);
		this.colunaTabelaPesquisaNome.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaTabelaPesquisaNome.setTitle("Nome");
		this.colunaTabelaPesquisaNome.setSortColumn(Rotinas.getInstancia().lsTabelaPesquisaColuna0);
		CellRendererText crtcolunaTabelaPesquisaNome = new CellRendererText(colunaTabelaPesquisaNome);
		crtcolunaTabelaPesquisaNome.setMarkup(Rotinas.getInstancia().lsTabelaPesquisaColuna0);
		this.colunaTabelaPesquisaTamanho = this.tabelaPesquisa.appendColumn();
		this.colunaTabelaPesquisaTamanho.setResizable(true);
		this.colunaTabelaPesquisaTamanho.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaTabelaPesquisaTamanho.setTitle("Tamanho");
		this.colunaTabelaPesquisaTamanho.setSortColumn(Rotinas.getInstancia().lsTabelaPesquisaColuna1);
		CellRendererText crtcolunaTabelaPesquisaTamanho = new CellRendererText(colunaTabelaPesquisaTamanho);
		crtcolunaTabelaPesquisaTamanho.setMarkup(Rotinas.getInstancia().lsTabelaPesquisaColuna1);
		this.colunaTabelaPesquisaTipo = this.tabelaPesquisa.appendColumn();
		this.colunaTabelaPesquisaTipo.setResizable(true);
		this.colunaTabelaPesquisaTipo.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaTabelaPesquisaTipo.setTitle("Tipo");
		this.colunaTabelaPesquisaTipo.setSortColumn(Rotinas.getInstancia().lsTabelaPesquisaColuna2);
		CellRendererText crtcolunaTabelaPesquisaTipo = new CellRendererText(colunaTabelaPesquisaTipo);
		crtcolunaTabelaPesquisaTipo.setMarkup(Rotinas.getInstancia().lsTabelaPesquisaColuna2);
		this.colunaTabelaPesquisaModificado = this.tabelaPesquisa.appendColumn();
		this.colunaTabelaPesquisaModificado.setResizable(true);
		this.colunaTabelaPesquisaModificado.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaTabelaPesquisaModificado.setTitle("Modificado");
		this.colunaTabelaPesquisaModificado.setSortColumn(Rotinas.getInstancia().lsTabelaPesquisaColuna3);
		CellRendererText crtcolunaTabelaPesquisaModificado = new CellRendererText(colunaTabelaPesquisaModificado);
		crtcolunaTabelaPesquisaModificado.setMarkup(Rotinas.getInstancia().lsTabelaPesquisaColuna3);
		this.colunaTabelaPesquisaAtributos = this.tabelaPesquisa.appendColumn();
		this.colunaTabelaPesquisaAtributos.setResizable(true);
		this.colunaTabelaPesquisaAtributos.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaTabelaPesquisaAtributos.setTitle("Atributos");
		this.colunaTabelaPesquisaAtributos.setSortColumn(Rotinas.getInstancia().lsTabelaPesquisaColuna4);
		CellRendererText crtcolunaTabelaPesquisaAtributos = new CellRendererText(colunaTabelaPesquisaAtributos);
		crtcolunaTabelaPesquisaAtributos.setMarkup(Rotinas.getInstancia().lsTabelaPesquisaColuna4);
		this.colunaTabelaPesquisaCaminho = this.tabelaPesquisa.appendColumn();
		this.colunaTabelaPesquisaCaminho.setResizable(true);
		this.colunaTabelaPesquisaCaminho.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaTabelaPesquisaCaminho.setTitle("Caminho");
		this.colunaTabelaPesquisaCaminho.setSortColumn(Rotinas.getInstancia().lsTabelaPesquisaColuna5);
		CellRendererText crtcolunaTabelaPesquisaCaminho = new CellRendererText(colunaTabelaPesquisaCaminho);
		crtcolunaTabelaPesquisaCaminho.setMarkup(Rotinas.getInstancia().lsTabelaPesquisaColuna5);
		this.colunaTabelaPesquisaAba = this.tabelaPesquisa.appendColumn();
		this.colunaTabelaPesquisaAba.setResizable(true);
		this.colunaTabelaPesquisaAba.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaTabelaPesquisaAba.setTitle("Aba");
		this.colunaTabelaPesquisaAba.setSortColumn(Rotinas.getInstancia().lsTabelaPesquisaColuna6);
		CellRendererText crtcolunaTabelaPesquisaAba = new CellRendererText(colunaTabelaPesquisaAba);
		crtcolunaTabelaPesquisaAba.setMarkup(Rotinas.getInstancia().lsTabelaPesquisaColuna6);
	
		this.scrollPesquisa = new ScrolledWindow();
		this.scrollPesquisa.setName("scrollPesquisa");
		this.scrollPesquisa.setCanFocus(true);
		this.scrollPesquisa.setPolicy(PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
		this.scrollPesquisa.add(this.tabelaPesquisa);
	
		this.label3 = new Label();
		this.label3.setName("label3");
		this.label3.setCanFocus(false);
		this.label3.setLabel("page 3");
	
		this.label2 = new Label();
		this.label2.setName("label2");
		this.label2.setCanFocus(false);
		this.label2.setLabel("page 2");
	
		this.labAbaFixa = new Label();
		this.labAbaFixa.setName("labAbaFixa");
		this.labAbaFixa.setCanFocus(false);
		this.labAbaFixa.setLabel("DISCO1");
	
	
	
	
	
	
	
		this.tabelaFixa = new TreeView();
		this.tabelaFixa.setName("tabelaFixa");
		this.tabelaFixa.setCanFocus(true);
		this.tabelaFixa.setModel(Rotinas.getInstancia().lsTabelaFixa());
		this.colunaTabelaFixaNome = this.tabelaFixa.appendColumn();
		this.colunaTabelaFixaNome.setResizable(true);
		this.colunaTabelaFixaNome.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaTabelaFixaNome.setTitle("Nome");
		this.colunaTabelaFixaNome.setSortColumn(Rotinas.getInstancia().lsTabelaFixaColuna0);
		CellRendererText crtcolunaTabelaFixaNome = new CellRendererText(colunaTabelaFixaNome);
		crtcolunaTabelaFixaNome.setMarkup(Rotinas.getInstancia().lsTabelaFixaColuna0);
		this.colunaTabelaFixaTamanho = this.tabelaFixa.appendColumn();
		this.colunaTabelaFixaTamanho.setResizable(true);
		this.colunaTabelaFixaTamanho.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaTabelaFixaTamanho.setTitle("Tamanho");
		this.colunaTabelaFixaTamanho.setSortColumn(Rotinas.getInstancia().lsTabelaFixaColuna1);
		CellRendererText crtcolunaTabelaFixaTamanho = new CellRendererText(colunaTabelaFixaTamanho);
		crtcolunaTabelaFixaTamanho.setMarkup(Rotinas.getInstancia().lsTabelaFixaColuna1);
		this.colunaTabelaFixaTipo = this.tabelaFixa.appendColumn();
		this.colunaTabelaFixaTipo.setResizable(true);
		this.colunaTabelaFixaTipo.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaTabelaFixaTipo.setTitle("Tipo");
		this.colunaTabelaFixaTipo.setSortColumn(Rotinas.getInstancia().lsTabelaFixaColuna2);
		CellRendererText crtcolunaTabelaFixaTipo = new CellRendererText(colunaTabelaFixaTipo);
		crtcolunaTabelaFixaTipo.setMarkup(Rotinas.getInstancia().lsTabelaFixaColuna2);
		this.colunaTabelaFixaModificado = this.tabelaFixa.appendColumn();
		this.colunaTabelaFixaModificado.setResizable(true);
		this.colunaTabelaFixaModificado.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaTabelaFixaModificado.setTitle("Modificado");
		this.colunaTabelaFixaModificado.setSortColumn(Rotinas.getInstancia().lsTabelaFixaColuna3);
		CellRendererText crtcolunaTabelaFixaModificado = new CellRendererText(colunaTabelaFixaModificado);
		crtcolunaTabelaFixaModificado.setMarkup(Rotinas.getInstancia().lsTabelaFixaColuna3);
		this.colunaTabelaFixaAtributos = this.tabelaFixa.appendColumn();
		this.colunaTabelaFixaAtributos.setResizable(true);
		this.colunaTabelaFixaAtributos.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaTabelaFixaAtributos.setTitle("Atributos");
		this.colunaTabelaFixaAtributos.setSortColumn(Rotinas.getInstancia().lsTabelaFixaColuna4);
		CellRendererText crtcolunaTabelaFixaAtributos = new CellRendererText(colunaTabelaFixaAtributos);
		crtcolunaTabelaFixaAtributos.setMarkup(Rotinas.getInstancia().lsTabelaFixaColuna4);
		this.colunaTabelaFixaCaminho = this.tabelaFixa.appendColumn();
		this.colunaTabelaFixaCaminho.setResizable(true);
		this.colunaTabelaFixaCaminho.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaTabelaFixaCaminho.setTitle("Caminho");
		this.colunaTabelaFixaCaminho.setSortColumn(Rotinas.getInstancia().lsTabelaFixaColuna5);
		CellRendererText crtcolunaTabelaFixaCaminho = new CellRendererText(colunaTabelaFixaCaminho);
		crtcolunaTabelaFixaCaminho.setMarkup(Rotinas.getInstancia().lsTabelaFixaColuna5);
	
		this.scrollTabelaFixa = new ScrolledWindow();
		this.scrollTabelaFixa.setName("scrollTabelaFixa");
		this.scrollTabelaFixa.setCanFocus(true);
		this.scrollTabelaFixa.setPolicy(PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
		this.scrollTabelaFixa.setShadowType(ShadowType.ETCHED_OUT);
		this.scrollTabelaFixa.add(this.tabelaFixa);
	
	
		this.arvoreFixa = new TreeView();
		this.arvoreFixa.setName("arvoreFixa");
		this.arvoreFixa.setCanFocus(true);
		this.arvoreFixa.setModel(Rotinas.getInstancia().tsArvoreFixa());
		this.arvoreFixa.setHeadersVisible(false);
		this.colunaArvoreFixa = this.arvoreFixa.appendColumn();
		this.colunaArvoreFixa.setTitle("coluna");
		CellRendererText crtcolunaArvoreFixa = new CellRendererText(colunaArvoreFixa);
		crtcolunaArvoreFixa.setMarkup(Rotinas.getInstancia().tsArvoreFixaColuna0);
	
		this.scrollArvore = new ScrolledWindow();
		this.scrollArvore.setName("scrollArvore");
		this.scrollArvore.setCanFocus(true);
		this.scrollArvore.setPolicy(PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
		this.scrollArvore.setShadowType(ShadowType.IN);
		this.scrollArvore.add(this.arvoreFixa);
	
		this.sp = new HPaned();
		this.sp.setName("sp");
		this.sp.setCanFocus(true);
		this.sp.setPosition(250);
		this.sp.add(this.scrollArvore);
		this.sp.add(this.scrollTabelaFixa);
	
		this.notebook1 = new Notebook();
		this.notebook1.setName("notebook1");
		this.notebook1.setCanFocus(true);
		this.notebook1.add(this.sp);
		this.notebook1.add(this.labAbaFixa);
		this.notebook1.add(this.label2);
		this.notebook1.add(this.label3);
	
		this.spPesquisa = new VPaned();
		this.spPesquisa.setName("spPesquisa");
		this.spPesquisa.setCanFocus(true);
		this.spPesquisa.setPosition(250);
		this.spPesquisa.add(this.notebook1);
		this.spPesquisa.add(this.scrollPesquisa);
	
		this.btnPesquisa = new Button();
		this.btnPesquisa.setName("btnPesquisa");
		this.btnPesquisa.setLabel("Pesquisar");
		this.btnPesquisa.setCanFocus(false);
	
		this.toolbutton4 = new ToolItem();
		this.toolbutton4.setName("toolbutton4");
		this.toolbutton4.setCanFocus(false);
		this.toolbutton4.add(this.btnPesquisa);
	
		this.edtPesquisa = new Entry();
		this.edtPesquisa.setName("edtPesquisa");
		this.edtPesquisa.setSizeRequest(325, -1);
		this.edtPesquisa.setCanFocus(true);
		this.edtPesquisa.setMaxLength(10);
		this.edtPesquisa.setIconActivatable(EntryIconPosition.PRIMARY, false);
		this.edtPesquisa.setIconActivatable(EntryIconPosition.SECONDARY, false);
		this.edtPesquisa.setIconSensitive(EntryIconPosition.PRIMARY, true);
		this.edtPesquisa.setIconSensitive(EntryIconPosition.SECONDARY, true);
	
		this.toolbutton3 = new ToolItem();
		this.toolbutton3.setName("toolbutton3");
		this.toolbutton3.setCanFocus(false);
		this.toolbutton3.add(this.edtPesquisa);
	
		this.pb = new ProgressBar();
		this.pb.setName("pb");
		this.pb.setSizeRequest(385, -1);
		this.pb.setCanFocus(false);
	
		this.toolbutton2 = new ToolItem();
		this.toolbutton2.setName("toolbutton2");
		this.toolbutton2.setSizeRequest(222, -1);
		this.toolbutton2.setCanFocus(false);
		this.toolbutton2.add(this.pb);
	
		this.btnImportarDiretorio = new Button();
		this.btnImportarDiretorio.setName("btnImportarDiretorio");
		this.btnImportarDiretorio.setLabel("Importar Diretorio");
		this.btnImportarDiretorio.setCanFocus(false);
	
		this.toolbutton1 = new ToolItem();
		this.toolbutton1.setName("toolbutton1");
		this.toolbutton1.setCanFocus(false);
		this.toolbutton1.add(this.btnImportarDiretorio);
	
		this.toolbar1 = new Toolbar();
		this.toolbar1.setName("toolbar1");
		this.toolbar1.setCanFocus(false);
		this.toolbar1.add(this.toolbutton1);
		this.toolbar1.add(this.toolbutton2);
		this.toolbar1.add(this.toolbutton3);
		this.toolbar1.add(this.toolbutton4);
	
		this.menuSobreCatalogador = new MenuItem("Sobre o Catalogador");
		this.menuSobreCatalogador.setName("menuSobreCatalogador");
		this.menuSobreCatalogador.setCanFocus(false);
	
		this.submenuSobre = new Menu();
		this.submenuSobre.setName("submenuSobre");
		this.submenuSobre.setCanFocus(false);
		this.submenuSobre.append(this.menuSobreCatalogador);
	
		this.menuSobre = new MenuItem("Sobre");
		this.menuSobre.setName("menuSobre");
		this.menuSobre.setCanFocus(false);
		this.menuSobre.setSubmenu(submenuSobre);
	
		this.menuMostrarOcultarListaItensPesquisados = new MenuItem("Mostrar/Ocultar lista de itens pesquisados");
		this.menuMostrarOcultarListaItensPesquisados.setName("menuMostrarOcultarListaItensPesquisados");
		this.menuMostrarOcultarListaItensPesquisados.setCanFocus(false);
	
		this.menuMostrarOcultarArvoreDirAbaAtiva = new MenuItem("Mostrar/Ocultar árvore de diretórios da Aba Ativa");
		this.menuMostrarOcultarArvoreDirAbaAtiva.setName("menuMostrarOcultarArvoreDirAbaAtiva");
		this.menuMostrarOcultarArvoreDirAbaAtiva.setCanFocus(false);
	
		this.submenuVisao = new Menu();
		this.submenuVisao.setName("submenuVisao");
		this.submenuVisao.setCanFocus(false);
		this.submenuVisao.append(this.menuMostrarOcultarArvoreDirAbaAtiva);
		this.submenuVisao.append(this.menuMostrarOcultarListaItensPesquisados);
	
		this.menuVisao = new MenuItem("Visão");
		this.menuVisao.setName("menuVisao");
		this.menuVisao.setCanFocus(false);
		this.menuVisao.setSubmenu(submenuVisao);
	
		this.menuGravarLogImportacao = new CheckMenuItem("Gravar Log da Importação");
		this.menuGravarLogImportacao.setName("menuGravarLogImportacao");
		this.menuGravarLogImportacao.setCanFocus(false);
	
		this.menuImportarDiretoriosViaXML = new MenuItem("Importar Diretórios via XML");
		this.menuImportarDiretoriosViaXML.setName("menuImportarDiretoriosViaXML");
		this.menuImportarDiretoriosViaXML.setCanFocus(false);
	
		this.menuSQL = new MenuItem("SQL");
		this.menuSQL.setName("menuSQL");
		this.menuSQL.setCanFocus(false);
	
		this.menuXML = new MenuItem("XML");
		this.menuXML.setName("menuXML");
		this.menuXML.setCanFocus(false);
	
		this.menuHTML = new MenuItem("HTML");
		this.menuHTML.setName("menuHTML");
		this.menuHTML.setCanFocus(false);
	
		this.menuCSV = new MenuItem("CSV");
		this.menuCSV.setName("menuCSV");
		this.menuCSV.setCanFocus(false);
	
		this.menuTXT = new MenuItem("TXT");
		this.menuTXT.setName("menuTXT");
		this.menuTXT.setCanFocus(false);
	
		this.menu2 = new Menu();
		this.menu2.setName("menu2");
		this.menu2.setCanFocus(false);
		this.menu2.append(this.menuTXT);
		this.menu2.append(this.menuCSV);
		this.menu2.append(this.menuHTML);
		this.menu2.append(this.menuXML);
		this.menu2.append(this.menuSQL);
	
		this.menuExportarDiretoriosAbaAtiva = new MenuItem("Exportar Diretórios da Aba Ativa");
		this.menuExportarDiretoriosAbaAtiva.setName("menuExportarDiretoriosAbaAtiva");
		this.menuExportarDiretoriosAbaAtiva.setCanFocus(false);
		this.menuExportarDiretoriosAbaAtiva.setSubmenu(menu2);
	
		this.menuColapsarDiretorios = new MenuItem("Colapsar Diretórios");
		this.menuColapsarDiretorios.setName("menuColapsarDiretorios");
		this.menuColapsarDiretorios.setCanFocus(false);
	
		this.menuExpandirDiretorios = new MenuItem("Expandir Diretórios");
		this.menuExpandirDiretorios.setName("menuExpandirDiretorios");
		this.menuExpandirDiretorios.setCanFocus(false);
	
		this.menuseparador1 = new SeparatorMenuItem();
		this.menuseparador1.setName("menuseparador1");
		this.menuseparador1.setCanFocus(false);
	
		this.menuCadastrarExtensaoArquivo = new MenuItem("Cadastrar Extensão de Arquivo");
		this.menuCadastrarExtensaoArquivo.setName("menuCadastrarExtensaoArquivo");
		this.menuCadastrarExtensaoArquivo.setCanFocus(false);
	
		this.menuCompararDiretorios = new MenuItem("Comparar Diretórios");
		this.menuCompararDiretorios.setName("menuCompararDiretorios");
		this.menuCompararDiretorios.setCanFocus(false);
	
		this.menuImportarSubDiretorios = new MenuItem("Importar SubDiretórios");
		this.menuImportarSubDiretorios.setName("menuImportarSubDiretorios");
		this.menuImportarSubDiretorios.setCanFocus(false);
	
		this.menuImportarDiretorio = new MenuItem("Importar Diretório");
		this.menuImportarDiretorio.setName("menuImportarDiretorio");
		this.menuImportarDiretorio.setCanFocus(false);
	
		this.submenuDiretorio = new Menu();
		this.submenuDiretorio.setName("submenuDiretorio");
		this.submenuDiretorio.setCanFocus(false);
		this.submenuDiretorio.append(this.menuImportarDiretorio);
		this.submenuDiretorio.append(this.menuImportarSubDiretorios);
		this.submenuDiretorio.append(this.menuCompararDiretorios);
		this.submenuDiretorio.append(this.menuCadastrarExtensaoArquivo);
		this.submenuDiretorio.append(this.menuseparador1);
		this.submenuDiretorio.append(this.menuExpandirDiretorios);
		this.submenuDiretorio.append(this.menuColapsarDiretorios);
		this.submenuDiretorio.append(this.menuExportarDiretoriosAbaAtiva);
		this.submenuDiretorio.append(this.menuImportarDiretoriosViaXML);
		this.submenuDiretorio.append(this.menuGravarLogImportacao);
	
		this.menuDiretorio = new MenuItem("Diretório");
		this.menuDiretorio.setName("menuDiretorio");
		this.menuDiretorio.setCanFocus(false);
		this.menuDiretorio.setSubmenu(submenuDiretorio);
	
		this.menuExcluirAbaAtiva = new MenuItem("Excluir Aba Ativa");
		this.menuExcluirAbaAtiva.setName("menuExcluirAbaAtiva");
		this.menuExcluirAbaAtiva.setCanFocus(false);
	
		this.menuAlterarNomeAbaAtiva = new MenuItem("Alterar Nome da Aba Ativa");
		this.menuAlterarNomeAbaAtiva.setName("menuAlterarNomeAbaAtiva");
		this.menuAlterarNomeAbaAtiva.setCanFocus(false);
	
		this.menuIncluirNovaAba = new MenuItem("Incluir Nova Aba");
		this.menuIncluirNovaAba.setName("menuIncluirNovaAba");
		this.menuIncluirNovaAba.setCanFocus(false);
	
		this.submenuAba = new Menu();
		this.submenuAba.setName("submenuAba");
		this.submenuAba.setCanFocus(false);
		this.submenuAba.append(this.menuIncluirNovaAba);
		this.submenuAba.append(this.menuAlterarNomeAbaAtiva);
		this.submenuAba.append(this.menuExcluirAbaAtiva);
	
		this.menuAba = new MenuItem("Aba");
		this.menuAba.setName("menuAba");
		this.menuAba.setCanFocus(false);
		this.menuAba.setSubmenu(submenuAba);
	
		this.barraMenu1 = new MenuBar();
		this.barraMenu1.setName("barraMenu1");
		this.barraMenu1.setCanFocus(false);
		this.barraMenu1.append(this.menuAba);
		this.barraMenu1.append(this.menuDiretorio);
		this.barraMenu1.append(this.menuVisao);
		this.barraMenu1.append(this.menuSobre);
	
		this.vbox1 = new VBox(false, 0);
		this.vbox1.setName("vbox1");
		this.vbox1.setCanFocus(false);
		vbox1.packStart(barraMenu1, false, true, 0);
		vbox1.packStart(toolbar1, false, true, 0);
		vbox1.packStart(spPesquisa, true, true, 0);
		vbox1.packStart(hbox6, false, true, 0);
	
		this.setName("frmPrincipal");
		this.setSizeRequest(900, 500);
		this.setCanFocus(false);
		this.setTitle("HFSGuardaDiretorio 2.0 - Catalogador de Diretórios");
		this.setPosition(WindowPosition.CENTER_ALWAYS);
		this.setDefaultSize(950, 718);
		this.add(vbox1);
		this.showAll();
	

		this.menuIncluirNovaAba.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuIncluirNovaAba_activate(mi);
			}
		});
		this.menuAlterarNomeAbaAtiva.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuAlterarNomeAbaAtiva_activate(mi);
			}
		});
		this.menuExcluirAbaAtiva.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuExcluirAbaAtiva_activate(mi);
			}
		});
		this.menuImportarDiretorio.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuImportarDiretorio_activate(mi);
			}
		});
		this.menuImportarSubDiretorios.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuImportarSubDiretorios_activate(mi);
			}
		});
		this.menuCompararDiretorios.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuCompararDiretorios_activate(mi);
			}
		});
		this.menuCadastrarExtensaoArquivo.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuCadastrarExtensaoArquivo_activate(mi);
			}
		});
		this.menuExpandirDiretorios.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuExpandirDiretorios_activate(mi);
			}
		});
		this.menuColapsarDiretorios.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuColapsarDiretorios_activate(mi);
			}
		});
		this.menuExportarDiretoriosAbaAtiva.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuExportarDiretoriosAbaAtiva_activate(mi);
			}
		});
		this.menuTXT.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuTXT_activate(mi);
			}
		});
		this.menuCSV.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuCSV_activate(mi);
			}
		});
		this.menuHTML.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuHTML_activate(mi);
			}
		});
		this.menuXML.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuXML_activate(mi);
			}
		});
		this.menuSQL.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuSQL_activate(mi);
			}
		});
		this.menuImportarDiretoriosViaXML.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuImportarDiretoriosViaXML_activate(mi);
			}
		});
		this.menuMostrarOcultarArvoreDirAbaAtiva.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuMostrarOcultarArvoreDirAbaAtiva_activate(mi);
			}
		});
		this.menuMostrarOcultarListaItensPesquisados.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuMostrarOcultarListaItensPesquisados_activate(mi);
			}
		});
		this.menuSobreCatalogador.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuSobreCatalogador_activate(mi);
			}
		});
		this.btnImportarDiretorio.connect(new Button.Clicked(){
			@Override
			public void onClicked(Button source){
				on_btnImportarDiretorio_clicked(source);
			}
		});
		this.btnPesquisa.connect(new Button.Clicked(){
			@Override
			public void onClicked(Button source){
				on_btnPesquisa_clicked(source);
			}
		});
		this.notebook1.connect(new Notebook.SwitchPage(){
			@Override
			public void onSwitchPage(Notebook source, int pageNum){
				on_notebook1_switch_page(source, pageNum);
			}
		});
		this.arvoreFixa.connect(new TreeView.ButtonReleaseEvent(){
			@Override
			public boolean onButtonReleaseEvent(Widget source, EventButton event){
				return on_arvoreFixa_button_release_event(source, event);
			}
		});
		this.arvoreFixa.connect(new TreeView.RowExpanded(){
			@Override
			public void onRowExpanded(TreeView source, TreeIter iter, TreePath path){
				on_arvoreFixa_row_expanded(source, iter, path);
			}
		});
		this.tabelaFixa.connect(new TreeView.ButtonReleaseEvent(){
			@Override
			public boolean onButtonReleaseEvent(Widget source, EventButton event){
				return on_tabelaFixa_button_release_event(source, event);
			}
		});
		this.tabelaFixa.connect(new TreeView.RowActivated(){
			@Override
			public void onRowActivated(TreeView source, TreePath path, TreeViewColumn vertical){
				on_tabelaFixa_row_activated(source, path, vertical);
			}
		});
		this.tabelaPesquisa.connect(new TreeView.ButtonReleaseEvent(){
			@Override
			public boolean onButtonReleaseEvent(Widget source, EventButton event){
				return on_tabelaPesquisa_button_release_event(source, event);
			}
		});
		this.connect(new Window.DeleteEvent(){
			@Override
			public boolean onDeleteEvent(Widget source, Event event){
				return on_FrmPrincipal_delete_event(source, event);
			}
		});

	}

	public static void mostrar() 
	{
		FrmPrincipal frmPrincipal = new FrmPrincipal();
		frmPrincipal.setPosition(WindowPosition.CENTER_ALWAYS);
		frmPrincipal.show();
	}

	public void on_menuIncluirNovaAba_activate(MenuItem mi){

	}

	public void on_menuAlterarNomeAbaAtiva_activate(MenuItem mi){
		
	}

	public void on_menuExcluirAbaAtiva_activate(MenuItem mi){
		
	}

	public void on_menuImportarDiretorio_activate(MenuItem mi){
		
	}

	public void on_menuImportarSubDiretorios_activate(MenuItem mi){
		
	}

	public void on_menuCompararDiretorios_activate(MenuItem mi){
		FrmCompararDiretorio.mostrar();
	}

	public void on_menuCadastrarExtensaoArquivo_activate(MenuItem mi){
		FrmCadExtensao.mostrar(this);
	}

	public void on_menuExpandirDiretorios_activate(MenuItem mi){
		
	}

	public void on_menuColapsarDiretorios_activate(MenuItem mi){
		
	}

	public void on_menuExportarDiretoriosAbaAtiva_activate(MenuItem mi){
		
	}

	public void on_menuTXT_activate(MenuItem mi){
		
	}

	public void on_menuCSV_activate(MenuItem mi){
		
	}

	public void on_menuHTML_activate(MenuItem mi){
		
	}

	public void on_menuXML_activate(MenuItem mi){
		
	}

	public void on_menuSQL_activate(MenuItem mi){
		
	}

	public void on_menuImportarDiretoriosViaXML_activate(MenuItem mi){
		
	}

	public void on_menuMostrarOcultarArvoreDirAbaAtiva_activate(MenuItem mi){
		
	}

	public void on_menuMostrarOcultarListaItensPesquisados_activate(MenuItem mi){
		
	}

	public void on_menuSobreCatalogador_activate(MenuItem mi){
		FrmSobre.mostrar(this);
	}

	public void on_btnImportarDiretorio_clicked(Button source){
		FrmImportarDiretorio.mostrar();
	}

	public void on_btnPesquisa_clicked(Button source){
		FrmInfoDiretorio.mostrar(this);
	}

	public void on_notebook1_switch_page(Notebook source, int pageNum){
		
	}

	public boolean on_arvoreFixa_button_release_event(Widget source, EventButton event){
		return false;
	}

	public void on_arvoreFixa_row_expanded(TreeView source, TreeIter iter, TreePath path){
		
	}

	public boolean on_tabelaFixa_button_release_event(Widget source, EventButton event){
		return false;
	}

	public void on_tabelaFixa_row_activated(TreeView source, TreePath path, TreeViewColumn vertical){
		
	}

	public boolean on_tabelaPesquisa_button_release_event(Widget source, EventButton event){
		return false;
	}

	public boolean on_FrmPrincipal_delete_event(Widget source, Event event){
		Gtk.mainQuit();
		return false;
	}


}
