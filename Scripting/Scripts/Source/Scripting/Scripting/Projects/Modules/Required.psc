ScriptName Scripting:Projects:Modules:Required Extends Scripting:Projects:Module Hidden

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
	Scripting:Projects:Context Property Context Auto Const Mandatory
EndGroup

Group Properties
	Actor Property Player Hidden
		Actor Function Get()
			return PlayerReference
		EndFunction
	EndProperty
EndGroup
