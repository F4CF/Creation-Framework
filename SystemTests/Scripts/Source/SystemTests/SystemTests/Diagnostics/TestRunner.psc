ScriptName SystemTests:Diagnostics:TestRunner Extends System:Diagnostics:UnitTest

SystemTests:Properties:Assembly Assembly
SystemTests:Diagnostics:TestRunnerMock TestRunnerMock

Armor Armor_Vault111_Underwear
ObjectReference TestArmorRef
Form EmptyForm


Event OnQuestInit()
	Assembly = SystemTests:Properties:Assembly.GetAssembly()
EndEvent


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

Function BeforeAll()
	TestRunnerMock = System:Type.Read(Assembly.File, Assembly.SystemTests_DiagnosticsTestRunner) as SystemTests:Diagnostics:TestRunnerMock
	TestRunnerMock.MockLastLilacDebugMessage = ""
	TestRunnerMock.MockLastRaisedResultResult = true

	Armor_Vault111_Underwear = System:Type.Read(Assembly.Fallout, Assembly.Armor_Vault111_Underwear) as Armor
	TestArmorRef = Game.GetPlayer().PlaceAtMe(Armor_Vault111_Underwear)
	EmptyForm = none
EndFunction


Function BeforeEach()
	TestRunnerMock.ResetTestRunner()
	TestRunnerMock.MockBeforeEachCallCount = 0
	TestRunnerMock.MockAfterEachCallCount = 0
	TestRunnerMock.MockItCallCount = 0
EndFunction


Function AfterAll()
	TestRunnerMock.MockLastLilacDebugMessage = ""
	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock = none
	Armor_Vault111_Underwear = none
	TestArmorRef.Disable()
	TestArmorRef.Delete()
EndFunction


Function AfterEach()
	TestRunnerMock.ResetTestRunner()
	TestRunnerMock.MockBeforeEachCallCount = 0
	TestRunnerMock.MockAfterEachCallCount = 0
	TestRunnerMock.MockItCallCount = 0
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

	ExpectForm(Armor_Vault111_Underwear, To, BeEqualTo, Armor_Vault111_Underwear)
	ExpectForm(Armor_Vault111_Underwear, NotTo, BeEqualTo, none)
	ExpectForm(Armor_Vault111_Underwear, NotTo, BeEqualTo, Game.GetPlayer().GetActorBase())

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

	ExpectForm(Armor_Vault111_Underwear, To, BeTruthy)
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

	ExpectForm(Armor_Vault111_Underwear, NotTo, BeFalsy)
	ExpectForm(EmptyForm, To, BeFalsy)

	ObjectReference EmptyRef = none
	ExpectRef(TestArmorRef, NotTo, BeFalsy)
	ExpectRef(EmptyRef, To, BeFalsy)

	ExpectString("test string", NotTo, BeFalsy)
	ExpectString("", To, BeFalsy)
EndFunction


bool Function Case_Matcher_BeNone()
	ExpectForm(EmptyForm, To, BeNone)
	ExpectForm(Armor_Vault111_Underwear, NotTo, BeNone)

	ObjectReference EmptyRef = none
	ExpectRef(EmptyRef, To, BeNone)
	ExpectRef(TestArmorRef, NotTo, BeNone)
EndFunction


