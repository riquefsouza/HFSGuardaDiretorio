/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 10/12/2014
 * Time: 17:39
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */

namespace HFSGuardaDiretorio.gui

partial internal class FrmPrincipal:

	private components as System.ComponentModel.IContainer = null

	
	protected override def Dispose(disposing as bool):
		if disposing:
			if components is not null:
				components.Dispose()
		super.Dispose(disposing)

	
	private def InitializeComponent():
		self.components = System.ComponentModel.Container()
		resources as System.ComponentModel.ComponentResourceManager = System.ComponentModel.ComponentResourceManager(typeof(FrmPrincipal))
		self.barraMenu = System.Windows.Forms.MenuStrip()
		self.menuAba = System.Windows.Forms.ToolStripMenuItem()
		self.menuIncluirNovaAba = System.Windows.Forms.ToolStripMenuItem()
		self.menuAlterarNomeAbaAtiva = System.Windows.Forms.ToolStripMenuItem()
		self.menuExcluirAbaAtiva = System.Windows.Forms.ToolStripMenuItem()
		self.menuDiretorio = System.Windows.Forms.ToolStripMenuItem()
		self.menuImportarDiretorio = System.Windows.Forms.ToolStripMenuItem()
		self.menuImportarSubDiretorios = System.Windows.Forms.ToolStripMenuItem()
		self.menuCompararDiretorios = System.Windows.Forms.ToolStripMenuItem()
		self.menuCadastrarExtensaoArquivo = System.Windows.Forms.ToolStripMenuItem()
		self.toolStripSeparator1 = System.Windows.Forms.ToolStripSeparator()
		self.menuExpandirDiretorios = System.Windows.Forms.ToolStripMenuItem()
		self.menuColapsarDiretorios = System.Windows.Forms.ToolStripMenuItem()
		self.menuExportarDiretoriosAbaAtiva = System.Windows.Forms.ToolStripMenuItem()
		self.menuTXT = System.Windows.Forms.ToolStripMenuItem()
		self.menuCSV = System.Windows.Forms.ToolStripMenuItem()
		self.menuHTML = System.Windows.Forms.ToolStripMenuItem()
		self.menuXML = System.Windows.Forms.ToolStripMenuItem()
		self.menuSQL = System.Windows.Forms.ToolStripMenuItem()
		self.menuImportarDiretoriosViaXML = System.Windows.Forms.ToolStripMenuItem()
		self.menuGravarLogImportacao = System.Windows.Forms.ToolStripMenuItem()
		self.menuVisao = System.Windows.Forms.ToolStripMenuItem()
		self.menuMostrarOcultArvoreDirAbaAtiva = System.Windows.Forms.ToolStripMenuItem()
		self.menuMostrarOcultarListaItensPesquisados = System.Windows.Forms.ToolStripMenuItem()
		self.menuModoExibicao = System.Windows.Forms.ToolStripMenuItem()
		self.menuIcones = System.Windows.Forms.ToolStripMenuItem()
		self.menuLista = System.Windows.Forms.ToolStripMenuItem()
		self.menuDetalhes = System.Windows.Forms.ToolStripMenuItem()
		self.menuIconesPequenos = System.Windows.Forms.ToolStripMenuItem()
		self.menuSobre = System.Windows.Forms.ToolStripMenuItem()
		self.menuSobreCatalogador = System.Windows.Forms.ToolStripMenuItem()
		self.barraFerra = System.Windows.Forms.ToolStrip()
		self.btnImportarDiretorio = System.Windows.Forms.ToolStripButton()
		self.pb = System.Windows.Forms.ToolStripProgressBar()
		self.edtPesquisa = System.Windows.Forms.ToolStripTextBox()
		self.btnPesquisar = System.Windows.Forms.ToolStripButton()
		self.spPesquisa = System.Windows.Forms.SplitContainer()
		self.tabControl1 = System.Windows.Forms.TabControl()
		self.popupMenu = System.Windows.Forms.ContextMenuStrip(self.components)
		self.menuInformacoesDiretorioArquivo = System.Windows.Forms.ToolStripMenuItem()
		self.menuExcluirDiretorioSelecionado = System.Windows.Forms.ToolStripMenuItem()
		self.menuExpandirDiretorios2 = System.Windows.Forms.ToolStripMenuItem()
		self.menuColapsarDiretorios2 = System.Windows.Forms.ToolStripMenuItem()
		self.toolStripSeparator2 = System.Windows.Forms.ToolStripSeparator()
		self.menuIncluirNovaAba2 = System.Windows.Forms.ToolStripMenuItem()
		self.menuAlterarNomeAbaAtiva2 = System.Windows.Forms.ToolStripMenuItem()
		self.menuExcluirAbaAtiva2 = System.Windows.Forms.ToolStripMenuItem()
		self.tabPage1 = System.Windows.Forms.TabPage()
		self.sp = System.Windows.Forms.SplitContainer()
		self.tvFixa = System.Windows.Forms.TreeView()
		self.imageList1 = System.Windows.Forms.ImageList(self.components)
		self.lvFixa = System.Windows.Forms.ListView()
		self.columnHeader10 = System.Windows.Forms.ColumnHeader()
		self.columnHeader11 = System.Windows.Forms.ColumnHeader()
		self.columnHeader12 = System.Windows.Forms.ColumnHeader()
		self.columnHeader13 = System.Windows.Forms.ColumnHeader()
		self.columnHeader14 = System.Windows.Forms.ColumnHeader()
		self.columnHeader15 = System.Windows.Forms.ColumnHeader()
		self.imageList2 = System.Windows.Forms.ImageList(self.components)
		self.imageList3 = System.Windows.Forms.ImageList(self.components)
		self.lvPesquisa = System.Windows.Forms.ListView()
		self.columnHeader1 = System.Windows.Forms.ColumnHeader()
		self.columnHeader2 = System.Windows.Forms.ColumnHeader()
		self.columnHeader3 = System.Windows.Forms.ColumnHeader()
		self.columnHeader4 = System.Windows.Forms.ColumnHeader()
		self.columnHeader5 = System.Windows.Forms.ColumnHeader()
		self.columnHeader6 = System.Windows.Forms.ColumnHeader()
		self.columnHeader7 = System.Windows.Forms.ColumnHeader()
		self.barraStatus = System.Windows.Forms.StatusStrip()
		self.labStatus1 = System.Windows.Forms.ToolStripStatusLabel()
		self.labStatus2 = System.Windows.Forms.ToolStripStatusLabel()
		self.odImportar = System.Windows.Forms.OpenFileDialog()
		self.sdExportar = System.Windows.Forms.SaveFileDialog()
		self.escolherDir = System.Windows.Forms.FolderBrowserDialog()
		self.barraMenu.SuspendLayout()
		self.barraFerra.SuspendLayout()
		(self.spPesquisa cast System.ComponentModel.ISupportInitialize).BeginInit()
		self.spPesquisa.Panel1.SuspendLayout()
		self.spPesquisa.Panel2.SuspendLayout()
		self.spPesquisa.SuspendLayout()
		self.tabControl1.SuspendLayout()
		self.popupMenu.SuspendLayout()
		self.tabPage1.SuspendLayout()
		(self.sp cast System.ComponentModel.ISupportInitialize).BeginInit()
		self.sp.Panel1.SuspendLayout()
		self.sp.Panel2.SuspendLayout()
		self.sp.SuspendLayout()
		self.barraStatus.SuspendLayout()
		self.SuspendLayout()
		// 
		// barraMenu
		// 
		self.barraMenu.Items.AddRange((of System.Windows.Forms.ToolStripItem: self.menuAba, self.menuDiretorio, self.menuVisao, self.menuSobre))
		self.barraMenu.Location = System.Drawing.Point(0, 0)
		self.barraMenu.Name = 'barraMenu'
		self.barraMenu.Size = System.Drawing.Size(884, 24)
		self.barraMenu.TabIndex = 0
		self.barraMenu.Text = 'menuStrip1'
		// 
		// menuAba
		// 
		self.menuAba.DropDownItems.AddRange((of System.Windows.Forms.ToolStripItem: self.menuIncluirNovaAba, self.menuAlterarNomeAbaAtiva, self.menuExcluirAbaAtiva))
		self.menuAba.Name = 'menuAba'
		self.menuAba.Size = System.Drawing.Size(40, 20)
		self.menuAba.Text = '&Aba'
		// 
		// menuIncluirNovaAba
		// 
		self.menuIncluirNovaAba.Name = 'menuIncluirNovaAba'
		self.menuIncluirNovaAba.Size = System.Drawing.Size(215, 22)
		self.menuIncluirNovaAba.Text = 'Incluir Nova Aba'
		self.menuIncluirNovaAba.Click += self.MenuIncluirNovaAbaClick
		// 
		// menuAlterarNomeAbaAtiva
		// 
		self.menuAlterarNomeAbaAtiva.Name = 'menuAlterarNomeAbaAtiva'
		self.menuAlterarNomeAbaAtiva.Size = System.Drawing.Size(215, 22)
		self.menuAlterarNomeAbaAtiva.Text = 'Alterar Nome da Aba Ativa'
		self.menuAlterarNomeAbaAtiva.Click += self.MenuAlterarNomeAbaAtivaClick
		// 
		// menuExcluirAbaAtiva
		// 
		self.menuExcluirAbaAtiva.Name = 'menuExcluirAbaAtiva'
		self.menuExcluirAbaAtiva.Size = System.Drawing.Size(215, 22)
		self.menuExcluirAbaAtiva.Text = 'Excluir Aba Ativa'
		self.menuExcluirAbaAtiva.Click += self.MenuExcluirAbaAtivaClick
		// 
		// menuDiretorio
		// 
		self.menuDiretorio.DropDownItems.AddRange((of System.Windows.Forms.ToolStripItem: self.menuImportarDiretorio, self.menuImportarSubDiretorios, self.menuCompararDiretorios, self.menuCadastrarExtensaoArquivo, self.toolStripSeparator1, self.menuExpandirDiretorios, self.menuColapsarDiretorios, self.menuExportarDiretoriosAbaAtiva, self.menuImportarDiretoriosViaXML, self.menuGravarLogImportacao))
		self.menuDiretorio.Name = 'menuDiretorio'
		self.menuDiretorio.Size = System.Drawing.Size(65, 20)
		self.menuDiretorio.Text = '&Diretório'
		// 
		// menuImportarDiretorio
		// 
		self.menuImportarDiretorio.Name = 'menuImportarDiretorio'
		self.menuImportarDiretorio.Size = System.Drawing.Size(241, 22)
		self.menuImportarDiretorio.Text = 'Importar Diretório'
		self.menuImportarDiretorio.Click += self.MenuImportarDiretorioClick
		// 
		// menuImportarSubDiretorios
		// 
		self.menuImportarSubDiretorios.Name = 'menuImportarSubDiretorios'
		self.menuImportarSubDiretorios.Size = System.Drawing.Size(241, 22)
		self.menuImportarSubDiretorios.Text = 'Importar SubDiretórios'
		self.menuImportarSubDiretorios.Click += self.MenuImportarSubDiretoriosClick
		// 
		// menuCompararDiretorios
		// 
		self.menuCompararDiretorios.Name = 'menuCompararDiretorios'
		self.menuCompararDiretorios.Size = System.Drawing.Size(241, 22)
		self.menuCompararDiretorios.Text = 'Comparar Diretórios'
		self.menuCompararDiretorios.Click += self.MenuCompararDiretoriosClick
		// 
		// menuCadastrarExtensaoArquivo
		// 
		self.menuCadastrarExtensaoArquivo.Name = 'menuCadastrarExtensaoArquivo'
		self.menuCadastrarExtensaoArquivo.Size = System.Drawing.Size(241, 22)
		self.menuCadastrarExtensaoArquivo.Text = 'Cadastrar Extensão de Arquivo'
		self.menuCadastrarExtensaoArquivo.Click += self.MenuCadastrarExtensaoArquivoClick
		// 
		// toolStripSeparator1
		// 
		self.toolStripSeparator1.Name = 'toolStripSeparator1'
		self.toolStripSeparator1.Size = System.Drawing.Size(238, 6)
		// 
		// menuExpandirDiretorios
		// 
		self.menuExpandirDiretorios.Name = 'menuExpandirDiretorios'
		self.menuExpandirDiretorios.Size = System.Drawing.Size(241, 22)
		self.menuExpandirDiretorios.Text = 'Expandir Diretórios'
		self.menuExpandirDiretorios.Click += self.MenuExpandirDiretoriosClick
		// 
		// menuColapsarDiretorios
		// 
		self.menuColapsarDiretorios.Name = 'menuColapsarDiretorios'
		self.menuColapsarDiretorios.Size = System.Drawing.Size(241, 22)
		self.menuColapsarDiretorios.Text = 'Colapsar Diretórios'
		self.menuColapsarDiretorios.Click += self.MenuColapsarDiretoriosClick
		// 
		// menuExportarDiretoriosAbaAtiva
		// 
		self.menuExportarDiretoriosAbaAtiva.DropDownItems.AddRange((of System.Windows.Forms.ToolStripItem: self.menuTXT, self.menuCSV, self.menuHTML, self.menuXML, self.menuSQL))
		self.menuExportarDiretoriosAbaAtiva.Name = 'menuExportarDiretoriosAbaAtiva'
		self.menuExportarDiretoriosAbaAtiva.Size = System.Drawing.Size(241, 22)
		self.menuExportarDiretoriosAbaAtiva.Text = 'Exportar Diretórios da Aba Ativa'
		// 
		// menuTXT
		// 
		self.menuTXT.Name = 'menuTXT'
		self.menuTXT.Size = System.Drawing.Size(107, 22)
		self.menuTXT.Text = 'TXT'
		self.menuTXT.Click += self.MenuTXTClick
		// 
		// menuCSV
		// 
		self.menuCSV.Name = 'menuCSV'
		self.menuCSV.Size = System.Drawing.Size(107, 22)
		self.menuCSV.Text = 'CSV'
		self.menuCSV.Click += self.MenuCSVClick
		// 
		// menuHTML
		// 
		self.menuHTML.Name = 'menuHTML'
		self.menuHTML.Size = System.Drawing.Size(107, 22)
		self.menuHTML.Text = 'HTML'
		self.menuHTML.Click += self.MenuHTMLClick
		// 
		// menuXML
		// 
		self.menuXML.Name = 'menuXML'
		self.menuXML.Size = System.Drawing.Size(107, 22)
		self.menuXML.Text = 'XML'
		self.menuXML.Click += self.MenuXMLClick
		// 
		// menuSQL
		// 
		self.menuSQL.Name = 'menuSQL'
		self.menuSQL.Size = System.Drawing.Size(107, 22)
		self.menuSQL.Text = 'SQL'
		self.menuSQL.Click += self.MenuSQLClick
		// 
		// menuImportarDiretoriosViaXML
		// 
		self.menuImportarDiretoriosViaXML.Name = 'menuImportarDiretoriosViaXML'
		self.menuImportarDiretoriosViaXML.Size = System.Drawing.Size(241, 22)
		self.menuImportarDiretoriosViaXML.Text = 'Importar Diretórios via XML'
		self.menuImportarDiretoriosViaXML.Click += self.MenuImportarDiretoriosViaXMLClick
		// 
		// menuGravarLogImportacao
		// 
		self.menuGravarLogImportacao.CheckOnClick = true
		self.menuGravarLogImportacao.Name = 'menuGravarLogImportacao'
		self.menuGravarLogImportacao.Size = System.Drawing.Size(241, 22)
		self.menuGravarLogImportacao.Text = 'Gravar Log da Importação'
		// 
		// menuVisao
		// 
		self.menuVisao.DropDownItems.AddRange((of System.Windows.Forms.ToolStripItem: self.menuMostrarOcultArvoreDirAbaAtiva, self.menuMostrarOcultarListaItensPesquisados, self.menuModoExibicao))
		self.menuVisao.Name = 'menuVisao'
		self.menuVisao.Size = System.Drawing.Size(47, 20)
		self.menuVisao.Text = '&Visão'
		// 
		// menuMostrarOcultArvoreDirAbaAtiva
		// 
		self.menuMostrarOcultArvoreDirAbaAtiva.Name = 'menuMostrarOcultArvoreDirAbaAtiva'
		self.menuMostrarOcultArvoreDirAbaAtiva.Size = System.Drawing.Size(334, 22)
		self.menuMostrarOcultArvoreDirAbaAtiva.Text = 'Mostrar/Ocultar árvore de diretórios da Aba Ativa'
		self.menuMostrarOcultArvoreDirAbaAtiva.Click += self.MenuMostrarOcultArvoreDirAbaAtivaClick
		// 
		// menuMostrarOcultarListaItensPesquisados
		// 
		self.menuMostrarOcultarListaItensPesquisados.Name = 'menuMostrarOcultarListaItensPesquisados'
		self.menuMostrarOcultarListaItensPesquisados.Size = System.Drawing.Size(334, 22)
		self.menuMostrarOcultarListaItensPesquisados.Text = 'Mostrar/Ocultar lista de itens pesquisados'
		self.menuMostrarOcultarListaItensPesquisados.Click += self.MenuMostrarOcultarListaItensPesquisadosClick
		// 
		// menuModoExibicao
		// 
		self.menuModoExibicao.DropDownItems.AddRange((of System.Windows.Forms.ToolStripItem: self.menuIcones, self.menuLista, self.menuDetalhes, self.menuIconesPequenos))
		self.menuModoExibicao.Name = 'menuModoExibicao'
		self.menuModoExibicao.Size = System.Drawing.Size(334, 22)
		self.menuModoExibicao.Text = 'Modo de Exibição'
		// 
		// menuIcones
		// 
		self.menuIcones.Name = 'menuIcones'
		self.menuIcones.Size = System.Drawing.Size(163, 22)
		self.menuIcones.Text = 'Ícones'
		self.menuIcones.Click += self.MenuIconesClick
		// 
		// menuLista
		// 
		self.menuLista.Name = 'menuLista'
		self.menuLista.Size = System.Drawing.Size(163, 22)
		self.menuLista.Text = 'Lista'
		self.menuLista.Click += self.MenuListaClick
		// 
		// menuDetalhes
		// 
		self.menuDetalhes.Name = 'menuDetalhes'
		self.menuDetalhes.Size = System.Drawing.Size(163, 22)
		self.menuDetalhes.Text = 'Detalhes'
		self.menuDetalhes.Click += self.MenuDetalhesClick
		// 
		// menuIconesPequenos
		// 
		self.menuIconesPequenos.Name = 'menuIconesPequenos'
		self.menuIconesPequenos.Size = System.Drawing.Size(163, 22)
		self.menuIconesPequenos.Text = 'Ícones Pequenos'
		self.menuIconesPequenos.Click += self.MenuIconesPequenosClick
		// 
		// menuSobre
		// 
		self.menuSobre.DropDownItems.AddRange((of System.Windows.Forms.ToolStripItem: self.menuSobreCatalogador))
		self.menuSobre.Name = 'menuSobre'
		self.menuSobre.Size = System.Drawing.Size(49, 20)
		self.menuSobre.Text = '&Sobre'
		// 
		// menuSobreCatalogador
		// 
		self.menuSobreCatalogador.Name = 'menuSobreCatalogador'
		self.menuSobreCatalogador.Size = System.Drawing.Size(182, 22)
		self.menuSobreCatalogador.Text = 'Sobre o Catalogador'
		self.menuSobreCatalogador.Click += self.MenuSobreCatalogadorClick
		// 
		// barraFerra
		// 
		self.barraFerra.GripStyle = System.Windows.Forms.ToolStripGripStyle.Hidden
		self.barraFerra.Items.AddRange((of System.Windows.Forms.ToolStripItem: self.btnImportarDiretorio, self.pb, self.edtPesquisa, self.btnPesquisar))
		self.barraFerra.Location = System.Drawing.Point(0, 24)
		self.barraFerra.Name = 'barraFerra'
		self.barraFerra.Size = System.Drawing.Size(884, 25)
		self.barraFerra.Stretch = true
		self.barraFerra.TabIndex = 1
		// 
		// btnImportarDiretorio
		// 
		self.btnImportarDiretorio.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
		self.btnImportarDiretorio.Image = (resources.GetObject('btnImportarDiretorio.Image') cast System.Drawing.Image)
		self.btnImportarDiretorio.ImageTransparentColor = System.Drawing.Color.Magenta
		self.btnImportarDiretorio.Name = 'btnImportarDiretorio'
		self.btnImportarDiretorio.Size = System.Drawing.Size(106, 22)
		self.btnImportarDiretorio.Text = '&Importar Diretório'
		self.btnImportarDiretorio.Click += self.BtnImportarDiretorioClick
		// 
		// pb
		// 
		self.pb.AutoSize = false
		self.pb.Name = 'pb'
		self.pb.Size = System.Drawing.Size(385, 22)
		self.pb.Step = 0
		// 
		// edtPesquisa
		// 
		self.edtPesquisa.AutoSize = false
		self.edtPesquisa.MaxLength = 255
		self.edtPesquisa.Name = 'edtPesquisa'
		self.edtPesquisa.Size = System.Drawing.Size(288, 25)
		self.edtPesquisa.ToolTipText = 'Digite aqui para pesquisar'
		// 
		// btnPesquisar
		// 
		self.btnPesquisar.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
		self.btnPesquisar.Image = (resources.GetObject('btnPesquisar.Image') cast System.Drawing.Image)
		self.btnPesquisar.ImageTransparentColor = System.Drawing.Color.Magenta
		self.btnPesquisar.Name = 'btnPesquisar'
		self.btnPesquisar.Size = System.Drawing.Size(61, 22)
		self.btnPesquisar.Text = '&Pesquisar'
		self.btnPesquisar.Click += self.BtnPesquisarClick
		// 
		// spPesquisa
		// 
		self.spPesquisa.Dock = System.Windows.Forms.DockStyle.Fill
		self.spPesquisa.Location = System.Drawing.Point(0, 49)
		self.spPesquisa.Name = 'spPesquisa'
		self.spPesquisa.Orientation = System.Windows.Forms.Orientation.Horizontal
		// 
		// spPesquisa.Panel1
		// 
		self.spPesquisa.Panel1.Controls.Add(self.tabControl1)
		// 
		// spPesquisa.Panel2
		// 
		self.spPesquisa.Panel2.Controls.Add(self.lvPesquisa)
		self.spPesquisa.Size = System.Drawing.Size(884, 413)
		self.spPesquisa.SplitterDistance = 294
		self.spPesquisa.TabIndex = 2
		// 
		// tabControl1
		// 
		self.tabControl1.ContextMenuStrip = self.popupMenu
		self.tabControl1.Controls.Add(self.tabPage1)
		self.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill
		self.tabControl1.ImageList = self.imageList3
		self.tabControl1.Location = System.Drawing.Point(0, 0)
		self.tabControl1.Name = 'tabControl1'
		self.tabControl1.SelectedIndex = 0
		self.tabControl1.Size = System.Drawing.Size(884, 294)
		self.tabControl1.TabIndex = 0
		self.tabControl1.SelectedIndexChanged += self.TabControl1SelectedIndexChanged
		// 
		// popupMenu
		// 
		self.popupMenu.Items.AddRange((of System.Windows.Forms.ToolStripItem: self.menuInformacoesDiretorioArquivo, self.menuExcluirDiretorioSelecionado, self.menuExpandirDiretorios2, self.menuColapsarDiretorios2, self.toolStripSeparator2, self.menuIncluirNovaAba2, self.menuAlterarNomeAbaAtiva2, self.menuExcluirAbaAtiva2))
		self.popupMenu.Name = 'popupMenu'
		self.popupMenu.Size = System.Drawing.Size(260, 164)
		// 
		// menuInformacoesDiretorioArquivo
		// 
		self.menuInformacoesDiretorioArquivo.Name = 'menuInformacoesDiretorioArquivo'
		self.menuInformacoesDiretorioArquivo.Size = System.Drawing.Size(259, 22)
		self.menuInformacoesDiretorioArquivo.Text = 'Informações do Diretório / Arquivo'
		self.menuInformacoesDiretorioArquivo.Click += self.MenuInformacoesDiretorioArquivoClick
		// 
		// menuExcluirDiretorioSelecionado
		// 
		self.menuExcluirDiretorioSelecionado.Name = 'menuExcluirDiretorioSelecionado'
		self.menuExcluirDiretorioSelecionado.Size = System.Drawing.Size(259, 22)
		self.menuExcluirDiretorioSelecionado.Text = 'Excluir Diretório Selecionado'
		self.menuExcluirDiretorioSelecionado.Click += self.MenuExcluirDiretorioSelecionadoClick
		// 
		// menuExpandirDiretorios2
		// 
		self.menuExpandirDiretorios2.Name = 'menuExpandirDiretorios2'
		self.menuExpandirDiretorios2.Size = System.Drawing.Size(259, 22)
		self.menuExpandirDiretorios2.Text = 'Expandir Diretórios'
		self.menuExpandirDiretorios2.Click += self.MenuExpandirDiretorios2Click
		// 
		// menuColapsarDiretorios2
		// 
		self.menuColapsarDiretorios2.Name = 'menuColapsarDiretorios2'
		self.menuColapsarDiretorios2.Size = System.Drawing.Size(259, 22)
		self.menuColapsarDiretorios2.Text = 'Colapsar Diretórios'
		self.menuColapsarDiretorios2.Click += self.MenuColapsarDiretorios2Click
		// 
		// toolStripSeparator2
		// 
		self.toolStripSeparator2.Name = 'toolStripSeparator2'
		self.toolStripSeparator2.Size = System.Drawing.Size(256, 6)
		// 
		// menuIncluirNovaAba2
		// 
		self.menuIncluirNovaAba2.Name = 'menuIncluirNovaAba2'
		self.menuIncluirNovaAba2.Size = System.Drawing.Size(259, 22)
		self.menuIncluirNovaAba2.Text = 'Incluir nova aba'
		self.menuIncluirNovaAba2.Click += self.MenuIncluirNovaAba2Click
		// 
		// menuAlterarNomeAbaAtiva2
		// 
		self.menuAlterarNomeAbaAtiva2.Name = 'menuAlterarNomeAbaAtiva2'
		self.menuAlterarNomeAbaAtiva2.Size = System.Drawing.Size(259, 22)
		self.menuAlterarNomeAbaAtiva2.Text = 'Alterar nome da aba ativa'
		self.menuAlterarNomeAbaAtiva2.Click += self.MenuAlterarNomeAbaAtiva2Click
		// 
		// menuExcluirAbaAtiva2
		// 
		self.menuExcluirAbaAtiva2.Name = 'menuExcluirAbaAtiva2'
		self.menuExcluirAbaAtiva2.Size = System.Drawing.Size(259, 22)
		self.menuExcluirAbaAtiva2.Text = 'Excluir aba ativa'
		self.menuExcluirAbaAtiva2.Click += self.MenuExcluirAbaAtiva2Click
		// 
		// tabPage1
		// 
		self.tabPage1.Controls.Add(self.sp)
		self.tabPage1.ImageIndex = 0
		self.tabPage1.Location = System.Drawing.Point(4, 23)
		self.tabPage1.Name = 'tabPage1'
		self.tabPage1.Padding = System.Windows.Forms.Padding(3)
		self.tabPage1.Size = System.Drawing.Size(876, 267)
		self.tabPage1.TabIndex = 0
		self.tabPage1.Text = 'DISCO1'
		self.tabPage1.UseVisualStyleBackColor = true
		// 
		// sp
		// 
		self.sp.Dock = System.Windows.Forms.DockStyle.Fill
		self.sp.Location = System.Drawing.Point(3, 3)
		self.sp.Name = 'sp'
		// 
		// sp.Panel1
		// 
		self.sp.Panel1.Controls.Add(self.tvFixa)
		// 
		// sp.Panel2
		// 
		self.sp.Panel2.Controls.Add(self.lvFixa)
		self.sp.Size = System.Drawing.Size(870, 261)
		self.sp.SplitterDistance = 290
		self.sp.TabIndex = 0
		// 
		// tvFixa
		// 
		self.tvFixa.Dock = System.Windows.Forms.DockStyle.Fill
		self.tvFixa.FullRowSelect = true
		self.tvFixa.HideSelection = false
		self.tvFixa.ImageIndex = 0
		self.tvFixa.ImageList = self.imageList1
		self.tvFixa.Location = System.Drawing.Point(0, 0)
		self.tvFixa.Name = 'tvFixa'
		self.tvFixa.SelectedImageIndex = 1
		self.tvFixa.Size = System.Drawing.Size(290, 261)
		self.tvFixa.TabIndex = 0
		self.tvFixa.AfterSelect += self.TvFixaAfterSelect
		// 
		// imageList1
		// 
		self.imageList1.ImageStream = (resources.GetObject('imageList1.ImageStream') cast System.Windows.Forms.ImageListStreamer)
		self.imageList1.TransparentColor = System.Drawing.Color.Transparent
		self.imageList1.Images.SetKeyName(0, 'Fechar.bmp')
		self.imageList1.Images.SetKeyName(1, 'Abrir.bmp')
		self.imageList1.Images.SetKeyName(2, 'Arquivo.bmp')
		// 
		// lvFixa
		// 
		self.lvFixa.Columns.AddRange((of System.Windows.Forms.ColumnHeader: self.columnHeader10, self.columnHeader11, self.columnHeader12, self.columnHeader13, self.columnHeader14, self.columnHeader15))
		self.lvFixa.Dock = System.Windows.Forms.DockStyle.Fill
		self.lvFixa.FullRowSelect = true
		self.lvFixa.GridLines = true
		self.lvFixa.LargeImageList = self.imageList2
		self.lvFixa.Location = System.Drawing.Point(0, 0)
		self.lvFixa.MultiSelect = false
		self.lvFixa.Name = 'lvFixa'
		self.lvFixa.Size = System.Drawing.Size(576, 261)
		self.lvFixa.SmallImageList = self.imageList1
		self.lvFixa.TabIndex = 1
		self.lvFixa.UseCompatibleStateImageBehavior = false
		self.lvFixa.View = System.Windows.Forms.View.Details
		self.lvFixa.ColumnClick += self.LvFixaColumnClick
		self.lvFixa.DoubleClick += self.LvFixaDoubleClick
		// 
		// columnHeader10
		// 
		self.columnHeader10.Text = 'Nome'
		self.columnHeader10.Width = 300
		// 
		// columnHeader11
		// 
		self.columnHeader11.Text = 'Tamanho'
		self.columnHeader11.Width = 100
		// 
		// columnHeader12
		// 
		self.columnHeader12.Text = 'Tipo'
		self.columnHeader12.Width = 70
		// 
		// columnHeader13
		// 
		self.columnHeader13.Text = 'Modificado'
		self.columnHeader13.Width = 120
		// 
		// columnHeader14
		// 
		self.columnHeader14.Text = 'Atributos'
		self.columnHeader14.Width = 90
		// 
		// columnHeader15
		// 
		self.columnHeader15.Text = 'Caminho'
		self.columnHeader15.Width = 300
		// 
		// imageList2
		// 
		self.imageList2.ImageStream = (resources.GetObject('imageList2.ImageStream') cast System.Windows.Forms.ImageListStreamer)
		self.imageList2.TransparentColor = System.Drawing.Color.Transparent
		self.imageList2.Images.SetKeyName(0, 'Fechar32.bmp')
		self.imageList2.Images.SetKeyName(1, 'Abrir32.bmp')
		self.imageList2.Images.SetKeyName(2, 'Arquivo32.bmp')
		// 
		// imageList3
		// 
		self.imageList3.ImageStream = (resources.GetObject('imageList3.ImageStream') cast System.Windows.Forms.ImageListStreamer)
		self.imageList3.TransparentColor = System.Drawing.Color.Magenta
		self.imageList3.Images.SetKeyName(0, 'cdouro.bmp')
		self.imageList3.Images.SetKeyName(1, 'cdprata.bmp')
		// 
		// lvPesquisa
		// 
		self.lvPesquisa.Columns.AddRange((of System.Windows.Forms.ColumnHeader: self.columnHeader1, self.columnHeader2, self.columnHeader3, self.columnHeader4, self.columnHeader5, self.columnHeader6, self.columnHeader7))
		self.lvPesquisa.Dock = System.Windows.Forms.DockStyle.Fill
		self.lvPesquisa.FullRowSelect = true
		self.lvPesquisa.GridLines = true
		self.lvPesquisa.LargeImageList = self.imageList2
		self.lvPesquisa.Location = System.Drawing.Point(0, 0)
		self.lvPesquisa.MultiSelect = false
		self.lvPesquisa.Name = 'lvPesquisa'
		self.lvPesquisa.Size = System.Drawing.Size(884, 115)
		self.lvPesquisa.SmallImageList = self.imageList1
		self.lvPesquisa.TabIndex = 0
		self.lvPesquisa.UseCompatibleStateImageBehavior = false
		self.lvPesquisa.View = System.Windows.Forms.View.Details
		self.lvPesquisa.ColumnClick += self.LvPesquisaColumnClick
		self.lvPesquisa.Click += self.LvPesquisaClick
		// 
		// columnHeader1
		// 
		self.columnHeader1.Text = 'Nome'
		self.columnHeader1.Width = 300
		// 
		// columnHeader2
		// 
		self.columnHeader2.Text = 'Tamanho'
		self.columnHeader2.Width = 100
		// 
		// columnHeader3
		// 
		self.columnHeader3.Text = 'Tipo'
		self.columnHeader3.Width = 70
		// 
		// columnHeader4
		// 
		self.columnHeader4.Text = 'Modificado'
		self.columnHeader4.Width = 120
		// 
		// columnHeader5
		// 
		self.columnHeader5.Text = 'Atributos'
		self.columnHeader5.Width = 90
		// 
		// columnHeader6
		// 
		self.columnHeader6.Text = 'Caminho'
		self.columnHeader6.Width = 300
		// 
		// columnHeader7
		// 
		self.columnHeader7.Text = 'Aba'
		self.columnHeader7.Width = 150
		// 
		// barraStatus
		// 
		self.barraStatus.Items.AddRange((of System.Windows.Forms.ToolStripItem: self.labStatus1, self.labStatus2))
		self.barraStatus.Location = System.Drawing.Point(0, 440)
		self.barraStatus.Name = 'barraStatus'
		self.barraStatus.Size = System.Drawing.Size(884, 22)
		self.barraStatus.TabIndex = 3
		self.barraStatus.Text = 'statusStrip1'
		// 
		// labStatus1
		// 
		self.labStatus1.AutoSize = false
		self.labStatus1.BorderSides = ((((System.Windows.Forms.ToolStripStatusLabelBorderSides.Left | System.Windows.Forms.ToolStripStatusLabelBorderSides.Top) | System.Windows.Forms.ToolStripStatusLabelBorderSides.Right) | System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom) cast System.Windows.Forms.ToolStripStatusLabelBorderSides)
		self.labStatus1.BorderStyle = System.Windows.Forms.Border3DStyle.SunkenInner
		self.labStatus1.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
		self.labStatus1.Name = 'labStatus1'
		self.labStatus1.Size = System.Drawing.Size(300, 17)
		self.labStatus1.Text = 'Quantidade Total: , Tamanho Total:'
		self.labStatus1.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		// 
		// labStatus2
		// 
		self.labStatus2.BorderSides = ((((System.Windows.Forms.ToolStripStatusLabelBorderSides.Left | System.Windows.Forms.ToolStripStatusLabelBorderSides.Top) | System.Windows.Forms.ToolStripStatusLabelBorderSides.Right) | System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom) cast System.Windows.Forms.ToolStripStatusLabelBorderSides)
		self.labStatus2.BorderStyle = System.Windows.Forms.Border3DStyle.SunkenInner
		self.labStatus2.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
		self.labStatus2.Name = 'labStatus2'
		self.labStatus2.Size = System.Drawing.Size(569, 17)
		self.labStatus2.Spring = true
		self.labStatus2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
		// 
		// odImportar
		// 
		self.odImportar.DefaultExt = 'xml'
		self.odImportar.Filter = 'Arquivos XML (*.xml)|*.xml'
		// 
		// FrmPrincipal
		// 
		self.AutoScaleDimensions = System.Drawing.SizeF(6.0F, 13.0F)
		self.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		self.ClientSize = System.Drawing.Size(884, 462)
		self.Controls.Add(self.barraStatus)
		self.Controls.Add(self.spPesquisa)
		self.Controls.Add(self.barraFerra)
		self.Controls.Add(self.barraMenu)
		self.MainMenuStrip = self.barraMenu
		self.Name = 'FrmPrincipal'
		self.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
		self.Text = 'HFSGuardaDiretorio 2.0 - Catalogador de Diretórios'
		self.FormClosed += self.FrmPrincipalFormClosed
		self.barraMenu.ResumeLayout(false)
		self.barraMenu.PerformLayout()
		self.barraFerra.ResumeLayout(false)
		self.barraFerra.PerformLayout()
		self.spPesquisa.Panel1.ResumeLayout(false)
		self.spPesquisa.Panel2.ResumeLayout(false)
		(self.spPesquisa cast System.ComponentModel.ISupportInitialize).EndInit()
		self.spPesquisa.ResumeLayout(false)
		self.tabControl1.ResumeLayout(false)
		self.popupMenu.ResumeLayout(false)
		self.tabPage1.ResumeLayout(false)
		self.sp.Panel1.ResumeLayout(false)
		self.sp.Panel2.ResumeLayout(false)
		(self.sp cast System.ComponentModel.ISupportInitialize).EndInit()
		self.sp.ResumeLayout(false)
		self.barraStatus.ResumeLayout(false)
		self.barraStatus.PerformLayout()
		self.ResumeLayout(false)
		self.PerformLayout()

	public escolherDir as System.Windows.Forms.FolderBrowserDialog

	public sdExportar as System.Windows.Forms.SaveFileDialog

	public odImportar as System.Windows.Forms.OpenFileDialog

	private menuExcluirAbaAtiva2 as System.Windows.Forms.ToolStripMenuItem

	private menuAlterarNomeAbaAtiva2 as System.Windows.Forms.ToolStripMenuItem

	private menuIncluirNovaAba2 as System.Windows.Forms.ToolStripMenuItem

	private toolStripSeparator2 as System.Windows.Forms.ToolStripSeparator

	private menuColapsarDiretorios2 as System.Windows.Forms.ToolStripMenuItem

	private menuExpandirDiretorios2 as System.Windows.Forms.ToolStripMenuItem

	private menuExcluirDiretorioSelecionado as System.Windows.Forms.ToolStripMenuItem

	private menuInformacoesDiretorioArquivo as System.Windows.Forms.ToolStripMenuItem

	private popupMenu as System.Windows.Forms.ContextMenuStrip

	private labStatus2 as System.Windows.Forms.ToolStripStatusLabel

	private labStatus1 as System.Windows.Forms.ToolStripStatusLabel

	public barraStatus as System.Windows.Forms.StatusStrip

	private imageList3 as System.Windows.Forms.ImageList

	public imageList2 as System.Windows.Forms.ImageList

	public imageList1 as System.Windows.Forms.ImageList

	private columnHeader15 as System.Windows.Forms.ColumnHeader

	private columnHeader14 as System.Windows.Forms.ColumnHeader

	private columnHeader13 as System.Windows.Forms.ColumnHeader

	private columnHeader12 as System.Windows.Forms.ColumnHeader

	private columnHeader11 as System.Windows.Forms.ColumnHeader

	private columnHeader10 as System.Windows.Forms.ColumnHeader

	public lvFixa as System.Windows.Forms.ListView

	public tvFixa as System.Windows.Forms.TreeView

	private sp as System.Windows.Forms.SplitContainer

	private columnHeader7 as System.Windows.Forms.ColumnHeader

	private columnHeader6 as System.Windows.Forms.ColumnHeader

	private columnHeader5 as System.Windows.Forms.ColumnHeader

	private columnHeader4 as System.Windows.Forms.ColumnHeader

	private columnHeader3 as System.Windows.Forms.ColumnHeader

	private columnHeader2 as System.Windows.Forms.ColumnHeader

	private columnHeader1 as System.Windows.Forms.ColumnHeader

	public lvPesquisa as System.Windows.Forms.ListView

	private tabPage1 as System.Windows.Forms.TabPage

	public tabControl1 as System.Windows.Forms.TabControl

	public spPesquisa as System.Windows.Forms.SplitContainer

	private btnPesquisar as System.Windows.Forms.ToolStripButton

	public edtPesquisa as System.Windows.Forms.ToolStripTextBox

	public pb as System.Windows.Forms.ToolStripProgressBar

	private btnImportarDiretorio as System.Windows.Forms.ToolStripButton

	private barraFerra as System.Windows.Forms.ToolStrip

	private menuSobreCatalogador as System.Windows.Forms.ToolStripMenuItem

	private menuIconesPequenos as System.Windows.Forms.ToolStripMenuItem

	private menuDetalhes as System.Windows.Forms.ToolStripMenuItem

	private menuLista as System.Windows.Forms.ToolStripMenuItem

	private menuIcones as System.Windows.Forms.ToolStripMenuItem

	private menuModoExibicao as System.Windows.Forms.ToolStripMenuItem

	private menuMostrarOcultarListaItensPesquisados as System.Windows.Forms.ToolStripMenuItem

	private menuMostrarOcultArvoreDirAbaAtiva as System.Windows.Forms.ToolStripMenuItem

	public menuGravarLogImportacao as System.Windows.Forms.ToolStripMenuItem

	private menuImportarDiretoriosViaXML as System.Windows.Forms.ToolStripMenuItem

	private menuSQL as System.Windows.Forms.ToolStripMenuItem

	private menuXML as System.Windows.Forms.ToolStripMenuItem

	private menuHTML as System.Windows.Forms.ToolStripMenuItem

	private menuCSV as System.Windows.Forms.ToolStripMenuItem

	private menuTXT as System.Windows.Forms.ToolStripMenuItem

	private menuExportarDiretoriosAbaAtiva as System.Windows.Forms.ToolStripMenuItem

	private menuColapsarDiretorios as System.Windows.Forms.ToolStripMenuItem

	private menuExpandirDiretorios as System.Windows.Forms.ToolStripMenuItem

	private toolStripSeparator1 as System.Windows.Forms.ToolStripSeparator

	private menuCadastrarExtensaoArquivo as System.Windows.Forms.ToolStripMenuItem

	private menuCompararDiretorios as System.Windows.Forms.ToolStripMenuItem

	private menuImportarSubDiretorios as System.Windows.Forms.ToolStripMenuItem

	private menuImportarDiretorio as System.Windows.Forms.ToolStripMenuItem

	private menuExcluirAbaAtiva as System.Windows.Forms.ToolStripMenuItem

	private menuAlterarNomeAbaAtiva as System.Windows.Forms.ToolStripMenuItem

	private menuIncluirNovaAba as System.Windows.Forms.ToolStripMenuItem

	private menuSobre as System.Windows.Forms.ToolStripMenuItem

	private menuVisao as System.Windows.Forms.ToolStripMenuItem

	private menuDiretorio as System.Windows.Forms.ToolStripMenuItem

	private menuAba as System.Windows.Forms.ToolStripMenuItem

	private barraMenu as System.Windows.Forms.MenuStrip

