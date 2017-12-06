require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "Gtk, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio
	class EscolhaArquivo
		def initialize()
			@FILTRO_TODOS_DIRETORIOS = "Todos os Diretórios (*.*)|*.*"
			@FILTRO_TODOS_ARQUIVOS = "Todos os Arquivos (*.*)|*.*"
			@FILTRO_XML = "Arquivo XML (*.xml)|*.xml"
			@FILTRO_EXPORTAR = "Arquivo TXT (*.txt)|*.txt|Arquivo CSV (*.csv)|*.csv|Arquivo HTML (*.html)|*.html|Arquivo XML (*.xml)|*.xml|Arquivo SQL (*.sql)|*.sql"
			@FILTRO_IMAGEM = "Arquivo BMP (*.bmp)|*.bmp|Arquivo ICO (*.ico)|*.ico|Arquivo GIF (*.gif)|*.gif|Arquivo JPEG (*.png)|*.png|Arquivo PNG (*.jpg)|*.jpg|Arquivo TIFF (*.tif)|*.tif"
			@nomeArquivo = ""
			@diretorioCorrente = ""
		end

		def NomeArquivo
			return @nomeArquivo
		end

		def DiretorioCorrente
			return @diretorioCorrente
		end

		def EscolhaArquivo.montaFiltro(fcdialog, filtro)
			sl = StringList.new(filtro, '|')
			ffiltro = nil
			bAdiciona = true
			enumerator = sl.GetEnumerator()
			while enumerator.MoveNext()
				item = enumerator.Current
				if bAdiciona then
					ffiltro = FileFilter.new()
					ffiltro.Name = item
					bAdiciona = false
				else
					ffiltro.AddPattern(item)
					fcdialog.AddFilter(ffiltro)
					bAdiciona = true
				end
			end
		end

		def EscolhaArquivo.escolher(filtro, titulo, acao, textoAcao)
			fcdialog = FileChooserDialog.new(titulo, nil, acao, "Cancelar", ResponseType.Cancel, textoAcao, ResponseType.Accept)
			fcdialog.SetPosition(WindowPosition.Center)
			EscolhaArquivo.montaFiltro(fcdialog, filtro)
			fcdialog.SelectMultiple = false
			fcdialog.SetFilename(@nomeArquivo)
			fcdialog.SetCurrentFolder(@diretorioCorrente)
			retorno = fcdialog.Run()
			@nomeArquivo = fcdialog.Filename
			@diretorioCorrente = fcdialog.CurrentFolder
			fcdialog.Destroy()
			return (retorno == ResponseType.Accept)
		end

		def EscolhaArquivo.abrirArquivo(filtro, diretorio, arquivo)
			@diretorioCorrente = diretorio
			@nomeArquivo = arquivo
			return EscolhaArquivo.escolher(filtro, "Abrir Arquivo", FileChooserAction.Open, "Abrir")
		end

		def EscolhaArquivo.abrirArquivo(filtro)
			return EscolhaArquivo.abrirArquivo(filtro, "", "")
		end

		def EscolhaArquivo.salvarArquivo(filtro, diretorio, arquivo)
			@diretorioCorrente = diretorio
			@nomeArquivo = arquivo
			return EscolhaArquivo.escolher(filtro, "Salvar Arquivo", FileChooserAction.Save, "Salvar")
		end

		def EscolhaArquivo.salvarArquivo(filtro)
			return EscolhaArquivo.salvarArquivo(filtro, "", "")
		end

		def EscolhaArquivo.abrirDiretorio(diretorio)
			@diretorioCorrente = diretorio
			@nomeArquivo = ""
			return EscolhaArquivo.escolher(@FILTRO_TODOS_DIRETORIOS, "Selecionar Diretório", FileChooserAction.SelectFolder, "Selecionar")
		end

		def EscolhaArquivo.abrirDiretorio()
			return EscolhaArquivo.abrirDiretorio("")
		end
	end
end