# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 07/07/2015
# * Time: 11:02
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from System.IO import *
from System.Drawing import *
from System.Collections.Generic import *
from Gtk import *
from HFSGuardaDiretorio.comum import *
from HFSGuardaDiretorio.objetos import *
from HFSGuardaDiretorio.objetosbo import *
from HFSGuardaDiretorio.objetosdao import *
from HFSGuardaDiretorio.gui import *
from HFSGuardaDiretorio.objetosgui import *

class Catalogador(ICatalogador):
	""" <summary>
	 Description of Catalogador.
	 </summary>
	""" #Logger.getLogger(Rotinas.HFSGUARDADIR);
	def __init__(self, form):
		self._CONSULTA_DIR_PAI = "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, " + "atributos, caminho, nomeaba, nomepai, caminhopai " + "from consultadirpai " + "order by 1,2,3,4"
		self._CONSULTA_DIR_FILHO = "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, " + "atributos, caminho, nomeaba, nomepai, caminhopai " + "from consultadirfilho " + "order by 1,2,3,4"
		self._CONSULTA_ARQUIVO = "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, " + "atributos, caminho, nomeaba, nomepai, caminhopai " + "from consultaarquivo " + "order by tipo desc, ordem"
		self._log = ArquivoLog()
		self._form = form
		self._diretorioOrdem = DiretorioOrdem()
		self._listaAbas = List[Aba]()
		self._listaExtensoes = List[Extensao]()
		self._listaDiretorioPai = List[Diretorio]()
		self._listaDiretorioFilho = List[Diretorio]()
		self._listaArquivos = List[Diretorio]()
		form.SPPesquisa.Child2.Visible = False
		form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Watch)
		frmSplash = FrmSplash()
		frmSplashProgresso = FrmSplashProgresso(frmSplash)
		frmSplash.Show()
		self.CarregarDados(frmSplashProgresso, True, True)
		self.CarregarAbas()
		self.tabPanelMudou()
		frmSplash.Hide()
		frmSplash.Destroy()
		form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Arrow)

	def iniciarSistema():
		sBanco = Rotinas.ExtractFilePath(Rotinas.ExecutablePath()) + Path.DirectorySeparatorChar + "GuardaDir.db"
		cp = ConexaoParams()
		cp.Nome = sBanco
		if not Rotinas.FileExists(sBanco):
			Rotinas.Conectar(cp)
			AbaBO.Instancia.criarTabelaAbas()
			aba = Aba(1, "DISCO1", 0)
			AbaBO.Instancia.incluirAba(aba)
			ExtensaoBO.Instancia.criarTabelaExtensoes()
			DiretorioBO.Instancia.criarTabelaDiretorios()
			VisaoDAO.Instancia.criarVisao("consultadirpai")
			VisaoDAO.Instancia.criarVisao("consultadirfilho")
			VisaoDAO.Instancia.criarVisao("consultaarquivo")
		else:
			Rotinas.Conectar(cp)

	iniciarSistema = staticmethod(iniciarSistema)

	def CarregarDados(self, pLog, bExtensao, bDiretorio):
		self._listaAbas = AbaBO.Instancia.carregarAba(pLog)
		if bExtensao:
			self._listaExtensoes = ExtensaoBO.Instancia.carregarExtensao(pLog)
		if bDiretorio:
			self._listaDiretorioPai = DiretorioBO.Instancia.carregarDiretorio(self._CONSULTA_DIR_PAI, "consultadirpai", pLog)
			self._listaDiretorioFilho = DiretorioBO.Instancia.carregarDiretorio(self._CONSULTA_DIR_FILHO, "consultadirfilho", pLog)
			self._listaArquivos = DiretorioBO.Instancia.carregarDiretorio(self._CONSULTA_ARQUIVO, "consultaarquivo", pLog)

	def ExcluirDados(self, aba, sCaminho):
		DiretorioBO.Instancia.excluirListaDiretorio(self._listaDiretorioPai, aba, sCaminho)
		DiretorioBO.Instancia.excluirListaDiretorio(self._listaDiretorioFilho, aba, sCaminho)
		DiretorioBO.Instancia.excluirListaDiretorio(self._listaArquivos, aba, sCaminho)

	def AddItemArvore(self, storeArvore, diretorio, Nivel, node1):
		if Nivel == 0:
			node1 = storeArvore.AppendValues(ExtensaoBO.Instancia.DiretorioGIF, diretorio.Nome)
		listaFilhos = DiretorioBO.Instancia.itensFilhos(self._listaDiretorioFilho, diretorio.Aba.Codigo, diretorio.Ordem, diretorio.Codigo)
		enumerator = listaFilhos.GetEnumerator()
		while enumerator.MoveNext():
			filho = enumerator.Current
			node2 = storeArvore.AppendValues(node1, ExtensaoBO.Instancia.DiretorioGIF, filho.Nome)
			self.AddItemArvore(storeArvore, filho, Nivel += 1, node2)

	def IncluirNovaAba(self):
		sAba = Dialogo.entrada("Digite o Nome da Nova Aba?")
		if (sAba != None) and (sAba.Trim().Length > 0):
			aba = Aba()
			aba.Codigo = AbaBO.Instancia.retMaxCodAba(self._listaAbas)
			aba.Nome = Rotinas.SubString(sAba, 1, 10)
			aba.Ordem = self._listaAbas.Count + 1
			AbaBO.Instancia.incluirAba(aba)
			self.IncluirNovaAba(aba.Nome)
			self._listaAbas.Add(aba)

	def AlterarNomeAbaAtiva(self, pLog):
		aba = self.getAbaAtual()
		sAba = Dialogo.entrada("Digite o Novo Nome da Aba Ativa?", aba.Nome)
		if (sAba != None) and (sAba.Trim().Length > 0):
			aba.Nome = Rotinas.SubString(sAba, 1, 10)
			AbaBO.Instancia.alterarAba(aba)
			self._form.tabControl1.SetTabLabelText(self._form.tabControl1.GetNthPage(self._form.tabControl1.Page), sAba)
			self.CarregarDados(pLog, False, True)

	def ExcluirAbaAtiva(self, pLog):
		indiceSel = self._form.tabControl1.Page
		if indiceSel > 0:
			res = Dialogo.confirma("Tem Certeza, que você deseja excluir esta aba, \n" + "isto implicará na destruição de todos os seus itens catalogados?")
			if res:
				self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Watch)
				aba = self.getAbaAtual()
				self.ExcluirDados(aba, "")
				AbaBO.Instancia.excluirAba(aba)
				self._form.tabControl1.RemovePage(indiceSel)
				self.CarregarDados(pLog, False, False)
				self._form.LabStatus2.Text = ""
				self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Arrow)
		else:
			Dialogo.mensagemErro("A primeira Aba não pode ser excluída!")

	def IncluirNovaAba(self, nomeAba):
		spPanel = HPaned()
		spPanel.CanFocus = True
		spPanel.Name = "spPanel" + nomeAba
		spPanel.Position = 250
		scrollArvore = ScrolledWindow()
		scrollArvore.Name = "scrollArvore" + nomeAba
		scrollArvore.ShadowType = ((1))
		arvore = TreeView()
		arvore.CanFocus = True
		arvore.Name = "arvore" + nomeAba
		arvore.Selection.Changed += self._form.OnArvoreFixaSelectionChanged
		arvore.RowExpanded += self._form.OnArvoreFixaRowExpanded
		arvore.RowCollapsed += self._form.OnArvoreFixaRowCollapsed
		arvore.ButtonReleaseEvent += self._form.OnArvoreFixaButtonReleaseEvent
		Arvore.Instancia.Construir(arvore)
		scrollArvore.Add(arvore)
		spPanel.Add(scrollArvore)
		w9 = ((spPanel[scrollArvore]))
		w9.Resize = False
		scrollTabela = ScrolledWindow()
		scrollTabela.Name = "scrollTabela" + nomeAba
		scrollTabela.ShadowType = ((1))
		tabela = NodeView()
		tabela.CanFocus = True
		tabela.Name = "tabela" + nomeAba
		tabela.ButtonReleaseEvent += self._form.OnTabelaFixaButtonReleaseEvent
		tabela.RowActivated += self._form.OnTabelaFixaRowActivated
		Tabela.Instancia.Construir(True, tabela)
		scrollTabela.Add(tabela)
		spPanel.Add(scrollTabela)
		self._form.adicionaTabPage(self._form.tabControl1, spPanel, nomeAba)

	def getArvoreAtual(self):
		return self.getArvoreAtual(self._form.tabControl1.Page)

	def getArvoreAtual(self, nIndicePagina):
		tabPage = self._form.tabControl1.GetNthPage(nIndicePagina)
		scrollArvore = tabPage.Child1
		arvore = scrollArvore.Child
		return arvore

	def getSplitAtual(self):
		nIndicePagina = self._form.tabControl1.Page
		tabPage = self._form.tabControl1.GetNthPage(nIndicePagina)
		return tabPage

	def getTabelaAtual(self):
		nIndicePagina = self._form.tabControl1.Page
		tabPage = self._form.tabControl1.GetNthPage(nIndicePagina)
		scrollTabela = tabPage.Child2
		tabela = scrollTabela.Child
		return tabela

	def mostrarOcultarArvore(self):
		self.getSplitAtual().Child1.Visible = not self.getSplitAtual().Child1.Visible

	def CarregarArvore(self, tvAba, aba):
		nodeRaiz = TreeIter()
		storeArvore = tvAba.Model
		enumerator = listaDiretorioPai.GetEnumerator()
		while enumerator.MoveNext():
			diretorio = enumerator.Current
			if diretorio.Aba.Codigo == aba.Codigo:
				self.AddItemArvore(storeArvore, diretorio, 0, nodeRaiz)

	def CarregarAbas(self):
		nMaximum = self._listaAbas.Count - 1
		self._form.PBar.Fraction = 0
		i = 0
		while i < self._listaAbas.Count:
			if i > 0:
				self.IncluirNovaAba(self._listaAbas[i].Nome)
			tvAba = self.getArvoreAtual(i)
			self.CarregarArvore(tvAba, self._listaAbas[i])
			self._form.PBar.Fraction = Rotinas.calculaProgresso(nMaximum, i)
			i += 1

	def getAbaAtual(self):
		return AbaBO.Instancia.pegaAbaPorOrdem(self._listaAbas, self._form.tabControl1.Page + 1)

	def CarregarArquivosLista(self, bLista1, lvArquivos, sCaminho):
		listaLocal = List[Diretorio]()
		storeArquivos = lvArquivos.Model
		storeArquivos.Clear()
		if bLista1:
			sPaiCaminho = sCaminho
			if not Rotinas.SubString(sCaminho, sCaminho.Length, 1).Equals(Rotinas.BARRA_INVERTIDA):
				sCaminho = sCaminho + Rotinas.BARRA_INVERTIDA
			nAba = self.getAbaAtual().Codigo
			enumerator = listaArquivos.GetEnumerator()
			while enumerator.MoveNext():
				diretorio = enumerator.Current
				if diretorio.Aba.Codigo == nAba:
					if diretorio.CaminhoPai.Equals(sPaiCaminho):
						if Rotinas.StartsStr(sCaminho, diretorio.Caminho):
							listaLocal.Add(diretorio)
		else:
			enumerator = listaArquivos.GetEnumerator()
			while enumerator.MoveNext():
				diretorio = enumerator.Current
				if Rotinas.ContainsStr(diretorio.Caminho.ToUpper(), sCaminho.ToUpper()):
					listaLocal.Add(diretorio)
		Tabela.Instancia.Carregar(bLista1, lvArquivos, listaLocal, self._listaExtensoes, self._form.PBar)

	def TamTotalDiretorio(self, sCaminho):
		conta = 0
		soma = 0
		enumerator = listaArquivos.GetEnumerator()
		while enumerator.MoveNext():
			diretorio = enumerator.Current
			nAba = self.getAbaAtual().Codigo
			if diretorio.Aba.Codigo == nAba:
				if diretorio.Tipo.Codigo != 'D':
					if sCaminho.Trim().Length > 0:
						if Rotinas.StartsStr(sCaminho, diretorio.Caminho):
							conta += 1
							tam = diretorio.Tamanho
							soma = soma + tam
					else:
						conta += 1
						tam = diretorio.Tamanho
						soma = soma + tam
		self._form.LabStatus1.Text = "Quantidade Total: " + Rotinas.FormatLong("0000", conta) + ", Tamanho Total: " + DiretorioBO.Instancia.MontaTamanho(soma)

	def testaSeparadorArquivo(self, sDir):
		sDir = Rotinas.SubString(sDir, sDir.Length, 1)
		if sDir.Equals(Rotinas.BARRA_INVERTIDA) or sDir.Equals(Rotinas.BARRA_NORMAL) or sDir.Equals(Rotinas.BARRA_INVERTIDA):
			return True
		else:
			return False

	def montaCaminho(self, sCaminho, bRemover):
		#sCaminho = NO_RAIZ + Rotinas.BARRA_INVERTIDA + sCaminho;
		sl = StringList(sCaminho, Rotinas.BARRA_INVERTIDA[0])
		if sl[sl.Count - 1].Trim().Length == 0:
			sl.RemoveAt(sl.Count - 1)
		if bRemover:
			sl.RemoveAt(sl.Count - 1)
		return sl

	def Pesquisar(self):
		arvoreLocal = self.getArvoreAtual()
		arvoreStore = arvoreLocal.Model
		tabelaStore = self._form.TabelaPesquisa.Model
		iter = TreeIter()
		if arvoreStore.IterNChildren() > 0:
			if self._form.EdtPesquisa.Text.Length >= 2:
				self._form.SPPesquisa.Child2.Visible = True
				self.CarregarArquivosLista(False, self._form.TabelaPesquisa, self._form.EdtPesquisa.Text)
				if tabelaStore.GetIterFirst():
					self._form.TabelaPesquisa.Selection.SelectIter(iter)
			else:
				self._form.SPPesquisa.Child2.Visible = False
				tabelaStore.Clear()
				Dialogo.mensagemInfo("A pesquisa só é feita com pelo menos 2 caracteres!")

	def PesquisarArvoreDiretorio(self, sCaminho, aba):
		self._form.tabControl1.Page = aba.Ordem - 1
		arvore = self.getArvoreAtual()
		arvoreStore = arvore.Model
		sl = self.montaCaminho(sCaminho, False) # Verifica Diretorio
		path = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
		if path == None:
			sl.Insert(1, sl[1] + Rotinas.BARRA_INVERTIDA)
			path = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
			if path == None:
				sl.Clear()
				sl = self.montaCaminho(sCaminho, True) # Verifica Arquivo
				path = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
				if path == None:
					sl.Insert(1, sl[1] + Rotinas.BARRA_INVERTIDA)
					path = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
		arvore.ExpandToPath(path)
		arvore.Selection.SelectPath(path)

	def LerArvoreDiretorio(self, arvoreStore, iter, barraStatus):
		sCaminho = arvoreStore.GetValue(iter, 1)
		arvoreStore.IterParent(, iter)
		if arvoreStore.IterIsValid(iterAnterior):
			while arvoreStore.IterParent(, iterAnterior):
				sValorAnterior = arvoreStore.GetValue(iterAnterior, 1)
				if Rotinas.SubString(sValorAnterior, sValorAnterior.Length, 1) == Rotinas.BARRA_INVERTIDA:
					sSep = ""
				else:
					sSep = Rotinas.BARRA_INVERTIDA
				sCaminho = sValorAnterior + sSep + sCaminho
		self._form.LabStatus2.Text = sCaminho

	def ListarArquivos(self, lvTabela, arvore, iter):
		arvoreStore = arvore.Model
		if arvore.Selection.IterIsSelected(iter):
			self.LerArvoreDiretorio(arvoreStore, iter, self._form.LabStatus2)
			self.CarregarArquivosLista(True, lvTabela, self._form.LabStatus2.Text)
			self.TamTotalDiretorio(self._form.LabStatus2.Text)

	def tabPanelMudou(self):
		arvore = self.getArvoreAtual()
		arvoreStore = arvore.Model
		lvTabela = self.getTabelaAtual()
		if arvoreStore.IterNChildren() > 0:
			if arvoreStore.GetIterFirst():
				self.ListarArquivos(lvTabela, arvore, iter)

	def getAbaSelecionada(self):
		return self.getAbaAtual()

	def DuploCliqueLista(self, nome, tipo):
		if tipo.Equals("Diretório"):
			self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Watch)
			sCaminho = self._form.LabStatus2.Text
			if self.testaSeparadorArquivo(sCaminho):
				sCaminho += nome
			else:
				sCaminho += Rotinas.BARRA_INVERTIDA + nome
			self.PesquisarArvoreDiretorio(sCaminho, self.getAbaAtual())
			self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Arrow)

	def EncontrarItemLista(self, nomeAba, nome, caminho):
		self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Watch)
		aba = AbaBO.Instancia.pegaAbaPorNome(self._listaAbas, nomeAba)
		self.PesquisarArvoreDiretorio(caminho, aba)
		tabela = self.getTabelaAtual()
		path = Tabela.Instancia.encontrarCaminhoPorNome(tabela, nome)
		if path != None:
			tabela.Selection.SelectPath(path)
		self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Arrow)

	def verificaNomeDiretorio(self, sCaminho, sRotuloRaiz):
		sRotuloRaiz.Rotulo = DiretorioBO.Instancia.removerDrive(sCaminho)
		if sRotuloRaiz.Rotulo.Length == 0:
			sRotuloRaiz.Rotulo = Dialogo.entrada("Este diretório não possui um nome.\nDigite o nome do diretório!")
			if (sRotuloRaiz.Rotulo != None) and (sRotuloRaiz.Rotulo.Trim().Length > 0):
				sRotuloRaiz.Rotulo = sRotuloRaiz.Rotulo.Trim()
				if sRotuloRaiz.Rotulo.Length > 0:
					return 1
				else:
					Dialogo.mensagemInfo("Nenhum nome de diretório informado!")
					return 0
			else:
				return 0
		elif Rotinas.Pos(Rotinas.BARRA_INVERTIDA, sRotuloRaiz.Rotulo) > 0:
			sRotuloRaiz.Rotulo = Rotinas.SubString(sRotuloRaiz.Rotulo, Rotinas.LastDelimiter(Rotinas.BARRA_INVERTIDA, sRotuloRaiz.Rotulo) + 1, sRotuloRaiz.Rotulo.Length)
			return 2
		else:
			return 3

	def ExportarArquivo(self, tipo, pLog):
		sExtensao = ""
		if tipo == TipoExportar.teTXT:
			sExtensao = "txt"
		elif tipo == TipoExportar.teCSV:
			sExtensao = "csv"
		elif tipo == TipoExportar.teHTML:
			sExtensao = "html"
		elif tipo == TipoExportar.teXML:
			sExtensao = "xml"
		elif tipo == TipoExportar.teSQL:
			sExtensao = "sql"
		aba = self.getAbaAtual()
		sDiretorio = Rotinas.ExtractFilePath(Rotinas.ExecutablePath())
		sArquivo = aba.Nome + '.' + sExtensao
		if EscolhaArquivo.salvarArquivo(EscolhaArquivo.FILTRO_EXPORTAR, sDiretorio, sArquivo):
			arquivo = FileInfo(EscolhaArquivo.NomeArquivo)
			if not arquivo.Exists:
				self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Watch)
				DiretorioBO.Instancia.exportarDiretorio(tipo, self.getAbaAtual(), arquivo.FullName, pLog)
				self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Arrow)
				Dialogo.mensagemErro("Exportação realizada com sucesso!")

	def ExcluirDiretorioSelecionado(self, pLog):
		arvore = self.getArvoreAtual()
		arvoreStore = arvore.Model
		arvore.Selection.GetSelected()
		if arvore.Selection.IterIsSelected(iter):
			tabela = self.getTabelaAtual()
			tabelaStore = tabela.Model
			res = Dialogo.confirma("Tem Certeza, que você deseja excluir este diretório, isto implicará na destruição de todos os seus items catalogados?")
			if res:
				self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Watch)
				valor = arvoreStore.GetValue(iter, 1)
				DiretorioBO.Instancia.excluirDiretorio(self.getAbaAtual(), valor)
				self.ExcluirDados(self.getAbaAtual(), valor)
				arvoreStore.Remove()
				tabelaStore.Clear()
				self.CarregarDados(pLog, False, False)
				self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Arrow)

	def ImportarArquivo(self, log, pLog):
		if EscolhaArquivo.abrirArquivo(EscolhaArquivo.FILTRO_XML):
			arquivo = FileInfo(EscolhaArquivo.NomeArquivo)
			if arquivo.Exists:
				self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Watch)
				nResultado = DiretorioBO.Instancia.importarDiretorioViaXML(self.getAbaAtual(), arquivo.FullName, self._listaDiretorioPai, pLog)
				if nResultado == -1:
					Dialogo.mensagemErro("Importação não realizada!")
				elif nResultado == -2:
					Dialogo.mensagemErro("Este diretório já existe no catálogo!")
				else:
					self.FinalizaImportacao(pLog)
				self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Arrow)

	def ImportarDiretorios(self, listaCaminho, bSubDiretorio, frmImportarDiretorio):
		sRotuloRaiz = RotuloRaiz()
		importar = Importar()
		nAba = self.getAbaAtual().Codigo
		nCodDirRaiz = DiretorioBO.Instancia.retMaxCodDir(nAba, self._listaDiretorioPai)
		enumerator = listaCaminho.GetEnumerator()
		while enumerator.MoveNext():
			sCaminho = enumerator.Current
			nRotuloRaiz = self.verificaNomeDiretorio(sCaminho, sRotuloRaiz)
			if nRotuloRaiz > 0:
				importar = Importar()
				importar.Aba = nAba
				importar.CodDirRaiz = nCodDirRaiz
				importar.RotuloRaiz = sRotuloRaiz.Rotulo
				if nRotuloRaiz == 1:
					importar.NomeDirRaiz = sRotuloRaiz.Rotulo
				elif nRotuloRaiz == 2:
					sCaminhoSemDrive = DiretorioBO.Instancia.removerDrive(sCaminho)
					importar.NomeDirRaiz = Rotinas.SubString(sCaminhoSemDrive, 1, Rotinas.LastDelimiter(Rotinas.BARRA_INVERTIDA, sCaminhoSemDrive) - 1)
				elif nRotuloRaiz == 3:
					importar.NomeDirRaiz = ""
				importar.Caminho = sCaminho
				frmImportarDiretorio.listaImportar.Add(importar)
				nCodDirRaiz += 1
		frmImportarDiretorio.bSubDiretorio = bSubDiretorio
		if bSubDiretorio:
			frmImportarDiretorio.Show()
			frmImportarDiretorio.Importar()
			frmImportarDiretorio.Hide()
			frmImportarDiretorio.Destroy()
			return True
		else:
			if not DiretorioBO.Instancia.verificaCodDir(importar.Aba, importar.RotuloRaiz, self._listaDiretorioPai):
				frmImportarDiretorio.Show()
				frmImportarDiretorio.Importar()
				frmImportarDiretorio.Hide()
				frmImportarDiretorio.Destroy()
				return True
			else:
				Dialogo.mensagemErro("Este diretório já existe no catálogo!")
				return False

	def FinalizaImportacao(self, pLog):
		self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Watch)
		self.CarregarDados(pLog, True, True)
		tvAba = self.getArvoreAtual()
		self.CarregarArvore(tvAba, self.getAbaAtual())
		self.tabPanelMudou()
		self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Arrow)
		Dialogo.mensagemInfo("Importação do(s) diretório(s) realizada com sucesso!")

	def ComecaImportacao(self, bSubDiretorios, pLog):
		if EscolhaArquivo.abrirDiretorio():
			arquivo = FileInfo(EscolhaArquivo.NomeArquivo)
			if arquivo.Directory.Exists:
				self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Watch)
				sCaminho = arquivo.FullName
				frmImportarDiretorio = FrmImportarDiretorio(self._form)
				listaCaminho = StringList()
				if bSubDiretorios:
					DiretorioBO.Instancia.carregarSubDiretorios(sCaminho, listaCaminho)
				else:
					listaCaminho.Add(sCaminho)
				if self.ImportarDiretorios(listaCaminho, bSubDiretorios, frmImportarDiretorio):
					self.FinalizaImportacao(pLog)
				self._form.GdkWindow.Cursor = Gdk.Cursor(Gdk.CursorType.Arrow)

	def InformacoesDiretorioArquivo(self):
		tabela = self.getTabelaAtual()
		tabela.Selection.GetSelected()
		if tabela.Selection.IterIsSelected(iter):
			frmInfo = FrmInfoDiretorio()
			aba = self.getAbaSelecionada()
			dir = Tabela.Instancia.getLinhaSelecionada(tabela, False)
			dir.Aba.Nome = aba.Nome
			frmInfo.setDiretorio(dir)
			frmInfo.Show()