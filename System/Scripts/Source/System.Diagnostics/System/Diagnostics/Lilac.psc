ScriptName System:Diagnostics:Lilac Extends Quest


Group Lilac
	string Property SystemName = "Lilac" AutoReadOnly
	float Property SystemVersion = 1.2 AutoReadOnly
	int Property APIVersion = 2 AutoReadOnly
EndGroup

Group Settings
	;
	bool Property Enabled = true Auto
	{
		Default: True.
		If false, this test cannot be run at runtime. Can help prevent unwanted execution.
		Note: A "conditional compilation" with the "DebugOnly" flag may be a better option than a boolean condition.
	}
EndGroup

Group Constants
	bool Property Done = true AutoReadOnly
EndGroup



; Unit Test Runner ================================================================================

float last_current_time = -1.0
string current_test_suite = ""
string current_test_case = ""
bool test_case_had_failures = false
bool verbose_logging = false
bool warn_on_long_duration = false
float warning_threshold = 0.0

int testsRun = 0
int testsPassed = 0
int testsFailed = 0

Group Runner
	string[] Property failedTestSuites Auto hidden
	string[] Property failedTestCases Auto hidden
	string[] Property failedActuals Auto hidden
	bool[] Property failedConditions Auto hidden
	int[] Property failedMatchers Auto hidden
	string[] Property failedExpecteds Auto hidden
	int[] Property failedExpectNumbers Auto hidden
	int Property expectCount = 0 Auto hidden

	int Property LILAC_TIMER_ID = 0x212AC Auto hidden
EndGroup


Event OnInit()
	If (self.IsRunning())
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

Function RunTests()
	Debug.Trace(CreateLilacDebugMessage(INFO, "Starting " + SystemName + " " + SystemVersion + " (API v" + APIVersion + ") on " + self))

	; Initial setup
	ResetTestRunner()
	SetUp()
	SetStartTime()
	beforeAll()
	beforeEach()

	; Execute test cases
	TestSuites()

	; Report results
	ShowTestFailureLog()
	ShowTestSummary()

	; Tear down
	afterEach()
	afterAll()
	self.Stop()
EndFunction

;/********f* Lilac/SetUp
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Override this Function to run test set-up functions.
*
* SYNTAX
*/;
Function SetUp()
	;/*
	* PARAMETERS
	* None
	*
	* NOTES
	* The most common use for declaring this Function is to enable verbose logging (`EnableVerboseLogging()`) or to
	* warn on slow tests (`EnableWarningOnSlowTests()`)
	*
	* EXAMPLES
	Function SetUp()
		EnableVerboseLogging()
	EndFunction
	;*********/;
EndFunction

;/********f* Lilac/TestSuites
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Override this Function to declare all test suites to run in this Lilac test script. Any test suites declared
* in this Function will be automatically run when the quest this script is attached to runs.
*
* SYNTAX
*/;
Function TestSuites()
	;/*
	* PARAMETERS
	* None
	*
	* EXAMPLES
	Function TestSuites()
		Describe("A test suite", myTestSuite())
		Describe("Another test suite", myOtherTestSuite())
	EndFunction
	;*********/;
EndFunction


Function SetStartTime()
	last_current_time = Game.GetRealHoursPassed()
EndFunction



;/********f* Lilac/EnableVerboseLogging
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Call this Function to enable verbose logging in the Papyrus log.
*
* SYNTAX
*/;
Function EnableVerboseLogging()
	;/*
	* PARAMETERS
	* None
	*
	* EXAMPLES
	Function SetUp()
		EnableVerboseLogging()
	EndFunction
	;*********/;
	verbose_logging = true
EndFunction



;/********f* Lilac/EnableWarningOnSlowTests
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Call this Function to enable warning generation on slow test cases.
*
* SYNTAX
*/;
Function EnableWarningOnSlowTests(float afWarningThreshold)
	;/*
	* PARAMETERS
	* * afWarningThreshold: If a spec takes longer than this to execute, generate a warning in the Papyrus log.
	*
	* EXAMPLES
	Function SetUp()
		; Generate warnings If a spec takes longer than 1 sec.
		EnableWarningOnSlowTests(1.0)
	EndFunction
	;*********/;
	warn_on_long_duration = true
	warning_threshold = afWarningThreshold
