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
require "System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

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

		def encontrarCaminhoPorNome(tvArvore, nomes)
			enumerator = tvArvore.Nodes.GetEnumerator()
			while enumerator.MoveNext()
				item = enumerator.Current
				if item.Text.Equals(nomes[0]) then
					return self.encontrarCaminho(item, nomes, 0)
				end
			end
			return nil
		end

		def encontrarCaminho(pai, nomes, nivel)
			if pai.Text.Equals(nomes[nivel]) then
				if nivel == (nomes.Length - 1) then
					return pai
				end
				if pai.GetNodeCount(true) > 0 then
					enumerator = pai.Nodes.GetEnumerator()
					while enumerator.MoveNext()
						filho = enumerator.Current
						res = self.encontrarCaminho(filho, nomes, nivel + 1)
						if res != nil then
							return res
						end
					end
				end
			end
			return nil
		end
	end
end