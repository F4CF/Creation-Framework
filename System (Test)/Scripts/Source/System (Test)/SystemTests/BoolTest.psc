ScriptName SystemTests:BoolTest Extends System:Diagnostics:Lilac
import System:BoolType
import System:Log

; Lilac
;---------------------------------------------

Function Setup()
	WriteLine("Executing the Setup function.")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine("Executing the TestSuites function.")
	describe("Boolean To Integer", BoolToIntSuite())
EndFunction


; Suites
;---------------------------------------------

bool Function BoolToIntSuite()
	WriteLine("BoolToIntSuite")
	it("should be converted to a valid integer", BoolToIntCase())
	return Done
EndFunction


; Cases
;---------------------------------------------

bool Function BoolToIntCase()
	WriteLine("BoolToIntCase")
	expect(BoolToInt(true), to, beEqualTo, 1)
	expect(BoolToInt(false), to, beEqualTo, 0)
	return Done
EndFunction
