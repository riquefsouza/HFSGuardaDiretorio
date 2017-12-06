# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 07/07/2015
# * Time: 11:01
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *

class RotuloRaiz(object):
	""" <summary>
	 Description of RotuloRaiz.
	 </summary>
	"""
	def __init__(self):

	def get_Rotulo(self):
		return self._rotulo

	def set_Rotulo(self, value):
		self._rotulo = value

	Rotulo = property(fget=get_Rotulo, fset=set_Rotulo)