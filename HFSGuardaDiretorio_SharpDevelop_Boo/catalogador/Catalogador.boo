/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 07/07/2015
 * Time: 11:02
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.catalogador

import System
import System.IO
import System.Drawing
import System.Collections.Generic
import System.Windows.Forms
import HFSGuardaDiretorio.comum
import HFSGuardaDiretorio.objetos
import HFSGuardaDiretorio.objetosbo
import HFSGuardaDiretorio.objetosdao
import HFSGuardaDiretorio.gui
import HFSGuardaDiretorio.objetosgui

public class Catalogador(ICatalogador):

	private static final CONSULTA_DIR_PAI as string = ((('select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, ' + 'atributos, caminho, nomeaba, nomepai, caminhopai ') + 'from consultadirpai ') + 'order by 1,2,3,4')

	private static final CONSULTA_DIR_FILHO as string = ((('select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, ' + 'atributos, caminho, nomeaba, nomepai, caminhopai ') + 'from consultadirfilho ') + 'order by 1,2,3,4')

	public static final CONSULTA_ARQUIVO as string = ((('select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, ' + 'atributos, caminho, nomeaba, nomepai, caminhopai ') + 'from consultaarquivo ') + 'order by tipo desc, ordem')

	
	private static final NO_RAIZ = 'Raiz'

	
	private static final log = ArquivoLog()

	//Logger.getLogger(Rotinas.HFSGUARDADIR);
	private listaDiretorioFilho as List[of Diretorio]

	private listaArquivos as List[of Diretorio]

	
	public diretorioOrdem as DiretorioOrdem

	
	public listaAbas as List[of Aba]

	public listaDiretorioPai as List[of Diretorio]

	public listaExtensoes as List[of Extensao]

	
	private nodeRaiz as TreeNode

	
	private final form as FrmPrincipal

	
	public def constructor(form as FrmPrincipal):
		self.form = form
		
		diretorioOrdem = DiretorioOrdem()
		
		listaAbas = List[of Aba]()
		listaExtensoes = List[of Extensao]()
		listaDiretorioPai = List[of Diretorio]()
		listaDiretorioFilho = List[of Diretorio]()
		listaArquivos = List[of Diretorio]()
		
		form.spPesquisa.Panel2Collapsed = true
		
		form.Cursor = Cursors.WaitCursor
		frmSplash = FrmSplash()
		frmSplashProgresso = FrmSplashProgresso(frmSplash)
		
		frmSplash.Show()
		frmSplash.Update()
		CarregarDados(frmSplashProgresso, true, true)
		CarregarAbas()
		tabPanelMudou()
		
		frmSplash.Close()
		frmSplash.Dispose()
		
		form.Cursor = Cursors.Default

	
	public static def iniciarSistema():
		aba as Aba
		sBanco as string = ((Rotinas.ExtractFilePath(Application.ExecutablePath) + Path.DirectorySeparatorChar) + 'GuardaDir.db')
		cp = ConexaoParams()
		cp.Nome = sBanco
		
		if not Rotinas.FileExists(sBanco):
			Rotinas.Conectar(cp)
			
			AbaBO.Instancia.criarTabelaAbas()
			
			aba = Aba(1, 'DISCO1', 0)
			AbaBO.Instancia.incluirAba(aba)
			
			ExtensaoBO.Instancia.criarTabelaExtensoes()
			DiretorioBO.Instancia.criarTabelaDiretorios()
			VisaoDAO.Instancia.criarVisao('consultadirpai')
			VisaoDAO.Instancia.criarVisao('consultadirfilho')
			VisaoDAO.Instancia.criarVisao('consultaarquivo')
		else:
			Rotinas.Conectar(cp)
		

	
	public def CarregarDados(pLog as IProgressoLog, bExtensao as bool, bDiretorio as bool):
		listaAbas = AbaBO.Instancia.carregarAba(pLog)
		if bExtensao:
			listaExtensoes = ExtensaoBO.Instancia.carregarExtensao(pLog)
			ExtensaoBO.Instancia.carregarExtensoes(listaExtensoes, form.imageList1, form.imageList2)
		if bDiretorio:
			listaDiretorioPai = DiretorioBO.Instancia.carregarDiretorio(CONSULTA_DIR_PAI, 'consultadirpai', pLog)
			listaDiretorioFilho = DiretorioBO.Instancia.carregarDiretorio(CONSULTA_DIR_FILHO, 'consultadirfilho', pLog)
			listaArquivos = DiretorioBO.Instancia.carregarDiretorio(CONSULTA_ARQUIVO, 'consultaarquivo', pLog)

	
	public def ExcluirDados(aba as Aba, sCaminho as string):
		DiretorioBO.Instancia.excluirListaDiretorio(listaDiretorioPai, aba, sCaminho)
		DiretorioBO.Instancia.excluirListaDiretorio(listaDiretorioFilho, aba, sCaminho)
		DiretorioBO.Instancia.excluirListaDiretorio(listaArquivos, aba, sCaminho)

	
	private def AddItemArvore(tv as TreeView, diretorio as Diretorio, Nivel as int, node1 as TreeNode):
		listaFilhos as List[of Diretorio]
		node2 as TreeNode
		
		if Nivel == 0:
			node1 = tv.Nodes.Add(diretorio.Nome)
		
		listaFilhos = DiretorioBO.Instancia.itensFilhos(listaDiretorioFilho, diretorio.Aba.Codigo, diretorio.Ordem, diretorio.Codigo)
		
		for filho as Diretorio in listaFilhos:
			node2 = node1.Nodes.Add(filho.Nome)
			AddItemArvore(tv, filho, ++Nivel, node2)

	
	public def IncluirNovaAba():
		aba as Aba
		sAba as string = Dialogo.entrada('Digite o Nome da Nova Aba?')
		if (sAba is not null) and (sAba.Trim().Length > 0):
			aba = Aba()
			aba.Codigo = AbaBO.Instancia.retMaxCodAba(listaAbas)
			aba.Nome = Rotinas.SubString(sAba, 1, 10)
			aba.Ordem = (listaAbas.Count + 1)
			AbaBO.Instancia.incluirAba(aba)
			IncluirNovaAba(aba.Nome)
			listaAbas.Add(aba)

	
	public def AlterarNomeAbaAtiva(pLog as IProgressoLog):
		aba as Aba = getAbaAtual()
		sAba as string = Dialogo.entrada('Digite o Novo Nome da Aba Ativa?', aba.Nome)
		if (sAba is not null) and (sAba.Trim().Length > 0):
			aba.Nome = Rotinas.SubString(sAba, 1, 10)
			AbaBO.Instancia.alterarAba(aba)
			form.tabControl1.SelectedTab.Text = sAba
			CarregarDados(pLog, false, true)

	
	public def ExcluirAbaAtiva(pLog as IProgressoLog):
		aba as Aba
		indiceSel as int = form.tabControl1.SelectedIndex
		if indiceSel > 0:
			res as bool = Dialogo.confirma(('Tem Certeza, que você deseja excluir esta aba, \n' + 'isto implicará na destruição de todos os seus itens catalogados?'))
			if res:
				form.Cursor = Cursors.WaitCursor
				
				aba = getAbaAtual()
				ExcluirDados(aba, '')
				AbaBO.Instancia.excluirAba(aba)
				form.tabControl1.Controls.RemoveAt(indiceSel)
				
				CarregarDados(pLog, false, false)
				
				form.barraStatus.Items[1].Text = ''
				
				form.Cursor = Cursors.Default
		else:
			Dialogo.mensagemErro('A primeira Aba não pode ser excluída!')

	
	private def IncluirNovaAba(nomeAba as string):
		tabPage1 as TabPage
		arvore as TreeView
		sp as SplitContainer
		tabela as ListView
		columnHeader15 as ColumnHeader
		columnHeader14 as ColumnHeader
		columnHeader13 as ColumnHeader
		columnHeader12 as ColumnHeader
		columnHeader11 as ColumnHeader
		columnHeader10 as ColumnHeader
		
		
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
		
		// 
		// tabPage1
		// 
		tabPage1.Controls.Add(sp)
		tabPage1.ImageIndex = 0
		tabPage1.Location = Point(4, 23)
		tabPage1.Name = ('tabPage' + nomeAba)
		tabPage1.Padding = Padding(3)
		tabPage1.Size = Size(876, 267)
		tabPage1.TabIndex = 0
		tabPage1.Text = nomeAba
		tabPage1.UseVisualStyleBackColor = true
		// 
		// sp
		// 
		sp.Dock = DockStyle.Fill
		sp.Location = Point(3, 3)
		sp.Name = ('sp' + nomeAba)
		// 
		// sp.Panel1
		// 
		sp.Panel1.Controls.Add(arvore)
		// 
		// sp.Panel2
		// 
		sp.Panel2.Controls.Add(tabela)
		sp.Size = Size(870, 261)
		sp.SplitterDistance = 290
		sp.TabIndex = 0
		// 
		// arvore
		// 
		arvore.Dock = DockStyle.Fill
		arvore.ImageIndex = 0
		arvore.ImageList = form.imageList1
		arvore.Location = Point(0, 0)
		arvore.Name = ('arvore' + nomeAba)
		arvore.SelectedImageIndex = 1
		arvore.Size = Size(290, 261)
		arvore.TabIndex = 0
		arvore.AfterSelect += form.TvFixaAfterSelect
		// 
		// tabela
		// 
		tabela.Columns.AddRange((of ColumnHeader: columnHeader10, columnHeader11, columnHeader12, columnHeader13, columnHeader14, columnHeader15))
		tabela.Dock = DockStyle.Fill
		tabela.FullRowSelect = true
		tabela.GridLines = true
		tabela.LargeImageList = form.imageList2
		tabela.Location = Point(0, 0)
		tabela.MultiSelect = false
		tabela.Name = ('tabela' + nomeAba)
		tabela.Size = Size(576, 261)
		tabela.SmallImageList = form.imageList1
		tabela.TabIndex = 1
		tabela.UseCompatibleStateImageBehavior = false
		tabela.View = View.Details
		tabela.ColumnClick += form.LvFixaColumnClick
		tabela.DoubleClick += form.LvFixaDoubleClick
		// 
		// columnHeader10
		// 
		columnHeader10.Text = 'Nome'
		columnHeader10.Width = 300
		// 
		// columnHeader11
		// 
		columnHeader11.Text = 'Tamanho'
		columnHeader11.Width = 100
		// 
		// columnHeader12
		// 
		columnHeader12.Text = 'Tipo'
		columnHeader12.Width = 70
		// 
		// columnHeader13
		// 
		columnHeader13.Text = 'Modificado'
		columnHeader13.Width = 120
		// 
		// columnHeader14
		// 
		columnHeader14.Text = 'Atributos'
		columnHeader14.Width = 90
		// 
		// columnHeader15
		// 
		columnHeader15.Text = 'Caminho'
		columnHeader15.Width = 300
		
		
		form.tabControl1.Controls.Add(tabPage1)

	
	public def getArvoreAtual() as TreeView:
		return getArvoreAtual(form.tabControl1.SelectedIndex)

	
	public def getArvoreAtual(nIndicePagina as int) as TreeView:
		tabPage as TabPage = form.tabControl1.TabPages[nIndicePagina]
		split = (tabPage.Controls[0] cast SplitContainer)
		arvore = (split.Panel1.Controls[0] cast TreeView)
		return arvore

	
	public def getSplitAtual() as SplitContainer:
		tabPage as TabPage = form.tabControl1.SelectedTab
		split = (tabPage.Controls[0] cast SplitContainer)
		return split

	
	public def getTabelaAtual() as ListView:
		tabPage as TabPage = form.tabControl1.SelectedTab
		split = (tabPage.Controls[0] cast SplitContainer)
		tabela = (split.Panel2.Controls[0] cast ListView)
		return tabela

	
	public def mostrarOcultarArvore():
		getSplitAtual().Panel1Collapsed = (not getSplitAtual().Panel1Collapsed)

	
	public def CarregarArvore(tvAba as TreeView, aba as Aba):
		tvAba.Nodes.Clear()
		
		tvAba.BeginUpdate()
		
		nodeRaiz = TreeNode(NO_RAIZ)
		for diretorio as Diretorio in listaDiretorioPai:
			if diretorio.Aba.Codigo == aba.Codigo:
				AddItemArvore(tvAba, diretorio, 0, nodeRaiz)
		
		tvAba.EndUpdate()

	
	public def CarregarAbas():
		tvAba as TreeView
		
		form.pb.Minimum = 0
		form.pb.Maximum = (listaAbas.Count - 1)
		form.pb.Value = 0
		for i in range(0, listaAbas.Count):
		
			if i > 0:
				IncluirNovaAba(listaAbas[i].Nome)
			tvAba = getArvoreAtual(i)
			CarregarArvore(tvAba, listaAbas[i])
			form.pb.Value = i

	
	private def getAbaAtual() as Aba:
		return AbaBO.Instancia.pegaAbaPorOrdem(listaAbas, (form.tabControl1.SelectedIndex + 1))

	
	public def CarregarArquivosLista(bLista1 as bool, lvArquivos as ListView, sCaminho as string):
		sPaiCaminho as string
		listaLocal as List[of Diretorio]
		nAba as int
		
		listaLocal = List[of Diretorio]()
		lvArquivos.Items.Clear()
		
		if bLista1:
			sPaiCaminho = sCaminho
			if not Rotinas.SubString(sCaminho, sCaminho.Length, 1).Equals(Rotinas.BARRA_INVERTIDA):
				sCaminho = (sCaminho + Rotinas.BARRA_INVERTIDA)
			nAba = getAbaAtual().Codigo
			for diretorio as Diretorio in listaArquivos:
				if diretorio.Aba.Codigo == nAba:
					if diretorio.CaminhoPai.Equals(sPaiCaminho):
						if Rotinas.StartsStr(sCaminho, diretorio.Caminho):
							listaLocal.Add(diretorio)
		else:
			for diretorio as Diretorio in listaArquivos:
				if Rotinas.ContainsStr(diretorio.Caminho.ToUpper(), sCaminho.ToUpper()):
					listaLocal.Add(diretorio)
		Tabela.Instancia.Carregar(bLista1, lvArquivos, listaLocal, listaExtensoes, form.pb.ProgressBar)
		

	
	public def TamTotalDiretorio(sCaminho as string):
		conta as long
		nAba as int
		soma as decimal
		tam as decimal
		
		conta = 0
		soma = 0
		
		for diretorio as Diretorio in listaArquivos:
			nAba = getAbaAtual().Codigo
			if diretorio.Aba.Codigo == nAba:
				if diretorio.Tipo.Codigo != char('D'):
					if sCaminho.Trim().Length > 0:
						if Rotinas.StartsStr(sCaminho, diretorio.Caminho):
							conta += 1
							tam = diretorio.Tamanho
							soma = (soma + tam)
					else:
						conta += 1
						tam = diretorio.Tamanho
						soma = (soma + tam)
		
		
		form.barraStatus.Items[0].Text = ((('Quantidade Total: ' + Rotinas.FormatLong('0000', conta)) + ', Tamanho Total: ') + DiretorioBO.Instancia.MontaTamanho(soma))

	
	private def testaSeparadorArquivo(sDir as string) as bool:
		sDir = Rotinas.SubString(sDir, sDir.Length, 1)
		if (sDir.Equals(Rotinas.BARRA_INVERTIDA) or sDir.Equals(Rotinas.BARRA_NORMAL)) or sDir.Equals(Rotinas.BARRA_INVERTIDA):
			return true
		else:
			return false

	
	private def montaCaminho(sCaminho as string, bRemover as bool) as StringList:
		//sCaminho = NO_RAIZ + Rotinas.BARRA_INVERTIDA + sCaminho;
		sl = StringList(sCaminho, Rotinas.BARRA_INVERTIDA[0])
		if sl[(sl.Count - 1)].Trim().Length == 0:
			sl.RemoveAt((sl.Count - 1))
		if bRemover:
			sl.RemoveAt((sl.Count - 1))
		return sl

	
	public def Pesquisar():
		arvoreLocal as TreeView = getArvoreAtual()
		if arvoreLocal.VisibleCount > 0:
			if form.edtPesquisa.Text.Length >= 2:
				form.spPesquisa.Panel2Collapsed = false
				CarregarArquivosLista(false, form.lvPesquisa, form.edtPesquisa.Text)
				form.lvPesquisa.Items[0].Selected = true
			else:
				form.spPesquisa.Panel2Collapsed = true
				form.lvPesquisa.Clear()
				Dialogo.mensagemInfo('A pesquisa só é feita com pelo menos 2 caracteres!')

	
	public def PesquisarArvoreDiretorio(sCaminho as string, aba as Aba):
		form.tabControl1.SelectedIndex = (aba.Ordem - 1)
		arvore as TreeView = getArvoreAtual()
		sl as StringList = montaCaminho(sCaminho, false)
		// Verifica Diretorio
		node as TreeNode = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
		
		if node is null:
			sl.Insert(1, (sl[1] + Rotinas.BARRA_INVERTIDA))
			node = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
			
			if node is null:
				sl.Clear()
				sl = montaCaminho(sCaminho, true)
				// Verifica Arquivo
				node = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
				
				if node is null:
					sl.Insert(1, (sl[1] + Rotinas.BARRA_INVERTIDA))
					node = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
		
		node.Expand()
		arvore.SelectedNode = node

	
	public def LerArvoreDiretorio(node as TreeNode, barraStatus as StatusStrip):
		NodeAnterior as TreeNode
		sSep as string
		sCaminho as string
		
		sCaminho = node.Text
		NodeAnterior = node.Parent
		
		while NodeAnterior is not null:
			if Rotinas.SubString(NodeAnterior.Text, NodeAnterior.Text.Length, 1) == Rotinas.BARRA_INVERTIDA:
				sSep = ''
			else:
				sSep = Rotinas.BARRA_INVERTIDA
			
			sCaminho = ((NodeAnterior.Text + sSep) + sCaminho)
			
			NodeAnterior = NodeAnterior.Parent
		
		form.barraStatus.Items[1].Text = sCaminho

	
	public def ListarArquivos(lvTabela as ListView, node as TreeNode):
		if node is not null:
			if node.IsSelected:
				LerArvoreDiretorio(node, form.barraStatus)
				CarregarArquivosLista(true, lvTabela, form.barraStatus.Items[1].Text)
				TamTotalDiretorio(form.barraStatus.Items[1].Text)

	
	public def tabPanelMudou():
		arvore as TreeView = getArvoreAtual()
		lvTabela as ListView = getTabelaAtual()
		
		arvore.Select()
		if arvore.Nodes.Count > 0:
			ListarArquivos(lvTabela, arvore.Nodes[0])

	
	public def getAbaSelecionada() as Aba:
		return getAbaAtual()

	
	
	public def DuploCliqueLista(nome as string, tipo as string):
		if tipo.Equals('Diretório'):
			form.Cursor = Cursors.WaitCursor
			sCaminho as string = form.barraStatus.Items[1].Text
			if testaSeparadorArquivo(sCaminho):
				sCaminho += nome
			else:
				sCaminho += (Rotinas.BARRA_INVERTIDA + nome)
			
			PesquisarArvoreDiretorio(sCaminho, getAbaAtual())
			
			form.Cursor = Cursors.Default

	
	
	public def EncontrarItemLista(nomeAba as string, nome as string, caminho as string):
		form.Cursor = Cursors.WaitCursor
		aba as Aba = AbaBO.Instancia.pegaAbaPorNome(listaAbas, nomeAba)
		PesquisarArvoreDiretorio(caminho, aba)
		
		tabela as ListView = getTabelaAtual()
		
		lvi as ListViewItem = tabela.FindItemWithText(nome, false, 0, false)
		if lvi is not null:
			tabela.FocusedItem = lvi
			tabela.Select()
		form.Cursor = Cursors.Default

	
	public def verificaNomeDiretorio(sCaminho as string, sRotuloRaiz as RotuloRaiz) as int:
		sRotuloRaiz.Rotulo = DiretorioBO.Instancia.removerDrive(sCaminho)
		if sRotuloRaiz.Rotulo.Length == 0:
			
			sRotuloRaiz.Rotulo = Dialogo.entrada('Este diretório não possui um nome.\nDigite o nome do diretório!')
			
			if (sRotuloRaiz.Rotulo is not null) and (sRotuloRaiz.Rotulo.Trim().Length > 0):
				sRotuloRaiz.Rotulo = sRotuloRaiz.Rotulo.Trim()
				
				if sRotuloRaiz.Rotulo.Length > 0:
					return 1
				else:
					Dialogo.mensagemInfo('Nenhum nome de diretório informado!')
					return 0
			else:
				return 0
		elif Rotinas.Pos(Rotinas.BARRA_INVERTIDA, sRotuloRaiz.Rotulo) > 0:
			sRotuloRaiz.Rotulo = Rotinas.SubString(sRotuloRaiz.Rotulo, (Rotinas.LastDelimiter(Rotinas.BARRA_INVERTIDA, sRotuloRaiz.Rotulo) + 1), sRotuloRaiz.Rotulo.Length)
			return 2
		else:
			return 3

	
	public def ExportarArquivo(tipo as TipoExportar, pLog as IProgressoLog):
		sExtensao = ''
		converterGeneratedName1 = tipo
		
		if converterGeneratedName1 == TipoExportar.teTXT:
			sExtensao = 'txt'
		elif converterGeneratedName1 == TipoExportar.teCSV:
			sExtensao = 'csv'
		elif converterGeneratedName1 == TipoExportar.teHTML:
			sExtensao = 'html'
		elif converterGeneratedName1 == TipoExportar.teXML:
			sExtensao = 'xml'
		elif converterGeneratedName1 == TipoExportar.teSQL:
			sExtensao = 'sql'
		
		
		aba as Aba = getAbaAtual()
		form.sdExportar.InitialDirectory = Rotinas.ExtractFilePath(Application.ExecutablePath)
		form.sdExportar.FileName = ((aba.Nome + char('.')) + sExtensao)
		form.sdExportar.Filter = Rotinas.FILTRO_EXPORTAR
		retval as DialogResult = form.sdExportar.ShowDialog()
		if retval == DialogResult.OK:
			arquivo = FileInfo(form.sdExportar.FileName)
			if not arquivo.Exists:
				form.Cursor = Cursors.WaitCursor
				DiretorioBO.Instancia.exportarDiretorio(tipo, getAbaAtual(), arquivo.FullName, pLog)
				form.Cursor = Cursors.Default
				
				Dialogo.mensagemErro('Exportação realizada com sucesso!')

	
	public def ExcluirDiretorioSelecionado(pLog as IProgressoLog):
		arvore as TreeView = getArvoreAtual()
		path as TreeNode = arvore.SelectedNode
		
		if path.Text.Length > 0:
			tabela as ListView = getTabelaAtual()
			res as bool = Dialogo.confirma('Tem Certeza, que você deseja excluir este diretório, isto implicará na destruição de todos os seus items catalogados?')
			if res:
				form.Cursor = Cursors.WaitCursor
				
				DiretorioBO.Instancia.excluirDiretorio(getAbaAtual(), path.Text)
				ExcluirDados(getAbaAtual(), path.Text)
				
				path.Remove()
				tabela.Clear()
				
				CarregarDados(pLog, false, false)
				
				form.Cursor = Cursors.Default

	
	public def ImportarArquivo(log as StringList, pLog as IProgressoLog):
		nResultado as int
		
		form.odImportar.Filter = 'Arquivo XML (*.xml)|*.xml'
		retval as DialogResult = form.odImportar.ShowDialog()
		if retval == DialogResult.OK:
			arquivo = FileInfo(form.odImportar.FileName)
			if arquivo.Exists:
				form.Cursor = Cursors.WaitCursor
				nResultado = DiretorioBO.Instancia.importarDiretorioViaXML(getAbaAtual(), arquivo.FullName, listaDiretorioPai, pLog)
				if nResultado == (-1):
					Dialogo.mensagemErro('Importação não realizada!')
				elif nResultado == (-2):
					Dialogo.mensagemErro('Este diretório já existe no catálogo!')
				else:
					FinalizaImportacao(pLog)
				form.Cursor = Cursors.Default

	
	public def ImportarDiretorios(listaCaminho as StringList, bSubDiretorio as bool, frmImportarDiretorio as FrmImportarDiretorio) as bool:
		nAba as int
		nRotuloRaiz as int
		nCodDirRaiz as int
		sRotuloRaiz = RotuloRaiz()
		sCaminhoSemDrive as string
		importar = Importar()
		
		nAba = getAbaAtual().Codigo
		nCodDirRaiz = DiretorioBO.Instancia.retMaxCodDir(nAba, listaDiretorioPai)
		
		for sCaminho as string in listaCaminho:
			nRotuloRaiz = verificaNomeDiretorio(sCaminho, sRotuloRaiz)
			if nRotuloRaiz > 0:
				importar = Importar()
				importar.Aba = nAba
				importar.CodDirRaiz = nCodDirRaiz
				importar.RotuloRaiz = sRotuloRaiz.Rotulo
				if nRotuloRaiz == 1:
					importar.NomeDirRaiz = sRotuloRaiz.Rotulo
				elif nRotuloRaiz == 2:
					sCaminhoSemDrive = DiretorioBO.Instancia.removerDrive(sCaminho)
					importar.NomeDirRaiz = Rotinas.SubString(sCaminhoSemDrive, 1, (Rotinas.LastDelimiter(Rotinas.BARRA_INVERTIDA, sCaminhoSemDrive) - 1))
				elif nRotuloRaiz == 3:
					importar.NomeDirRaiz = ''
				importar.Caminho = sCaminho
				
				frmImportarDiretorio.listaImportar.Add(importar)
				nCodDirRaiz += 1
		
		frmImportarDiretorio.bSubDiretorio = bSubDiretorio
		
		if bSubDiretorio:
			frmImportarDiretorio.ShowDialog()
			return true
		elif not DiretorioBO.Instancia.verificaCodDir(importar.Aba, importar.RotuloRaiz, listaDiretorioPai):
			frmImportarDiretorio.ShowDialog()
			return true
		else:
			Dialogo.mensagemErro('Este diretório já existe no catálogo!')
			
			return false
		

	
	public def FinalizaImportacao(pLog as IProgressoLog):
		tvAba as TreeView
		
		form.Cursor = Cursors.WaitCursor
		
		CarregarDados(pLog, true, true)
		tvAba = getArvoreAtual()
		CarregarArvore(tvAba, getAbaAtual())
		tabPanelMudou()
		
		form.Cursor = Cursors.Default
		Dialogo.mensagemInfo('Importação do(s) diretório(s) realizada com sucesso!')
		

	
	
	public def ComecaImportacao(bSubDiretorios as bool, pLog as IProgressoLog):
		sCaminho as string
		listaCaminho as StringList
		frmImportarDiretorio as FrmImportarDiretorio
		
		retval as DialogResult = form.escolherDir.ShowDialog()
		if retval == DialogResult.OK:
			arquivo = FileInfo(form.escolherDir.SelectedPath)
			if arquivo.Directory.Exists:
				form.Cursor = Cursors.WaitCursor
				sCaminho = arquivo.FullName
				
				frmImportarDiretorio = FrmImportarDiretorio(form)
				listaCaminho = StringList()
				
				if bSubDiretorios:
					DiretorioBO.Instancia.carregarSubDiretorios(sCaminho, listaCaminho)
				else:
					listaCaminho.Add(sCaminho)
				
				if ImportarDiretorios(listaCaminho, bSubDiretorios, frmImportarDiretorio):
					FinalizaImportacao(pLog)
				
				form.Cursor = Cursors.Default
		

	
	public def InformacoesDiretorioArquivo():
		frmInfo as FrmInfoDiretorio
		tabela as ListView = getTabelaAtual()
		if tabela.SelectedItems.Count > 0:
			frmInfo = FrmInfoDiretorio()
			aba as Aba = getAbaSelecionada()
			dir as Diretorio = Tabela.Instancia.getLinhaSelecionada(tabela, false)
			dir.Aba.Nome = aba.Nome
			frmInfo.setDiretorio(dir)
			frmInfo.ShowDialog()

	
	public def listaCompara(lvTabela as ListView, coluna as int, colOrdem as int) as int:
		if coluna != colOrdem:
			colOrdem = coluna
			lvTabela.Sorting = SortOrder.Ascending
		elif lvTabela.Sorting == SortOrder.Ascending:
			lvTabela.Sorting = SortOrder.Descending
		else:
			lvTabela.Sorting = SortOrder.Ascending
		
		lvTabela.Sort()
		lvTabela.ListViewItemSorter = TabelaItemComparer(coluna, lvTabela.Sorting)
		return colOrdem

