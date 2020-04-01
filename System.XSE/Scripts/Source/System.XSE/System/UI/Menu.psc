ScriptName System:UI:Menu Extends System:Quest Native Const Hidden
{The base type for user interface menus.}
import System:Debug
import System:Exception


; IMenu
;---------------------------------------------

; The `IMenu` language interface must be implemented.
IMenu Function IMenu()
	Abstract(self, "IMenu", "The language interface must be implemented on a child class.")
EndFunction

Struct IMenu
	string Name = ""
	{The name of this menu.}

	string Variable = ""
	{The menu object variable with dot accessor.
	By default, this is ignored unless given a value.
	Some vanilla menus will use `".Menu_mc"`.
	Leave this empty if the menu object is the document class.}

	string Root = "root1"
	{The root display object is the top-level MovieClip that is not the stage.}

	System:UI:OpenCloseEvent OpenClose
	{A custom event delegate for the OpenClose event.}
EndStruct


; Properties
;---------------------------------------------

Group Properties
	string Property Name Hidden
		{The name of this menu.}
		string Function Get()
			return IMenu().Name
		EndFunction
	EndProperty

	string Property Variable Hidden
		{The menu instance variable with dot accessor. This is typically the same as root.}
		string Function Get()
			return IMenu().Variable
		EndFunction
	EndProperty

	string Property Root Hidden
		{The root display object is the top-level MovieClip that is not the stage.}
		string Function Get()
			return IMenu().Root
		EndFunction
	EndProperty

	bool Property IsRegistered Hidden
		{Returns true if this menu is registered.}
		bool Function Get()
			return UI.IsMenuRegistered(Name)
		EndFunction
	EndProperty

	bool Property IsOpen Hidden
		{Returns true if this menu is open.}
		bool Function Get()
			return UI.IsMenuOpen(Name)
		EndFunction
	EndProperty
EndGroup


; Methods
;---------------------------------------------

; Opens this menu.
bool Function Open()
	If (IsOpen)
		WriteUnexpected(self, "Open", "The menu is already open.", log="System")
		return true
	Else
		If (IsRegistered)
			return UI.OpenMenu(Name)
		Else
			ThrowInvalidOperation(self, "Open", "The menu is not registered.", log="System")
			return false
		EndIf
	EndIf
EndFunction


; Closes this menu.
bool Function Close()
	If (!IsOpen)
		WriteUnexpected(self, "Close", "The menu is already closed.", log="System")
		return true
	Else
		If (IsRegistered)
			return UI.CloseMenu(Name)
		Else
			ThrowInvalidOperation(self, "Close", "The menu is not registered.", log="System")
			return false
		EndIf
	EndIf
EndFunction


var Function Get(string member)
	{Gets a property member value. The return type must be cast.}
	If (IsOpen)
		If (member)
			return UI.Get(Name, GetMember(member))
		Else
			ThrowArgumentNoneEmpty(self, "Get", "member", log="System")
			return ""
		EndIf
	Else
		ThrowInvalidOperation(self, "Get", "The menu is not open.", log="System")
		return ""
	EndIf
EndFunction


bool Function Set(string member, var argument)
	{Sets a property member with the given argument.}
	If (IsOpen)
		If (member)
			return UI.Set(Name, GetMember(member), argument)
		Else
			ThrowArgumentNoneEmpty(self, "Set", "member", log="System")
			return ""
		EndIf
	Else
		ThrowInvalidOperation(self, "Set", "The menu is not open.", log="System")
		return ""
	EndIf
EndFunction


var Function Invoke(string member, var[] arguments = none)
	{Invokes a function member with the given arguments.}
	If (IsOpen)
		If (member)
			return UI.Invoke(Name, GetMember(member), arguments)
		Else
			ThrowArgumentNoneEmpty(self, "Invoke", "member", log="System")
			return ""
		EndIf
	Else
		ThrowInvalidOperation(self, "Invoke", "The menu is not open.", log="System")
		return ""
	EndIf
EndFunction


; Returns the full AS3 instance path for the given member name.
string Function GetMember(string member, string variable = "")
	If (member)
		If (variable)
			return variable+"."+member
		Else
			return Root+"."+member
		EndIf
	Else
		ThrowArgumentNoneEmpty(self, "GetMember", "member", log="System")
		return ""
	EndIf
EndFunction


; @overrides
string Function ToString()
	{The string representation of this type.}
	return IMenu()+"[IsRegistered:"+IsRegistered+", IsOpen:"+IsOpen+"]"
EndFunction
