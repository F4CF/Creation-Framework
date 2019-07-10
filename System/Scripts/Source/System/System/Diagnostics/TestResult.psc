ScriptName System:Diagnostics:TestResult Extends System:Log DebugOnly

; Properties
;---------------------------------------------

; @overrides
string Function GetFile() DebugOnly
	{Property}
	return "TestResult"
EndFunction
