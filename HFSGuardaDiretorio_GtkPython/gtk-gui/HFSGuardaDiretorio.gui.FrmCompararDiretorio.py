﻿# This file has been generated by the GUI designer. Do not modify.
class FrmCompararDiretorio(object):
	def __init__(self):

	def Build(self):
		Stetic.Gui.Initialize(self)
		# Widget HFSGuardaDiretorio.gui.FrmCompararDiretorio
		self._WidthRequest = 693
		self._HeightRequest = 608
		self._Name = "HFSGuardaDiretorio.gui.FrmCompararDiretorio"
		self._Title = Mono.Unix.Catalog.GetString("Comparar Diretórios")
		self._TypeHint = ((1))
		self._WindowPosition = ((1))
		self._Modal = True
		self._AllowGrow = False
		# Container child HFSGuardaDiretorio.gui.FrmCompararDiretorio.Gtk.Container+ContainerChild
		self._vbox3 = Gtk.VBox()
		self._vbox3.Name = "vbox3"
		self._vbox3.Spacing = 6
		# Container child vbox3.Gtk.Box+BoxChild
		self._hbox1 = Gtk.HBox()
		self._hbox1.Name = "hbox1"
		self._hbox1.Spacing = 6
		# Container child hbox1.Gtk.Box+BoxChild
		self._btnCompararDiretorios = Gtk.Button()
		self._btnCompararDiretorios.CanFocus = True
		self._btnCompararDiretorios.Name = "btnCompararDiretorios"
		self._btnCompararDiretorios.UseUnderline = True
		self._btnCompararDiretorios.Label = Mono.Unix.Catalog.GetString("Comparar Diretórios")
		self._hbox1.Add(self._btnCompararDiretorios)
		w1 = ((self._hbox1[self._btnCompararDiretorios]))
		w1.Position = 0
		w1.Expand = False
		w1.Fill = False
		# Container child hbox1.Gtk.Box+BoxChild
		self._pb = Gtk.ProgressBar()
		self._pb.Name = "pb"
		self._hbox1.Add(self._pb)
		w2 = ((self._hbox1[self._pb]))
		w2.Position = 1
		# Container child hbox1.Gtk.Box+BoxChild
		self._btnSalvarLog = Gtk.Button()
		self._btnSalvarLog.CanFocus = True
		self._btnSalvarLog.Name = "btnSalvarLog"
		self._btnSalvarLog.UseUnderline = True
		self._btnSalvarLog.Label = Mono.Unix.Catalog.GetString("Salvar Log")
		self._hbox1.Add(self._btnSalvarLog)
		w3 = ((self._hbox1[self._btnSalvarLog]))
		w3.Position = 2
		w3.Expand = False
		w3.Fill = False
		self._vbox3.Add(self._hbox1)
		w4 = ((self._vbox3[self._hbox1]))
		w4.Position = 0
		w4.Expand = False
		w4.Fill = False
		# Container child vbox3.Gtk.Box+BoxChild
		self._hbox2 = Gtk.HBox()
		self._hbox2.Name = "hbox2"
		self._hbox2.Spacing = 6
		# Container child hbox2.Gtk.Box+BoxChild
		self._frame1 = Gtk.Frame()
		self._frame1.Name = "frame1"
		self._frame1.ShadowType = ((0))
		# Container child frame1.Gtk.Container+ContainerChild
		self._GtkAlignment = Gtk.Alignment(0f, 0f, 1f, 1f)
		self._GtkAlignment.Name = "GtkAlignment"
		self._GtkAlignment.LeftPadding = ((12))
		# Container child GtkAlignment.Gtk.Container+ContainerChild
		self._vbox4 = Gtk.VBox()
		self._vbox4.Name = "vbox4"
		self._vbox4.Spacing = 6
		# Container child vbox4.Gtk.Box+BoxChild
		self._cmbAba1 = Gtk.ComboBox.NewText()
		self._cmbAba1.Name = "cmbAba1"
		self._vbox4.Add(self._cmbAba1)
		w5 = ((self._vbox4[self._cmbAba1]))
		w5.Position = 0
		w5.Expand = False
		w5.Fill = False
		# Container child vbox4.Gtk.Box+BoxChild
		self._GtkScrolledWindow = Gtk.ScrolledWindow()
		self._GtkScrolledWindow.Name = "GtkScrolledWindow"
		self._GtkScrolledWindow.ShadowType = ((1))
		# Container child GtkScrolledWindow.Gtk.Container+ContainerChild
		self._tvDiretorio1 = Gtk.TreeView()
		self._tvDiretorio1.CanFocus = True
		self._tvDiretorio1.Name = "tvDiretorio1"
		self._GtkScrolledWindow.Add(self._tvDiretorio1)
		self._vbox4.Add(self._GtkScrolledWindow)
		w7 = ((self._vbox4[self._GtkScrolledWindow]))
		w7.Position = 1
		self._GtkAlignment.Add(self._vbox4)
		self._frame1.Add(self._GtkAlignment)
		self._GtkLabel2 = Gtk.Label()
		self._GtkLabel2.Name = "GtkLabel2"
		self._GtkLabel2.LabelProp = Mono.Unix.Catalog.GetString("<b>Diretório 1</b>")
		self._GtkLabel2.UseMarkup = True
		self._frame1.LabelWidget = self._GtkLabel2
		self._hbox2.Add(self._frame1)
		w10 = ((self._hbox2[self._frame1]))
		w10.Position = 0
		# Container child hbox2.Gtk.Box+BoxChild
		self._frame2 = Gtk.Frame()
		self._frame2.Name = "frame2"
		self._frame2.ShadowType = ((0))
		# Container child frame2.Gtk.Container+ContainerChild
		self._GtkAlignment1 = Gtk.Alignment(0f, 0f, 1f, 1f)
		self._GtkAlignment1.Name = "GtkAlignment1"
		self._GtkAlignment1.LeftPadding = ((12))
		# Container child GtkAlignment1.Gtk.Container+ContainerChild
		self._vbox5 = Gtk.VBox()
		self._vbox5.Name = "vbox5"
		self._vbox5.Spacing = 6
		# Container child vbox5.Gtk.Box+BoxChild
		self._cmbAba2 = Gtk.ComboBox.NewText()
		self._cmbAba2.Name = "cmbAba2"
		self._vbox5.Add(self._cmbAba2)
		w11 = ((self._vbox5[self._cmbAba2]))
		w11.Position = 0
		w11.Expand = False
		w11.Fill = False
		# Container child vbox5.Gtk.Box+BoxChild
		self._GtkScrolledWindow1 = Gtk.ScrolledWindow()
		self._GtkScrolledWindow1.Name = "GtkScrolledWindow1"
		self._GtkScrolledWindow1.ShadowType = ((1))
		# Container child GtkScrolledWindow1.Gtk.Container+ContainerChild
		self._tvDiretorio2 = Gtk.TreeView()
		self._tvDiretorio2.CanFocus = True
		self._tvDiretorio2.Name = "tvDiretorio2"
		self._GtkScrolledWindow1.Add(self._tvDiretorio2)
		self._vbox5.Add(self._GtkScrolledWindow1)
		w13 = ((self._vbox5[self._GtkScrolledWindow1]))
		w13.Position = 1
		self._GtkAlignment1.Add(self._vbox5)
		self._frame2.Add(self._GtkAlignment1)
		self._GtkLabel3 = Gtk.Label()
		self._GtkLabel3.Name = "GtkLabel3"
		self._GtkLabel3.LabelProp = Mono.Unix.Catalog.GetString("<b>Diretório 2</b>")
		self._GtkLabel3.UseMarkup = True
		self._frame2.LabelWidget = self._GtkLabel3
		self._hbox2.Add(self._frame2)
		w16 = ((self._hbox2[self._frame2]))
		w16.Position = 1
		self._vbox3.Add(self._hbox2)
		w17 = ((self._vbox3[self._hbox2]))
		w17.Position = 1
		# Container child vbox3.Gtk.Box+BoxChild
		self._hbox3 = Gtk.HBox()
		self._hbox3.Name = "hbox3"
		self._hbox3.Spacing = 6
		# Container child hbox3.Gtk.Box+BoxChild
		self._labDiferencasEncontradas = Gtk.Label()
		self._labDiferencasEncontradas.Name = "labDiferencasEncontradas"
		self._labDiferencasEncontradas.LabelProp = Mono.Unix.Catalog.GetString("Diferenças Encontradas")
		self._hbox3.Add(self._labDiferencasEncontradas)
		w18 = ((self._hbox3[self._labDiferencasEncontradas]))
		w18.Position = 0
		w18.Expand = False
		w18.Fill = False
		self._vbox3.Add(self._hbox3)
		w19 = ((self._vbox3[self._hbox3]))
		w19.Position = 2
		w19.Expand = False
		w19.Fill = False
		# Container child vbox3.Gtk.Box+BoxChild
		self._GtkScrolledWindow2 = Gtk.ScrolledWindow()
		self._GtkScrolledWindow2.Name = "GtkScrolledWindow2"
		self._GtkScrolledWindow2.ShadowType = ((1))
		# Container child GtkScrolledWindow2.Gtk.Container+ContainerChild
		self._tabelaCompara = Gtk.NodeView()
		self._tabelaCompara.CanFocus = True
		self._tabelaCompara.Name = "tabelaCompara"
		self._GtkScrolledWindow2.Add(self._tabelaCompara)
		self._vbox3.Add(self._GtkScrolledWindow2)
		w21 = ((self._vbox3[self._GtkScrolledWindow2]))
		w21.Position = 3
		# Container child vbox3.Gtk.Box+BoxChild
		self._hbox4 = Gtk.HBox()
		self._hbox4.Name = "hbox4"
		self._hbox4.Spacing = 6
		# Container child hbox4.Gtk.Box+BoxChild
		self._barraStatus1 = Gtk.Statusbar()
		self._barraStatus1.Name = "barraStatus1"
		self._barraStatus1.Spacing = 6
		self._barraStatus1.HasResizeGrip = False
		self._hbox4.Add(self._barraStatus1)
		w22 = ((self._hbox4[self._barraStatus1]))
		w22.Position = 0
		# Container child hbox4.Gtk.Box+BoxChild
		self._barraStatus2 = Gtk.Statusbar()
		self._barraStatus2.Name = "barraStatus2"
		self._barraStatus2.Spacing = 6
		self._hbox4.Add(self._barraStatus2)
		w23 = ((self._hbox4[self._barraStatus2]))
		w23.Position = 1
		self._vbox3.Add(self._hbox4)
		w24 = ((self._vbox3[self._hbox4]))
		w24.PackType = ((1))
		w24.Position = 4
		w24.Expand = False
		w24.Fill = False
		self.Add(self._vbox3)
		if (self._Child != None):
			self._Child.ShowAll()
		self._DefaultWidth = 693
		self._DefaultHeight = 608
		self.Show()
		self._btnCompararDiretorios.Clicked += self._OnBtnCompararDiretoriosClicked
		self._btnSalvarLog.Clicked += self._OnBtnSalvarLogClicked
		self._cmbAba1.Changed += self._OnCmbAba1Changed
		self._cmbAba2.Changed += self._OnCmbAba2Changed