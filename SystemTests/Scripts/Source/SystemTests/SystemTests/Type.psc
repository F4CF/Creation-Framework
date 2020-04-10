ScriptName SystemTests:Type Extends System:Diagnostics:UnitTest
import System:Debug

System:Collections:List MyList

Function Foo()
	MyList = System:Collections:List.Type()
	If (MyList)
		MyList.Add("One")
		MyList.Add("Two")
		MyList.Add("Three")
		WriteLine(self, "Foo", "[Factory] MyList contains '"+MyList.Count+"' elements..")
	Else
		WriteLine(self, "Foo", "[Factory] MyList is none.")
	EndIf
EndFunction


; Test Runner
;---------------------------------------------

Function Setup()
	WriteLine(self, "Setup")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine(self, "System", "Executing the TestSuites function.")
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
