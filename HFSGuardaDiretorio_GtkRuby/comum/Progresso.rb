# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 15:12
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.comum
	# <summary>
	# Description of Progresso.
	# </summary>
	class Progresso
		def initialize()
			self.@minimo = 0
			self.@maximo = 0
			self.@posicao = 0
			self.@passo = 0
			self.@log = ""
		end

		def Minimo
			return @minimo
		end

		def Minimo=(value)
			@minimo = value
		end

		def Maximo
			return @maximo
		end

		def Maximo=(value)
			@maximo = value
		end

		def Posicao
			return @posicao
		end

		def Posicao=(value)
			@posicao = value
		end

		def Passo
			return @passo
		end

		def Passo=(value)
			@passo = value
		end

		def Log
			return @log
		end

		def Log=(value)
			@log = value
		end
	end
end