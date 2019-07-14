ScriptName System:UI:Menu Extends System:Quest Native Const Hidden
import System:Exception
import System:Log


; Properties
;---------------------------------------------

Group Properties
	string Property Name Hidden
		{@abstract
		The name of this menu.}
		string Function Get()
			return GetName()
		EndFunction
	EndProperty

	string Property File Hidden
		{@abstract
		The swf file path of this menu without the file extension.
		The root directory is relative to `Data\Interface`.}
		string Function Get()
			return GetFile()
		EndFunction
	EndProperty

	string Property Instance Hidden
		{@virtual
		The menu instance variable with dot accessor. This is typically the same as root.}
		string Function Get()
			return Root+GetInstance()
		EndFunction
	EndProperty

	string Property Root Hidden
		{@virtual
		The root display object is the top-level MovieClip that is not the stage.}
		string Function Get()
			return GetRoot()
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

; @abstract
; The name of this menu.
string Function GetName()
	{Property}
	Abstract(self, "GetName")
	return ""
EndFunction


; @abstract
; The swf file path of this menu without the file extension.
; The root directory is relative to `Data\Interface`.
string Function GetFile()
	{Property}
	Abstract(self, "GetFile")
	return ""
EndFunction


; @virtual
; The menu instance variable with dot accessor. This is typically the same as root.
string Function GetInstance()
	{Property}
	return ""
EndFunction


; @virtual
; The root display object is the top-level MovieClip that is not the stage.
string Function GetRoot()
	{Property}
	return "root1"
EndFunction

;---------------------------------------------

; Opens this menu.
bool Function Open()
	If (IsRegistered)
		return UI.OpenMenu(Name)
	Else
		WriteUnexpected("System", ToString(), "Open", "The menu is not registered.")
		return false
	EndIf
EndFunction

; Closes this menu.
bool Function Close()
	If (IsRegistered)
		return UI.CloseMenu(Name)
	Else
		WriteUnexpected("System", ToString(), "Close", "The menu is not registered.")
		return false
	EndIf
EndFunction


; bool Function Open()
; 	If (IsOpen)
; 		WriteUnexpected("System", self, "Open", ToString()+" is already open.")
; 		return true
; 	Else
; 		If (IsRegistered)
; 			return UI.OpenMenu(Name)
; 		Else
; 			WriteUnexpected("System", self, "Open", ToString()+" is not registered.")
; 			return false
; 		EndIf
; 	EndIf
; EndFunction


; bool Function Close()
; 	If (!IsOpen)
; 		WriteUnexpected("System", self, "Close", ToString()+" is already closed.")
; 		return true
; 	Else
; 		If (IsRegistered)
; 			return UI.CloseMenu(Name)
; 		Else
; 			WriteUnexpected("System", self, "Close", ToString()+" is not registered.")
; 			return false
; 		EndIf
; 	EndIf
; EndFunction


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
; TODO: Maybe dont check for IsOpen, only handle static string concate.
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


; Below is from visor menu. Should I even check for IsOpen?

; string Function GetMember(string member)
; 	If !(member)
; 		WriteUnexpectedValue("System", self, "GetMember", "member", "The value cannot be none or empty.")
; 		return ""
; 	ElseIf !(Root)
; 		WriteUnexpectedValue("System", self, "GetMember", "Root", "The value cannot be none or empty.")
; 		return ""
; 	Else
; 		return Root+"."+member
; 	EndIf
; EndFunction


; @overrides
string Function ToString()
	{The string representation of this type.}
	return "[Name:"+Name+", File:"+File+"]"
EndFunction
