Scriptname System:Type Extends Quest Native Const Hidden
{The generic base type for all scripts which instantiate long running instances via `Quest` forms.}

; TODO: These kinds of scripts run like a "service". Maybe a "System.Services" import.

; OnGameReload
;---------------------------------------------

Event OnGameReload() Native
{Event occurs when the game has been reloaded.}


Event Actor.OnPlayerLoadGame(Actor sender)
	{The remote player actor event for game reloading.}
	OnGameReload()
EndEvent


bool Function RegisterForGameReload(ScriptObject this)
	{Register this script oject for game reload events.}
	return this.RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndFunction


Function UnregisterForGameReload(ScriptObject this)
	{Unregister this script oject for game reload events.}
	this.UnregisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndFunction


; Functions
;---------------------------------------------

string Function ToString()
	{The string representation of this script.}
	If (IsEmptyState)
		return self
	Else
		return self+"["+StateName+"]"
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	int Property Invalid = -1 AutoReadOnly
	{A generic invalid integer value.}
EndGroup

Group States
	string Property StateName Hidden
		{A property alias for the GetState function.}
		string Function Get()
			return GetState()
		EndFunction
	EndProperty

	bool Property IsEmptyState Hidden
		{Returns true if this script has the empty state.}
		bool Function Get()
			return StateName == EmptyState
		EndFunction
	EndProperty

	string Property EmptyState Hidden
		{The default papyrus script state is represented as an empty string.}
		string Function Get()
			return ""
		EndFunction
	EndProperty
EndGroup