EndFunction


Function ResetTestRunner()
	failedTestSuites = new string[128]
	failedTestCases = new string[128]
	failedActuals = new string[128]
	failedConditions = new bool[128]
	failedMatchers = new int[128]
	failedExpecteds = new string[128]
	failedExpectNumbers = new int[128]

	testsRun = 0
	testsPassed = 0
	testsFailed = 0
	expectCount = 0
	last_current_time = -1.0
	current_test_suite = ""
	current_test_case = ""
	verbose_logging = false
	warn_on_long_duration = false
	warning_threshold = 0.0
EndFunction


Function ShowTestFailureLog()
	int working_index = 0
	bool failed_tests_msg_shown = false

	string current_working_test_suite = ""
	bool processing_suites = true
	While processing_suites
		If failedTestSuites[working_index] != ""
			current_working_test_suite = failedTestSuites[working_index]
			If !failed_tests_msg_shown
				Debug.Trace(CreateLilacDebugMessage(INFO, "Failed Tests (first 128 failed test steps shown):"))
				failed_tests_msg_shown = true
			EndIf
			Debug.Trace(CreateLilacDebugMessage(INFO, " - " + failedTestSuites[working_index] + ":"))

			string current_working_test_case = ""
			bool processing_cases = true
			While processing_cases
				bool processing_steps = true
				If failedTestCases[working_index] != ""  && failedTestSuites[working_index] == current_working_test_suite
					current_working_test_case = failedTestCases[working_index]
					Debug.Trace(CreateLilacDebugMessage(INFO, "    - " + failedTestCases[working_index] + ":"))

					While processing_steps
						If failedActuals[working_index] != "" && failedTestCases[working_index] == current_working_test_case
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
	Debug.Trace(CreateLilacDebugMessage(INFO, "  " + testsRun + " total  " + testsPassed + " passed  " + testsFailed + " failed"))
EndFunction


string Function CreateStepFailureMessage(int index)
	bool cdtn_val = failedConditions[index]
	int matcher_val = failedMatchers[index]
	string actual_val = failedActuals[index]
	string expected_val = failedExpecteds[index]
	int expectnumber_val = failedExpectNumbers[index]

	string header = "        - Expect " + expectnumber_val + ": expected"

	;Debug.Trace("Creating step failure message from index " + index + " " + cdtn_val  + " " + matcher_val + " " + actual_val + " " + expected_val)

	string cdtn
	If failedConditions[index] == true
		cdtn = "to"
	Else
		cdtn = "not to"
	EndIf

	string matcher
	If matcher_val == BeEqualTo
		matcher = "be equal to"
	ElseIf matcher_val == beLessThan
		matcher = "be less than"
	ElseIf matcher_val == beLessThanOrEqualTo
		matcher = "be less than or equal to"
	ElseIf matcher_val == beGreaterThan
		matcher = "be greater than"
	ElseIf matcher_val == beGreaterThanOrEqualTo
		matcher = "be greater than or equal to"
	ElseIf matcher_val == beTruthy
		matcher = "be truthy"
	ElseIf matcher_val == beFalsy
		matcher = "be falsy"
	ElseIf matcher_val == beNone
		matcher = "be None"
	EndIf

	string msg

	If matcher_val == beTruthy || matcher_val == beFalsy || matcher_val == beNone
		msg = header + " " + actual_val + " " + cdtn + " " + matcher
	Else
		msg = header + " " + actual_val + " " + cdtn + " " + matcher + " " + expected_val
	EndIf

	return msg
EndFunction


