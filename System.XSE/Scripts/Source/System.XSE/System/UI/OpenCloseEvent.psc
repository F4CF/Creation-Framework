ScriptName System:UI:OpenCloseEvent Extends System:EventType
import System:Debug

; The custom event delegate.
CustomEvent Delegate

; The custom event arguments.
Struct OpenCloseEventArgs
	bool Opening = false
EndStruct


; Event
;---------------------------------------------

bool Function Send(System:Object sender, OpenCloseEventArgs e)
	If (sender)
		If (e)
			var[] arguments = new var[1]
			arguments[0] = sender
			arguments[1] = e
			self.SendCustomEvent("Delegate", arguments)
		Else
			WriteUnexpectedValue("System", self, "SendOpenCloseEvent", "e", "The argument cannot be none.")
		EndIf
	Else
		WriteUnexpectedValue("System", self, "Send", "sender", "The argument cannot be none.")
		return false
	EndIf
EndFunction


; Methods
;---------------------------------------------

; @overrides
bool Function Register(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "Delegate")
		return true
	Else
		WriteUnexpectedValue("System", self, "Register", "script", "Cannot register a none script for events.")
		return false
	EndIf
EndFunction


; @overrides
bool Function Unregister(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "Delegate")
		return true
	Else
		WriteUnexpectedValue("System", self, "Unregister", "script", "Cannot unregister a none script for events.")
		return false
	EndIf
EndFunction


; @System:EventType.Sender
ScriptObject Function GetSender(var[] arguments)
	return Sender(arguments) as ScriptObject
EndFunction


; @System:EventType.Arguments
OpenCloseEventArgs Function GetArguments(var[] arguments)
	return Arguments(arguments) as OpenCloseEventArgs
EndFunction
