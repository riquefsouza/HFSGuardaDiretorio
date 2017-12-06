# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 10/12/2014
# * Time: 17:58
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *

class Extensao(object):
	""" <summary>
	 Description of Extensao.
	 </summary>
	"""
	def __init__(self, codigo, nome, ordem, bmp16, bmp32):
		self._codigo = codigo
		self._nome = nome
		self._ordem = ordem
		self._bmp16 = bmp16
		self._bmp32 = bmp32

	def __init__(self, codigo, nome, ordem, bmp16, bmp32):
		self._codigo = codigo
		self._nome = nome
		self._ordem = ordem
		self._bmp16 = bmp16
		self._bmp32 = bmp32

	def get_Codigo(self):
		return codigo

	def set_Codigo(self, value):
		codigo = value

	Codigo = property(fget=get_Codigo, fset=set_Codigo)

	def get_Nome(self):
		return nome

	def set_Nome(self, value):
		nome = value

	Nome = property(fget=get_Nome, fset=set_Nome)

	def get_Ordem(self):
		return ordem

	def set_Ordem(self, value):
		ordem = value

	Ordem = property(fget=get_Ordem, fset=set_Ordem)

	def get_Bmp16(self):
		return bmp16

	def set_Bmp16(self, value):
		bmp16 = value

	Bmp16 = property(fget=get_Bmp16, fset=set_Bmp16)

	def get_Bmp32(self):
		return bmp32

	def set_Bmp32(self, value):
		bmp32 = value

	Bmp32 = property(fget=get_Bmp32, fset=set_Bmp32)