ScriptName System:Diagnostics:Type Extends System:Quest Native Const Hidden
{The generic base type for all system scripts which instantiate long running instances via Quest forms.}

; OnGameReload
;---------------------------------------------

Event OnGameReload() Native
{Event occurs when the game has been reloaded.}


Event Actor.OnPlayerLoadGame(Actor akSender)
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
	{The string representation of this type.}
	return "[System:Diagnostics:Type]"
EndFunction
