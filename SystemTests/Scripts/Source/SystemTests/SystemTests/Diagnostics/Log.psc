ScriptName SystemTests:Diagnostics:Log Extends System:Diagnostics:UnitTest
import System:Log


; Lilac
;---------------------------------------------

Function Setup()
	WriteLine(self, "Executing the Setup function.")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine(self, "Executing the TestSuites function.")
	Describe("The context", Suite1())
EndFunction


; Suites
;---------------------------------------------

bool Function Suite1()
	WriteLine(self, "Executing the Suite1 function.")
	return false
EndFunction
