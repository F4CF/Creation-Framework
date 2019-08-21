ScriptName System:UI:Code:Menu Extends System:UI:Code:MenuType
{The framework is used to track equipment changes on the player.}
import System:Debug
import System:UI:Menu
import System:UI:MenuDynamic

IMenu IMenu_
IMenuDynamic IMenuDynamic_

; Properties
;---------------------------------------------

Group Implementation
	System:UI:OpenCloseEvent Property OpenClose Auto Const Mandatory
	{@IMenu}

	System:UI:DynamicLoadEvent Property DynamicLoad Auto Const Mandatory
	{@IMenuDynamic}
EndGroup

Group Properties
	System:MenuName Property MenuNames Auto Const Mandatory
EndGroup


string Property ClientLoadedCallback Hidden
	{The client loaded external event ID.}
	string Function Get()
		return "SystemUI_ClientLoadedCallback"
	EndFunction
EndProperty


; Interfaces
;---------------------------------------------

; @overrides
IMenu Function IMenu()
	return IMenu_
EndFunction


; @overrides
IMenuDynamic Function IMenuDynamic()
	return IMenuDynamic_
EndFunction


; Events
;---------------------------------------------

; TODO: This only happens once per object life time.
Event OnInit()
	IMenu_ = new IMenu
	IMenu_.Name = ""
	IMenu_.OpenClose = OpenClose

	IMenuDynamic_ = new IMenuDynamic
	IMenuDynamic_.File = "SystemCodeClient"
	IMenuDynamic_.DynamicLoad = DynamicLoad

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


Event OnClientLoaded(bool success, string instance)
	{The client loaded event.}
	WriteLine(self, "OnClientLoaded", ToString()+":(success:"+success+", instance:"+instance+")", log="System")
	If (success)
		IMenuDynamic().Instance = instance
	Else
		IMenuDynamic().Instance = ""
	EndIf
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	WriteLine(self, "OnMenuOpenCloseEvent(MenuNames.menuName="+menuName+", opening="+opening+")", log="System")
	If (opening)
		Load()
	EndIf
EndEvent
