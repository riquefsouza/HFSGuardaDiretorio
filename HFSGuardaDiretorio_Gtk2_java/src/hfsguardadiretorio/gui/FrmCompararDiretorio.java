package hfsguardadiretorio.gui;

import hfsguardadiretorio.comum.Rotinas;

import org.gnome.gdk.EventButton;
import org.gnome.gtk.Alignment;
import org.gnome.gtk.Button;
import org.gnome.gtk.CellRendererText;
import org.gnome.gtk.ComboBox;
import org.gnome.gtk.DataColumn;
import org.gnome.gtk.DataColumnString;
import org.gnome.gtk.Frame;
import org.gnome.gtk.HBox;
import org.gnome.gtk.Label;
import org.gnome.gtk.ListStore;
import org.gnome.gtk.PolicyType;
import org.gnome.gtk.ProgressBar;
import org.gnome.gtk.ScrolledWindow;
import org.gnome.gtk.ShadowType;
import org.gnome.gtk.Statusbar;
import org.gnome.gtk.TreeIter;
import org.gnome.gtk.TreePath;
import org.gnome.gtk.TreeView;
import org.gnome.gtk.TreeViewColumn;
import org.gnome.gtk.TreeViewColumnSizing;
import org.gnome.gtk.VBox;
import org.gnome.gtk.Widget;
import org.gnome.gtk.Window;
import org.gnome.gtk.WindowPosition;
import org.gnome.gtk.WindowType;

public class FrmCompararDiretorio extends Window
{
	private VBox vbox5;
	private HBox hbox1;
	private Button btnCompararDiretorios;
	private ProgressBar pb2;
	private Button btnSalvarLog;
	private HBox hbox2;
	private Frame frame2;
	private Alignment alignment1;
	private VBox vbox6;
	private ComboBox cmbAba1;
	private ScrolledWindow scrolledwindow3;
	private TreeView tvDiretorio1;
	private TreeViewColumn colunaArvoreDiretorio1;
	private Label labDiretorio1;
	private Frame frame3;
	private Alignment alignment2;
	private VBox vbox7;
	private ComboBox cmbAba2;
	private ScrolledWindow scrolledwindow4;
	private TreeView tvDiretorio2;
	private TreeViewColumn colunaArvoreDiretorio2;
	private Label label6;
	private HBox hbox4;
	private Label labDiferencasEncontradas;
	private ScrolledWindow scrollTabela12;
	private TreeView tabelaCompara;
	private TreeViewColumn colunaComparaNome;
	private TreeViewColumn colunaComparaTamanho;
	private TreeViewColumn colunaComparaTipo;
	private TreeViewColumn colunaComparaModificado;
	private TreeViewColumn colunaComparaAtributos;
	private TreeViewColumn colunaComparaCaminho;
	private HBox hbox5;
	private Statusbar barraStatus11;
	private Statusbar barraStatus21;


