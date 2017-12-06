using System;
using Gtk;
using HFSGuardaDiretorio.comum;

namespace HFSGuardaDiretorio
{
	public class EscolhaArquivo
	{
		private static string FILTRO_TODOS_DIRETORIOS = "Todos os Diretórios (*.*)|*.*";

		public static string FILTRO_TODOS_ARQUIVOS = "Todos os Arquivos (*.*)|*.*";

		public static string FILTRO_XML = "Arquivo XML (*.xml)|*.xml";

		public static string FILTRO_EXPORTAR = "Arquivo TXT (*.txt)|*.txt|Arquivo CSV (*.csv)|*.csv|Arquivo HTML (*.html)|*.html|Arquivo XML (*.xml)|*.xml|Arquivo SQL (*.sql)|*.sql";

		public static string FILTRO_IMAGEM = "Arquivo BMP (*.bmp)|*.bmp|Arquivo ICO (*.ico)|*.ico|Arquivo GIF (*.gif)|*.gif|Arquivo JPEG (*.png)|*.png|Arquivo PNG (*.jpg)|*.jpg|Arquivo TIFF (*.tif)|*.tif";

		private static string nomeArquivo;

		private static string diretorioCorrente;

		public EscolhaArquivo ()
		{
			nomeArquivo = "";
			diretorioCorrente = "";
		}

		public static string NomeArquivo {
			get {
				return nomeArquivo;
			}
		}

		public static string DiretorioCorrente {
			get {
				return diretorioCorrente;
			}
		}
			
		private static void montaFiltro(FileChooserDialog fcdialog, string filtro){
			StringList sl = new StringList (filtro,'|');
			FileFilter ffiltro = null;
			bool bAdiciona = true;
			foreach (string item in sl) {
				if (bAdiciona) {
					ffiltro = new FileFilter ();
					ffiltro.Name = item;
					bAdiciona = false;
				} else {
					ffiltro.AddPattern (item);
					fcdialog.AddFilter (ffiltro);
					bAdiciona = true;
				}
			}
		}

		private static bool escolher(string filtro, string titulo, FileChooserAction acao, string textoAcao){
			FileChooserDialog fcdialog = new FileChooserDialog (titulo, null, acao, 
				"Cancelar", ResponseType.Cancel, textoAcao, ResponseType.Accept);
			fcdialog.SetPosition(WindowPosition.Center);
			montaFiltro (fcdialog, filtro);
			fcdialog.SelectMultiple = false;
			fcdialog.SetFilename (nomeArquivo);
			fcdialog.SetCurrentFolder (diretorioCorrente);

			int retorno = fcdialog.Run();
			nomeArquivo = fcdialog.Filename;
			diretorioCorrente = fcdialog.CurrentFolder;
			fcdialog.Destroy();

			return (retorno == (int)ResponseType.Accept);
		}

		public static bool abrirArquivo(string filtro, string diretorio, string arquivo){
			diretorioCorrente = diretorio;
			nomeArquivo = arquivo;
			return escolher(filtro, "Abrir Arquivo", FileChooserAction.Open, "Abrir");
		}

		public static bool abrirArquivo(string filtro){
			return abrirArquivo (filtro, "", "");
		}

		public static bool salvarArquivo(string filtro, string diretorio, string arquivo){
			diretorioCorrente = diretorio;
			nomeArquivo = arquivo;
			return escolher(filtro, "Salvar Arquivo", FileChooserAction.Save, "Salvar");
		}

		public static bool salvarArquivo(string filtro){
			return salvarArquivo (filtro, "", "");
		}

		public static bool abrirDiretorio(string diretorio){
			diretorioCorrente = diretorio;
			nomeArquivo = "";
			return escolher(FILTRO_TODOS_DIRETORIOS, "Selecionar Diretório", FileChooserAction.SelectFolder, "Selecionar");
		}

		public static bool abrirDiretorio(){
			return abrirDiretorio ("");
		}
	}
}

