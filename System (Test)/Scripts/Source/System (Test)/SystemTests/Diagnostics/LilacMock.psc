ScriptName SystemTests:Diagnostics:LilacMock Extends System:Diagnostics:TestRunner
{Test-specific subclass of Lilac.}

; Test Runner
;---------------------------------------------

Event OnInit()
	{EMPTY}
	; pass
EndEvent


Function TestSuites()
	Describe("Testing Suite", LilacTesting_TestSuite())
EndFunction


; Performance Counters
;---------------------------------------------

string Property MockLastLilacDebugMessage = "" Auto Hidden
string Function CreateLilacDebugMessage(int aiLogLevel, string asMessage)
	MockLastLilacDebugMessage = parent.CreateLilacDebugMessage(aiLogLevel, asMessage)
	return "MockLilac CreateLilacDebugMessage: " + MockLastLilacDebugMessage
EndFunction


bool Property MockLastRaisedResultResult = true Auto Hidden
Function RaiseResult(bool abResult, string asActual, bool abCondition, int aiMatcher, string asExpected)
	MockLastRaisedResultResult = abResult
EndFunction


int Property MockItCallCount = 0 Auto Hidden
Function It(string asTestCaseName, bool abTestSteps)
	MockItCallCount += 1
	parent.It(asTestCaseName, abTestSteps)
EndFunction


int Property MockBeforeEachCallCount = 0 Auto Hidden
Function BeforeEach()
	MockBeforeEachCallCount += 1
EndFunction


int Property MockAfterEachCallCount = 0 Auto Hidden
Function AfterEach()
	MockAfterEachCallCount += 1
EndFunction


; Suites
;---------------------------------------------

bool Function LilacTesting_TestSuite()
	It("should run a test case", LilacTesting_TestCase1())
	It("should run another test case", LilacTesting_TestCase2())
	return Done
EndFunction


; Cases
;---------------------------------------------

bool Function LilacTesting_TestCase1()
	Debug.Trace(CreateLilacDebugMessage(INFO, "Ran test case 1"))
	ExpectBool(true, To, BeTruthy)
	return Done
EndFunction


bool Function LilacTesting_TestCase2()
	Debug.Trace(CreateLilacDebugMessage(INFO, "Ran test case 2"))
	ExpectBool(false, To, BeFalsy)
	return Done
EndFunction
