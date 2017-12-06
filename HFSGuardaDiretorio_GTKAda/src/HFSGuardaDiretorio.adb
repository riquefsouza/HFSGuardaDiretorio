with Gtk; use Gtk;
with Gtk.Main;
with Gtk.Widget; use Gtk.Widget;
with FrmPrincipal; use FrmPrincipal;

procedure HFSGuardaDiretorio is
begin
	Gtk.Main.Init;

	Criar(FrmPrincipal.frmPrincipal);
	FrmPrincipal.frmPrincipal.Show_All;

	Gtk.Main.Main;
end HFSGuardaDiretorio;
