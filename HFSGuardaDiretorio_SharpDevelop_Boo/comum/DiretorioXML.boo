/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 03/07/2015
 * Time: 14:53
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.comum

import System
import HFSGuardaDiretorio.objetos

public class DiretorioXML:

	private diretorio as Diretorio

	
	public def constructor():
		self.diretorio = Diretorio()

	
	public Diretorio as Diretorio:
		get:
			return diretorio
		set:
			diretorio = value
	

