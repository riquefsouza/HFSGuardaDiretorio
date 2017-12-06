# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 06/07/2015
# * Time: 11:14
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from System.Data import *
from System.Data.SQLite import *
from System.Collections.Generic import *
from HFSGuardaDiretorio.comum import *
from HFSGuardaDiretorio.objetos import *

class ExtensaoDAO(object):
	""" <summary>
	 Description of ExtensaoDAO.
	 </summary>
	"""
	def get_Instancia(self):
		return self._instancia

	Instancia = property(fget=get_Instancia)

	def __init__(self):
		self._instancia = ExtensaoDAO()
		self._dr = None

	def fecharSqlPreparado(self):
		if self._dr != None:
			self._dr.Close()

	def novoObjeto(self, dr):
		ret = Extensao()
		ret.Codigo = dr.GetInt32(0)
		ret.Nome = dr.GetString(1)
		ret.Bmp16 = dr.GetValue(2)
		ret.Bmp32 = dr.GetValue(3)
		return ret

	def consultarTotal(self):
		total = 0
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand("select count(*) from Extensoes", self._conexao)
		self._dr = self._cmd.ExecuteReader()
		if self._dr.Read():
			total = self._dr.GetInt32(0)
		self.fecharSqlPreparado()
		return total

	def consultarTudo(self, progressoLog):
		lista = List[Extensao]()
		i = 0
		total = self.consultarTotal()
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand("select cod, nome, bmp16, bmp32 from Extensoes", self._conexao)
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
		self._cmd = SQLiteCommand("insert into Extensoes(cod, nome, bmp16, bmp32) values(@1,@2,@3,@4)", self._conexao)
		self._cmd.Parameters.Add("@1", DbType.Int32)
		self._cmd.Parameters.Add("@2", DbType.String, 20)
		self._cmd.Parameters.Add("@3", DbType.Binary, 1000000)
		self._cmd.Parameters.Add("@4", DbType.Binary, 1000000)
		# 
		# cmd.Parameters.AddWithValue("@1", obj.Codigo);
		# cmd.Parameters.AddWithValue("@2", obj.Nome);
		# cmd.Parameters.AddWithValue("@3", obj.Bmp16);
		# cmd.Parameters.AddWithValue("@4", obj.Bmp32);
		# 
		self._cmd.Prepare()
		self._cmd.Parameters["@1"].Value = obj.Codigo
		self._cmd.Parameters["@2"].Value = obj.Nome
		self._cmd.Parameters["@3"].Value = obj.Bmp16
		self._cmd.Parameters["@4"].Value = obj.Bmp32
		ret = self._cmd.ExecuteNonQuery()
		return ret

	def excluir(self, codigo):
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand("delete from Extensoes where cod=@1", self._conexao)
		self._cmd.Parameters.AddWithValue("@1", codigo)
		self._cmd.Prepare()
		ret = self._cmd.ExecuteNonQuery()
		return ret

	def excluirTudo(self):
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand("delete from Extensoes", self._conexao)
		ret = self._cmd.ExecuteNonQuery()
		return ret

	def criarTabela(self):
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand("create table IF NOT EXISTS Extensoes(" + "cod integer not null," + "nome varchar(20) not null," + "bmp16 BLOB COLLATE NOCASE null," + "bmp32 BLOB COLLATE NOCASE null," + "primary key (cod))", self._conexao)
		ret = self._cmd.ExecuteNonQuery()
		return ret