string Function CreateVerboseStepMessage(bool abResult, string asActual, bool abCondition, int aiMatcher, string asExpected, int aiNumber)
	bool cdtn_val = abCondition
	int matcher_val = aiMatcher
	string actual_val = asActual
	string expected_val = asExpected
	int expectnumber_val = aiNumber

	string header = " - Expect " + expectnumber_val + ": expected"

	string result
	If abResult == true
		result = "PASSED"
	Else
		result = "FAILED"
	EndIf

	string cdtn
	If cdtn_val == true
		cdtn = "to"
	Else
		cdtn = "not to"
	EndIf

	string matcher
	If matcher_val == BeEqualTo
		matcher = "be equal to"
	ElseIf matcher_val == beLessThan
		matcher = "be less than"
	ElseIf matcher_val == beLessThanOrEqualTo
		matcher = "be less than or equal to"
	ElseIf matcher_val == beGreaterThan
		matcher = "be greater than"
	ElseIf matcher_val == beGreaterThanOrEqualTo
		matcher = "be greater than or equal to"
	ElseIf matcher_val == beTruthy
		matcher = "be truthy"
	ElseIf matcher_val == beFalsy
		matcher = "be falsy"
	ElseIf matcher_val == beNone
		matcher = "be None"
	EndIf

	string msg

	If matcher_val == beTruthy || matcher_val == beFalsy || matcher_val == beNone
		msg = header + " " + actual_val + " " + cdtn + " " + matcher + " " + result
	Else
		msg = header + " " + actual_val + " " + cdtn + " " + matcher + " " + expected_val + " " + result
	EndIf

	return msg
EndFunction























; Unit Test Composition ===========================================================================

Group Conditions
	bool Property To 					= true 	AutoReadOnly
	bool Property NotTo					= false	AutoReadOnly
EndGroup
Group Matchers
	int Property BeEqualTo 				= 0		AutoReadOnly
	int Property beLessThan 			= 1		AutoReadOnly
	int Property beLessThanOrEqualTo 	= 2		AutoReadOnly
	int Property beGreaterThan 			= 3		AutoReadOnly
	int Property beGreaterThanOrEqualTo	= 4		AutoReadOnly
	int Property beTruthy 				= 5		AutoReadOnly
	int Property beFalsy 				= 6		AutoReadOnly
	int Property beNone					= 7		AutoReadOnly
EndGroup
Group ErrorLevel
; Log level enum
int Property INFO 					= 0 	AutoReadOnly
int Property WARN 					= 1 	AutoReadOnly
int Property ERROR 					= 2 	AutoReadOnly
EndGroup



;/********f* Lilac/Describe
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Defines and executes a test suite.
*
* SYNTAX
*/;
Function Describe(string asTestSuiteName, bool abTestCases)
	;/*
	* PARAMETERS
	* * asTestSuiteName: The name of the test suite.
	* * abTestCases: A Function that implements this suite's test cases.
	*
	* EXAMPLES
	Describe("A test suite", myTestSuite())
	;*********/;
	current_test_suite = asTestSuiteName
	LogFailedTestSuites()
EndFunction

;/********f* Lilac/it
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Defines and executes a test case (spec).
*
* SYNTAX
*/;
Function It(string asTestCaseName, bool abTestSteps)
	;/*
	* PARAMETERS
	* * asTestCaseName: The name of the test case.
	* * abTestSteps: A Function that implements this suite's test steps.
	*
	* EXAMPLES
	it("should do something", myTestCase())
	;*********/;
	current_test_case = asTestCaseName
	LogFailedTestCases()

	string resultString
	float this_current_time = Game.GetRealHoursPassed()
	float deltaTimeSecs = (this_current_time - last_current_time) * 3600.0

	testsRun += 1
	If test_case_had_failures == false
		resultString = " SUCCESS"
		testsPassed	+= 1
	Else
		resultString = " FAILED"
		testsFailed	+= 1
	EndIf

	If testsFailed > 0
		If warn_on_long_duration && deltaTimeSecs > warning_threshold
			Debug.Trace(CreateLilacDebugMessage(WARN, "Executed " + testsRun + " (" + testsFailed + " FAILED)" + resultString + " (slow: " + deltaTimeSecs + " secs)"))
		Else
			Debug.Trace(CreateLilacDebugMessage(INFO, "Executed " + testsRun + " (" + testsFailed + " FAILED)" + resultString + " (" + deltaTimeSecs + " secs)"))
		EndIf
	Else
		If warn_on_long_duration && deltaTimeSecs > warning_threshold
			Debug.Trace(CreateLilacDebugMessage(WARN, "Executed " + testsRun + resultString + " (slow: " + deltaTimeSecs + " secs)"))
		Else
			Debug.Trace(CreateLilacDebugMessage(INFO, "Executed " + testsRun + resultString + " (" + deltaTimeSecs + " secs)"))
		EndIf
	EndIf
	last_current_time = this_current_time
	test_case_had_failures = false
	expectCount = 0

	; Tear down this test and set up the next one.
	afterEach()
	beforeEach()
