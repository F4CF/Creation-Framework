ScriptName System:UI:Code:Client Extends System:UI:MenuClient
import System:Debug
import System:Log
import System:UI:Menu
import System:UI:MenuClient

IClient IClient_


; Interfaces
;---------------------------------------------

; @overrides
IMenu Function IMenu()
	IMenu this = new IMenu
	this.Name = "SystemCodeClient"
	return this
EndFunction


; @overrides
IClient Function IClient()
	return IClient_
EndFunction


; Events
;---------------------------------------------

Event OnInit()
	IClient_ = new IClient
	IClient_.File = "SystemCodeClient"
	RegisterForQuestInit(QUST)
EndEvent


Event OnQuestInit()
	OnGameReload()
	RegisterForGameReload(self)
EndEvent


Event OnGameReload()
	; If (Register())
	; 	RegisterForExternalEvent(ClientLoadedCallback, "OnClientLoaded")
	; EndIf
	WriteLine("System", self, "OnGameReload", ToString())
	WriteMessage("System", self, "UI.IsMenuRegistered('Console')", UI.IsMenuRegistered("Console"))
EndEvent


; @F4SE
Event OnLoadComplete(bool success, string menuName, string menuRoot, string assetInstance, string assetFile)
	{The UI loaded callback.}
	WriteLine("System", self, "OnLoadComplete", "(success:"+success+", menuName:"+menuName+", menuRoot:"+menuRoot+", assetInstance:"+assetInstance+", assetFile:"+assetFile+")")
	If (!success)
		WriteUnexpectedValue("System", self, "OnLoadComplete", "success", "The `"+assetFile+"` asset could not be loaded into `"+menuName+"`.")
	EndIf
	IClient().Variable = assetInstance
	IClient().Loaded = success
EndEvent


Event OnClientLoaded(bool success, string instance)
	WriteLine("System", self, "OnClientLoaded", ToString()+":(success:"+success+", instance:"+instance+")")
	If (success)
		IClient().Variable = instance
	Else
		IClient().Variable = ""
	EndIf
EndEvent
