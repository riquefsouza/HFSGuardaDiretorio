/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 06/07/2015
 * Time: 11:30
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetosdao

import System
import System.Data.SQLite
import System.Collections.Generic
import HFSGuardaDiretorio.comum
import HFSGuardaDiretorio.objetos
import HFSGuardaDiretorio.objetosbo

public final class DiretorioDAO:

	private static instancia = DiretorioDAO()

	
	private conexao as SQLiteConnection

	
	private cmd as SQLiteCommand

	
	private dr as SQLiteDataReader = null

	
	public static Instancia as DiretorioDAO:
		get:
			return instancia

	
	private def constructor():
		pass

	
	private def fecharSqlPreparado():
		if dr is not null:
			dr.Close()

	
	private def novoObjeto(dr as SQLiteDataReader) as Diretorio:
		ret = Diretorio()
		aba = Aba()
		tipo as Tipo
		
		aba.Codigo = dr.GetInt32(0)
		ret.Codigo = dr.GetInt32(1)
		ret.Ordem = dr.GetInt32(2)
		
		if not dr.IsDBNull(3):
			ret.CodDirPai = dr.GetInt32(3)
		else:
			ret.CodDirPai = (-1)
		
		if not dr.IsDBNull(4):
			ret.Nome = dr.GetString(4)
		
		ret.Tamanho = dr.GetDecimal(5)
		
		tipo = Tipo(dr.GetString(6)[0], '')
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
		if tipo.Codigo == char('D'):
			tipo.Nome = 'Diretório'
		else:
			tipo.Nome = 'Arquivo'
		ret.Tipo = tipo
		ret.ModificadoFormatado = Rotinas.formataDate(Rotinas.FORMATO_DATAHORA, ret.Modificado)
		
		return ret

	
	public def consultarTotal(sSQL as string, sCondicaoTotal as string) as int:
		sTabela as string
		
		if Rotinas.ContainsStr(sSQL, 'consultadirpai'):
			sTabela = 'consultadirpai'
		elif Rotinas.ContainsStr(sSQL, 'consultadirfilho'):
			sTabela = 'consultadirfilho'
		elif Rotinas.ContainsStr(sSQL, 'consultaarquivo'):
			sTabela = 'consultaarquivo'
		else:
			sTabela = 'Diretorios'
		
		sSQL = ('select count(*) from ' + sTabela)
		if sCondicaoTotal.Trim().Length > 0:
			sSQL += (' ' + sCondicaoTotal)
		total = 0
		conexao = Rotinas.getConexao()
		cmd = SQLiteCommand(sSQL, conexao)
		dr = cmd.ExecuteReader()
		
		if dr.Read():
			total = dr.GetInt32(0)
		self.fecharSqlPreparado()
		
		return total

	
	public def consultarTudo(sSQL as String, sCondicaoTotal as String, progressoLog as IProgressoLog) as List[of Diretorio]:
		obj as Diretorio
		lista as List[of Diretorio] = List[of Diretorio]()
		pb as Progresso
		i = 0
		total as int = self.consultarTotal(sSQL, sCondicaoTotal)
		
		conexao = Rotinas.getConexao()
		cmd = SQLiteCommand(sSQL, conexao)
		dr = cmd.ExecuteReader()
		
		if total > 0:
			pb = Progresso()
			pb.Minimo = 0
			pb.Maximo = (total - 1)
			pb.Posicao = 0
			pb.Passo = 1
			
			while dr.Read():
				obj = novoObjeto(dr)
				
				lista.Add(obj)
				
				pb.Posicao = i
				
				if progressoLog is not null:
					progressoLog.ProgressoLog(pb)
				
				i += 1
		
		self.fecharSqlPreparado()
		
		return lista

	
	private def atribuirCampos(cmd as SQLiteCommand, obj as Diretorio):
		cmd.Parameters.AddWithValue('@1', obj.Aba.Codigo)
		cmd.Parameters.AddWithValue('@2', obj.Codigo)
		cmd.Parameters.AddWithValue('@3', obj.Ordem)
		cmd.Parameters.AddWithValue('@4', obj.CodDirPai)
		cmd.Parameters.AddWithValue('@5', obj.Nome)
		cmd.Parameters.AddWithValue('@6', obj.Tamanho)
		cmd.Parameters.AddWithValue('@7', obj.Tipo.Codigo.ToString())
		cmd.Parameters.AddWithValue('@8', Rotinas.formataDate(Rotinas.FORMATO_DATAHORA, obj.Modificado))
		cmd.Parameters.AddWithValue('@9', obj.Atributos)
		cmd.Parameters.AddWithValue('@10', obj.Caminho)

	
	public def incluir(obj as Diretorio) as int:
		ret as int
		
		try:
			conexao = Rotinas.getConexao()
			cmd = SQLiteCommand((('insert into Diretorios(aba, cod, ordem, coddirpai, nome, tam,' + ' tipo, modificado, atributos, caminho)') + ' values (@1,@2,@3,@4,@5,@6,@7,@8,@9,@10)'), conexao)
			atribuirCampos(cmd, obj)
			cmd.Prepare()
			ret = cmd.ExecuteNonQuery()
		except converterGeneratedName1 as Exception:
			raise 
		
		return ret

	
	public def excluir(aba as Aba, sCaminho as string) as int:
		ret as int
		conexao = Rotinas.getConexao()
		
		cmd = SQLiteCommand('delete from Diretorios where caminho like @1 and aba=@2', conexao)
		cmd.Parameters.AddWithValue('@1', (sCaminho + '%'))
		cmd.Parameters.AddWithValue('@2', aba.Codigo)
		cmd.Prepare()
		ret = cmd.ExecuteNonQuery()
		
		return ret

	
	public def criarTabela() as int:
		sSQL as string
		ret as int
		
		sSQL = ((((((((((('create table if NOT EXISTS Diretorios(' + 'aba int not null,') + 'cod int not null,') + 'ordem int not null,') + 'nome varchar(255) not null,') + 'tam numeric not null,') + 'tipo char(1) not null,') + 'modificado date not null,') + 'atributos varchar(20) not null,') + 'coddirpai int not null,') + 'caminho varchar(255) not null,') + 'primary key (aba, cod, ordem))')
		
		conexao = Rotinas.getConexao()
		cmd = SQLiteCommand(sSQL, conexao)
		ret = cmd.ExecuteNonQuery()
		return ret
	

