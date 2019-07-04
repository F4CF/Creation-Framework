Scriptname System:UI:Menu extends System:UI:MenuType Hidden
import System:Log

DisplayData Display


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
	Display = NewDisplay()
	UI:MenuData data = new UI:MenuData
	data.MenuFlags = FlagNone
	data.ExtendedFlags = FlagInheritColors + FlagCheckForGamepad
	If (UI.RegisterCustomMenu(Display.Menu, Display.Asset, Display.Root, data))
		WriteLine(ToString(), "Registered as a custom menu.")
	Else
		WriteUnexpected(ToString(), "OnGameReload", "Failed to register as a custom menu.")
	EndIf
EndEvent


; Methods
;---------------------------------------------

bool Function Open()
	If (UI.IsMenuRegistered(Menu))
		return UI.OpenMenu(Menu)
	Else
		WriteUnexpected(ToString(), "Open", "The menu is not registered.")
		return false
	EndIf
EndFunction


bool Function Close()
	If (UI.IsMenuRegistered(Menu))
		return UI.CloseMenu(Menu)
	Else
		WriteUnexpected(ToString(), "Close", "The menu is not registered.")
		return false
	EndIf
EndFunction


bool Function GetVisible()
	If (UI.IsMenuOpen(Menu))
		return UI.Get(Menu, GetMember("Visible")) as bool
	Else
		WriteUnexpected(ToString(), "GetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetVisible(bool value)
	If (UI.IsMenuOpen(Menu))
		return UI.Set(Menu, GetMember("Visible"), value)
	Else
		WriteUnexpected(ToString(), "SetVisible", "The menu is not open.")
		return false
	EndIf
EndFunction


string Function GetMember(string member)
	{Returns the full AS3 instance path for the given member name.}
	If (member)
		WriteUnexpectedValue(ToString(), "GetMember", "member", "Cannot operate on a none or empty display member.")
		return none
	ElseIf (root)
		WriteUnexpected(ToString(), "GetMember", "Cannot operate on a none or empty display root.")
		return none
	Else
		return Root+"."+member
	EndIf
EndFunction


string Function ToString()
	{The string representation of this UI type.}
	return parent.ToString()+"[Menu:"+Menu+", Asset:"+Asset+", Root:"+Root+"]"
EndFunction


; Properties
;---------------------------------------------

Group Display
	string Property Menu Hidden
		string Function Get()
			return Display.Menu
		EndFunction
	EndProperty

	string Property Root Hidden
		string Function Get()
			return Display.Root
		EndFunction
	EndProperty

	string Property Asset Hidden
		string Function Get()
			return Display.Asset
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
