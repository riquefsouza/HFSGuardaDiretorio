# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 17:17
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Data.SQLite, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetosdao
	# <summary>
	# Description of VisaoDAO.
	# </summary>
	class VisaoDAO
		def Instancia
			return @instancia
		end

		def initialize()
			@instancia = VisaoDAO.new()
		end

		def criarVisao(visao)
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new(self.sqlVisao(visao), @conexao)
			ret = @cmd.ExecuteNonQuery()
			return ret
		end

		def sqlVisao(visao)
			sSQL = "create view " + visao + " as " + "SELECT d.aba,d.cod,d.ordem,d.coddirpai,d.nome,d.tam," + "d.tipo,d.modificado,d.atributos,d.caminho" + ",(select nome as nomeaba from Abas where cod=d.aba) as nomeaba" + ",(select nome as nomepai from Diretorios where cod=d.cod " + "  and ordem=d.coddirpai and aba=d.aba) as nomepai" + ",(select caminho as caminhopai from Diretorios where cod=d.cod " + " and ordem=d.coddirpai and aba=d.aba) as caminhopai " + "FROM Diretorios d "
			if visao.Equals("consultadirpai") then
				sSQL += "where d.tipo='D' and d.coddirpai = 0"
			elsif visao.Equals("consultadirfilho") then
				sSQL += "where d.tipo='D' and d.coddirpai > 0"
			end
			return sSQL
		end
	end
end