# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 10/12/2014
# * Time: 17:39
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 

require "mscorlib"
require "System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
require "System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
#require "HFSGuardaDiretorio.gui, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
#require "HFSGuardaDiretorio.catalogador, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
Dir['./**/*.rb'].each{ |f| require f }

module HFSGuardaDiretorio
	Application = System::Windows::Forms::Application
	
	#HFSGuardaDiretorio::catalogador::Catalogador.iniciarSistema()
	#Rotinas.iniciarLogArquivo(log);
	Application.EnableVisualStyles()
	Application.SetCompatibleTextRenderingDefault(false)
	Application.Run(FrmPrincipal.new())
end
