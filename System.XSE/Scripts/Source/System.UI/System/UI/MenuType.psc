ScriptName System:UI:MenuType Extends System:Quest Native Const Hidden
import System:Exception
import System:Log

; Abstract
;---------------------------------------------

string Function GetName()
	{Property}
	ThrowNotImplemented(self, "GetName", "This member must be overridden with an extending script.")
	return ""
EndFunction


string Function GetFile()
	{Property}
	ThrowNotImplemented(self, "GetFile", "This member must be overridden with an extending script.")
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
		WriteUnexpected("System", ToString(), "Open", "The menu is not registered.")
		return false
	EndIf
EndFunction


bool Function Close()
	If (IsRegistered)
		return UI.CloseMenu(Name)
	Else
		WriteUnexpected("System", ToString(), "Close", "The menu is not registered.")
		return false
	EndIf
EndFunction


var Function Get(string member)
	{Gets a property member value. The return type must be cast.}
	If (IsOpen)
		If (member)
			return UI.Get(Name, GetMember(member))
		Else
			WriteUnexpectedValue("System", self, "GetMember", "member", "The argument cannot be none or empty.")
			return ""
		EndIf
	Else
		WriteUnexpected("System", self, "GetMember", ToString()+" is not open.")
		return ""
	EndIf
EndFunction


bool Function Set(string member, var argument)
	{Sets a property member with the given argument.}
	If (IsOpen)
		If (member)
			return UI.Set(Name, GetMember(member), argument)
		Else
			WriteUnexpectedValue(self, "GetMember", "member", "The argument cannot be none or empty.")
			return ""
		EndIf
	Else
		WriteUnexpected("System", self, "GetMember", ToString()+" is not open.")
		return ""
	EndIf
EndFunction


var Function Invoke(string member, var[] arguments = none)
	{Invokes a function member with the given arguments.}
	If (IsOpen)
		If (member)
			return UI.Invoke(Name, GetMember(member), arguments)
		Else
			WriteUnexpectedValue("System", self, "GetMember", "member", "The argument cannot be none or empty.")
			return ""
		EndIf
	Else
		WriteUnexpected("System", self, "GetMember", ToString()+" is not open.")
		return ""
	EndIf
EndFunction


; Returns the full AS3 instance path for the given member name.
string Function GetMember(string member, string variable = "")
	If (IsOpen)
		If (member)
			If (variable)
				return variable+"."+member
			Else
				return Root+"."+member
			EndIf
		Else
			WriteUnexpectedValue("System", self, "GetMember", "member", "The argument cannot be none or empty.")
			return ""
		EndIf
	Else
		WriteUnexpected("System", self, "GetMember", ToString()+" is not open.")
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
