ScriptName SystemTests:BoolTest Extends System:Diagnostics:Lilac
import System:BoolType
import System:Log

; Lilac
;---------------------------------------------

Function Setup()
	WriteLine("SystemTests:BoolTest", "Executing the Setup function.")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine("SystemTests:BoolTest", "Executing the TestSuites function.")
	describe("Boolean To Integer", BoolToIntSuite())
EndFunction


; Suites
;---------------------------------------------

bool Function BoolToIntSuite()
	WriteLine("SystemTests:BoolTest", "BoolToIntSuite")
	it("should be converted to a valid integer", BoolToIntCase())
	return Done
EndFunction


; Cases
;---------------------------------------------

bool Function BoolToIntCase()
	WriteLine("SystemTests:BoolTest", "BoolToIntCase")
	expect(BoolToInt(true), to, beEqualTo, 1)
	expect(BoolToInt(false), to, beEqualTo, 0)
	return Done
EndFunction
