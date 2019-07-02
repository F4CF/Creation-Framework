ScriptName SystemTests:Diagnostics:Log Extends System:Diagnostics:Lilac
import System:Log


; Lilac
;---------------------------------------------

Function Setup()
	WriteLine(self, "Executing the Setup function.")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine(self, "Executing the TestSuites function.")
	describe("The context", Suite1())
EndFunction


; Suites
;---------------------------------------------

bool Function Suite1()
	WriteLine(self, "Executing the Suite1 function.")
	return false
EndFunction
