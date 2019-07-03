ScriptName System:Diagnostics:UnitTest Extends System:Diagnostics:TestRunner
import System:Log

; Overrides
;---------------------------------------------

bool Function ExpectIsNotNone(var value)
	Expect(value as bool, To, BeTruthy)
	return Done
EndFunction


bool Function ExpectStringHasText(string value)
	ExpectIsNotNone(value)
	Expect(value, NotTo, BeEqualTo, "")
	return Done
EndFunction
