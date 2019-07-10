ScriptName System:Diagnostics:TestRunner Extends System:Diagnostics:TestRunnerType Hidden
{Papyrus unit test syntax and test runner.
Base script for creating and running "Lilac" unit tests.
**Must be extended**
Generally executed by `<pre> StartQuest <MyUnitTestQuest></pre>` from the console.
https://github.com/chesko256/LilacFO4}
import System:Log


; Properties
;---------------------------------------------

Group Settings
	bool Property Enabled = true Auto
	{Default: True. If false, this test cannot be run at runtime. Can help prevent unwanted execution.
	Note: A "conditional compilation" with the "DebugOnly" flag may be a better option than a boolean condition.}
EndGroup


; Unit Test Runner
;---------------------------------------------

float Last_Current_Time = -1.0
string Current_Test_Suite = ""
string Current_Test_Case = ""
bool Test_Case_Had_Failures = false
bool Verbose_Logging = false
bool Warn_On_Long_Duration = false
float Warning_Threshold = 0.0

int TestsRun = 0
int TestsPassed = 0
int TestsFailed = 0

Group Runner
	string[] Property FailedTestSuites Auto Hidden
	string[] Property FailedTestCases Auto Hidden
	string[] Property FailedActuals Auto Hidden
	bool[] Property FailedConditions Auto Hidden
	int[] Property FailedMatchers Auto Hidden
	string[] Property FailedExpecteds Auto Hidden
	int[] Property FailedExpectNumbers Auto Hidden
	int Property ExpectCount = 0 Auto Hidden

	int Property LILAC_TIMER_ID = 0x212AC Auto Hidden
EndGroup


; Events
;---------------------------------------------

Event OnInit()
	If (QUST.IsRunning())
		If (Enabled)
			StartTimer(1, LILAC_TIMER_ID)
		Else
			Debug.Trace(CreateLilacDebugMessage(INFO, "The Lilac test on " + self + " was disabled."))
			Debug.Trace(CreateLilacDebugMessage(INFO, "Set the 'Enabled' Property of the test script to True in order to run it."))
			Debug.Trace(CreateLilacDebugMessage(INFO, "If you are a mod user and see this message, please ignore it; this message is for mod developers and is not indicative of a bug."))
		EndIf
	EndIf
EndEvent


Event OnTimer(int aiTimerID)
	RunTests()
EndEvent


; Setup Methods
;---------------------------------------------

; Call this Function to enable verbose logging in the Papyrus log.
Function EnableVerboseLogging()
	Verbose_Logging = true
EndFunction


; Call this Function to enable warning generation on slow test cases.
;#### Parameters
;* `afWarningThreshold`: If a spec takes longer than this to execute, generate a warning in the Papyrus log.
Function EnableWarningOnSlowTests(float afWarningThreshold)
	Warn_On_Long_Duration = true
	Warning_Threshold = afWarningThreshold
EndFunction


; Runner
;---------------------------------------------

Function RunTests()
	Debug.Trace(CreateLilacDebugMessage(INFO, "Starting " + SystemName + " " + SystemVersion + " (API v" + APIVersion + ") on " + self))

	; Initial setup
	ResetTestRunner()
	SetUp()
	SetStartTime()
	BeforeAll()
	BeforeEach()

	; Execute test cases
	TestSuites()

	; Report results
	ShowTestFailureLog()
	ShowTestSummary()

	; Tear down
	AfterEach()
	AfterAll()
	QUST.Stop()
EndFunction


Function ResetTestRunner()
	FailedTestSuites = new string[128]
	FailedTestCases = new string[128]
	FailedActuals = new string[128]
	FailedConditions = new bool[128]
	FailedMatchers = new int[128]
	FailedExpecteds = new string[128]
	FailedExpectNumbers = new int[128]

	TestsRun = 0
	TestsPassed = 0
	TestsFailed = 0
	ExpectCount = 0
	Last_Current_Time = -1.0
	Current_Test_Suite = ""
	Current_Test_Case = ""
	Verbose_Logging = false
	Warn_On_Long_Duration = false
	Warning_Threshold = 0.0
EndFunction


Function SetStartTime()
	Last_Current_Time = Game.GetRealHoursPassed()
EndFunction


; Reports
;---------------------------------------------

Function ShowTestFailureLog()
	int working_index = 0
	bool failed_tests_msg_shown = false

	string current_working_test_suite = ""
	bool processing_suites = true
	While (processing_suites)
		If (FailedTestSuites[working_index] != "")
			current_working_test_suite = FailedTestSuites[working_index]
			If (!failed_tests_msg_shown)
				Debug.Trace(CreateLilacDebugMessage(INFO, "Failed Tests (first 128 failed test steps shown):"))
				failed_tests_msg_shown = true
			EndIf
			Debug.Trace(CreateLilacDebugMessage(INFO, " - " + FailedTestSuites[working_index] + ":"))

			string current_working_test_case = ""
			bool processing_cases = true
			While (processing_cases)
				bool processing_steps = true
				If (FailedTestCases[working_index] != ""  && FailedTestSuites[working_index] == current_working_test_suite)
					current_working_test_case = FailedTestCases[working_index]
					Debug.Trace(CreateLilacDebugMessage(INFO, "    - " + FailedTestCases[working_index] + ":"))

					While (processing_steps)
						If (FailedActuals[working_index] != "" && FailedTestCases[working_index] == current_working_test_case)
							Debug.Trace(CreateLilacDebugMessage(INFO, CreateStepFailureMessage(working_index)))
							working_index += 1
						Else
							processing_steps = false
						EndIf
					EndWhile
				Else
					processing_cases = false
				EndIf
			EndWhile
		Else
			processing_suites = false
		EndIf
	EndWhile
EndFunction


Function ShowTestSummary()
	Debug.Trace(CreateLilacDebugMessage(INFO, "  " + TestsRun + " total  " + TestsPassed + " passed  " + TestsFailed + " failed"))
EndFunction


string Function CreateStepFailureMessage(int index)
	bool condition_Value = FailedConditions[index]
	int matcher_Value = FailedMatchers[index]
	string actual_Value = FailedActuals[index]
	string expected_Value = FailedExpecteds[index]
	int expectNumber_Value = FailedExpectNumbers[index]

	string header = "        - Expect " + expectNumber_Value + ": expected"
	;Debug.Trace("Creating step failure message from index " + index + " " + condition_Value  + " " + matcher_Value + " " + actual_Value + " " + expected_Value)

	string condition_String
	If (FailedConditions[index] == true)
		condition_String = "to"
	Else
		condition_String = "not to"
	EndIf

	string matcher_String
	If (matcher_Value == BeEqualTo)
		matcher_String = "be equal to"
	ElseIf (matcher_Value == BeLessThan)
		matcher_String = "be less than"
	ElseIf (matcher_Value == BeLessThanOrEqualTo)
		matcher_String = "be less than or equal to"
	ElseIf (matcher_Value == BeGreaterThan)
		matcher_String = "be greater than"
	ElseIf (matcher_Value == BeGreaterThanOrEqualTo)
		matcher_String = "be greater than or equal to"
	ElseIf (matcher_Value == BeTruthy)
		matcher_String = "be truthy"
	ElseIf (matcher_Value == BeFalsy)
		matcher_String = "be falsy"
	ElseIf (matcher_Value == BeNone)
		matcher_String = "be None"
	EndIf

	string text
	If (matcher_Value == BeTruthy || matcher_Value == BeFalsy || matcher_Value == BeNone)
		text = header+" "+actual_Value+" "+condition_String+" "+matcher_String
	Else
		text = header+" "+actual_Value+" "+condition_String+" "+matcher_String+" "+expected_Value
	EndIf
	return text
EndFunction


string Function CreateVerboseStepMessage(bool result, string actual, bool condition, int matcher, string expected, int number)
	bool condition_Value = condition
	int matcher_Value = matcher
	string actual_Value = actual
	string expected_Value = expected
	int expectNumber_Value = number

	string header = " - Expect " + expectNumber_Value + ": expected"

	string result_String
	If (result == true)
		result_String = "PASSED"
	Else
		result_String = "FAILED"
	EndIf

	string condition_String
	If (condition_Value == true)
		condition_String = "to"
	Else
		condition_String = "not to"
	EndIf

	string matcher_String
	If (matcher_Value == BeEqualTo)
		matcher_String = "be equal to"
	ElseIf (matcher_Value == BeLessThan)
		matcher_String = "be less than"
	ElseIf (matcher_Value == BeLessThanOrEqualTo)
		matcher_String = "be less than or equal to"
	ElseIf (matcher_Value == BeGreaterThan)
		matcher_String = "be greater than"
	ElseIf (matcher_Value == BeGreaterThanOrEqualTo)
		matcher_String = "be greater than or equal to"
	ElseIf (matcher_Value == BeTruthy)
		matcher_String = "be truthy"
	ElseIf (matcher_Value == BeFalsy)
		matcher_String = "be falsy"
	ElseIf (matcher_Value == BeNone)
		matcher_String = "be None"
	EndIf

	string msg
	If (matcher_Value == BeTruthy || matcher_Value == BeFalsy || matcher_Value == BeNone)
		msg = header + " " + actual_Value + " " + condition_String + " " + matcher_String + " " + result_String
	Else
		msg = header + " " + actual_Value + " " + condition_String + " " + matcher_String + " " + expected_Value + " " + result_String
	EndIf

	return msg
EndFunction


; API
;---------------------------------------------

; Defines and executes a test suite.
; #### Parameters
; * `asTestSuiteName`: The name of the test suite.
; * `abTestCases`: A function that implements this suite's test cases.
Function Describe(string asTestSuiteName, bool abTestCases)
	Current_Test_Suite = asTestSuiteName
	LogFailedTestSuites()
EndFunction

Function LogFailedTestSuites()
	int end_index = ArrayCountString(FailedActuals) - 1
	If (end_index == -1)
		return
	EndIf
	int start_index = ArrayCountString(FailedTestSuites)

	int index = start_index
	While (index <= end_index)
		FailedTestSuites[index] = Current_Test_Suite
		index += 1
	EndWhile
EndFunction


;  Defines and executes a test case (spec).
; #### Parameters
; * `asTestCaseName`: The name of the test case.
; * `abTestSteps`: A function that implements this suite's test steps.
Function It(string asTestCaseName, bool abTestSteps)
	Current_Test_Case = asTestCaseName
	LogFailedTestCases()

	string resultString
	float this_current_time = Game.GetRealHoursPassed()
	float deltaTimeSecs = (this_current_time - Last_Current_Time) * 3600.0

	TestsRun += 1
	If Test_Case_Had_Failures == false
		resultString = " SUCCESS"
		TestsPassed	+= 1
	Else
		resultString = " FAILED"
		TestsFailed	+= 1
	EndIf

	If TestsFailed > 0
		If Warn_On_Long_Duration && deltaTimeSecs > Warning_Threshold
			Debug.Trace(CreateLilacDebugMessage(WARN, "Executed " + TestsRun + " (" + TestsFailed + " FAILED)" + resultString + " (slow: " + deltaTimeSecs + " secs)"))
		Else
			Debug.Trace(CreateLilacDebugMessage(INFO, "Executed " + TestsRun + " (" + TestsFailed + " FAILED)" + resultString + " (" + deltaTimeSecs + " secs)"))
		EndIf
	Else
		If Warn_On_Long_Duration && deltaTimeSecs > Warning_Threshold
			Debug.Trace(CreateLilacDebugMessage(WARN, "Executed " + TestsRun + resultString + " (slow: " + deltaTimeSecs + " secs)"))
		Else
			Debug.Trace(CreateLilacDebugMessage(INFO, "Executed " + TestsRun + resultString + " (" + deltaTimeSecs + " secs)"))
		EndIf
	EndIf
	Last_Current_Time = this_current_time
	Test_Case_Had_Failures = false
	ExpectCount = 0

	; Tear down this test and set up the next one.
	AfterEach()
	BeforeEach()
EndFunction

Function LogFailedTestCases()
	int end_index = ArrayCountString(FailedActuals) - 1
	If (end_index == -1)
		return
	EndIf
	int start_index = ArrayCountString(FailedTestCases)

	int index = start_index
	While (index <= end_index)
		FailedTestCases[index] = Current_Test_Case
		index += 1
	EndWhile
EndFunction


; Results
;---------------------------------------------

Function RaiseResult(bool abResult, string asActual, bool abCondition, int aiMatcher, string asExpected)
	ExpectCount += 1
	If (abResult == false)
		Test_Case_Had_Failures = true
		int index
		If (asActual != "")
			index = ArrayAddString(FailedActuals, asActual as string)
		Else
			index = ArrayAddString(FailedActuals, "(empty string)")
		EndIf
		If (index != -1)
			FailedConditions[index] = abCondition
			FailedMatchers[index] = aiMatcher
			FailedExpectNumbers[index] = ExpectCount
			If (asExpected != "")
				FailedExpecteds[index] = asExpected
			Else
				FailedExpecteds[index] = "(empty string)"
			EndIf
		EndIf
	EndIf
	If (Verbose_Logging)
		Debug.Trace(CreateLilacDebugMessage(INFO, CreateVerboseStepMessage(abResult, asActual, abCondition, aiMatcher, asExpected, ExpectCount)))
	EndIf
EndFunction


; Expectations
;---------------------------------------------

; Defines a new expectation, comparing actual and expected values of any supported type.
; #### Parameters
; * `actual`: The value under test.
; * `condition`: The condition (To or NotTo).
; * `matcher`: The matcher. See also the list of **Valid Matchers** for this expectation.
; * `expected`: The expected value.
;
; #### Valid Matchers
; * `BeEqualTo`
; * `BeLessThan`
; * `BeGreaterThan`
; * `BeLessThanOrEqualTo`
; * `BeGreaterThanOrEqualTo`
; * `BeTruthy`
; * `BeFalsy`
; * `BeNone`
;
; #### NOTES
; This is a type-independent version of the individual `Expect*` functions and can be used in place of them.
; You must use a valid matcher for the type of "Actual" and "Expected".
; For instance, you cannot check If a `Form` is "less than" another `Form`.
; The "Actual" and "Expected" must be of the exact same supported type (Form, ObjectReference, int, float, bool, or string).
; Using 'BeTruthy', 'BeFalsy', or 'BeNone' matcher and not supplying `Expected` can produce a (harmless) Papyrus error.
; If this becomes an issue, use 'to beEqualTo true', or similar, instead.
Function Expect(var actual, bool condition, int aiMatcher, var akExpected = None)
	If (actual is Form)
		If (aiMatcher == BeEqualTo || aiMatcher == BeTruthy || aiMatcher == BeFalsy || aiMatcher == BeNone)
			If (aiMatcher >= 5) ; beTruthy, beFalsy, beNone
				ExpectForm(actual as Form, condition, aiMatcher)
			ElseIf (akExpected is Form)
				ExpectForm(actual as Form, condition, aiMatcher, akExpected as Form)
			Else
				RaiseException_NonMatchingType(actual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf
	ElseIf (actual is ObjectReference)
		If (aiMatcher == BeEqualTo || aiMatcher == BeTruthy || aiMatcher == BeFalsy || aiMatcher == BeNone)
			If (aiMatcher >= 5) ; beTruthy, beFalsy, beNone
				ExpectRef(actual as ObjectReference, condition, aiMatcher)
			ElseIf (akExpected is ObjectReference)
				ExpectRef(actual as ObjectReference, condition, aiMatcher, akExpected as ObjectReference)
			Else
				RaiseException_NonMatchingType(actual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf
	ElseIf (actual is int)
		If (aiMatcher != BeNone)
			If (aiMatcher >= 5) ; beTruthy, beFalsy
				ExpectInt(actual as int, condition, aiMatcher)
			ElseIf (akExpected is int)
				ExpectInt(actual as int, condition, aiMatcher, akExpected as int)
			Else
				RaiseException_NonMatchingType(actual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf
	ElseIf (actual is float)
		If (aiMatcher != BeNone)
			If (aiMatcher >= 5) ; beTruthy, beFalsy
				ExpectFloat(actual as float, condition, aiMatcher)
			ElseIf (akExpected is float)
				ExpectFloat(actual as float, condition, aiMatcher, akExpected as float)
			Else
				RaiseException_NonMatchingType(actual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf
	ElseIf (actual is bool)
		If (aiMatcher == BeEqualTo || aiMatcher == BeTruthy || aiMatcher == BeFalsy)
			If (aiMatcher >= 5) ; beTruthy, beFalsy
				ExpectBool(actual as bool, condition, aiMatcher)
			ElseIf (akExpected is bool)
				ExpectBool(actual as bool, condition, aiMatcher, akExpected as bool)
			Else
				RaiseException_NonMatchingType(actual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf
	ElseIf (actual is string)
		If (aiMatcher == BeEqualTo || aiMatcher == BeTruthy || aiMatcher == BeFalsy)
			If (aiMatcher >= 5) ; beTruthy, beFalsy
				ExpectString(actual as string, condition, aiMatcher)
			ElseIf (akExpected is string)
				ExpectString(actual as string, condition, aiMatcher, akExpected as string)
			Else
				RaiseException_NonMatchingType(actual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf
	Else
		RaiseException_InvalidType(actual)
	EndIf
EndFunction



; Defines a new expectation, comparing actual and expected Forms.
; Parameters
; * `akActual`: The form under test.
; * `abCondition`: The condition (To or NotTo).
; * `aiMatcher`: The matcher. See also the list of **Valid Matchers** for this expectation.
; * `akExpected`: The expected value.
;
; Valid Matchers
; * `BeEqualTo`
; * `BeTruthy`
; * `BeFalsy`
; * `BeNone`
Function ExpectForm(Form akActual, bool abCondition, int aiMatcher, Form akExpected = None)
	bool result
	If abCondition == To
		If aiMatcher == BeEqualTo
			result = akActual == (akExpected as Form)
		ElseIf aiMatcher == BeTruthy
			result = (akActual as bool) == true
		ElseIf aiMatcher == BeFalsy
			result = (akActual as bool) == false
		ElseIf aiMatcher == BeNone
			result = akActual == None
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	Else ; NotTo
		If aiMatcher == BeEqualTo
			result = akActual != (akExpected as Form)
		ElseIf aiMatcher == BeTruthy
			result = (akActual as bool) == false
		ElseIf aiMatcher == BeFalsy
			result = (akActual as bool) == true
		ElseIf aiMatcher == BeNone
			result = akActual != None
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, akActual as string, abCondition, aiMatcher, akExpected as string)
EndFunction


; Defines a new expectation, comparing actual and expected ObjectReferences.
; #### Parameters
; * `actual`: The reference under test.
; * `condition`: The condition (To or NotTo).
; * `matcher`: The matcher. See also the list of **Valid Matchers** for this expectation.
; * `expected`: The expected value.
;
; #### Valid Matchers
; * `BeEqualTo`
; * `BeTruthy`
; * `BeFalsy`
; * `BeNone`
Function ExpectRef(ObjectReference actual, bool condition, int matcher, ObjectReference expected = None)
	bool result
	If condition == To
		If (matcher == BeEqualTo)
			result = actual == (expected as ObjectReference)
		ElseIf (matcher == BeTruthy)
			result = (actual as bool) == true
		ElseIf (matcher == BeFalsy)
			result = (actual as bool) == false
		ElseIf (matcher == BeNone)
			result = actual == None
		Else
			RaiseException_InvalidMatcher(matcher)
			result = false
		EndIf
	Else ; NotTo
		If (matcher == BeEqualTo)
			result = actual != (expected as ObjectReference)
		ElseIf (matcher == BeTruthy)
			result = (actual as bool) == false
		ElseIf (matcher == BeFalsy)
			result = (actual as bool) == true
		ElseIf (matcher == BeNone)
			result = actual != None
		Else
			RaiseException_InvalidMatcher(matcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, actual as string, condition, matcher, expected as string)
EndFunction


; Defines a new expectation, comparing actual and expected integers.
; Parameters
; * `actual`: The integer under test.
; * `condition`: The condition (To or NotTo).
; * `matcher`: The matcher. See also the list of **Valid Matchers** for this expectation.
; * `expected`: The expected value.
;
; Valid Matchers
; * `BeEqualTo`
; * `BeLessThan`
; * `BeGreaterThan`
; * `BeLessThanOrEqualTo`
; * `BeGreaterThanOrEqualTo`
; * `BeTruthy`
; * `BeFalsy`
Function ExpectInt(int actual, bool condition, int matcher, int expected = -1)
	bool result
	If (condition == To)
		If (matcher == BeEqualTo)
			result = actual == expected
		ElseIf (matcher == BeLessThan)
			result = actual < expected
		ElseIf (matcher == BeGreaterThan)
			result = actual > expected
		ElseIf (matcher == BeLessThanOrEqualTo)
			result = actual <= expected
		ElseIf (matcher == BeGreaterThanOrEqualTo)
			result = actual >= expected
		ElseIf (matcher == BeTruthy)
			result = (actual as bool) == true
		ElseIf (matcher == BeFalsy)
			result = (actual as bool) == false
		Else
			RaiseException_InvalidMatcher(matcher)
			result = false
		EndIf
	Else ; NotTo
		If (matcher == BeEqualTo)
			result = actual != expected
		ElseIf (matcher == BeLessThan)
			result = actual >= expected
		ElseIf (matcher == BeGreaterThan)
			result = actual <= expected
		ElseIf (matcher == BeLessThanOrEqualTo)
			result = actual > expected
		ElseIf (matcher == BeGreaterThanOrEqualTo)
			result = actual < expected
		ElseIf (matcher == BeTruthy)
			result = (actual as bool) != true
		ElseIf (matcher == BeFalsy)
			result = (actual as bool) != false
		Else
			RaiseException_InvalidMatcher(matcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, actual as string, condition, matcher, expected as string)
EndFunction


; Defines a new expectation, comparing actual and expected floats.
; #### Parameters
; * `actual`: The float under test.
; * `condition`: The condition (To or NotTo).
; * `matcher`: The matcher. See also the list of **Valid Matchers** for this expectation.
; * `expected`: The expected value.
;
; #### Valid Matchers
; * `BeEqualTo`
; * `BeLessThan`
; * `BeGreaterThan`
; * `BeLessThanOrEqualTo`
; * `BeGreaterThanOrEqualTo`
; * `BeTruthy`
; * `BeFalsy`
Function ExpectFloat(float actual, bool condition, int matcher, float expected = -1.0)
	bool result
	If (condition == To)
		If (matcher == BeEqualTo)
			result = actual == expected
		ElseIf (matcher == BeLessThan)
			result = actual < expected
		ElseIf (matcher == BeGreaterThan)
			result = actual > expected
		ElseIf (matcher == BeLessThanOrEqualTo)
			result = actual <= expected
		ElseIf (matcher == BeGreaterThanOrEqualTo)
			result = actual >= expected
		ElseIf (matcher == BeTruthy)
			result = (actual as bool) == true
		ElseIf (matcher == BeFalsy)
			result = (actual as bool) == false
		Else
			RaiseException_InvalidMatcher(matcher)
			result = false
		EndIf
	Else ; NotTo
		If (matcher == BeEqualTo)
			result = actual != expected
		ElseIf (matcher == BeLessThan)
			result = actual >= expected
		ElseIf (matcher == BeGreaterThan)
			result = actual <= expected
		ElseIf (matcher == BeLessThanOrEqualTo)
			result = actual > expected
		ElseIf (matcher == BeGreaterThanOrEqualTo)
			result = actual < expected
		ElseIf (matcher == BeTruthy)
			result = (actual as bool) != true
		ElseIf (matcher == BeFalsy)
			result = (actual as bool) != false
		Else
			RaiseException_InvalidMatcher(matcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, actual as string, condition, matcher, expected as string)
EndFunction


; Defines a new expectation, comparing actual and expected booleans.
; #### Parameters
; * `actual`: The boolean under test.
; * `condition`: The condition (To or NotTo).
; * `matcher`: The matcher. See also the list of **Valid Matchers** for this expectation.
; * `expected`: The expected value.
;
; #### Valid Matchers:
; * `BeEqualTo`
; * `BeTruthy`
; * `BeFalsy`
Function ExpectBool(bool actual, bool condition, int matcher, bool expected = false)
	bool result
	If (condition == To)
		If (matcher == BeEqualTo)
			result = actual == expected
		ElseIf (matcher == BeTruthy)
			result = actual == true
		ElseIf( matcher == BeFalsy)
			result = actual == false
		Else
			RaiseException_InvalidMatcher(matcher)
			result = false
		EndIf
	Else ; NotTo
		If (matcher == BeEqualTo)
			result = actual != expected
		ElseIf (matcher == BeTruthy)
			result = actual != true
		ElseIf (matcher == BeFalsy)
			result = actual != false
		Else
			RaiseException_InvalidMatcher(matcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, actual as string, condition, matcher, expected as string)
EndFunction


; Defines a new expectation, comparing actual and expected string.
; The Fallout 4 version of Lilac does not support the "contain" matcher.
; #### Parameters
; * `actual`: The string under test.
; * `condition`: The condition (To or NotTo).
; * `matcher`: The matcher. See also the list of **Valid Matchers** for this expectation.
; * `expected`: The expected value.
;
; #### Valid Matchers
; * `BeEqualTo`
; * `BeTruthy`
; * `BeFalsy`
Function ExpectString(string actual, bool condition, int matcher, string expected = "")
	bool result
	If (condition == To)
		If matcher == BeEqualTo
			result = actual == expected
		ElseIf (matcher == BeTruthy)
			result = (actual as bool) == true
		ElseIf (matcher == BeFalsy)
			result = (actual as bool) == false
		Else
			RaiseException_InvalidMatcher(matcher)
			result = false
		EndIf
	Else ; NotTo
		If (matcher == BeEqualTo)
			result = actual != expected
		ElseIf (matcher == BeTruthy)
			result = (actual as bool) != true
		ElseIf (matcher == BeFalsy)
			result = (actual as bool) != false
		Else
			RaiseException_InvalidMatcher(matcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, actual, condition, matcher, expected)
EndFunction