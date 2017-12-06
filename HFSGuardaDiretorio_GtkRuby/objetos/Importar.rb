# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 14:41
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetos
	# <summary>
	# Description of Importar.
	# </summary>
	class Importar
		def initialize()
			self.@aba = 0
			self.@codDirRaiz = 0
			self.@rotuloRaiz = ""
			self.@nomeDirRaiz = ""
			self.@caminho = ""
		end

		def Aba
			return @aba
		end

		def Aba=(value)
			@aba = value
		end

		def CodDirRaiz
			return @codDirRaiz
		end

		def CodDirRaiz=(value)
			@codDirRaiz = value
		end

		def RotuloRaiz
			return @rotuloRaiz
		end

		def RotuloRaiz=(value)
			@rotuloRaiz = value
		end

		def NomeDirRaiz
			return @nomeDirRaiz
		end

		def NomeDirRaiz=(value)
			@nomeDirRaiz = value
		end

		def Caminho
			return @caminho
		end

		def Caminho=(value)
			@caminho = value
		end
	end
end