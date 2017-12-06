
module HFSGuardaDiretorio_objetos

class Diretorio < Arquivo
		def initialize()
			@aba = Aba.new()
			@codigo = 0
			@ordem = 0
			@codDirPai = 0
			@tipo = Tipo.new()
			@caminho = ""
			@nomePai = ""
			@caminhoPai = ""
			@tamanhoFormatado = ""
			@modificadoFormatado = ""
			@caminhoOriginal = ""
		end

		def Aba
			return @aba
		end

		def Aba=(value)
			@aba = value
		end

		def Codigo
			return @codigo
		end

		def Codigo=(value)
			@codigo = value
		end

		def Ordem
			return @ordem
		end

		def Ordem=(value)
			@ordem = value
		end

		def CodDirPai
			return @codDirPai
		end

		def CodDirPai=(value)
			@codDirPai = value
		end

		def Tipo
			return @tipo
		end

		def Tipo=(value)
			@tipo = value
		end

		def Caminho
			return @caminho
		end

		def Caminho=(value)
			@caminho = value
		end

		def NomePai
			return @nomePai
		end

		def NomePai=(value)
			@nomePai = value
		end

		def CaminhoPai
			return @caminhoPai
		end

		def CaminhoPai=(value)
			@caminhoPai = value
		end

		def TamanhoFormatado
			return @tamanhoFormatado
		end

		def TamanhoFormatado=(value)
			@tamanhoFormatado = value
		end

		def ModificadoFormatado
			return @modificadoFormatado
		end

		def ModificadoFormatado=(value)
			@modificadoFormatado = value
		end

		def CaminhoOriginal
			return @caminhoOriginal
		end

		def CaminhoOriginal=(value)
			@caminhoOriginal = value
		end
	end
end