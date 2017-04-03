ScriptName Papyrus:Project:ContextType extends Quest Native Const Hidden
import Papyrus:Compatibility:External
import Papyrus:Diagnostics:Log
import Papyrus:VersionType


; Virtual
;---------------------------------------------

Event OnInitialize()
	{VIRTUAL}
	Write(Title, "The context has not implemented the virtual OnInitialize event.")
EndEvent


Event OnGameReload()
	{VIRTUAL}
	Write(Title, "The context has not implemented the virtual OnGameReload event.")
EndEvent


Event OnContextStartup()
	{VIRTUAL}
	Write(Title, "The context has not implemented the virtual OnContextStartup event.")
EndEvent


Event OnContextShutdown()
	{VIRTUAL}
	Write(Title, "The context has not implemented the virtual OnContextShutdown event.")
EndEvent


Event OnContextUpgrade(Version aNew, Version aPrevious)
	{VIRTUAL}
	Write(Title, "The context has not implemented the virtual OnContextUpgrade event for version '"+VersionToString(aNew)+"'.")
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


; Properties
;---------------------------------------------

Group Context
	string Property Title Hidden
		string Function Get()
			return GetTitle()
		EndFunction
	EndProperty

	string[] Property Authors Hidden
		string[] Function Get()
			return GetAuthors()
		EndFunction
	EndProperty

	string Property FileName Hidden
		string Function Get()
			return Context().FileName
		EndFunction
	EndProperty

	int Property FormID Hidden
		int Function Get()
			return Context().FormID
		EndFunction
	EndProperty

	Version Property Release Hidden
		Version Function Get()
			return GetVersion()
		EndFunction
	EndProperty
EndGroup
