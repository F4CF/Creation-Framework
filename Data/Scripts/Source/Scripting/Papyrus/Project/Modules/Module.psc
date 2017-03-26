ScriptName Papyrus:Project:Modules:Module extends Form Native Const Hidden
import Papyrus
import Papyrus:Compatibility
import Papyrus:Diagnostics:Log
import Papyrus:VersionType


; Events
;---------------------------------------------

Event OnInit()
	Papyrus:Project:Context context = Papyrus:Project:ContextType.GetInstance() ; DUMMY!

	If (ModuleInitialize(context, self))
		self.OnInitialize()
		Write(none, "The module has initialized.")
	Else
		Write(none, "The module could not be initialized.")
	EndIf
EndEvent


Event Papyrus:Project:Context.OnStartup(Papyrus:Project:Context akSender, var[] arguments)
	self.OnEnable()
	Write(none, "The module has finished the OnStartup event.")
EndEvent


Event Papyrus:Project:Context.OnShutdown(Papyrus:Project:Context akSender, var[] arguments)
	self.OnDisable()
	Write(none, "The module has finished the OnShutdown event.")
EndEvent


Event Papyrus:Project:Context.OnUpgrade(Papyrus:Project:Context akSender, var[] arguments)
	Version newVersion = arguments[0] as Version
	Version oldVersion = arguments[1] as Version
	self.OnUpgrade(newVersion, oldVersion)
	Write(none, "The module has finished the OnUpgrade event. " \
		+"New '"+VersionToString(newVersion)+"', Old '"+VersionToString(oldVersion)+"'.")
EndEvent


; Globals
;---------------------------------------------

bool Function ModuleInitialize(Papyrus:Project:Context aContext, ScriptObject aModule) Global
	If (aModule)
		If (aContext)
			aModule.RegisterForCustomEvent(aContext, "OnStartup")
			aModule.RegisterForCustomEvent(aContext, "OnUpgrade")
			aModule.RegisterForCustomEvent(aContext, "OnShutdown")
			return true
		Else
			Write(none, "Cannot initialize a module with a none context.")
			return false
		EndIf
	Else
		Write(none, "Cannot initialize a module with a none ScriptObject.")
		return false
	EndIf
EndFunction


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
