ScriptName System:Menus:MenuType Extends System:Type Native Const Hidden
import System:Exception
import System:Log

; Abstract
;---------------------------------------------

string Function GetName()
	{Property}
	NotImplemented(self, "GetName", "This member must be overridden with an extending script.")
	return ""
EndFunction


string Function GetFile()
	{Property}
	NotImplemented(self, "GetFile", "This member must be overridden with an extending script.")
	return ""
EndFunction


; Virtual
;---------------------------------------------

string Function GetInstance()
	{Property}
	return ""
EndFunction


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

; TODO: check args and conditions
var Function Get(string member)
	{Gets a property member value. The return type must be cast.}
	return UI.Get(Name, GetMember(member))
EndFunction

; TODO: check args and conditions
bool Function Set(string member, var argument)
	{Sets a property member with the given argument.}
	return UI.Set(Name, GetMember(member), argument)
EndFunction

; TODO: check args and conditions
var Function Invoke(string member, var[] arguments = none)
	{Invokes a function member with the given arguments.}
	return UI.Invoke(Name, GetMember(member), arguments)
EndFunction


string Function GetMember(string member, string variable = "")
	If (IsOpen)
		If (member)
			If (variable)
				return variable+"."+member
			Else
				return Root+"."+member
			EndIf
		Else
			WriteUnexpectedValue(self, "GetMember", "member", "The argument cannot be none or empty.")
			return ""
		EndIf
	Else
		WriteUnexpected(self, "GetMember", ToString()+" is not open.")
		return ""
	EndIf
EndFunction


string Function ToString()
	{The string representation of this type.}
	return "[Name:"+Name+", File:"+File+"]"
EndFunction


; Properties
;---------------------------------------------

Group Properties
	string Property Name Hidden
		{The name of this menu.}
		string Function Get()
			return GetName()
		EndFunction
	EndProperty

	string Property File Hidden
		{The swf file path of this menu without the file extension.
		The root directory is relative to `Data\Interface`.}
		string Function Get()
			return GetFile()
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

	string Property Instance Hidden
		string Function Get()
			{The menu instance variable. This is typically the same as root.}
			return Root+GetInstance()
		EndFunction
	EndProperty

	string Property Root Hidden
		{The root display object is the top-level MovieClip that is not the stage.}
		string Function Get()
			return "root1"
		EndFunction
	EndProperty
EndGroup
