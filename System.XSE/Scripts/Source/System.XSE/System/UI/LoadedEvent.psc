ScriptName System:UI:LoadedEvent Extends System:EventType
import System:Debug
import System:Exception


; The arguments for this event.
Struct LoadedEventArgs
	bool Success = false
	string Variable = ""
EndStruct


; Event
;---------------------------------------------

; @System:EventType.Invoke
bool Function Send(System:UI:Menu sender, LoadedEventArgs e)
	If (sender)
		If (e)
			var[] delegate = new var[2]
			delegate[SenderIndex] = sender
			delegate[ArgumentsIndex] = e
			return Invoke(delegate)
		Else
			ThrowArgumentNoneEmpty(self, "Send", "e", "The argument cannot be none.")
		EndIf
	Else
		ThrowArgumentNoneEmpty(self, "Send", "sender", "The sender cannot be none.")
		return false
	EndIf
EndFunction


; Methods
;---------------------------------------------

; @System:EventType.Sender
System:UI:Menu Function Sender(var[] arguments)
	return ToSender(arguments) as System:UI:Menu
EndFunction


; @System:EventType.Arguments
LoadedEventArgs Function Arguments(var[] arguments)
	return ToArguments(arguments) as LoadedEventArgs
EndFunction
