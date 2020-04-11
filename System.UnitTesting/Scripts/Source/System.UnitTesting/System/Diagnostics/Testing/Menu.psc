ScriptName System:Diagnostics:Testing:Menu Extends System:Diagnostics:Testing:MenuType
import System:Debug
import System:UI:OpenCloseEvent

IMenu IMenu_
ICustom ICustom_

string Title = "Testing"
string OpenedState = "Opened" const


; Properties
;---------------------------------------------

Group Implementation
	System:UI:OpenCloseEvent Property OpenClose Auto Const Mandatory
	{@IMenu}
EndGroup


; Interfaces
;---------------------------------------------

; @overrides
IMenu Function IMenu()
	return IMenu_
EndFunction


; @overrides
ICustom Function ICustom()
	return ICustom_
EndFunction


; Events
;---------------------------------------------

; TODO: This only happens once per object life time.
Event OnInit()
	RegisterForQuestInit(QUST)
	; RegisterForQuestShutdown(QUST)
EndEvent


Event OnQuestInit()
	RegisterForGameReload(self)
	IMenu_ = new IMenu
	IMenu_.Name = "SystemTestingMenu"
	IMenu_.Variable = ""
	IMenu_.OpenClose = OpenClose

	ICustom_ = new ICustom
	ICustom_.File = "TestingMenu"
	ICustom_.MenuFlags = FlagDoNotPreventGameSave
	ICustom_.ExtendedFlags = FlagNone
	OnGameReload()
EndEvent


Event OnGameReload()
	WriteLine(self, "OnGameReload", log="System")
	RegisterForMenuOpenCloseEvent(Name)
	RegisterForKey(Keyboard.Home)
	RegisterForKey(Keyboard.Mouse4)
	RegisterForKey(Keyboard.End)
	RegisterForKey(Keyboard.Delete)
	Title = "Testing"
	Register()
EndEvent


Event OnKeyDown(int keyCode)
	If (UI.IsMenuOpen("Console"))
		return
	EndIf

	If (keyCode == Keyboard.Home || keyCode == Keyboard.Mouse4)
		Open()
	EndIf
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	If (opening)
		GotoState(OpenedState)
	Else
		GotoState(EmptyState)
	EndIf
	OpenCloseEventArgs e = new OpenCloseEventArgs
	e.Opening = opening
	IMenu().OpenClose.Send(self, e)
EndEvent


; Data
;---------------------------------------------

Function ApplyData()
	UnitTestData[] data = GetData()
	var[] arguments = new var[0]
	int index = 0
	While (index < data.Length)
		arguments.Add(data[index])
		Debug.TraceSelf(self, "Allocating: ", data[index])
		index += 1
	EndWhile
	SetData(arguments)
EndFunction


UnitTestData[] Function GetData()
	UnitTestData[] data = new UnitTestData[0]

	UnitTestData unitTest1 = new UnitTestData
	unitTest1.Name = "Hello World! Test 1"
	unitTest1.Description = "The dummy unit test #1."
	data.Add(unitTest1)

	UnitTestData unitTest2 = new UnitTestData
	unitTest2.Name = "Hello World! Test 2"
	unitTest2.Description = "The dummy unit test #2."
	data.Add(unitTest2)

	UnitTestData unitTest3 = new UnitTestData
	unitTest3.Name = "Hello World! Test 3"
	unitTest3.Description = "The dummy unit test #3."
	data.Add(unitTest3)

	UnitTestData unitTest4 = new UnitTestData
	unitTest4.Name = "Test 4"
	unitTest4.Description = "The dummy unit test #4."
	data.Add(unitTest4)

	UnitTestData unitTest5 = new UnitTestData
	unitTest5.Name = "Test 5"
	unitTest5.Description = "The dummy unit test #5."
	data.Add(unitTest5)

	UnitTestData unitTest6 = new UnitTestData
	unitTest6.Name = "Test 6"
	unitTest6.Description = "The dummy unit test #6."
	data.Add(unitTest6)

	UnitTestData unitTest7 = new UnitTestData
	unitTest7.Name = "Test 7"
	unitTest7.Description = "The dummy unit test #7."
	data.Add(unitTest7)

	UnitTestData unitTest8 = new UnitTestData
	unitTest8.Name = "Test 8"
	unitTest8.Description = "The dummy unit test #8."
	data.Add(unitTest8)

	UnitTestData unitTest9 = new UnitTestData
	unitTest9.Name = "Test 9"
	unitTest9.Description = "The dummy unit test #9."
	data.Add(unitTest9)

	UnitTestData unitTest10 = new UnitTestData
	unitTest10.Name = "Test 10"
	unitTest10.Description = "The dummy unit test #10."
	data.Add(unitTest10)

	UnitTestData unitTest11 = new UnitTestData
	unitTest11.Name = "Test 11"
	unitTest11.Description = "The dummy unit test #11."
	data.Add(unitTest11)

	UnitTestData unitTest12 = new UnitTestData
	unitTest12.Name = "Test 12"
	unitTest12.Description = "The dummy unit test #12."
	data.Add(unitTest12)

	UnitTestData unitTest13 = new UnitTestData
	unitTest13.Name = "Test 13"
	unitTest13.Description = "The dummy unit test #13."
	data.Add(unitTest13)

	UnitTestData unitTest14 = new UnitTestData
	unitTest14.Name = "Test 14"
	unitTest14.Description = "The dummy unit test #14."
	data.Add(unitTest14)

	UnitTestData unitTest15 = new UnitTestData
	unitTest15.Name = "Test 15"
	unitTest15.Description = "The dummy unit test #15."
	data.Add(unitTest15)

	UnitTestData unitTest16 = new UnitTestData
	unitTest16.Name = "Test 16"
	unitTest16.Description = "The dummy unit test #16."
	data.Add(unitTest16)

	return data
EndFunction


Function SetData(var[] data)
	string setDataMember = Root+".Panel.SetData"
	UI.Invoke(Name, setDataMember, data)
	Debug.TraceSelf(self, "SetData", Name+"::"+setDataMember)
EndFunction


; Methods
;---------------------------------------------

System:Diagnostics:Testing:Menu Function GetSelf() Global
	return Game.GetFormFromFile(0x00000F99, "System.UnitTesting.esp") as System:Diagnostics:Testing:Menu
EndFunction


; States
;---------------------------------------------

State Opened
	Event OnBeginState(string oldState)
		Debug.TraceSelf(self, "Opened.OnBeginState", Name)
		ApplyData()
	EndEvent

	Event OnKeyDown(int keyCode)
		If (keyCode == Keyboard.End)
			Close()
		EndIf

		If (keyCode == Keyboard.Home || keyCode == Keyboard.Mouse4)
		EndIf

		If (keyCode == Keyboard.Delete)
		EndIf
	EndEvent

	Event OnEndState(string newState)
		Debug.TraceSelf(self, "Opened.OnEndState", Name)
	EndEvent
EndState



; Properties
;---------------------------------------------

Group System
	System:Input Property Keyboard Auto Const Mandatory
EndGroup
