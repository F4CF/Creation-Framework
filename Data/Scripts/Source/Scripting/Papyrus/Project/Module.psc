ScriptName Papyrus:Project:Module extends Form Native Const Hidden
import Papyrus
import Papyrus:Compatibility
import Papyrus:Diagnostics:Log
import Papyrus:VersionType


; Module
;---------------------------------------------

bool Function Initialize(Project:Context context)
	If (ModuleInitialize(Context, self))
		self.OnInitialize()
		Write(context.Title, "The module has initialized.")

		If (context.IsActivated)
			ContextEvent(StartupEvent, Context, none)
			Write(context.Title, "The module is starting on the initialize thread.")
		Else
			Write(context.Title, "The module is waiting to be started from the initialize thread.")
		EndIf

		return true
	Else
		Write(context.Title, "The module could not be initialized.")
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






Function BigInit(Project:Context context, Project:Modules:Module module) Global

EndFunction











; Events
;---------------------------------------------

Event Papyrus:Project:Context.OnStartup(Project:Context akSender, var[] arguments)
	ContextEvent(StartupEvent, akSender, arguments)
EndEvent

Event Papyrus:Project:Context.OnShutdown(Project:Context akSender, var[] arguments)
	ContextEvent(ShutdownEvent, akSender, arguments)
EndEvent

Event Papyrus:Project:Context.OnUpgrade(Project:Context akSender, var[] arguments)
	ContextEvent(UpgradeEvent, akSender, arguments)
EndEvent


Event ContextEvent(int aEvent, Project:Context sender, var[] arguments)
	If (aEvent == StartupEvent)
		self.OnEnable()
		Write(sender.Title, "The module has finished the OnStartup event.")
	ElseIf (aEvent == ShutdownEvent)
		self.OnDisable()
		Write(sender.Title, "The module has finished the OnShutdown event.")
	ElseIf (aEvent == UpgradeEvent)
		Version newVersion = arguments[0] as Version
		Version oldVersion = arguments[1] as Version
		self.OnUpgrade(newVersion, oldVersion)
		Write(sender.Title, \
			"The module has finished the OnUpgrade event. "+\
			"New '"+VersionToString(newVersion)+"', "+\
			"Old '"+VersionToString(oldVersion)+"'.")
	Else
		Write(sender.Title, "The module has received and unhandled event.")
	EndIf
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
	int Property StartupEvent = 0 AutoReadOnly
	int Property ShutdownEvent = 1 AutoReadOnly
	int Property UpgradeEvent = 2 AutoReadOnly

	string Property StateName Hidden
		string Function Get()
			return GetState()
		EndFunction
	EndProperty

	string Property EmptyState = "" AutoReadOnly
EndGroup