EndFunction

;/********f* Lilac/beforeAll
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Override this Function to run a block of code before any test case runs (including before any beforeEach).
*
* SYNTAX
*/;
Function beforeAll()
	;/*
	* PARAMETERS
	* None
	*
	* EXAMPLES
	;Make sure the quest isn't running and is on stage 12 before every test.
	Function beforeAll()
		TheQuest.Stop()
		TheQuest.SetStage(12)
	EndFunction
	;*********/;
EndFunction

;/********f* Lilac/afterAll
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Override this Function to run a block of code after all test cases run (including after any afterEach).
*
* SYNTAX
*/;
Function afterAll()
	;/*
	* PARAMETERS
	* None
	*
	* EXAMPLES
	;Make sure the quest isn't running and is on stage 12 after every test.
	Function afterAll()
		TheQuest.Stop()
		TheQuest.SetStage(12)
	EndFunction
	;*********/;
EndFunction

;/********f* Lilac/beforeEach
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Override this Function to run a block of code before each test case.
*
* SYNTAX
*/;
Function beforeEach()
	;/*
	* PARAMETERS
	* None
	*
	* EXAMPLES
	;Make sure the storm trooper is reset before every test.
	Function beforeEach()
		stormtrooper.Reset()
	EndFunction
	;*********/;
EndFunction

;/********f* Lilac/afterEach
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Override this Function to run a block of code after each test case.
*
* SYNTAX
*/;
Function afterEach()
	;/*
	* PARAMETERS
	* None
	*
	* EXAMPLES
	;Make sure the star destroyer is deleted after every test.
	Function afterEach()
		destroyer.Disable()
		destroyer.Delete()
	EndFunction
	;*********/;
EndFunction

Function LogFailedTestSuites()
	int end_index = ArrayCountString(failedActuals) - 1
	If (end_index == -1)
		return
	EndIf
	int start_index = ArrayCountString(failedTestSuites)

	int i = start_index
	While (i <= end_index)
		failedTestSuites[i] = current_test_suite
		i += 1
	EndWhile
EndFunction

Function LogFailedTestCases()
	int end_index = ArrayCountString(failedActuals) - 1
	If (end_index == -1)
		return
	EndIf
	int start_index = ArrayCountString(failedTestCases)

	int i = start_index
	While (i <= end_index)
		failedTestCases[i] = current_test_case
		i += 1
	EndWhile
EndFunction








