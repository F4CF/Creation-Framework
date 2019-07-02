ScriptName System:Diagnostics:LilacEx extends System:Diagnostics:Lilac
import System:Log

; Overrides
;---------------------------------------------

string Function CreateLilacDebugMessage(int aiLogLevel, string asMessage)
	string level
	string value = "[" + SystemName + "] " + getLogLevel(aiLogLevel) + asMessage
	Write(Common.LogFile, value)
	return value
EndFunction


; Expectations
;---------------------------------------------

bool Function expectIsNotNone(var aValue)
	expect(aValue as bool, to, beTruthy)
	return Done
EndFunction


bool Function expectStringHasText(string asValue)
	expectIsNotNone(asValue)
	expect(asValue, notTo, beEqualTo, "")
	return Done
EndFunction


; Properties
;---------------------------------------------

Group Properties
	System:Diagnostics:Common Property Common Auto Const Mandatory
EndGroup

Group Constants
	bool Property Done = true AutoReadOnly
EndGroup
