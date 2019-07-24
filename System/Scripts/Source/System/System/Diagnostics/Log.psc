ScriptName System:Diagnostics:Log Extends System:Object Native Const Hidden DebugOnly
{Provides a set of methods and properties that help you trace the execution of your code.}


Struct Line
	string FileName = ""
	string Text = ""
	int Severity = 0
	{Severity is one of the following:
	0 - Info
	1 - Warning
	2 - Error}
EndStruct


; Methods
;---------------------------------------------

Line Function Line(string text, string filename = "") Global DebugOnly
	Line this = new Line
	this.FileName = filename
	this.Text = text
	return this
EndFunction


bool Function Writer(Line this) Global DebugOnly
	If (this)
		If (this.Text)
			If (!this.FileName)
				System:Diagnostics:Log.Trace(this.Text, this.Severity)
				return true
			Else
				System:Diagnostics:LogFile.Write(this.FileName, this.Text, this.Severity)
				return true
			EndIf
		Else
			return false
		EndIf
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
	Debug.MessageBox(text)
	Trace(text, severity)
EndFunction


; A convenient way to trace the script name and optional `member` name as a prefix to the trace string.
; Note, always pass in `self` as the `caller`.
bool Function TraceSelf(ScriptObject caller, string member, string text) Global DebugOnly
	Trace(Format(caller, member, text))
	return true
EndFunction


; Formatters
;---------------------------------------------

string Function Format(var caller, string member = "", string text = "") Global DebugOnly
	string script
	If !(caller)
	ElseIf !(caller is ScriptObject)
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

;---------------------------------------------

; string Function Formatter(string title, string text = "", string seperator = " ") Global DebugOnly
; 	If (text)
; 		return title+seperator+text
; 	Else
; 		return title
; 	EndIf
; EndFunction
