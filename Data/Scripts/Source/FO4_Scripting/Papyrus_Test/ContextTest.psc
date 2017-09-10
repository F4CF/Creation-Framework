ScriptName Papyrus_Test:ContextTest extends Papyrus_Test:Framework:Lilac
import Papyrus
import Papyrus:Compatibility
import Papyrus:Diagnostics:Log
import Papyrus:VersionType

UserLog Log


; Events
;---------------------------------------------

Event OnInit()
	Log = LogNew(Common.LogFile, self)
	parent.OnInit()
EndEvent


; Lilac
;---------------------------------------------

Function Setup()
	WriteLine(Log, "Executing the Setup function.")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine(Log, "Executing the TestSuites function.")
	describe("Implementation", ImplementationSuite())
EndFunction


; Suites
;---------------------------------------------

bool Function ImplementationSuite()
	WriteLine(Log, "Implementation Suite.")
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
	WriteLine(Log, "instanceTestCase")
	; expectations
	; -is not none
	expectIsNotNone(Context)
	expect(Context is Quest, to, beTruthy)
	return Done
EndFunction


bool Function titleTestCase()
	WriteLine(Log, "titleTestCase")
	; expectations
	; -string contains text
	expectStringHasText(Context.Title)
	return Done
EndFunction


bool Function authorsTestCase()
	WriteLine(Log, "authorsTestCase")
	; expectations
	; -is not none
	expect(Context.Authors as bool, to, beTruthy)
	return Done
EndFunction


bool Function filenameTestCase()
	WriteLine(Log, "filenameTestCase")
	; expectations
	; -string contains text
	; -string ends with ".esm" or ".esp"
	expectStringHasText(Context.FileName)
	return Done
EndFunction


bool Function formidTestCase()
	WriteLine(Log, "formidTestCase")
	; expectations
	; -the attached quest must match this FormID
	int actualFormID = (Context as Quest).GetFormID()
	int expectedFormID = Context.FormID
	expect(expectedFormID, to, beEqualTo, actualFormID)
	return Done
EndFunction


bool Function versionTestCase()
	WriteLine(Log, "versionTestCase")
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
