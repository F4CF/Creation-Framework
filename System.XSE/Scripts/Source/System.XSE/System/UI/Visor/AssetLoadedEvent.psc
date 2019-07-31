Scriptname System:UI:Visor:AssetLoadedEvent extends System:EventType
import System:Debug
import System:Exception


; The arguments for this event.
Struct AssetLoadedEventArgs
	string Root = ""
EndStruct


; Event
;---------------------------------------------

; @System:EventType.Invoke
bool Function Send(ScriptObject sender, AssetLoadedEventArgs e)
	If (sender)
		If (e)
			var[] delegate = new var[2]
			delegate[From] = sender
			delegate[With] = e
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
ScriptObject Function Sender(var[] arguments)
	return ToSender(arguments) as ScriptObject
EndFunction


; @System:EventType.Arguments
AssetLoadedEventArgs Function Arguments(var[] arguments)
	return ToArguments(arguments) as AssetLoadedEventArgs
EndFunction
