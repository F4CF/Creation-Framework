ScriptName Papyrus:Project:ContextType extends Quest Const Native Hidden
import Papyrus
import Papyrus:Compatibility:External
import Papyrus:Diagnostics:Log
import Papyrus:VersionType


; Events
;---------------------------------------------

Event Papyrus:Project:Context.OnStartup(Project:Context akSender, var[] arguments)
	self.OnContextStartup()
	Write(akSender.Title, "The context has finished the OnStartup event.")
EndEvent


Event Papyrus:Project:Context.OnShutdown(Project:Context akSender, var[] arguments)
	self.OnContextShutdown()
	Write(akSender.Title, "The context has finished the OnShutdown event.")
EndEvent


Event Papyrus:Project:Context.OnUpgrade(Project:Context akSender, var[] arguments)
	Version newVersion = arguments[0] as Version
	Version oldVersion = arguments[1] as Version
	self.OnContextUpgrade(newVersion, oldVersion)
	Write(akSender.Title, "The context has finished the OnUpgrade event. " \
		+"New '"+VersionToString(newVersion)+"', Old '"+VersionToString(oldVersion)+"'.")
EndEvent


; Virtual
;---------------------------------------------

Event OnInitialize()
	{VIRTUAL}
	Write(GetTitle(), "The context has not implemented the virtual OnInitialize event.")
EndEvent


Event OnGameReload()
	{VIRTUAL}
	Write(GetTitle(), "The context has not implemented the virtual OnGameReload event.")
EndEvent


Event OnContextStartup()
	{VIRTUAL}
	Write(GetTitle(), "The context has not implemented the virtual OnContextStartup event.")
EndEvent


Event OnContextShutdown()
	{VIRTUAL}
	Write(GetTitle(), "The context has not implemented the virtual OnContextShutdown event.")
EndEvent


Event OnContextUpgrade(Version aNew, Version aPrevious)
	{VIRTUAL}
	Write(GetTitle(), "The context has not implemented the virtual OnContextUpgrade event for version '"+VersionToString(aNew)+"'.")
EndEvent


; Implementation
;---------------------------------------------

string Function GetTitle()
	Write(none, self + ", The GetTitle function has not been implemented on a child script.")
	return none
EndFunction


string[] Function GetAuthors()
	Write(none, self + ", The GetAuthors function has not been implemented on a child script.")
	return none
EndFunction


Version Function GetVersion()
	Write(none, self + ", The GetVersion function has not been implemented on a child script.")
	return none
EndFunction


ExternalForm Function Context()
	Write(none, self + ", The Context function has not been implemented on a child script.")
	return none
EndFunction
