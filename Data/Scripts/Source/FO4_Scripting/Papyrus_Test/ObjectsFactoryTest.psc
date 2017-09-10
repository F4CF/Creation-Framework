Scriptname Papyrus_Test:ObjectsFactoryTest extends Papyrus_Test:Framework:Lilac
import Papyrus:Collections
import Papyrus:Diagnostics:Log


UserLog Log
List MyList


; Events
;---------------------------------------------

Event OnInit()
	Log = LogNew(Common.LogFile, self)
	parent.OnInit()
EndEvent


; Lilac
;---------------------------------------------


Function Setup()
	WriteLine(Log, "Setup")
	EnableVerboseLogging()
EndFunction


Function TestSuites()
	WriteLine(Log, "Executing the TestSuites function.")
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
		Write("Scripting", "[Factory] MyList contains '"+MyList.Count+"' elements..")
	Else
		Write("Scripting", "[Factory] MyList is none.")
	EndIf
EndFunction
