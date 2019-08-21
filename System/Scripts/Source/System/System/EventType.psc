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
	int Property From = 0 AutoReadOnly Hidden
	int Property With = 1 AutoReadOnly Hidden
EndGroup


; Methods
;---------------------------------------------

bool Function Invoke(var[] delegate)
	If (delegate)
		If (delegate[From])
			If (delegate[With])
				self.SendCustomEvent("Delegate", delegate)
				return true
			Else
				ThrowArgumentNoneEmpty(self, "Invoke", "delegate.With", "The delegate parameter at index '"+With+"' cannot be none or empty.", log="System")
				return false
			EndIf
		Else
			ThrowArgumentNoneEmpty(self, "Invoke", "delegate.From", "The delegate sender at index '"+From+"' cannot be none.", log="System")
			return false
		EndIf
	Else
		ThrowArgumentNoneEmpty(self, "Invoke", "delegate", "The delegate cannot be none or empty.", log="System")
		return false
	EndIf
EndFunction

;---------------------------------------------

bool Function Register(ScriptObject listener)
	If (listener)
		listener.RegisterForCustomEvent(self, "Delegate")
		return true
	Else
		ThrowArgumentNoneEmpty(self, "Register", "listener", "Cannot register a none script for an event.", log="System")
		return false
	EndIf
EndFunction


bool Function Unregister(ScriptObject listener)
	If (listener)
		listener.UnregisterForCustomEvent(self, "Delegate")
		return true
	Else
		ThrowArgumentNoneEmpty(self, "Unregister", "listener", "Cannot unregister a none script for an event.", log="System")
		return false
	EndIf
EndFunction

;---------------------------------------------

; @virtual
ScriptObject Function ToSender(var[] arguments)
	If (arguments)
		return arguments[From] as ScriptObject
	Else
		ThrowArgumentNoneEmpty(self, "ToSender", "arguments", log="System")
		return none
	EndIf
EndFunction


; @virtual
var Function ToArguments(var[] arguments)
	If (arguments)
		return arguments[With]
	Else
		ThrowArgumentNoneEmpty(self, "ToArguments", "arguments", log="System")
		return none
	EndIf
EndFunction
