ScriptName Papyrus:Project:ContextType extends Quest Native Const Hidden
import Papyrus
import Papyrus:Compatibility:External
import Papyrus:Diagnostics:Log
import Papyrus:VersionType



; Context
;---------------------------------------------

bool Function ContextInitialize(Project:Context context, ScriptObject script) Global
	If (script)
		If (context)
			script.RegisterForCustomEvent(context, "OnStartup")
			script.RegisterForCustomEvent(context, "OnShutdown")
			script.RegisterForCustomEvent(context, "OnUpgrade")
			script.RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
			return true
		Else
			Write(none, "Cannot initialize a script with a none context.")
			return false
		EndIf
	Else
		Write(none, "Cannot initialize a context with a none ScriptObject.")
		return false
	EndIf
EndFunction


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
	Write(akSender.Title, \
		"The context has finished the OnUpgrade event. "+\
		"New '"+VersionToString(newVersion)+"', "+\
		"Old '"+VersionToString(oldVersion)+"'.")
EndEvent


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

	bool Property IsSingleton Hidden
		bool Function Get()
			return FormID == self.GetFormID()
		EndFunction
	EndProperty
EndGroup
