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
from Gtk import *

class Dialogo(object):
	""" <summary>
	 Description of Dialogo.
	 </summary>
	"""
	def __init__(self):
		pass
	def MessageBox(texto, titulo, tipoBotao, tipoMsg):
		dialog = MessageDialog(None, DialogFlags.Modal | DialogFlags.DestroyWithParent, tipoMsg, tipoBotao, texto)
		dialog.Title = titulo
		dialog.SetPosition(WindowPosition.Center)
		retorno = dialog.Run()
		dialog.Destroy()
		return retorno

	MessageBox = staticmethod(MessageBox)

	def mensagemErro(texto):
		Dialogo.MessageBox(texto, "Erro", ButtonsType.Ok, MessageType.Error)

	mensagemErro = staticmethod(mensagemErro)

	def mensagemInfo(texto):
		Dialogo.MessageBox(texto, "Informação", ButtonsType.Ok, MessageType.Info)

	mensagemInfo = staticmethod(mensagemInfo)

	def confirma(texto):
		res = Dialogo.MessageBox(texto, "Confirma", ButtonsType.YesNo, MessageType.Question)
		return (res == ResponseType.Yes)

	confirma = staticmethod(confirma)

	def entrada(texto, valorInicial):
		dialog = MessageDialog(None, DialogFlags.Modal | DialogFlags.DestroyWithParent, MessageType.Question, ButtonsType.OkCancel, texto)
		dialog.Title = "Informa"
		dialog.SetPosition(WindowPosition.Center)
		txtEntrada = Entry(10)
		txtEntrada.Text = valorInicial
		txtEntrada.Show()
		dialog.VBox.PackEnd(txtEntrada)
		dialog.DefaultResponse = ResponseType.Ok
		retorno = dialog.Run()
		valorInicial = txtEntrada.Text
		dialog.Destroy()
		if retorno == ResponseType.Ok:
			return valorInicial
		else:
			return ""

	entrada = staticmethod(entrada)

	def entrada(texto):
		return Dialogo.entrada(texto, "")

	entrada = staticmethod(entrada)