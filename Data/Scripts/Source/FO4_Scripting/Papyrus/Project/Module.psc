ScriptName Papyrus:Project:Module extends Form Native Const Hidden
import Papyrus
import Papyrus:Compatibility
import Papyrus:Log
import Papyrus:VersionType

; Module
;---------------------------------------------

bool Function Initialize(Project:Context context)
	If (context)
		RegisterForCustomEvent(context, "OnStartup")
		RegisterForCustomEvent(context, "OnUpgrade")
		RegisterForCustomEvent(context, "OnShutdown")

		self.OnInitialize()
		WriteLine(self, "The module has initialized.")

		If (context.IsActivated)
			OnEvent(StartupEvent, Context, none)
			WriteLine(self, "The module has starting on the initialize thread.")
		Else
			WriteLine(self, "The module is waiting to be started from the initialize thread.")
		EndIf

		return true
	Else
		WriteLine(none, "Cannot initialize a module with a none context.")
		return false
	EndIf
EndFunction


; Events
;---------------------------------------------

Event Papyrus:Project:Context.OnStartup(Project:Context akSender, var[] arguments)
	OnEvent(StartupEvent, akSender, arguments)
EndEvent

Event Papyrus:Project:Context.OnShutdown(Project:Context akSender, var[] arguments)
	OnEvent(ShutdownEvent, akSender, arguments)
EndEvent

Event Papyrus:Project:Context.OnUpgrade(Project:Context akSender, var[] arguments)
	OnEvent(UpgradeEvent, akSender, arguments)
EndEvent


Event OnEvent(int aEvent, Project:Context sender, var[] arguments)
	If (aEvent == StartupEvent)
		self.OnEnable()
		WriteLine(self, "The module has finished the OnStartup event.")
	ElseIf (aEvent == ShutdownEvent)
		self.OnDisable()
		WriteLine(self, "The module has finished the OnShutdown event.")
	ElseIf (aEvent == UpgradeEvent)
		Version newVersion = arguments[0] as Version
		Version oldVersion = arguments[1] as Version
		self.OnUpgrade(newVersion, oldVersion)
		WriteLine(self, \
			"The module has finished the OnUpgrade event. "+\
			"New '"+VersionToString(newVersion)+"', "+\
			"Old '"+VersionToString(oldVersion)+"'.")
	Else
		WriteLine(self, "The module has received an unhandled event. Event:" + aEvent)
	EndIf
EndEvent


; Virtual
;---------------------------------------------

Event OnInitialize()
	{VIRTUAL}
	WriteLine(self, "The module has not implemented the virtual OnInitialize event.")
EndEvent

Event OnEnable()
	{VIRTUAL}
	WriteLine(self, "The module has not implemented the virtual OnEnable event.")
EndEvent

Event OnDisable()
	{VIRTUAL}
	WriteLine(self, "The module has not implemented the virtual OnDisable event.")
EndEvent

Event OnUpgrade(Version aNew, Version aPrevious)
	{VIRTUAL}
	WriteLine(self, "The module has not implemented the virtual OnUpgrade event for version '"+VersionToString(aNew)+"'.")
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
