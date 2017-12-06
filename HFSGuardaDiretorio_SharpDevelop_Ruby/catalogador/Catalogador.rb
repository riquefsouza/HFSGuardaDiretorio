
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.IO, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
#require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
#require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
#require "HFSGuardaDiretorio.objetosbo, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
#require "HFSGuardaDiretorio.objetosdao, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
#require "HFSGuardaDiretorio.gui, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
#require "HFSGuardaDiretorio.objetosgui, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

Dir['./**/*.rb'].each{ |f| require f }

module HFSGuardaDiretorio_catalogador

	class Catalogador < ICatalogador
		def initialize(frmPrincipal)
			@CONSULTA_DIR_PAI = "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, atributos, caminho, nomeaba, nomepai, caminhopai from consultadirpai order by 1,2,3,4"
			@CONSULTA_DIR_FILHO = "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, atributos, caminho, nomeaba, nomepai, caminhopai from consultadirfilho order by 1,2,3,4"
			@CONSULTA_ARQUIVO = "select aba, cod, ordem, coddirpai, nome, tam, tipo, modificado, atributos, caminho, nomeaba, nomepai, caminhopai from consultaarquivo order by tipo desc, ordem"
			@NO_RAIZ = "Raiz"
			@log = ArquivoLog.new()
			@form = frmPrincipal
			@diretorioOrdem = DiretorioOrdem.new()
			@listaAbas = List[Aba].new()
			@listaExtensoes = List[Extensao].new()
			@listaDiretorioPai = List[Diretorio].new()
			@listaDiretorioFilho = List[Diretorio].new()
			@listaArquivos = List[Diretorio].new()
			form.spPesquisa.Panel2Collapsed = true
			form.Cursor = Cursors.WaitCursor
			frmSplash = FrmSplash.new()
			frmSplashProgresso = FrmSplashProgresso.new(frmSplash)
			frmSplash.Show()
			frmSplash.Update()
			self.CarregarDados(frmSplashProgresso, true, true)
			self.CarregarAbas()
			self.tabPanelMudou()
			frmSplash.Close()
			frmSplash.Dispose()
			form.Cursor = Cursors.Default
		end

		def Catalogador.iniciarSistema()
			sBanco = Rotinas.ExtractFilePath(Application.ExecutablePath) + Path.DirectorySeparatorChar + "GuardaDir.db"
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
				ExtensaoBO.Instancia.carregarExtensoes(@listaExtensoes, @form.imageList1, @form.imageList2)
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

		def AddItemArvore(tv, diretorio, Nivel, node1)
			if Nivel == 0 then
				node1 = tv.Nodes.Add(diretorio.Nome)
			end
			listaFilhos = DiretorioBO.Instancia.itensFilhos(@listaDiretorioFilho, diretorio.Aba.Codigo, diretorio.Ordem, diretorio.Codigo)
			enumerator = listaFilhos.GetEnumerator()
			while enumerator.MoveNext()
				filho = enumerator.Current
				node2 = node1.Nodes.Add(filho.Nome)
				self.AddItemArvore(tv, filho, Nivel += 1, node2)
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
				@form.tabControl1.SelectedTab.Text = sAba
				self.CarregarDados(pLog, false, true)
			end
		end

		def ExcluirAbaAtiva(pLog)
			indiceSel = @form.tabControl1.SelectedIndex
			if indiceSel > 0 then
				res = Dialogo.confirma("Tem Certeza, que você deseja excluir esta aba, \n" + "isto implicará na destruição de todos os seus itens catalogados?")
				if res then
					@form.Cursor = Cursors.WaitCursor
					aba = self.getAbaAtual()
					self.ExcluirDados(aba, "")
					AbaBO.Instancia.excluirAba(aba)
					@form.tabControl1.Controls.RemoveAt(indiceSel)
					self.CarregarDados(pLog, false, false)
					@form.barraStatus.Items[1].Text = ""
					@form.Cursor = Cursors.Default
				end
			else
				Dialogo.mensagemErro("A primeira Aba não pode ser excluída!")
			end
		end

		def IncluirNovaAba(nomeAba)
			tabPage1 = TabPage.new()
			sp = SplitContainer.new()
			arvore = TreeView.new()
			tabela = ListView.new()
			columnHeader10 = ColumnHeader.new()
			columnHeader11 = ColumnHeader.new()
			columnHeader12 = ColumnHeader.new()
			columnHeader13 = ColumnHeader.new()
			columnHeader14 = ColumnHeader.new()
			columnHeader15 = ColumnHeader.new()
			# 
			# tabPage1
			# 
			tabPage1.Controls.Add(sp)
			tabPage1.ImageIndex = 0
			tabPage1.Location = Point.new(4, 23)
			tabPage1.Name = "tabPage" + nomeAba
			tabPage1.Padding = Padding.new(3)
			tabPage1.Size = Size.new(876, 267)
			tabPage1.TabIndex = 0
			tabPage1.Text = nomeAba
			tabPage1.UseVisualStyleBackColor = true
			# 
			# sp
			# 
			sp.Dock = DockStyle.Fill
			sp.Location = Point.new(3, 3)
			sp.Name = "sp" + nomeAba
			# 
			# sp.Panel1
			# 
			sp.Panel1.Controls.Add(arvore)
			# 
			# sp.Panel2
			# 
			sp.Panel2.Controls.Add(tabela)
			sp.Size = Size.new(870, 261)
			sp.SplitterDistance = 290
			sp.TabIndex = 0
			# 
			# arvore
			# 
			arvore.Dock = DockStyle.Fill
			arvore.ImageIndex = 0
			arvore.ImageList = @form.imageList1
			arvore.Location = Point.new(0, 0)
			arvore.Name = "arvore" + nomeAba
			arvore.SelectedImageIndex = 1
			arvore.Size = Size.new(290, 261)
			arvore.TabIndex = 0
			arvore.AfterSelect { @form.TvFixaAfterSelect() }
			# 
			# tabela
			# 
			tabela.Columns.AddRange(Array[ColumnHeader].new([columnHeader10, columnHeader11, columnHeader12, columnHeader13, columnHeader14, columnHeader15]))
			tabela.Dock = DockStyle.Fill
			tabela.FullRowSelect = true
			tabela.GridLines = true
			tabela.LargeImageList = @form.imageList2
			tabela.Location = Point.new(0, 0)
			tabela.MultiSelect = false
			tabela.Name = "tabela" + nomeAba
			tabela.Size = Size.new(576, 261)
			tabela.SmallImageList = @form.imageList1
			tabela.TabIndex = 1
			tabela.UseCompatibleStateImageBehavior = false
			tabela.View = View.Details
			tabela.ColumnClick { @form.LvFixaColumnClick() }
			tabela.DoubleClick { @form.LvFixaDoubleClick() }
			# 
			# columnHeader10
			# 
			columnHeader10.Text = "Nome"
			columnHeader10.Width = 300
			# 
			# columnHeader11
			# 
			columnHeader11.Text = "Tamanho"
			columnHeader11.Width = 100
			# 
			# columnHeader12
			# 
			columnHeader12.Text = "Tipo"
			columnHeader12.Width = 70
			# 
			# columnHeader13
			# 
			columnHeader13.Text = "Modificado"
			columnHeader13.Width = 120
			# 
			# columnHeader14
			# 
			columnHeader14.Text = "Atributos"
			columnHeader14.Width = 90
			# 
			# columnHeader15
			# 
			columnHeader15.Text = "Caminho"
			columnHeader15.Width = 300
			@form.tabControl1.Controls.Add(tabPage1)
		end

		def getArvoreAtual()
			return self.getArvoreAtual(@form.tabControl1.SelectedIndex)
		end

		def getArvoreAtual(nIndicePagina)
			tabPage = @form.tabControl1.TabPages[nIndicePagina]
			split = tabPage.Controls[0]
			arvore = split.Panel1.Controls[0]
			return arvore
		end

		def getSplitAtual()
			tabPage = @form.tabControl1.SelectedTab
			split = tabPage.Controls[0]
			return split
		end

		def getTabelaAtual()
			tabPage = @form.tabControl1.SelectedTab
			split = tabPage.Controls[0]
			tabela = split.Panel2.Controls[0]
			return tabela
		end

		def mostrarOcultarArvore()
			self.getSplitAtual().Panel1Collapsed = not self.getSplitAtual().Panel1Collapsed
		end

		def CarregarArvore(tvAba, aba)
			tvAba.BeginUpdate()
			@nodeRaiz = TreeNode.new(@NO_RAIZ)
			enumerator = listaDiretorioPai.GetEnumerator()
			while enumerator.MoveNext()
				diretorio = enumerator.Current
				if diretorio.Aba.Codigo == aba.Codigo then
					self.AddItemArvore(tvAba, diretorio, 0, @nodeRaiz)
				end
			end
			tvAba.EndUpdate()
		end

		def CarregarAbas()
			@form.pb.Minimum = 0
			@form.pb.Maximum = @listaAbas.Count - 1
			@form.pb.Value = 0
			i = 0
			while i < @listaAbas.Count
				if i > 0 then
					self.IncluirNovaAba(@listaAbas[i].Nome)
				end
				tvAba = self.getArvoreAtual(i)
				self.CarregarArvore(tvAba, @listaAbas[i])
				@form.pb.Value = i
				i += 1
			end
		end

		def getAbaAtual()
			return AbaBO.Instancia.pegaAbaPorOrdem(@listaAbas, @form.tabControl1.SelectedIndex + 1)
		end

		def CarregarArquivosLista(bLista1, lvArquivos, sCaminho)
			listaLocal = List[Diretorio].new()
			lvArquivos.Items.Clear()
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
			Tabela.Instancia.Carregar(bLista1, lvArquivos, listaLocal, @listaExtensoes, @form.pb.ProgressBar)
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
			@form.barraStatus.Items[0].Text = "Quantidade Total: " + Rotinas.FormatLong("0000", conta) + ", Tamanho Total: " + DiretorioBO.Instancia.MontaTamanho(soma)
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
			if arvoreLocal.VisibleCount > 0 then
				if @form.edtPesquisa.Text.Length >= 2 then
					@form.spPesquisa.Panel2Collapsed = false
					self.CarregarArquivosLista(false, @form.lvPesquisa, @form.edtPesquisa.Text)
					@form.lvPesquisa.Items[0].Selected = true
				else
					@form.spPesquisa.Panel2Collapsed = true
					@form.lvPesquisa.Clear()
					Dialogo.mensagemInfo("A pesquisa só é feita com pelo menos 2 caracteres!")
				end
			end
		end

		def PesquisarArvoreDiretorio(sCaminho, aba)
			@form.tabControl1.SelectedIndex = aba.Ordem - 1
			arvore = self.getArvoreAtual()
			sl = self.montaCaminho(sCaminho, false) # Verifica Diretorio
			node = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
			if node == nil then
				sl.Insert(1, sl[1] + Rotinas.BARRA_INVERTIDA)
				node = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
				if node == nil then
					sl.Clear()
					sl = self.montaCaminho(sCaminho, true) # Verifica Arquivo
					node = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
					if node == nil then
						sl.Insert(1, sl[1] + Rotinas.BARRA_INVERTIDA)
						node = Arvore.Instancia.encontrarCaminhoPorNome(arvore, sl.ToArray())
					end
				end
			end
			node.Expand()
			arvore.SelectedNode = node
		end

		def LerArvoreDiretorio(node, barraStatus)
			sCaminho = node.Text
			NodeAnterior = node.Parent
			while NodeAnterior != nil
				if Rotinas.SubString(NodeAnterior.Text, NodeAnterior.Text.Length, 1) == Rotinas.BARRA_INVERTIDA then
					sSep = ""
				else
					sSep = Rotinas.BARRA_INVERTIDA
				end
				sCaminho = NodeAnterior.Text + sSep + sCaminho
				NodeAnterior = NodeAnterior.Parent
			end
			@form.barraStatus.Items[1].Text = sCaminho
		end

		def ListarArquivos(lvTabela, node)
			if node != nil then
				if node.IsSelected then
					self.LerArvoreDiretorio(node, @form.barraStatus)
					self.CarregarArquivosLista(true, lvTabela, @form.barraStatus.Items[1].Text)
					self.TamTotalDiretorio(@form.barraStatus.Items[1].Text)
				end
			end
		end

		def tabPanelMudou()
			arvore = self.getArvoreAtual()
			lvTabela = self.getTabelaAtual()
			arvore.Select()
			if arvore.Nodes.Count > 0 then
				self.ListarArquivos(lvTabela, arvore.Nodes[0])
			end
		end

		def getAbaSelecionada()
			return self.getAbaAtual()
		end

		def DuploCliqueLista(nome, tipo)
			if tipo.Equals("Diretório") then
				@form.Cursor = Cursors.WaitCursor
				sCaminho = @form.barraStatus.Items[1].Text
				if self.testaSeparadorArquivo(sCaminho) then
					sCaminho += nome
				else
					sCaminho += Rotinas.BARRA_INVERTIDA + nome
				end
				self.PesquisarArvoreDiretorio(sCaminho, self.getAbaAtual())
				@form.Cursor = Cursors.Default
			end
		end

		def EncontrarItemLista(nomeAba, nome, caminho)
			@form.Cursor = Cursors.WaitCursor
			aba = AbaBO.Instancia.pegaAbaPorNome(@listaAbas, nomeAba)
			self.PesquisarArvoreDiretorio(caminho, aba)
			tabela = self.getTabelaAtual()
			lvi = tabela.FindItemWithText(nome, false, 0, false)
			if lvi != nil then
				tabela.FocusedItem = lvi
				tabela.Select()
			end
			@form.Cursor = Cursors.Default
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
			@form.sdExportar.InitialDirectory = Rotinas.ExtractFilePath(Application.ExecutablePath)
			@form.sdExportar.FileName = aba.Nome + '.' + sExtensao
			@form.sdExportar.Filter = Rotinas.FILTRO_EXPORTAR
			retval = @form.sdExportar.ShowDialog()
			if retval == DialogResult.OK then
				arquivo = FileInfo.new(@form.sdExportar.FileName)
				if not arquivo.Exists then
					@form.Cursor = Cursors.WaitCursor
					DiretorioBO.Instancia.exportarDiretorio(tipo, self.getAbaAtual(), arquivo.FullName, pLog)
					@form.Cursor = Cursors.Default
					Dialogo.mensagemErro("Exportação realizada com sucesso!")
				end
			end
		end

		def ExcluirDiretorioSelecionado(pLog)
			arvore = self.getArvoreAtual()
			path = arvore.SelectedNode
			if path.Text.Length > 0 then
				tabela = self.getTabelaAtual()
				res = Dialogo.confirma("Tem Certeza, que você deseja excluir este diretório, isto implicará na destruição de todos os seus items catalogados?")
				if res then
					@form.Cursor = Cursors.WaitCursor
					DiretorioBO.Instancia.excluirDiretorio(self.getAbaAtual(), path.Text)
					self.ExcluirDados(self.getAbaAtual(), path.Text)
					path.Remove()
					tabela.Clear()
					self.CarregarDados(pLog, false, false)
					@form.Cursor = Cursors.Default
				end
			end
		end

		def ImportarArquivo(log, pLog)
			@form.odImportar.Filter = "Arquivo XML (*.xml)|*.xml"
			retval = @form.odImportar.ShowDialog()
			if retval == DialogResult.OK then
				arquivo = FileInfo.new(@form.odImportar.FileName)
				if arquivo.Exists then
					@form.Cursor = Cursors.WaitCursor
					nResultado = DiretorioBO.Instancia.importarDiretorioViaXML(self.getAbaAtual(), arquivo.FullName, @listaDiretorioPai, pLog)
					if nResultado == -1 then
						Dialogo.mensagemErro("Importação não realizada!")
					elsif nResultado == -2 then
						Dialogo.mensagemErro("Este diretório já existe no catálogo!")
					else
						self.FinalizaImportacao(pLog)
					end
					@form.Cursor = Cursors.Default
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
				frmImportarDiretorio.ShowDialog()
				return true
			else
				if not DiretorioBO.Instancia.verificaCodDir(importar.Aba, importar.RotuloRaiz, @listaDiretorioPai) then
					frmImportarDiretorio.ShowDialog()
					return true
				else
					Dialogo.mensagemErro("Este diretório já existe no catálogo!")
					return false
				end
			end
		end

		def FinalizaImportacao(pLog)
			@form.Cursor = Cursors.WaitCursor
			self.CarregarDados(pLog, true, true)
			tvAba = self.getArvoreAtual()
			self.CarregarArvore(tvAba, self.getAbaAtual())
			self.tabPanelMudou()
			@form.Cursor = Cursors.Default
			Dialogo.mensagemInfo("Importação do(s) diretório(s) realizada com sucesso!")
		end

		def ComecaImportacao(bSubDiretorios, pLog)
			retval = @form.escolherDir.ShowDialog()
			if retval == DialogResult.OK then
				arquivo = FileInfo.new(@form.escolherDir.SelectedPath)
				if arquivo.Directory.Exists then
					@form.Cursor = Cursors.WaitCursor
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
					@form.Cursor = Cursors.Default
				end
			end
		end

		def InformacoesDiretorioArquivo()
			tabela = self.getTabelaAtual()
			if tabela.SelectedItems.Count > 0 then
				frmInfo = FrmInfoDiretorio.new()
				aba = self.getAbaSelecionada()
				dir = Tabela.Instancia.getLinhaSelecionada(tabela, false)
				dir.Aba.Nome = aba.Nome
				frmInfo.setDiretorio(dir)
				frmInfo.ShowDialog()
			end
		end

		def listaCompara(lvTabela, coluna, colOrdem)
			if coluna != colOrdem then
				colOrdem = coluna
				lvTabela.Sorting = SortOrder.Ascending
			else
				if lvTabela.Sorting == SortOrder.Ascending then
					lvTabela.Sorting = SortOrder.Descending
				else
					lvTabela.Sorting = SortOrder.Ascending
				end
			end
			lvTabela.Sort()
			lvTabela.ListViewItemSorter = TabelaItemComparer.new(coluna, lvTabela.Sorting)
			return colOrdem
		end
	end
end