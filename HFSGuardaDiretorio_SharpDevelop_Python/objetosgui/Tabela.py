# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 08/07/2015
# * Time: 10:45
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from System.Collections.Generic import *
from System.Windows.Forms import *
from HFSGuardaDiretorio.comum import *
from HFSGuardaDiretorio.objetos import *
from HFSGuardaDiretorio.objetosbo import *

class Tabela(object):
	""" <summary>
	 Description of Tabela.
	 </summary>
	"""
	def get_Instancia(self):
		return self._instancia

	Instancia = property(fget=get_Instancia)

	def __init__(self):
		self._instancia = Tabela()

	def AdicionaItemLista(self, bTabelaDir, lvTabela, dir, extensoes):
		item = lvTabela.Items.Add(dir.Nome)
		if dir.Tipo.Codigo == 'D':
			item.SubItems.Add("")
			item.ImageIndex = 0
		else:
			item.SubItems.Add(dir.TamanhoFormatado)
			item.ImageIndex = ExtensaoBO.Instancia.indiceExtensao(extensoes, dir.Nome)
		item.SubItems.Add(dir.Tipo.Nome)
		item.SubItems.Add(dir.ModificadoFormatado)
		item.SubItems.Add(dir.Atributos)
		item.SubItems.Add(dir.Caminho)
		if not bTabelaDir:
			item.SubItems.Add(dir.Aba.Nome)

	def Carregar(self, bTabelaDir, lvTabela, diretorios, extensoes, pb):
		if diretorios.Count > 0:
			pb.Minimum = 0
			pb.Maximum = diretorios.Count
			pb.Value = 0
			pb.Step = 1
			enumerator = diretorios.GetEnumerator()
			while enumerator.MoveNext():
				dir = enumerator.Current
				self.AdicionaItemLista(bTabelaDir, lvTabela, dir, extensoes)
				pb.Value += 1

	def encontrarLinha(self, lvTabela, nome):
		nlinha = 0
		i = 0
		while i < lvTabela.Items.Count:
			slinha = lvTabela.Items[i].SubItems[0].Text
			if slinha.Equals(nome):
				nlinha = i
				break
			i += 1
		return nlinha

	def getLinhaSelecionada(self, lvTabela, bTabelaDir):
		dir = None
		if lvTabela.SelectedItems.Count > 0:
			dir = Diretorio()
			dir.Nome = lvTabela.SelectedItems[0].SubItems[0].Text
			dir.TamanhoFormatado = lvTabela.SelectedItems[0].SubItems[1].Text
			dir.Tipo = Tipo('D', lvTabela.SelectedItems[0].SubItems[2].Text)
			dir.ModificadoFormatado = lvTabela.SelectedItems[0].SubItems[3].Text
			dir.Atributos = lvTabela.SelectedItems[0].SubItems[4].Text
			dir.Caminho = lvTabela.SelectedItems[0].SubItems[5].Text
			if bTabelaDir:
				dir.Aba.Nome = lvTabela.SelectedItems[0].SubItems[6].Text
		return dir