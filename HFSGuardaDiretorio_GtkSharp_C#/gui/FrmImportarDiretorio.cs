using System;
using Gtk;
using System.IO;
using System.Drawing;
using System.Collections.Generic;
using HFSGuardaDiretorio.comum;
using HFSGuardaDiretorio.objetos;
using HFSGuardaDiretorio.objetosbo;
using HFSGuardaDiretorio.objetosgui;
using HFSGuardaDiretorio.catalogador;

namespace HFSGuardaDiretorio.gui
{
	public partial class FrmImportarDiretorio : Gtk.Window
	{
		private readonly FrmPrincipal frmPrincipal;
		private readonly FrmImportarDiretorioProgresso frmImportarDiretorioProgresso;    
		private readonly Catalogador catalogador;

		public bool bSubDiretorio;
		public List<Importar> listaImportar;
		public List<Diretorio> listaDiretorio;
		private int nLargura, nAltura;

		public FrmImportarDiretorio (FrmPrincipal frmPrincipal) :
			base (Gtk.WindowType.Toplevel)
		{
			this.Build ();
			memoImportaDir.CursorVisible = false;
			barraStatus1.GetSizeRequest (out nLargura, out nAltura);
			barraStatus1.SetSizeRequest (180, nAltura);
			LabStatus1.Text = "Total de diferenças encontradas:";

	        frmImportarDiretorioProgresso = new FrmImportarDiretorioProgresso(this);
	        listaImportar = new List<Importar>();
	        
	        this.frmPrincipal = frmPrincipal;
	        catalogador = frmPrincipal.Catalogador;			
		}

		public ProgressBar PBar {
			get { return this.pbImportar; }
		}

		public TextView MemoImportaDir {
			get { return this.memoImportaDir; }
		}

		public Label LabStatus1 {
			get {
				Frame frameStatus1 = (Frame)barraStatus1.Children [0];
				HBox hboxStatus1 = (HBox)frameStatus1.Child;
				return (Label)hboxStatus1.Children [0];
			}
		}

		public Label LabStatus2 {
			get {
				Frame frameStatus2 = (Frame)barraStatus2.Children [0];
				HBox hboxStatus2 = (HBox)frameStatus2.Child;
				return (Label)hboxStatus2.Children [0];
			}
		}

		public void Importar()
		{
			string sLog;

			foreach (Importar importar in this.listaImportar) {
				catalogador.diretorioOrdem.Ordem = 1;

				if (!bSubDiretorio) {
					GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Watch);

					try {
						ImportarBO.Instancia.ImportacaoCompleta(importar,
							catalogador.diretorioOrdem, catalogador.listaExtensoes,
							frmImportarDiretorioProgresso);
					} catch (Exception ex) {
						Dialogo.mensagemErro(ex.Message);
					}					

					GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Arrow);
				} else {
					if (!DiretorioBO.Instancia.verificaCodDir(importar.Aba,
							importar.RotuloRaiz, catalogador.listaDiretorioPai)) {
						GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Watch);

						try {
							ImportarBO.Instancia.ImportacaoCompleta(importar,
									catalogador.diretorioOrdem, catalogador.listaExtensoes,
									frmImportarDiretorioProgresso);							
						} catch (Exception ex) {							
							Dialogo.mensagemErro(ex.Message);
						}
						
						GdkWindow.Cursor = new Gdk.Cursor(Gdk.CursorType.Arrow);
					} else {
						Dialogo.mensagemInfo("O diretório já existe no catálogo!");
					}
				}
			}

			if (frmPrincipal.MenuGravarLogImportacao.Active) {
				if (memoImportaDir.Buffer.LineCount > 0) {
					sLog = Rotinas.ExtractFilePath(Rotinas.ExecutablePath())+
						System.IO.Path.DirectorySeparatorChar +
						Rotinas.formataDate(Rotinas.FORMATO_DHARQUIVO, DateTime.Now) +
						"_Importacao.log";
					
					StringList log = new StringList ();
					TextIter titer;
					for (int nlinha = 0; nlinha < memoImportaDir.Buffer.LineCount; nlinha++) {
						titer = memoImportaDir.Buffer.GetIterAtLine(nlinha);
						log.Add(titer.Buffer.Text);
					}
		            log.SaveToFile(sLog);
				}
			} 
			
		}

	}
}

