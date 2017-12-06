# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 09/07/2015
# * Time: 17:06
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetosgui
	# <summary>
	# Description of TabelaItemComparer.
	# </summary>
	class TabelaItemComparer < IComparer
		def initialize(coluna, ordem)
			@col = coluna
			self.@ordem = ordem
		end

		def initialize(coluna, ordem)
			@col = coluna
			self.@ordem = ordem
		end

		def Compare(x, y)
			retornoVal = -1
			retornoVal = String.Compare((x).SubItems[@col].Text, (y).SubItems[@col].Text)
			if @ordem == SortOrder.Ascending then
				retornoVal *= -1
			end
			return retornoVal
		end
	end
end