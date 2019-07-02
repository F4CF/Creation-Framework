ScriptName SystemTests:Diagnostics:Lilac Extends System:Diagnostics:Lilac


Function TestSuites()
	describe("Conditions", ConditionTestCases())
	describe("Matchers", MatcherTestCases())
	describe("Test Cases", TestCaseTestCases())
	describe("Messages", MessageTestCases())
EndFunction


; Test Suites =================================================================

bool Function ConditionTestCases()
	It("'to' should be true", case_condition_to())
	It("'notTo' should be false", case_condition_notTo())
EndFunction

bool Function MatcherTestCases()
	It("'beEqualTo' should evaluate equality", case_matcher_beEqualTo())
	It("'beLessThan' should evaluate less than", case_matcher_beLessThan())
	It("'beLessThanOrEqualTo' should evaluate less than or equal to", case_matcher_beLessThanOrEqualTo())
	It("'beGreaterThan' should evaluate greater than", case_matcher_beGreaterThan())
	It("'beGreaterThanOrEqualTo' should evaluate greater than or equal to", case_matcher_beGreaterThanOrEqualTo())
	It("'beTruthy' should evaluate truthiness", case_matcher_beTruthy())
	It("'beFalsy' should evaluate falsiness", case_matcher_beFalsy())
	It("'beNone' should evaluate None", case_matcher_beNone())
EndFunction

bool Function TestCaseTestCases()
	It("should run beforeEach and afterEach before and after every test case", case_testcase_BeforeAfterEach())
	It("'describe' should run all test cases in its suite", case_testcase_describe())
EndFunction

bool Function MessageTestCases()
	It("should create correct step failure messages", case_message_stepfailure())
	It("should create an invalid matcher message", case_message_invalidmatcher())
EndFunction


; Test Cases ==================================================================

SystemTests:Diagnostics:LilacMock mockLilacTest
Armor ArmorIronCuirass
ObjectReference TestArmorRef
Form EmptyForm

Function beforeAll()
	mockLilacTest = Game.GetFormFromFile(0x12C5, "LilacTestLilac.esp") as SystemTests:Diagnostics:LilacMock
	mockLilacTest.mockLastLilacDebugMessage = ""
	mockLilacTest.mockLastRaisedResultResult = true
	ArmorIronCuirass = Game.GetFormFromFile(0x12E49, "Skyrim.esm") as Armor
	TestArmorRef = Game.GetPlayer().PlaceAtMe(ArmorIronCuirass)
	EmptyForm = None
EndFunction

Function beforeEach()
	mockLilacTest.ResetTestRunner()
	mockLilacTest.mockBeforeEachCallCount = 0
	mockLilacTest.mockAfterEachCallCount = 0
	mockLilacTest.mockItCallCount = 0
EndFunction

Function afterAll()
	mockLilacTest.mockLastLilacDebugMessage = ""
	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest = None
	ArmorIronCuirass = None
	TestArmorRef.Disable()
	TestArmorRef.Delete()
EndFunction

Function afterEach()
	mockLilacTest.ResetTestRunner()
	mockLilacTest.mockBeforeEachCallCount = 0
	mockLilacTest.mockAfterEachCallCount = 0
	mockLilacTest.mockItCallCount = 0
EndFunction


bool Function case_condition_to()
	expectBool(self.To, To, beTruthy)
EndFunction

bool Function case_condition_notTo()
	expectBool(self.NotTo, To, beFalsy)
EndFunction

bool Function case_matcher_beEqualTo()
	expectInt(5, To, BeEqualTo, 5)
	expectInt(5, NotTo, BeEqualTo, 12)

	expectFloat(7.0, To, BeEqualTo, 7.0)
	expectFloat(7.0, NotTo, BeEqualTo, 3.45)

	expectBool(true, To, BeEqualTo, true)
	expectBool(false, To, BeEqualTo, false)
	expectBool(true, NotTo, BeEqualTo, false)
	expectBool(false, NotTo, BeEqualTo, true)

	expectString("test string", To, BeEqualTo, "test string")
	expectString("test string", NotTo, BeEqualTo, "other string")
	expectString("", To, BeEqualTo, "")

	expectForm(ArmorIronCuirass, To, BeEqualTo, ArmorIronCuirass)
	expectForm(ArmorIronCuirass, NotTo, BeEqualTo, None)
	expectForm(ArmorIronCuirass, NotTo, BeEqualTo, Game.GetPlayer().GetActorBase())

	expectRef(TestArmorRef, To, BeEqualTo, TestArmorRef)
	expectRef(TestArmorRef, NotTo, BeEqualTo, None)
	expectRef(TestArmorRef, NotTo, BeEqualTo, Game.GetPlayer())
