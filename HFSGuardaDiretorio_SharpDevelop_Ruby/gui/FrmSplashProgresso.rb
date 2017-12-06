# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 07/07/2015
# * Time: 13:47
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.gui
	# <summary>
	# Description of FrmSplashProgresso.
	# </summary>
	class FrmSplashProgresso < IProgressoLog
		def initialize(form)
			self.@form = form
		end

		def ProgressoLog(progresso)
			if progresso.Posicao == 0 then
				self.@form.pb.Minimum = progresso.Minimo
				self.@form.pb.Maximum = progresso.Maximo
				self.@form.pb.Step = progresso.Passo
			end
			self.@form.pb.Value = progresso.Posicao
			self.@form.pb.Update()
		end
	end
end