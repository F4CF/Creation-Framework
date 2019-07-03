ScriptName SystemTests:Diagnostics:Lilac Extends System:Diagnostics:UnitTest

; Test Runner
;---------------------------------------------

Function TestSuites()
	Describe("Conditions", ConditionTestCases())
	Describe("Matchers", MatcherTestCases())
	Describe("Test Cases", TestCaseTestCases())
	Describe("Messages", MessageTestCases())
EndFunction


; Test Suites
;---------------------------------------------

bool Function ConditionTestCases()
	It("'To' should be true", Case_Condition_To())
	It("'NotTo' should be false", Case_Condition_NotTo())
EndFunction


bool Function MatcherTestCases()
	It("'BeEqualTo' should evaluate equality", Case_Matcher_BeEqualTo())
	It("'BeLessThan' should evaluate less than", Case_Matcher_BeLessThan())
	It("'BeLessThanOrEqualTo' should evaluate less than or equal to", Case_Matcher_BeLessThanOrEqualTo())
	It("'BeGreaterThan' should evaluate greater than", Case_Matcher_BeGreaterThan())
	It("'BeGreaterThanOrEqualTo' should evaluate greater than or equal to", Case_Matcher_BeGreaterThanOrEqualTo())
	It("'BeTruthy' should evaluate truthiness", Case_Matcher_BeTruthy())
	It("'BeFalsy' should evaluate falsiness", Case_Matcher_BeFalsy())
	It("'BeNone' should evaluate none", Case_Matcher_BeNone())
EndFunction


bool Function TestCaseTestCases()
	It("should run `BeforeEach` and `AfterEach` before and after every test case", Case_TestCase_BeforeAfterEach())
	It("'Describe' should run all test cases in its suite", Case_TestCase_Describe())
EndFunction


bool Function MessageTestCases()
	It("should create correct step failure messages", Case_Message_StepFailure())
	It("should create an invalid matcher message", Case_Message_InvalidMatcher())
EndFunction


; Test Cases
;---------------------------------------------

SystemTests:Diagnostics:LilacMock MockLilacTest
Armor ArmorIronCuirass
ObjectReference TestArmorRef
Form EmptyForm


Function BeforeAll()
	MockLilacTest = Game.GetFormFromFile(0x12C5, "LilacTestLilac.esp") as SystemTests:Diagnostics:LilacMock
	MockLilacTest.MockLastLilacDebugMessage = ""
	MockLilacTest.MockLastRaisedResultResult = true
	ArmorIronCuirass = Game.GetFormFromFile(0x12E49, "Skyrim.esm") as Armor
	TestArmorRef = Game.GetPlayer().PlaceAtMe(ArmorIronCuirass)
	EmptyForm = none
EndFunction


Function BeforeEach()
	MockLilacTest.ResetTestRunner()
	MockLilacTest.MockBeforeEachCallCount = 0
	MockLilacTest.mockAfterEachCallCount = 0
	MockLilacTest.MockItCallCount = 0
EndFunction


Function AfterAll()
	MockLilacTest.MockLastLilacDebugMessage = ""
	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest = none
	ArmorIronCuirass = none
	TestArmorRef.Disable()
	TestArmorRef.Delete()
EndFunction


Function AfterEach()
	MockLilacTest.ResetTestRunner()
	MockLilacTest.MockBeforeEachCallCount = 0
	MockLilacTest.mockAfterEachCallCount = 0
	MockLilacTest.MockItCallCount = 0
EndFunction


bool Function Case_Condition_To()
	ExpectBool(self.To, To, BeTruthy)
EndFunction


bool Function Case_Condition_NotTo()
	ExpectBool(self.NotTo, To, BeFalsy)
EndFunction