EndFunction

bool Function case_matcher_beLessThan()
	expectInt(3, To, beLessThan, 1000)
	expectInt(3, To, beLessThan, 4)
	expectInt(3, NotTo, beLessThan, 3)
	expectInt(3, NotTo, beLessThan, 1)

	expectInt(-5, To, beLessThan, 1000)
	expectInt(-5, To, beLessThan, -4)
	expectInt(-5, NotTo, beLessThan, -5)
	expectInt(-5, NotTo, beLessThan, -7)

	expectFloat(4.5, To, beLessThan, 100.0)
	expectFloat(4.5, To, beLessThan, 5.0)
	expectFloat(4.5, To, beLessThan, 4.6)
	expectFloat(4.5, To, beLessThan, 4.51)
	expectFloat(4.5, NotTo, beLessThan, 4.5)
	expectFloat(4.5, NotTo, beLessThan, 4.4)
	expectFloat(4.5, NotTo, beLessThan, 1.0)

	expectFloat(-12.6, To, beLessThan, 100.0)
	expectFloat(-12.6, To, beLessThan, -12.0)
	expectFloat(-12.6, To, beLessThan, -12.5)
	expectFloat(-12.6, To, beLessThan, -12.59)
	expectFloat(-12.6, NotTo, beLessThan, -12.6)
	expectFloat(-12.6, NotTo, beLessThan, -13.0)
	expectFloat(-12.6, NotTo, beLessThan, -100.0)
EndFunction

bool Function case_matcher_beLessThanOrEqualTo()
	expectInt(3, To, beLessThanOrEqualTo, 1000)
	expectInt(3, To, beLessThanOrEqualTo, 4)
	expectInt(3, To, beLessThanOrEqualTo, 3)
	expectInt(3, NotTo, beLessThanOrEqualTo, 1)

	expectInt(-5, To, beLessThanOrEqualTo, 1000)
	expectInt(-5, To, beLessThanOrEqualTo, -4)
	expectInt(-5, To, beLessThanOrEqualTo, -5)
	expectInt(-5, NotTo, beLessThanOrEqualTo, -7)

	expectFloat(4.5, To, beLessThanOrEqualTo, 100.0)
	expectFloat(4.5, To, beLessThanOrEqualTo, 5.0)
	expectFloat(4.5, To, beLessThanOrEqualTo, 4.6)
	expectFloat(4.5, To, beLessThanOrEqualTo, 4.51)
	expectFloat(4.5, To, beLessThanOrEqualTo, 4.5)
	expectFloat(4.5, NotTo, beLessThanOrEqualTo, 4.4)
	expectFloat(4.5, NotTo, beLessThanOrEqualTo, 1.0)

	expectFloat(-12.6, To, beLessThanOrEqualTo, 100.0)
	expectFloat(-12.6, To, beLessThanOrEqualTo, -12.0)
	expectFloat(-12.6, To, beLessThanOrEqualTo, -12.5)
	expectFloat(-12.6, To, beLessThanOrEqualTo, -12.59)
	expectFloat(-12.6, To, beLessThanOrEqualTo, -12.6)
	expectFloat(-12.6, NotTo, beLessThanOrEqualTo, -13.0)
	expectFloat(-12.6, NotTo, beLessThanOrEqualTo, -100.0)
EndFunction

bool Function case_matcher_beGreaterThan()
	expectInt(7, To, beGreaterThan, 5)
	expectInt(7, To, beGreaterThan, -6)
	expectInt(7, To, beGreaterThan, 6)
	expectInt(7, NotTo, beGreaterThan, 7)
	expectInt(7, NotTo, beGreaterThan, 8)

	expectInt(-8, To, beGreaterThan, -10)
	expectInt(-8, To, beGreaterThan, -1000)
	expectInt(-8, To, beGreaterThan, -9)
	expectInt(-8, NotTo, beGreaterThan, -8)
	expectInt(-8, NotTo, beGreaterThan, -7)
	expectInt(-8, NotTo, beGreaterThan, 12)

	expectFloat(4.5, To, beGreaterThan, 1.0)
	expectFloat(4.5, To, beGreaterThan, 4.0)
	expectFloat(4.5, To, beGreaterThan, 4.4)
	expectFloat(4.5, To, beGreaterThan, 4.45)
	expectFloat(4.5, To, beGreaterThan, 4.4999)
	expectFloat(4.5, NotTo, beGreaterThan, 4.5)
	expectFloat(4.5, NotTo, beGreaterThan, 23.6)

	expectFloat(-12.6, To, beGreaterThan, -100.0)
	expectFloat(-12.6, To, beGreaterThan, -14.0)
	expectFloat(-12.6, To, beGreaterThan, -12.7)
	expectFloat(-12.6, To, beGreaterThan, -12.61)
	expectFloat(-12.6, NotTo, beGreaterThan, -12.6)
	expectFloat(-12.6, NotTo, beGreaterThan, -12.5)
	expectFloat(-12.6, NotTo, beGreaterThan, 100.0)
