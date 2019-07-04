ScriptName System:Menus:Scope:Breath Extends ActiveMagicEffect
import System:Menus:Scope:Menu

; Events
;---------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If (Service.IsBreathKeyDown)
		BreathEventArgs e = new BreathEventArgs
		e.Breath = Service.BreathInterrupted
		Service.SendBreathEvent(e)
	EndIf
EndEvent

; Properties
;---------------------------------------------

Group Properties
	System:Menus:Scope:Service Property Service Auto Const Mandatory
EndGroup
