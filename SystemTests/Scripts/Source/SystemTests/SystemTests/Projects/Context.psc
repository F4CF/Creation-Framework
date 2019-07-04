ScriptName SystemTests:Projects:Context Extends System:Diagnostics:UnitTest
import System
import System:Log
import System:VersionType

; Test Runner
;---------------------------------------------

Function Setup()
	WriteLine(self, "Executing the Setup function.")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine(self, "Executing the TestSuites function.")
	Describe("Implementation", ImplementationSuite())
EndFunction


; Suites
;---------------------------------------------

bool Function ImplementationSuite()
	WriteLine(self, "Implementation Suite.")
	It("should not be none", InstanceTestCase())
	It("should have a valid title", TitleTestCase())
	It("should not have a none authors array, but it may be empty", AuthorsTestCase())
	It("should have a valid filename and extension to its plugin", FileNameTestCase())
	It("should have a valid FormID which matches the attached Quest", FormIDTestCase())
	It("should have a valid release version greater than zero", VersionTestCase())
	return Done
EndFunction


; Cases
;---------------------------------------------

bool Function InstanceTestCase()
	WriteLine(self, "InstanceTestCase")
	; expectations
	; -is not none
	ExpectIsNotNone(Context)
	Expect(Context is Quest, To, BeTruthy)
	return Done
EndFunction


bool Function TitleTestCase()
	WriteLine(self, "TitleTestCase")
	; expectations
	; -string contains text
	ExpectStringHasText(Context.Title)
	return Done
EndFunction


bool Function AuthorsTestCase()
	WriteLine(self, "AuthorsTestCase")
	; expectations
	; -is not none
	Expect(Context.Authors as bool, To, BeTruthy)
	return Done
EndFunction


bool Function FileNameTestCase()
	WriteLine(self, "FileNameTestCase")
	; expectations
	; -string contains text
	; -string ends with ".esm" or ".esp"
	ExpectStringHasText(Context.FileName)
	return Done
EndFunction


bool Function FormIDTestCase()
	WriteLine(self, "FormIDTestCase")
	; expectations
	; -the attached quest must match this FormID
	int actualFormID = (Context as Quest).GetFormID()
	int expectedFormID = Context.FormID
	Expect(expectedFormID, To, BeEqualTo, actualFormID)
	return Done
EndFunction


bool Function VersionTestCase()
	WriteLine(self, "VersionTestCase")
	; expectations
	; -the context version to be greater than a new version (new default 0.0.0.0, false)
	ExpectIsNotNone(Context.Release)
	Expect(VersionGreaterThan(Context.Release, new Version), To, BeTruthy)
	return Done
EndFunction


; Properties
;---------------------------------------------

Group Actual
	Projects:Context Property Context Auto Const Mandatory
EndGroup
