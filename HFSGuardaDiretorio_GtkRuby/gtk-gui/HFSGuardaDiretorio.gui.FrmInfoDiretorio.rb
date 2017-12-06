﻿# This file has been generated by the GUI designer. Do not modify.
module HFSGuardaDiretorio.gui
	class FrmInfoDiretorio
		def initialize()
		end

		def Build()
			Stetic.Gui.Initialize(self)
			# Widget HFSGuardaDiretorio.gui.FrmInfoDiretorio
			self.@WidthRequest = 369
			self.@HeightRequest = 372
			self.@Name = "HFSGuardaDiretorio.gui.FrmInfoDiretorio"
			self.@Title = Mono.Unix.Catalog.GetString("Informações do Diretório / Arquivo")
			self.@WindowPosition = ((1))
			self.@Modal = true
			# Internal child HFSGuardaDiretorio.gui.FrmInfoDiretorio.VBox
			w1 = self.@VBox
			w1.Name = "dialog1_VBox"
			w1.BorderWidth = ((2))
			# Container child dialog1_VBox.Gtk.Box+BoxChild
			self.@vbox4 = Gtk.VBox.new()
			self.@vbox4.Name = "vbox4"
			self.@vbox4.Spacing = 6
			# Container child vbox4.Gtk.Box+BoxChild
			self.@frame1 = Gtk.Frame.new()
			self.@frame1.Name = "frame1"
			# Container child frame1.Gtk.Container+ContainerChild
			self.@GtkAlignment1 = Gtk.Alignment.new(0f, 0f, 1f, 1f)
			self.@GtkAlignment1.Name = "GtkAlignment1"
			self.@GtkAlignment1.LeftPadding = ((12))
			# Container child GtkAlignment1.Gtk.Container+ContainerChild
			self.@table1 = Gtk.Table.new(((3)), ((2)), true)
			self.@table1.Name = "table1"
			self.@table1.RowSpacing = ((6))
			self.@table1.ColumnSpacing = ((6))
			# Container child table1.Gtk.Table+TableChild
			self.@label1 = Gtk.Label.new()
			self.@label1.Name = "label1"
			self.@label1.LabelProp = Mono.Unix.Catalog.GetString("[ARQ] - Arquivo comum")
			self.@table1.Add(self.@label1)
			w2 = ((self.@table1[self.@label1]))
			w2.XOptions = ((4))
			w2.YOptions = ((4))
			# Container child table1.Gtk.Table+TableChild
			self.@label2 = Gtk.Label.new()
			self.@label2.Name = "label2"
			self.@label2.LabelProp = Mono.Unix.Catalog.GetString("[DIR] - Diretório")
			self.@table1.Add(self.@label2)
			w3 = ((self.@table1[self.@label2]))
			w3.LeftAttach = ((1))
			w3.RightAttach = ((2))
			w3.XOptions = ((4))
			w3.YOptions = ((4))
			# Container child table1.Gtk.Table+TableChild
			self.@label3 = Gtk.Label.new()
			self.@label3.Name = "label3"
			self.@label3.LabelProp = Mono.Unix.Catalog.GetString("[HID] - Arquivo Oculto")
			self.@table1.Add(self.@label3)
			w4 = ((self.@table1[self.@label3]))
			w4.TopAttach = ((1))
			w4.BottomAttach = ((2))
			w4.XOptions = ((4))
			w4.YOptions = ((4))
			# Container child table1.Gtk.Table+TableChild
			self.@label4 = Gtk.Label.new()
			self.@label4.Name = "label4"
			self.@label4.LabelProp = Mono.Unix.Catalog.GetString("[VOL] - Volume ID")
			self.@table1.Add(self.@label4)
			w5 = ((self.@table1[self.@label4]))
			w5.TopAttach = ((1))
			w5.BottomAttach = ((2))
			w5.LeftAttach = ((1))
			w5.RightAttach = ((2))
			w5.XOptions = ((4))
			w5.YOptions = ((4))
			# Container child table1.Gtk.Table+TableChild
			self.@label5 = Gtk.Label.new()
			self.@label5.Name = "label5"
			self.@label5.LabelProp = Mono.Unix.Catalog.GetString("[SYS] - Arquivo de Sistema")
			self.@table1.Add(self.@label5)
			w6 = ((self.@table1[self.@label5]))
			w6.TopAttach = ((2))
			w6.BottomAttach = ((3))
			w6.XOptions = ((4))
			w6.YOptions = ((4))
			# Container child table1.Gtk.Table+TableChild
			self.@label6 = Gtk.Label.new()
			self.@label6.Name = "label6"
			self.@label6.LabelProp = Mono.Unix.Catalog.GetString("[ROL] - Arquivo Somente Leitura")
			self.@table1.Add(self.@label6)
			w7 = ((self.@table1[self.@label6]))
			w7.TopAttach = ((2))
			w7.BottomAttach = ((3))
			w7.LeftAttach = ((1))
			w7.RightAttach = ((2))
			w7.XOptions = ((4))
			w7.YOptions = ((4))
			self.@GtkAlignment1.Add(self.@table1)
			self.@frame1.Add(self.@GtkAlignment1)
			self.@GtkLabel1 = Gtk.Label.new()
			self.@GtkLabel1.Name = "GtkLabel1"
			self.@GtkLabel1.UseMarkup = true
			self.@frame1.LabelWidget = self.@GtkLabel1
			self.@vbox4.Add(self.@frame1)
			w10 = ((self.@vbox4[self.@frame1]))
			w10.Position = 0
			w10.Expand = false
			w10.Fill = false
			# Container child vbox4.Gtk.Box+BoxChild
			self.@GtkScrolledWindow = Gtk.ScrolledWindow.new()
			self.@GtkScrolledWindow.Name = "GtkScrolledWindow"
			self.@GtkScrolledWindow.ShadowType = ((1))
			# Container child GtkScrolledWindow.Gtk.Container+ContainerChild
			self.@tabelaInfo = Gtk.NodeView.new()
			self.@tabelaInfo.CanFocus = true
			self.@tabelaInfo.Name = "tabelaInfo"
			self.@GtkScrolledWindow.Add(self.@tabelaInfo)
			self.@vbox4.Add(self.@GtkScrolledWindow)
			w12 = ((self.@vbox4[self.@GtkScrolledWindow]))
			w12.Position = 1
			w1.Add(self.@vbox4)
			w13 = ((w1[self.@vbox4]))
			w13.Position = 0
			# Internal child HFSGuardaDiretorio.gui.FrmInfoDiretorio.ActionArea
			w14 = self.@ActionArea
			w14.Name = "dialog1_ActionArea"
			w14.Spacing = 10
			w14.BorderWidth = ((5))
			w14.LayoutStyle = ((1))
			# Container child dialog1_ActionArea.Gtk.ButtonBox+ButtonBoxChild
			self.@btnOk = Gtk.Button.new()
			self.@btnOk.CanDefault = true
			self.@btnOk.CanFocus = true
			self.@btnOk.Name = "btnOk"
			self.@btnOk.UseStock = true
			self.@btnOk.UseUnderline = true
			self.@btnOk.Label = "gtk-ok"
			self.AddActionWidget(self.@btnOk, -5)
			w15 = ((w14[self.@btnOk]))
			w15.Expand = false
			w15.Fill = false
			if (self.@Child != nil) then
				self.@Child.ShowAll()
			end
			self.@DefaultWidth = 400
			self.@DefaultHeight = 372
			self.Show()
			self.@btnOk.Clicked { |sender, e| self.@OnBtnOkClicked(sender, e) }
		end
	end
end