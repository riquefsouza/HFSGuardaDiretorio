import clr

			import clr

			import clr

			import clr

			import clr

			import clr

			import clr

			import clr

			import clr

			import clr

			import clr

			import clr

			import clr

			import clr

			import clr

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
from Gtk import *
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

	def Construir(self, bTabelaDir, lvTabela):
		tvColuna = TreeViewColumn()
		tvColuna.Title = "Nome"
		pixbufRender = CellRendererPixbuf()
		tvColuna.PackStart(pixbufRender, False)
		tvColuna.AddAttribute(pixbufRender, "pixbuf", 0)
		tvcolunaCell = CellRendererText()
		tvColuna.PackStart(tvcolunaCell, True)
		tvColuna.AddAttribute(tvcolunaCell, "text", 1)
		lvTabela.AppendColumn(tvColuna)
		lvTabela.AppendColumn("Tamanho", Gtk.CellRendererText(), "text", 2)
		lvTabela.AppendColumn("Tipo", Gtk.CellRendererText(), "text", 3)
		lvTabela.AppendColumn("Modificado", Gtk.CellRendererText(), "text", 4)
		lvTabela.AppendColumn("Atributos", Gtk.CellRendererText(), "text", 5)
		lvTabela.AppendColumn("Caminho", Gtk.CellRendererText(), "text", 6)
		tamanhos = Array[int]((300, 100, 70, 120, 90, 300))
		i = 0
		while i < tamanhos.Length:
			#lvTabela.Columns[i].MinWidth = tamanhos[i];
			lvTabela.Columns[i].SortColumnId = i + 1
			lvTabela.Columns[i].Resizable = True
			lvTabela.Columns[i].Sizing = TreeViewColumnSizing.Autosize
			i += 1
		if bTabelaDir:
			lstore = ListStore(clr.GetClrType(Gdk.Pixbuf), clr.GetClrType(str), clr.GetClrType(str), clr.GetClrType(str), clr.GetClrType(str), clr.GetClrType(str), clr.GetClrType(str))
		else:
			lvTabela.AppendColumn("Aba", Gtk.CellRendererText(), "text", 7)
			#lvTabela.Columns[6].MinWidth = 150;
			lvTabela.Columns[6].SortColumnId = 7
			lvTabela.Columns[6].Resizable = True
			lvTabela.Columns[6].Sizing = TreeViewColumnSizing.Autosize
			lstore = ListStore(clr.GetClrType(Gdk.Pixbuf), clr.GetClrType(str), clr.GetClrType(str), clr.GetClrType(str), clr.GetClrType(str), clr.GetClrType(str), clr.GetClrType(str), clr.GetClrType(str))
		lvTabela.Selection.Mode = SelectionMode.Single
		lvTabela.Model = lstore
		lvTabela.ColumnsAutosize()

	def AdicionaItemLista(self, bTabelaDir, lvTabela, dir, extensoes):
		lstore = lvTabela.Model
		lista = List[Object]()
		if dir.Tipo.Codigo == 'D':
			icone = Rotinas.LerArquivoPixbuf("diretorio.gif")
			lista.Add(icone)
		else:
			icone = ExtensaoBO.Instancia.pixbufExtensao(extensoes, dir.Nome)
			lista.Add(icone)
		lista.Add(dir.Nome)
		if dir.Tipo.Codigo == 'D':
			lista.Add("")
		else:
			lista.Add(dir.TamanhoFormatado)
		lista.Add(dir.Tipo.Nome)
		lista.Add(dir.ModificadoFormatado)
		lista.Add(dir.Atributos)
		lista.Add(dir.Caminho)
		if not bTabelaDir:
			lista.Add(dir.Aba.Nome)
		lstore.AppendValues(lista.ToArray())

	def Carregar(self, bTabelaDir, lvTabela, diretorios, extensoes, pb):
		if diretorios.Count > 0:
			nProgresso = 0
			nMaximum = diretorios.Count
			pb.Fraction = 0
			pb.PulseStep = 0.1
			enumerator = diretorios.GetEnumerator()
			while enumerator.MoveNext():
				dir = enumerator.Current
				self.AdicionaItemLista(bTabelaDir, lvTabela, dir, extensoes)
				pb.Fraction = Rotinas.calculaProgresso(nMaximum, nProgresso += 1)

	def encontrarCaminhoPorNome(self, lvTabela, nome):
		lstore = lvTabela.Model
		path = None
		i = 0
		while i < lstore.IterNChildren():
			lstore.IterNthChild(, i)
			slinha = lstore.GetValue(iter, 1)
			if slinha.Equals(nome):
				path = lstore.GetPath(iter)
				break
			i += 1
		return path

	def getLinhaSelecionada(self, lvTabela, bTabelaDir):
		dir = None
		lstore = lvTabela.Model
		lvTabela.Selection.GetSelected()
		if lvTabela.Selection.IterIsSelected(iter):
			dir = Diretorio()
			dir.Nome = lstore.GetValue(iter, 1)
			dir.TamanhoFormatado = lstore.GetValue(iter, 2)
			dir.Tipo = Tipo('D', lstore.GetValue(iter, 3))
			dir.ModificadoFormatado = lstore.GetValue(iter, 4)
			dir.Atributos = lstore.GetValue(iter, 5)
			dir.Caminho = lstore.GetValue(iter, 6)
			if bTabelaDir:
				dir.Aba.Nome = lstore.GetValue(iter, 7)
		return dir

	def listaCompara(self, lvTabela, coluna):
		tabelaStore = lvTabela.Model
		tabelaStore.SetSortFunc(coluna, Compara)

	def Compara(self, modelo, linha1, linha2):
		lstore = modelo
		lstore.GetSortColumnId(, )
		valor1 = modelo.GetValue(linha1, colOrdem)
		valor2 = modelo.GetValue(linha2, colOrdem)
		return valor1.CompareTo(valor2)