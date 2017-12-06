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

package FrmCompararDiretorio is

	type FrmCompararDiretorio_Record is new Gtk_Window_Record with record
		vbox5: Gtk_Vbox;
		hbox1: Gtk_Hbox;
		btnCompararDiretorios: Gtk_Button;
		pb2: Gtk_Progress_Bar;
		btnSalvarLog: Gtk_Button;
		hbox2: Gtk_Hbox;
		frame2: Gtk_Frame;
		alignment1: Gtk_Alignment;
		vbox6: Gtk_Vbox;
		cmbAba1: Gtk_Combo_Box;
		scrolledwindow3: Gtk_Scrolled_Window;
		tvDiretorio1: Gtk_Tree_View;
		colunaArvoreDiretorio1: Gtk_Tree_View_Column;
		labDiretorio1: Gtk_Label;
		frame3: Gtk_Frame;
		alignment2: Gtk_Alignment;
		vbox7: Gtk_Vbox;
		cmbAba2: Gtk_Combo_Box;
		scrolledwindow4: Gtk_Scrolled_Window;
		tvDiretorio2: Gtk_Tree_View;
		colunaArvoreDiretorio2: Gtk_Tree_View_Column;
		label6: Gtk_Label;
		hbox4: Gtk_Hbox;
		labDiferencasEncontradas: Gtk_Label;
		scrollTabela12: Gtk_Scrolled_Window;
		tabelaCompara: Gtk_Tree_View;
		colunaComparaNome: Gtk_Tree_View_Column;
		colunaComparaTamanho: Gtk_Tree_View_Column;
		colunaComparaTipo: Gtk_Tree_View_Column;
		colunaComparaModificado: Gtk_Tree_View_Column;
		colunaComparaAtributos: Gtk_Tree_View_Column;
		colunaComparaCaminho: Gtk_Tree_View_Column;
		hbox5: Gtk_Hbox;
		barraStatus11: Gtk_Status_Bar;
		barraStatus21: Gtk_Status_Bar;

	end record;

	type FrmCompararDiretorio_Access is access all FrmCompararDiretorio_Record'Class;

	frmCompararDiretorio: FrmCompararDiretorio_Access;

	procedure Criar(frmCompararDiretorio: out FrmCompararDiretorio_Access);
	procedure Inicializa(frmCompararDiretorio: access FrmCompararDiretorio_Record'Class);
	procedure Mostrar;

	procedure on_btnCompararDiretorios_clicked(source: access Gtk_Button_Record'Class);
	procedure btnSalvarLog_clicked_cb(source: access Gtk_Button_Record'Class);
	procedure on_cmbAba1_changed(source: access Gtk_Combo_Box_Record'Class);
	procedure on_tvDiretorio1_row_collapsed(source: access Gtk_Tree_View_Record'Class; iter: Gtk_Tree_Iter; path: Gtk_Tree_Path);
	procedure on_tvDiretorio1_row_expanded(source: access Gtk_Tree_View_Record'Class; iter: Gtk_Tree_Iter; path: Gtk_Tree_Path);
	function on_tvDiretorio1_button_release_event(source: access Gtk_Widget_Record'Class; event: Gdk_Event_Button) return Boolean;
	procedure on_cmbAba2_changed(source: access Gtk_Combo_Box_Record'Class);
	procedure on_tvDiretorio2_row_collapsed(source: access Gtk_Tree_View_Record'Class; iter: Gtk_Tree_Iter; path: Gtk_Tree_Path);
	procedure on_tvDiretorio2_row_expanded(source: access Gtk_Tree_View_Record'Class; iter: Gtk_Tree_Iter; path: Gtk_Tree_Path);
	function on_tvDiretorio2_button_release_event(source: access Gtk_Widget_Record'Class; event: Gdk_Event_Button) return Boolean;
	procedure on_tabelaCompara_row_activated(source: access Gtk_Tree_View_Record'Class; path: Gtk_Tree_Path; column: not null access Gtk_Tree_View_Column_Record'Class);
	function on_tabelaCompara_button_release_event(source: access Gtk_Widget_Record'Class; event: Gdk_Event_Button) return Boolean;

end FrmCompararDiretorio;
