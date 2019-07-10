ScriptName System:Properties:Log Extends System:Log DebugOnly


System:Properties:Log Function Type() Global
	return System:Type.Read("System.esl", 0x00000838) as System:Properties:Log
EndFunction


; Properties
;---------------------------------------------

; @overrides
; Gets this file property value.
string Function GetFile() DebugOnly
	{Property}
	return "System"
EndFunction
