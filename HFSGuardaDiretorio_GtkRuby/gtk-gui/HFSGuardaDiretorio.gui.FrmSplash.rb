﻿# This file has been generated by the GUI designer. Do not modify.
module HFSGuardaDiretorio.gui
	class FrmSplash
		def initialize()
		end

		def Build()
			Stetic.Gui.Initialize(self)
			# Widget HFSGuardaDiretorio.gui.FrmSplash
			self.@Name = "HFSGuardaDiretorio.gui.FrmSplash"
			self.@Title = Mono.Unix.Catalog.GetString("FrmSplash")
			self.@TypeHint = ((4))
			self.@WindowPosition = ((3))
			self.@Modal = true
			self.@Resizable = false
			self.@AllowGrow = false
			self.@DefaultWidth = 375
			self.@DefaultHeight = 113
			self.@Decorated = false
			# Container child HFSGuardaDiretorio.gui.FrmSplash.Gtk.Container+ContainerChild
			self.@vbox2 = Gtk.VBox.new()
			self.@vbox2.Name = "vbox2"
			self.@vbox2.Spacing = 6
			self.@vbox2.BorderWidth = ((1))
			# Container child vbox2.Gtk.Box+BoxChild
			self.@label1 = Gtk.Label.new()
			self.@label1.Name = "label1"
			self.@label1.LabelProp = Mono.Unix.Catalog.GetString("HFSGuardaDiretorio 2.0")
			self.@vbox2.Add(self.@label1)
			w1 = ((self.@vbox2[self.@label1]))
			w1.Position = 0
			w1.Expand = false
			w1.Fill = false
			# Container child vbox2.Gtk.Box+BoxChild
			self.@label2 = Gtk.Label.new()
			self.@label2.Name = "label2"
			self.@label2.LabelProp = Mono.Unix.Catalog.GetString("Catalogador de Diretórios")
			self.@vbox2.Add(self.@label2)
			w2 = ((self.@vbox2[self.@label2]))
			w2.Position = 1
			w2.Expand = false
			w2.Fill = false
			# Container child vbox2.Gtk.Box+BoxChild
			self.@pb = Gtk.ProgressBar.new()
			self.@pb.Name = "pb"
			self.@vbox2.Add(self.@pb)
			w3 = ((self.@vbox2[self.@pb]))
			w3.Position = 2
			w3.Expand = false
			w3.Fill = false
			self.Add(self.@vbox2)
			if (self.@Child != nil) then
				self.@Child.ShowAll()
			end
			self.Show()
		end
	end
end