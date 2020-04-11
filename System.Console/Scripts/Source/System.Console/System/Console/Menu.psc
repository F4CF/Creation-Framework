ScriptName System:Console:Menu Extends System:Console:MenuType
import System:Debug
import System:UI:Menu
import System:UI:MenuDynamic

; The IMenu implementation.
IMenu IMenu_

; The IMenuDynamic implementation.
IMenuDynamic IMenuDynamic_


; Properties
;---------------------------------------------

Group Implementation
	System:UI:Console:Menu Property ConsoleMenu Auto Const Mandatory
	{The console menu definition.}

	System:UI:DynamicLoadEvent Property DynamicLoad Auto Const Mandatory
	{@IMenuDynamic}
EndGroup

Group System
	System:Input Property Keyboard Auto Const Mandatory
EndGroup



; Interfaces
;---------------------------------------------

; @overrides
IMenu Function IMenu()
	return ConsoleMenu.IMenu()
EndFunction


; @overrides
IMenuDynamic Function IMenuDynamic()
	return IMenuDynamic_
EndFunction


; Events
;---------------------------------------------

; TODO: This only happens once per object life time.
Event OnInit()
	IMenuDynamic_ = new IMenuDynamic
	IMenuDynamic_.File = "SystemConsole"
	IMenuDynamic_.DynamicLoad = DynamicLoad

	RegisterForQuestInit(QUST)
	RegisterForQuestShutdown(QUST)
EndEvent


Event OnQuestInit()
	OnGameReload()
	RegisterForGameReload(self)
	RegisterForKey(Keyboard.End)
EndEvent


Event OnQuestShutdown()
	WriteLine(self, "OnQuestShutdown", log="System")
	UnregisterForGameReload(self)
EndEvent


Event OnGameReload()
	WriteLine(self, "OnGameReload", ToString(), log="System")
	RegisterForMenuOpenCloseEvent(Name)
	; RegisterForExternalEvent(ReadyEvent, "OnAssetReady")
	; RegisterForExternalEvent(UnloadEvent, "OnAssetUnloaded")
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	WriteLine(self, "OnMenuOpenCloseEvent(MenuNames.menuName="+menuName+", opening="+opening+")", log="System")
	If (opening)
		Unload()
		Load()
	Else
		; TODO: The unload may be called TOO LATE at this point.
		Unload()
	EndIf
EndEvent



Event OnKeyDown(int keyCode)
	WriteLine(self, "OnKeyDown", "keyCode:"+keyCode, log="System")
	If (keyCode == Keyboard.End)
		Unload()
	EndIf
EndEvent
