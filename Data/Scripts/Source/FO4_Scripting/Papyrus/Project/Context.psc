ScriptName Papyrus:Project:Context extends Papyrus:Project:ContextType Hidden Conditional
import Papyrus
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
	Log = LogNew(Title, self)
	LastVersion = Release
	Condition = new QuestStage
	Activated = false
	HasActivated = false
	RegisterForCustomEvent(self, "OnStartup")
	RegisterForCustomEvent(self, "OnShutdown")
	RegisterForCustomEvent(self, "OnUpgrade")
	RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
	self.OnInitialize()
EndEvent


Event OnQuestInit()
	WriteLine(Log, "OnQuestInit")
	IsActivated = true
EndEvent


Event OnQuestShutdown()
	WriteLine(Log, "OnQuestShutdown")
	IsActivated = false
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
		WriteLine(Log, "No version change with game reload.")
	EndIf

	self.OnGameReload()
EndEvent


Event Quest.OnStageSet(Quest akSender, Int auiStageID, Int auiItemID)
	WriteLine(Log, "Remote (Quest.OnStageSet) "+akSender)
	If (akSender == Required)
		IsActivated = true
	EndIf
EndEvent


; Custom Events
;---------------------------------------------

Event Papyrus:Project:Context.OnStartup(Project:Context akSender, var[] arguments)
	self.OnContextStartup()
	HasActivated = true
	Write(akSender.Title, "The context has finished the OnStartup event.")
EndEvent


Event Papyrus:Project:Context.OnShutdown(Project:Context akSender, var[] arguments)
	self.OnContextShutdown()
	HasActivated = false
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


; Properties
;---------------------------------------------

Group Context
	Quest Property Required Hidden
		Quest Function Get()
			return Condition.QuestToSet
		EndFunction
		Function Set(Quest value)
			Condition.QuestToSet = value
		EndFunction
	EndProperty

	int Property RequiredStage Hidden
		int Function Get()
			return Condition.StageToSet
		EndFunction
		Function Set(int value)
			Condition.StageToSet = value
		EndFunction
	EndProperty

	bool Property IsReady Hidden
		bool Function Get()
			return Required.IsStageDone(RequiredStage)
		EndFunction
	EndProperty

	bool Property HasActivated Auto Hidden Conditional
	bool Property IsActivated Hidden
		bool Function Get()
			return Activated
		EndFunction
		Function Set(bool value)
			If (Activated == value)
				WriteLine(Log, "Activated is already equal to "+value)
				return
			Else
				If (IsReady)
					Activated = value
					If (value)
						WriteLine(Log, Title+" is starting..")
						SendCustomEvent("OnStartup")
					Else
						WriteLine(Log, Title+" is shutting down.")
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
