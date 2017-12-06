/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 03/07/2015
 * Time: 15:10
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.comum

import System

public abstract class Log:

	public enum MessageType:

		Informational = 1

		Failure = 2

		Warning = 3

		Error = 4

	public abstract def RecordMessage(Message as Exception, Severity as MessageType):
		pass

	public abstract def RecordMessage(Message as string, Severity as MessageType):
		pass