bool Function Case_Matcher_BeEqualTo()
	ExpectInt(5, To, BeEqualTo, 5)
	ExpectInt(5, NotTo, BeEqualTo, 12)

	ExpectFloat(7.0, To, BeEqualTo, 7.0)
	ExpectFloat(7.0, NotTo, BeEqualTo, 3.45)

	ExpectBool(true, To, BeEqualTo, true)
	ExpectBool(false, To, BeEqualTo, false)
	ExpectBool(true, NotTo, BeEqualTo, false)
	ExpectBool(false, NotTo, BeEqualTo, true)

	ExpectString("test string", To, BeEqualTo, "test string")
	ExpectString("test string", NotTo, BeEqualTo, "other string")
	ExpectString("", To, BeEqualTo, "")

	ExpectForm(ArmorIronCuirass, To, BeEqualTo, ArmorIronCuirass)
	ExpectForm(ArmorIronCuirass, NotTo, BeEqualTo, none)
	ExpectForm(ArmorIronCuirass, NotTo, BeEqualTo, Game.GetPlayer().GetActorBase())

	ExpectRef(TestArmorRef, To, BeEqualTo, TestArmorRef)
	ExpectRef(TestArmorRef, NotTo, BeEqualTo, none)
	ExpectRef(TestArmorRef, NotTo, BeEqualTo, Game.GetPlayer())
EndFunction


bool Function Case_Matcher_BeLessThan()
	ExpectInt(3, To, BeLessThan, 1000)
	ExpectInt(3, To, BeLessThan, 4)
	ExpectInt(3, NotTo, BeLessThan, 3)
	ExpectInt(3, NotTo, BeLessThan, 1)

	ExpectInt(-5, To, BeLessThan, 1000)
	ExpectInt(-5, To, BeLessThan, -4)
	ExpectInt(-5, NotTo, BeLessThan, -5)
	ExpectInt(-5, NotTo, BeLessThan, -7)

	ExpectFloat(4.5, To, BeLessThan, 100.0)
	ExpectFloat(4.5, To, BeLessThan, 5.0)
	ExpectFloat(4.5, To, BeLessThan, 4.6)
	ExpectFloat(4.5, To, BeLessThan, 4.51)
	ExpectFloat(4.5, NotTo, BeLessThan, 4.5)
	ExpectFloat(4.5, NotTo, BeLessThan, 4.4)
	ExpectFloat(4.5, NotTo, BeLessThan, 1.0)

	ExpectFloat(-12.6, To, BeLessThan, 100.0)
	ExpectFloat(-12.6, To, BeLessThan, -12.0)
	ExpectFloat(-12.6, To, BeLessThan, -12.5)
	ExpectFloat(-12.6, To, BeLessThan, -12.59)
	ExpectFloat(-12.6, NotTo, BeLessThan, -12.6)
	ExpectFloat(-12.6, NotTo, BeLessThan, -13.0)
	ExpectFloat(-12.6, NotTo, BeLessThan, -100.0)
EndFunction


bool Function Case_Matcher_BeLessThanOrEqualTo()
	ExpectInt(3, To, BeLessThanOrEqualTo, 1000)
	ExpectInt(3, To, BeLessThanOrEqualTo, 4)
	ExpectInt(3, To, BeLessThanOrEqualTo, 3)
	ExpectInt(3, NotTo, BeLessThanOrEqualTo, 1)

	ExpectInt(-5, To, BeLessThanOrEqualTo, 1000)
	ExpectInt(-5, To, BeLessThanOrEqualTo, -4)
	ExpectInt(-5, To, BeLessThanOrEqualTo, -5)
	ExpectInt(-5, NotTo, BeLessThanOrEqualTo, -7)

	ExpectFloat(4.5, To, BeLessThanOrEqualTo, 100.0)
	ExpectFloat(4.5, To, BeLessThanOrEqualTo, 5.0)
	ExpectFloat(4.5, To, BeLessThanOrEqualTo, 4.6)
	ExpectFloat(4.5, To, BeLessThanOrEqualTo, 4.51)
	ExpectFloat(4.5, To, BeLessThanOrEqualTo, 4.5)
	ExpectFloat(4.5, NotTo, BeLessThanOrEqualTo, 4.4)
	ExpectFloat(4.5, NotTo, BeLessThanOrEqualTo, 1.0)

	ExpectFloat(-12.6, To, BeLessThanOrEqualTo, 100.0)
	ExpectFloat(-12.6, To, BeLessThanOrEqualTo, -12.0)
	ExpectFloat(-12.6, To, BeLessThanOrEqualTo, -12.5)
	ExpectFloat(-12.6, To, BeLessThanOrEqualTo, -12.59)
	ExpectFloat(-12.6, To, BeLessThanOrEqualTo, -12.6)
	ExpectFloat(-12.6, NotTo, BeLessThanOrEqualTo, -13.0)
	ExpectFloat(-12.6, NotTo, BeLessThanOrEqualTo, -100.0)
