# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 10/12/2014
# * Time: 17:48
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetos
	# <summary>
	# Description of Diretorio.
	# </summary>
	# 
	class Diretorio < Arquivo
		def initialize()
			self.@aba = Aba.new()
			self.@codigo = 0
			self.@ordem = 0
			self.@codDirPai = 0
			self.@tipo = Tipo.new()
			self.@caminho = ""
			self.@nomePai = ""
			self.@caminhoPai = ""
			self.@tamanhoFormatado = ""
			self.@modificadoFormatado = ""
			self.@caminhoOriginal = ""
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