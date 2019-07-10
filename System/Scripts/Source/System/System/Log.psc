ScriptName System:Log Extends System:Object Native Const Hidden DebugOnly
{Represents the standard output for script information, warnings, and errors.

**See Also**
* https://docs.microsoft.com/en-us/dotnet/api/system.console
* https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics
* https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.trace
}
import System:Exception


; Properties
;---------------------------------------------

; @abstract
; Gets this file property value.
string Function GetFile() DebugOnly
	{Property}
	Abstract(self, "GetFile", "This member must be overridden with an extending script.")
	return ""
EndFunction

Group Properties
	string Property File Hidden
		string Function Get()
			return GetFile()
		EndFunction
	EndProperty
EndGroup


; Methods
;---------------------------------------------

bool Function WriteG(System:Log this, string value) Global DebugOnly
	return System:Log.Write(this.File, value)
EndFunction


; Opens a new user log. Fails if the log is already open.
bool Function OpenG(System:Log this) Global DebugOnly
	return System:Log.Open(this.File)
EndFunction


; Closes the specified user log.
bool Function CloseG(System:Log this) Global DebugOnly
	System:Log.Close(this.File)
	return true
EndFunction


; @overrides
; Returns a string that represents the current object.
string Function ToString()
	return "[FormID:"+FormID+", File:"+File+"]"
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
	System:Log.Trace(caller + member + " " + text)
	return true
EndFunction


; File
;---------------------------------------------

; Opens a new user log using the given file name.
; @return: False if the log is already open.
bool Function Open(string filename) Global DebugOnly
	return Debug.OpenUserLog(filename)
EndFunction


; Closes the specified user log by file name.
; @return: True
bool Function Close(string filename) Global DebugOnly
	Debug.CloseUserLog(filename)
	return true
EndFunction


; Outputs the string text to a user log by file name.
; @return: False if the log has not already been opened.
bool Function Write(string filename, string text) Global DebugOnly
	return Debug.TraceUser(filename, text)
EndFunction


; Outputs the string text to a user log by file name.
; A log will be opened if one is not already.
; @return: False if the log could not be opened.
bool Function TryWrite(string filename, string text) Global DebugOnly
	If (Write(filename, text))
		return true
	ElseIf (Open(filename))
		return Write(filename, text)
	Else
		return false
	EndIf
EndFunction


; Printing
;---------------------------------------------

bool Function Print(string filename, string prefix, string text) Global DebugOnly
	{Writes text as lines in a log file.}
	Write(filename, prefix + " " + text)
EndFunction


bool Function WriteNotification(string filename, string prefix, string text) Global DebugOnly
	{Writes notifications as lines in a log file.}
	Debug.Notification(text)
	return Print(filename, prefix, text)
EndFunction


bool Function WriteMessage(string filename, string prefix, string title, string text = "") Global DebugOnly
	{Writes messages as lines in a log file.}
	string value
	If (text)
		value = title+"\n"+text
	EndIf
	Debug.MessageBox(value)
	return Print(filename, prefix, title+" "+text)
EndFunction


; Debug
;---------------------------------------------

bool Function WriteLine(string filename, var script, string member, string text = "") Global DebugOnly
	{Writes script info as lines in a log file.}
	If !(text)
		return Print(filename, script, member)
	Else
		return Print(filename, script+"["+member+"]", text)
	EndIf
EndFunction


bool Function WriteUnexpected(string filename, var script, string member, string text = "") Global DebugOnly
	{The script had an unexpected operation.}
	return Print(filename, script+"["+member+"]", "The member '"+member+"' had an unexpected operation. "+text)
EndFunction


bool Function WriteUnexpectedValue(string filename, var script, string member, string variable, string text = "") Global DebugOnly
	{The script had and unexpected value.}
	return Print(filename, script+"["+member+"."+variable+"]", "The member '"+member+"' with variable '"+variable+"' had an unexpected operation. "+text)
EndFunction


Function WriteChangedValue(string filename, var script, string propertyName, var fromValue, var toValue) Global DebugOnly
	{The value has changed from one value to another.}
	WriteLine(filename, script, "Changing '"+propertyName+"' from '"+fromValue+"' to '"+toValue+"'.")
EndFunction
