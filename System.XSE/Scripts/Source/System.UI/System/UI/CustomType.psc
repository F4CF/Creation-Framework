Scriptname System:UI:CustomType extends System:UI:MenuType Hidden Native Const
{A base script for custom menu types.}
import System:Log

; Virtual
;---------------------------------------------

UI:MenuData Function GetInitialization()
	{Property}
	return new UI:MenuData
EndFunction


; Methods
;---------------------------------------------

bool Function Register()
	If (UI.RegisterCustomMenu(Name, File, Root, Initialization))
		WriteLine(ToString(), "Registered as a custom menu.")
		return true
	Else
		WriteUnexpected(ToString(), "Register", "Failed to register as a custom menu.")
		return false
	EndIf
EndFunction


bool Function GetVisible()
	If (UI.IsMenuOpen(Name))
		return UI.Get(Name, GetMember("Visible")) as bool
	Else
		WriteUnexpected(ToString(), "GetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetVisible(bool value)
	If (UI.IsMenuOpen(Name))
		return UI.Set(Name, GetMember("Visible"), value)
	Else
		WriteUnexpected(ToString(), "SetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	UI:MenuData Property Initialization Hidden
		UI:MenuData Function Get()
			return GetInitialization()
		EndFunction
	EndProperty
EndGroup

Group MenuFlags
	int Property FlagNone = 0x0 AutoReadOnly
	int Property FlagPauseGame = 0x01 AutoReadOnly
	int Property FlagShowCursor = 0x04 AutoReadOnly
	int Property FlagEnableMenuControl = 0x08 AutoReadOnly
EndGroup

Group ExtendedFlags
	; If you set extendedFlags & 2, it will disable your ShowCursor if the Gamepad is enabled
	int Property FlagInheritColors = 1 AutoReadOnly
	int Property FlagCheckForGamepad = 2 AutoReadOnly
EndGroup