EndFunction


bool Function Case_Matcher_BeGreaterThan()
	ExpectInt(7, To, BeGreaterThan, 5)
	ExpectInt(7, To, BeGreaterThan, -6)
	ExpectInt(7, To, BeGreaterThan, 6)
	ExpectInt(7, NotTo, BeGreaterThan, 7)
	ExpectInt(7, NotTo, BeGreaterThan, 8)

	ExpectInt(-8, To, BeGreaterThan, -10)
	ExpectInt(-8, To, BeGreaterThan, -1000)
	ExpectInt(-8, To, BeGreaterThan, -9)
	ExpectInt(-8, NotTo, BeGreaterThan, -8)
	ExpectInt(-8, NotTo, BeGreaterThan, -7)
	ExpectInt(-8, NotTo, BeGreaterThan, 12)

	ExpectFloat(4.5, To, BeGreaterThan, 1.0)
	ExpectFloat(4.5, To, BeGreaterThan, 4.0)
	ExpectFloat(4.5, To, BeGreaterThan, 4.4)
	ExpectFloat(4.5, To, BeGreaterThan, 4.45)
	ExpectFloat(4.5, To, BeGreaterThan, 4.4999)
	ExpectFloat(4.5, NotTo, BeGreaterThan, 4.5)
	ExpectFloat(4.5, NotTo, BeGreaterThan, 23.6)

	ExpectFloat(-12.6, To, BeGreaterThan, -100.0)
	ExpectFloat(-12.6, To, BeGreaterThan, -14.0)
	ExpectFloat(-12.6, To, BeGreaterThan, -12.7)
	ExpectFloat(-12.6, To, BeGreaterThan, -12.61)
	ExpectFloat(-12.6, NotTo, BeGreaterThan, -12.6)
	ExpectFloat(-12.6, NotTo, BeGreaterThan, -12.5)
	ExpectFloat(-12.6, NotTo, BeGreaterThan, 100.0)
EndFunction


bool Function Case_Matcher_BeGreaterThanOrEqualTo()
	ExpectInt(7, To, BeGreaterThanOrEqualTo, 5)
	ExpectInt(7, To, BeGreaterThanOrEqualTo, -6)
	ExpectInt(7, To, BeGreaterThanOrEqualTo, 6)
	ExpectInt(7, To, BeGreaterThanOrEqualTo, 7)
	ExpectInt(7, NotTo, BeGreaterThanOrEqualTo, 8)

	ExpectInt(-8, To, BeGreaterThanOrEqualTo, -10)
	ExpectInt(-8, To, BeGreaterThanOrEqualTo, -1000)
	ExpectInt(-8, To, BeGreaterThanOrEqualTo, -9)
	ExpectInt(-8, To, BeGreaterThanOrEqualTo, -8)
	ExpectInt(-8, NotTo, BeGreaterThanOrEqualTo, -7)
	ExpectInt(-8, NotTo, BeGreaterThanOrEqualTo, 12)

	ExpectFloat(4.5, To, BeGreaterThanOrEqualTo, 1.0)
	ExpectFloat(4.5, To, BeGreaterThanOrEqualTo, 4.0)
	ExpectFloat(4.5, To, BeGreaterThanOrEqualTo, 4.4)
	ExpectFloat(4.5, To, BeGreaterThanOrEqualTo, 4.45)
	ExpectFloat(4.5, To, BeGreaterThanOrEqualTo, 4.4999)
	ExpectFloat(4.5, To, BeGreaterThanOrEqualTo, 4.5)
	ExpectFloat(4.5, NotTo, BeGreaterThanOrEqualTo, 4.51)
	ExpectFloat(4.5, NotTo, BeGreaterThanOrEqualTo, 23.6)

	ExpectFloat(-12.6, To, BeGreaterThanOrEqualTo, -100.0)
	ExpectFloat(-12.6, To, BeGreaterThanOrEqualTo, -14.0)
	ExpectFloat(-12.6, To, BeGreaterThanOrEqualTo, -12.7)
	ExpectFloat(-12.6, To, BeGreaterThanOrEqualTo, -12.61)
	ExpectFloat(-12.6, To, BeGreaterThanOrEqualTo, -12.6)
	ExpectFloat(-12.6, NotTo, BeGreaterThanOrEqualTo, -12.5)
	ExpectFloat(-12.6, NotTo, BeGreaterThanOrEqualTo, 100.0)
