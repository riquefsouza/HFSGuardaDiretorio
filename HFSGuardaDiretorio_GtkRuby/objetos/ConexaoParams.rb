# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 14:29
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetos
	# <summary>
	# Description of ConexaoParams.
	# </summary>
	class ConexaoParams
		def initialize()
			self.@nome = ""
			self.@driver = ""
			self.@url = ""
			self.@login = ""
			self.@senha = ""
		end

		def Nome
			return @nome
		end

		def Nome=(value)
			@nome = value
		end

		def Driver
			return @driver
		end

		def Driver=(value)
			@driver = value
		end

		def Url
			return @url
		end

		def Url=(value)
			@url = value
		end

		def Login
			return @login
		end

		def Login=(value)
			@login = value
		end

		def Senha
			return @senha
		end

		def Senha=(value)
			@senha = value
		end
	end
end