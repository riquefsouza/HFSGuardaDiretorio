/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 03/07/2015
 * Time: 14:29
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.objetos

import System

public class ConexaoParams:

	private nome as string

	private driver as string

	private url as string

	private login as string

	private senha as string

	
	public def constructor():
		self.nome = ''
		self.driver = ''
		self.url = ''
		self.login = ''
		self.senha = ''

	
	public Nome as string:
		get:
			return nome
		set:
			nome = value

	
	public Driver as string:
		get:
			return driver
		set:
			driver = value

	
	public Url as string:
		get:
			return url
		set:
			url = value

	
	public Login as string:
		get:
			return login
		set:
			login = value

	
	public Senha as string:
		get:
			return senha
		set:
			senha = value

