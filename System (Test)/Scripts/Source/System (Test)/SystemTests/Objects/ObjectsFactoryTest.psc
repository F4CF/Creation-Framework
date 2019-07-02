ScriptName SystemTests:Objects:ObjectsFactoryTest Extends System:Diagnostics:Lilac
import System:Collections
import System:Log


System:Collections:List MyList


; Lilac
;---------------------------------------------


Function Setup()
	WriteLine("SystemTests:Objects:ObjectsFactoryTest", "Setup")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine("SystemTests:Objects:ObjectsFactoryTest", "Executing the TestSuites function.")
;	describe("New List", NewListSuite())
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
		Write("Scripting", "[Factory] MyList contains '"+MyList.Count+"' elements..")
	Else
		Write("Scripting", "[Factory] MyList is none.")
	EndIf
EndFunction
