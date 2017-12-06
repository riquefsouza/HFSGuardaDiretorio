package hfsguardadiretorio.gui;

import hfsguardadiretorio.comum.Rotinas;

import org.gnome.gdk.WindowTypeHint;
import org.gnome.gtk.Button;
import org.gnome.gtk.ButtonBoxStyle;
import org.gnome.gtk.CellRendererText;
import org.gnome.gtk.Dialog;
import org.gnome.gtk.HButtonBox;
import org.gnome.gtk.Menu;
import org.gnome.gtk.MenuBar;
import org.gnome.gtk.MenuItem;
import org.gnome.gtk.PolicyType;
import org.gnome.gtk.ScrolledWindow;
import org.gnome.gtk.TreeView;
import org.gnome.gtk.TreeViewColumn;
import org.gnome.gtk.VBox;
import org.gnome.gtk.Window;
import org.gnome.gtk.WindowPosition;

public class FrmCadExtensao extends Dialog
{
	private VBox form_vbox;
	private VBox vbox;
	private MenuBar barraMenu;
	private MenuItem menuExtensao;
	private Menu submenuExtensao;
	private MenuItem menuIncluirExtensao;
	private MenuItem menuExcluirExtensao;
	private MenuItem menuExcluirTodasExtensoes;
	private MenuItem menuExportarTodos;
	private Menu submenuExportarTodos;
	private MenuItem menuExportarBitmap;
	private MenuItem menuExportarIcone;
	private MenuItem menuExportarGIF;
	private MenuItem menuExportarJPEG;
	private MenuItem menuExportarPNG;
	private MenuItem menuExportarTIFF;
	private MenuItem menuImportarTodos;
	private Menu submenuImportarTodos;
	private MenuItem menuImportarIconesArquivos;
	private MenuItem menuExtrairIconesArquivos;
	private ScrolledWindow scrollTabela;
	private TreeView tabelaExtensao;
	private TreeViewColumn colunaCadExtExtensao;
	private TreeViewColumn colunaCadExtIcone;
	private HButtonBox form_area;
	private Button btnIncluir;
	private Button btnExcluir;


