ScriptName System:UI:OpenCloseEvent Extends System:EventType
import System:Debug
import System:Exception


; The arguments for this event.
Struct OpenCloseEventArgs
	bool Opening = false
EndStruct


; Event
;---------------------------------------------

; @System:EventType.Invoke
bool Function Send(ScriptObject sender, OpenCloseEventArgs e)
	If (sender)
		If (e)
			var[] delegate = new var[2]
			delegate[From] = sender
			delegate[With] = e
			return Invoke(delegate)
		Else
			ThrowArgumentNoneEmpty(self, "Send", "e", "The argument cannot be none.", log="System")
		EndIf
	Else
		ThrowArgumentNoneEmpty(self, "Send", "sender", "The sender cannot be none.", log="System")
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
OpenCloseEventArgs Function Arguments(var[] arguments)
	return ToArguments(arguments) as OpenCloseEventArgs
EndFunction
