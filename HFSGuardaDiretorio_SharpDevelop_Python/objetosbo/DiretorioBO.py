# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 06/07/2015
# * Time: 16:17
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from System.IO import *
from System.Collections.Generic import *
from HFSGuardaDiretorio.comum import *
from HFSGuardaDiretorio.objetos import *
from HFSGuardaDiretorio.objetosdao import *

class DiretorioBO(object):
	""" <summary>
	 Description of DiretorioBO.
	 </summary>
	"""
	def get_Instancia(self):
		return self._instancia

	Instancia = property(fget=get_Instancia)

	def __init__(self):
		self._instancia = DiretorioBO()
		self._SQL_CONSULTA_ARQUIVO = "select aba, cod, " + "ordem, coddirpai, nome, tam, tipo, modificado, atributos, " + "caminho, nomeaba, nomepai, caminhopai from consultaarquivo"

	def carregarDiretorio(self, sSQL, progressoLog):
		return DiretorioDAO.Instancia.consultarTudo(sSQL, "", progressoLog)

	def carregarDiretorio(self, sSQL, sCondicaoTotal, progressoLog):
		return DiretorioDAO.Instancia.consultarTudo(sSQL, sCondicaoTotal, progressoLog)

	def removerDrive(self, sDiretorio):
		drives = Directory.GetLogicalDrives()
		i = 0
		bAchou = False
		sArq = Rotinas.testaNull(sDiretorio)
		if sArq.Length > 0:
			i = 0
			while i < drives.Length:
				if sArq.ToUpper().Contains(drives[i].ToUpper()):
					bAchou = True
					break
				i += 1
		sArq = Rotinas.trocaSeparador(sArq)
		if bAchou:
			return sArq.Substring(drives[i].Length)
		else:
			return sArq

	def arquivoAtributos(self, arquivo, bDiretorio):
		sAtributos = ""
		if bDiretorio:
			sAtributos += "[DIR]"
		else:
			sAtributos += "[ARQ]"
		if arquivo != None:
			if arquivo.Exists:
				#if (arquivo.Attributes==FileAttributes.Archive) {}		
				if arquivo.IsReadOnly:
					sAtributos += "[ROL]"
				if arquivo.Attributes == FileAttributes.Hidden:
					sAtributos += "[HID]"
				if arquivo.Attributes == FileAttributes.System:
					sAtributos += "[SYS]"
			else:
				#if (arquivo.Directory.Attributes==FileAttributes.Directory) {}
				if arquivo.Directory.Attributes == FileAttributes.Hidden:
					sAtributos += "[HID]"
				if arquivo.Directory.Attributes == FileAttributes.System:
					sAtributos += "[SYS]"
		return sAtributos

	def retCodDirPai(self, nAba, sDiretorio, listaLocal):
		enumerator = listaLocal.GetEnumerator()
		while enumerator.MoveNext():
			diretorio = enumerator.Current
			if diretorio.Aba.Codigo == nAba:
				if diretorio.Caminho.Equals(sDiretorio):
					return diretorio.Ordem
		return 0

	def MontaTamanho(self, nTam):
		nUmKilo = 1024
		nUmMega = nUmKilo * 1024
		nUmGiga = nUmMega * 1024
		nUmTera = nUmGiga * 1024
		nUmPeta = nUmTera * 1024
		if nTam.CompareTo(nUmKilo) == -1:
			nTamLocal = nTam
			return Rotinas.FormatDecimal(nTamLocal) + " Byte(s)"
		elif nTam.CompareTo(nUmKilo) == 1 and nTam.CompareTo(nUmMega) == -1:
			nTamLocal = nTam / nUmKilo
			return Rotinas.FormatDecimal(nTamLocal) + " KByte(s)"
		elif nTam.CompareTo(nUmMega) == 1 and nTam.CompareTo(nUmGiga) == -1:
			nTamLocal = nTam / nUmMega
			return Rotinas.FormatDecimal(nTamLocal) + " MByte(s)"
		elif nTam.CompareTo(nUmGiga) == 1 and nTam.CompareTo(nUmTera) == -1:
			nTamLocal = nTam / nUmGiga
			return Rotinas.FormatDecimal(nTamLocal) + " GByte(s)"
		elif nTam.CompareTo(nUmTera) == 1 and nTam.CompareTo(nUmPeta) == -1:
			nTamLocal = nTam / nUmTera
			return Rotinas.FormatDecimal(nTamLocal) + " TByte(s)"
		else:
			nTamLocal = nTam / nUmPeta
			return Rotinas.FormatDecimal(nTamLocal) + " PByte(s)"

	def atribuiDiretorio(self, nAba, nCodDirRaiz, sNomeDirRaiz, sDiretorio, bDiretorio, listaLocal, arquivo, dirOrdem):
		nOrdem = dirOrdem.Ordem
		fCaminho = None
		sCaminho = self.removerDrive(sDiretorio)
		if sDiretorio.Length > 0:
			fCaminho = FileInfo(sDiretorio)
		if (sCaminho.Length > 0) and (sNomeDirRaiz.Length > 0):
			if Rotinas.StartsStr(sNomeDirRaiz, sCaminho):
				sCaminho = Rotinas.SubString(sCaminho, sNomeDirRaiz.Length + 2, sCaminho.Length)
				sDir = Rotinas.SubString(sDiretorio, sNomeDirRaiz.Length + 2, sDiretorio.Length)
				fCaminho = FileInfo(sDir)
			else:
				sCaminho = sNomeDirRaiz + Rotinas.BARRA_INVERTIDA + sCaminho
				sDir = sNomeDirRaiz + Rotinas.BARRA_INVERTIDA + sDiretorio
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
		diretorio.Atributos = self.arquivoAtributos(fCaminho, bDiretorio)
		if sDiretorio.Length == 0:
			diretorio.Caminho = arquivo.Nome
			diretorio.CaminhoPai = ""
		else:
			diretorio.Caminho = sCaminho
			diretorio.CaminhoPai = Rotinas.SubString(diretorio.Caminho, 1, Rotinas.LastDelimiter(Rotinas.BARRA_INVERTIDA, diretorio.Caminho) - 1)
		if bDiretorio:
			tipoLocal.Codigo = 'D'
			if nOrdem == 1:
				diretorio.CodDirPai = 0
			else:
				diretorio.CodDirPai = self.retCodDirPai(abaLocal.Codigo, diretorio.CaminhoPai, listaLocal)
		else:
			tipoLocal.Codigo = 'A'
			diretorio.CodDirPai = self.retCodDirPai(abaLocal.Codigo, diretorio.CaminhoPai, listaLocal)
		abaLocal.Nome = ""
		diretorio.Aba = abaLocal
		diretorio.NomePai = ""
		diretorio.TamanhoFormatado = self.MontaTamanho(diretorio.Tamanho)
		if tipoLocal.Codigo == 'D':
			tipoLocal.Nome = "Diretório"
		else:
			tipoLocal.Nome = "Arquivo"
		diretorio.Tipo = tipoLocal
		diretorio.ModificadoFormatado = Rotinas.formataDate(Rotinas.FORMATO_DATAHORA, diretorio.Modificado)
		diretorio.CaminhoOriginal = sDiretorio
		nOrdem += 1
		dirOrdem.Ordem = nOrdem
		return diretorio

	def dirPesquisadoToArquivo(self, dirPesquisado):
		arquivo = Arquivo()
		arquivo.Nome = dirPesquisado.Name
		if dirPesquisado.Exists:
			arquivo.Tamanho = dirPesquisado.Length
		else:
			arquivo.Tamanho = 0
		arquivo.Modificado = dirPesquisado.LastWriteTime
		arquivo.Atributos = self.arquivoAtributos(dirPesquisado, not dirPesquisado.Exists)
		return arquivo

	def atribuiListaDiretorio(self, nAba, nCodDirRaiz, sNomeDirRaiz, sDiretorio, listaLocal, dirPesquisado, dirOrdem, progressoLog):
		pb = Progresso()
		if Rotinas.FileExists(sDiretorio):
			diretorio = self.atribuiDiretorio(nAba, nCodDirRaiz, sNomeDirRaiz, sDiretorio, False, listaLocal, self.dirPesquisadoToArquivo(dirPesquisado), dirOrdem)
			listaLocal.Add(diretorio)
			if progressoLog != None:
				pb.Log = sDiretorio
				progressoLog.ProgressoLog(pb)
		elif Rotinas.DirectoryExists(sDiretorio):
			if (not dirPesquisado.Name.Equals(".")) and (not dirPesquisado.Name.Equals("..")):
				diretorio = self.atribuiDiretorio(nAba, nCodDirRaiz, sNomeDirRaiz, sDiretorio, True, listaLocal, self.dirPesquisadoToArquivo(dirPesquisado), dirOrdem)
				listaLocal.Add(diretorio)
				if progressoLog != None:
					pb.Log = sDiretorio
					progressoLog.ProgressoLog(pb)
				self.ImportarDiretorio(nAba, nCodDirRaiz, sNomeDirRaiz, sDiretorio, listaLocal, dirOrdem, progressoLog)

	def ImportarDiretorio(self, nAba, nCodDirRaiz, sNomeDirRaiz, sDiretorio, listaLocal, dirOrdem, progressoLog):
		if Rotinas.SubString(sDiretorio, sDiretorio.Length, 1).Equals(Path.DirectorySeparatorChar):
			sSeparador = ""
		else:
			sSeparador = Path.DirectorySeparatorChar.ToString()
		sCaminho = sDiretorio + sSeparador
		dirPesquisado = FileInfo(sCaminho)
		if dirPesquisado.Directory.Exists:
			enumerator = Rotinas.listFiles(dirPesquisado.FullName).GetEnumerator()
			while enumerator.MoveNext():
				dirPesquisado2 = enumerator.Current
				sCaminho = sDiretorio + sSeparador + dirPesquisado2.Name
				self.atribuiListaDiretorio(nAba, nCodDirRaiz, sNomeDirRaiz, sCaminho, listaLocal, dirPesquisado2, dirOrdem, progressoLog)

	def verificaCodDir(self, nAba, sDiretorio, listaLocal):
		if sDiretorio.Length > 0:
			enumerator = listaLocal.GetEnumerator()
			while enumerator.MoveNext():
				diretorio = enumerator.Current
				if diretorio.Aba.Codigo == nAba:
					if diretorio.Ordem == 1:
						if diretorio.CodDirPai == 0:
							if diretorio.Caminho.Equals(sDiretorio):
								return True
		return False

	def retMaxCodDir(self, nAba, listaLocal):
		nMaior = -1
		enumerator = listaLocal.GetEnumerator()
		while enumerator.MoveNext():
			diretorio = enumerator.Current
			if diretorio.Aba.Codigo == nAba:
				if diretorio.Codigo > nMaior:
					nMaior = diretorio.Codigo
		return nMaior + 1

	def diretorioToSQL(self, diretorio, bInsert):
		sSQL = ""
		if bInsert:
			sSQL = "insert into Diretorios(aba, cod, ordem, coddirpai, nome, " + "tam, tipo, modificado, atributos, caminho) values("
		sSQL += diretorio.Aba.Codigo + ","
		sSQL += diretorio.Codigo + ","
		sSQL += diretorio.Ordem + ","
		sSQL += diretorio.CodDirPai + ","
		sSQL += Rotinas.QuotedStr(diretorio.Nome) + ","
		sSQL += diretorio.Tamanho + ","
		sSQL += Rotinas.QuotedStr(diretorio.Tipo.Codigo) + ","
		sSQL += Rotinas.QuotedStr(diretorio.ModificadoFormatado) + ","
		sSQL += Rotinas.QuotedStr(diretorio.Atributos) + ","
		sSQL += Rotinas.QuotedStr(diretorio.Caminho)
		if bInsert:
			sSQL += ")"
		return sSQL

	def salvarDiretorio(self, listaDiretorio, progressoLog):
		pb = Progresso()
		pb.Minimo = 0
		pb.Maximo = listaDiretorio.Count - 1
		pb.Posicao = 0
		pb.Passo = 1
		try:
			i = 0
			while i < listaDiretorio.Count:
				diretorio = listaDiretorio[i]
				DiretorioDAO.Instancia.incluir(diretorio)
				pb.Log = (i + 1) + " - Salvando Diretório: " + diretorio.Caminho
				pb.Posicao = i
				if progressoLog != None:
					progressoLog.ProgressoLog(pb)
				i += 1
		except Exception:
			raise 

	def excluirDiretorio(self, aba, sCaminho):
		return (DiretorioDAO.Instancia.excluir(aba, sCaminho) > 0)

	def excluirListaDiretorio(self, listaDiretorio, aba, sCaminho):
		i = listaDiretorio.Count - 1
		while i >= 0:
			diretorio = listaDiretorio[i]
			if diretorio.Aba.Codigo == aba.Codigo:
				if sCaminho.Trim().Length > 0:
					if Rotinas.StartsStr(sCaminho, diretorio.Caminho):
						listaDiretorio.Remove(diretorio)
				else:
					listaDiretorio.Remove(diretorio)
			i -= 1

	def diretorioToCSV(self, diretorio):
		sCSV = "\""
		sCSV += diretorio.Aba.Nome + "\";\""
		sCSV += diretorio.Nome + "\";\""
		sCSV += diretorio.Tamanho + "\";\""
		sCSV += diretorio.TamanhoFormatado + "\";\""
		sCSV += diretorio.Tipo.Nome + "\";\""
		sCSV += diretorio.ModificadoFormatado + "\";\""
		sCSV += diretorio.Atributos + "\";\""
		sCSV += diretorio.Caminho + "\""
		return sCSV

	def diretorioToXML(self, diretorio):
		sTAB = "\t"
		sTAB2 = "\t\t"
		sCR = "\n"
		sXML = sTAB + "<arquivo>" + sCR
		sXML += sTAB2 + "<aba>" + diretorio.Aba.Codigo + "</aba>" + sCR
		sXML += sTAB2 + "<nomeAba>" + diretorio.Aba.Nome + "</nomeAba>" + sCR
		sXML += sTAB2 + "<codigo>" + diretorio.Codigo + "</codigo>" + sCR
		sXML += sTAB2 + "<ordem>" + diretorio.Ordem + "</ordem>" + sCR
		sXML += sTAB2 + "<nome>" + diretorio.Nome + "</nome>" + sCR
		sXML += sTAB2 + "<tamanho>" + diretorio.Tamanho + "</tamanho>" + sCR
		sXML += sTAB2 + "<tipo>" + diretorio.Tipo.Codigo + "</tipo>" + sCR
		sXML += sTAB2 + "<modificado>" + diretorio.ModificadoFormatado + "</modificado>" + sCR
		sXML += sTAB2 + "<atributos>" + diretorio.Atributos + "</atributos>" + sCR
		sXML += sTAB2 + "<codDirPai>" + diretorio.CodDirPai + "</codDirPai>" + sCR
		sXML += sTAB2 + "<caminho>" + diretorio.Caminho + "</caminho>" + sCR
		sXML += sTAB + "</arquivo>"
		return sXML

	def diretorioToTXT(self, diretorio):
		sTAB = "\t"
		sTXT = ""
		sTXT += diretorio.Aba.Nome + sTAB
		sTXT += diretorio.Nome + sTAB
		sTXT += diretorio.Tamanho + sTAB
		sTXT += diretorio.TamanhoFormatado + sTAB
		sTXT += diretorio.Tipo.Nome + sTAB
		sTXT += diretorio.ModificadoFormatado + sTAB
		sTXT += diretorio.Atributos + sTAB
		sTXT += diretorio.Caminho
		return sTXT

	def diretorioToHTML(self, diretorio):
		sTAB = "\t"
		sTAB2 = "\t\t"
		sCR = "\n"
		sHTML = sTAB + "<tr>" + sCR
		sHTML += sTAB2 + "<td>" + diretorio.Aba.Nome + "</td>" + sCR
		sHTML += sTAB2 + "<td>" + diretorio.Nome + "</td>" + sCR
		sHTML += sTAB2 + "<td>" + diretorio.Tamanho + "</td>" + sCR
		sHTML += sTAB2 + "<td>" + Rotinas.StringReplaceAll(diretorio.TamanhoFormatado, " ", "&nbsp;") + "</td>" + sCR
		sHTML += sTAB2 + "<td>" + diretorio.Tipo.Nome + "</td>" + sCR
		sHTML += sTAB2 + "<td>" + Rotinas.StringReplaceAll(diretorio.ModificadoFormatado, " ", "&nbsp;") + "</td>" + sCR
		sHTML += sTAB2 + "<td>" + diretorio.Atributos + "</td>" + sCR
		sHTML += sTAB2 + "<td>" + diretorio.Caminho + "</td>" + sCR
		sHTML += sTAB + "</tr>"
		return sHTML

	def exportarDiretorio(self, tipo, aba, sNomeArquivo, progressoLog):
		sTexto = ""
		abaLocal = Aba()
		sTAB = "\t"
		sTAB2 = "\t\t"
		sCR = "\n"
		sCondicaoTotal = " where aba=" + aba.Codigo
		sSQL = self._SQL_CONSULTA_ARQUIVO + sCondicaoTotal + " order by 1, 2, 3"
		listaDiretorio = self.carregarDiretorio(sSQL, sCondicaoTotal, progressoLog)
		listaLocal = StringList()
		if tipo == TipoExportar.teCSV:
			sTexto = "\"Aba\";\"Nome\";\"TamanhoBytes\";\"Tamanho\";" + "\"Tipo\";\"Modificado\";\"Atributos\";\"Caminho\""
		elif tipo == TipoExportar.teHTML:
			sTexto = "<!DOCTYPE html>" + sCR
			sTexto += "<html>" + sCR
			sTexto += "<body>" + sCR
			sTexto += "<table border=\"1\" cellpadding=\"5\" cellspacing=\"0\">" + sCR
			sTexto += sTAB + "<tr>" + sCR
			sTexto += sTAB2 + "<th>Aba</th>" + sCR
			sTexto += sTAB2 + "<th>Nome</th>" + sCR
			sTexto += sTAB2 + "<th>Tamanho</th>" + sCR
			sTexto += sTAB2 + "<th>Tamanho Formatado</th>" + sCR
			sTexto += sTAB2 + "<th>Tipo</th>" + sCR
			sTexto += sTAB2 + "<th>Modificado</th>" + sCR
			sTexto += sTAB2 + "<th>Atributos</th>" + sCR
			sTexto += sTAB2 + "<th>Caminho</th>" + sCR
			sTexto += sTAB + "</tr>"
		elif tipo == TipoExportar.teXML:
			sTexto = "<diretorio>"
		elif tipo == TipoExportar.teSQL:
			abaLocal.Codigo = listaDiretorio[0].Aba.Codigo
			abaLocal.Nome = listaDiretorio[0].Aba.Nome
			sTexto = AbaBO.Instancia.abaToSQL(abaLocal)
		if sTexto.Length > 0:
			listaLocal.Add(sTexto)
		enumerator = listaDiretorio.GetEnumerator()
		while enumerator.MoveNext():
			diretorio = enumerator.Current
			if diretorio.Aba.Codigo == aba.Codigo:
				if tipo == TipoExportar.teTXT:
					sTexto = self.diretorioToTXT(diretorio)
				elif tipo == TipoExportar.teCSV:
					sTexto = self.diretorioToCSV(diretorio)
				elif tipo == TipoExportar.teHTML:
					sTexto = self.diretorioToHTML(diretorio)
				elif tipo == TipoExportar.teXML:
					sTexto = self.diretorioToXML(diretorio)
				elif tipo == TipoExportar.teSQL:
					sTexto = self.diretorioToSQL(diretorio, True) + ";"
				listaLocal.Add(sTexto)
		if tipo == TipoExportar.teHTML:
			sTexto += sCR + "</table>" + sCR
			sTexto += "</body>" + sCR
			sTexto += "</html>" + sCR
		elif tipo == TipoExportar.teXML:
			sTexto = "</diretorio>"
		listaLocal.Add(sTexto)
		listaLocal.SaveToFile(sNomeArquivo)
		listaDiretorio.Clear()
		listaLocal.Clear()

	def criarTabelaDiretorios(self):
		return (DiretorioDAO.Instancia.criarTabela() > 0)

	def XMLParaDiretorio(self, sTexto, nArquivo, diretorioXML):
		sTagInicio = ""
		sValor = ""
		sTagFim = ""
		resultado = nArquivo
		if Rotinas.Pos(">", sTexto) > 0:
			sTagInicio = Rotinas.SubString(sTexto, 1, Rotinas.Pos(">", sTexto))
		if (Rotinas.Pos(">", sTexto) > 0) and (Rotinas.Pos("</", sTexto) > 1):
			sValor = Rotinas.SubString(sTexto, Rotinas.Pos(">", sTexto) + 1, Rotinas.Pos("</", sTexto) - Rotinas.Pos(">", sTexto) - 1)
		if Rotinas.LastDelimiter(">", sTexto) > 0:
			sTagFim = Rotinas.SubString(sTexto, Rotinas.LastDelimiter("<", sTexto), Rotinas.LastDelimiter(">", sTexto))
		if (nArquivo == 1) and (not sTagInicio.Equals("<arquivo>")):
			resultado = -1
		if (nArquivo == 2) and (not sTagInicio.Equals("<aba>")) and (not sTagFim.Equals("</aba>")):
			# diretorio.aba.codigo = StrToInt(sValor);
			resultado = -1
		if (nArquivo == 3) and (not sTagInicio.Equals("<nomeAba>")) and (not sTagFim.Equals("</nomeAba>")):
			# diretorio.aba.nome = sValor;
			resultado = -1
		if (nArquivo == 4) and (sTagInicio.Equals("<codigo>")) and (sTagFim.Equals("</codigo>")):
			diretorioXML.Diretorio.Codigo = Convert.ToInt32(sValor)
		if (nArquivo == 5) and (sTagInicio.Equals("<ordem>")) and (sTagFim.Equals("</ordem>")):
			diretorioXML.Diretorio.Ordem = Convert.ToInt32(sValor)
		if (nArquivo == 6) and (sTagInicio.Equals("<nome>")) and (sTagFim.Equals("</nome>")):
			diretorioXML.Diretorio.Nome = sValor
		if (nArquivo == 7) and (sTagInicio.Equals("<tamanho>")) and (sTagFim.Equals("</tamanho>")):
			diretorioXML.Diretorio.Tamanho = Convert.ToInt64(sValor)
		if (nArquivo == 8) and (sTagInicio.Equals("<tipo>")) and (sTagFim.Equals("</tipo>")):
			tp = Tipo()
			tp.Codigo = sValor[0]
			diretorioXML.Diretorio.Tipo = tp
		if (nArquivo == 9) and (sTagInicio.Equals("<modificado>")) and (sTagFim.Equals("</modificado>")):
			diretorioXML.Diretorio.Modificado = Rotinas.StringToDate(sValor)
		if (nArquivo == 10) and (sTagInicio.Equals("<atributos>")) and (sTagFim.Equals("</atributos>")):
			diretorioXML.Diretorio.Atributos = sValor
		if (nArquivo == 11) and (sTagInicio.Equals("<codDirPai>")) and (sTagFim.Equals("</codDirPai>")):
			diretorioXML.Diretorio.CodDirPai = Convert.ToInt32(sValor)
		if (nArquivo == 12) and (sTagInicio.Equals("<caminho>")) and (sTagFim.Equals("</caminho>")):
			diretorioXML.Diretorio.Caminho = sValor
		if (nArquivo == 13) and (not sTagInicio.Equals("</arquivo>")):
			resultado = -1
		if sTagInicio.Equals("</diretorio>"):
			resultado = -3
		return resultado

	def importarDiretorioViaXML(self, aba, sNomeArquivo, listaDirPai, progressoLog):
		resultado = 0
		diretorioXML = DiretorioXML()
		listaDiretorio = List[Diretorio]()
		listaLocal = StringList()
		listaLocal.LoadFromFile(sNomeArquivo)
		if not listaLocal[0].Equals("<diretorio>"):
			resultado = -1
		else:
			nArquivo = 0
			enumerator = listaLocal.GetEnumerator()
			while enumerator.MoveNext():
				sTexto1 = enumerator.Current
				sTexto = sTexto1.Trim()
				nArquivo = self.XMLParaDiretorio(sTexto, nArquivo, diretorioXML)
				if nArquivo == -1:
					resultado = -1
					break
				elif nArquivo == 13:
					nArquivo = 1
					diretorioXML.Diretorio.Aba = aba
					listaDiretorio.Add(diretorioXML.Diretorio)
					if self.verificaCodDir(aba.Codigo, diretorioXML.Diretorio.Caminho, listaDirPai):
						resultado = -2
						break
					diretorioXML.Diretorio = Diretorio()
				elif nArquivo == -3:
					resultado = nArquivo
				else:
					nArquivo += 1
		self.salvarDiretorio(listaDiretorio, progressoLog)
		listaDiretorio.Clear()
		return resultado

	def carregarSubDiretorios(self, sDiretorio, listaLocal):
		if Rotinas.SubString(sDiretorio, sDiretorio.Length, 1).Equals(Path.DirectorySeparatorChar):
			sSeparador = ""
		else:
			sSeparador = Path.DirectorySeparatorChar.ToString()
		sCaminho = sDiretorio + sSeparador
		dirPesquisado = FileInfo(sCaminho)
		if dirPesquisado.Directory.Exists:
			enumerator = Rotinas.listFiles(dirPesquisado.FullName).GetEnumerator()
			while enumerator.MoveNext():
				dirPesquisado2 = enumerator.Current
				sCaminho = sDiretorio + sSeparador + dirPesquisado2.Name
				if dirPesquisado2.Directory.Exists:
					if Rotinas.DirectoryExists(sCaminho):
						if (not dirPesquisado2.Name.Equals(".")) and (not dirPesquisado2.Name.Equals("..")):
							listaLocal.Add(sCaminho)
		return (listaLocal.Count > 0)

	def carregarArquivos(self, sDiretorio, listaLocal):
		if Rotinas.SubString(sDiretorio, sDiretorio.Length, 1).Equals(Path.DirectorySeparatorChar):
			sSeparador = ""
		else:
			sSeparador = Path.DirectorySeparatorChar.ToString()
		sCaminho = sDiretorio + sSeparador
		dirPesquisado = FileInfo(sCaminho)
		if dirPesquisado.Directory.Exists:
			enumerator = Rotinas.listFiles(dirPesquisado.FullName).GetEnumerator()
			while enumerator.MoveNext():
				dirPesquisado2 = enumerator.Current
				sCaminho = sDiretorio + sSeparador + dirPesquisado2.Name
				if dirPesquisado2.Exists:
					if Rotinas.FileExists(sCaminho):
						if (not dirPesquisado.Name.Equals(".")) and (not dirPesquisado.Name.Equals("..")):
							listaLocal.Add(sCaminho)
		return (listaLocal.Count > 0)

	def carregarTodosArquivos(self, sDiretorio, listaLocal):
		if Rotinas.SubString(sDiretorio, sDiretorio.Length, 1).Equals(Path.DirectorySeparatorChar):
			sSeparador = ""
		else:
			sSeparador = Path.DirectorySeparatorChar.ToString()
		sCaminho = sDiretorio + sSeparador
		dirPesquisado = FileInfo(sCaminho)
		if dirPesquisado.Directory.Exists:
			sCaminho = sDiretorio + sSeparador + dirPesquisado.Name
			if Rotinas.FileExists(sCaminho):
				listaLocal.Add(sCaminho)
			elif Rotinas.DirectoryExists(sCaminho):
				if (not dirPesquisado.Name.Equals(".")) and (not dirPesquisado.Name.Equals("..")):
					self.carregarTodosArquivos(sCaminho, listaLocal)
			enumerator = Rotinas.listFiles(dirPesquisado.FullName).GetEnumerator()
			while enumerator.MoveNext():
				dirPesquisado2 = enumerator.Current
				sCaminho = sDiretorio + sSeparador + dirPesquisado2.Name
				if Rotinas.FileExists(sCaminho):
					listaLocal.Add(sCaminho)
				elif Rotinas.DirectoryExists(sCaminho):
					if (not dirPesquisado2.Name.Equals(".")) and (not dirPesquisado2.Name.Equals("..")):
						self.carregarTodosArquivos(sCaminho, listaLocal)
		return (listaLocal.Count > 0)

	def itensFilhos(self, lista_pai, aba, codDirPai, codigo):
		lista = List[Diretorio]()
		enumerator = lista_pai.GetEnumerator()
		while enumerator.MoveNext():
			diretorio = enumerator.Current
			if diretorio.Aba.Codigo == aba:
				if diretorio.CodDirPai == codDirPai:
					if diretorio.Codigo == codigo:
						lista.Add(diretorio)
		return lista