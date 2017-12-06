# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 11/12/2014
# * Time: 11:24
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.IO, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosbo, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosgui, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.catalogador, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.gui
	# <summary>
	# Description of FrmImportarDiretorio.
	# </summary>
	class FrmImportarDiretorio < System::Windows::Forms::Form
		def initialize(frmPrincipal)
			@components = nil
			self.InitializeComponent()
			@frmImportarDiretorioProgresso = FrmImportarDiretorioProgresso.new(self)
			@listaImportar = List[Importar].new()
			self.@frmPrincipal = frmPrincipal
			@catalogador = frmPrincipal.Catalogador
		end

		def InitializeComponent()
			@memoImportaDir = System::Windows::Forms::TextBox.new()
			@barraStatus = System::Windows::Forms::StatusStrip.new()
			@labStatus1 = System::Windows::Forms::ToolStripStatusLabel.new()
			@labStatus2 = System::Windows::Forms::ToolStripStatusLabel.new()
			@pbImportar = System::Windows::Forms::ProgressBar.new()
			@barraStatus.SuspendLayout()
			self.SuspendLayout()
			# 
			# memoImportaDir
			# 
			@memoImportaDir.Dock = System::Windows::Forms::DockStyle.Top
			@memoImportaDir.Location = System::Drawing::Point.new(0, 0)
			@memoImportaDir.Multiline = true
			@memoImportaDir.Name = "memoImportaDir"
			@memoImportaDir.ScrollBars = System::Windows::Forms::ScrollBars.Both
			@memoImportaDir.Size = System::Drawing::Size.new(889, 505)
			@memoImportaDir.TabIndex = 0
			# 
			# barraStatus
			# 
			@barraStatus.Items.AddRange(System::Array[System::Windows::Forms::ToolStripItem].new([@labStatus1, @labStatus2]))
			@barraStatus.Location = System::Drawing::Point.new(0, 522)
			@barraStatus.Name = "barraStatus"
			@barraStatus.Size = System::Drawing::Size.new(889, 22)
			@barraStatus.TabIndex = 9
			@barraStatus.Text = "statusStrip1"
			# 
			# labStatus1
			# 
			@labStatus1.AutoSize = false
			@labStatus1.BorderSides = System::Windows::Forms::ToolStripStatusLabelBorderSides.Left | System::Windows::Forms::ToolStripStatusLabelBorderSides.Top | System::Windows::Forms::ToolStripStatusLabelBorderSides.Right | System::Windows::Forms::ToolStripStatusLabelBorderSides.Bottom
			@labStatus1.BorderStyle = System::Windows::Forms::Border3DStyle.SunkenInner
			@labStatus1.DisplayStyle = System::Windows::Forms::ToolStripItemDisplayStyle.Text
			@labStatus1.Name = "labStatus1"
			@labStatus1.Size = System::Drawing::Size.new(200, 17)
			@labStatus1.Text = "Total de linhas sendo processadas:"
			@labStatus1.TextAlign = System::Drawing::ContentAlignment.MiddleLeft
			# 
			# labStatus2
			# 
			@labStatus2.BorderSides = System::Windows::Forms::ToolStripStatusLabelBorderSides.Left | System::Windows::Forms::ToolStripStatusLabelBorderSides.Top | System::Windows::Forms::ToolStripStatusLabelBorderSides.Right | System::Windows::Forms::ToolStripStatusLabelBorderSides.Bottom
			@labStatus2.BorderStyle = System::Windows::Forms::Border3DStyle.SunkenInner
			@labStatus2.DisplayStyle = System::Windows::Forms::ToolStripItemDisplayStyle.Text
			@labStatus2.Name = "labStatus2"
			@labStatus2.Size = System::Drawing::Size.new(643, 17)
			@labStatus2.Spring = true
			@labStatus2.TextAlign = System::Drawing::ContentAlignment.MiddleLeft
			# 
			# pbImportar
			# 
			@pbImportar.Dock = System::Windows::Forms::DockStyle.Bottom
			@pbImportar.Location = System::Drawing::Point.new(0, 505)
			@pbImportar.Name = "pbImportar"
			@pbImportar.Size = System::Drawing::Size.new(889, 17)
			@pbImportar.Step = 1
			@pbImportar.TabIndex = 10
			# 
			# FrmImportarDiretorio
			# 
			self.AutoScaleDimensions = System::Drawing::SizeF.new(6, 13)
			self.AutoScaleMode = System::Windows::Forms::AutoScaleMode.Font
			self.ClientSize = System::Drawing::Size.new(889, 544)
			self.ControlBox = false
			self.Controls.Add(@pbImportar)
			self.Controls.Add(@barraStatus)
			self.Controls.Add(@memoImportaDir)
			self.FormBorderStyle = System::Windows::Forms::FormBorderStyle.FixedDialog
			self.MaximizeBox = false
			self.MinimizeBox = false
			self.Name = "FrmImportarDiretorio"
			self.StartPosition = System::Windows::Forms::FormStartPosition.CenterScreen
			self.Text = "Importando Diretório"
			self.Shown { |sender, e| @FrmImportarDiretorioShown(sender, e) }
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

		def FrmImportarDiretorioShown(sender, e)
			enumerator = self.@listaImportar.GetEnumerator()
			while enumerator.MoveNext()
				importar = enumerator.Current
				@catalogador.diretorioOrdem.Ordem = 1
				if not @bSubDiretorio then
					Cursor = Cursors.WaitCursor
					begin
						ImportarBO.Instancia.ImportacaoCompleta(importar, @catalogador.diretorioOrdem, @catalogador.listaExtensoes, @frmImportarDiretorioProgresso)
					rescue Exception => ex
						Dialogo.mensagemErro(ex.Message)
					ensure
					end
					Cursor = Cursors.Default
				else
					if not DiretorioBO.Instancia.verificaCodDir(importar.Aba, importar.RotuloRaiz, @catalogador.listaDiretorioPai) then
						Cursor = Cursors.WaitCursor
						begin
							ImportarBO.Instancia.ImportacaoCompleta(importar, @catalogador.diretorioOrdem, @catalogador.listaExtensoes, @frmImportarDiretorioProgresso)
						rescue Exception => ex
							Dialogo.mensagemErro(ex.Message)
						ensure
						end
						Cursor = Cursors.Default
					else
						Dialogo.mensagemInfo("O diretório já existe no catálogo!")
					end
				end
			end
			if @frmPrincipal.menuGravarLogImportacao.Selected then
				if memoImportaDir.Lines.Length > 0 then
					sLog = Rotinas.ExtractFilePath(Application.ExecutablePath) + Path.DirectorySeparatorChar + Rotinas.formataDate(Rotinas.FORMATO_DHARQUIVO, DateTime.Now) + "_Importacao.log"
					log = StringList.new()
					log.AddRange(memoImportaDir.Lines)
					log.SaveToFile(sLog)
				end
			end
			self.Close()
		end
	end
end