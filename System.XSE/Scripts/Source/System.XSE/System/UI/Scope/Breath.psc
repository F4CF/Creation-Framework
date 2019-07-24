ScriptName System:UI:Scope:Breath Extends ActiveMagicEffect
import System:UI:Scope:BreathEvent

; Events
;---------------------------------------------

Event OnEffectStart(Actor target, Actor caster)
	If (Menu.IsBreathKeyDown)
		System:Log.WriteLine("System", self, "OnEffectStart", "Signaling for the breath depeleted event.")
		Menu.BreathEvent(Menu.BreathInterrupted)
	EndIf
EndEvent

; Properties
;---------------------------------------------

Group Properties
	System:UI:Scope:Menu Property Menu Auto Const Mandatory
EndGroup
