# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 06/07/2015
# * Time: 16:17
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.IO, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosdao, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetosbo
	# <summary>
	# Description of DiretorioBO.
	# </summary>
	class DiretorioBO
		def Instancia
			return @instancia
		end

		def initialize()
			@instancia = DiretorioBO.new()
			@SQL_CONSULTA_ARQUIVO = "select aba, cod, " + "ordem, coddirpai, nome, tam, tipo, modificado, atributos, " + "caminho, nomeaba, nomepai, caminhopai from consultaarquivo"
		end

		def carregarDiretorio(sSQL, progressoLog)
			return DiretorioDAO.Instancia.consultarTudo(sSQL, "", progressoLog)
		end

		def carregarDiretorio(sSQL, sCondicaoTotal, progressoLog)
			return DiretorioDAO.Instancia.consultarTudo(sSQL, sCondicaoTotal, progressoLog)
		end

		def removerDrive(sDiretorio)
			drives = Directory.GetLogicalDrives()
			i = 0
			bAchou = false
			sArq = Rotinas.testaNull(sDiretorio)
			if sArq.Length > 0 then
				i = 0
				while i < drives.Length
					if sArq.ToUpper().Contains(drives[i].ToUpper()) then
						bAchou = true
						break
					end
					i += 1
				end
			end
			sArq = Rotinas.trocaSeparador(sArq)
			if bAchou then
				return sArq.Substring(drives[i].Length)
			else
				return sArq
			end
		end

		def arquivoAtributos(arquivo, bDiretorio)
			sAtributos = ""
			if bDiretorio then
				sAtributos += "[DIR]"
			else
				sAtributos += "[ARQ]"
			end
			if arquivo != nil then
				if arquivo.Exists then
					#if (arquivo.Attributes==FileAttributes.Archive) {}		
					if arquivo.IsReadOnly then
						sAtributos += "[ROL]"
					end
					if arquivo.Attributes == FileAttributes.Hidden then
						sAtributos += "[HID]"
					end
					if arquivo.Attributes == FileAttributes.System then
						sAtributos += "[SYS]"
					end
				else
					#if (arquivo.Directory.Attributes==FileAttributes.Directory) {}
					if arquivo.Directory.Attributes == FileAttributes.Hidden then
						sAtributos += "[HID]"
					end
					if arquivo.Directory.Attributes == FileAttributes.System then
						sAtributos += "[SYS]"
					end
				end
			end
			return sAtributos
		end

		def retCodDirPai(nAba, sDiretorio, listaLocal)
			enumerator = listaLocal.GetEnumerator()
			while enumerator.MoveNext()
				diretorio = enumerator.Current
				if diretorio.Aba.Codigo == nAba then
					if diretorio.Caminho.Equals(sDiretorio) then
						return diretorio.Ordem
					end
				end
			end
			return 0
		end

		def MontaTamanho(nTam)
			nUmKilo = 1024
			nUmMega = nUmKilo * 1024
			nUmGiga = nUmMega * 1024
			nUmTera = nUmGiga * 1024
			nUmPeta = nUmTera * 1024
			if nTam.CompareTo(nUmKilo) == -1 then
				nTamLocal = nTam
				return Rotinas.FormatDecimal(nTamLocal) + " Byte(s)"
			elsif nTam.CompareTo(nUmKilo) == 1 and nTam.CompareTo(nUmMega) == -1 then
				nTamLocal = nTam / nUmKilo
				return Rotinas.FormatDecimal(nTamLocal) + " KByte(s)"
			elsif nTam.CompareTo(nUmMega) == 1 and nTam.CompareTo(nUmGiga) == -1 then
				nTamLocal = nTam / nUmMega
				return Rotinas.FormatDecimal(nTamLocal) + " MByte(s)"
			elsif nTam.CompareTo(nUmGiga) == 1 and nTam.CompareTo(nUmTera) == -1 then
				nTamLocal = nTam / nUmGiga
				return Rotinas.FormatDecimal(nTamLocal) + " GByte(s)"
			elsif nTam.CompareTo(nUmTera) == 1 and nTam.CompareTo(nUmPeta) == -1 then
				nTamLocal = nTam / nUmTera
				return Rotinas.FormatDecimal(nTamLocal) + " TByte(s)"
			else
				nTamLocal = nTam / nUmPeta
				return Rotinas.FormatDecimal(nTamLocal) + " PByte(s)"
			end
		end

		def atribuiDiretorio(nAba, nCodDirRaiz, sNomeDirRaiz, sDiretorio, bDiretorio, listaLocal, arquivo, dirOrdem)
			nOrdem = dirOrdem.Ordem
			fCaminho = nil
			sCaminho = self.removerDrive(sDiretorio)
			if sDiretorio.Length > 0 then
				fCaminho = FileInfo.new(sDiretorio)
			end
			if (sCaminho.Length > 0) and (sNomeDirRaiz.Length > 0) then
				if Rotinas.StartsStr(sNomeDirRaiz, sCaminho) then
					sCaminho = Rotinas.SubString(sCaminho, sNomeDirRaiz.Length + 2, sCaminho.Length)
					sDir = Rotinas.SubString(sDiretorio, sNomeDirRaiz.Length + 2, sDiretorio.Length)
					fCaminho = FileInfo.new(sDir)
				else
					sCaminho = sNomeDirRaiz + Rotinas.BARRA_INVERTIDA + sCaminho
					sDir = sNomeDirRaiz + Rotinas.BARRA_INVERTIDA + sDiretorio
					fCaminho = FileInfo.new(sDir)
				end
			end
			diretorio = Diretorio.new()
			abaLocal = Aba.new()
			tipoLocal = Tipo.new()
			abaLocal.Codigo = nAba
			diretorio.Codigo = nCodDirRaiz
			diretorio.Ordem = nOrdem
			diretorio.Nome = arquivo.Nome
			diretorio.Tamanho = arquivo.Tamanho
			diretorio.Modificado = arquivo.Modificado
			diretorio.Atributos = self.arquivoAtributos(fCaminho, bDiretorio)
			if sDiretorio.Length == 0 then
				diretorio.Caminho = arquivo.Nome
				diretorio.CaminhoPai = ""
			else
				diretorio.Caminho = sCaminho
				diretorio.CaminhoPai = Rotinas.SubString(diretorio.Caminho, 1, Rotinas.LastDelimiter(Rotinas.BARRA_INVERTIDA, diretorio.Caminho) - 1)
			end
			if bDiretorio then
				tipoLocal.Codigo = 'D'
				if nOrdem == 1 then
					diretorio.CodDirPai = 0
				else
					diretorio.CodDirPai = self.retCodDirPai(abaLocal.Codigo, diretorio.CaminhoPai, listaLocal)
				end
			else
				tipoLocal.Codigo = 'A'
				diretorio.CodDirPai = self.retCodDirPai(abaLocal.Codigo, diretorio.CaminhoPai, listaLocal)
			end
			abaLocal.Nome = ""
			diretorio.Aba = abaLocal
			diretorio.NomePai = ""
			diretorio.TamanhoFormatado = self.MontaTamanho(diretorio.Tamanho)
			if tipoLocal.Codigo == 'D' then
				tipoLocal.Nome = "Diretório"
			else
				tipoLocal.Nome = "Arquivo"
			end
			diretorio.Tipo = tipoLocal
			diretorio.ModificadoFormatado = Rotinas.formataDate(Rotinas.FORMATO_DATAHORA, diretorio.Modificado)
			diretorio.CaminhoOriginal = sDiretorio
			nOrdem += 1
			dirOrdem.Ordem = nOrdem
			return diretorio
		end

		def dirPesquisadoToArquivo(dirPesquisado)
			arquivo = Arquivo.new()
			arquivo.Nome = dirPesquisado.Name
			if dirPesquisado.Exists then
				arquivo.Tamanho = dirPesquisado.Length
			else
				arquivo.Tamanho = 0
			end
			arquivo.Modificado = dirPesquisado.LastWriteTime
			arquivo.Atributos = self.arquivoAtributos(dirPesquisado, not dirPesquisado.Exists)
			return arquivo
		end

		def atribuiListaDiretorio(nAba, nCodDirRaiz, sNomeDirRaiz, sDiretorio, listaLocal, dirPesquisado, dirOrdem, progressoLog)
			pb = Progresso.new()
			if Rotinas.FileExists(sDiretorio) then
				diretorio = self.atribuiDiretorio(nAba, nCodDirRaiz, sNomeDirRaiz, sDiretorio, false, listaLocal, self.dirPesquisadoToArquivo(dirPesquisado), dirOrdem)
				listaLocal.Add(diretorio)
				if progressoLog != nil then
					pb.Log = sDiretorio
					progressoLog.ProgressoLog(pb)
				end
			elsif Rotinas.DirectoryExists(sDiretorio) then
				if (not dirPesquisado.Name.Equals(".")) and (not dirPesquisado.Name.Equals("..")) then
					diretorio = self.atribuiDiretorio(nAba, nCodDirRaiz, sNomeDirRaiz, sDiretorio, true, listaLocal, self.dirPesquisadoToArquivo(dirPesquisado), dirOrdem)
					listaLocal.Add(diretorio)
					if progressoLog != nil then
						pb.Log = sDiretorio
						progressoLog.ProgressoLog(pb)
					end
					self.ImportarDiretorio(nAba, nCodDirRaiz, sNomeDirRaiz, sDiretorio, listaLocal, dirOrdem, progressoLog)
				end
			end
		end

		def ImportarDiretorio(nAba, nCodDirRaiz, sNomeDirRaiz, sDiretorio, listaLocal, dirOrdem, progressoLog)
			if Rotinas.SubString(sDiretorio, sDiretorio.Length, 1).Equals(Path.DirectorySeparatorChar) then
				sSeparador = ""
			else
				sSeparador = Path.DirectorySeparatorChar.ToString()
			end
			sCaminho = sDiretorio + sSeparador
			dirPesquisado = FileInfo.new(sCaminho)
			if dirPesquisado.Directory.Exists then
				enumerator = Rotinas.listFiles(dirPesquisado.FullName).GetEnumerator()
				while enumerator.MoveNext()
					dirPesquisado2 = enumerator.Current
					sCaminho = sDiretorio + sSeparador + dirPesquisado2.Name
					self.atribuiListaDiretorio(nAba, nCodDirRaiz, sNomeDirRaiz, sCaminho, listaLocal, dirPesquisado2, dirOrdem, progressoLog)
				end
			end
		end

		def verificaCodDir(nAba, sDiretorio, listaLocal)
			if sDiretorio.Length > 0 then
				enumerator = listaLocal.GetEnumerator()
				while enumerator.MoveNext()
					diretorio = enumerator.Current
					if diretorio.Aba.Codigo == nAba then
						if diretorio.Ordem == 1 then
							if diretorio.CodDirPai == 0 then
								if diretorio.Caminho.Equals(sDiretorio) then
									return true
								end
							end
						end
					end
				end
			end
			return false
		end

		def retMaxCodDir(nAba, listaLocal)
			nMaior = -1
			enumerator = listaLocal.GetEnumerator()
			while enumerator.MoveNext()
				diretorio = enumerator.Current
				if diretorio.Aba.Codigo == nAba then
					if diretorio.Codigo > nMaior then
						nMaior = diretorio.Codigo
					end
				end
			end
			return nMaior + 1
		end

		def diretorioToSQL(diretorio, bInsert)
			sSQL = ""
			if bInsert then
				sSQL = "insert into Diretorios(aba, cod, ordem, coddirpai, nome, " + "tam, tipo, modificado, atributos, caminho) values("
			end
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
			if bInsert then
				sSQL += ")"
			end
			return sSQL
		end

		def salvarDiretorio(listaDiretorio, progressoLog)
			pb = Progresso.new()
			pb.Minimo = 0
			pb.Maximo = listaDiretorio.Count - 1
			pb.Posicao = 0
			pb.Passo = 1
			begin
				i = 0
				while i < listaDiretorio.Count
					diretorio = listaDiretorio[i]
					DiretorioDAO.Instancia.incluir(diretorio)
					pb.Log = (i + 1) + " - Salvando Diretório: " + diretorio.Caminho
					pb.Posicao = i
					if progressoLog != nil then
						progressoLog.ProgressoLog(pb)
					end
					i += 1
				end
			rescue Exception => 
				raise 
			ensure
			end
		end

		def excluirDiretorio(aba, sCaminho)
			return (DiretorioDAO.Instancia.excluir(aba, sCaminho) > 0)
		end

		def excluirListaDiretorio(listaDiretorio, aba, sCaminho)
			i = listaDiretorio.Count - 1
			while i >= 0
				diretorio = listaDiretorio[i]
				if diretorio.Aba.Codigo == aba.Codigo then
					if sCaminho.Trim().Length > 0 then
						if Rotinas.StartsStr(sCaminho, diretorio.Caminho) then
							listaDiretorio.Remove(diretorio)
						end
					else
						listaDiretorio.Remove(diretorio)
					end
				end
				i -= 1
			end
		end

		def diretorioToCSV(diretorio)
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
		end

		def diretorioToXML(diretorio)
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
		end

		def diretorioToTXT(diretorio)
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
		end

		def diretorioToHTML(diretorio)
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
		end

		def exportarDiretorio(tipo, aba, sNomeArquivo, progressoLog)
			sTexto = ""
			abaLocal = Aba.new()
			sTAB = "\t"
			sTAB2 = "\t\t"
			sCR = "\n"
			sCondicaoTotal = " where aba=" + aba.Codigo
			sSQL = @SQL_CONSULTA_ARQUIVO + sCondicaoTotal + " order by 1, 2, 3"
			listaDiretorio = self.carregarDiretorio(sSQL, sCondicaoTotal, progressoLog)
			listaLocal = StringList.new()
			case tipo
				when TipoExportar.teCSV
					sTexto = "\"Aba\";\"Nome\";\"TamanhoBytes\";\"Tamanho\";" + "\"Tipo\";\"Modificado\";\"Atributos\";\"Caminho\""
				when TipoExportar.teHTML
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
				when TipoExportar.teXML
					sTexto = "<diretorio>"
				when TipoExportar.teSQL
					abaLocal.Codigo = listaDiretorio[0].Aba.Codigo
					abaLocal.Nome = listaDiretorio[0].Aba.Nome
					sTexto = AbaBO.Instancia.abaToSQL(abaLocal)
			end
			if sTexto.Length > 0 then
				listaLocal.Add(sTexto)
			end
			enumerator = listaDiretorio.GetEnumerator()
			while enumerator.MoveNext()
				diretorio = enumerator.Current
				if diretorio.Aba.Codigo == aba.Codigo then
					if tipo == TipoExportar.teTXT then
						sTexto = self.diretorioToTXT(diretorio)
					elsif tipo == TipoExportar.teCSV then
						sTexto = self.diretorioToCSV(diretorio)
					elsif tipo == TipoExportar.teHTML then
						sTexto = self.diretorioToHTML(diretorio)
					elsif tipo == TipoExportar.teXML then
						sTexto = self.diretorioToXML(diretorio)
					elsif tipo == TipoExportar.teSQL then
						sTexto = self.diretorioToSQL(diretorio, true) + ";"
					end
					listaLocal.Add(sTexto)
				end
			end
			if tipo == TipoExportar.teHTML then
				sTexto += sCR + "</table>" + sCR
				sTexto += "</body>" + sCR
				sTexto += "</html>" + sCR
			elsif tipo == TipoExportar.teXML then
				sTexto = "</diretorio>"
			end
			listaLocal.Add(sTexto)
			listaLocal.SaveToFile(sNomeArquivo)
			listaDiretorio.Clear()
			listaLocal.Clear()
		end

		def criarTabelaDiretorios()
			return (DiretorioDAO.Instancia.criarTabela() > 0)
		end

		def XMLParaDiretorio(sTexto, nArquivo, diretorioXML)
			sTagInicio = ""
			sValor = ""
			sTagFim = ""
			resultado = nArquivo
			if Rotinas.Pos(">", sTexto) > 0 then
				sTagInicio = Rotinas.SubString(sTexto, 1, Rotinas.Pos(">", sTexto))
			end
			if (Rotinas.Pos(">", sTexto) > 0) and (Rotinas.Pos("</", sTexto) > 1) then
				sValor = Rotinas.SubString(sTexto, Rotinas.Pos(">", sTexto) + 1, Rotinas.Pos("</", sTexto) - Rotinas.Pos(">", sTexto) - 1)
			end
			if Rotinas.LastDelimiter(">", sTexto) > 0 then
				sTagFim = Rotinas.SubString(sTexto, Rotinas.LastDelimiter("<", sTexto), Rotinas.LastDelimiter(">", sTexto))
			end
			if (nArquivo == 1) and (not sTagInicio.Equals("<arquivo>")) then
				resultado = -1
			end
			if (nArquivo == 2) and (not sTagInicio.Equals("<aba>")) and (not sTagFim.Equals("</aba>")) then
				# diretorio.aba.codigo = StrToInt(sValor);
				resultado = -1
			end
			if (nArquivo == 3) and (not sTagInicio.Equals("<nomeAba>")) and (not sTagFim.Equals("</nomeAba>")) then
				# diretorio.aba.nome = sValor;
				resultado = -1
			end
			if (nArquivo == 4) and (sTagInicio.Equals("<codigo>")) and (sTagFim.Equals("</codigo>")) then
				diretorioXML.Diretorio.Codigo = Convert.ToInt32(sValor)
			end
			if (nArquivo == 5) and (sTagInicio.Equals("<ordem>")) and (sTagFim.Equals("</ordem>")) then
				diretorioXML.Diretorio.Ordem = Convert.ToInt32(sValor)
			end
			if (nArquivo == 6) and (sTagInicio.Equals("<nome>")) and (sTagFim.Equals("</nome>")) then
				diretorioXML.Diretorio.Nome = sValor
			end
			if (nArquivo == 7) and (sTagInicio.Equals("<tamanho>")) and (sTagFim.Equals("</tamanho>")) then
				diretorioXML.Diretorio.Tamanho = Convert.ToInt64(sValor)
			end
			if (nArquivo == 8) and (sTagInicio.Equals("<tipo>")) and (sTagFim.Equals("</tipo>")) then
				tp = Tipo.new()
				tp.Codigo = sValor[0]
				diretorioXML.Diretorio.Tipo = tp
			end
			if (nArquivo == 9) and (sTagInicio.Equals("<modificado>")) and (sTagFim.Equals("</modificado>")) then
				diretorioXML.Diretorio.Modificado = Rotinas.StringToDate(sValor)
			end
			if (nArquivo == 10) and (sTagInicio.Equals("<atributos>")) and (sTagFim.Equals("</atributos>")) then
				diretorioXML.Diretorio.Atributos = sValor
			end
			if (nArquivo == 11) and (sTagInicio.Equals("<codDirPai>")) and (sTagFim.Equals("</codDirPai>")) then
				diretorioXML.Diretorio.CodDirPai = Convert.ToInt32(sValor)
			end
			if (nArquivo == 12) and (sTagInicio.Equals("<caminho>")) and (sTagFim.Equals("</caminho>")) then
				diretorioXML.Diretorio.Caminho = sValor
			end
			if (nArquivo == 13) and (not sTagInicio.Equals("</arquivo>")) then
				resultado = -1
			end
			if sTagInicio.Equals("</diretorio>") then
				resultado = -3
			end
			return resultado
		end

		def importarDiretorioViaXML(aba, sNomeArquivo, listaDirPai, progressoLog)
			resultado = 0
			diretorioXML = DiretorioXML.new()
			listaDiretorio = List[Diretorio].new()
			listaLocal = StringList.new()
			listaLocal.LoadFromFile(sNomeArquivo)
			if not listaLocal[0].Equals("<diretorio>") then
				resultado = -1
			else
				nArquivo = 0
				enumerator = listaLocal.GetEnumerator()
				while enumerator.MoveNext()
					sTexto1 = enumerator.Current
					sTexto = sTexto1.Trim()
					nArquivo = self.XMLParaDiretorio(sTexto, nArquivo, diretorioXML)
					if nArquivo == -1 then
						resultado = -1
						break
					elsif nArquivo == 13 then
						nArquivo = 1
						diretorioXML.Diretorio.Aba = aba
						listaDiretorio.Add(diretorioXML.Diretorio)
						if self.verificaCodDir(aba.Codigo, diretorioXML.Diretorio.Caminho, listaDirPai) then
							resultado = -2
							break
						end
						diretorioXML.Diretorio = Diretorio.new()
					elsif nArquivo == -3 then
						resultado = nArquivo
					else
						nArquivo += 1
					end
				end
			end
			self.salvarDiretorio(listaDiretorio, progressoLog)
			listaDiretorio.Clear()
			return resultado
		end

		def carregarSubDiretorios(sDiretorio, listaLocal)
			if Rotinas.SubString(sDiretorio, sDiretorio.Length, 1).Equals(Path.DirectorySeparatorChar) then
				sSeparador = ""
			else
				sSeparador = Path.DirectorySeparatorChar.ToString()
			end
			sCaminho = sDiretorio + sSeparador
			dirPesquisado = FileInfo.new(sCaminho)
			if dirPesquisado.Directory.Exists then
				enumerator = Rotinas.listFiles(dirPesquisado.FullName).GetEnumerator()
				while enumerator.MoveNext()
					dirPesquisado2 = enumerator.Current
					sCaminho = sDiretorio + sSeparador + dirPesquisado2.Name
					if dirPesquisado2.Directory.Exists then
						if Rotinas.DirectoryExists(sCaminho) then
							if (not dirPesquisado2.Name.Equals(".")) and (not dirPesquisado2.Name.Equals("..")) then
								listaLocal.Add(sCaminho)
							end
						end
					end
				end
			end
			return (listaLocal.Count > 0)
		end

		def carregarArquivos(sDiretorio, listaLocal)
			if Rotinas.SubString(sDiretorio, sDiretorio.Length, 1).Equals(Path.DirectorySeparatorChar) then
				sSeparador = ""
			else
				sSeparador = Path.DirectorySeparatorChar.ToString()
			end
			sCaminho = sDiretorio + sSeparador
			dirPesquisado = FileInfo.new(sCaminho)
			if dirPesquisado.Directory.Exists then
				enumerator = Rotinas.listFiles(dirPesquisado.FullName).GetEnumerator()
				while enumerator.MoveNext()
					dirPesquisado2 = enumerator.Current
					sCaminho = sDiretorio + sSeparador + dirPesquisado2.Name
					if dirPesquisado2.Exists then
						if Rotinas.FileExists(sCaminho) then
							if (not dirPesquisado.Name.Equals(".")) and (not dirPesquisado.Name.Equals("..")) then
								listaLocal.Add(sCaminho)
							end
						end
					end
				end
			end
			return (listaLocal.Count > 0)
		end

		def carregarTodosArquivos(sDiretorio, listaLocal)
			if Rotinas.SubString(sDiretorio, sDiretorio.Length, 1).Equals(Path.DirectorySeparatorChar) then
				sSeparador = ""
			else
				sSeparador = Path.DirectorySeparatorChar.ToString()
			end
			sCaminho = sDiretorio + sSeparador
			dirPesquisado = FileInfo.new(sCaminho)
			if dirPesquisado.Directory.Exists then
				sCaminho = sDiretorio + sSeparador + dirPesquisado.Name
				if Rotinas.FileExists(sCaminho) then
					listaLocal.Add(sCaminho)
				elsif Rotinas.DirectoryExists(sCaminho) then
					if (not dirPesquisado.Name.Equals(".")) and (not dirPesquisado.Name.Equals("..")) then
						self.carregarTodosArquivos(sCaminho, listaLocal)
					end
				end
				enumerator = Rotinas.listFiles(dirPesquisado.FullName).GetEnumerator()
				while enumerator.MoveNext()
					dirPesquisado2 = enumerator.Current
					sCaminho = sDiretorio + sSeparador + dirPesquisado2.Name
					if Rotinas.FileExists(sCaminho) then
						listaLocal.Add(sCaminho)
					elsif Rotinas.DirectoryExists(sCaminho) then
						if (not dirPesquisado2.Name.Equals(".")) and (not dirPesquisado2.Name.Equals("..")) then
							self.carregarTodosArquivos(sCaminho, listaLocal)
						end
					end
				end
			end
			return (listaLocal.Count > 0)
		end

		def itensFilhos(lista_pai, aba, codDirPai, codigo)
			lista = List[Diretorio].new()
			enumerator = lista_pai.GetEnumerator()
			while enumerator.MoveNext()
				diretorio = enumerator.Current
				if diretorio.Aba.Codigo == aba then
					if diretorio.CodDirPai == codDirPai then
						if diretorio.Codigo == codigo then
							lista.Add(diretorio)
						end
					end
				end
			end
			return lista
		end
	end
end