EndFunction

bool Function case_matcher_beGreaterThanOrEqualTo()
	expectInt(7, To, beGreaterThanOrEqualTo, 5)
	expectInt(7, To, beGreaterThanOrEqualTo, -6)
	expectInt(7, To, beGreaterThanOrEqualTo, 6)
	expectInt(7, To, beGreaterThanOrEqualTo, 7)
	expectInt(7, NotTo, beGreaterThanOrEqualTo, 8)

	expectInt(-8, To, beGreaterThanOrEqualTo, -10)
	expectInt(-8, To, beGreaterThanOrEqualTo, -1000)
	expectInt(-8, To, beGreaterThanOrEqualTo, -9)
	expectInt(-8, To, beGreaterThanOrEqualTo, -8)
	expectInt(-8, NotTo, beGreaterThanOrEqualTo, -7)
	expectInt(-8, NotTo, beGreaterThanOrEqualTo, 12)

	expectFloat(4.5, To, beGreaterThanOrEqualTo, 1.0)
	expectFloat(4.5, To, beGreaterThanOrEqualTo, 4.0)
	expectFloat(4.5, To, beGreaterThanOrEqualTo, 4.4)
	expectFloat(4.5, To, beGreaterThanOrEqualTo, 4.45)
	expectFloat(4.5, To, beGreaterThanOrEqualTo, 4.4999)
	expectFloat(4.5, To, beGreaterThanOrEqualTo, 4.5)
	expectFloat(4.5, NotTo, beGreaterThanOrEqualTo, 4.51)
	expectFloat(4.5, NotTo, beGreaterThanOrEqualTo, 23.6)

	expectFloat(-12.6, To, beGreaterThanOrEqualTo, -100.0)
	expectFloat(-12.6, To, beGreaterThanOrEqualTo, -14.0)
	expectFloat(-12.6, To, beGreaterThanOrEqualTo, -12.7)
	expectFloat(-12.6, To, beGreaterThanOrEqualTo, -12.61)
	expectFloat(-12.6, To, beGreaterThanOrEqualTo, -12.6)
	expectFloat(-12.6, NotTo, beGreaterThanOrEqualTo, -12.5)
	expectFloat(-12.6, NotTo, beGreaterThanOrEqualTo, 100.0)
EndFunction

bool Function case_matcher_beTruthy()
	expectInt(1, To, beTruthy)
	expectInt(0, NotTo, beTruthy)
	expectInt(-1, To, beTruthy)

	expectFloat(1.0, To, beTruthy)
	expectFloat(0.001, To, beTruthy)
	expectFloat(0.0, NotTo, beTruthy)
	expectFloat(-12.5, To, beTruthy)

	expectBool(true, To, beTruthy)
	expectBool(false, NotTo, beTruthy)

	expectForm(ArmorIronCuirass, To, beTruthy)
	expectForm(EmptyForm, NotTo, beTruthy)

	ObjectReference EmptyRef = None
	expectRef(TestArmorRef, To, beTruthy)
	expectRef(EmptyRef, NotTo, beTruthy)

	expectString("test string", To, beTruthy)
	expectString("", NotTo, beTruthy)
EndFunction

bool Function case_matcher_beFalsy()
	expectInt(1, NotTo, beFalsy)
	expectInt(0, To, beFalsy)
	expectInt(-1, NotTo, beFalsy)

	expectFloat(1.0, NotTo, beFalsy)
	expectFloat(0.001, NotTo, beFalsy)
	expectFloat(0.0, To, beFalsy)
	expectFloat(-12.5, NotTo, beFalsy)

	expectBool(true, NotTo, beFalsy)
	expectBool(false, To, beFalsy)

	expectForm(ArmorIronCuirass, NotTo, beFalsy)
	expectForm(EmptyForm, To, beFalsy)

	ObjectReference EmptyRef = None
	expectRef(TestArmorRef, NotTo, beFalsy)
	expectRef(EmptyRef, To, beFalsy)

	expectString("test string", NotTo, beFalsy)
	expectString("", To, beFalsy)
