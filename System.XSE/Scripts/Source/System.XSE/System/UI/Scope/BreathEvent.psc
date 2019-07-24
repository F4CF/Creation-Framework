ScriptName System:UI:Scope:BreathEvent Extends System:EventType
import System:Debug

; The custom event delegate.
CustomEvent Delegate

; The custom event arguments.
Struct BreathEventArgs
	int Breath = -1
EndStruct


; Event
;---------------------------------------------

bool Function Send(System:UI:Scope:Menu sender, BreathEventArgs e)
	If (sender)
		If (e)
			var[] arguments = new var[1]
			arguments[0] = sender
			arguments[1] = e
			self.SendCustomEvent("Delegate", arguments)
			return true
		Else
			WriteUnexpectedValue("System", self, "Send", "e", "The argument cannot be none.")
			return false
		EndIf
	Else
		WriteUnexpectedValue("System", self, "Send", "sender", "The argument cannot be none.")
		return false
	EndIf
EndFunction


; Methods
;---------------------------------------------

bool Function Register(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "Delegate")
		return true
	Else
		WriteUnexpectedValue("System", self, "Register", "script", "Cannot register a none script for events.")
		return false
	EndIf
EndFunction


bool Function Unregister(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "Delegate")
		return true
	Else
		WriteUnexpectedValue("System", self, "Unregister", "script", "Cannot unregister a none script for events.")
		return false
	EndIf
EndFunction


System:UI:Scope:Menu Function GetSender(var[] arguments)
	If (arguments)
		return arguments[0] as System:UI:Scope:Menu
	Else
		return none
	EndIf
EndFunction


BreathEventArgs Function GetArguments(var[] arguments)
	If (arguments)
		return arguments[1] as BreathEventArgs
	Else
		return none
	EndIf
EndFunction
