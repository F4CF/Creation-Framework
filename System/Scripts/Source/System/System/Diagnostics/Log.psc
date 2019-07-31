ScriptName System:Diagnostics:Log Extends System:Object Native Const Hidden DebugOnly
{Represents the standard output for script information, warnings, and errors.
This provides a set of methods that help trace the execution of your code.

**See Also**
* https://docs.microsoft.com/en-us/dotnet/api/system.console
* https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics
* https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.trace
}


Struct Line
	string Text = ""
	{Gets the line text to write.}
	int Severity = 0
	{Severity is one of the following:
	0 - Info
	1 - Warning
	2 - Error}
	string Log = ""
	{The file name to write this line to. An empty string specifies `Papyrus.0.log`.}
EndStruct


; Instantiates a new log line object.
Line Function Line(string text, string filename = "", int Severity = 0) Global DebugOnly
	Line this = new Line
	this.Text = text
	this.Log = filename
	return this
EndFunction


bool Function Writer(Line this) Global DebugOnly
	If (this)
		If (this.Text)
			If (!this.Log)
				Trace(this.Text, this.Severity)
				return true
			Else
				WriteTo(this.Log, this.Text, this.Severity)
				return true
			EndIf
		Else
			return false
		EndIf
	Else
		return false
	EndIf
EndFunction


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
bool Function Write(string filename, string text, int severity = 0) Global DebugOnly
	return Debug.TraceUser(filename, text, severity)
EndFunction


; Outputs the string text to a user log by file name.
; A log will be opened if one is not already.
; @return: False if the log could not be opened.
bool Function WriteTo(string filename, string text, int severity = 0) Global DebugOnly
	If (Write(filename, text, severity))
		return true
	ElseIf (Open(filename))
		return Write(filename, text, severity)
	Else
		return false
	EndIf
EndFunction


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
