import clr

		import clr

from System import *
from Gtk import *
from HFSGuardaDiretorio.objetos import *
from HFSGuardaDiretorio.comum import *

class FrmInfoDiretorio(Gtk.Dialog):
	def __init__(self):
		self.Build()
		self.ConstruirGrid()

	def OnBtnOkClicked(self, sender, e):
		self.Hide()

	def ConstruirGrid(self):
		rtexto = CellRendererText()
		rtexto.FontDesc = Pango.FontDescription.FromString("Bold")
		tabelaInfo.AppendColumn("Item", rtexto, "text", 0)
		tabelaInfo.AppendColumn("Descrição", CellRendererText(), "text", 1)
		#tabelaInfo.Columns [0].MinWidth = 108;
		#tabelaInfo.Columns [1].MinWidth = 214;
		tabelaInfo.Columns[0].SortColumnId = 1
		tabelaInfo.Columns[0].Resizable = True
		tabelaInfo.Columns[0].Sizing = TreeViewColumnSizing.Autosize
		tabelaInfo.Columns[1].SortColumnId = 1
		tabelaInfo.Columns[1].Resizable = True
		tabelaInfo.Columns[1].Sizing = TreeViewColumnSizing.Autosize
		lstore = ListStore(clr.GetClrType(str), clr.GetClrType(str))
		tabelaInfo.Model = lstore

	def setDiretorio(self, diretorio):
		if diretorio != None:
			lstore = tabelaInfo.Model
			lstore.AppendValues("Aba:", diretorio.Aba.Nome)
			lstore.AppendValues("Nome:", diretorio.Nome)
			lstore.AppendValues("Tamanho:", diretorio.TamanhoFormatado)
			lstore.AppendValues("Tipo:", diretorio.Tipo.Nome)
			lstore.AppendValues("Modificado:", diretorio.ModificadoFormatado)
			lstore.AppendValues("Atributos:", diretorio.Atributos)
			lstore.AppendValues("Caminho:", diretorio.Caminho)