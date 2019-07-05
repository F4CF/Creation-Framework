ScriptName System:UI:ButtonMenu Extends System:UI:CustomType Default
import System
import System:Log
import System:Script

Button[] Buttons
Button SelectedButton
CustomEvent OnShown
CustomEvent OnSelected

bool AutoHide = false

Struct Button
	string Text = ""
	{The button text label.}
	int KeyCode = -1
	{The keyboard scancode.}
EndStruct


; Events
;---------------------------------------------

Event OnQuestInit()
	OnGameReload()
	RegisterForGameReload(self)
EndEvent


Event OnQuestShutdown()
	UnregisterForGameReload(self)
EndEvent


Event OnGameReload()
	Buttons = new Button[0]
	Register()
EndEvent



; Display
;---------------------------------------------

bool Function Show()
	{Begin the shown state.}
	return AwaitState(self, "Shown")
EndFunction


bool Function Hide()
	{End any running state.}
	return ClearState(self)
EndFunction


; States
;---------------------------------------------

State Shown
	Event OnBeginState(string oldState)
		If (Open())
			If (Buttons)
				var[] arguments = new var[0]
				int index = 0
				While (index < Buttons.Length)
					arguments.Add(Buttons[index])
					RegisterForKey(Buttons[index].KeyCode)
					index += 1
				EndWhile

				string member = GetMember("SetButtons")
				UI.Invoke(Name, member, arguments)

				ShownEventArgs e = new ShownEventArgs
				e.Showing = true
				var[] shownArguments = new var[1]
				shownArguments[0] = e
				SendCustomEvent("OnShown", shownArguments)

				WriteLine(ToString(), "Showing button press hints. Invoke:"+member+"("+arguments+") @"+Name)
			Else
				WriteUnexpectedValue(ToString(), "Shown.OnBeginState", "Buttons", "The button array is none or empty.")
				ClearState(self)
			EndIf
		Else
			WriteUnexpected(ToString(), "Shown.OnBeginState", "Could not open menu for '"+GetState()+"' state.")
			ClearState(self)
		EndIf
	EndEvent


	Event OnKeyDown(int keyCode)
		If (!UI.IsMenuOpen("Console"))
			SelectedButton = Buttons[FindByKeyCode(keyCode)]

			var[] arguments = new var[1]
			arguments[0] = SelectedButton
			SendCustomEvent("OnSelected", arguments)

			If (AutoHide)
				WriteLine(ToString(), "The '"+SelectedButton.Text+"' button was selected. Automatically hiding for select once.")
				ClearState(self)
			Else
				WriteLine(ToString(), "The '"+SelectedButton.Text+"' button was selected.")
			EndIf
		Else
			WriteUnexpected(ToString(), "Shown.OnKeyDown", "Ignoring the "+keyCode+" key press for the developer console menu.")
		EndIf
	EndEvent


	bool Function Show()
		{EMPTY}
		System:Exception.NotImplemented(ToString(), "Shown.Show", "Not implemented in the '"+GetState()+"' state.")
		return false
	EndFunction


	bool Function Add(Button value)
		{EMPTY}
		System:Exception.NotImplemented(ToString(), "Shown.Add", "Not implemented in the '"+GetState()+"' state.")
		return false
	EndFunction


	bool Function Remove(Button value)
		{EMPTY}
		System:Exception.NotImplemented(ToString(), "Shown.Remove", "Not implemented in the '"+GetState()+"' state.")
		return false
	EndFunction


	bool Function Clear()
		{EMPTY}
		System:Exception.NotImplemented(ToString(), "Shown.Clear", "Not implemented in the '"+GetState()+"' state.")
		return false
	EndFunction


	Event OnEndState(string newState)
		WriteLine(ToString(), "Ending the '"+GetState()+"' state.")
		Close()

		int index = 0
		While (index < Buttons.Length)
			UnregisterForKey(Buttons[index].KeyCode)
			index += 1
		EndWhile

		ShownEventArgs e = new ShownEventArgs
		e.Showing = false
		var[] arguments = new var[1]
		arguments[0] = e
		SendCustomEvent("OnShown", arguments)
	EndEvent
EndState


; Methods
;---------------------------------------------

