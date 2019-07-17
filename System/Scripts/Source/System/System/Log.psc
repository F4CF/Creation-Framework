ScriptName System:Log Extends System:Object Native Const Hidden DebugOnly
{Represents the standard output for script information, warnings, and errors.

**See Also**
* https://docs.microsoft.com/en-us/dotnet/api/system.console
* https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics
* https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.trace
}


; Methods
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
bool Function Trace(string filename, string text, int severity = 0) Global DebugOnly
	return Debug.TraceUser(filename, text, severity)
EndFunction


; Outputs the string text to a user log by file name.
; A log will be opened if one is not already.
; @return: False if the log could not be opened.
bool Function Write(string filename, string text, int severity = 0) Global DebugOnly
	If (Trace(filename, text, severity))
		return true
	ElseIf (Open(filename))
		return Trace(filename, text, severity)
	Else
		return false
	EndIf
EndFunction


; Writes script info as lines in a log file.
bool Function WriteLine(string filename, string script, string member, string text = "") Global DebugOnly
	If !(text)
		return Write(filename, script+"["+member+"]")
	Else
		return Write(filename, script+"["+member+"] "+text)
	EndIf
EndFunction
