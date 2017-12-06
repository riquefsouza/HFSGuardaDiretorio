# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 10/12/2014
# * Time: 17:51
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *

class Aba(object):
	""" <summary>
	 Description of Aba.
	 </summary>
	"""
	def __init__(self, codigo, nome, ordem):
		self._codigo = codigo
		self._nome = nome
		self._ordem = ordem

	def __init__(self, codigo, nome, ordem):
		self._codigo = codigo
		self._nome = nome
		self._ordem = ordem

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