bool Function Case_Message_StepFailure()
	int index = 0

	TestRunnerMock.failedActuals[index] = "5"
	TestRunnerMock.failedConditions[index] = To
	TestRunnerMock.failedMatchers[index] = BeEqualTo
	TestRunnerMock.failedExpecteds[index] = "76"
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 1: expected 5 to be equal to 76")

	index += 1

	TestRunnerMock.failedActuals[index] = "5"
	TestRunnerMock.failedConditions[index] = NotTo
	TestRunnerMock.failedMatchers[index] = BeEqualTo
	TestRunnerMock.failedExpecteds[index] = "5"
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 2: expected 5 not to be equal to 5")

	index += 1

	TestRunnerMock.failedActuals[index] = "98"
	TestRunnerMock.failedConditions[index] = To
	TestRunnerMock.failedMatchers[index] = BeLessThan
	TestRunnerMock.failedExpecteds[index] = "12"
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 3: expected 98 to be less than 12")

	index += 1

	TestRunnerMock.failedActuals[index] = "12.65"
	TestRunnerMock.failedConditions[index] = NotTo
	TestRunnerMock.failedMatchers[index] = BeLessThan
	TestRunnerMock.failedExpecteds[index] = "35.97"
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 4: expected 12.65 not to be less than 35.97")

	index += 1

	TestRunnerMock.failedActuals[index] = "98"
	TestRunnerMock.failedConditions[index] = To
	TestRunnerMock.failedMatchers[index] = BeLessThanOrEqualTo
	TestRunnerMock.failedExpecteds[index] = "12"
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 5: expected 98 to be less than or equal to 12")

	index += 1

	TestRunnerMock.failedActuals[index] = "12.65"
	TestRunnerMock.failedConditions[index] = NotTo
	TestRunnerMock.failedMatchers[index] = BeLessThanOrEqualTo
	TestRunnerMock.failedExpecteds[index] = "12.65"
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 6: expected 12.65 not to be less than or equal to 12.65")

	index += 1

	TestRunnerMock.failedActuals[index] = "12.8"
	TestRunnerMock.failedConditions[index] = To
	TestRunnerMock.failedMatchers[index] = BeGreaterThan
	TestRunnerMock.failedExpecteds[index] = "98.2"
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 7: expected 12.8 to be greater than 98.2")

	index += 1

	TestRunnerMock.failedActuals[index] = "12.65"
	TestRunnerMock.failedConditions[index] = NotTo
	TestRunnerMock.failedMatchers[index] = BeGreaterThan
	TestRunnerMock.failedExpecteds[index] = "10.333333"
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 8: expected 12.65 not to be greater than 10.333333")

	index += 1

	TestRunnerMock.failedActuals[index] = "16"
	TestRunnerMock.failedConditions[index] = To
	TestRunnerMock.failedMatchers[index] = BeGreaterThanOrEqualTo
	TestRunnerMock.failedExpecteds[index] = "10356"
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 9: expected 16 to be greater than or equal to 10356")

	index += 1

	TestRunnerMock.failedActuals[index] = "10.333333"
	TestRunnerMock.failedConditions[index] = NotTo
	TestRunnerMock.failedMatchers[index] = BeGreaterThanOrEqualTo
	TestRunnerMock.failedExpecteds[index] = "10.333333"
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 10: expected 10.333333 not to be greater than or equal to 10.333333")

	index += 1

	TestRunnerMock.failedActuals[index] = "false"
	TestRunnerMock.failedConditions[index] = To
	TestRunnerMock.failedMatchers[index] = BeTruthy
	TestRunnerMock.failedExpecteds[index] = ""
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 11: expected false to be truthy")

	index += 1

	TestRunnerMock.failedActuals[index] = "true"
	TestRunnerMock.failedConditions[index] = NotTo
	TestRunnerMock.failedMatchers[index] = BeTruthy
	TestRunnerMock.failedExpecteds[index] = ""
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 12: expected true not to be truthy")

	index += 1

	TestRunnerMock.failedActuals[index] = "true"
	TestRunnerMock.failedConditions[index] = To
	TestRunnerMock.failedMatchers[index] = BeFalsy
	TestRunnerMock.failedExpecteds[index] = ""
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 13: expected true to be falsy")

	index += 1

	TestRunnerMock.failedActuals[index] = "false"
	TestRunnerMock.failedConditions[index] = NotTo
	TestRunnerMock.failedMatchers[index] = BeFalsy
	TestRunnerMock.failedExpecteds[index] = ""
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 14: expected false not to be falsy")

	index += 1

	TestRunnerMock.failedActuals[index] = "WeaponObject"
	TestRunnerMock.failedConditions[index] = To
	TestRunnerMock.failedMatchers[index] = BeNone
	TestRunnerMock.failedExpecteds[index] = ""
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 15: expected WeaponObject to be none")

	index += 1

	TestRunnerMock.failedActuals[index] = "none"
	TestRunnerMock.failedConditions[index] = NotTo
	TestRunnerMock.failedMatchers[index] = BeNone
	TestRunnerMock.failedExpecteds[index] = ""
	TestRunnerMock.failedExpectNumbers[index] = index + 1

	ExpectString(TestRunnerMock.CreateStepFailureMessage(index), To, BeEqualTo, "        - Expect 16: expected none not to be none")
