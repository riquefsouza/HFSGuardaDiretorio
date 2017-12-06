# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 14:29
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *

class ConexaoParams(object):
	""" <summary>
	 Description of ConexaoParams.
	 </summary>
	"""
	def __init__(self):
		self._nome = ""
		self._driver = ""
		self._url = ""
		self._login = ""
		self._senha = ""

	def get_Nome(self):
		return self._nome

	def set_Nome(self, value):
		self._nome = value

	Nome = property(fget=get_Nome, fset=set_Nome)

	def get_Driver(self):
		return self._driver

	def set_Driver(self, value):
		self._driver = value

	Driver = property(fget=get_Driver, fset=set_Driver)

	def get_Url(self):
		return self._url

	def set_Url(self, value):
		self._url = value

	Url = property(fget=get_Url, fset=set_Url)

	def get_Login(self):
		return self._login

	def set_Login(self, value):
		self._login = value

	Login = property(fget=get_Login, fset=set_Login)

	def get_Senha(self):
		return self._senha

	def set_Senha(self, value):
		self._senha = value

	Senha = property(fget=get_Senha, fset=set_Senha)