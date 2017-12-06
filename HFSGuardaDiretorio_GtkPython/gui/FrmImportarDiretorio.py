from System import *
from Gtk import *
from System.IO import *
from System.Drawing import *
from System.Collections.Generic import *
from HFSGuardaDiretorio.comum import *
from HFSGuardaDiretorio.objetos import *
from HFSGuardaDiretorio.objetosbo import *
from HFSGuardaDiretorio.objetosgui import *
from HFSGuardaDiretorio.catalogador import *

class FrmImportarDiretorio(Gtk.Window):
	def __init__(self, frmPrincipal):
		self.Build()
		memoImportaDir.CursorVisible = False
		barraStatus1.GetSizeRequest(, )
		barraStatus1.SetSizeRequest(180, self._nAltura)
		LabStatus1.Text = "Total de diferenças encontradas:"
		self._frmImportarDiretorioProgresso = FrmImportarDiretorioProgresso(self)
		self._listaImportar = List[Importar]()
		self._frmPrincipal = frmPrincipal
		self._catalogador = frmPrincipal.Catalogador

	def get_PBar(self):
		return self._pbImportar

	PBar = property(fget=get_PBar)

	def get_MemoImportaDir(self):
		return self._memoImportaDir

	MemoImportaDir = property(fget=get_MemoImportaDir)

	def get_LabStatus1(self):
		frameStatus1 = barraStatus1.Children[0]
		hboxStatus1 = frameStatus1.Child
		return hboxStatus1.Children[0]

	LabStatus1 = property(fget=get_LabStatus1)

	def get_LabStatus2(self):
		frameStatus2 = barraStatus2.Children[0]
		hboxStatus2 = frameStatus2.Child
		return hboxStatus2.Children[0]

	LabStatus2 = property(fget=get_LabStatus2)

	def Importar(self):
		enumerator = self._listaImportar.GetEnumerator()
		while enumerator.MoveNext():
			importar = enumerator.Current
			self._catalogador.diretorioOrdem.Ordem = 1
			if not self._bSubDiretorio:
				GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Watch)
				try:
					ImportarBO.Instancia.ImportacaoCompleta(importar, self._catalogador.diretorioOrdem, self._catalogador.listaExtensoes, self._frmImportarDiretorioProgresso)
				except Exception, ex:
					Dialogo.mensagemErro(ex.Message)
				finally:
				GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Arrow)
			else:
				if not DiretorioBO.Instancia.verificaCodDir(importar.Aba, importar.RotuloRaiz, self._catalogador.listaDiretorioPai):
					GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Watch)
					try:
						ImportarBO.Instancia.ImportacaoCompleta(importar, self._catalogador.diretorioOrdem, self._catalogador.listaExtensoes, self._frmImportarDiretorioProgresso)
					except Exception, ex:
						Dialogo.mensagemErro(ex.Message)
					finally:
					GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Arrow)
				else:
					Dialogo.mensagemInfo("O diretório já existe no catálogo!")
		if self._frmPrincipal.MenuGravarLogImportacao.Active:
			if memoImportaDir.Buffer.LineCount > 0:
				sLog = Rotinas.ExtractFilePath(Rotinas.ExecutablePath()) + System.IO.Path.DirectorySeparatorChar + Rotinas.formataDate(Rotinas.FORMATO_DHARQUIVO, DateTime.Now) + "_Importacao.log"
				log = StringList()
				nlinha = 0
				while nlinha < memoImportaDir.Buffer.LineCount:
					titer = memoImportaDir.Buffer.GetIterAtLine(nlinha)
					log.Add(titer.Buffer.Text)
					nlinha += 1
				log.SaveToFile(sLog)