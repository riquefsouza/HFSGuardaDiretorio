﻿# This file has been generated by the GUI designer. Do not modify.
class FrmSobre(object):
	def __init__(self):

	def Build(self):
		Stetic.Gui.Initialize(self)
		# Widget HFSGuardaDiretorio.gui.FrmSobre
		self._Name = "HFSGuardaDiretorio.gui.FrmSobre"
		self._Title = Mono.Unix.Catalog.GetString("Sobre o Catalogador")
		self._WindowPosition = ((1))
		self._Modal = True
		self._Resizable = False
		self._AllowGrow = False
		self._DefaultWidth = 300
		self._DefaultHeight = 150
		# Internal child HFSGuardaDiretorio.gui.FrmSobre.VBox
		w1 = self._VBox
		w1.Name = "dialog1_VBox"
		w1.BorderWidth = ((2))
		# Container child dialog1_VBox.Gtk.Box+BoxChild
		self._vbox2 = Gtk.VBox()
		self._vbox2.Name = "vbox2"
		self._vbox2.Spacing = 6
		# Container child vbox2.Gtk.Box+BoxChild
		self._label1 = Gtk.Label()
		self._label1.Name = "label1"
		self._label1.LabelProp = Mono.Unix.Catalog.GetString("HFSGuardaDir 2.0 - Catalogador de Diretórios")
		self._vbox2.Add(self._label1)
		w2 = ((self._vbox2[self._label1]))
		w2.Position = 0
		w2.Expand = False
		w2.Fill = False
		# Container child vbox2.Gtk.Box+BoxChild
		self._label2 = Gtk.Label()
		self._label2.Name = "label2"
		self._label2.LabelProp = Mono.Unix.Catalog.GetString("Desenvolvido em C# com GTK#, Versão: 2.0")
		self._vbox2.Add(self._label2)
		w3 = ((self._vbox2[self._label2]))
		w3.Position = 1
		w3.Expand = False
		w3.Fill = False
		# Container child vbox2.Gtk.Box+BoxChild
		self._label3 = Gtk.Label()
		self._label3.Name = "label3"
		self._label3.LabelProp = Mono.Unix.Catalog.GetString("Por Henrique Figueiredo de Souza")
		self._vbox2.Add(self._label3)
		w4 = ((self._vbox2[self._label3]))
		w4.Position = 2
		w4.Expand = False
		w4.Fill = False
		# Container child vbox2.Gtk.Box+BoxChild
		self._label4 = Gtk.Label()
		self._label4.Name = "label4"
		self._label4.LabelProp = Mono.Unix.Catalog.GetString("Todos os direitos reservados, 2014")
		self._vbox2.Add(self._label4)
		w5 = ((self._vbox2[self._label4]))
		w5.Position = 3
		w5.Expand = False
		w5.Fill = False
		w1.Add(self._vbox2)
		w6 = ((w1[self._vbox2]))
		w6.Position = 0
		w6.Expand = False
		w6.Fill = False
		# Internal child HFSGuardaDiretorio.gui.FrmSobre.ActionArea
		w7 = self._ActionArea
		w7.Name = "dialog1_ActionArea"
		w7.Spacing = 10
		w7.BorderWidth = ((5))
		w7.LayoutStyle = ((1))
		# Container child dialog1_ActionArea.Gtk.ButtonBox+ButtonBoxChild
		self._buttonOk = Gtk.Button()
		self._buttonOk.CanDefault = True
		self._buttonOk.CanFocus = True
		self._buttonOk.Name = "buttonOk"
		self._buttonOk.UseStock = True
		self._buttonOk.UseUnderline = True
		self._buttonOk.Label = "gtk-ok"
		self.AddActionWidget(self._buttonOk, -5)
		w8 = ((w7[self._buttonOk]))
		w8.Expand = False
		w8.Fill = False
		if (self._Child != None):
			self._Child.ShowAll()
		self.Show()
		self._buttonOk.Clicked += self._OnButtonOkClicked