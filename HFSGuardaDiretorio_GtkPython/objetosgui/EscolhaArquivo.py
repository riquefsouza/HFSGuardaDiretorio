from System import *
from Gtk import *
from HFSGuardaDiretorio.comum import *

class EscolhaArquivo(object):
	def __init__(self):
		self._FILTRO_TODOS_DIRETORIOS = "Todos os Diretórios (*.*)|*.*"
		self._FILTRO_TODOS_ARQUIVOS = "Todos os Arquivos (*.*)|*.*"
		self._FILTRO_XML = "Arquivo XML (*.xml)|*.xml"
		self._FILTRO_EXPORTAR = "Arquivo TXT (*.txt)|*.txt|Arquivo CSV (*.csv)|*.csv|Arquivo HTML (*.html)|*.html|Arquivo XML (*.xml)|*.xml|Arquivo SQL (*.sql)|*.sql"
		self._FILTRO_IMAGEM = "Arquivo BMP (*.bmp)|*.bmp|Arquivo ICO (*.ico)|*.ico|Arquivo GIF (*.gif)|*.gif|Arquivo JPEG (*.png)|*.png|Arquivo PNG (*.jpg)|*.jpg|Arquivo TIFF (*.tif)|*.tif"
		self._nomeArquivo = ""
		self._diretorioCorrente = ""

	def get_NomeArquivo(self):
		return self._nomeArquivo

	NomeArquivo = property(fget=get_NomeArquivo)

	def get_DiretorioCorrente(self):
		return self._diretorioCorrente

	DiretorioCorrente = property(fget=get_DiretorioCorrente)

	def montaFiltro(fcdialog, filtro):
		sl = StringList(filtro, '|')
		ffiltro = None
		bAdiciona = True
		enumerator = sl.GetEnumerator()
		while enumerator.MoveNext():
			item = enumerator.Current
			if bAdiciona:
				ffiltro = FileFilter()
				ffiltro.Name = item
				bAdiciona = False
			else:
				ffiltro.AddPattern(item)
				fcdialog.AddFilter(ffiltro)
				bAdiciona = True

	montaFiltro = staticmethod(montaFiltro)

	def escolher(filtro, titulo, acao, textoAcao):
		fcdialog = FileChooserDialog(titulo, None, acao, "Cancelar", ResponseType.Cancel, textoAcao, ResponseType.Accept)
		fcdialog.SetPosition(WindowPosition.Center)
		EscolhaArquivo.montaFiltro(fcdialog, filtro)
		fcdialog.SelectMultiple = False
		fcdialog.SetFilename(self._nomeArquivo)
		fcdialog.SetCurrentFolder(self._diretorioCorrente)
		retorno = fcdialog.Run()
		self._nomeArquivo = fcdialog.Filename
		self._diretorioCorrente = fcdialog.CurrentFolder
		fcdialog.Destroy()
		return (retorno == ResponseType.Accept)

	escolher = staticmethod(escolher)

	def abrirArquivo(filtro, diretorio, arquivo):
		self._diretorioCorrente = diretorio
		self._nomeArquivo = arquivo
		return EscolhaArquivo.escolher(filtro, "Abrir Arquivo", FileChooserAction.Open, "Abrir")

	abrirArquivo = staticmethod(abrirArquivo)

	def abrirArquivo(filtro):
		return EscolhaArquivo.abrirArquivo(filtro, "", "")

	abrirArquivo = staticmethod(abrirArquivo)

	def salvarArquivo(filtro, diretorio, arquivo):
		self._diretorioCorrente = diretorio
		self._nomeArquivo = arquivo
		return EscolhaArquivo.escolher(filtro, "Salvar Arquivo", FileChooserAction.Save, "Salvar")

	salvarArquivo = staticmethod(salvarArquivo)

	def salvarArquivo(filtro):
		return EscolhaArquivo.salvarArquivo(filtro, "", "")

	salvarArquivo = staticmethod(salvarArquivo)

	def abrirDiretorio(diretorio):
		self._diretorioCorrente = diretorio
		self._nomeArquivo = ""
		return EscolhaArquivo.escolher(self._FILTRO_TODOS_DIRETORIOS, "Selecionar Diretório", FileChooserAction.SelectFolder, "Selecionar")

	abrirDiretorio = staticmethod(abrirDiretorio)

	def abrirDiretorio():
		return EscolhaArquivo.abrirDiretorio("")

	abrirDiretorio = staticmethod(abrirDiretorio)