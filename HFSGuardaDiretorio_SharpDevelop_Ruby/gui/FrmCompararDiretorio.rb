# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 11/12/2014
# * Time: 11:44
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.IO, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.catalogador, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosbo, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosgui, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.gui
	# <summary>
	# Description of FrmCompararDiretorio.
	# </summary>
	class FrmCompararDiretorio < System::Windows::Forms::Form
		def initialize(frmPrincipal)
			@components = nil
			self.InitializeComponent()
			@listaCompara = List[Diretorio].new()
			@frmCompararDiretorioProgresso = FrmCompararDiretorioProgresso.new(self)
			@catalogador = frmPrincipal.Catalogador
			self.CarregarDados()
			self.LimparComparacao()
		end
		
		def InitializeComponent()
			@components = System.ComponentModel.Container.new()
			resources = System.ComponentModel.ComponentResourceManager.new(FrmCompararDiretorio.to_clr_type)
			@panel1 = System::Windows::Forms::Panel.new()
			@pb = System::Windows::Forms::ProgressBar.new()
			@btnSalvarLog = System::Windows::Forms::Button.new()
			@btnCompararDiretorios = System::Windows::Forms::Button.new()
			@gpDiretorio1 = System::Windows::Forms::GroupBox.new()
			@tvDiretorio1 = System::Windows::Forms::TreeView.new()
			@imageList1 = System::Windows::Forms::ImageList.new(@components)
			@cmbAba1 = System::Windows::Forms::ComboBox.new()
			@gpDiretorio2 = System::Windows::Forms::GroupBox.new()
			@tvDiretorio2 = System::Windows::Forms::TreeView.new()
			@cmbAba2 = System::Windows::Forms::ComboBox.new()
			@barraStatus = System::Windows::Forms::StatusStrip.new()
			@labStatus1 = System::Windows::Forms::ToolStripStatusLabel.new()
			@labStatus2 = System::Windows::Forms::ToolStripStatusLabel.new()
			@label1 = System::Windows::Forms::Label.new()
			@lvCompara = System::Windows::Forms::ListView.new()
			@columnHeader10 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader11 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader12 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader13 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader14 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader15 = System::Windows::Forms::ColumnHeader.new()
			@panel1.SuspendLayout()
			@gpDiretorio1.SuspendLayout()
			@gpDiretorio2.SuspendLayout()
			@barraStatus.SuspendLayout()
			self.SuspendLayout()
			# 
			# panel1
			# 
			@panel1.Controls.Add(@pb)
			@panel1.Controls.Add(@btnSalvarLog)
			@panel1.Controls.Add(@btnCompararDiretorios)
			@panel1.Dock = System::Windows::Forms::DockStyle.Top
			@panel1.Location = System::Drawing::Point.new(0, 0)
			@panel1.Name = "panel1"
			@panel1.Size = System::Drawing::Size.new(687, 37)
			@panel1.TabIndex = 0
			# 
			# pb
			# 
			@pb.Location = System::Drawing::Point.new(136, 10)
			@pb.Name = "pb"
			@pb.Size = System::Drawing::Size.new(446, 19)
			@pb.Step = 1
			@pb.TabIndex = 2
			# 
			# btnSalvarLog
			# 
			@btnSalvarLog.Location = System::Drawing::Point.new(588, 8)
			@btnSalvarLog.Name = "btnSalvarLog"
			@btnSalvarLog.Size = System::Drawing::Size.new(87, 23)
			@btnSalvarLog.TabIndex = 1
			@btnSalvarLog.Text = "&Salvar Log"
			@btnSalvarLog.UseVisualStyleBackColor = true
			@btnSalvarLog.Click { |sender, e| @BtnSalvarLogClick(sender, e) }
			# 
			# btnCompararDiretorios
			# 
			@btnCompararDiretorios.Location = System::Drawing::Point.new(12, 8)
			@btnCompararDiretorios.Name = "btnCompararDiretorios"
			@btnCompararDiretorios.Size = System::Drawing::Size.new(118, 23)
			@btnCompararDiretorios.TabIndex = 0
			@btnCompararDiretorios.Text = "&Comparar Diretórios"
			@btnCompararDiretorios.UseVisualStyleBackColor = true
			@btnCompararDiretorios.Click { |sender, e| @BtnCompararDiretoriosClick(sender, e) }
			# 
			# gpDiretorio1
			# 
			@gpDiretorio1.Controls.Add(@tvDiretorio1)
			@gpDiretorio1.Controls.Add(@cmbAba1)
			@gpDiretorio1.Location = System::Drawing::Point.new(12, 43)
			@gpDiretorio1.Name = "gpDiretorio1"
			@gpDiretorio1.Size = System::Drawing::Size.new(329, 284)
			@gpDiretorio1.TabIndex = 1
			@gpDiretorio1.TabStop = false
			@gpDiretorio1.Text = "Diretório 1"
			# 
			# tvDiretorio1
			# 
			@tvDiretorio1.ImageIndex = 0
			@tvDiretorio1.ImageList = @imageList1
			@tvDiretorio1.Location = System::Drawing::Point.new(6, 46)
			@tvDiretorio1.Name = "tvDiretorio1"
			@tvDiretorio1.SelectedImageIndex = 0
			@tvDiretorio1.Size = System::Drawing::Size.new(317, 232)
			@tvDiretorio1.TabIndex = 1
			# 
			# imageList1
			# 
			@imageList1.ImageStream = ((resources.GetObject("imageList1.ImageStream")))
			@imageList1.TransparentColor = System::Drawing::Color.Transparent
			@imageList1.Images.SetKeyName(0, "Fechar.bmp")
			@imageList1.Images.SetKeyName(1, "Abrir.bmp")
			# 
			# cmbAba1
			# 
			@cmbAba1.DropDownStyle = System::Windows::Forms::ComboBoxStyle.DropDownList
			@cmbAba1.FormattingEnabled = true
			@cmbAba1.Location = System::Drawing::Point.new(6, 19)
			@cmbAba1.Name = "cmbAba1"
			@cmbAba1.Size = System::Drawing::Size.new(317, 21)
			@cmbAba1.TabIndex = 0
			@cmbAba1.SelectedIndexChanged { |sender, e| @CmbAba1SelectedIndexChanged(sender, e) }
			# 
			# gpDiretorio2
			# 
			@gpDiretorio2.Controls.Add(@tvDiretorio2)
			@gpDiretorio2.Controls.Add(@cmbAba2)
			@gpDiretorio2.Location = System::Drawing::Point.new(347, 43)
			@gpDiretorio2.Name = "gpDiretorio2"
			@gpDiretorio2.Size = System::Drawing::Size.new(329, 284)
			@gpDiretorio2.TabIndex = 2
			@gpDiretorio2.TabStop = false
			@gpDiretorio2.Text = "Diretório 2"
			# 
			# tvDiretorio2
			# 
			@tvDiretorio2.ImageIndex = 0
			@tvDiretorio2.ImageList = @imageList1
			@tvDiretorio2.Location = System::Drawing::Point.new(6, 46)
			@tvDiretorio2.Name = "tvDiretorio2"
			@tvDiretorio2.SelectedImageIndex = 0
			@tvDiretorio2.Size = System::Drawing::Size.new(317, 232)
			@tvDiretorio2.TabIndex = 1
			# 
			# cmbAba2
			# 
			@cmbAba2.DropDownStyle = System::Windows::Forms::ComboBoxStyle.DropDownList
			@cmbAba2.FormattingEnabled = true
			@cmbAba2.Location = System::Drawing::Point.new(6, 19)
			@cmbAba2.Name = "cmbAba2"
			@cmbAba2.Size = System::Drawing::Size.new(317, 21)
			@cmbAba2.TabIndex = 0
			@cmbAba2.SelectedIndexChanged { |sender, e| @CmbAba2SelectedIndexChanged(sender, e) }
			# 
			# barraStatus
			# 
			@barraStatus.Items.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@labStatus1, @labStatus2]))
			@barraStatus.Location = System::Drawing::Point.new(0, 558)
			@barraStatus.Name = "barraStatus"
			@barraStatus.Size = System::Drawing::Size.new(687, 22)
			@barraStatus.TabIndex = 10
			@barraStatus.Text = "statusStrip1"
			# 
			# labStatus1
			# 
			@labStatus1.AutoSize = false
			@labStatus1.BorderSides = (((((System::Windows::Forms::ToolStripStatusLabelBorderSides.Left | System::Windows::Forms::ToolStripStatusLabelBorderSides.Top) | System::Windows::Forms::ToolStripStatusLabelBorderSides.Right) | System::Windows::Forms::ToolStripStatusLabelBorderSides.Bottom)))
			@labStatus1.BorderStyle = System::Windows::Forms::Border3DStyle.SunkenInner
			@labStatus1.DisplayStyle = System::Windows::Forms::ToolStripItemDisplayStyle.Text
			@labStatus1.Name = "labStatus1"
			@labStatus1.Size = System::Drawing::Size.new(200, 17)
			@labStatus1.Text = "Total de diferenças encontradas:"
			@labStatus1.TextAlign = System::Drawing::ContentAlignment.MiddleLeft
			# 
			# labStatus2
			# 
			@labStatus2.BorderSides = (((((System::Windows::Forms::ToolStripStatusLabelBorderSides.Left | System::Windows::Forms::ToolStripStatusLabelBorderSides.Top) | System::Windows::Forms::ToolStripStatusLabelBorderSides.Right) | System::Windows::Forms::ToolStripStatusLabelBorderSides.Bottom)))
			@labStatus2.BorderStyle = System::Windows::Forms::Border3DStyle.SunkenInner
			@labStatus2.DisplayStyle = System::Windows::Forms::ToolStripItemDisplayStyle.Text
			@labStatus2.Name = "labStatus2"
			@labStatus2.Size = System::Drawing::Size.new(472, 17)
			@labStatus2.Spring = true
			@labStatus2.TextAlign = System::Drawing::ContentAlignment.MiddleLeft
			# 
			# label1
			# 
			@label1.Location = System::Drawing::Point.new(8, 330)
			@label1.Name = "label1"
			@label1.Size = System::Drawing::Size.new(138, 18)
			@label1.TabIndex = 11
			@label1.Text = "Diferenças Encontradas"
			# 
			# lvCompara
			# 
			@lvCompara.Columns.AddRange(System::Array[System::Windows::Forms::ColumnHeader].new([@columnHeader10, @columnHeader11, @columnHeader12, @columnHeader13, @columnHeader14, @columnHeader15]))
			@lvCompara.FullRowSelect = true
			@lvCompara.GridLines = true
			@lvCompara.HeaderStyle = System::Windows::Forms::ColumnHeaderStyle.Nonclickable
			@lvCompara.Location = System::Drawing::Point.new(0, 351)
			@lvCompara.MultiSelect = false
			@lvCompara.Name = "lvCompara"
			@lvCompara.Size = System::Drawing::Size.new(687, 205)
			@lvCompara.SmallImageList = @imageList1
			@lvCompara.TabIndex = 12
			@lvCompara.UseCompatibleStateImageBehavior = false
			@lvCompara.View = System::Windows::Forms::View.Details
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
			# FrmCompararDiretorio
			# 
			self.AutoScaleDimensions = System::Drawing::SizeF.new(6f, 13f)
			self.AutoScaleMode = System::Windows::Forms::AutoScaleMode.Font
			self.ClientSize = System::Drawing::Size.new(687, 580)
			self.Controls.Add(@lvCompara)
			self.Controls.Add(@label1)
			self.Controls.Add(@barraStatus)
			self.Controls.Add(@gpDiretorio2)
			self.Controls.Add(@gpDiretorio1)
			self.Controls.Add(@panel1)
			self.FormBorderStyle = System::Windows::Forms::FormBorderStyle.FixedDialog
			self.MaximizeBox = false
			self.MinimizeBox = false
			self.Name = "FrmCompararDiretorio"
			self.StartPosition = System::Windows::Forms::FormStartPosition.CenterScreen
			self.Text = "Comparar Diretórios"
			@panel1.ResumeLayout(false)
			@gpDiretorio1.ResumeLayout(false)
			@gpDiretorio2.ResumeLayout(false)
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
		
		def BtnSalvarLogClick(sender, e)
			if @listaCompara.Count > 0 then
				listaLocal = StringList.new()
				sLog = Rotinas.ExtractFilePath(Application.ExecutablePath) + Path.DirectorySeparatorChar + Rotinas.formataDate(Rotinas.FORMATO_DHARQUIVO, DateTime.Now) + "_Comparacao.log"
				enumerator = listaCompara.GetEnumerator()
				while enumerator.MoveNext()
					diretorio = enumerator.Current
					listaLocal.Add(diretorio.Caminho)
				end
				listaLocal.SaveToFile(sLog)
				Dialogo.mensagemInfo("Log salvo no mesmo diretório do sistema!")
			end
		end

		def BtnCompararDiretoriosClick(sender, e)
			sCaminhoDir1 = ""
			sCaminhoDir2 = ""
			bSelecionado = false
			if tvDiretorio1.SelectedNode.IsSelected then
				@catalogador.LerArvoreDiretorio(tvDiretorio1.SelectedNode, barraStatus)
				sCaminhoDir1 = labStatus2.Text
				if tvDiretorio2.SelectedNode.IsSelected then
					@catalogador.LerArvoreDiretorio(tvDiretorio2.SelectedNode, barraStatus)
					sCaminhoDir2 = labStatus2.Text
					bSelecionado = true
				end
			end
			self.LimparComparacao()
			if bSelecionado then
				self.Comparar(sCaminhoDir1, sCaminhoDir2)
			else
				Dialogo.mensagemInfo("Diretórios não selecionados!")
			end
		end

		def CmbAba1SelectedIndexChanged(sender, e)
			Cursor = Cursors.WaitCursor
			tvDiretorio1.Nodes.Clear()
			aba = AbaBO.Instancia.pegaAbaPorOrdem(@catalogador.listaAbas, cmbAba1.SelectedIndex + 1)
			@catalogador.CarregarArvore(tvDiretorio1, aba)
			tvDiretorio1.Select()
			self.LimparComparacao()
			Cursor = Cursors.Default
		end

		def CmbAba2SelectedIndexChanged(sender, e)
			Cursor = Cursors.WaitCursor
			tvDiretorio2.Nodes.Clear()
			aba = AbaBO.Instancia.pegaAbaPorOrdem(@catalogador.listaAbas, cmbAba2.SelectedIndex + 1)
			@catalogador.CarregarArvore(tvDiretorio2, aba)
			tvDiretorio2.Select()
			self.LimparComparacao()
			Cursor = Cursors.Default
		end

		def CarregarDados()
			enumerator = @catalogador.listaAbas.GetEnumerator()
			while enumerator.MoveNext()
				aba = enumerator.Current
				cmbAba1.Items.Add(aba.Nome)
				cmbAba2.Items.Add(aba.Nome)
			end
			cmbAba1.SelectedIndex = 0
			cmbAba2.SelectedIndex = 0
		end

		def LimparComparacao()
			pb.Value = 0
			lvCompara.Items.Clear()
			btnSalvarLog.Enabled = false
			labStatus2.Text = ""
		end

		def SQLCompara(aba1, aba2, caminho1, caminho2)
			sSQL = DiretorioBO.SQL_CONSULTA_ARQUIVO + " WHERE aba=" + aba1.Codigo + " AND caminho LIKE " + Rotinas.QuotedStr(caminho1 + "%") + " AND nome NOT IN (SELECT nome FROM Diretorios " + " WHERE aba=" + aba2.Codigo + " AND caminho LIKE " + Rotinas.QuotedStr(caminho2 + "%") + ")" + " ORDER BY 1, 2, 3"
			return sSQL
		end

		def Comparar(sCaminhoDir1, sCaminhoDir2)
			aba1 = AbaBO.Instancia.pegaAbaPorOrdem(@catalogador.listaAbas, cmbAba1.SelectedIndex + 1)
			aba2 = AbaBO.Instancia.pegaAbaPorOrdem(@catalogador.listaAbas, cmbAba2.SelectedIndex + 1)
			sSQL = self.SQLCompara(aba1, aba2, sCaminhoDir1, sCaminhoDir2)
			@listaCompara = DiretorioBO.Instancia.carregarDiretorio(sSQL, "consultaarquivo", @frmCompararDiretorioProgresso)
			if @listaCompara.Count > 0 then
				Tabela.Instancia.Carregar(true, lvCompara, @listaCompara, @catalogador.listaExtensoes, pb)
				tamLista = @listaCompara.Count
				labStatus2.Text = tamLista.ToString()
				btnSalvarLog.Enabled = true
			else
				Dialogo.mensagemInfo("Nenhuma diferença encontrada!")
			end
		end
	end
end