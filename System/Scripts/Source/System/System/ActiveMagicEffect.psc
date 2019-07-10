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
