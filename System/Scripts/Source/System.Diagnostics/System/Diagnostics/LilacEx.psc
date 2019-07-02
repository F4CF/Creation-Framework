ScriptName System:Diagnostics:LilacEx extends System:Diagnostics:Lilac
import System:Log

; Overrides
;---------------------------------------------

string Function CreateLilacDebugMessage(int aiLogLevel, string asMessage)
	string level
	string value = "[" + SystemName + "] " + getLogLevel(aiLogLevel) + asMessage
	Write("TestLog", value)
	return value
EndFunction


; Expectations
;---------------------------------------------

bool Function expectIsNotNone(var aValue)
	expect(aValue as bool, To, beTruthy)
	return Done
EndFunction


bool Function expectStringHasText(string asValue)
	expectIsNotNone(asValue)
	expect(asValue, NotTo, BeEqualTo, "")
	return Done
EndFunction
