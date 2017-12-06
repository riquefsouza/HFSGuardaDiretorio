/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 07/07/2015
 * Time: 14:01
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetosgui

import System
import System.Drawing
import System.Windows.Forms

public class Dialogo:

	public def constructor():
		pass

	
	public static def mensagemErro(texto as String):
		MessageBox.Show(texto, 'Erro', MessageBoxButtons.OK, MessageBoxIcon.Error)

	
	public static def mensagemInfo(texto as String):
		MessageBox.Show(texto, 'Informação', MessageBoxButtons.OK, MessageBoxIcon.Information)

	
	public static def confirma(texto as String) as bool:
		res as DialogResult = MessageBox.Show(texto, 'Confirma', MessageBoxButtons.YesNo, MessageBoxIcon.Question)
		return (res == DialogResult.Yes)

	
	public static def entrada(texto as String, valorInicial as String) as String:
		form = Form()
		label = Label()
		textBox = TextBox()
		buttonOk = Button()
		buttonCancel = Button()
		
		form.Text = 'Informa'
		label.Text = texto
		textBox.Text = valorInicial
		textBox.MaxLength = 10
		
		buttonOk.Text = 'OK'
		buttonCancel.Text = 'Cancel'
		buttonOk.DialogResult = DialogResult.OK
		buttonCancel.DialogResult = DialogResult.Cancel
		
		label.SetBounds(9, 20, 372, 13)
		textBox.SetBounds(12, 36, 372, 20)
		buttonOk.SetBounds(228, 72, 75, 23)
		buttonCancel.SetBounds(309, 72, 75, 23)
		
		label.AutoSize = true
		textBox.Anchor = (textBox.Anchor | AnchorStyles.Right)
		buttonOk.Anchor = (AnchorStyles.Bottom | AnchorStyles.Right)
		buttonCancel.Anchor = (AnchorStyles.Bottom | AnchorStyles.Right)
		
		form.ClientSize = Size(396, 107)
		form.Controls.AddRange((of Control: label, textBox, buttonOk, buttonCancel))
		form.ClientSize = Size(Math.Max(300, (label.Right + 10)), form.ClientSize.Height)
		form.FormBorderStyle = FormBorderStyle.FixedDialog
		form.StartPosition = FormStartPosition.CenterScreen
		form.MinimizeBox = false
		form.MaximizeBox = false
		form.AcceptButton = buttonOk
		form.CancelButton = buttonCancel
		
		res as DialogResult = form.ShowDialog()
		
		if res == DialogResult.OK:
			return textBox.Text
		else:
			return ''

	
	public static def entrada(texto as String) as String:
		return entrada(texto, '')
	

