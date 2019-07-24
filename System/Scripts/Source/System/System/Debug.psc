ScriptName System:Debug Extends System:Object Native Hidden Const DebugOnly
{Provides a set of methods and properties that help debug your code.

**See Also**
* https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.debug
}
import System:Diagnostics:Log
import System:StringType

; Methods
;---------------------------------------------

; Writes script info as a line in a log file.
bool Function WriteLine(string script, string member, string text = "", string filename = "") Global DebugOnly
	return Writer(Line(Format(script, member, text), filename))
EndFunction


; Writes script info as lines in a log file.
bool Function WriteLines(string script, string member, var[] texts, string filename = "") Global DebugOnly
	If (texts)
		If (Writer(Line(Format(script, member, "..."))), filename)
			int index = 0
			While (index < texts.Length)
				Writer(Line(Format(script, member, ">"+texts[index]), filename))
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
bool Function WriteNotification(string script, string member, string title, string text = "", string filename = "") Global DebugOnly
	Debug.Notification(StringConcat(title, text, seperator=": "))
	return Writer(Line(Format(script, member, text), filename))
EndFunction


; Writes messages as lines in a log file.
bool Function WriteMessage(string script, string member, string title, string text = "", string filename = "") Global DebugOnly
	Debug.MessageBox(StringConcat(title, text, seperator="\n"))
	return Writer(Line(Format(script, member, text), filename))
EndFunction


; Expectations
;---------------------------------------------

; The script had an unexpected operation.
bool Function WriteUnexpected(var script, string member, string text = "", string filename = "") Global DebugOnly
	string help = "The member '"+member+"' had an unexpected operation. "
	string value = Format(script, member, help+" "+text)

	Line this = Line(value, filename)
	return Writer(this)
EndFunction

; The script had and unexpected value.
bool Function WriteUnexpectedValue(var script, string member, string variable, string text = "", string filename = "") Global DebugOnly
	string s1 = script+"["+member+"."+variable+"]"
	string s2 = "The member '"+member+"' with variable '"+variable+"' had an unexpected operation. "+text
	return Writer(Line(Format(script, member, text), filename))
EndFunction

; The value has changed from one value to another.
bool Function WriteChangedValue(var script, string variable, var fromValue, var toValue, string filename = "") Global DebugOnly
	string s1 = script
	string s2 = "Changing '"+variable+"' from '"+fromValue+"' to '"+toValue+"'."
	return Writer(Line(Format(script, member, text), filename))
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
