# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 10/12/2014
# * Time: 17:51
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetos
	# <summary>
	# Description of Aba.
	# </summary>
	class Aba
		def initialize(codigo, nome, ordem)
			self.@codigo = codigo
			self.@nome = nome
			self.@ordem = ordem
		end

		def initialize(codigo, nome, ordem)
			self.@codigo = codigo
			self.@nome = nome
			self.@ordem = ordem
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