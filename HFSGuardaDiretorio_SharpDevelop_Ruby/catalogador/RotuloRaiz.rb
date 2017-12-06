# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 07/07/2015
# * Time: 11:01
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.catalogador
	# <summary>
	# Description of RotuloRaiz.
	# </summary>
	class RotuloRaiz
		def initialize()
		end

		def Rotulo
			return @rotulo
		end

		def Rotulo=(value)
			@rotulo = value
		end
	end
end