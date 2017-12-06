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

package FrmCadExtensao is

	type FrmCadExtensao_Record is new Gtk_Dialog_Record with record
		form_vbox: Gtk_Vbox;
		vbox: Gtk_Vbox;
		barraMenu: Gtk_Menu_Bar;
		menuExtensao: Gtk_Menu_Item;
		submenuExtensao: Gtk_Menu;
		menuIncluirExtensao: Gtk_Menu_Item;
		menuExcluirExtensao: Gtk_Menu_Item;
		menuExcluirTodasExtensoes: Gtk_Menu_Item;
		menuExportarTodos: Gtk_Menu_Item;
		submenuExportarTodos: Gtk_Menu;
		menuExportarBitmap: Gtk_Menu_Item;
		menuExportarIcone: Gtk_Menu_Item;
		menuExportarGIF: Gtk_Menu_Item;
		menuExportarJPEG: Gtk_Menu_Item;
		menuExportarPNG: Gtk_Menu_Item;
		menuExportarTIFF: Gtk_Menu_Item;
		menuImportarTodos: Gtk_Menu_Item;
		submenuImportarTodos: Gtk_Menu;
		menuImportarIconesArquivos: Gtk_Menu_Item;
		menuExtrairIconesArquivos: Gtk_Menu_Item;
		scrollTabela: Gtk_Scrolled_Window;
		tabelaExtensao: Gtk_Tree_View;
		colunaCadExtExtensao: Gtk_Tree_View_Column;
		colunaCadExtIcone: Gtk_Tree_View_Column;
		form_area: Gtk_Hbutton_Box;
		btnIncluir: Gtk_Button;
		btnExcluir: Gtk_Button;

	end record;

	type FrmCadExtensao_Access is access all FrmCadExtensao_Record'Class;

	frmCadExtensao: FrmCadExtensao_Access;

	procedure Criar(frmCadExtensao: out FrmCadExtensao_Access);
	procedure Inicializa(frmCadExtensao: access FrmCadExtensao_Record'Class);
	procedure Mostrar;

	procedure on_menuIncluirExtensao_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuExcluirExtensao_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuExcluirTodasExtensoes_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuExportarBitmap_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuExportarIcone_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuExportarGIF_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuExportarJPEG_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuExportarPNG_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuExportarTIFF_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuImportarIconesArquivos_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuExtrairIconesArquivos_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_btnIncluir_clicked(source: access Gtk_Button_Record'Class);
	procedure on_btnExcluir_clicked(source: access Gtk_Button_Record'Class);

end FrmCadExtensao;
