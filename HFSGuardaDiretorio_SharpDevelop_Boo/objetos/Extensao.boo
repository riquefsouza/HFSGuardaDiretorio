/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 10/12/2014
 * Time: 17:58
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetos

import System

public class Extensao:

	private codigo as int

	private nome as string

	private ordem as int

	private bmp16 as (byte)

	private bmp32 as (byte)

	
	public def constructor():
		self.codigo = 0
		self.nome = ''
		self.ordem = 0
		self.bmp16 = null
		self.bmp32 = null

	
	public def constructor(codigo as int, nome as String, ordem as int, bmp16 as (byte), bmp32 as (byte)):
		self.codigo = codigo
		self.nome = nome
		self.ordem = ordem
		self.bmp16 = bmp16
		self.bmp32 = bmp32

	
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

	
	public Bmp16 as (byte):
		get:
			return bmp16
		set:
			bmp16 = value

	
	public Bmp32 as (byte):
		get:
			return bmp32
		set:
			bmp32 = value