;/********f* Lilac/expect
* API VERSION ADDED
* 1 (Fallout 4 only)
*
* DESCRIPTION
* Defines a new expectation, comparing actual and expected values of any supported type.
*
* SYNTAX
*/;
Function expect(var akActual, bool abCondition, int aiMatcher, var akExpected = None)
	;/*
	* PARAMETERS
	* * akActual: The value under test.
	* * abCondition: The condition (to or notTo).
	* * aiMatcher: The matcher. See Notes for a list of valid matchers for this expectation.
	* * akExpected: The expected value.
	*
	* EXAMPLES
	expect(MyArmor, to, beEqualTo, PowerArmor)
	expect(5, to, beEqualTo, 5)
	expect(5, notTo, beEqualTo, 1.4)
	expect(True, to, beTruthy)
	expect(0, to, beFalsy)
	expect("Preston", to, beEqualTo, "Preston")
	* NOTES
	* This is a type-independent version of the individual expect* functions and can be used in place of them.
	* You must use a valid matcher for the type of Actual and Expected. For instance, you cannot check If a Form is "less than" another Form.
	* The Actual and Expected must be of the exact same supported type (Form, ObjectReference, Int, Float, Bool, or String).
	* Using 'beTruthy', 'beFalsy', or 'beNone' matcher and not supplying akExpected can produce a (harmless) Papyrus error. If this becomes an issue, use 'to beEqualTo true', or similar, instead.
	* Valid matchers for this expectation:
	* * beEqualTo
	* * beLessThan
	* * beGreaterThan
	* * beLessThanOrEqualTo
	* * beGreaterThanOrEqualTo
	* * beTruthy
	* * beFalsy
	* * beNone
	;*********/;

	If akActual is Form
		If aiMatcher == BeEqualTo || aiMatcher == beTruthy || aiMatcher == beFalsy || aiMatcher == beNone
			If aiMatcher >= 5 ; beTruthy, beFalsy, beNone
				expectForm(akActual as Form, abCondition, aiMatcher)
			ElseIf akExpected is Form
				expectForm(akActual as Form, abCondition, aiMatcher, akExpected as Form)
			Else
				RaiseException_NonMatchingType(akActual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf
	ElseIf akActual is ObjectReference
		If aiMatcher == BeEqualTo || aiMatcher == beTruthy || aiMatcher == beFalsy || aiMatcher == beNone
			If aiMatcher >= 5 ; beTruthy, beFalsy, beNone
				expectRef(akActual as ObjectReference, abCondition, aiMatcher)
			ElseIf akExpected is ObjectReference
				expectRef(akActual as ObjectReference, abCondition, aiMatcher, akExpected as ObjectReference)
			Else
				RaiseException_NonMatchingType(akActual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf
	ElseIf akActual is Int
		If aiMatcher != beNone
			If aiMatcher >= 5 ; beTruthy, beFalsy
				expectInt(akActual as Int, abCondition, aiMatcher)
			ElseIf akExpected is Int
				expectInt(akActual as Int, abCondition, aiMatcher, akExpected as Int)
			Else
				RaiseException_NonMatchingType(akActual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf
	ElseIf akActual is Float
		If aiMatcher != beNone
			If aiMatcher >= 5 ; beTruthy, beFalsy
				expectFloat(akActual as Float, abCondition, aiMatcher)
			ElseIf akExpected is Float
				expectFloat(akActual as Float, abCondition, aiMatcher, akExpected as Float)
			Else
				RaiseException_NonMatchingType(akActual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf
	ElseIf akActual is Bool
		If aiMatcher == BeEqualTo || aiMatcher == beTruthy || aiMatcher == beFalsy
			If aiMatcher >= 5 ; beTruthy, beFalsy
				expectBool(akActual as Bool, abCondition, aiMatcher)
			ElseIf akExpected is Bool
				expectBool(akActual as Bool, abCondition, aiMatcher, akExpected as Bool)
			Else
				RaiseException_NonMatchingType(akActual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf
	ElseIf akActual is String
		If aiMatcher == BeEqualTo || aiMatcher == beTruthy || aiMatcher == beFalsy
			If aiMatcher >= 5 ; beTruthy, beFalsy
				expectString(akActual as String, abCondition, aiMatcher)
			ElseIf akExpected is String
				expectString(akActual as String, abCondition, aiMatcher, akExpected as String)
			Else
				RaiseException_NonMatchingType(akActual, akExpected)
			EndIf
		Else
			RaiseException_InvalidMatcher(aiMatcher)
		EndIf
	Else
		RaiseException_InvalidType(akActual)
	EndIf
EndFunction

;/********f* Lilac/expectForm
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Defines a new expectation, comparing actual and expected Forms.
*
* SYNTAX
*/;
Function expectForm(Form akActual, bool abCondition, int aiMatcher, Form akExpected = None)
	;/*
	* PARAMETERS
	* * akActual: The form under test.
	* * abCondition: The condition (to or notTo).
	* * aiMatcher: The matcher. See Notes for a list of valid matchers for this expectation.
	* * akExpected: The expected value.
	*
	* EXAMPLES
	expectForm(MyArmor, to, beEqualTo, PowerArmor)
	* NOTES
	* Valid matchers for this expectation:
	* * beEqualTo
	* * beTruthy
	* * beFalsy
	* * beNone
	;*********/;
	bool result
	If abCondition == To
		If aiMatcher == BeEqualTo
			result = akActual == (akExpected as Form)
		ElseIf aiMatcher == beTruthy
			result = (akActual as bool) == true
		ElseIf aiMatcher == beFalsy
			result = (akActual as bool) == false
		ElseIf aiMatcher == beNone
			result = akActual == None
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	Else ; notTo
		If aiMatcher == BeEqualTo
			result = akActual != (akExpected as Form)
		ElseIf aiMatcher == beTruthy
			result = (akActual as bool) == false
		ElseIf aiMatcher == beFalsy
			result = (akActual as bool) == true
		ElseIf aiMatcher == beNone
			result = akActual != None
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, akActual as string, abCondition, aiMatcher, akExpected as string)
EndFunction

;/********f* Lilac/expectRef
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Defines a new expectation, comparing actual and expected ObjectReferences.
*
* SYNTAX
*/;
Function expectRef(ObjectReference akActual, bool abCondition, int aiMatcher, ObjectReference akExpected = None)
	;/*
	* PARAMETERS
	* * akActual: The reference under test.
	* * abCondition: The condition (to or notTo).
	* * aiMatcher: The matcher. See Notes for a list of valid matchers for this expectation.
	* * akExpected: The expected value.
	*
	* EXAMPLES
	expectRef(FalmerRef, to, beEqualTo, BossFalmerRef)
	* NOTES
	* Valid matchers for this expectation:
	* * beEqualTo
	* * beTruthy
	* * beFalsy
	* * beNone
	;*********/;
	bool result
	If abCondition == To
		If aiMatcher == BeEqualTo
			result = akActual == (akExpected as ObjectReference)
		ElseIf aiMatcher == beTruthy
			result = (akActual as bool) == true
		ElseIf aiMatcher == beFalsy
			result = (akActual as bool) == false
		ElseIf aiMatcher == beNone
			result = akActual == None
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	Else ; notTo
		If aiMatcher == BeEqualTo
			result = akActual != (akExpected as ObjectReference)
		ElseIf aiMatcher == beTruthy
			result = (akActual as bool) == false
		ElseIf aiMatcher == beFalsy
			result = (akActual as bool) == true
		ElseIf aiMatcher == beNone
			result = akActual != None
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, akActual as string, abCondition, aiMatcher, akExpected as string)
EndFunction

;/********f* Lilac/expectInt
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Defines a new expectation, comparing actual and expected integers.
*
* SYNTAX
*/;
Function expectInt(int aiActual, bool abCondition, int aiMatcher, int aiExpected = -1)
	;/*
	* PARAMETERS
	* * akActual: The integer under test.
	* * abCondition: The condition (to or notTo).
	* * aiMatcher: The matcher. See Notes for a list of valid matchers for this expectation.
	* * akExpected: The expected value.
	*
	* EXAMPLES
	expectInt(counter, to, beLessThan, 40)
	* NOTES
	* Valid matchers for this expectation:
	* * beEqualTo
	* * beLessThan
	* * beGreaterThan
	* * beLessThanOrEqualTo
	* * beGreaterThanOrEqualTo
	* * beTruthy
	* * beFalsy
	;*********/;
	bool result
	If abCondition == To
		If aiMatcher == BeEqualTo
			result = aiActual == aiExpected
		ElseIf aiMatcher == beLessThan
			result = aiActual < aiExpected
		ElseIf aiMatcher == beGreaterThan
			result = aiActual > aiExpected
		ElseIf aiMatcher == beLessThanOrEqualTo
			result = aiActual <= aiExpected
		ElseIf aiMatcher == beGreaterThanOrEqualTo
			result = aiActual >= aiExpected
		ElseIf aiMatcher == beTruthy
			result = (aiActual as bool) == true
		ElseIf aiMatcher == beFalsy
			result = (aiActual as bool) == false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	Else ; notTo
		If aiMatcher == BeEqualTo
			result = aiActual != aiExpected
		ElseIf aiMatcher == beLessThan
			result = aiActual >= aiExpected
		ElseIf aiMatcher == beGreaterThan
			result = aiActual <= aiExpected
		ElseIf aiMatcher == beLessThanOrEqualTo
			result = aiActual > aiExpected
		ElseIf aiMatcher == beGreaterThanOrEqualTo
			result = aiActual < aiExpected
		ElseIf aiMatcher == beTruthy
			result = (aiActual as bool) != true
		ElseIf aiMatcher == beFalsy
			result = (aiActual as bool) != false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, aiActual as string, abCondition, aiMatcher, aiExpected as string)
EndFunction

;/********f* Lilac/expectFloat
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Defines a new expectation, comparing actual and expected floats.
*
* SYNTAX
*/;
Function expectFloat(float afActual, bool abCondition, int aiMatcher, float afExpected = -1.0)
	;/*
	* PARAMETERS
	* * akActual: The float under test.
	* * abCondition: The condition (to or notTo).
	* * aiMatcher: The matcher. See Notes for a list of valid matchers for this expectation.
	* * akExpected: The expected value.
	*
	* EXAMPLES
	expectFloat(GameHour.GetValue(), to, beGreaterThan, 19.0)
	* NOTES
	* Valid matchers for this expectation:
	* * beEqualTo
	* * beLessThan
	* * beGreaterThan
	* * beLessThanOrEqualTo
	* * beGreaterThanOrEqualTo
	* * beTruthy
	* * beFalsy
	;*********/;
	bool result
	If abCondition == To
		If aiMatcher == BeEqualTo
			result = afActual == afExpected
		ElseIf aiMatcher == beLessThan
			result = afActual < afExpected
		ElseIf aiMatcher == beGreaterThan
			result = afActual > afExpected
		ElseIf aiMatcher == beLessThanOrEqualTo
			result = afActual <= afExpected
		ElseIf aiMatcher == beGreaterThanOrEqualTo
			result = afActual >= afExpected
		ElseIf aiMatcher == beTruthy
			result = (afActual as bool) == true
		ElseIf aiMatcher == beFalsy
			result = (afActual as bool) == false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	Else ; notTo
		If aiMatcher == BeEqualTo
			result = afActual != afExpected
		ElseIf aiMatcher == beLessThan
			result = afActual >= afExpected
		ElseIf aiMatcher == beGreaterThan
			result = afActual <= afExpected
		ElseIf aiMatcher == beLessThanOrEqualTo
			result = afActual > afExpected
		ElseIf aiMatcher == beGreaterThanOrEqualTo
			result = afActual < afExpected
		ElseIf aiMatcher == beTruthy
			result = (afActual as bool) != true
		ElseIf aiMatcher == beFalsy
			result = (afActual as bool) != false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, afActual as string, abCondition, aiMatcher, afExpected as string)
EndFunction

;/********f* Lilac/expectBool
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Defines a new expectation, comparing actual and expected booleans.
*
* SYNTAX
*/;
Function expectBool(bool abActual, bool abCondition, int aiMatcher, bool abExpected = false)
	;/*
	* PARAMETERS
	* * akActual: The boolean under test.
	* * abCondition: The condition (to or notTo).
	* * aiMatcher: The matcher. See Notes for a list of valid matchers for this expectation.
	* * akExpected: The expected value.
	*
	* EXAMPLES
	expectBool(Follower.IsEssential(), to, beTruthy)
	* NOTES
	* Valid matchers for this expectation:
	* * beEqualTo
	* * beTruthy
	* * beFalsy
	;*********/;
	bool result
	If abCondition == To
		If aiMatcher == BeEqualTo
			result = abActual == abExpected
		ElseIf aiMatcher == beTruthy
			result = abActual == true
		ElseIf aiMatcher == beFalsy
			result = abActual == false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	Else ; notTo
		If aiMatcher == BeEqualTo
			result = abActual != abExpected
		ElseIf aiMatcher == beTruthy
			result = abActual != true
		ElseIf aiMatcher == beFalsy
			result = abActual != false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, abActual as string, abCondition, aiMatcher, abExpected as string)
