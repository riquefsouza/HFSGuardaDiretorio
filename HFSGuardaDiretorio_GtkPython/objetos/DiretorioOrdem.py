# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 14:47
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *

class DiretorioOrdem(object):
	""" <summary>
	 Description of DiretorioOrdem.
	 </summary>
	"""
	def __init__(self):
		""" <summary>
		 Description of DiretorioOrdem.
		 </summary>
		"""

	def get_Ordem(self):
		return self._ordem

	def set_Ordem(self, value):
		self._ordem = value

	Ordem = property(fget=get_Ordem, fset=set_Ordem)