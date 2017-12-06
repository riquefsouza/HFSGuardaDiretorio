
module HFSGuardaDiretorio_objetos
	class Arquivo
		def initialize(nome, tamanho, modificado, atributos)
			@nome = nome
			@tamanho = tamanho
			@modificado = modificado
			@atributos = atributos
		end

		def initialize(nome, tamanho, modificado, atributos)
			@nome = nome
			@tamanho = tamanho
			@modificado = modificado
			@atributos = atributos
		end

		def Nome
			return nome
		end

		def Nome=(value)
			nome = value
		end

		def Tamanho
			return tamanho
		end

		def Tamanho=(value)
			tamanho = value
		end

		def Modificado
			return modificado
		end

		def Modificado=(value)
			modificado = value
		end

		def Atributos
			return atributos
		end

		def Atributos=(value)
			atributos = value
		end
	end

end