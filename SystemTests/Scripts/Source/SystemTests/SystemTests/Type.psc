ScriptName SystemTests:Type Extends System:Diagnostics:UnitTest
import System:Log

System:Collections:List MyList

Function Foo()
	MyList = System:Collections:List.Type()
	If (MyList)
		MyList.Add("One")
		MyList.Add("Two")
		MyList.Add("Three")
		Write(self, "[Factory] MyList contains '"+MyList.Count+"' elements..")
	Else
		Write(self, "[Factory] MyList is none.")
	EndIf
EndFunction


; Test Runner
;---------------------------------------------

Function Setup()
	WriteLine("System", self, "Setup")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine("System", self, "Executing the TestSuites function.")
;	Describe("New List", NewListSuite())
EndFunction


Function BeforeAll()
EndFunction


Function BeforeEach()
EndFunction


Function AfterEach()
EndFunction


Function AfterAll()
EndFunction
