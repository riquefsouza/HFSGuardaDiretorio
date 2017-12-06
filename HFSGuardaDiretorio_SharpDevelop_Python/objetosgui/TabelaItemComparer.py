# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 09/07/2015
# * Time: 17:06
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from System.Collections import *
from System.Windows.Forms import *

class TabelaItemComparer(IComparer):
	""" <summary>
	 Description of TabelaItemComparer.
	 </summary>
	"""
	def __init__(self, coluna, ordem):
		self._col = coluna
		self._ordem = ordem

	def __init__(self, coluna, ordem):
		self._col = coluna
		self._ordem = ordem

	def Compare(self, x, y):
		retornoVal = -1
		retornoVal = String.Compare((x).SubItems[self._col].Text, (y).SubItems[self._col].Text)
		if self._ordem == SortOrder.Ascending:
			retornoVal *= -1
		return retornoVal