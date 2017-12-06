# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 07/07/2015
# * Time: 13:47
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from Gtk import *
from HFSGuardaDiretorio.comum import *

class FrmSplashProgresso(IProgressoLog):
	""" <summary>
	 Description of FrmSplashProgresso.
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
		self._form.PBar.Fraction = Rotinas.calculaProgresso(progresso.Maximo, progresso.Posicao)
		while Application.EventsPending():
			Application.RunIteration()