EndFunction

;/********f* Lilac/expectString
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Defines a new expectation, comparing actual and expected string.
*
* SYNTAX
*/;
Function expectString(string asActual, bool abCondition, int aiMatcher, string asExpected = "")
	;/*
	* PARAMETERS
	* * akActual: The string under test.
	* * abCondition: The condition (to or notTo).
	* * aiMatcher: The matcher. See Notes for a list of valid matchers for this expectation.
	* * akExpected: The expected value.
	*
	* EXAMPLES
	expectString("Preston", to, beEqualTo, "Preston")
	* NOTES
	* Valid matchers for this expectation:
	* * beEqualTo
	* * beTruthy
	* * beFalsy
	* The Fallout 4 version of Lilac does not support the "contain" matcher.
	;*********/;
	bool result
	If abCondition == To
		If aiMatcher == BeEqualTo
			result = asActual == asExpected
		ElseIf aiMatcher == beTruthy
			result = (asActual as bool) == true
		ElseIf aiMatcher == beFalsy
			result = (asActual as bool) == false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	Else ; notTo
		If aiMatcher == BeEqualTo
			result = asActual != asExpected
		ElseIf aiMatcher == beTruthy
			result = (asActual as bool) != true
		ElseIf aiMatcher == beFalsy
			result = (asActual as bool) != false
		Else
			RaiseException_InvalidMatcher(aiMatcher)
			result = false
		EndIf
	EndIf
	RaiseResult(result, asActual, abCondition, aiMatcher, asExpected)
