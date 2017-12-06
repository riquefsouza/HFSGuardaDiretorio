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
require "Gtk, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetosgui
	# <summary>
	# Description of Dialogo.
	# </summary>
	class Dialogo
		def initialize()
		end

		def Dialogo.MessageBox(texto, titulo, tipoBotao, tipoMsg)
			dialog = MessageDialog.new(nil, DialogFlags.Modal | DialogFlags.DestroyWithParent, tipoMsg, tipoBotao, texto)
			dialog.Title = titulo
			dialog.SetPosition(WindowPosition.Center)
			retorno = dialog.Run()
			dialog.Destroy()
			return retorno
		end

		def Dialogo.mensagemErro(texto)
			Dialogo.MessageBox(texto, "Erro", ButtonsType.Ok, MessageType.Error)
		end

		def Dialogo.mensagemInfo(texto)
			Dialogo.MessageBox(texto, "Informação", ButtonsType.Ok, MessageType.Info)
		end

		def Dialogo.confirma(texto)
			res = Dialogo.MessageBox(texto, "Confirma", ButtonsType.YesNo, MessageType.Question)
			return (res == ResponseType.Yes)
		end

		def Dialogo.entrada(texto, valorInicial)
			dialog = MessageDialog.new(nil, DialogFlags.Modal | DialogFlags.DestroyWithParent, MessageType.Question, ButtonsType.OkCancel, texto)
			dialog.Title = "Informa"
			dialog.SetPosition(WindowPosition.Center)
			txtEntrada = Entry.new(10)
			txtEntrada.Text = valorInicial
			txtEntrada.Show()
			dialog.VBox.PackEnd(txtEntrada)
			dialog.DefaultResponse = ResponseType.Ok
			retorno = dialog.Run()
			valorInicial = txtEntrada.Text
			dialog.Destroy()
			if retorno == ResponseType.Ok then
				return valorInicial
			else
				return ""
			end
		end

		def Dialogo.entrada(texto)
			return Dialogo.entrada(texto, "")
		end
	end
end