from System import *
from Gtk import *
from System.IO import *
from System.Drawing import *
from System.Collections.Generic import *
from HFSGuardaDiretorio.catalogador import *
from HFSGuardaDiretorio.comum import *
from HFSGuardaDiretorio.objetos import *
from HFSGuardaDiretorio.objetosbo import *
from HFSGuardaDiretorio.objetosgui import *

class FrmCompararDiretorio(Gtk.Window):
	def __init__(self, frmPrincipal):
		self.Build()
		self._listaCompara = List[Diretorio]()
		self._frmCompararDiretorioProgresso = FrmCompararDiretorioProgresso(self)
		self._catalogador = frmPrincipal.Catalogador
		Arvore.Instancia.Construir(tvDiretorio1)
		Arvore.Instancia.Construir(tvDiretorio2)
		Tabela.Instancia.Construir(True, tabelaCompara)
		self.CarregarDados()
		self.LimparComparacao()

	def get_PBar(self):
		return self._pb

	PBar = property(fget=get_PBar)

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

	def OnBtnCompararDiretoriosClicked(self, sender, e):
		sCaminhoDir1 = ""
		sCaminhoDir2 = ""
		bSelecionado = False
		tvDiretorio1.Selection.GetSelected(, )
		if tvDiretorio1.Selection.IterIsSelected(iter1):
			store1 = modelo1
			self._catalogador.LerArvoreDiretorio(store1, iter1, self.LabStatus2)
			sCaminhoDir1 = self.LabStatus2.Text
			tvDiretorio2.Selection.GetSelected(, )
			if tvDiretorio2.Selection.IterIsSelected(iter2):
				store2 = modelo2
				self._catalogador.LerArvoreDiretorio(store2, iter2, self.LabStatus2)
				sCaminhoDir2 = self.LabStatus2.Text
				bSelecionado = True
		self.LimparComparacao()
		if bSelecionado:
			self.Comparar(sCaminhoDir1, sCaminhoDir2)
		else:
			Dialogo.mensagemInfo("Diretórios não selecionados!")

	def OnBtnSalvarLogClicked(self, sender, e):
		if self._listaCompara.Count > 0:
			listaLocal = StringList()
			sLog = Rotinas.ExtractFilePath(Rotinas.ExecutablePath()) + System.IO.Path.DirectorySeparatorChar + Rotinas.formataDate(Rotinas.FORMATO_DHARQUIVO, DateTime.Now) + "_Comparacao.log"
			enumerator = listaCompara.GetEnumerator()
			while enumerator.MoveNext():
				diretorio = enumerator.Current
				listaLocal.Add(diretorio.Caminho)
			listaLocal.SaveToFile(sLog)
			Dialogo.mensagemInfo("Log salvo no mesmo diretório do sistema!")

	def OnCmbAba1Changed(self, sender, e):
		GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Watch)
		tvDiretorio1Store = tvDiretorio1.Model
		tvDiretorio1Store.Clear()
		aba = AbaBO.Instancia.pegaAbaPorOrdem(self._catalogador.listaAbas, cmbAba1.Active + 1)
		self._catalogador.CarregarArvore(tvDiretorio1, aba)
		tvDiretorio1.GrabFocus()
		self.LimparComparacao()
		GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Arrow)

	def OnCmbAba2Changed(self, sender, e):
		GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Watch)
		tvDiretorio2Store = tvDiretorio2.Model
		tvDiretorio2Store.Clear()
		aba = AbaBO.Instancia.pegaAbaPorOrdem(self._catalogador.listaAbas, cmbAba2.Active + 1)
		self._catalogador.CarregarArvore(tvDiretorio2, aba)
		tvDiretorio2.GrabFocus()
		self.LimparComparacao()
		GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Arrow)

	def CarregarDados(self):
		enumerator = self._catalogador.listaAbas.GetEnumerator()
		while enumerator.MoveNext():
			aba = enumerator.Current
			cmbAba1.AppendText(aba.Nome)
			cmbAba2.AppendText(aba.Nome)
		cmbAba1.Model.GetIterFirst()
		cmbAba1.SetActiveIter(iter)
		cmbAba2.Model.GetIterFirst()
		cmbAba2.SetActiveIter(iter)

	def LimparComparacao(self):
		pb.Fraction = 0
		tabelaStore = tabelaCompara.Model
		tabelaStore.Clear()
		btnSalvarLog.Sensitive = False
		self.LabStatus2.Text = ""

	def SQLCompara(self, aba1, aba2, caminho1, caminho2):
		sSQL = DiretorioBO.SQL_CONSULTA_ARQUIVO + " WHERE aba=" + aba1.Codigo + " AND caminho LIKE " + Rotinas.QuotedStr(caminho1 + "%") + " AND nome NOT IN (SELECT nome FROM Diretorios " + " WHERE aba=" + aba2.Codigo + " AND caminho LIKE " + Rotinas.QuotedStr(caminho2 + "%") + ")" + " ORDER BY 1, 2, 3"
		return sSQL

	def Comparar(self, sCaminhoDir1, sCaminhoDir2):
		aba1 = AbaBO.Instancia.pegaAbaPorOrdem(self._catalogador.listaAbas, cmbAba1.Active + 1)
		aba2 = AbaBO.Instancia.pegaAbaPorOrdem(self._catalogador.listaAbas, cmbAba2.Active + 1)
		sSQL = self.SQLCompara(aba1, aba2, sCaminhoDir1, sCaminhoDir2)
		self._listaCompara = DiretorioBO.Instancia.carregarDiretorio(sSQL, "consultaarquivo", self._frmCompararDiretorioProgresso)
		if self._listaCompara.Count > 0:
			Tabela.Instancia.Carregar(True, tabelaCompara, self._listaCompara, self._catalogador.listaExtensoes, pb)
			tamLista = self._listaCompara.Count
			self.LabStatus2.Text = tamLista.ToString()
			btnSalvarLog.Sensitive = True
		else:
			Dialogo.mensagemInfo("Nenhuma diferença encontrada!")