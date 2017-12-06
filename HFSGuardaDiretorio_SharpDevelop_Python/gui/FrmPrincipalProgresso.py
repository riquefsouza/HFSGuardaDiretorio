
from comum import IProgressoLog

class FrmPrincipalProgresso(IProgressoLog.IProgressoLog):
	def __init__(self, form):
		self._form = form

	def ProgressoLog(self, progresso):
		if progresso.Posicao == 0:
			self._form.pb.Minimum = progresso.Minimo
			self._form.pb.Maximum = progresso.Maximo
			self._form.pb.Step = progresso.Passo
		self._form.pb.Value = progresso.Posicao