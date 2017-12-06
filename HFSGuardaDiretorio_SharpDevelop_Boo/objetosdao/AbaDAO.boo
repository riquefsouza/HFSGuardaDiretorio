/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 03/07/2015
 * Time: 17:27
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetosdao

import System
import System.Data.SQLite
import System.Collections.Generic
import HFSGuardaDiretorio.comum
import HFSGuardaDiretorio.objetos

public final class AbaDAO:

	private static instancia = AbaDAO()

	
	private conexao as SQLiteConnection

	
	private cmd as SQLiteCommand

	
	private dr as SQLiteDataReader = null

	
	public static Instancia as AbaDAO:
		get:
			return instancia

	
	private def constructor():
		pass

	
	private def fecharSqlPreparado():
		if dr is not null:
			dr.Close()

	
	private def novoObjeto(dr as SQLiteDataReader) as Aba:
		ret = Aba()
		ret.Codigo = dr.GetInt32(0)
		ret.Nome = dr.GetString(1)
		return ret

	
	public def consultarTotal() as int:
		total = 0
		conexao = Rotinas.getConexao()
		cmd = SQLiteCommand('select count(*) from Abas', conexao)
		dr = cmd.ExecuteReader()
		
		if dr.Read():
			total = dr.GetInt32(0)
		self.fecharSqlPreparado()
		
		return total

	
	public def consultarTudo(progressoLog as IProgressoLog) as List[of Aba]:
		obj as Aba
		lista as List[of Aba] = List[of Aba]()
		pb as Progresso
		i = 0
		total as int = self.consultarTotal()
		
		conexao = Rotinas.getConexao()
		cmd = SQLiteCommand('select cod, nome from Abas', conexao)
		dr = cmd.ExecuteReader()
		
		if total > 0:
			pb = Progresso()
			pb.Minimo = 0
			pb.Maximo = (total - 1)
			pb.Posicao = 0
			pb.Passo = 1
			
			while dr.Read():
				obj = novoObjeto(dr)
				obj.Ordem = (i + 1)
				
				lista.Add(obj)
				
				pb.Posicao = i
				
				if progressoLog is not null:
					progressoLog.ProgressoLog(pb)
				
				i += 1
		
		self.fecharSqlPreparado()
		
		return lista

	
	public def incluir(obj as Aba) as int:
		ret as int
		conexao = Rotinas.getConexao()
		cmd = SQLiteCommand('insert into Abas(cod, nome) values(@1,@2)', conexao)
		cmd.Parameters.AddWithValue('@1', obj.Codigo)
		cmd.Parameters.AddWithValue('@2', obj.Nome)
		cmd.Prepare()
		ret = cmd.ExecuteNonQuery()
		return ret

	
	public def alterar(obj as Aba) as int:
		ret as int
		conexao = Rotinas.getConexao()
		cmd = SQLiteCommand('update Abas set nome=@1 where cod=@2', conexao)
		cmd.Parameters.AddWithValue('@1', obj.Nome)
		cmd.Parameters.AddWithValue('@2', obj.Codigo)
		cmd.Prepare()
		ret = cmd.ExecuteNonQuery()
		return ret

	
	public def excluir(codigo as int) as int:
		ret as int
		conexao = Rotinas.getConexao()
		
		cmd = SQLiteCommand('delete from Diretorios where aba=@1', conexao)
		cmd.Parameters.AddWithValue('@1', codigo)
		cmd.Prepare()
		cmd.ExecuteNonQuery()
		
		cmd = SQLiteCommand('delete from Abas where cod=@1', conexao)
		cmd.Parameters.AddWithValue('@1', codigo)
		cmd.Prepare()
		ret = cmd.ExecuteNonQuery()
		
		return ret

	
	public def criarTabela() as int:
		ret as int
		conexao = Rotinas.getConexao()
		cmd = SQLiteCommand((('create table IF NOT EXISTS Abas(' + 'cod integer not null, nome varchar(10) not null, ') + 'primary key (cod))'), conexao)
		ret = cmd.ExecuteNonQuery()
		return ret
	

