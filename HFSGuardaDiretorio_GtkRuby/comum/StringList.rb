# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 15:19
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.IO, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.Collections.Generic, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.comum
	# <summary>
	# Description of StringList.
	# </summary>
	class StringList < List
		def initialize(texto)
			pedacos = texto.Split('\n')
			self.AddRange(pedacos)
		end

		def initialize(texto)
			pedacos = texto.Split('\n')
			self.AddRange(pedacos)
		end

		def initialize(texto)
			pedacos = texto.Split('\n')
			self.AddRange(pedacos)
		end

		def initialize(texto)
			pedacos = texto.Split('\n')
			self.AddRange(pedacos)
		end

		def getText()
			ret = ""
			i = 0
			while i < self.Count
				ret += self[i]
				i += 1
			end
			return ret
		end

		def LoadFromFile(arquivo)
			fileStream = nil
			reader = nil
			begin
				fileStream = FileStream.new(arquivo, FileMode.Open, FileAccess.Read)
				reader = StreamReader.new(fileStream)
				while (linha = reader.ReadLine()) != nil
					self.Add(linha)
				end
			ensure
				if reader != nil then
					reader.Close()
				end
			end
		end

		def SaveToFile(arquivo)
			fileStream = nil
			writer = nil
			begin
				fileStream = FileStream.new(arquivo, FileMode.OpenOrCreate, FileAccess.Write)
				writer = StreamWriter.new(fileStream)
				enumerator = .GetEnumerator()
				while enumerator.MoveNext()
					linha = enumerator.Current
					writer.WriteLine(linha)
					writer.Flush()
				end
			ensure
				if writer != nil then
					writer.Close()
				end
			end
		end
	end
end