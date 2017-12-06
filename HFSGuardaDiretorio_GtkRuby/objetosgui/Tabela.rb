require "mscorlib"

				require "mscorlib"

				require "mscorlib"

				require "mscorlib"

				require "mscorlib"

				require "mscorlib"

				require "mscorlib"

				require "mscorlib"

				require "mscorlib"

				require "mscorlib"

				require "mscorlib"

				require "mscorlib"

				require "mscorlib"

				require "mscorlib"

				require "mscorlib"

# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 08/07/2015
# * Time: 10:45
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "Gtk, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetosbo, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetosgui
	# <summary>
	# Description of Tabela.
	# </summary>
	class Tabela
		def Instancia
			return @instancia
		end

		def initialize()
			@instancia = Tabela.new()
		end

		def Construir(bTabelaDir, lvTabela)
			tvColuna = TreeViewColumn.new()
			tvColuna.Title = "Nome"
			pixbufRender = CellRendererPixbuf.new()
			tvColuna.PackStart(pixbufRender, false)
			tvColuna.AddAttribute(pixbufRender, "pixbuf", 0)
			tvcolunaCell = CellRendererText.new()
			tvColuna.PackStart(tvcolunaCell, true)
			tvColuna.AddAttribute(tvcolunaCell, "text", 1)
			lvTabela.AppendColumn(tvColuna)
			lvTabela.AppendColumn("Tamanho", Gtk.CellRendererText.new(), "text", 2)
			lvTabela.AppendColumn("Tipo", Gtk.CellRendererText.new(), "text", 3)
			lvTabela.AppendColumn("Modificado", Gtk.CellRendererText.new(), "text", 4)
			lvTabela.AppendColumn("Atributos", Gtk.CellRendererText.new(), "text", 5)
			lvTabela.AppendColumn("Caminho", Gtk.CellRendererText.new(), "text", 6)
			tamanhos = Array[System::Int32].new([300, 100, 70, 120, 90, 300])
			i = 0
			while i < tamanhos.Length
				#lvTabela.Columns[i].MinWidth = tamanhos[i];
				lvTabela.Columns[i].SortColumnId = i + 1
				lvTabela.Columns[i].Resizable = true
				lvTabela.Columns[i].Sizing = TreeViewColumnSizing.Autosize
				i += 1
			end
			if bTabelaDir then
				lstore = ListStore.new(Gdk::Pixbuf.to_clr_type, System::String.to_clr_type, System::String.to_clr_type, System::String.to_clr_type, System::String.to_clr_type, System::String.to_clr_type, System::String.to_clr_type)
			else
				lvTabela.AppendColumn("Aba", Gtk.CellRendererText.new(), "text", 7)
				#lvTabela.Columns[6].MinWidth = 150;
				lvTabela.Columns[6].SortColumnId = 7
				lvTabela.Columns[6].Resizable = true
				lvTabela.Columns[6].Sizing = TreeViewColumnSizing.Autosize
				lstore = ListStore.new(Gdk::Pixbuf.to_clr_type, System::String.to_clr_type, System::String.to_clr_type, System::String.to_clr_type, System::String.to_clr_type, System::String.to_clr_type, System::String.to_clr_type, System::String.to_clr_type)
			end
			lvTabela.Selection.Mode = SelectionMode.Single
			lvTabela.Model = lstore
			lvTabela.ColumnsAutosize()
		end

		def AdicionaItemLista(bTabelaDir, lvTabela, dir, extensoes)
			lstore = lvTabela.Model
			lista = List[System::Object].new()
			if dir.Tipo.Codigo == 'D' then
				icone = Rotinas.LerArquivoPixbuf("diretorio.gif")
				lista.Add(icone)
			else
				icone = ExtensaoBO.Instancia.pixbufExtensao(extensoes, dir.Nome)
				lista.Add(icone)
			end
			lista.Add(dir.Nome)
			if dir.Tipo.Codigo == 'D' then
				lista.Add("")
			else
				lista.Add(dir.TamanhoFormatado)
			end
			lista.Add(dir.Tipo.Nome)
			lista.Add(dir.ModificadoFormatado)
			lista.Add(dir.Atributos)
			lista.Add(dir.Caminho)
			if not bTabelaDir then
				lista.Add(dir.Aba.Nome)
			end
			lstore.AppendValues(lista.ToArray())
		end

		def Carregar(bTabelaDir, lvTabela, diretorios, extensoes, pb)
			if diretorios.Count > 0 then
				nProgresso = 0
				nMaximum = diretorios.Count
				pb.Fraction = 0
				pb.PulseStep = 0.1
				enumerator = diretorios.GetEnumerator()
				while enumerator.MoveNext()
					dir = enumerator.Current
					self.AdicionaItemLista(bTabelaDir, lvTabela, dir, extensoes)
					pb.Fraction = Rotinas.calculaProgresso(nMaximum, nProgresso += 1)
				end
			end
		end

		def encontrarCaminhoPorNome(lvTabela, nome)
			lstore = lvTabela.Model
			path = nil
			i = 0
			while i < lstore.IterNChildren()
				lstore.IterNthChild(iter, i)
				slinha = lstore.GetValue(iter, 1)
				if slinha.Equals(nome) then
					path = lstore.GetPath(iter)
					break
				end
				i += 1
			end
			return path
		end

		def getLinhaSelecionada(lvTabela, bTabelaDir)
			dir = nil
			lstore = lvTabela.Model
			lvTabela.Selection.GetSelected(iter)
			if lvTabela.Selection.IterIsSelected(iter) then
				dir = Diretorio.new()
				dir.Nome = lstore.GetValue(iter, 1)
				dir.TamanhoFormatado = lstore.GetValue(iter, 2)
				dir.Tipo = Tipo.new('D', lstore.GetValue(iter, 3))
				dir.ModificadoFormatado = lstore.GetValue(iter, 4)
				dir.Atributos = lstore.GetValue(iter, 5)
				dir.Caminho = lstore.GetValue(iter, 6)
				if bTabelaDir then
					dir.Aba.Nome = lstore.GetValue(iter, 7)
				end
			end
			return dir
		end

		def listaCompara(lvTabela, coluna)
			tabelaStore = lvTabela.Model
			tabelaStore.SetSortFunc(coluna, Compara)
		end

		def Compara(modelo, linha1, linha2)
			lstore = modelo
			lstore.GetSortColumnId(colOrdem, ordem)
			valor1 = modelo.GetValue(linha1, colOrdem)
			valor2 = modelo.GetValue(linha2, colOrdem)
			return valor1.CompareTo(valor2)
		end
	end
end