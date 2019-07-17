Scriptname System:UI:MenuCustom extends System:UI:Menu Hidden Native Const
{A base script for custom menu types.}
import System:Log


; Properties
;---------------------------------------------

Group Properties
	UI:MenuData Property Flags Hidden
		{@virtual}
		UI:MenuData Function Get()
			return GetFlags()
		EndFunction
	EndProperty
EndGroup

Group MenuFlags
	int Property FlagNone = 0x0 AutoReadOnly
	int Property FlagPauseGame = 0x01 AutoReadOnly
	int Property FlagShowCursor = 0x04 AutoReadOnly
	int Property FlagEnableMenuControl = 0x08 AutoReadOnly
	int Property FlagDoNotPreventGameSave = 0x800 AutoReadOnly
EndGroup

Group ExtendedFlags
	; If you set extendedFlags & 2, it will disable your ShowCursor if the Gamepad is enabled
	int Property FlagInheritColors = 1 AutoReadOnly
	int Property FlagCheckForGamepad = 2 AutoReadOnly
EndGroup


; Methods
;---------------------------------------------

; @virtual
UI:MenuData Function GetFlags()
	{Property}
	return new UI:MenuData
EndFunction


bool Function Register()
	If (UI.RegisterCustomMenu(Name, File, Root, Flags))
		WriteLine("System", self, "Register", ToString()+":Registered as a custom menu.")
		return true
	Else
		System:Debug.WriteUnexpected("System", self, "Register", ToString()+":Failed to register as a custom menu.")
		return false
	EndIf
EndFunction


bool Function GetVisible()
	If (IsOpen)
		return UI.Get(Name, GetMember("Visible")) as bool
	Else
		System:Debug.WriteUnexpected("System", self, "GetVisible", ToString()+":The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetVisible(bool value)
	If (IsOpen)
		WriteLine("System", self, ToString()+" setting visible to "+value)
		return UI.Set(Name, GetMember("Visible"), value)
	Else
		System:Debug.WriteUnexpected("System", self, "SetVisible", ToString()+":The menu is not open.")
		return false
	EndIf
EndFunction

; @overrides
string Function ToString()
	{The string representation of this type.}
	return "[Name:"+Name+", File:"+File+", Root:"+Root+", Instance:"+Instance+", IsRegistered:"+IsRegistered+", IsOpen:"+IsOpen+", Flags:"+Flags+"]"
EndFunction
