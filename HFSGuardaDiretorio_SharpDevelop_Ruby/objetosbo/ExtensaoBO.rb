# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 06/07/2015
# * Time: 15:02
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.IO, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing.Imaging, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosdao, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetosbo
	# <summary>
	# Description of ExtensaoBO.
	# </summary>
	class ExtensaoBO
		def Instancia
			return @instancia
		end

		def initialize()
			@instancia = ExtensaoBO.new()
		end

		#diretorioBMP = Rotinas.LerArquivoImagem("imagens"+Path.DirectorySeparatorChar+"diretorio.bmp");
		#arquivoBMP = Rotinas.LerArquivoImagem("imagens"+Path.DirectorySeparatorChar+"arquivo.bmp");
		def carregarExtensao(progressoLog)
			return ExtensaoDAO.Instancia.consultarTudo(progressoLog)
		end

		def carregarExtensoes(lista, listaImg16, listaImg32)
			@diretorioBMP = Rotinas.imageToByteArray(listaImg16.Images[0], ImageFormat.Bmp)
			@arquivoBMP = Rotinas.imageToByteArray(listaImg16.Images[2], ImageFormat.Bmp)
			enumerator = lista.GetEnumerator()
			while enumerator.MoveNext()
				extensao = enumerator.Current
				bmp16 = Rotinas.byteArrayToBitmap(extensao.Bmp16)
				bmp32 = Rotinas.byteArrayToBitmap(extensao.Bmp32)
				listaImg16.Images.Add(bmp16)
				listaImg32.Images.Add(bmp32)
			end
		end

		def existeExtensao(sExtensao, listaLocal)
			if sExtensao.Trim().Length > 0 then
				enumerator = listaLocal.GetEnumerator()
				while enumerator.MoveNext()
					extensao = enumerator.Current
					if extensao.Nome.Trim().ToLower().Equals(sExtensao.Trim().ToLower()) then
						return true
					end
				end
			end
			return false
		end

		def retMaxCodExtensao(listaLocal)
			nMaior = 0
			enumerator = listaLocal.GetEnumerator()
			while enumerator.MoveNext()
				extensao = enumerator.Current
				if extensao.Codigo > nMaior then
					nMaior = extensao.Codigo
				end
			end
			return nMaior + 1
		end

		def incluirExtensao(extensao)
			return (ExtensaoDAO.Instancia.incluir(extensao) > 0)
		end

		def SalvarExtensao(listaExtensao, sNomeDiretorio, sCaminhoOriginal, log)
			if Rotinas.LastDelimiter(".", sNomeDiretorio) > 0 then
				sExtensao = Rotinas.SubString(sNomeDiretorio, Rotinas.LastDelimiter(".", sNomeDiretorio) + 1, sNomeDiretorio.Length)
				if not self.existeExtensao(sExtensao, listaExtensao) then
					extensao = Extensao.new()
					extensao.Codigo = self.retMaxCodExtensao(listaExtensao)
					extensao.Nome = sExtensao.ToLower()
					extensao.Ordem = listaExtensao.Count + 1
					extensao.Bmp16 = Rotinas.LerArquivoImagem(sCaminhoOriginal)
					extensao.Bmp32 = Rotinas.LerArquivoImagem(sCaminhoOriginal)
					self.incluirExtensao(extensao)
					listaExtensao.Add(extensao)
					log.Add("Salvando Extensão: " + extensao.Nome)
					return true
				end
			end
			return false
		end

		def salvarExtensoes(listaDiretorio, listaExtensao, progressoLog)
			log = StringList.new()
			pb = Progresso.new()
			pb.Minimo = 0
			pb.Maximo = listaDiretorio.Count - 1
			pb.Posicao = 0
			pb.Passo = 1
			i = 0
			while i < listaDiretorio.Count
				diretorio = listaDiretorio[i]
				if diretorio.Tipo.Codigo == 'A' then
					self.SalvarExtensao(listaExtensao, diretorio.Nome, diretorio.CaminhoOriginal, log)
					if log.Count > 0 then
						pb.Log = log[0]
						log.Clear()
					end
				end
				pb.Posicao = i
				if progressoLog != nil then
					progressoLog.ProgressoLog(pb)
				end
				i += 1
			end
		end

		def excluirExtensao(listaExtensao, codigo)
			if ExtensaoDAO.Instancia.excluir(codigo) > 0 then
				i = 0
				while i < listaExtensao.Count
					extensao = listaExtensao[i]
					if extensao.Codigo == codigo then
						listaExtensao.Remove(extensao)
						break
					end
					i += 1
				end
				return true
			else
				return false
			end
		end

		def excluirTodasExtensoes(listaExtensao)
			if ExtensaoDAO.Instancia.excluirTudo() > 0 then
				listaExtensao.Clear()
				return true
			else
				return false
			end
		end

		def criarTabelaExtensoes()
			return (ExtensaoDAO.Instancia.criarTabela() > 0)
		end

		def indiceExtensao(lista, nomeExtensao)
			nomeExtensao = Rotinas.SubString(nomeExtensao, Rotinas.LastDelimiter(".", nomeExtensao) + 1, nomeExtensao.Length)
			enumerator = lista.GetEnumerator()
			while enumerator.MoveNext()
				extensao = enumerator.Current
				if extensao.Nome.Trim().ToLower().Equals(nomeExtensao.Trim().ToLower()) then
					return (extensao.Ordem + 2)
				end
			end
			return -1
		end

		def pegaExtensaoPorOrdem(lista, ordem)
			enumerator = lista.GetEnumerator()
			while enumerator.MoveNext()
				extensao = enumerator.Current
				if extensao.Ordem == ordem then
					return extensao
				end
			end
			return nil
		end

		def pegaExtensaoPorCodigo(lista, codigo)
			enumerator = lista.GetEnumerator()
			while enumerator.MoveNext()
				extensao = enumerator.Current
				if extensao.Codigo == codigo then
					return extensao
				end
			end
			return nil
		end

		def pegaExtensaoPorNome(lista, nome, tipo)
			ext = nil
			if tipo.Equals("Diretório") then
				ext = Extensao.new()
				ext.Bmp16 = @diretorioBMP
			else
				if lista != nil and lista.Count > 0 then
					enumerator = lista.GetEnumerator()
					while enumerator.MoveNext()
						extensao = enumerator.Current
						if extensao.Nome.ToLower().Equals(nome.ToLower()) then
							return extensao
						end
					end
				end
				if tipo.Equals("Arquivo") then
					ext = Extensao.new()
					ext.Bmp16 = @arquivoBMP
				end
			end
			return ext
		end

		def ExportarExtensao(tipo, listaExtensao)
			if listaExtensao.Count > 0 then
				sCaminho = Rotinas.ExtractFilePath(Application.ExecutablePath) + Rotinas.BARRA_INVERTIDA
				if tipo == TipoExportarExtensao.teBMP then
					sExtensao = "." + Rotinas.EXTENSAO_BMP
				elsif tipo == TipoExportarExtensao.teICO then
					sExtensao = "." + Rotinas.EXTENSAO_ICO
				elsif tipo == TipoExportarExtensao.teGIF then
					sExtensao = "." + Rotinas.EXTENSAO_GIF
				elsif tipo == TipoExportarExtensao.teJPG then
					sExtensao = "." + Rotinas.EXTENSAO_JPEG
				elsif tipo == TipoExportarExtensao.tePNG then
					sExtensao = "." + Rotinas.EXTENSAO_PNG
				elsif tipo == TipoExportarExtensao.teTIF then
					sExtensao = "." + Rotinas.EXTENSAO_TIFF
				else
					sExtensao = ".img"
				end
				enumerator = listaExtensao.GetEnumerator()
				while enumerator.MoveNext()
					extensao = enumerator.Current
					sImg16 = sCaminho + extensao.Nome + "16" + sExtensao
					if Rotinas.FileExists(sImg16) then
						Rotinas.DeleteFile(sImg16)
					end
					sImg32 = sCaminho + extensao.Nome + "32" + sExtensao
					if Rotinas.FileExists(sImg32) then
						Rotinas.DeleteFile(sImg32)
					end
					case tipo
						when TipoExportarExtensao.teBMP
							Rotinas.SaveToFile(extensao.Bmp16, sImg16)
							Rotinas.SaveToFile(extensao.Bmp32, sImg32)
						when TipoExportarExtensao.teICO
							if extensao.Bmp16 != nil then
								Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp16, Rotinas.EXTENSAO_ICO), sImg16)
							end
							if extensao.Bmp32 != nil then
								Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp32, Rotinas.EXTENSAO_ICO), sImg32)
							end
						when TipoExportarExtensao.teGIF
							if extensao.Bmp16 != nil then
								Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp16, Rotinas.EXTENSAO_GIF), sImg16)
							end
							if extensao.Bmp32 != nil then
								Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp32, Rotinas.EXTENSAO_GIF), sImg32)
							end
						when TipoExportarExtensao.teJPG
							if extensao.Bmp16 != nil then
								Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp16, Rotinas.EXTENSAO_JPEG), sImg16)
							end
							if extensao.Bmp32 != nil then
								Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp32, Rotinas.EXTENSAO_JPEG), sImg32)
							end
						when TipoExportarExtensao.tePNG
							if extensao.Bmp16 != nil then
								Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp16, Rotinas.EXTENSAO_PNG), sImg16)
							end
							if extensao.Bmp32 != nil then
								Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp32, Rotinas.EXTENSAO_PNG), sImg32)
							end
						when TipoExportarExtensao.teTIF
							if extensao.Bmp16 != nil then
								Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp16, Rotinas.EXTENSAO_TIFF), sImg16)
							end
							if extensao.Bmp32 != nil then
								Rotinas.SaveToFile(Rotinas.BmpParaImagem(extensao.Bmp32, Rotinas.EXTENSAO_TIFF), sImg32)
							end
					end
				end
				return true
			end
			return false
		end

		def ImportarExtensao(caminho, listaExtensao)
			listaArquivos = StringList.new()
			log = StringList.new()
			if DiretorioBO.Instancia.carregarArquivos(caminho, listaArquivos) then
				enumerator = listaArquivos.GetEnumerator()
				while enumerator.MoveNext()
					sArquivo = enumerator.Current
					self.SalvarExtensao(listaExtensao, Rotinas.ExtractFileName(sArquivo), sArquivo, log)
				end
			end
		end

		def ExtrairExtensao(caminho, listaExtensao)
			listaArquivos = StringList.new()
			log = StringList.new()
			if DiretorioBO.Instancia.carregarTodosArquivos(caminho, listaArquivos) then
				enumerator = listaArquivos.GetEnumerator()
				while enumerator.MoveNext()
					sArquivo = enumerator.Current
					self.SalvarExtensao(listaExtensao, Rotinas.ExtractFileName(sArquivo), sArquivo, log)
				end
			end
		end
	end
end