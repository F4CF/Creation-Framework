ScriptName System:Diagnostics:TestRunnerType Extends System:Quest Native Const Hidden
import System:Debug

; Test Runner
;---------------------------------------------

Group Lilac
	string Property SystemName = "Lilac" AutoReadOnly
	float Property SystemVersion = 1.2 AutoReadOnly
	int Property APIVersion = 2 AutoReadOnly
EndGroup


; Unit Test Composition
;---------------------------------------------

Group Conditions
	bool Property To                    = true AutoReadOnly
	bool Property NotTo                 = false AutoReadOnly
EndGroup

Group Matchers
	int Property BeEqualTo              = 0 AutoReadOnly
	int Property BeLessThan             = 1 AutoReadOnly
	int Property BeLessThanOrEqualTo    = 2 AutoReadOnly
	int Property BeGreaterThan          = 3 AutoReadOnly
	int Property BeGreaterThanOrEqualTo = 4 AutoReadOnly
	int Property BeTruthy               = 5 AutoReadOnly
	int Property BeFalsy                = 6 AutoReadOnly
	int Property BeNone                 = 7 AutoReadOnly
EndGroup

string Function MatcherToString(int matcher)
	If (matcher == BeEqualTo)
		return "BeEqualTo"
	ElseIf (matcher == BeLessThan)
		return "BeLessThan"
	ElseIf (matcher == BeLessThanOrEqualTo)
		return "BeLessThanOrEqualTo"
	ElseIf (matcher == BeGreaterThan)
		return "BeGreaterThan"
	ElseIf (matcher == BeGreaterThanOrEqualTo)
		return "BeGreaterThanOrEqualTo"
	ElseIf (matcher == BeTruthy)
		return "BeTruthy"
	ElseIf (matcher == BeFalsy)
		return "BeFalsy"
	ElseIf (matcher == BeNone)
		return "BeNone"
	Else
		return ""
	EndIf
EndFunction

Group Completion
	bool Property Done = true AutoReadOnly
EndGroup


; Logging
;---------------------------------------------

Group Log
	int Property INFO = 0 AutoReadOnly
	int Property WARN = 1 AutoReadOnly
	int Property ERROR = 2 AutoReadOnly
EndGroup

string Function LogToString(int logLevel)
	If (logLevel == INFO)
		return ""
	ElseIf (logLevel == WARN)
		return "WARN - "
	ElseIf (logLevel == ERROR)
		return "ERROR - "
	EndIf
EndFunction


string Function CreateLilacDebugMessage(int logLevel, string text)
	string value = "[" + SystemName + "] " + LogToString(logLevel) + text
	WriteLine(self, "CreateLilacDebugMessage", value, SystemName)
	return value
EndFunction


Function RaiseException_InvalidMatcher(int matcher)
	string text = "Invalid matcher '" + MatcherToString(matcher) + "' used."
	Debug.Trace(CreateLilacDebugMessage(ERROR, text))
EndFunction


Function RaiseException_InvalidType(var actual)
	string text = "Actual " + (actual as string) + " was not a Form, ObjectReference, int, float, bool, or string."
	Debug.Trace(CreateLilacDebugMessage(ERROR, text))
EndFunction


Function RaiseException_NonMatchingType(var actual, var expected)
	string text = "Actual " + (actual as string) + " did not match the type of expected " + (expected as string)
	Debug.Trace(CreateLilacDebugMessage(ERROR, text))
EndFunction


; Methods
;---------------------------------------------

; Expressive syntax for none checking.
bool Function IsNone(string value)
	return value
EndFunction


; Adds a form to the first available element in the array.
; false = Error (array full)
; true = Success
int Function ArrayAddString(string[] array, string tKey)
	int index = 0
	While (index < array.Length)
		If (IsNone(array[index]))
			array[index] = tKey
			return index
		Else
			index += 1
		EndIf
	EndWhile
	return -1
EndFunction


; Counts the number of indices in this array that do not have a "none" type.
; For example, int count = number of indicies that are not "none".
int Function ArrayCountString(string[] array)
	int index = 0
	int count = 0
	While (index < array.Length)
		If !(IsNone(array[index]))
			count += 1
			index += 1
		Else
			index += 1
		EndIf
	EndWhile
	return count
EndFunction


; API
;---------------------------------------------

; Override this Function to run test set-up functions.
; #### Remarks
; The most common use for declaring this Function is to enable verbose logging (`EnableVerboseLogging()`) or to warn on slow tests (`EnableWarningOnSlowTests()`)
Function SetUp() Native

; Override this Function to declare all test suites to run in this Lilac test script.
; #### Remarks
; Any test suites declared n this Function will be automatically run when the quest this script is attached to runs.
Function TestSuites() Native

; Override this Function to run a block of code before any test case runs (including before any beforeEach).
Function BeforeAll() Native

; Override this Function to run a block of code after all test cases run (including after any afterEach).
Function AfterAll() Native

; Override this Function to run a block of code before each test case.
Function BeforeEach() Native

; Override this Function to run a block of code after each test case.
Function AfterEach() Native

