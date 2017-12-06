# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 07/07/2015
# * Time: 11:02
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.IO, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "Gtk, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosbo, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosdao, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.gui, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosgui, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.catalogador
	# <summary>
	# Description of Catalogador.
	# </summary>
	class Catalogador < ICatalogador #Logger.getLogger(Rotinas.HFSGUARDADIR);
		def initialize(form)
			@CONSULTA_DIR_PAI = "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, " + "atributos, caminho, nomeaba, nomepai, caminhopai " + "from consultadirpai " + "order by 1,2,3,4"
			@CONSULTA_DIR_FILHO = "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, " + "atributos, caminho, nomeaba, nomepai, caminhopai " + "from consultadirfilho " + "order by 1,2,3,4"
			@CONSULTA_ARQUIVO = "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, " + "atributos, caminho, nomeaba, nomepai, caminhopai " + "from consultaarquivo " + "order by tipo desc, ordem"
			@log = ArquivoLog.new()
			self.@form = form
			@diretorioOrdem = DiretorioOrdem.new()
			@listaAbas = List[Aba].new()
			@listaExtensoes = List[Extensao].new()
			@listaDiretorioPai = List[Diretorio].new()
			@listaDiretorioFilho = List[Diretorio].new()
			@listaArquivos = List[Diretorio].new()
			form.SPPesquisa.Child2.Visible = false
			form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Watch)
			frmSplash = FrmSplash.new()
			frmSplashProgresso = FrmSplashProgresso.new(frmSplash)
			frmSplash.Show()
			self.CarregarDados(frmSplashProgresso, true, true)
			self.CarregarAbas()
			self.tabPanelMudou()
			frmSplash.Hide()
			frmSplash.Destroy()
			form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Arrow)
		end

		def Catalogador.iniciarSistema()
			sBanco = Rotinas.ExtractFilePath(Rotinas.ExecutablePath()) + Path.DirectorySeparatorChar + "GuardaDir.db"
			cp = ConexaoParams.new()
			cp.Nome = sBanco
			if not Rotinas.FileExists(sBanco) then
				Rotinas.Conectar(cp)
				AbaBO.Instancia.criarTabelaAbas()
				aba = Aba.new(1, "DISCO1", 0)
				AbaBO.Instancia.incluirAba(aba)
				ExtensaoBO.Instancia.criarTabelaExtensoes()
				DiretorioBO.Instancia.criarTabelaDiretorios()
				VisaoDAO.Instancia.criarVisao("consultadirpai")
				VisaoDAO.Instancia.criarVisao("consultadirfilho")
				VisaoDAO.Instancia.criarVisao("consultaarquivo")
			else
				Rotinas.Conectar(cp)
			end
		end

		def CarregarDados(pLog, bExtensao, bDiretorio)
			@listaAbas = AbaBO.Instancia.carregarAba(pLog)
			if bExtensao then
				@listaExtensoes = ExtensaoBO.Instancia.carregarExtensao(pLog)
			end
			if bDiretorio then
				@listaDiretorioPai = DiretorioBO.Instancia.carregarDiretorio(@CONSULTA_DIR_PAI, "consultadirpai", pLog)
				@listaDiretorioFilho = DiretorioBO.Instancia.carregarDiretorio(@CONSULTA_DIR_FILHO, "consultadirfilho", pLog)
				@listaArquivos = DiretorioBO.Instancia.carregarDiretorio(@CONSULTA_ARQUIVO, "consultaarquivo", pLog)
			end
		end

		def ExcluirDados(aba, sCaminho)
			DiretorioBO.Instancia.excluirListaDiretorio(@listaDiretorioPai, aba, sCaminho)
			DiretorioBO.Instancia.excluirListaDiretorio(@listaDiretorioFilho, aba, sCaminho)
			DiretorioBO.Instancia.excluirListaDiretorio(@listaArquivos, aba, sCaminho)
		end

		def AddItemArvore(storeArvore, diretorio, Nivel, node1)
			if Nivel == 0 then
				node1 = storeArvore.AppendValues(ExtensaoBO.Instancia.DiretorioGIF, diretorio.Nome)
			end
			listaFilhos = DiretorioBO.Instancia.itensFilhos(@listaDiretorioFilho, diretorio.Aba.Codigo, diretorio.Ordem, diretorio.Codigo)
			enumerator = listaFilhos.GetEnumerator()
			while enumerator.MoveNext()
				filho = enumerator.Current
				node2 = storeArvore.AppendValues(node1, ExtensaoBO.Instancia.DiretorioGIF, filho.Nome)
				self.AddItemArvore(storeArvore, filho, Nivel += 1, node2)
			end
		end

		def IncluirNovaAba()
			sAba = Dialogo.entrada("Digite o Nome da Nova Aba?")
			if (sAba != nil) and (sAba.Trim().Length > 0) then
				aba = Aba.new()
				aba.Codigo = AbaBO.Instancia.retMaxCodAba(@listaAbas)
				aba.Nome = Rotinas.SubString(sAba, 1, 10)
				aba.Ordem = @listaAbas.Count + 1
				AbaBO.Instancia.incluirAba(aba)
				self.IncluirNovaAba(aba.Nome)
				@listaAbas.Add(aba)
			end
		end

		def AlterarNomeAbaAtiva(pLog)
			aba = self.getAbaAtual()
			sAba = Dialogo.entrada("Digite o Novo Nome da Aba Ativa?", aba.Nome)
			if (sAba != nil) and (sAba.Trim().Length > 0) then
				aba.Nome = Rotinas.SubString(sAba, 1, 10)
				AbaBO.Instancia.alterarAba(aba)
				@form.tabControl1.SetTabLabelText(@form.tabControl1.GetNthPage(@form.tabControl1.Page), sAba)
				self.CarregarDados(pLog, false, true)
			end
		end

		def ExcluirAbaAtiva(pLog)
			indiceSel = @form.tabControl1.Page
			if indiceSel > 0 then
				res = Dialogo.confirma("Tem Certeza, que você deseja excluir esta aba, \n" + "isto implicará na destruição de todos os seus itens catalogados?")
				if res then
					@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Watch)
					aba = self.getAbaAtual()
					self.ExcluirDados(aba, "")
					AbaBO.Instancia.excluirAba(aba)
					@form.tabControl1.RemovePage(indiceSel)
					self.CarregarDados(pLog, false, false)
					@form.LabStatus2.Text = ""
					@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Arrow)
				end
			else
				Dialogo.mensagemErro("A primeira Aba não pode ser excluída!")
			end
		end

		def IncluirNovaAba(nomeAba)
			spPanel = HPaned.new()
			spPanel.CanFocus = true
			spPanel.Name = "spPanel" + nomeAba
			spPanel.Position = 250
			scrollArvore = ScrolledWindow.new()
			scrollArvore.Name = "scrollArvore" + nomeAba
			scrollArvore.ShadowType = ((1))
			arvore = TreeView.new()
			arvore.CanFocus = true
			arvore.Name = "arvore" + nomeAba
			arvore.Selection.Changed { @form.OnArvoreFixaSelectionChanged() }
			arvore.RowExpanded { @form.OnArvoreFixaRowExpanded() }
			arvore.RowCollapsed { @form.OnArvoreFixaRowCollapsed() }
			arvore.ButtonReleaseEvent { @form.OnArvoreFixaButtonReleaseEvent() }
			Arvore.Instancia.Construir(arvore)
			scrollArvore.Add(arvore)
			spPanel.Add(scrollArvore)
			w9 = ((spPanel[scrollArvore]))
			w9.Resize = false
			scrollTabela = ScrolledWindow.new()
			scrollTabela.Name = "scrollTabela" + nomeAba
			scrollTabela.ShadowType = ((1))
			tabela = NodeView.new()
			tabela.CanFocus = true
			tabela.Name = "tabela" + nomeAba
			tabela.ButtonReleaseEvent { @form.OnTabelaFixaButtonReleaseEvent() }
			tabela.RowActivated { @form.OnTabelaFixaRowActivated() }
			Tabela.Instancia.Construir(true, tabela)
			scrollTabela.Add(tabela)
			spPanel.Add(scrollTabela)
			@form.adicionaTabPage(@form.tabControl1, spPanel, nomeAba)
		end

		def getArvoreAtual()
			return self.getArvoreAtual(@form.tabControl1.Page)
		end

		def getArvoreAtual(nIndicePagina)
			tabPage = @form.tabControl1.GetNthPage(nIndicePagina)
			scrollArvore = tabPage.Child1
			arvore = scrollArvore.Child
			return arvore
		end

		def getSplitAtual()
			nIndicePagina = @form.tabControl1.Page
			tabPage = @form.tabControl1.GetNthPage(nIndicePagina)
			return tabPage
		end

		def getTabelaAtual()
			nIndicePagina = @form.tabControl1.Page
			tabPage = @form.tabControl1.GetNthPage(nIndicePagina)
			scrollTabela = tabPage.Child2
			tabela = scrollTabela.Child
			return tabela
		end

		def mostrarOcultarArvore()
			self.getSplitAtual().Child1.Visible = not self.getSplitAtual().Child1.Visible
		end

		def CarregarArvore(tvAba, aba)
			nodeRaiz = TreeIter.new()
			storeArvore = tvAba.Model
			enumerator = listaDiretorioPai.GetEnumerator()
			while enumerator.MoveNext()
				diretorio = enumerator.Current
				if diretorio.Aba.Codigo == aba.Codigo then
					self.AddItemArvore(storeArvore, diretorio, 0, nodeRaiz)
				end
			end
		end

		def CarregarAbas()
			nMaximum = @listaAbas.Count - 1
			@form.PBar.Fraction = 0
			i = 0
			while i < @listaAbas.Count
				if i > 0 then
					self.IncluirNovaAba(@listaAbas[i].Nome)
				end
				tvAba = self.getArvoreAtual(i)
				self.CarregarArvore(tvAba, @listaAbas[i])
				@form.PBar.Fraction = Rotinas.calculaProgresso(nMaximum, i)
				i += 1
			end
		end

		def getAbaAtual()
			return AbaBO.Instancia.pegaAbaPorOrdem(@listaAbas, @form.tabControl1.Page + 1)
		end

		def CarregarArquivosLista(bLista1, lvArquivos, sCaminho)
			listaLocal = List[Diretorio].new()
			storeArquivos = lvArquivos.Model
			storeArquivos.Clear()
			if bLista1 then
				sPaiCaminho = sCaminho
				if not Rotinas.SubString(sCaminho, sCaminho.Length, 1).Equals(Rotinas.BARRA_INVERTIDA) then
					sCaminho = sCaminho + Rotinas.BARRA_INVERTIDA
				end
				nAba = self.getAbaAtual().Codigo
				enumerator = listaArquivos.GetEnumerator()
				while enumerator.MoveNext()
					diretorio = enumerator.Current
					if diretorio.Aba.Codigo == nAba then
						if diretorio.CaminhoPai.Equals(sPaiCaminho) then
							if Rotinas.StartsStr(sCaminho, diretorio.Caminho) then
								listaLocal.Add(diretorio)
							end
						end
					end
				end
			else
				enumerator = listaArquivos.GetEnumerator()
				while enumerator.MoveNext()
					diretorio = enumerator.Current
					if Rotinas.ContainsStr(diretorio.Caminho.ToUpper(), sCaminho.ToUpper()) then
						listaLocal.Add(diretorio)
					end
				end
			end
			Tabela.Instancia.Carregar(bLista1, lvArquivos, listaLocal, @listaExtensoes, @form.PBar)
		end

		def TamTotalDiretorio(sCaminho)
			conta = 0
			soma = 0
			enumerator = listaArquivos.GetEnumerator()
			while enumerator.MoveNext()
				diretorio = enumerator.Current
				nAba = self.getAbaAtual().Codigo
				if diretorio.Aba.Codigo == nAba then
					if diretorio.Tipo.Codigo != 'D' then
						if sCaminho.Trim().Length > 0 then
							if Rotinas.StartsStr(sCaminho, diretorio.Caminho) then
								conta += 1
								tam = diretorio.Tamanho
								soma = soma + tam
							end
						else
							conta += 1
							tam = diretorio.Tamanho
							soma = soma + tam
						end
					end
				end
			end
			@form.LabStatus1.Text = "Quantidade Total: " + Rotinas.FormatLong("0000", conta) + ", Tamanho Total: " + DiretorioBO.Instancia.MontaTamanho(soma)
		end

		def testaSeparadorArquivo(sDir)
			sDir = Rotinas.SubString(sDir, sDir.Length, 1)
			if sDir.Equals(Rotinas.BARRA_INVERTIDA) or sDir.Equals(Rotinas.BARRA_NORMAL) or sDir.Equals(Rotinas.BARRA_INVERTIDA) then
				return true
			else
				return false
			end
		end

		def montaCaminho(sCaminho, bRemover)
			#sCaminho = NO_RAIZ + Rotinas.BARRA_INVERTIDA + sCaminho;
			sl = StringList.new(sCaminho, Rotinas.BARRA_INVERTIDA[0])
			if sl[sl.Count - 1].Trim().Length == 0 then
				sl.RemoveAt(sl.Count - 1)
			end
			if bRemover then
				sl.RemoveAt(sl.Count - 1)
			end
			return sl
		end

		def Pesquisar()
			arvoreLocal = self.getArvoreAtual()
			arvoreStore = arvoreLocal.Model
			tabelaStore = @form.TabelaPesquisa.Model
			iter = TreeIter.new()
			if arvoreStore.IterNChildren() > 0 then
				if @form.EdtPesquisa.Text.Length >= 2 then
					@form.SPPesquisa.Child2.Visible = true
					self.CarregarArquivosLista(false, @form.TabelaPesquisa, @form.EdtPesquisa.Text)
					if tabelaStore.GetIterFirst(iter) then
						@form.TabelaPesquisa.Selection.SelectIter(iter)
					end
				else
					@form.SPPesquisa.Child2.Visible = false
					tabelaStore.Clear()
					Dialogo.mensagemInfo("A pesquisa só é feita com pelo menos 2 caracteres!")
				end
			end
		end

		def PesquisarArvoreDiretorio(sCaminho, aba)
			@form.tabControl1.Page = aba.Ordem - 1
			arvore = self.getArvoreAtual()
			arvoreStore = arvore.Model
			sl = self.montaCaminho(sCaminho, false) # Verifica Diretorio
			path = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
			if path == nil then
				sl.Insert(1, sl[1] + Rotinas.BARRA_INVERTIDA)
				path = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
				if path == nil then
					sl.Clear()
					sl = self.montaCaminho(sCaminho, true) # Verifica Arquivo
					path = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
					if path == nil then
						sl.Insert(1, sl[1] + Rotinas.BARRA_INVERTIDA)
						path = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
					end
				end
			end
			arvore.ExpandToPath(path)
			arvore.Selection.SelectPath(path)
		end

		def LerArvoreDiretorio(arvoreStore, iter, barraStatus)
			sCaminho = arvoreStore.GetValue(iter, 1)
			arvoreStore.IterParent(iterAnterior, iter)
			if arvoreStore.IterIsValid(iterAnterior) then
				while arvoreStore.IterParent(iterAnterior, iterAnterior)
					sValorAnterior = arvoreStore.GetValue(iterAnterior, 1)
					if Rotinas.SubString(sValorAnterior, sValorAnterior.Length, 1) == Rotinas.BARRA_INVERTIDA then
						sSep = ""
					else
						sSep = Rotinas.BARRA_INVERTIDA
					end
					sCaminho = sValorAnterior + sSep + sCaminho
				end
			end
			@form.LabStatus2.Text = sCaminho
		end

		def ListarArquivos(lvTabela, arvore, iter)
			arvoreStore = arvore.Model
			if arvore.Selection.IterIsSelected(iter) then
				self.LerArvoreDiretorio(arvoreStore, iter, @form.LabStatus2)
				self.CarregarArquivosLista(true, lvTabela, @form.LabStatus2.Text)
				self.TamTotalDiretorio(@form.LabStatus2.Text)
			end
		end

		def tabPanelMudou()
			arvore = self.getArvoreAtual()
			arvoreStore = arvore.Model
			lvTabela = self.getTabelaAtual()
			if arvoreStore.IterNChildren() > 0 then
				if arvoreStore.GetIterFirst(iter) then
					self.ListarArquivos(lvTabela, arvore, iter)
				end
			end
		end

		def getAbaSelecionada()
			return self.getAbaAtual()
		end

		def DuploCliqueLista(nome, tipo)
			if tipo.Equals("Diretório") then
				@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Watch)
				sCaminho = @form.LabStatus2.Text
				if self.testaSeparadorArquivo(sCaminho) then
					sCaminho += nome
				else
					sCaminho += Rotinas.BARRA_INVERTIDA + nome
				end
				self.PesquisarArvoreDiretorio(sCaminho, self.getAbaAtual())
				@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Arrow)
			end
		end

		def EncontrarItemLista(nomeAba, nome, caminho)
			@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Watch)
			aba = AbaBO.Instancia.pegaAbaPorNome(@listaAbas, nomeAba)
			self.PesquisarArvoreDiretorio(caminho, aba)
			tabela = self.getTabelaAtual()
			path = Tabela.Instancia.encontrarCaminhoPorNome(tabela, nome)
			if path != nil then
				tabela.Selection.SelectPath(path)
			end
			@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Arrow)
		end

		def verificaNomeDiretorio(sCaminho, sRotuloRaiz)
			sRotuloRaiz.Rotulo = DiretorioBO.Instancia.removerDrive(sCaminho)
			if sRotuloRaiz.Rotulo.Length == 0 then
				sRotuloRaiz.Rotulo = Dialogo.entrada("Este diretório não possui um nome.\nDigite o nome do diretório!")
				if (sRotuloRaiz.Rotulo != nil) and (sRotuloRaiz.Rotulo.Trim().Length > 0) then
					sRotuloRaiz.Rotulo = sRotuloRaiz.Rotulo.Trim()
					if sRotuloRaiz.Rotulo.Length > 0 then
						return 1
					else
						Dialogo.mensagemInfo("Nenhum nome de diretório informado!")
						return 0
					end
				else
					return 0
				end
			elsif Rotinas.Pos(Rotinas.BARRA_INVERTIDA, sRotuloRaiz.Rotulo) > 0 then
				sRotuloRaiz.Rotulo = Rotinas.SubString(sRotuloRaiz.Rotulo, Rotinas.LastDelimiter(Rotinas.BARRA_INVERTIDA, sRotuloRaiz.Rotulo) + 1, sRotuloRaiz.Rotulo.Length)
				return 2
			else
				return 3
			end
		end

		def ExportarArquivo(tipo, pLog)
			sExtensao = ""
			case tipo
				when TipoExportar.teTXT
					sExtensao = "txt"
				when TipoExportar.teCSV
					sExtensao = "csv"
				when TipoExportar.teHTML
					sExtensao = "html"
				when TipoExportar.teXML
					sExtensao = "xml"
				when TipoExportar.teSQL
					sExtensao = "sql"
			end
			aba = self.getAbaAtual()
			sDiretorio = Rotinas.ExtractFilePath(Rotinas.ExecutablePath())
			sArquivo = aba.Nome + '.' + sExtensao
			if EscolhaArquivo.salvarArquivo(EscolhaArquivo.FILTRO_EXPORTAR, sDiretorio, sArquivo) then
				arquivo = FileInfo.new(EscolhaArquivo.NomeArquivo)
				if not arquivo.Exists then
					@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Watch)
					DiretorioBO.Instancia.exportarDiretorio(tipo, self.getAbaAtual(), arquivo.FullName, pLog)
					@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Arrow)
					Dialogo.mensagemErro("Exportação realizada com sucesso!")
				end
			end
		end

		def ExcluirDiretorioSelecionado(pLog)
			arvore = self.getArvoreAtual()
			arvoreStore = arvore.Model
			arvore.Selection.GetSelected(iter)
			if arvore.Selection.IterIsSelected(iter) then
				tabela = self.getTabelaAtual()
				tabelaStore = tabela.Model
				res = Dialogo.confirma("Tem Certeza, que você deseja excluir este diretório, isto implicará na destruição de todos os seus items catalogados?")
				if res then
					@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Watch)
					valor = arvoreStore.GetValue(iter, 1)
					DiretorioBO.Instancia.excluirDiretorio(self.getAbaAtual(), valor)
					self.ExcluirDados(self.getAbaAtual(), valor)
					arvoreStore.Remove(iter)
					tabelaStore.Clear()
					self.CarregarDados(pLog, false, false)
					@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Arrow)
				end
			end
		end

		def ImportarArquivo(log, pLog)
			if EscolhaArquivo.abrirArquivo(EscolhaArquivo.FILTRO_XML) then
				arquivo = FileInfo.new(EscolhaArquivo.NomeArquivo)
				if arquivo.Exists then
					@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Watch)
					nResultado = DiretorioBO.Instancia.importarDiretorioViaXML(self.getAbaAtual(), arquivo.FullName, @listaDiretorioPai, pLog)
					if nResultado == -1 then
						Dialogo.mensagemErro("Importação não realizada!")
					elsif nResultado == -2 then
						Dialogo.mensagemErro("Este diretório já existe no catálogo!")
					else
						self.FinalizaImportacao(pLog)
					end
					@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Arrow)
				end
			end
		end

		def ImportarDiretorios(listaCaminho, bSubDiretorio, frmImportarDiretorio)
			sRotuloRaiz = RotuloRaiz.new()
			importar = Importar.new()
			nAba = self.getAbaAtual().Codigo
			nCodDirRaiz = DiretorioBO.Instancia.retMaxCodDir(nAba, @listaDiretorioPai)
			enumerator = listaCaminho.GetEnumerator()
			while enumerator.MoveNext()
				sCaminho = enumerator.Current
				nRotuloRaiz = self.verificaNomeDiretorio(sCaminho, sRotuloRaiz)
				if nRotuloRaiz > 0 then
					importar = Importar.new()
					importar.Aba = nAba
					importar.CodDirRaiz = nCodDirRaiz
					importar.RotuloRaiz = sRotuloRaiz.Rotulo
					if nRotuloRaiz == 1 then
						importar.NomeDirRaiz = sRotuloRaiz.Rotulo
					elsif nRotuloRaiz == 2 then
						sCaminhoSemDrive = DiretorioBO.Instancia.removerDrive(sCaminho)
						importar.NomeDirRaiz = Rotinas.SubString(sCaminhoSemDrive, 1, Rotinas.LastDelimiter(Rotinas.BARRA_INVERTIDA, sCaminhoSemDrive) - 1)
					elsif nRotuloRaiz == 3 then
						importar.NomeDirRaiz = ""
					end
					importar.Caminho = sCaminho
					frmImportarDiretorio.listaImportar.Add(importar)
					nCodDirRaiz += 1
				end
			end
			frmImportarDiretorio.bSubDiretorio = bSubDiretorio
			if bSubDiretorio then
				frmImportarDiretorio.Show()
				frmImportarDiretorio.Importar()
				frmImportarDiretorio.Hide()
				frmImportarDiretorio.Destroy()
				return true
			else
				if not DiretorioBO.Instancia.verificaCodDir(importar.Aba, importar.RotuloRaiz, @listaDiretorioPai) then
					frmImportarDiretorio.Show()
					frmImportarDiretorio.Importar()
					frmImportarDiretorio.Hide()
					frmImportarDiretorio.Destroy()
					return true
				else
					Dialogo.mensagemErro("Este diretório já existe no catálogo!")
					return false
				end
			end
		end

		def FinalizaImportacao(pLog)
			@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Watch)
			self.CarregarDados(pLog, true, true)
			tvAba = self.getArvoreAtual()
			self.CarregarArvore(tvAba, self.getAbaAtual())
			self.tabPanelMudou()
			@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Arrow)
			Dialogo.mensagemInfo("Importação do(s) diretório(s) realizada com sucesso!")
		end

		def ComecaImportacao(bSubDiretorios, pLog)
			if EscolhaArquivo.abrirDiretorio() then
				arquivo = FileInfo.new(EscolhaArquivo.NomeArquivo)
				if arquivo.Directory.Exists then
					@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Watch)
					sCaminho = arquivo.FullName
					frmImportarDiretorio = FrmImportarDiretorio.new(@form)
					listaCaminho = StringList.new()
					if bSubDiretorios then
						DiretorioBO.Instancia.carregarSubDiretorios(sCaminho, listaCaminho)
					else
						listaCaminho.Add(sCaminho)
					end
					if self.ImportarDiretorios(listaCaminho, bSubDiretorios, frmImportarDiretorio) then
						self.FinalizaImportacao(pLog)
					end
					@form.GdkWindow.Cursor = Gdk.Cursor.new(Gdk.CursorType.Arrow)
				end
			end
		end

		def InformacoesDiretorioArquivo()
			tabela = self.getTabelaAtual()
			tabela.Selection.GetSelected(iter)
			if tabela.Selection.IterIsSelected(iter) then
				frmInfo = FrmInfoDiretorio.new()
				aba = self.getAbaSelecionada()
				dir = Tabela.Instancia.getLinhaSelecionada(tabela, false)
				dir.Aba.Nome = aba.Nome
				frmInfo.setDiretorio(dir)
				frmInfo.Show()
			end
		end
	end
end