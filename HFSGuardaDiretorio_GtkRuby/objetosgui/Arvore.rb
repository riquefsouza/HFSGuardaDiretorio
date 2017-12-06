require "mscorlib"

			require "mscorlib"

# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 08/07/2015
# * Time: 10:51
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "Gtk, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetosgui
	# <summary>
	# Description of Arvore.
	# </summary>
	class Arvore
		def Instancia
			return @instancia
		end

		def initialize()
			@instancia = Arvore.new()
		end

		def Construir(tvArvore)
			tvColuna = TreeViewColumn.new()
			tvColuna.Title = "coluna"
			pixbufRender = CellRendererPixbuf.new()
			tvColuna.PackStart(pixbufRender, false)
			tvColuna.AddAttribute(pixbufRender, "pixbuf", 0)
			tvcolunaCell = CellRendererText.new()
			tvColuna.PackStart(tvcolunaCell, true)
			tvColuna.AddAttribute(tvcolunaCell, "text", 1)
			tvArvore.AppendColumn(tvColuna)
			tvArvore.HeadersVisible = false
			tvArvore.Selection.Mode = SelectionMode.Single
			storeArvore = TreeStore.new(Gdk::Pixbuf.to_clr_type, System::String.to_clr_type)
			tvArvore.Model = storeArvore
		end

		def selecionarPrimeiroItem(tvArvore)
			store = tvArvore.Model
			store.GetIterFirst(iter)
			tvArvore.Selection.SelectIter(iter)
		end

		def encontrarCaminhoPorNome(tvArvore, nomes)
			arvoreStore = tvArvore.Model
			if arvoreStore.GetIterFirst(raiz) then
				raiz = self.encontrarCaminho(arvoreStore, raiz, nomes, 0)
				return arvoreStore.GetPath(raiz)
			end
			return nil
		end

		def encontrarCaminho(arvoreStore, pai, nomes, nivel)
			bValido = arvoreStore.IterIsValid(pai)
			if bValido then
				while bValido
					valorPai = arvoreStore.GetValue(pai, 1)
					if valorPai.Equals(nomes[nivel]) then
						if nivel == (nomes.Length - 1) then
							return pai
						end
						if arvoreStore.IterHasChild(pai) then
							arvoreStore.IterChildren(filho, pai)
							return self.encontrarCaminho(arvoreStore, filho, nomes, nivel + 1)
						end
					end
					bValido = arvoreStore.IterNext(pai)
				end
			end
			return pai
		end
	end
end