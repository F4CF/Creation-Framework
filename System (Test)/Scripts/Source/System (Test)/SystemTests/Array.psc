ScriptName SystemTests:Array Extends System:Diagnostics:UnitTest
import System:Array
import System:Log


; Test Runner
;---------------------------------------------

Function Setup()
	WriteLine(self, "Executing the Setup function.")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine(self, "Executing the TestSuites function.")
	Describe("Array Capacity", CapacitySuite())
	Describe("Array Distinct", DistinctSuite())
EndFunction


; Capacity
;---------------------------------------------

bool Function CapacitySuite()
	WriteLine(self, "Capacity Suite.")
	It("should have a created length of 0", CapacityTest(0))
	It("should have a created length of 64", CapacityTest(64))
	It("should have a created length of 128", CapacityTest(128))
	It("should have a created length of 256", CapacityTest(256))
	It("should have a created length of 512", CapacityTest(512))
	It("should have a created length of 1024", CapacityTest(1024))
	return Done
EndFunction


bool Function CapacityTest(int size)
	WriteLine(self, "CapacityTest "+size)
	var[] array = new var[size]
	Expect(array.Length, BeEqualTo, size)
	return Done
EndFunction


; Distinct
;---------------------------------------------

bool Function DistinctSuite()
	WriteLine(self, "Distinct Suite.")
	It("should return a distinct array of booleans", DistinctBooleanCase())
	It("should return a distinct array of integers", DistinctIntegerCase())
	It("should return a distinct array of floating points", DistinctFloatingCase())
	It("should return a distinct array of strings", DistinctStringCase())
	It("should return a distinct array of elements", DistinctElementsCase())
	return Done
EndFunction


bool Function DistinctBooleanCase()
	WriteLine(self, "DistinctBooleanCase")
	var[] array = new var[0]
	array.Add(true)
	array.Add(true)
	array.Add(true)
	array.Add(false)
	array.Add(false)
	array.Add(false)
	var[] result = ArrayGetDistinct(array)
	Expect(result.Length, BeEqualTo, 2)
	return Done
EndFunction


bool Function DistinctIntegerCase()
	WriteLine(self, "DistinctIntegerCase")
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
	Expect(result.Length, BeEqualTo, 3)
	return Done
EndFunction


bool Function DistinctFloatingCase()
	WriteLine(self, "DistinctFloatingCase")
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
	Expect(result.Length, BeEqualTo, 9)
	return Done
EndFunction


bool Function DistinctStringCase()
	WriteLine(self, "DistinctStringCase")
	var[] array = new var[0]
	array.Add("")
	array.Add("")
	array.Add(" ")
	array.Add(" ")
	array.Add("Hello")
	array.Add("World")
	var[] result = ArrayGetDistinct(array)
	Expect(result.Length, BeEqualTo, 4)
	return Done
EndFunction


bool Function DistinctElementsCase()
	WriteLine(self, "DistinctElementsCase")
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
	Expect(result.Length, BeEqualTo, 7)
	return Done
EndFunction
