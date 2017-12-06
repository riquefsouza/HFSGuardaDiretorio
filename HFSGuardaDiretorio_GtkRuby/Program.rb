require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "System.IO, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "Gtk, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.gui, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.catalogador, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio
	class MainClass
		def MainClass.Main(args)
			Application.Init()
			Catalogador.iniciarSistema()
			#Rotinas.iniciarLogArquivo(log);
			frmPrincipal = FrmPrincipal.new()
			frmPrincipal.Show()
			Application.Run()
		end
	end
end

MainClass.Main(nil)