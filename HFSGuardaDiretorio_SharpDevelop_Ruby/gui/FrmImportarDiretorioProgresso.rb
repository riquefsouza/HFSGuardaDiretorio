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
			if progresso.Posicao == 0 then
				self.@form.pbImportar.Minimum = progresso.Minimo
				self.@form.pbImportar.Maximum = progresso.Maximo
				self.@form.pbImportar.Step = progresso.Passo
			end
			self.@form.pbImportar.Value = progresso.Posicao
			if progresso.Log.Length > 0 then
				pos = @form.memoImportaDir.TextLength
				@form.memoImportaDir.AppendText(progresso.Log + "\n")
				@form.memoImportaDir.Select(pos, pos)
				@form.barraStatus.Items[1].Text = Convert.ToString(pos)
				@form.barraStatus.Update()
			end
		end
	end
end