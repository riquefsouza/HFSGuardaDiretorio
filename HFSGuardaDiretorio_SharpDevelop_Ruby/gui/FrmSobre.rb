
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.gui
	class FrmSobre < System::Windows::Forms::Form
		def initialize()
			@components = nil
			self.InitializeComponent()
		end

		def InitializeComponent()
			@label1 = System::Windows::Forms::Label.new()
			@label2 = System::Windows::Forms::Label.new()
			@label3 = System::Windows::Forms::Label.new()
			@label4 = System::Windows::Forms::Label.new()
			@btnOk = System::Windows::Forms::Button.new()
			self.SuspendLayout()
			# 
			# label1
			# 
			@label1.Font = System::Drawing::Font.new("Microsoft Sans Serif", 8.25f, System::Drawing::FontStyle.Bold, System::Drawing::GraphicsUnit.Point, 0)
			@label1.Location = System::Drawing::Point.new(12, 9)
			@label1.Name = "label1"
			@label1.Size = System::Drawing::Size.new(268, 21)
			@label1.TabIndex = 0
			@label1.Text = "HFSGuardaDir 2.0 - Catalogador de Diretórios"
			@label1.TextAlign = System::Drawing::ContentAlignment.MiddleCenter
			# 
			# label2
			# 
			@label2.Location = System::Drawing::Point.new(12, 30)
			@label2.Name = "label2"
			@label2.Size = System::Drawing::Size.new(268, 18)
			@label2.TabIndex = 1
			@label2.Text = "Desenvolvido em C#, Versão: 2.0"
			@label2.TextAlign = System::Drawing::ContentAlignment.MiddleCenter
			# 
			# label3
			# 
			@label3.Location = System::Drawing::Point.new(12, 48)
			@label3.Name = "label3"
			@label3.Size = System::Drawing::Size.new(268, 18)
			@label3.TabIndex = 2
			@label3.Text = "Por Henrique Figueiredo de Souza"
			@label3.TextAlign = System::Drawing::ContentAlignment.MiddleCenter
			# 
			# label4
			# 
			@label4.Location = System::Drawing::Point.new(12, 66)
			@label4.Name = "label4"
			@label4.Size = System::Drawing::Size.new(268, 18)
			@label4.TabIndex = 3
			@label4.Text = "Todos os direitos reservados, 2014"
			@label4.TextAlign = System::Drawing::ContentAlignment.MiddleCenter
			# 
			# btnOk
			# 
			@btnOk.Location = System::Drawing::Point.new(108, 96)
			@btnOk.Name = "btnOk"
			@btnOk.Size = System::Drawing::Size.new(75, 23)
			@btnOk.TabIndex = 4
			@btnOk.Text = "&Ok"
			@btnOk.UseVisualStyleBackColor = true
			@btnOk.Click { |sender, e| @BtnOkClick(sender, e) }
			# 
			# FrmSobre
			# 
			self.AutoScaleDimensions = System::Drawing::SizeF.new(6, 13)
			self.AutoScaleMode = System::Windows::Forms::AutoScaleMode.Font
			self.ClientSize = System::Drawing::Size.new(292, 125)
			self.Controls.Add(@btnOk)
			self.Controls.Add(@label4)
			self.Controls.Add(@label3)
			self.Controls.Add(@label2)
			self.Controls.Add(@label1)
			self.FormBorderStyle = System::Windows::Forms::FormBorderStyle.FixedDialog
			self.MaximizeBox = false
			self.MinimizeBox = false
			self.Name = "FrmSobre"
			self.StartPosition = System::Windows::Forms::FormStartPosition.CenterScreen
			self.Text = "Sobre o Catalogador"
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
	end
end