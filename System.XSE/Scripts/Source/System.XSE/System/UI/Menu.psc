ScriptName System:UI:Menu Extends System:Quest Native Const Hidden
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
	Some vanilla menus will use `".Menu_mc"`.}

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
		WriteUnexpected(self, "Open", "The menu is already open. "+ToString(), log="System")
		return true
	Else
		If (IsRegistered)
			return UI.OpenMenu(Name)
		Else
			WriteUnexpected(self, "Open", "The menu is not registered. "+ToString(), log="System")
			return false
		EndIf
	EndIf
EndFunction


; Closes this menu.
bool Function Close()
	If (!IsOpen)
		WriteUnexpected(self, "Close", "The menu is already closed. "+ToString(), log="System")
		return true
	Else
		If (IsRegistered)
			return UI.CloseMenu(Name)
		Else
			WriteUnexpected(self, "Close", "The menu is not registered. "+ToString(), log="System")
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
			WriteUnexpectedValue(self, "GetMember", "member", "The argument cannot be none or empty. "+ToString(), log="System")
			return ""
		EndIf
	Else
		WriteUnexpected(self, "GetMember", "The menu is not open. "+ToString(), log="System")
		return ""
	EndIf
EndFunction


bool Function Set(string member, var argument)
	{Sets a property member with the given argument.}
	If (IsOpen)
		If (member)
			return UI.Set(Name, GetMember(member), argument)
		Else
			WriteUnexpectedValue(self, "Set", "member", "The argument cannot be none or empty. "+ToString(), log="System")
			return ""
		EndIf
	Else
		WriteUnexpected(self, "Set", "The menu is not open. "+ToString(), log="System")
		return ""
	EndIf
EndFunction


var Function Invoke(string member, var[] arguments = none)
	{Invokes a function member with the given arguments.}
	If (IsOpen)
		If (member)
			return UI.Invoke(Name, GetMember(member), arguments)
		Else
			WriteUnexpectedValue(self, "Invoke", "member", "The argument cannot be none or empty. "+ToString(), log="System")
			return ""
		EndIf
	Else
		WriteUnexpected(self, "Invoke", "The menu is not open. "+ToString(), log="System")
		return ""
	EndIf
EndFunction


; Returns the full AS3 instance path for the given member name.
; TODO:Maybe dont check for IsOpen, only handle static string concate.
string Function GetMember(string member, string variable = "")
	If (IsOpen)
		If (member)
			If (variable)
				return variable+"."+member
			Else
				return Root+"."+member
			EndIf
		Else
			WriteUnexpectedValue(self, "GetMember", "member", "The argument cannot be none or empty. "+ToString(), log="System")
			return ""
		EndIf
	Else
		WriteUnexpected(self, "GetMember", "The menu is not open. "+ToString(), log="System")
		return ""
	EndIf
EndFunction


; @overrides
string Function ToString()
	{The string representation of this type.}
	return IMenu()+"[IsRegistered:"+IsRegistered+", IsOpen:"+IsOpen+"]"
EndFunction
