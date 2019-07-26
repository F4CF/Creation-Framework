ScriptName System:UI:Visor:Menu Extends System:UI:Visor:MenuType
{Provides an abstraction for interacting with the visor menu.}
import System:Debug
import System:UI:LoadedEvent
import System:UI:MenuClient


string ClientInstance
string AssetLoadedEvent = "System_UI_VisorMenu_AssetLoadedEvent" const

; Interfaces
;---------------------------------------------

; @overrides
IMenu Function IMenu()
	IMenu this = new IMenu
	this.Name = "SystemVisorMenu"
	return this
EndFunction


; @overrides
ICustom Function ICustom()
	ICustom this = new ICustom
	this.File = "SystemVisorMenu"
	this.MenuFlags = FlagDoNotPreventGameSave
	this.ExtendedFlags = FlagNone
	return this
EndFunction


; Properties
;---------------------------------------------

Group Properties
	System:UI:Visor:Service Property Service Auto Const Mandatory

	string Property Client Hidden
		{The instance path of the client's display object.}
		string Function Get()
			return ClientInstance
		EndFunction
	EndProperty
EndGroup


; Events
;---------------------------------------------

Event OnInit()
	RegisterForQuestInit(QUST)
EndEvent


Event OnQuestInit()
	OnGameReload()
	RegisterForGameReload(self)
EndEvent


Event OnGameReload()
	If (Register())
		RegisterForExternalEvent(AssetLoadedEvent, "OnAssetLoaded")
	EndIf
	WriteLine(self, "OnGameReload", ToString())
EndEvent


Event OnAssetLoaded(bool success, string instance)
	WriteLine(self, "OnAssetLoaded", ":(success:"+success+", instance:"+instance+")"+ToString())
	If (success)
		ClientInstance = instance
	Else
		ClientInstance = ""
	EndIf
	LoadedEventArgs e = new LoadedEventArgs
	e.Success = success
	e.Variable = instance
	Service.SendLoadedEvent(e)
EndEvent


; Methods
;---------------------------------------------

bool Function Load(string value)
	If (IsOpen)
		If (value)
			var[] arguments = new var[1]
			arguments[0] = value
			string member = GetMember("Load")
			bool success = UI.Invoke(Name, member, arguments) as bool
			WriteLine(self, "Load", ToString()+":(value:"+value+", success:"+success+", member:"+member+")")
			return success
		Else
			WriteUnexpectedValue(self, "Load", "value", ToString()+":The value cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpected(self, "Load", ToString()+":The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetAlpha(float value)
	If (IsOpen)
		return UI.Set(Name, GetMember("Alpha"), value)
	Else
		WriteUnexpected(self, "SetAlpha", ToString()+":The menu is not open.")
		return false
	EndIf
EndFunction


bool Function AlphaTo(float value, float duration)
	If (IsOpen)
		var[] arguments = new var[2]
		arguments[0] = value
		arguments[1] = duration
		bool success = UI.Invoke(Name, GetMember("AlphaTo"), arguments) as bool
		WriteLine(self, "AlphaTo", ToString()+":(value:"+value+", duration:"+duration+", success:"+success+")")
		return success
	Else
		WriteUnexpected(self, "AlphaTo", ToString()+":The menu is not open.")
		return false
	EndIf
EndFunction
