Scriptname Action:Type extends Quest Const Native Hidden
{The base type for scripts.}

; OnGameReload
;---------------------------------------------

Event OnGameReload() Native
	{Event occurs when the game has been reloaded.}


	Event Actor.OnPlayerLoadGame(Actor akSender)
		OnGameReload()
	EndEvent


	bool Function RegisterForGameReload(ScriptObject this)
		return this.RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
	EndFunction


	Function UnregisterForGameReload(ScriptObject this)
		this.UnregisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
	EndFunction


	; Functions
	;---------------------------------------------

	string Function ToString()
		{The string representation of this type.}
		return "[Fallout:Overlays:Type]"
	EndFunction


	; Properties
	;---------------------------------------------

	Group Properties
		string Property EmptyState = "" AutoReadOnly

		string Property StateName Hidden
			string Function Get()
				return self.GetState()
			EndFunction
		EndProperty
	EndGroup