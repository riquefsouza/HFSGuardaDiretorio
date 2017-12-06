# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 14:44
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *

class Tipo(object):
	""" <summary>
	 Description of Tipo.
	 </summary>
	"""
	def __init__(self, codigo, nome):
		self._codigo = codigo
		self._nome = nome

	def __init__(self, codigo, nome):
		self._codigo = codigo
		self._nome = nome

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