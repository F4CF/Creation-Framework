ScriptName SystemTests:Projects:Context Extends System:Diagnostics:LilacEx
import System
import System:Log
import System:VersionType

; Lilac
;---------------------------------------------

Function Setup()
	WriteLine(self, "Executing the Setup function.")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine(self, "Executing the TestSuites function.")
	describe("Implementation", ImplementationSuite())
EndFunction


; Suites
;---------------------------------------------

bool Function ImplementationSuite()
	WriteLine(self, "Implementation Suite.")
	It("should not be none", instanceTestCase())
	It("should have a valid title", titleTestCase())
	It("should not have a none authors array, but it may be empty", authorsTestCase())
	It("should have a valid filename and extension to its plugin", filenameTestCase())
	It("should have a valid FormID which matches the attached Quest", formidTestCase())
	It("should have a valid release version greater than zero", versionTestCase())
	return Done
EndFunction


; Cases
;---------------------------------------------

bool Function instanceTestCase()
	WriteLine(self, "instanceTestCase")
	; expectations
	; -is not none
	expectIsNotNone(Context)
	expect(Context is Quest, To, beTruthy)
	return Done
EndFunction


bool Function titleTestCase()
	WriteLine(self, "titleTestCase")
	; expectations
	; -string contains text
	expectStringHasText(Context.Title)
	return Done
EndFunction


bool Function authorsTestCase()
	WriteLine(self, "authorsTestCase")
	; expectations
	; -is not none
	expect(Context.Authors as bool, To, beTruthy)
	return Done
EndFunction


bool Function filenameTestCase()
	WriteLine(self, "filenameTestCase")
	; expectations
	; -string contains text
	; -string ends with ".esm" or ".esp"
	expectStringHasText(Context.FileName)
	return Done
EndFunction


bool Function formidTestCase()
	WriteLine(self, "formidTestCase")
	; expectations
	; -the attached quest must match this FormID
	int actualFormID = (Context as Quest).GetFormID()
	int expectedFormID = Context.FormID
	expect(expectedFormID, To, BeEqualTo, actualFormID)
	return Done
EndFunction


bool Function versionTestCase()
	WriteLine(self, "versionTestCase")
	; expectations
	; -the context version to be greater than a new version (new default 0.0.0.0, false)
	expectIsNotNone(Context.Release)
	expect(VersionGreaterThan(Context.Release, new Version), To, beTruthy)
	return Done
EndFunction


; Properties
;---------------------------------------------

Group Actual
	Projects:Context Property Context Auto Const Mandatory
EndGroup
