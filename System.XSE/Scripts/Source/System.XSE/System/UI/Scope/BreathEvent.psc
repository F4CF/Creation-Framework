ScriptName System:UI:Scope:BreathEvent Extends System:EventType
import System:Debug
import System:Exception


; The arguments for this event.
Struct BreathEventArgs
	int Breath = -1
EndStruct


; Event
;---------------------------------------------

; @System:EventType.Invoke
bool Function Send(System:UI:Scope:Menu sender, BreathEventArgs e)
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
System:UI:Scope:Menu Function Sender(var[] arguments)
	return ToSender(arguments) as System:UI:Scope:Menu
EndFunction


; @System:EventType.Arguments
BreathEventArgs Function Arguments(var[] arguments)
	return ToArguments(arguments) as BreathEventArgs
EndFunction
