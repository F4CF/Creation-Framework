ScriptName Papyrus:Project:Modules:Module extends Form Native Const Hidden
import Papyrus
import Papyrus:Compatibility
import Papyrus:Diagnostics:Log
import Papyrus:VersionType


; Module
;---------------------------------------------

bool Function Initialize(Project:Context context)
	If (ModuleInitialize(Context, self))
		self.OnInitialize()
		Write(none, "The module has initialized.")
		return true
	Else
		Write(none, "The module could not be initialized.")
		return false
	EndIf
EndFunction


bool Function ModuleInitialize(Project:Context context, ScriptObject script) Global
	If (script)
		If (context)
			script.RegisterForCustomEvent(context, "OnStartup")
			script.RegisterForCustomEvent(context, "OnUpgrade")
			script.RegisterForCustomEvent(context, "OnShutdown")
			return true
		Else
			Write(none, "Cannot initialize a module with a none context.")
			return false
		EndIf
	Else
		Write(none, "Cannot initialize a module with a none script.")
		return false
	EndIf
EndFunction


; Events
;---------------------------------------------

Event Papyrus:Project:Context.OnStartup(Project:Context akSender, var[] arguments)
	self.OnEnable()
	Write(akSender.Title, "The module has finished the OnStartup event.")
EndEvent


Event Papyrus:Project:Context.OnShutdown(Project:Context akSender, var[] arguments)
	self.OnDisable()
	Write(akSender.Title, "The module has finished the OnShutdown event.")
EndEvent


Event Papyrus:Project:Context.OnUpgrade(Project:Context akSender, var[] arguments)
	Version newVersion = arguments[0] as Version
	Version oldVersion = arguments[1] as Version
	self.OnUpgrade(newVersion, oldVersion)
	Write(akSender.Title, \
		"The module has finished the OnUpgrade event. "+\
		"New '"+VersionToString(newVersion)+"', "+\
		"Old '"+VersionToString(oldVersion)+"'.")
EndEvent


; Virtual
;---------------------------------------------

Event OnInitialize()
	{VIRTUAL}
	Write(none, "The module has not implemented the virtual OnInitialize event.")
EndEvent

Event OnEnable()
	{VIRTUAL}
	Write(none, "The module has not implemented the virtual OnEnable event.")
EndEvent

Event OnDisable()
	{VIRTUAL}
	Write(none, "The module has not implemented the virtual OnDisable event.")
EndEvent

Event OnUpgrade(Version aNew, Version aPrevious)
	{VIRTUAL}
	Write(none, "The module has not implemented the virtual OnUpgrade event for version '"+VersionToString(aNew)+"'.")
EndEvent


; Properties
;---------------------------------------------

Group Module
	string Property StateName Hidden
		string Function Get()
			return GetState()
		EndFunction
	EndProperty

	string Property EmptyState = "" AutoReadOnly
EndGroup
