/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 06/07/2015
 * Time: 16:17
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetosbo

import System
import System.IO
import System.Collections.Generic
import HFSGuardaDiretorio.comum
import HFSGuardaDiretorio.objetos
import HFSGuardaDiretorio.objetosdao

public final class DiretorioBO:

	private static instancia = DiretorioBO()

	
	public static final SQL_CONSULTA_ARQUIVO as string = (('select aba, cod, ' + 'ordem, coddirpai, nome, tam, tipo, modificado, atributos, ') + 'caminho, nomeaba, nomepai, caminhopai from consultaarquivo')

	
	public static Instancia as DiretorioBO:
		get:
			return instancia

	
	private def constructor():
		pass

	
	public def carregarDiretorio(sSQL as string, progressoLog as IProgressoLog) as List[of Diretorio]:
		return DiretorioDAO.Instancia.consultarTudo(sSQL, '', progressoLog)

	
	public def carregarDiretorio(sSQL as string, sCondicaoTotal as string, progressoLog as IProgressoLog) as List[of Diretorio]:
		return DiretorioDAO.Instancia.consultarTudo(sSQL, sCondicaoTotal, progressoLog)

	
	public def removerDrive(sDiretorio as string) as string:
		drives as (string) = Directory.GetLogicalDrives()
		i = 0
		bAchou = false
		sArq as string = Rotinas.testaNull(sDiretorio)
		
		if sArq.Length > 0:
			i = 0
			goto converterGeneratedName1
			while true:
				i += 1
				:converterGeneratedName1
				break  unless (i <= (drives.Length - 1))
				if sArq.ToUpper().Contains(drives[i].ToUpper()):
					bAchou = true
					break 
		sArq = Rotinas.trocaSeparador(sArq)
		if bAchou:
			return sArq.Substring(drives[i].Length)
		else:
			return sArq

	
	private def arquivoAtributos(arquivo as FileInfo, bDiretorio as bool) as string:
		sAtributos = ''
		
		if bDiretorio:
			sAtributos += '[DIR]'
		else:
			sAtributos += '[ARQ]'
		
		if arquivo is not null:
			
			if arquivo.Exists:
				//if (arquivo.Attributes==FileAttributes.Archive) {}		
				if arquivo.IsReadOnly:
					sAtributos += '[ROL]'
				if arquivo.Attributes == FileAttributes.Hidden:
					sAtributos += '[HID]'
				if arquivo.Attributes == FileAttributes.System:
					sAtributos += '[SYS]'
			else:
				//if (arquivo.Directory.Attributes==FileAttributes.Directory) {}
				if arquivo.Directory.Attributes == FileAttributes.Hidden:
					sAtributos += '[HID]'
				if arquivo.Directory.Attributes == FileAttributes.System:
					sAtributos += '[SYS]'
		return sAtributos

	
	private def retCodDirPai(nAba as int, sDiretorio as string, listaLocal as List[of Diretorio]) as int:
		for diretorio as Diretorio in listaLocal:
			if diretorio.Aba.Codigo == nAba:
				if diretorio.Caminho.Equals(sDiretorio):
					return diretorio.Ordem
		return 0

	
	public def MontaTamanho(nTam as decimal) as string:
		nUmKilo as decimal
		nUmMega as decimal
		nUmGiga as decimal
		nUmTera as decimal
		nUmPeta as decimal
		nTamLocal as decimal
		
		nUmKilo = 1024
		nUmMega = (nUmKilo * 1024)
		nUmGiga = (nUmMega * 1024)
		nUmTera = (nUmGiga * 1024)
		nUmPeta = (nUmTera * 1024)
		
		if nTam.CompareTo(nUmKilo) == (-1):
			nTamLocal = nTam
			return (Rotinas.FormatDecimal(nTamLocal) + ' Byte(s)')
		elif (nTam.CompareTo(nUmKilo) == 1) and (nTam.CompareTo(nUmMega) == (-1)):
			nTamLocal = (nTam / nUmKilo)
			return (Rotinas.FormatDecimal(nTamLocal) + ' KByte(s)')
		elif (nTam.CompareTo(nUmMega) == 1) and (nTam.CompareTo(nUmGiga) == (-1)):
			nTamLocal = (nTam / nUmMega)
			return (Rotinas.FormatDecimal(nTamLocal) + ' MByte(s)')
		elif (nTam.CompareTo(nUmGiga) == 1) and (nTam.CompareTo(nUmTera) == (-1)):
			nTamLocal = (nTam / nUmGiga)
			return (Rotinas.FormatDecimal(nTamLocal) + ' GByte(s)')
		elif (nTam.CompareTo(nUmTera) == 1) and (nTam.CompareTo(nUmPeta) == (-1)):
			nTamLocal = (nTam / nUmTera)
			return (Rotinas.FormatDecimal(nTamLocal) + ' TByte(s)')
		else:
			nTamLocal = (nTam / nUmPeta)
			return (Rotinas.FormatDecimal(nTamLocal) + ' PByte(s)')

	
	public def atribuiDiretorio(nAba as int, nCodDirRaiz as int, sNomeDirRaiz as string, sDiretorio as string, bDiretorio as bool, listaLocal as List[of Diretorio], arquivo as Arquivo, dirOrdem as DiretorioOrdem) as Diretorio:
		nOrdem as int = dirOrdem.Ordem
		diretorio as Diretorio
		sCaminho as string
		sDir as string
		fCaminho as FileInfo = null
		
		sCaminho = removerDrive(sDiretorio)
		if sDiretorio.Length > 0:
			fCaminho = FileInfo(sDiretorio)
		
		if (sCaminho.Length > 0) and (sNomeDirRaiz.Length > 0):
			if Rotinas.StartsStr(sNomeDirRaiz, sCaminho):
				sCaminho = Rotinas.SubString(sCaminho, (sNomeDirRaiz.Length + 2), sCaminho.Length)
				sDir = Rotinas.SubString(sDiretorio, (sNomeDirRaiz.Length + 2), sDiretorio.Length)
				fCaminho = FileInfo(sDir)
			else:
				sCaminho = ((sNomeDirRaiz + Rotinas.BARRA_INVERTIDA) + sCaminho)
				sDir = ((sNomeDirRaiz + Rotinas.BARRA_INVERTIDA) + sDiretorio)
				fCaminho = FileInfo(sDir)
		
		diretorio = Diretorio()
		abaLocal = Aba()
		tipoLocal = Tipo()
		
		abaLocal.Codigo = nAba
		diretorio.Codigo = nCodDirRaiz
		diretorio.Ordem = nOrdem
		diretorio.Nome = arquivo.Nome
		diretorio.Tamanho = arquivo.Tamanho
		diretorio.Modificado = arquivo.Modificado
		diretorio.Atributos = arquivoAtributos(fCaminho, bDiretorio)
		
		if sDiretorio.Length == 0:
			diretorio.Caminho = arquivo.Nome
			diretorio.CaminhoPai = ''
		else:
			diretorio.Caminho = sCaminho
			diretorio.CaminhoPai = Rotinas.SubString(diretorio.Caminho, 1, (Rotinas.LastDelimiter(Rotinas.BARRA_INVERTIDA, diretorio.Caminho) - 1))
		
		if bDiretorio:
			tipoLocal.Codigo = char('D')
			if nOrdem == 1:
				diretorio.CodDirPai = 0
			else:
				diretorio.CodDirPai = retCodDirPai(abaLocal.Codigo, diretorio.CaminhoPai, listaLocal)
		else:
			tipoLocal.Codigo = char('A')
			diretorio.CodDirPai = retCodDirPai(abaLocal.Codigo, diretorio.CaminhoPai, listaLocal)
		abaLocal.Nome = ''
		diretorio.Aba = abaLocal
		diretorio.NomePai = ''
		diretorio.TamanhoFormatado = MontaTamanho(diretorio.Tamanho)
		if tipoLocal.Codigo == char('D'):
			tipoLocal.Nome = 'Diretório'
		else:
			tipoLocal.Nome = 'Arquivo'
		diretorio.Tipo = tipoLocal
		diretorio.ModificadoFormatado = Rotinas.formataDate(Rotinas.FORMATO_DATAHORA, diretorio.Modificado)
		diretorio.CaminhoOriginal = sDiretorio
		
		nOrdem += 1
		
		dirOrdem.Ordem = nOrdem
		
		return diretorio

	
	private def dirPesquisadoToArquivo(dirPesquisado as FileInfo) as Arquivo:
		arquivo = Arquivo()
		arquivo.Nome = dirPesquisado.Name
		if dirPesquisado.Exists:
			arquivo.Tamanho = dirPesquisado.Length
		else:
			arquivo.Tamanho = 0
		arquivo.Modificado = dirPesquisado.LastWriteTime
		arquivo.Atributos = arquivoAtributos(dirPesquisado, not dirPesquisado.Exists)
		return arquivo

	
	public def atribuiListaDiretorio(nAba as int, nCodDirRaiz as int, sNomeDirRaiz as string, sDiretorio as string, listaLocal as List[of Diretorio], dirPesquisado as FileInfo, dirOrdem as DiretorioOrdem, progressoLog as IProgressoLog):
		diretorio as Diretorio
		pb = Progresso()
		
		if Rotinas.FileExists(sDiretorio):
			diretorio = atribuiDiretorio(nAba, nCodDirRaiz, sNomeDirRaiz, sDiretorio, false, listaLocal, dirPesquisadoToArquivo(dirPesquisado), dirOrdem)
			listaLocal.Add(diretorio)
			
			if progressoLog is not null:
				pb.Log = sDiretorio
				progressoLog.ProgressoLog(pb)
		elif Rotinas.DirectoryExists(sDiretorio):
			if (not dirPesquisado.Name.Equals('.')) and (not dirPesquisado.Name.Equals('..')):
				diretorio = atribuiDiretorio(nAba, nCodDirRaiz, sNomeDirRaiz, sDiretorio, true, listaLocal, dirPesquisadoToArquivo(dirPesquisado), dirOrdem)
				listaLocal.Add(diretorio)
				
				if progressoLog is not null:
					pb.Log = sDiretorio
					progressoLog.ProgressoLog(pb)
				
				ImportarDiretorio(nAba, nCodDirRaiz, sNomeDirRaiz, sDiretorio, listaLocal, dirOrdem, progressoLog)
		

	
	public def ImportarDiretorio(nAba as int, nCodDirRaiz as int, sNomeDirRaiz as string, sDiretorio as string, listaLocal as List[of Diretorio], dirOrdem as DiretorioOrdem, progressoLog as IProgressoLog):
		dirPesquisado as FileInfo
		sCaminho as string
		sSeparador as string
		
		if Rotinas.SubString(sDiretorio, sDiretorio.Length, 1).Equals(Path.DirectorySeparatorChar):
			sSeparador = ''
		else:
			sSeparador = Path.DirectorySeparatorChar.ToString()
		
		sCaminho = (sDiretorio + sSeparador)
		
		dirPesquisado = FileInfo(sCaminho)
		if dirPesquisado.Directory.Exists:
			for dirPesquisado2 as FileInfo in Rotinas.listFiles(dirPesquisado.FullName):
				sCaminho = ((sDiretorio + sSeparador) + dirPesquisado2.Name)
				atribuiListaDiretorio(nAba, nCodDirRaiz, sNomeDirRaiz, sCaminho, listaLocal, dirPesquisado2, dirOrdem, progressoLog)

	
	public def verificaCodDir(nAba as int, sDiretorio as string, listaLocal as List[of Diretorio]) as bool:
		
		if sDiretorio.Length > 0:
			for diretorio as Diretorio in listaLocal:
				if diretorio.Aba.Codigo == nAba:
					if diretorio.Ordem == 1:
						if diretorio.CodDirPai == 0:
							if diretorio.Caminho.Equals(sDiretorio):
								return true
		return false

	
	public def retMaxCodDir(nAba as int, listaLocal as List[of Diretorio]) as int:
		nMaior as int = (-1)
		
		for diretorio as Diretorio in listaLocal:
			if diretorio.Aba.Codigo == nAba:
				if diretorio.Codigo > nMaior:
					nMaior = diretorio.Codigo
		return (nMaior + 1)

	
	private def diretorioToSQL(diretorio as Diretorio, bInsert as bool) as string:
		sSQL = ''
		
		if bInsert:
			sSQL = ('insert into Diretorios(aba, cod, ordem, coddirpai, nome, ' + 'tam, tipo, modificado, atributos, caminho) values(')
		
		sSQL += (diretorio.Aba.Codigo + ',')
		sSQL += (diretorio.Codigo + ',')
		sSQL += (diretorio.Ordem + ',')
		sSQL += (diretorio.CodDirPai + ',')
		sSQL += (Rotinas.QuotedStr(diretorio.Nome) + ',')
		sSQL += (diretorio.Tamanho + ',')
		sSQL += (Rotinas.QuotedStr(diretorio.Tipo.Codigo) + ',')
		sSQL += (Rotinas.QuotedStr(diretorio.ModificadoFormatado) + ',')
		sSQL += (Rotinas.QuotedStr(diretorio.Atributos) + ',')
		sSQL += Rotinas.QuotedStr(diretorio.Caminho)
		
		if bInsert:
			sSQL += ')'
		
		return sSQL

	
	public def salvarDiretorio(listaDiretorio as List[of Diretorio], progressoLog as IProgressoLog):
		diretorio as Diretorio
		pb = Progresso()
		pb.Minimo = 0
		pb.Maximo = (listaDiretorio.Count - 1)
		pb.Posicao = 0
		pb.Passo = 1
		
		try:
			for i in range(0, listaDiretorio.Count):
				diretorio = listaDiretorio[i]
				
				DiretorioDAO.Instancia.incluir(diretorio)
				pb.Log = (((i + 1) + ' - Salvando Diretório: ') + diretorio.Caminho)
				
				pb.Posicao = i
				
				if progressoLog is not null:
					progressoLog.ProgressoLog(pb)
		except converterGeneratedName2 as Exception:
			raise 
		

	
	public def excluirDiretorio(aba as Aba, sCaminho as string) as bool:
		return (DiretorioDAO.Instancia.excluir(aba, sCaminho) > 0)

	
	public def excluirListaDiretorio(listaDiretorio as List[of Diretorio], aba as Aba, sCaminho as string):
		diretorio as Diretorio
		for i in range((listaDiretorio.Count - 1), -1, -1):
		
			diretorio = listaDiretorio[i]
			
			if diretorio.Aba.Codigo == aba.Codigo:
				if sCaminho.Trim().Length > 0:
					if Rotinas.StartsStr(sCaminho, diretorio.Caminho):
						listaDiretorio.Remove(diretorio)
				else:
					listaDiretorio.Remove(diretorio)
		

	
	private def diretorioToCSV(diretorio as Diretorio) as string:
		sCSV as string
		
		sCSV = '"'
		
		sCSV += (diretorio.Aba.Nome + '";"')
		sCSV += (diretorio.Nome + '";"')
		sCSV += (diretorio.Tamanho + '";"')
		sCSV += (diretorio.TamanhoFormatado + '";"')
		sCSV += (diretorio.Tipo.Nome + '";"')
		sCSV += (diretorio.ModificadoFormatado + '";"')
		sCSV += (diretorio.Atributos + '";"')
		sCSV += (diretorio.Caminho + '"')
		
		return sCSV

	
	private def diretorioToXML(diretorio as Diretorio) as string:
		sXML as string
		sCR as string
		sTAB as string
		sTAB2 as string
		
		sTAB = '\t'
		sTAB2 = '\t\t'
		sCR = '\n'
		
		sXML = ((sTAB + '<arquivo>') + sCR)
		
		sXML += ((((sTAB2 + '<aba>') + diretorio.Aba.Codigo) + '</aba>') + sCR)
		sXML += ((((sTAB2 + '<nomeAba>') + diretorio.Aba.Nome) + '</nomeAba>') + sCR)
		sXML += ((((sTAB2 + '<codigo>') + diretorio.Codigo) + '</codigo>') + sCR)
		sXML += ((((sTAB2 + '<ordem>') + diretorio.Ordem) + '</ordem>') + sCR)
		sXML += ((((sTAB2 + '<nome>') + diretorio.Nome) + '</nome>') + sCR)
		sXML += ((((sTAB2 + '<tamanho>') + diretorio.Tamanho) + '</tamanho>') + sCR)
		sXML += ((((sTAB2 + '<tipo>') + diretorio.Tipo.Codigo) + '</tipo>') + sCR)
		sXML += ((((sTAB2 + '<modificado>') + diretorio.ModificadoFormatado) + '</modificado>') + sCR)
		sXML += ((((sTAB2 + '<atributos>') + diretorio.Atributos) + '</atributos>') + sCR)
		sXML += ((((sTAB2 + '<codDirPai>') + diretorio.CodDirPai) + '</codDirPai>') + sCR)
		sXML += ((((sTAB2 + '<caminho>') + diretorio.Caminho) + '</caminho>') + sCR)
		
		sXML += (sTAB + '</arquivo>')
		
		return sXML

	
	private def diretorioToTXT(diretorio as Diretorio) as string:
		sTXT as string
		sTAB as string
		
		sTAB = '\t'
		sTXT = ''
		sTXT += (diretorio.Aba.Nome + sTAB)
		sTXT += (diretorio.Nome + sTAB)
		sTXT += (diretorio.Tamanho + sTAB)
		sTXT += (diretorio.TamanhoFormatado + sTAB)
		sTXT += (diretorio.Tipo.Nome + sTAB)
		sTXT += (diretorio.ModificadoFormatado + sTAB)
		sTXT += (diretorio.Atributos + sTAB)
		sTXT += diretorio.Caminho
		
		return sTXT

	
	private def diretorioToHTML(diretorio as Diretorio) as string:
		sHTML as string
		sCR as string
		sTAB as string
		sTAB2 as string
		
		sTAB = '\t'
		sTAB2 = '\t\t'
		sCR = '\n'
		
		sHTML = ((sTAB + '<tr>') + sCR)
		
		sHTML += ((((sTAB2 + '<td>') + diretorio.Aba.Nome) + '</td>') + sCR)
		sHTML += ((((sTAB2 + '<td>') + diretorio.Nome) + '</td>') + sCR)
		sHTML += ((((sTAB2 + '<td>') + diretorio.Tamanho) + '</td>') + sCR)
		sHTML += ((((sTAB2 + '<td>') + Rotinas.StringReplaceAll(diretorio.TamanhoFormatado, ' ', '&nbsp;')) + '</td>') + sCR)
		sHTML += ((((sTAB2 + '<td>') + diretorio.Tipo.Nome) + '</td>') + sCR)
		sHTML += ((((sTAB2 + '<td>') + Rotinas.StringReplaceAll(diretorio.ModificadoFormatado, ' ', '&nbsp;')) + '</td>') + sCR)
		sHTML += ((((sTAB2 + '<td>') + diretorio.Atributos) + '</td>') + sCR)
		sHTML += ((((sTAB2 + '<td>') + diretorio.Caminho) + '</td>') + sCR)
		
		sHTML += (sTAB + '</tr>')
		return sHTML

	
	public def exportarDiretorio(tipo as TipoExportar, aba as Aba, sNomeArquivo as string, progressoLog as IProgressoLog):
		sTexto = ''
		sCR as string
		sTAB as string
		sTAB2 as string
		sSQL as string
		sCondicaoTotal as string
		abaLocal = Aba()
		listaLocal as StringList
		listaDiretorio as List[of Diretorio]
		
		sTAB = '\t'
		sTAB2 = '\t\t'
		sCR = '\n'
		
		sCondicaoTotal = (' where aba=' + aba.Codigo)
		sSQL = ((SQL_CONSULTA_ARQUIVO + sCondicaoTotal) + ' order by 1, 2, 3')
		listaDiretorio = carregarDiretorio(sSQL, sCondicaoTotal, progressoLog)
		
		listaLocal = StringList()
		converterGeneratedName3 = tipo
		
		if converterGeneratedName3 == TipoExportar.teCSV:
			sTexto = ('"Aba";"Nome";"TamanhoBytes";"Tamanho";' + '"Tipo";"Modificado";"Atributos";"Caminho"')
		elif converterGeneratedName3 == TipoExportar.teHTML:
			sTexto = ('<!DOCTYPE html>' + sCR)
			sTexto += ('<html>' + sCR)
			sTexto += ('<body>' + sCR)
			sTexto += ('<table border="1" cellpadding="5" cellspacing="0">' + sCR)
			sTexto += ((sTAB + '<tr>') + sCR)
			sTexto += ((sTAB2 + '<th>Aba</th>') + sCR)
			sTexto += ((sTAB2 + '<th>Nome</th>') + sCR)
			sTexto += ((sTAB2 + '<th>Tamanho</th>') + sCR)
			sTexto += ((sTAB2 + '<th>Tamanho Formatado</th>') + sCR)
			sTexto += ((sTAB2 + '<th>Tipo</th>') + sCR)
			sTexto += ((sTAB2 + '<th>Modificado</th>') + sCR)
			sTexto += ((sTAB2 + '<th>Atributos</th>') + sCR)
			sTexto += ((sTAB2 + '<th>Caminho</th>') + sCR)
			sTexto += (sTAB + '</tr>')
		elif converterGeneratedName3 == TipoExportar.teXML:
			sTexto = '<diretorio>'
		elif converterGeneratedName3 == TipoExportar.teSQL:
			abaLocal.Codigo = listaDiretorio[0].Aba.Codigo
			abaLocal.Nome = listaDiretorio[0].Aba.Nome
			sTexto = AbaBO.Instancia.abaToSQL(abaLocal)
		
		if sTexto.Length > 0:
			listaLocal.Add(sTexto)
		
		for diretorio as Diretorio in listaDiretorio:
			if diretorio.Aba.Codigo == aba.Codigo:
				if tipo == TipoExportar.teTXT:
					sTexto = diretorioToTXT(diretorio)
				elif tipo == TipoExportar.teCSV:
					sTexto = diretorioToCSV(diretorio)
				elif tipo == TipoExportar.teHTML:
					sTexto = diretorioToHTML(diretorio)
				elif tipo == TipoExportar.teXML:
					sTexto = diretorioToXML(diretorio)
				elif tipo == TipoExportar.teSQL:
					sTexto = (diretorioToSQL(diretorio, true) + ';')
				
				listaLocal.Add(sTexto)
		
		if tipo == TipoExportar.teHTML:
			sTexto += ((sCR + '</table>') + sCR)
			sTexto += ('</body>' + sCR)
			sTexto += ('</html>' + sCR)
		elif tipo == TipoExportar.teXML:
			sTexto = '</diretorio>'
		listaLocal.Add(sTexto)
		
		listaLocal.SaveToFile(sNomeArquivo)
		
		listaDiretorio.Clear()
		listaLocal.Clear()

	
	public def criarTabelaDiretorios() as bool:
		return (DiretorioDAO.Instancia.criarTabela() > 0)

	
	private def XMLParaDiretorio(sTexto as string, nArquivo as int, diretorioXML as DiretorioXML) as int:
		sTagInicio = ''
		sValor = ''
		sTagFim = ''
		resultado as int
		
		resultado = nArquivo
		
		if Rotinas.Pos('>', sTexto) > 0:
			sTagInicio = Rotinas.SubString(sTexto, 1, Rotinas.Pos('>', sTexto))
		if (Rotinas.Pos('>', sTexto) > 0) and (Rotinas.Pos('</', sTexto) > 1):
			sValor = Rotinas.SubString(sTexto, (Rotinas.Pos('>', sTexto) + 1), ((Rotinas.Pos('</', sTexto) - Rotinas.Pos('>', sTexto)) - 1))
		if Rotinas.LastDelimiter('>', sTexto) > 0:
			sTagFim = Rotinas.SubString(sTexto, Rotinas.LastDelimiter('<', sTexto), Rotinas.LastDelimiter('>', sTexto))
		
		if (nArquivo == 1) and (not sTagInicio.Equals('<arquivo>')):
			resultado = (-1)
		if ((nArquivo == 2) and (not sTagInicio.Equals('<aba>'))) and (not sTagFim.Equals('</aba>')):
			// diretorio.aba.codigo = StrToInt(sValor);
			resultado = (-1)
		if ((nArquivo == 3) and (not sTagInicio.Equals('<nomeAba>'))) and (not sTagFim.Equals('</nomeAba>')):
			// diretorio.aba.nome = sValor;
			resultado = (-1)
		if ((nArquivo == 4) and sTagInicio.Equals('<codigo>')) and sTagFim.Equals('</codigo>'):
			diretorioXML.Diretorio.Codigo = Convert.ToInt32(sValor)
		if ((nArquivo == 5) and sTagInicio.Equals('<ordem>')) and sTagFim.Equals('</ordem>'):
			diretorioXML.Diretorio.Ordem = Convert.ToInt32(sValor)
		if ((nArquivo == 6) and sTagInicio.Equals('<nome>')) and sTagFim.Equals('</nome>'):
			diretorioXML.Diretorio.Nome = sValor
		if ((nArquivo == 7) and sTagInicio.Equals('<tamanho>')) and sTagFim.Equals('</tamanho>'):
			diretorioXML.Diretorio.Tamanho = Convert.ToInt64(sValor)
		if ((nArquivo == 8) and sTagInicio.Equals('<tipo>')) and sTagFim.Equals('</tipo>'):
			tp = Tipo()
			tp.Codigo = sValor[0]
			diretorioXML.Diretorio.Tipo = tp
		if ((nArquivo == 9) and sTagInicio.Equals('<modificado>')) and sTagFim.Equals('</modificado>'):
			diretorioXML.Diretorio.Modificado = Rotinas.StringToDate(sValor)
		if ((nArquivo == 10) and sTagInicio.Equals('<atributos>')) and sTagFim.Equals('</atributos>'):
			diretorioXML.Diretorio.Atributos = sValor
		if ((nArquivo == 11) and sTagInicio.Equals('<codDirPai>')) and sTagFim.Equals('</codDirPai>'):
			diretorioXML.Diretorio.CodDirPai = Convert.ToInt32(sValor)
		if ((nArquivo == 12) and sTagInicio.Equals('<caminho>')) and sTagFim.Equals('</caminho>'):
			diretorioXML.Diretorio.Caminho = sValor
		if (nArquivo == 13) and (not sTagInicio.Equals('</arquivo>')):
			resultado = (-1)
		if sTagInicio.Equals('</diretorio>'):
			resultado = (-3)
		
		return resultado

	
	public def importarDiretorioViaXML(aba as Aba, sNomeArquivo as string, listaDirPai as List[of Diretorio], progressoLog as IProgressoLog) as int:
		sTexto as string
		nArquivo as int
		resultado as int
		listaLocal as StringList
		diretorioXML as DiretorioXML
		listaDiretorio as List[of Diretorio]
		
		resultado = 0
		diretorioXML = DiretorioXML()
		listaDiretorio = List[of Diretorio]()
		listaLocal = StringList()
		listaLocal.LoadFromFile(sNomeArquivo)
		
		if not listaLocal[0].Equals('<diretorio>'):
			resultado = (-1)
		else:
			nArquivo = 0
			for sTexto1 as string in listaLocal:
				sTexto = sTexto1.Trim()
				
				nArquivo = XMLParaDiretorio(sTexto, nArquivo, diretorioXML)
				
				if nArquivo == (-1):
					resultado = (-1)
					break 
				elif nArquivo == 13:
					nArquivo = 1
					diretorioXML.Diretorio.Aba = aba
					listaDiretorio.Add(diretorioXML.Diretorio)
					
					if verificaCodDir(aba.Codigo, diretorioXML.Diretorio.Caminho, listaDirPai):
						resultado = (-2)
						break 
					
					diretorioXML.Diretorio = Diretorio()
				elif nArquivo == (-3):
					resultado = nArquivo
				else:
					nArquivo += 1
		
		salvarDiretorio(listaDiretorio, progressoLog)
		listaDiretorio.Clear()
		
		return resultado

	
	public def carregarSubDiretorios(sDiretorio as string, listaLocal as StringList) as bool:
		dirPesquisado as FileInfo
		sCaminho as string
		sSeparador as string
		
		if Rotinas.SubString(sDiretorio, sDiretorio.Length, 1).Equals(Path.DirectorySeparatorChar):
			sSeparador = ''
		else:
			sSeparador = Path.DirectorySeparatorChar.ToString()
		
		sCaminho = (sDiretorio + sSeparador)
		dirPesquisado = FileInfo(sCaminho)
		if dirPesquisado.Directory.Exists:
			for dirPesquisado2 as FileInfo in Rotinas.listFiles(dirPesquisado.FullName):
				sCaminho = ((sDiretorio + sSeparador) + dirPesquisado2.Name)
				
				if dirPesquisado2.Directory.Exists:
					if Rotinas.DirectoryExists(sCaminho):
						if (not dirPesquisado2.Name.Equals('.')) and (not dirPesquisado2.Name.Equals('..')):
							listaLocal.Add(sCaminho)
		
		return (listaLocal.Count > 0)

	
	public def carregarArquivos(sDiretorio as string, listaLocal as StringList) as bool:
		dirPesquisado as FileInfo
		sCaminho as string
		sSeparador as string
		
		if Rotinas.SubString(sDiretorio, sDiretorio.Length, 1).Equals(Path.DirectorySeparatorChar):
			sSeparador = ''
		else:
			sSeparador = Path.DirectorySeparatorChar.ToString()
		
		sCaminho = (sDiretorio + sSeparador)
		dirPesquisado = FileInfo(sCaminho)
		if dirPesquisado.Directory.Exists:
			for dirPesquisado2 as FileInfo in Rotinas.listFiles(dirPesquisado.FullName):
				sCaminho = ((sDiretorio + sSeparador) + dirPesquisado2.Name)
				
				if dirPesquisado2.Exists:
					if Rotinas.FileExists(sCaminho):
						if (not dirPesquisado.Name.Equals('.')) and (not dirPesquisado.Name.Equals('..')):
							listaLocal.Add(sCaminho)
		
		return (listaLocal.Count > 0)

	
	public def carregarTodosArquivos(sDiretorio as string, listaLocal as StringList) as bool:
		dirPesquisado as FileInfo
		sCaminho as string
		sSeparador as string
		
		if Rotinas.SubString(sDiretorio, sDiretorio.Length, 1).Equals(Path.DirectorySeparatorChar):
			sSeparador = ''
		else:
			sSeparador = Path.DirectorySeparatorChar.ToString()
		
		sCaminho = (sDiretorio + sSeparador)
		dirPesquisado = FileInfo(sCaminho)
		if dirPesquisado.Directory.Exists:
			sCaminho = ((sDiretorio + sSeparador) + dirPesquisado.Name)
			
			if Rotinas.FileExists(sCaminho):
				listaLocal.Add(sCaminho)
			elif Rotinas.DirectoryExists(sCaminho):
				if (not dirPesquisado.Name.Equals('.')) and (not dirPesquisado.Name.Equals('..')):
					carregarTodosArquivos(sCaminho, listaLocal)
			
			for dirPesquisado2 as FileInfo in Rotinas.listFiles(dirPesquisado.FullName):
				sCaminho = ((sDiretorio + sSeparador) + dirPesquisado2.Name)
				
				if Rotinas.FileExists(sCaminho):
					listaLocal.Add(sCaminho)
				elif Rotinas.DirectoryExists(sCaminho):
					if (not dirPesquisado2.Name.Equals('.')) and (not dirPesquisado2.Name.Equals('..')):
						carregarTodosArquivos(sCaminho, listaLocal)
		return (listaLocal.Count > 0)

	
	public def itensFilhos(lista_pai as List[of Diretorio], aba as int, codDirPai as int, codigo as int) as List[of Diretorio]:
		lista as List[of Diretorio] = List[of Diretorio]()
		
		for diretorio as Diretorio in lista_pai:
			if diretorio.Aba.Codigo == aba:
				if diretorio.CodDirPai == codDirPai:
					if diretorio.Codigo == codigo:
						lista.Add(diretorio)
		return lista
	

