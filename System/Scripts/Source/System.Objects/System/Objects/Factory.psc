Scriptname System:Objects:Factory extends Quest Const
import System
import System:Objects


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
	return Game.GetFormFromFile(0x00000838, System:Environment.Plugin()) as Factory
EndFunction


Activator Function GetType(int aFormID) Global
	return Game.GetFormFromFile(aFormID, System:Environment.Plugin()) as Activator
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ObjectReference Property Anchor Auto Const Mandatory
EndGroup
