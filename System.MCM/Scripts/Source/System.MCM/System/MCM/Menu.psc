Scriptname ODST:MCM:Menu extends ODST:Type
{Provides methods for ODST to interact with the MCM library.}
import ODST:Log

string PauseMenu = "PauseMenu" const
;---------------------------------------------
string OnMCMOpen = "OnMCMOpen" const
string OnMCMClose = "OnMCMClose" const
string OnMCMSettingChange = "OnMCMSettingChange" const


; Events
;---------------------------------------------

Event OnQuestInit()
	OnGameReload()
	RegisterForGameReload(self)
	WriteLine(self, "OnQuestInit")
EndEvent


Event OnGameReload()
	WriteLine(self, "OnGameReload", "Re-registering for events.")
	RegisterForMenuOpenCloseEvent(PauseMenu)
	RegisterForExternalEvent(OnMCMOpen, "OnMCMOpen")
	RegisterForExternalEvent(OnMCMClose, "OnMCMClose")
	RegisterForExternalEvent(OnMCMSettingChange+"|"+Properties.PluginName, "OnMCMSettingChange")
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	WriteLine(self, "OnMenuOpenCloseEvent", "asMenuName="+asMenuName+", abOpening="+abOpening+"")
	If (abOpening)
		SendMenuStateEvent(MenuOpened)
	Else
		SendMenuStateEvent(MenuClosed)
	EndIf
EndEvent


; Callbacks
;---------------------------------------------

Function OnMCMOpen()
	WriteLine(self, "OnMCMOpen", "The Settings menu was opened.")
	RefreshMenu()
	SendMenuStateEvent(MenuShown)
EndFunction


Function OnMCMClose()
	WriteLine(self, "OnMCMClose", "The Settings menu was closed.")
	SendMenuStateEvent(MenuHidden)
EndFunction


Function OnMCMSettingChange(string modName, string identifier)
	If (modName == Properties.PluginName)
		int value = GetModSetting(identifier)
		; WriteLine(self, "OnMCMSettingChange(modName="+modName+", identifier="+identifier+")", "The new value equals "+value)
		SendOptionEvent(identifier, value)
	Else
		WriteUnexpected(self, "OnMCMSettingChange", "The "+modName+" modName was unhandled.")
	EndIf
EndFunction


; Methods
;---------------------------------------------

bool Function IsInstalled()
	{Checks to see whether the MCM is installed. This will not check if the plugin is actually activated for load.}
	return MCM.IsInstalled()
EndFunction


int Function GetVersionCode()
	{Returns the version code of the MCM. This value is incremented for every public release of MCM.}
	return MCM.GetVersionCode()
EndFunction


Function RefreshMenu()
	{Refreshes currently displayed values in the MCM menu if it is currently open.}
	MCM.RefreshMenu()
	WriteLine(self, "RefreshMenu")
EndFunction


int Function GetModSetting(string identifier)
	; WriteLine(self, "GetModSettingFor", "identifier:"+identifier)
	return MCM.GetModSettingInt(Properties.PluginName, identifier)
EndFunction


Function SetModSetting(string identifier, int value)
	; WriteLine(self, "GetModSettingFor", "identifier:"+identifier+", value:"+value)
	MCM.SetModSettingInt(Properties.PluginName, identifier, value)
EndFunction


int Function GetModSettingFor(string settingName, string settingSection = "")
	{Helper function for settings with variable section names.}
	; WriteLine(self, "GetModSettingFor", "settingName:"+settingName+", settingSection:"+settingSection)
	return GetModSetting(GetIdentifier(settingName, settingSection))
EndFunction


Function SetModSettingFor(string settingName, string settingSection, int value)
	{Helper function for settings with variable section names.}
	; WriteLine(self, "SetModSettingFor", "settingName:"+settingName+", settingSection:"+settingSection+", value:"+value)
	SetModSetting(GetIdentifier(settingName, settingSection), value)
EndFunction


; OnMenuState
;---------------------------------------------

CustomEvent OnMenuState

Struct MenuStateEventArgs
	int MenuState = -1
EndStruct


bool Function SendMenuStateEvent(int menuState)
	If (menuState > Invalid)
		MenuStateEventArgs e = new MenuStateEventArgs
		e.MenuState = menuState
		var[] arguments = new var[1]
		arguments[0] = e
		SendCustomEvent("OnMenuState", arguments)
		return true
	Else
		WriteUnexpectedValue(self, "SendMenuStateEvent", "menuState", "The value "+menuState+" is out of range.")
		return false
	EndIf
EndFunction


bool Function RegisterForMenuStateEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OnMenuState")
		return true
	Else
		WriteUnexpectedValue(self, "RegisterForMenuStateEvent", "script", "Cannot register a none script for changed events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForMenuStateEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OnMenuState")
		return true
	Else
		WriteUnexpectedValue(self, "UnregisterForMenuStateEvent", "script", "Cannot register a none script for changed events.")
		return false
	EndIf
EndFunction


MenuStateEventArgs Function GetMenuStateEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as MenuStateEventArgs
	Else
		WriteUnexpectedValue(self, "GetMenuStateEventArgs", "arguments", "The changed event arguments are empty or none.")
		return none
	EndIf
EndFunction


; OnOption
;---------------------------------------------

CustomEvent OnOption

Struct OptionEventArgs
	string Identifier
	int Value = -1
EndStruct


bool Function SendOptionEvent(string identifier, int value)
	OptionEventArgs e = new OptionEventArgs
	e.Identifier = identifier
	e.Value = value
	var[] arguments = new var[1]
	arguments[0] = e
	SendCustomEvent("OnOption", arguments)
	WriteLine(self, "SendOptionEvent", "identifier:"+identifier+", value:"+value)
	return true
EndFunction


bool Function RegisterForOptionEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OnOption")
		return true
	Else
		WriteUnexpectedValue(self, "RegisterForOptionEvent", "script", "Cannot register a none script for changed events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForOptionEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OnOption")
		return true
	Else
		WriteUnexpectedValue(self, "UnregisterForOptionEvent", "script", "Cannot register a none script for changed events.")
		return false
	EndIf
EndFunction


OptionEventArgs Function GetOptionEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as OptionEventArgs
	Else
		WriteUnexpectedValue(self, "GetOptionEventArgs", "arguments", "The changed event arguments are empty or none.")
		return none
	EndIf
EndFunction


; Functions
;---------------------------------------------

string Function GetIdentifier(string name, string section = "")
	{Concats a setting name with a section name.}
	If (section)
		return name+":"+section
	Else
		return name+":"+DefaultSection
	EndIf
EndFunction


string Function ToString()
	{The string representation of this type.}
	return "[ODST:MCM:Menu]"
EndFunction


; Properties
;---------------------------------------------

Group Properties
	ODST:Properties Property Properties Auto Const Mandatory
	{Provides common property values for ODST script objects.}
EndGroup

Group Menu
	int Property MenuOpened = 1 AutoReadOnly
	{The MCM menu has been opened.}
	int Property MenuShown = 2 AutoReadOnly
	{The MCM menu has been shown.}
	int Property MenuHidden = 3 AutoReadOnly
	{The MCM menu has been hidden.}
	int Property MenuClosed = 4 AutoReadOnly
	{The MCM menu has been closed.}
EndGroup

Group Settings
	string Property DefaultSection = "Settings" AutoReadOnly
	{The default section name for `settings.json`.}
EndGroup
