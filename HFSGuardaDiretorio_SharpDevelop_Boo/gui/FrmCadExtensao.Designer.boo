/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 11/12/2014
 * Time: 11:58
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */

namespace HFSGuardaDiretorio.gui

partial internal class FrmCadExtensao:

	private components as System.ComponentModel.IContainer = null

	
	protected override def Dispose(disposing as bool):
		if disposing:
			if components is not null:
				components.Dispose()
		super.Dispose(disposing)

	
	private def InitializeComponent():
		self.components = System.ComponentModel.Container()
		self.menuStrip1 = System.Windows.Forms.MenuStrip()
		self.menuExtensao = System.Windows.Forms.ToolStripMenuItem()
		self.menuIncluirExtensao = System.Windows.Forms.ToolStripMenuItem()
		self.menuExcluirExtensao = System.Windows.Forms.ToolStripMenuItem()
		self.menuExcluirTodasExtensoes = System.Windows.Forms.ToolStripMenuItem()
		self.menuExportarTodos = System.Windows.Forms.ToolStripMenuItem()
		self.menuExportarBitmap = System.Windows.Forms.ToolStripMenuItem()
		self.menuExportarIcone = System.Windows.Forms.ToolStripMenuItem()
		self.menuExportarGIF = System.Windows.Forms.ToolStripMenuItem()
		self.menuExportarJPEG = System.Windows.Forms.ToolStripMenuItem()
		self.menuExportarPNG = System.Windows.Forms.ToolStripMenuItem()
		self.menuExportarTIFF = System.Windows.Forms.ToolStripMenuItem()
		self.menuImportarTodos = System.Windows.Forms.ToolStripMenuItem()
		self.menuImportarIconesArquivos = System.Windows.Forms.ToolStripMenuItem()
		self.menuExtrairIconesArquivos = System.Windows.Forms.ToolStripMenuItem()
		self.lvExtensao = System.Windows.Forms.ListView()
		self.columnHeader1 = System.Windows.Forms.ColumnHeader()
		self.columnHeader2 = System.Windows.Forms.ColumnHeader()
		self.imgListExtensao = System.Windows.Forms.ImageList(self.components)
		self.panel1 = System.Windows.Forms.Panel()
		self.btnExcluir = System.Windows.Forms.Button()
		self.btnIncluir = System.Windows.Forms.Button()
		self.odEscolhaArquivo = System.Windows.Forms.OpenFileDialog()
		self.menuStrip1.SuspendLayout()
		self.panel1.SuspendLayout()
		self.SuspendLayout()
		// 
		// menuStrip1
		// 
		self.menuStrip1.Items.AddRange((of System.Windows.Forms.ToolStripItem: self.menuExtensao, self.menuExportarTodos, self.menuImportarTodos))
		self.menuStrip1.Location = System.Drawing.Point(0, 0)
		self.menuStrip1.Name = 'menuStrip1'
		self.menuStrip1.Size = System.Drawing.Size(280, 24)
		self.menuStrip1.TabIndex = 0
		self.menuStrip1.Text = 'menuStrip1'
		// 
		// menuExtensao
		// 
		self.menuExtensao.DropDownItems.AddRange((of System.Windows.Forms.ToolStripItem: self.menuIncluirExtensao, self.menuExcluirExtensao, self.menuExcluirTodasExtensoes))
		self.menuExtensao.Name = 'menuExtensao'
		self.menuExtensao.Size = System.Drawing.Size(65, 20)
		self.menuExtensao.Text = '&Extensão'
		// 
		// menuIncluirExtensao
		// 
		self.menuIncluirExtensao.Name = 'menuIncluirExtensao'
		self.menuIncluirExtensao.Size = System.Drawing.Size(197, 22)
		self.menuIncluirExtensao.Text = 'Incluir Extensão'
		self.menuIncluirExtensao.Click += self.MenuIncluirExtensaoClick
		// 
		// menuExcluirExtensao
		// 
		self.menuExcluirExtensao.Name = 'menuExcluirExtensao'
		self.menuExcluirExtensao.Size = System.Drawing.Size(197, 22)
		self.menuExcluirExtensao.Text = 'Excluir Extensão'
		self.menuExcluirExtensao.Click += self.MenuExcluirExtensaoClick
		// 
		// menuExcluirTodasExtensoes
		// 
		self.menuExcluirTodasExtensoes.Name = 'menuExcluirTodasExtensoes'
		self.menuExcluirTodasExtensoes.Size = System.Drawing.Size(197, 22)
		self.menuExcluirTodasExtensoes.Text = 'Excluir Todas Extensões'
		self.menuExcluirTodasExtensoes.Click += self.MenuExcluirTodasExtensoesClick
		// 
		// menuExportarTodos
		// 
		self.menuExportarTodos.DropDownItems.AddRange((of System.Windows.Forms.ToolStripItem: self.menuExportarBitmap, self.menuExportarIcone, self.menuExportarGIF, self.menuExportarJPEG, self.menuExportarPNG, self.menuExportarTIFF))
		self.menuExportarTodos.Name = 'menuExportarTodos'
		self.menuExportarTodos.Size = System.Drawing.Size(98, 20)
		self.menuExportarTodos.Text = 'Exportar &Todos'
		// 
		// menuExportarBitmap
		// 
		self.menuExportarBitmap.Name = 'menuExportarBitmap'
		self.menuExportarBitmap.Size = System.Drawing.Size(184, 22)
		self.menuExportarBitmap.Text = 'Exportar para Bitmap'
		self.menuExportarBitmap.Click += self.MenuExportarBitmapClick
		// 
		// menuExportarIcone
		// 
		self.menuExportarIcone.Name = 'menuExportarIcone'
		self.menuExportarIcone.Size = System.Drawing.Size(184, 22)
		self.menuExportarIcone.Text = 'Exportar para Ícone'
		self.menuExportarIcone.Click += self.MenuExportarIconeClick
		// 
		// menuExportarGIF
		// 
		self.menuExportarGIF.Name = 'menuExportarGIF'
		self.menuExportarGIF.Size = System.Drawing.Size(184, 22)
		self.menuExportarGIF.Text = 'Exportar para GIF'
		self.menuExportarGIF.Click += self.MenuExportarGIFClick
		// 
		// menuExportarJPEG
		// 
		self.menuExportarJPEG.Name = 'menuExportarJPEG'
		self.menuExportarJPEG.Size = System.Drawing.Size(184, 22)
		self.menuExportarJPEG.Text = 'Exportar para JPEG'
		self.menuExportarJPEG.Click += self.MenuExportarJPEGClick
		// 
		// menuExportarPNG
		// 
		self.menuExportarPNG.Name = 'menuExportarPNG'
		self.menuExportarPNG.Size = System.Drawing.Size(184, 22)
		self.menuExportarPNG.Text = 'Exportar para PNG'
		self.menuExportarPNG.Click += self.MenuExportarPNGClick
		// 
		// menuExportarTIFF
		// 
		self.menuExportarTIFF.Name = 'menuExportarTIFF'
		self.menuExportarTIFF.Size = System.Drawing.Size(184, 22)
		self.menuExportarTIFF.Text = 'Exportar para TIFF'
		self.menuExportarTIFF.Click += self.MenuExportarTIFFClick
		// 
		// menuImportarTodos
		// 
		self.menuImportarTodos.DropDownItems.AddRange((of System.Windows.Forms.ToolStripItem: self.menuImportarIconesArquivos, self.menuExtrairIconesArquivos))
		self.menuImportarTodos.Name = 'menuImportarTodos'
		self.menuImportarTodos.Size = System.Drawing.Size(101, 20)
		self.menuImportarTodos.Text = '&Importar Todos'
		// 
		// menuImportarIconesArquivos
		// 
		self.menuImportarIconesArquivos.Name = 'menuImportarIconesArquivos'
		self.menuImportarIconesArquivos.Size = System.Drawing.Size(229, 22)
		self.menuImportarIconesArquivos.Text = 'Importar Ícones dos Arquivos'
		self.menuImportarIconesArquivos.Click += self.MenuImportarIconesArquivosClick
		// 
		// menuExtrairIconesArquivos
		// 
		self.menuExtrairIconesArquivos.Name = 'menuExtrairIconesArquivos'
		self.menuExtrairIconesArquivos.Size = System.Drawing.Size(229, 22)
		self.menuExtrairIconesArquivos.Text = 'Extrair Ícones dos Arquivos'
		self.menuExtrairIconesArquivos.Click += self.MenuExtrairIconesArquivosClick
		// 
		// lvExtensao
		// 
		self.lvExtensao.Columns.AddRange((of System.Windows.Forms.ColumnHeader: self.columnHeader1, self.columnHeader2))
		self.lvExtensao.GridLines = true
		self.lvExtensao.Location = System.Drawing.Point(0, 24)
		self.lvExtensao.MultiSelect = false
		self.lvExtensao.Name = 'lvExtensao'
		self.lvExtensao.OwnerDraw = true
		self.lvExtensao.Size = System.Drawing.Size(280, 325)
		self.lvExtensao.TabIndex = 2
		self.lvExtensao.UseCompatibleStateImageBehavior = false
		self.lvExtensao.View = System.Windows.Forms.View.Details
		self.lvExtensao.DrawColumnHeader += self.LvExtensaoDrawColumnHeader
		self.lvExtensao.DrawItem += self.LvExtensaoDrawItem
		self.lvExtensao.DrawSubItem += self.LvExtensaoDrawSubItem
		// 
		// columnHeader1
		// 
		self.columnHeader1.Text = 'Extensão'
		self.columnHeader1.Width = 167
		// 
		// columnHeader2
		// 
		self.columnHeader2.Text = 'Ícone'
		self.columnHeader2.TextAlign = System.Windows.Forms.HorizontalAlignment.Center
		self.columnHeader2.Width = 58
		// 
		// imgListExtensao
		// 
		self.imgListExtensao.ColorDepth = System.Windows.Forms.ColorDepth.Depth8Bit
		self.imgListExtensao.ImageSize = System.Drawing.Size(16, 16)
		self.imgListExtensao.TransparentColor = System.Drawing.Color.Transparent
		// 
		// panel1
		// 
		self.panel1.Controls.Add(self.btnExcluir)
		self.panel1.Controls.Add(self.btnIncluir)
		self.panel1.Dock = System.Windows.Forms.DockStyle.Bottom
		self.panel1.Location = System.Drawing.Point(0, 347)
		self.panel1.Name = 'panel1'
		self.panel1.Size = System.Drawing.Size(280, 43)
		self.panel1.TabIndex = 3
		// 
		// btnExcluir
		// 
		self.btnExcluir.Location = System.Drawing.Point(155, 8)
		self.btnExcluir.Name = 'btnExcluir'
		self.btnExcluir.Size = System.Drawing.Size(75, 23)
		self.btnExcluir.TabIndex = 1
		self.btnExcluir.Text = '&Excluir'
		self.btnExcluir.UseVisualStyleBackColor = true
		self.btnExcluir.Click += self.BtnExcluirClick
		// 
		// btnIncluir
		// 
		self.btnIncluir.Location = System.Drawing.Point(46, 8)
		self.btnIncluir.Name = 'btnIncluir'
		self.btnIncluir.Size = System.Drawing.Size(75, 23)
		self.btnIncluir.TabIndex = 0
		self.btnIncluir.Text = '&Incluir'
		self.btnIncluir.UseVisualStyleBackColor = true
		self.btnIncluir.Click += self.BtnIncluirClick
		// 
		// odEscolhaArquivo
		// 
		self.odEscolhaArquivo.Filter = 'Todos os Arquivos (*.*)|*.*'
		// 
		// FrmCadExtensao
		// 
		self.AutoScaleDimensions = System.Drawing.SizeF(6.0F, 13.0F)
		self.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		self.ClientSize = System.Drawing.Size(280, 390)
		self.Controls.Add(self.lvExtensao)
		self.Controls.Add(self.menuStrip1)
		self.Controls.Add(self.panel1)
		self.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
		self.MainMenuStrip = self.menuStrip1
		self.MaximizeBox = false
		self.MinimizeBox = false
		self.Name = 'FrmCadExtensao'
		self.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
		self.Text = 'Cadastro de Extensão de Arquivo'
		self.menuStrip1.ResumeLayout(false)
		self.menuStrip1.PerformLayout()
		self.panel1.ResumeLayout(false)
		self.ResumeLayout(false)
		self.PerformLayout()

	private imgListExtensao as System.Windows.Forms.ImageList

	private odEscolhaArquivo as System.Windows.Forms.OpenFileDialog

	private btnIncluir as System.Windows.Forms.Button

	private btnExcluir as System.Windows.Forms.Button

	private panel1 as System.Windows.Forms.Panel

	private columnHeader2 as System.Windows.Forms.ColumnHeader

	private columnHeader1 as System.Windows.Forms.ColumnHeader

	private lvExtensao as System.Windows.Forms.ListView

	private menuExtrairIconesArquivos as System.Windows.Forms.ToolStripMenuItem

	private menuImportarIconesArquivos as System.Windows.Forms.ToolStripMenuItem

	private menuExportarTIFF as System.Windows.Forms.ToolStripMenuItem

	private menuExportarPNG as System.Windows.Forms.ToolStripMenuItem

	private menuExportarJPEG as System.Windows.Forms.ToolStripMenuItem

	private menuExportarGIF as System.Windows.Forms.ToolStripMenuItem

	private menuExportarIcone as System.Windows.Forms.ToolStripMenuItem

	private menuExportarBitmap as System.Windows.Forms.ToolStripMenuItem

	private menuExcluirTodasExtensoes as System.Windows.Forms.ToolStripMenuItem

	private menuExcluirExtensao as System.Windows.Forms.ToolStripMenuItem

	private menuIncluirExtensao as System.Windows.Forms.ToolStripMenuItem

	private menuImportarTodos as System.Windows.Forms.ToolStripMenuItem

	private menuExportarTodos as System.Windows.Forms.ToolStripMenuItem

	private menuExtensao as System.Windows.Forms.ToolStripMenuItem

	private menuStrip1 as System.Windows.Forms.MenuStrip

