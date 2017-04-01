ScriptName Papyrus:Project:Modules:Optional extends Papyrus:Project:Module Hidden
import Papyrus
import Papyrus:Compatibility
import Papyrus:Diagnostics:Log
import Papyrus:VersionType
import Papyrus:Script

UserLog Log

bool EnabledValue
Actor PlayerReference


; Events
;---------------------------------------------

Event OnInit()
	Log = Log(Context.Title, self)
	PlayerReference = Game.GetPlayer()
	EnabledValue = true

	Initialize(Context)
EndEvent


Event OnEvent(int aEvent, Project:Context sender, var[] arguments)
	If (aEvent == StartupEvent)
		If (SetActive(self))
			self.OnEnable()
			WriteLine(Log, "The module has finished the OnStartup event.")
		Else
			WriteLine(Log, "The module could not finish the OnStartup event.")
		EndIf
	ElseIf (aEvent == ShutdownEvent)
		If (SetActive(self, false))
			self.OnDisable()
			WriteLine(Log, "The module has finished the OnShutdown event.")
		Else
			WriteLine(Log, "The module could not finish the OnShutdown event.")
		EndIf
	ElseIf (aEvent == UpgradeEvent)
		If (Enabled)
			Version newVersion = arguments[0] as Version
			Version oldVersion = arguments[1] as Version
			self.OnUpgrade(newVersion, oldVersion)
			WriteLine(Log, "The module has finished the OnUpgrade event. " \
				+"New '"+VersionToString(newVersion)+"', Old '"+VersionToString(oldVersion)+"'.")
		Else
			WriteLine(Log, "Ignoring the OnUpgrade event, module is not enabled.")
		EndIf
	Else
		WriteLine(Log, "The module has received and unhandled event.")
	EndIf
EndEvent



; Functions
;---------------------------------------------

bool Function SetActive(Optional aOptional, bool abActive = true) Global
	string sEmptyState = "" const
	string sActiveState = "ActiveState" const

	If (aOptional)
		If (abActive) ; requested active state
			If (HasState(aOptional)) ; already activated
				Write(none, "Ignoring request for ActiveState, module is already active.")
				return false
			Else
				If (ChangeState(aOptional, sActiveState))
					Write(none, "The module has finished enabling.")
					return true
				Else
					Write(none, "The module could not be enabled.")
					return false
				EndIf
			EndIf
		Else ; requested empty state
			If (aOptional.GetState() == sEmptyState) ; already deactivated
				Write(none, "Ignoring request for EmptyState, module is already deactivated.")
				return false
			Else
				If (ChangeState(aOptional, sEmptyState))
					Write(none, "The module has finished disabling.")
					return true
				Else
					Write(none, "The module could not be disabled.")
					return false
				EndIf
			EndIf
		EndIf
	Else
		Write(none, "Cannot change ActiveState on a none script object.")
		return false
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Module
	Project:Context Property Context Auto Const Mandatory

	bool Property IsReady Hidden
		bool Function Get()
			return EnabledValue && HasState(self)
		EndFunction
	EndProperty

	bool Property Enabled Hidden
		bool Function Get()
			return EnabledValue
		EndFunction
		Function Set(bool aValue)
			If (aValue != EnabledValue)
				EnabledValue = aValue
				WriteChangedValue(Log, "Enabled", !aValue, aValue)
				SetActive(self, aValue)
			Else
				WriteLine(Log, "The module's Enabled property already equals '"+aValue+"'.")
			EndIf
		EndFunction
	EndProperty

	string Property ActiveState = "ActiveState" AutoReadOnly
EndGroup

Group Properties
	Actor Property Player Hidden
		Actor Function Get()
			return PlayerReference
		EndFunction
	EndProperty
EndGroup
