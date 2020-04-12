ScriptName System:UI:DynamicLoadEvent Extends System:EventType
{Provides the UI dynamic load event.}
import System:Debug
import System:Exception


; The arguments for this event.
Struct DynamicLoadEventArgs
	bool Success = false
	string MenuName = ""
	string MenuRoot = ""
	string Instance = ""
	string File = ""
EndStruct


; Event
;---------------------------------------------

; @System:EventType.Invoke
bool Function Send(ScriptObject sender, DynamicLoadEventArgs e)
	If (sender)
		If (e)
			var[] delegate = new var[2]
			delegate[From] = sender
			delegate[With] = e
			return Invoke(delegate)
		Else
			ThrowArgumentNoneEmpty(self, "Send", "e", "The argument cannot be none.")
			return false
		EndIf
	Else
		ThrowArgumentNoneEmpty(self, "Send", "sender", "The sender cannot be none.")
		return false
	EndIf
EndFunction


; Methods
;---------------------------------------------

; @System:EventType.Sender
ScriptObject Function Sender(var[] arguments)
	return ToSender(arguments) as ScriptObject
EndFunction


; @System:EventType.Arguments
DynamicLoadEventArgs Function Arguments(var[] arguments)
	return ToArguments(arguments) as DynamicLoadEventArgs
EndFunction
