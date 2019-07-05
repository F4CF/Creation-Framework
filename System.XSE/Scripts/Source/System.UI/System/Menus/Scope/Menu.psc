Scriptname System:Menus:Scope:Menu extends System:Menus:MenuType
import System:Log

; Open/Close Event
;---------------------------------------------

CustomEvent OpenCloseEvent

Struct OpenCloseEventArgs
	bool Opening = false
EndStruct


bool Function RegisterForOpenCloseEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OpenCloseEvent")
		return true
	Else
		WriteUnexpectedValue(self, "RegisterForOpenCloseEvent", "script", "Cannot register a none script for events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForOpenCloseEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OpenCloseEvent")
		return true
	Else
		WriteUnexpectedValue(self, "UnregisterForOpenCloseEvent", "script", "Cannot unregister a none script for events.")
		return false
	EndIf
EndFunction


OpenCloseEventArgs Function GetOpenCloseEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as OpenCloseEventArgs
	Else
		return none
	EndIf
EndFunction


; Breath Event
;---------------------------------------------

CustomEvent BreathEvent

Struct BreathEventArgs
	int Breath = -1
EndStruct


bool Function RegisterForBreathEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "BreathEvent")
		return true
	Else
		WriteUnexpectedValue(self, "RegisterForBreathEvent", "script", "Cannot register a none script for events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForBreathEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "BreathEvent")
		return true
	Else
		WriteUnexpectedValue(self, "UnregisterForBreathEvent", "script", "Cannot unregister a none script for events.")
		return false
	EndIf
EndFunction


BreathEventArgs Function GetBreathEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as BreathEventArgs
	Else
		return none
	EndIf
EndFunction


; Scaleform
;---------------------------------------------

bool Function SetOverlay(int identifier)
	If (IsOpen)
		If (identifier >= Default && identifier <= Empty)
			var[] arguments = new var[1]
			arguments[0] = identifier
			UI.Invoke(Name, GetMember("SetOverlay", Instance), arguments)
			WriteLine(self, "SetOverlay", identifier)
			return true
		Else
			WriteUnexpectedValue(self, "SetOverlay", "identifier", "The value of "+identifier+" is out of range.")
			return false
		EndIf
	Else
		WriteUnexpected(self, "SetOverlay", ToString()+" is not open.")
		return false
	EndIf
EndFunction


; Methods
;---------------------------------------------

string Function ToString()
	{The string representation of this type.}
	return parent.ToString()+"[Instance:"+Instance+"]"
EndFunction


; Properties
;---------------------------------------------

; @override
string Function GetName()
	return "ScopeMenu"
EndFunction

; @override
string Function GetFile()
	return "ScopeMenu"
EndFunction

; @override
string Function GetInstance()
	return ".ScopeMenuInstance"
EndFunction


Group Identifiers
	int Property Default = 0 AutoReadOnly
	int Property Fine = 1 AutoReadOnly
	int Property Duplex = 2 AutoReadOnly
	int Property German = 3 AutoReadOnly
	int Property Dot = 4 AutoReadOnly
	int Property MilDot = 5 AutoReadOnly
	int Property Circle = 6 AutoReadOnly
	int Property OldRangefind = 7 AutoReadOnly
	int Property ModernRangefind = 8 AutoReadOnly
	int Property SVD = 9 AutoReadOnly
	int Property HandPainted = 10 AutoReadOnly
	int Property Binoculars = 11 AutoReadOnly
	int Property M14NightVision = 12 AutoReadOnly
	int Property Zero = 13 AutoReadOnly
	int Property InternalRangefinder = 14 AutoReadOnly
	int Property Rangefinder00 = 15 AutoReadOnly
	int Property AssaultRifle_REC = 16 AutoReadOnly
	int Property GaussRiflePrototypeA = 17 AutoReadOnly
	int Property GaussRiflePrototypeB = 18 AutoReadOnly
	int Property SolarCannon = 19 AutoReadOnly
	int Property SolarCannonNight = 20 AutoReadOnly
	int Property Empty = 21 AutoReadOnly
EndGroup
