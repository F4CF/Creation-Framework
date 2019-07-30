ScriptName System:UI:Code:Service Extends System:Quest
{The framework is used to track equipment changes on the player.}
import System:Debug


; Properties
;---------------------------------------------

Group Overlay
	System:UI:Code:Client Property Client Auto Const Mandatory
EndGroup

Group Properties
	System:Input Property Keyboard Auto Const Mandatory
	System:MenuName Property MenuNames Auto Const Mandatory
EndGroup


; Events
;---------------------------------------------

; TODO: This only happens once per object life time.
Event OnInit()
	RegisterForQuestInit(QUST)
	RegisterForQuestShutdown(QUST)
EndEvent


Event OnQuestInit()
	RegisterForGameReload(self)
	OnGameReload()
EndEvent


Event OnGameReload()
	WriteLine(self, "OnGameReload", log="System")
	UnregisterForAllMenuOpenCloseEvents()

	RegisterForKey(Keyboard.P)

	; RegisterForMenuOpenCloseEvent(MenuNames.BarterMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.BookMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.ConsoleMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.ConsoleNativeUIMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.ContainerMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.CookingMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.CreditsMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.CursorMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.DialogueMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.ExamineMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.FaderMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.FavoritesMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.GenericMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.HUDMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.LevelUpMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.LoadingMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.LockpickingMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.LooksMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.MainMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.MessageBoxMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.MultiActivateMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.PauseMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.PipboyMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.PromptMenu)
	RegisterForMenuOpenCloseEvent(MenuNames.ScopeMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.SitWaitMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.SleepWaitMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.SPECIALMenu)
	RegisterForMenuOpenCloseEvent(MenuNames.TerminalHolotapeMenu)
	RegisterForMenuOpenCloseEvent(MenuNames.TerminalMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.VATSMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.VignetteMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.WorkshopMenu)
	; RegisterForMenuOpenCloseEvent(MenuNames.Workshop_CaravanMenu)
EndEvent


Event OnQuestShutdown()
	WriteLine(self, "OnQuestShutdown", log="System")
	UnregisterForGameReload(self)
EndEvent


Event OnKeyDown(int keyCode)
	UI.OpenMenu(MenuNames.ScopeMenu)
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	WriteLine(self, "OnMenuOpenCloseEvent(MenuNames.menuName="+menuName+", opening="+opening+")", log="System")
	If (opening)
		Client.Load(menuName)
	EndIf
EndEvent
