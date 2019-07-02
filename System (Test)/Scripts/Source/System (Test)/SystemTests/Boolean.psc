ScriptName SystemTests:Boolean Extends System:Diagnostics:Lilac
import System:BoolType
import System:Log

; Lilac
;---------------------------------------------

Function Setup()
	WriteLine(self, "Executing the Setup function.")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine(self, "Executing the TestSuites function.")
	Describe("Boolean To Integer", BoolToIntSuite())
EndFunction


; Suites
;---------------------------------------------

bool Function BoolToIntSuite()
	WriteLine(self, "BoolToIntSuite")
	It("should be converted to a valid integer", BoolToIntCase())
	return Done
EndFunction


; Cases
;---------------------------------------------

bool Function BoolToIntCase()
	WriteLine(self, "BoolToIntCase")
	Expect(BoolToInt(true), To, BeEqualTo, 1)
	Expect(BoolToInt(false), To, BeEqualTo, 0)
	return Done
EndFunction
