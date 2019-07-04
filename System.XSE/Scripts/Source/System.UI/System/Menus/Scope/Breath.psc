ScriptName System:Menus:Scope:Breath Extends ActiveMagicEffect
import System:Menus:Scope:Menu

; Events
;---------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If (Type.IsBreathKeyDown)
		BreathEventArgs e = new BreathEventArgs
		e.Breath = Type.BreathInterrupted
		Type.SendBreathEvent(e)
	EndIf
EndEvent

; Properties
;---------------------------------------------

Group Properties
	System:Menus:Scope:Type Property Type Auto Const Mandatory
EndGroup
