import System.Drawing
import System.Windows.Forms
import System.Collections.Generic

from System.Drawing import *
from System.Windows.Forms import *
from System.Collections.Generic import *

from gui import FrmSobre
from gui import FrmPrincipalProgresso

class FrmPrincipal(Form):
	def __init__(self):		
		self._colOrdem = -1
		self.InitializeComponent()
		self._frmPrincipalProgresso = FrmPrincipalProgresso.FrmPrincipalProgresso(self)
		#self._catalogador = Catalogador(self)
		self._catalogador = None
						
	def InitializeComponent(self):
		self._components = System.ComponentModel.Container()
		#resources = System.Resources.ResourceManager("HFSGuardaDiretorio.FrmPrincipal", System.Reflection.Assembly.GetEntryAssembly())
		self._barraMenu = System.Windows.Forms.MenuStrip()
		self._menuAba = System.Windows.Forms.ToolStripMenuItem()
		self._menuIncluirNovaAba = System.Windows.Forms.ToolStripMenuItem()
		self._menuAlterarNomeAbaAtiva = System.Windows.Forms.ToolStripMenuItem()
		self._menuExcluirAbaAtiva = System.Windows.Forms.ToolStripMenuItem()
		self._menuDiretorio = System.Windows.Forms.ToolStripMenuItem()
		self._menuImportarDiretorio = System.Windows.Forms.ToolStripMenuItem()
		self._menuImportarSubDiretorios = System.Windows.Forms.ToolStripMenuItem()
		self._menuCompararDiretorios = System.Windows.Forms.ToolStripMenuItem()
		self._menuCadastrarExtensaoArquivo = System.Windows.Forms.ToolStripMenuItem()
		self._toolStripSeparator1 = System.Windows.Forms.ToolStripSeparator()
		self._menuExpandirDiretorios = System.Windows.Forms.ToolStripMenuItem()
		self._menuColapsarDiretorios = System.Windows.Forms.ToolStripMenuItem()
		self._menuExportarDiretoriosAbaAtiva = System.Windows.Forms.ToolStripMenuItem()
		self._menuTXT = System.Windows.Forms.ToolStripMenuItem()
		self._menuCSV = System.Windows.Forms.ToolStripMenuItem()
		self._menuHTML = System.Windows.Forms.ToolStripMenuItem()
		self._menuXML = System.Windows.Forms.ToolStripMenuItem()
		self._menuSQL = System.Windows.Forms.ToolStripMenuItem()
		self._menuImportarDiretoriosViaXML = System.Windows.Forms.ToolStripMenuItem()
		self._menuGravarLogImportacao = System.Windows.Forms.ToolStripMenuItem()
		self._menuVisao = System.Windows.Forms.ToolStripMenuItem()
		self._menuMostrarOcultArvoreDirAbaAtiva = System.Windows.Forms.ToolStripMenuItem()
		self._menuMostrarOcultarListaItensPesquisados = System.Windows.Forms.ToolStripMenuItem()
		self._menuModoExibicao = System.Windows.Forms.ToolStripMenuItem()
		self._menuIcones = System.Windows.Forms.ToolStripMenuItem()
		self._menuLista = System.Windows.Forms.ToolStripMenuItem()
		self._menuDetalhes = System.Windows.Forms.ToolStripMenuItem()
		self._menuIconesPequenos = System.Windows.Forms.ToolStripMenuItem()
		self._menuSobre = System.Windows.Forms.ToolStripMenuItem()
		self._menuSobreCatalogador = System.Windows.Forms.ToolStripMenuItem()
		self._barraFerra = System.Windows.Forms.ToolStrip()
		self._btnImportarDiretorio = System.Windows.Forms.ToolStripButton()
		self._pb = System.Windows.Forms.ToolStripProgressBar()
		self._edtPesquisa = System.Windows.Forms.ToolStripTextBox()
		self._btnPesquisar = System.Windows.Forms.ToolStripButton()
		self._spPesquisa = System.Windows.Forms.SplitContainer()
		self._tabControl1 = System.Windows.Forms.TabControl()
		self._popupMenu = System.Windows.Forms.ContextMenuStrip(self._components)
		self._menuInformacoesDiretorioArquivo = System.Windows.Forms.ToolStripMenuItem()
		self._menuExcluirDiretorioSelecionado = System.Windows.Forms.ToolStripMenuItem()
		self._menuExpandirDiretorios2 = System.Windows.Forms.ToolStripMenuItem()
		self._menuColapsarDiretorios2 = System.Windows.Forms.ToolStripMenuItem()
		self._toolStripSeparator2 = System.Windows.Forms.ToolStripSeparator()
		self._menuIncluirNovaAba2 = System.Windows.Forms.ToolStripMenuItem()
		self._menuAlterarNomeAbaAtiva2 = System.Windows.Forms.ToolStripMenuItem()
		self._menuExcluirAbaAtiva2 = System.Windows.Forms.ToolStripMenuItem()
		self._tabPage1 = System.Windows.Forms.TabPage()
		self._sp = System.Windows.Forms.SplitContainer()
		self._tvFixa = System.Windows.Forms.TreeView()
		self._imageList1 = System.Windows.Forms.ImageList(self._components)
		self._lvFixa = System.Windows.Forms.ListView()
		self._columnHeader10 = System.Windows.Forms.ColumnHeader()
		self._columnHeader11 = System.Windows.Forms.ColumnHeader()
		self._columnHeader12 = System.Windows.Forms.ColumnHeader()
		self._columnHeader13 = System.Windows.Forms.ColumnHeader()
		self._columnHeader14 = System.Windows.Forms.ColumnHeader()
		self._columnHeader15 = System.Windows.Forms.ColumnHeader()
		self._imageList2 = System.Windows.Forms.ImageList(self._components)
		self._imageList3 = System.Windows.Forms.ImageList(self._components)
		self._lvPesquisa = System.Windows.Forms.ListView()
		self._columnHeader1 = System.Windows.Forms.ColumnHeader()
		self._columnHeader2 = System.Windows.Forms.ColumnHeader()
		self._columnHeader3 = System.Windows.Forms.ColumnHeader()
		self._columnHeader4 = System.Windows.Forms.ColumnHeader()
		self._columnHeader5 = System.Windows.Forms.ColumnHeader()
		self._columnHeader6 = System.Windows.Forms.ColumnHeader()
		self._columnHeader7 = System.Windows.Forms.ColumnHeader()
		self._barraStatus = System.Windows.Forms.StatusStrip()
		self._labStatus1 = System.Windows.Forms.ToolStripStatusLabel()
		self._labStatus2 = System.Windows.Forms.ToolStripStatusLabel()
		self._odImportar = System.Windows.Forms.OpenFileDialog()
		self._sdExportar = System.Windows.Forms.SaveFileDialog()
		self._escolherDir = System.Windows.Forms.FolderBrowserDialog()
		self._barraMenu.SuspendLayout()
		self._barraFerra.SuspendLayout()
		self._spPesquisa.BeginInit()
		self._spPesquisa.Panel1.SuspendLayout()
		self._spPesquisa.Panel2.SuspendLayout()
		self._spPesquisa.SuspendLayout()
		self._tabControl1.SuspendLayout()
		self._popupMenu.SuspendLayout()
		self._tabPage1.SuspendLayout()
		self._sp.BeginInit()
		self._sp.Panel1.SuspendLayout()
		self._sp.Panel2.SuspendLayout()
		self._sp.SuspendLayout()
		self._barraStatus.SuspendLayout()
		self.SuspendLayout()
		# 
		# barraMenu
		# 
		self._barraMenu.Items.AddRange(System.Array[System.Windows.Forms.ToolStripItem](
			[self._menuAba,
			self._menuDiretorio,
			self._menuVisao,
			self._menuSobre]))
		self._barraMenu.Location = System.Drawing.Point(0, 0)
		self._barraMenu.Name = "barraMenu"
		self._barraMenu.Size = System.Drawing.Size(884, 24)
		self._barraMenu.TabIndex = 0
		self._barraMenu.Text = "menuStrip1"
		# 
		# menuAba
		# 
		self._menuAba.DropDownItems.AddRange(System.Array[System.Windows.Forms.ToolStripItem](
			[self._menuIncluirNovaAba,
			self._menuAlterarNomeAbaAtiva,
			self._menuExcluirAbaAtiva]))
		self._menuAba.Name = "menuAba"
		self._menuAba.Size = System.Drawing.Size(40, 20)
		self._menuAba.Text = "&Aba"
		# 
		# menuIncluirNovaAba
		# 
		self._menuIncluirNovaAba.Name = "menuIncluirNovaAba"
		self._menuIncluirNovaAba.Size = System.Drawing.Size(215, 22)
		self._menuIncluirNovaAba.Text = "Incluir Nova Aba"
		self._menuIncluirNovaAba.Click += self.MenuIncluirNovaAbaClick
		# 
		# menuAlterarNomeAbaAtiva
		# 
		self._menuAlterarNomeAbaAtiva.Name = "menuAlterarNomeAbaAtiva"
		self._menuAlterarNomeAbaAtiva.Size = System.Drawing.Size(215, 22)
		self._menuAlterarNomeAbaAtiva.Text = "Alterar Nome da Aba Ativa"
		self._menuAlterarNomeAbaAtiva.Click += self.MenuAlterarNomeAbaAtivaClick
		# 
		# menuExcluirAbaAtiva
		# 
		self._menuExcluirAbaAtiva.Name = "menuExcluirAbaAtiva"
		self._menuExcluirAbaAtiva.Size = System.Drawing.Size(215, 22)
		self._menuExcluirAbaAtiva.Text = "Excluir Aba Ativa"
		self._menuExcluirAbaAtiva.Click += self.MenuExcluirAbaAtivaClick
		# 
		# menuDiretorio
		# 
		self._menuDiretorio.DropDownItems.AddRange(System.Array[System.Windows.Forms.ToolStripItem](
			[self._menuImportarDiretorio,
			self._menuImportarSubDiretorios,
			self._menuCompararDiretorios,
			self._menuCadastrarExtensaoArquivo,
			self._toolStripSeparator1,
			self._menuExpandirDiretorios,
			self._menuColapsarDiretorios,
			self._menuExportarDiretoriosAbaAtiva,
			self._menuImportarDiretoriosViaXML,
			self._menuGravarLogImportacao]))
		self._menuDiretorio.Name = "menuDiretorio"
		self._menuDiretorio.Size = System.Drawing.Size(65, 20)
		self._menuDiretorio.Text = "&Diretório"
		# 
		# menuImportarDiretorio
		# 
		self._menuImportarDiretorio.Name = "menuImportarDiretorio"
		self._menuImportarDiretorio.Size = System.Drawing.Size(241, 22)
		self._menuImportarDiretorio.Text = "Importar Diretório"
		self._menuImportarDiretorio.Click += self.MenuImportarDiretorioClick
		# 
		# menuImportarSubDiretorios
		# 
		self._menuImportarSubDiretorios.Name = "menuImportarSubDiretorios"
		self._menuImportarSubDiretorios.Size = System.Drawing.Size(241, 22)
		self._menuImportarSubDiretorios.Text = "Importar SubDiretórios"
		self._menuImportarSubDiretorios.Click += self.MenuImportarSubDiretoriosClick
		# 
		# menuCompararDiretorios
		# 
		self._menuCompararDiretorios.Name = "menuCompararDiretorios"
		self._menuCompararDiretorios.Size = System.Drawing.Size(241, 22)
		self._menuCompararDiretorios.Text = "Comparar Diretórios"
		self._menuCompararDiretorios.Click += self.MenuCompararDiretoriosClick
		# 
		# menuCadastrarExtensaoArquivo
		# 
		self._menuCadastrarExtensaoArquivo.Name = "menuCadastrarExtensaoArquivo"
		self._menuCadastrarExtensaoArquivo.Size = System.Drawing.Size(241, 22)
		self._menuCadastrarExtensaoArquivo.Text = "Cadastrar Extensão de Arquivo"
		self._menuCadastrarExtensaoArquivo.Click += self.MenuCadastrarExtensaoArquivoClick
		# 
		# toolStripSeparator1
		# 
		self._toolStripSeparator1.Name = "toolStripSeparator1"
		self._toolStripSeparator1.Size = System.Drawing.Size(238, 6)
		# 
		# menuExpandirDiretorios
		# 
		self._menuExpandirDiretorios.Name = "menuExpandirDiretorios"
		self._menuExpandirDiretorios.Size = System.Drawing.Size(241, 22)
		self._menuExpandirDiretorios.Text = "Expandir Diretórios"
		self._menuExpandirDiretorios.Click += self.MenuExpandirDiretoriosClick
		# 
		# menuColapsarDiretorios
		# 
		self._menuColapsarDiretorios.Name = "menuColapsarDiretorios"
		self._menuColapsarDiretorios.Size = System.Drawing.Size(241, 22)
		self._menuColapsarDiretorios.Text = "Colapsar Diretórios"
		self._menuColapsarDiretorios.Click += self.MenuColapsarDiretoriosClick
		# 
		# menuExportarDiretoriosAbaAtiva
		# 
		self._menuExportarDiretoriosAbaAtiva.DropDownItems.AddRange(System.Array[System.Windows.Forms.ToolStripItem](
			[self._menuTXT,
			self._menuCSV,
			self._menuHTML,
			self._menuXML,
			self._menuSQL]))
		self._menuExportarDiretoriosAbaAtiva.Name = "menuExportarDiretoriosAbaAtiva"
		self._menuExportarDiretoriosAbaAtiva.Size = System.Drawing.Size(241, 22)
		self._menuExportarDiretoriosAbaAtiva.Text = "Exportar Diretórios da Aba Ativa"
		# 
		# menuTXT
		# 
		self._menuTXT.Name = "menuTXT"
		self._menuTXT.Size = System.Drawing.Size(107, 22)
		self._menuTXT.Text = "TXT"
		self._menuTXT.Click += self.MenuTXTClick
		# 
		# menuCSV
		# 
		self._menuCSV.Name = "menuCSV"
		self._menuCSV.Size = System.Drawing.Size(107, 22)
		self._menuCSV.Text = "CSV"
		self._menuCSV.Click += self.MenuCSVClick
		# 
		# menuHTML
		# 
		self._menuHTML.Name = "menuHTML"
		self._menuHTML.Size = System.Drawing.Size(107, 22)
		self._menuHTML.Text = "HTML"
		self._menuHTML.Click += self.MenuHTMLClick
		# 
		# menuXML
		# 
		self._menuXML.Name = "menuXML"
		self._menuXML.Size = System.Drawing.Size(107, 22)
		self._menuXML.Text = "XML"
		self._menuXML.Click += self.MenuXMLClick
		# 
		# menuSQL
		# 
		self._menuSQL.Name = "menuSQL"
		self._menuSQL.Size = System.Drawing.Size(107, 22)
		self._menuSQL.Text = "SQL"
		self._menuSQL.Click += self.MenuSQLClick
		# 
		# menuImportarDiretoriosViaXML
		# 
		self._menuImportarDiretoriosViaXML.Name = "menuImportarDiretoriosViaXML"
		self._menuImportarDiretoriosViaXML.Size = System.Drawing.Size(241, 22)
		self._menuImportarDiretoriosViaXML.Text = "Importar Diretórios via XML"
		self._menuImportarDiretoriosViaXML.Click += self.MenuImportarDiretoriosViaXMLClick
		# 
		# menuGravarLogImportacao
		# 
		self._menuGravarLogImportacao.CheckOnClick = True
		self._menuGravarLogImportacao.Name = "menuGravarLogImportacao"
		self._menuGravarLogImportacao.Size = System.Drawing.Size(241, 22)
		self._menuGravarLogImportacao.Text = "Gravar Log da Importação"
		# 
		# menuVisao
		# 
		self._menuVisao.DropDownItems.AddRange(System.Array[System.Windows.Forms.ToolStripItem](
			[self._menuMostrarOcultArvoreDirAbaAtiva,
			self._menuMostrarOcultarListaItensPesquisados,
			self._menuModoExibicao]))
		self._menuVisao.Name = "menuVisao"
		self._menuVisao.Size = System.Drawing.Size(47, 20)
		self._menuVisao.Text = "&Visão"
		# 
		# menuMostrarOcultArvoreDirAbaAtiva
		# 
		self._menuMostrarOcultArvoreDirAbaAtiva.Name = "menuMostrarOcultArvoreDirAbaAtiva"
		self._menuMostrarOcultArvoreDirAbaAtiva.Size = System.Drawing.Size(334, 22)
		self._menuMostrarOcultArvoreDirAbaAtiva.Text = "Mostrar/Ocultar árvore de diretórios da Aba Ativa"
		self._menuMostrarOcultArvoreDirAbaAtiva.Click += self.MenuMostrarOcultArvoreDirAbaAtivaClick
		# 
		# menuMostrarOcultarListaItensPesquisados
		# 
		self._menuMostrarOcultarListaItensPesquisados.Name = "menuMostrarOcultarListaItensPesquisados"
		self._menuMostrarOcultarListaItensPesquisados.Size = System.Drawing.Size(334, 22)
		self._menuMostrarOcultarListaItensPesquisados.Text = "Mostrar/Ocultar lista de itens pesquisados"
		self._menuMostrarOcultarListaItensPesquisados.Click += self.MenuMostrarOcultarListaItensPesquisadosClick
		# 
		# menuModoExibicao
		# 
		self._menuModoExibicao.DropDownItems.AddRange(System.Array[System.Windows.Forms.ToolStripItem](
			[self._menuIcones,
			self._menuLista,
			self._menuDetalhes,
			self._menuIconesPequenos]))
		self._menuModoExibicao.Name = "menuModoExibicao"
		self._menuModoExibicao.Size = System.Drawing.Size(334, 22)
		self._menuModoExibicao.Text = "Modo de Exibição"
		# 
		# menuIcones
		# 
		self._menuIcones.Name = "menuIcones"
		self._menuIcones.Size = System.Drawing.Size(163, 22)
		self._menuIcones.Text = "Ícones"
		self._menuIcones.Click += self.MenuIconesClick
		# 
		# menuLista
		# 
		self._menuLista.Name = "menuLista"
		self._menuLista.Size = System.Drawing.Size(163, 22)
		self._menuLista.Text = "Lista"
		self._menuLista.Click += self.MenuListaClick
		# 
		# menuDetalhes
		# 
		self._menuDetalhes.Name = "menuDetalhes"
		self._menuDetalhes.Size = System.Drawing.Size(163, 22)
		self._menuDetalhes.Text = "Detalhes"
		self._menuDetalhes.Click += self.MenuDetalhesClick
		# 
		# menuIconesPequenos
		# 
		self._menuIconesPequenos.Name = "menuIconesPequenos"
		self._menuIconesPequenos.Size = System.Drawing.Size(163, 22)
		self._menuIconesPequenos.Text = "Ícones Pequenos"
		self._menuIconesPequenos.Click += self.MenuIconesPequenosClick
		# 
		# menuSobre
		# 
		self._menuSobre.DropDownItems.AddRange(System.Array[System.Windows.Forms.ToolStripItem](
			[self._menuSobreCatalogador]))
		self._menuSobre.Name = "menuSobre"
		self._menuSobre.Size = System.Drawing.Size(49, 20)
		self._menuSobre.Text = "&Sobre"
		# 
		# menuSobreCatalogador
		# 
		self._menuSobreCatalogador.Name = "menuSobreCatalogador"
		self._menuSobreCatalogador.Size = System.Drawing.Size(182, 22)
		self._menuSobreCatalogador.Text = "Sobre o Catalogador"
		self._menuSobreCatalogador.Click += self.MenuSobreCatalogadorClick
		# 
		# barraFerra
		# 
		self._barraFerra.GripStyle = System.Windows.Forms.ToolStripGripStyle.Hidden
		self._barraFerra.Items.AddRange(System.Array[System.Windows.Forms.ToolStripItem](
			[self._btnImportarDiretorio,
			self._pb,
			self._edtPesquisa,
			self._btnPesquisar]))
		self._barraFerra.Location = System.Drawing.Point(0, 24)
		self._barraFerra.Name = "barraFerra"
		self._barraFerra.Size = System.Drawing.Size(884, 25)
		self._barraFerra.Stretch = True
		self._barraFerra.TabIndex = 1
		# 
		# btnImportarDiretorio
		# 
		self._btnImportarDiretorio.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
		self._btnImportarDiretorio.ImageTransparentColor = System.Drawing.Color.Magenta
		self._btnImportarDiretorio.Name = "btnImportarDiretorio"
		self._btnImportarDiretorio.Size = System.Drawing.Size(106, 22)
		self._btnImportarDiretorio.Text = "&Importar Diretório"
		self._btnImportarDiretorio.Click += self.BtnImportarDiretorioClick
		# 
		# pb
		# 
		self._pb.AutoSize = False
		self._pb.Name = "pb"
		self._pb.Size = System.Drawing.Size(385, 22)
		self._pb.Step = 0
		# 
		# edtPesquisa
		# 
		self._edtPesquisa.AutoSize = False
		self._edtPesquisa.MaxLength = 255
		self._edtPesquisa.Name = "edtPesquisa"
		self._edtPesquisa.Size = System.Drawing.Size(288, 25)
		self._edtPesquisa.ToolTipText = "Digite aqui para pesquisar"
		# 
		# btnPesquisar
		# 
		self._btnPesquisar.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
		self._btnPesquisar.ImageTransparentColor = System.Drawing.Color.Magenta
		self._btnPesquisar.Name = "btnPesquisar"
		self._btnPesquisar.Size = System.Drawing.Size(61, 22)
		self._btnPesquisar.Text = "&Pesquisar"
		self._btnPesquisar.Click += self.BtnPesquisarClick
		# 
		# spPesquisa
		# 
		self._spPesquisa.Dock = System.Windows.Forms.DockStyle.Fill
		self._spPesquisa.Location = System.Drawing.Point(0, 49)
		self._spPesquisa.Name = "spPesquisa"
		self._spPesquisa.Orientation = System.Windows.Forms.Orientation.Horizontal
		# 
		# spPesquisa.Panel1
		# 
		self._spPesquisa.Panel1.Controls.Add(self._tabControl1)
		# 
		# spPesquisa.Panel2
		# 
		self._spPesquisa.Panel2.Controls.Add(self._lvPesquisa)
		self._spPesquisa.Size = System.Drawing.Size(884, 413)
		self._spPesquisa.SplitterDistance = 294
		self._spPesquisa.TabIndex = 2
		# 
		# tabControl1
		# 
		self._tabControl1.ContextMenuStrip = self._popupMenu
		self._tabControl1.Controls.Add(self._tabPage1)
		self._tabControl1.Dock = System.Windows.Forms.DockStyle.Fill
		self._tabControl1.ImageList = self._imageList3
		self._tabControl1.Location = System.Drawing.Point(0, 0)
		self._tabControl1.Name = "tabControl1"
		self._tabControl1.SelectedIndex = 0
		self._tabControl1.Size = System.Drawing.Size(884, 294)
		self._tabControl1.TabIndex = 0
		self._tabControl1.SelectedIndexChanged += self.TabControl1SelectedIndexChanged
		# 
		# popupMenu
		# 
		self._popupMenu.Items.AddRange(System.Array[System.Windows.Forms.ToolStripItem](
			[self._menuInformacoesDiretorioArquivo,
			self._menuExcluirDiretorioSelecionado,
			self._menuExpandirDiretorios2,
			self._menuColapsarDiretorios2,
			self._toolStripSeparator2,
			self._menuIncluirNovaAba2,
			self._menuAlterarNomeAbaAtiva2,
			self._menuExcluirAbaAtiva2]))
		self._popupMenu.Name = "popupMenu"
		self._popupMenu.Size = System.Drawing.Size(260, 164)
		# 
		# menuInformacoesDiretorioArquivo
		# 
		self._menuInformacoesDiretorioArquivo.Name = "menuInformacoesDiretorioArquivo"
		self._menuInformacoesDiretorioArquivo.Size = System.Drawing.Size(259, 22)
		self._menuInformacoesDiretorioArquivo.Text = "Informações do Diretório / Arquivo"
		self._menuInformacoesDiretorioArquivo.Click += self.MenuInformacoesDiretorioArquivoClick
		# 
		# menuExcluirDiretorioSelecionado
		# 
		self._menuExcluirDiretorioSelecionado.Name = "menuExcluirDiretorioSelecionado"
		self._menuExcluirDiretorioSelecionado.Size = System.Drawing.Size(259, 22)
		self._menuExcluirDiretorioSelecionado.Text = "Excluir Diretório Selecionado"
		self._menuExcluirDiretorioSelecionado.Click += self.MenuExcluirDiretorioSelecionadoClick
		# 
		# menuExpandirDiretorios2
		# 
		self._menuExpandirDiretorios2.Name = "menuExpandirDiretorios2"
		self._menuExpandirDiretorios2.Size = System.Drawing.Size(259, 22)
		self._menuExpandirDiretorios2.Text = "Expandir Diretórios"
		self._menuExpandirDiretorios2.Click += self.MenuExpandirDiretorios2Click
		# 
		# menuColapsarDiretorios2
		# 
		self._menuColapsarDiretorios2.Name = "menuColapsarDiretorios2"
		self._menuColapsarDiretorios2.Size = System.Drawing.Size(259, 22)
		self._menuColapsarDiretorios2.Text = "Colapsar Diretórios"
		self._menuColapsarDiretorios2.Click += self.MenuColapsarDiretorios2Click
		# 
		# toolStripSeparator2
		# 
		self._toolStripSeparator2.Name = "toolStripSeparator2"
		self._toolStripSeparator2.Size = System.Drawing.Size(256, 6)
		# 
		# menuIncluirNovaAba2
		# 
		self._menuIncluirNovaAba2.Name = "menuIncluirNovaAba2"
		self._menuIncluirNovaAba2.Size = System.Drawing.Size(259, 22)
		self._menuIncluirNovaAba2.Text = "Incluir nova aba"
		self._menuIncluirNovaAba2.Click += self.MenuIncluirNovaAba2Click
		# 
		# menuAlterarNomeAbaAtiva2
		# 
		self._menuAlterarNomeAbaAtiva2.Name = "menuAlterarNomeAbaAtiva2"
		self._menuAlterarNomeAbaAtiva2.Size = System.Drawing.Size(259, 22)
		self._menuAlterarNomeAbaAtiva2.Text = "Alterar nome da aba ativa"
		self._menuAlterarNomeAbaAtiva2.Click += self.MenuAlterarNomeAbaAtiva2Click
		# 
		# menuExcluirAbaAtiva2
		# 
		self._menuExcluirAbaAtiva2.Name = "menuExcluirAbaAtiva2"
		self._menuExcluirAbaAtiva2.Size = System.Drawing.Size(259, 22)
		self._menuExcluirAbaAtiva2.Text = "Excluir aba ativa"
		self._menuExcluirAbaAtiva2.Click += self.MenuExcluirAbaAtiva2Click
		# 
		# tabPage1
		# 
		self._tabPage1.Controls.Add(self._sp)
		self._tabPage1.ImageIndex = 0
		self._tabPage1.Location = System.Drawing.Point(4, 23)
		self._tabPage1.Name = "tabPage1"
		self._tabPage1.Padding = System.Windows.Forms.Padding(3)
		self._tabPage1.Size = System.Drawing.Size(876, 267)
		self._tabPage1.TabIndex = 0
		self._tabPage1.Text = "DISCO1"
		self._tabPage1.UseVisualStyleBackColor = True
		# 
		# sp
		# 
		self._sp.Dock = System.Windows.Forms.DockStyle.Fill
		self._sp.Location = System.Drawing.Point(3, 3)
		self._sp.Name = "sp"
		# 
		# sp.Panel1
		# 
		self._sp.Panel1.Controls.Add(self._tvFixa)
		# 
		# sp.Panel2
		# 
		self._sp.Panel2.Controls.Add(self._lvFixa)
		self._sp.Size = System.Drawing.Size(870, 261)
		self._sp.SplitterDistance = 290
		self._sp.TabIndex = 0
		# 
		# tvFixa
		# 
		self._tvFixa.Dock = System.Windows.Forms.DockStyle.Fill
		self._tvFixa.FullRowSelect = True
		self._tvFixa.HideSelection = False
		self._tvFixa.ImageIndex = 0
		self._tvFixa.ImageList = self._imageList1
		self._tvFixa.Location = System.Drawing.Point(0, 0)
		self._tvFixa.Name = "tvFixa"
		self._tvFixa.SelectedImageIndex = 1
		self._tvFixa.Size = System.Drawing.Size(290, 261)
		self._tvFixa.TabIndex = 0
		self._tvFixa.AfterSelect += self.TvFixaAfterSelect
		# 
		# imageList1
		# 
		#self._imageList1.ImageStream = resources.GetObject("imageList1.ImageStream")
		#self._imageList1.TransparentColor = System.Drawing.Color.Transparent
		#self._imageList1.Images.SetKeyName(0, "Fechar.bmp")
		#self._imageList1.Images.SetKeyName(1, "Abrir.bmp")
		#self._imageList1.Images.SetKeyName(2, "Arquivo.bmp")
		# 
		# lvFixa
		# 
		self._lvFixa.Columns.AddRange(System.Array[System.Windows.Forms.ColumnHeader](
			[self._columnHeader10,
			self._columnHeader11,
			self._columnHeader12,
			self._columnHeader13,
			self._columnHeader14,
			self._columnHeader15]))
		self._lvFixa.Dock = System.Windows.Forms.DockStyle.Fill
		self._lvFixa.FullRowSelect = True
		self._lvFixa.GridLines = True
		self._lvFixa.LargeImageList = self._imageList2
		self._lvFixa.Location = System.Drawing.Point(0, 0)
		self._lvFixa.MultiSelect = False
		self._lvFixa.Name = "lvFixa"
		self._lvFixa.Size = System.Drawing.Size(576, 261)
		self._lvFixa.SmallImageList = self._imageList1
		self._lvFixa.TabIndex = 1
		self._lvFixa.UseCompatibleStateImageBehavior = False
		self._lvFixa.View = System.Windows.Forms.View.Details
		self._lvFixa.ColumnClick += self.LvFixaColumnClick
		self._lvFixa.DoubleClick += self.LvFixaDoubleClick
		# 
		# columnHeader10
		# 
		self._columnHeader10.Text = "Nome"
		self._columnHeader10.Width = 300
		# 
		# columnHeader11
		# 
		self._columnHeader11.Text = "Tamanho"
		self._columnHeader11.Width = 100
		# 
		# columnHeader12
		# 
		self._columnHeader12.Text = "Tipo"
		self._columnHeader12.Width = 70
		# 
		# columnHeader13
		# 
		self._columnHeader13.Text = "Modificado"
		self._columnHeader13.Width = 120
		# 
		# columnHeader14
		# 
		self._columnHeader14.Text = "Atributos"
		self._columnHeader14.Width = 90
		# 
		# columnHeader15
		# 
		self._columnHeader15.Text = "Caminho"
		self._columnHeader15.Width = 300
		# 
		# imageList2
		# 
		#self._imageList2.ImageStream = resources.GetObject("imageList2.ImageStream")
		#self._imageList2.TransparentColor = System.Drawing.Color.Transparent
		#self._imageList2.Images.SetKeyName(0, "Fechar32.bmp")
		#self._imageList2.Images.SetKeyName(1, "Abrir32.bmp")
		#self._imageList2.Images.SetKeyName(2, "Arquivo32.bmp")
		# 
		# imageList3
		# 
		#self._imageList3.ImageStream = resources.GetObject("imageList3.ImageStream")
		#self._imageList3.TransparentColor = System.Drawing.Color.Magenta
		#self._imageList3.Images.SetKeyName(0, "cdouro.bmp")
		#self._imageList3.Images.SetKeyName(1, "cdprata.bmp")
		# 
		# lvPesquisa
		# 
		self._lvPesquisa.Columns.AddRange(System.Array[System.Windows.Forms.ColumnHeader](
			[self._columnHeader1,
			self._columnHeader2,
			self._columnHeader3,
			self._columnHeader4,
			self._columnHeader5,
			self._columnHeader6,
			self._columnHeader7]))
		self._lvPesquisa.Dock = System.Windows.Forms.DockStyle.Fill
		self._lvPesquisa.FullRowSelect = True
		self._lvPesquisa.GridLines = True
		self._lvPesquisa.LargeImageList = self._imageList2
		self._lvPesquisa.Location = System.Drawing.Point(0, 0)
		self._lvPesquisa.MultiSelect = False
		self._lvPesquisa.Name = "lvPesquisa"
		self._lvPesquisa.Size = System.Drawing.Size(884, 115)
		self._lvPesquisa.SmallImageList = self._imageList1
		self._lvPesquisa.TabIndex = 0
		self._lvPesquisa.UseCompatibleStateImageBehavior = False
		self._lvPesquisa.View = System.Windows.Forms.View.Details
		self._lvPesquisa.ColumnClick += self.LvPesquisaColumnClick
		self._lvPesquisa.Click += self.LvPesquisaClick
		# 
		# columnHeader1
		# 
		self._columnHeader1.Text = "Nome"
		self._columnHeader1.Width = 300
		# 
		# columnHeader2
		# 
		self._columnHeader2.Text = "Tamanho"
		self._columnHeader2.Width = 100
		# 
		# columnHeader3
		# 
		self._columnHeader3.Text = "Tipo"
		self._columnHeader3.Width = 70
		# 
		# columnHeader4
		# 
		self._columnHeader4.Text = "Modificado"
		self._columnHeader4.Width = 120
		# 
		# columnHeader5
		# 
		self._columnHeader5.Text = "Atributos"
		self._columnHeader5.Width = 90
		# 
		# columnHeader6
		# 
		self._columnHeader6.Text = "Caminho"
		self._columnHeader6.Width = 300
		# 
		# columnHeader7
		# 
		self._columnHeader7.Text = "Aba"
		self._columnHeader7.Width = 150
		# 
		# barraStatus
		# 
		self._barraStatus.Items.AddRange(System.Array[System.Windows.Forms.ToolStripItem](
			[self._labStatus1,
			self._labStatus2]))
		self._barraStatus.Location = System.Drawing.Point(0, 440)
		self._barraStatus.Name = "barraStatus"
		self._barraStatus.Size = System.Drawing.Size(884, 22)
		self._barraStatus.TabIndex = 3
		self._barraStatus.Text = "statusStrip1"
		# 
		# labStatus1
		# 
		self._labStatus1.AutoSize = False
		self._labStatus1.BorderSides = System.Windows.Forms.ToolStripStatusLabelBorderSides.Left | System.Windows.Forms.ToolStripStatusLabelBorderSides.Top | System.Windows.Forms.ToolStripStatusLabelBorderSides.Right | System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom
		self._labStatus1.BorderStyle = System.Windows.Forms.Border3DStyle.SunkenInner
		self._labStatus1.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
		self._labStatus1.Name = "labStatus1"
		self._labStatus1.Size = System.Drawing.Size(300, 17)
		self._labStatus1.Text = "Quantidade Total: , Tamanho Total:"
		self._labStatus1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		# 
		# labStatus2
		# 
		self._labStatus2.BorderSides = System.Windows.Forms.ToolStripStatusLabelBorderSides.Left | System.Windows.Forms.ToolStripStatusLabelBorderSides.Top | System.Windows.Forms.ToolStripStatusLabelBorderSides.Right | System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom
		self._labStatus2.BorderStyle = System.Windows.Forms.Border3DStyle.SunkenInner
		self._labStatus2.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
		self._labStatus2.Name = "labStatus2"
		self._labStatus2.Size = System.Drawing.Size(569, 17)
		self._labStatus2.Spring = True
		self._labStatus2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		# 
		# odImportar
		# 
		self._odImportar.DefaultExt = "xml"
		self._odImportar.Filter = "Arquivos XML (*.xml)|*.xml"
		# 
		# FrmPrincipal
		# 
		self.AutoScaleDimensions = System.Drawing.SizeF(6, 13)
		self.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		self.ClientSize = System.Drawing.Size(884, 462)
		self.Controls.Add(self._barraStatus)
		self.Controls.Add(self._spPesquisa)
		self.Controls.Add(self._barraFerra)
		self.Controls.Add(self._barraMenu)
		self.MainMenuStrip = self._barraMenu
		self.Name = "FrmPrincipal"
		self.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
		self.Text = "HFSGuardaDiretorio 2.0 - Catalogador de Diretórios"
		self.FormClosed += self.FrmPrincipalFormClosed
		self._barraMenu.ResumeLayout(False)
		self._barraMenu.PerformLayout()
		self._barraFerra.ResumeLayout(False)
		self._barraFerra.PerformLayout()
		self._spPesquisa.Panel1.ResumeLayout(False)
		self._spPesquisa.Panel2.ResumeLayout(False)
		self._spPesquisa.EndInit()
		self._spPesquisa.ResumeLayout(False)
		self._tabControl1.ResumeLayout(False)
		self._popupMenu.ResumeLayout(False)
		self._tabPage1.ResumeLayout(False)
		self._sp.Panel1.ResumeLayout(False)
		self._sp.Panel2.ResumeLayout(False)
		self._sp.EndInit()
		self._sp.ResumeLayout(False)
		self._barraStatus.ResumeLayout(False)
		self._barraStatus.PerformLayout()
		self.ResumeLayout(False)
		self.PerformLayout()

	def get_Catalogador(self):
		return self._catalogador

	Catalogador = property(fget=get_Catalogador)

	def MenuIncluirNovaAbaClick(self, sender, e):
		self._catalogador.IncluirNovaAba()

	def MenuAlterarNomeAbaAtivaClick(self, sender, e):
		self._catalogador.AlterarNomeAbaAtiva(self._frmPrincipalProgresso)

	def MenuExcluirAbaAtivaClick(self, sender, e):
		self._catalogador.ExcluirAbaAtiva(self._frmPrincipalProgresso)

	def MenuImportarDiretorioClick(self, sender, e):
		self._catalogador.ComecaImportacao(False, self._frmPrincipalProgresso)

	def MenuImportarSubDiretoriosClick(self, sender, e):
		self._catalogador.ComecaImportacao(True, self._frmPrincipalProgresso)

	def MenuCadastrarExtensaoArquivoClick(self, sender, e):
		frmCadExtensao = FrmCadExtensao(self)
		frmCadExtensao.ShowDialog()

	def MenuCompararDiretoriosClick(self, sender, e):
		frmCompararDiretorio = FrmCompararDiretorio(self)
		frmCompararDiretorio.ShowDialog()

	def MenuSobreCatalogadorClick(self, sender, e):
		frmSobre = FrmSobre.FrmSobre()
		frmSobre.ShowDialog()

	def MenuExpandirDiretoriosClick(self, sender, e):
		self._catalogador.getArvoreAtual().ExpandAll()

	def MenuColapsarDiretoriosClick(self, sender, e):
		self._catalogador.getArvoreAtual().CollapseAll()

	def MenuTXTClick(self, sender, e):
		self._catalogador.ExportarArquivo(TipoExportar.teTXT, self._frmPrincipalProgresso)

	def MenuCSVClick(self, sender, e):
		self._catalogador.ExportarArquivo(TipoExportar.teCSV, self._frmPrincipalProgresso)

	def MenuHTMLClick(self, sender, e):
		self._catalogador.ExportarArquivo(TipoExportar.teHTML, self._frmPrincipalProgresso)

	def MenuXMLClick(self, sender, e):
		self._catalogador.ExportarArquivo(TipoExportar.teXML, self._frmPrincipalProgresso)

	def MenuSQLClick(self, sender, e):
		self._catalogador.ExportarArquivo(TipoExportar.teSQL, self._frmPrincipalProgresso)

	def MenuImportarDiretoriosViaXMLClick(self, sender, e):
		log = StringList()
		self._catalogador.ImportarArquivo(log, self._frmPrincipalProgresso)

	def MenuMostrarOcultArvoreDirAbaAtivaClick(self, sender, e):
		self._catalogador.mostrarOcultarArvore()

	def MenuMostrarOcultarListaItensPesquisadosClick(self, sender, e):
		spPesquisa.Panel2Collapsed = not spPesquisa.Panel2Collapsed

	def BtnImportarDiretorioClick(self, sender, e):
		self.MenuImportarDiretorioClick(sender, e)

	def BtnPesquisarClick(self, sender, e):
		self._catalogador.Pesquisar()

	def FrmPrincipalFormClosed(self, sender, e):
		#Rotinas.Desconectar()
		pass

	def MenuInformacoesDiretorioArquivoClick(self, sender, e):
		self._catalogador.InformacoesDiretorioArquivo()

	def MenuExcluirDiretorioSelecionadoClick(self, sender, e):
		self._catalogador.ExcluirDiretorioSelecionado(self._frmPrincipalProgresso)

	def MenuIconesClick(self, sender, e):
		self._catalogador.getTabelaAtual().View = View.LargeIcon

	def MenuListaClick(self, sender, e):
		self._catalogador.getTabelaAtual().View = View.List

	def MenuDetalhesClick(self, sender, e):
		self._catalogador.getTabelaAtual().View = View.Details

	def MenuIconesPequenosClick(self, sender, e):
		self._catalogador.getTabelaAtual().View = View.SmallIcon

	def MenuExpandirDiretorios2Click(self, sender, e):
		self.MenuExpandirDiretoriosClick(sender, e)

	def MenuColapsarDiretorios2Click(self, sender, e):
		self.MenuColapsarDiretoriosClick(sender, e)

	def MenuIncluirNovaAba2Click(self, sender, e):
		self.MenuIncluirNovaAbaClick(sender, e)

	def MenuAlterarNomeAbaAtiva2Click(self, sender, e):
		self.MenuAlterarNomeAbaAtivaClick(sender, e)

	def MenuExcluirAbaAtiva2Click(self, sender, e):
		self.MenuExcluirAbaAtivaClick(sender, e)

	def TabControl1SelectedIndexChanged(self, sender, e):
		self._catalogador.tabPanelMudou()

	def LvFixaDoubleClick(self, sender, e):
		lvTabela = sender
		if lvTabela.SelectedItems.Count > 0:
			nome = lvTabela.SelectedItems[0].Text
			tipo = lvTabela.SelectedItems[0].SubItems[2].Text
			self._catalogador.DuploCliqueLista(nome, tipo)

	def LvFixaColumnClick(self, sender, e):
		lvTabela = sender
		self._colOrdem = self._catalogador.listaCompara(lvTabela, e.Column, self._colOrdem)

	def LvPesquisaColumnClick(self, sender, e):
		lvTabela = sender
		self._colOrdem = self._catalogador.listaCompara(lvTabela, e.Column, self._colOrdem)

	def LvPesquisaClick(self, sender, e):
		lvPesquisa = sender
		if lvPesquisa.SelectedItems.Count > 0:
			nome = lvPesquisa.SelectedItems[0].Text
			caminho = lvPesquisa.SelectedItems[0].SubItems[5].Text
			nomeAba = lvPesquisa.SelectedItems[0].SubItems[6].Text
			self._catalogador.EncontrarItemLista(nomeAba, nome, caminho)

	def TvFixaAfterSelect(self, sender, e):
		lvTabela = self._catalogador.getTabelaAtual()
		self._catalogador.ListarArquivos(lvTabela, e.Node)