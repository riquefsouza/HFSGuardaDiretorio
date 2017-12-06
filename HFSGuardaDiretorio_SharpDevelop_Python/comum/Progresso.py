# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 15:12
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *

class Progresso(object):
	""" <summary>
	 Description of Progresso.
	 </summary>
	"""
	def __init__(self):
		self._log = ""

	def get_Minimo(self):
		return self._minimo

	def set_Minimo(self, value):
		self._minimo = value

	Minimo = property(fget=get_Minimo, fset=set_Minimo)

	def get_Maximo(self):
		return self._maximo

	def set_Maximo(self, value):
		self._maximo = value

	Maximo = property(fget=get_Maximo, fset=set_Maximo)

	def get_Posicao(self):
		return self._posicao

	def set_Posicao(self, value):
		self._posicao = value

	Posicao = property(fget=get_Posicao, fset=set_Posicao)

	def get_Passo(self):
		return self._passo

	def set_Passo(self, value):
		self._passo = value

	Passo = property(fget=get_Passo, fset=set_Passo)

	def get_Log(self):
		return self._log

	def set_Log(self, value):
		self._log = value

	Log = property(fget=get_Log, fset=set_Log)