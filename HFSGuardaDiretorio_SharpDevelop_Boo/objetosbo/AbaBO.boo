/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 06/07/2015
 * Time: 14:53
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetosbo

import System
import System.Collections.Generic
import HFSGuardaDiretorio.comum
import HFSGuardaDiretorio.objetos
import HFSGuardaDiretorio.objetosdao

public final class AbaBO:

	private static instancia = AbaBO()

	
	public static Instancia as AbaBO:
		get:
			return instancia

	
	private def constructor():
		pass

	
	public def carregarAba(progressoLog as IProgressoLog) as List[of Aba]:
		return AbaDAO.Instancia.consultarTudo(progressoLog)

	
	public def retMaxCodAba(listaLocal as List[of Aba]) as int:
		nMaior = 0
		for aba as Aba in listaLocal:
			if aba.Codigo > nMaior:
				nMaior = aba.Codigo
		return (nMaior + 1)

	
	public def abaToSQL(aba as Aba) as string:
		return (((('insert into Abas(cod, nome) values(' + aba.Codigo) + ',') + Rotinas.QuotedStr(aba.Nome)) + ')')

	
	public def incluirAba(aba as Aba) as bool:
		return (AbaDAO.Instancia.incluir(aba) > 0)

	
	public def alterarAba(aba as Aba) as bool:
		return (AbaDAO.Instancia.alterar(aba) > 0)

	
	public def excluirAba(aba as Aba) as bool:
		return (AbaDAO.Instancia.excluir(aba.Codigo) > 0)

	
	public def criarTabelaAbas() as bool:
		return (AbaDAO.Instancia.criarTabela() > 0)

	
	public def pegaAbaPorOrdem(lista as List[of Aba], ordem as int) as Aba:
		for aba as Aba in lista:
			if aba.Ordem == ordem:
				return aba
		return null

	
	public def getElemento(lista as List[of Aba], codigo as int) as Aba:
		for elemento as Aba in lista:
			if elemento.Codigo == codigo:
				return elemento
		return null

	
	public def pegaAbaPorNome(lista as List[of Aba], nome as string) as Aba:
		for aba as Aba in lista:
			if aba.Nome.Equals(nome):
				return aba
		return null
	