EndFunction


bool Function Case_Message_InvalidMatcher()
	; ExpectForm
	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectForm(Armor_Vault111_Underwear, To, BeGreaterThan, Armor_Vault111_Underwear)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThan' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectForm(Armor_Vault111_Underwear, To, BeGreaterThanOrEqualTo, none)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThanOrEqualTo' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectForm(Armor_Vault111_Underwear, To, BeLessThan, Armor_Vault111_Underwear)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThan' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectForm(Armor_Vault111_Underwear, To, BeLessThanOrEqualTo, none)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThanOrEqualTo' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectForm(Armor_Vault111_Underwear, NotTo, BeGreaterThan, none)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThan' used.")


	; ExpectRef
	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectRef(TestArmorRef, To, BeGreaterThan, TestArmorRef)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThan' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectRef(TestArmorRef, To, BeGreaterThanOrEqualTo, TestArmorRef)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThanOrEqualTo' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectRef(TestArmorRef, To, BeLessThan, none)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThan' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectRef(TestArmorRef, To, BeLessThanOrEqualTo, none)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThanOrEqualTo' used.")


	; ExpectInt
	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectInt(5, To, BeNone)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeNone' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectInt(5, NotTo, BeNone)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeNone' used.")


	; ExpectFloat
	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectFloat(3.4565, To, BeNone)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeNone' used.")


	; ExpectBool
	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectBool(true, To, BeGreaterThan, 0)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThan' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectBool(true, To, BeGreaterThanOrEqualTo, 0)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThanOrEqualTo' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectBool(false, To, BeLessThan, 0)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThan' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectBool(false, To, BeLessThanOrEqualTo, 0)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThanOrEqualTo' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectBool(false, To, BeNone)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeNone' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectBool(false, NotTo, BeLessThanOrEqualTo, 0)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThanOrEqualTo' used.")


	; ExpectString
	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectString("test string", To, BeGreaterThan, 0)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThan' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectString("test string", To, BeGreaterThanOrEqualTo, 0)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeGreaterThanOrEqualTo' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectString("test string", To, BeLessThan, 0)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThan' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectString("test string", To, BeLessThanOrEqualTo, 0)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThanOrEqualTo' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectString("test string", To, BeNone)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeNone' used.")

	TestRunnerMock.MockLastRaisedResultResult = true
	TestRunnerMock.MockLastLilacDebugMessage = ""

	TestRunnerMock.ExpectString("test string", NotTo, BeLessThan, 0)
	ExpectBool(TestRunnerMock.MockLastRaisedResultResult, To, BeFalsy)
	ExpectString(TestRunnerMock.MockLastLilacDebugMessage, To, BeEqualTo, "[Lilac] ERROR - Invalid matcher 'BeLessThan' used.")
EndFunction


bool Function Case_TestCase_BeforeAfterEach()
	TestRunnerMock.RunTests()

	; There are 2 test cases, but beforeEach and afterEach
	; are expected to run 3 times.
	ExpectInt(TestRunnerMock.MockBeforeEachCallCount, To, BeEqualTo, 3)
	ExpectInt(TestRunnerMock.MockAfterEachCallCount, To, BeEqualTo, 3)
EndFunction


bool Function Case_TestCase_Describe()
	TestRunnerMock.RunTests()
	ExpectInt(TestRunnerMock.MockItCallCount, To, BeEqualTo, 2)
EndFunction
