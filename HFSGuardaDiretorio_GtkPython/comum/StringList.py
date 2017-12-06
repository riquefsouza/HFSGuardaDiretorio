# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 15:19
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *
from System.IO import *
from System.Collections.Generic import *

class StringList(List):
	""" <summary>
	 Description of StringList.
	 </summary>
	"""
	def __init__(self, texto):
		pedacos = texto.Split('\n')
		self.AddRange(pedacos)

	def __init__(self, texto):
		pedacos = texto.Split('\n')
		self.AddRange(pedacos)

	def __init__(self, texto):
		pedacos = texto.Split('\n')
		self.AddRange(pedacos)

	def __init__(self, texto):
		pedacos = texto.Split('\n')
		self.AddRange(pedacos)

	def getText(self):
		ret = ""
		i = 0
		while i < self.Count:
			ret += self[i]
			i += 1
		return ret

	def LoadFromFile(self, arquivo):
		fileStream = None
		reader = None
		try:
			fileStream = FileStream(arquivo, FileMode.Open, FileAccess.Read)
			reader = StreamReader(fileStream)
			while (linha = reader.ReadLine()) != None:
				self.Add(linha)
		finally:
			if reader != None:
				reader.Close()

	def SaveToFile(self, arquivo):
		fileStream = None
		writer = None
		try:
			fileStream = FileStream(arquivo, FileMode.OpenOrCreate, FileAccess.Write)
			writer = StreamWriter(fileStream)
			enumerator = .GetEnumerator()
			while enumerator.MoveNext():
				linha = enumerator.Current
				writer.WriteLine(linha)
				writer.Flush()
		finally:
			if writer != None:
				writer.Close()