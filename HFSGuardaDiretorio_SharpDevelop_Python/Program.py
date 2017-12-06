# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 10/12/2014
# * Time: 17:39
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
import clr
clr.AddReference('System.Windows.Forms')
clr.AddReference('System.Drawing')

from System.Windows.Forms import Application

from catalogador import Catalogador
from gui import FrmPrincipal 

#Catalogador.iniciarSistema()
#Rotinas.iniciarLogArquivo(log);
Application.EnableVisualStyles()
Application.SetCompatibleTextRenderingDefault(False)
form = FrmPrincipal.FrmPrincipal()
Application.Run(form)
