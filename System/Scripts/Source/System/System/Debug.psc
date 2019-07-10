ScriptName System:Debug Extends System:Object Native Hidden Const DebugOnly
{Provides a set of methods and properties that help debug your code.

**See Also**
* https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.debug
}


; Checks for a condition; if the condition is `false`,
; outputs a specified message and displays a message box that shows the call stack.
;
; **Parameters**
; * `condition:` The conditional expression to evaluate. If the condition is true,
; the specified message is not sent and the message box is not displayed.
; * `text:` The text message to send.
;
; **Remarks**
; Typically, the *Assert* method is used to identify logic errors during program development.
; The *Assert* method evaluates the *condition*. If the result is `false`, it sends the specified diagnostic message.
;
; **See Also**
; https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.debug.assert
bool Function Assert(bool condition, string text, int severity = 0) Global DebugOnly
	If (condition)
		return false
	Else
		System:Log.Trace(text, severity)
		Debug.TraceStack(text, severity)
		Debug.MessageBox(text)
		return true
	EndIf
EndFunction


