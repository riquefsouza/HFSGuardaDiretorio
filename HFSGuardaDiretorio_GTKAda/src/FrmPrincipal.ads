with Glib; use Glib;
with Gtk.Window; use Gtk.Window;
with Gtk.Box; use Gtk.Box;
with Gtk.Menu_Bar; use Gtk.Menu_Bar;
with Gtk.Menu_Item; use Gtk.Menu_Item;
with Gtk.Menu; use Gtk.Menu;
with Gtk.Check_Menu_Item; use Gtk.Check_Menu_Item;
with Gtk.Separator_Menu_Item; use Gtk.Separator_Menu_Item;
with Gtk.Toolbar; use Gtk.Toolbar;
with Gtk.Separator; use Gtk.Separator;
with Gtk.Fixed; use Gtk.Fixed;
with Gtk.Status_Bar; use Gtk.Status_Bar;
with Gtk.Button; use Gtk.Button;
with Gtk.Arguments; use Gtk.Arguments;
with Gtk.Widget; use Gtk.Widget;
with Gtk.Button; use Gtk.Button;
with Gtk.Label; use Gtk.Label;
with Gtk.Tool_Item; use Gtk.Tool_Item;
with Gtk.Progress_Bar; use Gtk.Progress_Bar;
with Gtk.GEntry; use Gtk.GEntry;
with Gtk.Paned; use Gtk.Paned;
with Gtk.Notebook; use Gtk.Notebook;
with Gtk.Scrolled_Window; use Gtk.Scrolled_Window;
with Gtk.Tree_View; use Gtk.Tree_View;
with Gtk.Tree_View_Column; use Gtk.Tree_View_Column;
with Gdk.Event; use Gdk.Event;
with Gtk.Tree_Model; use Gtk.Tree_Model;
with Gtk.Dialog; use Gtk.Dialog;
with Gtk.Hbutton_Box; use Gtk.Hbutton_Box;
with Gtk.Frame; use Gtk.Frame;
with Gtk.Table; use Gtk.Table;
with Gtk.Alignment; use Gtk.Alignment;
with Gtk.Combo_Box; use Gtk.Combo_Box;
with Gtk.Text_View; use Gtk.Text_View;

