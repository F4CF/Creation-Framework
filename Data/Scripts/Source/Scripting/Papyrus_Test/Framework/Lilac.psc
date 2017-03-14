ScriptName Papyrus_Test:Framework:Lilac extends Lilac


; Constants
;---------------------------------------------
string Property LogFile = "Lilac" AutoReadOnly
bool Property Done = true AutoReadOnly


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
