ScriptName System:UI:HUD:Service Extends System:UI:HUD:ServiceType
import System:Debug
import System:Log
import System:UI:Menu


; Events
;---------------------------------------------

Event OnInit() ; TODO: This only happens once per object life time.
	RegisterForQuestInit(QUST)
	RegisterForQuestShutdown(QUST)
EndEvent


Event OnQuestInit()
	RegisterForGameReload(self)
	OnGameReload()
EndEvent


Event OnGameReload()
	RegisterForMenuOpenCloseEvent(Menu.Name)
EndEvent


Event OnQuestShutdown()
	UnregisterForAllEvents()
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	OpenCloseEventArgs e = new OpenCloseEventArgs
	e.Opening = opening
	self.SendOpenCloseEvent(e)
EndEvent


; Methods
;---------------------------------------------

Function SendOpenCloseEvent(OpenCloseEventArgs e)
	If (e)
		var[] arguments = new var[1]
		arguments[0] = e
		Menu.SendCustomEvent("OpenCloseEvent", arguments)
	Else
		WriteUnexpectedValue("System", self, "SendOpenCloseEvent", "e", "The argument cannot be none.")
	EndIf
EndFunction


string Function ToString()
	{The string representation of this type.}
	return "[System:UI:HUD:Service]"
EndFunction


; Properties
;---------------------------------------------

Group Scopes
	System:UI:HUD:Menu Property Menu Auto Const Mandatory
EndGroup
