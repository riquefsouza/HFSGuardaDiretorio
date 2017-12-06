require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "Gtk, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.catalogador, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosgui, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosbo, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.gui
	class FrmPrincipal < Gtk::Window
		def initialize()
			self.Build()
			self.ConstruirPopupMenu()
			notebook1.RemovePage(0)
			self.adicionaTabPage(notebook1, sp, "DISCO1")
			spPesquisa.Position = 250
			sp.Position = 250
			barraStatus1.GetSizeRequest(@nLargura, @nAltura)
			barraStatus1.SetSizeRequest(300, @nAltura)
			Arvore.Instancia.Construir(arvoreFixa)
			arvoreFixa.Selection.Changed { |o, args| self.OnArvoreFixaSelectionChanged(o, args) }
			Tabela.Instancia.Construir(true, tabelaFixa)
			Tabela.Instancia.Construir(false, tabelaPesquisa)
			@frmPrincipalProgresso = FrmPrincipalProgresso.new(self)
			@catalogador = Catalogador.new(self)
			Arvore.Instancia.selecionarPrimeiroItem(arvoreFixa)
		end

		def Catalogador
			return @catalogador
		end

		def SPPesquisa
			return self.@spPesquisa
		end

		def tabControl1
			return self.@notebook1
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

		def PBar
			return self.@pb
		end

		def EdtPesquisa
			return self.@edtPesquisa
		end

		def TabelaPesquisa
			return self.@tabelaPesquisa
		end

		def MenuGravarLogImportacao
			return self.@GravarLogDaImportacaoAction
		end

		def ArvoreFixa
			return self.@arvoreFixa
		end

		def adicionaTabPage(noteBook, spPanel, nomeAba)
			noteBook.Add(spPanel)
			tabAba = HBox.new()
			imgAba = Gtk.Image.new(ExtensaoBO.Instancia.CDOuroGIF)
			labAba = Label.new()
			labAba.Name = "labAba" + nomeAba
			labAba.LabelProp = nomeAba
			tabAba.Add(imgAba)
			tabAba.Add(labAba)
			noteBook.SetTabLabel(spPanel, tabAba)
			tabAba.ShowAll()
			noteBook.ShowAll()
		end

		def ConstruirPopupMenu()
			@popupMenu = Menu.new()
			menuInformacoesDiretorioArquivo = MenuItem.new("Informações do Diretório / Arquivo")
			menuInformacoesDiretorioArquivo.Activated { |sender, e| self.OnInformacoesDiretorioArquivoActivated(sender, e) }
			menuInformacoesDiretorioArquivo.Show()
			@popupMenu.Append(menuInformacoesDiretorioArquivo)
			menuExcluirDiretorioSelecionado = MenuItem.new("Excluir Diretório Selecionado")
			menuExcluirDiretorioSelecionado.Activated { |sender, e| self.OnExcluirDiretorioSelecionadoActivated(sender, e) }
			menuExcluirDiretorioSelecionado.Show()
			@popupMenu.Append(menuExcluirDiretorioSelecionado)
			menuExpandirDiretorios2 = MenuItem.new("Expandir Diretórios")
			menuExpandirDiretorios2.Activated { |sender, e| self.OnExpandirDiretorios2Activated(sender, e) }
			menuExpandirDiretorios2.Show()
			@popupMenu.Append(menuExpandirDiretorios2)
			menuColapsarDiretorios2 = MenuItem.new("Colapsar Diretórios")
			menuColapsarDiretorios2.Activated { |sender, e| self.OnColapsarDiretorios2Activated(sender, e) }
			menuColapsarDiretorios2.Show()
			@popupMenu.Append(menuColapsarDiretorios2)
			separador2 = SeparatorMenuItem.new()
			separador2.Show()
			@popupMenu.Append(separador2)
			menuIncluirNovaAba2 = MenuItem.new("Incluir nova aba")
			menuIncluirNovaAba2.Activated { |sender, e| self.OnIncluirNovaAba2Activated(sender, e) }
			menuIncluirNovaAba2.Show()
			@popupMenu.Append(menuIncluirNovaAba2)
			menuAlterarNomeAbaAtiva2 = MenuItem.new("Alterar nome da aba ativa")
			menuAlterarNomeAbaAtiva2.Activated { |sender, e| self.OnAlterarNomeAbaAtiva2Activated(sender, e) }
			menuAlterarNomeAbaAtiva2.Show()
			@popupMenu.Append(menuAlterarNomeAbaAtiva2)
			menuExcluirAbaAtiva2 = MenuItem.new("Excluir aba ativa")
			menuExcluirAbaAtiva2.Activated { |sender, e| self.OnExcluirAbaAtiva2Activated(sender, e) }
			menuExcluirAbaAtiva2.Show()
			@popupMenu.Append(menuExcluirAbaAtiva2)
		end

		def OnDeleteEvent(sender, a)
			Rotinas.Desconectar()
			Application.Quit()
			a.RetVal = true
		end

		def OnSobreOCatalogadorActionActivated(sender, e)
			frmSobre = FrmSobre.new()
			frmSobre.Show()
		end

		def OnCadastrarExtensaoDeArquivoActionActivated(sender, e)
			frmCadExtensao = FrmCadExtensao.new(self)
			frmCadExtensao.Show()
		end

		def OnCompararDiretoriosActionActivated(sender, e)
			frmCompararDiretorio = FrmCompararDiretorio.new(self)
			frmCompararDiretorio.Show()
		end

		def OnMostrarOcultarListaItensPesquisadosActionActivated(sender, e)
			spPesquisa.Child2.Visible = not spPesquisa.Child2.Visible
		end

		def OnMostrarOcultarArvoreDirAbaAtivaActionActivated(sender, e)
			@catalogador.mostrarOcultarArvore()
		end

		def OnImportarDiretorioActionActivated(sender, e)
			@catalogador.ComecaImportacao(false, @frmPrincipalProgresso)
		end

		def OnIncluirNovaAbaActionActivated(sender, e)
			@catalogador.IncluirNovaAba()
		end

		def OnImportarDiretoriosViaXMLActionActivated(sender, e)
			log = StringList.new()
			@catalogador.ImportarArquivo(log, @frmPrincipalProgresso)
		end

		def OnSQLActionActivated(sender, e)
			@catalogador.ExportarArquivo(TipoExportar.teSQL, @frmPrincipalProgresso)
		end

		def OnXMLActionActivated(sender, e)
			@catalogador.ExportarArquivo(TipoExportar.teXML, @frmPrincipalProgresso)
		end

		def OnHTMLActionActivated(sender, e)
			@catalogador.ExportarArquivo(TipoExportar.teHTML, @frmPrincipalProgresso)
		end

		def OnCSVActionActivated(sender, e)
			@catalogador.ExportarArquivo(TipoExportar.teCSV, @frmPrincipalProgresso)
		end

		def OnTXTAction1Activated(sender, e)
			@catalogador.ExportarArquivo(TipoExportar.teTXT, @frmPrincipalProgresso)
		end

		def OnColapsarDiretoriosActionActivated(sender, e)
			@catalogador.getArvoreAtual().CollapseAll()
		end

		def OnExpandirDiretoriosActionActivated(sender, e)
			@catalogador.getArvoreAtual().ExpandAll()
		end

		def OnImportarSubDiretoriosActionActivated(sender, e)
			@catalogador.ComecaImportacao(true, @frmPrincipalProgresso)
		end

		def OnExcluirAbaAtivaActionActivated(sender, e)
			@catalogador.ExcluirAbaAtiva(@frmPrincipalProgresso)
		end

		def OnAlterarNomeDaAbaAtivaActionActivated(sender, e)
			@catalogador.AlterarNomeAbaAtiva(@frmPrincipalProgresso)
		end

		def OnInformacoesDiretorioArquivoActivated(sender, e)
			@catalogador.InformacoesDiretorioArquivo()
		end

		def OnExcluirDiretorioSelecionadoActivated(sender, e)
			@catalogador.ExcluirDiretorioSelecionado(@frmPrincipalProgresso)
		end

		def OnExpandirDiretorios2Activated(sender, e)
			self.OnExpandirDiretoriosActionActivated(sender, e)
		end

		def OnColapsarDiretorios2Activated(sender, e)
			self.OnColapsarDiretoriosActionActivated(sender, e)
		end

		def OnIncluirNovaAba2Activated(sender, e)
			self.OnIncluirNovaAbaActionActivated(sender, e)
		end

		def OnAlterarNomeAbaAtiva2Activated(sender, e)
			self.OnAlterarNomeDaAbaAtivaActionActivated(sender, e)
		end

		def OnExcluirAbaAtiva2Activated(sender, e)
			self.OnExcluirAbaAtivaActionActivated(sender, e)
		end

		def OnBtnImportarDiretorioClicked(sender, e)
			self.OnImportarDiretorioActionActivated(sender, e)
		end

		def OnBtnPesquisaClicked(sender, e)
			@catalogador.Pesquisar()
		end

		def OnNotebook1SelectPage(o, args)
			@catalogador.tabPanelMudou()
		end

		def OnTabelaFixaButtonReleaseEvent(o, args)
			if args.Event.Button == 3 then
				@popupMenu.Popup(nil, nil, nil, args.Event.Button, Global.CurrentEventTime)
			end
		end

		#if (args.Event.Button == 1) {
		#if (((Gdk.EventButton)args.Event).Type == Gdk.EventType.TwoButtonPress) {
		#}
		def OnArvoreFixaButtonReleaseEvent(o, args)
			if args.Event.Button == 3 then
				@popupMenu.Popup(nil, nil, nil, args.Event.Button, Global.CurrentEventTime)
			end
		end

		def OnTabelaPesquisaButtonReleaseEvent(o, args)
			if args.Event.Button == 1 then
				lvPesquisa = o
				lvPesquisa.Selection.GetSelected(iter)
				if lvPesquisa.Selection.IterIsSelected(iter) then
					storePesquisa = lvPesquisa.Model
					nome = storePesquisa.GetValue(iter, 1).ToString()
					caminho = storePesquisa.GetValue(iter, 6).ToString()
					nomeAba = storePesquisa.GetValue(iter, 7).ToString()
					@catalogador.EncontrarItemLista(nomeAba, nome, caminho)
				end
			end
		end

		def OnTabelaFixaRowActivated(o, args)
			lvTabela = o
			lvTabela.Selection.GetSelected(modelo, iter)
			if lvTabela.Selection.IterIsSelected(iter) then
				#ListStore modelo = (ListStore)lvTabela.Model;
				nome = modelo.GetValue(iter, 1).ToString()
				tipo = modelo.GetValue(iter, 3).ToString()
				@catalogador.DuploCliqueLista(nome, tipo)
			end
		end

		def OnArvoreFixaSelectionChanged(o, args)
			selecao = o
			if selecao.GetSelected(iter) then
				lvTabela = @catalogador.getTabelaAtual()
				arvore = @catalogador.getArvoreAtual()
				@catalogador.ListarArquivos(lvTabela, arvore, iter)
			end
		end

		def OnArvoreFixaRowExpanded(o, args)
			arvore = o
			store = arvore.Model
			store.SetValue(args.Iter, 0, ExtensaoBO.Instancia.DirAbertoGIF)
		end

		def OnArvoreFixaRowCollapsed(o, args)
			arvore = o
			store = arvore.Model
			store.SetValue(args.Iter, 0, ExtensaoBO.Instancia.DiretorioGIF)
		end
	end
end