EndFunction


bool Function Case_Matcher_BeTruthy()
	ExpectInt(1, To, BeTruthy)
	ExpectInt(0, NotTo, BeTruthy)
	ExpectInt(-1, To, BeTruthy)

	ExpectFloat(1.0, To, BeTruthy)
	ExpectFloat(0.001, To, BeTruthy)
	ExpectFloat(0.0, NotTo, BeTruthy)
	ExpectFloat(-12.5, To, BeTruthy)

	ExpectBool(true, To, BeTruthy)
	ExpectBool(false, NotTo, BeTruthy)

	ExpectForm(ArmorIronCuirass, To, BeTruthy)
	ExpectForm(EmptyForm, NotTo, BeTruthy)

	ObjectReference EmptyRef = none
	ExpectRef(TestArmorRef, To, BeTruthy)
	ExpectRef(EmptyRef, NotTo, BeTruthy)

	ExpectString("test string", To, BeTruthy)
	ExpectString("", NotTo, BeTruthy)
EndFunction


bool Function Case_Matcher_BeFalsy()
	ExpectInt(1, NotTo, BeFalsy)
	ExpectInt(0, To, BeFalsy)
	ExpectInt(-1, NotTo, BeFalsy)

	ExpectFloat(1.0, NotTo, BeFalsy)
	ExpectFloat(0.001, NotTo, BeFalsy)
	ExpectFloat(0.0, To, BeFalsy)
	ExpectFloat(-12.5, NotTo, BeFalsy)

	ExpectBool(true, NotTo, BeFalsy)
	ExpectBool(false, To, BeFalsy)

	ExpectForm(ArmorIronCuirass, NotTo, BeFalsy)
	ExpectForm(EmptyForm, To, BeFalsy)

	ObjectReference EmptyRef = none
	ExpectRef(TestArmorRef, NotTo, BeFalsy)
	ExpectRef(EmptyRef, To, BeFalsy)

	ExpectString("test string", NotTo, BeFalsy)
	ExpectString("", To, BeFalsy)
EndFunction


bool Function Case_Matcher_BeNone()
	ExpectForm(EmptyForm, To, BeNone)
	ExpectForm(ArmorIronCuirass, NotTo, BeNone)

	ObjectReference EmptyRef = none
	ExpectRef(EmptyRef, To, BeNone)
	ExpectRef(TestArmorRef, NotTo, BeNone)
EndFunction


