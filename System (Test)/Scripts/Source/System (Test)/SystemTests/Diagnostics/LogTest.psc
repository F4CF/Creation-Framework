ScriptName SystemTests:Diagnostics:LogTest Extends System:Diagnostics:Lilac
import System:Log


; Lilac
;---------------------------------------------

Function Setup()
	WriteLine("SystemTests:Diagnostics:LogTest", "Executing the Setup function.")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine("SystemTests:Diagnostics:LogTest", "Executing the TestSuites function.")
	describe("The context", Suite1())
EndFunction


; Suites
;---------------------------------------------

bool Function Suite1()
	WriteLine("SystemTests:Diagnostics:LogTest", "Executing the Suite1 function.")
	return false
EndFunction
