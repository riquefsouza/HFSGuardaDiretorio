# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 08/07/2015
# * Time: 11:24
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from HFSGuardaDiretorio.comum import *

class FrmCompararDiretorioProgresso(IProgressoLog):
	""" <summary>
	 Description of FrmCompararDiretorioProgresso.
	 </summary>
	"""
	def __init__(self, form):
		self._form = form

	def ProgressoLog(self, progresso):
		if progresso.Posicao == 0:
			self._form.pb.Minimum = progresso.Minimo
			self._form.pb.Maximum = progresso.Maximo
			self._form.pb.Step = progresso.Passo
		self._form.pb.Value = progresso.Posicao