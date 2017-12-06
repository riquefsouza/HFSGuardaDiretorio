# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 08/07/2015
# * Time: 11:33
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "Gtk, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.gui
	# <summary>
	# Description of FrmPrincipalProgresso.
	# </summary>
	class FrmPrincipalProgresso < IProgressoLog
		def initialize(form)
			self.@form = form
		end

		def ProgressoLog(progresso)
			# 
			# if (progresso.Posicao == 0) {
			# this.form.PBar.Minimum = progresso.Minimo;
			# this.form.PBar.Maximum = progresso.Maximo;
			# this.form.PBar.PulseStep = progresso.Passo;
			# }
			# 
			self.@form.PBar.Fraction = Rotinas.calculaProgresso(progresso.Maximo, progresso.Posicao)
		end
	end
end