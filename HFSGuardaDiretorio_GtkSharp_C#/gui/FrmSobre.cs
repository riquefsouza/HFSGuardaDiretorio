using System;

namespace HFSGuardaDiretorio.gui
{
	public partial class FrmSobre : Gtk.Dialog
	{
		public FrmSobre ()
		{
			this.Build ();
		}

		protected void OnButtonOkClicked (object sender, EventArgs e)
		{
			this.Hide();
		}
	}
}

