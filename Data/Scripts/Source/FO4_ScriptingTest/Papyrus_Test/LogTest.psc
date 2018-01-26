ScriptName Papyrus_Test:LogTest extends Papyrus_Test:Framework:Lilac
import Papyrus:Log


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
	describe("The context", Suite1())
EndFunction


; Suites
;---------------------------------------------

bool Function Suite1()
	WriteLine(Log, "Executing the Suite1 function.")
	return false
EndFunction