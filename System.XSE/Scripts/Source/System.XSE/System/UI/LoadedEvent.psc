ScriptName System:UI:LoadedEvent Extends System:EventType
import System:Debug

; The custom event delegate.
CustomEvent Delegate

; The custom event arguments.
Struct LoadedEventArgs
	bool Success = false
	string Variable = ""
EndStruct


; Event
;---------------------------------------------

; Methods
;---------------------------------------------

; @overrides
bool Function Register(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "Delegate")
		return true
	Else
		System:Debug.WriteUnexpectedValue("System", self, "Register", "script", "Cannot register a none script for events.")
		return false
	EndIf
EndFunction


; @overrides
bool Function Unregister(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "Delegate")
		return true
	Else
		System:Debug.WriteUnexpectedValue("System", self, "Unregister", "script", "Cannot unregister a none script for events.")
		return false
	EndIf
EndFunction


LoadedEventArgs Function GetLoadedEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as LoadedEventArgs
	Else
		return none
	EndIf
EndFunction
