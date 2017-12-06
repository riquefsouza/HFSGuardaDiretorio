# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 08/07/2015
# * Time: 11:26
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from HFSGuardaDiretorio.comum import *

class FrmImportarDiretorioProgresso(IProgressoLog):
	""" <summary>
	 Description of FrmImportarDiretorioProgresso.
	 </summary>
	"""
	def __init__(self, form):
		self._form = form

	def ProgressoLog(self, progresso):
		if progresso.Posicao == 0:
			self._form.pbImportar.Minimum = progresso.Minimo
			self._form.pbImportar.Maximum = progresso.Maximo
			self._form.pbImportar.Step = progresso.Passo
		self._form.pbImportar.Value = progresso.Posicao
		if progresso.Log.Length > 0:
			pos = self._form.memoImportaDir.TextLength
			self._form.memoImportaDir.AppendText(progresso.Log + "\n")
			self._form.memoImportaDir.Select(pos, pos)
			self._form.barraStatus.Items[1].Text = Convert.ToString(pos)
			self._form.barraStatus.Update()