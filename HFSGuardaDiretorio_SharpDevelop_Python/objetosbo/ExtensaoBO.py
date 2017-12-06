# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 06/07/2015
# * Time: 15:02
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from System.IO import *
from System.Collections.Generic import *
from System.Drawing import *
from System.Drawing.Imaging import *
from System.Windows.Forms import *
from HFSGuardaDiretorio.comum import *
from HFSGuardaDiretorio.objetos import *
from HFSGuardaDiretorio.objetosdao import *

class ExtensaoBO(object):
	""" <summary>
	 Description of ExtensaoBO.
	 </summary>
	"""
	def get_Instancia(self):
		return self._instancia

	Instancia = property(fget=get_Instancia)

	def __init__(self):
		self._instancia = ExtensaoBO()

	#diretorioBMP = Rotinas.LerArquivoImagem("imagens"+Path.DirectorySeparatorChar+"diretorio.bmp");
	#arquivoBMP = Rotinas.LerArquivoImagem("imagens"+Path.DirectorySeparatorChar+"arquivo.bmp");
	def carregarExtensao(self, progressoLog):
		return ExtensaoDAO.Instancia.consultarTudo(progressoLog)

	def carregarExtensoes(self, lista, listaImg16, listaImg32):
		self._diretorioBMP = Rotinas.imageToByteArray(listaImg16.Images[0], ImageFormat.Bmp)
		self._arquivoBMP = Rotinas.imageToByteArray(listaImg16.Images[2], ImageFormat.Bmp)
		enumerator = lista.GetEnumerator()
		while enumerator.MoveNext():
			extensao = enumerator.Current
			bmp16 = Rotinas.byteArrayToBitmap(extensao.Bmp16)
			bmp32 = Rotinas.byteArrayToBitmap(extensao.Bmp32)
			listaImg16.Images.Add(bmp16)
			listaImg32.Images.Add(bmp32)

	def existeExtensao(self, sExtensao, listaLocal):
		if sExtensao.Trim().Length > 0:
			enumerator = listaLocal.GetEnumerator()
			while enumerator.MoveNext():
				extensao = enumerator.Current
				if extensao.Nome.Trim().ToLower().Equals(sExtensao.Trim().ToLower()):
					return True
		return False

	def retMaxCodExtensao(self, listaLocal):
		nMaior = 0
		enumerator = listaLocal.GetEnumerator()
		while enumerator.MoveNext():
			extensao = enumerator.Current
			if extensao.Codigo > nMaior:
				nMaior = extensao.Codigo
		return nMaior + 1

	def incluirExtensao(self, extensao):
		return (ExtensaoDAO.Instancia.incluir(extensao) > 0)

	def SalvarExtensao(self, listaExtensao, sNomeDiretorio, sCaminhoOriginal, log):
		if Rotinas.LastDelimiter(".", sNomeDiretorio) > 0:
			sExtensao = Rotinas.SubString(sNomeDiretorio, Rotinas.LastDelimiter(".", sNomeDiretorio) + 1, sNomeDiretorio.Length)
			if not self.existeExtensao(sExtensao, listaExtensao):
				extensao = Extensao()
				extensao.Codigo = self.retMaxCodExtensao(listaExtensao)
				extensao.Nome = sExtensao.ToLower()
				extensao.Ordem = listaExtensao.Count + 1
				extensao.Bmp16 = Rotinas.LerArquivoImagem(sCaminhoOriginal)
				extensao.Bmp32 = Rotinas.LerArquivoImagem(sCaminhoOriginal)
				self.incluirExtensao(extensao)
				listaExtensao.Add(extensao)
				log.Add("Salvando Extensão: " + extensao.Nome)
				return True
		return False

	def salvarExtensoes(self, listaDiretorio, listaExtensao, progressoLog):
		log = StringList()
		pb = Progresso()
		pb.Minimo = 0
		pb.Maximo = listaDiretorio.Count - 1
		pb.Posicao = 0
		pb.Passo = 1
		i = 0
		while i < listaDiretorio.Count:
			diretorio = listaDiretorio[i]
			if diretorio.Tipo.Codigo == 'A':
				self.SalvarExtensao(listaExtensao, diretorio.Nome, diretorio.CaminhoOriginal, log)
				if log.Count > 0:
					pb.Log = log[0]
					log.Clear()
			pb.Posicao = i
			if progressoLog != None:
				progressoLog.ProgressoLog(pb)
			i += 1

	def excluirExtensao(self, listaExtensao, codigo):
		if ExtensaoDAO.Instancia.excluir(codigo) > 0:
			i = 0
			while i < listaExtensao.Count:
				extensao = listaExtensao[i]
				if extensao.Codigo == codigo:
					listaExtensao.Remove(extensao)
					break
				i += 1
			return True
		else:
			return False

	def excluirTodasExtensoes(self, listaExtensao):
		if ExtensaoDAO.Instancia.excluirTudo() > 0:
			listaExtensao.Clear()
			return True
		else:
			return False

	def criarTabelaExtensoes(self):
		return (ExtensaoDAO.Instancia.criarTabela() > 0)

	def indiceExtensao(self, lista, nomeExtensao):
		nomeExtensao = Rotinas.SubString(nomeExtensao, Rotinas.LastDelimiter(".", nomeExtensao) + 1, nomeExtensao.Length)
		enumerator = lista.GetEnumerator()
		while enumerator.MoveNext():
			extensao = enumerator.Current
			if extensao.Nome.Trim().ToLower().Equals(nomeExtensao.Trim().ToLower()):
				return (extensao.Ordem + 2)
		return -1

	def pegaExtensaoPorOrdem(self, lista, ordem):
		enumerator = lista.GetEnumerator()
		while enumerator.MoveNext():
			extensao = enumerator.Current
			if extensao.Ordem == ordem:
				return extensao
		return None

	def pegaExtensaoPorCodigo(self, lista, codigo):
		enumerator = lista.GetEnumerator()
		while enumerator.MoveNext():
			extensao = enumerator.Current
			if extensao.Codigo == codigo:
				return extensao
		return None

	def pegaExtensaoPorNome(self, lista, nome, tipo):
		ext = None
		if tipo.Equals("Diretório"):
			ext = Extensao()
			ext.Bmp16 = self._diretorioBMP
		else:
			if lista != None and lista.Count > 0:
				enumerator = lista.GetEnumerator()
				while enumerator.MoveNext():
					extensao = enumerator.Current
					if extensao.Nome.ToLower().Equals(nome.ToLower()):
						return extensao
			if tipo.Equals("Arquivo"):
				ext = Extensao()
				ext.Bmp16 = self._arquivoBMP
		return ext

	def ExportarExtensao(self, tipo, listaExtensao):
		if listaExtensao.Count > 0:
			sCaminho = Rotinas.ExtractFilePath(Application.ExecutablePath) + Rotinas.BARRA_INVERTIDA
			if tipo == TipoExportarExtensao.teBMP:
				sExtensao = "." + Rotinas.EXTENSAO_BMP
			elif tipo == TipoExportarExtensao.teICO:
				sExtensao = "." + Rotinas.EXTENSAO_ICO
			elif tipo == TipoExportarExtensao.teGIF:
				sExtensao = "." + Rotinas.EXTENSAO_GIF
			elif tipo == TipoExportarExtensao.teJPG:
				sExtensao = "." + Rotinas.EXTENSAO_JPEG
			elif tipo == TipoExportarExtensao.tePNG:
				sExtensao = "." + Rotinas.EXTENSAO_PNG
			elif tipo == TipoExportarExtensao.teTIF:
				sExtensao = "." + Rotinas.EXTENSAO_TIFF
			else:
				sExtensao = ".img"
			enumerator = listaExtensao.GetEnumerator()
			while enumerator.MoveNext():
				extensao = enumerator.Current
				sImg16 = sCaminho + extensao.Nome + "16" + sExtensao
				if Rotinas.FileExists(sImg16):
					Rotinas.DeleteFile(sImg16)
				sImg32 = sCaminho + extensao.Nome + "32" + sExtensao
				if Rotinas.FileExists(sImg32):
					Rotinas.DeleteFile(sImg32)
				if tipo == TipoExportarExtensao.teBMP:
					Rotinas.SaveToFile(extensao.Bmp16, sImg16)
					Rotinas.SaveToFile(extensao.Bmp32, sImg32)
				elif tipo == TipoExportarExtensao.teICO:
					if extensao.Bmp16 != None:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp16, Rotinas.EXTENSAO_ICO), sImg16)
					if extensao.Bmp32 != None:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp32, Rotinas.EXTENSAO_ICO), sImg32)
				elif tipo == TipoExportarExtensao.teGIF:
					if extensao.Bmp16 != None:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp16, Rotinas.EXTENSAO_GIF), sImg16)
					if extensao.Bmp32 != None:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp32, Rotinas.EXTENSAO_GIF), sImg32)
				elif tipo == TipoExportarExtensao.teJPG:
					if extensao.Bmp16 != None:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp16, Rotinas.EXTENSAO_JPEG), sImg16)
					if extensao.Bmp32 != None:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp32, Rotinas.EXTENSAO_JPEG), sImg32)
				elif tipo == TipoExportarExtensao.tePNG:
					if extensao.Bmp16 != None:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp16, Rotinas.EXTENSAO_PNG), sImg16)
					if extensao.Bmp32 != None:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp32, Rotinas.EXTENSAO_PNG), sImg32)
				elif tipo == TipoExportarExtensao.teTIF:
					if extensao.Bmp16 != None:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp16, Rotinas.EXTENSAO_TIFF), sImg16)
					if extensao.Bmp32 != None:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp32, Rotinas.EXTENSAO_TIFF), sImg32)
			return True
		return False

	def ImportarExtensao(self, caminho, listaExtensao):
		listaArquivos = StringList()
		log = StringList()
		if DiretorioBO.Instancia.carregarArquivos(caminho, listaArquivos):
			enumerator = listaArquivos.GetEnumerator()
			while enumerator.MoveNext():
				sArquivo = enumerator.Current
				self.SalvarExtensao(listaExtensao, Rotinas.ExtractFileName(sArquivo), sArquivo, log)

	def ExtrairExtensao(self, caminho, listaExtensao):
		listaArquivos = StringList()
		log = StringList()
		if DiretorioBO.Instancia.carregarTodosArquivos(caminho, listaArquivos):
			enumerator = listaArquivos.GetEnumerator()
			while enumerator.MoveNext():
				sArquivo = enumerator.Current
				self.SalvarExtensao(listaExtensao, Rotinas.ExtractFileName(sArquivo), sArquivo, log)