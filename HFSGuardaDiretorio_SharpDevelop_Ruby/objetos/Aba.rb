
module HFSGuardaDiretorio_objetos
	# <summary>
	# Description of Aba.
	# </summary>
	class Aba
		def initialize(codigo, nome, ordem)
			@codigo = codigo
			@nome = nome
			@ordem = ordem
		end

		def initialize(codigo, nome, ordem)
			@codigo = codigo
			@nome = nome
			@ordem = ordem
		end

		def Codigo
			return codigo
		end

		def Codigo=(value)
			codigo = value
		end

		def Nome
			return nome
		end

		def Nome=(value)
			nome = value
		end

		def Ordem
			return ordem
		end

		def Ordem=(value)
			ordem = value
		end
	end
end