EndFunction

Function RaiseResult(bool abResult, string asActual, bool abCondition, int aiMatcher, string asExpected)
	expectCount += 1
	If abResult == false
		test_case_had_failures = true
		int idx
		If asActual != ""
			idx = ArrayAddString(failedActuals, asActual as string)
		Else
			idx = ArrayAddString(failedActuals, "(empty string)")
		EndIf
		If idx != -1
			failedConditions[idx] = abCondition
			failedMatchers[idx] = aiMatcher
			failedExpectNumbers[idx] = expectCount
			If asExpected != ""
				failedExpecteds[idx] = asExpected
			Else
				failedExpecteds[idx] = "(empty string)"
			EndIf
		EndIf
	EndIf
	If verbose_logging
		Debug.Trace(CreateLilacDebugMessage(INFO, CreateVerboseStepMessage(abResult, asActual, abCondition, aiMatcher, asExpected, expectCount)))
	EndIf
EndFunction

Function RaiseException_InvalidMatcher(int aiMatcher)
	string matcher
	If aiMatcher == 0
		matcher = "beEqualTo"
	ElseIf aiMatcher == 1
		matcher = "beLessThan"
	ElseIf aiMatcher == 2
		matcher = "beLessThanOrEqualTo"
	ElseIf aiMatcher == 3
		matcher = "beGreaterThan"
	ElseIf aiMatcher == 4
		matcher = "beGreaterThanOrEqualTo"
	ElseIf aiMatcher == 5
		matcher = "beTruthy"
	ElseIf aiMatcher == 6
		matcher = "beFalsy"
	ElseIf aiMatcher == 7
		matcher = "beNone"
	EndIf

	Debug.Trace(CreateLilacDebugMessage(ERROR, "Invalid matcher '" + matcher + "' used."))
