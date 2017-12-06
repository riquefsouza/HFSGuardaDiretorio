# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 14:53
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from HFSGuardaDiretorio.objetos import *

class DiretorioXML(object):
	""" <summary>
	 Description of DiretorioXML.
	 </summary>
	"""
	def __init__(self):
		self._diretorio = Diretorio()

	def get_Diretorio(self):
		return self._diretorio

	def set_Diretorio(self, value):
		self._diretorio = value

	Diretorio = property(fget=get_Diretorio, fset=set_Diretorio)