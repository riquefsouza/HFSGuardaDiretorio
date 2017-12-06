# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 10/12/2014
# * Time: 17:48
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *

class Diretorio(Arquivo):
	""" <summary>
	 Description of Diretorio.
	 </summary>
	 
	"""
	def __init__(self):
		self._aba = Aba()
		self._codigo = 0
		self._ordem = 0
		self._codDirPai = 0
		self._tipo = Tipo()
		self._caminho = ""
		self._nomePai = ""
		self._caminhoPai = ""
		self._tamanhoFormatado = ""
		self._modificadoFormatado = ""
		self._caminhoOriginal = ""

	def get_Aba(self):
		return self._aba

	def set_Aba(self, value):
		self._aba = value

	Aba = property(fget=get_Aba, fset=set_Aba)

	def get_Codigo(self):
		return self._codigo

	def set_Codigo(self, value):
		self._codigo = value

	Codigo = property(fget=get_Codigo, fset=set_Codigo)

	def get_Ordem(self):
		return self._ordem

	def set_Ordem(self, value):
		self._ordem = value

	Ordem = property(fget=get_Ordem, fset=set_Ordem)

	def get_CodDirPai(self):
		return self._codDirPai

	def set_CodDirPai(self, value):
		self._codDirPai = value

	CodDirPai = property(fget=get_CodDirPai, fset=set_CodDirPai)

	def get_Tipo(self):
		return self._tipo

	def set_Tipo(self, value):
		self._tipo = value

	Tipo = property(fget=get_Tipo, fset=set_Tipo)

	def get_Caminho(self):
		return self._caminho

	def set_Caminho(self, value):
		self._caminho = value

	Caminho = property(fget=get_Caminho, fset=set_Caminho)

	def get_NomePai(self):
		return self._nomePai

	def set_NomePai(self, value):
		self._nomePai = value

	NomePai = property(fget=get_NomePai, fset=set_NomePai)

	def get_CaminhoPai(self):
		return self._caminhoPai

	def set_CaminhoPai(self, value):
		self._caminhoPai = value

	CaminhoPai = property(fget=get_CaminhoPai, fset=set_CaminhoPai)

	def get_TamanhoFormatado(self):
		return self._tamanhoFormatado

	def set_TamanhoFormatado(self, value):
		self._tamanhoFormatado = value

	TamanhoFormatado = property(fget=get_TamanhoFormatado, fset=set_TamanhoFormatado)

	def get_ModificadoFormatado(self):
		return self._modificadoFormatado

	def set_ModificadoFormatado(self, value):
		self._modificadoFormatado = value

	ModificadoFormatado = property(fget=get_ModificadoFormatado, fset=set_ModificadoFormatado)

	def get_CaminhoOriginal(self):
		return self._caminhoOriginal

	def set_CaminhoOriginal(self, value):
		self._caminhoOriginal = value

	CaminhoOriginal = property(fget=get_CaminhoOriginal, fset=set_CaminhoOriginal)