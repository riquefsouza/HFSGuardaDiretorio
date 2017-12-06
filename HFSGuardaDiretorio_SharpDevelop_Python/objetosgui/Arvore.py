# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 08/07/2015
# * Time: 10:51
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from System.Windows.Forms import *

class Arvore(object):
	""" <summary>
	 Description of Arvore.
	 </summary>
	"""
	def get_Instancia(self):
		return self._instancia

	Instancia = property(fget=get_Instancia)

	def __init__(self):
		self._instancia = Arvore()

	def encontrarCaminhoPorNome(self, tvArvore, nomes):
		enumerator = tvArvore.Nodes.GetEnumerator()
		while enumerator.MoveNext():
			item = enumerator.Current
			if item.Text.Equals(nomes[0]):
				return self.encontrarCaminho(item, nomes, 0)
		return None

	def encontrarCaminho(self, pai, nomes, nivel):
		if pai.Text.Equals(nomes[nivel]):
			if nivel == (nomes.Length - 1):
				return pai
			if pai.GetNodeCount(True) > 0:
				enumerator = pai.Nodes.GetEnumerator()
				while enumerator.MoveNext():
					filho = enumerator.Current
					res = self.encontrarCaminho(filho, nomes, nivel + 1)
					if res != None:
						return res
		return None