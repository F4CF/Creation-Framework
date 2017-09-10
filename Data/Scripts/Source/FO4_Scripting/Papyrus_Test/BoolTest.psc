ScriptName Papyrus_Test:BoolTest extends Papyrus_Test:Framework:Lilac
import Papyrus:BoolType
import Papyrus:Diagnostics:Log

UserLog Log


; Events
;---------------------------------------------

Event OnInit()
	Log = LogNew(Common.LogFile, self)
	parent.OnInit()
EndEvent


; Lilac
;---------------------------------------------

Function Setup()
	WriteLine(Log, "Executing the Setup function.")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine(Log, "Executing the TestSuites function.")
	describe("Boolean To Integer", BoolToIntSuite())
EndFunction


; Suites
;---------------------------------------------

bool Function BoolToIntSuite()
	WriteLine(Log, "BoolToIntSuite")
	it("should be converted to a valid integer", BoolToIntCase())
	return Done
EndFunction


; Cases
;---------------------------------------------

bool Function BoolToIntCase()
	WriteLine(Log, "BoolToIntCase")
	expect(BoolToInt(true), to, beEqualTo, 1)
	expect(BoolToInt(false), to, beEqualTo, 0)
	return Done
EndFunction
