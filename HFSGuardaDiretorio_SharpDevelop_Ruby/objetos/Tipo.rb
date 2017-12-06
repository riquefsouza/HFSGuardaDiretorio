
module HFSGuardaDiretorio_objetos

	class Tipo
		def initialize()
			@codigo = ' '
			@nome = ""
		end

		def initialize(codigo, nome)
			@codigo = codigo
			@nome = nome
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
	end
end