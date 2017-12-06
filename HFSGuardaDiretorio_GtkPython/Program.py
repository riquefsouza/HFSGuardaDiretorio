from System import *
from System.IO import *
from Gtk import *
from HFSGuardaDiretorio.gui import *
from HFSGuardaDiretorio.catalogador import *

class MainClass(object):
	def Main(args):
		Application.Init()
		Catalogador.iniciarSistema()
		#Rotinas.iniciarLogArquivo(log);
		frmPrincipal = FrmPrincipal()
		frmPrincipal.Show()
		Application.Run()

	Main = staticmethod(Main)

MainClass.Main(None)