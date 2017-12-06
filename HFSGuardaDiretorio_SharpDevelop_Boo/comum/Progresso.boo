/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 03/07/2015
 * Time: 15:12
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.comum

import System

public class Progresso:

	private minimo as int

	private maximo as int

	private posicao as int

	private passo as int

	private log as string

	
	public def constructor():
		self.log = ''

	
	public Minimo as int:
		get:
			return minimo
		set:
			minimo = value

	
	public Maximo as int:
		get:
			return maximo
		set:
			maximo = value

	
	public Posicao as int:
		get:
			return posicao
		set:
			posicao = value

	
	public Passo as int:
		get:
			return passo
		set:
			passo = value

	
	public Log as string:
		get:
			return log
		set:
			log = value
	