	public FrmCompararDiretorio()
	{
		super(WindowType.TOPLEVEL);
		this.barraStatus21 = new Statusbar();
		this.barraStatus21.setName("barraStatus21");
		this.barraStatus21.setCanFocus(false);
		this.barraStatus21.setSpacing(2);
	
		this.barraStatus11 = new Statusbar();
		this.barraStatus11.setName("barraStatus11");
		this.barraStatus11.setSizeRequest(300, -1);
		this.barraStatus11.setCanFocus(false);
		this.barraStatus11.setSpacing(2);
	
		this.hbox5 = new HBox(false, 0);
		this.hbox5.setName("hbox5");
		this.hbox5.setCanFocus(false);
		hbox5.packStart(barraStatus11, false, true, 0);
		hbox5.packStart(barraStatus21, true, true, 0);
	
	
	
	
	
	
	
		this.tabelaCompara = new TreeView();
		this.tabelaCompara.setName("tabelaCompara");
		this.tabelaCompara.setCanFocus(true);
		this.tabelaCompara.setModel(Rotinas.getInstancia().lsTabelaCompara());
		this.colunaComparaNome = this.tabelaCompara.appendColumn();
		this.colunaComparaNome.setResizable(true);
		this.colunaComparaNome.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaComparaNome.setTitle("Nome");
		this.colunaComparaNome.setSortColumn(Rotinas.getInstancia().lsTabelaComparaColuna0);
		CellRendererText crtcolunaComparaNome = new CellRendererText(colunaComparaNome);
		crtcolunaComparaNome.setMarkup(Rotinas.getInstancia().lsTabelaComparaColuna0);
		this.colunaComparaTamanho = this.tabelaCompara.appendColumn();
		this.colunaComparaTamanho.setResizable(true);
		this.colunaComparaTamanho.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaComparaTamanho.setTitle("Tamanho");
		this.colunaComparaTamanho.setSortColumn(Rotinas.getInstancia().lsTabelaComparaColuna1);
		CellRendererText crtcolunaComparaTamanho = new CellRendererText(colunaComparaTamanho);
		crtcolunaComparaTamanho.setMarkup(Rotinas.getInstancia().lsTabelaComparaColuna1);
		this.colunaComparaTipo = this.tabelaCompara.appendColumn();
		this.colunaComparaTipo.setResizable(true);
		this.colunaComparaTipo.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaComparaTipo.setTitle("Tipo");
		this.colunaComparaTipo.setSortColumn(Rotinas.getInstancia().lsTabelaComparaColuna2);
		CellRendererText crtcolunaComparaTipo = new CellRendererText(colunaComparaTipo);
		crtcolunaComparaTipo.setMarkup(Rotinas.getInstancia().lsTabelaComparaColuna2);
		this.colunaComparaModificado = this.tabelaCompara.appendColumn();
		this.colunaComparaModificado.setResizable(true);
		this.colunaComparaModificado.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaComparaModificado.setTitle("Modificado");
		this.colunaComparaModificado.setSortColumn(Rotinas.getInstancia().lsTabelaComparaColuna3);
		CellRendererText crtcolunaComparaModificado = new CellRendererText(colunaComparaModificado);
		crtcolunaComparaModificado.setMarkup(Rotinas.getInstancia().lsTabelaComparaColuna3);
		this.colunaComparaAtributos = this.tabelaCompara.appendColumn();
		this.colunaComparaAtributos.setResizable(true);
		this.colunaComparaAtributos.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaComparaAtributos.setTitle("Atributos");
		this.colunaComparaAtributos.setSortColumn(Rotinas.getInstancia().lsTabelaComparaColuna4);
		CellRendererText crtcolunaComparaAtributos = new CellRendererText(colunaComparaAtributos);
		crtcolunaComparaAtributos.setMarkup(Rotinas.getInstancia().lsTabelaComparaColuna4);
		this.colunaComparaCaminho = this.tabelaCompara.appendColumn();
		this.colunaComparaCaminho.setResizable(true);
		this.colunaComparaCaminho.setSizing(TreeViewColumnSizing.AUTOSIZE);
		this.colunaComparaCaminho.setTitle("Caminho");
		this.colunaComparaCaminho.setSortColumn(Rotinas.getInstancia().lsTabelaComparaColuna5);
		CellRendererText crtcolunaComparaCaminho = new CellRendererText(colunaComparaCaminho);
		crtcolunaComparaCaminho.setMarkup(Rotinas.getInstancia().lsTabelaComparaColuna5);
	
		this.scrollTabela12 = new ScrolledWindow();
		this.scrollTabela12.setName("scrollTabela12");
		this.scrollTabela12.setCanFocus(true);
		this.scrollTabela12.setPolicy(PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
		this.scrollTabela12.add(this.tabelaCompara);
	
		this.labDiferencasEncontradas = new Label();
		this.labDiferencasEncontradas.setName("labDiferencasEncontradas");
		this.labDiferencasEncontradas.setCanFocus(false);
		this.labDiferencasEncontradas.setLabel("Diferenças Encontradas");
	
		this.hbox4 = new HBox(false, 0);
		this.hbox4.setName("hbox4");
		this.hbox4.setCanFocus(false);
		hbox4.packStart(labDiferencasEncontradas, false, true, 0);
	
		this.label6 = new Label();
		this.label6.setName("label6");
		this.label6.setCanFocus(false);
		this.label6.setLabel("<b>Diretório 2</b>");
		this.label6.setUseMarkup(true);
	
	
		this.tvDiretorio2 = new TreeView();
		this.tvDiretorio2.setName("tvDiretorio2");
		this.tvDiretorio2.setCanFocus(true);
		this.tvDiretorio2.setModel(Rotinas.getInstancia().tsArvoreDiretorio2());
		this.tvDiretorio2.setHeadersVisible(false);
		this.colunaArvoreDiretorio2 = this.tvDiretorio2.appendColumn();
		this.colunaArvoreDiretorio2.setTitle("column");
		CellRendererText crtcolunaArvoreDiretorio2 = new CellRendererText(colunaArvoreDiretorio2);
		crtcolunaArvoreDiretorio2.setMarkup(Rotinas.getInstancia().tsArvoreDiretorio2Coluna0);
	
		this.scrolledwindow4 = new ScrolledWindow();
		this.scrolledwindow4.setName("scrolledwindow4");
		this.scrolledwindow4.setCanFocus(true);
		this.scrolledwindow4.setPolicy(PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
		this.scrolledwindow4.add(this.tvDiretorio2);
	
		this.cmbAba2 = new ComboBox(new ListStore(new DataColumn[] {new DataColumnString()}));
		this.cmbAba2.setName("cmbAba2");
		this.cmbAba2.setCanFocus(false);
	
		this.vbox7 = new VBox(false, 0);
		this.vbox7.setName("vbox7");
		this.vbox7.setCanFocus(false);
		vbox7.packStart(cmbAba2, false, true, 0);
		vbox7.packStart(scrolledwindow4, true, true, 0);
	
		this.alignment2 = new Alignment();
		this.alignment2.setName("alignment2");
		this.alignment2.setCanFocus(false);
		this.alignment2.setPadding(0, 0, 12, 0);
		this.alignment2.add(this.vbox7);
	
		this.frame3 = new Frame("");
		this.frame3.setName("frame3");
		this.frame3.setCanFocus(false);
		this.frame3.setLabelAlign(0, 0);
		this.frame3.setShadowType(ShadowType.NONE);
		this.frame3.add(this.alignment2);
		this.frame3.setLabelWidget(this.label6);
	
		this.labDiretorio1 = new Label();
		this.labDiretorio1.setName("labDiretorio1");
		this.labDiretorio1.setCanFocus(false);
		this.labDiretorio1.setLabel("<b>Diretório 1</b>");
		this.labDiretorio1.setUseMarkup(true);
	
	
		this.tvDiretorio1 = new TreeView();
		this.tvDiretorio1.setName("tvDiretorio1");
		this.tvDiretorio1.setCanFocus(true);
		this.tvDiretorio1.setModel(Rotinas.getInstancia().tsArvoreDiretorio1());
		this.tvDiretorio1.setHeadersVisible(false);
		this.colunaArvoreDiretorio1 = this.tvDiretorio1.appendColumn();
		this.colunaArvoreDiretorio1.setTitle("coluna");
		CellRendererText crtcolunaArvoreDiretorio1 = new CellRendererText(colunaArvoreDiretorio1);
		crtcolunaArvoreDiretorio1.setMarkup(Rotinas.getInstancia().tsArvoreDiretorio1Coluna0);
	
		this.scrolledwindow3 = new ScrolledWindow();
		this.scrolledwindow3.setName("scrolledwindow3");
		this.scrolledwindow3.setCanFocus(true);
		this.scrolledwindow3.setPolicy(PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
		this.scrolledwindow3.add(this.tvDiretorio1);
	
		this.cmbAba1 = new ComboBox(new ListStore(new DataColumn[] {new DataColumnString()}));
		this.cmbAba1.setName("cmbAba1");
		this.cmbAba1.setCanFocus(false);
	
		this.vbox6 = new VBox(false, 0);
		this.vbox6.setName("vbox6");
		this.vbox6.setCanFocus(false);
		vbox6.packStart(cmbAba1, false, true, 0);
		vbox6.packStart(scrolledwindow3, true, true, 0);
	
		this.alignment1 = new Alignment();
		this.alignment1.setName("alignment1");
		this.alignment1.setCanFocus(false);
		this.alignment1.setPadding(0, 0, 12, 0);
		this.alignment1.add(this.vbox6);
	
		this.frame2 = new Frame("");
		this.frame2.setName("frame2");
		this.frame2.setCanFocus(false);
		this.frame2.setLabelAlign(0, 0);
		this.frame2.setShadowType(ShadowType.NONE);
		this.frame2.add(this.alignment1);
		this.frame2.setLabelWidget(this.labDiretorio1);
	
		this.hbox2 = new HBox(false, 0);
		this.hbox2.setName("hbox2");
		this.hbox2.setCanFocus(false);
		hbox2.packStart(frame2, true, true, 0);
		hbox2.packStart(frame3, true, true, 0);
	
		this.btnSalvarLog = new Button();
		this.btnSalvarLog.setName("btnSalvarLog");
		this.btnSalvarLog.setLabel("Salvar Log");
		this.btnSalvarLog.setCanFocus(true);
	
		this.pb2 = new ProgressBar();
		this.pb2.setName("pb2");
		this.pb2.setCanFocus(false);
	
		this.btnCompararDiretorios = new Button();
		this.btnCompararDiretorios.setName("btnCompararDiretorios");
		this.btnCompararDiretorios.setLabel("Comparar Diretórios");
		this.btnCompararDiretorios.setCanFocus(true);
	
		this.hbox1 = new HBox(false, 0);
		this.hbox1.setName("hbox1");
		this.hbox1.setCanFocus(false);
		hbox1.packStart(btnCompararDiretorios, false, true, 0);
		hbox1.packStart(pb2, true, true, 0);
		hbox1.packStart(btnSalvarLog, false, true, 0);
	
		this.vbox5 = new VBox(false, 0);
		this.vbox5.setName("vbox5");
		this.vbox5.setCanFocus(false);
		vbox5.packStart(hbox1, false, false, 0);
		vbox5.packStart(hbox2, true, true, 0);
		vbox5.packStart(hbox4, false, true, 0);
		vbox5.packStart(scrollTabela12, true, true, 0);
		vbox5.packStart(hbox5, false, true, 0);
	
		this.setName("frmCompararDiretorio");
		this.setSizeRequest(700, 600);
		this.setCanFocus(false);
		this.setTitle("Comparar Diretórios");
		this.setResizable(false);
		this.setModal(true);
		this.setPosition(WindowPosition.CENTER);
		this.setDefaultSize(700, 600);
		this.add(vbox5);
		this.showAll();
	

		this.btnCompararDiretorios.connect(new Button.Clicked(){
			@Override
			public void onClicked(Button source){
				on_btnCompararDiretorios_clicked(source);
			}
		});
		this.btnSalvarLog.connect(new Button.Clicked(){
			@Override
			public void onClicked(Button source){
				btnSalvarLog_clicked_cb(source);
			}
		});
		this.cmbAba1.connect(new ComboBox.Changed(){
			@Override
			public void onChanged(ComboBox source){
				on_cmbAba1_changed(source);
			}
		});
		this.tvDiretorio1.connect(new TreeView.RowExpanded(){
			@Override
			public void onRowExpanded(TreeView source, TreeIter iter, TreePath path){
				on_tvDiretorio1_row_expanded(source, iter, path);
			}
		});
		this.tvDiretorio1.connect(new TreeView.ButtonReleaseEvent(){
			@Override
			public boolean onButtonReleaseEvent(Widget source, EventButton event){
				return on_tvDiretorio1_button_release_event(source, event);
			}
		});
		this.cmbAba2.connect(new ComboBox.Changed(){
			@Override
			public void onChanged(ComboBox source){
				on_cmbAba2_changed(source);
			}
		});
		this.tvDiretorio2.connect(new TreeView.RowExpanded(){
			@Override
			public void onRowExpanded(TreeView source, TreeIter iter, TreePath path){
				on_tvDiretorio2_row_expanded(source, iter, path);
			}
		});
		this.tvDiretorio2.connect(new TreeView.ButtonReleaseEvent(){
			@Override
			public boolean onButtonReleaseEvent(Widget source, EventButton event){
				return on_tvDiretorio2_button_release_event(source, event);
			}
		});
		this.tabelaCompara.connect(new TreeView.RowActivated(){
			@Override
			public void onRowActivated(TreeView source, TreePath path, TreeViewColumn vertical){
				on_tabelaCompara_row_activated(source, path, vertical);
			}
		});
		this.tabelaCompara.connect(new TreeView.ButtonReleaseEvent(){
			@Override
			public boolean onButtonReleaseEvent(Widget source, EventButton event){
				return on_tabelaCompara_button_release_event(source, event);
			}
		});

	}

	public static void mostrar() 
	{
		FrmCompararDiretorio frmCompararDiretorio = new FrmCompararDiretorio();
		frmCompararDiretorio.setPosition(WindowPosition.CENTER_ALWAYS);
		frmCompararDiretorio.show();
	}

	public void on_btnCompararDiretorios_clicked(Button source){

	}

	public void btnSalvarLog_clicked_cb(Button source){
		
	}

	public void on_cmbAba1_changed(ComboBox source){
		
	}

	public void on_tvDiretorio1_row_expanded(TreeView source, TreeIter iter, TreePath path){
		
	}

	public boolean on_tvDiretorio1_button_release_event(Widget source, EventButton event){
		return false;
	}

	public void on_cmbAba2_changed(ComboBox source){
		
	}

	public void on_tvDiretorio2_row_expanded(TreeView source, TreeIter iter, TreePath path){
		
	}

	public boolean on_tvDiretorio2_button_release_event(Widget source, EventButton event){
		return false;
	}

	public void on_tabelaCompara_row_activated(TreeView source, TreePath path, TreeViewColumn vertical){
		
	}

	public boolean on_tabelaCompara_button_release_event(Widget source, EventButton event){
		return false;
	}


}
