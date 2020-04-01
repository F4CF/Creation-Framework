ScriptName System:UI:Console:Menu Extends System:UI:Console:MenuType
{Represents the vanilla console menu.}
import System:Debug
import System:UI:OpenCloseEvent

IMenu IMenu_


; Properties
;---------------------------------------------

Group Implementation
	System:UI:OpenCloseEvent Property OpenClose Auto Const Mandatory
	{@IMenu}
EndGroup


; Interfaces
;---------------------------------------------

; @overrides
IMenu Function IMenu()
	return IMenu_
EndFunction


; Events
;---------------------------------------------

; TODO: This only happens once per object life time.
Event OnInit()
	IMenu_ = new IMenu
	IMenu_.Name = "Console"
	IMenu_.Variable = ".AnimHolder_mc.Menu_mc"
	IMenu_.OpenClose = OpenClose

	RegisterForQuestInit(QUST)
	RegisterForQuestShutdown(QUST)
EndEvent


Event OnQuestInit()
	RegisterForMenuOpenCloseEvent(Name)
	RegisterForGameReload(self)
	OnGameReload()
EndEvent


Event OnQuestShutdown()
	UnregisterForAllEvents()
EndEvent


Event OnGameReload()
	RegisterForMenuOpenCloseEvent(Name)
	WriteLine(self, "OnGameReload", log="System")
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	OpenCloseEventArgs e = new OpenCloseEventArgs
	e.Opening = opening
	IMenu().OpenClose.Send(self, e)
EndEvent
