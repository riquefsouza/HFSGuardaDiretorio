/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 08/07/2015
 * Time: 11:24
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.gui

import System
import HFSGuardaDiretorio.comum

public class FrmCompararDiretorioProgresso(IProgressoLog):

	private form as FrmCompararDiretorio

	
	public def constructor(form as FrmCompararDiretorio):
		self.form = form

	
	public def ProgressoLog(progresso as Progresso):
		if progresso.Posicao == 0:
			self.form.pb.Minimum = progresso.Minimo
			self.form.pb.Maximum = progresso.Maximo
			self.form.pb.Step = progresso.Passo
		self.form.pb.Value = progresso.Posicao
	

