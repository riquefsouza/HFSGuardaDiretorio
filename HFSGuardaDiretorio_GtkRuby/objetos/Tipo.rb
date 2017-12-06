# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 14:44
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetos
	# <summary>
	# Description of Tipo.
	# </summary>
	class Tipo
		def initialize(codigo, nome)
			self.@codigo = codigo
			self.@nome = nome
		end

		def initialize(codigo, nome)
			self.@codigo = codigo
			self.@nome = nome
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