package FrmPrincipal is

	type FrmPrincipal_Record is new Gtk_Window_Record with record
		vbox1: Gtk_Vbox;
		barraMenu1: Gtk_Menu_Bar;
		menuAba: Gtk_Menu_Item;
		submenuAba: Gtk_Menu;
		menuIncluirNovaAba: Gtk_Menu_Item;
		menuAlterarNomeAbaAtiva: Gtk_Menu_Item;
		menuExcluirAbaAtiva: Gtk_Menu_Item;
		menuDiretorio: Gtk_Menu_Item;
		submenuDiretorio: Gtk_Menu;
		menuImportarDiretorio: Gtk_Menu_Item;
		menuImportarSubDiretorios: Gtk_Menu_Item;
		menuCompararDiretorios: Gtk_Menu_Item;
		menuCadastrarExtensaoArquivo: Gtk_Menu_Item;
		menuseparador1: Gtk_Separator_Menu_Item;
		menuExpandirDiretorios: Gtk_Menu_Item;
		menuColapsarDiretorios: Gtk_Menu_Item;
		menuExportarDiretoriosAbaAtiva: Gtk_Menu_Item;
		menu2: Gtk_Menu;
		menuTXT: Gtk_Menu_Item;
		menuCSV: Gtk_Menu_Item;
		menuHTML: Gtk_Menu_Item;
		menuXML: Gtk_Menu_Item;
		menuSQL: Gtk_Menu_Item;
		menuImportarDiretoriosViaXML: Gtk_Menu_Item;
		menuGravarLogImportacao: Gtk_Check_Menu_Item;
		menuVisao: Gtk_Menu_Item;
		submenuVisao: Gtk_Menu;
		menuMostrarOcultarArvoreDirAbaAtiva: Gtk_Menu_Item;
		menuMostrarOcultarListaItensPesquisados: Gtk_Menu_Item;
		menuSobre: Gtk_Menu_Item;
		submenuSobre: Gtk_Menu;
		menuSobreCatalogador: Gtk_Menu_Item;
		toolbar1: Gtk_Toolbar;
		toolbutton1: Gtk_Tool_Item;
		btnImportarDiretorio: Gtk_Button;
		toolbutton2: Gtk_Tool_Item;
		pb: Gtk_Progress_Bar;
		toolbutton3: Gtk_Tool_Item;
		edtPesquisa: Gtk_Entry;
		toolbutton4: Gtk_Tool_Item;
		btnPesquisa: Gtk_Button;
		spPesquisa: Gtk_Vpaned;
		notebook1: Gtk_Notebook;
		sp: Gtk_Hpaned;
		scrollArvore: Gtk_Scrolled_Window;
		arvoreFixa: Gtk_Tree_View;
		colunaArvoreFixa: Gtk_Tree_View_Column;
		scrollTabelaFixa: Gtk_Scrolled_Window;
		tabelaFixa: Gtk_Tree_View;
		colunaTabelaFixaNome: Gtk_Tree_View_Column;
		colunaTabelaFixaTamanho: Gtk_Tree_View_Column;
		colunaTabelaFixaTipo: Gtk_Tree_View_Column;
		colunaTabelaFixaModificado: Gtk_Tree_View_Column;
		colunaTabelaFixaAtributos: Gtk_Tree_View_Column;
		colunaTabelaFixaCaminho: Gtk_Tree_View_Column;
		labAbaFixa: Gtk_Label;
		label2: Gtk_Label;
		label3: Gtk_Label;
		scrollPesquisa: Gtk_Scrolled_Window;
		tabelaPesquisa: Gtk_Tree_View;
		colunaTabelaPesquisaNome: Gtk_Tree_View_Column;
		colunaTabelaPesquisaTamanho: Gtk_Tree_View_Column;
		colunaTabelaPesquisaTipo: Gtk_Tree_View_Column;
		colunaTabelaPesquisaModificado: Gtk_Tree_View_Column;
		colunaTabelaPesquisaAtributos: Gtk_Tree_View_Column;
		colunaTabelaPesquisaCaminho: Gtk_Tree_View_Column;
		colunaTabelaPesquisaAba: Gtk_Tree_View_Column;
		hbox6: Gtk_Hbox;
		barraStatus111: Gtk_Status_Bar;
		barraStatus211: Gtk_Status_Bar;

	end record;

	type FrmPrincipal_Access is access all FrmPrincipal_Record'Class;

	frmPrincipal: FrmPrincipal_Access;

	procedure Criar(frmPrincipal: out FrmPrincipal_Access);
	procedure Inicializa(frmPrincipal: access FrmPrincipal_Record'Class);
	procedure Mostrar;

	procedure on_menuIncluirNovaAba_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuAlterarNomeAbaAtiva_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuExcluirAbaAtiva_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuImportarDiretorio_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuImportarSubDiretorios_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuCompararDiretorios_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuCadastrarExtensaoArquivo_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuExpandirDiretorios_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuColapsarDiretorios_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuExportarDiretoriosAbaAtiva_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuTXT_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuCSV_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuHTML_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuXML_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuSQL_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuImportarDiretoriosViaXML_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuMostrarOcultarArvoreDirAbaAtiva_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuMostrarOcultarListaItensPesquisados_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuSobreCatalogador_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_btnImportarDiretorio_clicked(source: access Gtk_Button_Record'Class);
	procedure on_btnPesquisa_clicked(source: access Gtk_Button_Record'Class);
	procedure on_notebook1_switch_page(source: access Gtk_Notebook_Record'Class; pageNum: Guint);
	procedure on_arvoreFixa_row_collapsed(source: access Gtk_Tree_View_Record'Class; iter: Gtk_Tree_Iter; path: Gtk_Tree_Path);
	function on_arvoreFixa_button_release_event(source: access Gtk_Widget_Record'Class; event: Gdk_Event_Button) return Boolean;
	procedure on_arvoreFixa_row_expanded(source: access Gtk_Tree_View_Record'Class; iter: Gtk_Tree_Iter; path: Gtk_Tree_Path);
	function on_tabelaFixa_button_release_event(source: access Gtk_Widget_Record'Class; event: Gdk_Event_Button) return Boolean;
	procedure on_tabelaFixa_row_activated(source: access Gtk_Tree_View_Record'Class; path: Gtk_Tree_Path; column: not null access Gtk_Tree_View_Column_Record'Class);
	function on_tabelaPesquisa_button_release_event(source: access Gtk_Widget_Record'Class; event: Gdk_Event_Button) return Boolean;
	function on_FrmPrincipal_delete_event(source: access Gtk_Widget_Record'Class; event: Gdk_Event) return Boolean;

end FrmPrincipal;
