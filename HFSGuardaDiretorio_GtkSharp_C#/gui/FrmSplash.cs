using System;
using Gtk;

namespace HFSGuardaDiretorio.gui
{
	public partial class FrmSplash : Gtk.Window
	{
		public FrmSplash() :
		base (Gtk.WindowType.Toplevel)
		{
			this.Build ();

			label1.ModifyFont(Pango.FontDescription.FromString("Bold 20"));
			label2.ModifyFont(Pango.FontDescription.FromString("Bold 15"));
		}

		public ProgressBar PBar {
			get { return this.pb; }
		}

	}
}

