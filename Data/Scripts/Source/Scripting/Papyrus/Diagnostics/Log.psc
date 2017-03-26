Scriptname Papyrus:Diagnostics:Log Hidden Const DebugOnly
import Papyrus:StringType


Struct UserLog
	string FileName
	string Caller
EndStruct


; Logging
;---------------------------------------------

UserLog Function Log(string filename, string caller = "") Global
	UserLog log = new UserLog
	log.FileName = filename
	log.Caller = caller
	return log
EndFunction


bool Function Write(string filename, string text) Global
	If(Debug.TraceUser(filename, text))
		return true
	Else
		Debug.OpenUserLog(filename)
		return Debug.TraceUser(filename, text)
	EndIf
EndFunction


bool Function WriteLine(UserLog userLog, var text) Global
	string defaultFile = "Scripting" const

	If (userLog == none)
		userLog = new UserLog
		userLog.Caller = ""
		userLog.FileName = defaultFile
	ElseIf (StringIsNoneOrEmpty(userLog.FileName))
		userLog.FileName = defaultFile
	EndIf

	text = userLog.Caller + " " + text
	return Write(userLog.FileName, text)
EndFunction


; Display
;---------------------------------------------

Function WriteNotification(UserLog userLog, var text) Global
	If (WriteLine(userLog, text))
		Debug.Notification(text)
	EndIf
EndFunction


Function WriteMessage(UserLog userLog, var text) Global
	If (WriteLine(userLog, text))
		Debug.MessageBox(text)
	EndIf
EndFunction


; Formatting
;---------------------------------------------

Function WriteChangedValue(UserLog userLog, string propertyName, var fromValue, var toValue) Global
	WriteLine(userLog, "Changing "+propertyName+" from " + fromValue + " to " + toValue)
EndFunction
