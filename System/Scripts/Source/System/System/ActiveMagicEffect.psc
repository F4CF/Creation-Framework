Scriptname System:ActiveMagicEffect Extends System:Object Native Const Hidden

; Instance
;---------------------------------------------

ActiveMagicEffect Property AME Hidden
	ActiveMagicEffect Function Get()
		return MGEF()
	EndFunction
EndProperty

; @virtual
ActiveMagicEffect Function MGEF()
	ActiveMagicEffect this = System:Type.AsActiveMagicEffect(self)
	System:Debug.Assert(this, "Exception: Invalid Object! This must be of the `ActiveMagicEffect` type.")
	return this
EndFunction


; OnEffectStart
;---------------------------------------------
; https://www.creationkit.com/fallout4/index.php?title=OnEffectStart_-_ActiveMagicEffect

Event OnEffectStart(Actor target, Actor caster) Native

Event ActiveMagicEffect.OnEffectStart(ActiveMagicEffect this, Actor target, Actor caster)
	OnEffectStart(target, caster)
EndEvent

bool Function RegisterForEffectStart(ActiveMagicEffect this)
	return self.RegisterForRemoteEvent(this, "OnEffectStart")
EndFunction

Function UnregisterForEffectStart(ActiveMagicEffect this)
	self.UnregisterForRemoteEvent(this, "OnEffectStart")
EndFunction


; OnEffectFinish
;---------------------------------------------
; https://www.creationkit.com/fallout4/index.php?title=OnEffectFinish_-_ActiveMagicEffect

Event OnEffectFinish(Actor target, Actor caster) Native

Event ActiveMagicEffect.OnEffectFinish(ActiveMagicEffect this, Actor target, Actor caster)
	OnEffectFinish(target, caster)
EndEvent

bool Function RegisterForEffectFinish(ActiveMagicEffect this)
	return self.RegisterForRemoteEvent(this, "OnEffectFinish")
EndFunction

Function UnregisterForEffectFinish(ActiveMagicEffect this)
	self.UnregisterForRemoteEvent(this, "OnEffectFinish")
EndFunction
