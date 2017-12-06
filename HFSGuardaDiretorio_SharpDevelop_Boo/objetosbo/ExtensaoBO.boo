/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 06/07/2015
 * Time: 15:02
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetosbo

import System
import System.Collections.Generic
import System.Drawing
import System.Drawing.Imaging
import System.Windows.Forms
import HFSGuardaDiretorio.comum
import HFSGuardaDiretorio.objetos
import HFSGuardaDiretorio.objetosdao

public final class ExtensaoBO:

	private static instancia = ExtensaoBO()

	
	private diretorioBMP as (byte)

	private arquivoBMP as (byte)

	
	public static Instancia as ExtensaoBO:
		get:
			return instancia

	
	private def constructor():
		pass
		//diretorioBMP = Rotinas.LerArquivoImagem("imagens"+Path.DirectorySeparatorChar+"diretorio.bmp");
		//arquivoBMP = Rotinas.LerArquivoImagem("imagens"+Path.DirectorySeparatorChar+"arquivo.bmp");

	
	public def carregarExtensao(progressoLog as IProgressoLog) as List[of Extensao]:
		return ExtensaoDAO.Instancia.consultarTudo(progressoLog)

	
	public def carregarExtensoes(lista as List[of Extensao], listaImg16 as ImageList, listaImg32 as ImageList):
		bmp16 as Bitmap
		bmp32 as Bitmap
		
		diretorioBMP = Rotinas.imageToByteArray(listaImg16.Images[0], ImageFormat.Bmp)
		arquivoBMP = Rotinas.imageToByteArray(listaImg16.Images[2], ImageFormat.Bmp)
		
		for extensao as Extensao in lista:
			bmp16 = Rotinas.byteArrayToBitmap(extensao.Bmp16)
			bmp32 = Rotinas.byteArrayToBitmap(extensao.Bmp32)
			
			listaImg16.Images.Add(bmp16)
			listaImg32.Images.Add(bmp32)

	
	public def existeExtensao(sExtensao as string, listaLocal as List[of Extensao]) as bool:
		if sExtensao.Trim().Length > 0:
			for extensao as Extensao in listaLocal:
				if extensao.Nome.Trim().ToLower().Equals(sExtensao.Trim().ToLower()):
					return true
		return false

	
	public def retMaxCodExtensao(listaLocal as List[of Extensao]) as int:
		nMaior = 0
		for extensao as Extensao in listaLocal:
			if extensao.Codigo > nMaior:
				nMaior = extensao.Codigo
		return (nMaior + 1)

	
	public def incluirExtensao(extensao as Extensao) as bool:
		return (ExtensaoDAO.Instancia.incluir(extensao) > 0)

	
	public def SalvarExtensao(listaExtensao as List[of Extensao], sNomeDiretorio as string, sCaminhoOriginal as string, log as StringList) as bool:
		sExtensao as string
		extensao as Extensao
		
		if Rotinas.LastDelimiter('.', sNomeDiretorio) > 0:
			sExtensao = Rotinas.SubString(sNomeDiretorio, (Rotinas.LastDelimiter('.', sNomeDiretorio) + 1), sNomeDiretorio.Length)
			if not existeExtensao(sExtensao, listaExtensao):
				extensao = Extensao()
				extensao.Codigo = retMaxCodExtensao(listaExtensao)
				extensao.Nome = sExtensao.ToLower()
				extensao.Ordem = (listaExtensao.Count + 1)
				extensao.Bmp16 = Rotinas.LerArquivoImagem(sCaminhoOriginal)
				extensao.Bmp32 = Rotinas.LerArquivoImagem(sCaminhoOriginal)
				incluirExtensao(extensao)
				listaExtensao.Add(extensao)
				log.Add(('Salvando Extensão: ' + extensao.Nome))
				return true
		return false

	
	public def salvarExtensoes(listaDiretorio as List[of Diretorio], listaExtensao as List[of Extensao], progressoLog as IProgressoLog):
		log = StringList()
		diretorio as Diretorio
		pb = Progresso()
		
		pb.Minimo = 0
		pb.Maximo = (listaDiretorio.Count - 1)
		pb.Posicao = 0
		pb.Passo = 1
		for i in range(0, listaDiretorio.Count):
		
			diretorio = listaDiretorio[i]
			
			if diretorio.Tipo.Codigo == char('A'):
				SalvarExtensao(listaExtensao, diretorio.Nome, diretorio.CaminhoOriginal, log)
				if log.Count > 0:
					pb.Log = log[0]
					log.Clear()
			
			pb.Posicao = i
			
			if progressoLog is not null:
				progressoLog.ProgressoLog(pb)

	
	public def excluirExtensao(listaExtensao as List[of Extensao], codigo as int) as bool:
		extensao as Extensao
		
		if ExtensaoDAO.Instancia.excluir(codigo) > 0:
			for i in range(0, listaExtensao.Count):
				extensao = listaExtensao[i]
				if extensao.Codigo == codigo:
					listaExtensao.Remove(extensao)
					break 
			return true
		else:
			return false

	
	public def excluirTodasExtensoes(listaExtensao as List[of Extensao]) as bool:
		if ExtensaoDAO.Instancia.excluirTudo() > 0:
			listaExtensao.Clear()
			return true
		else:
			return false

	
	public def criarTabelaExtensoes() as bool:
		return (ExtensaoDAO.Instancia.criarTabela() > 0)

	
	public def indiceExtensao(lista as List[of Extensao], nomeExtensao as string) as int:
		nomeExtensao = Rotinas.SubString(nomeExtensao, (Rotinas.LastDelimiter('.', nomeExtensao) + 1), nomeExtensao.Length)
		
		for extensao as Extensao in lista:
			if extensao.Nome.Trim().ToLower().Equals(nomeExtensao.Trim().ToLower()):
				return (extensao.Ordem + 2)
		return (-1)

	
	public def pegaExtensaoPorOrdem(lista as List[of Extensao], ordem as int) as Extensao:
		for extensao as Extensao in lista:
			if extensao.Ordem == ordem:
				return extensao
		return null

	
	public def pegaExtensaoPorCodigo(lista as List[of Extensao], codigo as int) as Extensao:
		for extensao as Extensao in lista:
			if extensao.Codigo == codigo:
				return extensao
		return null

	
	public def pegaExtensaoPorNome(lista as List[of Extensao], nome as string, tipo as string) as Extensao:
		ext as Extensao = null
		
		if tipo.Equals('Diretório'):
			ext = Extensao()
			ext.Bmp16 = diretorioBMP
		else:
			if (lista is not null) and (lista.Count > 0):
				for extensao as Extensao in lista:
					if extensao.Nome.ToLower().Equals(nome.ToLower()):
						return extensao
			if tipo.Equals('Arquivo'):
				ext = Extensao()
				ext.Bmp16 = arquivoBMP
		return ext

	
	public def ExportarExtensao(tipo as TipoExportarExtensao, listaExtensao as List[of Extensao]) as bool:
		sCaminho as string
		sImg16 as string
		sImg32 as string
		sExtensao as string
		
		if listaExtensao.Count > 0:
			sCaminho = (Rotinas.ExtractFilePath(Application.ExecutablePath) + Rotinas.BARRA_INVERTIDA)
			
			if tipo == TipoExportarExtensao.teBMP:
				sExtensao = ('.' + Rotinas.EXTENSAO_BMP)
			elif tipo == TipoExportarExtensao.teICO:
				sExtensao = ('.' + Rotinas.EXTENSAO_ICO)
			elif tipo == TipoExportarExtensao.teGIF:
				sExtensao = ('.' + Rotinas.EXTENSAO_GIF)
			elif tipo == TipoExportarExtensao.teJPG:
				sExtensao = ('.' + Rotinas.EXTENSAO_JPEG)
			elif tipo == TipoExportarExtensao.tePNG:
				sExtensao = ('.' + Rotinas.EXTENSAO_PNG)
			elif tipo == TipoExportarExtensao.teTIF:
				sExtensao = ('.' + Rotinas.EXTENSAO_TIFF)
			else:
				sExtensao = '.img'
			
			for extensao as Extensao in listaExtensao:
				sImg16 = (((sCaminho + extensao.Nome) + '16') + sExtensao)
				if Rotinas.FileExists(sImg16):
					Rotinas.DeleteFile(sImg16)
				
				sImg32 = (((sCaminho + extensao.Nome) + '32') + sExtensao)
				if Rotinas.FileExists(sImg32):
					Rotinas.DeleteFile(sImg32)
				converterGeneratedName1 = tipo
				
				if converterGeneratedName1 == TipoExportarExtensao.teBMP:
					Rotinas.SaveToFile(extensao.Bmp16, sImg16)
					Rotinas.SaveToFile(extensao.Bmp32, sImg32)
				elif converterGeneratedName1 == TipoExportarExtensao.teICO:
					if extensao.Bmp16 is not null:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp16, Rotinas.EXTENSAO_ICO), sImg16)
					if extensao.Bmp32 is not null:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp32, Rotinas.EXTENSAO_ICO), sImg32)
				elif converterGeneratedName1 == TipoExportarExtensao.teGIF:
					if extensao.Bmp16 is not null:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp16, Rotinas.EXTENSAO_GIF), sImg16)
					if extensao.Bmp32 is not null:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp32, Rotinas.EXTENSAO_GIF), sImg32)
				elif converterGeneratedName1 == TipoExportarExtensao.teJPG:
					if extensao.Bmp16 is not null:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp16, Rotinas.EXTENSAO_JPEG), sImg16)
					if extensao.Bmp32 is not null:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp32, Rotinas.EXTENSAO_JPEG), sImg32)
				elif converterGeneratedName1 == TipoExportarExtensao.tePNG:
					if extensao.Bmp16 is not null:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp16, Rotinas.EXTENSAO_PNG), sImg16)
					if extensao.Bmp32 is not null:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp32, Rotinas.EXTENSAO_PNG), sImg32)
				elif converterGeneratedName1 == TipoExportarExtensao.teTIF:
					if extensao.Bmp16 is not null:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp16, Rotinas.EXTENSAO_TIFF), sImg16)
					if extensao.Bmp32 is not null:
						Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp32, Rotinas.EXTENSAO_TIFF), sImg32)
				
			return true
		return false

	
	public def ImportarExtensao(caminho as string, listaExtensao as List[of Extensao]):
		listaArquivos as StringList
		log as StringList
		listaArquivos = StringList()
		log = StringList()
		
		if DiretorioBO.Instancia.carregarArquivos(caminho, listaArquivos):
			for sArquivo as string in listaArquivos:
				SalvarExtensao(listaExtensao, Rotinas.ExtractFileName(sArquivo), sArquivo, log)
		

	
	public def ExtrairExtensao(caminho as string, listaExtensao as List[of Extensao]):
		listaArquivos as StringList
		log as StringList
		listaArquivos = StringList()
		log = StringList()
		
		if DiretorioBO.Instancia.carregarTodosArquivos(caminho, listaArquivos):
			for sArquivo as string in listaArquivos:
				SalvarExtensao(listaExtensao, Rotinas.ExtractFileName(sArquivo), sArquivo, log)
	

