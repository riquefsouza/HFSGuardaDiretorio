 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.IO, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.catalogador, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosgui, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosbo, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio_gui
	class FrmCadExtensao < System::Windows::Forms::Form
		def initialize(frmPrincipal)
			@components = nil
			self.InitializeComponent()
			odEscolhaArquivo.Filter = Rotinas.FILTRO_IMAGEM
			@catalogador = frmPrincipal.Catalogador
			self.CarregarExtensoesNaGrid()
		end

		def InitializeComponent()
			@components = System::ComponentModel::Container.new()
			@menuStrip1 = System::Windows::Forms::MenuStrip.new()
			@menuExtensao = System::Windows::Forms::ToolStripMenuItem.new()
			@menuIncluirExtensao = System::Windows::Forms::ToolStripMenuItem.new()
			@menuExcluirExtensao = System::Windows::Forms::ToolStripMenuItem.new()
			@menuExcluirTodasExtensoes = System::Windows::Forms::ToolStripMenuItem.new()
			@menuExportarTodos = System::Windows::Forms::ToolStripMenuItem.new()
			@menuExportarBitmap = System::Windows::Forms::ToolStripMenuItem.new()
			@menuExportarIcone = System::Windows::Forms::ToolStripMenuItem.new()
			@menuExportarGIF = System::Windows::Forms::ToolStripMenuItem.new()
			@menuExportarJPEG = System::Windows::Forms::ToolStripMenuItem.new()
			@menuExportarPNG = System::Windows::Forms::ToolStripMenuItem.new()
			@menuExportarTIFF = System::Windows::Forms::ToolStripMenuItem.new()
			@menuImportarTodos = System::Windows::Forms::ToolStripMenuItem.new()
			@menuImportarIconesArquivos = System::Windows::Forms::ToolStripMenuItem.new()
			@menuExtrairIconesArquivos = System::Windows::Forms::ToolStripMenuItem.new()
			@lvExtensao = System::Windows::Forms::ListView.new()
			@columnHeader1 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader2 = System::Windows::Forms::ColumnHeader.new()
			@imgListExtensao = System::Windows::Forms::ImageList.new(@components)
			@panel1 = System::Windows::Forms::Panel.new()
			@btnExcluir = System::Windows::Forms::Button.new()
			@btnIncluir = System::Windows::Forms::Button.new()
			@odEscolhaArquivo = System::Windows::Forms::OpenFileDialog.new()
			@menuStrip1.SuspendLayout()
			@panel1.SuspendLayout()
			self.SuspendLayout()
			# 
			# menuStrip1
			# 
			@menuStrip1.Items.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@menuExtensao, @menuExportarTodos, @menuImportarTodos]))
			@menuStrip1.Location = System::Drawing::Point.new(0, 0)
			@menuStrip1.Name = "menuStrip1"
			@menuStrip1.Size = System::Drawing::Size.new(280, 24)
			@menuStrip1.TabIndex = 0
			@menuStrip1.Text = "menuStrip1"
			# 
			# menuExtensao
			# 
			@menuExtensao.DropDownItems.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@menuIncluirExtensao, @menuExcluirExtensao, @menuExcluirTodasExtensoes]))
			@menuExtensao.Name = "menuExtensao"
			@menuExtensao.Size = System::Drawing::Size.new(65, 20)
			@menuExtensao.Text = "&Extensão"
			# 
			# menuIncluirExtensao
			# 
			@menuIncluirExtensao.Name = "menuIncluirExtensao"
			@menuIncluirExtensao.Size = System::Drawing::Size.new(197, 22)
			@menuIncluirExtensao.Text = "Incluir Extensão"
			@menuIncluirExtensao.Click { |sender, e| @MenuIncluirExtensaoClick(sender, e) }
			# 
			# menuExcluirExtensao
			# 
			@menuExcluirExtensao.Name = "menuExcluirExtensao"
			@menuExcluirExtensao.Size = System::Drawing::Size.new(197, 22)
			@menuExcluirExtensao.Text = "Excluir Extensão"
			@menuExcluirExtensao.Click { |sender, e| @MenuExcluirExtensaoClick(sender, e) }
			# 
			# menuExcluirTodasExtensoes
			# 
			@menuExcluirTodasExtensoes.Name = "menuExcluirTodasExtensoes"
			@menuExcluirTodasExtensoes.Size = System::Drawing::Size.new(197, 22)
			@menuExcluirTodasExtensoes.Text = "Excluir Todas Extensões"
			@menuExcluirTodasExtensoes.Click { |sender, e| @MenuExcluirTodasExtensoesClick(sender, e) }
			# 
			# menuExportarTodos
			# 
			@menuExportarTodos.DropDownItems.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@menuExportarBitmap, @menuExportarIcone, @menuExportarGIF, @menuExportarJPEG, @menuExportarPNG, @menuExportarTIFF]))
			@menuExportarTodos.Name = "menuExportarTodos"
			@menuExportarTodos.Size = System::Drawing::Size.new(98, 20)
			@menuExportarTodos.Text = "Exportar &Todos"
			# 
			# menuExportarBitmap
			# 
			@menuExportarBitmap.Name = "menuExportarBitmap"
			@menuExportarBitmap.Size = System::Drawing::Size.new(184, 22)
			@menuExportarBitmap.Text = "Exportar para Bitmap"
			@menuExportarBitmap.Click { |sender, e| @MenuExportarBitmapClick(sender, e) }
			# 
			# menuExportarIcone
			# 
			@menuExportarIcone.Name = "menuExportarIcone"
			@menuExportarIcone.Size = System::Drawing::Size.new(184, 22)
			@menuExportarIcone.Text = "Exportar para Ícone"
			@menuExportarIcone.Click { |sender, e| @MenuExportarIconeClick(sender, e) }
			# 
			# menuExportarGIF
			# 
			@menuExportarGIF.Name = "menuExportarGIF"
			@menuExportarGIF.Size = System::Drawing::Size.new(184, 22)
			@menuExportarGIF.Text = "Exportar para GIF"
			@menuExportarGIF.Click { |sender, e| @MenuExportarGIFClick(sender, e) }
			# 
			# menuExportarJPEG
			# 
			@menuExportarJPEG.Name = "menuExportarJPEG"
			@menuExportarJPEG.Size = System::Drawing::Size.new(184, 22)
			@menuExportarJPEG.Text = "Exportar para JPEG"
			@menuExportarJPEG.Click { |sender, e| @MenuExportarJPEGClick(sender, e) }
			# 
			# menuExportarPNG
			# 
			@menuExportarPNG.Name = "menuExportarPNG"
			@menuExportarPNG.Size = System::Drawing::Size.new(184, 22)
			@menuExportarPNG.Text = "Exportar para PNG"
			@menuExportarPNG.Click { |sender, e| @MenuExportarPNGClick(sender, e) }
			# 
			# menuExportarTIFF
			# 
			@menuExportarTIFF.Name = "menuExportarTIFF"
			@menuExportarTIFF.Size = System::Drawing::Size.new(184, 22)
			@menuExportarTIFF.Text = "Exportar para TIFF"
			@menuExportarTIFF.Click { |sender, e| @MenuExportarTIFFClick(sender, e) }
			# 
			# menuImportarTodos
			# 
			@menuImportarTodos.DropDownItems.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@menuImportarIconesArquivos, @menuExtrairIconesArquivos]))
			@menuImportarTodos.Name = "menuImportarTodos"
			@menuImportarTodos.Size = System::Drawing::Size.new(101, 20)
			@menuImportarTodos.Text = "&Importar Todos"
			# 
			# menuImportarIconesArquivos
			# 
			@menuImportarIconesArquivos.Name = "menuImportarIconesArquivos"
			@menuImportarIconesArquivos.Size = System::Drawing::Size.new(229, 22)
			@menuImportarIconesArquivos.Text = "Importar Ícones dos Arquivos"
			@menuImportarIconesArquivos.Click { |sender, e| @MenuImportarIconesArquivosClick(sender, e) }
			# 
			# menuExtrairIconesArquivos
			# 
			@menuExtrairIconesArquivos.Name = "menuExtrairIconesArquivos"
			@menuExtrairIconesArquivos.Size = System::Drawing::Size.new(229, 22)
			@menuExtrairIconesArquivos.Text = "Extrair Ícones dos Arquivos"
			@menuExtrairIconesArquivos.Click { |sender, e| @MenuExtrairIconesArquivosClick(sender, e) }
			# 
			# lvExtensao
			# 
			@lvExtensao.Columns.AddRange(System::Array[System::Windows::Forms::ColumnHeader].new([@columnHeader1, @columnHeader2]))
			@lvExtensao.GridLines = true
			@lvExtensao.Location = System::Drawing::Point.new(0, 24)
			@lvExtensao.MultiSelect = false
			@lvExtensao.Name = "lvExtensao"
			@lvExtensao.OwnerDraw = true
			@lvExtensao.Size = System::Drawing::Size.new(280, 325)
			@lvExtensao.TabIndex = 2
			@lvExtensao.UseCompatibleStateImageBehavior = false
			@lvExtensao.View = System::Windows::Forms::View.Details
			@lvExtensao.DrawColumnHeader { |sender, e| @LvExtensaoDrawColumnHeader(sender, e) }
			@lvExtensao.DrawItem { |sender, e| @LvExtensaoDrawItem(sender, e) }
			@lvExtensao.DrawSubItem { |sender, e| @LvExtensaoDrawSubItem(sender, e) }
			# 
			# columnHeader1
			# 
			@columnHeader1.Text = "Extensão"
			@columnHeader1.Width = 167
			# 
			# columnHeader2
			# 
			@columnHeader2.Text = "Ícone"
			@columnHeader2.TextAlign = System::Windows::Forms::HorizontalAlignment.Center
			@columnHeader2.Width = 58
			# 
			# imgListExtensao
			# 
			@imgListExtensao.ColorDepth = System::Windows::Forms::ColorDepth.Depth8Bit
			@imgListExtensao.ImageSize = System::Drawing::Size.new(16, 16)
			@imgListExtensao.TransparentColor = System::Drawing::Color.Transparent
			# 
			# panel1
			# 
			@panel1.Controls.Add(@btnExcluir)
			@panel1.Controls.Add(@btnIncluir)
			@panel1.Dock = System::Windows::Forms::DockStyle.Bottom
			@panel1.Location = System::Drawing::Point.new(0, 347)
			@panel1.Name = "panel1"
			@panel1.Size = System::Drawing::Size.new(280, 43)
			@panel1.TabIndex = 3
			# 
			# btnExcluir
			# 
			@btnExcluir.Location = System::Drawing::Point.new(155, 8)
			@btnExcluir.Name = "btnExcluir"
			@btnExcluir.Size = System::Drawing::Size.new(75, 23)
			@btnExcluir.TabIndex = 1
			@btnExcluir.Text = "&Excluir"
			@btnExcluir.UseVisualStyleBackColor = true
			@btnExcluir.Click { |sender, e| @BtnExcluirClick(sender, e) }
			# 
			# btnIncluir
			# 
			@btnIncluir.Location = System::Drawing::Point.new(46, 8)
			@btnIncluir.Name = "btnIncluir"
			@btnIncluir.Size = System::Drawing::Size.new(75, 23)
			@btnIncluir.TabIndex = 0
			@btnIncluir.Text = "&Incluir"
			@btnIncluir.UseVisualStyleBackColor = true
			@btnIncluir.Click { |sender, e| @BtnIncluirClick(sender, e) }
			# 
			# odEscolhaArquivo
			# 
			@odEscolhaArquivo.Filter = "Todos os Arquivos (*.*)|*.*"
			# 
			# FrmCadExtensao
			# 
			self.AutoScaleDimensions = System::Drawing::SizeF.new(6f, 13f)
			self.AutoScaleMode = System::Windows::Forms::AutoScaleMode.Font
			self.ClientSize = System::Drawing::Size.new(280, 390)
			self.Controls.Add(@lvExtensao)
			self.Controls.Add(@menuStrip1)
			self.Controls.Add(@panel1)
			self.FormBorderStyle = System::Windows::Forms::FormBorderStyle.FixedDialog
			self.MainMenuStrip = @menuStrip1
			self.MaximizeBox = false
			self.MinimizeBox = false
			self.Name = "FrmCadExtensao"
			self.StartPosition = System::Windows::Forms::FormStartPosition.CenterScreen
			self.Text = "Cadastro de Extensão de Arquivo"
			@menuStrip1.ResumeLayout(false)
			@menuStrip1.PerformLayout()
			@panel1.ResumeLayout(false)
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

		def CarregarExtensoesNaGrid()
			lvExtensao.Items.Clear()
			imgListExtensao.Images.Clear()
			enumerator = @catalogador.listaExtensoes.GetEnumerator()
			while enumerator.MoveNext()
				extensao = enumerator.Current
				item = lvExtensao.Items.Add(extensao.Nome)
				item.SubItems.Add("icone")
				imgListExtensao.Images.Add(Rotinas.byteArrayToBitmap(extensao.Bmp16))
			end
		end

		def LvExtensaoDrawColumnHeader(sender, e)
			e.DrawDefault = true
		end

		def LvExtensaoDrawItem(sender, e)
			e.DrawBackground()
			if (e.State & ListViewItemStates.Selected) == ListViewItemStates.Selected then
				e.Graphics.FillRectangle(SystemBrushes.Highlight, e.Bounds)
				e.Item.ForeColor = SystemColors.HighlightText
			else
				e.Item.ForeColor = SystemColors.WindowText
			end
			e.DrawText()
		end

		def LvExtensaoDrawSubItem(sender, e)
			if e.ColumnIndex > 0 then
				e.DrawBackground()
				if (e.ItemState & ListViewItemStates.Selected) == ListViewItemStates.Selected then
					e.Graphics.FillRectangle(SystemBrushes.Highlight, e.Bounds)
					e.SubItem.ForeColor = SystemColors.HighlightText
				else
					e.SubItem.ForeColor = SystemColors.WindowText
				end
				rect = Rectangle.new(e.SubItem.Bounds.Left + 20, e.SubItem.Bounds.Top, e.SubItem.Bounds.Width, e.SubItem.Bounds.Height)
				e.Graphics.DrawImageUnscaled(imgListExtensao.Images[e.ItemIndex], rect)
			end
		end

		def MenuIncluirExtensaoClick(sender, e)
			retval = odEscolhaArquivo.ShowDialog()
			if retval == DialogResult.OK then
				arquivo = FileInfo.new(odEscolhaArquivo.FileName)
				if arquivo.Exists then
					log = StringList.new()
					if ExtensaoBO.Instancia.SalvarExtensao(@catalogador.listaExtensoes, arquivo.Name, arquivo.FullName, log) then
						self.CarregarExtensoesNaGrid()
						Dialogo.mensagemInfo("Extensão salva com sucesso!")
					else
						Dialogo.mensagemInfo("Extensão já existe cadastrada!")
					end
				end
			end
		end

		def MenuExcluirExtensaoClick(sender, e)
			if @catalogador.listaExtensoes.Count > 0 then
				res = Dialogo.confirma("Tem Certeza, que você deseja excluir esta extensão?")
				if res then
					extensao = ExtensaoBO.Instancia.pegaExtensaoPorOrdem(@catalogador.listaExtensoes, lvExtensao.SelectedIndices[0] + 1)
					if ExtensaoBO.Instancia.excluirExtensao(@catalogador.listaExtensoes, extensao.Codigo) then
						self.CarregarExtensoesNaGrid()
						Dialogo.mensagemInfo("Extensão excluída com sucesso!")
					end
				end
			end
		end

		def MenuExcluirTodasExtensoesClick(sender, e)
			res = Dialogo.confirma("Tem Certeza, que você deseja excluir todas as extensões?")
			if res then
				if ExtensaoBO.Instancia.excluirTodasExtensoes(@catalogador.listaExtensoes) then
					self.CarregarExtensoesNaGrid()
					Dialogo.mensagemInfo("Extensões excluídas com sucesso!")
				end
			end
		end

		def MenuExportarBitmapClick(sender, e)
			ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teBMP, @catalogador.listaExtensoes)
		end

		def MenuExportarIconeClick(sender, e)
			ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teICO, @catalogador.listaExtensoes)
		end

		def MenuExportarGIFClick(sender, e)
			ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teGIF, @catalogador.listaExtensoes)
		end

		def MenuExportarJPEGClick(sender, e)
			ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teJPG, @catalogador.listaExtensoes)
		end

		def MenuExportarPNGClick(sender, e)
			ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.tePNG, @catalogador.listaExtensoes)
		end

		def MenuExportarTIFFClick(sender, e)
			ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teTIF, @catalogador.listaExtensoes)
		end

		def MenuImportarIconesArquivosClick(sender, e)
			retval = odEscolhaArquivo.ShowDialog()
			if retval == DialogResult.OK then
				arquivo = FileInfo.new(odEscolhaArquivo.FileName)
				if arquivo.Exists then
					ExtensaoBO.Instancia.ImportarExtensao(arquivo.FullName, @catalogador.listaExtensoes)
					self.CarregarExtensoesNaGrid()
				end
			end
		end

		def MenuExtrairIconesArquivosClick(sender, e)
			retval = odEscolhaArquivo.ShowDialog()
			if retval == DialogResult.OK then
				arquivo = FileInfo.new(odEscolhaArquivo.FileName)
				if arquivo.Exists then
					ExtensaoBO.Instancia.ExtrairExtensao(arquivo.FullName, @catalogador.listaExtensoes)
					self.CarregarExtensoesNaGrid()
				end
			end
		end

		def BtnIncluirClick(sender, e)
			self.MenuIncluirExtensaoClick(sender, e)
		end

		def BtnExcluirClick(sender, e)
			self.MenuExcluirExtensaoClick(sender, e)
		end
	end
end