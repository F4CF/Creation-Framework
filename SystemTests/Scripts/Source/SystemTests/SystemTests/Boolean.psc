ScriptName SystemTests:Boolean Extends System:Diagnostics:UnitTest
import System:BoolType
import System:Debug

; Test Runner
;---------------------------------------------

Function Setup()
	WriteLine("System", self, "Executing the Setup function.")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine("System", self, "Executing the TestSuites function.")
	Describe("Boolean To Integer", BoolToIntSuite())
EndFunction


; Suites
;---------------------------------------------

bool Function BoolToIntSuite()
	WriteLine("System", self, "BoolToIntSuite")
	It("should be converted to a valid integer", BoolToIntCase())
	return Done
EndFunction


; Cases
;---------------------------------------------

bool Function BoolToIntCase()
	WriteLine("System", self, "BoolToIntCase")
	Expect(BoolToInt(true), To, BeEqualTo, 1)
	Expect(BoolToInt(false), To, BeEqualTo, 0)
	return Done
EndFunction
