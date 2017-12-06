require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.gui
	class FrmSobre < Gtk::Dialog
		def initialize()
			self.Build()
		end

		def OnButtonOkClicked(sender, e)
			self.Hide()
		end
	end
end