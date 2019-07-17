ScriptName System:UI:Visor:Client Extends System:UI:Client
import System:Log

Actor Player

; Events
;---------------------------------------------

Event OnInit()
	RegisterForQuestInit(QUST)
EndEvent


Event OnQuestInit()
	Player = Game.GetPlayer()
EndEvent


; Properties
;---------------------------------------------

System:UI:Visor:Service Property Service Auto Const Mandatory
{Private- The framework is used to track equipment changes on the player.}

Group Properties
	Armor Property Equipped Hidden
		{Returns the equipped eyes item.}
		Armor Function Get()
			return Service.GetWorn().Item as Armor
		EndFunction
	EndProperty
EndGroup
