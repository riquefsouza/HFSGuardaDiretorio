﻿# This file has been generated by the GUI designer. Do not modify.
class Gui(object):
	def __init__(self):

	def Initialize(iconRenderer):
		if (Stetic.Gui.initialized == False):
			Stetic.Gui.initialized = True

	Initialize = staticmethod(Initialize)

class ActionGroups(object):
	def GetActionGroup(type):
		return Stetic.ActionGroups.GetActionGroup(type.FullName)

	GetActionGroup = staticmethod(GetActionGroup)

	def GetActionGroup(name):
		return None

	GetActionGroup = staticmethod(GetActionGroup)