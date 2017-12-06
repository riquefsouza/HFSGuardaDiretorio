/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 03/07/2015
 * Time: 14:44
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetos

import System

public class Tipo:

	private codigo as char

	private nome as string

	
	public def constructor():
		self.codigo = char(' ')
		self.nome = ''

	
	public def constructor(codigo as char, nome as string):
		self.codigo = codigo
		self.nome = nome

	
	public Codigo as char:
		get:
			return codigo
		set:
			codigo = value

	
	public Nome as string:
		get:
			return nome
		set:
			nome = value
	

