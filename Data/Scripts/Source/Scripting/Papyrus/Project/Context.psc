ScriptName Papyrus:Project:Context extends Papyrus:Project:ContextType Hidden
import Papyrus:Compatibility
import Papyrus:Diagnostics:Log
import Papyrus:VersionType
import Quest

UserLog Log

Version LastVersion
QuestStage Condition
bool Activated = false

CustomEvent OnStartup
CustomEvent OnShutdown
CustomEvent OnUpgrade


; Events
;---------------------------------------------

Event OnInit()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = Title
	LastVersion = Release
	Condition = new QuestStage
	Activated = false
	RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
	RegisterForCustomEvent(self, "OnStartup")
	RegisterForCustomEvent(self, "OnUpgrade")
	RegisterForCustomEvent(self, "OnShutdown")
	self.OnInitialize()
	WriteLine(Log, "The context has initialized.")
EndEvent


Event OnQuestInit()
	; Event received when this quest has just started up.
	; This is after aliases are filled, and at the same time as the quest startup stage is run.
	WriteLine(Log, "OnQuestInit")
	IsActivated = true
EndEvent


Event OnQuestShutdown()
	; Event received when this quest has shut down (aliases are cleared at this time).
	WriteLine(Log, "OnQuestShutdown")
EndEvent


Event OnReset()
    ; Event received when this quest is started up, either the first time or subsequent times.
    ; This will fire in parallel with your startup stage!.
    WriteLine(Log, "OnReset")
EndEvent


Event OnStageSet(int auiStageID, int auiItemID)
	; Event received when a quest stage is set (runs in parallel with the fragment).
	WriteLine(Log, "OnStageSet")
	IsActivated = true
EndEvent


Event Quest.OnStageSet(Quest akSender, Int auiStageID, Int auiItemID)
	{Remote Event}
	WriteLine(Log, "Remote (Quest.OnStageSet) "+akSender)
EndEvent


Event Actor.OnPlayerLoadGame(Actor akSender)
	WriteLine(Log, "Reloaded "+Title+" version "+VersionToString(Release))
	Version versionNew = Release
	Version versionPrevious = LastVersion

	If (VersionGreaterThan(versionNew, versionPrevious))
		WriteChangedValue(Log, "Version", versionPrevious, versionNew)
		LastVersion = versionNew
		var[] arguments = new var[2]
		arguments[0] = versionNew
		arguments[1] = versionPrevious
		SendCustomEvent("OnUpgrade", arguments)
	Else
		WriteLine(Log, "No version change so doing nothing at all..")
	EndIf

EndEvent


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
			string[] values = new string[1]
			values[0] = "Anonymous"
			return values
		EndFunction
	EndProperty

	string Property Plugin Hidden
		string Function Get()
			return Papyrus:Project:ContextType.ContextPlugin()
		EndFunction
	EndProperty

	int Property FormID Hidden
		int Function Get()
			return GetFormID()
		EndFunction
	EndProperty

	Version Property Release Hidden
		Version Function Get()
			Version ver = new Version
			ver.Distribution = false
			ver.Major = 0
			ver.Minor = 0
			ver.Build = 0
			ver.Revision = 1
			return ver
		EndFunction
	EndProperty
EndGroup


Group Conditions
	Quest Property Required Hidden
		Quest Function Get()
			return Condition.QuestToSet
		EndFunction
		Function Set(Quest aValue)
			Condition.QuestToSet = aValue
		EndFunction
	EndProperty

	int Property RequiredStage Hidden
		int Function Get()
			return Condition.StageToSet
		EndFunction
		Function Set(int aValue)
			Condition.StageToSet = aValue
		EndFunction
	EndProperty

	bool Property IsReady Hidden
		bool Function Get()
			return Required.IsStageDone(RequiredStage)
		EndFunction
	EndProperty

	bool Property IsActivated Hidden
		bool Function Get()
			return Activated
		EndFunction
		Function Set(bool aValue)
			If (Activated == aValue)
				WriteLine(Log, "Activated is already equal to "+aValue)
				return
			Else
				If (IsReady)
					Activated = aValue
					If (aValue)
						WriteNotification(Log, Title+" is starting..")
						SendCustomEvent("OnStartup")
					Else
						WriteNotification(Log, Title+" is shutting down.")
						SendCustomEvent("OnShutdown")
					EndIf
					UnregisterForRemoteEvent(Required, "OnStageSet")
				Else
					WriteLine(Log, Title+" is not ready.")
					RegisterForRemoteEvent(Required, "OnStageSet")
				EndIf
			EndIf
		EndFunction
	EndProperty
EndGroup
