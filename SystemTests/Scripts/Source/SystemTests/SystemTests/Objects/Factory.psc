ScriptName SystemTests:Objects:Factory Extends System:Diagnostics:UnitTest
import System:Log

System:Collections:List MyList


; Test Runner
;---------------------------------------------

Function Setup()
	WriteLine(self, "Setup")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine(self, "Executing the TestSuites function.")
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


Function Foo()
	MyList = System:Collections:List.Init()
	If (MyList)
		MyList.Add("One")
		MyList.Add("Two")
		MyList.Add("Three")
		Write(self, "[Factory] MyList contains '"+MyList.Count+"' elements..")
	Else
		Write(self, "[Factory] MyList is none.")
	EndIf
EndFunction
