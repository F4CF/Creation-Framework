ScriptName System:Menus:Scope:Breath Extends ActiveMagicEffect
import System:Menus:Scope:Menu

; Events
;---------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If (Internal.IsBreathKeyDown)
		BreathEventArgs e = new BreathEventArgs
		e.Breath = Internal.BreathInterrupted
		Internal.SendBreathEvent(e)
	EndIf
EndEvent

; Properties
;---------------------------------------------

Group Properties
	System:Menus:Scope:Internal Property Internal Auto Const Mandatory
EndGroup
