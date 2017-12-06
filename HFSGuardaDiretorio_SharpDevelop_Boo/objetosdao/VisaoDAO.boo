/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 03/07/2015
 * Time: 17:17
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetosdao

import System
import System.Data.SQLite
import HFSGuardaDiretorio.comum

public final class VisaoDAO:

	private static instancia = VisaoDAO()

	
	private conexao as SQLiteConnection

	
	private cmd as SQLiteCommand

	
	public static Instancia as VisaoDAO:
		get:
			return instancia

	
	private def constructor():
		pass

	
	public def criarVisao(visao as string) as int:
		ret as int
		conexao = Rotinas.getConexao()
		cmd = SQLiteCommand(sqlVisao(visao), conexao)
		ret = cmd.ExecuteNonQuery()
		return ret

	
	private def sqlVisao(visao as string) as String:
		sSQL as string = (((((((((('create view ' + visao) + ' as ') + 'SELECT d.aba,d.cod,d.ordem,d.coddirpai,d.nome,d.tam,') + 'd.tipo,d.modificado,d.atributos,d.caminho') + ',(select nome as nomeaba from Abas where cod=d.aba) as nomeaba') + ',(select nome as nomepai from Diretorios where cod=d.cod ') + '  and ordem=d.coddirpai and aba=d.aba) as nomepai') + ',(select caminho as caminhopai from Diretorios where cod=d.cod ') + ' and ordem=d.coddirpai and aba=d.aba) as caminhopai ') + 'FROM Diretorios d ')
		
		if visao.Equals('consultadirpai'):
			sSQL += 'where d.tipo=\'D\' and d.coddirpai = 0'
		elif visao.Equals('consultadirfilho'):
			sSQL += 'where d.tipo=\'D\' and d.coddirpai > 0'
		
		return sSQL
	

