# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 14:41
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *

class Importar(object):
	""" <summary>
	 Description of Importar.
	 </summary>
	"""
	def __init__(self):
		self._aba = 0
		self._codDirRaiz = 0
		self._rotuloRaiz = ""
		self._nomeDirRaiz = ""
		self._caminho = ""

	def get_Aba(self):
		return self._aba

	def set_Aba(self, value):
		self._aba = value

	Aba = property(fget=get_Aba, fset=set_Aba)

	def get_CodDirRaiz(self):
		return self._codDirRaiz

	def set_CodDirRaiz(self, value):
		self._codDirRaiz = value

	CodDirRaiz = property(fget=get_CodDirRaiz, fset=set_CodDirRaiz)

	def get_RotuloRaiz(self):
		return self._rotuloRaiz

	def set_RotuloRaiz(self, value):
		self._rotuloRaiz = value

	RotuloRaiz = property(fget=get_RotuloRaiz, fset=set_RotuloRaiz)

	def get_NomeDirRaiz(self):
		return self._nomeDirRaiz

	def set_NomeDirRaiz(self, value):
		self._nomeDirRaiz = value

	NomeDirRaiz = property(fget=get_NomeDirRaiz, fset=set_NomeDirRaiz)

	def get_Caminho(self):
		return self._caminho

	def set_Caminho(self, value):
		self._caminho = value

	Caminho = property(fget=get_Caminho, fset=set_Caminho)