﻿# This file has been generated by the GUI designer. Do not modify.
module HFSGuardaDiretorio.gui
	class FrmImportarDiretorio
		def initialize()
		end

		def Build()
			Stetic.Gui.Initialize(self)
			# Widget HFSGuardaDiretorio.gui.FrmImportarDiretorio
			self.@WidthRequest = 895
			self.@HeightRequest = 572
			self.@Name = "HFSGuardaDiretorio.gui.FrmImportarDiretorio"
			self.@Title = Mono.Unix.Catalog.GetString("Importando Diretório")
			self.@TypeHint = ((4))
			self.@WindowPosition = ((1))
			self.@Modal = true
			self.@Resizable = false
			self.@AllowGrow = false
			# Container child HFSGuardaDiretorio.gui.FrmImportarDiretorio.Gtk.Container+ContainerChild
			self.@vbox1 = Gtk.VBox.new()
			self.@vbox1.Name = "vbox1"
			self.@vbox1.Spacing = 6
			# Container child vbox1.Gtk.Box+BoxChild
			self.@GtkScrolledWindow = Gtk.ScrolledWindow.new()
			self.@GtkScrolledWindow.Name = "GtkScrolledWindow"
			self.@GtkScrolledWindow.ShadowType = ((1))
			# Container child GtkScrolledWindow.Gtk.Container+ContainerChild
			self.@memoImportaDir = Gtk.TextView.new()
			self.@memoImportaDir.CanFocus = true
			self.@memoImportaDir.Name = "memoImportaDir"
			self.@memoImportaDir.Editable = false
			self.@memoImportaDir.CursorVisible = false
			self.@memoImportaDir.AcceptsTab = false
			self.@GtkScrolledWindow.Add(self.@memoImportaDir)
			self.@vbox1.Add(self.@GtkScrolledWindow)
			w2 = ((self.@vbox1[self.@GtkScrolledWindow]))
			w2.Position = 0
			# Container child vbox1.Gtk.Box+BoxChild
			self.@pbImportar = Gtk.ProgressBar.new()
			self.@pbImportar.Name = "pbImportar"
			self.@vbox1.Add(self.@pbImportar)
			w3 = ((self.@vbox1[self.@pbImportar]))
			w3.Position = 1
			w3.Expand = false
			w3.Fill = false
			# Container child vbox1.Gtk.Box+BoxChild
			self.@hbox3 = Gtk.HBox.new()
			self.@hbox3.Name = "hbox3"
			self.@hbox3.Spacing = 6
			# Container child hbox3.Gtk.Box+BoxChild
			self.@barraStatus1 = Gtk.Statusbar.new()
			self.@barraStatus1.Name = "barraStatus1"
			self.@barraStatus1.Spacing = 6
			self.@barraStatus1.HasResizeGrip = false
			self.@hbox3.Add(self.@barraStatus1)
			w4 = ((self.@hbox3[self.@barraStatus1]))
			w4.Position = 0
			w4.Expand = false
			# Container child hbox3.Gtk.Box+BoxChild
			self.@barraStatus2 = Gtk.Statusbar.new()
			self.@barraStatus2.Name = "barraStatus2"
			self.@barraStatus2.Spacing = 6
			self.@hbox3.Add(self.@barraStatus2)
			w5 = ((self.@hbox3[self.@barraStatus2]))
			w5.Position = 1
			self.@vbox1.Add(self.@hbox3)
			w6 = ((self.@vbox1[self.@hbox3]))
			w6.Position = 2
			w6.Expand = false
			w6.Fill = false
			self.Add(self.@vbox1)
			if (self.@Child != nil) then
				self.@Child.ShowAll()
			end
			self.@DefaultWidth = 895
			self.@DefaultHeight = 572
			self.Show()
		end
	end
end