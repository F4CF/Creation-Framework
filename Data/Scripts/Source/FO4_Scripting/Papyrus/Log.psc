Scriptname Papyrus:Log Hidden Const DebugOnly
import Papyrus:StringType


; Logging
;---------------------------------------------
; Writes messages as lines in a log file.

bool Function WriteLine(string prefix, string text) Global
	string filename = "Papyrus" const
	text = prefix + " " + text
	If(Debug.TraceUser(filename, text))
		return true
	Else
		Debug.OpenUserLog(filename)
		return Debug.TraceUser(filename, text)
	EndIf
EndFunction


bool Function WriteNotification(string prefix, string text) Global
	Debug.Notification(text)
	return WriteLine(prefix, text)
EndFunction


bool Function WriteMessage(string prefix, string title, string text = "") Global
	string value
	If !(StringIsNoneOrEmpty(text))
		value = title+"\n"+text
	EndIf
	Debug.MessageBox(value)
	return WriteLine(prefix, title+" "+text)
EndFunction


; Formated Messages
;---------------------------------------------

bool Function WriteUnexpected(var script, string member, string text = "") Global
	return WriteLine(script+"["+member+"]", "The member '"+member+"' had an unexpected operation. "+text)
EndFunction


bool Function WriteUnexpectedValue(var script, string member, string variable, string text = "") Global
	return WriteLine(script+"["+member+"."+variable+"]", "The member '"+member+"' with variable '"+variable+"' had an unexpected operation. "+text)
EndFunction


bool Function WriteNotImplemented(var script, string member, string text = "") Global
	{The exception that is thrown when a requested method or operation is not implemented.}
	; The exception is thrown when a particular method, get accessors, or set accessors is present as a member of a type but is not implemented.
	return WriteLine(script, member+": The member '"+member+"' was not implemented. "+text)
EndFunction


Function WriteChangedValue(var script, string propertyName, var fromValue, var toValue) Global
	WriteLine(script, "Changing '"+propertyName+"'' from '"+fromValue+"'' to '"+toValue+"'.")
EndFunction


; ; UserLog
; ;---------------------------------------------

; ; TODO: Depreciate
; Struct UserLog
; 	string FileName
; 	string Caller
; EndStruct

; ; TODO: Depreciate
; UserLog Function LogNew(string filename, string caller = "") Global
; 	UserLog log = new UserLog
; 	log.FileName = filename
; 	log.Caller = caller
; 	return log
; EndFunction


; ; Logging
; ;---------------------------------------------

; bool Function Write(string filename, string text) Global
; 	If (StringIsNoneOrEmpty(filename) || filename == "none")
; 		filename = "Scripting"
; 	EndIf
; 	If(Debug.TraceUser(filename, text))
; 		return true
; 	Else
; 		Debug.OpenUserLog(filename)
; 		return Debug.TraceUser(filename, text)
; 	EndIf
; EndFunction


; bool Function WriteLine(UserLog userLog, var text) Global
; 	If (userLog == none)
; 		userLog = new UserLog
; 	EndIf
; 	text = userLog.Caller + " " + text
; 	return Write(userLog.FileName, text)
; EndFunction


; ; Display
; ;---------------------------------------------

; Function WriteNotification(UserLog userLog, var text) Global
; 	If (WriteLine(userLog, text))
; 		Debug.Notification(text)
; 	EndIf
; EndFunction


; Function WriteMessage(UserLog userLog, var text) Global
; 	If (WriteLine(userLog, text))
; 		Debug.MessageBox(text)
; 	EndIf
; EndFunction
