require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "Gtk, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.IO, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosbo, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosgui, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.catalogador, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.gui
	class FrmImportarDiretorio < Gtk::Window
		def initialize(frmPrincipal)
			self.Build()
			memoImportaDir.CursorVisible = false
			barraStatus1.GetSizeRequest(@nLargura, @nAltura)
			barraStatus1.SetSizeRequest(180, @nAltura)
			LabStatus1.Text = "Total de diferenças encontradas:"
			@frmImportarDiretorioProgresso = FrmImportarDiretorioProgresso.new(self)
			@listaImportar = List[Importar].new()
			self.@frmPrincipal = frmPrincipal
			@catalogador = frmPrincipal.Catalogador
		end

		def PBar
			return self.@pbImportar
		end

		def MemoImportaDir
			return self.@memoImportaDir
		end

		def LabStatus1
			frameStatus1 = barraStatus1.Children[0]
			hboxStatus1 = frameStatus1.Child
			return hboxStatus1.Children[0]
		end

		def LabStatus2
			frameStatus2 = barraStatus2.Children[0]
			hboxStatus2 = frameStatus2.Child
			return hboxStatus2.Children[0]
		end

		def Importar()
			enumerator = self.@listaImportar.GetEnumerator()
			while enumerator.MoveNext()
				importar = enumerator.Current
				@catalogador.diretorioOrdem.Ordem = 1
				if not @bSubDiretorio then
					GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Watch)
					begin
						ImportarBO.Instancia.ImportacaoCompleta(importar, @catalogador.diretorioOrdem, @catalogador.listaExtensoes, @frmImportarDiretorioProgresso)
					rescue Exception => ex
						Dialogo.mensagemErro(ex.Message)
					ensure
					end
					GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Arrow)
				else
					if not DiretorioBO.Instancia.verificaCodDir(importar.Aba, importar.RotuloRaiz, @catalogador.listaDiretorioPai) then
						GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Watch)
						begin
							ImportarBO.Instancia.ImportacaoCompleta(importar, @catalogador.diretorioOrdem, @catalogador.listaExtensoes, @frmImportarDiretorioProgresso)
						rescue Exception => ex
							Dialogo.mensagemErro(ex.Message)
						ensure
						end
						GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Arrow)
					else
						Dialogo.mensagemInfo("O diretório já existe no catálogo!")
					end
				end
			end
			if @frmPrincipal.MenuGravarLogImportacao.Active then
				if memoImportaDir.Buffer.LineCount > 0 then
					sLog = Rotinas.ExtractFilePath(Rotinas.ExecutablePath()) + System.IO.Path.DirectorySeparatorChar + Rotinas.formataDate(Rotinas.FORMATO_DHARQUIVO, DateTime.Now) + "_Importacao.log"
					log = StringList.new()
					nlinha = 0
					while nlinha < memoImportaDir.Buffer.LineCount
						titer = memoImportaDir.Buffer.GetIterAtLine(nlinha)
						log.Add(titer.Buffer.Text)
						nlinha += 1
					end
					log.SaveToFile(sLog)
				end
			end
		end
	end
end