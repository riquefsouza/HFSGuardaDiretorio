# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 14:47
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetos
	# <summary>
	# Description of DiretorioOrdem.
	# </summary>
	class DiretorioOrdem
		def initialize()
		end

		def Ordem
			return @ordem
		end

		def Ordem=(value)
			@ordem = value
		end
	end
end