bool Function Add(Button value)
	{Adds a button to the collection.}
	If (value)
		If (Contains(value) == false)
			If (ContainsKeyCode(value.KeyCode) == false)
				Buttons.Add(value)
				return true
			Else
				WriteUnexpected(ToString(), "Add", "The button array already contains a button with key code '"+value.KeyCode+"'.")
				return false
			EndIf
		Else
			WriteUnexpected(ToString(), "Add", "The button array already contains '"+value+"'.")
			return false
		EndIf
	Else
		WriteUnexpectedValue(ToString(), "Add", "value", "Cannot add a none value to button array.")
		return false
	EndIf
EndFunction


bool Function Remove(Button value)
	{Removes the first occurrence of a button from the collection.}
	If (value)
		If (Contains(value))
			Buttons.Remove(IndexOf(value))
			return true
		Else
			WriteUnexpected(ToString(), "Remove", "The button array does not contain '"+value+"'.")
			return false
		EndIf
	Else
		WriteUnexpectedValue(ToString(), "Remove", "value", "Cannot remove a none value from button array.")
		return false
	EndIf
EndFunction


bool Function Clear()
	{Clears all buttons from the collection.}
	SelectedButton = none
	If (Buttons.Length > 0)
		Buttons.Clear()
		return true
	Else
		WriteUnexpected(ToString(), "Clear", "The button array is already cleared.")
		return false
	EndIf
EndFunction


int Function FindByKeyCode(int value)
	{Determines the index of a button with the given key code.}
	return Buttons.FindStruct("KeyCode", value)
EndFunction


bool Function ContainsKeyCode(int value)
	{Determines whether a button with the given key code is in the collection.}
	return FindByKeyCode(value) > Invalid
EndFunction


bool Function Contains(Button value)
	{Determines whether a button is in the collection.}
	return IndexOf(value) > Invalid
EndFunction


int Function IndexOf(Button value)
	{Determines the index of a specific button in the collection.}
	If (value)
		return Buttons.Find(value)
	Else
		return Invalid
	EndIf
EndFunction

;---------------------------------------------

bool Function RegisterForSelectedEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OnSelected")
		return true
	Else
		WriteUnexpectedValue(ToString(), "RegisterForSelectedEvent", "script", "Cannot register a none script for selection events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForSelectedEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OnSelected")
		return true
	Else
		WriteUnexpectedValue(ToString(), "UnregisterForSelectedEvent", "script", "Cannot register a none script for selection events.")
		return false
	EndIf
EndFunction


Button Function GetSelectedEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as Button
	Else
		WriteUnexpectedValue(ToString(), "GetSelectedEventArgs", "arguments", "The selection event arguments are empty or none.")
		return none
	EndIf
EndFunction

;---------------------------------------------

Struct ShownEventArgs
	bool Showing = false
EndStruct


bool Function RegisterForShownEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OnShown")
		return true
	Else
		WriteUnexpectedValue(ToString(), "RegisterForShownEvent", "script", "Cannot register a none script for shown events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForShownEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OnShown")
		return true
	Else
		WriteUnexpectedValue(ToString(), "UnregisterForShownEvent", "script", "Cannot register a none script for shown events.")
		return false
	EndIf
EndFunction


ShownEventArgs Function GetShownEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as ShownEventArgs
	Else
		WriteUnexpectedValue(ToString(), "GetShownEventArgs", "arguments", "The shown event arguments are empty or none.")
		return none
	EndIf
EndFunction


; Properties
;---------------------------------------------

; @overrides
string Function GetName()
	return "SystemButtonMenu"
EndFunction

; @overrides
string Function GetFile()
	return "SystemButtonMenu"
EndFunction

; @overrides
string Function GetInstance()
	return ".Menu"
EndFunction

; @overrides
UI:MenuData Function GetInitialization()
	UI:MenuData value = new UI:MenuData
	value.MenuFlags = FlagNone
	value.ExtendedFlags = FlagInheritColors + FlagCheckForGamepad
	return value
EndFunction

Group ButtonHint
	int Property Count Hidden
		int Function Get()
			return Buttons.Length
		EndFunction
	EndProperty

	Button Property Selected Hidden
		Button Function Get()
			return SelectedButton
		EndFunction
	EndProperty

	bool Property SelectOnce Hidden
		bool Function Get()
			return AutoHide
		EndFunction
		Function Set(bool value)
			AutoHide = value
		EndFunction
	EndProperty
EndGroup
