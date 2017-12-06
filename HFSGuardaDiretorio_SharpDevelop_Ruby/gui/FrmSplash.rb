
require "mscorlib"
require "System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio_gui

	class FrmSplash < System::Windows::Forms::Form
		def initialize()
			@components = nil
			self.InitializeComponent()
		end
		
		def InitializeComponent()
			@label1 = System::Windows::Forms::Label.new()
			@label2 = System::Windows::Forms::Label.new()
			@pb = System::Windows::Forms::ProgressBar.new()
			self.SuspendLayout()
			# 
			# label1
			# 
			@label1.Font = System::Drawing::Font.new("Microsoft Sans Serif", 20f, System::Drawing::FontStyle.Bold, System::Drawing::GraphicsUnit.Point, 0)
			@label1.Location = System::Drawing::Point.new(21, 9)
			@label1.Name = "label1"
			@label1.Size = System::Drawing::Size.new(332, 34)
			@label1.TabIndex = 0
			@label1.Text = "HFSGuardaDiretorio 2.0"
			# 
			# label2
			# 
			@label2.Font = System::Drawing::Font.new("Microsoft Sans Serif", 15f, System::Drawing::FontStyle.Bold, System::Drawing::GraphicsUnit.Point, 0)
			@label2.Location = System::Drawing::Point.new(47, 53)
			@label2.Name = "label2"
			@label2.Size = System::Drawing::Size.new(267, 29)
			@label2.TabIndex = 1
			@label2.Text = "Catalogador de Diretórios"
			# 
			# pb
			# 
			@pb.Dock = System::Windows::Forms::DockStyle.Bottom
			@pb.Location = System::Drawing::Point.new(0, 96)
			@pb.Name = "pb"
			@pb.Size = System::Drawing::Size.new(375, 17)
			@pb.Step = 1
			@pb.TabIndex = 2
			# 
			# FrmSplash
			# 
			self.AutoScaleDimensions = System::Drawing::SizeF.new(6f, 13f)
			self.AutoScaleMode = System::Windows::Forms::AutoScaleMode.Font
			self.ClientSize = System::Drawing::Size.new(375, 113)
			self.ControlBox = false
			self.Controls.Add(@pb)
			self.Controls.Add(@label2)
			self.Controls.Add(@label1)
			self.FormBorderStyle = System::Windows::Forms::FormBorderStyle.None
			self.MaximizeBox = false
			self.MinimizeBox = false
			self.Name = "FrmSplash"
			self.ShowIcon = false
			self.SizeGripStyle = System::Windows::Forms::SizeGripStyle.Hide
			self.StartPosition = System::Windows::Forms::FormStartPosition.CenterScreen
			self.Text = "FrmSplash"
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
		
	end
end