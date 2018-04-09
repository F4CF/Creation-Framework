ScriptName Papyrus:Project:Modules:Optional extends Papyrus:Project:Module Hidden
import Papyrus
import Papyrus:Compatibility
import Papyrus:Log
import Papyrus:VersionType
import Papyrus:Script

bool EnabledValue
Actor PlayerReference


; Events
;---------------------------------------------

Event OnInit()
	PlayerReference = Game.GetPlayer()
	EnabledValue = true

	Initialize(Context)
EndEvent


Event OnEvent(int aEvent, Project:Context sender, var[] arguments)
	If (aEvent == StartupEvent)
		If (SetActive(self))
			self.OnEnable()
			WriteLine(self, "The module has finished the OnStartup event.")
		Else
			WriteLine(self, "The module could not finish the OnStartup event.")
		EndIf
	ElseIf (aEvent == ShutdownEvent)
		If (SetActive(self, false))
			self.OnDisable()
			WriteLine(self, "The module has finished the OnShutdown event.")
		Else
			WriteLine(self, "The module could not finish the OnShutdown event.")
		EndIf
	ElseIf (aEvent == UpgradeEvent)
		If (Enabled)
			Version newVersion = arguments[0] as Version
			Version oldVersion = arguments[1] as Version
			self.OnUpgrade(newVersion, oldVersion)
			WriteLine(self, "The module has finished the OnUpgrade event. " \
				+"New '"+VersionToString(newVersion)+"', Old '"+VersionToString(oldVersion)+"'.")
		Else
			WriteLine(self, "Ignoring the OnUpgrade event, module is not enabled.")
		EndIf
	Else
		WriteLine(self, "The module has received and unhandled event.")
	EndIf
EndEvent


; Functions
;---------------------------------------------

bool Function SetActive(Optional aOptional, bool abActive = true) Global
	string sEmptyState = "" const
	string sActiveState = "ActiveState" const

	If (aOptional)
		If (abActive) ; requested active state
			If (aOptional.StateName != "") ; already activated
				WriteLine(aOptional, "Ignoring request for ActiveState, module is already active.")
				return false
			Else
				If (ChangeState(aOptional, sActiveState))
					WriteLine(aOptional, "The module has finished enabling.")
					return true
				Else
					WriteLine(aOptional, "The module could not be enabled.")
					return false
				EndIf
			EndIf
		Else ; requested empty state
			If (aOptional.GetState() == sEmptyState) ; already deactivated
				WriteLine(aOptional, "Ignoring request for EmptyState, module is already deactivated.")
				return false
			Else
				If (ChangeState(aOptional, sEmptyState))
					WriteLine(aOptional, "The module has finished disabling.")
					return true
				Else
					WriteLine(aOptional, "The module could not be disabled.")
					return false
				EndIf
			EndIf
		EndIf
	Else
		WriteLine("Modules:Optional", "Cannot change ActiveState on a none script object.")
		return false
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Module
	Project:Context Property Context Auto Const Mandatory

	bool Property IsReady Hidden
		bool Function Get()
			return EnabledValue && StateName != ""
		EndFunction
	EndProperty

	bool Property Enabled Hidden
		bool Function Get()
			return EnabledValue
		EndFunction
		Function Set(bool aValue)
			If (aValue != EnabledValue)
				EnabledValue = aValue
				WriteChangedValue(self, "Enabled", !aValue, aValue)
				SetActive(self, aValue)
			Else
				WriteLine(self, "The module's Enabled property already equals '"+aValue+"'.")
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
