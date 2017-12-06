# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 17:17
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from System.Data import *
from System.Data.SQLite import *
from HFSGuardaDiretorio.comum import *

class VisaoDAO(object):
	""" <summary>
	 Description of VisaoDAO.
	 </summary>
	"""
	def get_Instancia(self):
		return self._instancia

	Instancia = property(fget=get_Instancia)

	def __init__(self):
		self._instancia = VisaoDAO()

	def criarVisao(self, visao):
		self._conexao = Rotinas.getConexao()
		self._cmd = SQLiteCommand(self.sqlVisao(visao), self._conexao)
		ret = self._cmd.ExecuteNonQuery()
		return ret

	def sqlVisao(self, visao):
		sSQL = "create view " + visao + " as " + "SELECT d.aba,d.cod,d.ordem,d.coddirpai,d.nome,d.tam," + "d.tipo,d.modificado,d.atributos,d.caminho" + ",(select nome as nomeaba from Abas where cod=d.aba) as nomeaba" + ",(select nome as nomepai from Diretorios where cod=d.cod " + "  and ordem=d.coddirpai and aba=d.aba) as nomepai" + ",(select caminho as caminhopai from Diretorios where cod=d.cod " + " and ordem=d.coddirpai and aba=d.aba) as caminhopai " + "FROM Diretorios d "
		if visao.Equals("consultadirpai"):
			sSQL += "where d.tipo='D' and d.coddirpai = 0"
		elif visao.Equals("consultadirfilho"):
			sSQL += "where d.tipo='D' and d.coddirpai > 0"
		return sSQL