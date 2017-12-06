require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.IO, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Text, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.comum
	class ArquivoLog < Log
		def FileName
			return self.@_FileName
		end

		def FileName=(value)
			self.@_FileName = value
		end

		def FileLocation
			return self.@_FileLocation
		end

		def FileLocation=(value)
			self.@_FileLocation = value
			if self.@_FileLocation.LastIndexOf("\\") != (self.@_FileLocation.Length - 1) then
				self.@_FileLocation
			end
		end

		def initialize()
			@_FileName = ""
			@_FileLocation = ""
			self.FileLocation = "C:\\"
			self.FileName = "mylog.txt"
		end

		def RecordMessage(Message, Severity)
			self.RecordMessage(Message.Message, Severity)
		end

		def RecordMessage(Message, Severity)
			fileStream = nil
			writer = nil
			message = StringBuilder.new()
			begin
				fileStream = FileStream.new(self.@_FileLocation + self.@_FileName, FileMode.OpenOrCreate, FileAccess.Write)
				writer = StreamWriter.new(fileStream)
				writer.BaseStream.Seek(0, SeekOrigin.End)
				message.Append(System.DateTime.Now.ToString()).Append(",").Append(Message)
				writer.WriteLine(message.ToString())
				writer.Flush()
			ensure
				if writer != nil then
					writer.Close()
				end
			end
		end
	end
end