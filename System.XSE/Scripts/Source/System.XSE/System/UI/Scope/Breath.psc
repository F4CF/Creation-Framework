ScriptName System:UI:Scope:Breath Extends System:ActiveMagicEffect
import System:UI:Scope:Menu

; Events
;---------------------------------------------

Event OnInit()
	RegisterForEffectStart(AME)
EndEvent

Event OnEffectStart(Actor target, Actor caster)
	If (Service.IsBreathKeyDown)
		BreathEventArgs e = new BreathEventArgs
		e.Breath = Service.BreathInterrupted
		Service.SendBreathEvent(e)
	EndIf
EndEvent

; Properties
;---------------------------------------------

Group Properties
	System:UI:Scope:Service Property Service Auto Const Mandatory
EndGroup
