using System;
using System.IO;
using Gtk;
using HFSGuardaDiretorio.gui;
using HFSGuardaDiretorio.catalogador;

namespace HFSGuardaDiretorio
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			Application.Init ();

			Catalogador.iniciarSistema();
			//Rotinas.iniciarLogArquivo(log);

			FrmPrincipal frmPrincipal = new FrmPrincipal ();
			frmPrincipal.Show ();
			Application.Run ();
		}
	}
}
