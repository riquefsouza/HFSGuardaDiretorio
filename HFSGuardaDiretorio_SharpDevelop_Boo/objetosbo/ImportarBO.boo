/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 07/07/2015
 * Time: 10:55
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetosbo

import System
import System.Collections.Generic
import HFSGuardaDiretorio.comum
import HFSGuardaDiretorio.objetos

public final class ImportarBO:

	private static instancia = ImportarBO()

	
	public static Instancia as ImportarBO:
		get:
			return instancia

	
	private def constructor():
		pass

	
	public def CarregarListaDiretorios(importar as Importar, dirOrdem as DiretorioOrdem, listaDiretorio as List[of Diretorio], progressoLog as IProgressoLog):
		arquivo as Arquivo
		diretorio as Diretorio
		pb = Progresso()
		
		arquivo = Arquivo()
		arquivo.Nome = importar.RotuloRaiz
		arquivo.Tamanho = 0
		arquivo.Modificado = DateTime.Now
		arquivo.Atributos = '[DIR]'
		
		diretorio = DiretorioBO.Instancia.atribuiDiretorio(importar.Aba, importar.CodDirRaiz, importar.NomeDirRaiz, '', true, listaDiretorio, arquivo, dirOrdem)
		
		listaDiretorio.Add(diretorio)
		pb.Log = importar.Caminho
		
		DiretorioBO.Instancia.ImportarDiretorio(importar.Aba, importar.CodDirRaiz, importar.NomeDirRaiz, importar.Caminho, listaDiretorio, dirOrdem, progressoLog)
		
		if progressoLog is not null:
			progressoLog.ProgressoLog(pb)

	
	public def ImportacaoCompleta(importar as Importar, dirOrdem as DiretorioOrdem, listaExtensao as List[of Extensao], progressoLog as IProgressoLog):
		listaDiretorio as List[of Diretorio] = List[of Diretorio]()
		
		try:
			CarregarListaDiretorios(importar, dirOrdem, listaDiretorio, progressoLog)
			
			/*
		        //Por ser multiplataforma nao tem funcao para pegar icone de arquivo        
		        ExtensaoBO.Instancia.salvarExtensoes(listaDiretorio,
		                listaExtensao, progressoLog);
		        */
			
			DiretorioBO.Instancia.salvarDiretorio(listaDiretorio, progressoLog)
			
			listaDiretorio.Clear()
		except converterGeneratedName1 as Exception:
			raise 
		
	

