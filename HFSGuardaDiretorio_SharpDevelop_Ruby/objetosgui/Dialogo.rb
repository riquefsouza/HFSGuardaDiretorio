# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 07/07/2015
# * Time: 14:01
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetosgui
	# <summary>
	# Description of Dialogo.
	# </summary>
	class Dialogo
		def initialize()
		end

		def Dialogo.mensagemErro(texto)
			MessageBox.Show(texto, "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error)
		end

		def Dialogo.mensagemInfo(texto)
			MessageBox.Show(texto, "Informação", MessageBoxButtons.OK, MessageBoxIcon.Information)
		end

		def Dialogo.confirma(texto)
			res = MessageBox.Show(texto, "Confirma", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
			return (res == DialogResult.Yes)
		end

		def Dialogo.entrada(texto, valorInicial)
			form = Form.new()
			label = Label.new()
			textBox = TextBox.new()
			buttonOk = Button.new()
			buttonCancel = Button.new()
			form.Text = "Informa"
			label.Text = texto
			textBox.Text = valorInicial
			textBox.MaxLength = 10
			buttonOk.Text = "OK"
			buttonCancel.Text = "Cancel"
			buttonOk.DialogResult = DialogResult.OK
			buttonCancel.DialogResult = DialogResult.Cancel
			label.SetBounds(9, 20, 372, 13)
			textBox.SetBounds(12, 36, 372, 20)
			buttonOk.SetBounds(228, 72, 75, 23)
			buttonCancel.SetBounds(309, 72, 75, 23)
			label.AutoSize = true
			textBox.Anchor = textBox.Anchor | AnchorStyles.Right
			buttonOk.Anchor = AnchorStyles.Bottom | AnchorStyles.Right
			buttonCancel.Anchor = AnchorStyles.Bottom | AnchorStyles.Right
			form.ClientSize = Size.new(396, 107)
			form.Controls.AddRange(Array[Control].new([label, textBox, buttonOk, buttonCancel]))
			form.ClientSize = Size.new(Math.Max(300, label.Right + 10), form.ClientSize.Height)
			form.FormBorderStyle = FormBorderStyle.FixedDialog
			form.StartPosition = FormStartPosition.CenterScreen
			form.MinimizeBox = false
			form.MaximizeBox = false
			form.AcceptButton = buttonOk
			form.CancelButton = buttonCancel
			res = form.ShowDialog()
			if res == DialogResult.OK then
				return textBox.Text
			else
				return ""
			end
		end

		def Dialogo.entrada(texto)
			return Dialogo.entrada(texto, "")
		end
	end
end