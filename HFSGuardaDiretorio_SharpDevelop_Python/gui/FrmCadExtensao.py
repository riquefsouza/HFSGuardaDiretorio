
from System import *
from System.IO import *
from System.Drawing import *
from System.Collections.Generic import *
from System.Windows.Forms import *
from HFSGuardaDiretorio.comum import *
from HFSGuardaDiretorio.objetos import *
from HFSGuardaDiretorio.objetosbo import *
from HFSGuardaDiretorio.objetosgui import *
from HFSGuardaDiretorio.catalogador import *

class FrmCadExtensao(Form):
	def __init__(self, frmPrincipal):
		self._components = None
		self.InitializeComponent()
		odEscolhaArquivo.Filter = Rotinas.FILTRO_IMAGEM
		self._catalogador = frmPrincipal.Catalogador
		self.CarregarExtensoesNaGrid()

	def InitializeComponent(self):
		self._components = System.ComponentModel.Container()
		self._menuStrip1 = System.Windows.Forms.MenuStrip()
		self._menuExtensao = System.Windows.Forms.ToolStripMenuItem()
		self._menuIncluirExtensao = System.Windows.Forms.ToolStripMenuItem()
		self._menuExcluirExtensao = System.Windows.Forms.ToolStripMenuItem()
		self._menuExcluirTodasExtensoes = System.Windows.Forms.ToolStripMenuItem()
		self._menuExportarTodos = System.Windows.Forms.ToolStripMenuItem()
		self._menuExportarBitmap = System.Windows.Forms.ToolStripMenuItem()
		self._menuExportarIcone = System.Windows.Forms.ToolStripMenuItem()
		self._menuExportarGIF = System.Windows.Forms.ToolStripMenuItem()
		self._menuExportarJPEG = System.Windows.Forms.ToolStripMenuItem()
		self._menuExportarPNG = System.Windows.Forms.ToolStripMenuItem()
		self._menuExportarTIFF = System.Windows.Forms.ToolStripMenuItem()
		self._menuImportarTodos = System.Windows.Forms.ToolStripMenuItem()
		self._menuImportarIconesArquivos = System.Windows.Forms.ToolStripMenuItem()
		self._menuExtrairIconesArquivos = System.Windows.Forms.ToolStripMenuItem()
		self._lvExtensao = System.Windows.Forms.ListView()
		self._columnHeader1 = System.Windows.Forms.ColumnHeader()
		self._columnHeader2 = System.Windows.Forms.ColumnHeader()
		self._imgListExtensao = System.Windows.Forms.ImageList(self._components)
		self._panel1 = System.Windows.Forms.Panel()
		self._btnExcluir = System.Windows.Forms.Button()
		self._btnIncluir = System.Windows.Forms.Button()
		self._odEscolhaArquivo = System.Windows.Forms.OpenFileDialog()
		self._menuStrip1.SuspendLayout()
		self._panel1.SuspendLayout()
		self.SuspendLayout()
		# 
		# menuStrip1
		# 
		self._menuStrip1.Items.AddRange(System.Array[System.Windows.Forms.ToolStripItem]([self._menuExtensao, self._menuExportarTodos, self._menuImportarTodos]))
		self._menuStrip1.Location = System.Drawing.Point(0, 0)
		self._menuStrip1.Name = "menuStrip1"
		self._menuStrip1.Size = System.Drawing.Size(280, 24)
		self._menuStrip1.TabIndex = 0
		self._menuStrip1.Text = "menuStrip1"
		# 
		# menuExtensao
		# 
		self._menuExtensao.DropDownItems.AddRange(System.Array[System.Windows.Forms.ToolStripItem]([self._menuIncluirExtensao, self._menuExcluirExtensao, self._menuExcluirTodasExtensoes]))
		self._menuExtensao.Name = "menuExtensao"
		self._menuExtensao.Size = System.Drawing.Size(65, 20)
		self._menuExtensao.Text = "&Extensão"
		# 
		# menuIncluirExtensao
		# 
		self._menuIncluirExtensao.Name = "menuIncluirExtensao"
		self._menuIncluirExtensao.Size = System.Drawing.Size(197, 22)
		self._menuIncluirExtensao.Text = "Incluir Extensão"
		self._menuIncluirExtensao.Click += self.MenuIncluirExtensaoClick
		# 
		# menuExcluirExtensao
		# 
		self._menuExcluirExtensao.Name = "menuExcluirExtensao"
		self._menuExcluirExtensao.Size = System.Drawing.Size(197, 22)
		self._menuExcluirExtensao.Text = "Excluir Extensão"
		self._menuExcluirExtensao.Click += self.MenuExcluirExtensaoClick
		# 
		# menuExcluirTodasExtensoes
		# 
		self._menuExcluirTodasExtensoes.Name = "menuExcluirTodasExtensoes"
		self._menuExcluirTodasExtensoes.Size = System.Drawing.Size(197, 22)
		self._menuExcluirTodasExtensoes.Text = "Excluir Todas Extensões"
		self._menuExcluirTodasExtensoes.Click += self.MenuExcluirTodasExtensoesClick
		# 
		# menuExportarTodos
		# 
		self._menuExportarTodos.DropDownItems.AddRange(System.Array[System.Windows.Forms.ToolStripItem]([self._menuExportarBitmap, self._menuExportarIcone, self._menuExportarGIF, self._menuExportarJPEG, self._menuExportarPNG, self._menuExportarTIFF]))
		self._menuExportarTodos.Name = "menuExportarTodos"
		self._menuExportarTodos.Size = System.Drawing.Size(98, 20)
		self._menuExportarTodos.Text = "Exportar &Todos"
		# 
		# menuExportarBitmap
		# 
		self._menuExportarBitmap.Name = "menuExportarBitmap"
		self._menuExportarBitmap.Size = System.Drawing.Size(184, 22)
		self._menuExportarBitmap.Text = "Exportar para Bitmap"
		self._menuExportarBitmap.Click += self.MenuExportarBitmapClick
		# 
		# menuExportarIcone
		# 
		self._menuExportarIcone.Name = "menuExportarIcone"
		self._menuExportarIcone.Size = System.Drawing.Size(184, 22)
		self._menuExportarIcone.Text = "Exportar para Ícone"
		self._menuExportarIcone.Click += self.MenuExportarIconeClick
		# 
		# menuExportarGIF
		# 
		self._menuExportarGIF.Name = "menuExportarGIF"
		self._menuExportarGIF.Size = System.Drawing.Size(184, 22)
		self._menuExportarGIF.Text = "Exportar para GIF"
		self._menuExportarGIF.Click += self.MenuExportarGIFClick
		# 
		# menuExportarJPEG
		# 
		self._menuExportarJPEG.Name = "menuExportarJPEG"
		self._menuExportarJPEG.Size = System.Drawing.Size(184, 22)
		self._menuExportarJPEG.Text = "Exportar para JPEG"
		self._menuExportarJPEG.Click += self.MenuExportarJPEGClick
		# 
		# menuExportarPNG
		# 
		self._menuExportarPNG.Name = "menuExportarPNG"
		self._menuExportarPNG.Size = System.Drawing.Size(184, 22)
		self._menuExportarPNG.Text = "Exportar para PNG"
		self._menuExportarPNG.Click += self.MenuExportarPNGClick
		# 
		# menuExportarTIFF
		# 
		self._menuExportarTIFF.Name = "menuExportarTIFF"
		self._menuExportarTIFF.Size = System.Drawing.Size(184, 22)
		self._menuExportarTIFF.Text = "Exportar para TIFF"
		self._menuExportarTIFF.Click += self.MenuExportarTIFFClick
		# 
		# menuImportarTodos
		# 
		self._menuImportarTodos.DropDownItems.AddRange(System.Array[System.Windows.Forms.ToolStripItem]([self._menuImportarIconesArquivos, self._menuExtrairIconesArquivos]))
		self._menuImportarTodos.Name = "menuImportarTodos"
		self._menuImportarTodos.Size = System.Drawing.Size(101, 20)
		self._menuImportarTodos.Text = "&Importar Todos"
		# 
		# menuImportarIconesArquivos
		# 
		self._menuImportarIconesArquivos.Name = "menuImportarIconesArquivos"
		self._menuImportarIconesArquivos.Size = System.Drawing.Size(229, 22)
		self._menuImportarIconesArquivos.Text = "Importar Ícones dos Arquivos"
		self._menuImportarIconesArquivos.Click += self.MenuImportarIconesArquivosClick
		# 
		# menuExtrairIconesArquivos
		# 
		self._menuExtrairIconesArquivos.Name = "menuExtrairIconesArquivos"
		self._menuExtrairIconesArquivos.Size = System.Drawing.Size(229, 22)
		self._menuExtrairIconesArquivos.Text = "Extrair Ícones dos Arquivos"
		self._menuExtrairIconesArquivos.Click += self.MenuExtrairIconesArquivosClick
		# 
		# lvExtensao
		# 
		self._lvExtensao.Columns.AddRange(System.Array[System.Windows.Forms.ColumnHeader]([self._columnHeader1, self._columnHeader2]))
		self._lvExtensao.GridLines = True
		self._lvExtensao.Location = System.Drawing.Point(0, 24)
		self._lvExtensao.MultiSelect = False
		self._lvExtensao.Name = "lvExtensao"
		self._lvExtensao.OwnerDraw = True
		self._lvExtensao.Size = System.Drawing.Size(280, 325)
		self._lvExtensao.TabIndex = 2
		self._lvExtensao.UseCompatibleStateImageBehavior = False
		self._lvExtensao.View = System.Windows.Forms.View.Details
		self._lvExtensao.DrawColumnHeader += self.LvExtensaoDrawColumnHeader
		self._lvExtensao.DrawItem += self.LvExtensaoDrawItem
		self._lvExtensao.DrawSubItem += self.LvExtensaoDrawSubItem
		# 
		# columnHeader1
		# 
		self._columnHeader1.Text = "Extensão"
		self._columnHeader1.Width = 167
		# 
		# columnHeader2
		# 
		self._columnHeader2.Text = "Ícone"
		self._columnHeader2.TextAlign = System.Windows.Forms.HorizontalAlignment.Center
		self._columnHeader2.Width = 58
		# 
		# imgListExtensao
		# 
		self._imgListExtensao.ColorDepth = System.Windows.Forms.ColorDepth.Depth8Bit
		self._imgListExtensao.ImageSize = System.Drawing.Size(16, 16)
		self._imgListExtensao.TransparentColor = System.Drawing.Color.Transparent
		# 
		# panel1
		# 
		self._panel1.Controls.Add(self._btnExcluir)
		self._panel1.Controls.Add(self._btnIncluir)
		self._panel1.Dock = System.Windows.Forms.DockStyle.Bottom
		self._panel1.Location = System.Drawing.Point(0, 347)
		self._panel1.Name = "panel1"
		self._panel1.Size = System.Drawing.Size(280, 43)
		self._panel1.TabIndex = 3
		# 
		# btnExcluir
		# 
		self._btnExcluir.Location = System.Drawing.Point(155, 8)
		self._btnExcluir.Name = "btnExcluir"
		self._btnExcluir.Size = System.Drawing.Size(75, 23)
		self._btnExcluir.TabIndex = 1
		self._btnExcluir.Text = "&Excluir"
		self._btnExcluir.UseVisualStyleBackColor = True
		self._btnExcluir.Click += self.BtnExcluirClick
		# 
		# btnIncluir
		# 
		self._btnIncluir.Location = System.Drawing.Point(46, 8)
		self._btnIncluir.Name = "btnIncluir"
		self._btnIncluir.Size = System.Drawing.Size(75, 23)
		self._btnIncluir.TabIndex = 0
		self._btnIncluir.Text = "&Incluir"
		self._btnIncluir.UseVisualStyleBackColor = True
		self._btnIncluir.Click += self.BtnIncluirClick
		# 
		# odEscolhaArquivo
		# 
		self._odEscolhaArquivo.Filter = "Todos os Arquivos (*.*)|*.*"
		# 
		# FrmCadExtensao
		# 
		self.AutoScaleDimensions = System.Drawing.SizeF(6, 13)
		self.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
		self.ClientSize = System.Drawing.Size(280, 390)
		self.Controls.Add(self._lvExtensao)
		self.Controls.Add(self._menuStrip1)
		self.Controls.Add(self._panel1)
		self.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
		self.MainMenuStrip = self._menuStrip1
		self.MaximizeBox = False
		self.MinimizeBox = False
		self.Name = "FrmCadExtensao"
		self.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
		self.Text = "Cadastro de Extensão de Arquivo"
		self._menuStrip1.ResumeLayout(False)
		self._menuStrip1.PerformLayout()
		self._panel1.ResumeLayout(False)
		self.ResumeLayout(False)
		self.PerformLayout()

	def Dispose(self, disposing):
		if disposing:
			if self._components != None:
				self._components.Dispose()
		self.Dispose(disposing)

	def CarregarExtensoesNaGrid(self):
		lvExtensao.Items.Clear()
		imgListExtensao.Images.Clear()
		enumerator = self._catalogador.listaExtensoes.GetEnumerator()
		while enumerator.MoveNext():
			extensao = enumerator.Current
			item = lvExtensao.Items.Add(extensao.Nome)
			item.SubItems.Add("icone")
			imgListExtensao.Images.Add(Rotinas.byteArrayToBitmap(extensao.Bmp16))

	def LvExtensaoDrawColumnHeader(self, sender, e):
		e.DrawDefault = True

	def LvExtensaoDrawItem(self, sender, e):
		e.DrawBackground()
		if (e.State & ListViewItemStates.Selected) == ListViewItemStates.Selected:
			e.Graphics.FillRectangle(SystemBrushes.Highlight, e.Bounds)
			e.Item.ForeColor = SystemColors.HighlightText
		else:
			e.Item.ForeColor = SystemColors.WindowText
		e.DrawText()

	def LvExtensaoDrawSubItem(self, sender, e):
		if e.ColumnIndex > 0:
			e.DrawBackground()
			if (e.ItemState & ListViewItemStates.Selected) == ListViewItemStates.Selected:
				e.Graphics.FillRectangle(SystemBrushes.Highlight, e.Bounds)
				e.SubItem.ForeColor = SystemColors.HighlightText
			else:
				e.SubItem.ForeColor = SystemColors.WindowText
			rect = Rectangle(e.SubItem.Bounds.Left + 20, e.SubItem.Bounds.Top, e.SubItem.Bounds.Width, e.SubItem.Bounds.Height)
			e.Graphics.DrawImageUnscaled(imgListExtensao.Images[e.ItemIndex], rect)

	def MenuIncluirExtensaoClick(self, sender, e):
		retval = odEscolhaArquivo.ShowDialog()
		if retval == DialogResult.OK:
			arquivo = FileInfo(odEscolhaArquivo.FileName)
			if arquivo.Exists:
				log = StringList()
				if ExtensaoBO.Instancia.SalvarExtensao(self._catalogador.listaExtensoes, arquivo.Name, arquivo.FullName, log):
					self.CarregarExtensoesNaGrid()
					Dialogo.mensagemInfo("Extensão salva com sucesso!")
				else:
					Dialogo.mensagemInfo("Extensão já existe cadastrada!")

	def MenuExcluirExtensaoClick(self, sender, e):
		if self._catalogador.listaExtensoes.Count > 0:
			res = Dialogo.confirma("Tem Certeza, que você deseja excluir esta extensão?")
			if res:
				extensao = ExtensaoBO.Instancia.pegaExtensaoPorOrdem(self._catalogador.listaExtensoes, lvExtensao.SelectedIndices[0] + 1)
				if ExtensaoBO.Instancia.excluirExtensao(self._catalogador.listaExtensoes, extensao.Codigo):
					self.CarregarExtensoesNaGrid()
					Dialogo.mensagemInfo("Extensão excluída com sucesso!")

	def MenuExcluirTodasExtensoesClick(self, sender, e):
		res = Dialogo.confirma("Tem Certeza, que você deseja excluir todas as extensões?")
		if res:
			if ExtensaoBO.Instancia.excluirTodasExtensoes(self._catalogador.listaExtensoes):
				self.CarregarExtensoesNaGrid()
				Dialogo.mensagemInfo("Extensões excluídas com sucesso!")

	def MenuExportarBitmapClick(self, sender, e):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teBMP, self._catalogador.listaExtensoes)

	def MenuExportarIconeClick(self, sender, e):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teICO, self._catalogador.listaExtensoes)

	def MenuExportarGIFClick(self, sender, e):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teGIF, self._catalogador.listaExtensoes)

	def MenuExportarJPEGClick(self, sender, e):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teJPG, self._catalogador.listaExtensoes)

	def MenuExportarPNGClick(self, sender, e):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.tePNG, self._catalogador.listaExtensoes)

	def MenuExportarTIFFClick(self, sender, e):
		ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teTIF, self._catalogador.listaExtensoes)

	def MenuImportarIconesArquivosClick(self, sender, e):
		retval = odEscolhaArquivo.ShowDialog()
		if retval == DialogResult.OK:
			arquivo = FileInfo(odEscolhaArquivo.FileName)
			if arquivo.Exists:
				ExtensaoBO.Instancia.ImportarExtensao(arquivo.FullName, self._catalogador.listaExtensoes)
				self.CarregarExtensoesNaGrid()

	def MenuExtrairIconesArquivosClick(self, sender, e):
		retval = odEscolhaArquivo.ShowDialog()
		if retval == DialogResult.OK:
			arquivo = FileInfo(odEscolhaArquivo.FileName)
			if arquivo.Exists:
				ExtensaoBO.Instancia.ExtrairExtensao(arquivo.FullName, self._catalogador.listaExtensoes)
				self.CarregarExtensoesNaGrid()

	def BtnIncluirClick(self, sender, e):
		self.MenuIncluirExtensaoClick(sender, e)

	def BtnExcluirClick(self, sender, e):
		self.MenuExcluirExtensaoClick(sender, e)