ScriptName System:UI:HUD:Menu Extends System:UI:HUD:MenuType
import System:Debug
import System:UI:OpenCloseEvent


string HUDNotificationsGroup = "HUDNotificationsGroup_mc" const
string SafeRect = "SafeRect_mc" const
string FloatingQuestMarkerBase = "FloatingQuestMarkerBase" const

; Interfaces
;---------------------------------------------

; @overrides
IMenu Function IMenu()
	IMenu this = new IMenu
	this.Name = "HUDMenu"
	return this
EndFunction


; Open/Close Event
;---------------------------------------------

CustomEvent OpenCloseEvent

; Struct OpenCloseEventArgs
; 	bool Opening = false
; EndStruct


bool Function RegisterForOpenCloseEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OpenCloseEvent")
		return true
	Else
		WriteUnexpectedValue(self, "RegisterForOpenCloseEvent", "script", "Cannot register a none script for events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForOpenCloseEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OpenCloseEvent")
		return true
	Else
		WriteUnexpectedValue(self, "UnregisterForOpenCloseEvent", "script", "Cannot unregister a none script for events.")
		return false
	EndIf
EndFunction


OpenCloseEventArgs Function GetOpenCloseEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as OpenCloseEventArgs
	Else
		return none
	EndIf
EndFunction
