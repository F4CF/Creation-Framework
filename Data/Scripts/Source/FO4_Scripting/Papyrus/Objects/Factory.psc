Scriptname Papyrus:Objects:Factory extends Quest Const
import Papyrus
import Papyrus:Objects


; Functions
;---------------------------------------------

ObjectReference Function Initialize(int aFormID)
	Activator Type = GetType(aFormID)
	return Create(Type)
EndFunction


ObjectReference Function Create(Activator aActivator)
	ObjectReference reference = Anchor.PlaceAtMe(aActivator)
	return reference
EndFunction


; Globals
;---------------------------------------------

Factory Function GetFactory() Global
	return Game.GetFormFromFile(0x00000838, Papyrus:Environment.Plugin()) as Factory
EndFunction


Activator Function GetType(int aFormID) Global
	return Game.GetFormFromFile(aFormID, Papyrus:Environment.Plugin()) as Activator
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ObjectReference Property Anchor Auto Const Mandatory
EndGroup
