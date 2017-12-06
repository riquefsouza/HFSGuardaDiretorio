# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 06/07/2015
# * Time: 11:14
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
	# Description of ExtensaoDAO.
	# </summary>
	class ExtensaoDAO
		def Instancia
			return @instancia
		end

		def initialize()
			@instancia = ExtensaoDAO.new()
			@dr = nil
		end

		def fecharSqlPreparado()
			if @dr != nil then
				@dr.Close()
			end
		end

		def novoObjeto(dr)
			ret = Extensao.new()
			ret.Codigo = dr.GetInt32(0)
			ret.Nome = dr.GetString(1)
			ret.Bmp16 = dr.GetValue(2)
			ret.Bmp32 = dr.GetValue(3)
			return ret
		end

		def consultarTotal()
			total = 0
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new("select count(*) from Extensoes", @conexao)
			@dr = @cmd.ExecuteReader()
			if @dr.Read() then
				total = @dr.GetInt32(0)
			end
			self.fecharSqlPreparado()
			return total
		end

		def consultarTudo(progressoLog)
			lista = List[Extensao].new()
			i = 0
			total = self.consultarTotal()
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new("select cod, nome, bmp16, bmp32 from Extensoes", @conexao)
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
			@cmd = SQLiteCommand.new("insert into Extensoes(cod, nome, bmp16, bmp32) values(@1,@2,@3,@4)", @conexao)
			@cmd.Parameters.Add("@1", DbType.Int32)
			@cmd.Parameters.Add("@2", DbType.String, 20)
			@cmd.Parameters.Add("@3", DbType.Binary, 1000000)
			@cmd.Parameters.Add("@4", DbType.Binary, 1000000)
			# 
			# cmd.Parameters.AddWithValue("@1", obj.Codigo);
			# cmd.Parameters.AddWithValue("@2", obj.Nome);
			# cmd.Parameters.AddWithValue("@3", obj.Bmp16);
			# cmd.Parameters.AddWithValue("@4", obj.Bmp32);
			# 
			@cmd.Prepare()
			@cmd.Parameters["@1"].Value = obj.Codigo
			@cmd.Parameters["@2"].Value = obj.Nome
			@cmd.Parameters["@3"].Value = obj.Bmp16
			@cmd.Parameters["@4"].Value = obj.Bmp32
			ret = @cmd.ExecuteNonQuery()
			return ret
		end

		def excluir(codigo)
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new("delete from Extensoes where cod=@1", @conexao)
			@cmd.Parameters.AddWithValue("@1", codigo)
			@cmd.Prepare()
			ret = @cmd.ExecuteNonQuery()
			return ret
		end

		def excluirTudo()
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new("delete from Extensoes", @conexao)
			ret = @cmd.ExecuteNonQuery()
			return ret
		end

		def criarTabela()
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new("create table IF NOT EXISTS Extensoes(" + "cod integer not null," + "nome varchar(20) not null," + "bmp16 BLOB COLLATE NOCASE null," + "bmp32 BLOB COLLATE NOCASE null," + "primary key (cod))", @conexao)
			ret = @cmd.ExecuteNonQuery()
			return ret
		end
	end
end