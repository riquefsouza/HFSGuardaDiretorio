require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
require "Gtk, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

module HFSGuardaDiretorio.gui
	class FrmSplash < Gtk::Window
		def initialize()
			self.Build()
			label1.ModifyFont(Pango.FontDescription.FromString("Bold 20"))
			label2.ModifyFont(Pango.FontDescription.FromString("Bold 15"))
		end

		def PBar
			return self.@pb
		end
	end
end