EndFunction

Function RaiseException_InvalidType(var akActual)
	Debug.Trace(CreateLilacDebugMessage(ERROR, "Actual " + (akActual as String) + " was not a Form, ObjectReference, Int, Float, Bool, or String."))
EndFunction

Function RaiseException_NonMatchingType(var akActual, var akExpected)
	Debug.Trace(CreateLilacDebugMessage(ERROR, "Actual " + (akActual as String) + " did not match the type of Expected " + (akExpected as String)))
EndFunction

string Function CreateLilacDebugMessage(int aiLogLevel, string asMessage)
	string level
	return "[" + SystemName + "] " + getLogLevel(aiLogLevel) + asMessage
EndFunction

string Function getLogLevel(int aiLogLevel)
	If aiLogLevel == 0
		return ""
	ElseIf aiLogLevel == 1
		return "WARN - "
	ElseIf aiLogLevel == 2
		return "ERROR - "
	EndIf
EndFunction

int Function ArrayAddString(string[] myArray, string myKey)
    ;Adds a form to the first available element in the array.
    ;       false       =       Error (array full)
    ;       true        =       Success

    int i = 0
    While i < myArray.Length
        If IsNone(myArray[i])
            myArray[i] = myKey
            return i
        Else
            i += 1
        EndIf
    EndWhile
    return -1
EndFunction

int Function ArrayCountString(String[] myArray)
	;Counts the number of indices in this array that do not have a "none" type.
    ;       int myCount = number of indicies that are not "none"

    int i = 0
    int myCount = 0
    While i < myArray.Length
        If !(IsNone(myArray[i]))
            myCount += 1
            i += 1
        Else
            i += 1
        EndIf
    EndWhile
    return myCount
EndFunction

bool Function IsNone(string akString)
    If akString
        If akString == ""
            return true
        Else
            return false
        EndIf
    Else
        return true
    EndIf
EndFunction