EndFunction

bool Function case_matcher_beNone()
	expectForm(EmptyForm, To, beNone)
	expectForm(ArmorIronCuirass, NotTo, beNone)

	ObjectReference EmptyRef = None
	expectRef(EmptyRef, To, beNone)
	expectRef(TestArmorRef, NotTo, beNone)
EndFunction

bool Function case_message_stepfailure()
	int i = 0

	mockLilacTest.failedActuals[i] = "5"
	mockLilacTest.failedConditions[i] = To
	mockLilacTest.failedMatchers[i] = BeEqualTo
	mockLilacTest.failedExpecteds[i] = "76"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 1: expected 5 to be equal to 76")

	i += 1

	mockLilacTest.failedActuals[i] = "5"
	mockLilacTest.failedConditions[i] = NotTo
	mockLilacTest.failedMatchers[i] = BeEqualTo
	mockLilacTest.failedExpecteds[i] = "5"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 2: expected 5 not to be equal to 5")

	i += 1

	mockLilacTest.failedActuals[i] = "98"
	mockLilacTest.failedConditions[i] = To
	mockLilacTest.failedMatchers[i] = beLessThan
	mockLilacTest.failedExpecteds[i] = "12"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 3: expected 98 to be less than 12")

	i += 1

	mockLilacTest.failedActuals[i] = "12.65"
	mockLilacTest.failedConditions[i] = NotTo
	mockLilacTest.failedMatchers[i] = beLessThan
	mockLilacTest.failedExpecteds[i] = "35.97"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 4: expected 12.65 not to be less than 35.97")

	i += 1

	mockLilacTest.failedActuals[i] = "98"
	mockLilacTest.failedConditions[i] = To
	mockLilacTest.failedMatchers[i] = beLessThanOrEqualTo
	mockLilacTest.failedExpecteds[i] = "12"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 5: expected 98 to be less than or equal to 12")

	i += 1

	mockLilacTest.failedActuals[i] = "12.65"
	mockLilacTest.failedConditions[i] = NotTo
	mockLilacTest.failedMatchers[i] = beLessThanOrEqualTo
	mockLilacTest.failedExpecteds[i] = "12.65"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 6: expected 12.65 not to be less than or equal to 12.65")

	i += 1

	mockLilacTest.failedActuals[i] = "12.8"
	mockLilacTest.failedConditions[i] = To
	mockLilacTest.failedMatchers[i] = beGreaterThan
	mockLilacTest.failedExpecteds[i] = "98.2"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 7: expected 12.8 to be greater than 98.2")

	i += 1

	mockLilacTest.failedActuals[i] = "12.65"
	mockLilacTest.failedConditions[i] = NotTo
	mockLilacTest.failedMatchers[i] = beGreaterThan
	mockLilacTest.failedExpecteds[i] = "10.333333"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 8: expected 12.65 not to be greater than 10.333333")

	i += 1

	mockLilacTest.failedActuals[i] = "16"
	mockLilacTest.failedConditions[i] = To
	mockLilacTest.failedMatchers[i] = beGreaterThanOrEqualTo
	mockLilacTest.failedExpecteds[i] = "10356"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 9: expected 16 to be greater than or equal to 10356")

	i += 1

	mockLilacTest.failedActuals[i] = "10.333333"
	mockLilacTest.failedConditions[i] = NotTo
	mockLilacTest.failedMatchers[i] = beGreaterThanOrEqualTo
	mockLilacTest.failedExpecteds[i] = "10.333333"
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 10: expected 10.333333 not to be greater than or equal to 10.333333")

	i += 1

	mockLilacTest.failedActuals[i] = "false"
	mockLilacTest.failedConditions[i] = To
	mockLilacTest.failedMatchers[i] = beTruthy
	mockLilacTest.failedExpecteds[i] = ""
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 11: expected false to be truthy")

	i += 1

	mockLilacTest.failedActuals[i] = "true"
	mockLilacTest.failedConditions[i] = NotTo
	mockLilacTest.failedMatchers[i] = beTruthy
	mockLilacTest.failedExpecteds[i] = ""
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 12: expected true not to be truthy")

	i += 1

	mockLilacTest.failedActuals[i] = "true"
	mockLilacTest.failedConditions[i] = To
	mockLilacTest.failedMatchers[i] = beFalsy
	mockLilacTest.failedExpecteds[i] = ""
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 13: expected true to be falsy")

	i += 1

	mockLilacTest.failedActuals[i] = "false"
	mockLilacTest.failedConditions[i] = NotTo
	mockLilacTest.failedMatchers[i] = beFalsy
	mockLilacTest.failedExpecteds[i] = ""
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 14: expected false not to be falsy")

	i += 1

	mockLilacTest.failedActuals[i] = "WeaponObject"
	mockLilacTest.failedConditions[i] = To
	mockLilacTest.failedMatchers[i] = beNone
	mockLilacTest.failedExpecteds[i] = ""
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 15: expected WeaponObject to be None")

	i += 1

	mockLilacTest.failedActuals[i] = "None"
	mockLilacTest.failedConditions[i] = NotTo
	mockLilacTest.failedMatchers[i] = beNone
	mockLilacTest.failedExpecteds[i] = ""
	mockLilacTest.failedExpectNumbers[i] = i + 1

	expectString( mockLilacTest.CreateStepFailureMessage(i), To, BeEqualTo, \
		         "        - Expect 16: expected None not to be None")

