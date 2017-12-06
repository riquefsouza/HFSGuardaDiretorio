/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 08/07/2015
 * Time: 11:26
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.gui

import System
import HFSGuardaDiretorio.comum

public class FrmImportarDiretorioProgresso(IProgressoLog):

	private form as FrmImportarDiretorio

	
	public def constructor(form as FrmImportarDiretorio):
		self.form = form

	
	public def ProgressoLog(progresso as Progresso):
		if progresso.Posicao == 0:
			self.form.pbImportar.Minimum = progresso.Minimo
			self.form.pbImportar.Maximum = progresso.Maximo
			self.form.pbImportar.Step = progresso.Passo
		self.form.pbImportar.Value = progresso.Posicao
		
		if progresso.Log.Length > 0:
			pos as int = form.memoImportaDir.TextLength
			form.memoImportaDir.AppendText((progresso.Log + '\n'))
			form.memoImportaDir.Select(pos, pos)
			form.barraStatus.Items[1].Text = Convert.ToString(pos)
			form.barraStatus.Update()
		
	

