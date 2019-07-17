ScriptName System:UI:Visor:Menu Extends System:UI:Visor:MenuType
{Provides an abstraction for interacting with the visor menu.}
import System:UI:Client
import System:Log
import System:Debug

string ClientInstance
string ClientLoadedCallback = "System_UI_VisorMenu_ClientLoadedCallback" const

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
		RegisterForExternalEvent(ClientLoadedCallback, "OnClientLoaded")
	EndIf
	WriteLine("System", self, "OnGameReload", ToString())
EndEvent


Event OnClientLoaded(bool success, string instance)
	WriteLine("System", self, "OnClientLoaded", ToString()+":(success:"+success+", instance:"+instance+")")
	If (success)
		ClientInstance = instance
	Else
		ClientInstance = ""
	EndIf
	System:UI:Client:LoadedEventArgs e = new System:UI:Client:LoadedEventArgs
	e.Success = success
	e.Instance = instance
	Service.SendLoadedEvent(e)
EndEvent


; Methods
;---------------------------------------------

; @overrides
string Function GetName()
	return "SystemVisorMenu"
EndFunction


; @overrides
string Function GetFile()
	return "SystemVisorMenu"
EndFunction


; @overrides
UI:MenuData Function GetFlags()
	UI:MenuData data = new UI:MenuData
	data.MenuFlags = FlagDoNotPreventGameSave
	data.ExtendedFlags = FlagNone
	return data
EndFunction


bool Function Load(string value)
	If (IsOpen)
		If (value)
			var[] arguments = new var[1]
			arguments[0] = value
			string member = GetMember("Load")
			bool success = UI.Invoke(Name, member, arguments) as bool
			WriteLine("System", self, "Load", ToString()+":(value:"+value+", success:"+success+", member:"+member+")")
			return success
		Else
			WriteUnexpectedValue("System", self, "Load", "value", ToString()+":The value cannot be none or empty.")
			return false
		EndIf
	Else
		WriteUnexpected("System", self, "Load", ToString()+":The menu is not open.")
		return false
	EndIf
EndFunction


bool Function SetAlpha(float value)
	If (IsOpen)
		return UI.Set(Name, GetMember("Alpha"), value)
	Else
		WriteUnexpected("System", self, "SetAlpha", ToString()+":The menu is not open.")
		return false
	EndIf
EndFunction


bool Function AlphaTo(float value, float duration)
	If (IsOpen)
		var[] arguments = new var[2]
		arguments[0] = value
		arguments[1] = duration
		bool success = UI.Invoke(Name, GetMember("AlphaTo"), arguments) as bool
		WriteLine("System", self, "AlphaTo", ToString()+":(value:"+value+", duration:"+duration+", success:"+success+")")
		return success
	Else
		WriteUnexpected("System", self, "AlphaTo", ToString()+":The menu is not open.")
		return false
	EndIf
EndFunction


; @overrides
string Function ToString()
	{The string representation of this type.}
	return "[Name:"+Name+", File:"+File+", Root:"+Root+", Instance:"+Instance+", IsRegistered:"+IsRegistered+", IsOpen:"+IsOpen+", Flags:"+Flags+", Client:"+Client+"]"
EndFunction
