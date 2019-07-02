ScriptName System:Projects:Modules:Required extends System:Projects:Module Hidden
import System

Actor PlayerReference

; Events
;---------------------------------------------

Event OnInit()
	PlayerReference = Game.GetPlayer()
	Initialize(Context)
EndEvent


; Properties
;---------------------------------------------

Group Module
	Projects:Context Property Context Auto Const Mandatory
EndGroup

Group Properties
	Actor Property Player Hidden
		Actor Function Get()
			return PlayerReference
		EndFunction
	EndProperty
EndGroup
