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
require "System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
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

		def AdicionaItemLista(bTabelaDir, lvTabela, dir, extensoes)
			item = lvTabela.Items.Add(dir.Nome)
			if dir.Tipo.Codigo == 'D' then
				item.SubItems.Add("")
				item.ImageIndex = 0
			else
				item.SubItems.Add(dir.TamanhoFormatado)
				item.ImageIndex = ExtensaoBO.Instancia.indiceExtensao(extensoes, dir.Nome)
			end
			item.SubItems.Add(dir.Tipo.Nome)
			item.SubItems.Add(dir.ModificadoFormatado)
			item.SubItems.Add(dir.Atributos)
			item.SubItems.Add(dir.Caminho)
			if not bTabelaDir then
				item.SubItems.Add(dir.Aba.Nome)
			end
		end

		def Carregar(bTabelaDir, lvTabela, diretorios, extensoes, pb)
			if diretorios.Count > 0 then
				pb.Minimum = 0
				pb.Maximum = diretorios.Count
				pb.Value = 0
				pb.Step = 1
				enumerator = diretorios.GetEnumerator()
				while enumerator.MoveNext()
					dir = enumerator.Current
					self.AdicionaItemLista(bTabelaDir, lvTabela, dir, extensoes)
					pb.Value += 1
				end
			end
		end

		def encontrarLinha(lvTabela, nome)
			nlinha = 0
			i = 0
			while i < lvTabela.Items.Count
				slinha = lvTabela.Items[i].SubItems[0].Text
				if slinha.Equals(nome) then
					nlinha = i
					break
				end
				i += 1
			end
			return nlinha
		end

		def getLinhaSelecionada(lvTabela, bTabelaDir)
			dir = nil
			if lvTabela.SelectedItems.Count > 0 then
				dir = Diretorio.new()
				dir.Nome = lvTabela.SelectedItems[0].SubItems[0].Text
				dir.TamanhoFormatado = lvTabela.SelectedItems[0].SubItems[1].Text
				dir.Tipo = Tipo.new('D', lvTabela.SelectedItems[0].SubItems[2].Text)
				dir.ModificadoFormatado = lvTabela.SelectedItems[0].SubItems[3].Text
				dir.Atributos = lvTabela.SelectedItems[0].SubItems[4].Text
				dir.Caminho = lvTabela.SelectedItems[0].SubItems[5].Text
				if bTabelaDir then
					dir.Aba.Nome = lvTabela.SelectedItems[0].SubItems[6].Text
				end
			end
			return dir
		end
	end
end