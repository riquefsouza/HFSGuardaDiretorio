# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 14:54
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.comum
	# <summary>
	# Description of ICatalogador.
	# </summary>
	class ICatalogador
		def getAbaSelecionada()
		end

		def DuploCliqueLista(nome, tipo)
		end

		def EncontrarItemLista(nomeAba, nome, caminho)
		end
	end
end