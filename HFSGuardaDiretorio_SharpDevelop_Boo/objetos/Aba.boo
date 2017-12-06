/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 10/12/2014
 * Time: 17:51
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetos

import System

public class Aba:

	private codigo as int

	private nome as string

	private ordem as int

	
	public def constructor():
		self.codigo = 0
		self.nome = ''
		self.ordem = 0

	
	public def constructor(codigo as int, nome as string, ordem as int):
		self.codigo = codigo
		self.nome = nome
		self.ordem = ordem

	
	public Codigo as int:
		get:
			return codigo
		set:
			codigo = value

	
	public Nome as string:
		get:
			return nome
		set:
			nome = value

	
	public Ordem as int:
		get:
			return ordem
		set:
			ordem = value
	

