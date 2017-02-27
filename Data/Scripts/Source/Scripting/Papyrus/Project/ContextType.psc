ScriptName Papyrus:Project:ContextType extends Quest Const Native Hidden
import Papyrus
import Papyrus:Compatibility:External
import Papyrus:Diagnostics:Log
import Papyrus:VersionType


; Events
;---------------------------------------------

Event Papyrus:Project:Context.OnStartup(Project:Context akSender, var[] arguments)
	self.OnContextStartup()
	Write(ContextTitle(), "The context has finished the OnStartup event.")
EndEvent


Event Papyrus:Project:Context.OnShutdown(Project:Context akSender, var[] arguments)
	self.OnContextShutdown()
	Write(ContextTitle(), "The context has finished the OnShutdown event.")
EndEvent


Event Papyrus:Project:Context.OnUpgrade(Project:Context akSender, var[] arguments)
	Version newVersion = arguments[0] as Version
	Version oldVersion = arguments[1] as Version
	self.OnContextUpgrade(newVersion, oldVersion)
	Write(ContextTitle(), "The context has finished the OnUpgrade event. " \
		+"New '"+VersionToString(newVersion)+"', Old '"+VersionToString(oldVersion)+"'.")
EndEvent


; Globals
;---------------------------------------------
; Papyrus global functions cannot be overridden in extending classes!

;DEPRECIATE
string Function ContextTitle() Global
	{DUMMY - CANNOT OVERRIDE!}
	return "My Context"
EndFunction

;DEPRECIATE
string Function ContextPlugin() Global
	{DUMMY - CANNOT OVERRIDE!}
	return "MyContext.esp"
EndFunction

;DEPRECIATE
int Function ContextFormID() Global
	{DUMMY - CANNOT OVERRIDE!}
	return 0x00000000
EndFunction


; Virtual
;---------------------------------------------

Event OnInitialize()
	{VIRTUAL}
	Write(ContextTitle(), "The context has not implemented the virtual OnInitialize event.")
EndEvent


Event OnGameReload()
	{VIRTUAL}
	Write(ContextTitle(), "The context has not implemented the virtual OnGameReload event.")
EndEvent


Event OnContextStartup()
	{VIRTUAL}
	Write(ContextTitle(), "The context has not implemented the virtual OnContextStartup event.")
EndEvent


Event OnContextShutdown()
	{VIRTUAL}
	Write(ContextTitle(), "The context has not implemented the virtual OnContextShutdown event.")
EndEvent


Event OnContextUpgrade(Version aNew, Version aPrevious)
	{VIRTUAL}
	Write(ContextTitle(), "The context has not implemented the virtual OnContextUpgrade event for version '"+VersionToString(aNew)+"'.")
EndEvent


; Implementation
;---------------------------------------------

string Function GetTitle()
	Write(ContextTitle(), "The GetTitle function has not been implemented on child script.")
	return none
EndFunction


string[] Function GetAuthors()
	Write(ContextTitle(), "The GetAuthors function has not been implemented on child script.")
	return none
EndFunction


Version Function GetVersion()
	Write(ContextTitle(), "The GetVersion function has not been implemented on child script.")
	return none
EndFunction


ExternalForm Function Context()
	Write(ContextTitle(), "The Context function has not been implemented on child script.")
	return none
EndFunction


; DEPRECIATE
bool Function StartCondition()
	Write(ContextTitle(), "The optional GetStartCondition function has not been implemented on child script.")
	return true
EndFunction
