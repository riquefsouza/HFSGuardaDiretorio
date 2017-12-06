# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 06/07/2015
# * Time: 14:53
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from System.Collections.Generic import *
from HFSGuardaDiretorio.comum import *
from HFSGuardaDiretorio.objetos import *
from HFSGuardaDiretorio.objetosdao import *

class AbaBO(object):
	""" <summary>
	 Description of AbaBO.
	 </summary>
	"""
	def get_Instancia(self):
		return self._instancia

	Instancia = property(fget=get_Instancia)

	def __init__(self):
		self._instancia = AbaBO()

	def carregarAba(self, progressoLog):
		return AbaDAO.Instancia.consultarTudo(progressoLog)

	def retMaxCodAba(self, listaLocal):
		nMaior = 0
		enumerator = listaLocal.GetEnumerator()
		while enumerator.MoveNext():
			aba = enumerator.Current
			if aba.Codigo > nMaior:
				nMaior = aba.Codigo
		return nMaior + 1

	def abaToSQL(self, aba):
		return "insert into Abas(cod, nome) values(" + aba.Codigo + "," + Rotinas.QuotedStr(aba.Nome) + ")"

	def incluirAba(self, aba):
		return (AbaDAO.Instancia.incluir(aba) > 0)

	def alterarAba(self, aba):
		return (AbaDAO.Instancia.alterar(aba) > 0)

	def excluirAba(self, aba):
		return (AbaDAO.Instancia.excluir(aba.Codigo) > 0)

	def criarTabelaAbas(self):
		return (AbaDAO.Instancia.criarTabela() > 0)

	def pegaAbaPorOrdem(self, lista, ordem):
		enumerator = lista.GetEnumerator()
		while enumerator.MoveNext():
			aba = enumerator.Current
			if aba.Ordem == ordem:
				return aba
		return None

	def getElemento(self, lista, codigo):
		enumerator = lista.GetEnumerator()
		while enumerator.MoveNext():
			elemento = enumerator.Current
			if elemento.Codigo == codigo:
				return elemento
		return None

	def pegaAbaPorNome(self, lista, nome):
		enumerator = lista.GetEnumerator()
		while enumerator.MoveNext():
			aba = enumerator.Current
			if aba.Nome.Equals(nome):
				return aba
		return None