ScriptName System:UI:Code:Menu Extends System:UI:MenuClient
{The framework is used to track equipment changes on the player.}
import System:Debug
import System:UI:Menu
import System:UI:MenuClient

IMenu IMenu_
IClient IClient_

; Properties
;---------------------------------------------

Group Properties
	System:MenuName Property MenuNames Auto Const Mandatory
EndGroup


; Interfaces
;---------------------------------------------

; @overrides
IMenu Function IMenu()
	return IMenu_
EndFunction


; @overrides
IClient Function IClient()
	return IClient_
EndFunction


; Events
;---------------------------------------------

; TODO: This only happens once per object life time.
Event OnInit()
	IMenu_ = new IMenu
	IMenu_.Name = ""

	IClient_ = new IClient
	IClient_.File = "SystemCodeClient"

	RegisterForQuestInit(QUST)
	RegisterForQuestShutdown(QUST)
EndEvent


Event OnQuestInit()
	OnGameReload()
	RegisterForGameReload(self)
EndEvent


Event OnQuestShutdown()
	WriteLine(self, "OnQuestShutdown", log="System")
	UnregisterForGameReload(self)
EndEvent


Event OnGameReload()
	UnregisterForAllMenuOpenCloseEvents()
	RegisterForExternalEvent(ClientLoadedCallback, "OnClientLoaded")
	WriteLine(self, "OnGameReload", ToString(), log="System")

	RegisterForMenuOpenCloseEvent(MenuNames.TerminalHolotapeMenu)
	RegisterForMenuOpenCloseEvent(MenuNames.TerminalMenu)
EndEvent


; @F4SE
Event OnLoadComplete(bool success, string menuName, string menuRoot, string assetInstance, string assetFile)
	{The UI loaded callback.}
	WriteLine(self, "OnLoadComplete", "(success:"+success+", menuName:"+menuName+", menuRoot:"+menuRoot+", assetInstance:"+assetInstance+", assetFile:"+assetFile+")", log="System")
	If (!success)
		WriteUnexpectedValue(self, "OnLoadComplete", "success", "The `"+assetFile+"` asset could not be loaded into `"+menuName+"`.", log="System")
	EndIf
	IClient().Variable = assetInstance
	IClient().Loaded = success
EndEvent


Event OnClientLoaded(bool success, string instance)
	WriteLine(self, "OnClientLoaded", ToString()+":(success:"+success+", instance:"+instance+")", log="System")
	If (success)
		IClient().Variable = instance
	Else
		IClient().Variable = ""
	EndIf
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	WriteLine(self, "OnMenuOpenCloseEvent(MenuNames.menuName="+menuName+", opening="+opening+")", log="System")
	If (opening)
		Load(menuName)
	EndIf
EndEvent
