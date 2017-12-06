/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 07/07/2015
 * Time: 14:01
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using System.Drawing;
using Gtk;

namespace HFSGuardaDiretorio.objetosgui
{
	/// <summary>
	/// Description of Dialogo.
	/// </summary>
	public class Dialogo
	{
		public Dialogo()
		{
		}

		private static ResponseType MessageBox(string texto, string titulo, ButtonsType tipoBotao, MessageType tipoMsg) {
			MessageDialog dialog = new MessageDialog(null, 
				DialogFlags.Modal | DialogFlags.DestroyWithParent, 
				tipoMsg, tipoBotao, texto);
			dialog.Title = titulo;
			dialog.SetPosition(WindowPosition.Center);
			ResponseType retorno = (ResponseType)dialog.Run();
			dialog.Destroy();
			return retorno;
		}


		public static void mensagemErro(String texto) {
			MessageBox(texto, "Erro", ButtonsType.Ok, MessageType.Error);
		}
		
		public static void mensagemInfo(String texto) {
			MessageBox(texto, "Informação", ButtonsType.Ok, MessageType.Info);
		}
		
		public static bool confirma(String texto) {
			ResponseType res = MessageBox(texto, "Confirma", ButtonsType.YesNo, MessageType.Question);
			return (res == ResponseType.Yes);
		}
		
		public static String entrada(String texto, String valorInicial) {
			MessageDialog dialog = new MessageDialog(null, 
				DialogFlags.Modal |	DialogFlags.DestroyWithParent, 
				MessageType.Question, ButtonsType.OkCancel, texto);
			dialog.Title = "Informa";
			dialog.SetPosition(WindowPosition.Center);

			Entry txtEntrada = new Entry(10);
			txtEntrada.Text = valorInicial;
			txtEntrada.Show ();
			dialog.VBox.PackEnd (txtEntrada);
			dialog.DefaultResponse = ResponseType.Ok;

			int retorno = dialog.Run();
			valorInicial = txtEntrada.Text;
			dialog.Destroy();

			if (retorno == (int)ResponseType.Ok)
				return valorInicial;
			else
				return "";
		}
		
		public static String entrada(String texto) {
			return entrada(texto, "");
		}
		
	}
}
