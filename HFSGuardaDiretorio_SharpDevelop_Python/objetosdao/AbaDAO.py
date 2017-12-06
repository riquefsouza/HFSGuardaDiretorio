# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 17:27
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from System.Data import *
from System.Data.SQLite import *
from System.Collections.Generic import *
from HFSGuardaDiretorio.comum import *
from HFSGuardaDiretorio.objetos import *

class AbaDAO(object):
	""" <summary>
	 Description of AbaDAO.
	 </summary>
	"""
	def get_Instancia(self):
		return self._instancia

	Instancia = property(fget=get_Instancia)

	def __init__(self):
		self._instancia = AbaDAO()
		self._dr = None

	def fecharSqlPreparado(self):
		if self._dr != None:
			self._dr.Close()

	def novoObjeto(self, dr):
		ret = Aba()
		ret.Codigo = dr.GetInt32(0)
		ret.Nome = dr.GetString(1)
		return ret

	def consultarTotal(self):
		total = 0
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand("select count(*) from Abas", self._conexao)
		self._dr = self._cmd.ExecuteReader()
		if self._dr.Read():
			total = self._dr.GetInt32(0)
		self.fecharSqlPreparado()
		return total

	def consultarTudo(self, progressoLog):
		lista = List[Aba]()
		i = 0
		total = self.consultarTotal()
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand("select cod, nome from Abas", self._conexao)
		self._dr = self._cmd.ExecuteReader()
		if total > 0:
			pb = Progresso()
			pb.Minimo = 0
			pb.Maximo = total - 1
			pb.Posicao = 0
			pb.Passo = 1
			while self._dr.Read():
				obj = self.novoObjeto(self._dr)
				obj.Ordem = i + 1
				lista.Add(obj)
				pb.Posicao = i
				if progressoLog != None:
					progressoLog.ProgressoLog(pb)
				i += 1
		self.fecharSqlPreparado()
		return lista

	def incluir(self, obj):
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand("insert into Abas(cod, nome) values(@1,@2)", self._conexao)
		self._cmd.Parameters.AddWithValue("@1", obj.Codigo)
		self._cmd.Parameters.AddWithValue("@2", obj.Nome)
		self._cmd.Prepare()
		ret = self._cmd.ExecuteNonQuery()
		return ret

	def alterar(self, obj):
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand("update Abas set nome=@1 where cod=@2", self._conexao)
		self._cmd.Parameters.AddWithValue("@1", obj.Nome)
		self._cmd.Parameters.AddWithValue("@2", obj.Codigo)
		self._cmd.Prepare()
		ret = self._cmd.ExecuteNonQuery()
		return ret

	def excluir(self, codigo):
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand("delete from Diretorios where aba=@1", self._conexao)
		self._cmd.Parameters.AddWithValue("@1", codigo)
		self._cmd.Prepare()
		self._cmd.ExecuteNonQuery()
		self._cmd = SQLiteCommand("delete from Abas where cod=@1", self._conexao)
		self._cmd.Parameters.AddWithValue("@1", codigo)
		self._cmd.Prepare()
		ret = self._cmd.ExecuteNonQuery()
		return ret

	def criarTabela(self):
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand("create table IF NOT EXISTS Abas(" + "cod integer not null, nome varchar(10) not null, " + "primary key (cod))", self._conexao)
		ret = self._cmd.ExecuteNonQuery()
		return ret