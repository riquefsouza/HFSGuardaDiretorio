# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 06/07/2015
# * Time: 11:30
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from System.Data import *
from System.Data.SQLite import *
from System.Collections.Generic import *
from HFSGuardaDiretorio.comum import *
from HFSGuardaDiretorio.objetos import *
from HFSGuardaDiretorio.objetosbo import *

class DiretorioDAO(object):
	""" <summary>
	 Description of DiretorioDAO.
	 </summary>
	"""
	def get_Instancia(self):
		return self._instancia

	Instancia = property(fget=get_Instancia)

	def __init__(self):
		self._instancia = DiretorioDAO()
		self._dr = None

	def fecharSqlPreparado(self):
		if self._dr != None:
			self._dr.Close()

	def novoObjeto(self, dr):
		ret = Diretorio()
		aba = Aba()
		aba.Codigo = dr.GetInt32(0)
		ret.Codigo = dr.GetInt32(1)
		ret.Ordem = dr.GetInt32(2)
		if not dr.IsDBNull(3):
			ret.CodDirPai = dr.GetInt32(3)
		else:
			ret.CodDirPai = -1
		if not dr.IsDBNull(4):
			ret.Nome = dr.GetString(4)
		ret.Tamanho = dr.GetDecimal(5)
		tipo = Tipo(dr.GetString(6)[0], "")
		ret.Modificado = Rotinas.StringToDate(dr.GetString(7))
		if not dr.IsDBNull(8):
			ret.Atributos = dr.GetString(8)
		if not dr.IsDBNull(9):
			ret.Caminho = dr.GetString(9)
		if not dr.IsDBNull(10):
			aba.Nome = dr.GetString(10)
		ret.Aba = aba
		if not dr.IsDBNull(11):
			ret.NomePai = dr.GetString(11)
		if not dr.IsDBNull(12):
			ret.CaminhoPai = dr.GetString(12)
		ret.TamanhoFormatado = DiretorioBO.Instancia.MontaTamanho(ret.Tamanho)
		if tipo.Codigo == 'D':
			tipo.Nome = "Diretório"
		else:
			tipo.Nome = "Arquivo"
		ret.Tipo = tipo
		ret.ModificadoFormatado = Rotinas.formataDate(Rotinas.FORMATO_DATAHORA, ret.Modificado)
		return ret

	def consultarTotal(self, sSQL, sCondicaoTotal):
		if Rotinas.ContainsStr(sSQL, "consultadirpai"):
			sTabela = "consultadirpai"
		elif Rotinas.ContainsStr(sSQL, "consultadirfilho"):
			sTabela = "consultadirfilho"
		elif Rotinas.ContainsStr(sSQL, "consultaarquivo"):
			sTabela = "consultaarquivo"
		else:
			sTabela = "Diretorios"
		sSQL = "select count(*) from " + sTabela
		if sCondicaoTotal.Trim().Length > 0:
			sSQL += " " + sCondicaoTotal
		total = 0
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand(sSQL, self._conexao)
		self._dr = self._cmd.ExecuteReader()
		if self._dr.Read():
			total = self._dr.GetInt32(0)
		self.fecharSqlPreparado()
		return total

	def consultarTudo(self, sSQL, sCondicaoTotal, progressoLog):
		lista = List[Diretorio]()
		i = 0
		total = self.consultarTotal(sSQL, sCondicaoTotal)
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand(sSQL, self._conexao)
		self._dr = self._cmd.ExecuteReader()
		if total > 0:
			pb = Progresso()
			pb.Minimo = 0
			pb.Maximo = total - 1
			pb.Posicao = 0
			pb.Passo = 1
			while self._dr.Read():
				obj = self.novoObjeto(self._dr)
				lista.Add(obj)
				pb.Posicao = i
				if progressoLog != None:
					progressoLog.ProgressoLog(pb)
				i += 1
		self.fecharSqlPreparado()
		return lista

	def atribuirCampos(self, cmd, obj):
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

	def incluir(self, obj):
		try:
			self._conexao = Rotinas.getConexao()
			self._cmd = SQLiteCommand("insert into Diretorios(aba, cod, ordem, coddirpai, nome, tam," + " tipo, modificado, atributos, caminho)" + " values (@1,@2,@3,@4,@5,@6,@7,@8,@9,@10)", self._conexao)
			self.atribuirCampos(self._cmd, obj)
			self._cmd.Prepare()
			ret = self._cmd.ExecuteNonQuery()
		except Exception:
			raise 

		return ret

	def excluir(self, aba, sCaminho):
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand("delete from Diretorios where caminho like @1 and aba=@2", self._conexao)
		self._cmd.Parameters.AddWithValue("@1", sCaminho + "%")
		self._cmd.Parameters.AddWithValue("@2", aba.Codigo)
		self._cmd.Prepare()
		ret = self._cmd.ExecuteNonQuery()
		return ret

	def criarTabela(self):
		sSQL = "create table if NOT EXISTS Diretorios(" + "aba int not null," + "cod int not null," + "ordem int not null," + "nome varchar(255) not null," + "tam numeric not null," + "tipo char(1) not null," + "modificado date not null," + "atributos varchar(20) not null," + "coddirpai int not null," + "caminho varchar(255) not null," + "primary key (aba, cod, ordem))"
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand(sSQL, self._conexao)
		ret = self._cmd.ExecuteNonQuery()
		return ret