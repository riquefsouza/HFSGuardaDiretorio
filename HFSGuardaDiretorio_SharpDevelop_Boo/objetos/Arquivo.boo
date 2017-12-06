/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 10/12/2014
 * Time: 17:41
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetos

import System

public class Arquivo:

	private nome as string

	private tamanho as decimal

	private modificado as DateTime

	private atributos as string

	
	public def constructor():
		self.nome = ''
		self.tamanho = 0
		self.modificado = DateTime.Now
		self.atributos = ''

	
	public def constructor(nome as string, tamanho as decimal, modificado as DateTime, atributos as string):
		self.nome = nome
		self.tamanho = tamanho
		self.modificado = modificado
		self.atributos = atributos

	
	public Nome as string:
		get:
			return nome
		set:
			nome = value

	
	public Tamanho as decimal:
		get:
			return tamanho
		set:
			tamanho = value

	
	public Modificado as DateTime:
		get:
			return modificado
		set:
			modificado = value

	
	public Atributos as string:
		get:
			return atributos
		set:
			atributos = value
	
	

