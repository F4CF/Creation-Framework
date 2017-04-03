ScriptName Papyrus_Test:ContextMock extends Papyrus:Project:Context
import Papyrus
import Papyrus:Compatibility:External
import Papyrus:Diagnostics:Log
import Papyrus:VersionType

UserLog Log
Actor Player


; Events
;---------------------------------------------

Event OnInitialize()
	Log = new UserLog
	Log.Caller = self
	Log.FileName = "Lilac" + "_ContextMock"
	Player = Game.GetPlayer()
	Required = MQ102
	RequiredStage = 1
EndEvent


Event OnContextStartup()
	If (TryHolotape())
		WriteLine(Log, "Added a holotape to the player for startup.")
	Else
		WriteLine(Log, "The player already has a holotape for startup.")
	EndIf
EndEvent


Event OnContextShutdown()
	If (TryHolotape()) ; so player can enable the mod again
		WriteLine(Log, "Added a holotape to the player for shutdown.")
	Else
		WriteLine(Log, "The player already has a holotape for shutdown.")
	EndIf
EndEvent


; Context
;---------------------------------------------

string Function GetTitle()
	return "Mock Context"
EndFunction


string[] Function GetAuthors()
	return new string[0]
EndFunction


Version Function GetVersion()
	return new Version
EndFunction


ExternalForm Function Context()
	return new ExternalForm
EndFunction


bool Function StartCondition()
	return true
EndFunction


; Functions
;---------------------------------------------

bool Function TryHolotape()
	If (HasHolotape == false)
		Player.AddItem(Scripting_DummyHolotape, 1)
		return true
	Else
		return false
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Quest Property MQ102 Auto Const Mandatory
	Holotape Property Scripting_DummyHolotape Auto Const Mandatory
EndGroup


Group Setup
	bool Property HasHolotape Hidden
		bool Function Get()
			return Player.GetItemCount(Scripting_DummyHolotape) >= 1
		EndFunction
	EndProperty
EndGroup
