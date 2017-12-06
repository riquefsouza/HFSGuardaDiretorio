require "mscorlib"

			require "mscorlib"

require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.IO, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "Gtk, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.catalogador, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosgui, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosbo, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.gui
	class FrmCadExtensao < Gtk::Dialog
		def initialize(frmPrincipal)
			self.Build()
			@catalogador = frmPrincipal.Catalogador
			self.ConstruirGrid()
			self.CarregarExtensoesNaGrid()
		end

		def ConstruirGrid()
			tabelaExtensao.AppendColumn("Extensão", CellRendererText.new(), "text", 0)
			tabelaExtensao.AppendColumn("Ícone", CellRendererPixbuf.new(), "pixbuf", 1)
			tabelaExtensao.Columns[0].MinWidth = 150
			tabelaExtensao.Columns[1].MinWidth = 100
			lstore = ListStore.new(System::String.to_clr_type, Gdk::Pixbuf.to_clr_type)
			tabelaExtensao.Model = lstore
		end

		def CarregarExtensoesNaGrid()
			lstore = tabelaExtensao.Model
			lstore.Clear()
			enumerator = @catalogador.listaExtensoes.GetEnumerator()
			while enumerator.MoveNext()
				extensao = enumerator.Current
				lstore.AppendValues(extensao.Nome, Rotinas.byteArrayToPixbuf(extensao.Bmp16))
			end
		end

		def OnIncluirExtensaoActionActivated(sender, e)
			if EscolhaArquivo.abrirArquivo(EscolhaArquivo.FILTRO_IMAGEM) then
				arquivo = FileInfo.new(EscolhaArquivo.NomeArquivo)
				if arquivo.Exists then
					log = StringList.new()
					if ExtensaoBO.Instancia.SalvarExtensao(@catalogador.listaExtensoes, arquivo.Name, arquivo.FullName, log) then
						self.CarregarExtensoesNaGrid()
						Dialogo.mensagemInfo("Extensão salva com sucesso!")
					else
						Dialogo.mensagemInfo("Extensão já existe cadastrada!")
					end
				end
			end
		end

		def OnExcluirExtensaoActionActivated(sender, e)
			if @catalogador.listaExtensoes.Count > 0 then
				res = Dialogo.confirma("Tem Certeza, que você deseja excluir esta extensão?")
				if res then
					path = tabelaExtensao.Selection.GetSelectedRows()[0]
					extensao = ExtensaoBO.Instancia.pegaExtensaoPorOrdem(@catalogador.listaExtensoes, path.Indices[0] + 1)
					if ExtensaoBO.Instancia.excluirExtensao(@catalogador.listaExtensoes, extensao.Codigo) then
						self.CarregarExtensoesNaGrid()
						Dialogo.mensagemInfo("Extensão excluída com sucesso!")
					end
				end
			end
		end

		def OnExcluirTodasExtensoesActionActivated(sender, e)
			res = Dialogo.confirma("Tem Certeza, que você deseja excluir todas as extensões?")
			if res then
				if ExtensaoBO.Instancia.excluirTodasExtensoes(@catalogador.listaExtensoes) then
					self.CarregarExtensoesNaGrid()
					Dialogo.mensagemInfo("Extensões excluídas com sucesso!")
				end
			end
		end

		def OnExportarParaTIFFActionActivated(sender, e)
			ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teTIF, @catalogador.listaExtensoes)
		end

		def OnExportarParaPNGActionActivated(sender, e)
			ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.tePNG, @catalogador.listaExtensoes)
		end

		def OnExportarParaJPEGActionActivated(sender, e)
			ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teJPG, @catalogador.listaExtensoes)
		end

		def OnExportarParaGIFActionActivated(sender, e)
			ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teGIF, @catalogador.listaExtensoes)
		end

		def OnExportarParaIConeActionActivated(sender, e)
			ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teICO, @catalogador.listaExtensoes)
		end

		def OnExportarParaBitmapActionActivated(sender, e)
			ExtensaoBO.Instancia.ExportarExtensao(TipoExportarExtensao.teBMP, @catalogador.listaExtensoes)
		end

		def OnImportarIconesDosArquivosActionActivated(sender, e)
			if EscolhaArquivo.abrirArquivo(EscolhaArquivo.FILTRO_IMAGEM) then
				arquivo = FileInfo.new(EscolhaArquivo.NomeArquivo)
				if arquivo.Exists then
					ExtensaoBO.Instancia.ImportarExtensao(arquivo.FullName, @catalogador.listaExtensoes)
					self.CarregarExtensoesNaGrid()
				end
			end
		end

		def OnExtrairIconesDosArquivosActionActivated(sender, e)
			if EscolhaArquivo.abrirArquivo(EscolhaArquivo.FILTRO_IMAGEM) then
				arquivo = FileInfo.new(EscolhaArquivo.NomeArquivo)
				if arquivo.Exists then
					ExtensaoBO.Instancia.ExtrairExtensao(arquivo.FullName, @catalogador.listaExtensoes)
					self.CarregarExtensoesNaGrid()
				end
			end
		end

		def OnBtnIncluirClicked(sender, e)
			self.OnIncluirExtensaoActionActivated(sender, e)
		end

		def OnBtnExcluirClicked(sender, e)
			self.OnExcluirExtensaoActionActivated(sender, e)
		end
	end
end