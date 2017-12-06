from System import *
from Gtk import *
from HFSGuardaDiretorio.catalogador import *
from HFSGuardaDiretorio.comum import *
from HFSGuardaDiretorio.objetosgui import *
from HFSGuardaDiretorio.objetosbo import *

class FrmPrincipal(Gtk.Window):
	def __init__(self):
		self.Build()
		self.ConstruirPopupMenu()
		notebook1.RemovePage(0)
		self.adicionaTabPage(notebook1, sp, "DISCO1")
		spPesquisa.Position = 250
		sp.Position = 250
		barraStatus1.GetSizeRequest(, )
		barraStatus1.SetSizeRequest(300, self._nAltura)
		Arvore.Instancia.Construir(arvoreFixa)
		arvoreFixa.Selection.Changed += self.OnArvoreFixaSelectionChanged
		Tabela.Instancia.Construir(True, tabelaFixa)
		Tabela.Instancia.Construir(False, tabelaPesquisa)
		self._frmPrincipalProgresso = FrmPrincipalProgresso(self)
		self._catalogador = Catalogador(self)
		Arvore.Instancia.selecionarPrimeiroItem(arvoreFixa)

	def get_Catalogador(self):
		return self._catalogador

	Catalogador = property(fget=get_Catalogador)

	def get_SPPesquisa(self):
		return self._spPesquisa

	SPPesquisa = property(fget=get_SPPesquisa)

	def get_tabControl1(self):
		return self._notebook1

	tabControl1 = property(fget=get_tabControl1)

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

	def get_PBar(self):
		return self._pb

	PBar = property(fget=get_PBar)

	def get_EdtPesquisa(self):
		return self._edtPesquisa

	EdtPesquisa = property(fget=get_EdtPesquisa)

	def get_TabelaPesquisa(self):
		return self._tabelaPesquisa

	TabelaPesquisa = property(fget=get_TabelaPesquisa)

	def get_MenuGravarLogImportacao(self):
		return self._GravarLogDaImportacaoAction

	MenuGravarLogImportacao = property(fget=get_MenuGravarLogImportacao)

	def get_ArvoreFixa(self):
		return self._arvoreFixa

	ArvoreFixa = property(fget=get_ArvoreFixa)

	def adicionaTabPage(self, noteBook, spPanel, nomeAba):
		noteBook.Add(spPanel)
		tabAba = HBox()
		imgAba = Gtk.Image(ExtensaoBO.Instancia.CDOuroGIF)
		labAba = Label()
		labAba.Name = "labAba" + nomeAba
		labAba.LabelProp = nomeAba
		tabAba.Add(imgAba)
		tabAba.Add(labAba)
		noteBook.SetTabLabel(spPanel, tabAba)
		tabAba.ShowAll()
		noteBook.ShowAll()

	def ConstruirPopupMenu(self):
		self._popupMenu = Menu()
		menuInformacoesDiretorioArquivo = MenuItem("Informações do Diretório / Arquivo")
		menuInformacoesDiretorioArquivo.Activated += self.OnInformacoesDiretorioArquivoActivated
		menuInformacoesDiretorioArquivo.Show()
		self._popupMenu.Append(menuInformacoesDiretorioArquivo)
		menuExcluirDiretorioSelecionado = MenuItem("Excluir Diretório Selecionado")
		menuExcluirDiretorioSelecionado.Activated += self.OnExcluirDiretorioSelecionadoActivated
		menuExcluirDiretorioSelecionado.Show()
		self._popupMenu.Append(menuExcluirDiretorioSelecionado)
		menuExpandirDiretorios2 = MenuItem("Expandir Diretórios")
		menuExpandirDiretorios2.Activated += self.OnExpandirDiretorios2Activated
		menuExpandirDiretorios2.Show()
		self._popupMenu.Append(menuExpandirDiretorios2)
		menuColapsarDiretorios2 = MenuItem("Colapsar Diretórios")
		menuColapsarDiretorios2.Activated += self.OnColapsarDiretorios2Activated
		menuColapsarDiretorios2.Show()
		self._popupMenu.Append(menuColapsarDiretorios2)
		separador2 = SeparatorMenuItem()
		separador2.Show()
		self._popupMenu.Append(separador2)
		menuIncluirNovaAba2 = MenuItem("Incluir nova aba")
		menuIncluirNovaAba2.Activated += self.OnIncluirNovaAba2Activated
		menuIncluirNovaAba2.Show()
		self._popupMenu.Append(menuIncluirNovaAba2)
		menuAlterarNomeAbaAtiva2 = MenuItem("Alterar nome da aba ativa")
		menuAlterarNomeAbaAtiva2.Activated += self.OnAlterarNomeAbaAtiva2Activated
		menuAlterarNomeAbaAtiva2.Show()
		self._popupMenu.Append(menuAlterarNomeAbaAtiva2)
		menuExcluirAbaAtiva2 = MenuItem("Excluir aba ativa")
		menuExcluirAbaAtiva2.Activated += self.OnExcluirAbaAtiva2Activated
		menuExcluirAbaAtiva2.Show()
		self._popupMenu.Append(menuExcluirAbaAtiva2)

	def OnDeleteEvent(self, sender, a):
		Rotinas.Desconectar()
		Application.Quit()
		a.RetVal = True

	def OnSobreOCatalogadorActionActivated(self, sender, e):
		frmSobre = FrmSobre()
		frmSobre.Show()

	def OnCadastrarExtensaoDeArquivoActionActivated(self, sender, e):
		frmCadExtensao = FrmCadExtensao(self)
		frmCadExtensao.Show()

	def OnCompararDiretoriosActionActivated(self, sender, e):
		frmCompararDiretorio = FrmCompararDiretorio(self)
		frmCompararDiretorio.Show()

	def OnMostrarOcultarListaItensPesquisadosActionActivated(self, sender, e):
		spPesquisa.Child2.Visible = not spPesquisa.Child2.Visible

	def OnMostrarOcultarArvoreDirAbaAtivaActionActivated(self, sender, e):
		self._catalogador.mostrarOcultarArvore()

	def OnImportarDiretorioActionActivated(self, sender, e):
		self._catalogador.ComecaImportacao(False, self._frmPrincipalProgresso)

	def OnIncluirNovaAbaActionActivated(self, sender, e):
		self._catalogador.IncluirNovaAba()

	def OnImportarDiretoriosViaXMLActionActivated(self, sender, e):
		log = StringList()
		self._catalogador.ImportarArquivo(log, self._frmPrincipalProgresso)

	def OnSQLActionActivated(self, sender, e):
		self._catalogador.ExportarArquivo(TipoExportar.teSQL, self._frmPrincipalProgresso)

	def OnXMLActionActivated(self, sender, e):
		self._catalogador.ExportarArquivo(TipoExportar.teXML, self._frmPrincipalProgresso)

	def OnHTMLActionActivated(self, sender, e):
		self._catalogador.ExportarArquivo(TipoExportar.teHTML, self._frmPrincipalProgresso)

	def OnCSVActionActivated(self, sender, e):
		self._catalogador.ExportarArquivo(TipoExportar.teCSV, self._frmPrincipalProgresso)

	def OnTXTAction1Activated(self, sender, e):
		self._catalogador.ExportarArquivo(TipoExportar.teTXT, self._frmPrincipalProgresso)

	def OnColapsarDiretoriosActionActivated(self, sender, e):
		self._catalogador.getArvoreAtual().CollapseAll()

	def OnExpandirDiretoriosActionActivated(self, sender, e):
		self._catalogador.getArvoreAtual().ExpandAll()

	def OnImportarSubDiretoriosActionActivated(self, sender, e):
		self._catalogador.ComecaImportacao(True, self._frmPrincipalProgresso)

	def OnExcluirAbaAtivaActionActivated(self, sender, e):
		self._catalogador.ExcluirAbaAtiva(self._frmPrincipalProgresso)

	def OnAlterarNomeDaAbaAtivaActionActivated(self, sender, e):
		self._catalogador.AlterarNomeAbaAtiva(self._frmPrincipalProgresso)

	def OnInformacoesDiretorioArquivoActivated(self, sender, e):
		self._catalogador.InformacoesDiretorioArquivo()

	def OnExcluirDiretorioSelecionadoActivated(self, sender, e):
		self._catalogador.ExcluirDiretorioSelecionado(self._frmPrincipalProgresso)

	def OnExpandirDiretorios2Activated(self, sender, e):
		self.OnExpandirDiretoriosActionActivated(sender, e)

	def OnColapsarDiretorios2Activated(self, sender, e):
		self.OnColapsarDiretoriosActionActivated(sender, e)

	def OnIncluirNovaAba2Activated(self, sender, e):
		self.OnIncluirNovaAbaActionActivated(sender, e)

	def OnAlterarNomeAbaAtiva2Activated(self, sender, e):
		self.OnAlterarNomeDaAbaAtivaActionActivated(sender, e)

	def OnExcluirAbaAtiva2Activated(self, sender, e):
		self.OnExcluirAbaAtivaActionActivated(sender, e)

	def OnBtnImportarDiretorioClicked(self, sender, e):
		self.OnImportarDiretorioActionActivated(sender, e)

	def OnBtnPesquisaClicked(self, sender, e):
		self._catalogador.Pesquisar()

	def OnNotebook1SelectPage(self, o, args):
		self._catalogador.tabPanelMudou()

	def OnTabelaFixaButtonReleaseEvent(self, o, args):
		if args.Event.Button == 3:
			self._popupMenu.Popup(None, None, None, args.Event.Button, Global.CurrentEventTime)

	#if (args.Event.Button == 1) {
	#if (((Gdk.EventButton)args.Event).Type == Gdk.EventType.TwoButtonPress) {
	#}
	def OnArvoreFixaButtonReleaseEvent(self, o, args):
		if args.Event.Button == 3:
			self._popupMenu.Popup(None, None, None, args.Event.Button, Global.CurrentEventTime)

	def OnTabelaPesquisaButtonReleaseEvent(self, o, args):
		if args.Event.Button == 1:
			lvPesquisa = o
			lvPesquisa.Selection.GetSelected()
			if lvPesquisa.Selection.IterIsSelected(iter):
				storePesquisa = lvPesquisa.Model
				nome = storePesquisa.GetValue(iter, 1).ToString()
				caminho = storePesquisa.GetValue(iter, 6).ToString()
				nomeAba = storePesquisa.GetValue(iter, 7).ToString()
				self._catalogador.EncontrarItemLista(nomeAba, nome, caminho)

	def OnTabelaFixaRowActivated(self, o, args):
		lvTabela = o
		lvTabela.Selection.GetSelected(, )
		if lvTabela.Selection.IterIsSelected(iter):
			#ListStore modelo = (ListStore)lvTabela.Model;
			nome = modelo.GetValue(iter, 1).ToString()
			tipo = modelo.GetValue(iter, 3).ToString()
			self._catalogador.DuploCliqueLista(nome, tipo)

	def OnArvoreFixaSelectionChanged(self, o, args):
		selecao = o
		if selecao.GetSelected():
			lvTabela = self._catalogador.getTabelaAtual()
			arvore = self._catalogador.getArvoreAtual()
			self._catalogador.ListarArquivos(lvTabela, arvore, iter)

	def OnArvoreFixaRowExpanded(self, o, args):
		arvore = o
		store = arvore.Model
		store.SetValue(args.Iter, 0, ExtensaoBO.Instancia.DirAbertoGIF)

	def OnArvoreFixaRowCollapsed(self, o, args):
		arvore = o
		store = arvore.Model
		store.SetValue(args.Iter, 0, ExtensaoBO.Instancia.DiretorioGIF)