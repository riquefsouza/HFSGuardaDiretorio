# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 10/12/2014
# * Time: 17:41
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *

class Arquivo(object):
	""" <summary>
	 Description of Arquivo.
	 </summary>
	"""
	def __init__(self, nome, tamanho, modificado, atributos):
		self._nome = nome
		self._tamanho = tamanho
		self._modificado = modificado
		self._atributos = atributos

	def __init__(self, nome, tamanho, modificado, atributos):
		self._nome = nome
		self._tamanho = tamanho
		self._modificado = modificado
		self._atributos = atributos

	def get_Nome(self):
		return nome

	def set_Nome(self, value):
		nome = value

	Nome = property(fget=get_Nome, fset=set_Nome)

	def get_Tamanho(self):
		return tamanho

	def set_Tamanho(self, value):
		tamanho = value

	Tamanho = property(fget=get_Tamanho, fset=set_Tamanho)

	def get_Modificado(self):
		return modificado

	def set_Modificado(self, value):
		modificado = value

	Modificado = property(fget=get_Modificado, fset=set_Modificado)

	def get_Atributos(self):
		return atributos

	def set_Atributos(self, value):
		atributos = value

	Atributos = property(fget=get_Atributos, fset=set_Atributos)