bool Function Case_Message_StepFailure()
	int index = 0

	MockLilacTest.failedActuals[index] = "5"
	MockLilacTest.failedConditions[index] = To
	MockLilacTest.failedMatchers[index] = BeEqualTo
	MockLilacTest.failedExpecteds[index] = "76"
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 1: expected 5 to be equal to 76")

	index += 1

	MockLilacTest.failedActuals[index] = "5"
	MockLilacTest.failedConditions[index] = NotTo
	MockLilacTest.failedMatchers[index] = BeEqualTo
	MockLilacTest.failedExpecteds[index] = "5"
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 2: expected 5 not to be equal to 5")

	index += 1

	MockLilacTest.failedActuals[index] = "98"
	MockLilacTest.failedConditions[index] = To
	MockLilacTest.failedMatchers[index] = BeLessThan
	MockLilacTest.failedExpecteds[index] = "12"
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 3: expected 98 to be less than 12")

	index += 1

	MockLilacTest.failedActuals[index] = "12.65"
	MockLilacTest.failedConditions[index] = NotTo
	MockLilacTest.failedMatchers[index] = BeLessThan
	MockLilacTest.failedExpecteds[index] = "35.97"
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 4: expected 12.65 not to be less than 35.97")

	index += 1

	MockLilacTest.failedActuals[index] = "98"
	MockLilacTest.failedConditions[index] = To
	MockLilacTest.failedMatchers[index] = BeLessThanOrEqualTo
	MockLilacTest.failedExpecteds[index] = "12"
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 5: expected 98 to be less than or equal to 12")

	index += 1

	MockLilacTest.failedActuals[index] = "12.65"
	MockLilacTest.failedConditions[index] = NotTo
	MockLilacTest.failedMatchers[index] = BeLessThanOrEqualTo
	MockLilacTest.failedExpecteds[index] = "12.65"
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 6: expected 12.65 not to be less than or equal to 12.65")

	index += 1

	MockLilacTest.failedActuals[index] = "12.8"
	MockLilacTest.failedConditions[index] = To
	MockLilacTest.failedMatchers[index] = BeGreaterThan
	MockLilacTest.failedExpecteds[index] = "98.2"
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 7: expected 12.8 to be greater than 98.2")

	index += 1

	MockLilacTest.failedActuals[index] = "12.65"
	MockLilacTest.failedConditions[index] = NotTo
	MockLilacTest.failedMatchers[index] = BeGreaterThan
	MockLilacTest.failedExpecteds[index] = "10.333333"
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 8: expected 12.65 not to be greater than 10.333333")

	index += 1

	MockLilacTest.failedActuals[index] = "16"
	MockLilacTest.failedConditions[index] = To
	MockLilacTest.failedMatchers[index] = BeGreaterThanOrEqualTo
	MockLilacTest.failedExpecteds[index] = "10356"
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 9: expected 16 to be greater than or equal to 10356")

	index += 1

	MockLilacTest.failedActuals[index] = "10.333333"
	MockLilacTest.failedConditions[index] = NotTo
	MockLilacTest.failedMatchers[index] = BeGreaterThanOrEqualTo
	MockLilacTest.failedExpecteds[index] = "10.333333"
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 10: expected 10.333333 not to be greater than or equal to 10.333333")

	index += 1

	MockLilacTest.failedActuals[index] = "false"
	MockLilacTest.failedConditions[index] = To
	MockLilacTest.failedMatchers[index] = BeTruthy
	MockLilacTest.failedExpecteds[index] = ""
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 11: expected false to be truthy")

	index += 1

	MockLilacTest.failedActuals[index] = "true"
	MockLilacTest.failedConditions[index] = NotTo
	MockLilacTest.failedMatchers[index] = BeTruthy
	MockLilacTest.failedExpecteds[index] = ""
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 12: expected true not to be truthy")

	index += 1

	MockLilacTest.failedActuals[index] = "true"
	MockLilacTest.failedConditions[index] = To
	MockLilacTest.failedMatchers[index] = BeFalsy
	MockLilacTest.failedExpecteds[index] = ""
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 13: expected true to be falsy")

	index += 1

	MockLilacTest.failedActuals[index] = "false"
	MockLilacTest.failedConditions[index] = NotTo
	MockLilacTest.failedMatchers[index] = BeFalsy
	MockLilacTest.failedExpecteds[index] = ""
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 14: expected false not to be falsy")

	index += 1

	MockLilacTest.failedActuals[index] = "WeaponObject"
	MockLilacTest.failedConditions[index] = To
	MockLilacTest.failedMatchers[index] = BeNone
	MockLilacTest.failedExpecteds[index] = ""
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 15: expected WeaponObject to be none")

	index += 1

	MockLilacTest.failedActuals[index] = "none"
	MockLilacTest.failedConditions[index] = NotTo
	MockLilacTest.failedMatchers[index] = BeNone
	MockLilacTest.failedExpecteds[index] = ""
	MockLilacTest.failedExpectNumbers[index] = index + 1

	ExpectString(MockLilacTest.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 16: expected none not to be none")
EndFunction


bool Function Case_Message_InvalidMatcher()
	; ExpectForm
	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectForm(ArmorIronCuirass, To, BeGreaterThan, ArmorIronCuirass)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThan' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectForm(ArmorIronCuirass, To, BeGreaterThanOrEqualTo, none)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThanOrEqualTo' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectForm(ArmorIronCuirass, To, BeLessThan, ArmorIronCuirass)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThan' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectForm(ArmorIronCuirass, To, BeLessThanOrEqualTo, none)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThanOrEqualTo' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectForm(ArmorIronCuirass, NotTo, BeGreaterThan, none)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThan' used.")


	; ExpectRef
	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectRef(TestArmorRef, To, BeGreaterThan, TestArmorRef)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThan' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectRef(TestArmorRef, To, BeGreaterThanOrEqualTo, TestArmorRef)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThanOrEqualTo' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectRef(TestArmorRef, To, BeLessThan, none)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThan' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectRef(TestArmorRef, To, BeLessThanOrEqualTo, none)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThanOrEqualTo' used.")


	; ExpectInt
	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectInt(5, To, BeNone)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeNone' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectInt(5, NotTo, BeNone)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeNone' used.")


	; ExpectFloat
	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectFloat(3.4565, To, BeNone)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeNone' used.")


	; ExpectBool
	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectBool(true, To, BeGreaterThan, 0)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThan' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectBool(true, To, BeGreaterThanOrEqualTo, 0)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThanOrEqualTo' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectBool(false, To, BeLessThan, 0)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThan' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectBool(false, To, BeLessThanOrEqualTo, 0)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThanOrEqualTo' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectBool(false, To, BeNone)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeNone' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectBool(false, NotTo, BeLessThanOrEqualTo, 0)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThanOrEqualTo' used.")


	; ExpectString
	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectString("test string", To, BeGreaterThan, 0)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThan' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectString("test string", To, BeGreaterThanOrEqualTo, 0)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThanOrEqualTo' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectString("test string", To, BeLessThan, 0)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThan' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectString("test string", To, BeLessThanOrEqualTo, 0)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThanOrEqualTo' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectString("test string", To, BeNone)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeNone' used.")

	MockLilacTest.MockLastRaisedResultResult = true
	MockLilacTest.MockLastLilacDebugMessage = ""

	MockLilacTest.ExpectString("test string", NotTo, BeLessThan, 0)
	ExpectBool(MockLilacTest.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(MockLilacTest.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThan' used.")
EndFunction


bool Function Case_TestCase_BeforeAfterEach()
	MockLilacTest.RunTests()

	; There are 2 test cases, but beforeEach and afterEach
	; are expected to run 3 times.
	ExpectInt(MockLilacTest.MockBeforeEachCallCount, To, BeEqualTo, 3)
	ExpectInt(MockLilacTest.mockAfterEachCallCount, To, BeEqualTo, 3)
EndFunction


bool Function Case_TestCase_Describe()
	MockLilacTest.RunTests()
	ExpectInt(MockLilacTest.MockItCallCount, To, BeEqualTo, 2)
EndFunction
