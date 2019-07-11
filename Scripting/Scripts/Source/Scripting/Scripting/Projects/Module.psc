ScriptName Scripting:Projects:Module Extends Form Native Const Hidden
import System:Log
import System:VersionType
import Scripting

; Module
;---------------------------------------------

bool Function Initialize(Projects:Context context)
	If (context)
		RegisterForCustomEvent(context, "OnStartup")
		RegisterForCustomEvent(context, "OnUpgrade")
		RegisterForCustomEvent(context, "OnShutdown")

		self.OnInitialize()
		Write(context.Title, "The module has initialized.")

		If (context.IsActivated)
			OnEvent(StartupEvent, Context, none)
			Write(context.Title, "The module has starting on the initialize thread.")
		Else
			Write(context.Title, "The module is waiting to be started from the initialize thread.")
		EndIf

		return true
	Else
		Write(none, "Cannot initialize a module with a none context.")
		return false
	EndIf
EndFunction


; Events
;---------------------------------------------

Event Scripting:Projects:Context.OnStartup(Projects:Context sender, var[] arguments)
	OnEvent(StartupEvent, sender, arguments)
EndEvent

Event Scripting:Projects:Context.OnShutdown(Projects:Context sender, var[] arguments)
	OnEvent(ShutdownEvent, sender, arguments)
EndEvent

Event Scripting:Projects:Context.OnUpgrade(Projects:Context sender, var[] arguments)
	OnEvent(UpgradeEvent, sender, arguments)
EndEvent


Event OnEvent(int aEvent, Projects:Context sender, var[] arguments)
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
		Write(sender.Title, "The module has received an unhandled event. Event:" + aEvent)
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
