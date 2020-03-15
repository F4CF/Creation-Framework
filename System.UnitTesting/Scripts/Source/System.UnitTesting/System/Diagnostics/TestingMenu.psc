ScriptName System:Diagnostics:TestingMenu Extends System:Diagnostics:Type
import System:Diagnostics:Console:MenuType

string Title = "Testing"
UnitTestData[] Data

string BusyState = "Busy" const


; Events
;---------------------------------------------

Event OnInit() ; TODO: This only happens once per object life time.
	Debug.TraceSelf(self, "OnInit", "Called..")
	RegisterForQuestInit(QUST)
	RegisterForQuestShutdown(QUST)
EndEvent


Event OnQuestInit()
	Debug.TraceSelf(self, "OnQuestInit", "Called..")
	RegisterForGameReload(self)
	OnGameReload()
EndEvent


Event OnGameReload()
	Debug.TraceSelf(self, "OnGameReload", "Called..")
	Title = "Testing"
	Data = new UnitTestData[0]

	UnitTestData unitTest1 = new UnitTestData
	unitTest1.Name = "Test 1"
	unitTest1.Description = "The dummy unit test number 1."
	Data.Add(unitTest1)

	UnitTestData unitTest2 = new UnitTestData
	unitTest2.Name = "Test 2"
	unitTest2.Description = "The dummy unit test number 2."
	Data.Add(unitTest2)

	UnitTestData unitTest3 = new UnitTestData
	unitTest3.Name = "Test 3"
	unitTest3.Description = "The dummy unit test number 3."
	Data.Add(unitTest3)

	UnitTestData unitTest4 = new UnitTestData
	unitTest4.Name = "Test 4"
	unitTest4.Description = "The dummy unit test number 4."
	Data.Add(unitTest4)

	UnitTestData unitTest5 = new UnitTestData
	unitTest5.Name = "Test 5"
	unitTest5.Description = "The dummy unit test number 5."
	Data.Add(unitTest5)

	UnitTestData unitTest6 = new UnitTestData
	unitTest6.Name = "Test 6"
	unitTest6.Description = "The dummy unit test number 6."
	Data.Add(unitTest6)

	UnitTestData unitTest7 = new UnitTestData
	unitTest7.Name = "Test 7"
	unitTest7.Description = "The dummy unit test number 7."
	Data.Add(unitTest7)

	UnitTestData unitTest8 = new UnitTestData
	unitTest8.Name = "Test 8"
	unitTest8.Description = "The dummy unit test number 8."
	Data.Add(unitTest8)

	UnitTestData unitTest9 = new UnitTestData
	unitTest9.Name = "Test 9"
	unitTest9.Description = "The dummy unit test number 9."
	Data.Add(unitTest9)

	UnitTestData unitTest10 = new UnitTestData
	unitTest10.Name = "Test 10"
	unitTest10.Description = "The dummy unit test number 10."
	Data.Add(unitTest10)

	UnitTestData unitTest11 = new UnitTestData
	unitTest11.Name = "Test 11"
	unitTest11.Description = "The dummy unit test number 11."
	Data.Add(unitTest11)

	UnitTestData unitTest12 = new UnitTestData
	unitTest12.Name = "Test 12"
	unitTest12.Description = "The dummy unit test number 12."
	Data.Add(unitTest12)

	UnitTestData unitTest13 = new UnitTestData
	unitTest13.Name = "Test 13"
	unitTest13.Description = "The dummy unit test number 13."
	Data.Add(unitTest13)

	UnitTestData unitTest14 = new UnitTestData
	unitTest14.Name = "Test 14"
	unitTest14.Description = "The dummy unit test number 14."
	Data.Add(unitTest14)

	UnitTestData unitTest15 = new UnitTestData
	unitTest15.Name = "Test 15"
	unitTest15.Description = "The dummy unit test number 15."
	Data.Add(unitTest15)

	UnitTestData unitTest16 = new UnitTestData
	unitTest16.Name = "Test 16"
	unitTest16.Description = "The dummy unit test number 16."
	Data.Add(unitTest16)

	RegisterForMenuOpenCloseEvent(ConsoleMenu.Name)

	RegisterForKey(Keyboard.Home)
	RegisterForKey(Keyboard.Mouse4)
	RegisterForKey(Keyboard.End)
EndEvent


Event OnKeyDown(int keyCode)
	If (UI.IsMenuOpen(ConsoleMenu.Name))
		return
	EndIf

	If (keyCode == Keyboard.Home || keyCode == Keyboard.Mouse4)
		ConsoleMenu.Open()
	EndIf
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	If (abOpening)
		GotoState(BusyState)
	Else
		GotoState(EmptyState)
	EndIf
EndEvent


; States
;---------------------------------------------

State Busy
	Event OnBeginState(string oldState)
		Debug.TraceSelf(self, "Busy.OnBeginState", ConsoleMenu.Name)
	EndEvent

	Event OnKeyDown(int keyCode)
		If (keyCode == Keyboard.End)
			ConsoleMenu.Close()
		EndIf
	EndEvent

	Event OnEndState(string newState)
		Debug.TraceSelf(self, "Busy.OnEndState", ConsoleMenu.Name)
		Title = "Testing"
		Data = new UnitTestData[0]
	EndEvent
EndState


; Methods
;---------------------------------------------

System:Diagnostics:TestingMenu Function Get() Global
	return Game.GetFormFromFile(0x00000F99, "System.UnitTesting.esp") as System:Diagnostics:TestingMenu
EndFunction


string Function ToString()
	{The string representation of this type.}
	return "[System:Diagnostics:TestingMenu] " + Title
EndFunction


; Properties
;---------------------------------------------

Group System
	System:Input Property Keyboard Auto Const Mandatory
EndGroup

Group Properties
	System:Diagnostics:Console:Menu Property ConsoleMenu Auto Const Mandatory
EndGroup
