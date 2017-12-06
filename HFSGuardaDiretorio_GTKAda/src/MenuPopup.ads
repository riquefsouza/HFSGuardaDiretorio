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

package MenuPopup is

	type MenuPopup_Record is new Gtk_Menu_Record with record
		menuInformacoesDiretorioArquivo: Gtk_Menu_Item;
		menuExcluirDiretorioSelecionado: Gtk_Menu_Item;
		menuExpandirDiretorios2: Gtk_Menu_Item;
		menuColapsarDiretorios2: Gtk_Menu_Item;
		separador2: Gtk_Separator_Menu_Item;
		menuIncluirNovaAba2: Gtk_Menu_Item;
		menuAlterarNomeAbaAtiva2: Gtk_Menu_Item;
		menuExcluirAbaAtiva2: Gtk_Menu_Item;

	end record;

	type MenuPopup_Access is access all MenuPopup_Record'Class;

	menuPopup: MenuPopup_Access;

	procedure Criar(menuPopup: out MenuPopup_Access);
	procedure Inicializa(menuPopup: access MenuPopup_Record'Class);
	procedure Mostrar;

	procedure on_menuInformacoesDiretorioArquivo_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuExcluirDiretorioSelecionado_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuExpandirDiretorios2_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuColapsarDiretorios2_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuIncluirNovaAba2_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuAlterarNomeAbaAtiva2_activate(source: access Gtk_Menu_Item_Record'Class);
	procedure on_menuExcluirAbaAtiva2_activate(source: access Gtk_Menu_Item_Record'Class);

end MenuPopup;
