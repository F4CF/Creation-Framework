ScriptName System:Menus:Examine:Menu Extends System:Type
{Injects AS3 code into the vanilla Examine menu.}
import System:Log

; TODO: The instance paths are screwed up from the refactor. Fix `GetMember`.

; Events
;---------------------------------------------

; Methods
;---------------------------------------------

bool Function Open()
	If (IsRegistered)
		return UI.OpenMenu(Name)
	Else
		WriteUnexpected(ToString(), "Open", "The menu is not registered.")
		return false
	EndIf
EndFunction


bool Function Close()
	If (IsRegistered)
		return UI.CloseMenu(Name)
	Else
		WriteUnexpected(ToString(), "Close", "The menu is not registered.")
		return false
	EndIf
EndFunction


string Function GetMember(string member)
	If (member)
		return Instance+"."+member
	Else
		WriteUnexpectedValue(ToString(), "GetMember", "member", "The value cannot be none or empty.")
		return none
	EndIf
EndFunction


string Function ToString()
	{The string representation of this type.}
	return parent.ToString()+"[Name:"+Name+", Root:"+Root+"]"
EndFunction


; Properties
;---------------------------------------------

Group Display
	string Property Name Hidden
		{The name of the menu to load within.}
		string Function Get()
			return "ExamineMenu"
		EndFunction
	EndProperty

	string Property Root Hidden
		{The root display object.}
		string Function Get()
			return "root1"
		EndFunction
	EndProperty

	string Property Instance Hidden
		{The menu's base instance variable.}
		string Function Get()
			return Root+".BaseInstance"
		EndFunction
	EndProperty

	bool Property IsRegistered Hidden
		bool Function Get()
			{Returns true if this menu is registered.}
			return UI.IsMenuRegistered(Name)
		EndFunction
	EndProperty

	bool Property IsOpen Hidden
		bool Function Get()
			{Returns true if this menu is open.}
			return UI.IsMenuOpen(Name)
		EndFunction
	EndProperty
EndGroup
