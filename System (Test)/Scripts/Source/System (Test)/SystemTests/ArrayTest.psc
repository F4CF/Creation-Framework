ScriptName SystemTests:ArrayTest Extends System:Diagnostics:Lilac
import System:Array
import System:Log


; Lilac
;---------------------------------------------

Function Setup()
	WriteLine("Executing the Setup function.")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine("Executing the TestSuites function.")
	describe("Array Capacity", CapacitySuite())
	describe("Array Distinct", DistinctSuite())
EndFunction


; Capacity
;---------------------------------------------

bool Function CapacitySuite()
	WriteLine("Capacity Suite.")
	it("should have a created length of 0", CapacityTest(0))
	it("should have a created length of 64", CapacityTest(64))
	it("should have a created length of 128", CapacityTest(128))
	it("should have a created length of 256", CapacityTest(256))
	it("should have a created length of 512", CapacityTest(512))
	it("should have a created length of 1024", CapacityTest(1024))
	return Done
EndFunction


bool Function CapacityTest(int aSize)
	WriteLine("CapacityTest "+aSize)
	var[] array = new var[aSize]
	expect(array.Length, beEqualTo, aSize)
	return Done
EndFunction


; Distinct
;---------------------------------------------

bool Function DistinctSuite()
	WriteLine("Distinct Suite.")
	it("should return a distinct array of booleans", DistinctBooleanCase())
	it("should return a distinct array of integers", DistinctIntegerCase())
	it("should return a distinct array of floating points", DistinctFloatingCase())
	it("should return a distinct array of strings", DistinctStringCase())
	it("should return a distinct array of elements", DistinctElementsCase())
	return Done
EndFunction


bool Function DistinctBooleanCase()
	WriteLine("DistinctBooleanCase")
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
	WriteLine("DistinctIntegerCase")
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
	WriteLine("DistinctFloatingCase")
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
	WriteLine("DistinctStringCase")
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
	WriteLine("DistinctElementsCase")
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
