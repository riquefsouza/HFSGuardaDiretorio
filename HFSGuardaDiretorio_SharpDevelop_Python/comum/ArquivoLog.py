from System import *
from System.IO import *
from System.Text import *

class ArquivoLog(Log):
	def get_FileName(self):
		return self.__FileName

	def set_FileName(self, value):
		self.__FileName = value

	FileName = property(fget=get_FileName, fset=set_FileName)

	def get_FileLocation(self):
		return self.__FileLocation

	def set_FileLocation(self, value):
		self.__FileLocation = value
		if self.__FileLocation.LastIndexOf("\\") != (self.__FileLocation.Length - 1):
			self.__FileLocation += "\\";

	FileLocation = property(fget=get_FileLocation, fset=set_FileLocation)

	def __init__(self):
		self.__FileName = ""
		self.__FileLocation = ""
		self.FileLocation = "C:\\"
		self.FileName = "mylog.txt"

	def RecordMessage(self, Message, Severity):
		self.RecordMessage(Message.Message, Severity)

	def RecordMessage(self, Message, Severity):
		fileStream = None
		writer = None
		message = StringBuilder()
		try:
			fileStream = FileStream(self.__FileLocation + self.__FileName, FileMode.OpenOrCreate, FileAccess.Write)
			writer = StreamWriter(fileStream)
			writer.BaseStream.Seek(0, SeekOrigin.End)
			message.Append(System.DateTime.Now.ToString()).Append(",").Append(Message)
			writer.WriteLine(message.ToString())
			writer.Flush()
		finally:
			if writer != None:
				writer.Close()