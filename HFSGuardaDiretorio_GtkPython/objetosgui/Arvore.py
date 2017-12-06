import clr

		import clr

# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 08/07/2015
# * Time: 10:51
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from Gtk import *
from System.Collections.Generic import *

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

	def Construir(self, tvArvore):
		tvColuna = TreeViewColumn()
		tvColuna.Title = "coluna"
		pixbufRender = CellRendererPixbuf()
		tvColuna.PackStart(pixbufRender, False)
		tvColuna.AddAttribute(pixbufRender, "pixbuf", 0)
		tvcolunaCell = CellRendererText()
		tvColuna.PackStart(tvcolunaCell, True)
		tvColuna.AddAttribute(tvcolunaCell, "text", 1)
		tvArvore.AppendColumn(tvColuna)
		tvArvore.HeadersVisible = False
		tvArvore.Selection.Mode = SelectionMode.Single
		storeArvore = TreeStore(clr.GetClrType(Gdk.Pixbuf), clr.GetClrType(str))
		tvArvore.Model = storeArvore

	def selecionarPrimeiroItem(self, tvArvore):
		store = tvArvore.Model
		store.GetIterFirst()
		tvArvore.Selection.SelectIter(iter)

	def encontrarCaminhoPorNome(self, tvArvore, nomes):
		arvoreStore = tvArvore.Model
		if arvoreStore.GetIterFirst():
			raiz = self.encontrarCaminho(arvoreStore, raiz, nomes, 0)
			return arvoreStore.GetPath(raiz)
		return None

	def encontrarCaminho(self, arvoreStore, pai, nomes, nivel):
		bValido = arvoreStore.IterIsValid(pai)
		if bValido:
			while bValido:
				valorPai = arvoreStore.GetValue(pai, 1)
				if valorPai.Equals(nomes[nivel]):
					if nivel == (nomes.Length - 1):
						return pai
					if arvoreStore.IterHasChild(pai):
						arvoreStore.IterChildren(, pai)
						return self.encontrarCaminho(arvoreStore, filho, nomes, nivel + 1)
				bValido = arvoreStore.IterNext()
		return pai