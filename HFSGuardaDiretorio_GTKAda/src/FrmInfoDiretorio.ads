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

package FrmInfoDiretorio is

	type FrmInfoDiretorio_Record is new Gtk_Dialog_Record with record
		dialog_vbox3: Gtk_Vbox;
		vbox3: Gtk_Vbox;
		frame1: Gtk_Frame;
		table1: Gtk_Table;
		labArquivoComum: Gtk_Label;
		labArquivoOculto: Gtk_Label;
		labArquivoSistema: Gtk_Label;
		labLegendaDiretorio: Gtk_Label;
		labVolumeID: Gtk_Label;
		labArquivoSomenteLeitura: Gtk_Label;
		scrollTabela1: Gtk_Scrolled_Window;
		tabelaInfo: Gtk_Tree_View;
		colunaInfoItem: Gtk_Tree_View_Column;
		colunaInfoDescricao: Gtk_Tree_View_Column;
		dialog_action_area3: Gtk_Hbutton_Box;
		btnOk: Gtk_Button;

	end record;

	type FrmInfoDiretorio_Access is access all FrmInfoDiretorio_Record'Class;

	frmInfoDiretorio: FrmInfoDiretorio_Access;

	procedure Criar(frmInfoDiretorio: out FrmInfoDiretorio_Access);
	procedure Inicializa(frmInfoDiretorio: access FrmInfoDiretorio_Record'Class);
	procedure Mostrar;

	procedure on_btnOk_clicked(source: access Gtk_Button_Record'Class);

end FrmInfoDiretorio;
