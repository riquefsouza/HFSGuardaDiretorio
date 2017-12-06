# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 10/12/2014
# * Time: 17:39
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.catalogador, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosgui, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.gui
	# <summary>
	# Description of MainForm.
	# </summary>
	class FrmPrincipal < System::Windows::Forms::Form
		def initialize()
			@components = nil
			@colOrdem = -1
			#
			# The InitializeComponent() call is required for Windows Forms designer support.
			#
			self.InitializeComponent()
			@frmPrincipalProgresso = FrmPrincipalProgresso.new(self)
			@catalogador = Catalogador.new(self)
		end

		def InitializeComponent()
			@components = System.ComponentModel.Container.new()
			@barraMenu = System::Windows::Forms::MenuStrip.new()
			@menuAba = System::Windows::Forms::ToolStripMenuItem.new()
			@menuIncluirNovaAba = System::Windows::Forms::ToolStripMenuItem.new()
			@menuAlterarNomeAbaAtiva = System::Windows::Forms::ToolStripMenuItem.new()
			@menuExcluirAbaAtiva = System::Windows::Forms::ToolStripMenuItem.new()
			@menuDiretorio = System::Windows::Forms::ToolStripMenuItem.new()
			@menuImportarDiretorio = System::Windows::Forms::ToolStripMenuItem.new()
			@menuImportarSubDiretorios = System::Windows::Forms::ToolStripMenuItem.new()
			@menuCompararDiretorios = System::Windows::Forms::ToolStripMenuItem.new()
			@menuCadastrarExtensaoArquivo = System::Windows::Forms::ToolStripMenuItem.new()
			@toolStripSeparator1 = System::Windows::Forms::ToolStripSeparator.new()
			@menuExpandirDiretorios = System::Windows::Forms::ToolStripMenuItem.new()
			@menuColapsarDiretorios = System::Windows::Forms::ToolStripMenuItem.new()
			@menuExportarDiretoriosAbaAtiva = System::Windows::Forms::ToolStripMenuItem.new()
			@menuTXT = System::Windows::Forms::ToolStripMenuItem.new()
			@menuCSV = System::Windows::Forms::ToolStripMenuItem.new()
			@menuHTML = System::Windows::Forms::ToolStripMenuItem.new()
			@menuXML = System::Windows::Forms::ToolStripMenuItem.new()
			@menuSQL = System::Windows::Forms::ToolStripMenuItem.new()
			@menuImportarDiretoriosViaXML = System::Windows::Forms::ToolStripMenuItem.new()
			@menuGravarLogImportacao = System::Windows::Forms::ToolStripMenuItem.new()
			@menuVisao = System::Windows::Forms::ToolStripMenuItem.new()
			@menuMostrarOcultArvoreDirAbaAtiva = System::Windows::Forms::ToolStripMenuItem.new()
			@menuMostrarOcultarListaItensPesquisados = System::Windows::Forms::ToolStripMenuItem.new()
			@menuModoExibicao = System::Windows::Forms::ToolStripMenuItem.new()
			@menuIcones = System::Windows::Forms::ToolStripMenuItem.new()
			@menuLista = System::Windows::Forms::ToolStripMenuItem.new()
			@menuDetalhes = System::Windows::Forms::ToolStripMenuItem.new()
			@menuIconesPequenos = System::Windows::Forms::ToolStripMenuItem.new()
			@menuSobre = System::Windows::Forms::ToolStripMenuItem.new()
			@menuSobreCatalogador = System::Windows::Forms::ToolStripMenuItem.new()
			@barraFerra = System::Windows::Forms::ToolStrip.new()
			@btnImportarDiretorio = System::Windows::Forms::ToolStripButton.new()
			@pb = System::Windows::Forms::ToolStripProgressBar.new()
			@edtPesquisa = System::Windows::Forms::ToolStripTextBox.new()
			@btnPesquisar = System::Windows::Forms::ToolStripButton.new()
			@spPesquisa = System::Windows::Forms::SplitContainer.new()
			@tabControl1 = System::Windows::Forms::TabControl.new()
			@popupMenu = System::Windows::Forms::ContextMenuStrip.new(@components)
			@menuInformacoesDiretorioArquivo = System::Windows::Forms::ToolStripMenuItem.new()
			@menuExcluirDiretorioSelecionado = System::Windows::Forms::ToolStripMenuItem.new()
			@menuExpandirDiretorios2 = System::Windows::Forms::ToolStripMenuItem.new()
			@menuColapsarDiretorios2 = System::Windows::Forms::ToolStripMenuItem.new()
			@toolStripSeparator2 = System::Windows::Forms::ToolStripSeparator.new()
			@menuIncluirNovaAba2 = System::Windows::Forms::ToolStripMenuItem.new()
			@menuAlterarNomeAbaAtiva2 = System::Windows::Forms::ToolStripMenuItem.new()
			@menuExcluirAbaAtiva2 = System::Windows::Forms::ToolStripMenuItem.new()
			@tabPage1 = System::Windows::Forms::TabPage.new()
			@sp = System::Windows::Forms::SplitContainer.new()
			@tvFixa = System::Windows::Forms::TreeView.new()
			@imageList1 = System::Windows::Forms::ImageList.new(@components)
			@lvFixa = System::Windows::Forms::ListView.new()
			@columnHeader10 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader11 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader12 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader13 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader14 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader15 = System::Windows::Forms::ColumnHeader.new()
			@imageList2 = System::Windows::Forms::ImageList.new(@components)
			@imageList3 = System::Windows::Forms::ImageList.new(@components)
			@lvPesquisa = System::Windows::Forms::ListView.new()
			@columnHeader1 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader2 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader3 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader4 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader5 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader6 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader7 = System::Windows::Forms::ColumnHeader.new()
			@barraStatus = System::Windows::Forms::StatusStrip.new()
			@labStatus1 = System::Windows::Forms::ToolStripStatusLabel.new()
			@labStatus2 = System::Windows::Forms::ToolStripStatusLabel.new()
			@odImportar = System::Windows::Forms::OpenFileDialog.new()
			@sdExportar = System::Windows::Forms::SaveFileDialog.new()
			@escolherDir = System::Windows::Forms::FolderBrowserDialog.new()
			@barraMenu.SuspendLayout()
			@barraFerra.SuspendLayout()
			@spPesquisa.BeginInit()
			@spPesquisa.Panel1.SuspendLayout()
			@spPesquisa.Panel2.SuspendLayout()
			@spPesquisa.SuspendLayout()
			@tabControl1.SuspendLayout()
			@popupMenu.SuspendLayout()
			@tabPage1.SuspendLayout()
			@sp.BeginInit()
			@sp.Panel1.SuspendLayout()
			@sp.Panel2.SuspendLayout()
			@sp.SuspendLayout()
			@barraStatus.SuspendLayout()
			self.SuspendLayout()
			# 
			# barraMenu
			# 
			@barraMenu.Items.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@menuAba, @menuDiretorio, @menuVisao, @menuSobre]))
			@barraMenu.Location = System::Drawing::Point.new(0, 0)
			@barraMenu.Name = "barraMenu"
			@barraMenu.Size = System::Drawing::Size.new(884, 24)
			@barraMenu.TabIndex = 0
			@barraMenu.Text = "menuStrip1"
			# 
			# menuAba
			# 
			@menuAba.DropDownItems.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@menuIncluirNovaAba, @menuAlterarNomeAbaAtiva, @menuExcluirAbaAtiva]))
			@menuAba.Name = "menuAba"
			@menuAba.Size = System::Drawing::Size.new(40, 20)
			@menuAba.Text = "&Aba"
			# 
			# menuIncluirNovaAba
			# 
			@menuIncluirNovaAba.Name = "menuIncluirNovaAba"
			@menuIncluirNovaAba.Size = System::Drawing::Size.new(215, 22)
			@menuIncluirNovaAba.Text = "Incluir Nova Aba"
			@menuIncluirNovaAba.Click { |sender, e| @MenuIncluirNovaAbaClick(sender, e) }
			# 
			# menuAlterarNomeAbaAtiva
			# 
			@menuAlterarNomeAbaAtiva.Name = "menuAlterarNomeAbaAtiva"
			@menuAlterarNomeAbaAtiva.Size = System::Drawing::Size.new(215, 22)
			@menuAlterarNomeAbaAtiva.Text = "Alterar Nome da Aba Ativa"
			@menuAlterarNomeAbaAtiva.Click { |sender, e| @MenuAlterarNomeAbaAtivaClick(sender, e) }
			# 
			# menuExcluirAbaAtiva
			# 
			@menuExcluirAbaAtiva.Name = "menuExcluirAbaAtiva"
			@menuExcluirAbaAtiva.Size = System::Drawing::Size.new(215, 22)
			@menuExcluirAbaAtiva.Text = "Excluir Aba Ativa"
			@menuExcluirAbaAtiva.Click { |sender, e| @MenuExcluirAbaAtivaClick(sender, e) }
			# 
			# menuDiretorio
			# 
			@menuDiretorio.DropDownItems.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@menuImportarDiretorio, @menuImportarSubDiretorios, @menuCompararDiretorios, @menuCadastrarExtensaoArquivo, @toolStripSeparator1, @menuExpandirDiretorios, @menuColapsarDiretorios, @menuExportarDiretoriosAbaAtiva, @menuImportarDiretoriosViaXML, @menuGravarLogImportacao]))
			@menuDiretorio.Name = "menuDiretorio"
			@menuDiretorio.Size = System::Drawing::Size.new(65, 20)
			@menuDiretorio.Text = "&Diretório"
			# 
			# menuImportarDiretorio
			# 
			@menuImportarDiretorio.Name = "menuImportarDiretorio"
			@menuImportarDiretorio.Size = System::Drawing::Size.new(241, 22)
			@menuImportarDiretorio.Text = "Importar Diretório"
			@menuImportarDiretorio.Click { |sender, e| @MenuImportarDiretorioClick(sender, e) }
			# 
			# menuImportarSubDiretorios
			# 
			@menuImportarSubDiretorios.Name = "menuImportarSubDiretorios"
			@menuImportarSubDiretorios.Size = System::Drawing::Size.new(241, 22)
			@menuImportarSubDiretorios.Text = "Importar SubDiretórios"
			@menuImportarSubDiretorios.Click { |sender, e| @MenuImportarSubDiretoriosClick(sender, e) }
			# 
			# menuCompararDiretorios
			# 
			@menuCompararDiretorios.Name = "menuCompararDiretorios"
			@menuCompararDiretorios.Size = System::Drawing::Size.new(241, 22)
			@menuCompararDiretorios.Text = "Comparar Diretórios"
			@menuCompararDiretorios.Click { |sender, e| @MenuCompararDiretoriosClick(sender, e) }
			# 
			# menuCadastrarExtensaoArquivo
			# 
			@menuCadastrarExtensaoArquivo.Name = "menuCadastrarExtensaoArquivo"
			@menuCadastrarExtensaoArquivo.Size = System::Drawing::Size.new(241, 22)
			@menuCadastrarExtensaoArquivo.Text = "Cadastrar Extensão de Arquivo"
			@menuCadastrarExtensaoArquivo.Click { |sender, e| @MenuCadastrarExtensaoArquivoClick(sender, e) }
			# 
			# toolStripSeparator1
			# 
			@toolStripSeparator1.Name = "toolStripSeparator1"
			@toolStripSeparator1.Size = System::Drawing::Size.new(238, 6)
			# 
			# menuExpandirDiretorios
			# 
			@menuExpandirDiretorios.Name = "menuExpandirDiretorios"
			@menuExpandirDiretorios.Size = System::Drawing::Size.new(241, 22)
			@menuExpandirDiretorios.Text = "Expandir Diretórios"
			@menuExpandirDiretorios.Click { |sender, e| @MenuExpandirDiretoriosClick(sender, e) }
			# 
			# menuColapsarDiretorios
			# 
			@menuColapsarDiretorios.Name = "menuColapsarDiretorios"
			@menuColapsarDiretorios.Size = System::Drawing::Size.new(241, 22)
			@menuColapsarDiretorios.Text = "Colapsar Diretórios"
			@menuColapsarDiretorios.Click { |sender, e| @MenuColapsarDiretoriosClick(sender, e) }
			# 
			# menuExportarDiretoriosAbaAtiva
			# 
			@menuExportarDiretoriosAbaAtiva.DropDownItems.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@menuTXT, @menuCSV, @menuHTML, @menuXML, @menuSQL]))
			@menuExportarDiretoriosAbaAtiva.Name = "menuExportarDiretoriosAbaAtiva"
			@menuExportarDiretoriosAbaAtiva.Size = System::Drawing::Size.new(241, 22)
			@menuExportarDiretoriosAbaAtiva.Text = "Exportar Diretórios da Aba Ativa"
			# 
			# menuTXT
			# 
			@menuTXT.Name = "menuTXT"
			@menuTXT.Size = System::Drawing::Size.new(107, 22)
			@menuTXT.Text = "TXT"
			@menuTXT.Click { |sender, e| @MenuTXTClick(sender, e) }
			# 
			# menuCSV
			# 
			@menuCSV.Name = "menuCSV"
			@menuCSV.Size = System::Drawing::Size.new(107, 22)
			@menuCSV.Text = "CSV"
			@menuCSV.Click { |sender, e| @MenuCSVClick(sender, e) }
			# 
			# menuHTML
			# 
			@menuHTML.Name = "menuHTML"
			@menuHTML.Size = System::Drawing::Size.new(107, 22)
			@menuHTML.Text = "HTML"
			@menuHTML.Click { |sender, e| @MenuHTMLClick(sender, e) }
			# 
			# menuXML
			# 
			@menuXML.Name = "menuXML"
			@menuXML.Size = System::Drawing::Size.new(107, 22)
			@menuXML.Text = "XML"
			@menuXML.Click { |sender, e| @MenuXMLClick(sender, e) }
			# 
			# menuSQL
			# 
			@menuSQL.Name = "menuSQL"
			@menuSQL.Size = System::Drawing::Size.new(107, 22)
			@menuSQL.Text = "SQL"
			@menuSQL.Click { |sender, e| @MenuSQLClick(sender, e) }
			# 
			# menuImportarDiretoriosViaXML
			# 
			@menuImportarDiretoriosViaXML.Name = "menuImportarDiretoriosViaXML"
			@menuImportarDiretoriosViaXML.Size = System::Drawing::Size.new(241, 22)
			@menuImportarDiretoriosViaXML.Text = "Importar Diretórios via XML"
			@menuImportarDiretoriosViaXML.Click { |sender, e| @MenuImportarDiretoriosViaXMLClick(sender, e) }
			# 
			# menuGravarLogImportacao
			# 
			@menuGravarLogImportacao.CheckOnClick = true
			@menuGravarLogImportacao.Name = "menuGravarLogImportacao"
			@menuGravarLogImportacao.Size = System::Drawing::Size.new(241, 22)
			@menuGravarLogImportacao.Text = "Gravar Log da Importação"
			# 
			# menuVisao
			# 
			@menuVisao.DropDownItems.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@menuMostrarOcultArvoreDirAbaAtiva, @menuMostrarOcultarListaItensPesquisados, @menuModoExibicao]))
			@menuVisao.Name = "menuVisao"
			@menuVisao.Size = System::Drawing::Size.new(47, 20)
			@menuVisao.Text = "&Visão"
			# 
			# menuMostrarOcultArvoreDirAbaAtiva
			# 
			@menuMostrarOcultArvoreDirAbaAtiva.Name = "menuMostrarOcultArvoreDirAbaAtiva"
			@menuMostrarOcultArvoreDirAbaAtiva.Size = System::Drawing::Size.new(334, 22)
			@menuMostrarOcultArvoreDirAbaAtiva.Text = "Mostrar/Ocultar árvore de diretórios da Aba Ativa"
			@menuMostrarOcultArvoreDirAbaAtiva.Click { |sender, e| @MenuMostrarOcultArvoreDirAbaAtivaClick(sender, e) }
			# 
			# menuMostrarOcultarListaItensPesquisados
			# 
			@menuMostrarOcultarListaItensPesquisados.Name = "menuMostrarOcultarListaItensPesquisados"
			@menuMostrarOcultarListaItensPesquisados.Size = System::Drawing::Size.new(334, 22)
			@menuMostrarOcultarListaItensPesquisados.Text = "Mostrar/Ocultar lista de itens pesquisados"
			@menuMostrarOcultarListaItensPesquisados.Click { |sender, e| @MenuMostrarOcultarListaItensPesquisadosClick(sender, e) }
			# 
			# menuModoExibicao
			# 
			@menuModoExibicao.DropDownItems.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@menuIcones, @menuLista, @menuDetalhes, @menuIconesPequenos]))
			@menuModoExibicao.Name = "menuModoExibicao"
			@menuModoExibicao.Size = System::Drawing::Size.new(334, 22)
			@menuModoExibicao.Text = "Modo de Exibição"
			# 
			# menuIcones
			# 
			@menuIcones.Name = "menuIcones"
			@menuIcones.Size = System::Drawing::Size.new(163, 22)
			@menuIcones.Text = "Ícones"
			@menuIcones.Click { |sender, e| @MenuIconesClick(sender, e) }
			# 
			# menuLista
			# 
			@menuLista.Name = "menuLista"
			@menuLista.Size = System::Drawing::Size.new(163, 22)
			@menuLista.Text = "Lista"
			@menuLista.Click { |sender, e| @MenuListaClick(sender, e) }
			# 
			# menuDetalhes
			# 
			@menuDetalhes.Name = "menuDetalhes"
			@menuDetalhes.Size = System::Drawing::Size.new(163, 22)
			@menuDetalhes.Text = "Detalhes"
			@menuDetalhes.Click { |sender, e| @MenuDetalhesClick(sender, e) }
			# 
			# menuIconesPequenos
			# 
			@menuIconesPequenos.Name = "menuIconesPequenos"
			@menuIconesPequenos.Size = System::Drawing::Size.new(163, 22)
			@menuIconesPequenos.Text = "Ícones Pequenos"
			@menuIconesPequenos.Click { |sender, e| @MenuIconesPequenosClick(sender, e) }
			# 
			# menuSobre
			# 
			@menuSobre.DropDownItems.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@menuSobreCatalogador]))
			@menuSobre.Name = "menuSobre"
			@menuSobre.Size = System::Drawing::Size.new(49, 20)
			@menuSobre.Text = "&Sobre"
			# 
			# menuSobreCatalogador
			# 
			@menuSobreCatalogador.Name = "menuSobreCatalogador"
			@menuSobreCatalogador.Size = System::Drawing::Size.new(182, 22)
			@menuSobreCatalogador.Text = "Sobre o Catalogador"
			@menuSobreCatalogador.Click { |sender, e| @MenuSobreCatalogadorClick(sender, e) }
			# 
			# barraFerra
			# 
			@barraFerra.GripStyle = System::Windows::Forms::ToolStripGripStyle.Hidden
			@barraFerra.Items.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@btnImportarDiretorio, @pb, @edtPesquisa, @btnPesquisar]))
			@barraFerra.Location = System::Drawing::Point.new(0, 24)
			@barraFerra.Name = "barraFerra"
			@barraFerra.Size = System::Drawing::Size.new(884, 25)
			@barraFerra.Stretch = true
			@barraFerra.TabIndex = 1
			# 
			# btnImportarDiretorio
			# 
			@btnImportarDiretorio.DisplayStyle = System::Windows::Forms::ToolStripItemDisplayStyle.Text			
			@btnImportarDiretorio.ImageTransparentColor = System::Drawing::Color.Magenta
			@btnImportarDiretorio.Name = "btnImportarDiretorio"
			@btnImportarDiretorio.Size = System::Drawing::Size.new(106, 22)
			@btnImportarDiretorio.Text = "&Importar Diretório"
			@btnImportarDiretorio.Click { |sender, e| @BtnImportarDiretorioClick(sender, e) }
			# 
			# pb
			# 
			@pb.AutoSize = false
			@pb.Name = "pb"
			@pb.Size = System::Drawing::Size.new(385, 22)
			@pb.Step = 0
			# 
			# edtPesquisa
			# 
			@edtPesquisa.AutoSize = false
			@edtPesquisa.MaxLength = 255
			@edtPesquisa.Name = "edtPesquisa"
			@edtPesquisa.Size = System::Drawing::Size.new(288, 25)
			@edtPesquisa.ToolTipText = "Digite aqui para pesquisar"
			# 
			# btnPesquisar
			# 
			@btnPesquisar.DisplayStyle = System::Windows::Forms::ToolStripItemDisplayStyle.Text
			@btnPesquisar.Image = ((resources.GetObject("btnPesquisar.Image")))
			@btnPesquisar.ImageTransparentColor = System::Drawing::Color.Magenta
			@btnPesquisar.Name = "btnPesquisar"
			@btnPesquisar.Size = System::Drawing::Size.new(61, 22)
			@btnPesquisar.Text = "&Pesquisar"
			@btnPesquisar.Click { |sender, e| @BtnPesquisarClick(sender, e) }
			# 
			# spPesquisa
			# 
			@spPesquisa.Dock = System::Windows::Forms::DockStyle.Fill
			@spPesquisa.Location = System::Drawing::Point.new(0, 49)
			@spPesquisa.Name = "spPesquisa"
			@spPesquisa.Orientation = System::Windows::Forms::Orientation.Horizontal
			# 
			# spPesquisa.Panel1
			# 
			@spPesquisa.Panel1.Controls.Add(@tabControl1)
			# 
			# spPesquisa.Panel2
			# 
			@spPesquisa.Panel2.Controls.Add(@lvPesquisa)
			@spPesquisa.Size = System::Drawing::Size.new(884, 413)
			@spPesquisa.SplitterDistance = 294
			@spPesquisa.TabIndex = 2
			# 
			# tabControl1
			# 
			@tabControl1.ContextMenuStrip = @popupMenu
			@tabControl1.Controls.Add(@tabPage1)
			@tabControl1.Dock = System::Windows::Forms::DockStyle.Fill
			@tabControl1.ImageList = @imageList3
			@tabControl1.Location = System::Drawing::Point.new(0, 0)
			@tabControl1.Name = "tabControl1"
			@tabControl1.SelectedIndex = 0
			@tabControl1.Size = System::Drawing::Size.new(884, 294)
			@tabControl1.TabIndex = 0
			@tabControl1.SelectedIndexChanged { |sender, e| @TabControl1SelectedIndexChanged(sender, e) }
			# 
			# popupMenu
			# 
			@popupMenu.Items.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@menuInformacoesDiretorioArquivo, @menuExcluirDiretorioSelecionado, @menuExpandirDiretorios2, @menuColapsarDiretorios2, @toolStripSeparator2, @menuIncluirNovaAba2, @menuAlterarNomeAbaAtiva2, @menuExcluirAbaAtiva2]))
			@popupMenu.Name = "popupMenu"
			@popupMenu.Size = System::Drawing::Size.new(260, 164)
			# 
			# menuInformacoesDiretorioArquivo
			# 
			@menuInformacoesDiretorioArquivo.Name = "menuInformacoesDiretorioArquivo"
			@menuInformacoesDiretorioArquivo.Size = System::Drawing::Size.new(259, 22)
			@menuInformacoesDiretorioArquivo.Text = "Informações do Diretório / Arquivo"
			@menuInformacoesDiretorioArquivo.Click { |sender, e| @MenuInformacoesDiretorioArquivoClick(sender, e) }
			# 
			# menuExcluirDiretorioSelecionado
			# 
			@menuExcluirDiretorioSelecionado.Name = "menuExcluirDiretorioSelecionado"
			@menuExcluirDiretorioSelecionado.Size = System::Drawing::Size.new(259, 22)
			@menuExcluirDiretorioSelecionado.Text = "Excluir Diretório Selecionado"
			@menuExcluirDiretorioSelecionado.Click { |sender, e| @MenuExcluirDiretorioSelecionadoClick(sender, e) }
			# 
			# menuExpandirDiretorios2
			# 
			@menuExpandirDiretorios2.Name = "menuExpandirDiretorios2"
			@menuExpandirDiretorios2.Size = System::Drawing::Size.new(259, 22)
			@menuExpandirDiretorios2.Text = "Expandir Diretórios"
			@menuExpandirDiretorios2.Click { |sender, e| @MenuExpandirDiretorios2Click(sender, e) }
			# 
			# menuColapsarDiretorios2
			# 
			@menuColapsarDiretorios2.Name = "menuColapsarDiretorios2"
			@menuColapsarDiretorios2.Size = System::Drawing::Size.new(259, 22)
			@menuColapsarDiretorios2.Text = "Colapsar Diretórios"
			@menuColapsarDiretorios2.Click { |sender, e| @MenuColapsarDiretorios2Click(sender, e) }
			# 
			# toolStripSeparator2
			# 
			@toolStripSeparator2.Name = "toolStripSeparator2"
			@toolStripSeparator2.Size = System::Drawing::Size.new(256, 6)
			# 
			# menuIncluirNovaAba2
			# 
			@menuIncluirNovaAba2.Name = "menuIncluirNovaAba2"
			@menuIncluirNovaAba2.Size = System::Drawing::Size.new(259, 22)
			@menuIncluirNovaAba2.Text = "Incluir nova aba"
			@menuIncluirNovaAba2.Click { |sender, e| @MenuIncluirNovaAba2Click(sender, e) }
			# 
			# menuAlterarNomeAbaAtiva2
			# 
			@menuAlterarNomeAbaAtiva2.Name = "menuAlterarNomeAbaAtiva2"
			@menuAlterarNomeAbaAtiva2.Size = System::Drawing::Size.new(259, 22)
			@menuAlterarNomeAbaAtiva2.Text = "Alterar nome da aba ativa"
			@menuAlterarNomeAbaAtiva2.Click { |sender, e| @MenuAlterarNomeAbaAtiva2Click(sender, e) }
			# 
			# menuExcluirAbaAtiva2
			# 
			@menuExcluirAbaAtiva2.Name = "menuExcluirAbaAtiva2"
			@menuExcluirAbaAtiva2.Size = System::Drawing::Size.new(259, 22)
			@menuExcluirAbaAtiva2.Text = "Excluir aba ativa"
			@menuExcluirAbaAtiva2.Click { |sender, e| @MenuExcluirAbaAtiva2Click(sender, e) }
			# 
			# tabPage1
			# 
			@tabPage1.Controls.Add(@sp)
			@tabPage1.ImageIndex = 0
			@tabPage1.Location = System::Drawing::Point.new(4, 23)
			@tabPage1.Name = "tabPage1"
			@tabPage1.Padding = System::Windows::Forms::Padding.new(3)
			@tabPage1.Size = System::Drawing::Size.new(876, 267)
			@tabPage1.TabIndex = 0
			@tabPage1.Text = "DISCO1"
			@tabPage1.UseVisualStyleBackColor = true
			# 
			# sp
			# 
			@sp.Dock = System::Windows::Forms::DockStyle.Fill
			@sp.Location = System::Drawing::Point.new(3, 3)
			@sp.Name = "sp"
			# 
			# sp.Panel1
			# 
			@sp.Panel1.Controls.Add(@tvFixa)
			# 
			# sp.Panel2
			# 
			@sp.Panel2.Controls.Add(@lvFixa)
			@sp.Size = System::Drawing::Size.new(870, 261)
			@sp.SplitterDistance = 290
			@sp.TabIndex = 0
			# 
			# tvFixa
			# 
			@tvFixa.Dock = System::Windows::Forms::DockStyle.Fill
			@tvFixa.FullRowSelect = true
			@tvFixa.HideSelection = false
			@tvFixa.ImageIndex = 0
			@tvFixa.ImageList = @imageList1
			@tvFixa.Location = System::Drawing::Point.new(0, 0)
			@tvFixa.Name = "tvFixa"
			@tvFixa.SelectedImageIndex = 1
			@tvFixa.Size = System::Drawing::Size.new(290, 261)
			@tvFixa.TabIndex = 0
			@tvFixa.AfterSelect { |sender, e| @TvFixaAfterSelect(sender, e) }
			# 
			# imageList1
			# 
			@imageList1.ImageStream = ((resources.GetObject("imageList1.ImageStream")))
			@imageList1.TransparentColor = System::Drawing::Color.Transparent
			@imageList1.Images.SetKeyName(0, "Fechar.bmp")
			@imageList1.Images.SetKeyName(1, "Abrir.bmp")
			@imageList1.Images.SetKeyName(2, "Arquivo.bmp")
			# 
			# lvFixa
			# 
			@lvFixa.Columns.AddRange(System::Array[System::Windows::Forms::ColumnHeader].new([@columnHeader10, @columnHeader11, @columnHeader12, @columnHeader13, @columnHeader14, @columnHeader15]))
			@lvFixa.Dock = System::Windows::Forms::DockStyle.Fill
			@lvFixa.FullRowSelect = true
			@lvFixa.GridLines = true
			@lvFixa.LargeImageList = @imageList2
			@lvFixa.Location = System::Drawing::Point.new(0, 0)
			@lvFixa.MultiSelect = false
			@lvFixa.Name = "lvFixa"
			@lvFixa.Size = System::Drawing::Size.new(576, 261)
			@lvFixa.SmallImageList = @imageList1
			@lvFixa.TabIndex = 1
			@lvFixa.UseCompatibleStateImageBehavior = false
			@lvFixa.View = System::Windows::Forms::View.Details
			@lvFixa.ColumnClick { |sender, e| @LvFixaColumnClick(sender, e) }
			@lvFixa.DoubleClick { |sender, e| @LvFixaDoubleClick(sender, e) }
			# 
			# columnHeader10
			# 
			@columnHeader10.Text = "Nome"
			@columnHeader10.Width = 300
			# 
			# columnHeader11
			# 
			@columnHeader11.Text = "Tamanho"
			@columnHeader11.Width = 100
			# 
			# columnHeader12
			# 
			@columnHeader12.Text = "Tipo"
			@columnHeader12.Width = 70
			# 
			# columnHeader13
			# 
			@columnHeader13.Text = "Modificado"
			@columnHeader13.Width = 120
			# 
			# columnHeader14
			# 
			@columnHeader14.Text = "Atributos"
			@columnHeader14.Width = 90
			# 
			# columnHeader15
			# 
			@columnHeader15.Text = "Caminho"
			@columnHeader15.Width = 300
			# 
			# imageList2
			# 
			@imageList2.ImageStream = ((resources.GetObject("imageList2.ImageStream")))
			@imageList2.TransparentColor = System::Drawing::Color.Transparent
			@imageList2.Images.SetKeyName(0, "Fechar32.bmp")
			@imageList2.Images.SetKeyName(1, "Abrir32.bmp")
			@imageList2.Images.SetKeyName(2, "Arquivo32.bmp")
			# 
			# imageList3
			# 
			@imageList3.ImageStream = ((resources.GetObject("imageList3.ImageStream")))
			@imageList3.TransparentColor = System::Drawing::Color.Magenta
			@imageList3.Images.SetKeyName(0, "cdouro.bmp")
			@imageList3.Images.SetKeyName(1, "cdprata.bmp")
			# 
			# lvPesquisa
			# 
			@lvPesquisa.Columns.AddRange(System::Array[System::Windows::Forms::ColumnHeader].new([@columnHeader1, @columnHeader2, @columnHeader3, @columnHeader4, @columnHeader5, @columnHeader6, @columnHeader7]))
			@lvPesquisa.Dock = System::Windows::Forms::DockStyle.Fill
			@lvPesquisa.FullRowSelect = true
			@lvPesquisa.GridLines = true
			@lvPesquisa.LargeImageList = @imageList2
			@lvPesquisa.Location = System::Drawing::Point.new(0, 0)
			@lvPesquisa.MultiSelect = false
			@lvPesquisa.Name = "lvPesquisa"
			@lvPesquisa.Size = System::Drawing::Size.new(884, 115)
			@lvPesquisa.SmallImageList = @imageList1
			@lvPesquisa.TabIndex = 0
			@lvPesquisa.UseCompatibleStateImageBehavior = false
			@lvPesquisa.View = System::Windows::Forms::View.Details
			@lvPesquisa.ColumnClick { |sender, e| @LvPesquisaColumnClick(sender, e) }
			@lvPesquisa.Click { |sender, e| @LvPesquisaClick(sender, e) }
			# 
			# columnHeader1
			# 
			@columnHeader1.Text = "Nome"
			@columnHeader1.Width = 300
			# 
			# columnHeader2
			# 
			@columnHeader2.Text = "Tamanho"
			@columnHeader2.Width = 100
			# 
			# columnHeader3
			# 
			@columnHeader3.Text = "Tipo"
			@columnHeader3.Width = 70
			# 
			# columnHeader4
			# 
			@columnHeader4.Text = "Modificado"
			@columnHeader4.Width = 120
			# 
			# columnHeader5
			# 
			@columnHeader5.Text = "Atributos"
			@columnHeader5.Width = 90
			# 
			# columnHeader6
			# 
			@columnHeader6.Text = "Caminho"
			@columnHeader6.Width = 300
			# 
			# columnHeader7
			# 
			@columnHeader7.Text = "Aba"
			@columnHeader7.Width = 150
			# 
			# barraStatus
			# 
			@barraStatus.Items.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@labStatus1, @labStatus2]))
			@barraStatus.Location = System::Drawing::Point.new(0, 440)
			@barraStatus.Name = "barraStatus"
			@barraStatus.Size = System::Drawing::Size.new(884, 22)
			@barraStatus.TabIndex = 3
			@barraStatus.Text = "statusStrip1"
			# 
			# labStatus1
			# 
			@labStatus1.AutoSize = false
			@labStatus1.BorderSides = (((((System::Windows::Forms::ToolStripStatusLabelBorderSides.Left | System::Windows::Forms::ToolStripStatusLabelBorderSides.Top) | System::Windows::Forms::ToolStripStatusLabelBorderSides.Right) | System::Windows::Forms::ToolStripStatusLabelBorderSides.Bottom)))
			@labStatus1.BorderStyle = System::Windows::Forms::Border3DStyle.SunkenInner
			@labStatus1.DisplayStyle = System::Windows::Forms::ToolStripItemDisplayStyle.Text
			@labStatus1.Name = "labStatus1"
			@labStatus1.Size = System::Drawing::Size.new(300, 17)
			@labStatus1.Text = "Quantidade Total: , Tamanho Total:"
			@labStatus1.TextAlign = System::Drawing::ContentAlignment.MiddleLeft
			# 
			# labStatus2
			# 
			@labStatus2.BorderSides = (((((System::Windows::Forms::ToolStripStatusLabelBorderSides.Left | System::Windows::Forms::ToolStripStatusLabelBorderSides.Top) | System::Windows::Forms::ToolStripStatusLabelBorderSides.Right) | System::Windows::Forms::ToolStripStatusLabelBorderSides.Bottom)))
			@labStatus2.BorderStyle = System::Windows::Forms::Border3DStyle.SunkenInner
			@labStatus2.DisplayStyle = System::Windows::Forms::ToolStripItemDisplayStyle.Text
			@labStatus2.Name = "labStatus2"
			@labStatus2.Size = System::Drawing::Size.new(569, 17)
			@labStatus2.Spring = true
			@labStatus2.TextAlign = System::Drawing::ContentAlignment.MiddleLeft
			# 
			# odImportar
			# 
			@odImportar.DefaultExt = "xml"
			@odImportar.Filter = "Arquivos XML (*.xml)|*.xml"
			# 
			# FrmPrincipal
			# 
			self.AutoScaleDimensions = System::Drawing::SizeF.new(6f, 13f)
			self.AutoScaleMode = System::Windows::Forms::AutoScaleMode.Font
			self.ClientSize = System::Drawing::Size.new(884, 462)
			self.Controls.Add(@barraStatus)
			self.Controls.Add(@spPesquisa)
			self.Controls.Add(@barraFerra)
			self.Controls.Add(@barraMenu)
			self.MainMenuStrip = @barraMenu
			self.Name = "FrmPrincipal"
			self.StartPosition = System::Windows::Forms::FormStartPosition.CenterScreen
			self.Text = "HFSGuardaDiretorio 2.0 - Catalogador de Diretórios"
			self.FormClosed { |sender, e| @FrmPrincipalFormClosed(sender, e) }
			@barraMenu.ResumeLayout(false)
			@barraMenu.PerformLayout()
			@barraFerra.ResumeLayout(false)
			@barraFerra.PerformLayout()
			@spPesquisa.Panel1.ResumeLayout(false)
			@spPesquisa.Panel2.ResumeLayout(false)
			@spPesquisa.EndInit()
			@spPesquisa.ResumeLayout(false)
			@tabControl1.ResumeLayout(false)
			@popupMenu.ResumeLayout(false)
			@tabPage1.ResumeLayout(false)
			@sp.Panel1.ResumeLayout(false)
			@sp.Panel2.ResumeLayout(false)
			@sp.EndInit()
			@sp.ResumeLayout(false)
			@barraStatus.ResumeLayout(false)
			@barraStatus.PerformLayout()
			self.ResumeLayout(false)
			self.PerformLayout()
		end

		def Dispose(disposing)
			if disposing then
				if @components != nil then
					@components.Dispose()
				end
			end
			self.Dispose(disposing)
		end

		def Catalogador
			return @catalogador
		end

		def MenuIncluirNovaAbaClick(sender, e)
			@catalogador.IncluirNovaAba()
		end

		def MenuAlterarNomeAbaAtivaClick(sender, e)
			@catalogador.AlterarNomeAbaAtiva(@frmPrincipalProgresso)
		end

		def MenuExcluirAbaAtivaClick(sender, e)
			@catalogador.ExcluirAbaAtiva(@frmPrincipalProgresso)
		end

		def MenuImportarDiretorioClick(sender, e)
			@catalogador.ComecaImportacao(false, @frmPrincipalProgresso)
		end

		def MenuImportarSubDiretoriosClick(sender, e)
			@catalogador.ComecaImportacao(true, @frmPrincipalProgresso)
		end

		def MenuCadastrarExtensaoArquivoClick(sender, e)
			frmCadExtensao = FrmCadExtensao.new(self)
			frmCadExtensao.ShowDialog()
		end

		def MenuCompararDiretoriosClick(sender, e)
			frmCompararDiretorio = FrmCompararDiretorio.new(self)
			frmCompararDiretorio.ShowDialog()
		end

		def MenuSobreCatalogadorClick(sender, e)
			frmSobre = FrmSobre.new()
			frmSobre.ShowDialog()
		end

		def MenuExpandirDiretoriosClick(sender, e)
			@catalogador.getArvoreAtual().ExpandAll()
		end

		def MenuColapsarDiretoriosClick(sender, e)
			@catalogador.getArvoreAtual().CollapseAll()
		end

		def MenuTXTClick(sender, e)
			@catalogador.ExportarArquivo(TipoExportar.teTXT, @frmPrincipalProgresso)
		end

		def MenuCSVClick(sender, e)
			@catalogador.ExportarArquivo(TipoExportar.teCSV, @frmPrincipalProgresso)
		end

		def MenuHTMLClick(sender, e)
			@catalogador.ExportarArquivo(TipoExportar.teHTML, @frmPrincipalProgresso)
		end

		def MenuXMLClick(sender, e)
			@catalogador.ExportarArquivo(TipoExportar.teXML, @frmPrincipalProgresso)
		end

		def MenuSQLClick(sender, e)
			@catalogador.ExportarArquivo(TipoExportar.teSQL, @frmPrincipalProgresso)
		end

		def MenuImportarDiretoriosViaXMLClick(sender, e)
			log = StringList.new()
			@catalogador.ImportarArquivo(log, @frmPrincipalProgresso)
		end

		def MenuMostrarOcultArvoreDirAbaAtivaClick(sender, e)
			@catalogador.mostrarOcultarArvore()
		end

		def MenuMostrarOcultarListaItensPesquisadosClick(sender, e)
			spPesquisa.Panel2Collapsed = not spPesquisa.Panel2Collapsed
		end

		def BtnImportarDiretorioClick(sender, e)
			self.MenuImportarDiretorioClick(sender, e)
		end

		def BtnPesquisarClick(sender, e)
			@catalogador.Pesquisar()
		end

		def FrmPrincipalFormClosed(sender, e)
			Rotinas.Desconectar()
		end

		def MenuInformacoesDiretorioArquivoClick(sender, e)
			@catalogador.InformacoesDiretorioArquivo()
		end

		def MenuExcluirDiretorioSelecionadoClick(sender, e)
			@catalogador.ExcluirDiretorioSelecionado(@frmPrincipalProgresso)
		end

		def MenuIconesClick(sender, e)
			@catalogador.getTabelaAtual().View = View.LargeIcon
		end

		def MenuListaClick(sender, e)
			@catalogador.getTabelaAtual().View = View.List
		end

		def MenuDetalhesClick(sender, e)
			@catalogador.getTabelaAtual().View = View.Details
		end

		def MenuIconesPequenosClick(sender, e)
			@catalogador.getTabelaAtual().View = View.SmallIcon
		end

		def MenuExpandirDiretorios2Click(sender, e)
			self.MenuExpandirDiretoriosClick(sender, e)
		end

		def MenuColapsarDiretorios2Click(sender, e)
			self.MenuColapsarDiretoriosClick(sender, e)
		end

		def MenuIncluirNovaAba2Click(sender, e)
			self.MenuIncluirNovaAbaClick(sender, e)
		end

		def MenuAlterarNomeAbaAtiva2Click(sender, e)
			self.MenuAlterarNomeAbaAtivaClick(sender, e)
		end

		def MenuExcluirAbaAtiva2Click(sender, e)
			self.MenuExcluirAbaAtivaClick(sender, e)
		end

		def TabControl1SelectedIndexChanged(sender, e)
			@catalogador.tabPanelMudou()
		end

		def LvFixaDoubleClick(sender, e)
			lvTabela = sender
			if lvTabela.SelectedItems.Count > 0 then
				nome = lvTabela.SelectedItems[0].Text
				tipo = lvTabela.SelectedItems[0].SubItems[2].Text
				@catalogador.DuploCliqueLista(nome, tipo)
			end
		end

		def LvFixaColumnClick(sender, e)
			lvTabela = sender
			@colOrdem = @catalogador.listaCompara(lvTabela, e.Column, @colOrdem)
		end

		def LvPesquisaColumnClick(sender, e)
			lvTabela = sender
			@colOrdem = @catalogador.listaCompara(lvTabela, e.Column, @colOrdem)
		end

		def LvPesquisaClick(sender, e)
			lvPesquisa = sender
			if lvPesquisa.SelectedItems.Count > 0 then
				nome = lvPesquisa.SelectedItems[0].Text
				caminho = lvPesquisa.SelectedItems[0].SubItems[5].Text
				nomeAba = lvPesquisa.SelectedItems[0].SubItems[6].Text
				@catalogador.EncontrarItemLista(nomeAba, nome, caminho)
			end
		end

		def TvFixaAfterSelect(sender, e)
			lvTabela = @catalogador.getTabelaAtual()
			@catalogador.ListarArquivos(lvTabela, e.Node)
		end
	end
end