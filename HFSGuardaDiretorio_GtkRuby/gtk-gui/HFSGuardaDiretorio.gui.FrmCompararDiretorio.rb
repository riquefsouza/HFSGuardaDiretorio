﻿# This file has been generated by the GUI designer. Do not modify.
module HFSGuardaDiretorio.gui
	class FrmCompararDiretorio
		def initialize()
		end

		def Build()
			Stetic.Gui.Initialize(self)
			# Widget HFSGuardaDiretorio.gui.FrmCompararDiretorio
			self.@WidthRequest = 693
			self.@HeightRequest = 608
			self.@Name = "HFSGuardaDiretorio.gui.FrmCompararDiretorio"
			self.@Title = Mono.Unix.Catalog.GetString("Comparar Diretórios")
			self.@TypeHint = ((1))
			self.@WindowPosition = ((1))
			self.@Modal = true
			self.@AllowGrow = false
			# Container child HFSGuardaDiretorio.gui.FrmCompararDiretorio.Gtk.Container+ContainerChild
			self.@vbox3 = Gtk.VBox.new()
			self.@vbox3.Name = "vbox3"
			self.@vbox3.Spacing = 6
			# Container child vbox3.Gtk.Box+BoxChild
			self.@hbox1 = Gtk.HBox.new()
			self.@hbox1.Name = "hbox1"
			self.@hbox1.Spacing = 6
			# Container child hbox1.Gtk.Box+BoxChild
			self.@btnCompararDiretorios = Gtk.Button.new()
			self.@btnCompararDiretorios.CanFocus = true
			self.@btnCompararDiretorios.Name = "btnCompararDiretorios"
			self.@btnCompararDiretorios.UseUnderline = true
			self.@btnCompararDiretorios.Label = Mono.Unix.Catalog.GetString("Comparar Diretórios")
			self.@hbox1.Add(self.@btnCompararDiretorios)
			w1 = ((self.@hbox1[self.@btnCompararDiretorios]))
			w1.Position = 0
			w1.Expand = false
			w1.Fill = false
			# Container child hbox1.Gtk.Box+BoxChild
			self.@pb = Gtk.ProgressBar.new()
			self.@pb.Name = "pb"
			self.@hbox1.Add(self.@pb)
			w2 = ((self.@hbox1[self.@pb]))
			w2.Position = 1
			# Container child hbox1.Gtk.Box+BoxChild
			self.@btnSalvarLog = Gtk.Button.new()
			self.@btnSalvarLog.CanFocus = true
			self.@btnSalvarLog.Name = "btnSalvarLog"
			self.@btnSalvarLog.UseUnderline = true
			self.@btnSalvarLog.Label = Mono.Unix.Catalog.GetString("Salvar Log")
			self.@hbox1.Add(self.@btnSalvarLog)
			w3 = ((self.@hbox1[self.@btnSalvarLog]))
			w3.Position = 2
			w3.Expand = false
			w3.Fill = false
			self.@vbox3.Add(self.@hbox1)
			w4 = ((self.@vbox3[self.@hbox1]))
			w4.Position = 0
			w4.Expand = false
			w4.Fill = false
			# Container child vbox3.Gtk.Box+BoxChild
			self.@hbox2 = Gtk.HBox.new()
			self.@hbox2.Name = "hbox2"
			self.@hbox2.Spacing = 6
			# Container child hbox2.Gtk.Box+BoxChild
			self.@frame1 = Gtk.Frame.new()
			self.@frame1.Name = "frame1"
			self.@frame1.ShadowType = ((0))
			# Container child frame1.Gtk.Container+ContainerChild
			self.@GtkAlignment = Gtk.Alignment.new(0f, 0f, 1f, 1f)
			self.@GtkAlignment.Name = "GtkAlignment"
			self.@GtkAlignment.LeftPadding = ((12))
			# Container child GtkAlignment.Gtk.Container+ContainerChild
			self.@vbox4 = Gtk.VBox.new()
			self.@vbox4.Name = "vbox4"
			self.@vbox4.Spacing = 6
			# Container child vbox4.Gtk.Box+BoxChild
			self.@cmbAba1 = Gtk.ComboBox.NewText()
			self.@cmbAba1.Name = "cmbAba1"
			self.@vbox4.Add(self.@cmbAba1)
			w5 = ((self.@vbox4[self.@cmbAba1]))
			w5.Position = 0
			w5.Expand = false
			w5.Fill = false
			# Container child vbox4.Gtk.Box+BoxChild
			self.@GtkScrolledWindow = Gtk.ScrolledWindow.new()
			self.@GtkScrolledWindow.Name = "GtkScrolledWindow"
			self.@GtkScrolledWindow.ShadowType = ((1))
			# Container child GtkScrolledWindow.Gtk.Container+ContainerChild
			self.@tvDiretorio1 = Gtk.TreeView.new()
			self.@tvDiretorio1.CanFocus = true
			self.@tvDiretorio1.Name = "tvDiretorio1"
			self.@GtkScrolledWindow.Add(self.@tvDiretorio1)
			self.@vbox4.Add(self.@GtkScrolledWindow)
			w7 = ((self.@vbox4[self.@GtkScrolledWindow]))
			w7.Position = 1
			self.@GtkAlignment.Add(self.@vbox4)
			self.@frame1.Add(self.@GtkAlignment)
			self.@GtkLabel2 = Gtk.Label.new()
			self.@GtkLabel2.Name = "GtkLabel2"
			self.@GtkLabel2.LabelProp = Mono.Unix.Catalog.GetString("<b>Diretório 1</b>")
			self.@GtkLabel2.UseMarkup = true
			self.@frame1.LabelWidget = self.@GtkLabel2
			self.@hbox2.Add(self.@frame1)
			w10 = ((self.@hbox2[self.@frame1]))
			w10.Position = 0
			# Container child hbox2.Gtk.Box+BoxChild
			self.@frame2 = Gtk.Frame.new()
			self.@frame2.Name = "frame2"
			self.@frame2.ShadowType = ((0))
			# Container child frame2.Gtk.Container+ContainerChild
			self.@GtkAlignment1 = Gtk.Alignment.new(0f, 0f, 1f, 1f)
			self.@GtkAlignment1.Name = "GtkAlignment1"
			self.@GtkAlignment1.LeftPadding = ((12))
			# Container child GtkAlignment1.Gtk.Container+ContainerChild
			self.@vbox5 = Gtk.VBox.new()
			self.@vbox5.Name = "vbox5"
			self.@vbox5.Spacing = 6
			# Container child vbox5.Gtk.Box+BoxChild
			self.@cmbAba2 = Gtk.ComboBox.NewText()
			self.@cmbAba2.Name = "cmbAba2"
			self.@vbox5.Add(self.@cmbAba2)
			w11 = ((self.@vbox5[self.@cmbAba2]))
			w11.Position = 0
			w11.Expand = false
			w11.Fill = false
			# Container child vbox5.Gtk.Box+BoxChild
			self.@GtkScrolledWindow1 = Gtk.ScrolledWindow.new()
			self.@GtkScrolledWindow1.Name = "GtkScrolledWindow1"
			self.@GtkScrolledWindow1.ShadowType = ((1))
			# Container child GtkScrolledWindow1.Gtk.Container+ContainerChild
			self.@tvDiretorio2 = Gtk.TreeView.new()
			self.@tvDiretorio2.CanFocus = true
			self.@tvDiretorio2.Name = "tvDiretorio2"
			self.@GtkScrolledWindow1.Add(self.@tvDiretorio2)
			self.@vbox5.Add(self.@GtkScrolledWindow1)
			w13 = ((self.@vbox5[self.@GtkScrolledWindow1]))
			w13.Position = 1
			self.@GtkAlignment1.Add(self.@vbox5)
			self.@frame2.Add(self.@GtkAlignment1)
			self.@GtkLabel3 = Gtk.Label.new()
			self.@GtkLabel3.Name = "GtkLabel3"
			self.@GtkLabel3.LabelProp = Mono.Unix.Catalog.GetString("<b>Diretório 2</b>")
			self.@GtkLabel3.UseMarkup = true
			self.@frame2.LabelWidget = self.@GtkLabel3
			self.@hbox2.Add(self.@frame2)
			w16 = ((self.@hbox2[self.@frame2]))
			w16.Position = 1
			self.@vbox3.Add(self.@hbox2)
			w17 = ((self.@vbox3[self.@hbox2]))
			w17.Position = 1
			# Container child vbox3.Gtk.Box+BoxChild
			self.@hbox3 = Gtk.HBox.new()
			self.@hbox3.Name = "hbox3"
			self.@hbox3.Spacing = 6
			# Container child hbox3.Gtk.Box+BoxChild
			self.@labDiferencasEncontradas = Gtk.Label.new()
			self.@labDiferencasEncontradas.Name = "labDiferencasEncontradas"
			self.@labDiferencasEncontradas.LabelProp = Mono.Unix.Catalog.GetString("Diferenças Encontradas")
			self.@hbox3.Add(self.@labDiferencasEncontradas)
			w18 = ((self.@hbox3[self.@labDiferencasEncontradas]))
			w18.Position = 0
			w18.Expand = false
			w18.Fill = false
			self.@vbox3.Add(self.@hbox3)
			w19 = ((self.@vbox3[self.@hbox3]))
			w19.Position = 2
			w19.Expand = false
			w19.Fill = false
			# Container child vbox3.Gtk.Box+BoxChild
			self.@GtkScrolledWindow2 = Gtk.ScrolledWindow.new()
			self.@GtkScrolledWindow2.Name = "GtkScrolledWindow2"
			self.@GtkScrolledWindow2.ShadowType = ((1))
			# Container child GtkScrolledWindow2.Gtk.Container+ContainerChild
			self.@tabelaCompara = Gtk.NodeView.new()
			self.@tabelaCompara.CanFocus = true
			self.@tabelaCompara.Name = "tabelaCompara"
			self.@GtkScrolledWindow2.Add(self.@tabelaCompara)
			self.@vbox3.Add(self.@GtkScrolledWindow2)
			w21 = ((self.@vbox3[self.@GtkScrolledWindow2]))
			w21.Position = 3
			# Container child vbox3.Gtk.Box+BoxChild
			self.@hbox4 = Gtk.HBox.new()
			self.@hbox4.Name = "hbox4"
			self.@hbox4.Spacing = 6
			# Container child hbox4.Gtk.Box+BoxChild
			self.@barraStatus1 = Gtk.Statusbar.new()
			self.@barraStatus1.Name = "barraStatus1"
			self.@barraStatus1.Spacing = 6
			self.@barraStatus1.HasResizeGrip = false
			self.@hbox4.Add(self.@barraStatus1)
			w22 = ((self.@hbox4[self.@barraStatus1]))
			w22.Position = 0
			# Container child hbox4.Gtk.Box+BoxChild
			self.@barraStatus2 = Gtk.Statusbar.new()
			self.@barraStatus2.Name = "barraStatus2"
			self.@barraStatus2.Spacing = 6
			self.@hbox4.Add(self.@barraStatus2)
			w23 = ((self.@hbox4[self.@barraStatus2]))
			w23.Position = 1
			self.@vbox3.Add(self.@hbox4)
			w24 = ((self.@vbox3[self.@hbox4]))
			w24.PackType = ((1))
			w24.Position = 4
			w24.Expand = false
			w24.Fill = false
			self.Add(self.@vbox3)
			if (self.@Child != nil) then
				self.@Child.ShowAll()
			end
			self.@DefaultWidth = 693
			self.@DefaultHeight = 608
			self.Show()
			self.@btnCompararDiretorios.Clicked { |sender, e| self.@OnBtnCompararDiretoriosClicked(sender, e) }
			self.@btnSalvarLog.Clicked { |sender, e| self.@OnBtnSalvarLogClicked(sender, e) }
			self.@cmbAba1.Changed { |sender, e| self.@OnCmbAba1Changed(sender, e) }
			self.@cmbAba2.Changed { |sender, e| self.@OnCmbAba2Changed(sender, e) }
		end
	end
end