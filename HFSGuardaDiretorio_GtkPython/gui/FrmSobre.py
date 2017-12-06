from System import *

class FrmSobre(Gtk.Dialog):
	def __init__(self):
		self.Build()

	def OnButtonOkClicked(self, sender, e):
		self.Hide()