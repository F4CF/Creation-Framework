ScriptName System:UI:Scope:Breath Extends ActiveMagicEffect
import System:Debug
import System:UI:Scope:BreathEvent

; Events
;---------------------------------------------

Event OnEffectStart(Actor target, Actor caster)
	If (Menu.IsBreathKeyDown)
		WriteLine(self, "OnEffectStart", "Signaling for the breath depeleted event.", log="System")
		Menu.BreathEvent(Menu.BreathInterrupted)
	EndIf
EndEvent

; Properties
;---------------------------------------------

Group Properties
	System:UI:Scope:Menu Property Menu Auto Const Mandatory
EndGroup
