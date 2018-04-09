Scriptname ScriptingTest:PapyrusObjectsFactoryTest extends ScriptingTest:Framework:Lilac
import Papyrus:Collections
import Papyrus:Log

List MyList


; Lilac
;---------------------------------------------

Function Setup()
	WriteLine(self, "Setup")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine(self, "Executing the TestSuites function.")
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
	MyList = Papyrus:Collections:List.Init()
	If (MyList)
		MyList.Add("One")
		MyList.Add("Two")
		MyList.Add("Three")
		WriteLine(self, "[Factory] MyList contains '"+MyList.Count+"' elements..")
	Else
		WriteLine(self, "[Factory] MyList is none.")
	EndIf
EndFunction
