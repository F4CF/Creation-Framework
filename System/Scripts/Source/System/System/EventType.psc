ScriptName System:EventType Extends System:Object Const Hidden
{Events enable scripts to notify other scripts when something of interest occurs.

**See Also**
* https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/events/
* https://docs.microsoft.com/en-us/dotnet/api/system.delegate
* https://docs.microsoft.com/en-us/dotnet/api/system.eventhandler
* https://docs.microsoft.com/en-us/dotnet/api/system.eventargs
}
import System:Exception

; The custom event delegate.
CustomEvent Delegate

;/ Requires
* The custom event arguments.
  * bool Send(ScriptObject, var)
  * bool Register(ScriptObject)
  * bool Unregister(ScriptObject)
  * ScriptObject Sender(var[])
  * var Arguments(var[] arguments)
/;


; Methods
;---------------------------------------------

; @abstract
bool Function Register(ScriptObject script)
	Abstract(self, "Register")
EndFunction


; @abstract
bool Function Unregister(ScriptObject script)
	Abstract(self, "Unregister")
EndFunction

;---------------------------------------------

bool Function Send(ScriptObject sender, var e)
	If (sender)
		If (e)
			var[] arguments = new var[1]
			arguments[0] = sender
			arguments[1] = e
			self.SendCustomEvent("Delegate", arguments)
			return true
		Else
			ThrowArgumentNone(self, "Send", "e", "The argument cannot be none.")
			return false
		EndIf
	Else
		ThrowArgumentNone(self, "Send", "sender", "The argument cannot be none.")
		return false
	EndIf
EndFunction


; @virtual
ScriptObject Function Sender(var[] arguments)
	If (arguments)
		return arguments[0] as ScriptObject
	Else
		ThrowArgumentNone(self, "Sender", "var[] arguments")
		return none
	EndIf
EndFunction


; @virtual
var Function Arguments(var[] arguments)
	If (arguments)
		return arguments[1]
	Else
		ThrowArgumentNone(self, "Arguments", "var[] arguments")
		return none
	EndIf
EndFunction
