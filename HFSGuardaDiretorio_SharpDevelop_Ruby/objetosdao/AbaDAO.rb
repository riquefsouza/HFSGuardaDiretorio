# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 17:27
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Data.SQLite, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.objetos, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetosdao
	# <summary>
	# Description of AbaDAO.
	# </summary>
	class AbaDAO
		def Instancia
			return @instancia
		end

		def initialize()
			@instancia = AbaDAO.new()
			@dr = nil
		end

		def fecharSqlPreparado()
			if @dr != nil then
				@dr.Close()
			end
		end

		def novoObjeto(dr)
			ret = Aba.new()
			ret.Codigo = dr.GetInt32(0)
			ret.Nome = dr.GetString(1)
			return ret
		end

		def consultarTotal()
			total = 0
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new("select count(*) from Abas", @conexao)
			@dr = @cmd.ExecuteReader()
			if @dr.Read() then
				total = @dr.GetInt32(0)
			end
			self.fecharSqlPreparado()
			return total
		end

		def consultarTudo(progressoLog)
			lista = List[Aba].new()
			i = 0
			total = self.consultarTotal()
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new("select cod, nome from Abas", @conexao)
			@dr = @cmd.ExecuteReader()
			if total > 0 then
				pb = Progresso.new()
				pb.Minimo = 0
				pb.Maximo = total - 1
				pb.Posicao = 0
				pb.Passo = 1
				while @dr.Read()
					obj = self.novoObjeto(@dr)
					obj.Ordem = i + 1
					lista.Add(obj)
					pb.Posicao = i
					if progressoLog != nil then
						progressoLog.ProgressoLog(pb)
					end
					i += 1
				end
			end
			self.fecharSqlPreparado()
			return lista
		end

		def incluir(obj)
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new("insert into Abas(cod, nome) values(@1,@2)", @conexao)
			@cmd.Parameters.AddWithValue("@1", obj.Codigo)
			@cmd.Parameters.AddWithValue("@2", obj.Nome)
			@cmd.Prepare()
			ret = @cmd.ExecuteNonQuery()
			return ret
		end

		def alterar(obj)
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new("update Abas set nome=@1 where cod=@2", @conexao)
			@cmd.Parameters.AddWithValue("@1", obj.Nome)
			@cmd.Parameters.AddWithValue("@2", obj.Codigo)
			@cmd.Prepare()
			ret = @cmd.ExecuteNonQuery()
			return ret
		end

		def excluir(codigo)
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new("delete from Diretorios where aba=@1", @conexao)
			@cmd.Parameters.AddWithValue("@1", codigo)
			@cmd.Prepare()
			@cmd.ExecuteNonQuery()
			@cmd = SQLiteCommand.new("delete from Abas where cod=@1", @conexao)
			@cmd.Parameters.AddWithValue("@1", codigo)
			@cmd.Prepare()
			ret = @cmd.ExecuteNonQuery()
			return ret
		end

		def criarTabela()
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new("create table IF NOT EXISTS Abas(" + "cod integer not null, nome varchar(10) not null, " + "primary key (cod))", @conexao)
			ret = @cmd.ExecuteNonQuery()
			return ret
		end
	end
end