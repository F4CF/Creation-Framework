ScriptName System:Debug Extends System:Object Native Hidden Const DebugOnly
{Provides a set of methods and properties that help debug your code.

**See Also**
* https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.debug
}

;---------------------------------------------

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
		System:Debug.Trace(text, severity)
		Debug.TraceStack(text, severity)
		Debug.MessageBox(text)
		return true
	EndIf
EndFunction


; Debug
;---------------------------------------------

; The script had an unexpected operation.
bool Function WriteUnexpected(string filename, var script, string member, string text = "") Global DebugOnly
	return System:Log.WriteLine(filename, script+"["+member+"]", "The member '"+member+"' had an unexpected operation. "+text)
EndFunction

; The script had and unexpected value.
bool Function WriteUnexpectedValue(string filename, var script, string member, string variable, string text = "") Global DebugOnly
	return System:Log.WriteLine(filename, script+"["+member+"."+variable+"]", "The member '"+member+"' with variable '"+variable+"' had an unexpected operation. "+text)
EndFunction

; The value has changed from one value to another.
bool Function WriteChangedValue(string filename, var script, string variable, var fromValue, var toValue) Global DebugOnly
	return System:Log.WriteLine(filename, script, "Changing '"+variable+"' from '"+fromValue+"' to '"+toValue+"'.")
EndFunction


; Printing
;---------------------------------------------

; Writes notifications as lines in a log file.
bool Function WriteNotification(string filename, string prefix, string text) Global DebugOnly
	Debug.Notification(text)
	return System:Log.WriteLine(filename, prefix, text)
EndFunction

; Writes messages as lines in a log file.
bool Function WriteMessage(string filename, string prefix, string title, string text = "") Global DebugOnly
	string value
	If (text)
		value = title+"\n"+text
	EndIf
	Debug.MessageBox(value)
	return System:Log.WriteLine(filename, prefix, title+" "+text)
EndFunction


; Trace
;---------------------------------------------
; Provides a set of methods and properties that help you trace the execution of your code.


; Outputs the string to the log
; Severity is one of the following:
; 0 - Info
; 1 - Warning
; 2 - Error
; @return: True
bool Function Trace(string text, int severity = 0) Global DebugOnly
	Debug.Trace(text, severity)
	return true
EndFunction


; Suppressable Trace
; As Trace() but takes a second parameter bool `condition` (which if false suppresses the message).
; Used to toggle traces that might be otherwise annoying.
; @return: False if the log text was not written.
bool Function TraceIf(string text, bool condition, int severity = 0) Global DebugOnly
	If (condition)
		return Trace(text, severity)
	Else
		return false
	EndIf
EndFunction

; Suppressable Trace
; As TraceConditional() but checks to make sure the global exists to avoid error messages in the log.
bool Function TraceIfGlobal(string text, GlobalVariable condition, int severity = 0) Global DebugOnly
	If (System:GlobalVariable.ToBoolean(condition))
		return Trace(text, severity)
	Else
		return false
	EndIf
EndFunction


; A convenience function to throw both a message box AND write to the trace log.
; Since message boxes sometimes stack in weird ways and won't show up reliably.
bool Function TraceAndBox(string text, int severity = 0) Global DebugOnly
	Debug.MessageBox(text) ;;;
	Trace(text, severity)
EndFunction


; A convenient way to trace the script name and optional `member` name as a prefix to the trace string.
; Note, always pass in `self` as the `caller`.
bool Function TraceSelf(ScriptObject caller, string member, string text) Global DebugOnly
	member = "-->" + member + "():"
	System:Debug.Trace(caller + member + " " + text)
	return true
EndFunction
