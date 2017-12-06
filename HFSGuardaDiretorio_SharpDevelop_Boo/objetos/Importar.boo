/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 03/07/2015
 * Time: 14:41
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetos

import System

public class Importar:

	private aba as int

	private codDirRaiz as int

	private rotuloRaiz as string

	private nomeDirRaiz as string

	private caminho as string

	
	public def constructor():
		self.aba = 0
		self.codDirRaiz = 0
		self.rotuloRaiz = ''
		self.nomeDirRaiz = ''
		self.caminho = ''

	
	public Aba as int:
		get:
			return aba
		set:
			aba = value

	
	public CodDirRaiz as int:
		get:
			return codDirRaiz
		set:
			codDirRaiz = value

	
	public RotuloRaiz as string:
		get:
			return rotuloRaiz
		set:
			rotuloRaiz = value

	
	public NomeDirRaiz as string:
		get:
			return nomeDirRaiz
		set:
			nomeDirRaiz = value

	
	public Caminho as string:
		get:
			return caminho
		set:
			caminho = value
	

