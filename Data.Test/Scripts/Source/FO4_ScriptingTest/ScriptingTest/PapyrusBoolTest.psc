ScriptName ScriptingTest:PapyrusBoolTest extends ScriptingTest:Framework:Lilac
import Papyrus:BoolType
import Papyrus:Log


; Lilac
;---------------------------------------------

Function Setup()
	WriteLine(self, "Executing the Setup function.")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine(self, "Executing the TestSuites function.")
	describe("Boolean To Integer", BoolToIntSuite())
EndFunction


; Suites
;---------------------------------------------

bool Function BoolToIntSuite()
	WriteLine(self, "BoolToIntSuite")
	it("should be converted to a valid integer", BoolToIntCase())
	return Done
EndFunction


; Cases
;---------------------------------------------

bool Function BoolToIntCase()
	WriteLine(self, "BoolToIntCase")
	expect(BoolToInt(true), to, beEqualTo, 1)
	expect(BoolToInt(false), to, beEqualTo, 0)
	return Done
EndFunction
