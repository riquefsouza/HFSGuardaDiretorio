/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 08/07/2015
 * Time: 11:26
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using Gtk;
using HFSGuardaDiretorio.comum;

namespace HFSGuardaDiretorio.gui
{
	/// <summary>
	/// Description of FrmImportarDiretorioProgresso.
	/// </summary>
	public class FrmImportarDiretorioProgresso : IProgressoLog
	{
	    FrmImportarDiretorio form;
		TextIter titer;

	    public FrmImportarDiretorioProgresso(FrmImportarDiretorio form) 
	    {
	        this.form = form;
		}
	    
		public void ProgressoLog(Progresso progresso)
		{
			/*
	        if (progresso.Posicao == 0) {
				this.form.PBar.Minimum = progresso.Minimo;
				this.form.PBar.Maximum = progresso.Maximo;
				this.form.PBar.PulseStep = progresso.Passo;
			}
			*/
			if (progresso.Maximo > 0) {
				this.form.PBar.Fraction = Rotinas.calculaProgresso (progresso.Maximo, progresso.Posicao);				
			}
	        
	        if (progresso.Log.Length > 0) {
				int pos = form.MemoImportaDir.Buffer.LineCount;
				titer = form.MemoImportaDir.Buffer.GetIterAtLine (pos);
				form.MemoImportaDir.Buffer.Insert(ref titer, progresso.Log+"\n");
				form.MemoImportaDir.ScrollToIter (titer, 0, false, 0, 0);
	            form.LabStatus2.Text = Convert.ToString(pos);
	        }
	        
			while (Application.EventsPending ())
				Application.RunIteration ();

		}
	    
	}
}
