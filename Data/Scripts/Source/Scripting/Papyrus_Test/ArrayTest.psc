ScriptName Papyrus_Test:ArrayTest extends Papyrus_Test:Framework:Lilac
import Papyrus:Array
import Papyrus:Diagnostics:Log


UserLog Log



; Events
;---------------------------------------------

Event OnInit()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = LogFile
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
	describe("Distinct", DistinctSuite())
EndFunction


; Suites
;---------------------------------------------

bool Function DistinctSuite()
	WriteLine(Log, "Distinct Suite.")
	it("should return a distinct array of booleans", DistinctBooleanCase())
	it("should return a distinct array of integers", DistinctIntegerCase())
	it("should return a distinct array of floating points", DistinctFloatingCase())
	it("should return a distinct array of strings", DistinctStringCase())
	it("should return a distinct array of elements", DistinctElementsCase())
	return Done
EndFunction


; Cases
;---------------------------------------------

bool Function DistinctBooleanCase()
	WriteLine(Log, "DistinctBooleanCase")
	var[] array = new var[0]
	array.Add(true)
	array.Add(true)
	array.Add(true)
	array.Add(false)
	array.Add(false)
	array.Add(false)
	var[] result = ArrayGetDistinct(array)
	expect(result.Length, beEqualTo, 2)
	return Done
EndFunction


bool Function DistinctIntegerCase()
	WriteLine(Log, "DistinctIntegerCase")
	var[] array = new var[0]
	array.Add(1)
	array.Add(1)
	array.Add(1)
	array.Add(2)
	array.Add(2)
	array.Add(2)
	array.Add(3)
	array.Add(3)
	array.Add(3)
	var[] result = ArrayGetDistinct(array)
	expect(result.Length, beEqualTo, 3)
	return Done
EndFunction


bool Function DistinctFloatingCase()
	WriteLine(Log, "DistinctFloatingCase")
	var[] array = new var[0]
	array.Add(1.0)
	array.Add(1.0)
	array.Add(1.1)
	array.Add(1.1)
	array.Add(1.5)
	array.Add(1.5)
	array.Add(1.9)
	array.Add(1.9)
	array.Add(2.0)
	array.Add(3.0)
	array.Add(0.1)
	array.Add(0.1)
	array.Add(0.5)
	array.Add(0.5)
	array.Add(0.9)
	array.Add(0.9)
	var[] result = ArrayGetDistinct(array)
	expect(result.Length, beEqualTo, 9)
	return Done
EndFunction


bool Function DistinctStringCase()
	WriteLine(Log, "DistinctStringCase")
	var[] array = new var[0]
	array.Add("")
	array.Add("")
	array.Add(" ")
	array.Add(" ")
	array.Add("Hello")
	array.Add("World")
	var[] result = ArrayGetDistinct(array)
	expect(result.Length, beEqualTo, 4)
	return Done
EndFunction


bool Function DistinctElementsCase()
	WriteLine(Log, "DistinctElementsCase")
	var[] array = new var[0]
	array.Add(none)
	array.Add(1)
	array.Add(1.0)
	array.Add("1")
	array.Add("1.0")
	array.Add("Hello World")
	array.Add(true)
	array.Add(true)
	array.Add(true)
	array.Add(true)
	array.Add(true)
	var[] result = ArrayGetDistinct(array)
	expect(result.Length, beEqualTo, 7)
	return Done
EndFunction
