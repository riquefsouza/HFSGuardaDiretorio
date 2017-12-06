/*
 * Created by SharpDevelop.
 * User: henrique.souza
 * Date: 03/07/2015
 * Time: 15:19
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */


namespace HFSGuardaDiretorio.comum

import System
import System.IO
import System.Collections.Generic

public class StringList(List[of string]):

	public def constructor():
		pass

	
	public def constructor(capacidadeInicial as int):
		self.Capacity = capacidadeInicial

	
	public def constructor(str as string, separador as char):
		
		if str.IndexOf(separador) > 0:
			partes as (char) = str.ToCharArray()
			pedaco = ''
			for i in range(0, partes.Length):
				pedaco += partes[i]
				if partes[i] == separador:
					super.Add(pedaco.Substring(0, (pedaco.Length - 1)))
					pedaco = ''
			super.Add(pedaco)

	
	public def constructor(texto as string):
		pedacos as (string) = texto.Split(char('\n'))
		super.AddRange(pedacos)

	
	public def getText() as string:
		ret = ''
		for i in range(0, super.Count):
		
			ret += self[i]
		
		return ret

	
	public def LoadFromFile(arquivo as string):
		fileStream as FileStream = null
		reader as StreamReader = null
		linha as String
		
		try:
			fileStream = FileStream(arquivo, FileMode.Open, FileAccess.Read)
			reader = StreamReader(fileStream)
			while (linha = reader.ReadLine()) is not null:
				self.Add(linha)
		ensure:
			if reader is not null:
				reader.Close()

	
	public def SaveToFile(arquivo as String):
		fileStream as FileStream = null
		writer as StreamWriter = null
		try:
			fileStream = FileStream(arquivo, FileMode.OpenOrCreate, FileAccess.Write)
			writer = StreamWriter(fileStream)
			for linha as String in self:
				writer.WriteLine(linha)
				writer.Flush()
		ensure:
			if writer is not null:
				writer.Close()
	

