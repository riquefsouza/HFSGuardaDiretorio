# 
# * Created by SharpDevelop.
# * User: henrique.souza
# * Date: 08/07/2015
# * Time: 11:26
# *
# * To change this template use Tools | Options | Coding | Edit Standard Headers.
# 
require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "Gtk, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "HFSGuardaDiretorio.comum, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.gui
	# <summary>
	# Description of FrmImportarDiretorioProgresso.
	# </summary>
	class FrmImportarDiretorioProgresso < IProgressoLog
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
			if progresso.Maximo > 0 then
				self.@form.PBar.Fraction = Rotinas.calculaProgresso(progresso.Maximo, progresso.Posicao)
			end
			if progresso.Log.Length > 0 then
				pos = @form.MemoImportaDir.Buffer.LineCount
				@titer = @form.MemoImportaDir.Buffer.GetIterAtLine(pos)
				@form.MemoImportaDir.Buffer.Insert(@titer, progresso.Log + "\n")
				@form.MemoImportaDir.ScrollToIter(@titer, 0, false, 0, 0)
				@form.LabStatus2.Text = Convert.ToString(pos)
			end
			while Application.EventsPending()
				Application.RunIteration()
			end
		end
	end
end