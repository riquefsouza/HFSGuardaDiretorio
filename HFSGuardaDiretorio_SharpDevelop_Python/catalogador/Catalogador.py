import System.IO
import System.Drawing
import System.Windows.Forms
import System.Collections.Generic

from System.IO import *
from System.Drawing import *
from System.Windows.Forms import *
from System.Collections.Generic import *

from comum import ICatalogador
from comum import Rotinas

def iniciarSistema():
	sBanco = Rotinas().ExtractFilePath(Application.ExecutablePath) + Path.DirectorySeparatorChar + "GuardaDir.db"
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

class Catalogador(ICatalogador.ICatalogador):
	
	def __init__(self, form):
		self._CONSULTA_DIR_PAI = "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, " + "atributos, caminho, nomeaba, nomepai, caminhopai " + "from consultadirpai " + "order by 1,2,3,4"
		self._CONSULTA_DIR_FILHO = "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, " + "atributos, caminho, nomeaba, nomepai, caminhopai " + "from consultadirfilho " + "order by 1,2,3,4"
		self._CONSULTA_ARQUIVO = "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, " + "atributos, caminho, nomeaba, nomepai, caminhopai " + "from consultaarquivo " + "order by tipo desc, ordem"
		self._NO_RAIZ = "Raiz"
		self._log = ArquivoLog()
		self._form = form
		self._diretorioOrdem = DiretorioOrdem()
		self._listaAbas = List[Aba]()
		self._listaExtensoes = List[Extensao]()
		self._listaDiretorioPai = List[Diretorio]()
		self._listaDiretorioFilho = List[Diretorio]()
		self._listaArquivos = List[Diretorio]()
		form.spPesquisa.Panel2Collapsed = True
		form.Cursor = Cursors.WaitCursor
		frmSplash = FrmSplash()
		frmSplashProgresso = FrmSplashProgresso(frmSplash)
		frmSplash.Show()
		frmSplash.Update()
		self.CarregarDados(frmSplashProgresso, True, True)
		self.CarregarAbas()
		self.tabPanelMudou()
		frmSplash.Close()
		frmSplash.Dispose()
		form.Cursor = Cursors.Default

	#iniciarSistema = staticmethod(iniciarSistema)

	def CarregarDados(self, pLog, bExtensao, bDiretorio):
		self._listaAbas = AbaBO.Instancia.carregarAba(pLog)
		if bExtensao:
			self._listaExtensoes = ExtensaoBO.Instancia.carregarExtensao(pLog)
			ExtensaoBO.Instancia.carregarExtensoes(self._listaExtensoes, self._form.imageList1, self._form.imageList2)
		if bDiretorio:
			self._listaDiretorioPai = DiretorioBO.Instancia.carregarDiretorio(self._CONSULTA_DIR_PAI, "consultadirpai", pLog)
			self._listaDiretorioFilho = DiretorioBO.Instancia.carregarDiretorio(self._CONSULTA_DIR_FILHO, "consultadirfilho", pLog)
			self._listaArquivos = DiretorioBO.Instancia.carregarDiretorio(self._CONSULTA_ARQUIVO, "consultaarquivo", pLog)

	def ExcluirDados(self, aba, sCaminho):
		DiretorioBO.Instancia.excluirListaDiretorio(self._listaDiretorioPai, aba, sCaminho)
		DiretorioBO.Instancia.excluirListaDiretorio(self._listaDiretorioFilho, aba, sCaminho)
		DiretorioBO.Instancia.excluirListaDiretorio(self._listaArquivos, aba, sCaminho)

	def AddItemArvore(self, tv, diretorio, Nivel, node1):
		if Nivel == 0:
			node1 = tv.Nodes.Add(diretorio.Nome)
		listaFilhos = DiretorioBO.Instancia.itensFilhos(self._listaDiretorioFilho, diretorio.Aba.Codigo, diretorio.Ordem, diretorio.Codigo)
		enumerator = listaFilhos.GetEnumerator()
		while enumerator.MoveNext():
			filho = enumerator.Current
			node2 = node1.Nodes.Add(filho.Nome)
			Nivel += 1
			self.AddItemArvore(tv, filho, Nivel, node2)

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
			self._form.tabControl1.SelectedTab.Text = sAba
			self.CarregarDados(pLog, False, True)

	def ExcluirAbaAtiva(self, pLog):
		indiceSel = self._form.tabControl1.SelectedIndex
		if indiceSel > 0:
			res = Dialogo.confirma("Tem Certeza, que você deseja excluir esta aba, \n" + "isto implicará na destruição de todos os seus itens catalogados?")
			if res:
				self._form.Cursor = Cursors.WaitCursor
				aba = self.getAbaAtual()
				self.ExcluirDados(aba, "")
				AbaBO.Instancia.excluirAba(aba)
				self._form.tabControl1.Controls.RemoveAt(indiceSel)
				self.CarregarDados(pLog, False, False)
				self._form.barraStatus.Items[1].Text = ""
				self._form.Cursor = Cursors.Default
		else:
			Dialogo.mensagemErro("A primeira Aba não pode ser excluída!")

	def IncluirNovaAba(self, nomeAba):
		tabPage1 = TabPage()
		sp = SplitContainer()
		arvore = TreeView()
		tabela = ListView()
		columnHeader10 = ColumnHeader()
		columnHeader11 = ColumnHeader()
		columnHeader12 = ColumnHeader()
		columnHeader13 = ColumnHeader()
		columnHeader14 = ColumnHeader()
		columnHeader15 = ColumnHeader()
		# 
		# tabPage1
		# 
		tabPage1.Controls.Add(sp)
		tabPage1.ImageIndex = 0
		tabPage1.Location = Point(4, 23)
		tabPage1.Name = "tabPage" + nomeAba
		tabPage1.Padding = Padding(3)
		tabPage1.Size = Size(876, 267)
		tabPage1.TabIndex = 0
		tabPage1.Text = nomeAba
		tabPage1.UseVisualStyleBackColor = True
		# 
		# sp
		# 
		sp.Dock = DockStyle.Fill
		sp.Location = Point(3, 3)
		sp.Name = "sp" + nomeAba
		# 
		# sp.Panel1
		# 
		sp.Panel1.Controls.Add(arvore)
		# 
		# sp.Panel2
		# 
		sp.Panel2.Controls.Add(tabela)
		sp.Size = Size(870, 261)
		sp.SplitterDistance = 290
		sp.TabIndex = 0
		# 
		# arvore
		# 
		arvore.Dock = DockStyle.Fill
		arvore.ImageIndex = 0
		arvore.ImageList = self._form.imageList1
		arvore.Location = Point(0, 0)
		arvore.Name = "arvore" + nomeAba
		arvore.SelectedImageIndex = 1
		arvore.Size = Size(290, 261)
		arvore.TabIndex = 0
		arvore.AfterSelect += self._form.TvFixaAfterSelect
		# 
		# tabela
		# 
		tabela.Columns.AddRange(System.Array[ColumnHeader]([columnHeader10, columnHeader11, columnHeader12, columnHeader13, columnHeader14, columnHeader15]))
		tabela.Dock = DockStyle.Fill
		tabela.FullRowSelect = True
		tabela.GridLines = True
		tabela.LargeImageList = self._form.imageList2
		tabela.Location = Point(0, 0)
		tabela.MultiSelect = False
		tabela.Name = "tabela" + nomeAba
		tabela.Size = Size(576, 261)
		tabela.SmallImageList = self._form.imageList1
		tabela.TabIndex = 1
		tabela.UseCompatibleStateImageBehavior = False
		tabela.View = View.Details
		tabela.ColumnClick += self._form.LvFixaColumnClick
		tabela.DoubleClick += self._form.LvFixaDoubleClick
		# 
		# columnHeader10
		# 
		columnHeader10.Text = "Nome"
		columnHeader10.Width = 300
		# 
		# columnHeader11
		# 
		columnHeader11.Text = "Tamanho"
		columnHeader11.Width = 100
		# 
		# columnHeader12
		# 
		columnHeader12.Text = "Tipo"
		columnHeader12.Width = 70
		# 
		# columnHeader13
		# 
		columnHeader13.Text = "Modificado"
		columnHeader13.Width = 120
		# 
		# columnHeader14
		# 
		columnHeader14.Text = "Atributos"
		columnHeader14.Width = 90
		# 
		# columnHeader15
		# 
		columnHeader15.Text = "Caminho"
		columnHeader15.Width = 300
		self._form.tabControl1.Controls.Add(tabPage1)

	def getArvoreAtual(self):
		return self.getArvoreAtual(self._form.tabControl1.SelectedIndex)

	def getArvoreAtual(self, nIndicePagina):
		tabPage = self._form.tabControl1.TabPages[nIndicePagina]
		split = tabPage.Controls[0]
		arvore = split.Panel1.Controls[0]
		return arvore

	def getSplitAtual(self):
		tabPage = self._form.tabControl1.SelectedTab
		split = tabPage.Controls[0]
		return split

	def getTabelaAtual(self):
		tabPage = self._form.tabControl1.SelectedTab
		split = tabPage.Controls[0]
		tabela = split.Panel2.Controls[0]
		return tabela

	def mostrarOcultarArvore(self):
		self.getSplitAtual().Panel1Collapsed = not self.getSplitAtual().Panel1Collapsed

	def CarregarArvore(self, tvAba, aba):
		tvAba.BeginUpdate()
		self._nodeRaiz = TreeNode(self._NO_RAIZ)
		enumerator = listaDiretorioPai.GetEnumerator()
		while enumerator.MoveNext():
			diretorio = enumerator.Current
			if diretorio.Aba.Codigo == aba.Codigo:
				self.AddItemArvore(tvAba, diretorio, 0, self._nodeRaiz)
		tvAba.EndUpdate()

	def CarregarAbas(self):
		self._form.pb.Minimum = 0
		self._form.pb.Maximum = self._listaAbas.Count - 1
		self._form.pb.Value = 0
		i = 0
		while i < self._listaAbas.Count:
			if i > 0:
				self.IncluirNovaAba(self._listaAbas[i].Nome)
			tvAba = self.getArvoreAtual(i)
			self.CarregarArvore(tvAba, self._listaAbas[i])
			self._form.pb.Value = i
			i += 1

	def getAbaAtual(self):
		return AbaBO.Instancia.pegaAbaPorOrdem(self._listaAbas, self._form.tabControl1.SelectedIndex + 1)

	def CarregarArquivosLista(self, bLista1, lvArquivos, sCaminho):
		listaLocal = List[Diretorio]()
		lvArquivos.Items.Clear()
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
		Tabela.Instancia.Carregar(bLista1, lvArquivos, listaLocal, self._listaExtensoes, self._form.pb.ProgressBar)

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
		self._form.barraStatus.Items[0].Text = "Quantidade Total: " + Rotinas.FormatLong("0000", conta) + ", Tamanho Total: " + DiretorioBO.Instancia.MontaTamanho(soma)

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
		if arvoreLocal.VisibleCount > 0:
			if self._form.edtPesquisa.Text.Length >= 2:
				self._form.spPesquisa.Panel2Collapsed = False
				self.CarregarArquivosLista(False, self._form.lvPesquisa, self._form.edtPesquisa.Text)
				self._form.lvPesquisa.Items[0].Selected = True
			else:
				self._form.spPesquisa.Panel2Collapsed = True
				self._form.lvPesquisa.Clear()
				Dialogo.mensagemInfo("A pesquisa só é feita com pelo menos 2 caracteres!")

	def PesquisarArvoreDiretorio(self, sCaminho, aba):
		self._form.tabControl1.SelectedIndex = aba.Ordem - 1
		arvore = self.getArvoreAtual()
		sl = self.montaCaminho(sCaminho, False) # Verifica Diretorio
		node = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
		if node == None:
			sl.Insert(1, sl[1] + Rotinas.BARRA_INVERTIDA)
			node = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
			if node == None:
				sl.Clear()
				sl = self.montaCaminho(sCaminho, True) # Verifica Arquivo
				node = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
				if node == None:
					sl.Insert(1, sl[1] + Rotinas.BARRA_INVERTIDA)
					node = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
		node.Expand()
		arvore.SelectedNode = node

	def LerArvoreDiretorio(self, node, barraStatus):
		sCaminho = node.Text
		NodeAnterior = node.Parent
		while NodeAnterior != None:
			if Rotinas.SubString(NodeAnterior.Text, NodeAnterior.Text.Length, 1) == Rotinas.BARRA_INVERTIDA:
				sSep = ""
			else:
				sSep = Rotinas.BARRA_INVERTIDA
			sCaminho = NodeAnterior.Text + sSep + sCaminho
			NodeAnterior = NodeAnterior.Parent
		self._form.barraStatus.Items[1].Text = sCaminho

	def ListarArquivos(self, lvTabela, node):
		if node != None:
			if node.IsSelected:
				self.LerArvoreDiretorio(node, self._form.barraStatus)
				self.CarregarArquivosLista(True, lvTabela, self._form.barraStatus.Items[1].Text)
				self.TamTotalDiretorio(self._form.barraStatus.Items[1].Text)

	def tabPanelMudou(self):
		arvore = self.getArvoreAtual()
		lvTabela = self.getTabelaAtual()
		arvore.Select()
		if arvore.Nodes.Count > 0:
			self.ListarArquivos(lvTabela, arvore.Nodes[0])

	def getAbaSelecionada(self):
		return self.getAbaAtual()

	def DuploCliqueLista(self, nome, tipo):
		if tipo.Equals("Diretório"):
			self._form.Cursor = Cursors.WaitCursor
			sCaminho = self._form.barraStatus.Items[1].Text
			if self.testaSeparadorArquivo(sCaminho):
				sCaminho += nome
			else:
				sCaminho += Rotinas.BARRA_INVERTIDA + nome
			self.PesquisarArvoreDiretorio(sCaminho, self.getAbaAtual())
			self._form.Cursor = Cursors.Default

	def EncontrarItemLista(self, nomeAba, nome, caminho):
		self._form.Cursor = Cursors.WaitCursor
		aba = AbaBO.Instancia.pegaAbaPorNome(self._listaAbas, nomeAba)
		self.PesquisarArvoreDiretorio(caminho, aba)
		tabela = self.getTabelaAtual()
		lvi = tabela.FindItemWithText(nome, False, 0, False)
		if lvi != None:
			tabela.FocusedItem = lvi
			tabela.Select()
		self._form.Cursor = Cursors.Default

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
		self._form.sdExportar.InitialDirectory = Rotinas.ExtractFilePath(Application.ExecutablePath)
		self._form.sdExportar.FileName = aba.Nome + '.' + sExtensao
		self._form.sdExportar.Filter = Rotinas.FILTRO_EXPORTAR
		retval = self._form.sdExportar.ShowDialog()
		if retval == DialogResult.OK:
			arquivo = FileInfo(self._form.sdExportar.FileName)
			if not arquivo.Exists:
				self._form.Cursor = Cursors.WaitCursor
				DiretorioBO.Instancia.exportarDiretorio(tipo, self.getAbaAtual(), arquivo.FullName, pLog)
				self._form.Cursor = Cursors.Default
				Dialogo.mensagemErro("Exportação realizada com sucesso!")

	def ExcluirDiretorioSelecionado(self, pLog):
		arvore = self.getArvoreAtual()
		path = arvore.SelectedNode
		if path.Text.Length > 0:
			tabela = self.getTabelaAtual()
			res = Dialogo.confirma("Tem Certeza, que você deseja excluir este diretório, isto implicará na destruição de todos os seus items catalogados?")
			if res:
				self._form.Cursor = Cursors.WaitCursor
				DiretorioBO.Instancia.excluirDiretorio(self.getAbaAtual(), path.Text)
				self.ExcluirDados(self.getAbaAtual(), path.Text)
				path.Remove()
				tabela.Clear()
				self.CarregarDados(pLog, False, False)
				self._form.Cursor = Cursors.Default

	def ImportarArquivo(self, log, pLog):
		self._form.odImportar.Filter = "Arquivo XML (*.xml)|*.xml"
		retval = self._form.odImportar.ShowDialog()
		if retval == DialogResult.OK:
			arquivo = FileInfo(self._form.odImportar.FileName)
			if arquivo.Exists:
				self._form.Cursor = Cursors.WaitCursor
				nResultado = DiretorioBO.Instancia.importarDiretorioViaXML(self.getAbaAtual(), arquivo.FullName, self._listaDiretorioPai, pLog)
				if nResultado == -1:
					Dialogo.mensagemErro("Importação não realizada!")
				elif nResultado == -2:
					Dialogo.mensagemErro("Este diretório já existe no catálogo!")
				else:
					self.FinalizaImportacao(pLog)
				self._form.Cursor = Cursors.Default

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
			frmImportarDiretorio.ShowDialog()
			return True
		else:
			if not DiretorioBO.Instancia.verificaCodDir(importar.Aba, importar.RotuloRaiz, self._listaDiretorioPai):
				frmImportarDiretorio.ShowDialog()
				return True
			else:
				Dialogo.mensagemErro("Este diretório já existe no catálogo!")
				return False

	def FinalizaImportacao(self, pLog):
		self._form.Cursor = Cursors.WaitCursor
		self.CarregarDados(pLog, True, True)
		tvAba = self.getArvoreAtual()
		self.CarregarArvore(tvAba, self.getAbaAtual())
		self.tabPanelMudou()
		self._form.Cursor = Cursors.Default
		Dialogo.mensagemInfo("Importação do(s) diretório(s) realizada com sucesso!")

	def ComecaImportacao(self, bSubDiretorios, pLog):
		retval = self._form.escolherDir.ShowDialog()
		if retval == DialogResult.OK:
			arquivo = FileInfo(self._form.escolherDir.SelectedPath)
			if arquivo.Directory.Exists:
				self._form.Cursor = Cursors.WaitCursor
				sCaminho = arquivo.FullName
				frmImportarDiretorio = FrmImportarDiretorio(self._form)
				listaCaminho = StringList()
				if bSubDiretorios:
					DiretorioBO.Instancia.carregarSubDiretorios(sCaminho, listaCaminho)
				else:
					listaCaminho.Add(sCaminho)
				if self.ImportarDiretorios(listaCaminho, bSubDiretorios, frmImportarDiretorio):
					self.FinalizaImportacao(pLog)
				self._form.Cursor = Cursors.Default

	def InformacoesDiretorioArquivo(self):
		tabela = self.getTabelaAtual()
		if tabela.SelectedItems.Count > 0:
			frmInfo = FrmInfoDiretorio()
			aba = self.getAbaSelecionada()
			dir = Tabela.Instancia.getLinhaSelecionada(tabela, False)
			dir.Aba.Nome = aba.Nome
			frmInfo.setDiretorio(dir)
			frmInfo.ShowDialog()

	def listaCompara(self, lvTabela, coluna, colOrdem):
		if coluna != colOrdem:
			colOrdem = coluna
			lvTabela.Sorting = SortOrder.Ascending
		else:
			if lvTabela.Sorting == SortOrder.Ascending:
				lvTabela.Sorting = SortOrder.Descending
			else:
				lvTabela.Sorting = SortOrder.Ascending
		lvTabela.Sort()
		lvTabela.ListViewItemSorter = TabelaItemComparer(coluna, lvTabela.Sorting)
		return colOrdem