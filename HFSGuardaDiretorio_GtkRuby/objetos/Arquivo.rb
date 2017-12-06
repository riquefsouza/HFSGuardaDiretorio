# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 10/12/2014
# * Time: 17:41
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetos
	# <summary>
	# Description of Arquivo.
	# </summary>
	class Arquivo
		def initialize(nome, tamanho, modificado, atributos)
			self.@nome = nome
			self.@tamanho = tamanho
			self.@modificado = modificado
			self.@atributos = atributos
		end

		def initialize(nome, tamanho, modificado, atributos)
			self.@nome = nome
			self.@tamanho = tamanho
			self.@modificado = modificado
			self.@atributos = atributos
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