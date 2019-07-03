ScriptName Scripting:Projects:Context extends Scripting:Projects:ContextType Hidden Conditional
import System
import System:Log
import System:VersionType
import Scripting
import Quest

Version LastVersion
QuestStage Condition
bool Activated = false

CustomEvent OnStartup
CustomEvent OnShutdown
CustomEvent OnUpgrade


; Events
;---------------------------------------------

Event OnInit()
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
	WriteLine(self, "OnQuestInit")
	IsActivated = true
EndEvent


Event OnQuestShutdown()
	WriteLine(self, "OnQuestShutdown")
	IsActivated = false
EndEvent


Event Actor.OnPlayerLoadGame(Actor akSender)
	WriteLine(self, "Reloaded "+Title+" version "+VersionToString(Release))
	Version versionNew = Release
	Version versionPrevious = LastVersion

	If (VersionGreaterThan(versionNew, versionPrevious))
		WriteChangedValue(self, "Version", versionPrevious, versionNew)
		LastVersion = versionNew
		var[] arguments = new var[2]
		arguments[0] = versionNew
		arguments[1] = versionPrevious
		SendCustomEvent("OnUpgrade", arguments)
	Else
		WriteLine(self, "No version change with game reload.")
	EndIf

	self.OnGameReload()
EndEvent


Event Quest.OnStageSet(Quest akSender, int auiStageID, int auiItemID)
	WriteLine(self, "Remote (Quest.OnStageSet) "+akSender)
	If (akSender == Required)
		IsActivated = true
	EndIf
EndEvent


; Custom Events
;---------------------------------------------

Event Scripting:Projects:Context.OnStartup(Projects:Context akSender, var[] arguments)
	self.OnContextStartup()
	HasActivated = true
	Write(akSender.Title, "The context has finished the OnStartup event.")
EndEvent


Event Scripting:Projects:Context.OnShutdown(Projects:Context akSender, var[] arguments)
	self.OnContextShutdown()
	HasActivated = false
	Write(akSender.Title, "The context has finished the OnShutdown event.")
EndEvent


Event Scripting:Projects:Context.OnUpgrade(Projects:Context akSender, var[] arguments)
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
				WriteLine(self, "Activated is already equal to "+value)
				return
			Else
				If (IsReady)
					Activated = value
					If (value)
						WriteLine(self, Title+" is starting..")
						SendCustomEvent("OnStartup")
					Else
						WriteLine(self, Title+" is shutting down.")
						SendCustomEvent("OnShutdown")
					EndIf
					UnregisterForRemoteEvent(Required, "OnStageSet")
				Else
					WriteLine(self, Title+" is not ready.")
					RegisterForRemoteEvent(Required, "OnStageSet")
				EndIf
			EndIf
		EndFunction
	EndProperty
EndGroup
