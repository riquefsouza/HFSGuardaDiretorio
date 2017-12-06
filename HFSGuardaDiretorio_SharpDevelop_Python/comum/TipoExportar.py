# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 03/07/2015
# * Time: 15:44
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
from System import *

class TipoExportar(object):	
	
	def __init__(self):
		self.teTXT = 1
		self.teCSV = 2
		self.teHTML = 3
		self.teXML = 4
		self.teSQL = 5