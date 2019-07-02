ScriptName SystemTests:Projects:ContextTest Extends System:Diagnostics:Lilac
import System
import System:Log
import System:VersionType


; Lilac
;---------------------------------------------

Function Setup()
	WriteLine("Executing the Setup function.")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine("Executing the TestSuites function.")
	describe("Implementation", ImplementationSuite())
EndFunction


; Suites
;---------------------------------------------

bool Function ImplementationSuite()
	WriteLine("Implementation Suite.")
	it("should not be none", instanceTestCase())
	it("should have a valid title", titleTestCase())
	it("should not have a none authors array, but it may be empty", authorsTestCase())
	it("should have a valid filename and extension to its plugin", filenameTestCase())
	it("should have a valid FormID which matches the attached Quest", formidTestCase())
	it("should have a valid release version greater than zero", versionTestCase())
	return Done
EndFunction


; Cases
;---------------------------------------------

bool Function instanceTestCase()
	WriteLine("instanceTestCase")
	; expectations
	; -is not none
	expectIsNotNone(Context)
	expect(Context is Quest, to, beTruthy)
	return Done
EndFunction


bool Function titleTestCase()
	WriteLine("titleTestCase")
	; expectations
	; -string contains text
	expectStringHasText(Context.Title)
	return Done
EndFunction


bool Function authorsTestCase()
	WriteLine("authorsTestCase")
	; expectations
	; -is not none
	expect(Context.Authors as bool, to, beTruthy)
	return Done
EndFunction


bool Function filenameTestCase()
	WriteLine("filenameTestCase")
	; expectations
	; -string contains text
	; -string ends with ".esm" or ".esp"
	expectStringHasText(Context.FileName)
	return Done
EndFunction


bool Function formidTestCase()
	WriteLine("formidTestCase")
	; expectations
	; -the attached quest must match this FormID
	int actualFormID = (Context as Quest).GetFormID()
	int expectedFormID = Context.FormID
	expect(expectedFormID, to, beEqualTo, actualFormID)
	return Done
EndFunction


bool Function versionTestCase()
	WriteLine("versionTestCase")
	; expectations
	; -the context version to be greater than a new version (new default 0.0.0.0, false)
	expectIsNotNone(Context.Release)
	expect(VersionGreaterThan(Context.Release, new Version), to, beTruthy)
	return Done
EndFunction


; Properties
;---------------------------------------------

Group Actual
	Project:Context Property Context Auto Const Mandatory
EndGroup
