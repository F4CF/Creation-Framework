ScriptName SystemTests:Diagnostics:LilacMock Extends System:Diagnostics:Lilac
{Test-specific subclass of Lilac.}

Event OnInit()
	; pass
EndEvent

string Property mockLastLilacDebugMessage = "" Auto
string Function createLilacDebugMessage(int aiLogLevel, string asMessage)
	mockLastLilacDebugMessage = parent.createLilacDebugMessage(aiLogLevel, asMessage)
	return "mockLilac createLilacDebugMessage: " + mockLastLilacDebugMessage
EndFunction

bool Property mockLastRaisedResultResult = true Auto
Function RaiseResult(bool abResult, string asActual, bool abCondition, int aiMatcher, string asExpected)
	mockLastRaisedResultResult = abResult
EndFunction

int Property mockItCallCount = 0 Auto
Function it(string asTestCaseName, bool abTestSteps)
	mockItCallCount += 1
	parent.It(asTestCaseName, abTestSteps)
EndFunction

int Property mockBeforeEachCallCount = 0 Auto
Function beforeEach()
	mockBeforeEachCallCount += 1
EndFunction

int Property mockAfterEachCallCount = 0 Auto
Function afterEach()
	mockAfterEachCallCount += 1
EndFunction


Function TestSuites()
	describe("Testing Suite", LilacTesting_TestSuite())
EndFunction

bool Function LilacTesting_TestSuite()
	it("should run a test case", LilacTesting_TestCase1())
	it("should run another test case", LilacTesting_TestCase2())
	return true ; Done
EndFunction

bool Function LilacTesting_TestCase1()
	debug.trace(createLilacDebugMessage(INFO, "Ran test case 1"))
	expectBool(true, To, beTruthy)
	return true ; Done
EndFunction

bool Function LilacTesting_TestCase2()
	debug.trace(createLilacDebugMessage(INFO, "Ran test case 2"))
	expectBool(false, To, beFalsy)
	return true ; Done
EndFunction
