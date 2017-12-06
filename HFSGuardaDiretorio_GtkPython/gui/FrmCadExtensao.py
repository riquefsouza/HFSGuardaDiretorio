import clr

		import clr

from System import *
from System.IO import *
from System.Drawing import *
from System.Collections.Generic import *
from Gtk import *
from HFSGuardaDiretorio.catalogador import *
from HFSGuardaDiretorio.objetos import *
from HFSGuardaDiretorio.objetosgui import *
from HFSGuardaDiretorio.objetosbo import *
from HFSGuardaDiretorio.comum import *

class FrmCadExtensao(Gtk.Dialog):
	def __init__(self, frmPrincipal):
		self.Build()
		self._catalogador = frmPrincipal.Catalogador
		self.ConstruirGrid()
		self.CarregarExtensoesNaGrid()

	def ConstruirGrid(self):
		tabelaExtensao.AppendColumn("Extensão", CellRendererText(), "text", 0)
		tabelaExtensao.AppendColumn("Ícone", CellRendererPixbuf(), "pixbuf", 1)
		tabelaExtensao.Columns[0].MinWidth = 150
		tabelaExtensao.Columns[1].MinWidth = 100
		lstore = ListStore(clr.GetClrType(str), clr.GetClrType(Gdk.Pixbuf))
		tabelaExtensao.Model = lstore

	def CarregarExtensoesNaGrid(self):
		lstore = tabelaExtensao.Model
		lstore.Clear()
		enumerator = self._catalogador.listaExtensoes.GetEnumerator()
		while enumerator.MoveNext():
			extensao = enumerator.Current
			lstore.AppendValues(extensao.Nome, Rotinas.byteArrayToPixbuf(extensao.Bmp16))

	def OnIncluirExtensaoActionActivated(self, sender, e):
		if EscolhaArquivo.abrirArquivo(EscolhaArquivo.FILTRO_IMAGEM):
			arquivo = FileInfo(EscolhaArquivo.NomeArquivo)
			if arquivo.Exists:
				log = StringList()
				if ExtensaoBO.Instancia.SalvarExtensao(self._catalogador.listaExtensoes, arquivo.Name, arquivo.FullName, log):
					self.CarregarExtensoesNaGrid()
					Dialogo.mensagemInfo("Extensão salva com sucesso!")
				else:
					Dialogo.mensagemInfo("Extensão já existe cadastrada!")

	def OnExcluirExtensaoActionActivated(self, sender, e):
		if self._catalogador.listaExtensoes.Count > 0:
			res = Dialogo.confirma("Tem Certeza, que você deseja excluir esta extensão?")
			if res:
				path = tabelaExtensao.Selection.GetSelectedRows()[0]
				extensao = ExtensaoBO.Instancia.pegaExtensaoPorOrdem(self._catalogador.listaExtensoes, path.Indices[0] + 1)
				if ExtensaoBO.Instancia.excluirExtensao(self._catalogador.listaExtensoes, extensao.Codigo):
					self.CarregarExtensoesNaGrid()
					Dialogo.mensagemInfo("Extensão excluída com sucesso!")

	def OnExcluirTodasExtensoesActionActivated(self, sender, e):
		res = Dialogo.confirma("Tem Certeza, que você deseja excluir todas as extensões?")
		if res:
			if ExtensaoBO.Instancia.excluirTodasExtensoes(self._catalogador.listaExtensoes):
				self.CarregarExtensoesNaGrid()
				Dialogo.mensagemInfo("Extensões excluídas com sucesso!")

	def OnExportarParaTIFFActionActivated(self, sender, e):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teTIF, self._catalogador.listaExtensoes)

	def OnExportarParaPNGActionActivated(self, sender, e):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.tePNG, self._catalogador.listaExtensoes)

	def OnExportarParaJPEGActionActivated(self, sender, e):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teJPG, self._catalogador.listaExtensoes)

	def OnExportarParaGIFActionActivated(self, sender, e):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teGIF, self._catalogador.listaExtensoes)

	def OnExportarParaIConeActionActivated(self, sender, e):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teICO, self._catalogador.listaExtensoes)

	def OnExportarParaBitmapActionActivated(self, sender, e):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teBMP, self._catalogador.listaExtensoes)

	def OnImportarIconesDosArquivosActionActivated(self, sender, e):
		if EscolhaArquivo.abrirArquivo(EscolhaArquivo.FILTRO_IMAGEM):
			arquivo = FileInfo(EscolhaArquivo.NomeArquivo)
			if arquivo.Exists:
				ExtensaoBO.Instancia.ImportarExtensao(arquivo.FullName, self._catalogador.listaExtensoes)
				self.CarregarExtensoesNaGrid()

	def OnExtrairIconesDosArquivosActionActivated(self, sender, e):
		if EscolhaArquivo.abrirArquivo(EscolhaArquivo.FILTRO_IMAGEM):
			arquivo = FileInfo(EscolhaArquivo.NomeArquivo)
			if arquivo.Exists:
				ExtensaoBO.Instancia.ExtrairExtensao(arquivo.FullName, self._catalogador.listaExtensoes)
				self.CarregarExtensoesNaGrid()

	def OnBtnIncluirClicked(self, sender, e):
		self.OnIncluirExtensaoActionActivated(sender, e)

	def OnBtnExcluirClicked(self, sender, e):
		self.OnExcluirExtensaoActionActivated(sender, e)