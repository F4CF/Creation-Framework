ScriptName System:EventType Extends System:Object Const Hidden
{Events enable scripts to notify other scripts when something of interest occurs.

**See Also**
* https://docs.microsoft.com/en-us/dotnet/api/system.delegate
* https://docs.microsoft.com/en-us/dotnet/api/system.eventargs
}
import System:Debug
import System:Exception


; The custom delegate delegate.
CustomEvent Delegate

Group Events
	int Property SenderIndex = 0 AutoReadOnly Hidden
	int Property ArgumentsIndex = 1 AutoReadOnly Hidden
EndGroup


; Methods
;---------------------------------------------

bool Function Invoke(var[] delegate)
	If (delegate)
		If (delegate[SenderIndex])
			If (delegate[ArgumentsIndex])
				self.SendCustomEvent("Delegate", delegate)
				return true
			Else
				ThrowArgumentNoneEmpty(self, "Invoke", "delegate.ArgumentsIndex", "The delegate arguments at index '"+ArgumentsIndex+"' cannot be none or empty.")
				return false
			EndIf
		Else
			ThrowArgumentNoneEmpty(self, "Invoke", "delegate.SenderIndex", "The delegate sender at index '"+SenderIndex+"' cannot be none.")
			return false
		EndIf
	Else
		ThrowArgumentNoneEmpty(self, "Invoke", "delegate", "The delegate cannot be none or empty.")
		return false
	EndIf
EndFunction

;---------------------------------------------

bool Function Register(ScriptObject listener)
	If (listener)
		listener.RegisterForCustomEvent(self, "Delegate")
		return true
	Else
		ThrowArgumentNoneEmpty(self, "Register", "listener", "Cannot register a none script for an event.")
		return false
	EndIf
EndFunction


bool Function Unregister(ScriptObject listener)
	If (listener)
		listener.UnregisterForCustomEvent(self, "Delegate")
		return true
	Else
		ThrowArgumentNoneEmpty(self, "Unregister", "listener", "Cannot unregister a none script for an event.")
		return false
	EndIf
EndFunction

;---------------------------------------------

; @virtual
ScriptObject Function ToSender(var[] arguments)
	If (arguments)
		return arguments[SenderIndex] as ScriptObject
	Else
		ThrowArgumentNoneEmpty(self, "ToSender", "var[] arguments")
		return none
	EndIf
EndFunction


; @virtual
var Function ToArguments(var[] arguments)
	If (arguments)
		return arguments[ArgumentsIndex]
	Else
		ThrowArgumentNoneEmpty(self, "ToArguments", "var[] arguments")
		return none
	EndIf
EndFunction
