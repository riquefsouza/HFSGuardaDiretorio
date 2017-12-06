from System import *
from Gtk import *

class FrmSplash(Gtk.Window):
	def __init__(self):
		self.Build()
		label1.ModifyFont(Pango.FontDescription.FromString("Bold 20"))
		label2.ModifyFont(Pango.FontDescription.FromString("Bold 15"))

	def get_PBar(self):
		return self._pb

	PBar = property(fget=get_PBar)