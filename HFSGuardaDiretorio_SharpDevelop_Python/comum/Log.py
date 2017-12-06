# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 15:10
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *

class Log(object):
	""" <summary>
	 Description of Log.
	 </summary>
	"""

	class MessageType(object):
		def __init__(self):
			self._Informational = 1
			self._Failure = 2
			self._Warning = 3
			self._Error = 4

	def RecordMessage(self, Message, Severity):
		pass

	def RecordMessage(self, Message, Severity):
		pass