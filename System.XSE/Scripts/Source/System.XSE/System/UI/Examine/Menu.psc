ScriptName System:UI:Examine:Menu Extends System:UI:Examine:MenuType
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


; Properties
;---------------------------------------------

; @overrides
string Function GetName()
	return "ExamineMenu"
EndFunction

; @overrides
string Function GetFile()
	return "ExamineMenu"
EndFunction

; @override
string Function GetInstance()
	return ".BaseInstance"
EndFunction
