# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 07/07/2015
# * Time: 14:01
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from System.Drawing import *
from System.Windows.Forms import *

class Dialogo(object):
	""" <summary>
	 Description of Dialogo.
	 </summary>
	"""
	def __init__(self):
		pass
	def mensagemErro(texto):
		MessageBox.Show(texto, "Erro", MessageBoxButtons.OK, MessageBoxIcon.Error)

	mensagemErro = staticmethod(mensagemErro)

	def mensagemInfo(texto):
		MessageBox.Show(texto, "Informação", MessageBoxButtons.OK, MessageBoxIcon.Information)

	mensagemInfo = staticmethod(mensagemInfo)

	def confirma(texto):
		res = MessageBox.Show(texto, "Confirma", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
		return (res == DialogResult.Yes)

	confirma = staticmethod(confirma)

	def entrada(texto, valorInicial):
		form = Form()
		label = Label()
		textBox = TextBox()
		buttonOk = Button()
		buttonCancel = Button()
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
		label.AutoSize = True
		textBox.Anchor = textBox.Anchor | AnchorStyles.Right
		buttonOk.Anchor = AnchorStyles.Bottom | AnchorStyles.Right
		buttonCancel.Anchor = AnchorStyles.Bottom | AnchorStyles.Right
		form.ClientSize = Size(396, 107)
		form.Controls.AddRange(Array[Control]((label, textBox, buttonOk, buttonCancel)))
		form.ClientSize = Size(Math.Max(300, label.Right + 10), form.ClientSize.Height)
		form.FormBorderStyle = FormBorderStyle.FixedDialog
		form.StartPosition = FormStartPosition.CenterScreen
		form.MinimizeBox = False
		form.MaximizeBox = False
		form.AcceptButton = buttonOk
		form.CancelButton = buttonCancel
		res = form.ShowDialog()
		if res == DialogResult.OK:
			return textBox.Text
		else:
			return ""

	entrada = staticmethod(entrada)

	def entrada(texto):
		return Dialogo.entrada(texto, "")

	entrada = staticmethod(entrada)