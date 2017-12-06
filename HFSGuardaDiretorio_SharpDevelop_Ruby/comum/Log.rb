# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 15:10
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.comum
	# <summary>
	# Description of Log.
	# </summary>
	class Log
		class MessageType
			def initialize()
				@Informational = 1
				@Failure = 2
				@Warning = 3
				@Error = 4
			end
		end

		def RecordMessage(Message, Severity)
		end

		def RecordMessage(Message, Severity)
		end
	end
end