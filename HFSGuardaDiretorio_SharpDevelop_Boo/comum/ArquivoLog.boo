
namespace HFSGuardaDiretorio.comum

import System
import System.IO
import System.Text

public class ArquivoLog(Log):

	
	private _FileName = ''

	
	public FileName as string:
		get:
			return self._FileName
		set:
			self._FileName = value

	
	private _FileLocation = ''

	
	public FileLocation as string:
		get:
			return self._FileLocation
		set:
			self._FileLocation = value
			if self._FileLocation.LastIndexOf('\\') != (self._FileLocation.Length - 1):
				self._FileLocation += '\\'

	
	public def constructor():
		self.FileLocation = 'C:\\'
		self.FileName = 'mylog.txt'

	
	public override def RecordMessage(Message as Exception, Severity as Log.MessageType):
		self.RecordMessage(Message.Message, Severity)

	
	public override def RecordMessage(Message as string, Severity as Log.MessageType):
		fileStream as FileStream = null
		writer as StreamWriter = null
		message = StringBuilder()
		try:
			fileStream = FileStream((self._FileLocation + self._FileName), FileMode.OpenOrCreate, FileAccess.Write)
			writer = StreamWriter(fileStream)
			writer.BaseStream.Seek(0, SeekOrigin.End)
			message.Append(System.DateTime.Now.ToString()).Append(',').Append(Message)
			writer.WriteLine(message.ToString())
			writer.Flush()
		ensure:
			if writer is not null:
				writer.Close()