EndFunction

bool Function case_message_invalidmatcher()

	; expectForm
	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectForm(ArmorIronCuirass, To, beGreaterThan, ArmorIronCuirass)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectForm(ArmorIronCuirass, To, beGreaterThanOrEqualTo, None)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThanOrEqualTo' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectForm(ArmorIronCuirass, To, beLessThan, ArmorIronCuirass)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectForm(ArmorIronCuirass, To, beLessThanOrEqualTo, None)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThanOrEqualTo' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectForm(ArmorIronCuirass, NotTo, beGreaterThan, None)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThan' used.")


	; expectRef

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectRef(TestArmorRef, To, beGreaterThan, TestArmorRef)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectRef(TestArmorRef, To, beGreaterThanOrEqualTo, TestArmorRef)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThanOrEqualTo' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectRef(TestArmorRef, To, beLessThan, None)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectRef(TestArmorRef, To, beLessThanOrEqualTo, None)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThanOrEqualTo' used.")


	; expectInt
	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectInt(5, To, beNone)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beNone' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectInt(5, NotTo, beNone)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beNone' used.")


	; expectFloat
	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectFloat(3.4565, To, beNone)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beNone' used.")


	; expectBool
	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectBool(true, To, beGreaterThan, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectBool(true, To, beGreaterThanOrEqualTo, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThanOrEqualTo' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectBool(false, To, beLessThan, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectBool(false, To, beLessThanOrEqualTo, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThanOrEqualTo' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectBool(false, To, beNone)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beNone' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectBool(false, NotTo, beLessThanOrEqualTo, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThanOrEqualTo' used.")


	; expectString
	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectString("test string", To, beGreaterThan, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectString("test string", To, beGreaterThanOrEqualTo, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beGreaterThanOrEqualTo' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectString("test string", To, beLessThan, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThan' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectString("test string", To, beLessThanOrEqualTo, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThanOrEqualTo' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectString("test string", To, beNone)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beNone' used.")

	mockLilacTest.mockLastRaisedResultResult = true
	mockLilacTest.mockLastLilacDebugMessage = ""

	mockLilacTest.expectString("test string", NotTo, beLessThan, 0)
	expectBool(mockLilacTest.mockLastRaisedResultResult, To, beFalsy)
	expectString(mockLilacTest.mockLastLilacDebugMessage, To, BeEqualTo, \
		         "[Lilac] ERROR - Invalid matcher 'beLessThan' used.")
EndFunction

bool Function case_testcase_BeforeAfterEach()
	mockLilacTest.RunTests()

	; There are 2 test cases, but beforeEach and afterEach
	; are expected to run 3 times.
	expectInt(mockLilacTest.mockBeforeEachCallCount, To, BeEqualTo, 3)
	expectInt(mockLilacTest.mockAfterEachCallCount, To, BeEqualTo, 3)
EndFunction

bool Function case_testcase_describe()
	mockLilacTest.RunTests()
	expectInt(mockLilacTest.mockItCallCount, To, BeEqualTo, 2)
EndFunction
