# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 10/12/2014
# * Time: 17:58
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetos
	# <summary>
	# Description of Extensao.
	# </summary>
	class Extensao
		def initialize(codigo, nome, ordem, bmp16, bmp32)
			self.@codigo = codigo
			self.@nome = nome
			self.@ordem = ordem
			self.@bmp16 = bmp16
			self.@bmp32 = bmp32
		end

		def initialize(codigo, nome, ordem, bmp16, bmp32)
			self.@codigo = codigo
			self.@nome = nome
			self.@ordem = ordem
			self.@bmp16 = bmp16
			self.@bmp32 = bmp32
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

		def Bmp16
			return bmp16
		end

		def Bmp16=(value)
			bmp16 = value
		end

		def Bmp32
			return bmp32
		end

		def Bmp32=(value)
			bmp32 = value
		end
	end
end