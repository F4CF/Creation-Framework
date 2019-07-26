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
	System:Menu Property Menu Auto Const Mandatory
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

	; RegisterForMenuOpenCloseEvent(Menu.BarterMenu)
	; RegisterForMenuOpenCloseEvent(Menu.BookMenu)
	; RegisterForMenuOpenCloseEvent(Menu.ConsoleMenu)
	; RegisterForMenuOpenCloseEvent(Menu.ConsoleNativeUIMenu)
	; RegisterForMenuOpenCloseEvent(Menu.ContainerMenu)
	; RegisterForMenuOpenCloseEvent(Menu.CookingMenu)
	; RegisterForMenuOpenCloseEvent(Menu.CreditsMenu)
	; RegisterForMenuOpenCloseEvent(Menu.CursorMenu)
	; RegisterForMenuOpenCloseEvent(Menu.DialogueMenu)
	; RegisterForMenuOpenCloseEvent(Menu.ExamineMenu)
	; RegisterForMenuOpenCloseEvent(Menu.FaderMenu)
	; RegisterForMenuOpenCloseEvent(Menu.FavoritesMenu)
	; RegisterForMenuOpenCloseEvent(Menu.GenericMenu)
	; RegisterForMenuOpenCloseEvent(Menu.HUDMenu)
	; RegisterForMenuOpenCloseEvent(Menu.LevelUpMenu)
	; RegisterForMenuOpenCloseEvent(Menu.LoadingMenu)
	; RegisterForMenuOpenCloseEvent(Menu.LockpickingMenu)
	RegisterForMenuOpenCloseEvent(Menu.LooksMenu)
	; RegisterForMenuOpenCloseEvent(Menu.MainMenu)
	; RegisterForMenuOpenCloseEvent(Menu.MessageBoxMenu)
	; RegisterForMenuOpenCloseEvent(Menu.MultiActivateMenu)
	; RegisterForMenuOpenCloseEvent(Menu.PauseMenu)
	; RegisterForMenuOpenCloseEvent(Menu.PipboyMenu)
	; RegisterForMenuOpenCloseEvent(Menu.PromptMenu)
	; RegisterForMenuOpenCloseEvent(Menu.ScopeMenu)
	RegisterForMenuOpenCloseEvent(Menu.SitWaitMenu)
	RegisterForMenuOpenCloseEvent(Menu.SleepWaitMenu)
	; RegisterForMenuOpenCloseEvent(Menu.SPECIALMenu)
	; RegisterForMenuOpenCloseEvent(Menu.TerminalHolotapeMenu)
	; RegisterForMenuOpenCloseEvent(Menu.TerminalMenu)
	; RegisterForMenuOpenCloseEvent(Menu.VATSMenu)
	; RegisterForMenuOpenCloseEvent(Menu.VignetteMenu)
	; RegisterForMenuOpenCloseEvent(Menu.WorkshopMenu)
	; RegisterForMenuOpenCloseEvent(Menu.Workshop_CaravanMenu)
EndEvent


Event OnQuestShutdown()
	WriteLine(self, "OnQuestShutdown", log="System")
	UnregisterForGameReload(self)
EndEvent


Event OnKeyDown(int keyCode)
	; UI.OpenMenu(Menu.ConsoleNativeUIMenu)
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	WriteLine(self, "OnMenuOpenCloseEvent(Menu.menuName="+menuName+", opening="+opening+")", log="System")
	If (opening)
		Client.Load(menuName)
	EndIf
EndEvent
