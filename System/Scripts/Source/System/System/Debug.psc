ScriptName System:Debug Extends System:Object Native Hidden Const DebugOnly
{Provides a set of methods and properties that help debug your code.

**See Also**
* https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.debug
}
import System:Diagnostics:Log
import System:Text


; Formatters
;---------------------------------------------

string Function Script(var caller, string member = "", string text = "") Global DebugOnly
	string script
	If !(caller is ScriptObject)
		script = "["+caller+"]"
	Else
		script = caller
	EndIf
	If (member)
		member = "-->"+member+"():"
	EndIf
	If (text)
		text = " "+text
	EndIf
	return System:Text.Concat(script, member, text)
EndFunction


; Methods
;---------------------------------------------

; Writes script info as a line in a log file.
bool Function WriteLine(string script, string member, string text = "", string log = "") Global DebugOnly
	return Writer(Line(Script(script, member, text), log))
EndFunction


; Writes script info as lines in a log file.
bool Function WriteLines(string script, string member, var[] texts, string log = "") Global DebugOnly
	If (texts)
		If (Writer(Line(Script(script, member, "..."), log)))
			int index = 0
			While (index < texts.Length)
				Writer(Line(Script(script, member, ">"+texts[index]), log))
				index += 1
			EndWhile
			return true
		Else
			return false
		EndIf
	Else
		return false
	EndIf
EndFunction


; Writes notifications as lines in a log file.
bool Function WriteNotification(string script, string member, string title, string text = "", string log = "") Global DebugOnly
	Debug.Notification(Join(": ", title, text))
	return Writer(Line(Script(script, member, text), log))
EndFunction


; Writes messages as lines in a log file.
; A convenience function to throw both a message box AND write to the trace log.
; Since message boxes sometimes stack in weird ways and won't show up reliably.
bool Function WriteMessage(string script, string member, string title, string text = "", string log = "") Global DebugOnly
	Debug.MessageBox(Join("\n", title, text))
	return Writer(Line(Script(script, member, text), log))
EndFunction


; Expectations
;---------------------------------------------

; The script had an unexpected operation.
bool Function WriteUnexpected(var script, string member, string text = "", string log = "") Global DebugOnly
	return Writer(Line(Script(script, member, "The member '"+member+"' had an unexpected operation. "+text), log))
EndFunction


; The script had and unexpected value.
bool Function WriteUnexpectedValue(var script, string member, string variable, string text = "", string log = "") Global DebugOnly
	return Writer(Line(Script(script, member, "The member '"+member+"' with variable '"+variable+"' had an unexpected operation. "+text), log))
EndFunction


; The value has changed from one value to another.
bool Function WriteChangedValue(var script, string variable, var fromValue, var toValue, string log = "") Global DebugOnly
	return Writer(Line(Script(script, variable, "Changing '"+variable+"' from '"+fromValue+"' to '"+toValue+"'."), log))
EndFunction


; Assertions
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
		System:Diagnostics:Log.Trace(text, severity)
		Debug.TraceStack(text, severity)
		Debug.MessageBox(text)
		return true
	EndIf
EndFunction


; Methods
;---------------------------------------------

; ; Suppressable Trace
; ; As Trace() but takes a second parameter bool `condition` (which if false suppresses the message).
; ; Used to toggle traces that might be otherwise annoying.
; ; @return: False if the log text was not written.
; bool Function TraceIf(string text, bool condition, int severity = 0) Global DebugOnly
; 	If (condition)
; 		return Trace(text, severity)
; 	Else
; 		return false
; 	EndIf
; EndFunction


; ; Suppressable Trace
; ; As TraceConditional() but checks to make sure the global exists to avoid error messages in the log.
; bool Function TraceIfGlobal(string text, GlobalVariable condition, int severity = 0) Global DebugOnly
; 	If (System:GlobalVariable.ToBoolean(condition))
; 		return Trace(text, severity)
; 	Else
; 		return false
; 	EndIf
; EndFunction


; ; A convenience function to throw both a message box AND write to the trace log.
; ; Since message boxes sometimes stack in weird ways and won't show up reliably.
; bool Function TraceAndBox(string text, int severity = 0) Global DebugOnly
; 	Debug.MessageBox(text)
; 	Trace(text, severity)
; EndFunction


; ; A convenient way to trace the script name and optional `member` name as a prefix to the trace string.
; ; Note, always pass in `self` as the `caller`.
; bool Function TraceSelf(ScriptObject caller, string member, string text) Global DebugOnly
; 	Trace(Script(caller, member, text))
; 	return true
; EndFunction
