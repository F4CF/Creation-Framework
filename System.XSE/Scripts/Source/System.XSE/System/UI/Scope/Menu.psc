ScriptName System:UI:Scope:Menu Extends System:UI:Scope:MenuType
import System:Log


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
		WriteUnexpectedValue("System", self, "RegisterForOpenCloseEvent", "script", "Cannot register a none script for events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForOpenCloseEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OpenCloseEvent")
		return true
	Else
		WriteUnexpectedValue("System", self, "UnregisterForOpenCloseEvent", "script", "Cannot unregister a none script for events.")
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
		WriteUnexpectedValue("System", self, "RegisterForBreathEvent", "script", "Cannot register a none script for events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForBreathEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "BreathEvent")
		return true
	Else
		WriteUnexpectedValue("System", self, "UnregisterForBreathEvent", "script", "Cannot unregister a none script for events.")
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
			WriteLine("System", self, "SetOverlay", identifier)
			return true
		Else
			WriteUnexpectedValue("System", self, "SetOverlay", "identifier", "The value of "+identifier+" is out of range.")
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
