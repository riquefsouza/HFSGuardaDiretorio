# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 11/12/2014
# * Time: 11:11
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.gui

	class FrmInfoDiretorio < System::Windows::Forms::Form
		def initialize()
			@components = nil
			self.InitializeComponent()
			@fonte = Font.new(lvInfo.Items[0].Font, FontStyle.Bold)
		end

		def InitializeComponent()
			listViewItem1 = System::Windows::Forms::ListViewItem.new("Aba:")
			listViewItem2 = System::Windows::Forms::ListViewItem.new("Nome:")
			listViewItem3 = System::Windows::Forms::ListViewItem.new("Tamanho:")
			listViewItem4 = System::Windows::Forms::ListViewItem.new("Tipo:")
			listViewItem5 = System::Windows::Forms::ListViewItem.new("Modificado:")
			listViewItem6 = System::Windows::Forms::ListViewItem.new("Atributos:")
			listViewItem7 = System::Windows::Forms::ListViewItem.new("Caminho:")
			@groupBox1 = System::Windows::Forms::GroupBox.new()
			@label5 = System::Windows::Forms::Label.new()
			@label6 = System::Windows::Forms::Label.new()
			@label3 = System::Windows::Forms::Label.new()
			@label4 = System::Windows::Forms::Label.new()
			@label2 = System::Windows::Forms::Label.new()
			@label1 = System::Windows::Forms::Label.new()
			@lvInfo = System::Windows::Forms::ListView.new()
			@columnHeader1 = System::Windows::Forms::ColumnHeader.new()
			@columnHeader2 = System::Windows::Forms::ColumnHeader.new()
			@btnOk = System::Windows::Forms::Button.new()
			@groupBox1.SuspendLayout()
			self.SuspendLayout()
			# 
			# groupBox1
			# 
			@groupBox1.Controls.Add(@label5)
			@groupBox1.Controls.Add(@label6)
			@groupBox1.Controls.Add(@label3)
			@groupBox1.Controls.Add(@label4)
			@groupBox1.Controls.Add(@label2)
			@groupBox1.Controls.Add(@label1)
			@groupBox1.Location = System::Drawing::Point.new(12, 12)
			@groupBox1.Name = "groupBox1"
			@groupBox1.Size = System::Drawing::Size.new(340, 96)
			@groupBox1.TabIndex = 0
			@groupBox1.TabStop = false
			@groupBox1.Text = "Legenda dos Atributos"
			# 
			# label5
			# 
			@label5.Location = System::Drawing::Point.new(166, 62)
			@label5.Name = "label5"
			@label5.Size = System::Drawing::Size.new(168, 23)
			@label5.TabIndex = 5
			@label5.Text = "[ROL] - Arquivo Somente Leitura"
			@label5.TextAlign = System::Drawing::ContentAlignment.MiddleLeft
			# 
			# label6
			# 
			@label6.Location = System::Drawing::Point.new(6, 62)
			@label6.Name = "label6"
			@label6.Size = System::Drawing::Size.new(154, 23)
			@label6.TabIndex = 4
			@label6.Text = "[SYS] - Arquivo de Sistema"
			@label6.TextAlign = System::Drawing::ContentAlignment.MiddleLeft
			# 
			# label3
			# 
			@label3.Location = System::Drawing::Point.new(166, 39)
			@label3.Name = "label3"
			@label3.Size = System::Drawing::Size.new(168, 23)
			@label3.TabIndex = 3
			@label3.Text = "[VOL] - Volume ID"
			@label3.TextAlign = System::Drawing::ContentAlignment.MiddleLeft
			# 
			# label4
			# 
			@label4.Location = System::Drawing::Point.new(6, 39)
			@label4.Name = "label4"
			@label4.Size = System::Drawing::Size.new(154, 23)
			@label4.TabIndex = 2
			@label4.Text = "[HID] - Arquivo Oculto"
			@label4.TextAlign = System::Drawing::ContentAlignment.MiddleLeft
			# 
			# label2
			# 
			@label2.Location = System::Drawing::Point.new(166, 16)
			@label2.Name = "label2"
			@label2.Size = System::Drawing::Size.new(168, 23)
			@label2.TabIndex = 1
			@label2.Text = "[DIR] - Diretório"
			@label2.TextAlign = System::Drawing::ContentAlignment.MiddleLeft
			# 
			# label1
			# 
			@label1.Location = System::Drawing::Point.new(6, 16)
			@label1.Name = "label1"
			@label1.Size = System::Drawing::Size.new(154, 23)
			@label1.TabIndex = 0
			@label1.Text = "[ARQ] - Arquivo comum"
			@label1.TextAlign = System::Drawing::ContentAlignment.MiddleLeft
			# 
			# lvInfo
			# 
			@lvInfo.Columns.AddRange(System::Array[System::Windows::Forms::ColumnHeader].new([@columnHeader1, @columnHeader2]))
			@lvInfo.GridLines = true
			@lvInfo.Items.AddRange(System::Array[System::Windows::Forms::ListViewItem].new([listViewItem1, listViewItem2, listViewItem3, listViewItem4, listViewItem5, listViewItem6, listViewItem7]))
			@lvInfo.Location = System::Drawing::Point.new(18, 114)
			@lvInfo.MultiSelect = false
			@lvInfo.Name = "lvInfo"
			@lvInfo.OwnerDraw = true
			@lvInfo.Size = System::Drawing::Size.new(328, 181)
			@lvInfo.TabIndex = 1
			@lvInfo.UseCompatibleStateImageBehavior = false
			@lvInfo.View = System::Windows::Forms::View.Details
			@lvInfo.DrawColumnHeader { |sender, e| @LvInfoDrawColumnHeader(sender, e) }
			@lvInfo.DrawItem { |sender, e| @LvInfoDrawItem(sender, e) }
			@lvInfo.DrawSubItem { |sender, e| @LvInfoDrawSubItem(sender, e) }
			# 
			# columnHeader1
			# 
			@columnHeader1.Text = "Item"
			@columnHeader1.Width = 108
			# 
			# columnHeader2
			# 
			@columnHeader2.Text = "Descrição"
			@columnHeader2.Width = 214
			# 
			# btnOk
			# 
			@btnOk.Location = System::Drawing::Point.new(146, 309)
			@btnOk.Name = "btnOk"
			@btnOk.Size = System::Drawing::Size.new(75, 23)
			@btnOk.TabIndex = 2
			@btnOk.Text = "&Ok"
			@btnOk.UseVisualStyleBackColor = true
			@btnOk.Click { |sender, e| @BtnOkClick(sender, e) }
			# 
			# FrmInfoDiretorio
			# 
			self.AutoScaleDimensions = System::Drawing::SizeF.new(6, 13)
			self.AutoScaleMode = System::Windows::Forms::AutoScaleMode.Font
			self.ClientSize = System::Drawing::Size.new(363, 344)
			self.Controls.Add(@btnOk)
			self.Controls.Add(@lvInfo)
			self.Controls.Add(@groupBox1)
			self.FormBorderStyle = System::Windows::Forms::FormBorderStyle.FixedDialog
			self.MaximizeBox = false
			self.MinimizeBox = false
			self.Name = "FrmInfoDiretorio"
			self.StartPosition = System::Windows::Forms::FormStartPosition.CenterParent
			self.Text = "Informações do Diretório / Arquivo"
			@groupBox1.ResumeLayout(false)
			self.ResumeLayout(false)
		end

		def Dispose(disposing)
			if disposing then
				if @components != nil then
					@components.Dispose()
				end
			end
			self.Dispose(disposing)
		end

		def BtnOkClick(sender, e)
			self.Close()
		end

		def setDiretorio(diretorio)
			if diretorio != nil then
				lvInfo.Items[0].SubItems.Add(diretorio.Aba.Nome)
				lvInfo.Items[1].SubItems.Add(diretorio.Nome)
				lvInfo.Items[2].SubItems.Add(diretorio.TamanhoFormatado)
				lvInfo.Items[3].SubItems.Add(diretorio.Tipo.Nome)
				lvInfo.Items[4].SubItems.Add(diretorio.ModificadoFormatado)
				lvInfo.Items[5].SubItems.Add(diretorio.Atributos)
				lvInfo.Items[6].SubItems.Add(diretorio.Caminho)
				lvInfo.Columns[1].Width = diretorio.Caminho.Length * 8
			end
		end

		def LvInfoDrawColumnHeader(sender, e)
			e.DrawDefault = true
		end

		def LvInfoDrawItem(sender, e)
			e.DrawBackground()
			if (e.State & ListViewItemStates.Selected) == ListViewItemStates.Selected then
				e.Graphics.FillRectangle(SystemBrushes.Highlight, e.Bounds)
				e.Item.ForeColor = SystemColors.HighlightText
			else
				e.Item.ForeColor = SystemColors.WindowText
			end
			e.Item.Font = @fonte
			e.DrawText()
		end

		def LvInfoDrawSubItem(sender, e)
			e.DrawBackground()
			if (e.ItemState & ListViewItemStates.Selected) == ListViewItemStates.Selected then
				e.Graphics.FillRectangle(SystemBrushes.Highlight, e.Bounds)
				e.SubItem.ForeColor = SystemColors.HighlightText
			else
				e.SubItem.ForeColor = SystemColors.WindowText
			end
			e.DrawText()
		end
	end
end