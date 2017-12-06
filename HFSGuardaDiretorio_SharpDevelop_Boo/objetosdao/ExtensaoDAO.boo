/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 06/07/2015
 * Time: 11:14
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetosdao

import System
import System.Data
import System.Data.SQLite
import System.Collections.Generic
import HFSGuardaDiretorio.comum
import HFSGuardaDiretorio.objetos

public final class ExtensaoDAO:

	private static instancia = ExtensaoDAO()

	
	private conexao as SQLiteConnection

	
	private cmd as SQLiteCommand

	
	private dr as SQLiteDataReader = null

	
	public static Instancia as ExtensaoDAO:
		get:
			return instancia

	
	private def constructor():
		pass

	
	private def fecharSqlPreparado():
		if dr is not null:
			dr.Close()

	
	private def novoObjeto(dr as SQLiteDataReader) as Extensao:
		ret = Extensao()
		ret.Codigo = dr.GetInt32(0)
		ret.Nome = dr.GetString(1)
		ret.Bmp16 = (dr.GetValue(2) cast (byte))
		ret.Bmp32 = (dr.GetValue(3) cast (byte))
		
		return ret

	
	public def consultarTotal() as int:
		total = 0
		conexao = Rotinas.getConexao()
		cmd = SQLiteCommand('select count(*) from Extensoes', conexao)
		dr = cmd.ExecuteReader()
		
		if dr.Read():
			total = dr.GetInt32(0)
		self.fecharSqlPreparado()
		
		return total

	
	public def consultarTudo(progressoLog as IProgressoLog) as List[of Extensao]:
		obj as Extensao
		lista as List[of Extensao] = List[of Extensao]()
		pb as Progresso
		i = 0
		total as int = self.consultarTotal()
		
		conexao = Rotinas.getConexao()
		cmd = SQLiteCommand('select cod, nome, bmp16, bmp32 from Extensoes', conexao)
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

	
	public def incluir(obj as Extensao) as int:
		ret as int
		conexao = Rotinas.getConexao()
		cmd = SQLiteCommand('insert into Extensoes(cod, nome, bmp16, bmp32) values(@1,@2,@3,@4)', conexao)
		cmd.Parameters.Add('@1', DbType.Int32)
		cmd.Parameters.Add('@2', DbType.String, 20)
		cmd.Parameters.Add('@3', DbType.Binary, 1000000)
		cmd.Parameters.Add('@4', DbType.Binary, 1000000)
		/*
	        cmd.Parameters.AddWithValue("@1", obj.Codigo);
	        cmd.Parameters.AddWithValue("@2", obj.Nome);
	        cmd.Parameters.AddWithValue("@3", obj.Bmp16);
	        cmd.Parameters.AddWithValue("@4", obj.Bmp32);
	        */
		
		cmd.Prepare()
		
		cmd.Parameters['@1'].Value = obj.Codigo
		cmd.Parameters['@2'].Value = obj.Nome
		cmd.Parameters['@3'].Value = obj.Bmp16
		cmd.Parameters['@4'].Value = obj.Bmp32
		
		ret = cmd.ExecuteNonQuery()
		return ret

	
	public def excluir(codigo as int) as int:
		ret as int
		conexao = Rotinas.getConexao()
		
		cmd = SQLiteCommand('delete from Extensoes where cod=@1', conexao)
		cmd.Parameters.AddWithValue('@1', codigo)
		cmd.Prepare()
		ret = cmd.ExecuteNonQuery()
		
		return ret

	
	public def excluirTudo() as int:
		ret as int
		conexao = Rotinas.getConexao()
		
		cmd = SQLiteCommand('delete from Extensoes', conexao)
		ret = cmd.ExecuteNonQuery()
		
		return ret

	
	public def criarTabela() as int:
		ret as int
		conexao = Rotinas.getConexao()
		cmd = SQLiteCommand(((((('create table IF NOT EXISTS Extensoes(' + 'cod integer not null,') + 'nome varchar(20) not null,') + 'bmp16 BLOB COLLATE NOCASE null,') + 'bmp32 BLOB COLLATE NOCASE null,') + 'primary key (cod))'), conexao)
		ret = cmd.ExecuteNonQuery()
		return ret
	

