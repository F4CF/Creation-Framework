ScriptName Papyrus:Project:Modules:Required extends Papyrus:Project:Modules:Module Hidden
import Papyrus

Actor PlayerReference


; Events
;---------------------------------------------

Event OnInit()
	PlayerReference = Game.GetPlayer()
	parent.OnInit()
EndEvent


; Properties
;---------------------------------------------

Group Context
	Project:Context Property Context Auto Const Mandatory
EndGroup


Group Properties
	Actor Property Player Hidden
		Actor Function Get()
			return PlayerReference
		EndFunction
	EndProperty
EndGroup
