ScriptName System:Object Extends Form Native Const Hidden
{Provides methods for working with states, such as running, awaiting, or clearing script states.

**See Also**
* https://docs.microsoft.com/en-us/dotnet/api/system.object
* https://docs.microsoft.com/en-us/dotnet/api/system.reflection.memberinfo
}
import System:Exception
import System:Log


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


; Methods
;---------------------------------------------

; @virtual
; Returns a string that represents the current object.
;
; **See Also**
; * https://docs.microsoft.com/en-us/dotnet/api/system.object.tostring
string Function ToString()
	If (IsEmptyState)
		return self
	Else
		return self+"["+StateName+"]"
	EndIf
EndFunction


; OnGameReload
;---------------------------------------------

; Event occurs when the game has been reloaded.
Event OnGameReload() Native

; The remote player actor event for game reloading.
Event Actor.OnPlayerLoadGame(Actor sender)
	OnGameReload()
EndEvent

; Register this script object for game reload events.
bool Function RegisterForGameReload(ScriptObject this)
	return this.RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndFunction

; Unregister this script object for game reload events.
Function UnregisterForGameReload(ScriptObject this)
	this.UnregisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
EndFunction


; States
;---------------------------------------------

; The default papyrus script state is the empty state.
string Function EmptyState() Global
	return ""
EndFunction


; The default busy state is the busy state.
string Function BusyState() Global
	return "Busy"
EndFunction


; Uses the `OnTimer` event to start a new thread.
bool Function NewState(ScriptObject this, int stateID) Global
	If (this)
		this.StartTimer(0.1, stateID)
		return true
	Else
		System:Debug.WriteUnexpectedValue("System:Object", "NewState", "this", "Cannot request state ID "+stateID+" on a none script.")
		return false
	EndIf
EndFunction


; Polling until the given script is in the "empty" state.
bool Function AwaitState(ScriptObject this, string statename = "Busy") Global
	If (this)
		If (BeginState(this, statename))
			While (StateRunning(this))
				Utility.Wait(0.1)
			EndWhile
			return true
		Else
			System:Debug.WriteUnexpected(this, "AwaitState", "Could not await the '"+statename+"' state.")
			return false
		EndIf
	Else
		System:Debug.WriteUnexpectedValue("System:Object", "AwaitState", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction


; Begins the given state without waiting for it to end.
bool Function BeginState(ScriptObject this, string statename = "Busy") Global
	If (this)
		If (StateRunning(this))
			System:Debug.WriteUnexpected(this, "BeginState", "Cannot start the '"+statename+"' state while '"+this.GetState()+"' state is running.")
			return false
		Else
			If (statename)
				If (ChangeState(this, statename))
					return true
				Else
					System:Debug.WriteUnexpected(this, "BeginState", "Start state cannot change state for the '"+statename+"' state.")
					return false
				EndIf
			Else
				System:Debug.WriteUnexpectedValue(this, "BeginState", "statename", "Cannot operate on a none or empty state.")
				return false
			EndIf
		EndIf
	Else
		System:Debug.WriteUnexpectedValue("System:Object", "BeginState", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction


; Return true if the given script has any state other than the default empty state.
bool Function StateRunning(ScriptObject this) Global
	If (this)
		return this.GetState() != EmptyState()
	Else
		System:Debug.WriteUnexpectedValue("System:Object", "StateRunning", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction

; Ends any running state on the given script.
bool Function ClearState(ScriptObject this) Global
	If (this)
		If (ChangeState(this, EmptyState()))
			return true
		Else
			System:Debug.WriteUnexpected(this, "ClearState", "Unable to change the scripts state to empty.")
			return false
		EndIf
	Else
		System:Debug.WriteUnexpectedValue("System:Object", "ClearState", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction

; Changes the given scripts state only to a different state.
bool Function ChangeState(ScriptObject this, string statename) Global
	If (this)
		If(this.GetState() != statename)
			this.GoToState(statename)
			return true
		Else
			System:Debug.WriteUnexpectedValue(this, "ChangeState", "statename", "The script is already in the '"+statename+"' state.")
			return false
		EndIf
	Else
		System:Debug.WriteUnexpectedValue("System:Object", "ChangeState", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction
