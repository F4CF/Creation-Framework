Scriptname System:Object extends Quest Const
import System


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

Object Function Type() Global
	System:Assembly assembly = System:Assembly.GetAssembly()
	return System:External.Read(assembly.File, assembly.System) as Object
EndFunction


Activator Function GetType(int formID) Global
	System:Assembly assembly = System:Assembly.GetAssembly()
	return System:External.Read(assembly.File, formID) as Activator
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ObjectReference Property Anchor Auto Const Mandatory
EndGroup
