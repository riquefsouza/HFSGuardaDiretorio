package hfsguardadiretorio;

import hfsguardadiretorio.gui.FrmPrincipal;

import org.gnome.gtk.Gtk;

public class HFSGuardaDiretorio
{
	public static void main(String args[])
	{
		Gtk.init(args);

		FrmPrincipal frmPrincipal = new FrmPrincipal();
		frmPrincipal.show();
		Gtk.main();
	}
}
