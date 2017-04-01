ScriptName Papyrus:Project:Modules:Required extends Papyrus:Project:Module Hidden
import Papyrus

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
	Project:Context Property Context Auto Const Mandatory
EndGroup


Group Properties
	Actor Property Player Hidden
		Actor Function Get()
			return PlayerReference
		EndFunction
	EndProperty
EndGroup
