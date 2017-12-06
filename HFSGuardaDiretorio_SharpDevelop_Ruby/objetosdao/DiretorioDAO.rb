# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 06/07/2015
# * Time: 11:30
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
require "HFSGuardaDiretorio.objetosbo, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.objetosdao
	# <summary>
	# Description of DiretorioDAO.
	# </summary>
	class DiretorioDAO
		def Instancia
			return @instancia
		end

		def initialize()
			@instancia = DiretorioDAO.new()
			@dr = nil
		end

		def fecharSqlPreparado()
			if @dr != nil then
				@dr.Close()
			end
		end

		def novoObjeto(dr)
			ret = Diretorio.new()
			aba = Aba.new()
			aba.Codigo = dr.GetInt32(0)
			ret.Codigo = dr.GetInt32(1)
			ret.Ordem = dr.GetInt32(2)
			if not dr.IsDBNull(3) then
				ret.CodDirPai = dr.GetInt32(3)
			else
				ret.CodDirPai = -1
			end
			if not dr.IsDBNull(4) then
				ret.Nome = dr.GetString(4)
			end
			ret.Tamanho = dr.GetDecimal(5)
			tipo = Tipo.new(dr.GetString(6)[0], "")
			ret.Modificado = Rotinas.StringToDate(dr.GetString(7))
			if not dr.IsDBNull(8) then
				ret.Atributos = dr.GetString(8)
			end
			if not dr.IsDBNull(9) then
				ret.Caminho = dr.GetString(9)
			end
			if not dr.IsDBNull(10) then
				aba.Nome = dr.GetString(10)
			end
			ret.Aba = aba
			if not dr.IsDBNull(11) then
				ret.NomePai = dr.GetString(11)
			end
			if not dr.IsDBNull(12) then
				ret.CaminhoPai = dr.GetString(12)
			end
			ret.TamanhoFormatado = DiretorioBO.Instancia.MontaTamanho(ret.Tamanho)
			if tipo.Codigo == 'D' then
				tipo.Nome = "Diretório"
			else
				tipo.Nome = "Arquivo"
			end
			ret.Tipo = tipo
			ret.ModificadoFormatado = Rotinas.formataDate(Rotinas.FORMATO_DATAHORA, ret.Modificado)
			return ret
		end

		def consultarTotal(sSQL, sCondicaoTotal)
			if Rotinas.ContainsStr(sSQL, "consultadirpai") then
				sTabela = "consultadirpai"
			elsif Rotinas.ContainsStr(sSQL, "consultadirfilho") then
				sTabela = "consultadirfilho"
			elsif Rotinas.ContainsStr(sSQL, "consultaarquivo") then
				sTabela = "consultaarquivo"
			else
				sTabela = "Diretorios"
			end
			sSQL = "select count(*) from " + sTabela
			if sCondicaoTotal.Trim().Length > 0 then
				sSQL += " " + sCondicaoTotal
			end
			total = 0
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new(sSQL, @conexao)
			@dr = @cmd.ExecuteReader()
			if @dr.Read() then
				total = @dr.GetInt32(0)
			end
			self.fecharSqlPreparado()
			return total
		end

		def consultarTudo(sSQL, sCondicaoTotal, progressoLog)
			lista = List[Diretorio].new()
			i = 0
			total = self.consultarTotal(sSQL, sCondicaoTotal)
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new(sSQL, @conexao)
			@dr = @cmd.ExecuteReader()
			if total > 0 then
				pb = Progresso.new()
				pb.Minimo = 0
				pb.Maximo = total - 1
				pb.Posicao = 0
				pb.Passo = 1
				while @dr.Read()
					obj = self.novoObjeto(@dr)
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

		def atribuirCampos(cmd, obj)
			cmd.Parameters.AddWithValue("@1", obj.Aba.Codigo)
			cmd.Parameters.AddWithValue("@2", obj.Codigo)
			cmd.Parameters.AddWithValue("@3", obj.Ordem)
			cmd.Parameters.AddWithValue("@4", obj.CodDirPai)
			cmd.Parameters.AddWithValue("@5", obj.Nome)
			cmd.Parameters.AddWithValue("@6", obj.Tamanho)
			cmd.Parameters.AddWithValue("@7", obj.Tipo.Codigo.ToString())
			cmd.Parameters.AddWithValue("@8", Rotinas.formataDate(Rotinas.FORMATO_DATAHORA, obj.Modificado))
			cmd.Parameters.AddWithValue("@9", obj.Atributos)
			cmd.Parameters.AddWithValue("@10", obj.Caminho)
		end

		def incluir(obj)
			begin
				@conexao = Rotinas.getConexao()
				@cmd = SQLiteCommand.new("insert into Diretorios(aba, cod, ordem, coddirpai, nome, tam," + " tipo, modificado, atributos, caminho)" + " values (@1,@2,@3,@4,@5,@6,@7,@8,@9,@10)", @conexao)
				self.atribuirCampos(@cmd, obj)
				@cmd.Prepare()
				ret = @cmd.ExecuteNonQuery()
			rescue Exception => 
				raise 
			ensure
			end
			return ret
		end

		def excluir(aba, sCaminho)
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new("delete from Diretorios where caminho like @1 and aba=@2", @conexao)
			@cmd.Parameters.AddWithValue("@1", sCaminho + "%")
			@cmd.Parameters.AddWithValue("@2", aba.Codigo)
			@cmd.Prepare()
			ret = @cmd.ExecuteNonQuery()
			return ret
		end

		def criarTabela()
			sSQL = "create table if NOT EXISTS Diretorios(" + "aba int not null," + "cod int not null," + "ordem int not null," + "nome varchar(255) not null," + "tam numeric not null," + "tipo char(1) not null," + "modificado date not null," + "atributos varchar(20) not null," + "coddirpai int not null," + "caminho varchar(255) not null," + "primary key (aba, cod, ordem))"
			@conexao = Rotinas.getConexao()
			@cmd = SQLiteCommand.new(sSQL, @conexao)
			ret = @cmd.ExecuteNonQuery()
			return ret
		end
	end
end