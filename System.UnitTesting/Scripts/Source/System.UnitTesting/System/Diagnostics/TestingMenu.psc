ScriptName System:Diagnostics:TestingMenu Extends System:Diagnostics:Type
import System:Diagnostics:Console:MenuType

string Title = "Testing"
string OpenedState = "Opened" const


; Events
;---------------------------------------------

Event OnInit() ; TODO: This only happens once per object life time.
	Debug.TraceSelf(self, "OnInit", "")
	RegisterForQuestInit(QUST)
	RegisterForQuestShutdown(QUST)
EndEvent


Event OnQuestInit()
	Debug.TraceSelf(self, "OnQuestInit", "")
	RegisterForGameReload(self)
	OnGameReload()
EndEvent


Event OnGameReload()
	Debug.TraceSelf(self, "OnGameReload", "")
	Title = "Testing"
	RegisterForMenuOpenCloseEvent(ConsoleMenu.Name)
	RegisterForKey(Keyboard.Home)
	RegisterForKey(Keyboard.Mouse4)
	RegisterForKey(Keyboard.End)
	RegisterForKey(Keyboard.Delete)
EndEvent


Event OnKeyDown(int keyCode)
	If (UI.IsMenuOpen(ConsoleMenu.Name))
		return
	EndIf

	If (keyCode == Keyboard.Home || keyCode == Keyboard.Mouse4)
		ConsoleMenu.Open()
	EndIf
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	If (opening)
		GotoState(OpenedState)
	Else
		GotoState(EmptyState)
	EndIf
EndEvent


; States
;---------------------------------------------

State Opened
	Event OnBeginState(string oldState)
		Debug.TraceSelf(self, "Opened.OnBeginState", ConsoleMenu.Name)
	EndEvent

	Event OnKeyDown(int keyCode)
		If (keyCode == Keyboard.End)
			ConsoleMenu.Close()
		EndIf

		If (keyCode == Keyboard.Home || keyCode == Keyboard.Mouse4)
			ConsoleMenu.Load()
		EndIf

		If (keyCode == Keyboard.Delete)
			ConsoleMenu.Unload()
		EndIf
	EndEvent

	Event OnEndState(string newState)
		Debug.TraceSelf(self, "Opened.OnEndState", ConsoleMenu.Name)
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