	public FrmCadExtensao(Window parent)
	{
		super("", parent, true);

		this.btnExcluir = new Button();
		this.btnExcluir.setName("btnExcluir");
		this.btnExcluir.setLabel("gtk-remove");
		this.btnExcluir.setCanFocus(true);
	
		this.btnIncluir = new Button();
		this.btnIncluir.setName("btnIncluir");
		this.btnIncluir.setLabel("gtk-add");
		this.btnIncluir.setCanFocus(true);
	
		this.form_area = new HButtonBox();
		this.form_area.setName("form_area");
		this.form_area.setCanFocus(false);
		this.form_area.setLayout(ButtonBoxStyle.CENTER);
		form_area.packStart(btnIncluir, false, false, 0);
		form_area.packStart(btnExcluir, false, false, 0);
	
	
	
		this.tabelaExtensao = new TreeView();
		this.tabelaExtensao.setName("tabelaExtensao");
		this.tabelaExtensao.setCanFocus(true);		
		this.tabelaExtensao.setModel(Rotinas.getInstancia().lsTabelaExtensao());
		this.colunaCadExtExtensao = this.tabelaExtensao.appendColumn();
		this.colunaCadExtExtensao.setMinWidth(150);
		this.colunaCadExtExtensao.setTitle("Extensão");
		CellRendererText crtcolunaCadExtExtensao = new CellRendererText(colunaCadExtExtensao);
		crtcolunaCadExtExtensao.setMarkup(Rotinas.getInstancia().lsTabelaExtensaoColuna0);
		this.colunaCadExtIcone = this.tabelaExtensao.appendColumn();
		this.colunaCadExtIcone.setMinWidth(100);
		this.colunaCadExtIcone.setTitle("Ícone");
		CellRendererText crtcolunaCadExtIcone = new CellRendererText(colunaCadExtIcone);
		crtcolunaCadExtIcone.setMarkup(Rotinas.getInstancia().lsTabelaExtensaoColuna1);
	
		this.scrollTabela = new ScrolledWindow();
		this.scrollTabela.setName("scrollTabela");
		this.scrollTabela.setCanFocus(true);
		this.scrollTabela.setPolicy(PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
		this.scrollTabela.add(this.tabelaExtensao);
	
		this.menuExtrairIconesArquivos = new MenuItem("Extrair Ícones dos Arquivos");
		this.menuExtrairIconesArquivos.setName("menuExtrairIconesArquivos");
		this.menuExtrairIconesArquivos.setCanFocus(false);
	
		this.menuImportarIconesArquivos = new MenuItem("Importar Ícones dos Arquivos");
		this.menuImportarIconesArquivos.setName("menuImportarIconesArquivos");
		this.menuImportarIconesArquivos.setCanFocus(false);
	
		this.submenuImportarTodos = new Menu();
		this.submenuImportarTodos.setName("submenuImportarTodos");
		this.submenuImportarTodos.setCanFocus(false);
		this.submenuImportarTodos.append(this.menuImportarIconesArquivos);
		this.submenuImportarTodos.append(this.menuExtrairIconesArquivos);
	
		this.menuImportarTodos = new MenuItem("Importar Todos");
		this.menuImportarTodos.setName("menuImportarTodos");
		this.menuImportarTodos.setCanFocus(false);
		this.menuImportarTodos.setSubmenu(submenuImportarTodos);
	
		this.menuExportarTIFF = new MenuItem("Exportar para TIFF");
		this.menuExportarTIFF.setName("menuExportarTIFF");
		this.menuExportarTIFF.setCanFocus(false);
	
		this.menuExportarPNG = new MenuItem("Exportar para PNG");
		this.menuExportarPNG.setName("menuExportarPNG");
		this.menuExportarPNG.setCanFocus(false);
	
		this.menuExportarJPEG = new MenuItem("Exportar para JPEG");
		this.menuExportarJPEG.setName("menuExportarJPEG");
		this.menuExportarJPEG.setCanFocus(false);
	
		this.menuExportarGIF = new MenuItem("Exportar para GIF");
		this.menuExportarGIF.setName("menuExportarGIF");
		this.menuExportarGIF.setCanFocus(false);
	
		this.menuExportarIcone = new MenuItem("Exportar para Ícone");
		this.menuExportarIcone.setName("menuExportarIcone");
		this.menuExportarIcone.setCanFocus(false);
	
		this.menuExportarBitmap = new MenuItem("Exportar para Bitmap");
		this.menuExportarBitmap.setName("menuExportarBitmap");
		this.menuExportarBitmap.setCanFocus(false);
	
		this.submenuExportarTodos = new Menu();
		this.submenuExportarTodos.setName("submenuExportarTodos");
		this.submenuExportarTodos.setCanFocus(false);
		this.submenuExportarTodos.append(this.menuExportarBitmap);
		this.submenuExportarTodos.append(this.menuExportarIcone);
		this.submenuExportarTodos.append(this.menuExportarGIF);
		this.submenuExportarTodos.append(this.menuExportarJPEG);
		this.submenuExportarTodos.append(this.menuExportarPNG);
		this.submenuExportarTodos.append(this.menuExportarTIFF);
	
		this.menuExportarTodos = new MenuItem("Exportar Todos");
		this.menuExportarTodos.setName("menuExportarTodos");
		this.menuExportarTodos.setCanFocus(false);
		this.menuExportarTodos.setSubmenu(submenuExportarTodos);
	
		this.menuExcluirTodasExtensoes = new MenuItem("Excluir Todas Extensões");
		this.menuExcluirTodasExtensoes.setName("menuExcluirTodasExtensoes");
		this.menuExcluirTodasExtensoes.setCanFocus(false);
	
		this.menuExcluirExtensao = new MenuItem("Excluir Extensão");
		this.menuExcluirExtensao.setName("menuExcluirExtensao");
		this.menuExcluirExtensao.setCanFocus(false);
	
		this.menuIncluirExtensao = new MenuItem("Incluir Extensão");
		this.menuIncluirExtensao.setName("menuIncluirExtensao");
		this.menuIncluirExtensao.setCanFocus(false);
	
		this.submenuExtensao = new Menu();
		this.submenuExtensao.setName("submenuExtensao");
		this.submenuExtensao.setCanFocus(false);
		this.submenuExtensao.append(this.menuIncluirExtensao);
		this.submenuExtensao.append(this.menuExcluirExtensao);
		this.submenuExtensao.append(this.menuExcluirTodasExtensoes);
	
		this.menuExtensao = new MenuItem("_Extensão");
		this.menuExtensao.setName("menuExtensao");
		this.menuExtensao.setCanFocus(false);
		this.menuExtensao.setSubmenu(submenuExtensao);
	
		this.barraMenu = new MenuBar();
		this.barraMenu.setName("barraMenu");
		this.barraMenu.setCanFocus(false);
		this.barraMenu.append(this.menuExtensao);
		this.barraMenu.append(this.menuExportarTodos);
		this.barraMenu.append(this.menuImportarTodos);
	
		this.vbox = new VBox(false, 0);
		this.vbox.setName("vbox");
		this.vbox.setCanFocus(false);
		this.vbox.packStart(barraMenu, false, true, 0);
		this.vbox.packStart(scrollTabela, true, true, 0);
	/*
		this.form_vbox = new VBox(false, 0);
		this.form_vbox.setName("form_vbox");
		this.form_vbox.setCanFocus(false);
		this.form_vbox.setSpacing(2);
		this.form_vbox.packStart(vbox, true, true, 0);		
		this.form_vbox.packStart(form_area, false, true, 0);		
*/	
		this.vbox.packStart(form_area, false, true, 0);
		
		this.setName("frmCadExtensao");
		this.setSizeRequest(286, 418);
		this.setCanFocus(false);
		this.setBorderWidth(5);
		this.setTitle("Cadastro de Extensão de Arquivo");
		this.setResizable(false);
		this.setModal(true);
		this.setPosition(WindowPosition.CENTER);
		this.setTypeHint(WindowTypeHint.DIALOG);
		//this.add(form_vbox);
		this.add(vbox);
		this.showAll();
	

		this.menuIncluirExtensao.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuIncluirExtensao_activate(mi);
			}
		});
		this.menuExcluirExtensao.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuExcluirExtensao_activate(mi);
			}
		});
		this.menuExcluirTodasExtensoes.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuExcluirTodasExtensoes_activate(mi);
			}
		});
		this.menuExportarBitmap.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuExportarBitmap_activate(mi);
			}
		});
		this.menuExportarIcone.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuExportarIcone_activate(mi);
			}
		});
		this.menuExportarGIF.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuExportarGIF_activate(mi);
			}
		});
		this.menuExportarJPEG.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuExportarJPEG_activate(mi);
			}
		});
		this.menuExportarPNG.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuExportarPNG_activate(mi);
			}
		});
		this.menuExportarTIFF.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuExportarTIFF_activate(mi);
			}
		});
		this.menuImportarIconesArquivos.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuImportarIconesArquivos_activate(mi);
			}
		});
		this.menuExtrairIconesArquivos.connect(new MenuItem.Activate(){
			@Override
			public void onActivate(MenuItem mi){
				on_menuExtrairIconesArquivos_activate(mi);
			}
		});
		this.btnIncluir.connect(new Button.Clicked(){
			@Override
			public void onClicked(Button source){
				on_btnIncluir_clicked(source);
			}
		});
		this.btnExcluir.connect(new Button.Clicked(){
			@Override
			public void onClicked(Button source){
				on_btnExcluir_clicked(source);
			}
		});

	}

	public static void mostrar(Window parent) 
	{
		FrmCadExtensao frmCadExtensao = new FrmCadExtensao(parent);
		frmCadExtensao.setPosition(WindowPosition.CENTER_ALWAYS);
		frmCadExtensao.run();
		frmCadExtensao.destroy();
	}

	public void on_menuIncluirExtensao_activate(MenuItem mi){

	}

	public void on_menuExcluirExtensao_activate(MenuItem mi){
		
	}

	public void on_menuExcluirTodasExtensoes_activate(MenuItem mi){
		
	}

	public void on_menuExportarBitmap_activate(MenuItem mi){
		
	}

	public void on_menuExportarIcone_activate(MenuItem mi){
		
	}

	public void on_menuExportarGIF_activate(MenuItem mi){
		
	}

	public void on_menuExportarJPEG_activate(MenuItem mi){
		
	}

	public void on_menuExportarPNG_activate(MenuItem mi){
		
	}

	public void on_menuExportarTIFF_activate(MenuItem mi){
		
	}

	public void on_menuImportarIconesArquivos_activate(MenuItem mi){
		
	}

	public void on_menuExtrairIconesArquivos_activate(MenuItem mi){
		
	}

	public void on_btnIncluir_clicked(Button source){
		
	}

	public void on_btnExcluir_clicked(Button source){
		
	}


}
