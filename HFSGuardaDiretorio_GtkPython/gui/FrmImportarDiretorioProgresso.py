# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 08/07/2015
# * Time: 11:26
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from Gtk import *
from HFSGuardaDiretorio.comum import *

class FrmImportarDiretorioProgresso(IProgressoLog):
	""" <summary>
	 Description of FrmImportarDiretorioProgresso.
	 </summary>
	"""
	def __init__(self, form):
		self._form = form

	def ProgressoLog(self, progresso):
		# 
		# if (progresso.Posicao == 0) {
		# this.form.PBar.Minimum = progresso.Minimo;
		# this.form.PBar.Maximum = progresso.Maximo;
		# this.form.PBar.PulseStep = progresso.Passo;
		# }
		# 
		if progresso.Maximo > 0:
			self._form.PBar.Fraction = Rotinas.calculaProgresso(progresso.Maximo, progresso.Posicao)
		if progresso.Log.Length > 0:
			pos = self._form.MemoImportaDir.Buffer.LineCount
			self._titer = self._form.MemoImportaDir.Buffer.GetIterAtLine(pos)
			self._form.MemoImportaDir.Buffer.Insert(, progresso.Log + "\n")
			self._form.MemoImportaDir.ScrollToIter(self._titer, 0, False, 0, 0)
			self._form.LabStatus2.Text = Convert.ToString(pos)
		while Application.EventsPending():
			Application.RunIteration()